Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41107BDD56
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376763AbjJINJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376748AbjJINJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:09:27 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90119E;
        Mon,  9 Oct 2023 06:09:24 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 1CBC8120005;
        Mon,  9 Oct 2023 16:09:21 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 1CBC8120005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1696856961;
        bh=fJueb/I454tOqgUy+mqOFFsn6IdMT0sYitu6ljAKTBs=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=j2PsSXaTU7/xQBImFRZFRkiXL3U8tXLfP5hSgTxZd0R6ipksW6SlwiwzRSuoQ8BF9
         qrtUdcnmkM64evnkHYhePoALkJ5OSUqf5su/rofLnQwhXs219ik+ccJ4T9abwx+FjU
         7Xwp+05EVFFf+X6bETJdckU5eowrz7xvLh3ffVMtSNTymvEHBfCNWPMCnVZ7XXW3fH
         HwsEgr4Fn53D7N5OKNXOzEidDtb626+tRyNvLS67wDKgBn76AvMVOU76BOmeRS51V6
         0q0HQYU3fmD7nuibkgOhakq2SmHoeatQBNDY14pPeLyaxuODq2dfKimJZ4NNWCfUN3
         zY0b5m8fT5dfQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Mon,  9 Oct 2023 16:09:20 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 9 Oct
 2023 16:09:19 +0300
Date:   Mon, 9 Oct 2023 16:09:19 +0300
From:   Dmitry Rokosov <ddrokosov@salutedevices.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     <lee@kernel.org>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
Subject: Re: [PATCH v1 03/11] leds: aw200xx: support HWEN hardware control
Message-ID: <20231009130919.bezr4wvk4pwmc4p3@CAB-WSD-L081021>
References: <20231006160437.15627-1-ddrokosov@salutedevices.com>
 <20231006160437.15627-4-ddrokosov@salutedevices.com>
 <CAHp75VceobJuEnpQY2Hi1hrjTDCSa-zxi7zxaWt5-k9haGDFUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VceobJuEnpQY2Hi1hrjTDCSa-zxi7zxaWt5-k9haGDFUg@mail.gmail.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180473 [Oct 09 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 536 536 1ae19c7800f69da91432b5e67ed4a00b9ade0d03, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
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

Hello Andy,

Thanks a lot for such a quick review!

Please find my comments below.

On Fri, Oct 06, 2023 at 08:57:23PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 6, 2023 at 7:04 PM Dmitry Rokosov
> <ddrokosov@salutedevices.com> wrote:
> >
> > HWEN is hardware control, which is used for enable/disable aw200xx chip.
> > It's high active, internally pulled down to GND.
> >
> > After HWEN pin set high the chip begins to load the OTP information,
> > which takes 200us to complete. About 200us wait time is needed for
> > internal oscillator startup and display SRAM initialization. After
> > display SRAM initialization, the registers in page1 to page5 can be
> 
> pages 1 to 5
> 
> 

Sure, you are totally right.

> > configured via i2c interface.
> 
> ...
> 
> > +#include <linux/of_gpio.h>
> 
> Definitely not.
> 
> Use agnostic APIs.

Sure

> > @@ -116,6 +117,7 @@ struct aw200xx {
> >         struct mutex mutex;
> 
> >         u32 num_leds;
> >         u32 display_rows;
> > +       int hwen;
> >         struct aw200xx_led leds[];
> 
> Side note: add a patch to use __counted_by() here.

Okay, now I see the patch with __counted_by() some days ago. I will
rebase on it.

> > +       if (!gpio_is_valid(chip->hwen))
> 
> Absolutely not. You may not use legacy GPIO APIs.

Exactly

> > +               return;
> > +
> > +       gpio_set_value(chip->hwen, 1);
> 
> Ditto.

Ok

> > +       usleep_range(400, 500);
> 
> fsleep() ?

Agreed. In this situation fsleep() automatic behaviour is acceptable.

> 
> ...
> 
> > +static void aw200xx_disable(const struct aw200xx *const chip)
> > +{
> > +       if (gpio_is_valid(chip->hwen))
> > +               gpio_set_value(chip->hwen, 0);
> > +}
> 
> As per above.

Ok

> > +static void aw200xx_probe_hwen(struct device *dev, struct aw200xx *chip)
> > +{
> > +       chip->hwen = of_get_named_gpio(dev->of_node, "awinic,hwen-gpio", 0);
> > +       if (gpio_is_valid(chip->hwen))
> > +               if (devm_gpio_request_one(dev, chip->hwen, GPIOF_OUT_INIT_HIGH,
> > +                                         "AW200XX HWEN")) {
> > +                       dev_warn(dev, "Can't request gpio %d, tag it invalid\n",
> > +                                chip->hwen);
> > +                       chip->hwen = -EINVAL;
> > +               }
> > +}
> 
> Please, rewrite this completely using supported APIs and not
> deprecated or obsolete ones.

Yep, I see. I will use devm_gpiod_* API.

-- 
Thank you,
Dmitry
