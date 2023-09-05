Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE34792C71
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbjIERcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237452AbjIERbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 13:31:35 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20625.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::625])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC26A5FC;
        Tue,  5 Sep 2023 09:57:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gio+UIQN6kqo9jKsNEbL+mSnS9VI3QfddeJxvLdMkVey2PupPzm7VFBwb0nSAwmBcprzMVWmViI0w5JNb34X/7MHbdbOdc4NvDFtYO4wCUv4jeTbjUz0xlb7aCjptlD3To9ZTJ1RJQXDj+k/hKhghzLei/Q8ASmN9KGd7yvbqH7+5h+xhscM0IDWjze/aGYu58qZVbYKEn9gBoZB2Px72p/I1woS8oJ8Khryc6pZe5LUtoyW6w9I4SRdIXpcF/bwRehaj0/2vxNc2y0m0CJdB5WKWCwrXW2D4fp/TN6ESwvjTY4+hwzDvfcKh38rhYhWFnKfTXQy6HKmDMAHXk+vaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDuR3cyXL9LfhEkVhF3b0wOLne33JwiOi+R2Q9N60gw=;
 b=ft0W2xMbvsWRioadsUNxqtvGJG8brWaUJm6WzxM5cs1qihxs6uLupysiK7Xmn7ag8UmA1oc9H6BMqOmguVIRVmMoNgMWfBVVHsLqRUDYAxu0zvHGUfcYYck32MsNJuB/V7WXMXgT9Ns2L0I1XMUrLsH7kPi3c9bogoFyIFu3vIMPHxVh27kYFjWpmlFa3bHUnfE2lpPwLUK9ZuGURNC+qnRnzegBJmm9LHfEzeA5zFRviaZoLanx8FxNFDV9L6Cj7GxD966uKT5X3dQNQdD4jp/gNp3txmoNgjBeMLJVl5A0735xjRWGAhReGLBkKORh3ddRN7g0kBuIwif8NzuPLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDuR3cyXL9LfhEkVhF3b0wOLne33JwiOi+R2Q9N60gw=;
 b=vnWXE1Q5MggeTY5d+Ha7qVjI0kSKdIsmPRKc3XDDvPZEf6TvhL7xrVOpr4Kk9hRCjattA6QYP1QiRCywPGXhRXl2rL4ACo3XiAb0/TaDZ/nIAQeVJSm1Z0HyVMzNb9Axjr5jDauKuCypC3c7ovAF3gfUQoQ1Hy0WwEX8BqxuVHI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 BN9PR12MB5178.namprd12.prod.outlook.com (2603:10b6:408:11b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 16:55:42 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::5b90:dbf9:e0a5:64cc]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::5b90:dbf9:e0a5:64cc%6]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 16:55:42 +0000
Message-ID: <b2e22473-7c4e-e20b-7b67-463f84109ef6@amd.com>
Date:   Tue, 5 Sep 2023 11:55:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v10 07/15] cxl/pci: Add RCH downstream port AER register
 discovery
To:     Dan Williams <dan.j.williams@intel.com>,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
Cc:     rrichter@amd.com, linux-kernel@vger.kernel.org, bhelgaas@google.com
References: <20230831152031.184295-1-terry.bowman@amd.com>
 <20230831152031.184295-8-terry.bowman@amd.com>
 <64f0e11a6cc68_31c2db294d8@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <64f0e11a6cc68_31c2db294d8@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0237.namprd03.prod.outlook.com
 (2603:10b6:5:3ba::32) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|BN9PR12MB5178:EE_
