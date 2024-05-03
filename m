Return-Path: <linux-kernel+bounces-167513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 926D98BAAA3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64AAAB217BF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F30415099A;
	Fri,  3 May 2024 10:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DA3+D+AX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDB814F9E3;
	Fri,  3 May 2024 10:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714731553; cv=none; b=aE7ulha3Ha0r4bc/iI37/5xo0dToV/8xEpv2CfaB0SLpfxmu4uEcQlpifg0e9yf9k1VyiVJ+xt2UXnqZdivmpPUijwxCnaULGf2yuswpPPDQBKkrqtd605LPVCwFd2BKRa1VX6uiY//EWERxuwmSHyki//K4QK+9yjtBmZezA6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714731553; c=relaxed/simple;
	bh=w6EbXMLbZy+Iq3jqd1Fpizg4P9aa3UkGFXgdsxOAiOE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Afc21NHHB2wb0FJ/JDm0jKI1oU/4r7VNe/EkMb8gxYJFAGCJUdWnMSWlBW20AviIu+QOIYUauAa1lV5+n/5QSOzGfYpNwEz4PnZ7fX0RsA4oikgmH7mhjeDZ1Wcq4yX9JPfVsMSi7T+Yvp8zneJbF3aZdobmC/q8mJPHIrXt4+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DA3+D+AX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD506C116B1;
	Fri,  3 May 2024 10:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714731552;
	bh=w6EbXMLbZy+Iq3jqd1Fpizg4P9aa3UkGFXgdsxOAiOE=;
	h=From:To:Cc:Subject:Date:From;
	b=DA3+D+AXpjojEMciQeTe1i220pdfpQ2s1jKP7ixvlbzkYFvSXkQvoPyPp0SVVAZkg
	 grs9jC0mqBlOKno9ibb889SH+1MH88nYrYntgKf/2isFppzu5+zWc8IoseCy4udfio
	 2AEWS5a1gGu23Ir4M0vUDkFSaoV6b88EehNn2qraBQluFSugljkD+CxvZeMCuVp3Cb
	 1aAZsA3YFnCV2R9BHPlABwcGuQgui1+Kp29Wze9wUxoLBOrwaycnB+taHiJFVYZBnv
	 WxEy3GHXWCUPytWLRC5lqdF4h9VrtyunwF8vLdoMQkPKOeKHaKOIe91PhG1hNNjwHc
	 meRsB9t7qUz8Q==
From: Georgi Djakov <djakov@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	djakov@kernel.org
Subject: [GIT PULL] interconnect changes for 6.10
Date: Fri,  3 May 2024 13:19:01 +0300
Message-Id: <20240503101901.1681356-1-djakov@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Greg,

This is the pull request with interconnect changes for the v6.10-rc1 merge
window. It contains tiny clean-up and fix. As always, the summary is
in the signed tag.

The patches have been in linux-next for more than a week with no reported
issues. Please pull into char-misc-next when possible.

Thanks,
Georgi

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.10-rc1

for you to fetch changes up to 230d05b1179f6ce6f8dc8a2b99eba92799ac22d7:

  interconnect: qcom: qcm2290: Fix mas_snoc_bimc QoS port assignment (2024-04-11 20:46:26 +0300)

----------------------------------------------------------------
interconnect changes for 6.10

This pull request contains the interconnect changes for the 6.10-rc1 merge
window. It contains some small driver changes listed below:

Driver changes:
- Cleanup sm6115 QoS port numbering.
- Fix incorrect port value in qcm2290 driver.

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Konrad Dybcio (2):
      interconnect: qcom: sm6115: Unspaghettify SNoC QoS port numbering
      interconnect: qcom: qcm2290: Fix mas_snoc_bimc QoS port assignment

 drivers/interconnect/qcom/qcm2290.c |  2 +-
 drivers/interconnect/qcom/sm6115.c  | 33 ++++----
 2 files changed, 19 insertions(+), 16 deletions(-)

