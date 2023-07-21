Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F9575CA83
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 16:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjGUOsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 10:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjGUOsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 10:48:09 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CFFE52
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 07:48:07 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-40540a8a3bbso274751cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 07:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689950886; x=1690555686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6sSFiJgP0gs0HwrV3aQuow2fil5VFgTvbXpctbS367o=;
        b=NO59XVeD3uPHORoKhRouFsNmqm1dwlP2W1axHqWBLhKcTWvajztaSDlHSLQI001utc
         43BhzgF4N+hPn7mnTwe6foVG6w01WPBQ2S2i2rljoRBOff9T70Knli66OLGLTZlq17/9
         GgHp4vrrdiX9mTwG36e7i9RzBQkIMxPPs0u3hn1X7PG4UUFW0R07vQXmB+D8C+jwy96z
         mf7JBtdz8adlbgDFxYa/SyaxHEW/afpFTxEA8CvyDlzOIcWwZ5TKjSDdRgmfAZWqrzrE
         YuNcylS2e8lAjDytYBSGFYde2Ma694lO04XHteS8E6X5sA28djhyM5OJ1ptHnvzKYyLo
         NLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689950886; x=1690555686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6sSFiJgP0gs0HwrV3aQuow2fil5VFgTvbXpctbS367o=;
        b=Ghdh55F5DkR+XoYDFMoNw5zP9a9X9VU5Dh5YwImo6ADvqlqeROXQyiWPuiEdISQTps
         CNB11rZ6xxdsH1HMPPwm3V+GnGoPP/eqJHA+AER8GjC7kUyyR1RgmqyeLnlWi749ze2h
         ssucdCglZRkbddDuP3Jt8g3VdRfIROXCdVvz9Fda79CD+XmCrJsKbh5KnFJ/U3NH1EOs
         NILh13Yaqs4W3eVYFdj6eMUokUWhTzi8k08ya74pfGZgKEak9KCiJ8DqVrVQXs/X7xm6
         GMpz43b2ExLg4xSgxB0GkXcYGTHBLa4Pb7P7iwJfqjP3Z+BBGUqx5IRPcqo7ifq+I1oK
         iCew==
X-Gm-Message-State: ABy/qLZ9iLd8ZMoW7ytrGOrv5YlGzypH3pCBEK6/jPd2vvFKGXFvnRAP
        rKNOJ2bQA9we80ABh1K68G8Ic9HatSDJOl7Y9IWnsl+8BoVkc9+Y1uY=
X-Google-Smtp-Source: APBJJlEV2SYa1Zi27BZwq3Fkis0kB9TNTHtxEdejJQYTbzcp/4c2Yn46IBoyZ0HFbmW/igFnhule9/IW06lTcYMXZOE=
X-Received: by 2002:a05:622a:547:b0:403:f3f5:1a8 with SMTP id
 m7-20020a05622a054700b00403f3f501a8mr248798qtx.12.1689950886353; Fri, 21 Jul
 2023 07:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <04C1E631-725C-47AD-9914-25D5CE04DFF4@gmail.com>
 <CANn89iKJWw7zUP-E_d=Yhaz=Qw0R3Ae7ULaGgrtsi1yf2pfpGg@mail.gmail.com>
 <E9CF24C7-3080-4720-B540-BAF03068336B@gmail.com> <CANn89iLqU=huOuCt2kXmrXf68TUU-N90aQnMykkYcZ+Arx9-aA@mail.gmail.com>
 <EDE1C0AE-B479-49F9-995D-DA9CC1A6EA57@gmail.com>
