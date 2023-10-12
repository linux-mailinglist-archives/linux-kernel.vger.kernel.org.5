Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670577C75D3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 20:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379677AbjJLS2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 14:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjJLS2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 14:28:35 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90302C0;
        Thu, 12 Oct 2023 11:28:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GA+W2ZI9uvC4ujUTNR9zU2yqFAnEMIikIzhs7qZGnPO80gwmtoGzpq/GtlZvjW9jS096MsVExSo94grymvw0lLqeQlSFd+MCFwkat6UGwdV/gy40C07FM3Iky7w31+W/d1HzwgEsfHwfQWgeEXyYz225EJksffsytay/1/LrC7JAx+IHZiRVN0F0GASX94dAXzoK8Q6vO/ALcoSMbQFDiEe2tpiDIB3FMM60xQ3RM3qLM7CF5r86TmTbzGAFYBAEaO7lImLYE/Z6KM0l32uW5md4/QNBn/kBHjq/Xapl2P75GuIBbCjSIu3ns5L8YkOhobERGNA4v+4XeD6VXlFZ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6MVe9hf3Ac1CLO0HMUBlJdTO1fT1fjE597znCRybBg=;
 b=FZQMqvE86aqW42rgneOWXbtHSkQkoSY2gQQq93Zh6vXYtidqkGoCZ3rJAFzEky5FpydAVkS55O+iYDHR/Sk8X9iRplIQBE3Np+/NQVhdDZot8hcV7OoH7jGNOqxsIZ5xSjbSlPTor6oAaMHcmtrq0zkqcRUrregwQXYXo7W0Xtlyn5Zv1bCtffDyBTpK8eaiV2jbK1G1cB7h8i89jQXMzLS9qIOwbcHVOgPGP0JMUDj/WM5x4l3B8O0tvv/x5tCIP1U058xPmS0OC6DssftXzh2O2Cjfse+L/hDBKsoA01HYNuTr23uN/aSdB4ts0ZRUD1F+ycaqAzTrMXSzMBpB7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6MVe9hf3Ac1CLO0HMUBlJdTO1fT1fjE597znCRybBg=;
 b=XWqt0Hl9EzpeekPtbdoE9ZELSW23zs//YsIDb8lT0sXbZ2gVeVgt8T+VOT7XfuX8RAqzQTPJggYaQb/HBGzTx8N9w+zeWns69BQYpk1T1N00xN0w5Ef/XC2x9OnzKrNxpH9klJ+7Kj66EnxtwXXknYVAKFCR0JQY9aCl17PTVoU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS7PR12MB8419.namprd12.prod.outlook.com (2603:10b6:8:e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 18:28:28 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39%6]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 18:28:28 +0000
Message-ID: <f7daa9a7-6f74-44ef-80fc-d0ea013902f8@amd.com>
Date:   Thu, 12 Oct 2023 13:28:24 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v12 04/10] x86/resctrl: Add comments on RFTYPE flags
 hierarchy
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
References: <20231010233335.998475-1-babu.moger@amd.com>
 <20231010233335.998475-5-babu.moger@amd.com>
 <71539687-13cf-405d-bf7c-27480e49e872@intel.com>
 <fa03a5ca-fb16-47bb-a2c8-5cc4d96e54a9@amd.com>
 <a02c0f3b-2258-425f-94e4-a76739a24f00@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <a02c0f3b-2258-425f-94e4-a76739a24f00@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0097.namprd11.prod.outlook.com
 (2603:10b6:806:d1::12) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS7PR12MB8419:EE_
