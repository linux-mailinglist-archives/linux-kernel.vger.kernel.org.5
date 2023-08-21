Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79E878315E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 21:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjHUTpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 15:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjHUTo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 15:44:59 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AD4E8;
        Mon, 21 Aug 2023 12:44:56 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d7260fae148so3851914276.1;
        Mon, 21 Aug 2023 12:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692647096; x=1693251896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSgWHOn62q0TOR9IRF9c5uslZMHmhZyo6wOkQsCA9Sg=;
        b=gkrmRvn7Qxr182RHRNjzqg2R3tW17BESVQaczV309LmfU2Iv7X1P9d/LXS8FQC74Yj
         BkFNcAYgyIPFRr4v3opPCiKTppuo2Kj61j/jLZPRx35Zsry1SaVg7XhyW4dBi+yKqpPo
         WN6U+dZoYsbqkbsAv+MzDrN44TQyIuRLaTUQk4lum6rF8+qIiY6ECc86lzNBi1scsxaQ
         pl50HBTb5ISbrF3NroEfaKPBO7nV8/wY+7TWNrwQBkVwAWI39DD+2Op1W26cHo4CgeQG
         gMiY04Rr8q1/2xkI8pLInoeW6X/6F+5sx3jywXm+PlAe9DPXM92IoCzI6NhH4xmOQ5fE
         CsmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692647096; x=1693251896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iSgWHOn62q0TOR9IRF9c5uslZMHmhZyo6wOkQsCA9Sg=;
        b=k/4I28c7/eacxgXP9tmFBrccDs/RUTmTX/EGgKXBSwTH6p82pASSiEo1i9wkVTgtAZ
         6CzDk6FE1JeH7VbmhTrT2jiQkbF/jkotTqlYvEYWAJ/uQuGeYztzVUGtWGlsvUVTpMhj
         3wjcb64GBSjo41cfxPGVoO7PkrWBJfacIxEwp5jw2YR9ZR9E3NH9st4JILkOAInYWwYI
         E4QYQD0+V9R7Vo77ODN5tlfx+bDAT5gVRNbPmr7PtOCbuKXzVQJHYg1P+rzS5ucQJAFf
         RenEJv24NjForeuUUtAHWyZ2KHcbw0otsM00KbrYKwzqp8CmXSkUNnPtU6yHgYmpDd3I
         lx9A==
X-Gm-Message-State: AOJu0YwXJVKOh1o9I6EDCra0EuMg29+lkxJ7LU5w6Enn1wP8cRulK3Bg
        zEb8tvkXDBDfV9GjcVseVhn6HWn92nl+5Ls7zFM=
X-Google-Smtp-Source: AGHT+IG9tkFV/VbiqSrJumtkeCuNYBUnjHFppQT+AMDKxxYVD7j4Jgt0GJ+c62YY2hauiBJ3kz3P6TlYkbJ+xQ5Mqfo=
X-Received: by 2002:a5b:dc3:0:b0:d44:a90b:ba56 with SMTP id
 t3-20020a5b0dc3000000b00d44a90bba56mr6662804ybr.29.1692647094608; Mon, 21 Aug
 2023 12:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230815140030.1068590-1-robimarko@gmail.com> <83cc4b10-34bf-ea91-7756-f345c0071479@linaro.org>
 <20230821193152.GA2157670-robh@kernel.org> <CAOX2RU6be+eeTPT7HbC8_-C7d7oVhspsXWOmwtgg6s=QMe6QEg@mail.gmail.com>
In-Reply-To: <CAOX2RU6be+eeTPT7HbC8_-C7d7oVhspsXWOmwtgg6s=QMe6QEg@mail.gmail.com>
From:   Brian Norris <computersforpeace@gmail.com>
Date:   Mon, 21 Aug 2023 12:44:41 -0700
Message-ID: <CAN8TOE96PjH67+vmi7mksSvqeMdLNBd8MH3m=1Ft_h+TXbk4BA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: firmware: qcom,scm: Document SDI disable
To:     Robert Marko <robimarko@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        quic_gurus@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Aug 21, 2023 at 12:35=E2=80=AFPM Robert Marko <robimarko@gmail.com>=
 wrote:
> On Mon, 21 Aug 2023 at 21:31, Rob Herring <robh@kernel.org> wrote:
> > Why can't you just disable SDI unconditionally when going into debug
> > mode? Is doing that when not enabled going to crash the system or
> > something?

I asked the same, to resounding silence:

https://lore.kernel.org/all/20200721080054.2803881-1-computersforpeace@gmai=
l.com/
https://lore.kernel.org/all/ZNlhSdh0qDMieTAS@localhost/

> Because if not disabled you will enter the Secure Debug mode even on a
> regular reboot and then you have to pull the power in order to boot again=
.
> Even according to QCA docs they intended for the Linux to disable SDI as
> TZ/QSEE will always enable it as part of booting.

NB: I've never read such docs. Presumably they're internal/private to
Qualcomm and/or its direct partners? I'd love to see them.

But, I think you (robinmarko) are not really answering the same
question that Rob (robh) is asking. Rob is asking why you ever *don't*
want to disable SDI. You're answering why we ever need to disable it
at all. I don't think the latter question is controversial.

FWIW, your description of those docs sounds like we should
unconditionally *disable* SDI (like my first RFC above), which would
answer Rob's question, and would agree with my RFC above :) And as a
bonus, no Device Tree change would be required.

Brian
