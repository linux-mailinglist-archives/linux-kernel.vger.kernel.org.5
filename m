Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B18180D0B5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344184AbjLKQNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343941AbjLKQNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:13:13 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7531E93
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:13:19 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1fb33059466so3188104fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702311199; x=1702915999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMdTBUxR6AVwW86ExWMmPkNHggzo7L+Lz305ZVyo4xo=;
        b=Fr8cJOnXz/aPRsQZaOI8uvrbvFgFfMW5KzD+pWLuebYlEDt2KvRPiPVRJKZAkKQ1OD
         GtZt2W4r5EElRuvVNKYnrWtlnKrh9M3ku1xOyrj3xokiG+5H5KZqVLm8ES1K8xsSo04r
         w46HBjBBMSU91LCb30UDT/hI7619SS4EA6GhdHUx5k031wsQGRfsN9VjMkBdc/5mWvSy
         fs5d7m39NOHNNK96dgQlSjBW4+lcuF2ipOZjQeeEBMzVpr8mLTYdQvdXyNtq/I8uyjAZ
         XFdoPHmgDD/VcV4Kj9tHny8VqIRXfgQfoNcVANT5fU5p6TA/dbgPI0Oz5DDXgYDfEUWa
         2bAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702311199; x=1702915999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMdTBUxR6AVwW86ExWMmPkNHggzo7L+Lz305ZVyo4xo=;
        b=wjbFOHmqPUfN9k/+Uy66OdSXakqHoK2V3drQw4sxzfHqor2yBftBDydsQdHU8Vielg
         Ii2CMp2kYaeEXtb2MDLV5vf4y8QPYd959/ZHAgkjmJccMjaNLJ3qqRGiEvA62HeicH/f
         0DMuOig0ETJKK7dtFH6oaSqQzfl7Av+BcXoEKx96YjPbH29RfVIwDi1Iionb2JZu8K/t
         8UAe342wV2wW5KrIEU9KjmbHT7AVK49MjXAgCg3cV0qYI/C2Ae5qPgOvKtX7F0KzBHMA
         hMtlrseg4gV4R98eh3+bRu2h+GIZi7/3hWi2+rGkgTQAKU5qe3VKRnNs4gWAseyznoLh
         bT8Q==
X-Gm-Message-State: AOJu0Yx5PYbQUZ1kEuA5//VUPnjCB4JundgrJej2hDDbXSPVrR7g+k71
        N6O6KgJ9j2ruYAvrWOigX9TfOQjuAJW8yTVTQSS+sFoK5Eq5V4uU
X-Google-Smtp-Source: AGHT+IHg2NZrh/AUj7ZQM9me8Y07vZ1PsqzHpRMkWnNDA4LpsvfZNr1RuQfrDp+uriHlNjKbyDxVqea4oc7CbrlMwvw=
X-Received: by 2002:a05:6870:7817:b0:1fb:75a:6d15 with SMTP id
 hb23-20020a056870781700b001fb075a6d15mr5806790oab.60.1702311197241; Mon, 11
 Dec 2023 08:13:17 -0800 (PST)
MIME-Version: 1.0
References: <20231211155453.105409-1-piroyangg@gmail.com> <2023121133-mandatory-idealness-d454@gregkh>
In-Reply-To: <2023121133-mandatory-idealness-d454@gregkh>
From:   piro yang <piroyangg@gmail.com>
Date:   Tue, 12 Dec 2023 00:13:05 +0800
Message-ID: <CALaNatNpBJ6a-hv3MiV7NzuJ7wYLwHRCs3ppKM5O-UCvTSeiGg@mail.gmail.com>
Subject: Re: [PATCH] staging:vme_user:fix the issue of using the wrong error code
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev,
        Linux Outreachy <outreachy@lists.linux.dev>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2023=E5=B9=B412=E6=9C=8812=E6=
=97=A5=E5=91=A8=E4=BA=8C 00:01=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Dec 11, 2023 at 11:54:53PM +0800, Piro Yang wrote:
> > 1. the error code of ENOSYS indicates Invalid system call number,
> >    but there is not system call
> >
> > 2. unified the logging error message, when slave_set func is NULL
>
> That is two different things, and as such, should be two different
> changes, right?
>
> Yes, it's picky, but that's what the staging driver code is for, to get
> comfortable doing kernel development changes properly.
>
> Also, are you sure this second change is correct:

   yes, I'm sure .
   the vme_slave_set function is diffierent
/*****************************vme_slave_set***********************/
int vme_slave_set(struct vme_resource *resource, int enabled,
                  unsigned long long vme_base, unsigned long long size,
                  dma_addr_t buf_base, u32 aspace, u32 cycle)
{
        ...
        if (!bridge->slave_set) {
                 dev_err(bridge->parent, "Function not supported\n");
                return -ENOSYS;
        }

/******************other functions like below: *******************/
int vme_slave_get(struct vme_resource *resource, int *enabled,
                  unsigned long long *vme_base, unsigned long long *size,
                  dma_addr_t *buf_base, u32 *aspace, u32 *cycle)
{
        ....
        if (!bridge->slave_get) {
                dev_err(bridge->parent, "%s not supported\n", __func__);
                return -EINVAL;
        }

int vme_master_set(struct vme_resource *resource, int enabled,
                   unsigned long long vme_base, unsigned long long size,
                   u32 aspace, u32 cycle, u32 dwidth)
{
       ....
        if (!bridge->master_set) {
                dev_warn(bridge->parent, "%s not supported\n", __func__);
                return -EINVAL;
        }

int vme_master_get(struct vme_resource *resource, int *enabled,
                   unsigned long long *vme_base, unsigned long long *size,
                   u32 *aspace, u32 *cycle, u32 *dwidth)
{
      ....
        if (!bridge->master_get) {
                dev_warn(bridge->parent, "%s not supported\n", __func__);
                return -EINVAL;
        }

>
> >
> > Signed-off-by: Piro Yang <piroyangg@gmail.com>
> > ---
> >  drivers/staging/vme_user/vme.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/=
vme.c
> > index 5c416c31ec57..e9461a7a7ab8 100644
> > --- a/drivers/staging/vme_user/vme.c
> > +++ b/drivers/staging/vme_user/vme.c
> > @@ -340,8 +340,8 @@ int vme_slave_set(struct vme_resource *resource, in=
t enabled,
> >       image =3D list_entry(resource->entry, struct vme_slave_resource, =
list);
> >
> >       if (!bridge->slave_set) {
> > -             dev_err(bridge->parent, "Function not supported\n");
> > -             return -ENOSYS;
> > +             dev_err(bridge->parent, "%s not supported\n", __func__);
>
> __func__ is not the same here as "Function", right?  "Function" is the
> functionality of the thing that is attempted here, so replacing that
> word with the function name seems odd to me, don't you think?
>
> thanks,
>
> greg k-h
