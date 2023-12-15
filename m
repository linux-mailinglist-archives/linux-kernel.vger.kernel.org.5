Return-Path: <linux-kernel+bounces-805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B356D814680
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42FB2B22EB5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53F4250E5;
	Fri, 15 Dec 2023 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yd+AU+UX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB9224B37
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 11:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-336417c565eso397538f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 03:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702638848; x=1703243648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OvNThQelyPS3NeENr8X3Gu0AJLxvcIWGLiI4cgpCOqY=;
        b=Yd+AU+UX390BcC2onb+k74wSx5dCxgCFiYgZtKYfZB5OkuBlScpLo5bNwlEDbXwkt5
         dtwg2tGelT7SmVri/X+P5qJ4ydmYC8uqYeUPI5AwBYFg3YKW+5205HiR7h6UPl1jV89B
         a+BVUrAugbBkqNpnMcZtYnEzEfBV1zEFLUCXscJcVOBcoVMiPjpbUicdyWAkkyPfFLq3
         XXZOYoLPlzoR1EPloA+6lpxzM0V4rzrM7U9X6O1GlQqSdfpCLpvlztRLGRMbBkMwhnR8
         wd6M4w+yoV8amcgU69v+uU7q8krm1D4lPe1wjNKCX5cqi+DN8kampZyoK68oAfRGtBAB
         cjgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702638848; x=1703243648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OvNThQelyPS3NeENr8X3Gu0AJLxvcIWGLiI4cgpCOqY=;
        b=VRTaKOryou8lgDqDlCrwPkaux4Q8ST2OHaZgl9ge1jch3Q4k2OD+Rn+8hw8cH9QDL7
         RUomuBzCDvrpn1N4WTU/cnedNRPgo91L42XyxdLMxfPItadvokd27WMBtajAd/5Fa5ec
         nBzpjQcSWMu64EFni497APSXXhDFupgbEdGR8qaVGoCrNEuV96StC9XA3U/XAlf6A1rd
         NJVnFlvXkjyaIwcMlOa8g/GNtU8Vr/RjW3x00PHlfC6vr/VuQ92DjnZCB+M7iUYJ287z
         eT5jmZkH6EkiDHxOHjBZdwhYZW/7HX46qHubq8iwgVzC/oSLEKa6sArRi+MsRC5z5fJ6
         J9Hg==
X-Gm-Message-State: AOJu0Yy86e+9DeSFhbAQkUYOrXbqEwXnm55KnxwYjApz1C6JztVDM2to
	7j42gPOA4914MDEXdrDroNSXNw==
X-Google-Smtp-Source: AGHT+IHYFKbzrUI7xBGHTwHy3fWMmlDsT7flKeRf2MPHhrZRRqxReIgJOy+PjjoS+qY7Cjobl4c3SA==
X-Received: by 2002:adf:e88d:0:b0:336:4c99:9a26 with SMTP id d13-20020adfe88d000000b003364c999a26mr552575wrm.73.1702638848558;
        Fri, 15 Dec 2023 03:14:08 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id s15-20020a5d69cf000000b0033641783aeesm6310757wrw.7.2023.12.15.03.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 03:14:08 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/2] nvmem: fixes for 6.7
Date: Fri, 15 Dec 2023 11:13:56 +0000
Message-Id: <20231215111358.316727-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=603; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=H2rQDIcHpO9Kjwh8jJt9zGaTBO0RB46ss7B8z1AfnZ8=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBlfDTnxm2Kvm+Da/RzODZHCAIZg0QzxApFnEbs/ ASJGrV3/EiJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZXw05wAKCRB6of1ZxzRV N5ELCAChvlhDwku4XRyF8MRHY5HctdBuHuOR+x89XNbVbK12FM4JQzhl4UAg3uSrL6WlWkGwhyD ZYUX3YH+ocOziRD9P7RFuOITuUSI5C37Fru5OmGUqFrv4fzE/ONjqrOzYo8sqcMwQr8ZLov1IRA 7MB/fFZaUDEO+s3wqaWPEr80OY/j25MJRzdVE92jaHhgcGca6/q0/cL7Bwg6Wpc+TGTS3D2FIYB vfYH8V/tPaKixssLW4ksWlpOaNDSe3glt3mltUXMKirz/JCNGf0sDjd262Xxkl2uFZJF5ZjjyRx mWTfh/LSmPykgtIyRruTBe4GTVJToAR1tWymZlE3s+0yehdo
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Hi Greg, 

Here are two fixes in nvmem for 6.7, if its not too late could you queue
these for next possible rc.

Thanks,
Srini

MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

*** BLURB HERE ***

Fabio Estevam (1):
  dt-bindings: nvmem: mxs-ocotp: Document fsl,ocotp

Rafał Miłecki (1):
  nvmem: brcm_nvram: store a copy of NVRAM content

 .../devicetree/bindings/nvmem/mxs-ocotp.yaml  |  10 +-
 drivers/nvmem/brcm_nvram.c                    | 134 ++++++++++++------
 2 files changed, 100 insertions(+), 44 deletions(-)

-- 
2.25.1


