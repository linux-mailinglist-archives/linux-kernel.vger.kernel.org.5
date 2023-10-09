Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0677BEBB2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 22:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377872AbjJIUhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 16:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbjJIUhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:37:06 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD9C92;
        Mon,  9 Oct 2023 13:37:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IO+5Prsc3qBFmk7TJj2fprzTTWqJk52QBnMleiv2f4toEXibROY3HtPkqArcfyrYQocg/Ztlk2J3LQKkl9FF50KwwgHo1DrQUbZ+m3i8Y0n7Bj5Z8N5nRF93m0Xsz4+Lmed7blv0OLBGh/RjWz49N7IXiwCM6pRGaSrUl/BWkgIjtq+Vap+iXA1Nf6jnn8FrTMKCvbEYDTm6NSrcR5Bago+tTzTIbck/nGahehtPo0RJbP8ckCv23g44f99ntPkx493gchQI++PUoa6oJ8a6vOayGiQZkUhuReg4zqS3wuH2PMPZ/FTnYtJkWzv3ug0MKcCkLaej5JL2jsvMT09MLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRBcnQrZFFTbIdmvJNTTGUVjYCghxDN+Z4xKMnByDsk=;
 b=BRbYpAN+0v1bxJKM7B/jEpYZWY8HqO6d+UYx8DHulQeAbo2G71u2QLCwSQQFBmOt4DOGKg+amAy/BS09LDaR8aRjEt57dKU1IJvUsuGkoP8/+nGr2WDBNKx3q9KBLCBLdyr0fZHJ/QA5RTPCwoKmH5TXAu5HAqazSpBjx2mHGqjJrrw0w/Rffjrbo1jgsmSg6kF6NzdlEW2nFUJHK9FkHmz/E/ynCBNYlXIo67R8gJ23ZN3gycUON0++ZXfYqPBM2GkKRfQAL4eeHyNUuFnF6Tn+ipKQozQ846u+smoRO4NkbatHo+tI6a86gXDjr4RXdXHasJWs6sNnlYNAPyB0vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRBcnQrZFFTbIdmvJNTTGUVjYCghxDN+Z4xKMnByDsk=;
 b=wBgj4K8RylcMprMqSJrYfGYO2Fn2rBASwjcx7YJnF4A1VM0TrXClZ2L2TXI/tSvteCX/ToIM3WEWY0sa9dn7vLP6RzlEXIdFPxkbMe5n9hoc+i6W4pB2oDDVD2YMAQsUbuQcPMOSBIKJzPr0IaSZNARq48R9vuBQXsWRhfx04as=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA1PR12MB6113.namprd12.prod.outlook.com (2603:10b6:208:3eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 20:36:57 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39%6]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 20:36:57 +0000
Message-ID: <5a2b672a-a933-4909-b8c1-09b3bd92bd9b@amd.com>
Date:   Mon, 9 Oct 2023 15:36:54 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v11 04/10] x86/resctrl: Add comments on RFTYPE flags
 hierarchy
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
        mingo@redhat.com, fenghua.yu@intel.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        paulmck@kernel.org, akpm@linux-foundation.org,
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
References: <20231003235430.1231238-1-babu.moger@amd.com>
 <20231003235430.1231238-5-babu.moger@amd.com>
 <20231009172207.GQZSQ2vyKLm660U5o6@fat_crate.local>
 <c794d06d-1954-470d-bd3f-b8c73a32dce0@amd.com>
 <20231009195150.GFZSRZ1pl+KFBao/lK@fat_crate.local>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20231009195150.GFZSRZ1pl+KFBao/lK@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0104.namprd04.prod.outlook.com
 (2603:10b6:805:f2::45) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA1PR12MB6113:EE_
