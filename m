Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3217A6793
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 17:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbjISPIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 11:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbjISPIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 11:08:23 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84F2BE;
        Tue, 19 Sep 2023 08:08:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLdeljhtbgCK4hpZgF+WrZltIZdCYMhMNAbjjcnQeCTDjOQ6Fr+3EWCPYvQY5PXCsB2LecKPRoTpI2urQ9vlSCoXqjgjDK1xT5bNnEolsujUcJOHX/C4ilUchk8XrbXhdQh9J1NanR5W7hHrqFPUU1isQcZkgUW/WifSJ16m28tD1J+7RnSTmEc3Qppm1DvzWo/AQihxDLVWCPhkBV3nRv/jLa93mmFtww4XzdEIwzxdyPYxcRQ9yFpnR7EH8E2a2CaIixx3BsUt3Gzf8ZDqOVmQgLU6quZ+4OiLPyhq4swH4uPEw//bcItlwBJAHUYXbK3jyzQgVG9IgML6my//BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAlMbrOY1Ti72v7BGT1BXGVI3MNsaXEvV4JB6CgEC7s=;
 b=ZUcrX3EHSjz9DCreRkXXHr34QCLsP7zwIrQF6SOAI6TVu3uIWa/+MkGQ36zVnLJFGPJZRpMG/1f1IRPLj3ZpgthEeBpFzNl0JPTsPhIf2UL5+QSh6HjuMcbNR02mtuDrDZSBDjnKmWQ6zUPQMu9kpmsyL18jYmeE2MG0WLUqrfY8tsnpOrlqw7EvZHmd+sm2fUDHg8T6r3oyvd2E/Ihz/MQfEb9O82GoE2ubYMmi/t0TPHwmfOWxNjrg0sT3/3qq0YK3EGNOisFUepMSmfDySQGi666xa6Oc1wUMrwVTYS6fyj4bZbEWO82Zp0ofKJTKjLzX4wS+XDkDGo7oBY9eHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAlMbrOY1Ti72v7BGT1BXGVI3MNsaXEvV4JB6CgEC7s=;
 b=hwkqxcbsa1602cEMuN0i7lt+uhCmIY3LVU5+rPOCV/TFv3OhKQi1ZbTNDGdIxl2RnUXvx/EOCLtAb+lpYdgg+SOu/l9dgB98R7uq4sfDbIxJQDRMOrfqLIaqKoZ1S8IZO8zFayP+82MQIV06aDBoJJR2nQHyjEB/WlLKH1K5isE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH7PR12MB9175.namprd12.prod.outlook.com (2603:10b6:510:2e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Tue, 19 Sep
 2023 15:08:13 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::5b90:dbf9:e0a5:64cc]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::5b90:dbf9:e0a5:64cc%6]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 15:08:13 +0000
Message-ID: <f27f685c-6b53-8955-735f-e9c0c04354a5@amd.com>
Date:   Tue, 19 Sep 2023 10:08:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v10 12/15] cxl/pci: Disable root port interrupts in RCH
 mode
