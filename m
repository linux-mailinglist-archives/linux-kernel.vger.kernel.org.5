Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87C87F9ED0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 12:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbjK0Llf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 06:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjK0Lle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 06:41:34 -0500
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5916AB8;
        Mon, 27 Nov 2023 03:41:40 -0800 (PST)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id E182012001E;
        Mon, 27 Nov 2023 14:41:38 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru E182012001E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1701085298;
        bh=k9sXRlxKX0Gfpxy2Hej1U/l4OVoqNKeGfoA0hcSApV0=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=o4emJLIuoBD4DcoBOF1FevkO4JyAUmJdgCkNStovRPC4hJQHgVkm6PcFvnx6B1PkE
         FUz78b6Amq886+YsRXk5TDUqk4/bXIJI/MkUarSusMOkRVEzQp5egtE0Q2qzgSnpvI
         YVzs8Yq1bpdvrI2Ug7TjRZ4cqE2KxUP1o7Dj7wj5pOMrdBbIVWPB33RRB2er8Lh76o
         BIJcVtVewxxEMPAhqSY9ZEnLqUUeFcS3Ev4pNTDzxuvg4Eeta3PRs4mwpUPqcYXwgT
         GGnlY3lOQ7DeocAro1InW0zOp9CZz8A647XTKACdks/FN0uVZ5/CLcmvXfv31mN8ts
         uSyBR/TxeCrgw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Mon, 27 Nov 2023 14:41:38 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 27 Nov
 2023 14:41:38 +0300
Date:   Mon, 27 Nov 2023 14:41:38 +0300
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
Message-ID: <20231127114138.27reupes7w47txfk@CAB-WSD-L081021>
References: <20231121202835.28152-1-ddrokosov@salutedevices.com>
 <20231121202835.28152-5-ddrokosov@salutedevices.com>
 <20231123163252.GF1354538@google.com>
 <20231124094146.qsgmmbwulemjikpg@CAB-WSD-L081021>
 <20231127085755.GE1470173@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231127085755.GE1470173@google.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181606 [Nov 27 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 4 0.3.4 720d3c21819df9b72e78f051e300e232316d302a, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/27 09:57:00 #22553179
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lee,

Thank you for the quick reply!

On Mon, Nov 27, 2023 at 08:57:55AM +0000, Lee Jones wrote:
> On Fri, 24 Nov 2023, Dmitry Rokosov wrote:
> 
> > On Thu, Nov 23, 2023 at 04:32:52PM +0000, Lee Jones wrote:
> > > On Tue, 21 Nov 2023, Dmitry Rokosov wrote:
> > > 
> > > > From: George Stark <gnstark@salutedevices.com>
> > > > 
> > > > Get rid of device tree property "awinic,display-rows". The property
> > > > value actually means number of current switches and depends on how leds
> > > 
> > > Nit: LEDs
> > > 
> > > > are connected to the device. It should be calculated manually by max
> > > > used led number. In the same way it is computed automatically now.
> > > 
> > > As above - I won't mention this again.
> > > 
> > > > Max used led is taken from led definition subnodes.
> > > > 
> > > > Signed-off-by: George Stark <gnstark@salutedevices.com>
> > > > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> > > > ---
> > > >  drivers/leds/leds-aw200xx.c | 39 +++++++++++++++++++++++++------------
> > > >  1 file changed, 27 insertions(+), 12 deletions(-)
> > > > 
> > > > diff --git a/drivers/leds/leds-aw200xx.c b/drivers/leds/leds-aw200xx.c
> > > > index 7762b3a132ac..4bce5e7381c0 100644
> > > > --- a/drivers/leds/leds-aw200xx.c
> > > > +++ b/drivers/leds/leds-aw200xx.c
> > > > @@ -379,6 +379,30 @@ static void aw200xx_disable(const struct aw200xx *const chip)
> > > >  	return gpiod_set_value_cansleep(chip->hwen, 0);
> > > >  }
> > > >  
> > > > +static bool aw200xx_probe_get_display_rows(struct device *dev, struct aw200xx *chip)
> > > > +{
> > > > +	struct fwnode_handle *child;
> > > > +	u32 max_source = 0;
> > > > +
> > > > +	device_for_each_child_node(dev, child) {
> > > > +		u32 source;
> > > > +		int ret;
> > > > +
> > > > +		ret = fwnode_property_read_u32(child, "reg", &source);
> > > > +		if (ret || source >= chip->cdef->channels)
> > > 
> > > Shouldn't the second clause fail instantly?
> > > 
> > 
> > We already have such logic in the aw200xx_probe_fw() function, which
> > skips the LED node with the wrong reg value too. Furthermore, we have
> > strict reg constraints in the dt-bindings parts (in the current patch
> > series), so we assume that the DT developer will not create an LED with
> > the wrong reg value.
> 
> Why is it being checked again then?

Hmmm, aw200xx_probe_get_display_rows() executes before the old
implementation... So we need to check it again. Do you think it should
be reworked? I've already sent a new patchset. Could you please take a
look at the other fixes?

-- 
Thank you,
Dmitry
