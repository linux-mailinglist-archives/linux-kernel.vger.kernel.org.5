Return-Path: <linux-kernel+bounces-29026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAD283072B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57BED1F24C39
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4CC1EB52;
	Wed, 17 Jan 2024 13:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="C7VbANkO"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5600914A87
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 13:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705498652; cv=none; b=bd65btprVkmtaPmB/itQB3JLvyyFrz/GMX7jYR0rt4p+nCcPyFngSOjLJ6ZucujYWTm9c6k17QJMe5EoKVTFHo0I+AVRsmWpthWIYdz31n/ZC94FpxCX0cE6J9RTTwkKRkAkSnH27R3Le3NBV03McjuJL2iu/OqIs2QCHv0B95g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705498652; c=relaxed/simple;
	bh=UfsbhrsAmco6AdwOAi9OFiHC26t5vjPYtbU8prb6Xgc=;
	h=DKIM-Signature:Received:X-QQ-mid:Message-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding; b=tQIRkAmWdH0OIIryxfElfjOHNGLWgI8Zbzj2ICviEAN64HHwzNu13ShvTemX30u/bkLbd+G8L330iH3LkcJqOA1bQM6CTLpeyTNJGXKY7/TjxXRz2VWQiK00pFv9AbNMihZ24lZ39DTO7QlmisJK3WvzNaYCPWvyKJ3iK0PkYdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=C7VbANkO; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1705498645; bh=LVEn1oixf1BwLM2yzeQ8xANQluGzPCvbuOpLQ+emisY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C7VbANkOMNG9D/YA3HOgVpQ/E5urMjux0AJJxoGR0RCUbpIf9cjbd4udpbIUVqroD
	 5JHLS0CHvZhyRXHNHkc7jO00zPQ3b8/WBxLPHXaMYN9BySwj+eMiSLZ8cDXHmMYPSg
	 eb2KhpGJ64DJCG4mSygJRg9t9mdx6cmDvnTdhseQ=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 957B6EEC; Wed, 17 Jan 2024 21:37:23 +0800
X-QQ-mid: xmsmtpt1705498643tj0reex5a
Message-ID: <tencent_891761177606DD73662373096203B5C44305@qq.com>
X-QQ-XMAILINFO: Mdc3TkmnJyI/VlmtfTzmjpgiCurE8enklQdA8Co+VSN6t3Imbd5PSiNZZUfBbF
	 3SJ4JNjGaRy5jRtjMAit+FoBJLTHAjy7FBZETUFXJrFpQTzJsQ2Zvv1v5kx6lWDFoHIX88z3ax+L
	 g7F7KVQYji/lSvfvMbKXlC+p4yYOjADuwZl7f7hmgiYUsSdU0qIuEOc7G3F+AF+TjUsmjGfoCsfr
	 g4yY8AIe3S3f1tmtIM6xnKABZBiBH/bn8jN3DehBrJdmSobWteFVv7eLBMUJGI1vnVsLKR5DRbDx
	 3ODDoQpQ2/TSNr7pEazuKOyUbP8dLkdWDv1YHDVLEVv19gnmajNRLHTwSEMRCt32WEfgld1Crvbw
	 mOq5RO3MGtMWfBU3VgsxkTs2VbjmjNki6wUpq3ZKyvgEFXN8L1eprMJaTuihJ5FGjqiYPgKSOVGN
	 g2/vVYZ8VMa0D6R9Qrc+uEWfZDEgUB/9otZRyOXdwhD8ev2XXKO2gdr8scKyOicWt7cIVWScaLH0
	 ebhO81JaPeFVbhiU4BdRXgovMoyIt0uXUuib1s+2U9vZMpcRtJYZ3C7VQo16unFKiFnv/V93sYb2
	 8XA6sk4a6Cd47GxEf0XH6ugrI8rh+Ls4+HfPlIZtaXdU46bZY00NQOhOBv6wvCf2OQ1bgPOiV3fb
	 9FdLRb2HWs/5rm0TYyw/PL7OjzF2jmQRKdt0cvNnjlcVY2H6NZ2IvGfd1wPMrIgm4CxThoDz6Ghg
	 RTRZNQfIGTNq365oaMwJ8KV2uRoDDbK9Jjuo9IU9VY8h2j46/TRIzKgS4WhxQrbhIoyirhhQCX93
	 2o4cPqEw7ei+hd9GtoAjitdIB/UXBr2srwn1RS6EtgTzMDkOcB75sACZmiN8AK8g3K7M3uLa0DFC
	 vGP6Jf7AzbE5LZi0ggKNA23OashOCHvLraL82MAgAAHSVi2dTiitE83boBL0cHrw==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+830d9e3fa61968246abd@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] general protection fault in btintel_read_version
Date: Wed, 17 Jan 2024 21:37:24 +0800
X-OQ-MSGID: <20240117133723.2124393-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000cde441060f230f4f@google.com>
References: <000000000000cde441060f230f4f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test null ptr deref in btintel_read_version

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git 943b9f0ab2cf

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index cdc5c08824a0..e5b043d96207 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -435,7 +435,7 @@ int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver)
 	struct sk_buff *skb;
 
 	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_CMD_TIMEOUT);
-	if (IS_ERR(skb)) {
+	if (IS_ERR_OR_NULL(skb)) {
 		bt_dev_err(hdev, "Reading Intel version information failed (%ld)",
 			   PTR_ERR(skb));
 		return PTR_ERR(skb);


