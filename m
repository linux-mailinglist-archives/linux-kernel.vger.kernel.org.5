Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0840A7CF691
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345285AbjJSLVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbjJSLVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:21:46 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8915713D
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:21:44 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6cd09663b1cso881992a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697714504; x=1698319304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3SPNfk0MBZSGH8SXgS5730xn3GrjsvVhbuXYaMzrM4=;
        b=HjvL758hVOzEb9fbeoxNw4YK42CiKWUWwKffqOGcp44oR3MtzIof0tTdMZ+iE3lmVJ
         K4qMg7m+rzB5Rl6/73Kit1XNqFxNR4GceVDd6smW2WgAkJMk70lPoaCU/3Mfofs2lDUi
         kMb4As1Bu1p3o5xczUQlSuzS6uG+WDickPPIIhZ+mCC1DkQb1z8ppapbIqf3nPYSyhv9
         +NtzE72SNAmHEAXQ5DK/MMZ3lkiwho9jobiiZ++u7VItY5iwI7dVN4hu1nOF/gI/AM/6
         eCJoAryS39hAjGEXE+jQ3IeKmyAy6Tia/LJLGahPpGexaPt1Rq2FBMpGwk9bfNndWDu+
         Mm6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697714504; x=1698319304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3SPNfk0MBZSGH8SXgS5730xn3GrjsvVhbuXYaMzrM4=;
        b=v0cghvL1n//pLtE8v/zBLfVORetQ9tp30qvcbXoeKdXX62Y8aZ5AX3E5oby11XGjI8
         ilzwHHKYTRkOpEgQH1qMsFRiT+WhvrRwruN70pE4YButxL2uiOF58nqF5HDyi2otEggJ
         zHaC2SZgCoW08U6/bSVD1I8kdkKtl4kQw2A6H4HzxN/e6yQyImx2EjOPUSr1Yq04z9jo
         LbcWezZvPoPVOu6NDTy0j/TNSVTDi+NG1T0HcN5MY/mtNpYVtO/QKQ+OueNf7lv7EsWw
         iFuFq3LhMvYKnXU/eh8Z5WAvSofBgVPJSob3A8EkcSKzf6pehiLHAbEcJidzkAwRwSWr
         deSA==
X-Gm-Message-State: AOJu0YzSmvY9S8HjODTekFhm/m9tKuu9W1QA0oB/Idkrti34wbmf9C7k
        b2Wv7yAvJxCU3DNzCssZ8Cmlse75LDGPDNleJ9NtcgSOvdbeng==
X-Google-Smtp-Source: AGHT+IEyh2R89gb0G7TKWAFgHpET4HBGbIDd81JD9Rp9+cxsWVvXkJ+wOTKm4GEag1lO1HJhacHcX1Q2yxVtniNWbH8=
X-Received: by 2002:a05:6830:140a:b0:6cd:a9d:bc57 with SMTP id
 v10-20020a056830140a00b006cd0a9dbc57mr1939761otp.32.1697714503786; Thu, 19
 Oct 2023 04:21:43 -0700 (PDT)
