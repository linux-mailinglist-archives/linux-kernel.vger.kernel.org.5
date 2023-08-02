Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1274A76C41E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 06:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjHBEZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 00:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjHBEZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 00:25:11 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BF411A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 21:25:05 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so69342325e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 21:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690950304; x=1691555104;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mtSlfWL5ufjC4lYnzIHx4JjC5PrXYey+w4yFZchnGZQ=;
        b=hHQxBachE016lHBZru9Jmm7yn8F27Sr0rEDHLVru3e8MY7sPIPx95DiX+OwDwOvCdJ
         W4qv/XjfKPD99PeafFFYa9ahz91P160gQYO2HpePPp0qpUdObbBq8VTaoSIjo9ymGqtV
         HmKse1ZoJHP3ySXmZOt01/d3vAAt7YS3OXcGiSFFpj5gv4VG2s16+qm2mBRBkS8islz2
         natfabDRdnYO5fKJYuRejfefZHDXGpyT93u+yoe+AtP+i4XMIcJFQErciSQiq67VTWDS
         HIdmmb5xCXaXPpE7kUE8kR0Oz5LcfhYzeHGweYfUFbel9EqpWLHGzq632l02P516MMmj
         DK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690950304; x=1691555104;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mtSlfWL5ufjC4lYnzIHx4JjC5PrXYey+w4yFZchnGZQ=;
        b=T/GTHHcoGe9Y0z4+iSomPnVmzedfrNJEZJFC03mHsLbAHvnlcp3sPAHvwJD/YAnwrT
         43b7mWU92woV5TghcKcch5+fJytYSHzrmPPJTcRGKr2ill4fGMa5wQaSdE1OXEYs5cBa
         ET2flbqDk2lJdhjnVGrKmV9Qt8QDV9cJJ+SUbtVJOswM/vUQ7hTs7470LqwRA7Fwltyn
         8oKTMUqFM52x768THi13NGSQnb8iqjo9bVvjetdEFTXdyYsyrU9UMQfjym7le0AIegpW
         KJcsSMTMr/oJLmP8Qp6JvtVMkp+EPkFMn/kg6WEiDeQgAGCwcQjm4WRWBjBWnI9CmBCF
         GOZA==
X-Gm-Message-State: ABy/qLZueLM3XWle5hcVvrlKU+KX85xf7G1xgPtemC0XkpBj/A2mV8lu
        ZGW5ZtB41st0Tx5UUNQF5a/4MQ==
X-Google-Smtp-Source: APBJJlFhZeydmdaXg6TMe/5VEekDJ1CQYoO96Asld3t94Me+C+AV4bHDV2VWJJlPbnRH20vO5HuUSQ==
X-Received: by 2002:a5d:474c:0:b0:317:631b:43ce with SMTP id o12-20020a5d474c000000b00317631b43cemr3800841wrs.41.1690950304171;
        Tue, 01 Aug 2023 21:25:04 -0700 (PDT)
Received: from [10.0.2.15] ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id o20-20020a5d58d4000000b0031762e89f94sm17659259wrf.117.2023.08.01.21.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 21:25:03 -0700 (PDT)
Message-ID: <79a79ec5-3691-43d2-ca3e-478a94f85e2d@tuxon.dev>
Date:   Wed, 2 Aug 2023 07:24:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH 03/42] clk: at91: sam9x60: switch to parent_hw and
 parent_data
To:     Stephen Boyd <sboyd@kernel.org>, alexandre.belloni@bootlin.com,
        mripard@kernel.org, mturquette@baylibre.com,
        nicolas.ferre@microchip.com
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com
References: <20230727053156.13587-1-claudiu.beznea@tuxon.dev>
 <20230727053156.13587-4-claudiu.beznea@tuxon.dev>
 <412f9209637e6eb861cd07e1d6dbc346.sboyd@kernel.org>
Content-Language: en-US
In-Reply-To: <412f9209637e6eb861cd07e1d6dbc346.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.07.2023 06:28, Stephen Boyd wrote:
> Quoting Claudiu Beznea (2023-07-26 22:31:17)
>> @@ -177,31 +178,34 @@ static const struct {
>>  
>>  static void __init sam9x60_pmc_setup(struct device_node *np)
>>  {
>> +       struct clk_hw *td_slck_hw, *md_slck_hw, *main_xtal_hw, *main_rc_hw, *main_osc_hw;
>> +       struct clk_hw *parent_hws[6], *hw, *usbck_hw;
>> +       static struct clk_parent_data parent_data;
>>         struct clk_range range = CLK_RANGE(0, 0);
>> -       const char *td_slck_name, *md_slck_name, *mainxtal_name;
>> +       const char *main_xtal_name = "main_xtal";
>>         struct pmc_data *sam9x60_pmc;
>> -       const char *parent_names[6];
>> -       struct clk_hw *main_osc_hw;
>>         struct regmap *regmap;
>> -       struct clk_hw *hw;
>> +       struct clk *clk;
>>         int i;
>>  
>> -       i = of_property_match_string(np, "clock-names", "td_slck");
>> -       if (i < 0)
>> +       clk = of_clk_get_by_name(np, "td_slck");
>> +       if (IS_ERR(clk))
>>                 return;
>> -
>> -       td_slck_name = of_clk_get_parent_name(np, i);
>> -
>> -       i = of_property_match_string(np, "clock-names", "md_slck");
>> -       if (i < 0)
>> +       td_slck_hw = __clk_get_hw(clk);
> 
> Don't introduce more usage of __clk_get_hw(). The index for "td_slck"
> should be known, and it can be used as the index member in struct
> clk_parent_data.  This allows the clk framework to lazily find the
> parent, instead of requiring the parent to be registered before this
> code runs. It also reduces the usage of __clk_get_hw().

If I'll do this I will have to also change the approach that has been done
for SAMA7G5 (already integrated in v6.5-rc1, maybe I had to let it more on
the mailing list before taking into the tree) for all the clock drivers
(basically instead of parent_hws I will have to provide parent_data to AT91
clock registration APIs AFAICT). No issue with that... just telling...

The reason I did it with parent_hws + __clk_get_hw() on PMC parents in
SAMA7G5 is that SAMA7G5 PLL parent rate need to be known from the
registration to setup properly the PLL. Otherwise PLL will not lock if not
properly setup. For this I got the parent_hw for PLL parent to retrieve its
rate and thus I chose at that time to also get the clk_hw for the other
parents of PMC just to have the same approach on all parents (and it looked
to me that code will be simpler).

Thank you for your review,
Claudiu Beznea
