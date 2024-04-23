Return-Path: <linux-kernel+bounces-155097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 770DC8AE541
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A28441C20C6F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00C51386B2;
	Tue, 23 Apr 2024 11:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j/o6c8CF"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59B21384A4
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872846; cv=none; b=SE2n1usLnttIQquKdBVLQ1M0mbFeZ2XXB2p5EwTUCfu1vk8mEIvT2V72uH5yZmRy+v2YnPcEr+yHgBholMIeycqepdjIapfG3r8ioDDsMerLG8c16INfUdImbFLDL0Ybeb0uMCLXOCC7TUsPUA2SyQHDo9zqNPLGULJGF+aiCXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872846; c=relaxed/simple;
	bh=5zXXaSDHHLZNmipmrDXsZzK9DAc3oLYYNJml3DyaE0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=crRqr5jzE5x3StcWjLtF0csMHDE/X7eBddoaU4z130ZhDOBW+GUbEYIF07KLR9Sb/BTajb65+i9ulNWUVDjwfKfr+kxcQUCkmrDUy7NUJPvy2JlEWBAHyUySCd26Lj+qhMADPWaM2/lyVZEPrp+roEKiA2ot5NWu3d24DOEWmLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j/o6c8CF; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-ddda842c399so5474318276.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 04:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713872844; x=1714477644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zXXaSDHHLZNmipmrDXsZzK9DAc3oLYYNJml3DyaE0E=;
        b=j/o6c8CFdBdfEW96EocgV4qMtZFKTFwHpUtuNWSeCLd8tEasG/T4995qxlu801Wyu4
         S/HQM4cxJ257i+LXrh9gfHKFDPavaKecr/G7H0wYNVm23T4Yj/lwVdR8Xj+ZIn4epE7k
         iIU6sVyMXVxhsS4Xxs4MBhfPVRxUezI6yGXIs/K85ld8/vfPKq2NxfSMh571G/yzIsOK
         Zq1/HYW4Xtw95sGyf8rYjOeDSkNtjO0+2BPhRsAdLQBWzWWD9WrfaHkNXff2w2AXeZOW
         RfxV36FOrNYMAKIgZXjFs30cBazElOsVCI/DhbOrgsAasypQOuGTkcKo/xSJy+9dWulV
         o3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713872844; x=1714477644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zXXaSDHHLZNmipmrDXsZzK9DAc3oLYYNJml3DyaE0E=;
        b=Zjtk1ltnH8jkALnIgpKF9caoWjDv1iOib5S0Or8x3LAsx3T9gEWIak5rbszIK8T84S
         sbfVRoEabp5HXtPV36okQd37QJ8q+FfvhkfpedJAdFIohZ3CoTq6qcsRgFq7tL0kKhc3
         36t1W1Hab02EmTLQegae57OnefLvBj245MZl7LFxUxxTXkSbkrnjeLhHyfHFU1u64hBs
         DMhpUDuSqQOTxjnL3PphMf/ilEuEuPZ0dBbEaFyNccIfN25fbmacjOb56GdlIru9x4W6
         xHUse5u/Pg3qA7d4FZm2wwhKgbg7654/8HsNIsoMAtID3qM6Da1exuTNOipCdAtRf2ru
         9zFg==
X-Forwarded-Encrypted: i=1; AJvYcCW4mG3tS5CAPV16c5atpnvi8EiD89CDUy8mPLf2nf/PG/u2aOHSk0gf9Nb53/S+5AecLWs1RYfUhQKcssh4UMxxuXOCDbY1h6zYklc7
X-Gm-Message-State: AOJu0Yyryz/JjLrO1KFqfvOR40E5swli99GOsT7FSsn3X0WUA3YO8TX0
	s2vill72YwoVyG7RZyEUTk5g2twZTT9U4xEcSOyj+ouMNmEC7NbXcRAD+kRTSBLHpUXDRCuDvpB
	HWu0f5FZ535ghXgg+NV7DEyJIR8hEQJCcC9emPA==
X-Google-Smtp-Source: AGHT+IHntaLe6W6a9zZrdQp/NobtXyLalEiGhjsvJyg2CKkOy+q6UNrHqwWUkHv1SV9kpP87mRM7PtZ2WCmKIrFs8zs=
X-Received: by 2002:a25:5f42:0:b0:de5:51dd:87da with SMTP id
 h2-20020a255f42000000b00de551dd87damr1858523ybm.32.1713872843745; Tue, 23 Apr
 2024 04:47:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423-for-soc-asus-rt-ac3200-ac5300-v3-0-23d33cfafe7a@arinc9.com>
 <20240423-for-soc-asus-rt-ac3200-ac5300-v3-2-23d33cfafe7a@arinc9.com>
In-Reply-To: <20240423-for-soc-asus-rt-ac3200-ac5300-v3-2-23d33cfafe7a@arinc9.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 23 Apr 2024 13:47:12 +0200
Message-ID: <CACRpkdagwAD6KbCU0351rSUgqu6wimjREyfzGu06+aeSvM4fbA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] dt-bindings: arm: bcm: add bindings for ASUS RT-AC5300
To: arinc.unal@arinc9.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, 
	Hauke Mehrtens <hauke@hauke-m.de>, Rafal Milecki <zajec5@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Tom Brautaset <tbrautaset@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 11:51=E2=80=AFAM Ar=C4=B1n=C3=A7 =C3=9CNAL via B4 R=
elay
<devnull+arinc.unal.arinc9.com@kernel.org> wrote:

> From: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
>
> Add ASUS RT-AC5300 under BCM47094 based boards.
>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

