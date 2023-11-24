Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F43F7F7031
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345319AbjKXJl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345278AbjKXJlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:41:47 -0500
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F8810F8;
        Fri, 24 Nov 2023 01:41:48 -0800 (PST)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 99F5112000C;
        Fri, 24 Nov 2023 12:41:46 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 99F5112000C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1700818906;
        bh=ZjjszLeVnBPwoAj6f6uQYU1y6GX4z6DbNr2+xOZZZGo=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=UhUTZuL+2i7sGTzkhnmT9eCZmSAravoRcnQYqakh1ENk5N4Tb8EeQ/AQEQGdSznS9
         F/pTPIVdNYdZY7zYTwdDd5n9jGOhKNdYVpx+8AQurqsvvvbaWwckaSIH3Ys+tqBoap
         EXDmoQl0uty8aT9u4EPSlf6x21aTWiZLxhrIyLkWOzSDhEHV6PtJdGG2sehiV0yXy/
         VpF7QTGgiGt9nWu81PJc6Jr68W35Gn8ib7r+26wQPLA0i19Mh+Gl8qHZ8rUx0wo3Cd
         ITql7ePcZD+lhSjQ9F5N9FWbmCxggPwcpcmSaYF2fm7CAbOOw5w2kMtCJnjqnFvkT0
         jpM3wBawvCoHQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Fri, 24 Nov 2023 12:41:46 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 24 Nov
 2023 12:41:46 +0300
Date:   Fri, 24 Nov 2023 12:41:46 +0300
From:   Dmitry Rokosov <ddrokosov@salutedevices.com>
To:     Lee Jones <lee@kernel.org>
CC:     <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andy.shevchenko@gmail.com>, <kernel@sberdevices.ru>,
        <rockosov@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        George Stark <gnstark@salutedevices.com>
Subject: Re: [PATCH v4 04/11] leds: aw200xx: calculate dts property
 display_rows in the driver
Message-ID: <20231124094146.qsgmmbwulemjikpg@CAB-WSD-L081021>
References: <20231121202835.28152-1-ddrokosov@salutedevices.com>
 <20231121202835.28152-5-ddrokosov@salutedevices.com>
 <20231123163252.GF1354538@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231123163252.GF1354538@google.com>
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
X-KSMG-AntiSpam-Info: LuaCore: 4 0.3.4 720d3c21819df9b72e78f051e300e232316d302a, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2, FromAlignment: s, {Track_Chinese_Simplified, text}, ApMailHostAddress: 100.64.160.123
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

On Thu, Nov 23, 2023 at 04:32:52PM +0000, Lee Jones wrote:
> On Tue, 21 Nov 2023, Dmitry Rokosov wrote:
> 
> > From: George Stark <gnstark@salutedevices.com>
> > 
> > Get rid of device tree property "awinic,display-rows". The property
> > value actually means number of current switches and depends on how leds
> 
> Nit: LEDs
> 
> > are connected to the device. It should be calculated manually by max
> > used led number. In the same way it is computed automatically now.
> 
> As above - I won't mention this again.
> 
> > Max used led is taken from led definition subnodes.
> > 
> > Signed-off-by: George Stark <gnstark@salutedevices.com>
> > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> > ---
> >  drivers/leds/leds-aw200xx.c | 39 +++++++++++++++++++++++++------------
> >  1 file changed, 27 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/leds/leds-aw200xx.c b/drivers/leds/leds-aw200xx.c
> > index 7762b3a132ac..4bce5e7381c0 100644
> > --- a/drivers/leds/leds-aw200xx.c
> > +++ b/drivers/leds/leds-aw200xx.c
> > @@ -379,6 +379,30 @@ static void aw200xx_disable(const struct aw200xx *const chip)
> >  	return gpiod_set_value_cansleep(chip->hwen, 0);
> >  }
> >  
> > +static bool aw200xx_probe_get_display_rows(struct device *dev, struct aw200xx *chip)
> > +{
> > +	struct fwnode_handle *child;
> > +	u32 max_source = 0;
> > +
> > +	device_for_each_child_node(dev, child) {
> > +		u32 source;
> > +		int ret;
> > +
> > +		ret = fwnode_property_read_u32(child, "reg", &source);
> > +		if (ret || source >= chip->cdef->channels)
> 
> Shouldn't the second clause fail instantly?
> 

We already have such logic in the aw200xx_probe_fw() function, which
skips the LED node with the wrong reg value too. Furthermore, we have
strict reg constraints in the dt-bindings parts (in the current patch
series), so we assume that the DT developer will not create an LED with
the wrong reg value.

> > +			continue;
> > +
> > +		max_source = max(max_source, source);
> > +	}
> > +
> > +	if (!max_source)
> 
> Since max_source is an integer, please use an '== 0' comparison.
> 

Okay

> > +		return false;
> > +
> > +	chip->display_rows = max_source / chip->cdef->display_size_columns + 1;
> > +
> > +	return true;
> > +}
> > +
> >  static int aw200xx_probe_fw(struct device *dev, struct aw200xx *chip)
> >  {
> >  	struct fwnode_handle *child;
> > @@ -386,18 +410,9 @@ static int aw200xx_probe_fw(struct device *dev, struct aw200xx *chip)
> >  	int ret;
> >  	int i;
> >  
> > -	ret = device_property_read_u32(dev, "awinic,display-rows",
> > -				       &chip->display_rows);
> > -	if (ret)
> > -		return dev_err_probe(dev, ret,
> > -				     "Failed to read 'display-rows' property\n");
> > -
> > -	if (!chip->display_rows ||
> > -	    chip->display_rows > chip->cdef->display_size_rows_max) {
> > -		return dev_err_probe(dev, ret,
> > -				     "Invalid leds display size %u\n",
> > -				     chip->display_rows);
> > -	}
> > +	if (!aw200xx_probe_get_display_rows(dev, chip))
> 
> Function calls in side if() statements in general is rough.
> 
> Please break it out and use 'ret' as we usually do.
> 
> > +		return dev_err_probe(dev, -EINVAL,
> 
> Make this the return value from aw200xx_probe_get_display_rows() and use
> 'ret' instead.
> 

No problem, I'll prepare a new version.

> > +				     "No valid led definitions found\n");
> >  
> >  	current_max = aw200xx_imax_from_global(chip, AW200XX_IMAX_MAX_uA);
> >  	current_min = aw200xx_imax_from_global(chip, AW200XX_IMAX_MIN_uA);
> > -- 
> > 2.36.0
> > 
> 
> -- 
> Lee Jones [李琼斯]

-- 
Thank you,
Dmitry
