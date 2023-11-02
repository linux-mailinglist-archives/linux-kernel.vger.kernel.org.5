Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076A57DF844
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 18:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377111AbjKBREY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 13:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjKBREX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:04:23 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C9E123;
        Thu,  2 Nov 2023 10:04:16 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A7A986000E;
        Thu,  2 Nov 2023 17:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698944654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1xhIFytvblxbmfyiIoYu3Q5FahJid0lCbHGSI24bjXI=;
        b=GfDDSzF2xzgThGYyu7Ybk/I6oJ9c4CRulDy5whgMwv106tH4H+pkskIbz+WLDzU+tXsfob
        AJbd474500WmKklcT/+V/10UbmU407r3qkRfMWb3rMXVM7LXzDB+4Qyllfa8Gk0nMfOJ5h
        oFCpizU9Z8yizjexUm+ebf/efwLsIpcTHCwo0Sh2raN5aVEwi5yrKipc2nEdWvDlPYbXcE
        8ui9YrM+02oHOxUFdgVq2BKz4jxUjpTsbETPfDMUEGOzyvxhmE+xKn9OmXs/P2CqCx+gIj
        V+D/nag8WRkyeg8Cg8jaRTq7Anyf1JgvQ6MskckZBDnKHmx9zGjNCEg/j+5fiA==
Date:   Thu, 2 Nov 2023 18:04:12 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Esteban Blanc <eblanc@baylibre.com>, a.zummo@towertech.it,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        jpanis@baylibre.com, jneanne@baylibre.com, u-kumar1@ti.com
Subject: Re: [PATCH v8] rtc: tps6594: Add driver for TPS6594 RTC
Message-ID: <202311021704127e77aa02@mail.local>
References: <20231102132616.1130960-1-eblanc@baylibre.com>
 <CAHp75VdvR0H7XVLWGqdZqSgoHprUUPQHGiyWEEaHjTgEbeinqQ@mail.gmail.com>
 <CWOGMAUT9MKY.2IBKELIOR1CF7@burritosblues>
 <CAHp75VdV5A+WpWj2eY9o_2wwPB7GTi6Eig7YyV8urdv1P3utgQ@mail.gmail.com>
 <2023110216503718884fde@mail.local>
 <CAHp75VcfKdeQeJRhyANhnwB2j-AikzNY1t_vr5=Qon1tdR6P2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VcfKdeQeJRhyANhnwB2j-AikzNY1t_vr5=Qon1tdR6P2Q@mail.gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2023 19:00:27+0200, Andy Shevchenko wrote:
> On Thu, Nov 2, 2023 at 6:50 PM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> > On 02/11/2023 18:46:05+0200, Andy Shevchenko wrote:
> > > On Thu, Nov 2, 2023 at 6:17 PM Esteban Blanc <eblanc@baylibre.com> wrote:
> > > > On Thu Nov 2, 2023 at 5:00 PM CET, Andy Shevchenko wrote:
> > > > > On Thu, Nov 2, 2023 at 3:26 PM Esteban Blanc <eblanc@baylibre.com> wrote:
> > > > >
> > > > > > Notes:
> > > > > >     This patch was picked from a series since there is no dependency between
> > > > > >     the two patches.
> > > > >
> > > > > Not sure if RTC maintainer uses the b4 tool, but as I said in previous
> > > > > email for pinctrl change, there is no need to resend. b4 has an
> > > > > ability to select patches from the series to be applied.
> > > >
> > > > Oh that's good to know, I was not aware of that.
> > > > I resent it because there was some minor nits that I fixed on both
> > > > patches.
> > >
> > > Ah, that was not reflected in the changelog...
> >
> > For the record, I'm using b4 but it was not clear which path the patches
> > would take.
> 
> You mean in the initial series? You take it by direct message-id with
> -P _. Or did I misunderstand the problem?

No I mean it was not clear whether I should take the patch or it would
get through MFD.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
