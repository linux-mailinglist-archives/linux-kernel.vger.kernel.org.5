Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4753281398A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572946AbjLNSMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjLNSMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:12:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B9B123
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:12:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B434AC433C7;
        Thu, 14 Dec 2023 18:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702577576;
        bh=9uDKjR6ENQ/K3Sf5xNvwga0k6H6K4XUFFfjNnkFeRrI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H1105MNyP9Wff0fEMpFolNBcsQf0S9V4M49eBuV3/S7ONiYCzZyNMm9KaZS7xluH4
         Q1MjaO8tavKqNjas65Hnc+ZSkUioUvCSqRnaBNwnR9n2BaxD9OGqtUc6UFCfX8UDTP
         hPGad+bvIPFnKJpq09KvMQN2Ez9rfVXgvGfxh+akL2fPfSrV4lRxBS9q6wTy5beJjY
         lKxIBk654oZ1/yy6VlBVDFHpz8sVZkHkxMgM2fuJDmqGclvuNn9UyafQ4R5vgNVhY/
         W3VmSeuADjkRRfGho1O9VuuV+3dGGuh8NQt+R4fEWkO029/Rkt7tdzlmVac4YLLxSC
         wysccIJjt/gQg==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e0ba402b4so4544020e87.1;
        Thu, 14 Dec 2023 10:12:56 -0800 (PST)
X-Gm-Message-State: AOJu0YwNDvUTML9jrXqo92ztlVpXAde4hPOPd4jOLQCxW5HlZwbEnNq0
        xWharj5I1ZraL+CDbbR2zC3AdXgR2h7Tur2WaA==
X-Google-Smtp-Source: AGHT+IGJmgByQmzdpXCeRamEl4cngOXuD0FNxHvEbfASuSp1YNGDfU2difQ6xmc2xdlhi8xJtU6GmISDFggf4ernITU=
X-Received: by 2002:ac2:5f43:0:b0:50b:ef17:5137 with SMTP id
 3-20020ac25f43000000b0050bef175137mr4523117lfz.35.1702577574903; Thu, 14 Dec
 2023 10:12:54 -0800 (PST)
MIME-Version: 1.0
References: <20231213232455.2248056-1-robh@kernel.org> <20231214-buzz-playlist-2f75095ef2b0@spud>
In-Reply-To: <20231214-buzz-playlist-2f75095ef2b0@spud>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 14 Dec 2023 12:12:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKaGFfQNwR3HqRnVs3K7SUtevpoG6tEDntM0SNfyyp6AQ@mail.gmail.com>
Message-ID: <CAL_JsqKaGFfQNwR3HqRnVs3K7SUtevpoG6tEDntM0SNfyyp6AQ@mail.gmail.com>
Subject: Re: [PATCH net-next] dt-bindings: net: marvell,orion-mdio: Drop "reg"
 sizes schema
To:     Conor Dooley <conor@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 10:23=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Wed, Dec 13, 2023 at 05:24:55PM -0600, Rob Herring wrote:
> > Defining the size of register regions is not really in scope of what
> > bindings need to cover. The schema for this is also not completely corr=
ect
> > as a reg entry can be variable number of cells for the address and size=
,
> > but the schema assumes 1 cell.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> Does this not also remove restrictions on what the number in the reg
> entry is actually allowed to be?

Yes, that's what I mean with the first sentence. We don't do this
anywhere else with the exception of some I2C devices with fixed
addresses. Keying off of the interrupt property also seems
questionable. If the register size is different, that should be a
different compatible.

I only noticed this when I happened to remove "definitions/cell" and
this broke. That wasn't really intended to be public.

Rob
