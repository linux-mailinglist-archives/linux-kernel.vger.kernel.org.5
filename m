Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A31A7DA162
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 21:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjJ0TiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 15:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJ0TiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 15:38:23 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6190A1B4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 12:38:20 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9bf86b77a2aso346440066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 12:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698435499; x=1699040299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HResry5JndYeZBSzTVAWBwxzRl7+fUNF38GNSOea4NU=;
        b=AmnrvFM8pY/WSb2SEchOnNX9gmzhPV4+ItnmSD7Iy6POFrPij3pF1vnkfNgRYSti7p
         WnY1oDILFqn4zNB2vfh3KktUXk7FAiCo/q2Li84ORALTfsnGiAL13vqaY4zDW6P3mFQY
         8HSBRA6Rit29fhhvWZWSI5LKJxuWzsIvqUUej4amgzmShIS67fpq1a6kiT+zqDKaEXjG
         8xhGdPfNoPH8GYGqYTwq23u7AqXfsOdaMYE1Qh7xn7Gv7CC1AeyaH4aNgjZebT7nUTMW
         KrhbZtO+7WKQoH6LPdJnYfUuPx+lZa/E7C1VJHB/iWQjg96ipT9fHzV+cf7dXfrNVQU8
         2dJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698435499; x=1699040299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HResry5JndYeZBSzTVAWBwxzRl7+fUNF38GNSOea4NU=;
        b=ICymCRFpRRKXOSHTIg1erWo/phIsM7mf/8aJ4dt/BOCTq4N98mSDLF5PE1tPgavoxO
         MMemCZ4SQQaLfydQaFjgPC2pTxXDyQEIkBfjE64SBukfgJ7+KoaIHNcfZSc691ZscuZ5
         zgbNaDCEH8BnPwbhwGvrEWVY7vWyfLEp+OkxGAiYiSkzQoNjUBxDCoTIWbadeJaVEGMe
         Q+krNDrMocfrVWr32qbmD6gixUpvvwgJ/KMx7RTSrJ0fNCnpA10UYkDg3v3yNUE5KnEN
         +U3FrYqD5MiIj6yQYcE5zCJL6ljCPxSC4rXou/5CitcGwZ8+SphYDhoVfhd/P21pKv14
         2/3g==
X-Gm-Message-State: AOJu0Yz5fLP/0m/4qVwQsz9+PvQadQTTMJ7fxiYJj8UXM2cJhvpQem1A
        6yf60Y1JZcenEyFzQWSXXzojkiqpj6YdhB3wHTMg5g==
X-Google-Smtp-Source: AGHT+IGfiH7/vZwPOYNJYfiPFBz2VHBIUsAkZ3hwTXH1qOBLB7kLIxeiWKyV6/erRjPKyouXW2aFwt8n98N0Q3p+tfY=
X-Received: by 2002:a17:907:9341:b0:9b2:b71f:83be with SMTP id
 bv1-20020a170907934100b009b2b71f83bemr3210322ejc.1.1698435498762; Fri, 27 Oct
 2023 12:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231026-ethtool_puts_impl-v2-0-0d67cbdd0538@google.com>
 <20231026-ethtool_puts_impl-v2-1-0d67cbdd0538@google.com> <20231026220248.blgf7kgt5fkkbg7f@skbuf>
 <CAFhGd8rWOE8zGFCdjM6i8H3TP8q5BFFxMGCk0n-nmLmjHojefg@mail.gmail.com> <20231026222548.rqbp5ktgo2mysl6w@skbuf>
In-Reply-To: <20231026222548.rqbp5ktgo2mysl6w@skbuf>
From:   Justin Stitt <justinstitt@google.com>
Date:   Fri, 27 Oct 2023 12:38:06 -0700
Message-ID: <CAFhGd8r9Y2tavxA2KVpELm-SRdvD+iEmYW=s7tf_dPpmVT3WeA@mail.gmail.com>
Subject: Re: [PATCH next v2 1/3] ethtool: Implement ethtool_puts()
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     GR-Linux-NIC-Dev@marvell.com, UNGLinuxDriver@microchip.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, oss-drivers@corigine.com,
        linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 3:25=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
>
> On Thu, Oct 26, 2023 at 03:09:59PM -0700, Justin Stitt wrote:
> > Should I undo this? I want my patch against next since it's targeting
> > some stuff in-flight over there. BUT, I also want ethtool_puts() to be
> > directly below ethtool_sprintf() in the source code. What to do?
>
> (removing everyone except the lists from CC, I don't want to go to email
> arest because of spamming too many recipients)
>
> What is the stuff in-flight in next that this is targeting?
>
> And why would anything prevent you from putting ethtool_puts() directly
> below ethtool_sprintf()?

The in-flight stuff consists of patches I sent changing some strncpy() usag=
e
to

ethtool_sprintf(&data, "%s", something[i].name);

We can see them here [1]. I went for this approach initially but then
discussion came up about introducing ethtool_puts() which now
made my patches (some accepted into next already) semi-outdated
and in need of another swap from sprintf->puts() -- hence this series.

As far as the rebase, I simply took my commits and placed them on
top of next/master and got merge conflicts when ethtool_puts()
was placed below ethtool_sprintf(). All I have to do is move the hunks
around but since I formatted the file it's appearing in the diff. v3 will
be a clean diff.


[1]: https://lore.kernel.org/all/?q=3Ddfb:ethtool_sprintf%20AND%20f:justins=
titt

Thanks
Justin