X-MS-Office365-Filtering-Correlation-Id: 1172423c-98aa-4a40-c25d-08dbae30f0a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 40q0skP16BaAEXjbSXctKnWXTyr+Mas+VhuDvnZxPJbC7Yd0ZPi0k0EOT3U3e1aebzDeBbHgge1Yf2bhEGdiz9OCJJ+b4fF3jynvwMp4js+EkHtA53XbK5Vqq6cHYW2s+JDlKTQtjhEmcngDACMN0fib4ZMIZwga/Cf3yT1y1SfgRjOsTI2iIiKjhpfgkg2VQHVCRrDRj9mLrsP855owsvr0p16mZkMnfVdC3Rlo69zuW8/URYqwvFto5fXDAHfq159QfaSaq2O0S8WNp5fbXUcuXuk0WQ5PClVXfPEQV/uehM0F6bu8tfI/lQ0A8KHH+sJxvRBp8EUMRm0EYQAK1/FPezpWAxR06kiZTavOs3A3Toyt65xNbQBr5A1wMO/ifmLw1lrOmgz/g6f5kUlg6Jyy7/Br+i+Wbx3tuxLd2BJD/m1LoLWi1zrobmwA9QGOXflVlUg7WyQix/P3IEKz9vVltdS5x9cMrqgncSSHBragTUhYSOn/NXJKAkcBcsYLXP38yjCc2KF7/huoKUGQFRzPXYvfTVM3RImXs/Qbg/EWQH5rEvTR1taS8MZCVyh/jwGqv8IHw7kRWbYu0RaZ0WWaZk9kBgDBImzImrgqNqMhKpOWH51tCw/4SfA2Vs3t3855PAZpNCHZUkHvwtLW4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(39860400002)(136003)(346002)(186009)(1800799009)(451199024)(41300700001)(7416002)(6486002)(6506007)(53546011)(478600001)(83380400001)(2616005)(26005)(6512007)(38100700002)(2906002)(316002)(36756003)(66946007)(31696002)(86362001)(66476007)(66556008)(31686004)(8936002)(5660300002)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bi9aeDhIRVNveGM3YTNxeEZlYm9lTGRuN2ova3hyanBlamM0N0tDUi9rdTdD?=
 =?utf-8?B?OHpkSmNCNys0eDQ2UTlSM1dtM2FzUFN4NFVyaXh0TlJhUEdLWTc3ZUdFdzli?=
 =?utf-8?B?NXlMRmNXTmdjZmlUUjhtb1h5Mmh0ZnRPMFJQSVB6U3pVWW1BOXc3dzROeXdu?=
 =?utf-8?B?ZS9xK1B1MzN5eW1BekxMTWVON2lzMnZXRjQ3bDQ3RmJ5WHAxeGEybDJPZEdW?=
 =?utf-8?B?bEYvR082Wll6M0NkMjMzdTlBQzN5c1dQZDZqYWY2bVFkVXo3U1dtVllFWXd1?=
 =?utf-8?B?WHl0ak9HbDE0R0c3TGd4SmJOb21FRFkxTGZYMkV2djhEb0F1T1Ava0hGUmVD?=
 =?utf-8?B?QUVzaHN2cUJ3QXovWU11VzYzM285RHNjUkh4K0ZWUGcvaWdrbDBMeDlqR3pj?=
 =?utf-8?B?bEJOamJTcVM0ZmtYQm5rZUFFRk8wcEtCUVB0alRYQ0tzdkEzU294dmZBcmkv?=
 =?utf-8?B?K1RZc0NUMEF5MU4xTVFiSWxCa2pTaGZFcEwzazN6cEI4V2NMeUlKalpFR1R6?=
 =?utf-8?B?djF5cEVIU290QkpKTzlQOFpQczRYQWgxL29xcU5lYmcrVDhKVUNrVXdPTC82?=
 =?utf-8?B?L1VVOXNQcmJMM1Z3RmMrSzFrNVBCOTE1VFh2Qkl2WE9TRk1nS2U3Vy9zZ3JP?=
 =?utf-8?B?bUNGdDZRcjZCUmgrYnRzQ3l6TGlYWUF4YzRZZjMxUGFGK2lRUHZvSFlQUGtZ?=
 =?utf-8?B?dm8rOUFlaFlXK1NGTG1tSm5BVUMvY29zWEcvclp4aUUrWXhpem1WQUQ1WDdh?=
 =?utf-8?B?bVNpWHFJSm43MjFiS1ZMUDFLd2FGaWFkN21EWWl3U05ySXlSWTJRMHRkelRI?=
 =?utf-8?B?L1hyNDRBNnFMOEFVeWJEM2VUVWFJTzZhRWJUZWlBYlMvYWhQdktJNzVBeDVZ?=
 =?utf-8?B?aDFTdlRtTHBVU21DcUkwL29pZytETXBjVHlXalhSc0FYU1lxRWM3OG40QWp1?=
 =?utf-8?B?a2lCMnBNR3JqY1FaT0Q5T21vL04xbEp5VUhGVlBUc3FoTk1KbERrVWxZeFlq?=
 =?utf-8?B?UmZYVG1ybnM4ekN4Y3IxUUpWSGJGbStId2ZxcHRvODNxMkQvNnEwcDRqeFlI?=
 =?utf-8?B?Q3Z5NE85cTdtRUk0dW1Zd2FnK3lpTWRkaVFiWk9ZdUtlNDRzWTVhSnN6Z2xU?=
 =?utf-8?B?STBmRFJib2pVVXBuc01oQXVJSTRxTXJYOHlKN0pacW5DUStpaXB2THhJTmNS?=
 =?utf-8?B?VkpOakZ6TEFZQzQ1R2JUekN0NnJVNldyTGhNZ09BQlpZWC9yRStzVDNFaDV1?=
 =?utf-8?B?dHQvRGFxajJ4Tlg1bTZyNWI4OHJwVnJrQjErVTd5RmhML1JIbG16RGJoalNr?=
 =?utf-8?B?U2J3VGlHOGxVcG5vNXIzWHB5TDlySHYwMGRzSzBZeFBkelp0ZHZBMnU3Zi9O?=
 =?utf-8?B?U3ZCU2ZhZlRWbmRyV1pmYUtyeW5mRHN6djFKRklPbjhFVDM2U1hrY0IwdStl?=
 =?utf-8?B?L2pKNHlXMGJEUllhaFRyZmdUWHd6cjViK0JHNThMZVJKU0tEUHllSjhtWTZY?=
 =?utf-8?B?Y255cXRBVS93U1VZMEZ1TlpWamJFNTFvVVBtdmlpdDRtNkQydWw3Z2VmSk1V?=
 =?utf-8?B?QXNGUTMwQ1NoTkF6V3lkbXZETURrNWZ0bG43MlhzZDJ6M28rM09KNk5OVCtk?=
 =?utf-8?B?SCtaUEVmaXBDWFlDUmVGL0NiY0ExZ3VzZW9QTmxJWHVKVEN3QSs0TTdSMnlE?=
 =?utf-8?B?ZjJrZCtwbU1tNnVwVlhRSVBqYm1VVUxUdGZQZjl0bXFEVVRiTXFaVjl0bkpr?=
 =?utf-8?B?K3NXSkREUFkrbWVLaFcxZklJcCsxMm44bXFXWktISC9mWXpFdkgvK1lETm5G?=
 =?utf-8?B?MWxVUlE3K2lXY3NlNTJadXpQMXg1cXhGa29mZHZsaEdFaVNBNnpVUkc4UXQ4?=
 =?utf-8?B?RnJjQk5pYjhTL1UrNW1LQ3BPU014Z3QyQmx6SHUrZmQwL29lc0EwZ1lrNFVu?=
 =?utf-8?B?OVJjT0Z1YkwxY1R4L1ZaczB6bjVuaFdGV1NabXhGWTJEZnVLZi9TajY3Qk1s?=
 =?utf-8?B?VUplZVZBSjNYYjkydlVia0hXWm5qL0ZXbEhoVWQ2ZG9DT0tnaXpVcmZDZzlK?=
 =?utf-8?B?OVBVMmx1YjdVckptUlNlUU9pTkxVc0VhSXlIUXF6RmFvODZ6WWtjKzljeDd1?=
 =?utf-8?Q?yOsFQFVUzB4cdSw5mbK6EcOk5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1172423c-98aa-4a40-c25d-08dbae30f0a5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 16:55:42.3448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KCCaIaAUtbmkY8pLiJm0wfOIKVOfz8jdYKS47NYoEGushOGytKZ5jBmT33WPOgsvau0kjPMrDt/Zb/blwAIRBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5178
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Thanks for reviewing. I added response below.

