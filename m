Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739A87DE630
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 19:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344795AbjKASyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 14:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbjKASyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 14:54:18 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97092ED;
        Wed,  1 Nov 2023 11:54:11 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6D85CE0003;
        Wed,  1 Nov 2023 18:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698864850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q3sZj6RniyTzoHCodRr2i/ntz4jNs4JFrcHctmS81hg=;
        b=cdd3Y9sRN8ttWyWYp4CktTx2h/eFQ4OzABlsf8uGELdQDyy4ZLTgQpLoQW2XFiinuPJHXW
        RBWEDFR/7TXz2KOELIFqMaFIuN87guCVLfRaEZ2WkYKUJGe2NIcPHSTPUyyxIRW7qLMMpr
        x/l4nfgGrrMf4WWlXWkrokf5igp3s34oN562NLrpUwAeV9atz5NOJFpDWO3LBuqIDzCcCA
        4rIuyKnglUtAkHwI1Xeo8m0/zt3TxovMLAOr7sYgdO1qncnQfbqblUZaLcI22Xf0ay6had
        L5Ltk/H2PXKdO/Tos5XGraWcb+wnP6t8a8mtDv5lB1CBHR/XZZYrx48SbvWPYA==
Date:   Wed, 1 Nov 2023 19:54:09 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] rtc: max31335: add driver support
Message-ID: <202311011854099f524c30@mail.local>
References: <20231031153100.92939-1-antoniu.miclaus@analog.com>
 <20231031153100.92939-2-antoniu.miclaus@analog.com>
 <95e41f16-4b5f-4f2a-bc31-17273032312b@roeck-us.net>
 <CY4PR03MB3399DEF73E052036AC7EDBA99BA0A@CY4PR03MB3399.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR03MB3399DEF73E052036AC7EDBA99BA0A@CY4PR03MB3399.namprd03.prod.outlook.com>
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

On 31/10/2023 16:28:07+0000, Miclaus, Antoniu wrote:
> > According to the register map above, the chip does support
> > low and high temperature limits as well as over- and undertemperature
> > alarms and interrupts. I would suggest to add support for all of those.
> > You might also consider adding support for temperature alarm interrupts
> > and report temperature alarm events by calling hwmon_notify_event()
> > if a thermal event occurs.
> 
> I've sent in the first version of this patch series a cover letter:
> 
> "Although the datasheet is not public yet, the driver can be made public (on
> other linux custom trees it is already).
> 
> The driver was tested with actual hardware and works.
> 

Did you run rtctest? Please provide the output.

> Even though the datasheet is not available, if there are any queries about
> the functionality of the part, these can be provided/inserted as code comments
> inside the driver."
> 
> The reason why I am rushing this a bit is because the customer that uses the
> driver wants the driver released and mainline kernel compliant.
> 
> This is an initial version of the driver covering the main use cases (which were
> requested, therefore actually used).
> 
> Additional features can be added afterwards, if requested.
> 
> > 
> > > +
> > > +	hwmon = devm_hwmon_device_register_with_info(&client->dev,
> > client->name,
> > > +						     max31335,
> > > +						     &max31335_chip_info,
> > > +						     NULL);
> > 
> > There is no "depends on HWMON" in the Kconfig entry, meaning this will fail
> > to compile if HWMON=n or if HWMON=m and RTC_DRV_MAX31335=y.
> >
> 
> Will do in v4.
> 
> > Guenter

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
