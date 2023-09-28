Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC4D7B1F63
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 16:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjI1OVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 10:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjI1OVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:21:53 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95475136;
        Thu, 28 Sep 2023 07:21:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QoEPrDn+6O9LPw5DmeoakGTPQnLaylbloNhS8gZd1sVNtI1S/CNa+jfse8LOz23jRmyT/Xy6GvD0CfDdP0BaiCG0GeDb3hiparrmd8bo97vlcU3tE5clnCU7clAzwY27sEqA31SchjWjDK4TNC7Rwy43NM4E+j8u+HnClz6ixtnujx5omA05eB1nQ5Wtk8B4Kq6preGM1WK/Gdf2hSNfm6YSLhsG5qLtDSIN1z5ba1ywwolsRFWiVEO+W+K3FmrkHJPDs7G5h1zFapIkx8vmr29QJVFO6hHFP0GfbAaqJXG6YIy+cV21rqAAe5PkiZ//C83JHq4n0q0dHnBjhMxYHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWeWghAEWrSwXvfrX7ykRjqvZDMfY6juB4TTXuXh9b0=;
 b=O4rOTglxSzVRN9/lpXvzNBFx6WcmlG2+0T2zfDwI2vzGFqPKFWsyU9FQBe3Klwk6ZRDdTxHl3aDTjHU+yL0DOwhmgzc360oMHwCBDyNOoH5dmDBcSSo+0OOjwrSCC+no6xMTphegr4D7o5c4oCTFTrY0FycN+7FKX7Mn1v1L10wJbCGnpu9qlymT07ojsT2u6GSFsrrUDuhUR3myDVCQ1Vq49AnQVWpPgi9AWINb50lbYDCVlvtqKpr+WFvJAq7F6Fvcmeo+opqZdpmsynRYPbL7DH41jlfwF/SdWGLU7gGWmWlY3+aPqR0DKWdrqsmW77RusP65AO6covYFVer9OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWeWghAEWrSwXvfrX7ykRjqvZDMfY6juB4TTXuXh9b0=;
 b=KNejgG5h6g6ZXehyNAsTT+8Nq6Mt3eJCkzXDolr35KQNdNBpC3S0+WbAETYvyvAbtFEoKAtD8/fQtWoUtquBpVErgXGgelfLnBfTVdNHluqyc1g9mcOK2bhOc2GLnvlo5CZE406oLAiYAUoCtOmyFLecZN/NagqXIK4qDjbBd0w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH0PR12MB5058.namprd12.prod.outlook.com (2603:10b6:610:e1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 14:21:47 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6838.024; Thu, 28 Sep 2023
 14:21:47 +0000
Message-ID: <22cc26fd-3631-b048-e243-3e5373fd3655@amd.com>
Date:   Thu, 28 Sep 2023 09:21:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v10 00/10] x86/resctrl: Miscellaneous resctrl features
Content-Language: en-US
To:     "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
        "'corbet@lwn.net'" <corbet@lwn.net>,
        "'reinette.chatre@intel.com'" <reinette.chatre@intel.com>,
        "'tglx@linutronix.de'" <tglx@linutronix.de>,
        "'mingo@redhat.com'" <mingo@redhat.com>,
        "'bp@alien8.de'" <bp@alien8.de>
Cc:     "'fenghua.yu@intel.com'" <fenghua.yu@intel.com>,
        "'dave.hansen@linux.intel.com'" <dave.hansen@linux.intel.com>,
        "'x86@kernel.org'" <x86@kernel.org>,
        "'hpa@zytor.com'" <hpa@zytor.com>,
        "'paulmck@kernel.org'" <paulmck@kernel.org>,
        "'akpm@linux-foundation.org'" <akpm@linux-foundation.org>,
        "'quic_neeraju@quicinc.com'" <quic_neeraju@quicinc.com>,
        "'rdunlap@infradead.org'" <rdunlap@infradead.org>,
        "'damien.lemoal@opensource.wdc.com'" 
        <damien.lemoal@opensource.wdc.com>,
        "'songmuchun@bytedance.com'" <songmuchun@bytedance.com>,
        "'peterz@infradead.org'" <peterz@infradead.org>,
        "'jpoimboe@kernel.org'" <jpoimboe@kernel.org>,
        "'pbonzini@redhat.com'" <pbonzini@redhat.com>,
        "'chang.seok.bae@intel.com'" <chang.seok.bae@intel.com>,
        "'pawan.kumar.gupta@linux.intel.com'" 
        <pawan.kumar.gupta@linux.intel.com>,
        "'jmattson@google.com'" <jmattson@google.com>,
        "'daniel.sneddon@linux.intel.com'" <daniel.sneddon@linux.intel.com>,
        "'sandipan.das@amd.com'" <sandipan.das@amd.com>,
        "'tony.luck@intel.com'" <tony.luck@intel.com>,
        "'james.morse@arm.com'" <james.morse@arm.com>,
        "'linux-doc@vger.kernel.org'" <linux-doc@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'bagasdotme@gmail.com'" <bagasdotme@gmail.com>,
        "'eranian@google.com'" <eranian@google.com>,
        "'christophe.leroy@csgroup.eu'" <christophe.leroy@csgroup.eu>,
        "'jarkko@kernel.org'" <jarkko@kernel.org>,
        "'adrian.hunter@intel.com'" <adrian.hunter@intel.com>,
        "'quic_jiles@quicinc.com'" <quic_jiles@quicinc.com>,
        "'peternewman@google.com'" <peternewman@google.com>
