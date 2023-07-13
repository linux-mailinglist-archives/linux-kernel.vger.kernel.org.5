Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E18752A23
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 20:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjGMSG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 14:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjGMSGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 14:06:23 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAD62735
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 11:06:12 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-77a62a84855so38296839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 11:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689271571; x=1691863571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=auNjaZTMlMjO1MNI7rOFAGYTTXE3LG+F1sO+7F+3Cjo=;
        b=2mBYEmOsM2NHZzLs8qCVda0oa62e5T+VCEiNippannHSlMkJ7VANxn3t9vjFy4Ixfr
         Cy+gdvMOggvEA3hAsubZOhZvF+9AOstQ7FQKr3GgExkbCJfuCXp2+Pqare+RrltIHXC9
         DyobViEuj1F/KKCWUWuxSgTENckCjKV9f+gk1dFxWz7cBIVqwJbdjoO6MhJn8l8NfSZi
         igsnPEaOS0qt8iGPE0QoFcSgklQ/0E/9HujtcHV8OK9AAsbF4rU6RZSRm4rRbL8XV84j
         6C80rZ6pZq/28+ElnK3NNqmwFfDicOg/s+a/8fw86q6G9U1Y0938r72n8lFn++YRmuKv
         JC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689271571; x=1691863571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=auNjaZTMlMjO1MNI7rOFAGYTTXE3LG+F1sO+7F+3Cjo=;
        b=hQf9uWGBfzv6xEdEhwopuwJZBcAWasu2YS+RTAGR9H5hI1FJgS7rM31UJEUSBmxxpB
         wZN8AazA1t7AUU646qiOTzRYA1AY86RYGhcGCXtKJ+Fe11cChEWgCcmBlRJw3hC/W5D4
         mr0zVcrx14QKvpM+F+zfAqnWEaA5vQfXqeBGj9ux8oUGYP38aMKrd9O/SNl1B7FySIjB
         555SOipsQ+hY3A44D+3OBqBBNsBWa98xySUaAR9CSxDTsjH26BJyrQIkRRmlRXw+4Nc2
         S3WGAIeahJCao+G0KTfxDNKLXMSueUZGc2n1XB1XFgsnlKD+3f0Tc/BZfON98fKcF8Px
         hW/w==
X-Gm-Message-State: ABy/qLbThohBbauXmicinaixfoRQyVjE2OPFxOdhbcV4G13xBqDmM8Jz
        03mUcV3IAnrUHbUquGmbEq06mxSFCw0WRNIhmoBI9Q==
X-Google-Smtp-Source: APBJJlFDeaPggkMcm4ieg8CBZavhQztwzL1IDo8AvMBvjbbkcMRVU166NV5RXEqx5e46x96EyL6YUmbn/ccR3VK3xV4=
X-Received: by 2002:a5e:c009:0:b0:783:5452:e343 with SMTP id
 u9-20020a5ec009000000b007835452e343mr2383611iol.14.1689271571286; Thu, 13 Jul
 2023 11:06:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230713125706.2884502-1-glider@google.com> <20230713125706.2884502-2-glider@google.com>
 <ZLA0TwHZOgAGCgKX@smile.fi.intel.com>
In-Reply-To: <ZLA0TwHZOgAGCgKX@smile.fi.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 13 Jul 2023 20:05:34 +0200
Message-ID: <CAG_fn=WsPC_qMZfbVQHbXq_cGXP4ZfYkyGyJPzaAKSqurxoibw@mail.gmail.com>
Subject: Re: [v2 1/5] lib/bitmap: add bitmap_{set,get}_value_unaligned()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 7:29=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> +Cc: William
>
> On Thu, Jul 13, 2023 at 02:57:01PM +0200, Alexander Potapenko wrote:
> > The two new functions allow setting/getting values of length up to
> > BITS_PER_LONG bits at arbitrary position in the bitmap.
>
> A couple of years (?) ago it was a series to achieve something like this =
with
> better (?) code. Why not resurrect that one?
>
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2195426.html

It looks more compact thanks to GENMASK, I can cook something based on
the proposed bitmap_{set,get}_value (and change the names if you
prefer the shorter ones).
But I'd better avoid pulling in the rest of that series without a strong ne=
ed.

> --
> With Best Regards,
> Andy Shevchenko
>
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
