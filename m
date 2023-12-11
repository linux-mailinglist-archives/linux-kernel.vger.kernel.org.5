Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C313D80D204
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344870AbjLKQhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344433AbjLKQhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:37:23 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0ED8E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:37:30 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-db99bad7745so4237906276.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702312649; x=1702917449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O48C/CJEj4wZSfp3763oo3jCjp+8dc3hHNx68ntAz6g=;
        b=BO/7rcWFEhp/VwQabSaee6vkn4rgn0CM67Ubd9rEsss57tZcMZy3AduJsfi6JD8bxS
         8cHtVrKQsi3udX1Kv9XCyEj2IH5acjAItfMzyCvSyP17GRM+SgKinhddNCEPBalz8cn8
         rYeLTpW2epEF7LQM0GOyZl8ZDnFTTbpK5kQlyWgUll4f4deRsxWZgr5o8MAUfRUeFNLz
         3l2UxIKnwGS/WFjExWmUWCI8WHw4GlK8JlylS9jUOCFMYGA1SFrSkrN5uSFnyCPcChFR
         PMIDmqtQc50ogm63p1l04fGEo6M/ol1X+EJ00Ffba5x0Fr8K8DxUB8nxVyTxR9FDRjQP
         JS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702312649; x=1702917449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O48C/CJEj4wZSfp3763oo3jCjp+8dc3hHNx68ntAz6g=;
        b=VypJ7YQDkn3ltvUIYDuYkRQetVnC2x0jJIzFlfqVTuquGVKbJxxrZNIDn5VqiX9/Ro
         nB5GiJhB3cLwvdOrZcMoWbq/6mzNNc/9/SEzffw8XIbYpJ1b4Bkom+1yTVATDmq3+Ekq
         lnPgpi9WYQNVcW6vU037o7SjuCOYor5RQ4Wdt04yX6b15ksOAFuuMfDNNfhzxhsPpxkM
         YTMq5wcl38GtN/HZSWqrK7aqxFfcOx03z7u2YXA6HUkjbezySP0IGlTpcbxXnSlZ78nc
         15veJVslU0SxFFlDwuycSK8QfZu8lysD1S6UPihk46n+Sho6NEC9XbeLdCSOYOMvUlJO
         mveA==
X-Gm-Message-State: AOJu0Yw7gYb/T/HpDG4jUsvi1tAnXqp5leU4WGacpO7Vj71rhxeq4tXM
        a14Sf7caPh9NREAQC6tH9NnktaZK5kgWJuq8MwYVFfSx/xRDU2Pt
X-Google-Smtp-Source: AGHT+IHsWOfhNhkuofOaAYc2UYyIkxsHju3N7BW8qPIaRgg3fnWoQDF/kzVyr8SDxt0NmDZv8bmumLbnqk6nJmdnXyA=
X-Received: by 2002:a05:6902:1ac2:b0:db7:dacf:2eff with SMTP id
 db2-20020a0569021ac200b00db7dacf2effmr3523938ybb.70.1702312649072; Mon, 11
 Dec 2023 08:37:29 -0800 (PST)
MIME-Version: 1.0
References: <20231211155453.105409-1-piroyangg@gmail.com> <2023121133-mandatory-idealness-d454@gregkh>
 <CALaNatNpBJ6a-hv3MiV7NzuJ7wYLwHRCs3ppKM5O-UCvTSeiGg@mail.gmail.com>
In-Reply-To: <CALaNatNpBJ6a-hv3MiV7NzuJ7wYLwHRCs3ppKM5O-UCvTSeiGg@mail.gmail.com>
From:   piro yang <piroyangg@gmail.com>
Date:   Tue, 12 Dec 2023 00:37:16 +0800
Message-ID: <CALaNatM_2UKo5jS=9FWjCCrj0dA-01JDndc+Q2RF=1LTCbHfZQ@mail.gmail.com>
Subject: Re: [PATCH] staging:vme_user:fix the issue of using the wrong error code
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev,
        Linux Outreachy <outreachy@lists.linux.dev>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

