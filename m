Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE93790220
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 20:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350611AbjIASjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 14:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjIASjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 14:39:31 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C92CD8
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 11:39:27 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-400a087b0bfso22823175e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 11:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1693593566; x=1694198366; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bA5Lm6a1t+KFAs7vnfL5/17M6lm4KSTTxqyCI/pc5BY=;
        b=ZiqUuk9p4uZ/yOZAr5a+RcMr0ew02/QrP2SaKXTOtNRKAhMTGpo/XtFQGJu0Omhu1K
         qhpkoPCaQFESaNA6OeK3whxRVLW/NkzbKlzwIo+kCnF8K+4ckSIjxaA5NeQyi9+e5nPo
         ShDY1K5wYQudm+SXQKDcI2MUete8t0pGLXXpxfy70IeHaXjTbeidkHbDBM5wCnpDrnRV
         240RgKdpMmDvmkJsWumT31Sm/IK7KK6lbeuPndS69jE4WaLoQibwU97TQdGjgHA//Cq1
         frJIX1mfv3AlWny/85CNz67tz4O94lqM7DUTW+kg/ZDXIPdAxk0UTChPNey1MvEU8bv/
         kBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693593566; x=1694198366;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bA5Lm6a1t+KFAs7vnfL5/17M6lm4KSTTxqyCI/pc5BY=;
        b=OVbBRPwClum3b2CEo3fGtT/Mjgrs8Za/a4e06ogWKwdMeeZHbpzUl0zPIqQSNuxrI2
         zkEMqckvI8OWA5ehCOh7NQXL4jNpwCfVNjibHzjwWkLhMw5v5ASpUGYNB0mo7H/KRdbw
         Or8EexYMRnZLVhj+v57obLJQcY8qGTeVTb8FMrunbqVhBhePiyh78sV6v6Cdw2R+k6Ee
         qc9rgskcIX5I+PK5JRLhVHjkJfx47QCaR10Ld8Cl6QI+VijBb4YJRj768BCtpxtBYDSj
         lyAawxVKPXAUmv66jf6kBsdQpZ/CkijdQwXKnnXsK9sgepgEXMi+sPLlu1u47pviLqCq
         2Pcw==
X-Gm-Message-State: AOJu0Yw2UfSbM+Fz/cC093w7u9O1lQsnXZPHf6/M2zIfqwDivG6j1uzU
        4BIDr/Gpt45K480c9QJFQku4wg==
X-Google-Smtp-Source: AGHT+IHwt+wcmiHzIzpBrobUBa991WScHeOvwtCAq4Ysh3WkCDFvhnNCS5xE0Y9TRcLz8axynzkOjA==
X-Received: by 2002:a7b:c8ca:0:b0:401:b204:3b95 with SMTP id f10-20020a7bc8ca000000b00401b2043b95mr2441626wml.15.1693593566116;
        Fri, 01 Sep 2023 11:39:26 -0700 (PDT)
Received: from smtpclient.apple ([131.111.5.246])
        by smtp.gmail.com with ESMTPSA id l8-20020a05600c1d0800b003fef6881350sm5840720wms.25.2023.09.01.11.39.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Sep 2023 11:39:25 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH v1 1/3] dt-bindings: mmc: Drop unused properties
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20230901-affected-wanting-ab517791a870@spud>
Date:   Fri, 1 Sep 2023 19:39:14 +0100
Cc:     William Qiu <william.qiu@starfivetech.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-mmc@vger.kernel.org, Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C9C76D81-7244-4549-97E2-83CE10050A74@jrtc27.com>
References: <20230830031846.127957-1-william.qiu@starfivetech.com>
 <20230830031846.127957-2-william.qiu@starfivetech.com>
 <20230830-commence-trickery-40eaa193cb15@wendy>
 <b375b88c-0d9c-30a9-21f6-283083cf3880@linaro.org>
 <20230830-procedure-frostbite-56c751f7c276@wendy>
 <efab6f52-4d7f-ea3c-0fc3-4e3ad03c14c7@starfivetech.com>
 <20230901-remold-sublease-a1ddb1fc6348@spud>
 <9EF26965-10E5-4BCA-AC5E-93C5AA55A0DF@jrtc27.com>
 <20230901-affected-wanting-ab517791a870@spud>
