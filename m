Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B171E784CD4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 00:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjHVW2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 18:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjHVW2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 18:28:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11934CDD
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 15:28:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AD3263BAF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 22:28:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0696CC433C9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 22:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692743300;
        bh=geGPAzWnRQXSH/yKRxJr9oEA6cw5V92wyIYSowAp4p0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=irtBDPkzKvT64lm2LFNoYKz2GGGErlhxhZwlFZNMDcuxJqThaPQSedYnDv7Ue1CJS
         vJzICoc96HRF1w1oxaG8Km8Vce0n48Y8ZjpwKYGzgm+iZz5GyggfqaDgKBlLLRBfnL
         C9gyuF7/SSsMch2w2owk/0ct88gWkojs7Zaw5aiUMpNs5ju9wRalR9uggH3erMSQkH
         DprpdsXEC5nrN6kEcXmalje/sXMdRH7HeAZ8jfzmXC7yBxpHze/4zMsMpoRR6cMzlw
         BcyQRYR+vgVvEEZrov8fQa7JOwXlvfT8Mp3c27VxUl1o5cu6yf0kf0q8N90nMK5lFE
         B6iWfZ041QxtQ==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2bb97f2c99cso78362971fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 15:28:19 -0700 (PDT)
X-Gm-Message-State: AOJu0YwJDzuBhFyyQXyOWRf4h4pyVSg0aulPC1Elf0Kb1bzjuuottsbZ
        huTZeSbsa6avu1xAy5g/fXBDill5BT5OKMV2yg==
X-Google-Smtp-Source: AGHT+IHnU+qmnbDd24XJLjCvEMjv36tzTs1g6aWdXU3Ip/dqr3RWOt30VkNK3y4mDXmtyQCzqzaXMnjhzpqHY4g0rWA=
X-Received: by 2002:a2e:86ca:0:b0:2b9:b067:9554 with SMTP id
 n10-20020a2e86ca000000b002b9b0679554mr8204874ljj.2.1692743297950; Tue, 22 Aug
 2023 15:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230717225610.3214029-1-robh@kernel.org> <169028492642.1718138.9430735746671016845.b4-ty@ti.com>
In-Reply-To: <169028492642.1718138.9430735746671016845.b4-ty@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 22 Aug 2023 17:28:05 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKAuLJwBiKjLFd03C89ZRr0P+URyOh3t-7oqKv3vQzBdw@mail.gmail.com>
Message-ID: <CAL_JsqKAuLJwBiKjLFd03C89ZRr0P+URyOh3t-7oqKv3vQzBdw@mail.gmail.com>
Subject: Re: [PATCH] ARM: keystone: Drop unused includes
To:     Nishanth Menon <nm@ti.com>
Cc:     Santosh Shilimkar <ssantosh@kernel.org>,
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

On Tue, Jul 25, 2023 at 6:35=E2=80=AFAM Nishanth Menon <nm@ti.com> wrote:
>
> Hi Rob Herring,
>
> On Mon, 17 Jul 2023 16:56:09 -0600, Rob Herring wrote:
> > Several includes are not needed, so drop them.
> >
> > of_platform.h is not needed, but it implicitly includes platform_device=
.h
> > (for now) which is needed.
> >
> >
>
> I have applied the following to branch ti-keystone-next on [1].
> Thank you!
>
> [1/1] ARM: keystone: Drop unused includes
>       commit: 630c191b3396c6aaccab1234f8834848a2c42e8a

Did you really? Doesn't look like this is in linux-next.

Rob
