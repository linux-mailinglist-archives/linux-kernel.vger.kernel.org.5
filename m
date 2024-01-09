Return-Path: <linux-kernel+bounces-20838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3194C8285F8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4BBDB23FC7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC44381C0;
	Tue,  9 Jan 2024 12:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZrVbgLCn"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C75A381B4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 12:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e5280a33eso1927725e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 04:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704802943; x=1705407743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s+mFmDvLzl1W8S/o/HBXWXg1x6nCRXGw45+KcA5RU+I=;
        b=ZrVbgLCnXy0yT9YGv9BZONMWMy+ej6LIlp3QkT+OVG7SUmzjevbYMuVtGBmNKbu+b6
         qzfOp4yNW7O9dN7tCxNxVD00g6xRjzHzzGHuW2w8eT21eT87VuEPfM5MohLZS0Uf+3vH
         VSBXyPU6QcFgA4ovUWjjp+eKLz1A9QRYrG3ADsatYW2Xvf4MnT8kTuEMdFKSX79oJK5e
         J4pE2elKlHrqBi+ZYJ7kUHrB3K3BpJh568p1UCdItXIeopnIDlekf1N9uHCR49+oO/36
         jdD8BU1Sp2zBCNQPVHIn3tvbTKBGVDPhK7vjOhEqBOcqrWV2rLPm2Mw/2lJpjY2fQOPS
         UCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704802943; x=1705407743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+mFmDvLzl1W8S/o/HBXWXg1x6nCRXGw45+KcA5RU+I=;
        b=DFbvJHbQmEhCM82nwVN8oWPWN44wccelyITdpTPzquiR582d9G0TaRmXZFahLPQYIZ
         JGkbk9IN7z7UeWbM9y5kZlknSjE79Dy/T9YMTJZ2e/W2m3TO0pIZ8npalZY3tSTjGTA+
         E7e94heNrdjp54r+r8M3DzSEVYJd5EGTYt88Iwx+kn4zdznffWuq6WxqN+Ou/RrkOunm
         7WQWGJ3mk1SwBWdU/vjjBQzIoTZWm1hJ30i93l42LenxwvBbzccYA7PmJmpiWT6qQLVV
         17u1d18gX6coPvAEI+ewqTpH4iEw+M2QyCbWcTLKu4M2rvS8aNdJlmw9U2oqzVuriagh
         0hKQ==
X-Gm-Message-State: AOJu0YwnqyIVDDR16v4AmuZkUMQGWauWn428G6i9UZEFhI9dcWvfPvg5
	wEznhASfsEiZmRUvAN4Niq/Pe+4oHDf/ig==
X-Google-Smtp-Source: AGHT+IG4OFzVoMmxpgZZz+Is/bVT/V4t71XFSOPqm7Bop/mY179ODSjKjt3PlGxUcSwO9dnR7hzsnw==
X-Received: by 2002:a7b:ce0f:0:b0:40e:4bce:f952 with SMTP id m15-20020a7bce0f000000b0040e4bcef952mr371445wmc.95.1704802943561;
        Tue, 09 Jan 2024 04:22:23 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id e1-20020a056000120100b00333404e9935sm2275101wrx.54.2024.01.09.04.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 04:22:23 -0800 (PST)
Date: Tue, 9 Jan 2024 15:22:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: SilverPlate3 <arielsilver77@gmail.com>
Cc: forest@alittletooquiet.net, gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: vt6655: Fix sparse warning. Restricted cast.
Message-ID: <d6489a61-3985-4fc2-9eda-333ea8fa02ae@moroto.mountain>
References: <20240109072704.44582-1-arielsilver77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109072704.44582-1-arielsilver77@gmail.com>

On Tue, Jan 09, 2024 at 09:27:04AM +0200, SilverPlate3 wrote:
> Running 'make M=drivers/staging/vt6655 C=2'
> causes sparse to generate few warnings.
> This patch fixes the following warnings by ensuring le64_to_cpu
> handles only __le64 values, thus dismissing chances of bad endianness.
> * drivers/staging/vt6655/card.c:302:45: warning: cast to restricted __le64
> * drivers/staging/vt6655/card.c:336:23: warning: cast to restricted __le64
> * drivers/staging/vt6655/card.c:804:23: warning: cast to restricted __le64
> * drivers/staging/vt6655/card.c:831:18: warning: cast to restricted __le64
> 
> Signed-off-by: Ariel Silver <arielsilver77@gmail.com>
> ---
>  drivers/staging/vt6655/card.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
> index 350ab8f3778a..5dc2200466b7 100644
> --- a/drivers/staging/vt6655/card.c
> +++ b/drivers/staging/vt6655/card.c
> @@ -292,6 +292,7 @@ bool card_update_tsf(struct vnt_private *priv, unsigned char rx_rate,
>  {
>  	u64 local_tsf;
>  	u64 qwTSFOffset = 0;
> +	__le64 le_qwTSFOffset = 0;
>  
>  	local_tsf = vt6655_get_current_tsf(priv);
>  
> @@ -299,7 +300,8 @@ bool card_update_tsf(struct vnt_private *priv, unsigned char rx_rate,
>  		qwTSFOffset = CARDqGetTSFOffset(rx_rate, qwBSSTimestamp,
>  						local_tsf);
>  		/* adjust TSF, HW's TSF add TSF Offset reg */
> -		qwTSFOffset =  le64_to_cpu(qwTSFOffset);
> +		le_qwTSFOffset = cpu_to_le64(qwTSFOffset);
> +		qwTSFOffset = le64_to_cpu(le_qwTSFOffset);


This isn't right at all.  You've just to convert it and then convert it
back.  (In other words do nothing but in a very complicated way).

This isn't a bug, it's just an issue of annotations.  The code is
re-using a single variable to hold both cpu and little endian data.  So
the way to write the annotations is to create two variables, one that's
cpu endian and one that's little endian.

regards,
dan carpenter


