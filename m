Return-Path: <linux-kernel+bounces-37492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C88A83B0C2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 347AC1F222C6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1A112A161;
	Wed, 24 Jan 2024 18:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpBvyfZC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02DA129A83;
	Wed, 24 Jan 2024 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706119965; cv=none; b=LfEJZbSUNblNcEP9Kbzl/7Dp4D8ToCboqozbhjztxI3w5Re+qUBIfupWL9+oEZOskpbX9ahj6CixuINRIrnM0lAPT6aL4sMpxfd53UjTYYyIsW3jl1wl9DDVxvrpgky6VLeVvPiCVrWjalJEy+02mnAt/3G+TjQInn8YfhBD0OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706119965; c=relaxed/simple;
	bh=fy5ndU56bZ/p4JHI62d9ycEW3tZ+dtVRsUrjEUAhStE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RNBgsWeE29iHHMw/vJGUDg0jk4u/+65gmzsiHoc+8lfWNoUpM7nkv3979XJApo2N8gb241R9tDCM0PqwJeMkeg4+k2rkgMAhSzgKSXDPu7zABuDPaNANunxpRMcSIHFCyJAAp4kqPvjAWD2Ig7uNcv0uZ1zesQOpSQqnqYJmzTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpBvyfZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEF3C433C7;
	Wed, 24 Jan 2024 18:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706119965;
	bh=fy5ndU56bZ/p4JHI62d9ycEW3tZ+dtVRsUrjEUAhStE=;
	h=From:Subject:Date:To:Cc:From;
	b=QpBvyfZCZK0EtLFqIBmun52SdVFAtzeugzbD5yj6NMWy9kUtn6Cn7AWVHksQX0f78
	 0TAhNhjkcM2sulQbltL9qXMWRCeGJQ4myceBbJjPJ33ViOK2LzK2yWrbK2InEyxAqU
	 eJFuHeXxzi5HKR1QpbTzyNSRfmI/kzzhEvyfMnzGZmooQ7fBoSMa8ja430IKfb8eYC
	 H7AbJHqnbZfbJ8nytHNlHVNYysYz+85F69dh23x235DQanrhFYjO8SXwac2TgihkCG
	 +b/AKu3CtB9JgRTNhcMCWEuG4bOSEqF7PnoWJQlmy3g0QW90dcOOJhVBNOAGov7NNQ
	 Q2hHKdp8v0X/A==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/4] arm64/fp: Documentation cleanups and clarifications
Date: Wed, 24 Jan 2024 18:12:34 +0000
Message-Id: <20240124-arm64-sve-sme-doc-v2-0-fe3964fb3c19@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABJTsWUC/22NQQrCMBBFr1Jm7UgyJgFdeQ/pIk3HNmgbmUhQS
 u9uLC5dvgf//QUyS+QMp2YB4RJzTHMF2jUQRj8PjLGvDKTIKK0VepmcwVwY88TYp4BdcMRBe1L
 KQt09hK/xtTUvbeUx5meS93ZR9Nf+akR/akWjwkNvjsTGkrPd+cYy832fZIB2XdcPox/rTbMAA
 AA=
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, 
 Edmund Grimley-Evans <edmund.grimley-evans@arm.com>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=922; i=broonie@kernel.org;
 h=from:subject:message-id; bh=fy5ndU56bZ/p4JHI62d9ycEW3tZ+dtVRsUrjEUAhStE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlsVMXZ13fks7Sw8E8yVFAp1zpr9k3dJtnAudmKth8
 1yUY+h6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZbFTFwAKCRAk1otyXVSH0C+zB/
 4m05VOz1xpabiF4/njieBYjoBNTDhdnzHmHhjl1bSvcLearECyzSxPM4a1hBJURp7VlNhtP3ILeT9l
 ldEO+90nlASoqgn/srvWTpSo0nMUXyic3BPrPj1822sdlrOD7/Fy187WAnq35pAHJTu5LsgvOgKzHk
 9IPcMd9oBI+9CPPobqAq502USynPAlQFdzdzRsdIZDqanNP7fDfSIofOU06ZXwhkvBREyP7J0qPg2q
 DnFUye+7wQGCzIrTnV9J5HVse+qQnVDeoHo2XZhnPAmBGHq++AwIUfoKfgvlLhVYgKN/+Q3887WEzs
 hS1TkTgExGm27kvphbyuupnEIARHEX
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Edwin noticed some issues with the SVE and SME documentation which are
corrected by this series.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Explicitly say which prtcl() configures the vector length.
- Link to v1: https://lore.kernel.org/r/20240122-arm64-sve-sme-doc-v1-0-3d492e45265b@kernel.org

---
Mark Brown (4):
      arm64/sve: Remove bitrotted comment about syscall behaviour
      arm64/sme: Fix cut'n'paste in ABI document
      arm64/fp: Clarify effect of setting an unsupported system VL
      arm64/sme: Remove spurious 'is' in SME documentation

 Documentation/arch/arm64/sme.rst | 11 +++++------
 Documentation/arch/arm64/sve.rst | 10 ++--------
 2 files changed, 7 insertions(+), 14 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240110-arm64-sve-sme-doc-bc62ec1a2005

Best regards,
-- 
Mark Brown <broonie@kernel.org>


