Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D90767DC3
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 11:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjG2JzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 05:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjG2JzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 05:55:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83F818B;
        Sat, 29 Jul 2023 02:55:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C6C360AF7;
        Sat, 29 Jul 2023 09:55:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9443C433C9;
        Sat, 29 Jul 2023 09:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690624505;
        bh=SQL13M4f5E2+56p2vK8z9W2ChH7UansjvSz262SEOU4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ehSZ3pAEa1OqcgzaEgF1qj7zr+lDGpDkoMeIYwTj79PjEsRTsA37KDKV3ZsCkDZgu
         pbB8Grp17nlQWQxuEFEP7ZdJd0oleZ3pwkopom8h4rYwIuU9rfreNV6fX83gRTcB1k
         5/PeiS06SLfBMk80ANu4HKwNxUBIErR4H6tAbAIlolzMz4T5NbSkZyT62RdSxidVNV
         TAlhYkBK4B9agHGx270jwzv7htKXKYtjMAsTkvk/fbFYXyATUO/2+/1c2qvl0em4tB
         wKTx+CjYqx9dbh5/2wvBNBrpYK7tHe87jtUZBGomc8NAtTHzXhxajRkuYRXaW/7MMW
         1WETcbEcd+Aqg==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3a425ef874dso2287411b6e.0;
        Sat, 29 Jul 2023 02:55:05 -0700 (PDT)
X-Gm-Message-State: ABy/qLZP3ayIJKd89evVuTYNLBxaLL5eauistP9DSiPcZj2rfB5pGNRh
        jP0G9/wM01KQd+EuMWJwWL3lqBmKiW8tXtE15tI=
X-Google-Smtp-Source: APBJJlHgSZ5y+Dz+Y8xqJgAwQBiY0Pn2BniF/Lh7M60CvamIcvGPIJVmzKTTtRN1xTrRjtXOOFqGBIuje3vrxIAuvwY=
X-Received: by 2002:a05:6808:2029:b0:3a4:38fa:2e08 with SMTP id
 q41-20020a056808202900b003a438fa2e08mr5334904oiw.7.1690624504998; Sat, 29 Jul
 2023 02:55:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230724074625.458456-1-boris@codesynthesis.com>
 <20230724074625.458456-2-boris@codesynthesis.com> <e11e6287-9b27-90d7-da95-1dc88348b8b0@infradead.org>
 <boris.20230725155503@codesynthesis.com>
In-Reply-To: <boris.20230725155503@codesynthesis.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 29 Jul 2023 18:54:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNASHM0Gp7t1tpCMekyYA0c0ntr8COztL9GEivr21MN+faA@mail.gmail.com>
Message-ID: <CAK7LNASHM0Gp7t1tpCMekyYA0c0ntr8COztL9GEivr21MN+faA@mail.gmail.com>
Subject: Re: [PATCH 1/1] kconfig: port qconf to work with Qt6 in addition to Qt5
To:     Boris Kolpackov <boris@codesynthesis.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 10:58=E2=80=AFPM Boris Kolpackov
<boris@codesynthesis.com> wrote:
>
> Randy Dunlap <rdunlap@infradead.org> writes:
>
> > On 7/24/23 00:46, Boris Kolpackov wrote:
> >
> > > Tested with Qt5 5.15 and Qt6 6.4. Note that earlier versions of Qt5
> > > are no longer guaranteed to work.



This patch did not change scripts/kconfig/qconf-cfg.sh at all.
Hence, Qt5 is always linked.


Please change scripts/kconfig/qconf-cfg.sh so that:

  1. If Qt6 is installed, please link Qt6.
  2. If Qt6 is not installed but Qt5 is installed,
     please link Qt5



> >
> > Was there such a guarantee somewhere?
>
> I don't believe there was anything explicit, but seeing that the
> qconf source code hardly changed in the past couple of years, it
> could have worked with earlier versions of Qt5 and some people
> could have relied on that.
>
>
> > Acked-by: Randy Dunlap <rdunlap@infradead.org>
> > Tested-by: Randy Dunlap <rdunlap@infradead.org>
>
> Thanks!


A request to reviewers/testers:

  Please make sure you tested this
  with both Qt5 and Qt6.


To check the Qt version you are running:
  1.   'make xconfig'
 2. See  Help -> About


--
Best Regards
Masahiro Yamada
