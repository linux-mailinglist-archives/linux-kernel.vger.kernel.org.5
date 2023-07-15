Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F2B75476A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 09:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjGOH7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 03:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjGOH7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 03:59:18 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3471535B3;
        Sat, 15 Jul 2023 00:59:17 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52173d4e9f9so470587a12.0;
        Sat, 15 Jul 2023 00:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689407955; x=1691999955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNEqhSaxQJgR+PH3sB9F83nBN4e0Vd3/2Q8uF01FsmA=;
        b=pzLUv5prOZRQXGNtnR6gzKRQlsR2o/bhYUTfemUgusrYU1ID44kDVnka+/EMEroHRk
         Ck+xXSfK7v9gwxTJ3dvsMh/wp8pFMvEqf5DR2AxOaka5qHzWp/Xm826mWfU5scFPkWrS
         9G9cHXo9kUhsKscMVVPL1HapobQyiaRr13arTig1b/sCanyvWeZDEvSIoPItxJL0+iWQ
         zUjYQKoWPsonol8gWruRTrGxDKHXPyQi1IuwrCdqdpJIIA70pY22SpR43bAZRMIXVXEP
         OX+9WsBLO618dWfPhY2KO8ZPWhmCbCdwQGVGtCvXDb42YNcQglwXUpHh52JM8tP+/+uZ
         xbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689407955; x=1691999955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNEqhSaxQJgR+PH3sB9F83nBN4e0Vd3/2Q8uF01FsmA=;
        b=WEam1OU3Kapx8XcIJE2MithHBtQ/anzZzGbnRAAuq81Nm9qFk1W74KqhmAtqCnw4BG
         bz1O9JAwWh/EezH1klZuVHRXdY/zAw3u75ANUnGvVo95DqXdMy1ib2FNRy4rqmrpBAfI
         JhLl5R2ytN6xtCsaqOp4/CyRGTM5sOp9DDomHdsnsoN/d8/CyEuCy3Cb26ukeC37Pd9B
         djAZl8tTf4cHrb0Q1P/gyBURxNrJJsG0By2GmVRi610fDRiwwTeWqa+d6gYnLC6PbJK5
         jn7X1ILQpcrGLZ2Q4Q1gVFhgRBg6cIVoPMs1X8Yf0JQPqHwJVQZog3eumVOTHBuYAK6c
         3/uA==
X-Gm-Message-State: ABy/qLYtxX9I1rulOG2nS67OyUzq23cOJwj2n91F+leqWtfG0hv+kLjp
        Sq4aNv3HMMOvTHYnubt39P+FtJ5q7dVYnkMZoBw=
X-Google-Smtp-Source: APBJJlGOf08UJbJMLlmC5hVxMxwOrYp1gReM9BViYZmDAGEAfjqIN8Il7xBKePQ62d+Im/7k5IAz9gT8+o/29wVQZfI=
X-Received: by 2002:aa7:c3d6:0:b0:518:6a99:cac3 with SMTP id
 l22-20020aa7c3d6000000b005186a99cac3mr6460062edr.31.1689407955625; Sat, 15
 Jul 2023 00:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230715010407.1751715-1-fabrizio.castro.jz@renesas.com> <20230715010407.1751715-11-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20230715010407.1751715-11-fabrizio.castro.jz@renesas.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 15 Jul 2023 10:58:39 +0300
Message-ID: <CAHp75Vc5UAec05TKF2A21YoNtvMz160v4SeOkDAsrU+i8b88YA@mail.gmail.com>
Subject: Re: [PATCH 10/10] spi: rzv2m-csi: Make use of device_set_node
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 15, 2023 at 4:04=E2=80=AFAM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
>
> Use device_set_node instead of assigning controller->dev.of_node
> directly.

"...because it also sets the firmware node."

You probably need to add property.h, if not added yet.

--=20
With Best Regards,
Andy Shevchenko