To:     Dan Williams <dan.j.williams@intel.com>,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
Cc:     rrichter@amd.com, linux-kernel@vger.kernel.org, bhelgaas@google.com
References: <20230831170248.185078-1-terry.bowman@amd.com>
 <20230831170248.185078-5-terry.bowman@amd.com>
 <6504a5e23cee9_d7cc8294b7@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <6504a5e23cee9_d7cc8294b7@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:806:21::21) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH7PR12MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: f6548868-d04e-4d85-9b07-08dbb9223e58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f8Ewvv+9PeWb/Qo3mOdePzifV9UwK/1ojbLviszxXSt1ysRr9LBXg+qUgyPKLcUF6KScNEnV6oAg8ijnj2uUtbWcTXgxkF5XOMihb7uaJz0J4CMFm8mHkl9lfL4diOSCSGqg+x4QO6D3lDW3qVEjgztaE8d6z1MZT0SPeXgfEjNgv8tf+vCI51FlaIQsuBwaaoKBnwEVAzvX+0+Yw4OmaFk7L7rcxC6heQsUjWjs1QTKC3uOMdgZ/gRCchCkX/5tS+9ojxbbxc3d/9VmX/waO/tkITCMvZy/L1LrYG/HIITvze6aACOMJ+Cvw9m9jaq8+8DvOz/2a6OEbfzZym53Hwbo7vM7uCE7icCBs4uaDmVVRzf5qIcTgWILLYJfTyIUSHKcPhuZBhioRI3FFTuzpW4rh/REzIyC5r1FBCoJgcKzb65xKtzXlbnNHXyYpjS3bTqOscVI9QXMSCI1YrrNsTZoc8H5DLRVyphiOax1nredvpKsGftGSLyW5sDbTvRDy4cHZg9t8ucu85Xr7RNj8SpMXSDnY1p7juQ+YkrHxjWEb7LOik+8ax6cgywGfTYXRx65Xm+M2Q05TxvwilBc7avBEXRXqjmsJDGCVd0mkJC4BXtt+WxZrAKaI4t3GIQkYrWvJ06TvNHrhI+urBbfuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(39860400002)(396003)(1800799009)(186009)(451199024)(66946007)(36756003)(6486002)(2906002)(6506007)(53546011)(26005)(83380400001)(478600001)(2616005)(8676002)(8936002)(4326008)(7416002)(66556008)(66476007)(316002)(41300700001)(6512007)(38100700002)(31696002)(86362001)(5660300002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXhjTjZmUzBCM2xRa0pDa3lTdkpvQXZvZW40K3ZGOUNPdFhWbXFSOU1xTm5R?=
 =?utf-8?B?SERINnVyQVVJcXAxZzRHVVM1UFJpVnZINk0rT3ZzcG5RMUU3ZUFuMFUzN1dv?=
 =?utf-8?B?VFFQWFlSSU9xdndOOFlYaEJXR2s1eWxpWm9KQitQQStORDFrU1BMdHM3WVM0?=
 =?utf-8?B?SGY5R1JucWJVZ1V5MFFkL2xQM040NEFqMHgrMWdRckZySEk3ZVBaMHdmSDFD?=
 =?utf-8?B?R2VxUWlIZkhEbFdUUWNrZFhxV1kyRjhFRFlqVTF3eFZiakZadnQxK1JPT1VB?=
 =?utf-8?B?ZmNseWpSK3hxMXVnWU5nTUhKcEVWdzhrYmFtTnhhSnpaWFJHOGZaaFppQS96?=
 =?utf-8?B?UG5TRXNqelZjVGduWDFVWmtucDVsZnlVVXVrdmQ0SWFYdGVSYytDT0YxdjF6?=
 =?utf-8?B?T2xZVkNDWFpzUmFqa1E3WmhyWnR0RHA2QXZKNFErU3lqZ3F4OTRrWVEzSm1Q?=
 =?utf-8?B?ZUZqOFJ5NmhKZGJMVVp0bWZEQ1hQWlRRVmxRTW5LR3RDams1eFlSdXkvWGpw?=
 =?utf-8?B?SzZvTUxrY2xqU2M1ZDk3b1J3Sk9Rb0ZsVS9WWUxZWi9iQm9XOXIxYnhtSU82?=
 =?utf-8?B?cU9xaGM1NnFGUjMzWXVuMUQxcXgvVXBqdXpYZENLNTZ5NmszbEtvZ1BEWDBj?=
 =?utf-8?B?MnJKbkVtVVhSOVUwV2hhNU1qbCt5VUJsZS8yc2gxSEVQNTFuMHpqaDFrbkE4?=
 =?utf-8?B?RFQyUGNMMG93Q292ZDkvL2FMUm5WQlZoQWJ1b1BnTkFJWkcyQ2VWd1VFTVd2?=
 =?utf-8?B?T0NCNjFaOTBpWVFrc0FKQlUwU1Fadk5MNDB1anJMVGpIUnZFaTNGYnFXby9P?=
 =?utf-8?B?STUraWJzMnhlYWI5THIyUFhyU1UxMVJ0eWRFMm81VTlOOUNFWUxzR3AyWWdH?=
 =?utf-8?B?b1pFYlo2QjZjekxtdzZPVXNjOEFJU2xtVUthdkZjUGpMdUc1U2NvQ21WTEV2?=
 =?utf-8?B?MS9nTVZKTlJUeG1JN0t2VFhJWnJmSzZtWUFualBDbmR3TktRVlhvWjloSXM5?=
 =?utf-8?B?S25qMjhkUDcwc2NteXV1RTI4MlRzN2c2Vm81YW5CclVJL0I3UFdGRWk5dVFq?=
 =?utf-8?B?blh2VmJaMFlFdDEvSGNwb3pHa3VmaWxDd3o3QVJJNnQxbjJCelRtdUdKbkli?=
 =?utf-8?B?R0ZLVnBjM0ZpUFVPVC9nTEZaZGhHT2dpMFU2dnhZUXoxNVhFbXFXZ2lMZDl4?=
 =?utf-8?B?U3g5TkJvbzNtWWc4V1hhSjFIVncraWF4RFJRaTRFZ3hvaVNoak9RMk5NbmxQ?=
 =?utf-8?B?b2MzVlljOVFuYSs4Y3R4eVZMS1dIWnhNaGNCMm9tRWQ5NzlDSU1COENqVFZu?=
 =?utf-8?B?Y2YzQ3lQaWtvSGVGZkhFbStCL0VCc3Bqc1EyQlVUTFZmSXQxUU9xNUZwOWhM?=
 =?utf-8?B?b2UyaFU2RnlOY2F5MWs2MHJibFFTdkIxYXdxZlpqdkQrcFpBYXVucHoyR1A4?=
 =?utf-8?B?NlY0enhRcGs3MzJNbHNZeER4aFZSbll0VjJGdkhZby9tQnZ5OUs2dWIyM0N2?=
 =?utf-8?B?L2piRTNUaExETERFQ0IzT1NoV0JpLzc1aHJadXZnSkExcmhmZ3pDVFVRajR0?=
 =?utf-8?B?YVN2WE5FT0g5ZUpueVRWTlZKQ2xwbFc4NUoyczMzM1d3NHBXak5SOVpBdXBE?=
 =?utf-8?B?TE9zeHVlM09Fc1QxUnhkeGpxUTZMbWoyVjV6VkYzU3NpdDJZRzViWjN3Nmda?=
 =?utf-8?B?bXI5RkpZYlFrWnIzTm1VVDMwbjdaTUwzWkRrbmVjaFRtWkgyendwNmpSUzB5?=
 =?utf-8?B?MkJGNXd0Wkxlb1YrQmFsMXlJdnpBVjQzNTQrUFpjTFFETUZJN0xwSHFsMEx1?=
 =?utf-8?B?TXlHT2RIWnVHb1EvRnNmRzQzR0tMTlNVSFlBUTBZVUtGWk9LUkFmUFFMamVX?=
 =?utf-8?B?RTVhTDh0US9rOGdWVjlNUEozdWFNUkk4aXRnTithbzJyeldnRml2OTh1UDND?=
 =?utf-8?B?TGlzN3VTWkN4WWFFalJtbTNZMUZVRTI3MU1xL2E2cW1NcCtMNVF3TnF4QUtt?=
 =?utf-8?B?STZPRzV5S1haR0JQOHFSV201NFZYVWhNVW03VUVYSk1rdEtLanRTYkhEMTd2?=
 =?utf-8?B?bTVvVnRiT0pNNjNlNVVaaGFqOWhzeVpuNDh6WWtYRDBkS2tpakJuejJlb3Vo?=
 =?utf-8?Q?QobCCHwwRvRddUPctaNRdDFld?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6548868-d04e-4d85-9b07-08dbb9223e58
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 15:08:13.0438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uu+t8x2MRKosP0XNPpOEo+qLJW01Jwi43x7LArs1lhsQQtFKD2C2arI4OOPi6HBtTugxALuQlKMZ+mxPH9f7UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9175
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

I added comments below.

On 9/15/23 13:43, Dan Williams wrote:
> Terry Bowman wrote:
>> The RCH root port contains root command AER registers that should not be
>> enabled.[1] Disable these to prevent root port interrupts.
>>
>> [1] CXL 3.0 - 12.2.1.1 RCH Downstream Port-detected Errors
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Signed-off-by: Robert Richter <rrichter@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> [..]
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 2a22a7ed4704..d195af72ed65 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -1042,6 +1042,9 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>>  
>>  	cxl_dport_map_regs(dport);
>>  
>> +	if (dport->rch)
>> +		cxl_disable_rch_root_ints(dport);
>> +
> 
> Similar to the comment about cxl_dport_map_regs() not being appropriate
> in an enumeration routine, this also needs to move out of _add_dport. It
> occurs to me that it should also be undone on driver detach just like
> other device "enables".

Ok. I will move out of enumeration. 

Per the 'undo' request: This is a RCH downstream port (dport) with PCIe root port 
capability. PCI spec states root port error reporting is disabled by default at 
powerup. And SW does *not* enable the root port errors because the RCH dport is *not* 
bound to a root port driver (missing BDF, etc). This mask is added to follow the 
CXL spec precisely and if the rest of the system behaves as expected should not 
be necessary. 

I don't believe masking should be 'undone' in driver detach or elsewhere. Adding 
the 'undo' masking would potentially introduce RCH dport root port interrupt 
reporting which is incorrect for the RCH/RCD mode. Only CXL components (device, 
uport, switch) may reside under the RCH dport and never want RCH dport reporting 
root port errors. RCEC reports the root complex errors in RCH/RCD mode.

Regards,
Terry

