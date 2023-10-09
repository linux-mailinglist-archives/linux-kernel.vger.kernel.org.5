Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5B67BEB1B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378525AbjJIT7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377401AbjJIT7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:59:06 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C06C94;
        Mon,  9 Oct 2023 12:59:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BsrenA5z+8Q1vmRP6UNqGUUh4+5NJdOuZlkhCSUp7LCIzIxIwYomynXOjI2gwh2okBOzS9N3YD42PDfaWT/tRKe+hYY9ayQeBfIKNFq+/s9kuC7uOkNmma4oGPd0vfHkoDDiZf/QJ3yj9PHSIIMEtM4i6VvnXgyU7ZV0fAjs9KL9NAzvfdBxopRpzRuM7qoA9k9+h4DeC15aCauBTNcIeolZAFVZx5Z8F+Gu3bcZPBYjMrSGFKV8JcS6xylXZJaAHJ3nO1bJDv/Vkl8ZTp0gVNXTrQbBvE9WnJ+Tn/3/oQPX9p5eJ2XZs2Woim5vubfQFbfUUNiu+rsdQy38tfWcdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5M8EA2tP2tuVFb7Zah9WxZBn8q66CaymKcxtqKiFBg=;
 b=Vk6f01hK9VeFomqbcSe3Wr6UcylV/Ksx+2U8mra9yHYBjIVdfYxDU6rAmSxNeVT5p0LdT1puzQWXYLXkhjuP7n98WFYgw0UQprr3I/UgZhXyt99Z8I4+9aFJBcgNnsdBQAbx2ssuqFN+x01nFHH2icnA/R4cXZGgdHQXyktMZ2F0jWwqZJ9KfqUb5RI6RpWRsuDcg8VilZWFihDwjxqyp5SAldzaHYReRhh4zwnnTycT7obQJE+NUIUgLJ7QN2d2VRED5k5M8X5MufyhCh2QH39FPQ2Shd6tVxl75gSI8v3Er3XP+u5m5rzhZE60e+EOHzxYvgmUtt3lPfj91puPRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5M8EA2tP2tuVFb7Zah9WxZBn8q66CaymKcxtqKiFBg=;
 b=2uZ8q9U61dZqLC/14cHYIl9VSK+8DZvRO6rQZwCGGzl4Gm014LcO63dYc1boEujYUFSUB/cvUJkZIFmc3MpyUEGWHM6i5687G80cx9TkxVO883umFvUz/LKcQQCwRST4N3PP0nhEFKE6u4K9pDoOLigdRUGcfMq7ADcMtaJrZ98=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS0PR12MB8317.namprd12.prod.outlook.com (2603:10b6:8:f4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 19:59:01 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39%6]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 19:59:01 +0000
Message-ID: <3369d0f6-8da2-42f6-a579-c8219d13b0fc@amd.com>
Date:   Mon, 9 Oct 2023 14:58:57 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v11 05/10] x86/resctrl: Unwind the errors inside
 rdt_enable_ctx()
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Cc:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com,
        fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
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
References: <20231003235430.1231238-1-babu.moger@amd.com>
 <20231003235430.1231238-6-babu.moger@amd.com>
 <20231009172517.GRZSQ3fT05LGgpcW35@fat_crate.local>
 <51277249-2351-4933-98d5-2cb74a14c7dd@intel.com>
 <20231009192340.GEZSRTPE9b9hOtu0JJ@fat_crate.local>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20231009192340.GEZSRTPE9b9hOtu0JJ@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::28) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS0PR12MB8317:EE_
