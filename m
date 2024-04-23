Return-Path: <linux-kernel+bounces-154547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBAC8ADD77
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55302B22F2A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 06:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F6F22F03;
	Tue, 23 Apr 2024 06:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDJ3xSvk"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26B018AED;
	Tue, 23 Apr 2024 06:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713853499; cv=none; b=ZdF6wC4MrfEOZmknSLFU+cnicSGgVS4vXDgGH402ZPy9f9IYhwLhibk4HE2oA/eWAcIwLtc52++ngTH+aNqa9gk1q01Pp+mp8fQ0YHDss/UlV3RTWVhuygYhVLR3jJxnOC5TkkCVwHJOmCbt2aJWxJJCFBQ4XsUi+cQokj6f9pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713853499; c=relaxed/simple;
	bh=W2TMVZWUJbNFRxa8LN8et0fl4uaQ1TuJZNhbHUPmzA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PKAproC7LtEA8H7SO5My+4sZtS8HMSbCxzsgORCXQlxG7e8THnS9wY8rS3FY0OZ7NQooI5B/DaKCYtL7NLueLmvdrsHxMmmS0r5TppWXyqEDbDG9JwhA4PCXvNqow4D4Kx41scuML5ytLyhmTLSawQt3C/A7Nj524Btr5fLQB5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDJ3xSvk; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a559b919303so305532566b.1;
        Mon, 22 Apr 2024 23:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713853496; x=1714458296; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=obB4jlV59abA/wNMxE4U5cZlxStQlUiG01gvsp/PbYA=;
        b=bDJ3xSvkdZX+HnH1/KNz8Zb+jObUP+48X+fHJWpYeNJg2wta3hdKgKV6P5mie9o5yZ
         xy/zMsMDXYmfiBkaLYJrALY5/fUzlCOd14nCOBiavTjOgIxFuv5Zc1jvjBjdBlN/fAbT
         GreRFvqeVaNPJEE9bGS6KrNATr6V5HRWdEK7x08j7ITRQd1qN60pKlawc95FFxpFsBj1
         j25FNI5a/0GC4gu1llmkDU3rMLg+ueAk9hEVHflgRj//CIFJy+y8Y8O+QCoFkZixBzmq
         JHBqWH+567bT/+VtbEJfeoNKyUenOr0kOvPg9N877IZhKDDk7Wvngnqq2dTGpyKXiKX5
         0Nrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713853496; x=1714458296;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=obB4jlV59abA/wNMxE4U5cZlxStQlUiG01gvsp/PbYA=;
        b=Aa0pc0JQonqdxktV3YODbaQ16wbcbV1arfUhewd0GFYEzYp0DmgBrNxZHcdZzoRKFo
         MxuiDDRiKcAeEluhcMnY6nG5iMfcWYsYVyJDkypscvEq6OP8kOc9ml3DItfdNWCwwFiR
         bF8PC/s0wu410xijkLSJfX9wH81Q00CeIdeROLzzD5wjRKNkrAR39nrvaVJxeJyiqxiu
         GrcSuEtL9/FEpZYRh1O9M+mXziBjtxz5F9mpduBTkJ5vgVIZJ1ezLqCHLp5MP8GCNc+A
         lB5G7xZc33zmkzlRj2i/cgbQMIIlHtVywbG4pGXEas32EVLflbbKrANsAnnKId8VjOm+
         lY+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVaxs54NI77yK7RIFudWOW+5mbnNm+8IiVJ0ZKgiGq6ieEIj0Qx63UiLiYh891nLzMvdiE1B+tF9oBLbnMvoVa6w5STZUeRNpQDVS28IT/kEa8x+SszBomcfHw0sgBw1GZ57FR1R/mCXw==
X-Gm-Message-State: AOJu0YwZY8S33zcxCTcMTC/sh65JruBELY5YiLj4LF4h1lgnQI7LUcYl
	0fOUXn26nT8hMQ+FcBiVIOn0nDBdcieEijr1ggFwo+T06ciHiSd+
X-Google-Smtp-Source: AGHT+IHQ2kyt1szdhcEQk2QGUGAR/bJi4xRuNd8GavAbfvnOchMdo8396OvvSqo6YbIOygKYR18d9g==
X-Received: by 2002:a17:906:395b:b0:a52:3ff7:744d with SMTP id g27-20020a170906395b00b00a523ff7744dmr8520159eje.4.1713853495933;
        Mon, 22 Apr 2024 23:24:55 -0700 (PDT)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id 17-20020a170906329100b00a4ea067f6f8sm6628072ejw.161.2024.04.22.23.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 23:24:55 -0700 (PDT)
Message-ID: <0395c3a1-1211-4962-bafd-fbf20be98ce4@gmail.com>
Date: Tue, 23 Apr 2024 08:24:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Document ASUS RT-AC3200 and ASUS RT-AC5300 and add
 device trees
To: arinc.unal@arinc9.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Hauke Mehrtens <hauke@hauke-m.de>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Tom Brautaset <tbrautaset@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Krzysztof Kozlowski <krzk@kernel.org>
References: <20240419-for-soc-asus-rt-ac3200-ac5300-v2-0-f95ff50c2a4d@arinc9.com>
Content-Language: en-US
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20240419-for-soc-asus-rt-ac3200-ac5300-v2-0-f95ff50c2a4d@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 19.04.2024 09:22, Arınç ÜNAL via B4 Relay wrote:
> This patch series documents the compatible strings for ASUS RT-AC3200 and
> ASUS RT-AC5300, and adds the device trees for them.

I was on holidays and couldn't reply earlier.

This patchset looks good to me, thanks for your work!

Bot warnings come from .dtsi so they are not directly caused by your changes.

Nitpicking:
Try to put "reg" before "device_type" in future.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst?h=v6.8#n112


> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
> Changes in v2:
> - Patch 3
>    - Remove the chosen node as earlycon is not for mainline use, and the
>      stdout-path property which should be used instead of bootargs =
>      "console=" is already described in bcm4708.dtsi with the same value.
>    - Remove MAC address assignment to switch ports. To explain why shortly,
>      on the switch with CPU port architecture, the LLC Entity associated
>      with each port can be accessed without a distinct MAC address assigned
>      to each port. Therefore, it is unnecessary.
> - Patch 4
>    - Same as above.
> - Link to v1: https://lore.kernel.org/r/20240414-for-soc-asus-rt-ac3200-ac5300-v1-0-118c90bae6e5@arinc9.com
> 
> ---
> Arınç ÜNAL (4):
>        dt-bindings: arm: bcm: add bindings for ASUS RT-AC3200
>        dt-bindings: arm: bcm: add bindings for ASUS RT-AC5300
>        ARM: dts: BCM5301X: Add DT for ASUS RT-AC3200
>        ARM: dts: BCM5301X: Add DT for ASUS RT-AC5300
> 
>   .../devicetree/bindings/arm/bcm/brcm,bcm4708.yaml  |   2 +
>   arch/arm/boot/dts/broadcom/Makefile                |   2 +
>   .../boot/dts/broadcom/bcm4709-asus-rt-ac3200.dts   | 150 ++++++++++++++++++++
>   .../boot/dts/broadcom/bcm47094-asus-rt-ac5300.dts  | 156 +++++++++++++++++++++
>   4 files changed, 310 insertions(+)
> ---
> base-commit: 011d79ef1cfad701c2d8e7e80d8c77523af9c771
> change-id: 20240408-for-soc-asus-rt-ac3200-ac5300-5d6efc2c497b
> 
> Best regards,


