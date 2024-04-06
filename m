Return-Path: <linux-kernel+bounces-134001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A6789ABEE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 18:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31BB41C20EEF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 16:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6FB3C087;
	Sat,  6 Apr 2024 16:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pVaYGjZN"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409263FB92
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 16:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712419682; cv=none; b=myJ30L6xQMO6v+HO7IoPYvDioVG4wnpGfXS5DZWSQoCWN9e11LmDzxFJCJR0sAK9wyQe2fpnBVwU6gMTDKugYQrpRT7O5n+hqVu55O47mRA7OW12JFZ//GThxWeTvxwzvwRuGzJOX+2U0+hYLs2w6LDNEdgYwtVSt/vahPKxGJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712419682; c=relaxed/simple;
	bh=Re9aog4YI0eZKksmQyEgqtuyaTCf0OysxZQoXoVWlyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A3hX2G0r+CnvJC+cSECpwVcNnla4ZSWkvRwUUhHeTooj8Tx25MTAj+4DZg0aw0Xjl+zx3bywmNa4Acrp9DuhaCej2QgEJq2V0PwwnUJK7UDO7WSGjeYc9rawZGgBQHxnjQnmnEQ1xqi38KLk41vz+5ztXYTNuSmOMAO/9sU3A1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pVaYGjZN; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dd161eb03afso2926449276.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 09:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712419678; x=1713024478; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xxhiT4mz7EkwRe7mA3Y1GYf1RmoX1+AQ0pJ6CUbqHqM=;
        b=pVaYGjZNljmYK5haX5Hk9nYOp6BhsAH3mdQgdq+OqJyWFba0DR+R9VqzxnFXSdNclr
         d4P5/y466v75glXTyZK7fS69xlZyWkVb+Tl525LxKAJ8w7dwXijXva/CWI41ndNHwj+U
         qkj2yhQbRvZdxWFhO2Wgta9gaoWqkX31cdxhBA77XboKgU0xzLd8OqVYgTXEJN1M0Hn7
         KObLOcVso2E9XEcJUsdTazCSdr3EzTKdjWgK/D3mPuJsu8e4KMe/VemUM28yChFKQ8Hv
         5ApA/eeqDanfOr0JAroOuWl0/QxP4eCJHfdFH+ppepNL21sUscTrU9R3ZV/eomiLkuOh
         uD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712419678; x=1713024478;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xxhiT4mz7EkwRe7mA3Y1GYf1RmoX1+AQ0pJ6CUbqHqM=;
        b=OO4n2J4LVXvjBZbkUBrvUjdh2vBX79VfOkJrMZxpqBDsnL8jMq+bHM83YPH8kdHzyh
         c2b/wz6eR655hcwKxjb3vn1z9XzQv2eUvMUPHYJdopelVTC1M9yi7bAw/77zV0ip4kWG
         S5K/G3UZyxbL0xlts/E4e0S/aP5LQSVip5IJ+Ied3nIZWGGzqSvacZZjc9+mqFkFYLyx
         NXsoO8TsjIfedH+G4fIQyeON06SiF5LGB20Terk6L6oRYxVDjI8LHKqRKMoQ25WxSCNt
         VU4jWu+lwHgOXjtXPFRxCtLTx5rEbx8L5l+LABPKYwrdKANS6vvdFQqsa/Zd5LOtA7W7
         eDDg==
X-Forwarded-Encrypted: i=1; AJvYcCVcjGGKjPIETLYcIuEo5ElXNI4IKb1Jg6cv2+6hZAVILJVM7yUvameUF3rT8VFrLnD4wSHiqL2683Pytf1NDNZ+sgs0IizbfTSh1IXG
X-Gm-Message-State: AOJu0YymFgOwxy25c5fYkCJ0y+CKkm8fCeybq+WsQ6fYP4JpA4ckmbHP
	CjQRAJC0CzS7bNNWrO9XHU11nln1NekenkjSOfXj9hwMVYrVsq19Z1BrDYJASfOC+lk3UYyTMIQ
	/prsKg+Nl1EvZ4k6bjOwWSixbkBppfGwuj7WXnA==
X-Google-Smtp-Source: AGHT+IHggO+6U20SEYFId9dF+T2+hCDTSyO2Vax1gDweglAaFNbjoPCJbiYC8M6TObeewBzJ5GyPc4eC7fPDozv2hHQ=
X-Received: by 2002:a25:6a46:0:b0:dc6:2e29:4262 with SMTP id
 f67-20020a256a46000000b00dc62e294262mr3611046ybc.58.1712419678311; Sat, 06
 Apr 2024 09:07:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240406-shinano-vib-v1-1-fdd02af39d56@z3ntu.xyz>
In-Reply-To: <20240406-shinano-vib-v1-1-fdd02af39d56@z3ntu.xyz>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 6 Apr 2024 19:07:47 +0300
Message-ID: <CAA8EJprxuhE5BNw4LMUkjF8WPi-oBzY5t6LrnN8yvjfguFPoig@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: qcom: msm8974-sony-shinano: Enable vibrator
To: Luca Weiss <luca@z3ntu.xyz>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 6 Apr 2024 at 18:36, Luca Weiss <luca@z3ntu.xyz> wrote:
>
> Enable the vibrator connected to PM8941 found on the Sony shinano
> platform.
>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  .../arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-common.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

