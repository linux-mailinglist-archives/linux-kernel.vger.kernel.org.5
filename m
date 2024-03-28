Return-Path: <linux-kernel+bounces-123802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB54890E4A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B27FE1F24880
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84933139598;
	Thu, 28 Mar 2024 23:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/UzZX98"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B712112DDAF;
	Thu, 28 Mar 2024 23:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711667318; cv=none; b=iMq8EQOPptPVuD9M8EpGiDyBgBaD7oGQ/G8omUORIJjzFElQigU59Fnw5PxyWMnchhPT0waSAVzyTODrnId3MjbiqpMPWF9pKvM5xkjmsDBM0OywBboUiZ3n0/M94/kUcAeMsLatjUgorqnKvBc87n/rzjfr3C5JIRmFszpzsIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711667318; c=relaxed/simple;
	bh=EO57HbOh5710XDfnxOWvIJpZVjwIG+J4+aFo0XfThjo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=p8qL5dV6vHRlyIikhQFjdtxEH7fsDY0eaLUhPEm+VvNeJAsaHOBYKr4RqCHqBL7A/qhsOuFxdMFgHmfsNq3lZaeWsHjZ06sq2zob06BGRl2w8uaWpWve3NbgC9WOUdpFJvwgfJk1ja2u3UYgHulle56LKDBoQQX+y/kZ7e7lr40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/UzZX98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 470C0C43394;
	Thu, 28 Mar 2024 23:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711667318;
	bh=EO57HbOh5710XDfnxOWvIJpZVjwIG+J4+aFo0XfThjo=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=C/UzZX98fPjRD0VpPQTkAgBAzMrAOMYyvb6GQgoHb571Ib9H9tvfxwCNDyBUBHp1F
	 7oiqUFx9snxoFNWwlY1ZElYP6TQ/JqP5PyvEbQNriGEc+EnkI0+oatjNanWy+Wpsn5
	 gMrhWEGvoNUj3nqC9JkNXgj1Xx3hI9151Fd9/9LdNG5GoLMvz49ErE1aI4OYgunMnS
	 g1WE1tEH9knpRrAOCjBShZOX3NtKHm6h8wSqfC94NypwFYSWzP6Mz6wiHs+D2ZNZqt
	 +uPqbVVA4N1ErpvsYuz5SNj/MIA6gfVDLJuFOycV10kDNultjNU85bRrIw9tZ4J5Gx
	 41JbsMGMFwpEQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339D0CD1288;
	Thu, 28 Mar 2024 23:08:38 +0000 (UTC)
From: Alexandru Marc Serdeliuc via B4 Relay <devnull+serdeliuk.yahoo.com@kernel.org>
Subject: [PATCH 0/2] V2 arm64: dts: qcom: Add support for Samsung Galaxy Z
 Fold5
Date: Fri, 29 Mar 2024 00:08:33 +0100
Message-Id: <20240329-v2-dts-add-support-for-samsung-galaxy-zfold5-v1-0-9a91e635cacc@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHL4BWYC/x3NQQrDIBBA0auEWXfAqIW0VyldTOpohVTFSULSk
 LtXunyb/w8QrpEF7t0BldcoMaeG/tLB600pMEbXDFppq4wecNXoZkFyDmUpJdcZfa4o9JElBQw
 00bbj1+fJXdHa8aZ6M3gzMrRkqezj9t89nuf5AwZqQ2B+AAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711667317; l=1075;
 i=serdeliuk@yahoo.com; s=20240326; h=from:subject:message-id;
 bh=EO57HbOh5710XDfnxOWvIJpZVjwIG+J4+aFo0XfThjo=;
 b=VS5eDCzT2/mE6l3UAaVadUeWpsFPHwax2Lx88eeJ3m/j6FRGubnsDpHgOwlCHbElDC8h1EV6r
 cDlVSqnKE9nDkacFKgHdSO7IXRXfX9FB9pydI+ngKu8hiBO5nGCHESr
X-Developer-Key: i=serdeliuk@yahoo.com; a=ed25519;
 pk=aWyveUE11qfDOOlRIFayXukrNn39BvZ9k9uq94dAsgY=
X-Endpoint-Received: by B4 Relay for serdeliuk@yahoo.com/20240326 with
 auth_id=147
X-Original-From: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
Reply-To: serdeliuk@yahoo.com

Added the  binding file to  the  same patch that includes the  device tree.
Refactored the  decivetree
- removed bootargs
- removed unused nodes
- removed disabled nodes
- added missing identation
- removed all the comments at the end of the nodes
- moved node status at the end of the nodes
- ordered all the nodes alphabetically
- ran the recommended dtbs tests all returned success

Signed-off-by: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
---
Alexandru Marc Serdeliuc (2):
      V2 arm64: dts: qcom: Add support for Samsung Galaxy Z Fold5
      v2 arm64: dts: qcom: Add support for Samsung Galaxy Z Fold5

 Documentation/devicetree/bindings/arm/qcom.yaml |   1 +
 arch/arm64/boot/dts/qcom/Makefile               |   1 +
 arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts | 584 ++++++++++++++++++++++++
 3 files changed, 586 insertions(+)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240328-v2-dts-add-support-for-samsung-galaxy-zfold5-44b90138f3be

Best regards,
-- 
Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>