piro yang <piroyangg@gmail.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=8812=E6=97=
=A5=E5=91=A8=E4=BA=8C 00:13=E5=86=99=E9=81=93=EF=BC=9A
>
> Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2023=E5=B9=B412=E6=9C=8812=
=E6=97=A5=E5=91=A8=E4=BA=8C 00:01=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Mon, Dec 11, 2023 at 11:54:53PM +0800, Piro Yang wrote:
> > > 1. the error code of ENOSYS indicates Invalid system call number,
> > >    but there is not system call
> > >
> > > 2. unified the logging error message, when slave_set func is NULL
> >
> > That is two different things, and as such, should be two different
> > changes, right?
> >
> > Yes, it's picky, but that's what the staging driver code is for, to get
> > comfortable doing kernel development changes properly.
> >
> > Also, are you sure this second change is correct:
>
>    yes, I'm sure .
>    the vme_slave_set function is diffierent
> /*****************************vme_slave_set***********************/
> int vme_slave_set(struct vme_resource *resource, int enabled,
>                   unsigned long long vme_base, unsigned long long size,
>                   dma_addr_t buf_base, u32 aspace, u32 cycle)
> {
>         ...
>         if (!bridge->slave_set) {
>                  dev_err(bridge->parent, "Function not supported\n");
>                 return -ENOSYS;
>         }
>
> /******************other functions like below: *******************/
> int vme_slave_get(struct vme_resource *resource, int *enabled,
>                   unsigned long long *vme_base, unsigned long long *size,
>                   dma_addr_t *buf_base, u32 *aspace, u32 *cycle)
> {
>         ....
>         if (!bridge->slave_get) {
>                 dev_err(bridge->parent, "%s not supported\n", __func__);
>                 return -EINVAL;
>         }
>
> int vme_master_set(struct vme_resource *resource, int enabled,
>                    unsigned long long vme_base, unsigned long long size,
>                    u32 aspace, u32 cycle, u32 dwidth)
> {
>        ....
>         if (!bridge->master_set) {
>                 dev_warn(bridge->parent, "%s not supported\n", __func__);
>                 return -EINVAL;
>         }
>
> int vme_master_get(struct vme_resource *resource, int *enabled,
>                    unsigned long long *vme_base, unsigned long long *size=
,
>                    u32 *aspace, u32 *cycle, u32 *dwidth)
> {
>       ....
>         if (!bridge->master_get) {
>                 dev_warn(bridge->parent, "%s not supported\n", __func__);
>                 return -EINVAL;
>         }
>
> >
> > >
> > > Signed-off-by: Piro Yang <piroyangg@gmail.com>
> > > ---
> > >  drivers/staging/vme_user/vme.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_use=
r/vme.c
> > > index 5c416c31ec57..e9461a7a7ab8 100644
> > > --- a/drivers/staging/vme_user/vme.c
> > > +++ b/drivers/staging/vme_user/vme.c
> > > @@ -340,8 +340,8 @@ int vme_slave_set(struct vme_resource *resource, =
int enabled,
> > >       image =3D list_entry(resource->entry, struct vme_slave_resource=
, list);
> > >
> > >       if (!bridge->slave_set) {
> > > -             dev_err(bridge->parent, "Function not supported\n");
> > > -             return -ENOSYS;
> > > +             dev_err(bridge->parent, "%s not supported\n", __func__)=
;
> >
> > __func__ is not the same here as "Function", right?  "Function" is the
> > functionality of the thing that is attempted here, so replacing that
> > word with the function name seems odd to me, don't you think?
> >
    yes, __func__ is not the same here as "Function".
    but I think the logging error message format  shoud be unified
with other functions.
    like:  vme_slave_get(){
             .....
             if (!bridge->slave_get) {
                dev_err(bridge->parent, "%s not supported\n", __func__);


> > thanks,
> >
> > greg k-h
