Return-Path: <linux-kernel+bounces-102343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9D887B100
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 733BA1C2676A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD316DCEA;
	Wed, 13 Mar 2024 18:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOjFvhza"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E3760B94;
	Wed, 13 Mar 2024 18:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710353904; cv=none; b=cowb46PL7lGBiaijFAFPYtg/AAAQiqJpWCTF7DuZVgBozoeGnQVE4Rtzy2pLU8BrrLX2kzn2VNCQf8Abdr3noeugWVMrxVmvVfLmbwYWIeu6XYlHQo1AyfWOinldL7ectRB4x42UJJ/p3CSHd2YxpROsTkVkvNIsHeHIjfnBklg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710353904; c=relaxed/simple;
	bh=BGNgiGNyp2r/WFo9AF80RMtpr7W+rRwBh6nlDkVQ6VM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FLegn8VcDQdgRGiQG73KLcDgltutILJS+6q7Li2YEMZTnuWIO+1eQzQuthSWONKlhIFL/wfRu277aAoLcJ7Au7S0TYq3+/DbiVFRVf1sLcC8o1ifk8+FrOMRvqzk7LamkJj1OPtTZSIlRSMnjdT4QbdvMkljh2L9/JDz3YyBJwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOjFvhza; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33e92b3b5c9so70833f8f.2;
        Wed, 13 Mar 2024 11:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710353901; x=1710958701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yCc0/S0zgq2oMArP0ajpR3WFLegRCSHAl26z/qpqpk=;
        b=QOjFvhzaBvvPk8OKJ1iIrYQxl5DVUU03Q7RiCCei8VXz6lbTtJTCq7JMyLaPKtNC9I
         ZJKpaM0Vyrx7S3tItqIdE6mmekwHU9Jm+uzYPnm+3aofVQmQ+rmFdhDN4tQt39SbChyW
         +rz9zw7opuj98SuXnOl8lqzpnk4shspiJnG/132LYbNRCQ8WTCuLJHopiav85/qwT+1z
         l71pI0tZ3+qj4JnR5Y/DnqkV45eHi/obA36WwsYcW3QcR+AXIjOcVYCLSt9eae9ElKjx
         FhoXfy+DtnZM5ACHj9pkZqu//yNFFrOmpuzPkRQ1GZQktnA/Ikxyr/QKKhKKlVQNpRff
         VDgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710353901; x=1710958701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9yCc0/S0zgq2oMArP0ajpR3WFLegRCSHAl26z/qpqpk=;
        b=kuvafqlMPIwu82PpfNngy4GEGyAj3PlGtGKP9xI9sVR2Ag4Q3S3IhsDkJmkcF9j7cg
         NspLBu9VfznWUKCJ183GaQ+4PG5I4Ky1MRBtq2Aj0adrFcF3BgeQ9yxnPSkFSA/Jfv00
         FtNfnhrBc4NlYnBayMdknIlUa2gmOrMhDAJWrJa3bjtdcHNqxonf3+OeogVj9LBq0Cld
         gBwa8J9++3Ni0UIPZTAOqumAHX9vx0sv3BoV47GuYHUf3Iy7u0YGvOeM+VEUazEldRys
         e2rEaEaYOXAwF/3iWJYS44pF3fgJovNffA689ZYtJbReYWDnrVAiCzLRYdeCTkPHN1SS
         1w0A==
X-Forwarded-Encrypted: i=1; AJvYcCUmSveEM7V3/5KUAqmD6PdrgO9Kuh+dyZMfXj21uxPO4pj63M8nVqdZiXeYBccMY3IUkYlgy2GZXjX0bBpn5n22397VVL9RBYqS/OS4R7tUuojdwYhv/d6eTmCsEuoVqirtOLAEQ/5bTBkOs9xJ8a3RixLTPs3IiUXgEQD62Y7/nA==
X-Gm-Message-State: AOJu0YyNRh8bd+zq3pA0aLXdpDxGkRyy0OJkUx7jiEfQBNfHjmstbR0F
	Yhd+Ci9qurQYZCuYtX8S2JtwT0R47qY3ww2JyxPnXIaUX2Qes9SW
X-Google-Smtp-Source: AGHT+IEINZzKrCwt57AAp8s6840j6RZ2WxfBjoKO1fAuijCL24OCWLtQpTpKGO8XI3jgUHD+eLF9Zw==
X-Received: by 2002:a5d:4d42:0:b0:33d:a190:f0c with SMTP id a2-20020a5d4d42000000b0033da1900f0cmr1974873wru.16.1710353900734;
        Wed, 13 Mar 2024 11:18:20 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id h4-20020a05600c350400b00413177c3f1dsm2962129wmq.18.2024.03.13.11.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 11:18:20 -0700 (PDT)
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
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Oltmanns <frank@oltmanns.dev>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 Frank Oltmanns <frank@oltmanns.dev>, Diego Roversi <diegor@tiscali.it>,
 stable@vger.kernel.org
Subject:
 Re: [PATCH v4 2/5] clk: sunxi-ng: a64: Set minimum and maximum rate for
 PLL-MIPI
Date: Wed, 13 Mar 2024 19:18:18 +0100
Message-ID: <1784566.VLH7GnMWUR@jernej-laptop>
In-Reply-To: <20240310-pinephone-pll-fixes-v4-2-46fc80c83637@oltmanns.dev>
References:
 <20240310-pinephone-pll-fixes-v4-0-46fc80c83637@oltmanns.dev>
 <20240310-pinephone-pll-fixes-v4-2-46fc80c83637@oltmanns.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dne nedelja, 10. marec 2024 ob 14:21:12 CET je Frank Oltmanns napisal(a):
> When the Allwinner A64's TCON0 searches the ideal rate for the connected
> panel, it may happen that it requests a rate from its parent PLL-MIPI
> which PLL-MIPI does not support.
> 
> This happens for example on the Olimex TERES-I laptop where TCON0
> requests PLL-MIPI to change to a rate of several GHz which causes the
> panel to stay blank. It also happens on the pinephone where a rate of
> less than 500 MHz is requested which causes instabilities on some
> phones.
> 
> Set the minimum and maximum rate of Allwinner A64's PLL-MIPI according
> to the Allwinner User Manual.
> 
> Fixes: ca1170b69968 ("clk: sunxi-ng: a64: force select PLL_MIPI in TCON0 mux")
> Reported-by: Diego Roversi <diegor@tiscali.it>
> Closes: https://groups.google.com/g/linux-sunxi/c/Rh-Uqqa66bw
> Tested-by: Diego Roversi <diegor@tiscali.it>
> Cc: stable@vger.kernel.org
> Reviewed-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> index 8951ffc14ff5..6a4b2b9ef30a 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> @@ -182,6 +182,8 @@ static struct ccu_nkm pll_mipi_clk = {
>  					      &ccu_nkm_ops,
>  					      CLK_SET_RATE_UNGATE | CLK_SET_RATE_PARENT),
>  		.features	= CCU_FEATURE_CLOSEST_RATE,
> +		.min_rate	= 500000000,
> +		.max_rate	= 1400000000,
>  	},
>  };
>  
> 
> 





