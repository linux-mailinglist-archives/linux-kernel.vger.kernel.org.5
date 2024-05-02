Return-Path: <linux-kernel+bounces-166426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EBE8B9A80
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791351F21143
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8127BB19;
	Thu,  2 May 2024 12:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B52KXfMF"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5476341B;
	Thu,  2 May 2024 12:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714651976; cv=none; b=mN2RKQsVPDx6fHNM3qWl4vW/Cb2xO2AuyjZkyGqeJq9N2Z9HOS39DYEtZD5JcxOgjXKwvRs/hfRLs6quvwOmdEF7O0DYZP147E4zKPsZrug0J097a8YNmyb5vA2wXuSipHZkNlQTKJ9S4demLKnwtA7HenU+yreZ99pSGmYK/gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714651976; c=relaxed/simple;
	bh=yyElqMJCjwEyniMrl78ZoWICJ5DjHc3UAY+McBkmy1A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TM0ur3VAVqCD9UjXitOkjTs2M/GquVAac2aM44bgkZ6x5zNH/WRacKmGqCSYhVWIu4k6D1tG0t5Qi7mvZ6nr+lf64WWv79GiILshMJ9wm9PEud42kK9Zz4TTKV71ZcoCoXB25F4px72FJaf58AtxApRdOED/N+NHQS8hWowbErg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B52KXfMF; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41c7ac73fddso37052265e9.3;
        Thu, 02 May 2024 05:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714651972; x=1715256772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8Cd3ceTPfcz44C698EfqoBu5JqoTu9HkF/UxnLB5X0=;
        b=B52KXfMFxh5tYqxvg9GXFXS4zawFyqM18TxJriUCNCQ7i3I5nG89ywQNQEkWHHdcnn
         S7xSL55jOiTIxhdyKw60Yv7Zbp2H12Pkv53Xjz8OICpIS1L5dURzlZcML8no6xqtbkyN
         J2wkWIbmoT7xDJsg3bq8mGwNdQnf7aQNG4N43JA2UGag21R61IaXOdyVFCVk27BxV7Hb
         eXe12LNsXQMqTRS56JZvKKRTfJxgL2YMxUuJ15g5tJq51u9m7uYQYebQpgaP5/Fj1cz+
         VLbxR/G5PImfvcYuq5cNd/1lGi88nYYx7OhovjOMFJzTfxvaTj0Zi6smAGGWyWjuW+2i
         LvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714651972; x=1715256772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8Cd3ceTPfcz44C698EfqoBu5JqoTu9HkF/UxnLB5X0=;
        b=neUd9SFPkWyaDu/NUMwoPZif+LCnaGPU51pNa04Egg/Z8BIWGJby2tsdnawJa517sH
         6sobTVd8PQmEPtptC6hXIHzGILX/g731OFKqdUyi/6Sb9YzxnvCBmCiXlz+FoUhk6mu9
         ohxjsvs0TXf00ItFnfXQxSjai7r3EQrL9UDz03RWg1vsXDxajq/J3kGp+cgFWGcdQRPl
         W4w616nhEcLRRe8hiJKlyx2TVA7Tn8QjGmqz7JP/Zm8kYuGMDa49lVtcE9Hntsgt88kx
         da86dYLS6dtNMkVfScwsNXZ64vOXrhxLFVWhpPLNjEVUfrhuTPQAqhc4lgLFO68LrYxC
         xkyg==
X-Forwarded-Encrypted: i=1; AJvYcCVc8/CTp9BcYLSh9o29aWBi3PUxJGGeRxidvBT6+j0Zaeg9eHGMBUkl2e98NeMbvH2OF0aF1N7rndo7gspnTEUEcgm6L7odcdO/JTZzID3pix+WpNUrwNSPf0Mdq20OaL3jdwLKQuwUYrEIG9jeMtuwj4ojwZSIQZwhQsnrSfeUhGsDuary
X-Gm-Message-State: AOJu0Yx7Zf03V2K/8Pee+ZXV5dfALgooR3DJK3Mlb4Lqlu4mxd967DDg
	iW2SPjQAtLiUiSbYjPKD0AlSJu9gnSMAMcAIOngeD+wNCRkDQ9Gr
X-Google-Smtp-Source: AGHT+IE/ykd6eS4f3MLm+LcCsfX7u1lOan3YS1bdHWF7JBh0lA6Mqpa4nhct1WoxyL31nuJMkI1I6Q==
X-Received: by 2002:a05:600c:5250:b0:41c:b44:f917 with SMTP id fc16-20020a05600c525000b0041c0b44f917mr5148027wmb.22.1714651972334;
        Thu, 02 May 2024 05:12:52 -0700 (PDT)
Received: from localhost ([217.151.144.138])
        by smtp.gmail.com with ESMTPSA id m7-20020a05600c4f4700b0041b434e5869sm5486417wmq.43.2024.05.02.05.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 05:12:51 -0700 (PDT)
From: Oliver Graute <oliver.graute@gmail.com>
X-Google-Original-From: Oliver Graute <oliver.graute@kococonnector.com>
Date: Thu, 2 May 2024 10:41:23 +0200
To: Andreas Kemnade <andreas@kemnade.info>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, o.rempel@pengutronix.de,
	u.kleine-koenig@pengutronix.de, hdegoede@redhat.com,
	ye.xingchen@zte.com.cn, p.puschmann@pironex.com,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
	felix@kaechele.ca,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: input: touchscreen: edt-ft5x06: Add
 ft5426
Message-ID: <ZjNRs/PVleEq2z3c@graute-think>
References: <20240501204758.758537-1-andreas@kemnade.info>
 <20240501204758.758537-2-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501204758.758537-2-andreas@kemnade.info>

On 01/05/24, Andreas Kemnade wrote:
> Add compatible for ft5426.
> Searches for documentation reveal neither edt nor evervision
> as some related company, only FocalTech.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/input/touchscreen/edt-ft5x06.yaml        | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
> index f2808cb4d99df..71fd3c66c966e 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
> @@ -39,6 +39,7 @@ properties:
>        - edt,edt-ft5406
>        - edt,edt-ft5506
>        - evervision,ev-ft5726
> +      - focaltech,ft5426
>        - focaltech,ft6236
>  
>    reg:
> -- 
> 2.39.2
> 
Reviewed-by: Oliver Graute <oliver.graute@kococonnector.com>

