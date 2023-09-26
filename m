Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0559C7AE67E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 09:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjIZHOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 03:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjIZHO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 03:14:27 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97FC6DE;
        Tue, 26 Sep 2023 00:14:17 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 0427D80A3;
        Tue, 26 Sep 2023 07:14:17 +0000 (UTC)
Date:   Tue, 26 Sep 2023 10:14:15 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org, martin_rysavy@centrum.cz,
        phone-devel@vger.kernel.org, maemo-leste@lists.dyne.org
Subject: Re: droid4 -- weird behaviour when attempting to use usb host
Message-ID: <20230926071415.GW5285@atomide.com>
References: <ZRGa+0OFNluV4T5t@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRGa+0OFNluV4T5t@localhost>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [230925 14:36]:
> Hi!
> 
> I'm having some fun with usb host. Good news is it works with
> externally powered hub... after a while. I get some error messages
> about inability to go host mode, but with enough patience it
> eventually does enter host mode and I see my keyboard/mouse.
> 
> And usually in that process, one of my cpu cores disappear. top no
> longer shows 2 cores, and I was wondering for a while if d4 is
> single-core system. It is not, my two cores are back after reboot.
> 
> That's with 6.1.9 kernel from leste. Ideas how to debug this would be
> welcome. (Do you use usb host?)

You are using a "proper" non-standard usb micro-b cable that grounds
the id pin, right?

If not, try with one of those as it allows the hardware to do what it's
supposed to do.

And presumably you don't have a hacked usb hub that feeds back the
vbus to your phone, right?

If you have, that should not be used as the pmic can feed vbus.

Regards,

Tony

