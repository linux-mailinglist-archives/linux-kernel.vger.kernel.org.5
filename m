Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB409762A6F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjGZEtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjGZEtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:49:31 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548951BC3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 21:49:29 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-403af7dfa3aso53864021cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 21:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690346968; x=1690951768;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dWy+eh+XETRHStGfU4VJieNbSzKSrBm8pMucxBT2kKI=;
        b=e6Qm06pHQSNGkbaJML/G/GP9UwQDRG4pMdqBfJYIDXepUHXJnaYsG240pyyKF9zGRk
         3ofXF6F0BElLnsAPEac1/FaB5SS2VtH6bMD2a2SjbyZe5BgubJrpcg9grptI8OaeU0Ze
         k4PUP+AHz5t2W6zJ/ObXMgIM5XT7brJvONUtbFFTYOJTGP5bUL5pxQsCq2aVOPAanARj
         HP4s4Sv/DYKeHCzxLvz9uzijX0274Qif4y76TMawkl9va6nfY1rCB+OUcSl9adn9nLRd
         iKiZeb+ndEq8QhOI9ddxQLNCmudJDA6cYR+SUPbSMaSkwt6/en8dBkaD8LSLKwvfnVYO
         5fyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690346968; x=1690951768;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dWy+eh+XETRHStGfU4VJieNbSzKSrBm8pMucxBT2kKI=;
        b=CxqZO0OsWLwOTp+jxlHBXvST9cQjKxMelu3K5zzOHZvCMYhIAGo4RzxcxfOris1GX4
         iLRSO/z22H+3iV3N6Eb/cLCmc+xkHnyoazS9lzBVq6TwlxryR+RKVNGEndUDmiCiRzhT
         TcoF0P5kgwXrY9BAPSib9VcHYOMWKVCaAvMbQRb0CRHg/3lqIE0vYI1boe9GplB+e28m
         SKJmoHQQVaHoeVmSp6HDaor+NtKfNfH3ywSpmJGQJFYqi1fljTP9zWNDB2P9pkV4+WeE
         RGJZF+G0qtw7HX68/tBg1jkBlG2fqHaknzIcha6iXOZlXSoPrSrmlA+Xu0X62wf3+hx8
         1NxQ==
X-Gm-Message-State: ABy/qLZXBraDhEvjsgKscjfcBhAU2Ahhsnm6KUnpwC8Pd/sB47F9poss
        DO8rWfFhMIJNz6pB7nUOdQN6M8LoXAsAJq3Cr+bULA==
X-Google-Smtp-Source: APBJJlEmkmN0bmQ01fCYzevEDlyYdybVkP+Bm8Ahvypn6HQRqqjGqAtCUObPx2TmN0g1CpyO3zhd4eOHMN1ezbtuW+k=
X-Received: by 2002:a05:620a:40c1:b0:75b:23a0:deb7 with SMTP id
 g1-20020a05620a40c100b0075b23a0deb7mr1373583qko.53.1690346968392; Tue, 25 Jul
 2023 21:49:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230622085112.1521-1-masahisa.kojima@linaro.org>
 <20230622085112.1521-5-masahisa.kojima@linaro.org> <5fe03be6-8c95-0bfa-687d-68e7ddffd97c@siemens.com>
 <ZJSZbmUz583pszny@hera> <CADQ0-X8TMQoViFW_zFCrOK6yjOqp-X8zQc6c2qsUcWZ5=Suugg@mail.gmail.com>
 <CAC_iWj+-h+TbuesypQ-PpwFYOUOZ-vjd2C6dWb1oSBt7jEviPQ@mail.gmail.com>
In-Reply-To: <CAC_iWj+-h+TbuesypQ-PpwFYOUOZ-vjd2C6dWb1oSBt7jEviPQ@mail.gmail.com>
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
Date:   Wed, 26 Jul 2023 13:49:17 +0900
Message-ID: <CADQ0-X8f7PrhMbepp_SCA3cvrUuz0+t1+xUdhx5O1yijsvMsYQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] efivarfs: automatically update super block flag
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ilias,

