Return-Path: <linux-kernel+bounces-140214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 815418A0D3D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 372F21F225DE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310F5145B04;
	Thu, 11 Apr 2024 10:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jz4u73zd"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D23145B07
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 10:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712829707; cv=none; b=coO4HmkzKsF0/I9tiB3xOueJiI45cPIkfZJL8v/dqz0UBJToARTSUycDKyvVDSK8P0qznJye1Goj7P6a0e0CVTEm61V1xAE4CClllURKSuNfP3yG1INKjbAeL2zDQS/gwjDqklmoEz17fCpjU8mqrDcc0pLyLbiwak49BN+IplE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712829707; c=relaxed/simple;
	bh=oy8LcJ+W0uqOLu9PnTh84K8sqY89rg5jjjcpg2OZPJc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Q5lcpRFhXyMCJL0mBdJxEVNdLWt31EUqxoPKsO/E9LHBjnL5EExsbMMY+SeFYXF29h4FIxo357yeO4+GmvfOSIWPCe4wp/4Mfw1PxLtBySIoNGAdKKuYlA/3+xvoSawe1BCHjvtcLTkpHI9l2LwpKTdPMaaTY3naaLu4/F5NWc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jz4u73zd; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-34339f01cd2so5561871f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 03:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712829704; x=1713434504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmB3K/ttL5cmOZJWlbskxN8kkVBLB3rM/aYCLco3xYQ=;
        b=Jz4u73zdV9h2W9LdaONnSrA1f0rutyA4tpLbl8yV2iOaZtlSy2QGGHkZTFUHxXD3g6
         hhQ9MF1M9NvxHH8w8gnrrFygjn6RCNjWe23HVeBCM/IL/XyrjZnbf/nULkuKQkU42Civ
         7acUN4f80i5Z6/40cEyIQUsTOncMHhcFudoaIkF8vRpcoPazatvxFb8MH8lFx3eUgYXw
         3K7Hv+LDUIKfYnPEQM06iWTgQd0yB98O9Rmg5qwr7aDLMZ7rrfb3TH+H6KsClfaomMUD
         zzSsrMjStDwsCL03KAsMtNYUp+Wg9T/4xp2mUNGelSzjeeRJL7X+DSuQFazEud/rKuQc
         r1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712829704; x=1713434504;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LmB3K/ttL5cmOZJWlbskxN8kkVBLB3rM/aYCLco3xYQ=;
        b=RfBKOVt5g5Y4mfKODWiXAjO9+FpZ5onQueJznk3l6zvgzL9zD2wQAp2d+Qpq2alHhj
         FNwGnuGE/XSUDH61xhiO76wT8g7DhxmDSTtiM0e+vPE8wKaNJFrIFrOw+O0P6mD/CdwG
         zV/Rz/3vuD5R8KY2nFq5UabSNnyzpeJoPKAAOoTTLwC/yxCEKIknYB558UFEtg7jIgUH
         /wcBF05L2dWH28dc4NZhiMMJc9X3gJhA9Ad3/55naIcLcTP9e5ax2KJBoHDhRZnnqPzx
         +ywahh2pmZRFdVmm2TywCG7maV/VMxiLIsgBEoU99W061LJ4XEYhHKS33n+8aJcgiVie
         cMtA==
X-Gm-Message-State: AOJu0YzZJgpTpeoiQ4M5BdG5n0BL4hMgtav+ZR2T54zUGTzqaiQ0OH63
	Zhd3c9UVHa9miL+4Bkv4YSWvM/NeCGN7j3pdUWG6uDD41AF3EoQ+1CH/CyfZkLQ=
X-Google-Smtp-Source: AGHT+IETbfh3cmO5zObGlyrhjCfOUwsQGqnW5cGKh9QdYOqA8aZr6EN+QPdsIzL1kim8IaQcHleLNA==
X-Received: by 2002:a5d:620c:0:b0:343:eb8d:4365 with SMTP id y12-20020a5d620c000000b00343eb8d4365mr3161567wru.42.1712829704279;
        Thu, 11 Apr 2024 03:01:44 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id w13-20020a5d680d000000b003433bf6651dsm1381810wru.75.2024.04.11.03.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 03:01:43 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Michael Walle <mwalle@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20240329-module-owner-nvmem-v1-0-d700685f08e1@linaro.org>
References: <20240329-module-owner-nvmem-v1-0-d700685f08e1@linaro.org>
Subject: Re: [PATCH 0/3] nvmem: layouts: store owner from modules with
 nvmem_layout_driver_register()
Message-Id: <171282970361.159167.848249101676337371.b4-ty@linaro.org>
Date: Thu, 11 Apr 2024 11:01:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Fri, 29 Mar 2024 17:13:34 +0100, Krzysztof Kozlowski wrote:
> Merging
> =======
> All further patches depend on the first patch.
> 
> Description
> ===========
> Modules registering driver with nvmem_layout_driver_register() might
> forget to set .owner field.
> 
> [...]

Applied, thanks!

[1/3] nvmem: layouts: store owner from modules with nvmem_layout_driver_register()
      commit: e428f11ae8fb23c4c9e4ca7c178ca22e8b6335b6
[2/3] nvmem: layouts: onie-tlv: drop driver owner initialization
      commit: 995b22c48ed05ef2149a364e2f4025fa14f8bb70
[3/3] nvmem: layouts: sl28vpd: drop driver owner initialization
      commit: 3575d48e5d2f7fcb258f1ee951f2d4706d8ff715

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


