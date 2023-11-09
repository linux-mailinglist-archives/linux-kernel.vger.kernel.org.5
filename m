Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7002D7E687E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjKIKlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjKIKlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:41:19 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454BD2696;
        Thu,  9 Nov 2023 02:41:17 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-5842a7fdc61so354237eaf.3;
        Thu, 09 Nov 2023 02:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699526476; x=1700131276; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v4qZyY6I3TWlQuY7QSG5t1j1KfvhdmXf6M2V0Mb5Kn4=;
        b=izmWdz7AnLS/6kDt4viHU/c1VZ9VEX6341cZ+eceBfn5UOc5YgHoU4kbvCUH55ve8O
         1XlaTCPn7IU6VA2CnBQI4Kj3aB/YKB9+ELMFi6HHjVKWQJBld4fZrh31oZiFYAJwUntP
         vRU/5lEWCgoxO9tUYGJm2sEah4rkdM00t087zTe4nALmtaCGT01Tmqws5gLLzFHUH4sm
         5LTWeE+aFsWY88F1eJJsQBjIT90oaS+F/SDcX3zDC/j6+MSfC+0C+1tsW/JylbLZO25B
         eERjFEFM1DdM7nS2ScZkJB0L60dqZ4lzEjpF6BrVmcctJy/c1BHfKNFTugCsDSigH3+z
         81Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699526476; x=1700131276;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v4qZyY6I3TWlQuY7QSG5t1j1KfvhdmXf6M2V0Mb5Kn4=;
        b=B1g7WPTwM5pbE0z2f++RW0Zx7b3BKMh/g7L3FkIzlrkS6EApSzO4P+7ySf4bDEfoud
         LvwdSoP22C8Wmtu2Ya/Y6X92Gcc6mhZHb9zdizPE9RUxhZPAUc7tX6iZ+drHIEVrD1Sn
         EnQtcRtM80qd1bL306FBUiDux2L5DNm6N1WoM6Xb9y8yBLvZT/reCmHxad4KAQ/xBlJa
         Blt9uy1lzVqdpa9qbHQyqwyAlG322RZ5NkYcSBFp5z4Eee6wtSPfv2IfLAIdlh1b1AGM
         0jDanhhe/gBlJ3eTc6IKgIVpO3t8LcsWOAzxO/ZDHqTROMPVUujbYtLYrxQFs6ZyLzVC
         njiQ==
X-Gm-Message-State: AOJu0Ywvm7XmqNcw7onTrAaso2tA099uDcqBjTBUdSTD5XJC8vNzncol
        PNILmoblXnkYDzdsvEouIL8UkhbvCNb2A8jYb5iV6akP
X-Google-Smtp-Source: AGHT+IGRcBr8r41MhPatCg2OTWlqjkYopLpeW80rHa9Fnn8gpMOv1bAH7Awl+8cfQFZqnnRvufJA0ZYWFrCI3MH5f48=
X-Received: by 2002:a05:6820:1a47:b0:57b:7e41:9f11 with SMTP id
 br7-20020a0568201a4700b0057b7e419f11mr4842012oob.2.1699526476447; Thu, 09 Nov
 2023 02:41:16 -0800 (PST)
MIME-Version: 1.0
References: <20230914112739.112729-1-alessandro.carminati@gmail.com>
 <20230914112739.112729-3-alessandro.carminati@gmail.com> <69d0dc4f-5ff5-4cda-a272-71b890db5bc8@redhat.com>
In-Reply-To: <69d0dc4f-5ff5-4cda-a272-71b890db5bc8@redhat.com>
From:   Alessandro Carminati <alessandro.carminati@gmail.com>
Date:   Thu, 9 Nov 2023 11:40:40 +0100
Message-ID: <CAPp5cGRgDVFO2pes9ThOr+h_P_yF1aOFQbd1mYef-LvYawUjnQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] docs: Update kernel-parameters.txt for signature
 verification enhancement
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Prarit,

Il giorno mer 8 nov 2023 alle ore 16:33 Prarit Bhargava
<prarit@redhat.com> ha scritto:
>
> On 9/14/23 07:27, Alessandro Carminati (Red Hat) wrote:
> > Update kernel-parameters.txt to reflect new deferred signature
> > verification.
> > Enhances boot speed by allowing unsigned modules in initrd after
> > bootloader check.
> >
> > Signed-off-by: Alessandro Carminati (Red Hat) <alessandro.carminati@gmail.com>
> > ---
> >   Documentation/admin-guide/kernel-parameters.txt | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 0c38a8af95ce..beec86f0dd05 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -3410,6 +3410,15 @@
> >                       Note that if CONFIG_MODULE_SIG_FORCE is set, that
> >                       is always true, so this option does nothing.
> >
> > +     module_sig_check_wait=
> > +                     This parameter enables delayed activation of module
> > +                     signature checks, deferring the process until userspace
> > +                     triggers it. Once activated, this setting becomes
> > +                     permanent and cannot be reversed. This feature proves
> > +                     valuable for incorporating unsigned modules within
> > +                     initrd, especially after bootloader verification.
> > +                     By employing this option, boot times can be quicker.
> > +
>
> Please keep these in alphabetical order.
>
> Would making the kernel-parameters.txt warning a little bit more
> informative be a good thing?  This should only be used in environments
> where some other signature verification method is employed.
>
> Also, for future reference, it would be good to have hard numbers to
> show the boot time improvement in the changelog.
I'll do the necessary adjustments in the v2, thank you for your feedback.
>
> P.
>
> >       module_blacklist=  [KNL] Do not load a comma-separated list of
> >                       modules.  Useful for debugging problem modules.
> >
>
