Return-Path: <linux-kernel+bounces-123083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB948901E3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2044D293FC9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9E982D7F;
	Thu, 28 Mar 2024 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvW1KE+9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C3142061;
	Thu, 28 Mar 2024 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636342; cv=none; b=T0OA4yWB2fwfUFfyoTri3uHnpw33BfyH1EfnRESsh4PdnZCxMreu5xT1tl9duXohib8d0sBbKWO/bP2WrRIKAobjqZXWZXmcYu4OpxCSQ0Lj99bI+5N/EYWYd/JL/9ADBt6bX/wRDoaifyCLvLY8rvAvsDNsYDOwvTHVnuZD+eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636342; c=relaxed/simple;
	bh=DniBv7HDuOSFJ9Q/K/rkEYhPtiwkAM9wDfWrElmwlbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=V9/kIokIuLHVy0j5j1MGuDWXvcoxHVVXmIcwNWYiPOUzfDJMhm83hmJWAWur6yKZRoobi4YonEh5RGwwsxgfLAw7mU+LArGqFXB4hlP4Z3tDZSp9QcD8+VMdq7F1+vIw32p4YR+f2u0GoGZMu0A/gksdNWuHYpufLKws4kRciLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvW1KE+9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A04D9C433F1;
	Thu, 28 Mar 2024 14:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711636341;
	bh=DniBv7HDuOSFJ9Q/K/rkEYhPtiwkAM9wDfWrElmwlbM=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=nvW1KE+9FE0GhHRQIATdCjTTgBBITil9f1CWyHaYGjAgwuPPZ6NTGa+eTUMepBmdo
	 AW26qtGpKx9GY94U86oDEy3SniVBDdNo42uNTncueyCdTD1iU4c67bzrGTk8+6tOuy
	 gGF0iSNBqxn3/WeYggTzJGRPjj0VwqFO8lW3EHJ6gemLnrroZg2AW8dzJwkQjHDlN7
	 g5LzMD1b8tKh1Y/dWJcdziMsKvdQW5qpDOXxG2Q3pHXhRpKbfLm+aypl/kpy4ZgIbG
	 PXs55R6f+rJCzkI2RUH+VZKuZTlggBhkOM9BKC++oiUhFp6qcEpQStaGCDX9BzvUmI
	 yJ6DN4D5+xryw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86769CD1283;
	Thu, 28 Mar 2024 14:32:21 +0000 (UTC)
From: Alexandru Marc Serdeliuc via B4 Relay <devnull+serdeliuk.yahoo.com@kernel.org>
Date: Thu, 28 Mar 2024 15:31:54 +0100
Subject: [PATCH] dt-bindings: arm: qcom: Add Samsung Galaxy Z Fold5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-dt-bindings-arm-qcom-add-support-for-samsung-galaxy-zfold5-v1-1-cb612e3ade18@yahoo.com>
X-B4-Tracking: v=1; b=H4sIAFl/BWYC/x3Nyw6CMBBA0V8hXTtJRUysv2JcDH05CX04AwQl/
 LuNy7O5d1fimbyoe7cr9isJldxwPnXKvjBHD+SaVa/7QV/6G7gZRsqOchRATvC2JQE6B7LUWni
 GUBgEkyw5QsQJtw98Q5ncFbQxg9XGttao2qCyD7T954/ncfwAtNAm74wAAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711636340; l=1106;
 i=serdeliuk@yahoo.com; s=20240326; h=from:subject:message-id;
 bh=IpQsriBYvSNLQMd2YJDhHVpK6OXYCGczgxGgUDxifKw=;
 b=Z4u1H1PWLX9nzxHNm1NxgRKIFZIAJe45DtsuFdFLAk59N198RnTlEnBQXghV2Try2UAsBPFQx
 C9trdRB/AT4AnGa0/edd20Wic9fm4u6aQ+D37uW+jv726xKpDaUko4b
X-Developer-Key: i=serdeliuk@yahoo.com; a=ed25519;
 pk=aWyveUE11qfDOOlRIFayXukrNn39BvZ9k9uq94dAsgY=
X-Endpoint-Received: by B4 Relay for serdeliuk@yahoo.com/20240326 with
 auth_id=147
X-Original-From: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
Reply-To: serdeliuk@yahoo.com

From: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>

This documents Samsung Galaxy Z Fold5 (samsung,q5q)
which is a foldable phone by Samsung based on the sm8550 SoC.

Signed-off-by: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
---
This documents Samsung Galaxy Z Fold5 (samsung,q5q)
which is a foldable phone by Samsung based on the sm8550 SoC.
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 66beaac60e1d..dea2a23b8fc2 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1003,6 +1003,7 @@ properties:
               - qcom,sm8550-hdk
               - qcom,sm8550-mtp
               - qcom,sm8550-qrd
+              - samsung,q5q
           - const: qcom,sm8550
 
       - items:

---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240328-dt-bindings-arm-qcom-add-support-for-samsung-galaxy-zfold5-0994c09c202b

Best regards,
-- 
Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>



