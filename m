Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EE075E9E9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 04:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjGXCxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 22:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjGXCxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 22:53:09 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFC5C4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 19:53:08 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6b9c5362a51so3009338a34.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 19:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690167187; x=1690771987;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i3Ul/yib6AVpUBR82WT2XWQzdvG86SoceqyAVEO8xa4=;
        b=hobKpHD4tELSbF98E97BcgxRKfDSmmNBdxraOcygmOsuhC6MzBr601WutWaCExDpDK
         VKqSOIVPehUE39YZ392arCdQdSuyn4imYSFe+OG9rb/qLcsxQMKhoy9aLxzqV/OedpH+
         IYqKAtR7FBD0NozRn7hDC/sx1NTYA3eZqmPJ/4rBrRR/U8u/K6tQlX+K4SojM4wGX4qf
         euO9NLQWlADfXWptlmq0E2rCHHvO8Ct8RUKdJAtfE0Xq/oJIGjbIhuhncs2cVUCi+Wf/
         //argLKKwMOcaTOyFzlBXWgmbHyDMZjitmsKauhKid7YC7nDHUzqvDftyu8DluApK0cR
         gA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690167187; x=1690771987;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i3Ul/yib6AVpUBR82WT2XWQzdvG86SoceqyAVEO8xa4=;
        b=Qaf48UfifCHePDAW2qOBZteWB1b5kxJretF2dF7tGAgf/+LDlnZQbWprtw7F8X8VsT
         JyVIiRzp7xhQfrss+sKTgK1aE/6cHyGhEhRswljFRwoFOn1gvMfD8uGsnzAJW3OmIqHw
         fyzDXdhGw2j5JBv6UYCD7Vy7NR5JCX6X0kNptKSEy0WrM0MJuzl01GsIpiZR15bq5ucx
         5kcCVEVgabKyTWdewUQ2BRzY0DvTWdCU8a0q4tzveWeDjfMTfwU5zX4rlcRwEI138Vop
         a9qJou+4RgeHg6z7Tk+zHtRE7JgkYI1j3HLoNxMohlHfdF2FLRXwcUjoxUwe1kbguZ5Q
         4cmQ==
X-Gm-Message-State: ABy/qLbP2FD4ovaC+EoruNlsPWE4w3w4NbhPYSEKl/iKxO2QHPxXa2+f
        6k0h0CuzNNZk4V6CxuEtyFCE+z0rUN5ylvHQoxPHug==
X-Google-Smtp-Source: APBJJlHjEvy+T8pOFNfKrTVuyZ5HTLua+jMjPTZushYXl9MtOL4QdLkQ5rghLIqMY+Gi/ilPvhQ+yEaiITWuAag+lz4=
X-Received: by 2002:a05:6808:ecc:b0:3a4:3a71:14dc with SMTP id
 q12-20020a0568080ecc00b003a43a7114dcmr10027133oiv.1.1690167187779; Sun, 23
 Jul 2023 19:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230622085112.1521-1-masahisa.kojima@linaro.org>
 <20230622085112.1521-5-masahisa.kojima@linaro.org> <5fe03be6-8c95-0bfa-687d-68e7ddffd97c@siemens.com>
 <ZJSZbmUz583pszny@hera>
In-Reply-To: <ZJSZbmUz583pszny@hera>
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
Date:   Mon, 24 Jul 2023 11:52:56 +0900
Message-ID: <CADQ0-X8TMQoViFW_zFCrOK6yjOqp-X8zQc6c2qsUcWZ5=Suugg@mail.gmail.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ilias, Jan,

On Fri, 23 Jun 2023 at 03:56, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Kojima-san, Jan
>
> On Thu, Jun 22, 2023 at 04:58:50PM +0200, Jan Kiszka wrote:
> > On 22.06.23 10:51, Masahisa Kojima wrote:
> > > efivar operation is updated when the tee_stmm_efi module is probed.
> > > tee_stmm_efi module supports SetVariable runtime service,
> > > but user needs to manually remount the efivarfs as RW to enable
> > > the write access if the previous efivar operation does not support
> > > SerVariable and efivarfs is mounted as read-only.
> > >
> > > This commit notifies the update of efivar operation to
> > > efivarfs subsystem, then drops SB_RDONLY flag if the efivar
> > > operation supports SetVariable.
> >
> > But it does not re-add it and prevents further requests to the TA (that
> > will only cause panics there) when the daemon terminates, does it?
>
> It doesn't, but I think I got a better way out.  Even what you suggest won't
> solve the problem entirely.  For the sake of context
> - The kernel decides between the RO/RW depending on the SetVariable ptr
> - The stmm *module* registers and swaps the RT calls -- and the ptr is now
> valid.  Note here that the module probe function will run only if the
> supplicant is running
> - Once the module is inserted the filesystem will be remounted even without
> the supplicant running, which would not trigger an oops, but an hard to
> decipher error message from OP-TEE.
>
> So even if we switch the permissions back to RO when the supplicant dies,
> someone can still remount it as RW and trigger the same error.
>
> Which got me thinking and staring the TEE subsystem a bit more.  The
> supplicant is backed by a /dev file, which naturally has .open() and
> .release() callbacks.  Why don't we leave the module perform the initial
> setup -- e.g talk to StMM and make sure it's there, setup the necessary
> buffers etc and defer the actual swapping of the efivar ops and the
> filesystem permissions there?  I might 'feel' a bit weird, but as I
> mentioned the module probe function only runs if the supplicant is running
> anyway

I think we are discussing two issues.

1) efivar ops is not restored when the tee-supplicant daemon terminates.

The patch[1] sent by Sumit addresses this issue.
Thanks to this patch, 'remove' callback of tee_stmm_efi_driver is called
when the tee-supplicant daemon terminates, then restore the previous efivar ops
and SB_RDONLY flag if necessary.

2) cause panic when someone remounts the efivarfs as RW even if
SetVariable is not supported.

[1] https://lore.kernel.org/all/20230607151435.92654-1-sumit.garg@linaro.org/

Thanks,
Masahisa Kojima

>
> Cheers
> /Ilias
>
> >
> > Jan
> >
> > --
> > Siemens AG, Technology
> > Competence Center Embedded Linux
> >
