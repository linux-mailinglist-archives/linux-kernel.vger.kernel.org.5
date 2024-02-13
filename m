Return-Path: <linux-kernel+bounces-63038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E3F8529A2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D421B282299
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E2817566;
	Tue, 13 Feb 2024 07:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtuWQrdQ"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EF6171AF;
	Tue, 13 Feb 2024 07:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707808878; cv=none; b=cFZV+gkI/htiZ1elXKtb+edkzWqGpy/9v9Gh/2iWLuswIb2O7sYpS0MW1O/1JbLuYrt8M/H/x4w8SGbpIhlzJhkttV1uQatIuGsMGfnU5aUsL7icttaB/QjP0PSQPdaDVWf1IikvV3IcCdsJRWq4dkx74eC3HgV6kjbjb3daVr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707808878; c=relaxed/simple;
	bh=gOBQOWJMUMfNtbxdju9G/6MPpVI+aiIiDWC+zaTV8BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNAndGScUsJWV1EYEKPlwYeQXEN0C0taWdAJQGuKRIfRSYdXPlH4TGnNrwHkmqmKxubGvAbyfOh03V+J5wk4YUkT+ZEqxm/QZgYeUOezm9FXGOo7gKPf4y9P9M/QOIL1boW0yERo3MsXoAJfKEAEYo0eodDT3CErclxSfZUokhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtuWQrdQ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-411c863c1c6so384725e9.0;
        Mon, 12 Feb 2024 23:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707808875; x=1708413675; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8CoOnrmU5IgwoMjOJC9hlVJa4bE1pFzCtcl4Q05gH4k=;
        b=BtuWQrdQBv/mULrRrvNsOPNA29bY4UF8GzI9dqQRCOnq4GfQqxK7yQ6r6ROc1AYhCd
         KmrVhsoczleFlj0lgd/CDC/eFWOJtSVk5CUJRp2lpIoSle4EzKk3wh3cgOSVnpMTO8fu
         dZxhIyzcZQvYOFNjHMnMQnyH99P3SUALUMqfPU8j82L3aoff2cDKidaDmBN8iGSeUND1
         v6S8MhHhmf/NDT9rwKNW19/m1TecT1/DiGxE536J7XjtDwx//U2YqASu8ace6ApHdqgp
         XcLa9nrTZWw8k7AT7IxNGzJBHTdpOhbSdLZqglwSvksVZYSexDmABLAwQ58wrorgQhcq
         0kug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707808875; x=1708413675;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8CoOnrmU5IgwoMjOJC9hlVJa4bE1pFzCtcl4Q05gH4k=;
        b=qGru3aA0congFJxwI6hG4kiURztZV7IC9uaXluFm/W6WgoEqLhZRT/u9T/yZnDihK8
         m95a0hZYc8pyZ5DVc9vgpBM9FIyyeJWdjUgxXf2YEWt2Y1+pC3zxCwj/zx1KyPDhXAsy
         nagYnFcbs3tU98A20mUZ2uAvjPOgbcKxhRu9/FoUgNhBeCUi/n2O/MeiegjHH0d30me4
         +BOglg5hwbgrCj57bgUucOWZ877xd11pkeGqS2dw9RIkImPJZCmRm7PDFCVkrG6zeNgE
         p0NCAnYttp9hg5MuZrWhgGTsHiHdkSWIi/0+A4btfEABMzBI+ojW78G0qnpTZZ16hp5v
         nEdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLaF304pkdI1PoELRr1YXeO4RzVxcPnJ7+I9AKP++crezb6Ya1yASv8xhfO2SybnbUdlQOZo/Bm7EtlCoFUeCUx2w7O8nuCtVr1Y8vKyUr521wwsJoKsGjfp0i8oo2kQjtQEN1jhOyrFwTwYWQ/QgMCegjMbNrCNUXtf0YFNUDcq+Wxd+H4A==
X-Gm-Message-State: AOJu0YyH5A1N1NJfTX5o1vbOciudoT9311nyL+Bg37c7qpqp0exkXTOX
	A5OC1pNFn7g6P8EOGN+vlu4upuCoWJUDAgiNY+RjJH9BiL/Zj6Ul
