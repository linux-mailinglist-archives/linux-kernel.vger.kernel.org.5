Return-Path: <linux-kernel+bounces-30638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F276D832259
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 00:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52E43B22A38
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 23:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F6F1EA78;
	Thu, 18 Jan 2024 23:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTxLtczc"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DE51EB36;
	Thu, 18 Jan 2024 23:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705621341; cv=none; b=rjE2yZAmUapxsrukDqoDcNFjSoe8O5Vm1aTQ4mKZWL8MoGWliKhHFYxr4a7CdW4qtNwz/4uQMdQEyMQ2xAsgL+ma0XpNIwCae74uO/VXjN99etqYdxW3oegFplf0S6quVuheF093JLyulnj+KvpFZxp15qkVjX0KvqZYmlFjbHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705621341; c=relaxed/simple;
	bh=d0FUsaPnEbJ2mmTluTYSegMAHd4m0WOXy0PH77QLwGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHHsooVTb3TenUgnKl69koRCL8q0h39oPELxRJodQLfgSP2sXN/AVSc7dkW1fS7IWTRInUcOONHU8CDzZl1vl8NR2xoflVxSPT4m/tBMutD+AFPHzOUD8GZqiw+OcIEtRGuvuv4VMeqeIH93KqngVyywd5try1Oin6e6g3uo3yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTxLtczc; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6daa89a6452so213154b3a.2;
        Thu, 18 Jan 2024 15:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705621339; x=1706226139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TpvN6GRjyohgmj3h7PVSatVG5kzyChlMtg/L4b57Fqw=;
        b=jTxLtczcGaSUzlkxP6El36uJUgMi9qiIo1GAiKafwOu6rR8hUgJdTedeL8z07OWeOR
         /DpkjWFsVtysOGsJwtEPbMO7XaSjIRzXEWJKTp48yIeZNUJb9mwH6xC/j9AqUeBDSpzr
         A9rfg0BgORJOSc+gdcHWNDsEAybAT0++MvczgsWBHqmd5whqRHsCgFHdjJX+ZZ1eMguE
         QUcerQln2c+gSO/uX7qwGNJVnfE8ArDeLoo67z4qYJfV+bCPTDineRUY7XgAPDHdPYWW
         f7MD2Ye7g/X35CxrdiFFeeFsq+M8MBil+eYvgv3Ezjztx0mmHVsnaEGRTSF0l8rVLIDH
         7TxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705621339; x=1706226139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TpvN6GRjyohgmj3h7PVSatVG5kzyChlMtg/L4b57Fqw=;
        b=tHvgTbjZkVGdd90WjoeuDDISj0XQYshQ4ka940ldd0DqHXeXxpahPnNbCo3TzO4u0I
         HAgt/TeXYMIKSUhM8glpAUKaSHEUIKq0Zwh+DGYG6FfgZ/0+N1w4v2pwjBKIUY6Cxe5l
         trg+BJsOSmz+J+VtsIDgGJAJrVvpvBUMnEpDt8A6dwpduDVH1lTNGjU1D8cZEL71G2US
         4GxmjQnw2vGw3hi8Z+CP1PJDlmsWExYTQy+f50mAKZKH3bS9nMzH2YLxuqKp/8woppjk
         y4W3w8ByuHDT5r+ZOC+XE5FrFRB56+as+dfSsH/dseNePqNNFEEvFkJ31B3GhWOgAXaP
         4nUg==
X-Gm-Message-State: AOJu0YwkGXunsGdb+F1tI6YjqoWYVkETCHZ2miKh2tLG6sIOG0AWkCWv
	3Giumwl4LNYT0atDbbGp1xYyxzYMiFVxYWhv+xivtrQAf2JSBMRrcH+0fiQQ
X-Google-Smtp-Source: AGHT+IE2mz9jfDaEBwt+wKPTVvCqwisEK1D0GiebHOw2yNYpfNM57ePSZFPUIgDzohwzLdGidBeBWA==
X-Received: by 2002:a05:6a20:47c8:b0:19b:5b08:18de with SMTP id ey8-20020a056a2047c800b0019b5b0818demr1329911pzb.98.1705621339135;
        Thu, 18 Jan 2024 15:42:19 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id pq17-20020a17090b3d9100b002903826fb3bsm1124281pjb.20.2024.01.18.15.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 15:42:18 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 18 Jan 2024 15:42:16 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Lukasz Majczak <lma@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Radoslaw Biernacki <biernacki@google.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH v2 1/3] platform/chrome: Update binary interface for
 EC-based watchdog
Message-ID: <75bddec1-bb4a-467f-b37a-4b5e2892db34@roeck-us.net>
References: <20240118195325.2964918-1-lma@chromium.org>
 <20240118195325.2964918-2-lma@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118195325.2964918-2-lma@chromium.org>

