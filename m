Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82D17546F6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 07:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjGOFrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 01:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGOFq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 01:46:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6EA3A9D;
        Fri, 14 Jul 2023 22:46:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B10060909;
        Sat, 15 Jul 2023 05:46:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60934C433C8;
        Sat, 15 Jul 2023 05:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689400016;
        bh=hXicwqLTN0ET4Pl6rTMLYhLj6AtHzbo3scQYuxwzea4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=STYIBS83WpZDa+b/m7xmR7a+XOwXEdVongq0B5mMzumcJWWwiKV0i0E5a+jCDPBRP
         P0ApJbJZjC06ir+MLTbntcSUvvHK1TehdC5dlsov54lQSDQdxtgeGjnFgSVHNrhgqU
         4q+SiGOlnkgWsV3KVMdaCpcejfo8my/DrXyoq/+HyCilZle1Wlu2gnx462V0thAg2j
         FAo3a2+J2ptref/krsaBOWvR11PgYJ9ochbBD16prpJlBkXDmTuDkmbdY94+EAD0ps
         E2WOm6foac2orBB2rL6HFbTO7VRSr3UaxbjYNdLVW7+JIYE5raHQecRXisjEa1P3eS
         yyg+hVpZBiGog==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1b060bce5b0so2220746fac.3;
        Fri, 14 Jul 2023 22:46:56 -0700 (PDT)
X-Gm-Message-State: ABy/qLaeCBN4cIcOrDMIKdk9ni2hFvkGMA7WIGaYhK/rrL5qSuWskBU7
        QLouKZox48YWi9mE6e8s7vEQeaisATA3jEw8aBc=
X-Google-Smtp-Source: APBJJlGpxm4MsON8WQKGqUZVkVAKj0IVymynYg7nIfKuv2V46AjhZDPfdOvMCSVYP3vj36HBrUEXSLDXj8R7Lojivow=
X-Received: by 2002:a05:6870:702b:b0:1ba:4815:ee64 with SMTP id
 u43-20020a056870702b00b001ba4815ee64mr3751692oae.1.1689400015673; Fri, 14 Jul
 2023 22:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230704221951.7396-1-bp@alien8.de> <20230705162026.GA2951@dev-arch.thelio-3990X>
In-Reply-To: <20230705162026.GA2951@dev-arch.thelio-3990X>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 15 Jul 2023 14:46:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNARbt-=KnmA+pTJQ1Fg9XmGMySWAFd1jDs_smnpq1Nus7w@mail.gmail.com>
Message-ID: <CAK7LNARbt-=KnmA+pTJQ1Fg9XmGMySWAFd1jDs_smnpq1Nus7w@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Enable -Wenum-conversion by default
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kbuild@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 6, 2023 at 1:20=E2=80=AFAM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> On Wed, Jul 05, 2023 at 12:19:51AM +0200, Borislav Petkov wrote:
> > From: "Borislav Petkov (AMD)" <bp@alien8.de>
> >
> > This diagnostic checks whether there is a type mismatch when
> > converting enums (assign an enum of type A to an enum of type B, for
> > example) and it caught a legit issue recently. The reason it didn't sho=
w
> > is because that warning is enabled only with -Wextra with GCC. Clang,
> > however, enables it by default.
> >
> > GCC folks were considering enabling it by default but it was too noisy
> > back then:
> >
> >   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D78736
> >
> > Now that due to clang all those warnings have been fixed, enable it wit=
h
> > GCC too.
> >
> > allmodconfig tests done with: x86, arm{,64}, powerpc{,64}, riscv
> > crossbuilds.
> >
> > Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
>
> Yes please :)
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>




Applied to linux-kbuild.
Thanks.






--=20
Best Regards
Masahiro Yamada
