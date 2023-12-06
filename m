Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEFC807595
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378516AbjLFQp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378403AbjLFQp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:45:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CDA1BD;
        Wed,  6 Dec 2023 08:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=s+0eyoF2IA7/iZzTtDBodGF4W/RxeJnnXr1f0bX3bC0=; b=Fm6qLk5mSRJ+EDcNikw8GwlHde
        gNdsq5LMcHSmlMx5drBt/xCoSJ58NDr9S/Cbkl/zyKj+ttMMJoL2PjZTugX7+MiH+RbNE/lDHxW4F
        73OxKjWSEO/NAdi5QTDZ3kUsA3Ne7Qwtuapba4X+QA8b/8N8kEeJnD4MbleaUN3WflpK3/8QtWCS+
        VGxM8y7cZE7P21AvbevWdrQThsNPsB4vw8O7aIN5/KMOHKn0fvkDoWK51lST/k/iM2hf11Pymw9Fe
        CQ01i1+MTnTx8aYcVQIfv7JXH05PhK9z8lTyARfLgrPv1YLsdqy//Ad8GDGQXqAVE4KC0vMMd2Ghv
        HLY1rYnQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rAv27-00AnaX-34;
        Wed, 06 Dec 2023 16:45:59 +0000
Message-ID: <f734ff9e-6005-4d47-959d-fab34c71c6e0@infradead.org>
Date:   Wed, 6 Dec 2023 08:45:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ibm-acpi-devel] [PATCH] platform/x86: thinkpad_acpi: fix
 kernel-doc warnings
Content-Language: en-US
To:     Mark Pearson <mpearson-lenovo@squebb.ca>,
        linux-kernel@vger.kernel.org
Cc:     ibm-acpi-devel@lists.sourceforge.net,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20231206060144.8260-1-rdunlap@infradead.org>
 <ea94a2d7-a13c-4f08-9979-48a8f33a47fc@app.fastmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ea94a2d7-a13c-4f08-9979-48a8f33a47fc@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 12/6/23 07:30, Mark Pearson wrote:
> Hi Randy
> 
> On Wed, Dec 6, 2023, at 1:01 AM, Randy Dunlap wrote:
>> Add a function's return description and don't misuse "/**" for
>> non-kernel-doc comments to prevent warnings from scripts/kernel-doc.
>>
>> thinkpad_acpi.c:523: warning: No description found for return value of 
>> 'tpacpi_check_quirks'
>> thinkpad_acpi.c:9307: warning: This comment starts with '/**', but 
>> isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>> thinkpad_acpi.c:9307: warning: missing initial short description on 
>> line:
>>  * This evaluates a ACPI method call specific to the battery
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
>> Cc: Hans de Goede <hdegoede@redhat.com>
>> Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
>> CC: ibm-acpi-devel@lists.sourceforge.net
>> CC: platform-driver-x86@vger.kernel.org
>> ---
>>  drivers/platform/x86/thinkpad_acpi.c |    6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff -- a/drivers/platform/x86/thinkpad_acpi.c 
>> b/drivers/platform/x86/thinkpad_acpi.c
>> --- a/drivers/platform/x86/thinkpad_acpi.c
>> +++ b/drivers/platform/x86/thinkpad_acpi.c
>> @@ -512,10 +512,10 @@ struct tpacpi_quirk {
>>   * Iterates over a quirks list until one is found that matches the
>>   * ThinkPad's vendor, BIOS and EC model.
>>   *
>> - * Returns 0 if nothing matches, otherwise returns the quirks field of
>> + * Returns: %0 if nothing matches, otherwise returns the quirks field 
> 
> Just being nosy - what does %0 do?
> I assume it helps with the return value but was intrigued how it is used and where

It causes the output to be formatted as a CONSTANT (probably monospaced font,
but no guarantees on that).

> 
>> of
>>   * the matching &struct tpacpi_quirk entry.
>>   *
>> - * The match criteria is: vendor, ec and bios much match.
>> + * The match criteria is: vendor, ec and bios must match.
> I can't for the life of me see what is different here. What am I missing? 

s/much/must/

> 
>>   */
>>  static unsigned long __init tpacpi_check_quirks(
>>  			const struct tpacpi_quirk *qlist,
>> @@ -9303,7 +9303,7 @@ static struct tpacpi_battery_driver_data
>>
>>  /* ACPI helpers/functions/probes */
>>
>> -/**
>> +/*
>>   * This evaluates a ACPI method call specific to the battery
>>   * ACPI extension. The specifics are that an error is marked
>>   * in the 32rd bit of the response, so we just check that here.
>>
>>
>> _______________________________________________
>> ibm-acpi-devel mailing list
>> ibm-acpi-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel
> 
> Thanks
> Mark

-- 
~Randy