X-MS-Office365-Filtering-Correlation-Id: 83c1a5be-cb10-427d-63fa-08dbcb5107c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lZ6E9+cBPDAgvN8QeaYepW6RsmYaaAEnD8n/EYO+97YhJl+hmOEfScDVnBWG8s4QTGufxcZtApL+0+f9HUrz8H6ahZXsNhxapGzWPiOEEvIYNX3VYyHpnpA1LshZsgtWFGjMVMs4cPxTXSyxVMC5L3azs22puGK/x4SoYx54I3S8EXe6niw6hB8bHxsfPouTexPuroYYgqVtNvZOfc0UK1PiM4FRZuYBSxYOA5FjIcYxJyci+abojNSb8LGwEXmMb3QH5fE+0ful8X1/6d/Q23Ra3JMhY5uX8QbDzVKQ/voCBixR2Jav/1Oskvkx5CX6e9/kWwNkj+MwGhMiISlKVL8281e73JEZZwgLkprcT/x2OJwW8uCWiTlKuSbBrLTKYRmFl+YQrl+7pweR6cfbrclmsfb/Sg3abaDnDabXBu2+YCb6F6inDmfGin5UIwL4yucUa09d0ma84toDlZtj0eVXa7wOXjq8lVcn5yimmfU+pZr0/Yk3YCkl9YMMz//qtN99F3kbK5dPkzIk3eiWYYPEgFZuWAKrl7RPHE/2PPzjk6ngnav3H3Rn6kAhJbmySGCVmT+LKBXY1kvOkZSW+6OFwzjwsIEKi6EX0zV7rPv9tl7IZT7X7kcpuun7Ghr/KvxYBlPq8ogXymFhh2gNMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(346002)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(8676002)(4326008)(8936002)(26005)(31696002)(86362001)(7416002)(7406005)(38100700002)(2906002)(4744005)(3450700001)(36756003)(5660300002)(41300700001)(83380400001)(6512007)(53546011)(6506007)(6486002)(478600001)(6666004)(31686004)(2616005)(66476007)(66556008)(66946007)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVE5MXplejhia1JpbENEblZvZGc1ZktxbjhOMFlUQnZoUzdZTjAyVTJWUXZn?=
 =?utf-8?B?WmZQY0xCSzB4SFJ0am1vbWVvRlVQNmhDcDJEbFErRWpFaFU0azdSL2RwS0lW?=
 =?utf-8?B?YVNoMzR2Y3ZzZ0hkc056RTJKVXJrQU1RSndPVnc2RHEvcHZJN01YSGFOYnV5?=
 =?utf-8?B?aHZRa3owcmlydGxvREh4dW1NWDM2bGRuZTM1Rkp1T0gwOTFiT2gvcFZJYkI3?=
 =?utf-8?B?ZGY5L0xQNS9yZ3FLaFdlL205YnBkL0hIb0dZTmRVSEk5bDlQQ2kyM2FjaTAy?=
 =?utf-8?B?WUpMUWFYblBHOWhKWlp6M2cvV0dQTG5sMmRPM280RWpTZHlnT2RkRzF3RkYz?=
 =?utf-8?B?QmkzUlA0N0FycEpaZ2szR3dFS2lneXhaUWkzQlA4c0R5UDQrbWp6Q0E2L2dl?=
 =?utf-8?B?VHhaY1dzYTQyRy9Od0Q4NGZGcEZMM29COTJYVWlZVDN3Z2JCVGxVZXJpVzZR?=
 =?utf-8?B?OUJqQlJFY3laN2dIU3hSbWovbFY4VlVOKzZ1dTdsYVhUMk1SSExQZElFRmNv?=
 =?utf-8?B?V3QyVFFzNS9JclBQQ0Vuc0d3WXpFWWFOZFYya2U0a3AvUGE0Y0VYMldGRWwz?=
 =?utf-8?B?dlNrVUxpS00xNjlMVy9WNDZraUo4RmJ3U1paVk1UZWMweWt0Q1h4UXBWMzRo?=
 =?utf-8?B?a0cyaGw4aGowbitBRFRITlRXZ0krOEJseWg4RnlyaDJEbHdUVm8rYVFmMXYz?=
 =?utf-8?B?bGdFSDRTOEUvV1hsdGNxWksxcWE5YW5wZVhKQ3hteW11S1RsRWZ6bGU2Um5G?=
 =?utf-8?B?VGJmVjhvSTFUWnJyVzdtM2FCR0JDK1h0L0VYUEU1RStwdnNqMmpVNk9KT20w?=
 =?utf-8?B?U2NLOHQ3dzNCbTFSMFVxSzlLd2NsUVVWK25mYXZ1NzVKWFJrR1k2YnYyK29Z?=
 =?utf-8?B?MnRIbTZmRmZkMzc0TnRzWDF1T2YxNDlCaUFrUmptaDRBbk5nUUhNVnE2bHlp?=
 =?utf-8?B?amxjaE54cTh4SnpwQ0lFQ3RHcWhNY0J4eHVWL2VQZllBc0pYRUtETW1FNkho?=
 =?utf-8?B?ck9CbStsemZKWlkrdCtmeFQ3YnNiVzlDRmFNdUJaeUNkelFtYXBZZFpLS2sz?=
 =?utf-8?B?RHd3cUhCdnRFcmp4bStNdWZzbDQ3VWV5T1dxNW5GeVJ3NGlvV01qOGlQZG5D?=
 =?utf-8?B?YUZsVGxZVzVIcXlpT3dvc1A0ZG1ZUStkU2tZRHJRZmNLWGJYbkd1U3JNbHJM?=
 =?utf-8?B?TUk1SW5ZNmQ4aWpVd3Z6SWJoV1NHL2Qzc0d6M05yNVBiVHJjUHVhYXpTQjZo?=
 =?utf-8?B?bFU5d1JEdGMyalc5NDNxTll0VTBIWTMwVWpyNFZEYnZBRHZwSXRzcVIwaGhh?=
 =?utf-8?B?M3N6TER2Y1FJenJmVStuVUE5TXpaMTFzcmt6UktJMy9wVGhMbXhnb05YMmYr?=
 =?utf-8?B?dnp1UldJelFGQm5DRmV3ZHJqOHFNWGZnV3A0bzVXU3pOK1pDVG4wRTRiL1pp?=
 =?utf-8?B?NUs3YkwrdXNpUU5RdGxIN1FqVG9VZUJhdVNJUlVoYVpuUjhTQkpiZzgwbWZs?=
 =?utf-8?B?eVFhK2hYOWJaaDg5ancrOSt3bWc3WXYxSVJ1Mk92ak4xelBaTlZHaE84cmlV?=
 =?utf-8?B?bE5jdWJ1L0JJczlqM0I1eVBQRHhDOGt0UnI0bTBJL0lkbkRzbzROME1nK25T?=
 =?utf-8?B?cFlQdkNCWlJxT0VFYzBJK05hVGdIaEp5MFg5dlMzakZ3MlhoUWR1Qnp2N2pR?=
 =?utf-8?B?WUtuNThUVFBlTWdxOExIT3VxK0puWjFGS1VMeGpxNUdiL0Y5ZlMxTHZ1dWRz?=
 =?utf-8?B?NTM0WU9sOW5hOG8vT04vZlViTUV6M1dlL1JuTnF1bjFmbDlScUlCdmFFekF4?=
 =?utf-8?B?YWNTR1puZCt1U0FHZW9uM3FlUnNzblArZWxydDFuQWUvTlpNdDdRd1E2NUZ0?=
 =?utf-8?B?Q0ZJdXdLdVNCNVBoRjg2R3BuTThHcmFyRWJXeU03NUlia0s4REovWGtRS1Ex?=
 =?utf-8?B?YW5yblQ3eXR5emhMK25UVEowYmNZWTcwYmozT0xIWnB4SzZvTzh3NXdsVGp3?=
 =?utf-8?B?ZkVRUDkrRUsxTVJlQVVaU3NyY2k0dkxKa1BrY1FsM3dYay9BaGtYdFkwQVgr?=
 =?utf-8?B?dDV5NEs5NUFYSGlyZkl0QVo5cnJsQlV2WmViWXk3NXVsa0RNTFB0Y3BvUGJa?=
 =?utf-8?Q?GXjU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c1a5be-cb10-427d-63fa-08dbcb5107c2
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 18:28:28.8082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fzrW1KNFUMYiNRGAcstdBMCeQAjE1fgBXxKSejWythCvt4kDqtcZ0yjIe2iyGJ+T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8419
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 10/12/23 11:01, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/11/2023 9:57 AM, Moger, Babu wrote:
>> Sure. Will remove Reviewed-by on this patch. Please let me know about
>> other patches when you get a chance.
> 
> From what I can tell, apart from moving the flags text to Documentation,
> there is only one other code related change and that is just moving the
> RFTYPE_MON_BASE definition to a later patch. That looks good to me.
> 
> The other changes are all in the commit messages and that mostly looks
> good to me ... some issues seemed to have slipped in during this version
> and I will point them out in responses to the individual patches.

Sure. Thanks
Babu Moger