On Thu, Jan 18, 2024 at 07:53:22PM +0000, Lukasz Majczak wrote:
> Update structures and defines related to EC_CMD_HANG_DETECT
> to allow usage of new EC-based watchdog.
> 
> Signed-off-by: Lukasz Majczak <lma@chromium.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  .../linux/platform_data/cros_ec_commands.h    | 78 +++++++++----------
>  1 file changed, 35 insertions(+), 43 deletions(-)
> 
> diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
> index 7dae17b62a4d..ecc47d5fe239 100644
> --- a/include/linux/platform_data/cros_ec_commands.h
> +++ b/include/linux/platform_data/cros_ec_commands.h
> @@ -3961,60 +3961,52 @@ struct ec_response_i2c_passthru {
>  } __ec_align1;
>  
>  /*****************************************************************************/
> -/* Power button hang detect */
> -
> +/* AP hang detect */
>  #define EC_CMD_HANG_DETECT 0x009F
>  
> -/* Reasons to start hang detection timer */
> -/* Power button pressed */
> -#define EC_HANG_START_ON_POWER_PRESS  BIT(0)
> -
> -/* Lid closed */
> -#define EC_HANG_START_ON_LID_CLOSE    BIT(1)
> -
> - /* Lid opened */
> -#define EC_HANG_START_ON_LID_OPEN     BIT(2)
> -
> -/* Start of AP S3->S0 transition (booting or resuming from suspend) */
> -#define EC_HANG_START_ON_RESUME       BIT(3)
> -
> -/* Reasons to cancel hang detection */
> +#define EC_HANG_DETECT_MIN_TIMEOUT 5
> +#define EC_HANG_DETECT_MAX_TIMEOUT 65535
>  
> -/* Power button released */
> -#define EC_HANG_STOP_ON_POWER_RELEASE BIT(8)
> +/* EC hang detect commands */
> +enum ec_hang_detect_cmds {
> +	/* Reload AP hang detect timer. */
> +	EC_HANG_DETECT_CMD_RELOAD = 0x0,
>  
> -/* Any host command from AP received */
> -#define EC_HANG_STOP_ON_HOST_COMMAND  BIT(9)
> +	/* Stop AP hang detect timer. */
> +	EC_HANG_DETECT_CMD_CANCEL = 0x1,
>  
> -/* Stop on end of AP S0->S3 transition (suspending or shutting down) */
> -#define EC_HANG_STOP_ON_SUSPEND       BIT(10)
> +	/* Configure watchdog with given reboot timeout and
> +	 * cancel currently running AP hang detect timer.
> +	 */
> +	EC_HANG_DETECT_CMD_SET_TIMEOUT = 0x2,
>  
> -/*
> - * If this flag is set, all the other fields are ignored, and the hang detect
> - * timer is started.  This provides the AP a way to start the hang timer
> - * without reconfiguring any of the other hang detect settings.  Note that
> - * you must previously have configured the timeouts.
> - */
> -#define EC_HANG_START_NOW             BIT(30)
> +	/* Get last hang status - whether the AP boot was clear or not */
> +	EC_HANG_DETECT_CMD_GET_STATUS = 0x3,
>  
> -/*
> - * If this flag is set, all the other fields are ignored (including
> - * EC_HANG_START_NOW).  This provides the AP a way to stop the hang timer
> - * without reconfiguring any of the other hang detect settings.
> - */
> -#define EC_HANG_STOP_NOW              BIT(31)
> +	/* Clear last hang status. Called when AP is rebooting/shutting down
> +	 * gracefully.
> +	 */
> +	EC_HANG_DETECT_CMD_CLEAR_STATUS = 0x4
> +};
>  
>  struct ec_params_hang_detect {
> -	/* Flags; see EC_HANG_* */
> -	uint32_t flags;
> -
> -	/* Timeout in msec before generating host event, if enabled */
> -	uint16_t host_event_timeout_msec;
> +	uint16_t command; /* enum ec_hang_detect_cmds */
> +	/* Timeout in seconds before generating reboot */
> +	uint16_t reboot_timeout_sec;
> +} __ec_align2;
>  
> -	/* Timeout in msec before generating warm reboot, if enabled */
> -	uint16_t warm_reboot_timeout_msec;
> -} __ec_align4;
> +/* Status codes that describe whether AP has boot normally or the hang has been
> + * detected and EC has reset AP
> + */
> +enum ec_hang_detect_status {
> +	EC_HANG_DETECT_AP_BOOT_NORMAL = 0x0,
> +	EC_HANG_DETECT_AP_BOOT_EC_WDT = 0x1,
> +	EC_HANG_DETECT_AP_BOOT_COUNT,
> +};
>  
> +struct ec_response_hang_detect {
> +	uint8_t status; /* enum ec_hang_detect_status */
> +} __ec_align1;
>  /*****************************************************************************/
>  /* Commands for battery charging */
>  
> -- 
> 2.43.0.429.g432eaa2c6b-goog
> 
> 