X-MS-Office365-Filtering-Correlation-Id: bae8d280-af32-4b2b-38e5-08dbc9022eae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VWgMwYGkeaMBTCuqrwHFSNj3PxkJxx0ZR/TrgeC/k7GjjVTEVUqw2BKCA5e0+vStRBbDVdlb/C299w+fG3rWruNA3sv1OAdq4emOrHCAsDVg9x/hdECAwClRTPgHt+XJZqwH6o6bWPSdWq57h83ofZDRy/pFOixF/TwvovdPOg2yE/RRn78/AjfV17wd5GlaXlC9Bao02c+9kI3bEc4LyhwD+rFofQAtJw+yjzzjMfOF6lXYtlfQph9iqfSoExyuPC5tiMFkTU26vnQ6/+sx/zP+dLdD4tB7LF0sliXKjgExX5qmGSxlc10aFy3B0s3gVWbrobBrOSARCphllgz4xSPsfoMeu4UdP21j90kBisYVVYoay2givRTRncfvasko8paA2sOHoem40RnJS8Jh3TF5oIpMNBomrdwDix3Lg1IsPYZQd7yJhGxFetZiLQoax1p7zLvGz/Xf2TpqTNvnwwcze0l6xfOosGNZLtdTyi8YU2Cx6kwYFK5KdUbGbYx8jYQpeiRaRY6+G3evFrQv/3CjcvVQflZeXcGVdHLk8J2fCfEQRUxJ/tWzpRY5kwaSj27Ho4C2Qs3pOUODDcB1phc8xsPZtXzWAtBszlVe3KxblPhDxkhp8cB2WcgGGA8j2dkT+kyZmWsgOdhKAGraTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(346002)(396003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(31686004)(26005)(2616005)(53546011)(31696002)(38100700002)(86362001)(36756003)(83380400001)(7416002)(7406005)(6506007)(2906002)(4326008)(3450700001)(478600001)(6512007)(8676002)(6666004)(5660300002)(6486002)(8936002)(316002)(41300700001)(110136005)(66556008)(66946007)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tmszd0NITW1SL1BTbzhGcHNPRm9TR1RWc2loWHZ5S1JZR1ZJbytRZTAya3JH?=
 =?utf-8?B?WFFJc0RzZkpzREdFcnN6M1lsRmJINnkxWS9kTkU5QlRTaS9FZTg0UFZZN0ZW?=
 =?utf-8?B?cVVGRENqcTNUeFZ0bWpkcERhWVpLSDd6MGl4M3VlTGQzdE5nUE05dyt1MFN4?=
 =?utf-8?B?UlI3RFM1MXFmbGo3MXc5dXN5cldacDNhbXF6WWhBclF4MlF2Q0lQd0IrVXkx?=
 =?utf-8?B?dVhVR2t5K0IvVEdHYnl0Yk8ybDVEK3RlSVRNTmZwcHczTTloNCtuZGxHTncx?=
 =?utf-8?B?ZWdWamdiSmZpaGl6bW9DZ2VLcFpmc0ZPYnd4bE02TENzV3Y1VWdNazV3SmFC?=
 =?utf-8?B?SnQyanZ3QVg5bHBSNTZEWktaMDFBSXdLTW1VbmVVRlBTSXBYcDNVWWlNQ3Fn?=
 =?utf-8?B?bW5LMkFGRTlTZityMmptcm82WFVTdlc1U2cxT01ObjVHT0pxK0F3OUdsbGZi?=
 =?utf-8?B?Y0NIbVlQa0VhQVltZEpkK2ZoVlorNVJBMWZYT1duRDZwZDBoeWFPdjFFcDB4?=
 =?utf-8?B?V08vVkNxYmV4Zm5jdm9vcTZML3ZkdjNJcjJUUldQZFFCam5NSnNDYkNxV25V?=
 =?utf-8?B?eG85VUVKZHNPRnV6Q1pUK21hTU9yM3JOc2FSTmJvcHo0eU1MNlFmc1ZHejhJ?=
 =?utf-8?B?eWo4R0FFR3dpR3BMbjlZYTBnTTloTGN0dGZHSkRKODJKUGJua0U4Zm16ZXFm?=
 =?utf-8?B?dTg0OTloZkFuVWJ3ZEJVTWVlZ3UzbmpPcjFGS29idnJ5anpwM2Y5YVo1aDFQ?=
 =?utf-8?B?dlpvYVlTRWFKTHBqVjd5Umk3U21yTHpCczVFOGdpeFVGK0tlbzBtbXpKOWkz?=
 =?utf-8?B?Rzd4dFZBMFl2djRPblR2b2xNdDB1RlNoN2VrcVU4RXN0amxoRkMvaEkrc0ll?=
 =?utf-8?B?bEw5MWRuVlJLaWdlaTZYMHhHdHo3YW5FYUllYlJWdU51TWxrbnI1a1BiZFlS?=
 =?utf-8?B?MnRRM3N0SUk3VVNsa3NXaVRwaGw3TzZSZHZLU3BzUDh5WXdrYVc1N0pxc0pX?=
 =?utf-8?B?KzBHcDVpWGNOMkM3U3AxMkpzUnFvRmhWUXEzRldSUTFHZ0M4dlpNQmI0aHhX?=
 =?utf-8?B?SmlmSkxrMGZTaExnQU1zM3NLZWdzWmJEaDFrQ3VyY0lHUGNvbnlJYjAwemxn?=
 =?utf-8?B?NmN2TnlYQ1RLa1dCZmFwRlJFclNOMFcxYVBPaUV4a0taREhwZjN6ekg2K1lL?=
 =?utf-8?B?QngrOEpCejMycW1YKzRNZitvWUVmSXJhN1VtTVlsYVpESUNuMUE2NFcrc2ds?=
 =?utf-8?B?NFhaWmM4bkZoRlFBUE1RdlFaZEpxYWhxNFlZOUdzM2w5OWptUVJSU25KUmFv?=
 =?utf-8?B?bjNmSmE1SVVUNXptbWFyY1k3QnZoaGpUUXpJMzNNS21ZZlBML1YrVG83VU9l?=
 =?utf-8?B?UCswZ3J0TnBNSktNbitleTk1aDBrK0paV1QyRDljelFqVnRsajI5K3pBNmhX?=
 =?utf-8?B?NXVYVHp1RXdsRnhRZXFaN0NldFZ5cWpmNGEyVmgwTGNoeVZzb0hkKzA3dkRY?=
 =?utf-8?B?UHVLdjloV3JhdTRaZHNVUTNQclQvMmNpQ2tXZDAvdTJSWUpjY2JWUi96c0pI?=
 =?utf-8?B?SEZlcUVudjJXc2R3NUhQcUtTRHBRcjdBN3Jtdm9lcEliMVZTMnQxY01yMnlB?=
 =?utf-8?B?aC9QQWRJRlp0OWVTRTRyaWI0NEN6azA2Q3lBdUQrdEFtWk5UdXI5ZmJjWFAv?=
 =?utf-8?B?Q3FmU29ZSWRkdzQrbmsvUWFmK2NLdXpsZmhtTXkrU0s0TGFzWklaZGhmVHpm?=
 =?utf-8?B?dVQvaXNTV3p3SWpsbGVWWGlDeHJ6dW9pY0V2c3NpcW9Xb3g2K0pRS2dqV0FO?=
 =?utf-8?B?UWlCcEJMZG10T1FvKzJEc054aThRNTNnMzl1N2M1MjF5K0xYUHBnaDNabUF4?=
 =?utf-8?B?REZrcTVzUE5ZOS9vaGFCeHhIcmJTcVVraWN0eTlPQlo4dzVOZWsyT0t3Sjdt?=
 =?utf-8?B?SGNIK3F5citjdmRtWmpBRCtOS2UvOUJoeVJIdGV1eml3S1BKVGFjdk95bkg2?=
 =?utf-8?B?UHQ3MWhiRE1vTVRyQkFoMXpKSHdzaXlST3RnaGlYNFN5dDRvdXJxeERzTXZx?=
 =?utf-8?B?bS9xaHNPZDFHY2JTa3pVUnh5dTRnWXJTY21rQ0lseTBwSW9HbG4zb3NNVk9i?=
 =?utf-8?Q?dI3Q=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bae8d280-af32-4b2b-38e5-08dbc9022eae
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 19:59:01.4866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8HxhP+BYhfi9gBeaqfBit7n/WpsDgZqp16Mx8Dl3v7fAq6orNYjK1kBe23XmzMvo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8317
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/9/23 14:23, Borislav Petkov wrote:
> On Mon, Oct 09, 2023 at 10:59:27AM -0700, Reinette Chatre wrote:
>> Is it the fourth paragraph (mentioning cdp_disable_all()) that is annoying? I
>> can see that it is redundant. Would it be more palatable if the fourth paragraph
>> is just dropped?
> 
> Yes, basically you don't want to explain what a patch does as that
> should be obvious from the diff. Rather, it should talk about why
> a change is being done. Sure, sometimes, you need to talk about the
> change in case you want to highlight certain aspects of why the code is
> being changed in the first place but explaining in text what is already
> visible in the diff is not very useful.
> 
> I always give the example about git archeology here: put enough info in
> the commit message so that any future reader of it can understand why
> the change was done. The "what" of a patch doesn't belong to that text.
> 
> I hope that makes more sense.
> 

Sure. Will drop the last paragraph in next revision.
-- 
Thanks
Babu Moger
