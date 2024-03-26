Return-Path: <linux-kernel+bounces-120037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F57088D0A1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0F8F1C2FF15
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF9A13DBA0;
	Tue, 26 Mar 2024 22:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPmkTVJQ"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F63173;
	Tue, 26 Mar 2024 22:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711491484; cv=none; b=SUJjNlnNlKg75/fLV6g7d3+wkZDOJ/gM3xSjXjE2ouQ0F8V16vdV5JYvjO3T2zN2TQtxvkUOFg3udiFPOgssVby3AHyioqTRTBlxQppy9ysJGf4SDdXuIHu48lFfOpSpEZM8XQwU9bb9RlzRKq0Gsg3Lq3lrZsfkSt3HvBbQbPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711491484; c=relaxed/simple;
	bh=jZamp4MsOv0a0vk5eb1zcKU8x6xTFCXsYRJynilmCSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=endvNY1QFQC+nyTFuUqnMupHMtOIOEY3uSby7OnN6yWjrJ6aNfMpaMq5uANFLP9JudG5FfOAtAHEx/vLD11pbkZCa/H9l81+ZGRJoOmcuHyy7rOcpWOm7bbGqcn9lZgUbfXJ5H6m1PLR4VsY9aGJyDgqwbCcOHRlj+lzp2dTONY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LPmkTVJQ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a4a39ab1a10so354887866b.1;
        Tue, 26 Mar 2024 15:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711491481; x=1712096281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yzPU6QXENTrmR1HpeV0OvIjJ9OWKrJqQwOwJWoxqWwE=;
        b=LPmkTVJQaSjE8SE7HPSBGSN0ZB14yjsuFkDzEl/4t5pIyK22rR961UAklDoLrfk1zn
         4FtSvhkL2fhEikM8tNJPH5qa8T1WFPnBQCd3CAshHLrKQNCkkGftDOmCSaUqk+VwAYfe
         MBBE70veLDn0mNhoq+wpTSqT2ueBL4SWTKc9fNA7Iq2soleigBF/hC0ki4STqXz38U+E
         N1KwllVxO1GsbglsQ9paJMFYSvz/YCBIROez+4gNZpzQRpOPT6cYlXdZ+Vcf8HaOO8kl
         hVtJonrx64zbOm3mi7Qrcs8YKO/OEbMjU1FSQrNHMFgf0U2ZsnFJbgIGz5NkUCGnxBfW
         iqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711491481; x=1712096281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yzPU6QXENTrmR1HpeV0OvIjJ9OWKrJqQwOwJWoxqWwE=;
        b=Kb/GGRhUE4JOe3U3rYlyvgMu4i+SYBLQ2miHRTDuE0NBpFn4tyOlNW5qbIhD+H/ZPL
         ummQbFWeuRz7gaBJlS9QFP5wNEa1+ZTw/V0E6zWYD13mb3zN3Js7niMEalRHAZZX4hx2
         2ZuogA/bptIjhMqOFL/nYT05CWL8ny/+mDDUA62RVo9FnuZHYCMzSiUtVcebl83bOr2W
         mcwh8r1wkgyNnccbaFDfBOSBaxrVYhj3UvQKlg2hhIIICRKsEX6+QiAeDwES36ZNr0qr
         5Rk70sn1dLMunt6v1AsqczCu6Y2VYuQ1IES6m01fzePHg+7boGZbq5pTzzGhdGTCiPlE
         Zq5w==
X-Forwarded-Encrypted: i=1; AJvYcCVZFg/3fAYwfY0HeH5JYIsVFcZLJW5QNhbgR7vdXo8EUktnwhziuNi1dzUSb1+Q+KD1kfXaixKrr8w3M/s/vn0EJJrVlJPbBTlf2X6uqGrMSw5JgKE+gtkMaVh5pckGqvPq4Y6u98kCcw==
X-Gm-Message-State: AOJu0YxG13ImIj8hdir3s0SrtNQPsvwtOuDWTQpAs7cpGEsxC0rUbDzk
	yye6jZ57HWUV/KfXTIOoSWhEs0hSbeevvuryRKJ0OT0bYA3S3sgWp/bgccZe
X-Google-Smtp-Source: AGHT+IHQFMA0QHnR8HNwKCAjD8+h5k/NmQkshAvwPkY848lMOrho3HwTvRtW0e4CHOIkhJUv0mft5w==
X-Received: by 2002:a17:907:77d8:b0:a46:65fd:969d with SMTP id kz24-20020a17090777d800b00a4665fd969dmr638521ejc.71.1711491481550;
        Tue, 26 Mar 2024 15:18:01 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id mc2-20020a170906eb4200b00a47152e6d10sm4663717ejb.134.2024.03.26.15.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 15:18:01 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Corentin Labbe <clabbe@baylibre.com>,
 Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 2/4] arm64: dts: allwinner: drop underscore in node names
Date: Tue, 26 Mar 2024 23:18:00 +0100
Message-ID: <5763839.DvuYhMxLoT@jernej-laptop>
In-Reply-To: <20240317184130.157695-2-krzysztof.kozlowski@linaro.org>
References:
 <20240317184130.157695-1-krzysztof.kozlowski@linaro.org>
 <20240317184130.157695-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dne nedelja, 17. marec 2024 ob 19:41:28 CET je Krzysztof Kozlowski napisal(a):
> Underscores should not be used in node names (dtc with W=2 warns about
> them), so replace them with hyphens.  Use also generic name for pwrseq
> node, because generic naming is favored by Devicetree spec.  All the
> clocks affected by this change use clock-output-names, so resulting
> clock name should not change.  Functional impact checked with comparing
> before/after DTBs with dtx_diff and fdtdump.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej




