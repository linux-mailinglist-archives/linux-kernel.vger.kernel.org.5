Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202C979D838
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237030AbjILR77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjILR76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:59:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D12C1;
        Tue, 12 Sep 2023 10:59:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CEF8C433C7;
        Tue, 12 Sep 2023 17:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694541594;
        bh=gTj8iF9KcqBW/RU03eG4Ux7aTjD77gzubI/yf7LAsOs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Oe3pEuLfrQJFi8kxdOsYhLw3OeQBwQaBfxW8wVmAm04NL0uIG6QLagTHPUFeQ6QR6
         lWiOD84U1mAABlv+2zibX1gPqtR4NsZQAKl18jW6WmaWK/ras703QgQwGyVqeCj22p
         KT82QtMdP41bDZbTndElPcRGb4jSmhtIdyNCStyILXRnQZongWpKc6XjVBnxJgwB89
         3M8mzQle8bS2al/m1yX6o2amKOliQuts3R/Q7b+y0VlAZ/lHGhBEPvr4ZACcv82VNK
         E2PoepWD0c8RLfWJGSu3Jnui0JVAMa5L6zzYNWGi7NsLtalwzLPnqbU4PK8KrCKn++
         xBEE1TGetT+3Q==
Message-ID: <f72f0a599fa5ca03321454fd14dd8856.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAPp5cGSbdhLb2c5hQrP-O-+j63haXs0c6=JCoFxnAzF1mhspuA@mail.gmail.com>
References: <20230822134849.3352329-1-alessandro.carminati@gmail.com> <CAPp5cGTshQJ3aLeLqv=CbaVeg9GnK_k9nsoaWrBKs1dcXzNZow@mail.gmail.com> <fc8023b435f78e02c96fecbe8e7599ee.sboyd@kernel.org> <CAPp5cGQ0Wp4my93tEm9-Huc6R+22zCj91mNJsPpGTFoo49=mcQ@mail.gmail.com> <fde1b20074cf5c0e0bc1944959486150.sboyd@kernel.org> <CAPp5cGSbdhLb2c5hQrP-O-+j63haXs0c6=JCoFxnAzF1mhspuA@mail.gmail.com>
Subject: Re: [PATCH] Sanitize possible_parent_show to Handle Return Value of of_clk_get_parent_name
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Philip Daly <pdaly@redhat.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Alessandro Carminati <alessandro.carminati@gmail.com>
Date:   Tue, 12 Sep 2023 10:59:51 -0700
User-Agent: alot/0.10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alessandro Carminati (2023-09-12 10:05:19)
> Il giorno ven 8 set 2023 alle ore 23:25 Stephen Boyd
> <sboyd@kernel.org> ha scritto:
> >
> > Is nothing actually wrong? And this is a speculative patch?
>=20
> In the current state, Linux can crash, so I would say that there's someth=
ing
> wrong.
> I submitted this patch in response to a specific bug report that caused a
> kernel crash during testing.

Where is the bug report? On some public tracker? Can you link to it?

>=20
> >
> > All other arms of this conditional statement check the validity of the
> > pointer before printing the string. And when the parent isn't known we
> > print "(missing)", so it looks like we should do that instead. How about
> > this patch?
>=20
> Indeed, your patch appears to provide a more verbose coding and accurate
> message, which is valuable for troubleshooting.
> So yeah, for what it is worth, I think it is good as well.

Cool, can you send it after testing it out?
