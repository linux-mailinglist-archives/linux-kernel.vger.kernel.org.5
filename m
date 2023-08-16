Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AC377E97D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 21:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345747AbjHPTPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 15:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345746AbjHPTPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 15:15:24 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CED52709;
        Wed, 16 Aug 2023 12:15:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nbmoozv/Xy7xZEcav7sbiTeEgkW7N4bGdPde0LA21HTFXcnP0H9wG9SaXNiDi+z0c29cTnbyIP039LKSvSYT9qgPb05T6PWOG1FrfLi7SEWrRsnpeGksaO20AaXVGn8pRsYgwCYEUCeFvAoopKbHusvISYNOMs7+XMCPv9bVSrRNMane/VSnccqjDMzUNOFXFDjMA7ar2q1rsgH5B//dPoxQPPZ+BY1wZ116dlRp/01u7iRKgqVPibKI8c0rxdvYE/w9hnh8nRMtpfr1iRTfqA/FehDEe+DbWBsxxSPTOpYGuIgWoGN4FqXx/f/yFBnPkRVF6V2B+v/UJVPXInDk9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPKPZz3dzSZ05iH1cA6nV2oZ6clIpIWaxEW4iSJHWPA=;
 b=l5ynhozAn3NiqM3IepvRL9sf9jy+4+cVT8gllFa5qzTU5MEtT3Nctt+bsz9ZwvB2kEiHzZAluQON6tELYMSDOdm/bS097dG4G6eGyhARqafpo/VOoK1z0TaTrZpFFPBEeK8x4koJuOQb2q9ZMIava3y0EH4O9fC+ngevUJy7e5snKlXqt/4PCkoX/0t1CcA/zyDxwM9S6thPFsME50ULZcv9lZhkEtd1lyuf0gwKneWEMZez7jn8DxIaFZYK4IiS+ueTuAUe8eC/3AbiXEsAf6JVmzAgIBXnbfDROKiiaAy8aZgUGGE0WxzXdI+/P9Ia1/gJPAIMWU8uGNAkm4MrSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPKPZz3dzSZ05iH1cA6nV2oZ6clIpIWaxEW4iSJHWPA=;
 b=RQW77jWT1WlGtAcG9EE5wls2uD4wRppX5qAU/FraI18MUF2vcPdK+b2GVP7z0ENSg8kidn7ityot1aSWC/N2ZeInjnCB+WbIUF+8sc1Zae86VkSlEX4iNeBwfZNMlA5CA50+riRvtvDmFiMWiR48duq4ynQzLTWYYxUZO31HNBE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BY5PR12MB5014.namprd12.prod.outlook.com (2603:10b6:a03:1c4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 19:15:20 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8%7]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 19:15:20 +0000
