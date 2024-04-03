Return-Path: <linux-kernel+bounces-129232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 276EF896767
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF2BD1F28CCD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975B35FB85;
	Wed,  3 Apr 2024 07:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0A9Xjnp"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BF45CDE1;
	Wed,  3 Apr 2024 07:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131169; cv=none; b=XLr6HFrKbP7GILBQJKxsaCQcCqvAIRIR4oBPqjy6CknlCt0twNk/CGev0wDok+wzlsoD+5yJpraumQFveZS7fcJSEBwAkKLSWqROf28YitpiXbaC5a41q6fyD1fBUDBIOno+5wKmJDzkTCHDm8MQFqDYuuiYqIAEPzsBmXotXbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131169; c=relaxed/simple;
	bh=Mqs11XDvSzMb00a/L3tUp4N7WbZfs5QSZUdg9Qd2nR8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UVfxYMPW7kunu1SsFZd206xeOlNjKeFrPn1ItTuvGOaUKNYNFg3XPg65aqj8qr++FsVCVd8Vxx1SZmFmeBpJfAkNB7WbzL3ZH1YPbY7HPhPw1CoeHWr9fqypHXaYjYmE/OTkGDOrKuA0rGYdKyirDrtPNmAqpMaSnqqNyhSaV9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0A9Xjnp; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6eaf1005fcaso2785252b3a.3;
        Wed, 03 Apr 2024 00:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712131168; x=1712735968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeXMBV/DDbXYMSIOdbEvhHUID1HnBQQHNSOBZwWjgL8=;
        b=W0A9XjnpkWTvAu6e1BHmGnhcrEGJ8DFzZAfKxfNqOJgwMz22khas7wOAc00VedLDBT
         olzGiiG9/ahJd/Ax+XQbevIuiZ1/UNHxaflU9087Mp2mCCOhQnacbUy3EKtw2CbT4MCh
         proHuqMeTy14Q0oSV1k10B3Qu4XwuNQKYbTE7wpWigIEYMDhQ4AWl6MbQIzFTcaj09+S
         KqZow6WCRbZ1NVUif8KYWcOKUTNFmGwj0/HfSuWOBpv813RcyoqYTr/H1peTuX7PUsfY
         e5Fz40udEBpDMmLonXgmR0t+bnJxr1L6FT3FJlruElkIEVWfCJC2hxbzpW3oDIp5ogje
         9oFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131168; x=1712735968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YeXMBV/DDbXYMSIOdbEvhHUID1HnBQQHNSOBZwWjgL8=;
        b=v6NaTKWlO2RBiU66x2BdfNK9Sh51tggFqaVxp6GdTa74MZ8KR7JjB5OW3OsH8zn6rt
         Ch34hrhtjJsG/EfJKy/VyhXaGvcctW5OWh0iQU/s5ArzjBuKQz3QLszlsLYDCAalWRsY
         TciPxsSaBjyRGM9JMRRpZ8oaV1KBp6eqBudBJasMaMSsP82Xk2b4jC/oKWeE3zIZbBxJ
         gguxK6/yZquGqhjwlRqe9xiiyoaLtCyF+h9f0p3lrn2qNg8tEmmy2yxN6mXwVRIYAXrN
         4UdXoh7H/X09rxPpu+E+GlcaBkI10pHJJBVr855mIPM4Llw5Bd19Ta7vCON04cfE8vR7
         sqtw==
X-Forwarded-Encrypted: i=1; AJvYcCXZkjZadZMRiFeVN9PwVfMHT1gQcQUpZAMAMEocvFcb1aTXIRLJqUMFhFQEcgIOc0SJ2uw5Xh3LauqPsgSODXR+3RxnKjSzC5c1S+k1iw6KQS8UsQdoc2kt2PZ5ieOFC5OA4wrxkx/IjQ==
X-Gm-Message-State: AOJu0YzZA5b28oa1nvMfmhvFMH/SnxS6yNkQwvSEo8ctA6OVSGmZQfb/
	4hVedRVa0zZR4wV+bAcCHA3YrPJJgkWm6w1FQNVdFOOqUFXeG6wQao9ToVyGY0zUOg==
