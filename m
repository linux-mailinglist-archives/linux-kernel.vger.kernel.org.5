Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C43E7FADB1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbjK0Wqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbjK0Wqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:46:52 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0841E136
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:46:58 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50aabfa1b75so6834209e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1701125216; x=1701730016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6h9xJ1VXHv+qvv2KV0aJYsRErzcVo7sfauMJWo2Gqg=;
        b=ISMjksLtODNUpoBIB4lu0wYzBwciHOhp7Yxcr+YgscVmxNrtY6kUrFrRpzNQ3Q19U1
         HYwEMVCc8pAqiusxgj4e6RzQ9Ki8dX68aOlNA4Is6uLQtb7LpduOXrPm3ieaglURSsiG
         tyA/Gk0jGjDniwNPmEOPvxXsERknd5VB7h3fcy6YPBmSwMcCSMlaR54n/UrSqQVh5WFt
         hcy50Lj1elLnWNGRhOXu3dj0vdCDb7ODmFgUqK8F/n1GCosEkrGPjXRdBSSiYgi71t6T
         WylB3euWGiLumOcxB4IwwLSjEs1D3ZHUGeyyq9h7MYiNQ5fIhWhr4dvlrdQ6TiN6nKE8
         Cvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701125216; x=1701730016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6h9xJ1VXHv+qvv2KV0aJYsRErzcVo7sfauMJWo2Gqg=;
        b=od1CoFzI4yUL0axSir2sLzVAY0cAWX90yMq/2TdM8QF6R/i4EOWNumYW2H+YSoAuRH
         mzmwEOLEOOLs0MXDDw7UpbLI3mDcjyng2koC570IDYGQyDDBthBhFHZpGpKskMRDkJkf
         1fJLQpvciewTNWVZ3XLs6yXI9sAHJACGUczWY2tkCd/ssKQhtywR4t8qrLkO4U/CQWeH
         gO1g77H702hAn3Np0NWn67AQ2LSNAOw5SnqQNOdI5v+8i5byleHV8tl1NgEMgAdhrN8e
         exRThmajaEWo5m5X3pK6WEYq/+AqeHeko67PQWuHBYvnsX90p2dLPnOZrxjf8vM32g0b
         WvFA==
X-Gm-Message-State: AOJu0YzbiQc/UD2oRj3uzIopKlkpEGwbYMFwMa4PenzYWkQ/G/Jd9gsP
        T1XGJHJKgjJuFWmOpeBSDSptWb5Ya7sJvz/HOXOHyjZBcviFwvg=
X-Google-Smtp-Source: AGHT+IEHlofYKiVFRD+a0QshyTP4Axy7hN3IFZ8/uWujZWXRGn5gtaru88msHJ7/6QtORF8Eyb/iKgPyv/srktguhiI=
X-Received: by 2002:a05:6512:3b0a:b0:509:4b78:69b5 with SMTP id
 f10-20020a0565123b0a00b005094b7869b5mr7567693lfv.36.1701125216093; Mon, 27
 Nov 2023 14:46:56 -0800 (PST)
MIME-Version: 1.0
References: <20231103131011.1316396-1-lb@semihalf.com> <20231103131011.1316396-8-lb@semihalf.com>
 <CAJfuBxzWSyw-Xp3k5WzOexbRZFydCUp_nX4A_BZs8Gq0OE2U7Q@mail.gmail.com>
 <CAK8ByeL=A6xC=q8Ah4im4JQGUcN_NZNg10pSezBPCeKW9J_DeQ@mail.gmail.com>
 <CAJfuBxzH=G++Qs86OGUFTC2WuBZh8JZ4y7a7KcVi+7R8L3N7Fw@mail.gmail.com>
 <CAK8Bye+uX38zDyGdd4GbsYWfPACNiaiBW92vZuRjuM1VDQqe0A@mail.gmail.com>
 <CAK8ByeK8mVQbmYsbCdZGf4F=RHPbGguDcKfhtbWF3-MpVDNkbg@mail.gmail.com> <CAJfuBxyVDy6e-M+g7-aydfHov_KGuF5Ze7Gx_bEGuU5mzzjbcg@mail.gmail.com>
In-Reply-To: <CAJfuBxyVDy6e-M+g7-aydfHov_KGuF5Ze7Gx_bEGuU5mzzjbcg@mail.gmail.com>
From:   =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date:   Mon, 27 Nov 2023 23:46:44 +0100
Message-ID: <CAK8ByeKXh2JWW8vsokx4wJo_S7GZvg=McJBJ7sucp5Lf6Ccbvw@mail.gmail.com>
Subject: Re: [PATCH v1 07/12] dyndbg: repack struct _ddebug
To:     jim.cromie@gmail.com
Cc:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        Yaniv Tzoreff <yanivt@google.com>,
        Benson Leung <bleung@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

