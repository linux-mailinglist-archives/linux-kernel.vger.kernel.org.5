Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33AE7DABE8
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 10:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjJ2JrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 05:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjJ2Jql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 05:46:41 -0400
X-Greylist: delayed 446 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 29 Oct 2023 02:46:38 PDT
Received: from 3.mo576.mail-out.ovh.net (3.mo576.mail-out.ovh.net [188.165.52.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8441BD
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 02:46:38 -0700 (PDT)
Received: from director4.ghost.mail-out.ovh.net (unknown [10.108.20.161])
        by mo576.mail-out.ovh.net (Postfix) with ESMTP id A4B252806A
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 09:39:10 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-cv5d2 (unknown [10.110.171.164])
        by director4.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 856C91FE5E;
        Sun, 29 Oct 2023 09:39:08 +0000 (UTC)
Received: from foxhound.fi ([37.59.142.103])
        by ghost-submission-6684bf9d7b-cv5d2 with ESMTPSA
        id JR/PGjwoPmW5FQAA0ek+iw
        (envelope-from <jose.pekkarinen@foxhound.fi>); Sun, 29 Oct 2023 09:39:08 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-103G005964038db-79ba-4581-8d75-77bb2bfe47b4,
                    2D5A9C8C3C9544CFCEEB4DEE313913C815DB1A20) smtp.auth=jose.pekkarinen@foxhound.fi
X-OVh-ClientIp: 87.94.110.144
From:   =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>
To:     seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        skhan@linuxfoundation.org
Cc:     =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>,
        x86@kernel.org, hpa@zytor.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] KVM: x86: cleanup unused variables
Date:   Sun, 29 Oct 2023 11:38:59 +0200
Message-Id: <20231029093859.138442-1-jose.pekkarinen@foxhound.fi>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 2899755212625716902
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrleekgddthecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeflohhsrocurfgvkhhkrghrihhnvghnuceojhhoshgvrdhpvghkkhgrrhhinhgvnhesfhhogihhohhunhgurdhfiheqnecuggftrfgrthhtvghrnhepfedtleeuteeitedvtedtteeuieevudejfeffvdetfeekleehhfelleefteetjeejnecukfhppeduvdejrddtrddtrddupdekjedrleegrdduuddtrddugeegpdefjedrheelrddugedvrddutdefnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeojhhoshgvrdhpvghkkhgrrhhinhgvnhesfhhogihhohhunhgurdhfiheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehjeeipdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reported by coccinelle, the following patch will remove some
redundant variables. This patch will address the following
warnings:

arch/x86/kvm/emulate.c:1315:5-7: Unneeded variable: "rc". Return "X86EMUL_CONTINUE" on line 1330
arch/x86/kvm/emulate.c:4557:5-7: Unneeded variable: "rc". Return "X86EMUL_CONTINUE" on line 4591
arch/x86/kvm/emulate.c:1180:5-7: Unneeded variable: "rc". Return "X86EMUL_CONTINUE" on line 1202

Signed-off-by: José Pekkarinen <jose.pekkarinen@foxhound.fi>
---
 arch/x86/kvm/emulate.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 2673cd5c46cb..c4bb03a88dfe 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -1177,7 +1177,6 @@ static int decode_modrm(struct x86_emulate_ctxt *ctxt,
 {
 	u8 sib;
 	int index_reg, base_reg, scale;
-	int rc = X86EMUL_CONTINUE;
 	ulong modrm_ea = 0;
 
 	ctxt->modrm_reg = ((ctxt->rex_prefix << 1) & 8); /* REX.R */
@@ -1199,16 +1198,16 @@ static int decode_modrm(struct x86_emulate_ctxt *ctxt,
 			op->bytes = 16;
 			op->addr.xmm = ctxt->modrm_rm;
 			kvm_read_sse_reg(ctxt->modrm_rm, &op->vec_val);
-			return rc;
+			return X86EMUL_CONTINUE;
 		}
 		if (ctxt->d & Mmx) {
 			op->type = OP_MM;
 			op->bytes = 8;
 			op->addr.mm = ctxt->modrm_rm & 7;
-			return rc;
+			return X86EMUL_CONTINUE;
 		}
 		fetch_register_operand(op);
-		return rc;
+		return X86EMUL_CONTINUE;
 	}
 
 	op->type = OP_MEM;
@@ -1306,14 +1305,12 @@ static int decode_modrm(struct x86_emulate_ctxt *ctxt,
 		ctxt->memop.addr.mem.ea = (u32)ctxt->memop.addr.mem.ea;
 
 done:
-	return rc;
+	return X86EMUL_CONTINUE;
 }
 
 static int decode_abs(struct x86_emulate_ctxt *ctxt,
 		      struct operand *op)
 {
-	int rc = X86EMUL_CONTINUE;
-
 	op->type = OP_MEM;
 	switch (ctxt->ad_bytes) {
 	case 2:
@@ -1327,7 +1324,7 @@ static int decode_abs(struct x86_emulate_ctxt *ctxt,
 		break;
 	}
 done:
-	return rc;
+	return X86EMUL_CONTINUE;
 }
 
 static void fetch_bit_operand(struct x86_emulate_ctxt *ctxt)
@@ -4554,8 +4551,6 @@ static unsigned imm_size(struct x86_emulate_ctxt *ctxt)
 static int decode_imm(struct x86_emulate_ctxt *ctxt, struct operand *op,
 		      unsigned size, bool sign_extension)
 {
-	int rc = X86EMUL_CONTINUE;
-
 	op->type = OP_IMM;
 	op->bytes = size;
 	op->addr.mem.ea = ctxt->_eip;
@@ -4588,7 +4583,7 @@ static int decode_imm(struct x86_emulate_ctxt *ctxt, struct operand *op,
 		}
 	}
 done:
-	return rc;
+	return X86EMUL_CONTINUE;
 }
 
 static int decode_operand(struct x86_emulate_ctxt *ctxt, struct operand *op,
-- 
2.39.2

