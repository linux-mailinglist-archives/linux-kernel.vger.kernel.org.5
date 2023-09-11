Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4077479A552
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 10:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbjIKIEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 04:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjIKIEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:04:40 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0180ECDC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:04:34 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-501be2d45e0so6907226e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694419473; x=1695024273; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D+tzn08T+6+E+bZdqrGIMhxWBEfdVKjukvqeuQN2voU=;
        b=QmMtfsjnsp9EEZHIdqOCGe8okx1SksyMJ0iQWYBdKAgQT9Vwno4j92iVO32MVurRQX
         Pv5U8G+AO5+BBznHv/r0DObeQlc0SPXWaittpRdiY6H4CeHi07D1g2NK5yzlUjnOqKkS
         Ps99QJynBVKFqd8slvYpNbfRApy1gXNCBwbfIJ1kS4NH266hNrpGM/wCkhNy0K03yiCO
         VurOmz2XQAzQDRVX/Q73q5JDzHJeNdAojT1VnOJa31tPeQx4UcTD5FNbKjtJ7QJ2Z02+
         8492OE6keOnv9XUGicWitS1uX+S/+aMV7XPxC5ZzYcd4ZUVWMBQA3xWWACmpvye7/QEY
         pF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694419473; x=1695024273;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D+tzn08T+6+E+bZdqrGIMhxWBEfdVKjukvqeuQN2voU=;
        b=ivCNG3NwB+oeC/nTz9/B4g6iI9gTHRfYeqs5WxYJKqotIc3Bz2rA4i1ugpsXK+p+8+
         MCBBhK1u8/Zv2k4zOKc1f04ef06kyx26nUy2yJy2u72Lgfjrt9kSKqtZmVNiAMxiz8+W
         wdrQYCWJdL64uI/1UvJdKnhJzq1ynXQvKKbFxOAXU1MIrZFDo0zvgdpRYGjBvkF13OoY
         IXPKHwILZHMtsQ7YocUCHJgSqxySw4nW7yJ1/ngkQ76VeBWgrtPVHZgXHkM6lk7b/u/Z
         POfin9/FWvz3yrhbCibPhPbptjWCNnsHzReU2x1XCW0wgWhxIne8rQKpmxuUZsA5qcbe
         2zQA==
X-Gm-Message-State: AOJu0YxDo/XT4u80pAoNA7Z8UQwv1qB8wK6zEg27iijxlbnbzuftVRGq
        WdtHrQTdLt9V86WK69bl1zqJhqD1zoitqRKrvK/rGg==
X-Google-Smtp-Source: AGHT+IHD1Dcx6b/AtttlAsIHxA5yYdjV+3IuhNDYqhTPQAls3U588hqdsOfZUDtTP16vp/M2CiMRwTGPfJRUhUv40F0=
X-Received: by 2002:a05:6512:159d:b0:4f8:6dfd:faa0 with SMTP id
 bp29-20020a056512159d00b004f86dfdfaa0mr8039657lfb.2.1694419473134; Mon, 11
 Sep 2023 01:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230910045445.41632-1-heinrich.schuchardt@canonical.com>
 <ZP4QEvhzO5cOt6lT@gpdmax> <1bc137b6-6006-42cd-9f6d-c523fc753d63@canonical.com>
 <CAMj1kXGChp5TOk5h1EC9R7TBn=QDVo_FU5VhHjp8nSz2GJ6wtA@mail.gmail.com>
In-Reply-To: <CAMj1kXGChp5TOk5h1EC9R7TBn=QDVo_FU5VhHjp8nSz2GJ6wtA@mail.gmail.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Mon, 11 Sep 2023 11:03:57 +0300
Message-ID: <CAC_iWjLdA=gFkdB2LhOe9J-d_G=estenCWgYyCenqOYfZSFd+A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] efivarfs: fix statfs() on efivarfs
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Anisse Astier <anisse@astier.eu>, Jeremy Kerr <jk@ozlabs.org>,
        Anisse Astier <an.astier@criteo.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Mon, 11 Sept 2023 at 09:45, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Sun, 10 Sept 2023 at 22:42, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > On 9/10/23 20:53, Anisse Astier wrote:
