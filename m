Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0AC7ADA2B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbjIYOhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjIYOhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:37:03 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1B2101;
        Mon, 25 Sep 2023 07:36:54 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 916EF1C001E; Mon, 25 Sep 2023 16:36:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1695652612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=A7Kx6EcoVfeBKi/SbwuwCQZldltNiCrHCuxYKrSTkLM=;
        b=bTgxHCrLGiy6IbyXRORlo36rCN9vZbwl0l3j/og4gJKP1+jG7UozXISxwxIFXeRVHzoFeT
        Z0lDrMBrDnppBRrH9QBhubb025oZjEU3iJ4BWvtIF3HfMJyOrliUZroTZqI9tWOcH0cpbi
        RcMPC5Yquju+aFsap1ThfO1Nfh0dsU0=
Date:   Mon, 25 Sep 2023 16:36:43 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org,
        martin_rysavy@centrum.cz, phone-devel@vger.kernel.org,
        maemo-leste@lists.dyne.org
Subject: droid4 -- weird behaviour when attempting to use usb host
Message-ID: <ZRGa+0OFNluV4T5t@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm having some fun with usb host. Good news is it works with
externally powered hub... after a while. I get some error messages
about inability to go host mode, but with enough patience it
eventually does enter host mode and I see my keyboard/mouse.

And usually in that process, one of my cpu cores disappear. top no
longer shows 2 cores, and I was wondering for a while if d4 is
single-core system. It is not, my two cores are back after reboot.

That's with 6.1.9 kernel from leste. Ideas how to debug this would be
welcome. (Do you use usb host?)

Best regards,
							Pavel
--=20
