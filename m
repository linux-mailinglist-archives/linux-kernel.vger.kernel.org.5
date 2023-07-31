Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B2F768A32
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 05:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjGaDEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 23:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjGaDEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 23:04:20 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB388E68;
        Sun, 30 Jul 2023 20:04:19 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-522aad4e82fso2820052a12.0;
        Sun, 30 Jul 2023 20:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690772658; x=1691377458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GeHrOq3E7w0wD16jui9tOFwdWDi60y55qUBPhdegPog=;
        b=ig27SJXssI6fIPXRy5TJUgdHAi4y8ciH+rxxK9UXdxsG3j/SrH4aITDfrlfm72e/gX
         7OoT6Iajg9NbRq1PZfPwCCskqUE3c6cjdPVABPtCiTr1rPMiGo0C8uCtMMDhehIjw6qb
         pcgLscWumAxsTYac5s6KdRs66BcxUjy+RzrsA9QYpgSXW9Ks6UFDYKbj4UdH4zLkQuwI
         aAnAZuGQHl3kY5aCU4umR97bteSRo7m29x8pRm5LEpziE818U0QlWRlA7amaYPlVcjYK
         9Hyc8owprlHXirey+U1/7ZE34bPPAK3FX98Kr82czibWml7tdXwXQOPPRnKjMjt87J9W
         paXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690772658; x=1691377458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GeHrOq3E7w0wD16jui9tOFwdWDi60y55qUBPhdegPog=;
        b=fOJgJi1uA75AOPM1BrFjBhMu6rc/rgNxI8b7KU/u170vknjob+c/dvjPOswK9TWZJq
         Wblf48D6Ko9V/YlMPXv23nzGZuXMT5Mo2aoGrDQRsjWLMTXYv+CRQeH0syFkTdKJw2xy
         GgCet9+y+yp/NVCFW9mkZzcxS0Ei2+j72tC+7eXjFfCWZApYyOipITLXxeFjJYzvpojH
         CohxUVWY7SLXrA/tbyYt32SPqmv9JmkMwkaACxGkL6zBAK41BMZdFmvJUOaiKo86KeqQ
         MJW7LJwYjlJD/zwTsdyGvPCYRhCzDCYwyUT/5egmD/WC18ITy7pP9dfnVFXosIp2c5WI
         OCvA==
X-Gm-Message-State: ABy/qLYQ2G7MWO0XhmHBaHVsE1B1fO8MAUGwNe2zVJVr/lnwKhlFI95i
        XsnV2ghmgf38znlBrjM86NxvM/dz/MImytYW08k=
X-Google-Smtp-Source: APBJJlFqo4sbM4vfLjB7pKQ8m6u12SOWCPsYffOtG2wUulcqaIqlWobQH6PQuGDUR3onSn6H5f+xds7BUvrEbBerf9k=
X-Received: by 2002:a05:6402:32a:b0:51e:c82:6f3b with SMTP id
 q10-20020a056402032a00b0051e0c826f3bmr6676976edw.16.1690772658097; Sun, 30
 Jul 2023 20:04:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230729134318.1694467-1-keguang.zhang@gmail.com>
 <20230729134318.1694467-8-keguang.zhang@gmail.com> <2ee2336c-d54f-6fb7-0142-8d0e08cce25b@linaro.org>
In-Reply-To: <2ee2336c-d54f-6fb7-0142-8d0e08cce25b@linaro.org>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Mon, 31 Jul 2023 11:04:01 +0800
Message-ID: <CAJhJPsXbW-JkzPTH+fHW3PD9J9+s0_F3Fbs3sb44tC12iTCk-Q@mail.gmail.com>
Subject: Re: [PATCH 07/17] MIPS: loongson32: Convert UART platform device to DT
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2023 at 4:26=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 29/07/2023 15:43, Keguang Zhang wrote:
> > Add UART device nodes for Loongson-1 boards,
> > and drop the legacy platform devices and data accordingly.
> >
> > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > ---
> >  arch/mips/boot/dts/loongson/loongson1.dtsi    | 54 +++++++++++++++++++
>
> Same problem - DTS is always separate. It seems you made this mistake
> everywhere, so entire patchset needs to be fixed. Keep all DTS - your
> base board and extending it - at the end of the patchset and squash it.
> There is little point to add new DTS in steps (e.g. first add incomplete
> broken DTS and then immediately fix it... no, instead just add correct
> and complete DTS).
>
Sorry. I thought it would be easier to review for split patches.
Thanks for the explanation.
Will send v2 with one complete DTS.
>
> Best regards,
> Krzysztof
>


--=20
Best regards,

Keguang Zhang
