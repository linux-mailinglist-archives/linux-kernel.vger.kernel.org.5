Return-Path: <linux-kernel+bounces-133171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15065899FE9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7B031F22640
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EDE16F28D;
	Fri,  5 Apr 2024 14:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3gsiQ8s"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C50341C68;
	Fri,  5 Apr 2024 14:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712327827; cv=none; b=CjBfQCGWn/9yiJ2ZCPxLKieWvs19KiQj/FO3deY6veVaUmHBm2JFmtPNTd07CT/D65HhBl+tOJMjVC9MxdZPMpxEtcIW3G0IsfIzhFFVKRvGanjA92o2v854wz23Jz2NtLGNh5WuNhCNpJ0nTtCZR2Sa7RVmgiZG8PxurLhKOPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712327827; c=relaxed/simple;
	bh=eIorOYYZiLdm+pbueizWefpBql/HDSgTVKhM4Iafk9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPB3PcqWrQSkXUiWDOUNpitnlf9VQ8IHIFd5vrsL33oCyuMU1vqBKl/K/HQ0842iYiNdztiTwqQSZyWflvF4pAVH+oMb2NrlnL+NGDPMgxsm1Uijy9gcLczq1UQ/ITtTbn+tkOJkZJjD8bZ+eHNZJvOz9q+56hF8qKXuoAM3+6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3gsiQ8s; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56e0acaf69aso2863359a12.1;
        Fri, 05 Apr 2024 07:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712327824; x=1712932624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CSJRYNqAmVBKiGPVSvhxhy0tW7FVAqspgSB3v6fe5Ds=;
        b=Y3gsiQ8svPUtQZrrCXc27NzBXOLlsTreXBahRXZUiBffEsgfbld9wgmy3/u6zdJFNO
         47aGdkjkbOcXTY2NXnpajYoUgj1CNNg0CmRkZfXN1azPc0Bff8o9awEWoVvqfwcC7Qb2
         YWw3W86F/ktfCPvSo3fE+LACIAPOVp4OY1hqKcNEwJQfKhxqT3RkuEjgt+Uyl5DTfbn+
         6uQ3SI0MsFRQmbs+JzmV9xfXZEwViUOpkQ/7GiWqf7QSikJa1nNB/8okqYMbHFdoRxtH
         2EvFUpmLZiWnYLhj3jbmQgWzc7/Hcql5CK+q1F4SnrEh/PKUC/yjekO7AxRavP78bCK7
         ZtQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712327824; x=1712932624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSJRYNqAmVBKiGPVSvhxhy0tW7FVAqspgSB3v6fe5Ds=;
        b=lmHYuzvhj8Wyg+i7gXbGzVfi37lbn2rPx3M8UjdLsC32WzWRlOlyZkCclpd4RN1NLc
         VDtLApv3VtNaFPvrAW9o9xW0tvsOEkD3Wqii7DtqmhhB0/6x6+atjdfdw1tE9bQl6w8l
         8yGflySh4BJ2MynloiNsEq5LOZ03EvAr1LAHvb7Kb48RAuSvg0Cx+Qq5KXuPm/WJrLK3
         KDgsSGZL5kwGZS9wahFSoHKAibSdHAtThFJi1fwXnL4drZwYEge+KzZcp1EjtCDe/0Cx
         7ZcsSKWqFu6g0ULG7j/AlZ/7sHuNWo+wPoeInIEeDTRTixizHDViUDo8AuFQt7TteOnj
         /ViQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT2R1anYi6iEMJkqfSrFCZ/m3ADe++9wVnLhxnDm5tMYSOY94+7VwgENm7v8XJDc3b8psa2x25iR1EsxmSRMYBXYsnpv7INYcVL+nm
X-Gm-Message-State: AOJu0YwIkGfjjjgBTfm3tl0oFOF0iFVlWojTTYRnKpTs1UddP4zr3pni
	JGvo300V8/d8wQn661bbprs18o6bjP8gONqMhOHCCy/iNZhJRBaC
X-Google-Smtp-Source: AGHT+IHZlbgRHFlooAtDFVBN7jM5NrSJFl77rEcVoUJUAp4b0sSOmB3NQgvCCqIeb055tv+wzACddg==
X-Received: by 2002:a50:d6d6:0:b0:56d:ee61:6874 with SMTP id l22-20020a50d6d6000000b0056dee616874mr973236edj.20.1712327824238;
        Fri, 05 Apr 2024 07:37:04 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d700:2000::b2c])
        by smtp.gmail.com with ESMTPSA id es18-20020a056402381200b0056a033fa007sm845735edb.64.2024.04.05.07.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 07:37:03 -0700 (PDT)
Date: Fri, 5 Apr 2024 17:37:00 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8 05/16] net: dsa: vsc73xx: add structure
 descriptions
Message-ID: <20240405143700.vaohtglfzcbrcd3f@skbuf>
References: <20240403103734.3033398-1-paweldembicki@gmail.com>
 <20240403103734.3033398-6-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403103734.3033398-6-paweldembicki@gmail.com>

On Wed, Apr 03, 2024 at 12:37:21PM +0200, Pawel Dembicki wrote:
> This commit adds updates to the documentation describing the structures
> used in vsc73xx. This will help prevent kdoc-related issues in the future.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

> diff --git a/drivers/net/dsa/vitesse-vsc73xx.h b/drivers/net/dsa/vitesse-vsc73xx.h
> index fee1378508b5..e7b08599a625 100644
> --- a/drivers/net/dsa/vitesse-vsc73xx.h
> +++ b/drivers/net/dsa/vitesse-vsc73xx.h
> @@ -15,7 +15,16 @@
>  #define VSC73XX_MAX_NUM_PORTS	8
>  
>  /**
> - * struct vsc73xx - VSC73xx state container
> + * struct vsc73xx - VSC73xx state container: main data structure
> + * @dev: The device pointer
> + * @reset: The descriptor for the GPIO line tied to the reset pin
> + * @ds: Pointer to the DSA core structure
> + * @gc: Main structure of the GPIO controller
> + * @chipid: Storage for the Chip ID value read from the CHIPID register of the
> + *	sswitch

Nitpick (not a request to resend): "switch"

> + * @addr: MAC address used in flow control frames
> + * @ops: Structure with hardware-dependent operations
> + * @priv: Pointer to the configuration interface structure
>   */
>  struct vsc73xx {
>  	struct device			*dev;

