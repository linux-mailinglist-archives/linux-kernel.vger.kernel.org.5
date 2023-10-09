Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78307BDE9A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376336AbjJINVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346585AbjJINVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:21:00 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6BA99;
        Mon,  9 Oct 2023 06:20:58 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id B578310000B;
        Mon,  9 Oct 2023 16:20:56 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru B578310000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1696857656;
        bh=zNcGdC0Xpihdq0tqVDbNQ0hhf0XjHMwDMYk3I79sqXU=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=TuDyjCrRExBXVibRAt73EMcHiMjfL1dxzHzOSeR0NbEGbyNg82tMh8NScFywscXiH
         JZA5nkFT0TxKA27UqCNffVyiQBFeIR6z8LyjkpEG9wZ9bKeLYYVuuNeAS5byyIp9f/
         +bVATwX/5l2liDTiZwD8Baj5jNgHuur6JxbJpRiyEmBAzGlpgSZ+EiNWx+yLwg4ItY
         etbQtfDNgvUXGNt9bz72qv/7V1f9k9dOkOXKR1SIzL9ViMXDaHQTHaJELxrO9r3oD5
         s1/QqxJCqBhPffRFRa+FXmJYcdAOC8o4K7wk8wPezCgeQvVTIjhFaAXM29LWgzIgPg
         MDLVg5qKuTjeg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Mon,  9 Oct 2023 16:20:55 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 9 Oct
 2023 16:20:55 +0300
Date:   Mon, 9 Oct 2023 16:20:55 +0300
From:   Dmitry Rokosov <ddrokosov@salutedevices.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     <lee@kernel.org>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>,
        George Stark <gnstark@salutedevices.com>
Subject: Re: [PATCH v1 05/11] leds: aw200xx: calculate dts property
 display_rows in driver
Message-ID: <20231009132055.kg2gbbznr63plvm4@CAB-WSD-L081021>
References: <20231006160437.15627-1-ddrokosov@salutedevices.com>
 <20231006160437.15627-6-ddrokosov@salutedevices.com>
 <CAHp75VeWwzg1spSvQ1tNmC7zVN1FLOjcpRGZsoL-49Di02pn0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VeWwzg1spSvQ1tNmC7zVN1FLOjcpRGZsoL-49Di02pn0g@mail.gmail.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180475 [Oct 09 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 536 536 1ae19c7800f69da91432b5e67ed4a00b9ade0d03, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/10/08 23:24:00 #22096719
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 08:59:46PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 6, 2023 at 7:05 PM Dmitry Rokosov
> <ddrokosov@salutedevices.com> wrote:
> >
> > From: George Stark <gnstark@salutedevices.com>
> >
> > Get rid of device tree property "awinic,display-rows" and calculate it
> > in driver using led definition nodes. display-row actually means number
> > of current switches and depends on how leds are connected to the device.
> 
> So, how do we know that there will be no regressions on the systems
> where this property is used in production?

In the production boards, developers should set up the display-rows
correctly; otherwise, the AW200XX LED controller will not function
properly. In the new implementation, we calculate display-rows
automatically, and I assume that the value will remain unchanged.

> > +               if (max_source < source)
> > +                       max_source = source;
> 
> max()  (will need minmax.h)?

Correct, I will fix it in the v2.

-- 
Thank you,
Dmitry
