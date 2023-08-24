Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D883A7864C8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 03:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239126AbjHXBpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 21:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239121AbjHXBpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 21:45:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3A012C;
        Wed, 23 Aug 2023 18:45:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59F9F633E0;
        Thu, 24 Aug 2023 01:45:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4BEC433CA;
        Thu, 24 Aug 2023 01:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692841506;
        bh=6GgbihUlRiFKBpNgjk/gJ96kVjizItouIAMzPd6FKEY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KedDJ7MmUybKxohGgoxLYWZRF89G3fTk87S+GX/0jLCscJuWHlXL+liulgF47Qlu3
         G0hduuMergGXR6Uo3jGAcVdI6dV+EgtnCTwYM2Xz85kYT8+R6h7cPiMMyVn9/pmQeW
         L/A2dwzhLRCBnB8kCax5NEDV1zv+U8V+gkUKxUZDIMq4tD4D7CW9+ZmmYUuWGBK56X
         vqSid9y0HNpvogRLn0pOYOw4NiS5dhcVOMZFfLGYQxZXUymHAzHyxiWUAO4lL3rcMR
         W/Y7HSgbycxsaj520abwBw2lZA26uvAnhFmxA31wt2u70giGOStF6uau0p/EcvvIzd
         wBtdDf/BGT7uw==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1c4b4c40281so240294fac.1;
        Wed, 23 Aug 2023 18:45:06 -0700 (PDT)
X-Gm-Message-State: AOJu0YymgptRtNO8Lpi+ia1EMMyRrDK4k5ad9IGcKGk+UFIaciVLPLQP
        kPN/NdBYQGpqccChydHpnr3j0p2ovniPi2JEm7c=
X-Google-Smtp-Source: AGHT+IH4Hwas3YeBNfU629vGtS5UVDZT0grCXXzWiel6WR57nswmYfg2oIubkvA1vRYlRnQDmBTEWFI6ItsfcbIWbwY=
X-Received: by 2002:a05:6871:70d:b0:1c5:dcd:5d64 with SMTP id
 f13-20020a056871070d00b001c50dcd5d64mr9548348oap.7.1692841505924; Wed, 23 Aug
 2023 18:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230823120816.824352-1-masahiroy@kernel.org>
In-Reply-To: <20230823120816.824352-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 24 Aug 2023 10:44:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNASDi7RTBk6z4=J8mtyoRd7-NKD36d2fGwtkA_=tdmka0g@mail.gmail.com>
Message-ID: <CAK7LNASDi7RTBk6z4=J8mtyoRd7-NKD36d2fGwtkA_=tdmka0g@mail.gmail.com>
Subject: Re: [PATCH] kbuild: get lib-y objects back to static library
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 10:05=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
>
> Revert the following two commits:
>
>  - 7273ad2b08f8 ("kbuild: link lib-y objects to vmlinux forcibly when CON=
FIG_MODULES=3Dy")
>  - 7f2084fa55e6 ("[kbuild] handle exports in lib-y objects reliably")
>
> Now, lib-y is back to static library again, and the link order is
> consistent w/wo CONFIG_MODULES.
>
> Since commit ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by
> modpost"), .vmlinux.export.c contains references to exported symbols.
> If a symbol in a lib-y object is exported, that object is always linked
> even without any explicit user in vmlinux.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---



I just recalled that presumably ARM code must be fixed beforehand.

https://lore.kernel.org/lkml/20230619143725.57967-1-masahiroy@kernel.org/

$(mmu-y) is added to lib-y, but they cannot go into a static library.







--=20
Best Regards
Masahiro Yamada
