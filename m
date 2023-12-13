Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C584880E405
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 06:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjLLFjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 00:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjLLFjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 00:39:20 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7BBDB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 21:39:26 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a1e116f2072so1077634766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 21:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702359565; x=1702964365; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2s5wboysl24U2AM1HQ6RieOI3gN8lUlWthT422m2PQk=;
        b=NYBxgkA+jRkPj5s7zFbUpoCQSLgZ9IEPlAwpsM7fC3nmEwkSDK5PQ2rOkJJtqNBEFd
         u7yxxrdSNetR5rZSTm9O8JPOXJ6gsbPLb09C2btFisIn7p/1buCpW80Hj7hGcrXEOG0U
         8GH55Wfk4w9QyYXmE3n6dXY+0XXBs3jTlOt0pAOHSt8/LKDGIeuQhIbKCXGJSfJbe5/s
         XqQvZMlQMRid6TFNauduJt1WZ3b2AkWHYp9ZORBOISzaEDpmExz8j4Uig3cghZoaCNTQ
         t0sKrHSixB+7TbUNBZNi2bJYcOk/CMW8NhzIMoaBA9mObUG4zA1bFPhfr4eL/nj39TFK
         v28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702359565; x=1702964365;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2s5wboysl24U2AM1HQ6RieOI3gN8lUlWthT422m2PQk=;
        b=adfzQlwz8DNbyHMGSsPWiQtozhhAbMQnPzbpv0i0E8KhRET1Y87BBiLTxYPGwGhXIu
         kMhUzUEDLHm3+h73aKgshBhOJ3vMWjJEHSnIWDFY5g5otN7UtqSmRhBw5mIZwCm/T5qI
         yQaVSMCeq/SHBmbtSb5R2+hfcDecTUZZhIBzGO/Fdjf0He3b+SuImmfcYoKcTdQfGXHx
         LWG8OvlByHfLGjCXVlo8A1z1RUk1wPYLInJ02ojwbW+jUQdOSsXXJI2QISO7ISrx+e3+
         yF8ENJpuhZusjrB7mdvgxg/zljt/Vp0OkcqCWpzxpI2RSgJ0ljXvStRneajaVj5wyWS2
         T+fQ==
X-Gm-Message-State: AOJu0YxtQ1qo18jH2dnwr5DJRyJTGLVINr8zZk+FztHrQW0an4EeZwMG
        z5rs8HALvsGDJDB0hdGon480LVxkE8XUXgSBrGz6fQ==
X-Google-Smtp-Source: AGHT+IEQWclwHOrT+FS56iY7acNmevQCSx7YWfP5xzUBTMAZxB5RiX46J8pxyG5l2e6DyAMt0BxLBI/K5tdpNjOHWkU=
X-Received: by 2002:a17:906:51c6:b0:a1e:ac03:9752 with SMTP id
 v6-20020a17090651c600b00a1eac039752mr5190027ejk.52.1702359564795; Mon, 11 Dec
 2023 21:39:24 -0800 (PST)
MIME-Version: 1.0
References: <20231013074540.8980-1-masahisa.kojima@linaro.org>
 <20231013074540.8980-5-masahisa.kojima@linaro.org> <CAMj1kXEFPwqd=Ksc_HuoNSwRUyCNka4E7cWZgkgMq7XHcu2VFA@mail.gmail.com>
In-Reply-To: <CAMj1kXEFPwqd=Ksc_HuoNSwRUyCNka4E7cWZgkgMq7XHcu2VFA@mail.gmail.com>
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
Date:   Tue, 12 Dec 2023 14:39:13 +0900
Message-ID: <CADQ0-X8DJk02oKabzQcMwqKFjr6A6LDWaQDCndKybC6D=9M7vg@mail.gmail.com>
Subject: Re: [PATCH v9 4/6] efivarfs: automatically update super block flag
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
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

Hi Ard,

On Mon, 11 Dec 2023 at 19:02, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 13 Oct 2023 at 09:47, Masahisa Kojima
> <masahisa.kojima@linaro.org> wrote:
> >
> > efivar operation is updated when the tee_stmm_efi module is probed.
> > tee_stmm_efi module supports SetVariable runtime service,
> > but user needs to manually remount the efivarfs as RW to enable
> > the write access if the previous efivar operation does not support
> > SerVariable and efivarfs is mounted as read-only.
> >
> > This commit notifies the update of efivar operation to
> > efivarfs subsystem, then drops SB_RDONLY flag if the efivar
> > operation supports SetVariable.
> >
> > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
>
> Unfortunately, I have identified a problem with this approach.
>
> There are cases where there are multiple instances of struct
> superblock are associated with the efivarfs file system [0].
>
> So I reworked the patch a little - please take the time to double
> check that I did not make any mistakes here.
>
> [0] https://lore.kernel.org/linux-efi/20231208163925.3225018-8-ardb@google.com/T/#u

I think you are referring to this patch[1]?
The modification should be OK, also I have tested it works as expected.

Thank you very much for fixing this.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/fs/efivarfs?id=94f7f6182c72ba642c1f20111681f9cc8621c95f

Thanks,
Masahisa Kojima

