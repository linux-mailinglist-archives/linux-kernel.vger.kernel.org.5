Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8470764407
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 04:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjG0CzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 22:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjG0CzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 22:55:22 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A1E1BCB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 19:55:20 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-403f65a3f8cso2749221cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 19:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690426519; x=1691031319;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=531ExcdQJrOXcgPUVOBto/W+I+a7TtCPVuUjr2N2/aQ=;
        b=vRL1ggbH5B1zpDwkOroc/uItz455YfapqCRxequLrO6uleNZvr5iCG8fBMB2Qu1L/a
         ik0JRZ90e602CIptGGY0srrNWtLQKC3UfEoh9GRK3rCp/PGEDdKGABWHNBd/h3TlN/VE
         ELK9p9lK7QP+ZIoFd19xRo2fSlo9Pdz3TlIXY3okSHiCwlOeso8OHJEJd2T41MRgpzW7
         hCMSextIqg78hUgYrLKAw4SAxRq6mPF+VPvrsNkDDAHDX9telw00yL+gSCcIpYpOinvZ
         pIsiSwqSc3RTcdhLc5Ya4R4AbswPf/OFCpuO9dKVbZY57DZDBs2GgJw9iKMLTJxqxrK2
         Cj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690426519; x=1691031319;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=531ExcdQJrOXcgPUVOBto/W+I+a7TtCPVuUjr2N2/aQ=;
        b=dcYC93fDj0Zqsj9+6jp3bvnciQi2UtM9bLmwvGq0LQuaXkHXo2PwlHHngT7dCULcy2
         YzFKKsysnYv6TW9Np9HxByTOkK3Jhn1E9hcm4QOzGe+nDIrgq+OKHLfUpNqpf2AKC1Of
         wxyT6p7d216/YZS8D6gdH2gXvvKVDvb+9+12YkU4Ny+XuWrHz9etenXFK7U69bO6gBGP
         IQLd+/BUQzJTlgng3Yox/WA3fSdAvepL09TMLWPf3db2LC/FgRlQrazYO+j9T6evrm/o
         qKlxDcY0e3v6Fsj/M2WYGWXexihnVBm8W7ReiBx3F0edwvK0UTuVA/d0OXDMzbc7K3CJ
         3mHw==
X-Gm-Message-State: ABy/qLYTjklM+5x098Ym430jr2+aNQnLhV/DgLP+2hAQJkM/1vubABM1
        XfF0kNVyNrFubQruUlOsaCIc+Hu7c1Eu/FlMbeFONQ==
X-Google-Smtp-Source: APBJJlHZROck17kapwWRhXcNpBH3CZmmLUah1FtlMUqKT3pHFFOEeYj+ltngtIU6g3Deh/7rrh7eV6NxvryjYt8cTKY=
X-Received: by 2002:ac8:7e8b:0:b0:3ff:42df:7bfd with SMTP id
 w11-20020ac87e8b000000b003ff42df7bfdmr4292832qtj.63.1690426519062; Wed, 26
 Jul 2023 19:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230622085112.1521-1-masahisa.kojima@linaro.org>
 <20230622085112.1521-5-masahisa.kojima@linaro.org> <5fe03be6-8c95-0bfa-687d-68e7ddffd97c@siemens.com>
 <ZJSZbmUz583pszny@hera> <CADQ0-X8TMQoViFW_zFCrOK6yjOqp-X8zQc6c2qsUcWZ5=Suugg@mail.gmail.com>
 <CAC_iWj+-h+TbuesypQ-PpwFYOUOZ-vjd2C6dWb1oSBt7jEviPQ@mail.gmail.com> <CADQ0-X8f7PrhMbepp_SCA3cvrUuz0+t1+xUdhx5O1yijsvMsYQ@mail.gmail.com>
