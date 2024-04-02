Return-Path: <linux-kernel+bounces-127842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6A289519D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D1BD1C2345C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D30664CF9;
	Tue,  2 Apr 2024 11:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="2D060gjv"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0570C627FC;
	Tue,  2 Apr 2024 11:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712056640; cv=none; b=YU5NmI+9zoJgY+k2uUXV+6yWAkl5VvORUm4ZNC9FLPz9Qh7duM245Kexjra3TSWI/l6ZDlPhLWffE11d6bhEIdktTQkTOYLV7LS5FwfDDI+91Kp+jiLuv9m5TsK0u0CM53R+ik874mMtsCmA7OrjLMGanhN4xNIC3s3qzUy4XwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712056640; c=relaxed/simple;
	bh=3p55CVrq9iuOG18GVfPuvJM+1XznpjhKC1MOFnxHBco=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ox/4HIImMobpDTWSjmcH+1HhfaSHi3SbA1s2q7xttT+AsEhjHu/u0kFIyQsBIN83CcydX7YBe5VEPCbHYA/bwssRTQBzft3WELS7BZ9VHRZlb55UhG9F0038UQvXW0OSBa2Ci/sXhDX6M2j01ImF9vATSQZCWaGJhAHdsMjCKqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=2D060gjv; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rrc8c-003kp9-2C;
	Tue, 02 Apr 2024 13:17:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9MRqTZ5hji8Z4mdkDWZpaDS9fQ1NAcdQnKFC5GgJSMk=; b=2D060gjvyytlYEzcptGZF4jdhp
	lTTTPssfZGO5HNXgULHUz8gfq43BQXCY4KbDZyldTf4koDAbTdfTfhnbjfeNbO09UACdgNCBb3c7Y
	Nv2llr8tqzmOR97wYY+yIsjG/xNIcq9dF9COHs9wba0BfbjBNi+AX2kC8ex08ODknXQvs3+HYSMok
	gk0cLDCQ6PtPKbPHaD1SvE89R+Ghs+FAStwQepfKaRG4RiohzFriS+shYS2ZxiI6hZV0+6PRftGD6
	VisRFDbZUsNNC23zDwwFm/dzaPh8OEXLYU+5Glens0hekwaMQjIUGP1ADc+3boEUABh1WhxAlWTC1
	Q46DuIng==;
Received: from p2003010777026a001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7702:6a00:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rrc8b-000IAF-15;
	Tue, 02 Apr 2024 13:17:09 +0200
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rrc8b-0024W8-00;
	Tue, 02 Apr 2024 13:17:09 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: lee@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	mazziesaccount@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v3 0/2] mfd: rohm-bd71828: Add power off
Date: Tue,  2 Apr 2024 13:16:58 +0200
Message-Id: <20240402111700.494004-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add power off functionality. Marked as RFC because of magic numbers
without a good source and strange delays. The only information source is
a vendor kernel.

Changes in v3:
- define for poweroff bit
- rmw operation to set only that bit

Changes in v2:
- style corrections
- remove unnecessary writes and delays
- correctly unregister handler

Andreas Kemnade (2):
  dt-bindings: mfd: Add ROHM BD71828 system-power-controller property
  mfd: rohm-bd71828: Add power off functionality

 .../bindings/mfd/rohm,bd71828-pmic.yaml       |  2 ++
 drivers/mfd/rohm-bd71828.c                    | 36 ++++++++++++++++++-
 include/linux/mfd/rohm-bd71828.h              |  3 ++
 3 files changed, 40 insertions(+), 1 deletion(-)

-- 
2.39.2


