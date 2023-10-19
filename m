Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2CD7CF098
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 09:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbjJSHCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 03:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjJSHCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 03:02:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E9FAB;
        Thu, 19 Oct 2023 00:02:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2FCC433CC;
        Thu, 19 Oct 2023 07:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697698923;
        bh=lbbfOAE2NRbG+DqD8tGHOqkfq02lJ0zD4vLMWLBVXd8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fpKNZrfWCGweE0vQMZobOoeffRV9deMwwKPPY+CFErCDCixE5xEFNmYzp7B9l50m1
         X3dOSMfXsNahVQsOv4sR6f87gVWRv6q78WgUWEERSeMJM0W/vOwRvfUWj/UiWeacs6
         64lOZrpDFIzxIywJmxDw2xTA72FaxBGTaLrhRWMEm56fkKmEWp2aQQK57RlyqDnynL
         /aEdigJ8HSHpw+7b0jwYW7cCSof5+km6a+/8GwGksejb9ggsaXouedOl9MpXwQKb+O
         tlsCSUi+BGc8VxtUtpHeiSVzwcMr3u5tp+ekOyJB29hJoRQSPOaW1BPXKVoBugXW0d
         8D4CkIFRG9X0Q==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2c54c8934abso14326991fa.0;
        Thu, 19 Oct 2023 00:02:03 -0700 (PDT)
X-Gm-Message-State: AOJu0YzbQl709B9dx7E32r+ukojGsh0Sm3f8fOd/N03k8n7TweXSjpJH
        vVkcMEOH7eG/9VOzcgh1Nj+jUxH8T3X6IcxxQ5Y=
X-Google-Smtp-Source: AGHT+IECn5/3hSSgZelWrViiuEE1ozNKbEMJudisUiyBPuZwBpD82KH3lOw2MG5qcO5qgnAVA56sFVDrfdR0QOGwW0I=
X-Received: by 2002:a2e:8715:0:b0:2c5:1c4:9005 with SMTP id
 m21-20020a2e8715000000b002c501c49005mr673055lji.32.1697698921566; Thu, 19 Oct
 2023 00:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231019145404.63bd38ca@canb.auug.org.au> <20231019151927.2a20d800@canb.auug.org.au>
In-Reply-To: <20231019151927.2a20d800@canb.auug.org.au>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 19 Oct 2023 09:01:47 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGvDozDhomY17UoTKbf+yWvxdsAhCGXYoV+m3q0rjjM-w@mail.gmail.com>
Message-ID: <CAMj1kXGvDozDhomY17UoTKbf+yWvxdsAhCGXYoV+m3q0rjjM-w@mail.gmail.com>
Subject: Re: linux-next: manual merge of the tip tree with the efi-fixes tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023 at 06:19, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> On Thu, 19 Oct 2023 14:54:04 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Today's linux-next merge of the tip tree got a conflict in:
> >
> >   drivers/firmware/efi/libstub/x86-stub.c
> >
> > between commit:
> >
> >   db7724134c26 ("x86/boot: efistub: Assign global boot_params variable")
> >
> > from the efi-fixes tree and commit:
> >
> >   50dcc2e0d62e ("x86/boot: efistub: Assign global boot_params variable")
> >
> > from the tip tree.
> >
> > I fixed it up (I just arbitrarily chose the former) and can carry the
> > fix as necessary. This is now fixed as far as linux-next is concerned,
> > but any non trivial conflicts should be mentioned to your upstream
> > maintainer when your tree is submitted for merging.  You may also want
> > to consider cooperating with the maintainer of the conflicting tree to
> > minimise any particularly complex conflicts.
>
> Well, that didn't work :-(
>
> I ave used the latter version (i.e. the tip tree one) this time.
>

Apologies, I should have updated or reverted the efi-fixes one but I
still need to find a way to deal with this issue on the fixes branch
too.

Note that the hunk below needs to be dropped or the build will fail.



--- a/drivers/firmware/efi/libstub/x86-stub.h
+++ b/drivers/firmware/efi/libstub/x86-stub.h
@@ -2,6 +2,8 @@

 #include <linux/efi.h>

+extern struct boot_params *boot_params_pointer asm("boot_params");
+
 extern void trampoline_32bit_src(void *, bool);
 extern const u16 trampoline_ljmp_imm_offset;