Message-ID: <307e6672-6778-bc32-c5fc-64ddc74de2cc@amd.com>
Date:   Wed, 16 Aug 2023 14:15:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 7/8] x86/resctrl: Introduce "-o debug" mount option
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
References: <169178429591.1147205.4030367096506551808.stgit@bmoger-ubuntu>
 <169178464934.1147205.6915303244307989200.stgit@bmoger-ubuntu>
 <820a0cb4-423c-ae61-79be-a134be9882bc@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <820a0cb4-423c-ae61-79be-a134be9882bc@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:805:de::20) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|BY5PR12MB5014:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d17f0f9-1304-4a64-7738-08db9e8d21b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wqZ4D1xVUI+JRmAaCfplq1di4Cvvy2C2949RhZ3AM9cazudB7VClVr7rbSU4MxJlbFQ8fG37LLfclWxjEuYut0KprYzJX9vMrzkTYCJSJODDOC8mUluzUwdOvC9kGY74O7+iTo/3dMni8zfqDxFim3xO1fB716Z8BYPayU5aYLLtWRk1Cr2CGFSYK0WQ/oF/7XeojQCBhl9ClLAARW7AMi8RZrzOhtCr30Cz8QkAEhhTJOFDz5hPcFx7D2ntuQauBnclwI8atMVw0/lKFv9pQHCpaGoP16swqF4rGOJsSOCB2pEpNy3Wr2xAALLEBxMlvG2gu8wS69A/8ELOllpXsFguZdLSB2gxVzcy68M+Wu5OKk9Nn+19kFl1RFNxImjnqZk6Qh61sBECij+BrS9MBkJAo55HoomWdt6W6F+uHklqOcaxU0ckvr7/oOQ7/gYaMR5v3wKTuTxaBneu3ydbpEwedaTOMZNJhJRKL5sAZeXqlbEVWFEiGb83yCbQnman3IT1NgrJ8J1LwNO64emRKwcjGQs6S4MtcMYmJn10b4r5wTbywnPaHd25L4rd49NDNMTWTf9tva68egmXKq5TOHzraxps/BOrxP8Ga5G6dOIXJwxPYiivV86zYHj/Lc65qbzRHree/l1m0EnSTf3MGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(136003)(366004)(451199024)(1800799009)(186009)(316002)(66946007)(66556008)(66476007)(5660300002)(41300700001)(38100700002)(31686004)(8676002)(4326008)(8936002)(2906002)(4744005)(83380400001)(3450700001)(26005)(478600001)(7406005)(7416002)(86362001)(53546011)(6512007)(31696002)(6506007)(36756003)(6666004)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkVES1BjdWg2SlpQcXNaWE8vNU5FUkw1YldZTm9ZNUw2V1pOZW8wZUFsSmFM?=
 =?utf-8?B?TVM3TTBobFVjYTJBbTY4T3BVREY3NVR1TDhRNm9NamU0NmpHM3lmREV1VmlE?=
 =?utf-8?B?Q1Ftd0lqeWkxWi9zaEd0R1lYa1FTdkk4cHE1d1FzWGczbEF0UEUwNEdsYXFC?=
 =?utf-8?B?cFloQVZUTWVYV1hUWWx0czF1YzFyUml6VitnNWNSVlVhdEZweEhMQktVK2Y0?=
 =?utf-8?B?bXlKaXQxUE1UZXBtak9od2tTV3hINlorVDVTRzlnQWdINDNKQW9LbG9ScUJI?=
 =?utf-8?B?bjJOWC9CV1crdEdXSU9KeDBXOGlBazBXaXExTTFvcGIrUHJTTDFhbTc2TWRl?=
 =?utf-8?B?R0VocFZ6dzlNZlFVOFhUUzFZSWNaa3JWeVRsQWNKZ0l2ZzUyODlQWEdtbFRH?=
 =?utf-8?B?aFhwcWRWdlZOYVk1aVRWeFJOWFZDaVRGVDEybkg2WTFRcEI0Vi9LSUZvWDJZ?=
 =?utf-8?B?Y2hRZER2OEwzTThTQmkveEgrdzB5NWhLVjdibUIxY1BpUjRmdG1FK2dNb2do?=
 =?utf-8?B?UldPbUk4d2ZFUmxNdTlQS3E1RUt5b2p6OUZ6bG0zMGwwV0JLSWh2cGl6ZUJW?=
 =?utf-8?B?aUtLdGF2R3ZtcEoya0NNZXVMaWp0VmdFMWc0RDlvN1JYU3NFR2dZcks5L0lv?=
 =?utf-8?B?elNXM3pydnkzMVl6cTlIWUJVRHZ1b1UvalM2NWxTNGdreWlUS255RFgveUZm?=
 =?utf-8?B?c0oySUt3OStlTnZBRVh1U0VxSUY5UVZxZEpXQXBrZG9Pd0x2Qzluck00WlVr?=
 =?utf-8?B?S0VTTWI1OUdEMms2cUsxRFdtWEVhM0ZvRlpWZEF4MjMwTFdYbDR4Y2JFWmxi?=
 =?utf-8?B?eHl2RUs1TDlQZlZac0JIekc3TzZXbWV1S0s4MVJ1OXlYK2xvWWhZUGtZaE0y?=
 =?utf-8?B?Mjkxa3N1VXVYMmx4Y0VaMlRmcFNxYnlCSVFyRFVNOHhsTTBjK0RUeE4vR1hw?=
 =?utf-8?B?b2JCV1VGd2x6cVpNMkp2MXJpdmJoUkJoWkVmWFhUdy9teE1FWmdLTUhCTzA5?=
 =?utf-8?B?RnljNFhjT0c2T0lEQUpScEFMbFZDVFFncjd1NTRvUUxwWFBIUXhSUXhnQlpy?=
 =?utf-8?B?NG5oS3QrUkpuVlY5MkNxS3JzNGQ5c1BRZ0MxVDV5MkVkYlhzaTYxTTF0VDJZ?=
 =?utf-8?B?Mi90RXJqN2Q4Sm9VZDYxdE9sbnZHQzNzeTdjKzZjUm5vanhVeTJrcEhXK2lr?=
 =?utf-8?B?THhXdVVPZDdUa09zRVI3NTNkd2VUN001UmZOQ0ZkOE9mYlBiNDFIRWdlQTdC?=
 =?utf-8?B?Wk03anF2czk1VlRGSEx3cGVlaVNFYnQzREFoUThnWW1wYlI4blBVcnRqL0l4?=
 =?utf-8?B?Z096K09hUjNPdCtlaUFsOU80bk9vS3lDUURDOHhSQXdMOXVkUjB0dHJoSFdm?=
 =?utf-8?B?bTFOQ0d6WW5DVkZZVE5PVms4RHNuY0wzeEp5aFRGNHhpQlNrUTYxd1A4eUtB?=
 =?utf-8?B?OTFtekFTSTFZdGI0aDVYczJ6VGY4NkVvUkpJWjdNeDhlcnlqV1RzZlpsUHpU?=
 =?utf-8?B?QmxBRjNJZ0EwM2Vpb1VDb2M5SVJXamU1RUkrT1lDQVhnclJmMjZaQ3ZINzd2?=
 =?utf-8?B?VzhkY3RVaytSbzVhMjhvME4zV0VrVitFL29uTFlBcnBtTnBWb0IyNk1WeGtU?=
 =?utf-8?B?R2t5MGl1aW1ISXB4VnpuNWQ3aFFnQVlncTN5czRlY01SRU0zYzVqc1ZrU0pk?=
 =?utf-8?B?UDNJWU5nZ3JROFZlWHRHbmRpRlVMTDRWODFGai8wajBQMGlISzF5N1l5Z0h1?=
 =?utf-8?B?N3BDQWJoaTlJZFNLblZKRjhjb0R6MCtNR281azd5VWxXTS9BdURQOGVjeFNE?=
 =?utf-8?B?R2NtTkV6SkQ3eDBFdHVBUS9KdGU3OUR3eWQzcVkvN0p2bldkRU4xT1JFU1Vx?=
 =?utf-8?B?OUpIczZQcWVYTXVwOGlLNUd6M2lNb1pSSjFLQkxMV1ZmK2paano0MXphZDRU?=
 =?utf-8?B?VjN5RTFoK2VZeGY3Mk1jTlFielZGV1l6bzBjeGk0cWxQcGF1ZnMwVFQ3R09Z?=
 =?utf-8?B?Nys5UTNxL05PSHZOd2l3aXR0V3JKT2ZhREZ4cVQ5RnZiM2FXUHRJQTZmLytL?=
 =?utf-8?B?cDJDZ1FMdDVQNXJFcEJwL0taWnpKeHI0bzQ3SERxYmhmMW11RUJyM0tmS3BE?=
 =?utf-8?Q?ETiA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d17f0f9-1304-4a64-7738-08db9e8d21b4
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 19:15:19.8613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 019jW1YnEUBUJT4rGznIZAMsYMvnNIic2exXE1MSZuEU8QPPPNqkWcjGfYTzbzR/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5014
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 8/15/23 17:51, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/11/2023 1:10 PM, Babu Moger wrote:
> 
> ...
> 
>> @@ -2833,6 +2849,8 @@ static void rdt_kill_sb(struct super_block *sb)
>>  
>>  	set_mba_sc(false);
>>  
>> +	resctrl_debug = false;
>> +
>>  	/*Put everything back to default values. */
>>  	for_each_alloc_capable_rdt_resource(r)
>>  		reset_all_ctrls(r);
> 
> This should not be necessary as rdt_disable_ctx() should already
> be called here.

Yes. Sure.

-- 
Thanks
Babu Moger
