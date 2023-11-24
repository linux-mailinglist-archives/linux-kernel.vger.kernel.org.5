Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D1E7F767D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 15:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjKXOjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 09:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjKXOi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 09:38:58 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757E11718
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 06:39:04 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50ba71356ddso170380e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 06:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1700836742; x=1701441542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIB5HI2zbPMViiXeUmcjMKe9UaMCUWxP4QpCG/rkGCE=;
        b=C424cdNRJxG2M7uQnzJ/m+1NW+UG8kkgo9DVjdW424urv97A9F+VYO8P8f6M8yMS9F
         tubI70+/qnoDNHzqcpk/SFRA7ia5DDcs9z8uVI69PygLLFstoZYS1FeVjUy3G3/NO/8t
         6RkaVxXv3RfINyD4GOLdyVPCCe3FRfoLEKBS/DinkkywmfwLDnlfDaYhtO7If6CQF0cG
         kwhpMk29JQ1JIQUAaibw3xAFN2hT2ogT8m/lqXzWH5eWXCXgKrv+C9OsoiQKhgGDP6U+
         jiQp91cnMiqpe1yvo6/w+M0PmTBjOl03t40ES3IbuoIg95DBotH1Fu94vLzzhsgGXfD2
         kiyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700836742; x=1701441542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oIB5HI2zbPMViiXeUmcjMKe9UaMCUWxP4QpCG/rkGCE=;
        b=n3ekCLhXER1HGvuZFpMHdZ0zI9spJlJD0Uy6EeF1FRipuzn5ozUds/vSCi3Ck3hA+h
         Ux/v/LRk+fopIHdSU0JmUy+FAMh3aj/uSaZ99BSy5Vr7oIHVosS69Sx7SErg+uiR2t+R
         qiR7P7qKde+Ew1B4iUNKsuePhhhd/3v7itUb1BLN91QRyjtfdfRlXKDfX7dZED0Gr7xw
         8wWQyaAvmbnIewjfUsxNSDWA1fxp6pTMtDZ/I2Fy+c+AKhidiUKyKrNymwSKVOZEuBA5
         zapIC9hxawQ+jHpFeXsD9HYI97Ngi485fgaHBHazD6aDIFhulqV1yYvO4ILoCyAzKcHo
         gceA==
X-Gm-Message-State: AOJu0YzDZCsR/x/f+E81nHFSqtVhg6YWDHSGnglOgwQll4UO2C4wZlOZ
        2WnDD+4e/TunN8iT5oEvpzgT4c/SMuxGyQMgbmBO
X-Google-Smtp-Source: AGHT+IEtEQkJd1k/Ky6597iLeTfJxAs4uP2hyyJFFKocmbMLqlHjfBxQU/Ntue5KH/p8ujUm9cmjruw36NURi3X1U8M=
X-Received: by 2002:a05:6512:2805:b0:509:5d4b:44c4 with SMTP id
 cf5-20020a056512280500b005095d4b44c4mr2977498lfb.1.1700836742323; Fri, 24 Nov
 2023 06:39:02 -0800 (PST)
MIME-Version: 1.0
References: <20231103131011.1316396-1-lb@semihalf.com> <20231103131011.1316396-8-lb@semihalf.com>
 <CAJfuBxzWSyw-Xp3k5WzOexbRZFydCUp_nX4A_BZs8Gq0OE2U7Q@mail.gmail.com>
 <CAK8ByeL=A6xC=q8Ah4im4JQGUcN_NZNg10pSezBPCeKW9J_DeQ@mail.gmail.com>
 <CAJfuBxzH=G++Qs86OGUFTC2WuBZh8JZ4y7a7KcVi+7R8L3N7Fw@mail.gmail.com> <CAK8Bye+uX38zDyGdd4GbsYWfPACNiaiBW92vZuRjuM1VDQqe0A@mail.gmail.com>
In-Reply-To: <CAK8Bye+uX38zDyGdd4GbsYWfPACNiaiBW92vZuRjuM1VDQqe0A@mail.gmail.com>
From:   =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date:   Fri, 24 Nov 2023 15:38:51 +0100
Message-ID: <CAK8ByeK8mVQbmYsbCdZGf4F=RHPbGguDcKfhtbWF3-MpVDNkbg@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

niedz., 12 lis 2023 o 17:28 =C5=81ukasz Bartosik <lb@semihalf.com> napisa=
=C5=82(a):
>
> pt., 10 lis 2023 o 22:01 <jim.cromie@gmail.com> napisa=C5=82(a):
> >
> > On Fri, Nov 10, 2023 at 7:51=E2=80=AFAM =C5=81ukasz Bartosik <lb@semiha=
lf.com> wrote:
> > >
> > > sob., 4 lis 2023 o 02:49 <jim.cromie@gmail.com> napisa=C5=82(a):
> > > >
> > > > On Fri, Nov 3, 2023 at 7:10=E2=80=AFAM =C5=81ukasz Bartosik <lb@sem=
ihalf.com> wrote:
> > > > >
> > > > > From: Jim Cromie <jim.cromie@gmail.com>
> > > > >
> > > > > Move the JUMP_LABEL to the top of the struct, since theyre both
> > > > > align(8) and this closes a pahole (unfortunately trading for padd=
ing,
> > > > > but still).
> > > > >
> > > > > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > > >
> > > > let me add, I havent really tested this, nevermind thorough.
> > > > specifically, I didnt look for any offset dependence on the static-=
key
> > > > inside their container.
> > > > Conversely, maybe theres a free default or something in there.
> > > >
> > >
> > > Any idea how to properly test the relocation of the key ?
> >
> > I was hoping Jason knew it from memory.
> >
> > I have booted dd-kitchen-sink, which includes it, and it didnt melt the=
 box.
> >
> > I just checked `pahole vmlinux` output for the existence of 0-offset ke=
ys.
> > Its not conclusive, cuz im only looking at x86.
> >
> > it does occur, but only for "sub-types".
> >
> > struct static_key_true {
> >         struct static_key          key;                  /*     0    16=
 */
> >
> >         /* size: 16, cachelines: 1, members: 1 */
> >         /* last cacheline: 16 bytes */
> > };
> > struct static_key_false {
> >         struct static_key          key;                  /*     0    16=
 */
> >
> >         /* size: 16, cachelines: 1, members: 1 */
> >         /* last cacheline: 16 bytes */
> > };
> > struct static_key_false_deferred {
> >         struct static_key_false    key;                  /*     0    16=
 */
> > ...};
> > struct static_key_mod {
> >         struct static_key_mod *    next;                 /*     0     8=
 */
> > ...};
> > struct static_key_deferred {
> >         struct static_key          key;                  /*     0    16=
 */
>
> I will test it on arm64.

Hi Jim,

I verified that relocation of JUMP_LABEL to the top of the _ddebug
struct does not brak dynamic debug functionality on arm64.
I double checked I had CONFIG_JUMP_LABEL enabled in the kernel config for a=
rm64.
I was able to enable/disable callsites and see debug logs being written.

But if you're concerned there might be issue related to that
relocation on other architectures then let's drop this patch
and I will use pahole instead of padding for location of flags and
trace destination fields.
What do you think ?

Thanks,
Lukasz