X-MS-Office365-Filtering-Correlation-Id: 45013eb5-182b-4fbf-4fa1-08dbc9077b70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: buM7zWBt7MHYY4dy+QMjMduhRx92WDd5PvoW/FgoGgzc+OjojWtURWPo1rq8zdSLFO9Sk2Rnz9b+4im/ABT89LBVqOA+H/rHBuGAOAByk/YSrxhd1I6R5AsaajgUD3qNX1vwqXN/i0gjuE4spDnfGMxojakdDXn22xkSR+k1CeVpxH8bljyBWCKfir0wwB4SH9jNMh1e/WoJ1bnsGAanZ0EDIjWjXDxhTz3o/RkACtUwZA/NqexFT9vwwjKIOQeiMPE86WGldh/yi4ey1Pxa35WQ/THMTslrvoo89RMdgCzqYZpWJDTVoG6lYHiLgedIoNG2ogEsZfgmV0kabzMXRu5HI3XmNzFl086tjor+t7lsa02A0hlpb/k0yxbZi7oh3KITV1+4VGvRKh1anakDv/2x/Ou0GasJf+DFaWFObMGhyGh5FmSVAWKIL75tjKa99+crEl5H49BhvnfeB3GAIbpP9OADwutfpeq9CZutq9kwYzPbRUtKFUI2s6xBBITyRPr3phdJtLTY7z0H/u52J0TQU+2IZTTmJXT01ivfAFP/prPbizjB+0klrl03uJ0DZrCYZKIi1geQvdi9sST0Hz6csxMssje59mylONN9RlOPgHF5gdZjwp2GZ0T63fefu8Rq5bbWn8P+PY1w8KNYDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(366004)(136003)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(66946007)(83380400001)(2616005)(26005)(7406005)(66556008)(66476007)(316002)(6916009)(7416002)(4326008)(6666004)(8936002)(6512007)(8676002)(5660300002)(6506007)(41300700001)(6486002)(2906002)(478600001)(3450700001)(4744005)(53546011)(36756003)(38100700002)(86362001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHN2d0xLcXNnOFBSdGJSa1lQTXpLM05GTWIzbGg3SU9RR3JpOWl6NUFUNXQz?=
 =?utf-8?B?UnlTTk9ZU3N3YW11NW1zdmZXczdWWXB3ZFlmaGFYT1l2c3RyR0ljVXV3WEEx?=
 =?utf-8?B?a2lUNlNBQ3FpY2tQeUY2RUI2Z094d2hCaktQK1JsNG83REFtd2dXZVVoQjVu?=
 =?utf-8?B?d3U1K2tSSVkxeS9jcHdiOS8rdDRGeE91S2dXaExCWU44UHhNWmJYUnZ0dE1h?=
 =?utf-8?B?Q25lOHRkK1hUeTR3VzU1eUZ4UFJQT3preWRNMkxHR3crdFhQcHAwV2xRU0lI?=
 =?utf-8?B?bnpNdWVPa2U4MGpNTjI1ajdGUXQ1cDJLN2JRM1JxUVVDQ3FoUlVmSnNrRTIy?=
 =?utf-8?B?REJDaEpvNkNkZjA1b1dEZUlITW9zeWVVL3ljZTBYd2ZzcEJ1dnJNTjNPaHNa?=
 =?utf-8?B?d0s3QWVDS2VTbTVmUmduSTFZclBYRmtZQlhvU25BeTdHWTdDbVVWOXpZaTNG?=
 =?utf-8?B?WmdVTmV1VHFQMFdRcTVXK2ozd016NkNObnJmaHRJN2d5b2FOZDE4SkZRd29V?=
 =?utf-8?B?WTNvQWFLQjZqQW9zQW5nYURBWEd1Y3RlYlkzOGNHZUhDaHhKOVJJajkrdkp3?=
 =?utf-8?B?b0xNNGJISEwzV0hRZklWcFhGUWgxQmJkSzdWbHUyVHFvbFU1aFh0STAvMkZq?=
 =?utf-8?B?cjNDSnJaNGVFeWtibnJ6OGlVS0hZbzFGYTZlSDdwQU9uN3RGOUNlVXhZTUZs?=
 =?utf-8?B?NkU5bTE3b1dDeFRqMEhjN21YVHU4SCtUVVhsOUpqYVpZejNwWmRrcjNkdHZs?=
 =?utf-8?B?Q3VzY2wzVDdFOGJFYjM1WFVadi95WDNRd2s1Vi9jNjIxYnJONFRTbFNuQVky?=
 =?utf-8?B?dVQxb3FOWU1tNkkrKzJyWXJHWnYyeHhrUnFKMFpsNFduSndhK1lpVy9rdVUv?=
 =?utf-8?B?dXI1TDgrNkw0c1ZlMVRNa0tLaGJjbHFESG1ic2ZTbE4zQ1NxaVlhNlJNVTJr?=
 =?utf-8?B?aHNCMXJMc2RSeEdJcG1uMW1lL2VoNUZrQm9uRlRHVkxiSURHTGdlZWgyNSsw?=
 =?utf-8?B?d2kzdGdxWmxFdnY4ajFrRVhJSnU4akkvbUZSOHJpbDNaZ3NiM1FXZGx3TFh4?=
 =?utf-8?B?RG1JRXdhU2dyNTV0Lzd5dEZZSzlGYUxQZVlnQ0Q5T1U3cGdBRlBZQUthN1Ay?=
 =?utf-8?B?Qng0WENDZjM5cGkydlRVN1E2SjRDUFBUK05ncWZPOHpCWmhpNWhvM3FaeFVn?=
 =?utf-8?B?YUxjaGZDdEhUS1dQRGI3UjRKVzR3enRmTXN6emlOeWlzRnNPQzkwd1dNOTN4?=
 =?utf-8?B?Z0JqOVZ4bU4ySEJjSmJ2cDBJRVdObnRhR3lZVGtWZ0FvV3RBZHdlYmgxaTRl?=
 =?utf-8?B?dGV5b3BoOU9FbFV3cXh0SWlXRFBpZHU4SVRFRFRrZ1lldW1RR0dGc2hTY20y?=
 =?utf-8?B?M01hRHd4WXFLaVdlTGNYVURITFVtdGV4VW0waFZ1UUY3LzNLeGJXdWdqNGZ5?=
 =?utf-8?B?YlRYTER0dmxpclh2c2VrQ1BCL1pJdzZVbWtIbzJLY3IrVWNiV3dkZk5xZHdm?=
 =?utf-8?B?dDFoRkovQXhDUzRvd0Z0bUk2N3V0d2QzUkhhUGtiVkdLNGEvQVErNjVHWXhN?=
 =?utf-8?B?RTk5WkJtT29rZk1xUStBalVQdCsxa1FhdGtDR3paV3FzMjYxL0E0dklhLysx?=
 =?utf-8?B?QUxQVC9oUTFxTVhFWUpyRUpDdWRnUFVKbHRkajlRQ3VpS2JOTlB5L3dBS3ln?=
 =?utf-8?B?Um9hKzVxQlhYbTI5NXAvVmo5djNKdXgvRWJDV0tJRmJQR0lKbG5nK2x2bjhF?=
 =?utf-8?B?NWNGUUpqa2hWN20yZzRtZEVEUHdDOEtBN3lySUV2elBpZXFzMzhXQXpUV1hx?=
 =?utf-8?B?ZTFMeDBubFpmbk5FV0N0cjBjR1gyT1dDS1lyekEzU1pXeU96ZG9aRVJ6N1pJ?=
 =?utf-8?B?Vk9TQjQ2ZlFBU3paYkNlMmd3VmFvR0s0UnlmZUVoOE5Mb2lTL0JIZ1ltR2xQ?=
 =?utf-8?B?WDZxb0tBUnlOMEtqelVzUHpiZFlRVCtlVGZ3OU9velU1MGhsbTk3WUxjSzZz?=
 =?utf-8?B?S0xTM1BDalVrT1lFMDd2ZFhzZUVManR3Wkl3TGZWb0hEd0F5VWZoS2QvT3F5?=
 =?utf-8?B?SGdIcHB6WXJ1T0d2Mlc3Y01yZDhFbHlxU2t3QmN2bUNsbUFDYjNlVTVwVlV6?=
 =?utf-8?Q?2cdk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45013eb5-182b-4fbf-4fa1-08dbc9077b70
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 20:36:57.7370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gDWd9hLzaOcuXWbhZjMFzlMmRIXXlqEbar9GZahBgUojo3fDOBo0UW5ZYlgJl71Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6113
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 10/9/23 14:51, Borislav Petkov wrote:
> On Mon, Oct 09, 2023 at 02:39:30PM -0500, Moger, Babu wrote:
>> User visible files are already documented in resctrl.rst file.
>>
>> Understanding of these flags are mostly required for programmers. Users
>> don't need to know all these internal flags. That is why it is listed in here.
> 
> You can have a section in resctrl.rst called "Implementation notes" or
> so. This way you have it all in one file instead of having programmers
> grep the whole tree for info.
> 

Will add new section in resctrl.rst to add these details. Will send v12 soon.
-- 
Thanks
Babu Moger
