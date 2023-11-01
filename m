Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA567DE67C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 20:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345782AbjKAThv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 15:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345757AbjKAThu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 15:37:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E70F9F;
        Wed,  1 Nov 2023 12:37:44 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AE7C81F85D;
        Wed,  1 Nov 2023 19:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698867461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Lkcb7+DOuEYU8z+OLfth9u5epDmfR3nilYe3WjVLwI=;
        b=eijjj50MaPUvP6KhdzokYQ2gHO7MR1EbSua7poiO9s+RWZeCs2gonhfIIx8c0+ISc/na5I
        2kP4Y/Qcy9UUMsNARxU+7YdhLWG6Ay21b7vdRXzS5LSD1Si0F4qoQVGj+KBXIht9a+TvY8
        QHV9/dF5w/enJxwS4fUUGmASH+/50hk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698867461;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Lkcb7+DOuEYU8z+OLfth9u5epDmfR3nilYe3WjVLwI=;
        b=0CDu8WgpjNAi2VOjx3MUnrhZddv9lStJJqpmq0fEWt+CsuMQgENEVYeR3cPco2OAosxe+i
        s5eXpDrTJUbv5bBA==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2A2612C2D2;
        Wed,  1 Nov 2023 19:37:41 +0000 (UTC)
Date:   Wed, 1 Nov 2023 20:37:40 +0100 (CET)
From:   Jiri Kosina <jkosina@suse.cz>
To:     David Revoy <davidrevoy@protonmail.com>
cc:     "jason.gerecke@wacom.com" <jason.gerecke@wacom.com>,
        "jose.exposito89@gmail.com" <jose.exposito89@gmail.com>,
        "ilya.ostapyshyn@gmail.com" <ilya.ostapyshyn@gmail.com>,
        Nils Fuhler <nils@nilsfuhler.de>,
        Ping Cheng <ping.cheng@wacom.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: Requesting your attention and expertise regarding a Tablet/Kernel
 issue
In-Reply-To: <kRKTNDYigUSblpNgSuZ2H4dX03Of1yD4j_L9GgbyKXcDqZ67yh5HOQfcd7_83U3jZuQzxpKT3L6FXcRkkZIGdl_-PQF14oIB0QmRSfvpc2k=@protonmail.com>
Message-ID: <nycvar.YFH.7.76.2311012033290.29220@cbobk.fhfr.pm>
References: <kRKTNDYigUSblpNgSuZ2H4dX03Of1yD4j_L9GgbyKXcDqZ67yh5HOQfcd7_83U3jZuQzxpKT3L6FXcRkkZIGdl_-PQF14oIB0QmRSfvpc2k=@protonmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2023, David Revoy wrote:

> Hi Jason Gerecke, José Expósito, Jiri Kosina and Illia Ostapyshyn,
> 
> I am emailing to draw your attention and expertise to a problem I had 
> earlier this week with my Xp-Pen Artist 24 Pro display tablet under 
> Fedora Linux 38 KDE after a kernel update.
> 
> The second button on my stylus changed from a right-click (which I could 
> customise with xsetwacom or any GUI like kcm-tablet) to a button that 
> feels 'hardcoded' and now switches the whole device to an eraser mode. 
> This makes my main tool unusable.
> 
> I don't have the skills to write a proper kernel bug report, workaround 
> or even identify the exact source of the issue. I have written a blog 
> post about this with more details here: 
> https://www.davidrevoy.com/article995/how-a-kernel-update-broke-my-stylus-need-help 
> , contacting you was something suggested by the comments.
> 
> Thank you very much if you can help me.

CCing a couple more people involved both in 276e14e6c3 and 87562fcd1342, 
and mailinglists.

This is almost certainly the behavior introduced by 276e14e6c3, where 
previously the button was mapped to BTN_TOUCH, but now it's mapped to 
BTN_TOOL_RUBBER, causing user-visible change in behavior.

-- 
Jiri Kosina
SUSE Labs
