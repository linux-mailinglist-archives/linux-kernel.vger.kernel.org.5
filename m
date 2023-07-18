Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12B6757101
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 02:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjGRAd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 20:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjGRAdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 20:33:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2388710C0;
        Mon, 17 Jul 2023 17:33:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABBA96127D;
        Tue, 18 Jul 2023 00:33:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1466DC433C9;
        Tue, 18 Jul 2023 00:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689640433;
        bh=RBL+5TgTWKgSNwaUUHaerkgq74itFtQzynxN4Q1YlJY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BZEIcyPjCdkAMInJ9ANpvNALlETPVGui1DK789rGO47CRbMYczS2bWfguyEKoubY0
         //RgjTHrCZk0/mdIwkO1IDJNJTtCOJo1xX5tvmNLrd1WjlZLO1jMd2e3ooULuZs6iQ
         quDxeMEM74N7B1MoKWcFQdPie2Jx+peptW3wDSmgFcVrJF3sn6hJ8ZFhSNpmjr4Zf7
         Yb61qPGj62R3rt83zpKtqrBmxYM4Bfxcjp6vkqq77NAYkMt1VR8c8Z7g1eexqRhbhq
         UknkyA8n/hk7SWLjfvHCbhcjf3SbTCIVgnHgn0yPvOLQUDZ/zJ5+iOm/+u+jcVePUt
         6XVgRu2T1TRnA==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3a426e70575so2756782b6e.0;
        Mon, 17 Jul 2023 17:33:53 -0700 (PDT)
X-Gm-Message-State: ABy/qLb0AMkbPD7FrpBahpbGSEg+/yKqB67xlRj9UaIdwgjZcAP/pDq4
        v0gnVNUnl2CXPCYG2hzw78U7aY8OP6oQih2fclg=
X-Google-Smtp-Source: APBJJlGhgFmIaVK1SEzpjxImWMYoLPEPtqNHew/5ib79WF3kY5HPWvLAcexq5bGDexV3s4iYYOLYBxTSjAKJJrbmBSs=
X-Received: by 2002:a05:6808:1404:b0:3a3:cfec:ab43 with SMTP id
 w4-20020a056808140400b003a3cfecab43mr13150557oiv.9.1689640432319; Mon, 17 Jul
 2023 17:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <boris.20230717111132@codesynthesis.com>
In-Reply-To: <boris.20230717111132@codesynthesis.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 18 Jul 2023 09:33:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNATAYqG+Y-XubnU9EJqc3R9QhWCn1nfiGMLU63W7k0vpxQ@mail.gmail.com>
Message-ID: <CAK7LNATAYqG+Y-XubnU9EJqc3R9QhWCn1nfiGMLU63W7k0vpxQ@mail.gmail.com>
Subject: Re: Qt6 port of kconfig qconf
To:     Boris Kolpackov <boris@codesynthesis.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 6:27=E2=80=AFPM Boris Kolpackov <boris@codesynthesi=
s.com> wrote:
>
> Is there interest in the Qt6 port of qconf (which is currently Qt5)?
>
> I took an exploratory stab at it and I've managed to make it compile
> and run with relatively few changes, though there are quite a few
> warnings about using deprecated stuff.
>
> I can see three possible approaches here:
>
> 1. Drop Qt5 support and port qconf to be exclusively Qt6. This should
>    allow cleaning up all the deprecated stuff.
>
> 2. Support Qt5 and Qt6 in the same qconf.cc. With this approach it's
>    unlikely we will be able to cleanup the deprecated stuff without
>    turning it into an #if soup.
>
> 3. Leave qconf.cc to be Qt5-only and make the changes in the qconf6.cc
>    copy. This will allow us to clean up all the deprecated stuff but
>    will require applying further changes to two files until we drop
>    support for Qt5.
>
> Thoughts?


I like 1 or 2, depending on the size of #if soup.




--=20
Best Regards
Masahiro Yamada
