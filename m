Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAC277E70F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345001AbjHPQ5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344996AbjHPQ46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:56:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4248B1BE7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 09:56:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB0E563C06
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 16:56:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D6AC433C7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 16:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692205016;
        bh=YXafEea114io5dZrO32RstA5qzqap9r3v6OtCQtRHdg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A75waRAIAhPg3mf/mZvpMk+XrNfJOquk2IxkDRxX6F08PgPGJ+f9RXD8iJh7fqf8t
         uGZFrwUZNzb0FpD+tuhb6GgJjc3Mf/1LS51eFpQZH/cINdZp68JjDpBoFivx2XjOjy
         +b78QWsUi6IvoU9PFM6wwWxiKaju545dCB33YaVOs7uVVWAZQ1Cht2ei6ekn626w1O
         dACsdfb6V1sPmbfW5GSbsjLfF6ADAsPUaEpYKYbXlS1EonAHz1IoRFbX6C/0vwJFnT
         ca1XfC0XDCJfi/EPipybDWSNkrbc7Hxv7De7NwMcRx3hPFaxQzb8vUYaMR2qJ2jtcB
         RUiCE/wKjRjDA==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ba1e9b1fa9so105454961fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 09:56:56 -0700 (PDT)
X-Gm-Message-State: AOJu0YzuQUhYICzgNJYlV3sKPWMPbyOqQh2XFNaX7+HjAT/9wiKiH69C
        Etbx0aXFjyGPUX/K28Umseew7AqLKvBW4Sb1bg==
X-Google-Smtp-Source: AGHT+IFAT+7BgMv/V6g03kazrcjMspVljx78PyqqSNcZJO5eHBw27SFCIYc/3s1AHga0Yn+qAhAzy4RBkGCqrI3R788=
X-Received: by 2002:a2e:2e0b:0:b0:2b8:36d4:7b0a with SMTP id
 u11-20020a2e2e0b000000b002b836d47b0amr2327664lju.29.1692205014260; Wed, 16
 Aug 2023 09:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230717225645.3214989-1-robh@kernel.org> <87sf8otid2.fsf@BL-laptop>
In-Reply-To: <87sf8otid2.fsf@BL-laptop>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 16 Aug 2023 11:56:42 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJFjoKupAofBVQfCfBdjCgHGevupLAjpp9bGUGdsG4ymQ@mail.gmail.com>
Message-ID: <CAL_JsqJFjoKupAofBVQfCfBdjCgHGevupLAjpp9bGUGdsG4ymQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dove: Drop unused includes
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Sat, Aug 12, 2023 at 10:01=E2=80=AFAM Gregory CLEMENT
<gregory.clement@bootlin.com> wrote:
>
> Rob Herring <robh@kernel.org> writes:
>
> > Several includes are not needed, so drop them.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> Applied on mvebu/arm

Arnd already applied this directly.

Rob
