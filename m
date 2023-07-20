Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3994C75A83F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjGTHvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjGTHvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:51:44 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA24A2707
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:51:20 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-55b1238cab4so233044a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1689839480; x=1692431480;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2k4jDd0ZIOszcSg+J/IXQt6qEPXRORw1/6EUeNiGUWU=;
        b=adv0UXSqiTsvAO3sMOno0Si9w9X3YSPmSgrglWHPTYqrvzIwodST3g5VcZ9KKoNhkB
         2w/3WP1ZMvfzR2nzxvxgaFCWiWArPiLjT8ARrjCQZ6BgRb655IbH7VVyaY5oLM/dCCF9
         Q88JAaK7+r7cImjLxtmoDOP1H1xvx9n8i3YJYw6mL848fNQ//n+ENWg9iB/xscZDDxq5
         qOKcTOUB9hqpHJRqvNYYi7IWfpjuDmGh4YLkdKXthL67Ll4HsrPAIpADm6EXOfLEYKEF
         baVUe64rkOVkCvadahpYmDv8I86xIy2fA7ebNBb8++DVz5G6wrBvt7uwdZMvkFXRllY4
         qF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689839480; x=1692431480;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2k4jDd0ZIOszcSg+J/IXQt6qEPXRORw1/6EUeNiGUWU=;
        b=Wrpu2c/mPhh+YVLiiLLf1bMJ1Z5q4sSIa26kFHubha/TmwTlhnBvNGRW6rW3DFtdVj
         +S3g35uENIjPxyX58SpCbnKLJV0y6Kb4euALYV1bB/3xhRCtDQ3ivSP+fA+bNrNJLokg
         ljFeDR04LARZ2teO27CJy2p5tVBYYlao0jIDxOgy8z3NYJftQfe+nWyuGJj2C7jT19A6
         iZ0MXV3dr1RGAQolLey3fF8q8paZ9SzZLPWkw0OOQXL+VONnxpfxGyeNlOgiFb/PvDbZ
         UM9RshqtQ+EBUwXZf9WxS1YadkpcIEbcNM8mHbi/KEzi++lxHNL9Vq6eIcVnAkZOwvgt
         om+g==
X-Gm-Message-State: ABy/qLYNqR6fRFDuU+nekn7RnsFWP0876Zy6vAaTsraR2kth2/2vYK+h
        VRwJJgaCKkZDHU7xrATuwNc1v2rlBJT3/tSH04oDDQ==
X-Google-Smtp-Source: APBJJlHy3Qp+lYj9Pw4twQ1use0NxR3mKM4+QvJjBaFFSzzalPR4jcXJVKn45xO97mV59mJlaUq4TiltAI5vPLOKHbg=
X-Received: by 2002:a17:90a:ad94:b0:263:528:144a with SMTP id
 s20-20020a17090aad9400b002630528144amr1269938pjq.28.1689839480180; Thu, 20
 Jul 2023 00:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230420111759.2687001-1-Naresh.Solanki@9elements.com>
 <76e57634-75dd-01e8-9c56-36ed7de17812@linaro.org> <c8d1b5db-318e-3401-0834-b89769831eca@9elements.com>
 <be129c4f-3ad7-c54b-936e-08b142608ebc@linaro.org> <88f9a008-2861-284c-76c4-7d416c107fbb@9elements.com>
 <bd45ea5d-e6e4-403a-e855-376e0f647f91@9elements.com> <20eb1d0e-0aa2-9d41-7ba5-2feb148748d0@linaro.org>
 <9d989c4c-7c9e-9e95-133f-03741d07198b@9elements.com> <80b60de0-dcb5-303f-8d13-f4b1cf7d8521@linaro.org>
 <45236017-22d2-f9f8-0069-77195e49221d@9elements.com> <3a912cab-001f-a70b-394d-71370fc482e5@roeck-us.net>
In-Reply-To: <3a912cab-001f-a70b-394d-71370fc482e5@roeck-us.net>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Thu, 20 Jul 2023 13:21:09 +0530
Message-ID: <CABqG17jvz7Ma5WeZ4gzrXKkNbEXWxcNC2LpNuC40uOr2QAioDQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Add max6639
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,


On Wed, 19 Jul 2023 at 23:10, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 5/4/23 04:36, Naresh Solanki wrote:
> > Hi Krzysztof,
> >
> [ ... ]
> >>
> >> No, we cannot, because we asked you to fix things there. Your entire
> >> explanation about compatible and driver is not related to the comment
> >> you received: bindings should be complete. You argue that bindings do
> >> not have to be complete, because of something with driver. This is not
> >> related. Bindings are not for driver.
> >
> > I understand that complete bindings are important, but as the driver is already merged and functional, my immediate goal is to enable its use on my machine. I will work on a separate patch to include the interrupts in both binding & driver.
> >
>
> As a follow-up, since it came up in a separate context:
>
> Bindings and driver are independent of each other. _Bindings_
> are supposed to be complete. However, the existence of a property
> in the bindings description does not have to be reflected in
> the driver.
>
> FWIW, you _could_ have added the device to the list of trivial
> devices. The only really mandatory property is vdd, and every
> chip has that. All other properties are really about configuration
> and/or fan properties, and I don't even know how to describe fan
> properties (such as pulses per revolution, pwm parameters,
> fan speed limits, the relationship between pwm outputs
> and fan inputs, the relationship between fan speed input
> and pwm output, or fan spin-up requirements) in devicetree.

Thanks for the inputs,
Will work on it & keep you posted.

Regards,
Naresh
>
> Guenter
>
