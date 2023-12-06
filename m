Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19897806507
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjLFCfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 21:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjLFCfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 21:35:30 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95F4183
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 18:35:36 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-db35caa1749so4758568276.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 18:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1701830136; x=1702434936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlDuu53vbrn6lPFwY45IWnvR+3YA7mUVyinONkEtmto=;
        b=SRK+pabrlkiwbYXkzJtUFX14s18ngYJbY2/idV6bttR4EnH3nzHEp7QhkddKFrwg9o
         kwBc3JqH9Hoggz/idJkLT3G+sTiL4D2/8ngF4v2flkhwMWbU3m7I/mhQ9WxrsbHgb9kn
         z7o+vcJdntMjiBc48pEbcpS/uZJvxLfqfDvQgshB226/Z4VlGwJKeo4xXVxlqvZwBl37
         VDp9bYFtDJJICEcDjSF9jHw1CFUjLejSq9jJwmkdQZ3vW3s425xbN1isioU8ipAp2Run
         X27EKXF1lbzhF/v4pGvl/b9XNrxl4SoMphI86lo7IDERngZIbX5510PXciYgT1Sl66Gi
         sW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701830136; x=1702434936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlDuu53vbrn6lPFwY45IWnvR+3YA7mUVyinONkEtmto=;
        b=gGbM6oOjip95vTQmkpTd94zKEKTEsMzAacVw3IOTpiww9M5OwOQEyMUL6xIfrrI8ql
         DMe0GCEc81NYNBh+NyamL/bvCOml/EiFxxgDZm7IfSDzlg2mViVeY+DhODjlDfrfwN+i
         nhbL/Lde3ByBVLLcWosOChDIbCFsoO6QR+J63kC3UI7CrdvvO50vus9i5pI+yj8f0azC
         d575HHhoM7nYeHsFZ6JZyd20BDhEOCL7bAPkggjo3p9Oxt7vcInB9eOkSgr8iI7IDQhw
         SnYsogyJ5EibGD+rv7qZAJy2/mG1cplg2XhDbsIhawd1f/KHmeJ2tWubBKhsTSvbYQZf
         ZpPQ==
X-Gm-Message-State: AOJu0YyipyEyAgRVtisTlHjNIu3ub4f7sPQWh/wZGWvvqAe09jIQHCsb
        5CB0XC025vn7+Iqbf8n1DOrZ01KWZ1qz4jIM0grVYg==
X-Google-Smtp-Source: AGHT+IEAAK7nw9Tt/NLs1EhilQZoE6ZJOZfYmBJo7cb7QrMdkaOgVc2RlX9xN6TjZVgIA+w28XmZQLETw6at2bm172k=
X-Received: by 2002:a05:6902:522:b0:db7:dacf:3faf with SMTP id
 y2-20020a056902052200b00db7dacf3fafmr126141ybs.92.1701830135801; Tue, 05 Dec
 2023 18:35:35 -0800 (PST)
MIME-Version: 1.0
References: <20231024101902.6689-1-nylon.chen@sifive.com> <20231024101902.6689-3-nylon.chen@sifive.com>
 <CAHh=Yk_i-tH-n_5wuwp6H8QRu3cZovkukDzMbeUZrgiih46V8g@mail.gmail.com> <21985579-e017-4a56-b5e3-697fd9d0c9d7@linaro.org>
In-Reply-To: <21985579-e017-4a56-b5e3-697fd9d0c9d7@linaro.org>
From:   Nylon Chen <nylon.chen@sifive.com>
Date:   Wed, 6 Dec 2023 10:35:24 +0800
Message-ID: <CAHh=Yk_=JJnBXVY4nrcmam6aQVN6Db=sPp59je=_BXj140QP3Q@mail.gmail.com>
Subject: Re: [v5 2/2] pwm: sifive: change the PWM controlled LED algorithm
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, emil.renner.berthing@canonical.com,
        vincent.chen@sifive.com, greentime.hu@sifive.com,
        zong.li@sifive.com, nylon7717@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ping on the series.

The merge window should have ended.

Is there anything more I can do to push the process forward?

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E6=96=BC 2023=E5=B9=
=B411=E6=9C=889=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=884:22=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> On 09/11/2023 08:02, Nylon Chen wrote:
> > Hi, Ping on the series.
> >
> > Uwe, is there anything more I can do to push the process forward?
>
> It's merge window. What do you exactly expect to happen?
>
> Best regards,
> Krzysztof
>
