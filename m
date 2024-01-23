Return-Path: <linux-kernel+bounces-36039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB5A839A88
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9001283D03
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74F05250;
	Tue, 23 Jan 2024 20:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxuaT8JX"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EFB63B2;
	Tue, 23 Jan 2024 20:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706042817; cv=none; b=nxgeZCc4x6BtYnXr8bBzJy8RkkSu/ku70+2haqpWaIpdKH4m8VE8vaLovbBJw4lkFamaoM1POJzmJTnF5J0jY6sP4G0DXH6b9k/rNaSVSM558II7jVvYdoKQ44IcVUeW1ErzJ9MqANHy9aCS1ZLSUgzGIuBqEO1Z/xUp6BkE7S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706042817; c=relaxed/simple;
	bh=YZHodvUWAeuvnhi1pJmgPsoMYoy8W6KTZoyK3m9HKlY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=d0drX0XGpD344KNy5p3pBiZiMCe0CQSr88a7f5nStMkrCu0eJqHbOG3JYzZ3mutrKoXLfkznRvpdzKN+pB2pTEDMwore2ZbnQ3WVHb3UxbtvCmIA8RVNr/uNlrZHdG5LY2ajp+NDIpl9YFmu47yjMnD2L/0R4FoSVg7I7HYg20U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxuaT8JX; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40eac352733so28551265e9.0;
        Tue, 23 Jan 2024 12:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706042813; x=1706647613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sq0tMecm3i3zHlp+86M5Zkr7Njk4ZDjptPk+ajtPCMg=;
        b=dxuaT8JXbV6nH4lBJJqGY0PFuBpcwtyRLLHh6u1BxUR2x8H8yKQtRndmZNXP4sh+fQ
         Swav0Cl3RcxqLuFAwIDj1epCnM9MtlUXeT2SBHA2+CIvyrCQCB9MqyOd0CDnU7b6K5VR
         3VEKH4pYfPcRbVHQW/UFMciDV39fVubps74TFT5ovJ6hpKSlzJ+BVZsOIZIrZEW7U3DA
         p03lAKXtIZEO8P3oJeNLTzjPEZhwK3f93DxuLcr5mkRSvN+543ATAuJSNlB1LN9O4HzN
         peMFWFZ8ZAsPGO9z32TK1Uwl4umHB00G87P0/yLNqNE/hs4NswFA47MWo2oX4/zdKBtm
         tEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706042813; x=1706647613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sq0tMecm3i3zHlp+86M5Zkr7Njk4ZDjptPk+ajtPCMg=;
        b=BA1FS8RbBjc/NrHafkB2w0csU6XVC78iejsNQD40FTCp2FCXUpIEtUoZzBYT4Bf8Wx
         QllWt5qtyiw4DCmY+EcvltX+vAJFmYNjdrLa98p4ts0q/16pPvkes6eHeKJbtC+pUc+6
         MjMaML2zKi7JiSZ1wGFKSYSQj4QAHHQiBXlN8hxuWOvuB8/7Ziv94DvTF1aHPKvk84VT
         KKDIxp9N6tjijT50wvwpZqlfo6SfZNtAMcGujPWTt++lhpX3TEftEnCmxYNIMR3BQpml
         jUCeEWox2Q32yd8Xn2GWZrGc/1WlYAoOTAuMV1eYUGgs28JUeU9HTHgQuzM2enl0ddTi
         QUbQ==
X-Gm-Message-State: AOJu0YzxVApg671TffG9xWv2AF53DD2wm9o8kVMkANyayd/sHJF/hIdX
	jCHymR+S0G2cMu8lh/Lm6zm+6JVJPbeg8VcrXb6eUcZf/D+SNvvs
X-Google-Smtp-Source: AGHT+IGvUC5Ht5Wo8CwoFJ6X2/sTIe8RA850NVi6zqWSjYp/joLV25WudT26G53MKdSgM2/pOUDoiQ==
X-Received: by 2002:a05:600c:538e:b0:40e:4dc1:fbc0 with SMTP id hg14-20020a05600c538e00b0040e4dc1fbc0mr517877wmb.60.1706042813473;
        Tue, 23 Jan 2024 12:46:53 -0800 (PST)
Received: from [192.168.0.28] (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id l34-20020a05600c1d2200b0040e89ade84bsm23386198wms.4.2024.01.23.12.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 12:46:52 -0800 (PST)
Message-ID: <9b1d7c15-16a6-478d-975c-5c375f8674fe@gmail.com>
Date: Tue, 23 Jan 2024 21:46:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: savicaleksa83@gmail.com, dan.carpenter@linaro.org,
 kernel-janitors@vger.kernel.org, error27@gmail.com
Subject: Re: [PATCH] hwmon: gigabyte_waterforce: Fix locking bug in
 waterforce_get_status()
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240122154952.2851934-1-harshit.m.mogalapalli@oracle.com>
Content-Language: en-US
From: Aleksa Savic <savicaleksa83@gmail.com>
In-Reply-To: <20240122154952.2851934-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-01-22 16:49:52 GMT+01:00, Harshit Mogalapalli wrote:
> Goto 'unlock_and_return' for unlocking before returning on the error
> path.
> 
> Fixes: d5939a793693 ("hwmon: Add driver for Gigabyte AORUS Waterforce AIO coolers")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> This is based on static analysis with smatch, only compile tested.
> ---
>  drivers/hwmon/gigabyte_waterforce.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/gigabyte_waterforce.c b/drivers/hwmon/gigabyte_waterforce.c
> index 1799377fc2f1..7bccfe2eaa76 100644
> --- a/drivers/hwmon/gigabyte_waterforce.c
> +++ b/drivers/hwmon/gigabyte_waterforce.c
> @@ -146,7 +146,7 @@ static int waterforce_get_status(struct waterforce_data *priv)
>  	/* Send command for getting status */
>  	ret = waterforce_write_expanded(priv, get_status_cmd, GET_STATUS_CMD_LENGTH);
>  	if (ret < 0)
> -		return ret;
> +		goto unlock_and_return;
>  
>  	ret = wait_for_completion_interruptible_timeout(&priv->status_report_received,
>  							msecs_to_jiffies(STATUS_VALIDITY));

Reviewed-by: Aleksa Savic <savicaleksa83@gmail.com>

Thanks,
Aleksa

