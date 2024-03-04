Return-Path: <linux-kernel+bounces-91419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5715871147
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72478B20ED4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FCB7D089;
	Mon,  4 Mar 2024 23:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="gwOL8uG5"
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89321E4A2;
	Mon,  4 Mar 2024 23:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.177.23.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709595815; cv=none; b=LXp5baFWw8/mKAkaDE82VEJ4KSCiasyYOlDgm60kwaxfcG3bdjMUxP6EMTiGkuVqTGlb2DGB6Y7d/LY5w/f+njwrQ/+2KIg2hXEZ4AWS4ZYbfwhRoxX5Gk0qJC/U+wO2nXjsOqwhnvspWfH/F2yKYOx1l7+7o7dvFmeqBv/pUg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709595815; c=relaxed/simple;
	bh=xueZhO6TwVJo6QASo+1YxhLvd0B0az0vWrOzqnoIX68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=flLZPjKFFgmDmzcYTbR9jOu8PdO1A2hfsTKdhz760P51Eqk2TjKhZ2Y5R9ve8A5636Jcn8QCKn4tim4Ftz5N3dsoyZV7vxJF3cwICo2OWIDNTKO03zoVjg3F5CivTPTbTHz2ba145ks6mO70N9dVhOm71IJIchx7RiChIo7IMN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=gwOL8uG5; arc=none smtp.client-ip=89.177.23.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Received: from localhost.localdomain (unknown [193.96.224.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id EF487165264;
	Tue,  5 Mar 2024 00:43:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1709595810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ffDu/aVNhPb8G/gbL+4BrQaiGSUOAl4a84jpx9cTCcA=;
	b=gwOL8uG5imkrToD9/gpu9CgPgRSNBLqshzX8oAMmY926QT/D6C80hUjce8nDob9sZ5jlkD
	vmHt67OnzaA9xtgUuAdjLHBRr72qL45cUXBR1quew2NqSXI1LUS+PGU5aXMB142OEixUHS
	LU81ox+ADskDt0HdTWyY08/20fuUYfA=
From: David Heidelberg <david@ixit.cz>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>
Cc: David Heidelberg <david@ixit.cz>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: opp: drop maxItems from inner items
Date: Tue,  5 Mar 2024 00:43:06 +0100
Message-ID: <20240304234328.382467-1-david@ixit.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With recent changes within matrix dimensions calculation,
dropping maxItems: 1 provides a warning-free run.

Fixes warning such as:
arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dtb: opp-table: opp-200000000:opp-hz:0: [200000000, 0, 0, 150000000, 0, 0, 0, 0, 300000000] is too long

Fixes: 3cb16ad69bef ("dt-bindings: opp: accept array of frequencies")
Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 follow-up of https://lore.kernel.org/lkml/20231229191038.247258-1-david@ixit.cz/T/

 Documentation/devicetree/bindings/opp/opp-v2-base.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
index e2f8f7af3cf4..b1bb87c865ed 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
@@ -57,8 +57,6 @@ patternProperties:
           specific binding.
         minItems: 1
         maxItems: 32
-        items:
-          maxItems: 1
 
       opp-microvolt:
         description: |
-- 
2.43.0


