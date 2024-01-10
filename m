Return-Path: <linux-kernel+bounces-22817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B91F82A34F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0993D287E3E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE404F5FB;
	Wed, 10 Jan 2024 21:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P13+70tD"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114D34F881;
	Wed, 10 Jan 2024 21:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-46788b25f95so1082931137.0;
        Wed, 10 Jan 2024 13:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704922389; x=1705527189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6v5CI9Rd44b7UOY4K7sfex6hxeFhVRcBTEwwVc9S/k=;
        b=P13+70tDRoqfn6d1xpTIx6Fr69Hmy7Yy4k5cQlWFzneSvMbPrptUhXaLQlhMPlEnw8
         V/YhQnIVgdPow8fkRR38ggN5c9eGO52jmA8lqQNclf718JYWYIpav0VmCLxIkMemJxbl
         QrvUNCU4d/MwjmBycaIj3uqrnPo7Y7Jt21Tm6IvLmi2dVFlEM55tERhHVlakaDno/Juq
         dAnqSCdtdt49c4Mkwa8rVNKvIW/VbmvDJ2uyAplm+cy779mzwfTa03WtXHYPMFUN3Zw3
         jOrXVWXTM1teavU+pmjZHk6/M5imXB0tVo41TvSn/e6AqhfyyC7udzJ0ewZm2xREpe28
         GXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704922389; x=1705527189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6v5CI9Rd44b7UOY4K7sfex6hxeFhVRcBTEwwVc9S/k=;
        b=NVcL+ZQFWxotWSeX4Qf+Y4qD9LnfxF0tvy9fSLFR3vj31KYxyYnGkBKHTvym5p9Cf3
         e/yO3t7n0dY37eBFpglNNzofOJ8GtiufJlo1WFHVbJCXx2ROICf3NJT0eaE6XIEOFsyZ
         bYjfIfWkClsrHEHwtAFWtAlOVj0zlNoqDm+rNDpC7wDh1IaT+Mohr7EHGzusYAKNikW+
         cZpbjwX8nT5jF1zLvbjNUYVgJuWgTCEGOvQTGHRDEnER/m6Z7Iw2aZhxVWcersl75n2w
         E53VK2RqW15GlXq4bpEDfAmubiYMJMxpkG8Km4VDdp2dqJmzlLwCrHkUiVFdPdkyt637
         /XWA==
X-Gm-Message-State: AOJu0Yy0yLjCxypnnY0nWlb+iq41cBXIbptx/t0V5jfoC37JO6xrp3OQ
	piqwIaiGqMWX6wZAybse6iuvCJ8mC7GdsJVMjFc=
X-Google-Smtp-Source: AGHT+IGuu/ugNHXGHzU9RbZdCb2DhxvyajPX/SjB5pTt5H6IQbtyutWMSsB5qTFq1e+9kKzFTrHGUbPAiWbibjdDW40=
X-Received: by 2002:a67:c085:0:b0:467:f6c3:14c5 with SMTP id
 x5-20020a67c085000000b00467f6c314c5mr149205vsi.16.1704922388712; Wed, 10 Jan
 2024 13:33:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110140903.4090946-1-nm@ti.com> <20240110140903.4090946-14-nm@ti.com>
In-Reply-To: <20240110140903.4090946-14-nm@ti.com>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Wed, 10 Jan 2024 15:32:42 -0600
Message-ID: <CAOCHtYgFtBXdY7_PpsBi4ep0VqHOEXbqBu5+O8rB4qkChPx15w@mail.gmail.com>
Subject: Re: [PATCH 13/16] arm64: dts: ti: beagle*: Add MIT license along with GPL-2.0
To: Nishanth Menon <nm@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Ayush Singh <ayushdevel1325@gmail.com>, 
	Jason Kridner <jkridner@beagleboard.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Tony Lindgren <tony@atomide.com>, 
	Wadim Egorov <w.egorov@phytec.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 8:09=E2=80=AFAM Nishanth Menon <nm@ti.com> wrote:
>
> Modify license to include dual licensing as GPL-2.0-only OR MIT
> license for device trees belonging to BeagleBoard.org Foundation
> platforms. This allows for Linux kernel device tree to be used in
> other Operating System ecosystems such as Zephyr or FreeBSD.
>
> While at this, update the GPL-2.0 to be GPL-2.0-only to be in sync
> with latest SPDX conventions (GPL-2.0 is deprecated).
>
> While at this, update the copyright year to sync with current year
> to indicate license change.
>
> Cc: Ayush Singh <ayushdevel1325@gmail.com>
> Cc: Jason Kridner <jkridner@beagleboard.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Robert Nelson <robertcnelson@gmail.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Wadim Egorov <w.egorov@phytec.de>
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  .../boot/dts/ti/k3-am625-beagleplay-csi2-ov5640.dtso      | 4 ++--
>  .../boot/dts/ti/k3-am625-beagleplay-csi2-tevi-ov5640.dtso | 4 ++--
>  arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts            | 6 +++---
>  arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts        | 8 ++++----
>  4 files changed, 11 insertions(+), 11 deletions(-)
>

Acked-by: Robert Nelson <robertcnelson@gmail.com>

Regards,

--=20
Robert Nelson
https://rcn-ee.com/

