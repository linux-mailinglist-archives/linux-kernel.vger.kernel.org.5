Return-Path: <linux-kernel+bounces-162907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 816B38B61ED
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 227431F248E3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71B513B5B5;
	Mon, 29 Apr 2024 19:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="UwohD1fc";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="UwohD1fc"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EAB13AA3B;
	Mon, 29 Apr 2024 19:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714418415; cv=none; b=kI3P9Gf1IfEKAizhZFDRnlTFp5Uql2l0wwR0UjjP4m7IWtacvTpiodAwJb4Z1JWnbZkuI22fdBTUr7Lqw0pCI3+eTiEgezO2t81YbCF7eCipAl9+3R4bvFM5GepLQEA8SBfLBHOGXJ9NLqeIc/hZton9iE/1hqTHj/2PaRjHS2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714418415; c=relaxed/simple;
	bh=xexf8TmIz8amBZcDRUsUdrq6y5hbq/90WNiHb4InD2w=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=HQ2co7j49uzGSA94Q5Dx/KaTQsIV5Qx6hNMT8+jh9zFi8+282kPejW+EyyAABG91k3GGLrjvKHarr2GO6z8/AerGtvCzRyEAIjzMn23KMd0zNSE44tIrp/CkS8BF91QJKdPxK6I6/RQlLy1btUDRTdQg1KJMEjI5z/+nfFbAbeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=UwohD1fc; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=UwohD1fc; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1714418412;
	bh=xexf8TmIz8amBZcDRUsUdrq6y5hbq/90WNiHb4InD2w=;
	h=Message-ID:Subject:From:To:Date:From;
	b=UwohD1fctUw78cKYTpyRHNLcWHgMErGXHxsRfknqXR7CoogyqqgOJI2o3lcH9S2pP
	 tEbKTBRgNqqoLDFP44oiTpRijS1z7hPu2T2lXu+lVaBNKpHxOIXzgbJjeNwBItMqGu
	 ww7Vx1vW3EOR/fqOK9egHaBkP6xtiyAinIC7yDgk=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 8E9C8128167C;
	Mon, 29 Apr 2024 15:20:12 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id KOa4eJ2Jzaar; Mon, 29 Apr 2024 15:20:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1714418412;
	bh=xexf8TmIz8amBZcDRUsUdrq6y5hbq/90WNiHb4InD2w=;
	h=Message-ID:Subject:From:To:Date:From;
	b=UwohD1fctUw78cKYTpyRHNLcWHgMErGXHxsRfknqXR7CoogyqqgOJI2o3lcH9S2pP
	 tEbKTBRgNqqoLDFP44oiTpRijS1z7hPu2T2lXu+lVaBNKpHxOIXzgbJjeNwBItMqGu
	 ww7Vx1vW3EOR/fqOK9egHaBkP6xtiyAinIC7yDgk=
Received: from [IPv6:2601:5c4:4302:c21::a774] (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id D035D128164D;
	Mon, 29 Apr 2024 15:20:11 -0400 (EDT)
Message-ID: <1bbda065d2089acaca9ab88a3938234a60e780f1.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.9-rc6
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds
	 <torvalds@linux-foundation.org>
Cc: linux-scsi <linux-scsi@vger.kernel.org>, linux-kernel
	 <linux-kernel@vger.kernel.org>
Date: Mon, 29 Apr 2024 15:20:10 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Minor core fix to prevent the sd driver printing the stream count every
time we rescan and instead print only if it's changed

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

John Garry (1):
      scsi: sd: Only print updates to permanent stream count

And the diffstat:

 drivers/scsi/sd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

With full diff below.

James

---

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 58fdf679341d..65cdc8b77e35 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3120,6 +3120,7 @@ static void sd_read_io_hints(struct scsi_disk *sdkp, unsigned char *buffer)
 {
 	struct scsi_device *sdp = sdkp->device;
 	const struct scsi_io_group_descriptor *desc, *start, *end;
+	u16 permanent_stream_count_old;
 	struct scsi_sense_hdr sshdr;
 	struct scsi_mode_data data;
 	int res;
@@ -3140,12 +3141,13 @@ static void sd_read_io_hints(struct scsi_disk *sdkp, unsigned char *buffer)
 	for (desc = start; desc < end; desc++)
 		if (!desc->st_enble || !sd_is_perm_stream(sdkp, desc - start))
 			break;
+	permanent_stream_count_old = sdkp->permanent_stream_count;
 	sdkp->permanent_stream_count = desc - start;
 	if (sdkp->rscs && sdkp->permanent_stream_count < 2)
 		sd_printk(KERN_INFO, sdkp,
 			  "Unexpected: RSCS has been set and the permanent stream count is %u\n",
 			  sdkp->permanent_stream_count);
-	else if (sdkp->permanent_stream_count)
+	else if (sdkp->permanent_stream_count != permanent_stream_count_old)
 		sd_printk(KERN_INFO, sdkp, "permanent stream count = %d\n",
 			  sdkp->permanent_stream_count);
 }


