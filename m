Return-Path: <linux-kernel+bounces-156424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E4C8B02A6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B05222859D3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADC7158DDC;
	Wed, 24 Apr 2024 06:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pdJOyFxt"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9782E158DAC
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713941674; cv=none; b=dqcSaBFDzEmi14BGchwGtZMoYQGF0yXQ0LT7Ra6H9Wq6F8rXW/LUDZ86AgnhhNdHQdneUDNESK608zDQT5f5O3dLjkIpGk6ASc/ssSIQV3j7FdaJYRgpaEkw0C1sJ9GjT5Pa6VkQE0vP1cmhYAOf7EXXAWNZJ9qpSwyjWRWwm6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713941674; c=relaxed/simple;
	bh=5sYxl+UaCDeqqMYybUb4bNjgCQWorMCRcRO1ytuBsCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uX6cgH/0RSjYOC9NOir3zkk0o5YBaFx/y1oDGz5sJv1vew+vqAdlTZei3UxF4s7ssXkz4KEb94VxQXOo8/48JaUR6KW4FbkY0dw2w46eeAcGMnJ3M+FW7OPcH2OLFpPF9jRyQyeOOYcQjNi9QaqpqK4CTSsDFQwawAysmM7v19Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pdJOyFxt; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-346406a5fb9so5191149f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 23:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713941671; x=1714546471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2YujgyGecZeMQxLbGb9B2UsmPy4VXriFvistWzKOEs=;
        b=pdJOyFxtGdmzMRY2QL7E9+jfoNc+PCCvaIdvmXoeN4ppIMLeH0GS7SKMlfduUXpJVO
         Eo9YU+Zg2VIqohVy9o0o9SWrAsNz+odrKVIBxo0X1v3qZqN8PqAyoHP1J2TJhRJ8Mw2b
         LTy1j/L5sc4n9LuzwTIoU5G4kf5s8D/QZSqRu0G8vYL+C7QxzicBJX41u4RSq9E7iSy6
         y7pAyI6LOFEo6pgFT1CsAcrL8MD/AfGktba96gTvwDc0m1vsjgmKnGFG76dN3HuGf8dO
         OyeDeALFKwyrc79ze9HK5h9x0ys3sqsiZM5v3JNkItJSiqmY9me9EsSdjlvzyUv9OVlp
         bxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713941671; x=1714546471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2YujgyGecZeMQxLbGb9B2UsmPy4VXriFvistWzKOEs=;
        b=aCcRpYOBV5E/Kzfjba/cbu1P+DrGafRjFszyo6KIqFnOxhf92IFtx7C7ppuXFi4zJu
         pPGIOEumPDoM1QPe9+4bBYcgjoPQvA8a9IIzaUtkKCnosJVtXTtIUo72InOu5NWN1mE3
         JicF0SJYKI3aw0hoy/pZ1mgx+Pd1VrmOQlv/nOSVkOK1kGhlwNw7exeADbD6o9kJdTTk
         NjYRg0QqBzc+ZAya0dCwZF/+9rXlziDNd03OCJvcSJmzpKy/gAbog6F0QvS14+0x24rG
         VfCNadPzvas7zubVTmRWXHWcLYQ/Sf6pk7xkWKyXz3APh5OFO9uvaIkXeLrCtfBm4IMU
         u3mg==
X-Forwarded-Encrypted: i=1; AJvYcCVF450aaypA9pWngqEYUOqYXbhG2BBvG9zsTUoJec2AAk/w2QvrmJ4bEUrIqmDMcWV8IWOGc96B4KeV1Pj9/2lUra7i5sj5rMRwuSr6
X-Gm-Message-State: AOJu0YwDnrFLulxaiJkFdk4bQ9CUvhN0I+ZufFW3VJRdGRoWzK2gi0PF
	fY/uMncybKtxIO1t86hgdDhRMbBY3u67aDN1voeCk6YOqVI8HYPPJrk4U7dJwvk=
X-Google-Smtp-Source: AGHT+IEb/SW08foe6uJmKrfgo2ULn693vJ0SzboRceBM+oGihPmtjWUwOYuhHCN3rosDOAIgjJj0LQ==
X-Received: by 2002:adf:fdc6:0:b0:345:66a1:d949 with SMTP id i6-20020adffdc6000000b0034566a1d949mr843051wrs.0.1713941671027;
        Tue, 23 Apr 2024 23:54:31 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id t18-20020a5d6912000000b0034997769ae4sm16338534wru.15.2024.04.23.23.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 23:54:30 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Tsahee Zidenberg <tsahee@annapurnalabs.com>,
	Antoine Tenart <atenart@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/5] arm64: dts: amazon: alpine-v2: add missing io-fabric unit addresses
Date: Wed, 24 Apr 2024 08:54:16 +0200
Message-ID: <171394159881.43787.8772365708305051790.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240402200744.79349-1-krzk@kernel.org>
References: <20240402200744.79349-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 02 Apr 2024 22:07:40 +0200, Krzysztof Kozlowski wrote:
> Add io-fabric unit address, because it has ranges property.  This also
> fixes dtc W=1 warnings:
> 
>   alpine-v2.dtsi:153.13-229.5: Warning (simple_bus_reg): /soc/io-fabric: simple-bus unit address format error, expected "fc000000"
> 
> 

Almost a month passed, no replies from maintainers about picking it up. Dunno,
looks abandoned, so let me grab this. If anyone else wants to pick it up, let
me know.

Applied, thanks!

[1/5] arm64: dts: amazon: alpine-v2: add missing io-fabric unit addresses
      https://git.kernel.org/krzk/linux-dt/c/0d8ec5c9415f3ac1a8dd02bc8ec31db240d3329a
[2/5] arm64: dts: amazon: alpine-v2: move non-MMIO node out of soc
      https://git.kernel.org/krzk/linux-dt/c/c92b25ab66e76e197353761d5631e1a3299e777a
[3/5] arm64: dts: amazon: alpine-v3: add missing io-fabric unit addresses
      https://git.kernel.org/krzk/linux-dt/c/4c8bdd35ec797dc083cbc6ed30a5a41f471d6c8d
[4/5] arm64: dts: amazon: alpine-v3: drop cache nodes unit addresses
      https://git.kernel.org/krzk/linux-dt/c/6f7be4b3d912b22b708fe444ba11afa521068b21
[5/5] arm64: dts: amazon: alpine-v3: correct gic unit addresses
      https://git.kernel.org/krzk/linux-dt/c/b5efd50d10295ce732ee9c2e546245ad4b9c8db5

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

