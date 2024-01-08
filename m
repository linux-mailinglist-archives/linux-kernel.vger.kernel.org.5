Return-Path: <linux-kernel+bounces-19166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0710F826903
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABC87282306
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878EFBE6B;
	Mon,  8 Jan 2024 07:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ICmVvVCN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353438F5C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 07:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3368d1c7b23so1577722f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jan 2024 23:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704700707; x=1705305507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=22GnWJEolWDoUmtgnWlTz2yR3gzlLLCnrhahsHJ5GNM=;
        b=ICmVvVCN037RYlVF849WJFurBQQ4AvE4j6VAs39kQUAEl2uBfv5qZhRyvn/BY2R3rq
         C0TwqUHZkJB2aDmOT+Qz2FKYESjFRC4KD68G8xWEzibctEtiVAScZc0wXL7Ila3s0uxU
         Dy0Wd1hGYs9TBMqKJb81VqPukBT8OOoWFY03g46OwEpdJAStuw+JWAdL2Y5msbBrye8w
         lsugobNgKQTCKtSruMpPtLCJMD14wQOR54ppa3pHbv3G+nb7KAFjOgzeGiftLSHNxsof
         euyTnArT2KUhkSvQJ0aRCEfMvpFKnMcTgJ3NeSPu+Mn2+ScGkvnq8M/wDzA0vqEz1Wo9
         A2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704700707; x=1705305507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22GnWJEolWDoUmtgnWlTz2yR3gzlLLCnrhahsHJ5GNM=;
        b=CHR5I6h6vbvxLAXdAmU8zIUc+sowiJBRJhzZJ0vNwrxYMPVXeqVVhWeJSMtYUxeFbk
         hdiWN4rguECq0xBwuCNrQ5BDd2RX4H+78CaWdPT6dr3HokQJLrMROJWQ9IdznmV7QHQP
         05Z/WNSaBXNbh7vY8yUlKmtT/jbmgCY7BzFLCrIJz9/QKsXstuh6zzeUPSrmv39I3V8U
         8zkdrQ6ADLFIxNIOVYIRZpifCQN1dCeeNj+cvJPftQOeOrWIq30pZsrrEsFrX4GPKvLc
         TVKX8PlLVMMEWs7S5vGusq+lL9nXBERdVYXHfaAu+E85iNMLCbiWoZCUsJw8VnihwnUP
         94Vg==
X-Gm-Message-State: AOJu0YzZK+nPlij5LjagXZwZWQCR/pUYklNHdmFSvViFgWvPFuR62a65
	yMijHjflAbuKQv9FaeLjFnC8LvIPw9e7Aw==
X-Google-Smtp-Source: AGHT+IEhO8W9NrKFr+1v+YuEt3zSnIMP1x5ul3UCIbMMaDcO/kuxMS2uVdG1do1yLqS3HEuwFOeNig==
X-Received: by 2002:a05:600c:4fd0:b0:40d:6ea3:9bd6 with SMTP id o16-20020a05600c4fd000b0040d6ea39bd6mr1648289wmq.178.1704700707353;
        Sun, 07 Jan 2024 23:58:27 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id h4-20020a05600c314400b0040d7c3d5454sm9967101wmo.3.2024.01.07.23.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jan 2024 23:58:27 -0800 (PST)
Date: Mon, 8 Jan 2024 10:58:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Gary Rookard <garyrookard@fastmail.org>
Cc: gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] staging: rtl8192e: rename variable is40MHz
Message-ID: <897a8bb4-a1d7-46ab-96cf-fd5ba447d2d8@moroto.mountain>
References: <20240108032233.4280-1-garyrookard@fastmail.org>
 <20240108032233.4280-2-garyrookard@fastmail.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108032233.4280-2-garyrookard@fastmail.org>

On Sun, Jan 07, 2024 at 10:22:29PM -0500, Gary Rookard wrote:
> Coding style issue, checkpatch avoid CamelCase,
> rename it. is40MHz -> is_40mhz
> 
> Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
> ---
>  drivers/staging/rtl8192e/rtl819x_HTProc.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> index 6d0912f90198..1b1cb9514028 100644
> --- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
> +++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> @@ -87,36 +87,36 @@ static u16 ht_mcs_to_data_rate(struct rtllib_device *ieee, u8 mcs_rate)
>  {
>  	struct rt_hi_throughput *ht_info = ieee->ht_info;
>  
> -	u8	is40MHz = (ht_info->cur_bw_40mhz) ? 1 : 0;
> +	u8	is_40mhz = (ht_info->cur_bw_40mhz) ? 1 : 0;

This should be is_40MHz.  It's metric.  M means Mega.  m means milli.

regards,
dan carpenter


