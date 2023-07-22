Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421AD75D864
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 02:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjGVAoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 20:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjGVAoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 20:44:08 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4F3E0;
        Fri, 21 Jul 2023 17:44:07 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-bd61dd9a346so2396346276.2;
        Fri, 21 Jul 2023 17:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689986647; x=1690591447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/YDucU2AULnNX/enS6tagh/a4vMGcAQyh4Z1e1ZemfI=;
        b=Vw0Mfa/cLMFs3BGzu8CsG5s/o2Psjecc6sUnoHVQEPgVviEW3wjDggeK7ViV4WQkeq
         /U66wCqYMfASqWxudA3f0w7XGlhrFsptwleIZYo/tiZj6N59BH9bDlRuCsjiQkw5qen5
         1dtQUa+E305zZVNorIO+2tmKc4cbbrxLHCmO2OpAmj7UsgrRPLP9u9an+vJOevT+kpGV
         cw7LXamFV7qJJt/M97c5OIEfvWLPwAw2x/0SjlyTKXxpVy59w/uEy9tIpQTR6349lvfm
         hxDa6j7ijHlHDJ9Kl/bk0AEutQ7zevpaVcXVwBd7F+KppcPaIOhGEzpQq5SERsgeIzPd
         RgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689986647; x=1690591447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/YDucU2AULnNX/enS6tagh/a4vMGcAQyh4Z1e1ZemfI=;
        b=JA9itSlNddSMKCq9pD/Jpg5MBOGT7PH9WNBJZROMpBJLUYYrZw/AmNi2Pi44s4p4BB
         RGhvM+vK2F9wiBcjPzVfI5gzVnfL4N2dYgfhvcb9vZQBJUT3Tywqp4xbusaPDDGcOmnb
         awmyZpyn493gCU4w6DyyU+SFW6zs8mcuj4q8fpVJ/t/JJWnXfqi6GEJdBc8zWaFnKqZh
         uMknYxKw1Sp4rD74Q6d/WJmUBwPEx+ujZCQlm36V/90ulBXrxR7+6VB+6BIGgPYvkAJ/
         7+Xzy33eldoOXwd5T5ElVFfoBCFKRteYg3RSKbJ/8WGvHg06G0dLeYn2cCrPSxi7kpop
         C8yQ==
X-Gm-Message-State: ABy/qLYpGSCC9dQ8nC8ktfKdjJj448bATECmCreRpiV6nKyvCbaPEoyq
        ofAVorAU3+wLyAYyPw6iG1RI4fbScwKp4P3Q7KM=
X-Google-Smtp-Source: APBJJlGba0Oud4IpjcIQD0oP9QfXeafjv/79QHVBp7RKjRPESfCDIB6COTSHFOAe5OPJw+B+tUjTlrKgxJ39uqTEmac=
X-Received: by 2002:a25:d804:0:b0:d01:6e22:9291 with SMTP id
 p4-20020a25d804000000b00d016e229291mr2948454ybg.34.1689986647060; Fri, 21 Jul
 2023 17:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230719081544.741051-1-javierm@redhat.com> <20230719081544.741051-2-javierm@redhat.com>
 <87sf9gublz.fsf@minerva.mail-host-address-is-not-set> <CANiq72=A3PLGGPGnwL=gjX7LFsQL9N8W__ojxmVpj2uCAKvhQA@mail.gmail.com>
 <87mszou7kz.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <87mszou7kz.fsf@minerva.mail-host-address-is-not-set>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 22 Jul 2023 02:43:55 +0200
Message-ID: <CANiq72=RBUdFdt8=k-AACxXWrbnqfiaiViNUNxvwzGNCDkjwQA@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] video: Add auxiliary display drivers to Graphics
 support menu
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Nipun Gupta <nipun.gupta@amd.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
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

On Sat, Jul 22, 2023 at 2:13=E2=80=AFAM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Oh, interesting. I wonder why that couldn't had been a fbdev driver then
> using FB_VISUAL_MONO01? I'll reword then the commit message before apply
> to the following instead:

It is :)

    .type =3D FB_TYPE_PACKED_PIXELS,
    .visual =3D FB_VISUAL_MONO10,

The original distinction was more about having a place where to put
small, simple displays that were not your usual "screen", where you
would typically draw a custom UI, probably controlled with a few
custom buttons, etc.

> Perfect, thanks!

My pleasure!

Cheers,
Miguel