> > > Hi Heinrich,
> > >
> > > On Sun, Sep 10, 2023 at 06:54:45AM +0200, Heinrich Schuchardt wrote:
> > >> Some firmware (notably U-Boot) provides GetVariable() and
> > >> GetNextVariableName() but not QueryVariableInfo().
> > >
> > >  From a quick search, it seems u-boot, does support QueryVariableInfo, is
> > > it on a given version ?
> > >
> > > https://elixir.bootlin.com/u-boot/v2023.07.02/source/lib/efi_loader/efi_variable.c#L391
> >
> > QueryVariableInfo() and SetVariable() are available before
> > ExitBootServices(), i.e. in Linux' EFI stub.
> >
> > ExitBootServices() results in calling efi_variables_boot_exit_notify()
> > which disables these services during the UEFI runtime.
> >
> > >
> > >>
> > >> With commit d86ff3333cb1 ("efivarfs: expose used and total size") the
> > >> statfs syscall was broken for such firmware.
> > >
> > > Could you be more specific ? What breaks, and what regressed ? I imagine
> > > it could be some scripts running df, but maybe you had something else in
> > > mind ?
> >
> > Some more details can be found in
> > https://bugs.launchpad.net/ubuntu/+source/linux-meta-riscv/+bug/2034705.
> >
> > Though EFI variables are exposed via GetVariable() and
> > GetNextVariableName() the efivar command refuses to display variables
> > when statfs() reports an error.
> >
> > >
> > >>
> > >> If QueryVariableInfo() does not exist or returns an error, just report the
> > >> file-system size as 0 as statfs_simple() previously did.
> > >
> > > I considered doing this [2] , but we settled on returning an error
> > > instead for clarity:
> > > https://lore.kernel.org/linux-efi/20230515-vorgaben-portrait-bb1b4255d31a@brauner/
> > >
> > > I still think it would be a good idea if necessary.
> >
> > We should never break user APIs.
> >
>
> Indeed.
>
> > >
> > > On the approach, I prefer what Ard proposed, to fall back to the old
> > > approach. I think the difference in block size could also be a good
> > > marker that something wrong is happening:
> > > https://lore.kernel.org/linux-efi/CAMj1kXEkNSoqG4zWfCZ8Ytte5b2SzwXggZp21Xt17Pszd-q0dg@mail.gmail.com/
> >
> > This will allow user code making assumptions based on block size:
> > If block size > 1, assume setting variables is possible.
> >
> > We should really avoid this.
> >
>
> I agree that having different block sizes depending on which code path
> is taken is not great. But that is the situation we are already in,
> given that older kernels will always report PAGE_SIZE. And actually,
> PAGE_SIZE does not make sense either - PAGE_SIZE could be larger than
> 4k on ARM for instance, so the efivarfs block size will be dependent
> on the page size of the kernel you happened to boot.
>
> So I think we should go with the below:
>
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -32,10 +32,16 @@ static int efivarfs_statfs(struct dentry *dentry,
> struct kstatfs *buf)
>         u64 storage_space, remaining_space, max_variable_size;
>         efi_status_t status;
>
> -       status = efivar_query_variable_info(attr, &storage_space,
> &remaining_space,
> -                                           &max_variable_size);
> -       if (status != EFI_SUCCESS)
> -               return efi_status_to_err(status);
> +       /* Some UEFI firmware does not implement QueryVariableInfo() */
> +       storage_space = remaining_space = 0;
> +       if (efi_rt_services_supported(EFI_RT_SUPPORTED_QUERY_VARIABLE_INFO)) {
> +               status = efivar_query_variable_info(attr, &storage_space,
> +                                                   &remaining_space,
> +                                                   &max_variable_size);
> +               if (status != EFI_SUCCESS && status != EFI_UNSUPPORTED)
> +                       pr_warn_ratelimited("query_variable_info()
> failed: 0x%lx\n",
> +                                           status);
> +       }

I think this is better, but shouldn't we initialize the status
variable now? Or is there more code following that I am missing?

Thanks
/Ilias


>
>         /*
>          * This is not a normal filesystem, so no point in pretending
> it has a block
