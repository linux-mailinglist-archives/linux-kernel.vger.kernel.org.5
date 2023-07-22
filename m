Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FBE75D87E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 03:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjGVBBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 21:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjGVBBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 21:01:30 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E554F30D7;
        Fri, 21 Jul 2023 18:01:29 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-57045429f76so28503167b3.0;
        Fri, 21 Jul 2023 18:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689987689; x=1690592489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgAKBTCLGko3WFZbluw/Ne8ucJz0BHQta3RW0S2hIRk=;
        b=LJQH6PoUH2lr8N6JBNj1lPRiAbArnv1CI14uzPKWm4ggEgemPpsC6f03HGJf0lAtKP
         scIRDJ1WOnSZuQCoAwbBGc0yYYx50JdWx6HyFaBwE6TYJ5P3bVreBqyMSsKlFG5/GvxZ
         ZQNaxuQdlNpcdT/65HJ/GiEYYfpSbVXAizKOb/JRv3FUl4KRKwvNMI0g2xuBG+tYqyiO
         OKSTfCdoTt8tnxABz6Wtrn3+uiHyHV0WEtTELlFk3AiJlii92eBTvBT5kIL/ORQ3Sf9g
         SmDHfqquHPED4OOgo+JBboYubJwdEpJAxyyFToDNx2W1uKddK7YUgXkerflXco2H8QQu
         oAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689987689; x=1690592489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgAKBTCLGko3WFZbluw/Ne8ucJz0BHQta3RW0S2hIRk=;
        b=OExIHBFz3ZPdgU6YDo0NYtIy92iiah0YBCV4belMFsTIAWtLiKvtpwgvxtLIk8Bkxg
         MBK1pU6lUWQi+iaScDytdPvPKAmWzVzv6Z+IGSmEGFU+3X2/X9xHkb/VahlX9pceCU5u
         h9i8YfSLKqxn6ykQCI5EZkA1kxQMOjRVymJpv4V19/ttAN/CqrUb7ab6n1v+vUBd2x3s
         /QrfhP8f9MlFkXLJnL07YP2ufEiCwE1PhW0l4T3lR1GrLcdmaeK4fUyko5/rzb/iXc9u
         WnmyEc9Y3f7NsWRV8oBZ4cF0sJi32v2z7vmzEN586XaL9gkVSD7dxi06DDHAs1Y1dT2I
         gRFQ==
X-Gm-Message-State: ABy/qLbNGIaqNYfmncxzksO8pemDc0Nz5NrNVEzHnHz2rSDrsrQ0hCQJ
        RLwgx9fIYnJviuJVCjgXVyGZW1V+MMGxu0axRmPUxywg82oUSg==
X-Google-Smtp-Source: APBJJlF0//QiQWtD+L/zdxm4m2v5yewUmFENZfqZXoW8TfgOJ3R2IFQidV6q5TbqWU9Fe4aXsfKC/kf56gdIg4lT7tQ=
X-Received: by 2002:a81:6a45:0:b0:583:a418:c3fc with SMTP id
 f66-20020a816a45000000b00583a418c3fcmr1764965ywc.23.1689987689139; Fri, 21
 Jul 2023 18:01:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230719081544.741051-1-javierm@redhat.com> <20230719081544.741051-2-javierm@redhat.com>
 <87sf9gublz.fsf@minerva.mail-host-address-is-not-set> <CANiq72=A3PLGGPGnwL=gjX7LFsQL9N8W__ojxmVpj2uCAKvhQA@mail.gmail.com>
 <87mszou7kz.fsf@minerva.mail-host-address-is-not-set> <CANiq72=RBUdFdt8=k-AACxXWrbnqfiaiViNUNxvwzGNCDkjwQA@mail.gmail.com>
 <87jzusu5uz.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <87jzusu5uz.fsf@minerva.mail-host-address-is-not-set>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 22 Jul 2023 03:01:17 +0200
Message-ID: <CANiq72=UZun8=ibyKd7dJoxSZGaohg8-YEqxGb1RzXfELCV9AQ@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 22, 2023 at 2:50=E2=80=AFAM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Got it. Then that's yet another argument for adding the auxdisplay
> drivers under the same "Graphics support" menu.

Just in case it matters for Helge/you: these may also register an
input device, e.g. the ht16k33 has a matrix keypad.

Cheers,
Miguel
