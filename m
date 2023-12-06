Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222C7807535
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379372AbjLFQhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379359AbjLFQhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:37:34 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D67BD3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 08:37:40 -0800 (PST)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9FCCA40185
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 16:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701880655;
        bh=Zi682t5K7EyE6/V/tMw8fdaNtybN1Zt94trKteMb2ew=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=dn7HEyjT4LeK6kcArP7h+GeSKIwzIne3I1vd2+jCaNW6UahZWyra8svLqPohyG69R
         o+dZh2VUk/bFqFW7OMtNQe3bkzSAIMpNbEyPzsvay6W04fdriBXhLBydXqVON5STpa
         v2/+AejiljdrDUpc6k4P0+shmyvX8pDMblne5xwxMLOVakMOVss9fY4+FpoCMXLWjN
         Qh/RvSy8V3TwaKeNE3emcKNmbG2lsuHytNeJv9jG+H37fYR7G5YgVuhG6z7TyOMeQ8
         Z2Yr23EgM3CsgmBB9ggkFwwnTwma/0t/OIUmjG8xct4jovakCSl5KpAw5R6GVBwAtM
         h21Yk4HaJ7TnQ==
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40c18e668faso7349045e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 08:37:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701880654; x=1702485454;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zi682t5K7EyE6/V/tMw8fdaNtybN1Zt94trKteMb2ew=;
        b=tbQwdDQrsL/ZGiMaTOBQr7kx6gD2U704vgSKJFLhHykkHOcR92iFNbxMTEV2sEYeQf
         FI+8hcWIAmNyL0TkrZtLZeefRdwHQy0cSKklYMSxuvLUym/p0MkRVYw1MzW/mhkp/eFY
         UB9FwuefC51waAoDvrHn1XyL/gbVaQLrfvKM2+fEQ/FxNH2BaS5lxHn8fYwRM0ilday7
         GnLlC3suZMYr/5VGYGrUIDjDIsMYWsWMc4sobIKTrIoVnGz3vGWLdNcBaKh5QwVXYSFk
         mzBrciyFivRkpCRxUOpR1n9lFJqhgdvAZD7SZmBk8ztDBe6OMXx4HFMKOQf/17yQCKxZ
         hR1w==
X-Gm-Message-State: AOJu0YwKNV+QutO8f3YmKc/L79B+8iKcYEzLsIJii66mBWtVqhNSGtiF
        o15t9WBZy3U80Bsz2fkuNmOQBAluSRK4xwqEtg/GdHfORsH89ID4waniamdON/uXE4tmhgJH3Fa
        xdm4SThEFrCEGzDY1njY3GzxYpqpmNGBvP0awlf1cuA==
X-Received: by 2002:a05:600c:1c1d:b0:40c:1c2a:ee6e with SMTP id j29-20020a05600c1c1d00b0040c1c2aee6emr538673wms.61.1701880654321;
        Wed, 06 Dec 2023 08:37:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMgacecIbMy3255zcVF0NByF8i+K7PORe5RRs8XOmBlXXH3pVjexVFuK5qZmbqjxuH1mYOYw==
X-Received: by 2002:a05:600c:1c1d:b0:40c:1c2a:ee6e with SMTP id j29-20020a05600c1c1d00b0040c1c2aee6emr538664wms.61.1701880653964;
        Wed, 06 Dec 2023 08:37:33 -0800 (PST)
Received: from [192.168.123.67] (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
        by smtp.gmail.com with ESMTPSA id g20-20020a05600c4ed400b0040b4c7e1a65sm214908wmq.13.2023.12.06.08.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 08:37:33 -0800 (PST)
Message-ID: <a3ea149b-adad-4680-bb59-ae460e8eda04@canonical.com>
Date:   Wed, 6 Dec 2023 17:37:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ACPI: XSDT: struct acpi_table_xsdt must be packed
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20231111134827.174908-1-heinrich.schuchardt@canonical.com>
 <CAJZ5v0gGKuBNBvDj2fNMyCvKTrt2SWfusxyaf7W4jvvfL0nxUg@mail.gmail.com>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAJZ5v0gGKuBNBvDj2fNMyCvKTrt2SWfusxyaf7W4jvvfL0nxUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.12.23 17:30, Rafael J. Wysocki wrote:
> On Sat, Nov 11, 2023 at 2:48 PM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> According to the ACPI 6.5 specification the component Entry starts at
>> offset 36 in the XSDT table which is not a multiple of 8. Hence we must
>> mark the structure as packed.
> 
> There is #pragma pack(1) at the beginning of actbl.h.  Is it not sufficient?

Sorry I missed that pragma.

> 
>> We did not see an error due to the incorrect packing yet as in
>> acpi_tb_parse_root_table() we use ACPI_ADD_PTR() to find the address of
>> Entry.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   include/acpi/actbl.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
>> index 451f6276da49..1a37ac378765 100644
>> --- a/include/acpi/actbl.h
>> +++ b/include/acpi/actbl.h
>> @@ -148,7 +148,7 @@ struct acpi_table_rsdt {
>>   struct acpi_table_xsdt {
>>          struct acpi_table_header header;        /* Common ACPI table header */
>>          u64 table_offset_entry[1];      /* Array of pointers to ACPI tables */
>> -};
>> +} __packed;
>>
>>   #define ACPI_RSDT_ENTRY_SIZE        (sizeof (u32))
>>   #define ACPI_XSDT_ENTRY_SIZE        (sizeof (u64))
>> --
>> 2.40.1
>>