References: <20230915224227.1336967-1-babu.moger@amd.com>
 <TYAPR01MB633074E7E850F680927780F68BC1A@TYAPR01MB6330.jpnprd01.prod.outlook.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <TYAPR01MB633074E7E850F680927780F68BC1A@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0092.namprd04.prod.outlook.com
 (2603:10b6:805:f2::33) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH0PR12MB5058:EE_
X-MS-Office365-Filtering-Correlation-Id: ad1c5cda-d975-4f73-164a-08dbc02e3fdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cLxs6v+EFMn7armaz6CKIZyZSF+PmzXe50/gJ5OkRYZzi8c4yKds9ezy7VfBAL9bJ2WNkp5rthK4lOrzG4ZBOOYwWKCfuDB9rBEsH5UoV3ZqdNKHsFdwwn2cLbkbhK0cS2OVPQYmbPLiJRNAAH0dU018HRndb3HpjiSVyLVsrsOlbOwIZ/5h9sxafv44BCnzEf7jvRNihqmGQiOh04dH7gThJY7bdHvc/WYuUmnQ+w1n8GrXCPy1lWY/Q+Y3kaTrp9EHbtT1am8/HYbQDwcdBbuWDwhTRCZj3yuVQ5dyFqozXWbRMqiKns4etQONUcoMI1XjUlG86kZKdoMLpo4cX69GbCyyqPHPWTWjFyu5KLx0ST/0JDtZsNSgGqaqrCoi24+4BYHZ38G0WTuYJMecwc++Ks+ynu29+ZXkt8G3+r4I2ylgaRrzd/EtI1FcXI0+RsQj+Y5PdX1erz5ZrUgaRoTeZ9esHUqsgsINU2EA5/jQrBg4f7KMi9ZvNHN1xCX1rC4c7/TYv74z5otZNweqEAxzAIeOR1yuXoOgBsHEMWuFYukwqq7PBgQiXjuNRAY8J9Km9cKhOT41TyoKpHABZweaj61TqyP6fASeO1d3FDLtpbENcsFFjdlUfaazPNooIRImt4xw7CxObJGSdOmfrQ4HWRmALJsz3Bg79dLjTpc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(36756003)(31696002)(86362001)(31686004)(6506007)(110136005)(478600001)(54906003)(66556008)(41300700001)(66946007)(6512007)(66476007)(5660300002)(26005)(316002)(53546011)(2616005)(8676002)(4326008)(6666004)(8936002)(4744005)(2906002)(38100700002)(6486002)(7416002)(83380400001)(7406005)(3450700001)(491001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDJzQnp4MWNZRVBQeThGOFlVaE9EaGVnMFhZekQzamVWeE1wUHJVVG5hb2FQ?=
 =?utf-8?B?OXMveDBPYVBmVjJXMzQ5bXFidU5CMzEvdlh6eVh3cGFiYnNYQzhIeFk4VnFC?=
 =?utf-8?B?aVNtMllBdmpQVDVNbUNDclUvQzNvQnk3Q3lzL0s4aGVoc3FMTVFXOW4wSnNj?=
 =?utf-8?B?SFA2TlFvaVVFanE2VjJyRHlyZ2J3S0FJQW9Sdk82UHpycU9zSGNBZEpvVHBk?=
 =?utf-8?B?N0JJaFNUSTJaTDdaNDU4bmx4dTRPYm1WekM1MU5rL3oxUVJBUDRKNVZDbUI1?=
 =?utf-8?B?UkUyWm5kRDM5b1VGK2hGU3lmamJ0WHUvTkVtU1hzeS9HcjBxdzlpaU9hR21j?=
 =?utf-8?B?ZTRpVTdBUXlneVhEYThocFoySHRXVHV5cnNzakk1VE1mdVYwZC8xb0UzSzRC?=
 =?utf-8?B?NjNVd25jc1Z3bVdTaWpQOUxnbkdDYzcvOU00SVowQU9nalIyZlBBcWtIdUxY?=
 =?utf-8?B?elV2RUo4QmpqcTJPQVFyN2lyZ0ZXaEZNWEl0RkowZ0Vjc0dUaWxWakpoaC9w?=
 =?utf-8?B?UytCejVPK1p3dkRDYklkS1krRlh2UnNKVmErSEtFSHE0eHF2Skd1YVRONHh2?=
 =?utf-8?B?dGswOUcwbnhDTjdiVUREY1dRU3dHNTdjUW53eHpnSE8xMStrRjB3VnRXZE41?=
 =?utf-8?B?cThKVndJN3VFTE8vN0kyTFVWSm11M1h3cUJVeHQrdCthQzNxOEcrRjRXaWQ2?=
 =?utf-8?B?bm1hREdMZFRLOTRjOU1QQ04wekpBNGpubzVPeUE5NFpsd1pWb0piWndOREh6?=
 =?utf-8?B?QVo5VUpIU1Q3QzM4UWFzZE1PZzE4bGRaWXIrdXFyN1BrVHdEOXlVUThZeE5W?=
 =?utf-8?B?L1RtTFlubGRKZ3NHcVhKdGVUMmlHbFNNT0ZyTXJTV3g5eVNoMmRwbXlqNytT?=
 =?utf-8?B?ZFdsOUtnZnZnWUJKWVJ3OWJRVklzUGVSUnExdGxzZVRLbGFmSjVRTVlBK3RZ?=
 =?utf-8?B?TDRPOThkRkRidHNVSndweVJEOFRNakdEbjlBRllUYnNyeEx6bkhTTko3YUIw?=
 =?utf-8?B?UE1xMnZjOElOb0NJaXZaYnBKV0NIbkNOdTFPUmZMMk9iZUNVS2JvNDZwTDJZ?=
 =?utf-8?B?bXVjWXVEM0hudmRkN3I4T2FQMlZOQktKTVkwY202REVzUmZWSENZeURqVWRp?=
 =?utf-8?B?UlZDdTl1c0s4K05zMXdXTmRDajlSUGJIUkt2U1l5QnF5OHFVZXZoc2lYUGVO?=
 =?utf-8?B?aHg4VVh6bTQwV2Q3VklRdTdDQXNVK3dGcUVKWE54bWtpb3lMRHN0aGVpTDc1?=
 =?utf-8?B?OGUycGtHWCtaN1YvQ2kwdXFOVEFtYk9CTVJFN0c5eTRlcnp3OEUrUWVBWTRV?=
 =?utf-8?B?dWtqT0F6N2xJSG5CeXgxOENPS1p5Z2VKSVBPR20vMmVjY29XbGhpVjRwSTBZ?=
 =?utf-8?B?bmNYbjVuSnB6ckhCaVhFTVJzTlBjeFB2OG9NS3AwS3lreHpWNzVmTGdMaG8v?=
 =?utf-8?B?eW4yQVFpSkpYT0MwZk1DOHpSUmdzaWZmSmhnTy9BRGQyQW95VzdsOUJnSXRk?=
 =?utf-8?B?Y0hpTWJYK1ZscHNTMUpFdXY2SHM5SmswWXlGWnBsWmIybUtoTytoUnRIRlMz?=
 =?utf-8?B?VE5BNTVQcG1YdHhuZC9tK3NCdGdMQkxhd0NWNWNidlJFVGFtYXBjTlhYcTNz?=
 =?utf-8?B?UUpTNkR3VlJYRlN5cnlpcnRxakVWZjZtZDlJVGZXMCtnZkUxZDc1ekgralph?=
 =?utf-8?B?c28wVGxDSU42UFY0M0xXdFMwc3NhbUtjQUpwZ0h2NTFvNS9KcG9hSmUxQzhJ?=
 =?utf-8?B?ZXpDRTNWZFVqU3JRQ1hlQ1NYTFNsRFVDL2x3eU5rT0txYnZ1OWhMdERRV2pT?=
 =?utf-8?B?cHVIdWZlb3BJV2tmb1hpL1F2TFVxRDhnd3hmVmFrTEROdWQxZERDYkN6KzdD?=
 =?utf-8?B?dElQNkRjNWVmeHFWWHorK3JQQjNEWGs5WmhSK3E0UFlVUWdvUG43ZHVsSDhq?=
 =?utf-8?B?a003L2JRZFd6RVVidVIvNGRmWEQ3aDArYlNIRSt5TjhqZzRJVnBnT0N4a2Yx?=
 =?utf-8?B?ZW5hZGxaUVErbC9VaGp0aHl0NjY0VkN2UEFtTGRaUFRWWGt1YXVLbXdPQXF4?=
 =?utf-8?B?OXZNejN2RCt0NmpBcWlMK3k4cjU1MnlDSEUxSklnQ3BFalI3RXVzUiszby9a?=
 =?utf-8?Q?cxNI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1c5cda-d975-4f73-164a-08dbc02e3fdd
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 14:21:47.7001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: STiP9otLz25nwuUj0pdZWvzw6pBgD4v/28D+H58W/GLwo3S5ZaUNReaPyQXc4CVI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5058
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shaopeng,

On 9/28/23 00:28, Shaopeng Tan (Fujitsu) wrote:
> Hi Babu,
> 
> I tested these features and ran the selftests/resctrl test set on Intel(R) Xeon(R) Gold 6254 CPU, there is no problem.
> 
> <Reviewed-by:tan.shaopeng@jp.fujitsu.com>
> <Tested-by:tan.shaopeng@jp.fujitsu.com>

Thanks. I believe the normal format is "Tag: Name <email>"
Like this below. Please update next time.

Reviewed-by:Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>


-- 
Thanks
Babu Moger
