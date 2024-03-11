Return-Path: <linux-kernel+bounces-98842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0012878026
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D18DE1C214B5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E633B7AC;
	Mon, 11 Mar 2024 12:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="UPRH5TTH"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DF41364
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710161385; cv=none; b=G3Q7rNm430RkefaXIYDU0Ccdi2ewC47YyyACdqY1VURsZyu5xjymkbZeCPAsMK0tt/1h1nR64Dc50tWM/wCkjhKgVwkbndh2x1ExDfXMmz9OSXf4x4JMJlvmBeG8uA1NTsrjml44akbP7rB2PC6fztvrzzRIpVASm49QnPAZZGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710161385; c=relaxed/simple;
	bh=jhiwJhcKVBRZIdqpk4E2dgcKQXEmHWRcfgca5ia865s=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ZBYfJ6gaMK5jc0ToAFX+UPs9fLsbadgzwLHrs08pkqMj3MdVDahb8K/vv0Rdy5CBSJ/55ECMDcfeZ+Yd3cplfaPDcNwtBZZ3ykPmQgibvqtUg289miuiy/1IRbE0SDSDSOthav1oEpxa6RcmhsDDlwefIuuwiR8HaTbOSamRtus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=UPRH5TTH; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1710161076; bh=tLb6KWZBoxGV0fA+3X/ShT89VgoRxqI6W6b+OTUce/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UPRH5TTHAA5W4ke8bDBV2RPbnylBiihGIrHsEpyLVUgUtdMaHqwSSWpF5Z4G7kblc
	 DlCtwI6PsiqAP5KKbL1sCvAyO7WIKh7Ba+DjmQc90vlkIMFJZroWa1yMUnp0pRdM3O
	 3pR3at1YTWPL7DMuObUv0oX3TpDZxfAtkP7ve2NY=
Received: from pek-lxu-l1.wrs.com ([2408:8409:ce0:38d1:a032:4bf1:303d:acae])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id B22A8861; Mon, 11 Mar 2024 20:44:34 +0800
X-QQ-mid: xmsmtpt1710161074tbdinx252
Message-ID: <tencent_7B6E46C35367636DE97C83A16448F7623705@qq.com>
X-QQ-XMAILINFO: NyTsQ4JOu2J2NvXWLetB1rP6VE8ZT9+4Wd73MXKvJUzIVsyC7VsmFgHvcGDX7S
	 TTpB5EB7ZNVKqhq3Prsg+NkX2kKxedsz+Y952Q0Hqy/TwzlRgHCGASy9M5lfJvo+DTEoUd1wJuG4
	 gb9LvUt7veo11P/U99QDsfP+RltGO897ybEzWrWWH1ZgleL5U4yNDdqOs1T0AR3hcDmJDtf5EoPs
	 o/2W/fENO+Nu6Dib/UIJIYBFsB5XV9KC9o4M0LcSWvubXogHIFEbF25lP6a926qc7efejgZyClKm
	 JC5FY3DWxmylw+gUA0VHWpSB/Z13BzUQmOK0EF+8FNtNU3EDN8zEcq04Kc2sbkJmg1EZpLkURq10
	 QTNE3hXjNIPVOl3v6ACQvwf/vf+TFE4Js9est3xuG08wA4epizmpoMfCTRaEcWXifBvHe+i+IceO
	 7SaxxA5IrJ3hm8/PfuuXaOtOlfiUscuCAQrU4crJqqvIJ0rezX+GkP97ZMj3PaaNmu6Qz+fcwOHk
	 vxFnkwgtDIgsGemfvBENV7E26tdKIlpCSc9QdJh0ZH5cCEW/Okv0zvnLnQJrSX4Xc5v402GHSfFN
	 3se7N1BCFw4O4N74d9BL31PyJhnvkMtgdIX8/QcyQrJfmKcllPenjNEtKOdqsVPNtY4orhf+N8cG
	 Fe4y/3obPDAOCm34YmBLrdp05FYvLoRA7+E2xRrghfI+szpn6UHXH2tzPXzQlM03ArwMyt6cYNtp
	 OEr633lp+drsI63HVoRN4M5o6jg5dT1can7Tvj7AEAlBXp5LL6XDKlFZxpbwcqVzKzLeaNHUOh/U
	 hczA8KFOZOm2aS4k4yXKH6LghpW++ZsFQF/jJCopYV50M0HNHkTZUjWvIY3/NSppF0CZG23iAhFO
	 LdbALPcJWy10KXYyJrkV0E7sKlYNFQh7iiKfA8/1eMVoRngsTvpMJDOVlQ+DpK9w==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+cc32304f6487ebff9b70@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] KASAN: slab-out-of-bounds Read in btf_datasec_check_meta
Date: Mon, 11 Mar 2024 20:44:30 +0800
X-OQ-MSGID: <20240311124429.125440-2-eadavis@qq.com>
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

please test oob in btf_datasec_check_meta

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master

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