X-Google-Smtp-Source: AGHT+IEBIcujhRDn+1hfgiVtv9AVDgqqgKjFxDvFFBFMnQPxLW374rkT4yy5yy/O2btL53SNRC3jEA==
X-Received: by 2002:a05:600c:4e4f:b0:411:b334:2ff0 with SMTP id e15-20020a05600c4e4f00b00411b3342ff0mr1033156wmq.24.1707808874828;
        Mon, 12 Feb 2024 23:21:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXJ+mVPsRajillNQzfK5RfT4+AfUgV6U+MVBinI8U04MvPycDa2dobzqU+K0Eww377kXmD7SsZDI0t9VZdK0fT7JxBe9m6TbunNmmC0oa95bNnLw3FWCCGhMy+QH3zHQ7lxLcCeKv2nFxwRYC3DXf0oOurYkdqlpwli/hUOx2ORhWZ2yaSd+mIdnLdOty4IIjYrGN+IwT8+Iz0NNVxsQOc3o4vj68khEtLKjeLK1flXAnr/6VFdch1Bmc3tzhRUJ30Hr0SN6cDS+HqETBcItLNb+4PL2STGilGGSTQyG5pETo9pT7/pwBogHPy8/L9phG0EO1hVTotJIk7sOdsnOln3wbqlsPTnFdK/S5cK8WcDF6jpV/hKr12gSmb/Njchw7Gx3WGRpNBz6Z5m5tqj/7NI5u+qQ/PW8mTWDwum48fMgOZyMA0A0lyvoHJabNNJZN1A+U6//yTwkI691g2K9xjhdEBt1/sjaI33zglgaKjqny4u8cKsT7DUrouZUxdz5DAvCHOQWC0wReh0EwdqtCd8vNQJN+XQh6jjp8ARLqS7hLwdPsBnx83zpRdtPjZevE6oofuZVmZZ15Ce1L85EBIHdTch61FpGMIpZDlB5Sb3IVRpGX4KvyguaDAi+5FcUGqGQsH2wK07
