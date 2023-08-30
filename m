Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B0678E03F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbjH3TQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243744AbjH3LkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:40:08 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194D81B0;
        Wed, 30 Aug 2023 04:40:05 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-401da71b7c5so12957785e9.2;
        Wed, 30 Aug 2023 04:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693395603; x=1694000403; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IXiOAz/5YldoVo6YMY0MxhgKtPGOmCvkDjVmYV3HYIQ=;
        b=BGNaxjOmAEMdR/I75dUCQ2Rli93aAo60g7FLg2BUM8HFmFroBLlLk9trSmceKZPG0B
         y5XSTcZEoS4LR92UV4fmFV1Mz11isDvPvYF6b/6KgGTIy8ZCxLlHJQQa8zhFkTdA/IEX
         SPMSHXmS1g6/kgY7B3Cr+oF42jgKh4GOPXVg76VILpO3hd2GCe66rix1mCA4pWSBhr5y
         S+TpHP15o3yAJcNhlkloSr/QXRbm8lPMxxd9tY+gLxSj4GF8LAsGUXNKacxAfGUuu5B4
         5+tD1MjFQlyW6orHZyJGzbHdVFotKA974aK2ksmat+zNNHOmufIsvBnyhCda2JINkDbf
         Pk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693395603; x=1694000403;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IXiOAz/5YldoVo6YMY0MxhgKtPGOmCvkDjVmYV3HYIQ=;
        b=Tric1sHA41uSoT0VoHb4LNL6eLFBndWsuLToB3KMaChFdDEs1N57dxOh+A3zghSiS2
         yej/tR89gz5fiM8muddZF9Sp79RnJKj8hj3fIh+iFZCeVVi07V+/+JFq9lJpRbwJH9yT
         EC5hWMc7zjsGuukz0jTswYHvB5UdgCBZm5CtSpzt+MOb5ee3Fu6k0KlpePROtA4r3y43
         x8A1pGmdJNCtRO578iqLnakSJ7sdt6RRpF0LofegVutieoXJlUL63n7UKm2NwR2JhM4O
         zpudrrQZaR8gg4HISPfVKaawnBWkEzOhQJcH5Kph6NhsHPoKfcTKtg690KbGwqhCsUHJ
         cA6g==
X-Gm-Message-State: AOJu0YylLwNb/xwYIYBf6M87lUsNfSE+/OZvfJsg8ync3Xp3dVOmuWpS
        zgSHfVrx7WiB02zwLa/G85zXDoW7j62Ejw==
X-Google-Smtp-Source: AGHT+IHkuPMEpQJgVFAWz/Fgk+XKScfrDr/wI7OXLhwOUAYdh7hAgUFiEqgxB7A6vvAQv0JSJMfCog==
X-Received: by 2002:a7b:cbc6:0:b0:3fe:18be:76f8 with SMTP id n6-20020a7bcbc6000000b003fe18be76f8mr1744032wmi.38.1693395603237;
        Wed, 30 Aug 2023 04:40:03 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id f7-20020a1c6a07000000b003fe407ca05bsm2023455wmc.37.2023.08.30.04.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 04:40:02 -0700 (PDT)
Date:   Wed, 30 Aug 2023 12:40:01 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Guo Ren <guoren@linux.alibaba.com>,
        Oleg Nesterov <oleg@redhat.com>, Guo Ren <guoren@kernel.org>
Cc:     linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        regressions@lists.linux.dev
Subject: mainline build failure due to c8171a86b274 ("csky: Fixup
 -Wmissing-prototypes warning")
Message-ID: <ZO8qkS0Skg9L4xzr@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The latest mainline kernel branch fails to build csky allmodconfig with
the error:

In file included from ./arch/csky/include/asm/ptrace.h:7,
                 from ./arch/csky/include/asm/processor.h:8,
                 from ./include/linux/prefetch.h:15,
                 from drivers/net/ethernet/intel/i40e/i40e_txrx.c:4:
./arch/csky/include/asm/traps.h:43:11: error: expected ';' before 'void'
   43 | asmlinkage void do_trap_unknown(struct pt_regs *regs);
      |           ^~~~~
      |           ;
./arch/csky/include/asm/traps.h:44:11: error: expected ';' before 'void'
   44 | asmlinkage void do_trap_zdiv(struct pt_regs *regs);
      |           ^~~~~
      |           ;
./arch/csky/include/asm/traps.h:45:11: error: expected ';' before 'void'
   45 | asmlinkage void do_trap_buserr(struct pt_regs *regs);
      |           ^~~~~
      |           ;
./arch/csky/include/asm/traps.h:46:11: error: expected ';' before 'void'
   46 | asmlinkage void do_trap_misaligned(struct pt_regs *regs);
      |           ^~~~~
      |           ;
./arch/csky/include/asm/traps.h:47:11: error: expected ';' before 'void'
   47 | asmlinkage void do_trap_bkpt(struct pt_regs *regs);
      |           ^~~~~
      |           ;
./arch/csky/include/asm/traps.h:48:11: error: expected ';' before 'void'
   48 | asmlinkage void do_trap_illinsn(struct pt_regs *regs);
      |           ^~~~~
      |           ;
./arch/csky/include/asm/traps.h:49:11: error: expected ';' before 'void'
   49 | asmlinkage void do_trap_fpe(struct pt_regs *regs);
      |           ^~~~~
      |           ;
./arch/csky/include/asm/traps.h:50:11: error: expected ';' before 'void'
   50 | asmlinkage void do_trap_priv(struct pt_regs *regs);
      |           ^~~~~
      |           ;
./arch/csky/include/asm/traps.h:51:11: error: expected ';' before 'void'
   51 | asmlinkage void trap_c(struct pt_regs *regs);
      |           ^~~~~
      |           ;
./arch/csky/include/asm/traps.h:53:11: error: expected ';' before 'void'
   53 | asmlinkage void do_notify_resume(struct pt_regs *regs,
      |           ^~~~~
      |           ;
In file included from ./arch/csky/include/asm/processor.h:8,
                 from ./include/linux/prefetch.h:15,
                 from drivers/net/ethernet/intel/i40e/i40e_txrx.c:4:
./arch/csky/include/asm/ptrace.h:99:11: error: expected ';' before 'int'
   99 | asmlinkage int syscall_trace_enter(struct pt_regs *regs);
      |           ^~~~
      |           ;
./arch/csky/include/asm/ptrace.h:100:11: error: expected ';' before 'void'
  100 | asmlinkage void syscall_trace_exit(struct pt_regs *regs);
      |           ^~~~~
      |           ;

git bisect pointed to c8171a86b274 ("csky: Fixup -Wmissing-prototypes warning").

Reverting the commit has fixed the build failure.

I will be happy to test any patch or provide any extra log if needed.

#regzbot introduced: c8171a86b27401aa1f492dd1f080f3102264f1ab


-- 
Regards
Sudip
