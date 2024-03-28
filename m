Return-Path: <linux-kernel+bounces-123241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3556890507
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70804B22220
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2E6136983;
	Thu, 28 Mar 2024 16:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4Eql3pz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C63130E4F;
	Thu, 28 Mar 2024 16:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642927; cv=none; b=rzDcB80P5HaPwuGFezEFx3ma695jtqMRJUxk8HSzYlj85BkT8P8FWsuqdDkywbqB/rb44D20IorDJg8uLi36gFQyYYP3H2hAmeS1HoupXi3NNO6ljlF03YBR16UQmZtLRt5xCKWz2kY82upA8ZLzkC1lmcru0oICPA9HZnCyVN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642927; c=relaxed/simple;
	bh=OIn2dZxMAHksrWIjCgDEJp/EXR+efkol4wQYb64yzgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a3/xNZY2yFyXh2Osf0kHjXddnjiCwXhWZKVUMTmZqaEPwZFTnG4EgabQIKlEkjeY0/Joy9AqN+gy3l6o1ihbXZFndZNovT2f+b7m7o/Q2gWOWEYPDEzVMNv+f2TW/kMopNwzj9oMqvxJ6lqKczxQV2Ag/jzlvcnlXa9tehW4LiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4Eql3pz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C341C4166B;
	Thu, 28 Mar 2024 16:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711642927;
	bh=OIn2dZxMAHksrWIjCgDEJp/EXR+efkol4wQYb64yzgo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=i4Eql3pz2OAR/Kzs2ZFmJDHdOMUcTbz+92BQZ3b5z+xlxIeDSNQE4bDUXiduWLJSA
	 wuZY/QAif/w7yHc7AAT9EHLc1CPOmRHdpezSXG0QCyVaM2GhvQCUKbG2A/qtCJeHx2
	 FyCBcWVZu4fWWmaX/VmSUAm1BbmuhDxrveY2zE9fCjs26TD6h84ssvmEB5N7b0G/j3
	 12p8iziEMsLLoIpdvqF5hZLPFieog42SUVx41rKrtG4IugVtRV6kncKlr2KDTHuN66
	 e6EetqorMHLEfTDh+Nk1ivjMSsataUJMoI1XSzUG6pkkio5owAmVxcGBTx5jXb9F7V
	 Mc7s8nYI+Tgag==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E299CD1283;
	Thu, 28 Mar 2024 16:22:07 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 28 Mar 2024 17:22:03 +0100
Subject: [PATCH v4 3/6] dt-bindings: iio: temperature: ltc2983: document
 power supply
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-ltc2983-misc-improv-v4-3-0cc428c07cd5@analog.com>
References: <20240328-ltc2983-misc-improv-v4-0-0cc428c07cd5@analog.com>
In-Reply-To: <20240328-ltc2983-misc-improv-v4-0-0cc428c07cd5@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Jyoti Bhayana <jbhayana@google.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711642925; l=1227;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=rnQzwLPbXO4Riqnz6PXrWUTn4Pd8xKChQYwf/cGw4js=;
 b=43SYwE62YUShXFDg44JLjUmDEaIeL6O2K6S/Q9mqqHe32n1B6dDx12C1g4d5anxoCxxyZqYgI
 vyxOz4sd/clAkTmqZx8ubk8axhEJSB8CfB5Uk+gatvrKoYJCh7Sqp2k
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Add a property for the VDD power supply regulator.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
index dbb85135fd66..312febeeb3bb 100644
--- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
@@ -57,6 +57,8 @@ properties:
   interrupts:
     maxItems: 1
 
+  vdd-supply: true
+
   adi,mux-delay-config-us:
     description: |
       Extra delay prior to each conversion, in addition to the internal 1ms
@@ -460,6 +462,7 @@ required:
   - compatible
   - reg
   - interrupts
+  - vdd-supply
 
 additionalProperties: false
 
@@ -489,6 +492,7 @@ examples:
             #address-cells = <1>;
             #size-cells = <0>;
 
+            vdd-supply = <&supply>;
             interrupts = <20 IRQ_TYPE_EDGE_RISING>;
             interrupt-parent = <&gpio>;
 

-- 
2.44.0



