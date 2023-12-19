Return-Path: <linux-kernel+bounces-5367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E608189EE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F13F1F28285
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE49328BE;
	Tue, 19 Dec 2023 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xn0rHfUW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E422D7A4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 14:26:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2435C433C7;
	Tue, 19 Dec 2023 14:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702996006;
	bh=/vfAfNsoNNWZCT7m/ZTfcYEDIuGqfyE3dGzkrpGY9DU=;
	h=From:To:Cc:Subject:Date:From;
	b=xn0rHfUW9SOb7qTYr2hseSnUS876mCIcHkt1Vaa1DTYW4YpMDe7EKXGr2ID36S014
	 uBmU5VfDVxqeTaujoNJD4O9r1G+DxEBNrtajylBElB1bzJK8pFaRVAP2hFEeZJxVET
	 fEXmSXeSkI+Z8lR/U6tj4sj+VX2fUS1kjwQxcnsw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: kabel@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/2] moxtet: remove unused moxtet_type declaration
Date: Tue, 19 Dec 2023 15:26:38 +0100
Message-ID: <2023121937-pants-heroics-17c1@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Lines: 26
X-Developer-Signature: v=1; a=openpgp-sha256; l=818; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=/vfAfNsoNNWZCT7m/ZTfcYEDIuGqfyE3dGzkrpGY9DU=; b=owGbwMvMwCRo6H6F97bub03G02pJDKmNK2Tnqbqn1qTvnRi7zfHPUcvpSpeilQqY3kyzanEVb b2bf/FWRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAExkdzvDPDsha3Hxz2K7o5uC 3Tap8IuuW3jiOcOCZYcPif3VP33186wPUc2f1G4rv5o/BwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

For some reason, moxtet_type was defined in moxtet.h, but never actually
used.  Looks like a left-over from the original commit that was
exporting the moxtet bus type, but that wasn't needed, and it was a
different variable name, so no one noticed this one dangling around.

Cc: "Marek Behún" <kabel@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/moxtet.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/moxtet.h b/include/linux/moxtet.h
index 79184948fab4..ac577699edfd 100644
--- a/include/linux/moxtet.h
+++ b/include/linux/moxtet.h
@@ -35,8 +35,6 @@ enum turris_mox_module_id {
 
 #define MOXTET_NIRQS	16
 
-extern struct bus_type moxtet_type;
-
 struct moxtet {
 	struct device			*dev;
 	struct mutex			lock;
-- 
2.43.0


