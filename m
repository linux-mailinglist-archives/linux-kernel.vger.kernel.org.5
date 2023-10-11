Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AF37C4B0D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 08:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344583AbjJKG7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 02:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344499AbjJKG66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 02:58:58 -0400
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DCD90;
        Tue, 10 Oct 2023 23:58:56 -0700 (PDT)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=96621b7d4a=fe@dev.tdt.de>)
        id 1qqTB4-00AC05-8G; Wed, 11 Oct 2023 08:58:42 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1qqTB3-009Qf4-63; Wed, 11 Oct 2023 08:58:41 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id CBC472400B1;
        Wed, 11 Oct 2023 08:58:40 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 271D1240082;
        Wed, 11 Oct 2023 08:58:40 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id 7E37B334C9;
        Wed, 11 Oct 2023 08:58:39 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 11 Oct 2023 08:58:39 +0200
From:   Florian Eckert <fe@dev.tdt.de>
To:     Lee Jones <lee@kernel.org>
Cc:     Eckert.Florian@googlemail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pavel@ucw.cz, kabel@kernel.org,
        u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-leds@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 3/4] trigger: ledtrig-tty: move variable definition to
 the top
In-Reply-To: <20231002140559.GB8453@google.com>
References: <20230928132632.200263-1-fe@dev.tdt.de>
 <20230928132632.200263-4-fe@dev.tdt.de> <20231002140559.GB8453@google.com>
Message-ID: <66ca9e2231629a72e098e1b17736ca34@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-purgate-type: clean
X-purgate: clean
X-purgate-ID: 151534::1697007521-520A685C-E874BB0D/0/0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Lee,

I only got reviews for the fixes and preparations for commits that 
change the
tty subsystem, but no reaction from the maintainer of the feature I want 
to
add to ledtrig-tty for v1 and v2 patchset.

How should I proceed? Send a v3 with the the requested changes.

[Patch v2 1/4]: 
https://lore.kernel.org/linux-leds/20230928132632.200263-1-fe@dev.tdt.de/T/#m913d3822465f35b54dfa24b1dfe4d50e61352980
Change got a 'Reviewed-by: Jiri Slaby <jirislaby@kernel.org>'.
Will add this to an upcoming v3 again.

[Patch v2 2/4] : 
https://lore.kernel.org/linux-leds/20230928132632.200263-1-fe@dev.tdt.de/T/#m7ee7618894a66fd3c89bed488a2394265a3f8df1
I missed to add the robot error message to the commit message and also 
missed
to add the the following 'Reported-by: kernel test robot 
<lkp@intel.com>' and
'Closes: 
https://lore.kernel.org/oe-kbuild-all/202309270440.IJB24Xap-lkp@intel.com/'
to the commit message. Will add this to an upcoming v3.

And do not wait for the review of the following patches.
https://lore.kernel.org/linux-leds/20230928132632.200263-1-fe@dev.tdt.de/T/#mc0ecb912fa0e59015ad0a9b4cb491ae9f18c1ea9
https://lore.kernel.org/linux-leds/20230928132632.200263-1-fe@dev.tdt.de/T/#mba36217323c386ecd900e188bbdf6276c3c96c91

---

Florian
