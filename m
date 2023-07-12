Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CA87513CF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 00:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjGLW44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 18:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjGLW4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 18:56:54 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488A319B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:56:52 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-577412111f0so87814077b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689202611; x=1691794611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VB9ypz/KY/xV4cSqtZ+tUlnGhLGfTgqW2/3T6mN7ebg=;
        b=zqXzgzWKFV6nFUVPIAAPE0mvcmohHovWT46vSnWqga+md0s0CjPw+S/slrQmtYD/+I
         Fu0NJj/cGiDczTnmqqNEItLDzKpArQ+WRuNWc3U3XMwXODsKJkLrAVbsPysme2TvZlIQ
         1nYVNxGO7F7Ylo2QbTcDyees8UGOWMay7cQq9+ubv3fb6bXR1CbmePyVVhhqIA0AS9RT
         tL8OHX1Mp9QLdxnzRYNhfIXauDWWOUboIKDr0iOGH5r+D74mbNsha1Himxc8/xYDV/BD
         jTjCUY8Qz1/Nl5IiMjzjvKt8+BjcT526DZvxuID7aGVOFHbTflMIReO9ZOI+Evkv/6ik
         qlNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689202611; x=1691794611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VB9ypz/KY/xV4cSqtZ+tUlnGhLGfTgqW2/3T6mN7ebg=;
        b=LklGd+GPOjvGRcJxFx3UeQzdEDKISe1WraFVXPs65t5fHpGmiuiaGyiMzKJWIkkfmE
         G7YVTkQKnP/H9zyWMQerEt1CO9ooMKLLfnyYHiILAIVNT2DibqUDs+aJFQXo+Dp92JDn
         CKIcIKSCH3uNHItbnr1WWJP200v7XDLGD+XthiXqDzW9TE9Q6bdmmmmRhPIohULr72HS
         vMircAWFiY4QewsPx/G07tCijDgYVKY4TnalfizdTES1XVbehNOrHbX4BtoW+hac8G4U
         E6witHxX9/QUd0rLw+CYT35Gp+XqxKND/d6w7gKuy3QChjw7coEO6fpsKR4AYt6hjS00
         K6Hw==
X-Gm-Message-State: ABy/qLaFFICIMuABTEokVEe8ufaSIOMWJmIbW8KKRRZ8YVfsjHK7xdvx
        xPMGz5vRw5rUqFM3qie0UxWQ4cymgf1CKQFsgnJzKA==
X-Google-Smtp-Source: APBJJlF4igHjEc2KmL3nrfbBjOxJjhZo34FKjrNMDYKyWYjw8zNV/gZXWKTyO+6j1ecKjSoqtvT+UHPYSbZAxvI2mT4=
X-Received: by 2002:a81:9281:0:b0:57a:897e:abce with SMTP id
 j123-20020a819281000000b0057a897eabcemr24404ywg.7.1689202611241; Wed, 12 Jul
 2023 15:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230706073719.1156288-1-thomas.bourgoin@foss.st.com>
 <20230706073719.1156288-3-thomas.bourgoin@foss.st.com> <CACRpkdaHn8fhZtuhU4sXHK1xoxO3-xYg_Xb=3=bX8i-uJM9KDA@mail.gmail.com>
 <a584c152-329e-9c79-ec62-795485302a55@foss.st.com>
In-Reply-To: <a584c152-329e-9c79-ec62-795485302a55@foss.st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 13 Jul 2023 00:56:39 +0200
Message-ID: <CACRpkdYStm_dxo-FMo4Kdw_Lm3iG+xppf7O5W6cxtoiRy1DOsw@mail.gmail.com>
Subject: Re: [PATCH 2/7] crypto: stm32 - add new algorithms support
To:     Thomas BOURGOIN <thomas.bourgoin@foss.st.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lionel Debieve <lionel.debieve@foss.st.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 9:58=E2=80=AFAM Thomas BOURGOIN
<thomas.bourgoin@foss.st.com> wrote:

> Did you run your test only with the patch adding the support for
> STM32MP13 or did you try the whole patch set ?

Both, actually.

> The error is on the test vector number 4, which is an HASH of 64 bytes
> which is exactly the size of a blcok for SHA1.
>
> Did you try to run the test for SHA256 ? (I guess you will see the same
> error on test vector 4)

Yes... I posted a log with both SHA256 and SHA1.

> I found a typo in the number of CSR to save/restore for the SHA1 and
> SHA256 algorithm. It should be 38 instead of 22.
> Tell me if it fixes the regression.

Yes this fixes the bug and the tests pass fine :)
I wonder why SHA1 was affected? Same codepath?

> It could be possible to divide the patch in 2 (one patch rework
> preparing MP13 and one patch with the new algorithm) but for the
> upstream I do not know if it is relevant to have 2 patches instead of one=
.

The major point of splitting patches to "one technical step" is to be
able to do fine-grained git bisect to find bugs such as this one :D
But admittedly the defintion of "techical step" is a bit fuzzy.

Yours,
Linus Walleij
