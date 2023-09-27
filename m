Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0EF7B0CA3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 21:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjI0Tfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 15:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjI0Tfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 15:35:41 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D287E114
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 12:35:39 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c008042211so202055711fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 12:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695843338; x=1696448138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OBZ4IYoE3UGlFGxrLn0BTpDP5IoGpepsXCJr4HwsmE=;
        b=chDU9h114PLb3ueLvc9KZH7uQPbYthAW/LocAwigQPI8F1pc9llAQoVC86LTm5wHho
         ECT30BdTiVKKwC5wBS24bYXnvGSvLgEMyRPRQVZMWYF2trKkNOrQt+Lrp04C+JIDqcnN
         4vWzJ6xSf/VR/zaKp//Xu+AapByOgPC+9AWCRp+QnN2G8MAfKlJan97hzumlrpDfm5/a
         CT0UNa82aWOMbEGhsBUpf29JGnW29n/2X6923lIuq8AsKSonKu1N3MWuGKdp4ofeliZq
         Nos/HUdBm1lUnfg1JHQpu6SuWaFBMw78p6uqgEeauqXdFIDcC2rX+mk5pxWwmr/Fyzkm
         KWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695843338; x=1696448138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4OBZ4IYoE3UGlFGxrLn0BTpDP5IoGpepsXCJr4HwsmE=;
        b=OBhNTub2yQml3bJbjF5jya9tn9BahTS2+cEIcHoCNryTNtGgHq5HpFeaKj2fZ+WPQw
         zRm9ipIOdK0cu4KANwnD7hVu14QGtlsSE2Fi11MMLyA2wEIDDbE8fJMzsfdHgwDn6CDf
         b/zrCHmRm/0S6ptnjYft7G+8lhxMYAUAttw1x//WP2TZRWt7UyJIKtW0Ts0n16cd9W5B
         Xwk7xo6A2PgAjrBYNi9CvkYhVW+7cgzPPE9JNBCx3VmusX0P7eThpvpXXv6Hdiv8rFyE
         c5IICdPsObG99RIH2o48F5Qk/nxcIKlki1Xw/6IN9xQf7i+p38a34wQk9nWX4m3JD45y
         wXJQ==
X-Gm-Message-State: AOJu0YyB/ORETVAs7gf/98ftJ9kPl7KnqdewPmL/zZDmjsM//7MC7lXn
        M/bcTRFwLFtluCCiXGoJkpUTbJZiqDEIVP2K9qotDA+MJPY=
X-Google-Smtp-Source: AGHT+IHhwf76s38RaAZ7EgW0fnLVrk6vmzRVLT0HM+oYD6dhWdYcbcdp+Az3hS0Kw6QAQuZ0ZzwNJsa6ObbFK2izdXc=
X-Received: by 2002:a05:651c:104:b0:2b9:e53f:e201 with SMTP id
 a4-20020a05651c010400b002b9e53fe201mr2716509ljb.31.1695843337780; Wed, 27 Sep
 2023 12:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAPDJoNtU9Vuh87PxDkxo+7M_Kg_K4PPNGksPuW_guFbChYu-jA@mail.gmail.com>
 <20220601155702.176588-1-ariel.miculas@gmail.com> <CAPDJoNvZmeeU+T94rp8BJ0+bH5pDXQCEKPHiQF0Kcu=JrRRfrg@mail.gmail.com>
 <CAPDJoNsb-HtfOQhD6ntZ8Hqx3fv3WAh1U5Jd3GzyN5EwO8znWA@mail.gmail.com>
 <CAPDJoNuR8pNa+rp-PG_eeS14EvpMBLAmjNf9JvL=+0QTpwww-w@mail.gmail.com>
 <d6bd3632-207e-b232-b4a1-0c592a3aaae9@csgroup.eu> <CAPDJoNvADrCj8L2RAthXVbBxMNrjbY_4pnHu0QtKKARgyoQ-QA@mail.gmail.com>
 <9afcdb29-db22-3f5c-b596-da7567b707ff@csgroup.eu>
In-Reply-To: <9afcdb29-db22-3f5c-b596-da7567b707ff@csgroup.eu>
From:   Ariel Miculas <ariel.miculas@gmail.com>
Date:   Wed, 27 Sep 2023 22:35:25 +0300
Message-ID: <CAPDJoNt1xzLHfVYDi09X8Tz-3urrepboW7-S=iM6TpWv=Qih7A@mail.gmail.com>
Subject: Re: Fwd: [PATCH] powerpc/ptrace: Fix buffer overflow when handling
 PTRACE_PEEKUSER and PTRACE_POKEUSER
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 7:01=E2=80=AFPM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 27/09/2023 =C3=A0 17:27, Ariel Miculas a =C3=A9crit :
> > I've forwarded this old email thread for visibility and discussion's
> > sake around my recent blog post [1][2]
>
> Ah, right, it's been superseded by
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20220609133245.57=
3565-1-mpe@ellerman.id.au/
>
> So I mark the new one superseded as well.
>
> By the way, is your other patch still applicable, ref
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20220610102821.25=
2729-1-ariel.miculas@belden.com/
> ?

Well, I think it's better to explicitly access fpscr than to implicitly
overflow fpr into fpscr. Because in the implicit case you need to make sure
fpscr comes directly after fpr and this relationship is never modified (e.g=
.
someone refactors the code and puts fpscr before fpr).

Regards,
Ariel
>
> Thanks
> Christophe
>
> >
> > Regards,
> > Ariel
> >
> > [1] https://news.ycombinator.com/item?id=3D37671991
> > [2] https://www.reddit.com/r/programming/comments/16tf5ne/how_i_got_rob=
bed_of_my_first_kernel_contribution/?ref=3Dshare&ref_source=3Dlink
