Return-Path: <linux-kernel+bounces-127306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC00894970
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AADC1F2462D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2CE13FFC;
	Tue,  2 Apr 2024 02:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="puJD6xgT"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63B212E7F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 02:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712024901; cv=none; b=NyO4ljq20BDSNhMct+Yqn6u65qv/j5nPEyzO5/2zvaEQIvSF0R8mOS/85hDgH9BbaCjCbyGjm8cKcjPQ+6vLHAsMZX3E3H/myb82zNrAHQHJwPcn4xyK0COepwAhB8u9Cf5qcp4DF+Wkn2pXzM6GDCT9jmqkmcrSUFYCy9OZnM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712024901; c=relaxed/simple;
	bh=BcDyjWiD/PMhjv4jQzwRWrn1OjRV4u2EbxQczygQFH8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=E567R/bvmsxYYaDCcvF9e7YPZ09PbBbXYg4NRmZbaGWfJk80MM6deB/lJdusu877W3EIeAsnSvYAN7khEX3+zom+2i9QvSb9UIjjaEyyfBguMdmp1t9Hh+DMyQ9PhEC9ZfuM76y+xD7BsT6T2coUU11xx909FdU6188vqGBvXUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=puJD6xgT; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712024894; bh=3CG1unMDZakglFocFHQP6ra4WgoNtqCAnPS7VPdrMVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=puJD6xgTXA50nb0ENV/1nddMzt2VY0jrMDYlVG2NbjUffAEw92qnVuMhfqqfQ+Gm/
	 YM2mPrf8FDgRTvIInjXJW///UVODsknywD22gND5LnrePulprrNwXK51jK+xcMA1Hh
	 ir2giidIspdOSsamz1hFDGRxYeR5Yv2wP/f5EDe4=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id 3E83BC84; Tue, 02 Apr 2024 10:15:40 +0800
X-QQ-mid: xmsmtpt1712024140t5m2eypdc
Message-ID: <tencent_5E797A6E302C756D0494D4EAD2EEAACDB40A@qq.com>
X-QQ-XMAILINFO: NhpLzBn2I3XwSHfcxv1kEwSKIvyZhjEZWpctlG+FvsgQzA40g5+ys0250mMVkr
	 dQWuKOF9eRXRNIVlfUXyfJUM6AUAcKcksDN8R4gKkEyQaHZLXs2nQCK1u5pmvHCOR5MvSEe3gSCq
	 sEd7bPgebTReVDUtKCzr/oHzXoisp7j4vcFT1slZyrCL5jj6BsiyCPWUzyj4o6raboMcXH73W6KK
	 1llXIGly/jc30pyr1tdfGHvquCEzkeea3Zjdb1LppaFTpr3R3RhNRRZtX37yRyai78G78dmR7gpt
	 AClfRxkc2rGqGrlhdluQ2L2ctXQl2cXd2YaimWb+BmDEavnDbOfmRb0bU+WUwhBMHsHQyXT/nzZS
	 UtjlX4cy1v3ia8H7t50h+wjAkEu+W+fqrczLhV4INzHiPAvHoPVIQLJPcp9Re5LEq5+yjaw0MkTj
	 AjVicE++3lX8ggOg+oive+z5z41xF45+CyVXrM/PMTHPhbIKp8FB04CtELsqlNuHjuLOjSKSHllz
	 F0v8Xwz0bvshy2bvFHqRM17lXE6/Z1AfwByJaBlEleSTVWApIw/ik23OWKBEMZ9Nv0IRidf78sqd
	 AMZAhDCmug6PXIM+e9W78PPCKSoga9ZvRPZIssWzI0AZOnPobu0Bc7mIngqfc4eZDeehjx+Arc1O
	 LpjQc0hbkEBajlb7XCD11ASm1+Njd6goQ1F2uy9O4Wy+8lU+WrlSgVmJckgNXKXaTOhzQSSvdQFr
	 1pb+lPVeEOQs3DHXEjlEXjE9MM1KDLrFWGvWf1Y598tPmhPmx5jec06kTlC8xWykR5xRc7EtwOZd
	 stWc8DrHeJ/rV2JMS4TaRff2EHICsF4bAau2upvOyjiYEpX0g+2s8trBSi+/cW3Y++ueh+S8YQCi
	 Lai29VuUTu9p7B8fOoPhEYNyZWooHlZ8hTnQ+sBL3YIw6WrIF9Zo91CVGv735xj42cZi5ZsONk
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+956651316bb16496a837@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [gfs2?] KASAN: slab-use-after-free Write in gfs2_qd_dealloc (2)
Date: Tue,  2 Apr 2024 10:15:40 +0800
X-OQ-MSGID: <20240402021539.1724819-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000cf534906150d00c1@google.com>
References: <000000000000cf534906150d00c1@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uaf in gfs2_qd_dealloc

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 18737353cca0

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 572d58e86296..91103e0307ac 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1321,6 +1321,8 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 fail_delete_wq:
 	destroy_workqueue(sdp->sd_delete_wq);
 fail_free:
+	wait_event(sdp->sd_kill_wait,
+                atomic_read(&sdp->sd_quota_count) == 0);
 	free_sbd(sdp);
 	sb->s_fs_info = NULL;
 	return error;


