Return-Path: <linux-kernel+bounces-67199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC238567F0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF3911F2E146
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C70133995;
	Thu, 15 Feb 2024 15:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=okanakyuz.com header.i=@okanakyuz.com header.b="ZI5tZ5+F"
Received: from quail.birch.relay.mailchannels.net (quail.birch.relay.mailchannels.net [23.83.209.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA268133288
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 15:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.151
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011351; cv=pass; b=aGhekCXnUBEBk18HM9qeiVf4WmxN5Ppu2z82Dgzc6xiJnX8YX0aokGF6wU/qZ51YSY9P2bpgsL6UDAlm7HlOcQrQlGKmpfBA36hXH5ULnZeki7ImiGM2k+qDu2GwFPd9hNfPg5nuINS9kiOXKKcHLTKYRsPXY3nkALg9zNIDgV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011351; c=relaxed/simple;
	bh=+4O3D4o5CsfHbruLVlheO0dIe4wiYNfrvNQ9FVYTaoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hVvo1l/P9h/TGWKYx766opqnRumnm+nRrYM4gKYiD+QtfeetUFOCBzOeNHdmX2YTMLmP9CoenySUpPMjc4rxl/GGbzlqRiwio/AIbF+MpqF9UyfRrQG0ngXMxmub/S86pFYtMhR2fdCysHOHO/mSX5CWc++dCQV/TN8ZF3RT17U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=okanakyuz.com; spf=none smtp.mailfrom=okanakyuz.com; dkim=pass (2048-bit key) header.d=okanakyuz.com header.i=@okanakyuz.com header.b=ZI5tZ5+F; arc=pass smtp.client-ip=23.83.209.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=okanakyuz.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=okanakyuz.com
X-Sender-Id: hostingeremail|x-authuser|okanakyuz@okanakyuz.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 1144C843C5C
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 15:29:25 +0000 (UTC)
Received: from uk-fast-smtpout2.hostinger.io (unknown [127.0.0.6])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 51885843A96
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 15:29:24 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1708010964; a=rsa-sha256;
	cv=none;
	b=67y1Q3QqUG66cVnUj1n8UeLz3KwahaGzJFS6mN0gROR3jrWkRiUnvQGAVybHD/btF7zhK0
	OJ6owRWTla0TSmN5u7VV7wfg//j4oTJSAswTZO7yAltN8d7RnpDKI7Mx0yaCKKNFH0c+en
	wkuq4d2FM+o8BVPsV1rstmSa+dPxQBArtcknqhSYcwRFNRGxi6OrrCstmKn3C01Wp+qV2g
	Y/7kBwwG9WjbV0oB/vudFTJllMITDc+m/lKP8F9L4AWPVl3cDHnRQcfAOc/9YCS8ihcK9Q
	eVQ15/UDlMVecmRCaHiHQDl38k7uyVbqTsxr5DUmSq2tCrRcuPC9h/GGyLOO2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1708010964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=cbX2TFeKmQIH09gm5LYQHKCMm5YzJk5x0VxemUSMmNU=;
	b=5TEn/ssRXw3vSYsobv3Xapycx62Z75055/c2oY3L5AsXp19n/bW34Mj96WGpDxujOOgKlq
	7yQM76znlFDq6PsFCnbnAC+wDDOTTn8vO7D8YMlVuSL2dW8zloBu463dZwwPhM7FZ9klt9
	f2TopggpMxXaW6vtEt38HKfmq8fjeVJWHF9aIfE2c9l8Xior7jn3hea1aXP5fxVLVOcbcx
	/h3260rzbb/Uk/d0MmOqiBRj4wQHh/e/h2Q0081baf/FgyRTlnekv6f0tactgR0SMaQ8hG
	DViL0HMJxN1CeKzFRPxLJ0c4aQs7bliCrPyzpPp7yE/zMwDdDyWyI/UiAWrkhg==
ARC-Authentication-Results: i=1;
	rspamd-6bdc45795d-9xwmf;
	auth=pass smtp.auth=hostingeremail smtp.mailfrom=okanakyuz@okanakyuz.com
X-Sender-Id: hostingeremail|x-authuser|okanakyuz@okanakyuz.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostingeremail|x-authuser|okanakyuz@okanakyuz.com
X-MailChannels-Auth-Id: hostingeremail
X-Tank-Whimsical: 5eb6e1fe4553a7d6_1708010964876_3788297568
X-MC-Loop-Signature: 1708010964876:4085679989
X-MC-Ingress-Time: 1708010964876
Received: from uk-fast-smtpout2.hostinger.io (uk-fast-smtpout2.hostinger.io
 [31.220.23.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.119.153.75 (trex/6.9.2);
	Thu, 15 Feb 2024 15:29:24 +0000
From: Okan Akyuz <okanakyuz@okanakyuz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=okanakyuz.com;
	s=hostingermail-a; t=1708010962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cbX2TFeKmQIH09gm5LYQHKCMm5YzJk5x0VxemUSMmNU=;
	b=ZI5tZ5+FAniwcDdqXIV+E1OcmYk+pNteOtrqb7CrD/3jH70hAvQGOk8HWEBGoUpx+AzDSW
	t5rxiA0Uewd6B0lxilNIN0DDIS842Ea1RwyEEhz1Jlokf8I5MxTiQ+PeWEw1sEcspCK44H
	IPGoLVI8KZYprahKaPoyUEpQPARxX2zFoxANOBFf0d/5OmsEOEmetQ3NqOstl/HdU4Q/HR
	t2s3caEKs9o6Rwkohu8/KSX5mmY5E9tV7Uf8zmMm2KP32yIaLR/6pQCU1eVrUoRtZIkxI+
	qv05TCcKiVsA3Ja/I4PS50fugC5z+91mKMol9pFl7778HbT1btIGxwWD6GSRgQ==
To: jdelvare@suse.com,
	linux@roeck-us.net,
	corbet@lwn.net
Cc: linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	okanakyuz@okanakyuz.com
Subject: [PATCH] The datasheet URL has been changed.
Date: Thu, 15 Feb 2024 18:19:57 +0300
Message-ID: <20240215151957.20855-1-okanakyuz@okanakyuz.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-Envelope: MS4xfELWMjXxd9QwZl2hd/DXq0dhbDsJyXzaJU1n2KAVlPPQQWWAaX4bocHs95nVwUzgkes8cSg6c3/XcyXMdZ9Ssxin/55zpWCdg+I7z41lRicNDzc99Uq3 3W0vvCsyii0gCRm7ZSp+xmVg9RNmg7CIh5E9JS0MZodQ4iW9EVXPUeZoEImWpArh64clFdpdvy0ueMiZlFLy5jj4MDCCSXSmUuGRUijxUv+rm/+3yd2a0ZJ8 Ha1SDJxk/KVBEiLAArZU+zzIUrOPk1SbXA3v2dOat5VEx0V8GFv52hlbwY6BLVddBzzMqBEaVUHI3AfzOvin/of//dE/I5wp5/RGeku8Uj74ewwjmVOrdAiP Dy+AvZBDHNrgZRRt34622uWpjltK3K1aUC3hOUEAOvi+Qg1byN+Y2v/2OiJfYkz65xnnQiQkC2rgDLK1KtZtDB9ADHrnJA==
X-CM-Analysis: v=2.4 cv=Rp/DLjmK c=1 sm=1 tr=0 ts=65ce2dd2 a=geHYaF3j5ifCImHjKwHHfg==:117 a=geHYaF3j5ifCImHjKwHHfg==:17 a=-tA9vPf7AAAA:8 a=UXzzSC1OAAAA:8 a=gAnH3GRIAAAA:8 a=2_2egfEcOiK7PuE5XgAA:9 a=vtdtr2SZiqPAgdHKmkdM:22 a=NXyddzfXndtU_1loVILY:22 a=oVHKYsEdi7-vN-J5QA_j:22
X-AuthUser: okanakyuz@okanakyuz.com

The URL for the datasheet was not functional. It has been replaced
with the active one from the manufacturer's website.

Signed-off-by: Okan Akyuz <okanakyuz@okanakyuz.com>
---
 Documentation/hwmon/max6620.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/hwmon/max6620.rst b/Documentation/hwmon/max6620.rst
index 84c1c44d3de4..d70173bf0242 100644
--- a/Documentation/hwmon/max6620.rst
+++ b/Documentation/hwmon/max6620.rst
@@ -11,7 +11,7 @@ Supported chips:
 
     Addresses scanned: none
 
-    Datasheet: http://pdfserv.maxim-ic.com/en/ds/MAX6620.pdf
+    Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/max6620.pdf
 
 Authors:
     - L\. Grunenberg <contact@lgrunenberg.de>
-- 
2.43.0