MIME-Version: 1.0
References: <ZTD677iqMkRPxT27@lab-ubuntu> <93a6d8b0-140c-983e-1b78-6f5a4e03e62e@intel.com>
In-Reply-To: <93a6d8b0-140c-983e-1b78-6f5a4e03e62e@intel.com>
From:   Calvince Otieno <calvncce@gmail.com>
Date:   Thu, 19 Oct 2023 14:21:32 +0300
Message-ID: <CADFX3OTHX=5jNm8aaUyC_RzDPntiL4ZC=Jj+8bZPjHNmZwUs9A@mail.gmail.com>
Subject: Re: [PATCH] staging: vc04_services: remove empty functions
To:     Karolina Stolarek <karolina.stolarek@intel.com>
Cc:     outreachy@lists.linux.dev, gustavo@embeddedor.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 1:55=E2=80=AFPM Karolina Stolarek
<karolina.stolarek@intel.com> wrote:
>
> On 19.10.2023 11:46, Calvince Otieno wrote:
> > The functions vchiq_debugfs_init(), vchiq_debugfs_deinit(),
> > vchiq_debugfs_add_instance(), and vchiq_debugfs_remove_instance()
> > are declared and defined but contains no code or statements.
> > They do nothing.
> >
> > Signed-off-by: Calvince Otieno <calvncce@gmail.com>
> > ---
> >   .../interface/vchiq_arm/vchiq_arm.c              |  3 ---
> >   .../interface/vchiq_arm/vchiq_debugfs.c          | 16 ---------------=
-
> >   .../interface/vchiq_arm/vchiq_debugfs.h          |  8 --------
> >   .../interface/vchiq_arm/vchiq_dev.c              |  4 ----
> >   4 files changed, 31 deletions(-)
> >
> > diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ar=
m.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> > index eef9c8c06e66..b802d1ecc8f6 100644
> > --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> > +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> > @@ -1806,8 +1806,6 @@ static int vchiq_probe(struct platform_device *pd=
ev)
> >       if (err)
> >               goto failed_platform_init;
> >
> > -     vchiq_debugfs_init();
> > -
> >       vchiq_log_info(vchiq_arm_log_level,
> >                      "vchiq: platform initialised - version %d (min %d)=
",
> >                      VCHIQ_VERSION, VCHIQ_VERSION_MIN);
> > @@ -1838,7 +1836,6 @@ static void vchiq_remove(struct platform_device *=
pdev)
> >   {
> >       vchiq_device_unregister(bcm2835_audio);
> >       vchiq_device_unregister(bcm2835_camera);
> > -     vchiq_debugfs_deinit();
> >       vchiq_deregister_chrdev();
> >   }
> >
> > diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
bugfs.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
> > index dc667afd1f8c..7e45076e5ebd 100644
> > --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
> > +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
> > @@ -228,20 +228,4 @@ void vchiq_debugfs_deinit(void)
> >
> >   #else /* CONFIG_DEBUG_FS */
> We need to have these definitions, so a kernel with no CONFIG_DEBUG_FS
> selected builds. Have you experimented with this config with your
> changes applied?
>
> All the best,
> Karolina
>
> >
> > -void vchiq_debugfs_init(void)
> > -{
> > -}
> > -
> > -void vchiq_debugfs_deinit(void)
> > -{
> > -}
> > -
> > -void vchiq_debugfs_add_instance(struct vchiq_instance *instance)
> > -{
> > -}
> > -
> > -void vchiq_debugfs_remove_instance(struct vchiq_instance *instance)
> > -{
> > -}
> > -
> >   #endif /* CONFIG_DEBUG_FS */
> > diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
bugfs.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h
> > index e9bf055a4ca9..76424473c32b 100644
> > --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h
> > +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h
> > @@ -10,12 +10,4 @@ struct vchiq_debugfs_node {
> >       struct dentry *dentry;
> >   };
> >
> > -void vchiq_debugfs_init(void);
> > -
> > -void vchiq_debugfs_deinit(void);
> > -
> > -void vchiq_debugfs_add_instance(struct vchiq_instance *instance);
> > -
> > -void vchiq_debugfs_remove_instance(struct vchiq_instance *instance);
> > -
> >   #endif /* VCHIQ_DEBUGFS_H */
> > diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_de=
v.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> > index 841e1a535642..953f39f537a8 100644
> > --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> > +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> > @@ -1185,8 +1185,6 @@ static int vchiq_open(struct inode *inode, struct=
 file *file)
> >       instance->state =3D state;
> >       instance->pid =3D current->tgid;
> >
> > -     vchiq_debugfs_add_instance(instance);
> > -
> >       init_completion(&instance->insert_event);
> >       init_completion(&instance->remove_event);
> >       mutex_init(&instance->completion_mutex);
> > @@ -1297,8 +1295,6 @@ static int vchiq_release(struct inode *inode, str=
uct file *file)
> >
> >       free_bulk_waiter(instance);
> >
> > -     vchiq_debugfs_remove_instance(instance);
> > -
> >       kfree(instance);
> >       file->private_data =3D NULL;
> >

Could you kindly clarify what these definitions are doing.
At the moment they do absolutely nothing, I might be wrong

--=20
Kind regards,
Calvince Otieno
