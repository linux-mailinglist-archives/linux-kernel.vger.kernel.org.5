Return-Path: <linux-kernel+bounces-5125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC318186C6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63D301F245BB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F56018032;
	Tue, 19 Dec 2023 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="aLXAXQR3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E5F168C0
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 11:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1702986785; bh=HcVrn0m+rOxt2QKdepUSpuTYqEYEqH0SH9zDU7X4Ty0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aLXAXQR3anSoyRveXC9V5enzzlfBrw+Fk6CzC5E8mlx1e/PRKm4eb5yj0OA0MoBrB
	 kO05e/leVGNxp/kGU82MNc8Oh6F1Ql/u+iF//q2DpPFzu2tsh8GcF1tTQnKWCxLjVk
	 4Fi/eA2cbKyeLmXXtHY6fzxICskjWdMsAVeTshtw=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id D4324267; Tue, 19 Dec 2023 19:53:03 +0800
X-QQ-mid: xmsmtpt1702986783t8b386nbm
Message-ID: <tencent_049D8DFF92105DAADDA1995ECFAE0DC82507@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9RG4S4i57iS1dYNCQjitiL1fcoQSRHMrBIMIlv3bIdwu4thenAW
	 dVxoeWyN2K51Ub1Iue4PxNkekSWCXm6THpr11r1e5KQZ7+9keTfp6nX5V76XofaFPWK0zfBm5SDr
	 MUjDnmmHdT2g6kBQHJFOmGmDebfYRviRGTTMxPC2mp3n78iOU3ICduyrD3TetDpv8z3fCzwwPxyk
	 nrH0EymjoCiIWqYbVe/u50BpvoVdJW/vzuSNyejDTGk2Y5rmSTh01vSZvEaeBLzB4vOw2Qd6FJLB
	 zd6Ks0eXVkWV66h1ji3Vm/Hor6b2W3tswfv2LZU5MumGDPSWQxtS36LopOhV7rgygGCluYcK4Hef
	 oA0bZIqTuWMbDHZ5+OSUMjTKKc1gcbsZlhSBoWYAAc3G5cF3fwYA7B3cN3utNQFYoN3OEpTs4UbZ
	 kZ5ygwYWP12Cejy10IohYsBBnTdzm6gnftopt9Xirg9jt503Udzs4kF9/G62BeWC3ker502Tkdgb
	 t60RzSBOAvr0Le5YsMlNCJzAOeDENARYXjhQ67F2CgUzKIfN9pZ32rmAiv1mZdBpphxvJJHzQNX0
	 nNYlZe3RgMt+ucOuZjZovcrEC/wqV0a3UiKblgyEz+zatDg9XRgd73SexCPDO59bHOO0dZY1TNDu
	 a/ztnQZM5PsNUyb6Nw3bB7c5/qSeolin6Gt7rZKiqt8ppL+KsjursKh1QemC0KILqPTdhB+qgDtp
	 Is81hBPcuC9LoKzqfraelQ08qln+qbTxKwqLp0Lkz6Wsefn/HnYv9Vq1AzPrjSanQeFlWq17Uexi
	 Y4Z8kRHIffumaNEJ+TsIsKe+8WvWiBs55oKlvKvMuF4Ud6itY23bkVDAChPooToq68dY/GjtoquP
	 73wV/PwCGT/OYRR3mD8LLnN4onKtJcpvnPVKbBwYkw+Ma0nzRc9sCsEYDAdjXXDMeJ6uM2USddoH
	 LZkE9IcliGztuaQIDPhw==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+8ffb0839a24e9c6bfa76@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [crypto?] KASAN: slab-out-of-bounds Read in arc4_crypt
Date: Tue, 19 Dec 2023 19:53:04 +0800
X-OQ-MSGID: <20231219115303.2141992-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <000000000000d52e14060cc9c551@google.com>
References: <000000000000d52e14060cc9c551@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test slab-out-of-bounds Read in arc4_crypt

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git 17cb8a20bde6
diff --git a/crypto/lskcipher.c b/crypto/lskcipher.c
index a06008e112f3..36968495607d 100644
--- a/crypto/lskcipher.c
+++ b/crypto/lskcipher.c
@@ -215,6 +215,12 @@ static int crypto_lskcipher_crypt_sg(struct skcipher_request *req,
 
 	flags = req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP;
 
+	printk("ivs: %p, v: %d, s: %u, ri: %p, wi: %p, %s\n", 
+		ivs, IS_ERR_OR_NULL(ivs), ivsize, req->iv, walk.iv, __func__);
+
+	if (IS_ERR_OR_NULL(ivs))
+		ivs = kzalloc(ivsize, GFP_KERNEL);
+
 	if (req->base.flags & CRYPTO_SKCIPHER_REQ_CONT)
 		flags |= CRYPTO_LSKCIPHER_FLAG_CONT;
 	else


