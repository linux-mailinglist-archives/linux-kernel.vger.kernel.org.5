Return-Path: <linux-kernel+bounces-98864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A14B5878070
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 418411F22D2C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC6D3D986;
	Mon, 11 Mar 2024 13:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="exreY1fl"
Received: from out203-205-251-80.mail.qq.com (out203-205-251-80.mail.qq.com [203.205.251.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074913D541;
	Mon, 11 Mar 2024 13:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710163330; cv=none; b=XgCIo0Hbigrn3UZK1mOhEkVySwwyNP2uhCxxMLrEBDJSEUXlZaeWwPZVBBpUU58bWK7H2CAnw7BdcFBe57B5ykUAiyu7Grz3+kSMfAxYMwwyrE1pmlrX7aOzM5SiBz4i8LAPbDKzxjUcvrKQbJ1c5A0jFYK3zwZjnn7w2rQpf78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710163330; c=relaxed/simple;
	bh=3+xxg4ETzFMb63127mOvBTZyTlYXtPpq7mf4zurTLq8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=oUcuk8t8hsPf9OWebUUSMHB4rHVGqp8hLH5MRI/oTCmNyQXegfryN7ePxRvau0aHuVQTeNn1lwzA/WpyDjPOAYWk7GGr8LArfzBfCdRKNJWGvXOAWn9PyMdn2qW1xqF3ml49UdFqyjbdITHS8R4x5A866eU6ojMNOY7OkEX4ahw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=exreY1fl; arc=none smtp.client-ip=203.205.251.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1710163024; bh=jmpH0Xkw0Njp0yvCShHoL5DVGZlUug/nMtr2L4QpBJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=exreY1flqzqsX+X/AraI0T1Nju60JrXKeyNndBVXS0zQJetgD7r9zeQgqjvJyuu29
	 XhZ1BNlf/B9SdhHQ05DJbmTH7ecz2wD7JM1OT6aXaLqq2X9kN/lGRVsWrnvYUdxZ1J
	 q7Gzgu+3iCMq6n6tWBXeL/+PzMpMsRejGMHtmVQo=
Received: from pek-lxu-l1.wrs.com ([2408:8409:ce0:38d1:a032:4bf1:303d:acae])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 43B1EC66; Mon, 11 Mar 2024 21:16:59 +0800
X-QQ-mid: xmsmtpt1710163019tizb048h8
Message-ID: <tencent_E4EB1B6A2584BA2BBBB733409EAE1B524B08@qq.com>
X-QQ-XMAILINFO: MmpliBmRb3iCgT0VMlIhb+FmTZpopN2STe9Rpls2NzUeAxSrxH/8n5o9V1Q532
	 XalIkpEluGgCj+13jp8n+U3FhVcjxGqz+JRiNu2Y86z9DqWgnJW3hIQqhwg5H758gHGZQCN2KQZU
	 r/WZLhpjr0sDyi1NkA1nsmAbY4PrwqVZM/rTgPiY1/mX0ab0RmZ7YBd1wjEiq41zGojj9IxANxNa
	 wI2kehu+cTFurcyI88BkV07/88joj4kbhU88Ain3klpc+Ldz9EYpM2WEOXpjExZNoTc4wvgVBVdC
	 PRCPVy5muBMh1mYZuclcZVyegXKhf83Q1IWBDvuJ8Gs+9UKM7HwsbZe10TbRnfgBp8h/D8vfIQ0M
	 qU0eSEst5bwjpv2SDKa6ryidJwK5XaNeqG5+zbCBiXZqACBpwqnX6f+J/JlrjGl6l+5E/vCFVy8G
	 IqBq20PXFXWjezNSDdghACiNUNFrZRFhydhpnmExLDNGn3pCwHv2MbCO5HwolKRCgmM2Pc4jidKF
	 /Xq80gc/OKGHdNjgabz5qcbMK6JvVvlCeRN2zUxOOOWc0IJk4RwFsDrxe8witxvER7sfVTBTMB2C
	 3GjLR+PBEgCeS3CYrwU3VsyXW5Iy5UZVQC1iNPL67UutL8f8iEW2XrEkRkg/c0hl87/SQwtHjEr9
	 Wyh3Auu+N7Kbe1Z1Xck/Lj5M1rLSiIeL7W32Q8/XV6d6JNe6nv+2sm2z5e5RWMUYETJG90ujnNVT
	 kL9RBcKB+GKbEJr/YO6kx62ks/9aPnZAMFmo+RTg292Mgpqc121wkKWGW/l2bL2ogBI3yNK5pVXI
	 ttrtgncvCMEfFoJtAv3LxTzvpPidPPV7OxNhQvScOLKL4Ok/zPbQQRmFNFKQEnTVzhiAnpl+f4gG
	 aUXF37kApDf6oxNxjcGZEp+tvd/m7bhoE+db+gNiEFAEo0pT5mzW4X42gax59EKn/kU3dllEHh
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+cc32304f6487ebff9b70@syzkaller.appspotmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	sdf@google.com,
	song@kernel.org,
	syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: [PATCH bpf-next] bpf: fix oob in btf_name_valid_section
Date: Mon, 11 Mar 2024 21:16:59 +0800
X-OQ-MSGID: <20240311131658.161143-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000081fb0d06135eb3ca@google.com>
References: <00000000000081fb0d06135eb3ca@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the first char of the BTF DATASEC names.

Fixes: bd70a8fb7ca4 ("bpf: Allow all printable characters in BTF DATASEC names")
Reported-and-tested-by: syzbot+cc32304f6487ebff9b70@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 kernel/bpf/btf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 170d017e8e4a..dda0aa0d7175 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -816,6 +816,8 @@ static bool btf_name_valid_section(const struct btf *btf, u32 offset)
 	const char *src = btf_str_by_offset(btf, offset);
 	const char *src_limit;
 
+	if (!isprint(*src))
+		return false;
 	/* set a limit on identifier length */
 	src_limit = src + KSYM_NAME_LEN;
 	src++;
-- 
2.43.0


