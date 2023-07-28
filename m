Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352A8767045
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbjG1PNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbjG1PMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:12:53 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6260311D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 08:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690557164; x=1691161964; i=efault@gmx.de;
 bh=HFEWy9d+Gvhj42G9xWKqsN2s+LgvcRgffnojjT3T1LE=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=lgLsPjtMOzSFQ6rB9rNXtWM6AdkrM/7KffVwzak5cndqQgykzJGGI6y3AObBUDf6E88WrzW
 Bc06X8KjuwbLq8UaeHg4aiWUYbJUgQO8M5VT7Hib7ErOnB/wSpByiAmzEvHZicPVpRCheDQ+l
 AQPiD3A46AIU83RwrvlxAY26FbylVQLY710h7ZOInjSJhegv8uAP6S8f21DSBYE8mBIDxR0Wa
 kjl+1gi+Liejf6JqhzycuPFO9rHar4ighHpcHK8WIyp7+3g6g5bzBOJD4rwrgvdijg41pARKj
 U2g48UhMyBhRS1MMp5Ws0x4yBYkjY9ZEJfGBuWZpFdfSle6v0eGA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.191.217.156]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbzuH-1psXQp0Rjz-00dTAL; Fri, 28
 Jul 2023 17:12:44 +0200
Message-ID: <1620591d2201c1498f2832b32d26efd0c5cdd5cf.camel@gmx.de>
Subject: Re: arm64: perf test 26 rpi4 oops
From:   Mike Galbraith <efault@gmx.de>
To:     Will Deacon <will@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Date:   Fri, 28 Jul 2023 17:12:43 +0200
In-Reply-To: <20230728141852.GA21718@willie-the-truck>
References: <b39c62d29a431b023e98959578ba87e96af0e030.camel@gmx.de>
         <20230728141852.GA21718@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RUVDxGEIqIX6kFwtqIyZ+kXUPwOPzxW0nxRWT4GuVJaH6sOfuT4
 yOuk7rZdCwhWVXxQFZt5BDByZ+br6HyEn/H8a+RDh+sZhMHlRgw1GgBg2KAN58P+2WM2d7b
 cOR7I0hml0CBQ5vEkcvaGuHVQANkFL2F1IwSgICGmuQh2BY4x259qFIHg2YSFoDmtpGnSP+
 J7YNi9gEayXR5iUKu6J3A==
UI-OutboundReport: notjunk:1;M01:P0:XEyKx1z2D00=;wfbqOOP0c13lxWWYwCeujjJANwQ
 MU94zILDe73EWW1z12EL7yCp1Zwv5yc4jlOJkK+SA93T/r7e7I1yxxxPxkWUJPtowlt9m4HvD
 0IMiYfvEekCx2lL/3ymZMq5p82CGfE4+Nz0DkK81Nt1Ef3sAXFpKHkDgvuDucNOr6pdXrvCBM
 2aCx67Hx9uyVvpINgkU1KnbHBMMr7k85gJlzZrwDKBAL+hDV+5lvTN8POfT56+PWrW7U7fOvg
 n4Ox4jO5imGwiRf3Q2SyH5RDEZP2Z3IIdmRJyIHsTCqzlRqI9c79p6rs43OwiQdUCyOANMVuq
 mDPDqj73v1aWxr2HZfb9CETqCBTPgtp6vtPmJTjYrqIMI7u6idOSzQqbNK14rtHerkeN5QesY
 kCJFHiJTtNOzzfmFe3u4RRfEXxe3AuS5UID4gY4uFBA9H01I9nJ6qXKBsKOg2CCmA/dnvX8+Y
 2BE37vlu2s9J1uZe4niP3SGHU11ePnUZ9Gqf0cy4ih6OLIp+Dgbl25MZDHITffDizduKuJZ9m
 lcjZyOazQkxdBYC562hqpbhMLuSCUio4skUnBAMZ5kZOQgP027/STZWdoO/ZVfpkbS1PH2ejX
 YqcG1/d1UOocTZDqdWgbmuAStpekXNiukwNSDHwQ6t3mpdHPueWp1ZKMDLzCaqp6GEYd4qUx3
 +n/dicCOyKGsOl5fpXm140PxH1laC3r397ghwltxS+Un7kJzFBOV6HPkfRjvFIfijgTscATSe
 a/l1u6TUUxoZV62I9OIGQaXUWzhE6QCVYHxj1/GSfyQhxyKZTYMjgmK56SVrFAK6fKPw/lZHT
 XMYy8uYyw2WMWjtIPT7vzIoknrB0ch4+iih6gICy3p1vzxHc/mGoJoz53VTDw0qKL1nhbqjUz
 VAelLEowGgSb1AV0C9DRE6VQ3psNyalO1KZsFfrq8sbuuZSwaZ9WPetrwXqsUzXnZ2Wpk2OGp
 5ydLRA==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-07-28 at 15:18 +0100, Will Deacon wrote:
> Hi Mike,
>
> On Fri, Jul 28, 2023 at 06:06:33AM +0200, Mike Galbraith wrote:
> > perf test 26 in virgin master inspired the below.
>
> Ah, so this is the 6.5-based panic message below?

Yeah, that was virgin master.

The oops arrived with 2e1c0170771e, _but_ it turns out to be somehow
config related.  The obese distro config rolled forward does not oops,
much leaner local config does, despite cute little rpi4 working just
fine.. for everything _except_ 'perf test 26' :)

Hohum, send report to round file.  I'm looking for the option out of
curiosity, but it's not gonna be a long search.

	-Mike