Received: from Red ([2a01:cb1d:3d5:a100:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id m14-20020a05600c4f4e00b00411bff9f7cbsm695225wmq.37.2024.02.12.23.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 23:21:14 -0800 (PST)
Date: Tue, 13 Feb 2024 08:21:12 +0100
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: neil.armstrong@linaro.org, clabbe@baylibre.com,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, khilman@baylibre.com, jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com, vadim.fedorenko@linux.dev,
	linux-crypto@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@salutedevices.com
Subject: Re: [PATCH v4 00/20] Support more Amlogic SoC families in crypto
 driver
Message-ID: <ZcsYaPIUrBSg8iXu@Red>
References: <20240212135108.549755-1-avromanov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240212135108.549755-1-avromanov@salutedevices.com>

Le Mon, Feb 12, 2024 at 04:50:48PM +0300, Alexey Romanov a écrit :
> Hello!
> 
> This patchset expand the funcionality of the Amlogic
> crypto driver by adding support for more SoC families:
> AXG, G12A, G12B, SM1, A1, S4.
> 
> Also specify and enable crypto node in device tree
> for reference Amlogic devices.
> 
> Tested on AXG, G12A/B, SM1, A1 and S4 devices via
> custom tests [1] and tcrypt module.
> 
> ---
> 

I started to test on Lepotato board and added patchs up to  "drivers: crypto: meson: process more than MAXDESCS descriptors"
booting lead to:
[   18.559922] gxl-crypto c883e000.crypto: will run requests pump with realtime priority
[   18.562492] gxl-crypto c883e000.crypto: will run requests pump with realtime priority
[   18.570328] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000028
[   18.581135] Mem abort info:
[   18.581354]   ESR = 0x0000000096000006
[   18.585138]   EC = 0x25: DABT (current EL), IL = 32 bits
[   18.593005]   SET = 0, FnV = 0
[   18.593334]   EA = 0, S1PTW = 0
[   18.597329]   FSC = 0x06: level 2 translation fault
[   18.604250] Data abort info:
[   18.604282]   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
[   18.612243]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[   18.614552]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[   18.624249] user pgtable: 4k pages, 48-bit VAs, pgdp=000000007b8ab000
[   18.626196] [0000000000000028] pgd=080000007b8ac003, p4d=080000007b8ac003, pud=080000007b8ad003, pmd=0000000000000000
[   18.640426] Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
[   18.642929] Modules linked in: of_mdio fixed_phy fwnode_mdio sm4_ce(-) sm4 meson_rng meson_canvas libphy rng_core meson_gxbb_wdt watchdog amlogic_gxl_crypto(+) ghash_generic gcm xctr xts cts essiv authenc cmac xcbc ccm
[   18.662164] CPU: 3 PID: 264 Comm: cryptomgr_test Not tainted 6.8.0-rc1-00052-gf70f2b0814a0 #11
[   18.670698] Hardware name: Libre Computer AML-S905X-CC (DT)
[   18.676220] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   18.683118] pc : meson_get_engine_number+0x2c/0x50 [amlogic_gxl_crypto]
[   18.689674] lr : meson_skencrypt+0x38/0x8c [amlogic_gxl_crypto]
[   18.695539] sp : ffff800081393790
[   18.698816] x29: ffff800081393790 x28: 0000000000000400 x27: ffff800080874a80
[   18.705888] x26: ffff800081393830 x25: ffff800081393bd8 x24: ffff000001aaa000
[   18.712961] x23: 0000000000000001 x22: 0000000000000000 x21: ffff0000011b1c50
[   18.720033] x20: ffff00007bac8248 x19: ffff0000011b1c00 x18: ffffffffffffffff
[   18.727105] x17: 00000000000001a4 x16: ffff800078edc1f0 x15: ffff8000813938e0
[   18.734178] x14: ffff800101393bd7 x13: 0000000000000000 x12: 0000000000000000
[   18.741250] x11: 000000000000021c x10: fffffffff81213e0 x9 : 00000000000730d5
[   18.748323] x8 : ffff0000011b1ca8 x7 : fefefefefefefefe x6 : fffffc000007a302
[   18.755395] x5 : ffff800078eb4148 x4 : 0000000000000000 x3 : 0000000000000028
[   18.762468] x2 : ffff000001aaa040 x1 : 0000000000000000 x0 : 0000000000000000
[   18.769541] Call trace:
[   18.771956]  meson_get_engine_number+0x2c/0x50 [amlogic_gxl_crypto]
[   18.778167]  crypto_skcipher_encrypt+0xe0/0x124
[   18.782651]  test_skcipher_vec_cfg+0x2a8/0x6b0
[   18.787050]  test_skcipher_vec+0x80/0x1c4
[   18.791017]  alg_test_skcipher+0xbc/0x1fc
[   18.794985]  alg_test+0x140/0x628
[   18.798262]  cryptomgr_test+0x24/0x44
[   18.801885]  kthread+0x110/0x114
[   18.805076]  ret_from_fork+0x10/0x20
[   18.808617] Code: 1b008440 d65f03c0 9100a003 f9800071 (885f7c61) 
[   18.814651] ---[ end trace 0000000000000000 ]---
[   18.862270] meson8b-dwmac c9410000.ethernet: IRQ eth_wake_irq not found
[   18.863897] meson8b-dwmac c9410000.ethernet: IRQ eth_lpi not found
[   18.870349] meson8b-dwmac c9410000.ethernet: PTP uses main clock
[   18.880548] meson8b-dwmac c9410000.ethernet: User ID: 0x11, Synopsys ID: 0x37
[   18.882403] meson8b-dwmac c9410000.ethernet: 	DWMAC1000
[   18.887926] meson8b-dwmac c9410000.ethernet: DMA HW capability register supported
[   18.895215] meson8b-dwmac c9410000.ethernet: RX Checksum Offload Engine supported
[   18.902627] meson8b-dwmac c9410000.ethernet: COE Type 2
[   18.907756] meson8b-dwmac c9410000.ethernet: TX Checksum insertion supported
[   18.914750] meson8b-dwmac c9410000.ethernet: Wake-Up On Lan supported
[   18.921246] meson8b-dwmac c9410000.ethernet: Normal descriptors
[   18.927017] meson8b-dwmac c9410000.ethernet: Ring mode enabled
[   18.932782] meson8b-dwmac c9410000.ethernet: Enable RX Mitigation via HW Watchdog Timer