To:     Conor Dooley <conor@kernel.org>
X-Mailer: Apple Mail (2.3731.600.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 Sep 2023, at 18:43, Conor Dooley <conor@kernel.org> wrote:
>=20
> On Fri, Sep 01, 2023 at 06:20:38PM +0100, Jessica Clarke wrote:
>> On 1 Sep 2023, at 16:42, Conor Dooley <conor@kernel.org> wrote:
>>>=20
>>> On Fri, Sep 01, 2023 at 10:33:13AM +0800, William Qiu wrote:
>>>>=20
>>>>=20
>>>> On 2023/8/30 16:34, Conor Dooley wrote:
>>>>> On Wed, Aug 30, 2023 at 09:29:20AM +0200, Krzysztof Kozlowski =
wrote:
>>>>>> On 30/08/2023 08:50, Conor Dooley wrote:
>>>>>>> On Wed, Aug 30, 2023 at 11:18:44AM +0800, William Qiu wrote:
>>>>>>>> Due to the change of tuning implementation, it's no longer =
necessary to
>>>>>>>> use the "starfive,sysreg" property in dts, so drop the relevant
>>>>>>>> description in dt-bindings here.
>>>>>>>=20
>>>>>>> How does changing your software implantation invalidate a =
description of
>>>>>>> the hardware?
>>>>>>>=20
>>>>>>=20
>>>>>> Which is kind of proof that this syscon was just to substitute
>>>>>> incomplete hardware description (e.g. missing clocks and phys). =
We
>>>>>> should have rejected it. Just like we should reject them in the =
future.
>>>>>=20
>>>>> :s I dunno what to do with this... I'm inclined to say not to =
remove it
>>>>> from the binding or dts at all & only change the software.
>>>>>=20
>>>>>> There are just few cases where syscon is reasonable. All others =
is just
>>>>>> laziness. It's not only starfivetech, of course. Several other
>>>>>> contributors do the same.
>>>>>=20
>>>>> I'm not sure if laziness is fair, lack of understanding is usually =
more
>>>>> likely.
>>>>=20
>>>> For this, I tend to keep it in binding, but remove it from =
required. Because
>>>> we only modify the tuning implementation, it doesn't mean that this =
property
>>>> need to be removed, it's just no longer be the required one.
>>>=20
>>> Please only remove it from required if the current driver doesn't =
break
>>> if the regmap is removed.
>>=20
>> Either way please make sure the documentation clearly states =E2=80=9Cn=
ever use
>> this, if you=E2=80=99re using it you=E2=80=99re doing it wrong, this =
only exists
>> because it was wrongly used in the past=E2=80=9D. Otherwise people =
writing
>> drivers for other OSes will probably use it too thinking they need =
to.
>=20
> Maybe we should just delete it if the impact is going to be =
negligible,
> sounds like you're not using it in FreeBSD, which was part of what I =
was
> worried about. Guess it depends on what Emil & the distro heads think.

FreeBSD doesn=E2=80=99t have StarFive drivers yet; I don=E2=80=99t have =
time to write
them, and a community member has taken it upon themselves as a hobby
but is rather inexperienced and has been struggling for months. OpenBSD
has drivers, including a modified dwmmc, but doesn=E2=80=99t use this =
property
(in fact its driver doesn=E2=80=99t use the compatible other than to =
probe the
generic driver). I don=E2=80=99t think anyone else has a serious port; =
Haiku=E2=80=99s
the closest but also has no StarFive support.

Jess

