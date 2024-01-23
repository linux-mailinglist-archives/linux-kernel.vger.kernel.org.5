Return-Path: <linux-kernel+bounces-36049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC9F839AB3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89CF51C2843F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DA8F500;
	Tue, 23 Jan 2024 20:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuBFvfO+"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A89FF512;
	Tue, 23 Jan 2024 20:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706043509; cv=none; b=FJbLb1oKWGaBKg/q/jBXr73OLJwM9Sr1KDxNJZPdxMGkPo9/Rc5UozqKc3FdS/Yo+/pQXYVUeaHUlIpf/VLsonq/et8WrYYbgHFqAzpIjLbmUswdos89i+domri3beGNjhFaRjXxI5py326yZ+IOOtJWb9K5hJIHhPWcPECauC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706043509; c=relaxed/simple;
	bh=S2q7c5fkB+kuMBms6LRjckdjZiaUkaGxP/jA/1mPeuA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O3t7HQNDTA3IqkKgVgffOKtF8ifBJcTM5jgv3XBggV8DX3a04JTkc6+2joU9jU01I7tL+zFamVcvYlC36Yjx4xN0wo4ARWqlPtavKKN62Oc/qU5mAqvYS48lEYHzac2S6+YMb5ImVroPqdg8drtOovJK0hljb594IEmb/gVdTCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SuBFvfO+; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e60e137aaso52628985e9.0;
        Tue, 23 Jan 2024 12:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706043506; x=1706648306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FhzpM+Hbm13JKFnsdWrzrb1CjPr2WwviT4McrcRZJUY=;
        b=SuBFvfO+bacXzcddB3f9zWg9+FX4vD0CezkD1kPvmbH5tUV2nnr9pP6TD5ETDRDexW
         KEALLOWRMRKmoNUpUlHUY3PDJpvWJVSyJSYIwO2u/TFsIqzcXOq/+USUBcYC+fW6nddf
         fBsgAoVOVQRAj6BsiXDNeghOTdZXtsghYjpVxIXuvAImhYMd2a2TaJ8CSWRS9OZPxAGJ
         YzmQxyJtsLFyWviN6wGkfJGEVJI74k18lqsDF4UXoPFWzWjXMaGdKFvfgrvA6qp+GQAX
         weOqh50UwugztDBy830AEaTRt2Si7/EqtTqsmiQN3BN//AKrfb3KxMHB/lWYBD1oR22b
         OCtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706043506; x=1706648306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FhzpM+Hbm13JKFnsdWrzrb1CjPr2WwviT4McrcRZJUY=;
        b=CxDqYxBRAvWBm19VWZZWO5uXYD6GYOI278WJ4H7CwL/o34pwx8A+I4KxdhszF0+yK5
         f6QY4zVAJ6V7XOORYMpcUhhMROyOkVc/D++RgDWFleRCEec+hhuD9Iz/WrAI3pmLWIQM
         +oeJwNBPm7YFgzdJDEF55Eiaitb9C+DQVEccJ6sdeoY7CixIsLrs38psbzHYiN2Q6Gxw
         F67G9Gv342aOnhdnyTZza0FdmUNBlu8/Fe00Lt/ZQD9ZbjNxKHRD4OD3erFW5xoLIKpz
         X3nuBJgL50dDsnb1QuQHxdXlwo7ctLa1YB2uq7BhualmwK/O2AM8tGLZt3sOuELlIith
         GDoQ==
X-Gm-Message-State: AOJu0YwzlP+0l4PEQTsa33w3uUVb25LNQj1u6SCPh+4fRw+U5oc9dDbF
	XBAECbFYGcs8Az/ned9cMlvKIla58w6eQx05jcwqTsaBVamaZH56
X-Google-Smtp-Source: AGHT+IEmm+4oKlJo6i0ZDCB9QPPWXNn4anv1JK1yKEQ1E23x77g6/ibRSfN0RsoKbTSXENvc7dFing==
X-Received: by 2002:a1c:7702:0:b0:40e:7677:c25b with SMTP id t2-20020a1c7702000000b0040e7677c25bmr916470wmi.126.1706043505859;
        Tue, 23 Jan 2024 12:58:25 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-14-70.dynamic.telemach.net. [86.58.14.70])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c020800b0040e89ade83fsm402726wmi.1.2024.01.23.12.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 12:58:25 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Wei Xu <xuwei5@hisilicon.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 =?utf-8?B?6bqm5YGl5bu6?= <maijianzhang@allwinnertech.com>
Subject: Re: [PATCH v2] ARM: dts: sun8i: Open FETA40i-C regulator aldo1
Date: Tue, 23 Jan 2024 21:58:24 +0100
Message-ID: <23373941.6Emhk5qWAg@jernej-laptop>
In-Reply-To: <ZYqRZev1g_mztff2@debian.cyg>
References: <ZYqRZev1g_mztff2@debian.cyg>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne torek, 26. december 2023 ob 09:40:05 CET je Fuyao Kashizuku napisal(a):
> The USB PHY in the Allwinner R40 SoC seems to rely on voltage on the
> VCC-TVIN/OUT supply pins for proper operation, on top of its own supply
> voltage on VCC-USB. Without a 3.3V voltage supplied to VCC-TV*, USB
> operation becomes unstable and can result in disconnects.
> 
> The Forlinx FETA40i-C SoM connects both the VCC-TVOUT and VCC-TVIN pins
> to the ALDO1 rail of the PMIC, so we need to enable that rail for USB
> operation. Since there is no supply property in the DT bindings for
> the USB core, we need to always enable the regulator.
> 
> This fixes unstable USB operation on boards using the Forlinx FETA40i-C
> module.
> 
> Signed-off-by: Fuyao Kashizuku <fuyao@sjterm.com>

Merged, thanks!

Best regards,
Jernej



