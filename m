Return-Path: <linux-kernel+bounces-75730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3173B85EE1A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 636061C20DF6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CF711712;
	Thu, 22 Feb 2024 00:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcxI/ODS"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A9810A21;
	Thu, 22 Feb 2024 00:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708562124; cv=none; b=ketCCi3gU0f9SRsoQNPetzhDNvvVy4jBWqxrgE+k4lJS1l9ygTwQR4rW/cM1MdYqIxfpNu4z1FeLPJjgMX/PPaBuIzFJkYG6L3p4dGPsmvGV2vI7odTj8yqVe1O2N4RLDtOOKnlOmIjjJeg2ZqLL9xwVOe6rvsfKje/Hy9VDLMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708562124; c=relaxed/simple;
	bh=bRUQR2AfYbIVDREDggIi0tV70eU6Jl0WcIi4w7uD0r8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iFYqR0Ep1YkRbS5KE74ed1/rfWO/SvdHI9Zz3sT5ATIacDQYiJ7VK6jDwccjcNwVAZiCOQTpnyAfDsZwmzrn3LZL76ij54ApS5n3m+SMDw2RDKvFwVht1ooKo9KEdyd7rH2dXkJT9SUDe/qKqQRIIgfcIMnvvLW/qz2w+13cimo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcxI/ODS; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-785d954b236so77042585a.0;
        Wed, 21 Feb 2024 16:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708562122; x=1709166922; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uQcSzwYTlfpfWbC6MSH72/ZoCsP8jeNoOiicayAEZtY=;
        b=bcxI/ODS6FD4ZSpGVtEWPYLIRGkIIlvVx7dK0VoT+V2f3ydog0FexY63uCP0Q/7aZ6
         P1KyBrgG2IOamGilwFwEtrhdbUvxmXSi2UAl+cR1v7neEIFd310b4S0KUpT2IkRsz11c
         53nTiiptgGrByHlcGw9PZiGa34HaOLPaJRNAmjUOaLRuUjBj0Ev6IrhWRqCy5hg88EJF
         RwEDG7lFH3L5GZolEMAd4m2gKEsK4NkBpsw5iji1oJcLX+QwoJR/B97FfCBlNeKjSVPX
         04RKPLbibOVeFVqvRCQ717XzCATblO/K1Ad2K8mNBm8AffvYb4KqCEqeujzwBffjzq4V
         bIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708562122; x=1709166922;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uQcSzwYTlfpfWbC6MSH72/ZoCsP8jeNoOiicayAEZtY=;
        b=XAZdtQWDeZlC3wXUn+8CeJgdl0BCQ/3ShDvOYxfvMvbZfDKfdGFX+tkKGJmAjJyiOu
         zKGhLCC7yI16LI6SfYv9OP31rQ49hmv4WLZEbvIVmZNbgLXRwu6XsiUrzwe+lQAsb/CR
         Cuk2T7o0VucoHszwCeCFJv28q6zkvRUicPSopDLqGSIUGQIYArm12A8nrcyEVs7FJTMn
         JnqsPgUxEaVwg1onKObt4ThqB212CeoDcrqBW8kbY6LLrGpzQaOhLv3KU3xNeI4PkiR3
         VxSNHKhmFbw+2voeUgsF+/FS+2R+UC1sMxQHvIcAIvXJ5dviw7jFV1fpoIr+ofywDaFZ
         JChQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOJkarToMC5Ro7lLzIaU8W0sxKAOofCVSr7+sVmjP3pPIeaZXoHn/f7lWKmNZ+mW0J4GBwSdrgt8drWjfyAD+RLU1kQ9I8SWOpf3SWC+KO0hG6i2imnRdFl/Ys7KOoVYh4yfYtWPqcLg==
X-Gm-Message-State: AOJu0YywGTPIxmObJgs64AluIa0Xzh7f83DxsZW3Bkl/VvX+2BzSZlRB
	Ofzda6bOcQ/QuQJ9gffSLT7SHdiOiCwZvZUnPX2zFyfI1x7TOeWr
X-Google-Smtp-Source: AGHT+IGLYs/AqW3ANawAK7DT3YYIZr8BCGmTNtcMollWrLax0a8fj192lb91A98q6G/j28j+aPI7Ww==
X-Received: by 2002:a05:620a:b52:b0:787:3820:8d9 with SMTP id x18-20020a05620a0b5200b00787382008d9mr20353756qkg.0.1708562121729;
        Wed, 21 Feb 2024 16:35:21 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id w5-20020a05620a148500b0078723db4da9sm4804921qkj.98.2024.02.21.16.35.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 16:35:21 -0800 (PST)
Message-ID: <7be28a94-f0f4-4098-aaa3-be3194fc14b0@gmail.com>
Date: Wed, 21 Feb 2024 16:35:17 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/12] dt-bindings: mtd: brcmnand: Add WP pin
 connection property
Content-Language: en-US
To: William Zhang <william.zhang@broadcom.com>,
 Linux MTD List <linux-mtd@lists.infradead.org>,
 Linux ARM List <linux-arm-kernel@lists.infradead.org>,
 Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc: kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
 anand.gore@broadcom.com, dregan@mail.com, kamal.dasu@broadcom.com,
 tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com,
 devicetree@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>,
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Kamal Dasu <kdasu.kdev@gmail.com>,
 Rob Herring <robh+dt@kernel.org>
References: <20240207202257.271784-1-william.zhang@broadcom.com>
 <20240207202257.271784-3-william.zhang@broadcom.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240207202257.271784-3-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/7/24 12:22, William Zhang wrote:
> Add brcm,wp-not-connected property to have an option for disabling this
> feature on broadband board design that does not connect WP pin.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


