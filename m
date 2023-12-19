Return-Path: <linux-kernel+bounces-5658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB00818DB4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FC21B219C8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297B6225D2;
	Tue, 19 Dec 2023 17:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EM2r0lHn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EE535896;
	Tue, 19 Dec 2023 17:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a2340c803c6so356346266b.0;
        Tue, 19 Dec 2023 09:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703006044; x=1703610844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9vtfVLly14ekhlTunGy1vRxwLpd8U5NIsSj2AVK3Vk=;
        b=EM2r0lHns+qVfCE/SnsFr51o7VCJHzTlBqDn7KOvQH3457NqbuwOtwcTNX/T6lsSZW
         W1WBvZbfd/TO8ecEoxfQpXDw3HMAqOAWCplTskcNRtoj2XiY5xocXSVpzC9ZEhctrybW
         PASKUAaGtLj5Ny9dbzrCam7dWejaah7AN1bYI8tnBb3vOZbTkx8gXK1gXUu8m2RnoZCE
         l15GFBcJIHAPtoxQiJTon/4SfJeWDzWgMdDxjOXrd4F+SXOojn6AQc38Pgf7Xgd//8C7
         MeI8+OXjhxGdWa8tvzOQHedqrtvMJDaFEKxEITS3j8v6Yoc1Bi+Lqr8yCCaq6eTh3rPY
         Hxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703006044; x=1703610844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9vtfVLly14ekhlTunGy1vRxwLpd8U5NIsSj2AVK3Vk=;
        b=sDa2XuX+U6Z2a0fN318rhkanrCny6t3uBpui9Cy7BuHoJP1mCB9ow14oE8WGvpWODY
         8yzyLkhjGbbiQ99SnWxHda0+RNeycVwOCdldTTUS4xcmjGuhTf4NeixYdObdN2fHYBjN
         gE5cL5Crd6E1qX9lDtO/6miK0JC0P4TfwhbdVXpdj/DT2z6nvAGn0f8zkOVCoLBnqkfh
         8UIrTRTmXGpSDFMtWowEBnqzAUcjmrme98N4v99X1j9/d/AmGvS1SeqsY3N/NF9rqBBP
         uZZ8hHPi4Y/SU/yOcOionWjnIpBM/CGa5FSF8LjDxdwE1hgV0FVOUKGtxXvkgvN3NrWR
         VJXA==
X-Gm-Message-State: AOJu0YzCfTIrYIe6RfS+x6+4NwZQodeiomYv2ftAzxKfX8UPjubVmhU3
	/Dn2QC5EaGFXJoKBM/EUpqE=
X-Google-Smtp-Source: AGHT+IG4srAKNtlRLgacln5AazC7R1jIUPMIg1CJHj5l9uMv+Lm+7DWv6+igpI5lY+xNGDiLnRvPEw==
X-Received: by 2002:a17:907:3d91:b0:9fe:57b3:bc08 with SMTP id he17-20020a1709073d9100b009fe57b3bc08mr11848783ejc.41.1703006044090;
        Tue, 19 Dec 2023 09:14:04 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id cx7-20020a170907168700b009fc576e26e6sm15541544ejd.80.2023.12.19.09.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:14:03 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Maksim Kiselev <bigunclemax@gmail.com>
Cc: Andre Przywara <andre.przywara@arm.com>,
 Maxim Kiselev <bigunclemax@gmail.com>,
 Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 John Watts <contact@jookia.org>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
Subject:
 Re: [PATCH v6 2/3] thermal: sun8i: Add D1/T113s THS controller support
Date: Tue, 19 Dec 2023 18:14:01 +0100
Message-ID: <1950771.PYKUYFuaPT@jernej-laptop>
In-Reply-To: <20231217210629.131486-3-bigunclemax@gmail.com>
References:
 <20231217210629.131486-1-bigunclemax@gmail.com>
 <20231217210629.131486-3-bigunclemax@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne nedelja, 17. december 2023 ob 22:06:23 CET je Maksim Kiselev napisal(a):
> From: Maxim Kiselev <bigunclemax@gmail.com>
> 
> This patch adds a thermal sensor controller support for the D1/T113s,
> which is similar to the one on H6, but with only one sensor and
> different scale and offset values.
> 
> Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



