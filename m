Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9537C4AAD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 08:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345404AbjJKGdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 02:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345378AbjJKGdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 02:33:06 -0400
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720A093
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 23:33:01 -0700 (PDT)
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
        by cmsmtp with ESMTP
        id qHWwq5iwINWIeqSmCqFUuL; Wed, 11 Oct 2023 06:33:00 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
        by cmsmtp with ESMTPS
        id qSm8qM4fTsZgTqSm9qjn7j; Wed, 11 Oct 2023 06:32:59 +0000
X-Authority-Analysis: v=2.4 cv=SoKDVdC0 c=1 sm=1 tr=0 ts=6526419b
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=J9R/PiKqv2o3jGxbVGXx4w==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=oz0wMknONp8A:10
 a=su0M68nG-EwQ1gf0PqMA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
        ; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Al5/o99yN8BkQN7R5iE3F5t0YaiCundyUcTbHLg2cZI=; b=Y5ySBPMvxoIxB3HYjHjkxdqpU/
        RbZiUYvnw4AiKve4rXBBiOKP/WhwJdtQBd0CDoJ727igFZBb5pbDCwiokdE0sMaMn/tl7PMn2vjFM
        d/NfDRf88iVX8ygVT/7Ezcp6U6hMPM/pzgnMZ6lm4FsCwEAjHglWhvDY7r/6Nz7xe7mjbyHodtZmo
        LRvRX5+UWM8EyzcSt4b4c3dWKKOO3b789M0HsqMWs+yXaTQtUVUO2ycJ56OltHF4UQoC+v+kvs4p/
        9fFnF1ErGuaGDEj1TAb+Kgo+czP5RhwbkYz41EBQghbJvbw7NZDTdOVyN3jkN0F4D/j4QhwO1NGjT
        gwO2C3KQ==;
Received: from [103.186.120.251] (port=40770 helo=[192.168.1.103])
        by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.1)
        (envelope-from <saravanan@linumiz.com>)
        id 1qqSm6-002H4p-39;
        Wed, 11 Oct 2023 12:02:55 +0530
Message-ID: <7a964442-80ca-f69a-f1ad-9296cc8f6839@linumiz.com>
Date:   Wed, 11 Oct 2023 12:02:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/3] regulator: dt-bindings: Add mps,mpq2286
 power-management IC
To:     Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jdelvare@suse.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <20231007165803.239718-1-saravanan@linumiz.com>
 <20231007165803.239718-3-saravanan@linumiz.com>
 <84f4692c-5fee-4d00-b537-570f90191d6e@roeck-us.net>
 <1ce9d59e-0938-4448-8279-b8c6e522b26a@linaro.org>
 <154920ff-ad72-43fe-9631-e65ed918a9bb@roeck-us.net>
Content-Language: en-US
From:   Saravanan Sekar <saravanan@linumiz.com>
In-Reply-To: <154920ff-ad72-43fe-9631-e65ed918a9bb@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 103.186.120.251
X-Source-L: No
X-Exim-ID: 1qqSm6-002H4p-39
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.103]) [103.186.120.251]:40770
X-Source-Auth: saravanan@linumiz.com
X-Email-Count: 4
X-Org:  HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMPhNbt82sec1Y1a3zcPKs5XUrVh0HVPHC4wQAsALTuligM3lr7/gmang1awaztwuxzlFWAHD0behj5p2msi4Q/mAftWnED+Liq24HHi4a09lL4Uh5L7
 /xn+ALysslstyYWU63XlykY4NK0sJuIeYLHjh7t2BHfx72mnm31gAMNT+QFBysd27rp3obQixL8FZcUKCsfO1pJ+RfPeyaCSQyI=
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/23 19:22, Guenter Roeck wrote:
> On Sun, Oct 08, 2023 at 12:40:29PM +0200, Krzysztof Kozlowski wrote:
>> On 08/10/2023 03:20, Guenter Roeck wrote:
>>> On Sat, Oct 07, 2023 at 10:28:02PM +0530, Saravanan Sekar wrote:
>>>> Document mpq2286 power-management IC. Instead of simple 'buck', 'buck0' is
>>>> used to keep the driver common which handles multiple regulators.
>>>
>>> Sorry for the maybe dumb question, but where can I find the driver
>>> depencency on buck naming ?
>>
>> I guess it is because:
>> PMBUS_REGULATOR_STEP("buck", 0, MPQ7932_N_VOLTAGES,
>> creates regulator name as buck+id (so buck0).
>>
> 
> Ah, good point. Problem here is that this is already kind of common,
> even though the use of "buckX" isn't. Look for "vout0", or
> 'PMBUS_REGULATOR("vout", 0)'. Apparently so far no one took offence
> if a regulator was named "vout0" even if "vout1" didn't exist.
> 
> I don't really have a good solution right now, but I guess we'll need
> a second set of macros for the single-regulator case, or maybe generate
> struct regulator_desc arrays using a function. I'll have to explore
> options.
> 
> Please let me know how you want the subsystem to handle existing
> single-channel regulators with numbered regulator name.
> 
> Saravanan - for this driver please just declare a local driver-specific
> variant of the PMBUS_REGULATOR_STEP() macro which doesn't use indexing,
> use it to initialise a second regulators_desc array, and use that second
> array for mpq2286. That is a bit messy, but acceptable for now until
> there is a more generic solution (unless of course you have an idea for
> one and want to implement it, but that is not a requirement).
Hello Guenter,

Thanks for your proposal as intermediate fix local declaration of macro, 
could you please suggest whether below changes is acceptable as workaround?

+++ b/drivers/hwmon/pmbus/mpq7932.c
@@ -118,6 +118,12 @@ static int mpq7932_probe(struct i2c_client *client)
  #if IS_ENABLED(CONFIG_SENSORS_MPQ7932_REGULATOR)
         info->num_regulators = info->pages;
         info->reg_desc = mpq7932_regulators_desc;
+
+       if (info->num_regulators == 1) {
+               mpq7932_regulators_desc->name = "buck";
+               mpq7932_regulators_desc->of_match = of_match_ptr("buck");
+       }
+


> 
> Thanks,
> Guenter

Thanks,
Saravanan
