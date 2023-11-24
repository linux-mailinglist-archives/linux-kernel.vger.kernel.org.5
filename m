Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7E37F700B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345158AbjKXJhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjKXJh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:37:28 -0500
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0C5130;
        Fri, 24 Nov 2023 01:37:32 -0800 (PST)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 2D6EC100004;
        Fri, 24 Nov 2023 12:37:29 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 2D6EC100004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1700818649;
        bh=dtiyxtmPH0TSIzM6r3/YxZhPNjL7NhlWfSbuYozZXDg=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=knUtII8402sq5S9M2saPnvqSLQWFwuniAHU6Qb2h4yy5xKY8YSQ3zgf5pjqg1b4zq
         WE7JSQOf7Pl6/GR8Ro1tE8EQrHOfDm8jA71/ZrN8kSwoxXbtdJOmAVy5sm0g7oLmBF
         5OjKj0VpWMEzBSaCX5dDSKlClr9e+yE30stS54XS3K2gYg2CJ13+S76wl37YhOzIKY
         A4CxfmVDcxXu5NGAofjvxkXccYvCp6QCbsbBhBmQquj8hxfdtizXadFlQ7H65qA/np
         BL0ZG54bB30vFecbi5mypxCjFRSoL4KiSffnwPcWn74vBAQcLwz90kkjd6HsLAMC5h
         OEMDGpHneAa3g==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Fri, 24 Nov 2023 12:37:28 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 24 Nov
 2023 12:37:28 +0300
Date:   Fri, 24 Nov 2023 12:37:22 +0300
From:   Dmitry Rokosov <ddrokosov@salutedevices.com>
To:     Lee Jones <lee@kernel.org>
CC:     <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andy.shevchenko@gmail.com>, <kernel@sberdevices.ru>,
        <rockosov@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        George Stark <gnstark@salutedevices.com>
Subject: Re: [PATCH v4 06/11] leds: aw200xx: add delay after software reset
Message-ID: <20231124093722.picykrqaewxlxa7h@CAB-WSD-L081021>
References: <20231121202835.28152-1-ddrokosov@salutedevices.com>
 <20231121202835.28152-7-ddrokosov@salutedevices.com>
 <20231123163816.GG1354538@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231123163816.GG1354538@google.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181570 [Nov 24 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 4 0.3.4 720d3c21819df9b72e78f051e300e232316d302a, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2, FromAlignment: s, {Track_Chinese_Simplified, text}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/24 06:01:00 #22520095
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Lee,

Thank you for the detailed review!

Please find my answer below.

On Thu, Nov 23, 2023 at 04:38:16PM +0000, Lee Jones wrote:
> On Tue, 21 Nov 2023, Dmitry Rokosov wrote:
> 
> > From: George Stark <gnstark@salutedevices.com>
> > 
> > According to datasheets of aw200xx devices software reset takes at
> > least 1ms so add delay after reset before issuing commands to device.
> 
> Are you able to use an auto-correct tool to sharpen the grammar a little?
> 
> > Signed-off-by: George Stark <gnstark@salutedevices.com>
> > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > ---
> >  drivers/leds/leds-aw200xx.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/leds/leds-aw200xx.c b/drivers/leds/leds-aw200xx.c
> > index 4bce5e7381c0..bb17e48b3e2a 100644
> > --- a/drivers/leds/leds-aw200xx.c
> > +++ b/drivers/leds/leds-aw200xx.c
> > @@ -321,6 +321,9 @@ static int aw200xx_chip_reset(const struct aw200xx *const chip)
> >  	if (ret)
> >  		return ret;
> >  
> > +	/* according to datasheet software reset takes at least 1ms */
> 
> Please start sentences with an uppercase char.
> 
> "According to the datasheet, software resets take at least 1ms"
>               ^                            ^     ^
> 

Here it's only one 'software reset' mentioned.

> > +	fsleep(1000);
> > +
> >  	regcache_mark_dirty(chip->regmap);
> >  	return regmap_write(chip->regmap, AW200XX_REG_FCD, AW200XX_FCD_CLEAR);
> >  }
> > -- 
> > 2.36.0
> > 
> 
> -- 
> Lee Jones [李琼斯]

-- 
Thank you,
Dmitry
