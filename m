Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8808809D2A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573242AbjLHHce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573274AbjLHHcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:32:16 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA4019B4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:32:16 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1fb9884ee04so1214676fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 23:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702020735; x=1702625535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjJS8HSQDSnXrxZ5dUx3kPD9L3rXlLFUfqrUorHps48=;
        b=FDZLJDJFun85ISpLG78cz5DUW62C7JMJx7JNPrFUNlo9cJ+lZHwJhlrTEgki8zaZFx
         B+XHvBtLWwHih5vQ78iNw2oDWo4B9Uo3tAH/ImccpURjwpFDQnqhzVdi410gB4Cfznv5
         EzWHwnDpvJwA7Z4QVSa+2SCmjfG++lxhmxcNt0O4ofADrYRTvZW+Iq1AzPJ9VmezuJpr
         J1q5x4ILM8fXM0t+BLUFIq1m2vq3d0XpjpHrgr3Nsg9jDlu1r6exVOZFJb9cA6l5KGUT
         XEFrBymlriCji5VFHMGq5p3QxyKrpytr02DjC9FDBhQvxT00RIDVglrgCic6LbSVBY0w
         wsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702020735; x=1702625535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EjJS8HSQDSnXrxZ5dUx3kPD9L3rXlLFUfqrUorHps48=;
        b=Nt7UOT2mbR6oiYKRAVZr2KIci/Q2JqxTSLG19jR2E3e0zdWsJ2aS+qG+ErptxC5pZ+
         fbVDGAt2qToES9pGpsTRhL9klSgCfIMqNF8mrkAaBNF/1DM7TakFZCI4BlydNg3p8W88
         UUzCDQRcYZ6of+CNefLaQgNKLmt9WoZDMTaaTvwVtQbsD4OC24lqL9bxjzAGcxITIcnK
         nOF65Hv2gMFq6+D6VTi6YT4O5LJitUDhjF1ufz254BKKM6EJh+PAlfcdaihmMVlsKX2b
         z3PDkjniH0IuiINMPkiZBL1Qgg3gJlmkJvtXGhlejrZio+WlnsWnuo3JR/iny+kkoJrY
         rbww==
X-Gm-Message-State: AOJu0YyQ6V9avBrAGnOz15v9Y4hbQhBNcBcvWFlZfPEaVP+wh+AnGGUY
        muc/hEvgdAG1cppDUb2tnExk528KXHk02ZQaQnVe/wRkqCQ=
X-Google-Smtp-Source: AGHT+IGA9AtMSmTYK558NKTSPw7yjK8uH+6MOfVWiGY3yTUA6/jgaHGeo2kgqTypTB7jB1uGD3KovK3NW2hG+Tit5VQ=
X-Received: by 2002:a05:6870:9728:b0:1fa:df7d:754a with SMTP id
 n40-20020a056870972800b001fadf7d754amr4424706oaq.5.1702020735716; Thu, 07 Dec
 2023 23:32:15 -0800 (PST)
MIME-Version: 1.0
References: <20230902115026.13460-1-qiang.zhang1211@gmail.com>
 <ZPd4yKqbvBNGV7cL@slm.duckdns.org> <CALm+0cVf+E_Y41AdEwLjm2gZAjzeKaZev1Tu1hUS-VpYH0eEHQ@mail.gmail.com>
 <ZPiwaaZaDPVexezn@slm.duckdns.org> <CALm+0cUytR3-0mcW3t24gcyP27UW3rpP5_+vpLVC3w70+0n6oQ@mail.gmail.com>
 <ZQiRncEYCK3RYXA7@slm.duckdns.org> <CALm+0cU9W2P46cKnijeQRQFKzpqUyZUykQ-UFt28f4b4ueyAZg@mail.gmail.com>
In-Reply-To: <CALm+0cU9W2P46cKnijeQRQFKzpqUyZUykQ-UFt28f4b4ueyAZg@mail.gmail.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Fri, 8 Dec 2023 15:32:04 +0800
Message-ID: <CAB8ipk8J1H_pNacd8SjrByqNg9mgR_V6nbgZ8Ug6cyagFFk=iQ@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Fix UAF report by KASAN in pwq_release_workfn()
To:     Z qiang <qiang.zhang1211@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, guohua.yan@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi qiang && Tejun

On Tue, Sep 19, 2023 at 7:30=E2=80=AFPM Z qiang <qiang.zhang1211@gmail.com>=
 wrote:
>
> >
> > On Thu, Sep 07, 2023 at 10:13:23AM +0800, Z qiang wrote:
> > > >
> > > > On Wed, Sep 06, 2023 at 10:12:34AM +0800, Z qiang wrote:
> > > > > Flush the pwq_release_worker is insufficient, the call_rcu() is
> > > > > invoked to release wq
> > > > > in pwq_release_workfn(), this is also asynchronous.
> > > >
> > > > But rcu_free_pwq() doesn't access wq or anything. The last access i=
s from
> > > > the work function.
> > >
> > > The rcu_free_wq() will access wq->cpu_pwq or unbound_attrs,
> > > but  at this time, the kfree(wq) may have been called in alloc_workqu=
eue().
> >
> > I'm not following. The only way alloc_and_link fails is if
> > apply_wqattrs_prepare() fails and if prepare fails, none of the pwq's a=
re
> > installed and pwq_unbound_release_workfn() won't try to free the wq as =
the
> > pwq's don't have any reference on it. So, if you flush the pwq release =
work
> > items, there can be no rcu_free_wq() in flight. Can you please try to s=
ee
> > whether the problem is reproducible with flushing?
> >
>
> you are right .  sorry,  I ignore if apply_wqattrs_prepare() fails,
> none of the pwq is installed,
> the install_unbound_pwq() is not invoked. I will resend v2 and test.

I want to ask a question, why delete the v1?
Although add the flush_work, the release work would release the lockdep key=
,
and at the last of alloc_workqueue, it would also unregister_lockdep_key tw=
ice.

And other question, why not free lockdep and just unregister_lockdep?

4136         if (is_last) {
4137                 wq_unregister_lockdep(wq);
4138                 call_rcu(&wq->rcu, rcu_free_wq);
4139         }

I would really appreciate it if you could help explain it.

Thanks!
BR



>
> Thanks
> Zqiang
>
> >
> > Thanks.
> >
> > --
> > tejun
