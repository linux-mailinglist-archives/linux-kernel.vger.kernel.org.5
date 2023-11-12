Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB0B7E91A4
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 17:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjKLQ25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 11:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbjKLQ24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 11:28:56 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E342D54
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 08:28:53 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5440f25dcc7so5595350a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 08:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1699806531; x=1700411331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=um03Yqqx/06N6+M1zoLQib+zcCkyW92PIAirsMhKLg8=;
        b=bXfWFE5ZsiHl5IcDanz/03ICE1XivxyMQjXlDDeKPuy2sW+bO22Q0I9T9Rm5m3+7Dv
         Us+6ItJ2YC4j1UrOJEGA8etQsfWMa4gQT5QRNkP2bfZnCM/uORUehKOb3aJ8Yewz6xOo
         Ed7moF+HoMWg/vjNKabZr8LGhPbWiNvkZeJxITI9Vb9VL6n3mcI+K5y1NcTNjPC1eJvO
         UJ5dT+NX6Ah51ePekqTtw3ypsiS/FkS6KtKKXoFWfb/PmH+MgoPjxL5ky52ZDNIOH5kH
         8scBCkgBSuwzaI2zfACZB5Na6LDdyX8QUBQsuUoHcWwBW3/8aVli4Gmn6doFonGxrrRn
         y9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699806531; x=1700411331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=um03Yqqx/06N6+M1zoLQib+zcCkyW92PIAirsMhKLg8=;
        b=tOkI+5SAGSKpwM4VWU2T+VFg+VtfVWgWemSd9n++isJkC/l5TWexn5yYD6+SBoLJNQ
         yxEZ1OoFMH3uK1x125tbfD5tEmB2iQIkLulBy7oTa8knOGv6CtTHDt39ZKES5dP9HIlj
         8F0GVlvf4kCv7Xg+kpqmPtAnXqBerV0AkXb42JWg36PE3M6MkjkdvrmghX3BCb1qYWMq
         nmKUZdGUKbbPj6LtNgCOXoA7tinZk9mmCtSGUf78gUvaDvdC4CJHwlX3jr6NRldBGaJN
         fTRuXcw41o0u1trSyTk8vkmJYisUkkDs6cNX1qEBJzTOIsJ2SQp1P2XD0s0m20Eo3VAF
         TpUg==
X-Gm-Message-State: AOJu0YzCd2gDAm+J+Ek0x4bN4Y1NR+e1cH7abHYV2uU3coFzd6JPQ3IR
        AtNv+bIT4veajPBKIG8xqGsz2YSeqFALv0G/+v7e
X-Google-Smtp-Source: AGHT+IHdMRQcXfdTOghv6I7AVQMIJxSRjIDaeRsaYn/4HdfCKacezBcBB0QhDXSzmYg9GipEzJ77HqPM5G5EVReBwEQ=
X-Received: by 2002:aa7:dcc7:0:b0:53e:343a:76bf with SMTP id
 w7-20020aa7dcc7000000b0053e343a76bfmr3525399edu.1.1699806531395; Sun, 12 Nov
 2023 08:28:51 -0800 (PST)
MIME-Version: 1.0
References: <20231103131011.1316396-1-lb@semihalf.com> <20231103131011.1316396-8-lb@semihalf.com>
 <CAJfuBxzWSyw-Xp3k5WzOexbRZFydCUp_nX4A_BZs8Gq0OE2U7Q@mail.gmail.com>
 <CAK8ByeL=A6xC=q8Ah4im4JQGUcN_NZNg10pSezBPCeKW9J_DeQ@mail.gmail.com> <CAJfuBxzH=G++Qs86OGUFTC2WuBZh8JZ4y7a7KcVi+7R8L3N7Fw@mail.gmail.com>
In-Reply-To: <CAJfuBxzH=G++Qs86OGUFTC2WuBZh8JZ4y7a7KcVi+7R8L3N7Fw@mail.gmail.com>
From:   =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date:   Sun, 12 Nov 2023 17:28:40 +0100
Message-ID: <CAK8Bye+uX38zDyGdd4GbsYWfPACNiaiBW92vZuRjuM1VDQqe0A@mail.gmail.com>
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

pt., 10 lis 2023 o 22:01 <jim.cromie@gmail.com> napisa=C5=82(a):
>
> On Fri, Nov 10, 2023 at 7:51=E2=80=AFAM =C5=81ukasz Bartosik <lb@semihalf=
.com> wrote:
> >
> > sob., 4 lis 2023 o 02:49 <jim.cromie@gmail.com> napisa=C5=82(a):
> > >
> > > On Fri, Nov 3, 2023 at 7:10=E2=80=AFAM =C5=81ukasz Bartosik <lb@semih=
alf.com> wrote:
> > > >
> > > > From: Jim Cromie <jim.cromie@gmail.com>
> > > >
> > > > Move the JUMP_LABEL to the top of the struct, since theyre both
> > > > align(8) and this closes a pahole (unfortunately trading for paddin=
g,
> > > > but still).
> > > >
> > > > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > >
> > > let me add, I havent really tested this, nevermind thorough.
> > > specifically, I didnt look for any offset dependence on the static-ke=
y
> > > inside their container.
> > > Conversely, maybe theres a free default or something in there.
> > >
> >
> > Any idea how to properly test the relocation of the key ?
>
> I was hoping Jason knew it from memory.
>
> I have booted dd-kitchen-sink, which includes it, and it didnt melt the b=
ox.
>
> I just checked `pahole vmlinux` output for the existence of 0-offset keys=
.
> Its not conclusive, cuz im only looking at x86.
>
> it does occur, but only for "sub-types".
>
> struct static_key_true {
>         struct static_key          key;                  /*     0    16 *=
/
>
>         /* size: 16, cachelines: 1, members: 1 */
>         /* last cacheline: 16 bytes */
> };
> struct static_key_false {
>         struct static_key          key;                  /*     0    16 *=
/
>
>         /* size: 16, cachelines: 1, members: 1 */
>         /* last cacheline: 16 bytes */
> };
> struct static_key_false_deferred {
>         struct static_key_false    key;                  /*     0    16 *=
/
> ...};
> struct static_key_mod {
>         struct static_key_mod *    next;                 /*     0     8 *=
/
> ...};
> struct static_key_deferred {
>         struct static_key          key;                  /*     0    16 *=
/

I will test it on arm64.
