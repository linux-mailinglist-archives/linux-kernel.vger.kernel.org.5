Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612207BDDFB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376884AbjJINOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376864AbjJINOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:14:33 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D68CA;
        Mon,  9 Oct 2023 06:14:30 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 6F0D710000B;
        Mon,  9 Oct 2023 16:14:28 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6F0D710000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1696857268;
        bh=z5iRO3RNusoCOixRJJnEOCG2jfwEP64vxRjriXO4eWU=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=hu9Bqq5nAk+Vy0m7p+YaT7jRtggLgIbhblLIIYUfUdhK/pC4eERoAiRDaFdwgebwS
         y9EMhyUvxC07FULOxt480KcRhqNKqEAp1XRLcnUM9k+l5pd8ME7wnNJq5qk3siUqz2
         5QLXolCuJB3G/Af/DxBUb3Xbn7wJl+UlAO84n4qVyrPbB7rAnxo7tkF3L2UOFFqZUm
         m3OncegZE0zD5mPFOUUC10S6F3nqlQhVm7GseKiNr5bNCughUuuVviutJrhLcZUms2
         KaxN98vnDa3eX/qiu7KBqzE5EijQhW6WQQp5B2rHy20p2AntHE0ZAbflUkqF6NyP44
         Ad5bqlORmxpTQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Mon,  9 Oct 2023 16:14:28 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 9 Oct
 2023 16:14:27 +0300
Date:   Mon, 9 Oct 2023 16:14:27 +0300
From:   Dmitry Rokosov <ddrokosov@salutedevices.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     <lee@kernel.org>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>,
        George Stark <gnstark@salutedevices.com>
Subject: Re: [PATCH v1 07/11] leds: aw200xx: add delay after software reset
Message-ID: <20231009131427.vdhcoia2zuztpl5d@CAB-WSD-L081021>
References: <20231006160437.15627-1-ddrokosov@salutedevices.com>
 <20231006160437.15627-8-ddrokosov@salutedevices.com>
 <CAHp75VdkBR5yNd-U_v_4fv2pHHwzKBg6ajnZgjw=xb8kT+y7UA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdkBR5yNd-U_v_4fv2pHHwzKBg6ajnZgjw=xb8kT+y7UA@mail.gmail.com>
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
X-KSMG-AntiSpam-Info: LuaCore: 536 536 1ae19c7800f69da91432b5e67ed4a00b9ade0d03, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
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

On Fri, Oct 06, 2023 at 09:01:39PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 6, 2023 at 7:05 PM Dmitry Rokosov
> <ddrokosov@salutedevices.com> wrote:
> >
> > From: George Stark <gnstark@salutedevices.com>
> >
> > According to datasheets of aw200xx devices software reset takes at
> > least 1 ms so add delay after reset before issuing commands to device.
> 
> > +       /* according to datasheet software reset takes at least 1ms */
> 
> Please, be consistent in all patches in all commit messages and code
> comments on how you supply physical units (w/ space or w/o, take also
> into consideration traditional scientific practices).
> 
> > +       usleep_range(1000, 2000);
> 
> fsleep() ?

Good catch! Thank you for pointing!

-- 
Thank you,
Dmitry
