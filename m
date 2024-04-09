Return-Path: <linux-kernel+bounces-136797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A1689D846
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1AA228ABDE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F31486269;
	Tue,  9 Apr 2024 11:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="qZ3hsfop"
Received: from out203-205-251-82.mail.qq.com (out203-205-251-82.mail.qq.com [203.205.251.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCE68004E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 11:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712662938; cv=none; b=WcEbJJMcKez4+ICg+eykWgzoB+ys3+CJ1B0e6RLs4+vy+1g/9fTbXGTHtD8doJoMiXbIVU1btr3zd53CzAzcSnkqsLCsC2q2lBibMLCHrQkkomwNdmfE++tdjvJDwcsfNuSS3XUmxNMEEAwlLBMGO1KkxSg74hRpZepfaPJu2t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712662938; c=relaxed/simple;
	bh=w28AhVJdaf28gczTEC/743XeuXFRjTt+LY/KGqEIw+M=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=aM7YTFuYTdqSRda1TDwumSla7Z2jJFT27+FYt+yKmhhaAoHEqueR+4R5VwgiLGPSw5Hg1E5wRbiFE1e9R1IOA75QHZcjiPZjS3hOVmnexLVGWXnFXgx1GTinaYHtWsgwBNscoAgwh65ak80HsLQbcLFhA1NwatAfqAL5ckgisdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=qZ3hsfop; arc=none smtp.client-ip=203.205.251.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712662627; bh=Zpzsx2iCV/8x6AGSzYws7eooAgEtLnw86Ev2U3APbH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qZ3hsfopsbBYAD+SHz7hqsv3PlAhAyjlmXZbIvFWp7NxxQE61BDDDJrufVLqF6cW8
	 NjII4jWh1yTtjD+pTl8y6Qm8faa+tpkfeHoK8saFZVvtI/5Q1QkpgEJJ9Juw9ALLc8
	 aav3239okgZwz5iKFAR5Q0LkcgtA5R73OLgJh0YQ=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 945BD8ED; Tue, 09 Apr 2024 19:37:05 +0800
X-QQ-mid: xmsmtpt1712662625t2a1uvbbr
Message-ID: <tencent_4DCD347A366F802CB96D5095B8EAA6ED7E0A@qq.com>
X-QQ-XMAILINFO: MBjwNRQMz5zU6FmzQCNFwtLz8gWpg/n77NbsNuATmSx1a+KyglPMJ1EpbbA3ir
	 awEM0qdTDy5VXVSaAXxMiI9M30wMaeVpm440NHQkERT04DWS60aqwq3kmpGkGMqxeeHlVAZcWlD5
	 pZcNwMPYjn9Y94Y1LjCs86cgy70Sr6fHiI+J75q3FKAIm8qsFc+CG8PEdnNI+u2qL3NBrZO3+x7E
	 IwDxx5bYNVCA2O2P2W2RATdfmKzlzVhhRD274ZFBWutUq/IK53KGQ5EDP2L0WAcby9RHwDu3afDM
	 s9LkCIFYCWi+lilLesDiPq0UQN5Ki9pH+ACr3Wbz4m4AQ1oFzSXQjp4SH8XCEPtJ/WVsH8rwLEqA
	 ANJ8wTvrz/YPut3ue0UVgvq0+Z7kXWJnQLHHSCnz4yZSSF8AjPVvfFpWq/sctuemExAM99hoRbSO
	 zdTuGbT3PMi+c8VOyJOXkI8E7Np43A6lrzVw6eXhh+2S8o54d01lbbDDvK4Ug4Hr8DrVaHFIGoh2
	 uUVkuGSoTFagiMSC+RGxUUGoTSGA01QKKqMYgYi10fEp7C4YWXr0JNGUoh6hZ2YZjULCfLy+387V
	 tbNT/NFepM/REbyGIH3+Holm7VtXFDo8+Lxfp+ctLjMDD9M4XHXJKFwiaOk4DwCuzi/SePJyz3TX
	 pISZkVRHO/5PD2VUV3Brw4j35dDF2UHEJdEP233aGyvxz87d+JuDF9azriml42iFQFcV3xadOBI4
	 HSWRyoVSIfrnWxluzPu6/N+EdEsjB9i6XQkO1xYtIhFgzC1YXEyxeF/EGL6mVjgTmaqN0P6jQ2JM
	 HGf5S9o/WsV4DSCRh8yCdeGbb2ul9jPjNW95PFdZ2PnK/XVq6L8SfWi85g3KOGJ2AVZ2bxBPDW5e
	 WCskSsqGauLeH4TnbyzaTXUyVwtInkhx1ZOIgrJiaClOuKv/DZE++5GG7ELWy+03f96Cgo+ahx
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+9b8be5e35747291236c8@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in strnchr
Date: Tue,  9 Apr 2024 19:37:06 +0800
X-OQ-MSGID: <20240409113705.4054825-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000009e2ff406130de279@google.com>
References: <0000000000009e2ff406130de279@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uini in strnchr

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 04b8076df253

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 449b9a5d3fe3..07490eba24fe 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -826,7 +826,7 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 	u64 cur_arg;
 	char fmt_ptype, cur_ip[16], ip_spec[] = "%pXX";
 
-	fmt_end = strnchr(fmt, fmt_size, 0);
+	fmt_end = strnchrnul(fmt, fmt_size, 0);
 	if (!fmt_end)
 		return -EINVAL;
 	fmt_size = fmt_end - fmt;


