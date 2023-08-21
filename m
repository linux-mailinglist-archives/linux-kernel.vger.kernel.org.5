Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7AC782EC3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236659AbjHUQuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbjHUQuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:50:17 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26A9CC;
        Mon, 21 Aug 2023 09:50:15 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-56a3e6bce68so745206a12.1;
        Mon, 21 Aug 2023 09:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692636615; x=1693241415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XR2yyunJzTVylJd0O9OMot2bWsAj0OOysrvklSnCbu4=;
        b=awZ8EcWECM2Gf+b7+fHdgw7ooZozUCf5/xbrV8Ub3ayWY6HpgbjDxyBaftAx1939KQ
         8FdzvU5QvNOhM0GVlZSjFPyIQcAvKd5R9bEPOvOnrlf/okLkmNHBnx68cRIk1VhsaJiJ
         npsotZm3pgEy2PPoIRVeNmERJX2icwmibmwnyON8jH62HlZVgjURKt3tA32bdWv014UF
         5PzaLSFwLs8lemgh8PpYr/+qs/ZbN8leBkT4yqPyEHxmCz255vES8MNIg/TWcmOuDIeN
         p9FPHH9NuuZk5YA1GMgZzOqWhFKWbmnfi6IAsvlBNBRrzaEjcT0BosLYUj7MXMXjpQD5
         K6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692636615; x=1693241415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XR2yyunJzTVylJd0O9OMot2bWsAj0OOysrvklSnCbu4=;
        b=h239MUI0lUFM0wqH3ljN5NdcUmZw+uwjievFU/58TkpBItA3Aeq6WEV9eVNdixFDwK
         Q9TGqiFj2FyR2eKPVOHHZ7D6fBI0K5Tb+Nsce6pste1xVvw8N80faAdjVGKNMu7/Xb48
         zg14Ea2wAQXfweQatDkWqYMgPQ3yIrzu+HpoO93EXy+ctFNCg7G2n2mhCN+0xDGVJb/X
         2u3Tpxj48Svk99SlSMAQjEM3wJaQSgPAxQpWfFbLMgBJulaDSGrVJvwO1GVv9sM7WQji
         CA4GgSK0YPYmB3BXVlCcTEUTewOrfFl7ginTB6wulgaW3xGHKz+Al3AVqFhXMnRbkI79
         Ogxg==
X-Gm-Message-State: AOJu0Yx5ZQjpblt9TkprHTim79GN3g0fiqqHTf5V6qzmGtxSmQLu3+hS
        MKLIZ9E3n4H+IO9JLTkewn2dw+IV1e2cvyaH5Kw=
X-Google-Smtp-Source: AGHT+IHiuWf7GBuYIkxaCdpdgJmZc6c20f/H/tO0At/LUg3HH4ULaGaMZtK6LsAajICuZKR1GOO0Hq8s4upJ2qM2zYU=
X-Received: by 2002:a17:90a:a389:b0:269:7eea:d7f6 with SMTP id
 x9-20020a17090aa38900b002697eead7f6mr3862231pjp.49.1692636615233; Mon, 21 Aug
 2023 09:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230817101014.3484715-1-martin@geanix.com> <20230817101014.3484715-2-martin@geanix.com>
 <20230817094529.68ae1083@kernel.org> <CAMZ6RqLvbp8EStaSRFQUimhUMpn75=3pkQZYspnP1gYRsspv-g@mail.gmail.com>
 <CAMZ6RqLmNJ0zL9XO9zGCu=CbUHgm68M42fwqkSKk-rSAosCWzg@mail.gmail.com> <cca27b04-8b06-78d1-fe0a-50a10dcbebe2@hartkopp.net>
In-Reply-To: <cca27b04-8b06-78d1-fe0a-50a10dcbebe2@hartkopp.net>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Tue, 22 Aug 2023 01:50:04 +0900
Message-ID: <CAMZ6RqJGjEMfst=4ksGeTnxovbALpSH4DX0fnajqKrO8Jivgag@mail.gmail.com>
Subject: Re: [PATCH 1/2] can: netlink: support setting hardware filters
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        =?UTF-8?Q?Martin_Hundeb=C3=B8ll?= <martin@geanix.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        linux-can <linux-can@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Mon. 21 Aug. 2023 at 04:21, Oliver Hartkopp <socketcan@hartkopp.net> wro=
te:
> On 19.08.23 15:29, Vincent Mailhol wrote:
> > On Sat. 19 Aug. 2023 at 22:10, Vincent Mailhol
> > <vincent.mailhol@gmail.com> wrote:
> >> On Sat. 19 Aug. 2023, 01:19, Jakub Kicinski <kuba@kernel.org> wrote:
> >>>
> >>> On Thu, 17 Aug 2023 12:10:13 +0200 Martin Hundeb=C3=B8ll wrote:
> >>>> +             int len =3D nla_len(data[IFLA_CAN_HW_FILTER]);
> >>>> +             int num_filter =3D len / sizeof(struct can_filter);
> >>>> +             struct can_filter *filter =3D nla_data(data[IFLA_CAN_H=
W_FILTER]);
> >>>
> >>> This will prevent you from ever extending struct can_filter in
> >>> a backward-compatible fashion, right? I obviously know very little
> >>> about CAN but are you confident a more bespoke API to manipulate
> >>> filters individually and allow extensibility is not warranted?
> >>
> >> I follow Jakub's point of view.
> >>
> >> The current struct can_filter is not sound. Some devices such as the
> >> ES582.1 supports filtering of the CAN frame based on the flags (i.e.
> >> SFF/EFF, RTR, FDF).
> >
> > I wrote too fast. The EFF and RTR flags are contained in the canid_t,
> > so the current struct can_filter is able to handle these two flags.
> > But it remains true that the CAN-FD flags (FDF and BRS) are currently
> > not handled. Not to mention that more flags will come with the
> > upcoming CAN XL.
>
> You are right with FDF where we could use the former CAN_ERR_FLAG value
> which is not needed for hw filter API.

And what about the BRS flag?

> But regarding CAN XL we could use the Standard 11 bit ID handling with
> another flag inside the remaining 18 bits.

Then, wouldn't you still need one more flag to indicate that this is a
CAN XL filter?

> The general concept of re-using the struct can_filter makes sense to me
> as this follows the widely used pattern in the af_can.c core and CAN_RAW
> sockets.
>
> Best regards,
> Oliver
>
> >
> >> I think that each of the fields of the filter should have its own NLA
> >> declaration with the whole thing wrapped within a NLA_NESTED_ARRAY.
> >>
> >> I also think that there should then be a method to report the precise
> >> filtering capabilities of the hardware.
> >>
> >>
> >> Yours sincerely,
> >> Vincent Mailhol