>
>
> > ---
> >  drivers/firmware/efi/efi.c  |  6 ++++++
> >  drivers/firmware/efi/vars.c |  8 ++++++++
> >  fs/efivarfs/super.c         | 33 +++++++++++++++++++++++++++++++++
> >  include/linux/efi.h         |  8 ++++++++
> >  4 files changed, 55 insertions(+)
> >
> > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > index 53ae25bbb6ac..d2eec5ed8e5e 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -32,6 +32,7 @@
> >  #include <linux/ucs2_string.h>
> >  #include <linux/memblock.h>
> >  #include <linux/security.h>
> > +#include <linux/notifier.h>
> >
> >  #include <asm/early_ioremap.h>
> >
> > @@ -187,6 +188,9 @@ static const struct attribute_group efi_subsys_attr_group = {
> >         .is_visible = efi_attr_is_visible,
> >  };
> >
> > +struct blocking_notifier_head efivar_ops_nh;
> > +EXPORT_SYMBOL_GPL(efivar_ops_nh);
> > +
> >  static struct efivars generic_efivars;
> >  static struct efivar_operations generic_ops;
> >
> > @@ -427,6 +431,8 @@ static int __init efisubsys_init(void)
> >                 platform_device_register_simple("efivars", 0, NULL, 0);
> >         }
> >
> > +       BLOCKING_INIT_NOTIFIER_HEAD(&efivar_ops_nh);
> > +
> >         error = sysfs_create_group(efi_kobj, &efi_subsys_attr_group);
> >         if (error) {
> >                 pr_err("efi: Sysfs attribute export failed with error %d.\n",
> > diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
> > index e9dc7116daf1..f654e6f6af87 100644
> > --- a/drivers/firmware/efi/vars.c
> > +++ b/drivers/firmware/efi/vars.c
> > @@ -63,6 +63,7 @@ int efivars_register(struct efivars *efivars,
> >                      const struct efivar_operations *ops)
> >  {
> >         int rv;
> > +       int event;
> >
> >         if (down_interruptible(&efivars_lock))
> >                 return -EINTR;
> > @@ -77,6 +78,13 @@ int efivars_register(struct efivars *efivars,
> >
> >         __efivars = efivars;
> >
> > +       if (efivar_supports_writes())
> > +               event = EFIVAR_OPS_RDWR;
> > +       else
> > +               event = EFIVAR_OPS_RDONLY;
> > +
> > +       blocking_notifier_call_chain(&efivar_ops_nh, event, NULL);
> > +
> >         pr_info("Registered efivars operations\n");
> >         rv = 0;
> >  out:
> > diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> > index e028fafa04f3..0f6e4d223aea 100644
> > --- a/fs/efivarfs/super.c
> > +++ b/fs/efivarfs/super.c
> > @@ -14,11 +14,36 @@
> >  #include <linux/slab.h>
> >  #include <linux/magic.h>
> >  #include <linux/statfs.h>
> > +#include <linux/notifier.h>
> >
> >  #include "internal.h"
> >
> >  LIST_HEAD(efivarfs_list);
> >
> > +struct efivarfs_info {
> > +       struct super_block *sb;
> > +       struct notifier_block nb;
> > +};
> > +
> > +static struct efivarfs_info info;
> > +
> > +static int efivarfs_ops_notifier(struct notifier_block *nb, unsigned long event,
> > +                                void *data)
> > +{
> > +       switch (event) {
> > +       case EFIVAR_OPS_RDONLY:
> > +               info.sb->s_flags |= SB_RDONLY;
> > +               break;
> > +       case EFIVAR_OPS_RDWR:
> > +               info.sb->s_flags &= ~SB_RDONLY;
> > +               break;
> > +       default:
> > +               return NOTIFY_DONE;
> > +       }
> > +
> > +       return NOTIFY_OK;
> > +}
> > +
> >  static void efivarfs_evict_inode(struct inode *inode)
> >  {
> >         clear_inode(inode);
> > @@ -255,6 +280,12 @@ static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
> >         if (!root)
> >                 return -ENOMEM;
> >
> > +       info.sb = sb;
> > +       info.nb.notifier_call = efivarfs_ops_notifier;
> > +       err = blocking_notifier_chain_register(&efivar_ops_nh, &info.nb);
> > +       if (err)
> > +               return err;
> > +
> >         INIT_LIST_HEAD(&efivarfs_list);
> >
> >         err = efivar_init(efivarfs_callback, (void *)sb, true, &efivarfs_list);
> > @@ -281,6 +312,8 @@ static int efivarfs_init_fs_context(struct fs_context *fc)
> >
> >  static void efivarfs_kill_sb(struct super_block *sb)
> >  {
> > +       blocking_notifier_chain_unregister(&efivar_ops_nh, &info.nb);
> > +       info.sb = NULL;
> >         kill_litter_super(sb);
> >
> >         if (!efivar_is_available())
> > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > index 4776a3dd9a72..489707b9b0b0 100644
> > --- a/include/linux/efi.h
> > +++ b/include/linux/efi.h
> > @@ -1355,6 +1355,14 @@ bool efi_config_table_is_usable(const efi_guid_t *guid, unsigned long table)
> >
> >  umode_t efi_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n);
> >
> > +/*
> > + * efivar ops event type
> > + */
> > +#define EFIVAR_OPS_RDONLY 0
> > +#define EFIVAR_OPS_RDWR 1
> > +
> > +extern struct blocking_notifier_head efivar_ops_nh;
> > +
> >  void efivars_generic_ops_register(void);
> >  void efivars_generic_ops_unregister(void);
> >
> > --
> > 2.30.2
> >
