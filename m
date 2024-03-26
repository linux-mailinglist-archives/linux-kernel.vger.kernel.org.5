Return-Path: <linux-kernel+bounces-120038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A356588D0A3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E3182E035B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA9B13DBA4;
	Tue, 26 Mar 2024 22:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5eU8Rbv"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0576413D8BA;
	Tue, 26 Mar 2024 22:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711491546; cv=none; b=WZITjVx2wRNDlGU9W+AAKmOSqZMi5EdhKlhJtGl5pIwq4JmDfeaBnUVzNwhVVBPcjgxaNXOV38qsRm6Y5QsUen6AUwQUSaa/xrzHHeiVA8fIy1ge/WBf8GL/DrjFUy9AkxL1AB0fbvnRKcxaVyPS7/RQe+HLeQP/ynbiiQ4+hRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711491546; c=relaxed/simple;
	bh=9zMGqulRLmq3vqj01LsBRA0A8CYYbMWKFHP8jPtDCik=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GAMmikcZFPlMOyeRL21/vlviV/HhYn3dRtf1AevCJFvlJiWHKT5mJJy+bJN8pZfNeUZmYXcU8o6oEAJm3DlMgpBzV6lWn4ilv5ThBrPa2OvNtUEo5Ps7YAHnHyY0AKxlc9Th6GqgWFnrQV89L4utLz1fNDYYJYLxZ4wapoX/+s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5eU8Rbv; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a474c4faf5eso362237366b.2;
        Tue, 26 Mar 2024 15:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711491543; x=1712096343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qyCLj1OUpWkQyfhuJXsbD10TSivodqh5GvYGLmhlJI4=;
        b=h5eU8RbvBvwu77UW2CQ/2UzBwKAnW1xeb361vCkhUv43GwtC4rNlLieFivqHaDP584
         CTGZvYA1AWG7ienEQ6UHEfxyzvxJ0T37iIviMv5ntwy3vTRQxuVlHVYKa0aN74tiaTMX
         HKFeNJAaTM5Iq47pJkH1JuQ3shGEIe3ANONDId5tSEnX0qBU30b0xaf7Zt4uf7RNZuve
         DVTkhGIYsW9sWUuUz5iiVOSy9T7rHT7OZBOPWOiigE6lIDYYavMiHWFgsgSD7geHo2PS
         tmVo2H5at8qaf/HwUEjSy4QkQP1FqmQRseZPEy2vlyhnn1sU+ZpjHi+dA9fRqZb6NZGu
         j8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711491543; x=1712096343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyCLj1OUpWkQyfhuJXsbD10TSivodqh5GvYGLmhlJI4=;
        b=JTCyLFh3G05KRe+Ahr+GHUxl/kTIYTXT0DpKTh/Sy/WDdI7/10VCr3DJZ1u/R6JPv2
         G8BOHc15DXw3LvHIPCF+urIJ3U5paXWe83RKAPW9DB9RxkYDmgBxGlqtt+kQgMua8pTp
         R9JrrJyEVfKo4WJ3+jgErNzKSTxcW4q8YWuUt22iO36dHvYah7l7PW2X4gn9ewUfk/V6
         4jKL1N7kzLwAJPR0EM5vpN3Vv7KNxL9ajiwPvPujyAM/NYO5G30dqIRRSWuDDaN/9erO
         +JqfYVq9WRyiaRniXi705RXYcWo8ShfE4EcvNsgW8ekzwDtdK0Ywb3ZG2CzJ3OdWzyEM
         8Qeg==
X-Forwarded-Encrypted: i=1; AJvYcCVW9OBjUqeMGZSAy5N1Mzp2Gvlt9WcNPmNWe68xfAmj7LKzdCmvsSldg/uJjpd2BUV5Ced2ZV29aowmXvDj43SkqS6Bq45vUc3CXKOHEaytgO3xcsMgxeS5zZYV+z1pnsQ7DC0tQJSdJw==
X-Gm-Message-State: AOJu0YydPLF0pGRdgEguLMvtZtxQKMYb+1re9n8rzsUBwrWVm+4OiSh4
	0wimOeHtxTyBYBq79Px5kamk4vK2HCNnI2Os/GMVBjSnKD4RfFNa
X-Google-Smtp-Source: AGHT+IGXf7T1vMLhzW/KEzN/Dqw4wUjeLLwxv4WedhqYn6D3+5Ku5/xi/MqHxQy4P57dEpI+PhWewQ==
X-Received: by 2002:a17:907:78c5:b0:a46:a7d8:3f7e with SMTP id kv5-20020a17090778c500b00a46a7d83f7emr6492795ejc.2.1711491543176;
        Tue, 26 Mar 2024 15:19:03 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id fw10-20020a170906c94a00b00a4dba9b98c7sm1465435ejb.66.2024.03.26.15.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 15:19:02 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Corentin Labbe <clabbe@baylibre.com>,
 Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject:
 Re: [PATCH 3/4] arm64: dts: allwinner: Orange Pi: delete node by phandle
Date: Tue, 26 Mar 2024 23:19:01 +0100
Message-ID: <4905229.31r3eYUQgx@jernej-laptop>
In-Reply-To: <41dcd736-5e58-4b71-ba82-961cd2863a62@linaro.org>
References:
 <20240317184130.157695-1-krzysztof.kozlowski@linaro.org>
 <20240317184130.157695-3-krzysztof.kozlowski@linaro.org>
 <41dcd736-5e58-4b71-ba82-961cd2863a62@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dne nedelja, 17. marec 2024 ob 19:42:51 CET je Krzysztof Kozlowski napisal(a):
> On 17/03/2024 19:41, Krzysztof Kozlowski wrote:
> > Delete node via phandle, not via full node path, to avoid easy mistakes
> > - if original node name changes, such deletion would be ineffective and
> > not reported by the dtc as error.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  arch/arm/boot/dts/allwinner/sun8i-h2-plus-orangepi-r1.dts | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> 
> Eh, copy-paste, the subject prefix should be "ARM:".

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

I can fix it when applying.

Best regards,
Jernej

> 
> Best regards,
> Krzysztof
> 
> 





