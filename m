Return-Path: <linux-kernel+bounces-109504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9106E881A4A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 00:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 293241F216E3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 23:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36ED28615C;
	Wed, 20 Mar 2024 23:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="G2BTpIsp"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFC91E522
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 23:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710979031; cv=none; b=neMWSEgA7JVx1I5A4bqwRKeiKONySdZOFzFeRUQkOMf6xF4ZMBSGzb3bttcaFwx2K2nGhmHvosmFsQaQRDvE6QMat835mhv0wRwlyiu9Ie81RPCTGUi1/1x2yLdZpuzp0envCGie/xlg27nf8rtXkeKh8C8Pf4HmIeWfNd02FSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710979031; c=relaxed/simple;
	bh=uJUykw8jUkOORzgwxqEhMRwr0zQjg27PUy2ACwXrCAE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=gI1KsdVEbbNymktIELYSPsFUoCtde8l8OH8aLyF/+BGg2aloR885rdRscgyahlPxcOktQGHcT9G+1Jq9Fykae7QqFp/8UuHPe7oIMr0Alc86nIwchaHDd82OYARKr8OpPnFEr45RfXPeNktMlaNFBo5GjjcdudaQhcnUfFNxrb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=G2BTpIsp; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1710978718; bh=27H7m5kBFQ6WUCbYjJTiUtRH7buNouNhLTaOuWrEkD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G2BTpIsp2pIXWJJWajhD36DrQ+GfSIMlhRid/MUb7Py/wpPdWk2RFUABdx2/evb/X
	 wn/t7OCajs51yu5VHrpVpyG+MCJVcMx0JmhpchPDiz71BFeL8xcGWK66XpLFGHJff7
	 9vVLS1C/F0MhRaTXASh+n5fgb0JnsBAHqMFlUhtU=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id CF891E7A; Thu, 21 Mar 2024 07:51:56 +0800
X-QQ-mid: xmsmtpt1710978716t4owoxfc3
Message-ID: <tencent_1FB08DB4A5808DDF12555DA6DDE799744F07@qq.com>
X-QQ-XMAILINFO: NhUkPfKlCtQwjfAHDpPnwVSd8w4ia+wOjuxjv83V9I9u3GuWsT00K3QbF2R9Og
	 a1KNCqAEI3qcP4W6k6kOPfr3HE658MIz/ufb8aXvqEOEqlk8gAQU4muH/iaSzLfj2z9wW2Sh39lN
	 9EbgcFWdOk9797LxmmbsWDMUqcSgL3CB5czjYxl4ni/6wqtiy6shrvlR6CU78PFNWAXk7/vaglgM
	 xzgnUNezIxw4enQCNa10JcWsh3RtRzkX0Rh8nPGMQQHFddNR9TS06PcyFohVH6bjI0SmeAm8F8Wr
	 Oda222pePk/pS1nX+n2DTyJzqNrQ4YUSXFCKwyri0kPsrSHCPUfRyTK+QgZy+pS6aJRaQCyjqK77
	 4clg6v7ulj9G/uIa83gNbscfYCajNLU24tyMyFP6LaJ1kgpWMHBo/1xJ0UJ8wMAY8fetzAnixsBo
	 Wpc9diWfT/xVQeZssu3I2nqOCTfA+G+GkQFM8GYII1yaRyJkxdWYXv2fqC5pocHIlGad8hT/xjy1
	 JVzIHYKorMFbcFQXpndbs4A6RaLZ7bM9C4oV0jH2DsMhaCLhNzETr/PeimAmlnP1u6gSj1r46Day
	 TmAd8BkRet8wrnuNuvaOAsWJMOfBRofcgh4bwxQdw74JTEgyqdfaClVKGxSBmReEHQR27XVq9IbK
	 1PmwR3HhEamSaLAFvFa7MCfqtnehm9aG1DNwQ6TV6HtBRI8LBBVQsp++gPs76eS69rzdnvObxzcS
	 ZK5OEXRFkOjN7h8/+TWvS8XhREWua6kYberZqLjtUAGk3SNpAqcFC2iZdiZZ1gNMpe9sy0nvn45R
	 +L+41Xd0yPcV1YOPZypGTZdsqEEERdi5rpAp1kIwuiGpi3RVVxYXxaRz83DYeQ8KZ7eTwnnZe5u4
	 w7rsKnY8TZ/fuBPd+suwZKdloUl5lApyarAsTMTB1m88LGrOsLxxrpJ48ExBTqzw==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+33f4297b5f927648741a@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] UBSAN: array-index-out-of-bounds in check_stack_range_initialized
Date: Thu, 21 Mar 2024 07:52:02 +0800
X-OQ-MSGID: <20240320235201.1681744-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000003dc8e00614076ab6@google.com>
References: <0000000000003dc8e00614076ab6@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test oob in check_stack_range_initialized

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master


diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1dd3b99d1bb9..7ba5b4131929 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7177,6 +7177,11 @@ static int check_stack_range_initialized(
 		return 0;
 	}
 
+	if (INT_MIN - access_size > max_off) {
+		verbose(env, "invalid access size\n");
+		return -EACCES;
+	}
+
 	for (i = min_off; i < max_off + access_size; i++) {
 		u8 *stype;
 
@@ -8589,6 +8594,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		return 0;
 	}
 
+	printk("1meta:%p, maptr:%p, ks:%d, kv:%d,%s\n",
+		meta, meta->map_ptr, meta->map_ptr->key_size, meta->map_ptr->value_size, __func__);
 	if (type_is_pkt_pointer(type) &&
 	    !may_access_direct_pkt_data(env, meta, BPF_READ)) {
 		verbose(env, "helper access to the packet is not allowed\n");
@@ -8704,6 +8711,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			verbose(env, "invalid map_ptr to access map->key\n");
 			return -EACCES;
 		}
+		printk("meta:%p, maptr:%p, ks:%d, reg->map_ptr:%p, %s\n",
+			meta, meta->map_ptr, meta->map_ptr->key_size, reg->map_ptr, __func__);
 		err = check_helper_mem_access(env, regno,
 					      meta->map_ptr->key_size, false,
 					      NULL);
@@ -8721,6 +8730,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			return -EACCES;
 		}
 		meta->raw_mode = arg_type & MEM_UNINIT;
+		printk("meta:%p, maptr:%p, vs:%d, reg->map_ptr:%p, %s\n",
+			meta, meta->map_ptr, meta->map_ptr->value_size, reg->map_ptr, __func__);
 		err = check_helper_mem_access(env, regno,
 					      meta->map_ptr->value_size, false,
 					      meta);
@@ -10248,6 +10259,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 
 	meta.func_id = func_id;
 	/* check args */
+	printk("meta:%p, maptr:%p, ks:%d, kv:%d,%s\n",
+		&meta, meta.map_ptr, meta.map_ptr->key_size, meta.map_ptr->value_size, __func__);
 	for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
 		err = check_func_arg(env, i, &meta, fn, insn_idx);
 		if (err)