On Mon, 24 Jul 2023 at 19:22, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Kojima-san,
>
> On Mon, 24 Jul 2023 at 05:53, Masahisa Kojima
> <masahisa.kojima@linaro.org> wrote:
> >
> > Hi Ilias, Jan,
> >
> > On Fri, 23 Jun 2023 at 03:56, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Kojima-san, Jan
> > >
> > > On Thu, Jun 22, 2023 at 04:58:50PM +0200, Jan Kiszka wrote:
> > > > On 22.06.23 10:51, Masahisa Kojima wrote:
> > > > > efivar operation is updated when the tee_stmm_efi module is probed.
> > > > > tee_stmm_efi module supports SetVariable runtime service,
> > > > > but user needs to manually remount the efivarfs as RW to enable
> > > > > the write access if the previous efivar operation does not support
> > > > > SerVariable and efivarfs is mounted as read-only.
> > > > >
> > > > > This commit notifies the update of efivar operation to
> > > > > efivarfs subsystem, then drops SB_RDONLY flag if the efivar
> > > > > operation supports SetVariable.
> > > >
> > > > But it does not re-add it and prevents further requests to the TA (that
> > > > will only cause panics there) when the daemon terminates, does it?
> > >
> > > It doesn't, but I think I got a better way out.  Even what you suggest won't
> > > solve the problem entirely.  For the sake of context
> > > - The kernel decides between the RO/RW depending on the SetVariable ptr
> > > - The stmm *module* registers and swaps the RT calls -- and the ptr is now
> > > valid.  Note here that the module probe function will run only if the
> > > supplicant is running
> > > - Once the module is inserted the filesystem will be remounted even without
> > > the supplicant running, which would not trigger an oops, but an hard to
> > > decipher error message from OP-TEE.
> > >
> > > So even if we switch the permissions back to RO when the supplicant dies,
> > > someone can still remount it as RW and trigger the same error.
> > >
> > > Which got me thinking and staring the TEE subsystem a bit more.  The
> > > supplicant is backed by a /dev file, which naturally has .open() and
> > > .release() callbacks.  Why don't we leave the module perform the initial
> > > setup -- e.g talk to StMM and make sure it's there, setup the necessary
> > > buffers etc and defer the actual swapping of the efivar ops and the
> > > filesystem permissions there?  I might 'feel' a bit weird, but as I
> > > mentioned the module probe function only runs if the supplicant is running
> > > anyway
> >
> > I think we are discussing two issues.
> >
>
> Yes
>
> > 1) efivar ops is not restored when the tee-supplicant daemon terminates.
> >
> > The patch[1] sent by Sumit addresses this issue.
> > Thanks to this patch, 'remove' callback of tee_stmm_efi_driver is called
> > when the tee-supplicant daemon terminates, then restore the previous efivar ops
> > and SB_RDONLY flag if necessary.
>
> Ok but that didn't fix the original error Jan reported and I am not
> sure about the patch status

I think the patch is pending because the fTPM still causes panic when the system
shuts down.
https://lore.kernel.org/all/452472c5-ef30-ac30-6e4e-954f53b48315@siemens.com/

This is fTPM specific issue and is unrelated to the tee-based
SetVariable runtime series itself.

>
> >
> > 2) cause panic when someone remounts the efivarfs as RW even if
> > SetVariable is not supported.
>
> Yes, this [0] is fixing that issue

Thank you, I will include this patch in the next submission.

Anyway, the GetVariable() runtime service backed by the U-Boot variable service
does not work from kernel v6.4.0, so I will investigate this issue.

Thanks,
Masahisa Kojima

>
> [0] https://lore.kernel.org/linux-efi/20230609094532.562934-1-ilias.apalodimas@linaro.org/
> Thanks
> /Ilias
> >
> > [1] https://lore.kernel.org/all/20230607151435.92654-1-sumit.garg@linaro.org/
> >
> > Thanks,
> > Masahisa Kojima
> >
> > >
> > > Cheers
> > > /Ilias
> > >
> > > >
> > > > Jan
> > > >
> > > > --
> > > > Siemens AG, Technology
> > > > Competence Center Embedded Linux
> > > >
