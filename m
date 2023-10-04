Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9437B8DDE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 22:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbjJDUKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 16:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjJDUKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 16:10:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C06A6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 13:09:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33F4C433CC;
        Wed,  4 Oct 2023 20:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696450199;
        bh=bQor1saGeB+PRL/MUNk1VQn208AY2/DIznHoyUEXTvM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G5kYhPFroQtnJr+8UcqoNuc4kbyXsULYUd1Q+Pi/yihOyBNXqnAHL3b3X64zzkOoT
         f45Hma7sDMmyWaFH4TWva4cOzzLQUBNh8Wrd+MoWHXi8VGXrFipttbQHNiJJVaJAp5
         xKOFXxDlVjsPJOt7d/VF9HlAjEM1nD0v01RY8x8HfHfl+hkCkWgNvUgnwofSLZPDP2
         RL5zO/z5RxiUxiOHbkhWfe9cHNedjjRxqZxTCZw2Lumx7pQcSfz2ACQGT/ShneFeT7
         5xIq3sgQUaEHtCFeLBHbeMBre4gj82DBQBp5ZgpEvYVfVUwhkm7i50yqwjpScuGlaW
         eX1ADmqhQVSaw==
Date:   Wed, 4 Oct 2023 13:09:57 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Vishvambar Panth S <vishvambarpanth.s@microchip.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        andrew@lunn.ch
Subject: Re: [PATCH net] net: microchip: lan743x : bidirectional throughuput
 improvement
Message-ID: <20231004130957.2d633d03@kernel.org>
In-Reply-To: <b1f64c44-0d1c-480e-a272-fb017e7d8673@gmail.com>
References: <20230927111623.9966-1-vishvambarpanth.s@microchip.com>
        <20231004122016.76b403f0@kernel.org>
        <b1f64c44-0d1c-480e-a272-fb017e7d8673@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Wed, 4 Oct 2023 13:02:17 -0700 Florian Fainelli wrote:
> > Nobody complained for 5 years, and it's not a regression.
> > Let's not treat this as a fix, please repost without the Fixes tag for
> > net-next. =20
>=20
> As a driver maintainer, you may want to provide some guarantees to your=20
> end users/customers that from stable version X.Y.Z the performance=20
> issues have been fixed. Performance improvements are definitively border=
=20
> line in terms of being considered as bug fixes though.

I understand that, but too often people just "feel like a device which
advertises X Mbps / Gbps should reach line rate" while no end user
cares.

Luckily stable rules are pretty clear about this (search for
"performance"):=20
https://docs.kernel.org/process/stable-kernel-rules.html

As posted it doesn't fulfill the requirements =F0=9F=A4=B7=EF=B8=8F