In-Reply-To: <EDE1C0AE-B479-49F9-995D-DA9CC1A6EA57@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 21 Jul 2023 16:47:54 +0200
Message-ID: <CANn89iL47bu8bWu2EziK2gCJDBDb4Z5LAZJt1xhb_jQMaieG-g@mail.gmail.com>
Subject: Re: Question about the barrier() in hlist_nulls_for_each_entry_rcu()
To:     Alan Huang <mmpgouride@gmail.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        roman.gushchin@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 4:31=E2=80=AFPM Alan Huang <mmpgouride@gmail.com> w=
rote:
>
>
> > 2023=E5=B9=B47=E6=9C=8821=E6=97=A5 05:11=EF=BC=8CEric Dumazet <edumazet=
@google.com> =E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Thu, Jul 20, 2023 at 10:00=E2=80=AFPM Alan Huang <mmpgouride@gmail.c=
om> wrote:
> >>
> >>
> >>> 2023=E5=B9=B47=E6=9C=8821=E6=97=A5 03:22=EF=BC=8CEric Dumazet <edumaz=
et@google.com> =E5=86=99=E9=81=93=EF=BC=9A
> >>>
> >>> On Thu, Jul 20, 2023 at 8:54=E2=80=AFPM Alan Huang <mmpgouride@gmail.=
com> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> I noticed a commit c87a124a5d5e(=E2=80=9Cnet: force a reload of firs=
t item in hlist_nulls_for_each_entry_rcu=E2=80=9D)
> >>>> and a related discussion [1].
> >>>>
> >>>> After reading the whole discussion, it seems like that ptr->field wa=
s cached by gcc even with the deprecated
> >>>> ACCESS_ONCE(), so my question is:
> >>>>
> >>>>       Is that a compiler bug? If so, has this bug been fixed today, =
ten years later?
> >>>>
> >>>>       What about READ_ONCE(ptr->field)?
> >>>
> >>> Make sure sparse is happy.
> >>
> >> It caused a problem without barrier(), and the deprecated ACCESS_ONCE(=
) didn=E2=80=99t help:
> >>
> >>        https://lore.kernel.org/all/519D19DA.50400@yandex-team.ru/
> >>
> >> So, my real question is: With READ_ONCE(ptr->field), are there still s=
ome unusual cases where gcc
> >> decides not to reload ptr->field?
> >
> > I can not really answer without seeing an actual patch...
>
> The content of the potential patch:
>
> diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.=
h
> index 89186c499dd4..bcd39670f359 100644
> --- a/include/linux/rculist_nulls.h
> +++ b/include/linux/rculist_nulls.h
> @@ -158,15 +158,9 @@ static inline void hlist_nulls_add_fake(struct hlist=
_nulls_node *n)
>   * @pos:       the &struct hlist_nulls_node to use as a loop cursor.
>   * @head:      the head of the list.
>   * @member:    the name of the hlist_nulls_node within the struct.
> - *
> - * The barrier() is needed to make sure compiler doesn't cache first ele=
ment [1],
> - * as this loop can be restarted [2]
> - * [1] Documentation/memory-barriers.txt around line 1533
> - * [2] Documentation/RCU/rculist_nulls.rst around line 146
>   */
>  #define hlist_nulls_for_each_entry_rcu(tpos, pos, head, member)         =
               \
> -       for (({barrier();}),                                             =
       \
> -            pos =3D rcu_dereference_raw(hlist_nulls_first_rcu(head));   =
         \
> +       for (pos =3D rcu_dereference_raw(hlist_nulls_first_rcu(head));   =
         \
>                 (!is_a_nulls(pos)) &&                                    =
       \
>                 ({ tpos =3D hlist_nulls_entry(pos, typeof(*tpos), member)=
; 1; }); \
>                 pos =3D rcu_dereference_raw(hlist_nulls_next_rcu(pos)))
> @@ -180,8 +174,7 @@ static inline void hlist_nulls_add_fake(struct hlist_=
nulls_node *n)
>   * @member:    the name of the hlist_nulls_node within the struct.
>   */
>  #define hlist_nulls_for_each_entry_safe(tpos, pos, head, member)        =
       \
> -       for (({barrier();}),                                             =
       \
> -            pos =3D rcu_dereference_raw(hlist_nulls_first_rcu(head));   =
         \
> +       for (pos =3D rcu_dereference_raw(hlist_nulls_first_rcu(head));   =
         \
>                 (!is_a_nulls(pos)) &&                                    =
       \
>                 ({ tpos =3D hlist_nulls_entry(pos, typeof(*tpos), member)=
;        \
>                    pos =3D rcu_dereference_raw(hlist_nulls_next_rcu(pos))=
; 1; });)
>
>
> >
> > Why are you asking ? Are you tracking compiler bug fixes ?
>
> The barrier() here makes me confused.
>
> If we really need that, do we need:
>
>         READ_ONCE(head->first);
>         barrier();
>         READ_ONCE(head->first);
>

Nope, the patch you want to revert (while it did fix (by pure luck
???) a real bug back in the days) was replacing

ACCESS_ONCE()

by

barrier();
ACCESS_ONCE();

(There is one ACCESS_ONCE(), not two of them)

BTW,
  barrier();
  followed by an arbitrary number of barrier(); back to back,
translates to one barrier()

Frankly, I would not change the code, unless someone can explain what
was the issue.
(Perhaps there was a missing barrier elsewhere)
