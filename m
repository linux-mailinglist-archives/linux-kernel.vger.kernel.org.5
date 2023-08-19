Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CBB7819A8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 15:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbjHSNLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 09:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbjHSNLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 09:11:45 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003A51CABC;
        Sat, 19 Aug 2023 06:10:48 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-26b56cc7896so1091538a91.3;
        Sat, 19 Aug 2023 06:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692450648; x=1693055448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1e+/XnsKbjswDuOJErNhCCCCiL5iSSWZ7RF7mQ7/+3w=;
        b=dwid1HtELpcOUIDba9rowZithC342CaX+0ngTuoCeNcueWxXGFhoWXugu7R4ecOTrC
         I+wpq1K4TlPwvXLxFp0FL+Jx2nhNrnQEEPH2gRsIlEomRiDDMB9gbyNxudIc+ZRIZkYB
         Wu9dJW491DFNgAWornGvxBIeDQuarRvCYe96XBUCuxy0q87R4/NGT5cbbgbS1sPCybAW
         eNpTlNirDvufASE2ol3xIdQfreVVxmzuIAToa1evJG21qld3oNtSbCWRZ/x0XRTU1yG6
         0VofgmdvBMsdxKjzpRRE2PnbiIiLzWXYbbbmDV64y8ZBXxO7mKYVLTwuBxOaxSqflQQM
         9QQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692450648; x=1693055448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1e+/XnsKbjswDuOJErNhCCCCiL5iSSWZ7RF7mQ7/+3w=;
        b=RqcxFsBQDgiKObc75lFu4GAK6+EJ+A4o9x62FDYNmyWht95Au8U8J8m5krTChXDJFr
         DQ3dQCz+h9aKgqT7kO+Ocuqgbjh/MP6sgnBwGpRfg3anCzJp4GF5BETbh4kbytqrW8IJ
         otTWDkPYhPFjnGcnH+ci1pQpFQuQm7WfMKkdrJYcm8SySYj3pX4g73o0mo2GES1FP0LJ
         qItc0F4ip66wxc3TyEmPwL+3HyvH4SWA5ON+wQR0wCxpM5hIwc+lYaVkjKDaao8oiH4A
         8YCWVxMGKztWvmDsPoSYzLl+SPb6l4diR0rPcYiNeHmb7hj6XjB3AUixOztsAIylLJUG
         gWzA==
X-Gm-Message-State: AOJu0Yw48ilyojxvBcO5qKXjCrF5t15fHcSvz9I5mSbF3XGVj9WMEwZB
        6BQvt6qrsINYZCcEmA9Ykv2JgRoejU39A92/dt8=
X-Google-Smtp-Source: AGHT+IEi7ryax+7gcMZllWjyl1lEZYP/Sxe6jDorLDrYSUoJSuj5qN0WtumtQ6/fR+4XZPf4+VbMKLip+gBwMC4uYcY=
X-Received: by 2002:a17:90a:f98a:b0:268:2d92:55d3 with SMTP id
 cq10-20020a17090af98a00b002682d9255d3mr1120669pjb.39.1692450647831; Sat, 19
 Aug 2023 06:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230817101014.3484715-1-martin@geanix.com> <20230817101014.3484715-2-martin@geanix.com>
 <20230817094529.68ae1083@kernel.org>
In-Reply-To: <20230817094529.68ae1083@kernel.org>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Sat, 19 Aug 2023 22:10:36 +0900
Message-ID: <CAMZ6RqLvbp8EStaSRFQUimhUMpn75=3pkQZYspnP1gYRsspv-g@mail.gmail.com>
Subject: Re: [PATCH 1/2] can: netlink: support setting hardware filters
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     =?UTF-8?Q?Martin_Hundeb=C3=B8ll?= <martin@geanix.com>,
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

On Sat. 19 Aug. 2023, 01:19, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Thu, 17 Aug 2023 12:10:13 +0200 Martin Hundeb=C3=B8ll wrote:
> > +             int len =3D nla_len(data[IFLA_CAN_HW_FILTER]);
> > +             int num_filter =3D len / sizeof(struct can_filter);
> > +             struct can_filter *filter =3D nla_data(data[IFLA_CAN_HW_F=
ILTER]);
>
> This will prevent you from ever extending struct can_filter in
> a backward-compatible fashion, right? I obviously know very little
> about CAN but are you confident a more bespoke API to manipulate
> filters individually and allow extensibility is not warranted?

I follow Jakub's point of view.

The current struct can_filter is not sound. Some devices such as the
ES582.1 supports filtering of the CAN frame based on the flags (i.e.
SFF/EFF, RTR, FDF).

I think that each of the fields of the filter should have its own NLA
declaration with the whole thing wrapped within a NLA_NESTED_ARRAY.

I also think that there should then be a method to report the precise
filtering capabilities of the hardware.


Yours sincerely,
Vincent Mailhol
