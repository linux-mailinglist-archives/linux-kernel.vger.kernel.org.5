Return-Path: <linux-kernel+bounces-25984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C89182D94C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B59DE1F2199B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 12:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808651758E;
	Mon, 15 Jan 2024 12:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="yApihBdV"
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7752217561
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 12:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1705323455; bh=VGtEqPsJkEqhuNF3+7JU66Qt0P3kizIOWb//UPjajn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yApihBdVPS9tLWatFGj6/wwCbU4QtZRk9DEia4XiNHxs26nY3WpupD4/WzbmvXSIs
	 NhqXCS4VL+0g3uMt9lS7tDnNRp7OYl1+jK9UDjJ/tg28fmvzMnJCn13M6ZNlvN6tSL
	 hGqLuPpvHZpth16KtRu1BWsn5k32brOcgnzm1ICQ=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id E6092A64; Mon, 15 Jan 2024 20:57:32 +0800
X-QQ-mid: xmsmtpt1705323452tq77d6hya
Message-ID: <tencent_E8B0751D76BD66F43CDD363296D836844A09@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j8ZOrKAnPRVt/1qn8q8HtmBMsceto3Si6E1j+gmIPdYPdPo4UiKb
	 oEkmAsXriIRE3caPkeeMvM8RrojQArE5kfBBXzn60eRHNmgaNgt2ArSs9RU6bnUhXXd4KTiSV2Sn
	 dlhjpWiuZDJ+KzOEs9t/FGS1LRUx0pwJs9qIfBUofyDAD8GV0JrolGipVaZ2LAyZq8EQsU9lJyqp
	 8NSqsAKVs4nO7xQ6bhlxcxTd95tcbZzDBUx6VrYAjzr5ZLIHGvj0ryr93obTCSKAOwfGz5z/w3s1
	 28OUBxRTM+kh4RJRb02g0ns56H8C1fARPP/ssGb9dGrJPuk4MJtb7QnGIGuh4LjsBfJ3O8mcAedY
	 4kNdK1c6AhSuHjQXGhYx/Obj1fnrLO9ehFwUuShIgzXEkz3Ua2WtHg8lXBTL/phqht5NDdTMnFFA
	 h5CXtKPVFTNxZlJMXMP57NT6wCbjnPOp42lH3Q0Mig/Z6owr2dKjgZ7IR8etWXS3AOp+5NVNv38U
	 sj4kyDGpkBr2zQqKGKi8C+GAkji2wKPBNxkI8Y1tikVB6xke7OnsTouVHmovNTEj38NSLGJMxkfI
	 2bJ6gK/ekhjvs6Do6nxiPfUhNuT2NZAz1IThT57rqeRGQ/NW+NOOFl79hWeuYGSXveBnhKop0frq
	 fadKxSWNgWf2HWZUzW5+0RVoKcVKuuwFJJNCu9BGHO7lUDbThfZF5gyNXBe3zqCLe43OMSFuUFmi
	 6EDKsUMT6g90VmEA38YB7pV6oj9WobxeWFHSqbJPff38z5APCOObJ/pLEopUEFkew4HzZSJKTJGV
	 dirUhfJGNEFJzHCSpTazAt5JgcVPEuop0XrGFYF4x/Wrj3PLWGS5wdr5W4K8kSGVcvn9rryS7kZF
	 OAGN16r4bASsjPb9r3vlXR4ZPD+aX222jAOyIZSr0Iwf6yELcs2u0qxX56uVgm8KzO7EPY8oJp
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+2ef3a8ce8e91b5a50098@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in hsr_get_node (2)
Date: Mon, 15 Jan 2024 20:57:33 +0800
X-OQ-MSGID: <20240115125732.3807536-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000001663ea060ee476ea@google.com>
References: <0000000000001663ea060ee476ea@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uninit-value in hsr_get_node

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 9f8413c4a66f

diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 6d14d935ee82..280dca33ec4f 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -209,6 +209,8 @@ struct hsr_node *hsr_get_node(struct hsr_port *port, struct list_head *node_db,
 		return NULL;
 
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	if (!is_valid_ether_addr(ethhdr->h_source))
+		eth_zero_addr(ethhdr->h_source);
 
 	list_for_each_entry_rcu(node, node_db, mac_list) {
 		if (ether_addr_equal(node->macaddress_A, ethhdr->h_source)) {


