Return-Path: <linux-kernel+bounces-135261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D393189BE0E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62CDC282BD1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE24657B6;
	Mon,  8 Apr 2024 11:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="d9Cz5HFy"
Received: from out203-205-251-59.mail.qq.com (out203-205-251-59.mail.qq.com [203.205.251.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78805524DE
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 11:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712575382; cv=none; b=LM1O4s4TlfBNlUDiVCzDpPj1XXIMOIVFZmW+ECIEghUn8lT1wtcfLju+sdEt40DZnLV9c+vhOu3NIsRmSDlG0sRX7gkJYVtDtnpUWAc1sBPBzmMEG6z1iPNAWJLRJRRHmctO3XVIJqZKE6XrLfJntReUjylyt25gkBcI/2OUEQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712575382; c=relaxed/simple;
	bh=XhqTmTMe18T6k+62nzT1yDwjlXkJi47c+0NJqPcL7cA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=qutKFQwt/m7oF6z04moajBERGruNtusIFvCoHXqsN8wdb3cb9rxHz74SsvDveqpndKuU3Chj6inOYf10Gmj1EQRPj9oMgUoT456g9lRCId1r3LvY/p7cSPj8NzXHILfAvL2Tur4uJHe2QWod3BHDiIQB2kMlXBBIUtQpfI1P++s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=d9Cz5HFy; arc=none smtp.client-ip=203.205.251.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712575071; bh=IN0PPZfitbW7SvARXHrN9jP/IWMkw2Od0a/16l8uoxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d9Cz5HFyMa3bfHerdHOKB+/u8a9ROZg+v65R1Ah+qBh17zy9df1pDP0HTc5CIrHEH
	 CXcmS19HuYgBL0X1Y1tlSoMnPifZ5ldbqhw6Gd50NPZq0nvhDFUIigz2ETvTl+320B
	 wLodJHx/09xCiWShSV4OL7lIR8gXb4YCYqfrKMEU=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id 4718FE4A; Mon, 08 Apr 2024 19:17:49 +0800
X-QQ-mid: xmsmtpt1712575069thrfk93hs
Message-ID: <tencent_7C336C9E5A1B9C4B9F1B7C251BBA77BB4008@qq.com>
X-QQ-XMAILINFO: MPEorwW6cFo9f+ohww/ti2qvfbDyw8Fhy6Vi73WGjkRV3AM54ABgu60WO2/irK
	 FW87jxRM980OUEYhw3o4GtxZrbIKeGV2/Y6xETaL3XyOd4ikGys6+pAQvjFW+qwEq7dwZzYk+9Hc
	 9ow7ThDefuo9EdlTk17i7WiRAzljacJWW30peRuM47VkFAmk1I3q0LmTrU9EgsYDufNDzqkhM72u
	 4zWP+Z4kSM7JAwgEk0MZAnylGLOMWUKm7F5Y1IDEdI4McPBUCijPE15RBlflewvmo4++x95aNohD
	 SgiPDA++rIrboDmIqCBXm0GYJUv+f6AZvk+A8PZW8NnHu7mBJHx+n5UzGF7QuR6lm+8Xeu/c6Ajt
	 4sFcJPRfkWvZJTXnCvVZXEf3vkXUeudKKFHLh3GAwNTzvLMP2COhlE/p27qqBVDgQwc7CzCIhzef
	 Xus4vXBAjSQHE0QLcF8J/vaytQI31w5gWSLajYen5thDb8qWmjiAJjwvWhGvXmfJsn338NfrpSFT
	 aGM5zybH+iUVVfE4vkFQfsg6n9w7DTFJ0PZs2swv3rBiF3ShLBO5oINUhPI8g3wIuzlGhLwXEORr
	 LDmu3QMWqN6koyNQ155gV6n40OTS42HcYu0BUOmL23vC5Od0zCzN8CpzGzdMeyudvdBVE6m15kaR
	 RLmlpvT329jXDtZbKZxQ3A4kOkIshH7sjqeEyqMRu5PpCh49SsPBW2eSDVbgN3vr0UJcdNocyJ5W
	 Vziw08BKEs66oBhPltnHfeTJBnUKEdzsNKO+ghvhl98yv3kRgwySm1qC9lI63Cz+ENyEEJr5oMI4
	 a0xYvK0V0s8sN7gMLTSZZzpG3s+rbyGubPm6JcofFz6Tg4kTdgAE/e8oFNeVun1yOatMfWkTgnYJ
	 pRoFp1UQeGayzNvHIcbnoKCCb0uaPNYPNB/TS36I+zjTdOMRvkWWW1du7k1MI16mX2UTAPOMR2
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+ff14db38f56329ef68df@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [v9fs?] KMSAN: uninit-value in p9_client_rpc (2)
Date: Mon,  8 Apr 2024 19:17:48 +0800
X-OQ-MSGID: <20240408111747.3191219-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000a77e580614ded85a@google.com>
References: <000000000000a77e580614ded85a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uv p9_client_rpc

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/net/9p/client.c b/net/9p/client.c
index e265a0ca6bdd..cd525cee5885 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -235,6 +235,7 @@ static int p9_fcall_init(struct p9_client *c, struct p9_fcall *fc,
 	if (!fc->sdata)
 		return -ENOMEM;
 	fc->capacity = alloc_msize;
+	fc->tag = 0;
 	return 0;
 }
 