On 8/31/23 13:51, Dan Williams wrote:
> Terry Bowman wrote:
>> Restricted CXL host (RCH) downstream port AER information is not currently
>> logged while in the error state. One problem preventing the error logging
>> is the AER and RAS registers are not accessible. The CXL driver requires
>> changes to find RCH downstream port AER and RAS registers for purpose of
>> error logging.
>>
>> RCH downstream ports are not enumerated during a PCI bus scan and are
>> instead discovered using system firmware, ACPI in this case.[1] The
>> downstream port is implemented as a Root Complex Register Block (RCRB).
>> The RCRB is a 4k memory block containing PCIe registers based on the PCIe
>> root port.[2] The RCRB includes AER extended capability registers used for
>> reporting errors. Note, the RCH's AER Capability is located in the RCRB
>> memory space instead of PCI configuration space, thus its register access
>> is different. Existing kernel PCIe AER functions can not be used to manage
>> the downstream port AER capabilities and RAS registers because the port was
>> not enumerated during PCI scan and the registers are not PCI config
>> accessible.
>>
>> Discover RCH downstream port AER extended capability registers. Use MMIO
>> accesses to search for extended AER capability in RCRB register space.
>>
>> [1] CXL 3.0 Spec, 9.11.2 - System Firmware View of CXL 1.1 Hierarchy
>> [2] CXL 3.0 Spec, 8.2.1.1 - RCH Downstream Port RCRB
>>
>> Co-developed-by: Robert Richter <rrichter@amd.com>
>> Signed-off-by: Robert Richter <rrichter@amd.com>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>  drivers/cxl/core/core.h |  1 +
>>  drivers/cxl/core/port.c |  6 ++++++
>>  drivers/cxl/core/regs.c | 35 +++++++++++++++++++++++++++++++++++
>>  3 files changed, 42 insertions(+)
>>
>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>> index 45e7e044cf4a..f470ef5c0a6a 100644
>> --- a/drivers/cxl/core/core.h
>> +++ b/drivers/cxl/core/core.h
>> @@ -73,6 +73,7 @@ struct cxl_rcrb_info;
>>  resource_size_t __rcrb_to_component(struct device *dev,
>>  				    struct cxl_rcrb_info *ri,
>>  				    enum cxl_rcrb which);
>> +u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb);
>>  
>>  extern struct rw_semaphore cxl_dpa_rwsem;
>>  
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 9151ec5b879b..da4f1b303d6c 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -979,6 +979,8 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>>  		return ERR_PTR(-ENOMEM);
>>  
>>  	if (rcrb != CXL_RESOURCE_NONE) {
>> +		struct pci_host_bridge *host_bridge;
>> +
>>  		dport->rcrb.base = rcrb;
>>  		component_reg_phys = __rcrb_to_component(dport_dev, &dport->rcrb,
>>  							 CXL_RCRB_DOWNSTREAM);
>> @@ -987,6 +989,10 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>>  			return ERR_PTR(-ENXIO);
>>  		}
>>  
>> +		host_bridge = to_pci_host_bridge(dport_dev);
>> +		if (host_bridge->native_cxl_error)
>> +			dport->rcrb.aer_cap = cxl_rcrb_to_aer(dport_dev, dport->rcrb.base);
>> +
> 
> Minor comment...
> 
> Is there a need to gate the discovery of the registers on the ACPI
> setting? For example cxl_pci unconditionally enumerates the RAS
> component register block but gates *using* them by ->native_cxl_error.

This is to prevent RCH AER and RAS accesses in CXL device driver if CXL error handling was not 
OSC enabled. Would you like this check moved to immediately before the logging?

Regards,
Terry
