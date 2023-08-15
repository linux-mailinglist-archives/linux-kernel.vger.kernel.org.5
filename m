Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3A477CCA5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 14:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237184AbjHOM2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 08:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237218AbjHOM14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 08:27:56 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027D9199F;
        Tue, 15 Aug 2023 05:27:47 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe9f226cdbso4433819e87.0;
        Tue, 15 Aug 2023 05:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692102465; x=1692707265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVDDJlWhUCzNd5EzhLvuiUskyN3c3RfjOPmwxNMLBoQ=;
        b=EEZlIEkkHTSZjflV063Ba+ihFccGT6E0fQZnAkTbH4cnvs7XalS74aKS7J5Fc8+jy3
         Oy/MfMANIuQMzgazpi58Y3jE8tq0X09EBdzUWMyUOwohCs5EGMEs6U1ED+1r0JNblfWa
         0aYGsV2mQrrlUzWecnayklYKdyV8f92jZZqaI68H210pfWqivG71RoqDhm/igoXmWFUv
         5/SsEB//8i94HjEdft7lAhrKAoMbRNyyZ4Ik8YtZP3FO52wWv4WXMX19imxwSfwwGCos
         KmuZDIwsXS8uyet7Ix9BsO+uu0OuwaVgfO0uWOCgGpWsJ/XFdAx1WvxnP/ncpnAembpb
         bLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692102465; x=1692707265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVDDJlWhUCzNd5EzhLvuiUskyN3c3RfjOPmwxNMLBoQ=;
        b=TmXIeqLh2plb0TfY37Y0y/Y1BkgEWOtiXdJUW2ibUS4S77XYFr2fcNKNluPXycdOJU
         6xdEV1t/WvE4CJScHFbkJhbmYtO/+T4duvkMDig4UBVvHW4YSd0eRy/i8V97Rv2vcANW
         dATK+Wm0V04944SKKGvMTfbcc+tvAVFoWTMtwzrg4oRgm2fagHau3mbLd2e3knqXeyJ/
         b1kiKAWwHxw2MT1QSrbstFZKPmoEM7tZWTmtccELIyn6huI+oXp+AJiBu0UKBLNKcw/U
         KQxwMWgM4HnuSFsKok8lHF+RGhy5IyMFwnJyFBIBBBDmKUMznUpjyrqIB9qP+cPuO/2B
         LwDQ==
X-Gm-Message-State: AOJu0YwadS+QT7ks5gSJv4wvC0QJgq8LELBhHilkqfeudAzqHz+fOLAd
        6AKpnYxCvtOk1zSo4oNUX7J+7+qtB14=
X-Google-Smtp-Source: AGHT+IG+cwmqQnGcgtQ0KiswsiQhrqD1uMPt1W4S48i/yx2yACHzwUMti+3UczLKtLgnuthlvtm6SA==
X-Received: by 2002:a05:6512:acf:b0:4fe:5860:7abf with SMTP id n15-20020a0565120acf00b004fe58607abfmr9520807lfu.13.1692102464921;
        Tue, 15 Aug 2023 05:27:44 -0700 (PDT)
Received: from suse.localnet (host-87-6-98-229.retail.telecomitalia.it. [87.6.98.229])
        by smtp.gmail.com with ESMTPSA id g13-20020a5d698d000000b003180027d67asm17774055wru.19.2023.08.15.05.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 05:27:44 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2] Documentation/page_tables: Add info about MMU/TLB and Page
 Faults
Date:   Tue, 15 Aug 2023 14:27:42 +0200
Message-ID: <3179607.5fSG56mABF@suse>
In-Reply-To: <CACRpkdbq8UCtvtRH7FZUEqvTxPQcoGbrKvf_mT5QHMAfVoYNNQ@mail.gmail.com>
References: <20230813182552.31792-1-fmdefrancesco@gmail.com>
 <CACRpkdbq8UCtvtRH7FZUEqvTxPQcoGbrKvf_mT5QHMAfVoYNNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On marted=EC 15 agosto 2023 10:51:24 CEST Linus Walleij wrote:
> Hi Fabio,
>=20
> overall this v2 looks good!

Hi Linus,

Thanks for your review. I appreciated it.

I'm counting at least ten mistakes. Well my poor English should still impro=
ve=20
in order to work on documentation.

I agree with you on all changes you are proposing, so I won't agree line by=
=20
line. Instead I'll send a v3 and forward your tag.=20

I have only a doubt and a questions.=20
I'll jump directly to the relevant parts.

>=20
> The below are my grammar and spelling nitpicks.
>
> [snip]=20
>=20
> > +If the above-mentioned conditions happen in user-space, the kernel sen=
ds=20
a
> > +`Segmentation Fault` (SIGSEGV) signal to the current thread. That sign=
al
> > usually +causes the termination of the thread and of the process it=20
belongs
> > to. +
> > +Instead, there are also common and expected other causes of page fault=
s.
> > These
> The word you are looking for is "Additionally" right?
>=20
> "Additionally, there are..."

I was only able to use "Instead" to express that, contrary to the former=20
conditions that is unexpected and uncommon, there are other expected and=20
common causes of page faults. I thought that "Instead" stresses that the=20
latter causes carry with them opposite and wanted consequences.

I think of "additionally" as a means to introduce less important and less=20
frequently occurring conditions.

Nevertheless, I'll change it to "Additionally" as you are asking for.

Everything that follows from here onward should surely be changed as you ar=
e=20
suggesting. =20

[snip]

> > +Swapping can't work for memory mapped by kernel logical addresses. The=
se
> > are a
> "kernel logical addresses" -> "kernel-internal logical addresses"

My only question is about why you prefer "kernel-internal" to a straight=20
"kernel". Can you please say more about this?

[snip]
=20
> With
> or without the above suggestions:

I'll do the v3 _with_ the above suggestions.

> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>=20
> Yours,
> Linus Walleij

Again thanks,

=46abio


