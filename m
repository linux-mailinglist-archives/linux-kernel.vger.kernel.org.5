Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB957E37F5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbjKGJiX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 7 Nov 2023 04:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjKGJiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:38:22 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FB292;
        Tue,  7 Nov 2023 01:38:19 -0800 (PST)
Received: from lhrpeml100001.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SPjjl0dvWz67mKT;
        Tue,  7 Nov 2023 17:34:51 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml100001.china.huawei.com (7.191.160.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 7 Nov 2023 09:38:16 +0000
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.031;
 Tue, 7 Nov 2023 09:38:16 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH RFC v3 1/6] cxl/trace: Remove uuid from event trace known
 events
Thread-Topic: [PATCH RFC v3 1/6] cxl/trace: Remove uuid from event trace known
 events
Thread-Index: AQHaDQgRQ2vINXGk70OHbaqSCzYaYrBoqc8AgAAYFhCABR7LgIAAwHxA
Date:   Tue, 7 Nov 2023 09:38:16 +0000
Message-ID: <36f2d12934d64a278f2c0313cbd01abc@huawei.com>
References: <20230601-cxl-cper-v3-0-0189d61f7956@intel.com>
 <20230601-cxl-cper-v3-1-0189d61f7956@intel.com>
 <20231103142756.00000e20@Huawei.com>
 <547d055eb85d4cee9c636c69e89a82ed@huawei.com>
 <65496333c1dc9_90fed29479@iweiny-mobl.notmuch>
In-Reply-To: <65496333c1dc9_90fed29479@iweiny-mobl.notmuch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.168.44]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ira,

>-----Original Message-----
>From: Ira Weiny <ira.weiny@intel.com>
>Sent: 06 November 2023 22:06
>To: Shiju Jose <shiju.jose@huawei.com>; Jonathan Cameron
><jonathan.cameron@huawei.com>; Ira Weiny <ira.weiny@intel.com>
>Cc: Dan Williams <dan.j.williams@intel.com>; Smita Koralahalli
><Smita.KoralahalliChannabasappa@amd.com>; Yazen Ghannam
><yazen.ghannam@amd.com>; Davidlohr Bueso <dave@stgolabs.net>; Dave
>Jiang <dave.jiang@intel.com>; Alison Schofield <alison.schofield@intel.com>;
>Vishal Verma <vishal.l.verma@intel.com>; Ard Biesheuvel <ardb@kernel.org>;
>linux-efi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
>cxl@vger.kernel.org
>Subject: RE: [PATCH RFC v3 1/6] cxl/trace: Remove uuid from event trace known
>events
>
>Shiju Jose wrote:
>>
>>
>> >-----Original Message-----
>> >From: Jonathan Cameron <jonathan.cameron@huawei.com>
>> >Sent: 03 November 2023 14:28
>> >To: Ira Weiny <ira.weiny@intel.com>
>> >Cc: Dan Williams <dan.j.williams@intel.com>; Smita Koralahalli
>> ><Smita.KoralahalliChannabasappa@amd.com>; Yazen Ghannam
>> ><yazen.ghannam@amd.com>; Davidlohr Bueso <dave@stgolabs.net>; Dave
>> >Jiang <dave.jiang@intel.com>; Alison Schofield
>> ><alison.schofield@intel.com>; Vishal Verma
>> ><vishal.l.verma@intel.com>; Ard Biesheuvel <ardb@kernel.org>;
>> >linux-efi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
>> >cxl@vger.kernel.org; Shiju Jose <shiju.jose@huawei.com>
>> >Subject: Re: [PATCH RFC v3 1/6] cxl/trace: Remove uuid from event
>> >trace known events
>> >
>> >On Wed, 01 Nov 2023 14:11:18 -0700
>> >Ira Weiny <ira.weiny@intel.com> wrote:
>> >
>> >> The uuid printed in the well known events is redundant.  The uuid
>> >> defines what the event was.
>> >>
>> >> Remove the uuid from the known events and only report it in the
>> >> generic event as it remains informative there.
>> >>
>> >> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
>> >> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> >> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>> >
>> >Removing the print is fine, but look like this also removes the
>> >actual trace point field.  That's userspace ABI.  Expanding it is
>> >fine, but taking fields away is more problematic.
>> >
>> >Are we sure we don't break anyone?  Shiju, will rasdaemon be fine
>> >with this change?
>>
>> The field hdr_uuid is removed from the common CXL_EVT_TP_entry shared
>> by the trace events cxl_generic_event, cxl_general_media, cxl_dram and
>cxl_memory_module .
>> rasdaemon will break because of this while processing these trace
>> events and also affects the corresponding error records in the SQLite data
>base.
>> Rasdaemon needs update to avoid this.
>>
>
>Ok we can leave the uuid field in easy enough.
>
>But does rasdaemon use the value of the field for anything?  In other words does
>CPER record processing need to generate a proper UUID value?
No. Presently used for logging purpose only in the rasdaemon.

>
>Ira

Thanks,
Shiju