X-Google-Smtp-Source: AGHT+IGy1/ipZnnxBslaBMOtfbRbw5ZxCaIZRbUfDoiUz9M2U3w3UDxRiZx7620AoOukewYjyFNLmA==
X-Received: by 2002:a05:6a00:ccb:b0:6eb:3ffa:8131 with SMTP id b11-20020a056a000ccb00b006eb3ffa8131mr9378678pfv.12.1712131167725;
        Wed, 03 Apr 2024 00:59:27 -0700 (PDT)
Received: from localhost.localdomain ([221.220.133.103])
        by smtp.gmail.com with ESMTPSA id fk15-20020a056a003a8f00b006e6c74eac34sm11108652pfb.151.2024.04.03.00.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 00:59:27 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: heiko@sntech.de
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	liujianfeng1994@gmail.com,
	robh@kernel.org,
	sfr@canb.auug.org.au
Subject: Re: Re: [PATCH] arm64: dts: rockchip: remove startup-delay-us from vcc3v3_pcie2x1l0 on rock-5b
Date: Wed,  3 Apr 2024 15:59:16 +0800
Message-Id: <20240403075916.1025550-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2535182.Sgy9Pd6rRy@diego>
References: <2535182.Sgy9Pd6rRy@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Heiko,

Tue, 02 Apr 2024 12:39:17 +0200, Heiko Stübner wrote:
>Does the pcie driver enable the regulator too late somehow?
The pcie driver will enable the regulator imediately when it is probed.
I added log at when driver is probed and when regulator is enabled.
Here is the log with "startup-delay-us = <50000>":
```
[    1.572991] rockchip-dw-pcie a40800000.pcie: rockchip_pcie_probe start
[    1.573697] rockchip-dw-pcie a40800000.pcie: going to enable vpcie3v3 regulator
[    1.575194] rockchip-dw-pcie a40800000.pcie: enable vpcie3v3 regulator done
```

And here is the log without "startup-delay-us":
```
[    1.518490] rockchip-dw-pcie a40800000.pcie: rockchip_pcie_probe start
[    1.518603] rockchip-dw-pcie a40800000.pcie: going to enable vpcie3v3 regulator
[    1.518610] rockchip-dw-pcie a40800000.pcie: enable vpcie3v3 regulator done
```

We can see startup-delay-us will delay the driver probe.

I also take a look at rockchip's SDK kernel, their pci driver is probed
very late:
```
[    3.398682] dw-pcie fe170000.pcie: invalid resource
[    3.398686] dw-pcie fe170000.pcie: Failed to initialize host
[    3.398688] dw-pcie: probe of fe170000.pcie failed with error -22
[    3.399396] rk-pcie fe170000.pcie: invalid prsnt-gpios property in node
[    3.399410] rk-pcie fe170000.pcie: Looking up vpcie3v3-supply from device tree
[    3.405195] rk-pcie fe170000.pcie: host bridge /pcie@fe170000 ranges:
[    3.405253] rk-pcie fe170000.pcie:       IO 0x00f2100000..0x00f21fffff -> 0x00f2100000
[    3.405283] rk-pcie fe170000.pcie:      MEM 0x00f2200000..0x00f2ffffff -> 0x00f2200000
[    3.405310] rk-pcie fe170000.pcie:      MEM 0x0980000000..0x09bfffffff -> 0x0980000000
[    3.405372] rk-pcie fe170000.pcie: iATU unroll: enabled
[    3.405381] rk-pcie fe170000.pcie: iATU regions: 8 ob, 8 ib, align 64K, limit 8G
[    3.666917] rk-pcie fe170000.pcie: PCIe Link up, LTSSM is 0x30011
[    3.666932] rk-pcie fe170000.pcie: PCIe Gen.1 x1 link up
[    3.667139] rk-pcie fe170000.pcie: PCI host bridge to bus 0002:20
```

And it is reported that startup-delay-us is necessary in rockchip's SDK
kernel. But in mainline kernel it is different.

Jianfeng

