Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE82767885
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 00:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbjG1WhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 18:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjG1Wg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 18:36:58 -0400
Received: from mgamail.intel.com (unknown [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC963AA5;
        Fri, 28 Jul 2023 15:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690583816; x=1722119816;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=akWlnL0ng+mGlxV9ZTyYVs+n+iX8+R1CTkRyxwnBMpA=;
  b=GrzDei1LyJn2CiPAXsv0nD6EWK8akazjcICMtTmF6n5D7p3ghfGuBjqO
   tor/epQWmQjTVnB9yuAjEcfqY3G+4YX8ZF+MHWV6qu17X5vjUJ2RFu2FU
   ePrjIPVBO1eAlFLOuAQUtdXfuxHzrhxiey71QpQOWKkcMqMa0MNkD68ts
   r3FZvpFK3X1nTAdYQ2IsX4SlGOCnA6Alseb/nlAbMybVXYVZlFEeumoIh
   +0iAAHkADW1BQHZbnnU9FgthN58/WUSiDMUiQVQAkpQNb6RpU97l4z7Hx
   idHk5+2cdafE5QmlLQhkvArpMNbABbdo/Hh83FkrnH3vtj5FmFWakTrEX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="366165799"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="366165799"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 15:36:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="793060796"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="793060796"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jul 2023 15:36:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 15:36:46 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 28 Jul 2023 15:36:46 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 28 Jul 2023 15:36:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y94s2oN93llkc05wjNOvXDfIjLGi3H7HCKWHLKMTgQIk609FkWTFkURhIXALdn+aBi0Xb8mu/FU/CxGkBIIzqYhRdjqIJCT9jas88i3EVGWwXHCqyvo5T5uvov++QhU/RNUgAf83TDP8zazG/aejr/37V6N6cboIq1qzeR/f4b1+tbYmCLeqalDrGrPr9+xWueBF8QF4Ai9uNYukRNqSgt4m059wXzL/+BP0bF8WZ4vlxth+YIoZieZ4hC4JXqMLuDq6FGoEVB+S7OSWxfeJ5gWJvBbrP1mpKwujyTcE2giyHWD5xoYJ0R42cSVrOnfLwBHoEeWipNvdlGIjzSrQ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PciEHpw4AwYr8Ig686IWbSZe1xD3rrLjd4AYdZ7gIGA=;
 b=Ojoq+FftOog4tP8BdQ5S4/LzMpFQNZ4G8pbz/vFZ5Wr+dILQ6YP96wnbdVIktsPZ9QliveyI4O7uUeYo140BmSy/NzLGjwCWtx0Ku/wCkL7xoLq1xZB7EpgYyi6oBD0QRFcywJ5Dq0UXpL6o5AoHFF/l7Xwv8XdDSseQqzR0BKgBxPaySAeb50r4v3aDXCPuE3r1nJQtTyW07DVA02O+868AcxzjUJS36PxVQG2dnqUSavX1iS6eaDSjXtW5PcRGWXarkXou42b+UBsnhGNREqiU3QycxwvNiTfkXvAv9eeGzhxvt9lXOxHC7b16bENmNVJ4UQ7/KvcokYwgCItf5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DS0PR11MB7622.namprd11.prod.outlook.com (2603:10b6:8:144::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 22:36:44 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::d790:194b:937b:68e2]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::d790:194b:937b:68e2%2]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 22:36:44 +0000
Message-ID: <48b6d063-8528-2208-5117-5c9c095886e5@intel.com>
Date:   Fri, 28 Jul 2023 15:36:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [patch v2 11/38] x86/apic: Use BAD_APICID consistently;
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     <x86@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, "Jean Delvare" <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "Russ Anderson" <russ.anderson@hpe.com>
References: <20230728105650.565799744@linutronix.de>
 <20230728120930.281607646@linutronix.de>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20230728120930.281607646@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::14) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DS0PR11MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: f6496497-0157-4434-0b3b-08db8fbb1eda
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vIQCFLmorwAZDhp12gNgJ4Jo/gpRztBzvVs5vOSbuzFh66PCZpZ8Cn0/wbzh0SOpXbcomA863aHEh2vmdmUodOW/9owYml4wBWcYgrvSJScUO/2sIyIC0AeJt6BtuUkD/17+3bzY+zI2a+CtODHml7lttwXYeutNUMpMITKyB/VBXONdiPTNcqIQQ0Sy/JA04XWnIrs3FQWryLclCL7ttTdhd4hd19tPSA/azDmmbWkiq0pqwdz4p4wnwdDEdfaJFVGJIp7VyI0+XNsaQkb0VmWpJrejMsATIpSVPvgDMEf8tElJHprbz0nuVwwLkmyf6K1JEVAdxgiGLfh61bwdeLLpbQPjanZEWy99YbQxcZ/MvyXwve3zcD/kwvoCrZPJadS/WSeaBb4mM6x8fnfEDCuCQJcG87xPibvZGd6T7Nt4/xLfCy9N7/H7Gc+2efMUaABWwnie0crTPGkQlwZRFiCdlrDFGP7cLo1sjl3XJP8SWY57xenLII2WRVLs6isspMLwMaGZnnKaryCsIxQjUGHYSMtnmJbkI1Jd1EKdHzFfR7XmWUT/XB6I75ff/EeAdRzd3anguxtZKVeCptY3tOv7lSrwbhQh0OqjPBIxgkyO0vPHgJ4Ze/Z8hbPX2jQTjHjLM5RgG7wfeNUf7Uj4tg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199021)(26005)(6506007)(54906003)(82960400001)(478600001)(110136005)(53546011)(186003)(6512007)(6486002)(66556008)(4326008)(66476007)(2616005)(31686004)(38100700002)(66946007)(4744005)(5660300002)(7416002)(44832011)(41300700001)(316002)(2906002)(8936002)(8676002)(86362001)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFVpN2c0aTJvWnVjMkYrNjQ3U0QreS9IRlljUkUyeTRJUFFrdG5vcnJ6U3JI?=
 =?utf-8?B?cFZWWkZsOUs5NW1Pamx3ZTBKS0tpWlNGMU10eDE0MUQ5VmVGcHZGb28xaTFt?=
 =?utf-8?B?MnVKMVdQV2dBbE10QnBMVk5MeUxnaXFPY1cvMXJGcThTeXFyTWxPOFhPUHhO?=
 =?utf-8?B?WXJiS2R4WG9aOE1uMmkxSDJRS3ZnVSs1N0ROMy9JWnBCRkx2bFFlQmNoWk13?=
 =?utf-8?B?SjBYMllYRytkelNiS1lHcmRCTEhYbW9RV1Vwa0tBdVF6OU9hUEx3aUtqQW8x?=
 =?utf-8?B?by81bms0L0F4bkpXVDVzYkVUQUNRTmxMcWNkN3ZNaHNreW1NQmt0WFZZNTlS?=
 =?utf-8?B?Ry8xN094VUdPN0FpNWZPdzlDcFVGRktJQ25sY1ltSk9KYk5BeFFoOXVHcGtO?=
 =?utf-8?B?QlNnazdaZkY5QzNLQ2tnL3BOb0dXWFNBSUY3bkk5YTRoUHNCcjZBQ2t6M1dG?=
 =?utf-8?B?SFROSTlkQ21qYkJnN3Roc0hFM2NsTTBwc1B6VkRkREZlVDJZKytGVkpNRlhh?=
 =?utf-8?B?aHFuaGVKSC9KN1JrOEtmbGJDRXh0RzlqbVl1SGxpeGpjQUJHTGlpdE9hOGtX?=
 =?utf-8?B?SFVVQ254ZjRUdHNmZVBsWU5uYUl3YzFoZGJiWVFMVUxtdzJoUGI4NlNXdzl2?=
 =?utf-8?B?RS81NWRKTXZodHpVOW4yQWNlRVZqNHVUMmdJZEdwWlJaMHFUakM5TFRKSFho?=
 =?utf-8?B?MjJ3ajJueUxmeXd1QVpHN3BzZzdjVHBHTWdTTURNZjN3OElhekJJZVFXRGxx?=
 =?utf-8?B?alhOYkZWRHNyNjEvU01ZZHUyQ2tFWVU1VjJTNmRReFFSaFNESUxVVGw0cmVW?=
 =?utf-8?B?djRNWWRvZ0JEcS9BYWk5ejVEWmN6NmxGUkVGenNOTllKSmMvMTFFWEhjWWF6?=
 =?utf-8?B?U2lMUi84eUI0a3pya0o0eUIwSC9TZnAzMVE0ZlhlRkpMcGgza2NGU2ZKem1q?=
 =?utf-8?B?dmN6NjJhNW01cWZLY0VvNDFNUjhhVHhGdzBVYjNCcTF5TTZhbFZvSVhKMWNU?=
 =?utf-8?B?NGFJRGkwa3I1Z3hENzBCREVlZFhGTUFwSjQ4R0FJc1YycWxKb2xYdlkwajlW?=
 =?utf-8?B?UWJGWVZqN09xbTY0bUp4eS9lMjVCWjlpbmw2b0lxZVptWjdBb3gzOGVnRnBm?=
 =?utf-8?B?VkMwQ09YZzBDTnNVLytId2xZbVV5MjRWNkJrbzFTWWQwcTk5dnNlTlpYcm85?=
 =?utf-8?B?L0F1TWw4Yk51eVA2cFl6RGdNWWtLYmtmSnFidDJnQkpYRm4wTEZVOFJ3NHVD?=
 =?utf-8?B?UEd4b2tjM0FQWFQzTDcvSmdhcWVxN1VJYU1BUVFCMFF5Z1llUWVtdVF0QlV1?=
 =?utf-8?B?OFF6ZFVZYjVqemwxdFZCbU1mY2dwNkRLcnVabWpOR1dRSDEraFBxOU9qOVJv?=
 =?utf-8?B?VmNSN0Y4SEhsczVGQ0d3eW1adEhHNmpDdnFoRXYvbVlvcm1oTGhHSzBNMEhj?=
 =?utf-8?B?MmRWd3NWVzVDcVlWWEZkRDNpQlJ4bHVGcnZPdS9yTGFHT3pSbXNrWGRlTytW?=
 =?utf-8?B?dWM5QTh4aVZQSVRjSU1GTjBHUElrN2xmK2RnVTdGN3RTci9YTkJRUzNYeElv?=
 =?utf-8?B?ZndIOHhvRHJHcUxpTE55YUFiM1pQejBrdHlLRFc0UVRqMzZPeHRrTTk2MWZP?=
 =?utf-8?B?SkZaV1Y2OHpWZVNQL2x2TWJBYXlMMy96bU50TW1CSEpQVVM3YlpOK0RZOTVj?=
 =?utf-8?B?TVNPSjhjSi9UaUtjQTlxUm0wL1JPWk0vZmk1WHlrZnZSZlkyUnRKTW5ablZY?=
 =?utf-8?B?bkpHa0kwRyt6V0dBc01VemVkMm0zSGRTc2ZuYlZCU01jWHhPRmIvbFRtTUZx?=
 =?utf-8?B?L0hjbm0zUjQ5RTVVRGV2UkhEMFh6RC9seE1wNmxOVFE0VjRhcEhweVVSWElw?=
 =?utf-8?B?UlRuSTM2UDZTZzFyYUZMQmU1U1VDWVVDd01RWXJQSEtwckFpRTlSNEQrUEZK?=
 =?utf-8?B?NHFoYUJoSmhDaG50TmtSNHJzTEc5ZHR1QVdIZWQ5VXA1MG5IUW5Jdm1KVGJ2?=
 =?utf-8?B?cmpxeGhWTDFtN1FsQkpzd2JEMm56L2U0WW9WMWhxTkFnaVdtS3pyRWJoajB0?=
 =?utf-8?B?QmJ2bmEzTVdod1JWc25WUkVieGJqbU1OeHVOQjlML0ZVVWREN1g1QlVtNU5E?=
 =?utf-8?Q?apMJY7UgRLCrEmXdsjBqyRfvb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6496497-0157-4434-0b3b-08db8fbb1eda
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 22:36:44.4141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eCBnYYpoM3VWIVdlYhlbD2In4qWsrCoMOWmrIafg0nKEWmy6CDgQ1L/7QjWY79GuaiSWZvi81ZoQLt9BOFeNFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7622
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an extra semicolon at the end of the patch subject.

On 7/28/2023 5:12 AM, Thomas Gleixner wrote:
> APIC ID checks compare with BAD_APICID all over the place, but some
> initializers and some code which fiddles with global data structure use
> -1[U] instead. That simply cannot work at all.
> 
> Fix it up and use BAD_APICID consistenly all over the place.
> 

s/consistenly/consistently

-Sohil

