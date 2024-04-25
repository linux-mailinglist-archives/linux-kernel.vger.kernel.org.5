Return-Path: <linux-kernel+bounces-158895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4333D8B2669
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8480DB23CF7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9A314D43B;
	Thu, 25 Apr 2024 16:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bep3hvd3"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2934500E;
	Thu, 25 Apr 2024 16:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714062515; cv=none; b=iSaV8y+QWIucIBfGOa7w8HAdVAS+NmL0vJrs4cuv4/KiL4B3euKheiDCtnyvXSquUd9w0OKeNHhqUaMIkKD7SUzBM2u2EqKuYm1wTdzXhs8AyqE1iOKkfw1gNinjYvex2J9H4tRvyiEldB+YkWpjkHnymkN8fGcXJT1PBv7ezBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714062515; c=relaxed/simple;
	bh=zYklsoUISlYvKcyat4IXY/FAxqT4drqQLM3RObkFEns=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BtioOXg/aIlw4v/J/uxN3J/RmThVrmN9K8ri+uG6oUJu3WitJEQdxjTqnWzQyFO4uX/8iVJT+WY7gmY0oJOrx68HOdVhwtIA4S5ngpXxZbL8ff/7fzuFweIfnAS6G1ur0ehaVnL+qMv8Hor853cuw3DEfTw11fjr8Ievr4I+V4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bep3hvd3; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7de9261da9bso52992839f.0;
        Thu, 25 Apr 2024 09:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714062513; x=1714667313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mM4rXzzAkJW7swm4RgUC3JddyT33k2sAHq9gnK5IRxE=;
        b=Bep3hvd3Aac4AVAme8+hIk+OJpKdNRGlWdo4uKtDuTrHpL0wrLkKB+fFBoXNvsJY9V
         VaxkgAkcOcLL9aF0PAVBCkG8zPu/BYvkoLwd3qw+vWrU+6t1fFwSb0Ab2+3Sh5CXwbL0
         8r2ugCTEZJm5zdcBwm/PB8n2ReVZm4v4ivhHBXAsIU00+CUP2jTbnY5v8q8GxbNvDLwc
         ff42Y45xnY0z+BGWhB763d3zliY06l1WDZqFY3kp1jKAEDwMYbHvMSTgJO51HEYC61rf
         nxG3qA0Q0WVoLwOU+uTtXB7Sg4Mzw/R9Y3HWEmfDFTsnU36EwCYkOrrJ8UPJklR0GOAU
         NOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714062513; x=1714667313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mM4rXzzAkJW7swm4RgUC3JddyT33k2sAHq9gnK5IRxE=;
        b=FSvZp8wa3WZ7LkaehBuWbhkOyYXd7ZPU4K5WO+U0udl5ORfS26fiNwhP2LRGz7e0Gk
         0KzBIJpS2hJEMM05C33RM3TGsN0y6O+tl1cuNzsuTFxcYnSL4PS3z6jesiAD+PTIqMvh
         BP95QWe22loNPP18kW9uDm7uoi01eSuVSjgUq/FgihRjhs1H4CSumgWufGlYWAzdk3f8
         JzO0IafQ+/izISxBnLYFb6bT3b65QV3UhVMrcs7JO9qzeeBPcQfPRX+HMKIeIelyqnGn
         rwzPUsPNGkaZPgk+KX+IKMFvknPLQ9hdvUwVu+D7noLdRZQALz0FT4tRdM6ts0czagHe
         H7Vg==
X-Forwarded-Encrypted: i=1; AJvYcCXNTbUV0Xd7AgBla5rQNGOM9JWJbvKEykJw4ZSWm/+JlEeGEFwP1Cqoty1+4HKOjNv6JSmNA7crDxAmSfz/sESJqchJjHHQ92bsM7mI2Rb34gWu4SSsV/0RYeNerTvMGgRe+wAUi3Cbmw==
X-Gm-Message-State: AOJu0YzcKzNbbLwQj38GcThE1nsuCKHZhIh9ha3ySZBTrRxNSkGH/siN
	1fvIEpqQkbcgN5lBk1N/OZ+X8fSE8n5u216nin4vQMdJHollXVkriSs/dA==
X-Google-Smtp-Source: AGHT+IHsi7KLteoETH3HlQjP/C9ySCjZ4hp/t0fU8NHdy2orc+ybHiNJPYqiZOqo92itEM0lY7nL2g==
X-Received: by 2002:a6b:5c08:0:b0:7d5:d997:dd5 with SMTP id z8-20020a6b5c08000000b007d5d9970dd5mr196489ioh.6.1714062513638;
        Thu, 25 Apr 2024 09:28:33 -0700 (PDT)
Received: from hestia.. (208-107-161-31-static.midco.net. [208.107.161.31])
        by smtp.gmail.com with ESMTPSA id g21-20020a056602151500b007da63ce9a48sm3386171iow.49.2024.04.25.09.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 09:28:32 -0700 (PDT)
From: Robert Nelson <robertcnelson@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Robert Nelson <robertcnelson@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Andrew Davis <afd@ti.com>,
	Nishanth Menon <nm@ti.com>,
	Jared McArthur <j-mcarthur@ti.com>,
	Jason Kridner <jkridner@beagleboard.org>,
	Deepak Khatri <lorforlinux@beagleboard.org>,
	Drew Fustini <drew@beagleboard.org>
Subject: [PATCH v2 1/2] dt-bindings: arm: ti: Add BeagleY-AI
Date: Thu, 25 Apr 2024 11:28:28 -0500
Message-Id: <20240425162829.2370614-1-robertcnelson@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This board is based on ti,j722s family using the am67a variation.

https://beagley-ai.org/
https://openbeagle.org/beagley-ai/beagley-ai

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
CC: Rob Herring <robh@kernel.org>
CC: Andrew Davis <afd@ti.com>
CC: Nishanth Menon <nm@ti.com>
CC: Jared McArthur <j-mcarthur@ti.com>
CC: Jason Kridner <jkridner@beagleboard.org>
CC: Deepak Khatri <lorforlinux@beagleboard.org>
CC: Drew Fustini <drew@beagleboard.org>
---
Changes since v1:
 - switched to the TI model am67a over the family name j722s
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 52b51fd7044e..201378cdbd93 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -134,6 +134,7 @@ properties:
       - description: K3 J722S SoC and Boards
         items:
           - enum:
+              - beagle,am67a-beagley-ai
               - ti,j722s-evm
           - const: ti,j722s
 
-- 
2.39.2


