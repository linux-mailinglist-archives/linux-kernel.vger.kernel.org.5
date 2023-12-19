Return-Path: <linux-kernel+bounces-5594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E55BC818CCE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24DE3B250C9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C040320B14;
	Tue, 19 Dec 2023 16:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xinhqs8t"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4218F37D01;
	Tue, 19 Dec 2023 16:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a234dc0984fso323825566b.0;
        Tue, 19 Dec 2023 08:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703004422; x=1703609222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NeShSK6cVdZ3tR/tSiq3rkncbpvvwt6PkK61/vcn6JY=;
        b=Xinhqs8tvxNzeIoc02/jCs+z9B4PbEIc65GByBLhPcXBwvNn+tzDvd9dQkVQAqC4Dd
         Uxshn2jcRCoPz3I12lRUrruDq20mPALEKs27+qyI/qcsWv39rCz48F63eViK2Rf2qVlS
         w6qR/6G3jXkLJaJMHecuMJqcEMCME5/bNRLHDgniGKodxwPtrt6QRk86BJFHKAcnTLGW
         ryIQhwI5GQXEMlFju53aqXBASoTsnihmBtxwG50wU3K2PMjqs3QVfJ++S4fqlqBkNGBF
         QuuAtMvXd+ALAkYsVYLAEXqdgT+xZetteYCQmw5tqev5fwI0DbebuUCWPLBUBUj83CjO
         6Slw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703004422; x=1703609222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NeShSK6cVdZ3tR/tSiq3rkncbpvvwt6PkK61/vcn6JY=;
        b=mExwoPSa1OuFTQbMS9faXGya9dzmU4gccPcjqJ4HKwWG391pfq3Igczcq9Rpqd5za5
         0jdZvefYdDAKXQv3xmQbmJ+9Vv5Ed9DGH0P5/QvwI1gOvBj1tr+SOmANyOErPdV0A1zW
         QqUuofOsXH3PoBi/adgGyZftOqDMvgnXSMNlE/XQjVOZqLjAAIL8cP95Tt2d1m4kiw15
         Z6OqfuW8bTqodw6ccVJFgpGOF5i1QoKUGZQGyur4WTmfGKAKZUrr7h6lVhfPlDdSNlpF
         Lotd28xPk/QRtaYCQh2aVw8p5w9M+J7r535kFgm79b4PbaAvg+CNRuLzwi++fD1/LTww
         0iGQ==
X-Gm-Message-State: AOJu0YwFt83IvwEMZislhPlca8nQZGKbpwKLc7ho09JsXT1BlMrMT0xB
	aDqkoTINxzyssIxt+dK6DDw=
X-Google-Smtp-Source: AGHT+IG/BM4Mx/0Unwhzt2oGgH1Ni3lsEEn7GjfNPeGpMSmWn0LI6JdBChftgTkGEW3WIn9NXYk51A==
X-Received: by 2002:a17:906:c214:b0:a19:a19b:78bd with SMTP id d20-20020a170906c21400b00a19a19b78bdmr8931356ejz.128.1703004422323;
        Tue, 19 Dec 2023 08:47:02 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id x24-20020a170906135800b00a25501f4160sm780675ejb.1.2023.12.19.08.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 08:47:01 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
 Purism Kernel Team <kernel@puri.sm>, Ondrej Jirman <megi@xff.cz>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Frank Oltmanns <frank@oltmanns.dev>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Frank Oltmanns <frank@oltmanns.dev>
Subject:
 Re: [PATCH 2/5] clk: sunxi-ng: a64: Add constraints on PLL-MIPI's n/m ratio
 and parent rate
Date: Tue, 19 Dec 2023 17:46:59 +0100
Message-ID: <4881920.31r3eYUQgx@jernej-laptop>
In-Reply-To: <20231218-pinephone-pll-fixes-v1-2-e238b6ed6dc1@oltmanns.dev>
References:
 <20231218-pinephone-pll-fixes-v1-0-e238b6ed6dc1@oltmanns.dev>
 <20231218-pinephone-pll-fixes-v1-2-e238b6ed6dc1@oltmanns.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne ponedeljek, 18. december 2023 ob 14:35:20 CET je Frank Oltmanns napisal(a):
> The Allwinner A64 manual lists the following constraints for the
> PLL-MIPI clock:
>  - M/N >= 3

Same as in previous patch, should be "<=".

Best regards,
Jernej

>  - (PLL_VIDEO0)/M >= 24MHz
> 
> Use these constraints.
> 
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> index 8951ffc14ff5..c034ac027d1c 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> @@ -176,6 +176,8 @@ static struct ccu_nkm pll_mipi_clk = {
>  	.n		= _SUNXI_CCU_MULT(8, 4),
>  	.k		= _SUNXI_CCU_MULT_MIN(4, 2, 2),
>  	.m		= _SUNXI_CCU_DIV(0, 4),
> +	.max_mn_ratio	= 3,
> +	.parent_wo_nk	= 24000000,
>  	.common		= {
>  		.reg		= 0x040,
>  		.hw.init	= CLK_HW_INIT("pll-mipi", "pll-video0",
> 
> 





