Return-Path: <linux-kernel+bounces-23120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F10DD82A7F7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10C3D1C2272E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6465672;
	Thu, 11 Jan 2024 07:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pu9njGfv"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3FF6AA1;
	Thu, 11 Jan 2024 07:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6db0fdd2b8fso1473339b3a.2;
        Wed, 10 Jan 2024 23:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704956558; x=1705561358; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pxmM/JgsgR/85LH2742vTtx8OCVD3zviSBr+nobGNIs=;
        b=Pu9njGfvmxcDbQAtVnt0n2nVOTKU4zgSLW8zb6+5At/Umtmi+R64BRghn6WMWeNGwh
         EI3Op7YXQA+8RDzqISt8NTZZyrjwch3BoIB/h+pmMibZPNoelZLohf/XZGcUst+LLrUz
         lnS151lfpUx6c3BtP7mlWRPW04/pbTYPIg5d+FKn1mFwU9H+sF1putncI7zSdoVYL81U
         gPNWPP6WYfac5L0ixshuRkj6HAdrZ4y+KEVlKi2RoKjHC1sWIUHy0bKkXZs53DrxbHZN
         fl1XhKerPnUfoyk+Ykho2jGyhzL+iKBjypSPx6nzgT5qMI4Nopn9xs9ldXE72JnLXkwO
         vOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704956558; x=1705561358;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pxmM/JgsgR/85LH2742vTtx8OCVD3zviSBr+nobGNIs=;
        b=qOA9oKXb/yrIENoaHsoImFx0kp/x8EZ2+eEgBsy6bgagWFLX04IMoP0EiyJykQOpDR
         lrmXw1u6K3jrnWQ7XbPQfHVfewaZ+iUovp7XNYawEXzKnQrM0LRJwqso+DuQ1Yrixavz
         Ob6gZn4wtOExGMrhDa0GdLGSUrMThKgWvO0/HNRGzZT/Q6m9hbQ95/vs+e+VM5fBDuAJ
         7WjAXIIzJrCvazZyQAfRYcJZ1p6wtm874aF+/3mu+PZ9iKv3t06SkG8QtkYJdnSI0PWQ
         GzDbxYZawnYA4ncC6KwaubP4z2WtTw4GLhZd82QFbye+4EojpIJGRWGYYXfZjq16TSTb
         1q9w==
X-Gm-Message-State: AOJu0YwLg4ZXWWDtdw7qPYa8qKb+2xZ1DRpzrvXktvLtXxXJqOCRlbUU
	QQZnrOwiVEy8SriCkrt+Kng=
X-Google-Smtp-Source: AGHT+IErncag6/nGPjlsKvdjtHjsplQiV2fh+JIK3Tfm7UM9GAxbICo7idKXHfSL/m2SE5QrIbcm0A==
X-Received: by 2002:a05:6a00:6c97:b0:6d9:ad3a:29db with SMTP id jc23-20020a056a006c9700b006d9ad3a29dbmr845552pfb.28.1704956558089;
        Wed, 10 Jan 2024 23:02:38 -0800 (PST)
Received: from [172.16.116.58] ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id it7-20020a056a00458700b006d9a13b491csm428389pfb.212.2024.01.10.23.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 23:02:37 -0800 (PST)
Message-ID: <b32fe5d2-d53d-4663-9b24-02d86bd25b57@gmail.com>
Date: Thu, 11 Jan 2024 12:32:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/16] arm64: dts: ti: beagle*: Add MIT license along with
 GPL-2.0
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Jason Kridner <jkridner@beagleboard.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Robert Nelson <robertcnelson@gmail.com>, Tony Lindgren <tony@atomide.com>,
 Wadim Egorov <w.egorov@phytec.de>
References: <20240110140903.4090946-1-nm@ti.com>
 <20240110140903.4090946-14-nm@ti.com>
From: Ayush Singh <ayushdevel1325@gmail.com>
In-Reply-To: <20240110140903.4090946-14-nm@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/01/24 19:39, Nishanth Menon wrote:

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
>   .../boot/dts/ti/k3-am625-beagleplay-csi2-ov5640.dtso      | 4 ++--
>   .../boot/dts/ti/k3-am625-beagleplay-csi2-tevi-ov5640.dtso | 4 ++--
>   arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts            | 6 +++---
>   arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts        | 8 ++++----
>   4 files changed, 11 insertions(+), 11 deletions(-)

Acked-by: Ayush Singh <ayushdevel1325@gmail.com>


Ayush Singh


