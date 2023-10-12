Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0927C7327
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379176AbjJLQgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235760AbjJLQgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:36:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB17DD;
        Thu, 12 Oct 2023 09:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=FSonfJ43zgcuW47KrZQgDGNzqMRjSofTrzRRTIZpHxw=; b=AcK5zXeWq6cVOul5gredeXoI3t
        7pceXZIXjt6v//yo13Ykd6hmIKqGaVf8Euj9mIAxAX+gs1j8yYwly9Fqt8jn2G3uAOFZXJGkV5PZD
        DmYOXr712vrJ2F7eIB3L2S1ryBex2vA8uGFzSMWZ0JpEeqrhZJ39ktHwJDgsCNZbK77YUWJt02jcy
        tubb6Lb7EKT/fXiREytmIdkjUpIRL1yS9EOP3iX14D5Ab0pDzhNm1nWl2hhavT8iHjI4XIHOb3SMc
        9V2c4zfH8VPG4L9AnDrfUIeiW/ucau1GS2+LnOkzvSucMCLiciR2vPwmNeCZpYxDFimKbmhQS1MvG
        E98Cg9pw==;
Received: from 173.red-88-11-240.dynamicip.rima-tde.net ([88.11.240.173] helo=[192.168.100.242])
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qqyfP-000KOI-5s; Thu, 12 Oct 2023 16:36:07 +0000
Message-ID: <39719eae-f166-4059-a70d-c6b74ecd46e2@infradead.org>
Date:   Thu, 12 Oct 2023 18:36:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [RFC] wireless: move obsolete drivers to staging
To:     Johannes Berg <johannes@sipsolutions.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kalle Valo <kvalo@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Pavel Machek <pavel@ucw.cz>,
        "David S . Miller" <davem@davemloft.net>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20231010155444.858483-1-arnd@kernel.org>
 <2023101051-unmasked-cleaver-79b3@gregkh> <87y1g94szz.fsf@kernel.org>
 <2023101139-pyromania-game-2237@gregkh> <87r0m1fwg9.fsf@kernel.org>
 <20231011080955.1beeb010@kernel.org> <87sf6g2hc8.fsf@kernel.org>
 <63e57ef8-c9f2-489a-8df8-51dcffd437c6@app.fastmail.com>
 <b1c87f71abef5aba6b39893a417466bf9f65c2d5.camel@sipsolutions.net>
 <CAMuHMdX3F9rvD3Fzbc1dwm7Vm73VW1x5ETbxkk-jJm3Bpr5i+A@mail.gmail.com>
 <d336126d58e12e8e67078c8142a524c667cc5639.camel@sipsolutions.net>
Content-Language: en-US
From:   Geoff Levand <geoff@infradead.org>
In-Reply-To: <d336126d58e12e8e67078c8142a524c667cc5639.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/23 17:41, Johannes Berg wrote:
> But seriously - is it worth to try to keep a wireless driver for it if
> we don't even know anyone using a PS3 at all?

There is still a considerable user base for the PS3, so we
must keep the ps3-gelic-wireless driver.

-Geoff

