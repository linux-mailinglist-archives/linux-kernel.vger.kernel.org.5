Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999AC78E20A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244288AbjH3WDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234731AbjH3WDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:03:13 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBDEE6D;
        Wed, 30 Aug 2023 15:02:47 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6bf01bcb1aeso228399a34.3;
        Wed, 30 Aug 2023 15:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693432896; x=1694037696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ueoe83p5TP/BX5e5mMzX6M9AVSVyHZ9ZgbLNvbyWLBk=;
        b=ekcC95f56mj3jGoqdGBbfIUXvzrr18N6mNzXbYJlEZSZlF8GOxWYPebKPZx3V5rTW3
         fSQDPILnq2rZzcVjgxNKEXiE22k1Pw0LlLgQkVBZb9O8I3LHBYO/zn6bAnlLlbNXB8cD
         BI2fRy/2FDm/G7gxgtb6gLaofUsjIbbyH14OudVWt1RkUGCfyvaKV5aDA2weTzvxWWy1
         x4qXzyTBHlFsJjF1EeheFZ0IldA/2i5RGpspjX9JhIFCPBmN/LQmjbgIqoxAwB1LYd5O
         2rcps3zJXYN17VIXrGVmBcomsyZY87kCSEbUon0T9SLwwnbPETEVa0oc8hOim7FhQYKz
         9I/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693432896; x=1694037696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ueoe83p5TP/BX5e5mMzX6M9AVSVyHZ9ZgbLNvbyWLBk=;
        b=iMuljDoE4lk/USniueVC9xPIHoU31tYdSlpEGp9+DTzTP9JG6+Pl9vHGncT9V7Smpw
         MF0elb5cLK5CrnXs3SHAYZmexbBo3Q8KLmOVMEg1k4xJq1bpA0I+7rwYGAD31q8mqvCa
         dc8EcuIdHeo/l6k8w9IslrBctab4HRohB+D4bm6zvKDvLFVeb0RnhhJj1d4i6ZmaKKC+
         vrlmdzt+3NkwWn0NYk2SoQGjDr9+tuMfeO0MH74SWQBltXKIVXby2qeAjD2gxYhsgmzX
         AQbYVqG2TWw5mxyhHzXOAbJ58NBW8GuuoM/Jt8zCgaI5+SB9OxeLt1f6ix0Z1jNji5SN
         SNCw==
X-Gm-Message-State: AOJu0YxnCgpvgnpliLA4O/4kpmEE/YnPjj9bPo4xhbWhcXEyXovGKXrJ
        EwgUVKwtV9ZisS0WuROVCp0c3diB+eSAhTMH/lA=
X-Google-Smtp-Source: AGHT+IGOjrhJiurHDG9CO68WFg+Lj3uKyBzjsZmu31JRwGBSDIWI65s5f4XLYn5/36TmhNRh+UGv5SlC4Hd8+XPDAwU=
X-Received: by 2002:a05:6358:4414:b0:12f:2573:45b4 with SMTP id
 z20-20020a056358441400b0012f257345b4mr3002501rwc.26.1693432896229; Wed, 30
 Aug 2023 15:01:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230830210724.4156575-1-azeemshaikh38@gmail.com> <20230830215330.6gyhpq3ohkbbtsam@google.com>
In-Reply-To: <20230830215330.6gyhpq3ohkbbtsam@google.com>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Wed, 30 Aug 2023 18:01:25 -0400
Message-ID: <CADmuW3VbUZBRXVyZVeVuS4cbPGjfgD8fntQwMCUskR5W-CyNVQ@mail.gmail.com>
Subject: Re: [PATCH v2] scsi: target: Replace strlcpy with strscpy
To:     Justin Stitt <justinstitt@google.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-hardening@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 5:53=E2=80=AFPM Justin Stitt <justinstitt@google.co=
m> wrote:
>
> On Wed, Aug 30, 2023 at 09:07:24PM +0000, Azeem Shaikh wrote:
> > strlcpy() reads the entire source buffer first.
> > This read may exceed the destination size limit.
> > This is both inefficient and can lead to linear read
> > overflows if a source string is not NUL-terminated [1].
> > In an effort to remove strlcpy() completely [2], replace
> > strlcpy() here with strscpy().
> >
> > Direct replacement is safe here since return value of -errno
> > is used to check for truncation instead of sizeof(dest).
> >
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strl=
cpy
> > [2] https://github.com/KSPP/linux/issues/89
> >
> > Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> > ---
> > v2:
> >  * Replace all instances of strlcpy in this file instead of just 1.
> >
> > v1:
> >  * https://lore.kernel.org/all/20230830200717.4129442-1-azeemshaikh38@g=
mail.com/
> >
> >  drivers/target/target_core_configfs.c |   27 ++++++++++++-------------=
--
> >  1 file changed, 12 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/target/target_core_configfs.c b/drivers/target/tar=
get_core_configfs.c
> > index 936e5ff1b209..10a22a428267 100644
> > --- a/drivers/target/target_core_configfs.c
> > +++ b/drivers/target/target_core_configfs.c
> > @@ -1392,16 +1392,15 @@ static ssize_t target_wwn_vendor_id_store(struc=
t config_item *item,
> >       /* +2 to allow for a trailing (stripped) '\n' and null-terminator=
 */
> >       unsigned char buf[INQUIRY_VENDOR_LEN + 2];
> >       char *stripped =3D NULL;
> > -     size_t len;
> > +     ssize_t len;
> >       ssize_t ret;
> >
> > -     len =3D strlcpy(buf, page, sizeof(buf));
> > -     if (len < sizeof(buf)) {
> > +     len =3D strscpy(buf, page, sizeof(buf));
> > +     if (len > 0) {
> >               /* Strip any newline added from userspace. */
> >               stripped =3D strstrip(buf);
> > -             len =3D strlen(stripped);
> >       }
> > -     if (len > INQUIRY_VENDOR_LEN) {
> > +     if (len < 0 || strlen(stripped) > INQUIRY_VENDOR_LEN) {
> >               pr_err("Emulated T10 Vendor Identification exceeds"
> >                       " INQUIRY_VENDOR_LEN: " __stringify(INQUIRY_VENDO=
R_LEN)
> >                       "\n");
>
> Should we be explicitly checking for `len =3D=3D -E2BIG` instead of the m=
ore
> generic `len < 0`? Perhaps this is a nitpick but I prefer the former.
>

Most maintainers to whom I have sent such patches in the past have
preferred `len < 0` since it is not "rigid" in checking for -E2BIG
which is an implementation detail of strscpy.