niedz., 26 lis 2023 o 07:00 <jim.cromie@gmail.com> napisa=C5=82(a):
>
> On Fri, Nov 24, 2023 at 7:39=E2=80=AFAM =C5=81ukasz Bartosik <lb@semihalf=
.com> wrote:
> >
> > niedz., 12 lis 2023 o 17:28 =C5=81ukasz Bartosik <lb@semihalf.com> napi=
sa=C5=82(a):
> > >
> > > pt., 10 lis 2023 o 22:01 <jim.cromie@gmail.com> napisa=C5=82(a):
> > > >
> > > > On Fri, Nov 10, 2023 at 7:51=E2=80=AFAM =C5=81ukasz Bartosik <lb@se=
mihalf.com> wrote:
> > > > >
> > > > > sob., 4 lis 2023 o 02:49 <jim.cromie@gmail.com> napisa=C5=82(a):
> > > > > >
> > > > > > On Fri, Nov 3, 2023 at 7:10=E2=80=AFAM =C5=81ukasz Bartosik <lb=
@semihalf.com> wrote:
> > > > > > >
> > > > > > > From: Jim Cromie <jim.cromie@gmail.com>
> > > > > > >
> > > > > > > Move the JUMP_LABEL to the top of the struct, since theyre bo=
th
> > > > > > > align(8) and this closes a pahole (unfortunately trading for =
padding,
> > > > > > > but still).
> > > > > > >
> > > > > > > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > > > > >
> > > > > > let me add, I havent really tested this, nevermind thorough.
> > > > > > specifically, I didnt look for any offset dependence on the sta=
tic-key
> > > > > > inside their container.
> > > > > > Conversely, maybe theres a free default or something in there.
> > > > > >
> > > > >
> > > > > Any idea how to properly test the relocation of the key ?
> > > >
> > > > I was hoping Jason knew it from memory.
> > > >
> > > > I have booted dd-kitchen-sink, which includes it, and it didnt melt=
 the box.
> > > >
> > > > I just checked `pahole vmlinux` output for the existence of 0-offse=
t keys.
> > > > Its not conclusive, cuz im only looking at x86.
> > > >
> > > > it does occur, but only for "sub-types".
> > > >
> > > > struct static_key_true {
> > > >         struct static_key          key;                  /*     0  =
  16 */
> > > >
> > > >         /* size: 16, cachelines: 1, members: 1 */
> > > >         /* last cacheline: 16 bytes */
> > > > };
> > > > struct static_key_false {
> > > >         struct static_key          key;                  /*     0  =
  16 */
> > > >
> > > >         /* size: 16, cachelines: 1, members: 1 */
> > > >         /* last cacheline: 16 bytes */
> > > > };
> > > > struct static_key_false_deferred {
> > > >         struct static_key_false    key;                  /*     0  =
  16 */
> > > > ...};
> > > > struct static_key_mod {
> > > >         struct static_key_mod *    next;                 /*     0  =
   8 */
> > > > ...};
> > > > struct static_key_deferred {
> > > >         struct static_key          key;                  /*     0  =
  16 */
> > >
> > > I will test it on arm64.
> >
> > Hi Jim,
> >
> > I verified that relocation of JUMP_LABEL to the top of the _ddebug
> > struct does not brak dynamic debug functionality on arm64.
> > I double checked I had CONFIG_JUMP_LABEL enabled in the kernel config f=
or arm64.
> > I was able to enable/disable callsites and see debug logs being written=
.
> >
> > But if you're concerned there might be issue related to that
> > relocation on other architectures then let's drop this patch
> > and I will use pahole instead of padding for location of flags and
> > trace destination fields.
> > What do you think ?
> >
>
>
> On balance, I think it should go in.
> 0 - my bias was towards abundance of paranoia
> 1 - youve done real work to evaluate the actual risk
> 2 - Jason is on thread, hasnt said WHOA
> 3 - actual patches have seen some testing (lkp-robot included)
> 4 - static-keys/jump-labels have been around a long time
>
> One new topic:
>
> Do you have any thoughts or plans wrt self-testing ?
>

Actually I didn't think about it at all ;). It is not so common
practice to write tests among kernel developers. Addition of trace
instances & events to the dynamic debug is a major change so I see the
value in having it thoroughly tested. That said I'm not saying no to
writing test harness for that purpose but I wonder if there is any
test framework in the kernel that could be reused or is everyone on
their own when it comes to the testing area ?

Thanks,
Lukasz

> the addition of private instances,
> that can be opened & closed, and written to by +T:private_1
>
> would benefit greatly from a test harness to validate it.
> so far all Ive done is demo scripts
>
> :-) thanks
>
> > Thanks,
> > Lukasz
