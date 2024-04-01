Return-Path: <linux-kernel+bounces-126438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33085893805
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 06:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C02C11F21418
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 04:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07A78F44;
	Mon,  1 Apr 2024 04:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZzieYSI"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45BA2595;
	Mon,  1 Apr 2024 04:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711946980; cv=none; b=ooStbDcPeo2E6cRrX7v9RMmBK0Vi+X9AgzFVL/h+eUDXgcALeNDZm11436bEKNEz7TVi4249DM/EcLlRSFZ/MazGqcYUa7qNvjleGg3zpL1xUIbg2HhKWxF4nTHCZJcaCRo+G40LjcpzlRlGcrd5pMRJblL6PXoCuaOtVlmyCyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711946980; c=relaxed/simple;
	bh=9P7DNDDewKZzJDm8kGzQZn2gBUwX7Mnh0jPmlVtXWrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:In-Reply-To:
	 From:Content-Type; b=nOfIFrOZl8yN2Br7vxaHD/aBhkmt/83rmYV5mRAn0Z7hDL/tx/p4eoTHg7NHskL0x6Ie/J1u9CsT7cqiapqn0/BhONnKKKOZxiCnvz5FU1XFJcAdHQTbROT/AOWrR3hhXJRiSWcLcQq4uQb4/lGahEEn5ueTcNT5oPV5VGAasuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZzieYSI; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-22215ccbafeso2320543fac.0;
        Sun, 31 Mar 2024 21:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711946978; x=1712551778; darn=vger.kernel.org;
        h=content-transfer-encoding:from:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9P7DNDDewKZzJDm8kGzQZn2gBUwX7Mnh0jPmlVtXWrY=;
        b=lZzieYSI6C+4Hzvcb/Q2C/UVrpNeTFhv0SIDpMZVnRqroKHCHhFQo4QN0QbUhH+y4O
         yrRoxvfUqXbgHRhq+Y3tGduFhY2i3g5htkchhy1I8Hqv09clr3jHVvZWmraEC8bmye8t
         s3bhaxMh7wimR7rbAJN4DaEc8yqVsveycxXEP2gM8wxMiFo4jKf5Im/RPKNX0XTXV3v2
         Ym056U3TZuTX+fL4WXxboE70hkBPoE6WLL2jzrtiHfu2VyoqHoaH/Vvg3M4Nd4ob9KqX
         0d2+7f3XmONTXSNiw5vNhxM7m6Sx7mfqxm5sJg56gCCK5PArVPqoOxQbY3kiACtfpBw4
         mR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711946978; x=1712551778;
        h=content-transfer-encoding:from:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9P7DNDDewKZzJDm8kGzQZn2gBUwX7Mnh0jPmlVtXWrY=;
        b=IVOOfpBmtIRSdgvQsIGyY9gKZi+thWUc+heV6uG4P3EteyfTZH35DfpgSuI2QEhae6
         FmY0OEeAM9d1HT9F1IeZ4JBuJuCOCaVq/sd8QjvnjjBMfqU56BWYJ1vDohWaKryZoWgk
         QOIHmcy/fGgy/+3wUCdSTlb3W4bdyVUV9b/i1LWsJErjKgcr+WYi+6cNjIUpz3+VTbAo
         GmeICAp1lBXpJEAdD2KztvuQJcqpGhYmWO2BaigR8Xymehu7Fa1T9DxhExf9AG2LWj6D
         XmsNMBq5048dK3GIFo9+tjiU0envOgSABL2Ee1392rdVMN1L6HNu6l+3gNjN6xuIcyon
         Kzlg==
X-Forwarded-Encrypted: i=1; AJvYcCXRAurC8yQfwQux4ohy5cY22l/2z4dU4UNllIvTvvAPlbm1L46CmwRPoHvx8sM7ULlXvFVjael2zPOcRd7EvJWcPPSu5J0IqADvTdbUfHzOZf//tzByrMvcQRGHyDgZSi9Pdk5jkJhFxQ==
X-Gm-Message-State: AOJu0Yz1k/0OzWKks2NiMaoTvs9hqyi/q6KEf5WRuFE/ZgBbSltLv96U
	6FnTLBYPMq2SYe69GfA5w/CXUm6Z95V3K9GQJ+40WJBa9LvqCy3i
X-Google-Smtp-Source: AGHT+IGMYFyjD1S0J/UlMasZQdb+LzfB19BFL7nbiO9VGTxLKWZM7nDChE1SjMsf1YPBvo7tIhAIfQ==
X-Received: by 2002:a05:6870:3912:b0:229:819a:d2e6 with SMTP id b18-20020a056870391200b00229819ad2e6mr9837827oap.15.1711946977956;
        Sun, 31 Mar 2024 21:49:37 -0700 (PDT)
Received: from [10.5.5.43] ([103.139.191.219])
        by smtp.gmail.com with ESMTPSA id fj42-20020a056a003a2a00b006eae2d9298esm5613056pfb.194.2024.03.31.21.49.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Mar 2024 21:49:37 -0700 (PDT)
Message-ID: <d4b0aa10-c2d3-4beb-98de-23ab929a0764@gmail.com>
Date: Mon, 1 Apr 2024 10:19:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: dt-bindings: mt2701-wm8960: Convert to dtschema
Content-Language: en-US, ar-LB
To: lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240401043505.40972-1-agarwala.kartik@gmail.com>
In-Reply-To: <20240401043505.40972-1-agarwala.kartik@gmail.com>
From: Kartik Agarwala <agarwala.kartik@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/1/24 10:05 AM, Kartik Agarwala wrote:
> Convert mt2701-wm890 bindings from text to dtschema. This is used by MediaTek mt77623a/n SoC.

Apologies for the typo, it should be mt7623a/n instead of mt77623a/n.

Regards,
Kartik Agarwala

