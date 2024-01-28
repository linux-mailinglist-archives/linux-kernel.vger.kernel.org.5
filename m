Return-Path: <linux-kernel+bounces-41870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA2183F905
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 19:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 511CF1F20582
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58B23C06A;
	Sun, 28 Jan 2024 18:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="HjfMgtol"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7086833CF1;
	Sun, 28 Jan 2024 18:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706465188; cv=none; b=EfvRqi1Hu7pu075WPjafocbkE5Rs2Uz7mOcRYKwWHJbviRZDul5+9C5UTsAxTh7XDGllegECgJ+x0XYpRR5ZdbkK1WvvUUE3b5nQyI6B1BUkHQCkjondQGGEdyzBYf0n3HypjLqHrIH1vWUaKhJQxqKwar8r3of/b5IwK4QkPSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706465188; c=relaxed/simple;
	bh=xeJpHy5p3TX6HUTpy0hNf1X9TiuUySjV1G3KdJuEz+Y=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mvyMgxCqy8P9QQRtFYR06IBR0bynJSZBU22UwugTa66zw1S762n3bEiS9V3CQzT5D2Io7viClC8LbvrPkhYRURRc5oQq3dgTMEspDBccFBYNrD8CDkaSpJzKNrDLcnqwA5jalEPy9HrfVcxDdEM45+KPSSkDKvj7zk2XLLjt1qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=HjfMgtol; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uy766eRmu4f/14ST1SkrTm7XvdpFq6LpMkMB0sq2fWw=; b=HjfMgtolvJlys2ez29qkSflDmd
	ccHmjqp2JJgP++WDwMdNUxiEh74O3ZxEdBXCSB2lK9XqVOHfJZypmVaeJbzvy3vHgGa5d6glhUIcq
	+rSPqwoTKiWZblDBd5b/GIn89zSGl0RSWYxJe3S7eR4RmSErUio3sPYUOTx5mkfyrdBxix5OucT4I
	AL54Qd3E3G0az2w09lbmLvNaspm55hltm5h76WHQSw05fhLPD5cFpNp67uh704JG4z8em3du9ByXM
	95jFh4QNEuGvO9ABfeb2sXZ6WVLso9M4vayXL3BW8/S3eYTqc4taROSrUjQxFvHxMcjS1B5FdrVhC
	1NXTPAnA==;
Received: from p200300c2070939001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:c2:709:3900:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andreas@kemnade.info>)
	id 1rU92b-008qDa-Us; Sun, 28 Jan 2024 18:33:57 +0100
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rU92b-00BO9h-0t;
	Sun, 28 Jan 2024 18:33:57 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	johan@kernel.org,
	jirislaby@kernel.org,
	andreas@kemnade.info,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	Adam Ford <aford173@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	tomi.valkeinen@ideasonboard.com,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@gmail.com>,
	robh@kernel.org,
	hns@goldelico.com
Subject: [RFC PATCH v2 1/3] gnss: Add AI2 protocol used by some TI combo chips.
Date: Sun, 28 Jan 2024 18:33:50 +0100
Message-Id: <20240128173352.2714442-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240128173352.2714442-1-andreas@kemnade.info>
References: <20240128173352.2714442-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Texas Instruments uses something called Air Independent Interface (AI2) for
their WLAN/BT/GPS combo chips.
No public documentation is available, but allow that protocol to be
specified.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/gnss/core.c  | 1 +
 include/linux/gnss.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gnss/core.c b/drivers/gnss/core.c
index 48f2ee0f78c4d..cac9f45aec4b2 100644
--- a/drivers/gnss/core.c
+++ b/drivers/gnss/core.c
@@ -335,6 +335,7 @@ static const char * const gnss_type_names[GNSS_TYPE_COUNT] = {
 	[GNSS_TYPE_SIRF]	= "SiRF",
 	[GNSS_TYPE_UBX]		= "UBX",
 	[GNSS_TYPE_MTK]		= "MTK",
+	[GNSS_TYPE_AI2]		= "AI2",
 };
 
 static const char *gnss_type_name(const struct gnss_device *gdev)
diff --git a/include/linux/gnss.h b/include/linux/gnss.h
index 36968a0f33e8d..16b565dab83ea 100644
--- a/include/linux/gnss.h
+++ b/include/linux/gnss.h
@@ -23,6 +23,7 @@ enum gnss_type {
 	GNSS_TYPE_SIRF,
 	GNSS_TYPE_UBX,
 	GNSS_TYPE_MTK,
+	GNSS_TYPE_AI2,
 
 	GNSS_TYPE_COUNT
 };
-- 
2.39.2


