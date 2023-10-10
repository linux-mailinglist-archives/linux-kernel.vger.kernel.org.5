Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3B87BF181
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 05:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442051AbjJJDac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 23:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442114AbjJJDaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 23:30:12 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFB1ED
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 20:30:09 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3296b3f03e5so3327156f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 20:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696908608; x=1697513408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Apy2BHmD7Z2ti+DhZK221EJ5nHABHDkWgsBmsqhbGd0=;
        b=Nvnb+7CAT8AdEWLW8SGxaluZXmhbfJ+a3z6ZB3LLBJG2awCI6faBIgua5lPst5tvQG
         HigNhVZWFyimFRmzsruI2qHsMeXJjSU92Jda+G2Rh4/yFl6OkXyNzMqH3Q3COXLpnHvs
         llu9WGlLymL9kvGQbv+UjuiAvYiWIyAD6Dj4w2QTnPbeU5Tk23d+DWZomF/Sz2+94YZ5
         W1X7eFZ15sfNVzzcaLkUif3r18mG7NkQ6ZHXQ6BPmHJ+5llgG6nNjbKx9OYAQn2FkXyF
         iceMM87IbeFAhCQ9JInYpMqHI6D6lhYyljy1HDGVdNBBTq+n1LnWVyQKTrMTBgMSTMDV
         fSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696908608; x=1697513408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Apy2BHmD7Z2ti+DhZK221EJ5nHABHDkWgsBmsqhbGd0=;
        b=jNlmdj/YMOCNSvXSWvHPBBVIgGnk6MvDVI/0VQ3SeR/QJ7CIe2tiU9To5yodceA7I/
         i3vKSciq80TC2kgKsxKmbsOk/41HORkoDbcKCvVrVi5w9pjAQld9MFVo2qaylQV8ASYh
         81Xh7aepAOSLDg219ZHRNgoOh9kEx+U/5L4WKoBJC1ox0q2jitVhb9QPqYWdbj1cS2dg
         26g2H9vmGJIjt0c3CJrcqpGeqiFkCBVUBHK85S0d4/esyTIkr9wXDLHgidZa7COzyaWM
         WIVtNCRJw0scQcwL4ouYh4H+IwimCA1sB8xDf1ct38pWuXoFXBtDVKq0NxtxM0bqY2hD
         nxoA==
X-Gm-Message-State: AOJu0Yxw83dQLLgghbXRrLqwsYMBcZTn6vjj6h4PtnYQWqAelt1CMRsE
        jJMGHxDfgOel7xAecqNuCSHIjgjGvQUPOlAfPeFXyg==
X-Google-Smtp-Source: AGHT+IFA/AygTerY74EIhUkKtIH7cWXmr6pPdWLn55ZGGzigMQGZUPpvbrldeOvCaxWOQfgt54dPUL5Wxg7dp1ly2mI=
X-Received: by 2002:a5d:504e:0:b0:320:bbb:5ab1 with SMTP id
 h14-20020a5d504e000000b003200bbb5ab1mr14794300wrt.14.1696908608193; Mon, 09
 Oct 2023 20:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAEEQ3wnfOOpKAKGt07cFv1Du-NaFOzX_=yeQZfD6VNojpPFTqA@mail.gmail.com>
 <202310091307.CB416B950@keescook>
In-Reply-To: <202310091307.CB416B950@keescook>
From:   yunhui cui <cuiyunhui@bytedance.com>
Date:   Tue, 10 Oct 2023 11:29:57 +0800
Message-ID: <CAEEQ3wnA=_TjE-nD2UzSSEsbjBmeE23V0KdA3MkqkOCxtwv=Vw@mail.gmail.com>
Subject: Re: [External] Re: Discuss the implementation of pidns_install()
To:     Kees Cook <keescook@chromium.org>
Cc:     brauner@kernel.org, jeffxu@google.com, akpm@linux-foundation.org,
        cyphar@cyphar.come, mcgrof@kernel.org, frederic@kernel.org,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees Cook=EF=BC=8C

On Tue, Oct 10, 2023 at 4:08=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Wed, Sep 20, 2023 at 05:37:20PM +0800, yunhui cui wrote:
> > Hi Kees, jeff, Andrew, Christian,
> >
> > We hope that containers at the same level can also switch pid namespace=
.
> > To fork() the entire pstree of a container, we need to switch from the =
pid
> > namespace of the template container to the  target container's pid
> > namespace. But it is blocked by the following code:
> >
> > ...
> >         while (ancestor->level > active->level)
> >                 ancestor =3D ancestor->parent;
> >         if (ancestor !=3D active)
> >                 return -EINVAL;
> > ...
> >
> > Can we give this code permission, such as CAP_SYS_ADMIN ..., so that th=
ose
> > with this permission can switch to sibling pid namespace. Rather than j=
ust
> > parent, parent ...
> >
> > Do you think this plan is okay?  Or can you give me some suggestions?
>
> I'll defer to Christian on this, but it seems like moving processes
> sideways is kind of unexpected. I agree it'd need privilege if we did
> it, though.
>
>

I'll defer to Christian on this, but it seems like moving processes
sideways is kind of unexpected. I agree it'd need privilege if we did
it, though.

Thanks for your suggestion, my plan is to give this code SYS_ADMIN permissi=
ons.

CAP_SYS_ADMIN has been checked in pidns_install(), as follows:
static int pidns_install(struct nsproxy *nsproxy, struct ns_common *ns)
{
...
if (!ns_capable(new->user_ns, CAP_SYS_ADMIN) ||
!ns_capable(current_user_ns(), CAP_SYS_ADMIN))
return -EPERM;
...
}

So can I delete this code:
ancestor =3D new;
while (ancestor->level > active->level)
ancestor =3D ancestor->parent;
if (ancestor !=3D active)
return -EINVAL=EF=BC=9B

Thanks=EF=BC=8C
Yunhui
