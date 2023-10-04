Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644F07B8344
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243081AbjJDPNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243038AbjJDPNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:13:19 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4528DBF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 08:13:15 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-563ab574cb5so1770118a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 08:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696432394; x=1697037194; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WPvrdimJk+6ET5yzeMFp8sbCNMwce3CbuZMRLA/5qXQ=;
        b=QqhqBkEXlbKTock6z0wk4sCYAeseisPQPGwrPY24N0b5m7GwvUb90+Myk6znN1xZ+Y
         EBq5uEqBZD2kyI3gxLEsMEHc+KpNIA1UUr1cKHp+GVTMeewLvnlTz9sdv0UzL0WMi6QZ
         hyebyElSN4CH39cRGJBmhGnrdOth0BGK17mc3WBPvwv1WEC9p2t+xX7Ubk7VHDVVHg3M
         xnp7wu/0As5WmKUNAbDaqb1FgYRMFllQgzAYNBKZiwvUMVi98Qpgtub6lzP4BkqAOyiE
         jPPtEmn95zgLE10c3Z2VBWU2NIoIaPZPXfSXJ7u7UZgKCFAQR9tIx0HEge5Jb0URlPEm
         z3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696432394; x=1697037194;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WPvrdimJk+6ET5yzeMFp8sbCNMwce3CbuZMRLA/5qXQ=;
        b=HLwuOY6tLIBPizcYhszZtnpoiPubDqxLI85e6J+qMylM+D67WRPtKJgtJw5CiiwKf9
         EXNi2tvqYLU8pgMk6tpBlCmxAZ2uF5SGiqfg8CTS73lQsdDAutW+rFwyjEmf033a/N2H
         UivicgwtmNmC5h+tNzh0HOrdf9dF/CktlT0z+yicx/XMlhS9qWbsBrFj8dOVcVXDKr4x
         3km7mhyui6w7pisJnpibP/PcHCGN+wfBZPn/ITCk1pW3a8FhiI8OJGJySEZkqNZghvNQ
         qskuJtSc4ucU7g7cmMl4P8IwAEEuP7K+IfWgarjx1xf5yofjMbz2ELeZtZIfblnk+l/1
         AZHQ==
X-Gm-Message-State: AOJu0YxizrXyMta4iFxdqBsX6V9R4ZLGdBL5sjahBvphWHIV0XCtFAqG
        f4pvuOF5xaBN25fA2tu+fC1NOGjRlWA=
X-Google-Smtp-Source: AGHT+IEKa17mmr2ebFxTfA1V0ZPXedWSM8wuYgAPoTve4i5P/ko83KyT+5QmGNULOttyAQXT8DIABAa9e8w=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:d583:b0:262:ffa8:f49d with SMTP id
 v3-20020a17090ad58300b00262ffa8f49dmr42120pju.9.1696432394658; Wed, 04 Oct
 2023 08:13:14 -0700 (PDT)
Date:   Wed, 4 Oct 2023 08:13:12 -0700
In-Reply-To: <20231004133827.107-2-julian.stecklina@cyberus-technology.de>
Mime-Version: 1.0
References: <20231004133827.107-1-julian.stecklina@cyberus-technology.de> <20231004133827.107-2-julian.stecklina@cyberus-technology.de>
Message-ID: <ZR2BCHmqofCcAuBM@google.com>
Subject: Re: [PATCH 2/2] KVM: x86: rename push to emulate_push for consistency
From:   Sean Christopherson <seanjc@google.com>
To:     Julian Stecklina <julian.stecklina@cyberus-technology.de>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023, Julian Stecklina wrote:
> push and emulate_pop are counterparts. Rename push to emulate_push and
> harmonize its function signature with emulate_pop. This should remove
> a bit of cognitive load when reading this code.
> 
> Signed-off-by: Julian Stecklina <julian.stecklina@cyberus-technology.de>
> ---
>  arch/x86/kvm/emulate.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index fc4a365a309f..33f3327ddfa7 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -1819,22 +1819,23 @@ static int writeback(struct x86_emulate_ctxt *ctxt, struct operand *op)
>  	return X86EMUL_CONTINUE;
>  }
>  
> -static int push(struct x86_emulate_ctxt *ctxt, void *data, int bytes)
> +static int emulate_push(struct x86_emulate_ctxt *ctxt, const unsigned long *data,
> +			u8 op_bytes)

I like the rename and making @data const, but please leave @bytes as an int.

Regarding @bytes versus @len, my vote is to do s/len/bytes for emulate_pop() and
emulate_popf().
