Return-Path: <linux-kernel+bounces-37578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB8C83B1DE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA1C02826D5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9A6133424;
	Wed, 24 Jan 2024 19:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwCmJcr2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3436A004;
	Wed, 24 Jan 2024 19:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706123271; cv=none; b=bu2E/Yp1JrH/PIrjyzAOw2kLs9ZadmDipA1k4UrsXrTgx1rmIhjpV4sJPM/uSv8nT3qtMXkD3eyuX5MzmXsk9HnS34d8c4yXXRxwVLlgP0zgP4WhreHhwqC4wJ2ulcFJvP0Rtm16OyaSqioGXsv8iE1a0jJo3DFnb+6s9o5NjO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706123271; c=relaxed/simple;
	bh=qVls8IQx2552RmwN7Jy0Od2PMEq7oPBPKU49JRihW/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=adROG1Nj5ZmTZal6E5uVdJktMEl74uHmikgYWvidbADxHL91Xj0YY7Jc/V5TZcg8kO0NTOdIbQp/o/Y49qH81Fu620i3M+Gubor82ou7zi+DO9ah2VLQeeeuilx2JczsV7/v1Cug59o7xiJmtnaEaX+PKOsjpwqWEHvRqe6QwCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwCmJcr2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79A7C433C7;
	Wed, 24 Jan 2024 19:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706123271;
	bh=qVls8IQx2552RmwN7Jy0Od2PMEq7oPBPKU49JRihW/Y=;
	h=From:To:Cc:Subject:Date:From;
	b=UwCmJcr2x3BQbRozjA+zj26aMkHyBUJtmxi2/4NK3KkkpL1c1vbCq5OqjgZQgzec1
	 x+eua/G12IpwxsN//fMS1fRth9vQXSEQbTJMrPmCIbgqipL6nEuXvTmny8DvNAQ6hk
	 wrYFTWYv0c3VcjtYf4483HQI0JeZ101Iz5XfHt4kF8CcN5t097ajUTHixqX7/KmNax
	 h0PIdnqWSaKDqYtyIys4QGqbPX2uJAThD8ZoKzjwR+jGne858ZwsK9e7QtK4hKkywm
	 UMnSjpLP1qV6CucpAymEvkdnfLQaEGQLxcxrRblMUe5LQS6rrButrBFsgfYMowpumh
	 dbkBSMWCZSu1Q==
From: Rob Herring <robh@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: soc/qcom: Add size constraints on "qcom,rpm-msg-ram"
Date: Wed, 24 Jan 2024 13:07:44 -0600
Message-ID: <20240124190744.1554625-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'phandle-array' type is a bit ambiguous. It can be either just an
array of phandles or an array of phandles plus args. "qcom,rpm-msg-ram" is
the former and needs to constrain each entry to a single phandle value.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/soc/qcom/qcom,rpm-master-stats.yaml     | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,rpm-master-stats.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,rpm-master-stats.yaml
index 031800985b5e..9410404f87f1 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,rpm-master-stats.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,rpm-master-stats.yaml
@@ -35,6 +35,8 @@ properties:
     description: Phandle to an RPM MSG RAM slice containing the master stats
     minItems: 1
     maxItems: 5
+    items:
+      maxItems: 1
 
   qcom,master-names:
     $ref: /schemas/types.yaml#/definitions/string-array
-- 
2.43.0


