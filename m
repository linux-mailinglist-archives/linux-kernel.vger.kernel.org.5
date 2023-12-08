Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B56809DFE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 09:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573264AbjLHISN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 03:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbjLHISK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 03:18:10 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18095B5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 00:18:17 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2866951b6e0so1825074a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 00:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702023496; x=1702628296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57GTQbkkoTIYsX8AsUQsI3kUtcdAazbeehTKAb0YI0U=;
        b=WlRmXHRWyCxY6SBJS/B3JMPrx6TavSKtlX4DHcQuhjyK9HowKXYHjXPSIlsP/RhVXX
         ESNIW14g9N3M2YYbjagHONLq7pcxy3st6coCWQSMIKMCZEIwPA5J1sgHMdiY7je+d33r
         aSHrjy/hfp8Xxi6HKhuDuUb5xfMqv1+BcJworPYF+Z1pX+rrJsndfWBNQfuGR7Sb32v9
         k8wDjUWKlviXUQHvGWXZiyLXu/1DOebcES/fdUB74QwiLefPl+d0hGhaZ7Su6kMvu5LF
         +jYuEEKkZd5OOHptN2YqxBOSEnRaSquoq2Rya/xpa/BVTu0lPQ0ZEUv0ir5Fmkla3eC9
         9L/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702023496; x=1702628296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57GTQbkkoTIYsX8AsUQsI3kUtcdAazbeehTKAb0YI0U=;
        b=qaEzv9azAk2ZqnoNYYJMA6KpVjs/zRBD/MaCHCi3InaQ2c8/bhy9wgrxVFl5Ji031r
         jeKnOUpbKtmB3FSHe69aMb2QcO7uC53C5PQtqtN4Hpcp0oepRI4w+ImNXtM8vbViz5Ew
         cr4HsIJa2eOD9uPWv1f3eXzevo88QrtsJ8IGZWlWxF/ri9XHtxQrEE1lGyqZ+5prgOMp
         pHBRjaVw3Weag0fVseVrQ53D3s4r9Xgjj5r2tFrzB919l+ygoXN2Jp2Th1LQDaC0oS5B
         /iQZ9D9l5ZPm+8Y62PKKQwX+DZMA/ApvUm89mmcJUjjVLxgvYXe5+4/VGNQzcxcJC5n/
         jgmw==
X-Gm-Message-State: AOJu0YyS8XEshoAHOCMJLS636shKRrfA1r5WzAtmzUdfNN9rR2/qoVXa
        XVmRXufQ/zdBmcOQecmss+LDy4wVwd5p9EeNpgw=
X-Google-Smtp-Source: AGHT+IGi1X/XlskQ5+TMOY03RSWWF151hJQT79NPJpPPpbuJ2c7kD0SlzWIHGDFuUWXWgmP5gVkqr7+UmleejaR9ZTk=
X-Received: by 2002:a17:90a:780e:b0:286:ca3e:be8c with SMTP id
 w14-20020a17090a780e00b00286ca3ebe8cmr3855048pjk.90.1702023496234; Fri, 08
 Dec 2023 00:18:16 -0800 (PST)
MIME-Version: 1.0
References: <20230902115026.13460-1-qiang.zhang1211@gmail.com>
 <ZPd4yKqbvBNGV7cL@slm.duckdns.org> <CALm+0cVf+E_Y41AdEwLjm2gZAjzeKaZev1Tu1hUS-VpYH0eEHQ@mail.gmail.com>
 <ZPiwaaZaDPVexezn@slm.duckdns.org> <CALm+0cUytR3-0mcW3t24gcyP27UW3rpP5_+vpLVC3w70+0n6oQ@mail.gmail.com>
 <ZQiRncEYCK3RYXA7@slm.duckdns.org> <CALm+0cU9W2P46cKnijeQRQFKzpqUyZUykQ-UFt28f4b4ueyAZg@mail.gmail.com>
 <CAB8ipk8J1H_pNacd8SjrByqNg9mgR_V6nbgZ8Ug6cyagFFk=iQ@mail.gmail.com>
In-Reply-To: <CAB8ipk8J1H_pNacd8SjrByqNg9mgR_V6nbgZ8Ug6cyagFFk=iQ@mail.gmail.com>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Fri, 8 Dec 2023 16:18:04 +0800
Message-ID: <CALm+0cVWmQHZPFgG5hjTixG3TFS_7XsDq8YY8tCugMFSJi6Cpw@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Fix UAF report by KASAN in pwq_release_workfn()
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, guohua.yan@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Hi qiang && Tejun
>
> On Tue, Sep 19, 2023 at 7:30=E2=80=AFPM Z qiang <qiang.zhang1211@gmail.co=
m> wrote:
> >
> > >
> > > On Thu, Sep 07, 2023 at 10:13:23AM +0800, Z qiang wrote:
> > > > >
> > > > > On Wed, Sep 06, 2023 at 10:12:34AM +0800, Z qiang wrote:
> > > > > > Flush the pwq_release_worker is insufficient, the call_rcu() is
> > > > > > invoked to release wq
> > > > > > in pwq_release_workfn(), this is also asynchronous.
> > > > >
> > > > > But rcu_free_pwq() doesn't access wq or anything. The last access=
 is from
> > > > > the work function.
> > > >
> > > > The rcu_free_wq() will access wq->cpu_pwq or unbound_attrs,
> > > > but  at this time, the kfree(wq) may have been called in alloc_work=
queue().
> > >
> > > I'm not following. The only way alloc_and_link fails is if
> > > apply_wqattrs_prepare() fails and if prepare fails, none of the pwq's=
 are
> > > installed and pwq_unbound_release_workfn() won't try to free the wq a=
s the
> > > pwq's don't have any reference on it. So, if you flush the pwq releas=
e work
> > > items, there can be no rcu_free_wq() in flight. Can you please try to=
 see
> > > whether the problem is reproducible with flushing?
> > >
> >
> > you are right .  sorry,  I ignore if apply_wqattrs_prepare() fails,
> > none of the pwq is installed,
> > the install_unbound_pwq() is not invoked. I will resend v2 and test.
>
> I want to ask a question, why delete the v1?
> Although add the flush_work, the release work would release the lockdep k=
ey,
> and at the last of alloc_workqueue, it would also unregister_lockdep_key =
twice.
>

For unbound wq,  if apply_workqueue_attrs() return error,  the link_pwq() w=
ill
not be invoked, that means will not insert pwq->pwqs_node to wq->pwqs list,
that also means the is_last is false in pwq_release_workfn().



> And other question, why not free lockdep and just unregister_lockdep?
>
> 4136         if (is_last) {
> 4137                 wq_unregister_lockdep(wq);
> 4138                 call_rcu(&wq->rcu, rcu_free_wq);
> 4139         }

free lockdep in rcu_free_wq();

Thanks
Zqiang

>
> I would really appreciate it if you could help explain it.
>
> Thanks!
> BR
>
>
>
> >
> > Thanks
> > Zqiang
> >
> > >
> > > Thanks.
> > >
> > > --
> > > tejun
