Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44D678C00D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjH2IMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbjH2IMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:12:34 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D7B9E
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:12:31 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-52a4818db4aso5278423a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693296750; x=1693901550;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sUBkOkSn+fNpGKbpzoAsa+XXVS4RDDY3/CCAT4NKkbc=;
        b=kmpXEXRscSEfs8/aucVTnvjrPlKskVkA6tKp60RdaHdfC7KfgnQWzGySl92MPtrftq
         4cTG2V+e/bpNAqL7Qpm1QJRjM5u2hKbYzJJ2pihgP6EnXQVm6E5OcmcM83f23IVWSR2J
         Sm4ubvbLpl0JHbcoCViklc8IjQmFkCCCbJWrAiby3E7HX53eehHW8Wvv8uigFBBpijI7
         v6pitK6q1XWWC5jXHH4r3/gIe/a8w0cE3E8ZsTfKvgu03Wo5hG1SVkKRR1zRBiVpX6y+
         j2B16xN51j7E88O7JfB90ypICR9KNWrdGwsUvWuWW81waPt/oSy7DVMcSRDNaWC8/FL9
         O/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693296750; x=1693901550;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sUBkOkSn+fNpGKbpzoAsa+XXVS4RDDY3/CCAT4NKkbc=;
        b=GaaDgnRj+nSGoaqmWr5jHDakQaxx/HyjLDmdD7FAPo5NE1asqJ0nK/5jG3cQdPG7SN
         xSCAEsZSXALYY5WTiqgCJwqvTv2mdaXLbf08re69ZL/YJC/IbRGyexCKXlhIn43XRonx
         Dz1oLfZMtQAxSsd4ZTLg0e5uhDMLnLYkwRp0CfY0r7aYDFpWCguPSKQ7xrbiQjViB47q
         x6xyIN6s50K9ENkNQ9kvHnPi+IliCD/znd5a1udEm7zLMlrB2PLHFeGhg9VTULLnW72G
         TujUF3USsEE1Whoiec19KYcwOMj8hgC3EZy1Ln0pdhhrL3w/tZhNqXfMOM/72eiAy4o5
         JQYw==
X-Gm-Message-State: AOJu0Yx5n5/cce1Y8NfVpJ2DrCbK1qrI4kDnzsOiprbYpZElz/wAaOU3
        icZgu28Ue+hHA+kWtscPIEo/8imioyo=
X-Google-Smtp-Source: AGHT+IH1P3iU+c+MfeDSKphQ/LNuOLt5BV0h6BGz1lW6rAJrEULK+IouT/ZMobUfiO5Fto9u4sZNIA==
X-Received: by 2002:a17:906:3182:b0:9a5:d095:a8e3 with SMTP id 2-20020a170906318200b009a5d095a8e3mr538678ejy.13.1693296749919;
        Tue, 29 Aug 2023 01:12:29 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id e8-20020a170906044800b009a57d30df89sm5339400eja.132.2023.08.29.01.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 01:12:29 -0700 (PDT)
Date:   Tue, 29 Aug 2023 10:12:28 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        bjorn@kernel.org
Subject: Re: [PATCH] riscv: provide riscv-specific is_trap_insn()
Message-ID: <ZO2obGvrqWsl1VvY@nam-dell>
References: <20230827205641.46836-1-namcaov@gmail.com>
 <CAJF2gTQysBBSbtFcx1uY_ztTnzN5jRWpG2OD4O3aJ0u9Ekwsag@mail.gmail.com>
 <20230829-unbridle-condense-2fc45a442bb6@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230829-unbridle-condense-2fc45a442bb6@wendy>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 07:26:54AM +0100, Conor Dooley wrote:
> On Tue, Aug 29, 2023 at 01:56:34PM +0800, Guo Ren wrote:
> > On Mon, Aug 28, 2023 at 4:56 AM Nam Cao <namcaov@gmail.com> wrote:
> > >
> > > uprobes expects is_trap_insn() to return true for any trap instructions,
> > > not just the one used for installing uprobe. The current default
> > > implementation only returns true for 16-bit c.ebreak if C extension is
> > > enabled. This can confuse uprobes if a 32-bit ebreak generates a trap
> > > exception from userspace: uprobes asks is_trap_insn() who says there is no
> > > trap, so uprobes assume a probe was there before but has been removed, and
> > > return to the trap instruction. This cause an infinite loop of entering
> > > and exiting trap handler.
> > >
> > > Instead of using the default implementation, implement this function
> > > speficially for riscv which checks for both ebreak and c.ebreak.
> > >
> > > Fixes: 74784081aac8 ("riscv: Add uprobes supported")
> > > Signed-off-by: Nam Cao <namcaov@gmail.com>
> > > ---
> > >  arch/riscv/kernel/probes/uprobes.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probes/uprobes.c
> > > index 194f166b2cc4..91f4ce101cd1 100644
> > > --- a/arch/riscv/kernel/probes/uprobes.c
> > > +++ b/arch/riscv/kernel/probes/uprobes.c
> > > @@ -3,6 +3,7 @@
> > >  #include <linux/highmem.h>
> > >  #include <linux/ptrace.h>
> > >  #include <linux/uprobes.h>
> > > +#include <asm/insn.h>
> > >
> > >  #include "decode-insn.h"
> > >
> > > @@ -17,6 +18,15 @@ bool is_swbp_insn(uprobe_opcode_t *insn)
> > >  #endif
> > >  }
> >  >
> > > +bool is_trap_insn(uprobe_opcode_t *insn)
> > > +{
> > > +#ifdef CONFIG_RISCV_ISA_C
> 
> > Can we remove the CONFIG_RISCV_ISA_C? As you said, "uprobes expects
> > is_trap_insn() to return true for any trap instructions". So userspace
> > wouldn't be limited by CONFIG_RISCV_ISA_C.
> 
> Isn't the RISCV_ISA_C required because there's a different encoding for
> EBREAK vs C_EBREAK?

riscv_insn_is_c_ebreak() can be used without enabling RISCV_ISA_C, so no it's
not required.

Best regards,
Nam
