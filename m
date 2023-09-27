Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031B57B0E28
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 23:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjI0VhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 17:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0VhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 17:37:16 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F8411D;
        Wed, 27 Sep 2023 14:37:14 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so14286684a12.2;
        Wed, 27 Sep 2023 14:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695850633; x=1696455433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJVhey8RIggiy940PuwmSoQQP3nNcn3uKLurpxTPjJ4=;
        b=PNyj6tzMPDst0UTvSjWHGhgCbU7EqXGSHo4NNHScMCa1rSseKXoReJRFXmCDuO7L37
         UUtQPsmoEVs7tKjVJl7IFLfIKzhwEhwyaeveVHL4CUr2ijd77Nb7JCVCYiN8zZhnFK0x
         nLDRsvYpaVBQiVegiHG0CWJC8Ro9+ODnljUksADX/xxRBvTN44yd331NcyYCfRLpzLpq
         AYgCMN1L6JtvfN/hCC1PQrs8RATY4r0o508g7GHygi6V1bijy/YS5avyHsNE+Yhxc9GI
         aNcnqefFHmLG1UDJm9EI1ZK52HRysyeR5+FE8MD92vEAvZ970HIXm7SwoUcrDopMdJGk
         f8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695850633; x=1696455433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJVhey8RIggiy940PuwmSoQQP3nNcn3uKLurpxTPjJ4=;
        b=rSQj+VFO0AQxh+PY/DceHV5ASG0ipqVweOGmgWWDp9nVa3g7YeUi7Sqdxx8tS2r0r3
         k5UezGyraRvcZpioX2ZGTx1tNC/Cb1kQwlrm6y71IVfHtW0LJ6997IO6Nn/UlEy6cPQk
         VKfpe51IA//xIGpz4x9TpqxI2hWra7mr+6u/PrZdO5Xw98L6aG0s76aMRtq+cuRaSpl9
         B8mmtuRdh5E5VO/YwZd0oac//0zWTDRu3tHW/QSA0WJeTXdwdEB7AHIq5tHqED2NOrW0
         klSB5Lw3BH8Hk1BabSczxYC1UPXrehtPZRVjoA4HAy3iCK+q2xUXOqknTtFJ8ZlM2eH8
         qSXA==
X-Gm-Message-State: AOJu0YwEzDUYuo/tA9A1iofl7C1T/VNml1kDnzFi4dbnSFG7CEVTW4Bc
        J+aKwT1Az5+NUVcHNGbUt7bLLf+kmLNexIIhgmk=
X-Google-Smtp-Source: AGHT+IG6pMYUePSEQczqS5u0bJro8yBf0c7CsCbSAt5egf17Tv7W1oRMwwnTk/DE99VVKAiAtPGubtxYFbYY3CYuCMs=
X-Received: by 2002:aa7:d043:0:b0:522:2ce0:d80a with SMTP id
 n3-20020aa7d043000000b005222ce0d80amr3066327edo.35.1695850632999; Wed, 27 Sep
 2023 14:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230918080314.11959-1-jagathjog1996@gmail.com>
 <20230918080314.11959-2-jagathjog1996@gmail.com> <b27b58d9-9e55-b803-dd61-dd86a78e7c5c@linaro.org>
 <CAM+2Eu+R6M7U+t4z5K0Cty736ybAzis7xnrT1edk4-y6B=JAOA@mail.gmail.com> <20230924143126.60a142c4@jic23-huawei>
In-Reply-To: <20230924143126.60a142c4@jic23-huawei>
From:   Jagath Jog J <jagathjog1996@gmail.com>
Date:   Thu, 28 Sep 2023 03:07:01 +0530
Message-ID: <CAM+2EuJ+LGe5Gu8jek32yJe4cLYHSrrbND8WPyPsYsuyFSJNoQ@mail.gmail.com>
Subject: Re: [RFC 1/2] dt-bindings: iio: imu: Add DT binding doc for BMI323
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        andriy.shevchenko@linux.intel.com, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan

On Sun, Sep 24, 2023 at 7:01=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Tue, 19 Sep 2023 22:14:40 +0530
> Jagath Jog J <jagathjog1996@gmail.com> wrote:
>
> > Hi Krzysztof,
> >
> > On Mon, Sep 18, 2023 at 5:55=E2=80=AFPM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> > >
> > > On 18/09/2023 10:03, Jagath Jog J wrote:
> > > > Add devicetree description document for Bosch BMI323, a 6-Axis IMU.
> > >
> > > I don't know why this is RFC and cover letter does not explain it. Sh=
all
> > > I just ignore it? Patch is no ready? Recently at least two times some=
one
> > > was disappointed that his code marked as RFC received my review.
> >
> > Thank you for reviewing. This was the sensor's first patch series,
> > so I initially submitted it as an RFC. I will mark it as "Patch"
> > in the next series.
>
> Have more confidence!  RFCs need to have clearly stated questions.
> If you don't have any then you are putting forwards driver for review
> in ordering to get it merged upstream - so PATCH is appropriate.
> As you'll see many IIO drivers go through a 'few' revisions once they
> are posted (hopefully not too many!)
>
> Krzysztof is great at reviewing whatever shows up, but in many
> cases reviewers won't look at an RFC (unless a big discussion starts) bec=
ause
> they aren't interested in open questions, just code that the author consi=
ders
> ready.

Thank you for your feedback and guidance. I appreciate
the insight into the RFC process and the importance of
clearly stated questions. I'll keep this in mind when
preparing future submissions.

Regards
Jagath

>
> Jonathan
