Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383C3781C15
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 04:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjHTCgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 22:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjHTCfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 22:35:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96DC6CB35;
        Sat, 19 Aug 2023 16:20:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F50761882;
        Sat, 19 Aug 2023 23:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9B0C433CB;
        Sat, 19 Aug 2023 23:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692487234;
        bh=DIVwax5Y3AFVt2W6HkTTPIpqSiJRvcBZtl6jpYXaXlU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LC38TrMnFINW6OjR+twcKA37K3TMDEiEQNxY4Rx5vZCI5YGancu0e5BgkxXcp1l8C
         Ig4ldcWwp/L9BnkZudSTWB9zSxPTbkOwHpFTZkggOaEfI/Yfj56ca4zSiYZF3vjT5l
         gg4rYAB7q66vzvixkl4PxoMXoeQA53P8rz8a2mLiEjDCKYOD0Kj3jYkz3cTzlEcAB+
         iE9ICRmdKJF378HkKrWmOgBWhidea4WToYYu/u8JyudRRVT+/F2trquEh3YkTokZvl
         FKsrEuCHx2e4No1VCScgpV/WU38zTSL1YywwMO94aIlUA9f4iMibnXXAVQ+NRVPnN/
         IHx8LK/RErqlg==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-56e0d6651fbso1714419eaf.1;
        Sat, 19 Aug 2023 16:20:34 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz5SD1TivzVbkV0/dqCy/P2BrEgfLxnPlt61baabNa7v75yYI5T
        4yGDNtlBbbgP3aKcwIonP4LaOc5rTzmr8mfvvDY=
X-Google-Smtp-Source: AGHT+IFXuIQCKgq40Jh+CUksunkc4g/HDrnQiJZxj1NwMk0N8zIlTUbmfGTPV89p9ZOEo/oIbsfpCG8Z9qm6KBIXmfM=
X-Received: by 2002:aca:1b08:0:b0:3a4:8ecb:185c with SMTP id
 b8-20020aca1b08000000b003a48ecb185cmr2035399oib.22.1692487233928; Sat, 19 Aug
 2023 16:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230817012007.131868-1-senozhatsky@chromium.org>
In-Reply-To: <20230817012007.131868-1-senozhatsky@chromium.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 20 Aug 2023 08:19:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNASJWKSsdzn5ccgWaC35-XvHGU7pnE6C=eZFDbqrrghtdQ@mail.gmail.com>
Message-ID: <CAK7LNASJWKSsdzn5ccgWaC35-XvHGU7pnE6C=eZFDbqrrghtdQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] kconfig: introduce listunknownconfig
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>,
        Tomasz Figa <tfiga@chromium.org>, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 5:30=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Example:
> Suppose old .config has the following two options which
> were removed from the recent kernel:
>
> $ cat .config
> CONFIG_DISABLE_BUGS=3Dy
>
> Running `make listunknownconfig` produces the following
> list of unrecognized symbols:
>
> .config:6:warning: unknown symbol: DISABLE_BUGS
> .config:7:warning: unknown unset symbol: ENABLE_WINAPI
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>


A new target is not what I like to see.


We decided to add KCONFIG_VERBOSE, which will be used to
warn options accidentally disabled or downgraded.

https://lore.kernel.org/linux-kbuild/20230809002436.18079-1-sunying@nj.isca=
s.ac.cn/T/#u


--
Best Regards

Masahiro Yamada
