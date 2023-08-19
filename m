Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850707819B4
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 15:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbjHSN3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 09:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbjHSN3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 09:29:46 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1074212761;
        Sat, 19 Aug 2023 06:29:31 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-56546b45f30so1429895a12.3;
        Sat, 19 Aug 2023 06:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692451770; x=1693056570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBvCJLgdbds9yMG1zJ/sZSFWfzBUh6K/ALsYYt3rpTY=;
        b=S7Nv72YLp9CPkp/wEe8NG7NKHXcVilBVMZ4dz320VCIx00S8MKYiTkgyxP8rvrJOai
         uid1Q72FceFzV4cCOHVaLG2Fptdjk19Ggc9uTK3BvEdA4zX9uMbIMr6+5HJKIx0qfzt+
         Pt0LT4u2RAmk7X3dFdLrepbYdgtOk2WxOfrCHUEh5ByZt+mUSbDdh3G6/d1+njMYmMFo
         q5qeHq7wdpwzh/3hevJA6Qg5R00+3HYfEprGP2wKOayB40qHh0q4EjdAJ4UGeNajWSwr
         DA7Et1/HfoHrzXFX9Wz3H134eksl/JzCegrn859sPVmRbrgBWiCmjqpnTa0qzTmIK+6I
         2LFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692451770; x=1693056570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FBvCJLgdbds9yMG1zJ/sZSFWfzBUh6K/ALsYYt3rpTY=;
        b=OYkCCCq6IK4zX5zTM+Tvp327h4jm89SL9ltTgr09DKCb+QkVx5I8ADDSxrL1lg/4Yn
         wHELdnjAQjvq75AJenYD/yTkMKIqtDfB9zQ35IaD3H/0Cm/Zbg5BR6W4v95j5B5HaqT+
         fmaQOJm30i2XKIxwXop7r8N/+jZ2Rl2zb1L0b/+zHihQnnofSJcMSOJ4MuD8DWyTKMEm
         n0GpX4gbqveIcsIvNyFETC6m3b8bPm/m6QACEEJ4xzsUq4VG1Jwprir4iTWDR7lkbzk7
         AgFpYWBcq7xKUrWSxkghkPUg2kwd56keTEQ6b2/QJ/OuJzBYVJkZUr3urB8Y4sYUDwi7
         AOrQ==
X-Gm-Message-State: AOJu0YyxDiMj4xGhe5eiu+2F+3t5JqKGG8o7WmQ/SlB3hDLyTw3hyPTa
        GIQ8YDp2CxjuW6eH6XUfw5+lwzIkUsBy7OKMI1g=
X-Google-Smtp-Source: AGHT+IGPAyLCY1zvg2b23YnGGAM6I9p5N/1WAnaqwnxts/NroHHI/nabZDMaNf5oWv1Xvg2pPgdB/A0cdEMcDxq5ZXw=
X-Received: by 2002:a17:90a:9ac:b0:268:60d9:92cc with SMTP id
 41-20020a17090a09ac00b0026860d992ccmr1708534pjo.43.1692451770416; Sat, 19 Aug
 2023 06:29:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230817101014.3484715-1-martin@geanix.com> <20230817101014.3484715-2-martin@geanix.com>
 <20230817094529.68ae1083@kernel.org> <CAMZ6RqLvbp8EStaSRFQUimhUMpn75=3pkQZYspnP1gYRsspv-g@mail.gmail.com>
In-Reply-To: <CAMZ6RqLvbp8EStaSRFQUimhUMpn75=3pkQZYspnP1gYRsspv-g@mail.gmail.com>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Sat, 19 Aug 2023 22:29:19 +0900
Message-ID: <CAMZ6RqLmNJ0zL9XO9zGCu=CbUHgm68M42fwqkSKk-rSAosCWzg@mail.gmail.com>
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

On Sat. 19 Aug. 2023 at 22:10, Vincent Mailhol
<vincent.mailhol@gmail.com> wrote:
> On Sat. 19 Aug. 2023, 01:19, Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Thu, 17 Aug 2023 12:10:13 +0200 Martin Hundeb=C3=B8ll wrote:
> > > +             int len =3D nla_len(data[IFLA_CAN_HW_FILTER]);
> > > +             int num_filter =3D len / sizeof(struct can_filter);
> > > +             struct can_filter *filter =3D nla_data(data[IFLA_CAN_HW=
_FILTER]);
> >
> > This will prevent you from ever extending struct can_filter in
> > a backward-compatible fashion, right? I obviously know very little
> > about CAN but are you confident a more bespoke API to manipulate
> > filters individually and allow extensibility is not warranted?
>
> I follow Jakub's point of view.
>
> The current struct can_filter is not sound. Some devices such as the
> ES582.1 supports filtering of the CAN frame based on the flags (i.e.
> SFF/EFF, RTR, FDF).

I wrote too fast. The EFF and RTR flags are contained in the canid_t,
so the current struct can_filter is able to handle these two flags.
But it remains true that the CAN-FD flags (FDF and BRS) are currently
not handled. Not to mention that more flags will come with the
upcoming CAN XL.

> I think that each of the fields of the filter should have its own NLA
> declaration with the whole thing wrapped within a NLA_NESTED_ARRAY.
>
> I also think that there should then be a method to report the precise
> filtering capabilities of the hardware.
>
>
> Yours sincerely,
> Vincent Mailhol
