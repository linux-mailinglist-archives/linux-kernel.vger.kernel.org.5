Return-Path: <linux-kernel+bounces-112226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB8A887716
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 05:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED8431C21A0B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 04:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2387B4683;
	Sat, 23 Mar 2024 04:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="g8Pp+jVU"
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804901113
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 04:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711169309; cv=none; b=ndQ0uX0hg4pIUT9hggsWnAeutLkUl53yUMPWAzC19EUgk0n/4EQrcyi5+gKHXBBnWwozkAVAC2VlaHf85nP81P5fj8i18J0mdKEeRUIN5uVop5OmwIJ6HlnQH5YxMc9dKpdpnx2ISxXEtaQERxw4WjocDa98AZXW+7r46BLC03c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711169309; c=relaxed/simple;
	bh=gYgpZRQDfZdvDxmkDmsuWvYvYS90C9lwtgM5EUPIV34=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=gqEsh42VlocZFWqtRKUeiq6BE4yVlTLV9/RHpIOC656kV37ZrUewNQSZRdmk3gjCfqXVcNlDXfCmJc7IwuenjDaVYUP1HtlS0i74mh2Q/htcPEYkYeBOGLGLePUY2/aQ21k7dar2RiF8dANs+h41udPHCU4wHDBy0fgRI/jqCmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=g8Pp+jVU; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711169299; bh=zIq4+4WqAxVN/mMsPefLIlKwl2DRZUKhkSkFnJqrUJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g8Pp+jVUZA1tatdn5g78xddaLDsdoGdUvrqIqargmCVNkdV/wxZ4FMV2+xRcs4XI1
	 FX7o6tLu4SvpZmZRROUse5iasTwWYiyDX7IQkdYhnVrVSqGgFxDulLqHMhwId5Borz
	 8Fkfi3G+ws3t+DmF5q866iUWmm95h6bru2iIkzJo=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id A87294EA; Sat, 23 Mar 2024 12:42:07 +0800
X-QQ-mid: xmsmtpt1711168927t18lb0ilx
Message-ID: <tencent_D8BA24BB3B33559EDD1B644B2D1B16259808@qq.com>
X-QQ-XMAILINFO: OZsapEVPoiO6pb6ZN/T6VITKzRnCRGE531fel4ubOsgunIZ37DlK4qSNBW1Gi9
	 JBbKNVO8Os8Ipvo0YavsqByphAqZwp/h32MvYMs7QbXv75ZKeVh4WJO/TnZLL+YAinC+idKds34N
	 hnmqP4HYHVUeoAsPpsZtXD6OHt7m2yftO7pP0NSb1ONHlovGBbIw7SEXBC+pJKJ94Ss4mkTYCMNj
	 /ybJ5hhvSfNP7FKc0F43iFLAxLywBwPa7boEcb/6gniI7C78TnbRabGEMmZvEXbENII9POJe4lKr
	 hueIx8NrvzW6VHU/7fiwQAoJmks3jeS7Pxn2md5j0p/hofqzNgQXzkLvmUBTEFcKr+/0xllRBw7+
	 FY7k3P9MeFcE2HdUDlS2bozYiR+1R1AbVnU60rCasixbk3EMu5H7SquDm7sOzrjShxSWuIf2LFmp
	 eDIn2zjA+C7OV5wJofFnP+ifHpj+x9cICq/xjNZ56RUAeCZBCu+emP+dq0cVJ5RVauHYP2XqXyQ+
	 zaPQ1WFNlPdI8629DAgvR055mmzTXmxzKrDqTFc9AnP2W8xj8+KxvkN55d7joZTp05xy02wDBOCM
	 k0OwluitPMJYm3edaeWSJDJl77ggkjpCNSkA4SSTJi6zUv+d/PgctRY1CaBMcx4OUCdA7/Fk2TK6
	 DYUTuUQhVEtKus21kf7gsw4aqxqR7A1GCeIT+XYYXbB65sb2I99MDbKd1d0jr/aLI5EoEkGAmGkM
	 fsem5jvyi+gCseB7I1r2i7JuLo5SeyagIG5gnnIvGT41NyRLmUksyoyTbIndOen6rfnFrCHtFXC+
	 zveT8kmP7QCV2B7eFRYFbBHAxg//pM3lCd7hJ3oiHd+Wa31C4MbnSyiet3quwF6AHIlxnpc5GMD1
	 e8Hl9DSVv9kB0NzfFSu6m3LC0oXm/RKOD3gR4zUAig4uHgEZ/KWi8FsufwYlYrow==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+33f4297b5f927648741a@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] UBSAN: array-index-out-of-bounds in check_stack_range_initialized
Date: Sat, 23 Mar 2024 12:42:08 +0800
X-OQ-MSGID: <20240323044207.3809847-2-eadavis@qq.com>
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
index 1dd3b99d1bb9..29d7673d0e1f 100644
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
 
+	printk("1meta:%p, maptr:%p, %s\n",
+		meta, meta->map_ptr, __func__);
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
+	printk("meta:%p, maptr:%p, %s\n",
+		&meta, meta.map_ptr, __func__);
 	for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
 		err = check_func_arg(env, i, &meta, fn, insn_idx);
 		if (err)


