Return-Path: <linux-kernel+bounces-123455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1A08908E2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B0691C2CC75
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D6D1384AB;
	Thu, 28 Mar 2024 19:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgVeiVQt"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C7B1311B3;
	Thu, 28 Mar 2024 19:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711653130; cv=none; b=heJRyEnxTGdA7eQX5trXfKXPNYD9arw1NBki5TOQkScBguJbw+38OTjJEYh/atFWqp6KvkdLqezGOp5XzUZ0urRVtHqe23MXlQ/jifsYb7LSzQoTqmTD9Gk6U72C1KJ/2LZi7w2aZ3oXwD0WZthkSbQFvmEsmJI61ImTKM6WXQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711653130; c=relaxed/simple;
	bh=biYxyJhLDCyx3WdQsS5BmOjmFGFgSE1mva1PXOLzYXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ind56j0EMlq2qEpsGbH3QempT3AzUsuMk89YFgJVf0fIYR3BsHbS3PFIgqQxp/NwLSiZbUyrmKHhZCc5zfO2Ja/u9i1ecjYZCOdv+1RhJAirI+95mafvvQBmLmaEGm6wLnVRR3G4Jjm6DHwqYZXDgwHF+CvnD2h97booHKAEkjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgVeiVQt; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36867dfe940so4260525ab.3;
        Thu, 28 Mar 2024 12:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711653128; x=1712257928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sJ86BPk/z7nJiBSTEphysEjHpoF9fC7TBFrMbkKS54Q=;
        b=FgVeiVQtK0sDhn4IU22ozAt2yAhC0hadnoZ5s0U7tPXL4xBSch5l19kZeGrg8p7k6Q
         EM9jIxjgPo3xEeNln38xgynHMwMcaa4K8zsocxgUuEItbsGro70ZrImW2ByjS/v2pknj
         amqEvXaCamUFf/MIhzxcvDxMg70OYnvQ3HO+F5sR36MioiidcFglGXrtFY2/nS8b4g4g
         VAhSW0R+YDXHfZ+HXNrk/meuhdNmzcJ63IziZRLN0rSwlivEwzkGYM8l9lGOoJb3vkJo
         pc/udBU+efbIq8AzRdT+MsClkMHC2bl0hUA7soY7vxhCdxdRgHu9nHmWEcC7bnN78RHE
         GxPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711653128; x=1712257928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sJ86BPk/z7nJiBSTEphysEjHpoF9fC7TBFrMbkKS54Q=;
        b=MKWmKqJVBqKNPi8WTfHJdQYl2OeTWK6nV5wh01SRMbI7ut/tlTU+n7jDRmURLX0w7b
         RmEKUYISJR0gvrwbKI0cVQIJmG/YeLScfioo7ueu99O4hBM04kp9dgbDQ53LwXUt4Ml0
         f8+x8VtWx1Tgzk4HLGsgzf7Awl2u7p0ebmlFYBrst0Dw1ZQ+RNOR0h4gOK18d4JhWF9q
         7yfLsVZJp435eq0WGtiq22EM+OBC17aPjcG2qkjUfEMuGezJwphUlNqhRGgK8p5DWyof
         fVZIp8KWxh237T1R2Sh2OB4GSxOU6qn0uAp+ag3FHrCswPyxCEwwgT5Yeb5if/E6yIQg
         /iQg==
X-Forwarded-Encrypted: i=1; AJvYcCVetZSyA0HfHx8b9sCA64SeUk5B5phBNbJjheuSTeCEGd4qvxLmLLnjv/KLMaAedZdRz/JQypHYbZ49iIuWFP1wgO8EKRnA00CxPLuXPqwV5mAOzRBE7Wq2ZawlGdDTcsp9sWV19P3C6g==
X-Gm-Message-State: AOJu0YxJ44qAXNEnTgeCZ4JLRWSmliNNzmRoJhShHsbCWEGycb5hg17c
	dF2G7mq7So3GwRLynLIr0DtvGLVSKC8yWyp7mReXiFJd7fSlFxff
X-Google-Smtp-Source: AGHT+IFLfnLNW0l2diyN43Gt0EjvMYz199HCeJRag2x2dZHlLF+jJEkFP6pLmURA0QyYh12MkF30iQ==
X-Received: by 2002:a05:6e02:1e02:b0:368:8ab3:7d9b with SMTP id g2-20020a056e021e0200b003688ab37d9bmr1123ila.15.1711653128467;
        Thu, 28 Mar 2024 12:12:08 -0700 (PDT)
Received: from hestia.. (208-107-161-31-dynamic.midco.net. [208.107.161.31])
        by smtp.gmail.com with ESMTPSA id e13-20020a056e0204ad00b003685ea08fb3sm590301ils.73.2024.03.28.12.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 12:12:08 -0700 (PDT)
From: Robert Nelson <robertcnelson@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Robert Nelson <robertcnelson@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Jared McArthur <j-mcarthur@ti.com>,
	Jason Kridner <jkridner@beagleboard.org>,
	Deepak Khatri <lorforlinux@beagleboard.org>
Subject: [PATCH 1/2] dt-bindings: arm: ti: Add BeagleY-AI
Date: Thu, 28 Mar 2024 14:12:04 -0500
Message-Id: <20240328191205.82295-1-robertcnelson@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This board is based on ti,j722s

https://beagley-ai.org/
https://openbeagle.org/beagley-ai/beagley-ai

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
CC: Rob Herring <robh@kernel.org>
CC: Nishanth Menon <nm@ti.com>
CC: Jared McArthur <j-mcarthur@ti.com>
CC: Jason Kridner <jkridner@beagleboard.org>
CC: Deepak Khatri <lorforlinux@beagleboard.org>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 52b51fd7044e..ca23b7e6a35e 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -134,6 +134,7 @@ properties:
       - description: K3 J722S SoC and Boards
         items:
           - enum:
+              - beagle,j722s-beagley-ai
               - ti,j722s-evm
           - const: ti,j722s
 
-- 
2.39.2


