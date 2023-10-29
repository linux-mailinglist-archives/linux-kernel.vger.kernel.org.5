Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310037DAD72
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 18:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjJ2RK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 13:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjJ2RK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 13:10:57 -0400
Received: from hutie.ust.cz (hutie.ust.cz [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06D6AF;
        Sun, 29 Oct 2023 10:10:55 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1698599452; bh=qqFFfHBHXxc/vngEYN7PGSdvv72J5iWHr+qOTphN6Io=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=gWSwdjK4WQs8sn+bwfMnOmyLeSs2iQt1mq45yaHM3oreInK8s1UO7jN5IiKTeO+bC
         fGaz5XZnbSq5149tfmhcXo6wryLDzl8PGWBS6Lt1xsLjVYH5hr6LzcVjfRDNWIA4ZW
         in+71aaNRTNvrn+SEYjAjyiL+ZH1A27ER1tbzA08=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH] dmaengine: apple-admac: Keep upper bits of REG_BUS_WIDTH
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <20231029170053.82146-1-povik+lin@cutebit.org>
Date:   Sun, 29 Oct 2023 18:10:41 +0100
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        dmaengine@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <00401D09-6037-44AE-91CC-34379ED9589E@cutebit.org>
References: <20231029170053.82146-1-povik+lin@cutebit.org>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Vinod Koul <vkoul@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 29. 10. 2023, at 18:00, Martin Povi=C5=A1er <povik+lin@cutebit.org> =
wrote:
>=20
> From: Hector Martin <marcan@marcan.st>
>=20
> For RX channels, REG_BUS_WIDTH seems to default to a value of 0xf00, =
and
> macOS preserves the upper bits when setting the configuration in the
> lower ones. If we reset the upper bits to 0, this causes framing =
errors
> on suspend/resume (the data stream "tears" and channels get swapped
> around). Keeping the upper bits untouched, like the macOS driver does,
> fixes this issue.
>=20
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Reviewed-by: Martin Povi=C5=A1er <povik@cutebit.org>
> Signed-off-by: Martin Povi=C5=A1er <povik@cutebit.org>
> ---

Please take up v2 instead. I slipped in the wrong email address in here,
which I don=E2=80=99t want to subscribe for kernel spam with.

=
https://lore.kernel.org/dmaengine/20231029170704.82238-1-povik+lin@cutebit=
.org/T/#u

Thanks!

Kind regards,
Martin