In-Reply-To: <CADQ0-X8f7PrhMbepp_SCA3cvrUuz0+t1+xUdhx5O1yijsvMsYQ@mail.gmail.com>
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
Date:   Thu, 27 Jul 2023 11:55:08 +0900
Message-ID: <CADQ0-X9Rvo2FZ_1y6t_KxOrLCEf0WN13YXyH9z4Ya15U4xPm_A@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2023 at 13:49, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> Hi Ilias,
>
> On Mon, 24 Jul 2023 at 19:22, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Kojima-san,
> >
> > On Mon, 24 Jul 2023 at 05:53, Masahisa Kojima
> > <masahisa.kojima@linaro.org> wrote:
> > >
> > > Hi Ilias, Jan,
> > >
> > > On Fri, 23 Jun 2023 at 03:56, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi Kojima-san, Jan
> > > >
> > > > On Thu, Jun 22, 2023 at 04:58:50PM +0200, Jan Kiszka wrote:
> > > > > On 22.06.23 10:51, Masahisa Kojima wrote:
> > > > > > efivar operation is updated when the tee_stmm_efi module is probed.
> > > > > > tee_stmm_efi module supports SetVariable runtime service,
> > > > > > but user needs to manually remount the efivarfs as RW to enable
> > > > > > the write access if the previous efivar operation does not support
> > > > > > SerVariable and efivarfs is mounted as read-only.
> > > > > >
> > > > > > This commit notifies the update of efivar operation to
> > > > > > efivarfs subsystem, then drops SB_RDONLY flag if the efivar
> > > > > > operation supports SetVariable.
> > > > >
> > > > > But it does not re-add it and prevents further requests to the TA (that
> > > > > will only cause panics there) when the daemon terminates, does it?
> > > >
> > > > It doesn't, but I think I got a better way out.  Even what you suggest won't
> > > > solve the problem entirely.  For the sake of context
> > > > - The kernel decides between the RO/RW depending on the SetVariable ptr
> > > > - The stmm *module* registers and swaps the RT calls -- and the ptr is now
> > > > valid.  Note here that the module probe function will run only if the
> > > > supplicant is running
> > > > - Once the module is inserted the filesystem will be remounted even without
> > > > the supplicant running, which would not trigger an oops, but an hard to
> > > > decipher error message from OP-TEE.
> > > >
> > > > So even if we switch the permissions back to RO when the supplicant dies,
> > > > someone can still remount it as RW and trigger the same error.
> > > >
> > > > Which got me thinking and staring the TEE subsystem a bit more.  The
> > > > supplicant is backed by a /dev file, which naturally has .open() and
> > > > .release() callbacks.  Why don't we leave the module perform the initial
> > > > setup -- e.g talk to StMM and make sure it's there, setup the necessary
> > > > buffers etc and defer the actual swapping of the efivar ops and the
> > > > filesystem permissions there?  I might 'feel' a bit weird, but as I
> > > > mentioned the module probe function only runs if the supplicant is running
> > > > anyway
> > >
> > > I think we are discussing two issues.
> > >
> >
> > Yes
> >
> > > 1) efivar ops is not restored when the tee-supplicant daemon terminates.
> > >
> > > The patch[1] sent by Sumit addresses this issue.
> > > Thanks to this patch, 'remove' callback of tee_stmm_efi_driver is called
> > > when the tee-supplicant daemon terminates, then restore the previous efivar ops
> > > and SB_RDONLY flag if necessary.
> >
> > Ok but that didn't fix the original error Jan reported and I am not
> > sure about the patch status
>
> I think the patch is pending because the fTPM still causes panic when the system
> shuts down.
> https://lore.kernel.org/all/452472c5-ef30-ac30-6e4e-954f53b48315@siemens.com/
>
> This is fTPM specific issue and is unrelated to the tee-based
> SetVariable runtime series itself.
>
> >
> > >
> > > 2) cause panic when someone remounts the efivarfs as RW even if
> > > SetVariable is not supported.
> >
> > Yes, this [0] is fixing that issue
>
> Thank you, I will include this patch in the next submission.
>
> Anyway, the GetVariable() runtime service backed by the U-Boot variable service
> does not work from kernel v6.4.0, so I will investigate this issue.

I found that the QueryVariableInfo EFI API is required since this patch[2].
Current U-Boot does not support QueryVariableInfo runtime service.
Anyway this is not directly related to this series.
After efivar ops is replaced by the tee-based one, variable access works fine.

[2] https://lore.kernel.org/all/20230517153812.2010174-1-anisse@astier.eu/

Thanks,
Masahisa Kojima

>
> Thanks,
> Masahisa Kojima
>
> >
> > [0] https://lore.kernel.org/linux-efi/20230609094532.562934-1-ilias.apalodimas@linaro.org/
> > Thanks
> > /Ilias
> > >
> > > [1] https://lore.kernel.org/all/20230607151435.92654-1-sumit.garg@linaro.org/
> > >
> > > Thanks,
> > > Masahisa Kojima
> > >
> > > >
> > > > Cheers
> > > > /Ilias
> > > >
> > > > >
> > > > > Jan
> > > > >
> > > > > --
> > > > > Siemens AG, Technology
> > > > > Competence Center Embedded Linux
> > > > >
