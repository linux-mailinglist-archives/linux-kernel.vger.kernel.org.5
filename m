Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB677DAC93
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 14:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjJ2NF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 09:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJ2NF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 09:05:27 -0400
X-Greylist: delayed 1199 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 29 Oct 2023 06:05:24 PDT
Received: from 8.mo561.mail-out.ovh.net (8.mo561.mail-out.ovh.net [87.98.172.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D36BC
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 06:05:23 -0700 (PDT)
Received: from director6.ghost.mail-out.ovh.net (unknown [10.108.16.164])
        by mo561.mail-out.ovh.net (Postfix) with ESMTP id 1EFD725A9E
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 12:26:24 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-zlzdz (unknown [10.110.171.220])
        by director6.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 136771FD23;
        Sun, 29 Oct 2023 12:26:23 +0000 (UTC)
Received: from RCM-web4.webmail.mail.ovh.net ([176.31.235.81])
        by ghost-submission-6684bf9d7b-zlzdz with ESMTPSA
        id CCgfA29PPmWg6QAAfL0Qcw
        (envelope-from <jose.pekkarinen@foxhound.fi>); Sun, 29 Oct 2023 12:26:23 +0000
MIME-Version: 1.0
Date:   Sun, 29 Oct 2023 14:26:22 +0200
From:   =?UTF-8?Q?Jos=C3=A9_Pekkarinen?= <jose.pekkarinen@foxhound.fi>
To:     seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        skhan@linuxfoundation.org
Cc:     x86@kernel.org, hpa@zytor.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] KVM: x86: cleanup unused variables
In-Reply-To: <20231029093859.138442-1-jose.pekkarinen@foxhound.fi>
References: <20231029093859.138442-1-jose.pekkarinen@foxhound.fi>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <411f0a96b86c08e85a02c7174a921138@foxhound.fi>
X-Sender: jose.pekkarinen@foxhound.fi
Organization: Foxhound Ltd.
X-Originating-IP: 192.42.116.212
X-Webmail-UserID: jose.pekkarinen@foxhound.fi
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 5724075128479131302
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrleekgdeflecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepggffhffvvefujghffgfkgihoihgtgfesthekjhdttderjeenucfhrhhomheplfhoshorucfrvghkkhgrrhhinhgvnhcuoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqeenucggtffrrghtthgvrhhnpeekhfeguddufeegvdelgedtvdffgeehvddtkeevkeejvedvgeeitdefleehtdeitdenucfkphepuddvjedrtddrtddruddpudelvddrgedvrdduudeirddvuddvpddujeeirdefuddrvdefhedrkedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeojhhoshgvrdhpvghkkhgrrhhinhgvnhesfhhogihhohhunhgurdhfiheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehiedupdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-29 11:38, José Pekkarinen wrote:
> Reported by coccinelle, the following patch will remove some
> redundant variables. This patch will address the following
> warnings:
> 
> arch/x86/kvm/emulate.c:1315:5-7: Unneeded variable: "rc". Return
> "X86EMUL_CONTINUE" on line 1330
> arch/x86/kvm/emulate.c:4557:5-7: Unneeded variable: "rc". Return
> "X86EMUL_CONTINUE" on line 4591
> arch/x86/kvm/emulate.c:1180:5-7: Unneeded variable: "rc". Return
> "X86EMUL_CONTINUE" on line 1202
> 
> Signed-off-by: José Pekkarinen <jose.pekkarinen@foxhound.fi>
> ---
>  arch/x86/kvm/emulate.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index 2673cd5c46cb..c4bb03a88dfe 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -1177,7 +1177,6 @@ static int decode_modrm(struct x86_emulate_ctxt 
> *ctxt,
>  {
>  	u8 sib;
>  	int index_reg, base_reg, scale;
> -	int rc = X86EMUL_CONTINUE;
>  	ulong modrm_ea = 0;
> 
>  	ctxt->modrm_reg = ((ctxt->rex_prefix << 1) & 8); /* REX.R */
> @@ -1199,16 +1198,16 @@ static int decode_modrm(struct x86_emulate_ctxt 
> *ctxt,
>  			op->bytes = 16;
>  			op->addr.xmm = ctxt->modrm_rm;
>  			kvm_read_sse_reg(ctxt->modrm_rm, &op->vec_val);
> -			return rc;
> +			return X86EMUL_CONTINUE;
>  		}
>  		if (ctxt->d & Mmx) {
>  			op->type = OP_MM;
>  			op->bytes = 8;
>  			op->addr.mm = ctxt->modrm_rm & 7;
> -			return rc;
> +			return X86EMUL_CONTINUE;
>  		}
>  		fetch_register_operand(op);
> -		return rc;
> +		return X86EMUL_CONTINUE;
>  	}
> 
>  	op->type = OP_MEM;
> @@ -1306,14 +1305,12 @@ static int decode_modrm(struct x86_emulate_ctxt 
> *ctxt,
>  		ctxt->memop.addr.mem.ea = (u32)ctxt->memop.addr.mem.ea;
> 
>  done:
> -	return rc;
> +	return X86EMUL_CONTINUE;
>  }
> 
>  static int decode_abs(struct x86_emulate_ctxt *ctxt,
>  		      struct operand *op)
>  {
> -	int rc = X86EMUL_CONTINUE;
> -
>  	op->type = OP_MEM;
>  	switch (ctxt->ad_bytes) {
>  	case 2:
> @@ -1327,7 +1324,7 @@ static int decode_abs(struct x86_emulate_ctxt 
> *ctxt,
>  		break;
>  	}
>  done:
> -	return rc;
> +	return X86EMUL_CONTINUE;
>  }
> 
>  static void fetch_bit_operand(struct x86_emulate_ctxt *ctxt)
> @@ -4554,8 +4551,6 @@ static unsigned imm_size(struct x86_emulate_ctxt 
> *ctxt)
>  static int decode_imm(struct x86_emulate_ctxt *ctxt, struct operand 
> *op,
>  		      unsigned size, bool sign_extension)
>  {
> -	int rc = X86EMUL_CONTINUE;
> -
>  	op->type = OP_IMM;
>  	op->bytes = size;
>  	op->addr.mem.ea = ctxt->_eip;
> @@ -4588,7 +4583,7 @@ static int decode_imm(struct x86_emulate_ctxt
> *ctxt, struct operand *op,
>  		}
>  	}
>  done:
> -	return rc;
> +	return X86EMUL_CONTINUE;
>  }
> 
>  static int decode_operand(struct x86_emulate_ctxt *ctxt, struct 
> operand *op,

     Sorry, this is a false positive, please skip it.

     José.
