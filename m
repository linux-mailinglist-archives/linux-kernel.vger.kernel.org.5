Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7558976B6F2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbjHAOMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234419AbjHAOMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:12:15 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823B718B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 07:11:51 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-40c72caec5cso328851cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 07:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690899110; x=1691503910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkC3KIklnTCY53hK9lBcQer2DPh4HPjr+bgJxfgI/K0=;
        b=AWiRoEuYk0UGZeHx2qpOUsfJvYvsb9ItVBq1bBfWodqv8ZtmHcSr5U4SJH+F1o5vWI
         K6iPs0qHJLgYXDC2w0OADuJPUFP1UEbCuEa7zAkE3mKud7uQly0y644nfeff9UA+hzRN
         7uUZDuGz9fvLg+w3oFRAf8MffaUovWmFq72/mIu+dU6ms+nbXasl12aGs9/XvEI5qwnU
         VSH1cgj6/KjWVNDXvD3quSoqJJNC1CERaEVyHfPr0JMOGtpjbMDtFV84czo6m4O7UCnr
         aXou7ABUttpT7pdmUHdfZX3kY+ncNENW6E2OKNfk4afkRnrmzBRadF1EUSjKYnXClAE7
         V7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690899110; x=1691503910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pkC3KIklnTCY53hK9lBcQer2DPh4HPjr+bgJxfgI/K0=;
        b=YMjMAUvNUyM5TXn0agmMAT6W2aIJXMtdk/uv6XVMAJyYoXLzsjkwRaTUd82mUTBkoB
         xizvijQnd6aEe+2gqZQR8+OCrOT1bmwys+7oXPSMccdpuUVZElgGh4wYp9yKgnCNlVqi
         rd+bRQpqQs/dt1dNxp40rIBLMRFWU2rFcIhwOU3NCHwrvcd2BPHpbuIz4EsrvA3bNEUr
         ct3GStFmH0z8QQM5vw0lerk0Drju/yWfq+NnJjXRtUFJQkKCf8QJljBugQ+h7LVlX8mc
         U0Zf9lFHuCiKq76B2qHvXAIIR+7NV3ywYYRI6yd+dUUzQpDRzCbuAF8wwjuu2bGSrYNz
         K9KA==
X-Gm-Message-State: ABy/qLZGKgMlHsA7XOTrtyoRsxNCAN2+tZZVBhYx1LIAM1q1wJWsBDdH
        rvxtPWzjqIQc+Czg3sfGjMm1sohNk7nKf6a/LvBofQ==
X-Google-Smtp-Source: APBJJlFNN7TWoySV0L3/UDLWOkPxv6mhMd0pB7EJCklr4ZYuom2VaoZTG0odAsEuSbDFFTORdXlTxd8qkchCkWNlu7Q=
X-Received: by 2002:a05:622a:15d0:b0:3f8:5b2:aef0 with SMTP id
 d16-20020a05622a15d000b003f805b2aef0mr825346qty.24.1690899110445; Tue, 01 Aug
 2023 07:11:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230801112101.15564-1-quic_ajainp@quicinc.com>
 <447ba1fe-b20b-4ed0-97bc-4137b2ccfb37@lunn.ch> <8c591002-308e-bdba-de5f-c96113230451@quicinc.com>
In-Reply-To: <8c591002-308e-bdba-de5f-c96113230451@quicinc.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 1 Aug 2023 16:11:39 +0200
Message-ID: <CANn89iL3TTLJy0kbbxLZRyyRft66absBbh4x22KMKCag7ywOzg@mail.gmail.com>
Subject: Re: [PATCH] net: export dev_change_name function
To:     Anvesh Jain P <quic_ajainp@quicinc.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <simon.horman@corigine.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andy Ren <andy.ren@getcruise.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Venkata Rao Kakani <quic_vkakani@quicinc.com>,
        Vagdhan Kumar <quic_vagdhank@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023 at 3:08=E2=80=AFPM Anvesh Jain P <quic_ajainp@quicinc.c=
om> wrote:
>
>
>
> On 8/1/2023 6:01 PM, Andrew Lunn wrote:
> > On Tue, Aug 01, 2023 at 04:51:01PM +0530, Anvesh Jain P wrote:
> >> export dev_change_name function to be used by other modules.
> >>
> >> Signed-off-by: Vagdhan Kumar <quic_vagdhank@quicinc.com>
> >> Signed-off-by: Anvesh Jain P <quic_ajainp@quicinc.com>
> >
> > It would be normal to include a user of the API when exposing an API.
> >
> > What module needs to change the name of a device? At the moment, only
> > user space can do this via netlink or an IOCTL.
> >
> >       Andrew
> CONFIG_RENAME_DEVICES is the module which needs "dev_change_name" API.
> Our requirement is to change the network device name from kernel space.

We do not support out-of-tree code.

You will have to upstream this code first.
