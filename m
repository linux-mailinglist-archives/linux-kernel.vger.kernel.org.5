Return-Path: <linux-kernel+bounces-39500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CF883D21C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D65BE1C25750
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CA767C54;
	Fri, 26 Jan 2024 01:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="mXwfb6q+"
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534F610E9
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 01:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706232934; cv=none; b=JXDgYIQ1/jIKdT+7httNVwxh+v1pZzn+q7Rn69YKxxV5vz+rGBnHTKeyEqWKj3TU9b7ZpR13BVxO6uutx5ZDIb50kCG2hlomG8yk7uLkqnMeg8p479YYkE1A5WV8Mm/Pp4ktFlc4+i1jSJj4RK1elpC2CDn+vpqbQYCeYdwNeBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706232934; c=relaxed/simple;
	bh=eMrqXNx6HDQwJl63Sm3B7g46lltXLvepuUnMNytLcN8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ePcR0+3Y2BPBuk1EOr0xnqcrFqpvsU0V1qM4k+/DVmxsTqfJS2Hpbp4lsXLplQLe6BffaOyDFh4ffAjif29lOw4g3gXc1lUwYJhzzbE/CUds9ytMxfS1mTCav2DPJoQvBRYcVIC3xVvvD6TIbjmlZvluMGqjumQl0dRt/c2/vlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=mXwfb6q+; arc=none smtp.client-ip=203.205.221.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1706232922; bh=RdZnkvvfCYW/pYfuZWmjNKebaw5GRZSG1/MnI6u10Ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mXwfb6q+F2dDJ7nq6wX3pkSxn2OTFo5ZI8LURIYsr4X+/Ff394DIHVu7yb6/cci+2
	 b7G74tzuXJPhspyYvZrGOQ98vpNjb8eacnpFTYWucB9H4bAsIUQNPm0qVu5hB2IP0F
	 Yqx8HU6Jq8B+6iOyDGnbgo3l1aSwTc8Pz3Y7b1dI=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id 8D4A56A7; Fri, 26 Jan 2024 09:35:20 +0800
X-QQ-mid: xmsmtpt1706232920tmbh4jfdj
Message-ID: <tencent_613652973C377A4AEC7507777B66C63C8309@qq.com>
X-QQ-XMAILINFO: NshvC2+mlzw33wOMqgLcV0WIwGQRMPtEvMxueURkvbJ4cctfh94aUrKyHpkaFO
	 wWoLKuxaU/oxvfxAaNJRWzFR9iUEyz3u/o2cl/K3FVithOrmLCttSyti1rPaVLqHjTiNINZffwii
	 3XJ4t/oB5I3VvohQ+OafoI89bgQOeIDknrHo+eSSe1jVDpn90gulP4Hk/ai7GN/LDzqoL8XmwjVp
	 PtnpptrnjeLCe/XzjNuDVxCWutcfCOpCVbs3P71lTv5Jl7dDRncKOkvL0OMFnMVGdVDsksya8HSg
	 gBQC3TCIMXSelF0wyZVT3tJDwlUuCm5b8QBD8KdT9HrMm0uw4ALZwC2nle1si22k2uAQxkuoQ4YM
	 /4jIueKvhb3pJb9bsKyryubvg/9DYzbxiMGhvl0q8NNSQCLqkXRmFQksHg6/NZi6Ec3TOFLwvPDS
	 DZPQvCAnpWsgwAhyJSuFn1DS5lx1K3FtLwTwEM2LuqvDhpakvgUXXq8EDFZgjY6abxuhhNg1rLYh
	 m33DBhdiI10NZi/3qLKhs29v90pvPK3fmOYLrBZd+4M5rfmMxUKwHnQcchvrovjK4zXY+K5uaLdk
	 l3vKcYnqM1g80qf8oLGUzXukntd/qowdD+ykwvMyVEr5mPyWSnhDLPZ7mCHjRo/2eh8pXSsiNCG4
	 ijMqTq3qWLma8dh/rJXFPfJ/2R3o6Nv5wsOmiXwCx9XpdxQYGt7cp4YyRjolHzThmUS7Lt1msH2C
	 pqCI4oPbFtWnzBhHbrp825FpsQirbiGjOSa0JAo/MmtzQ0OKDWUeCoDLpKGNAiugKmQmY+Gd4PKl
	 MM2FGwLmwTj6t8+Oc8d9PLNwUXwd3vPuSdRq4D2lfDXD1If2YTx8P3WWHSKvzpfgJNA6zzvJO0LV
	 XT2yMSZJ7aJMXKrG8kY98P+63wdaYt3vHcDs4/RRSUSrGBFGps7Efep/MmD9aED7nuqMvTFudVDs
	 YRZlqXA6tsfeeeaTTNFc+fzeFKQxNu1Mc/wzgVKvM=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+d7521c1e3841ed075a42@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [virtualization?] KMSAN: uninit-value in virtqueue_add (4)
Date: Fri, 26 Jan 2024 09:35:21 +0800
X-OQ-MSGID: <20240126013520.2837161-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000fd588e060de27ef4@google.com>
References: <000000000000fd588e060de27ef4@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uninit-value in virtqueue_add (4)

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git fbafc3e621c3

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 9d1bdcdc1331..4ca6627a7459 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -427,7 +427,7 @@ static int __virtscsi_add_cmd(struct virtqueue *vq,
 			    size_t req_size, size_t resp_size)
 {
 	struct scsi_cmnd *sc = cmd->sc;
-	struct scatterlist *sgs[6], req, resp;
+	struct scatterlist *sgs[6], req = {}, resp = {};
 	struct sg_table *out, *in;
 	unsigned out_num = 0, in_num = 0;
 


