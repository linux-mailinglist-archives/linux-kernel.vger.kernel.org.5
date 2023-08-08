Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BB67748F3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236496AbjHHTph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbjHHTpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:45:17 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0DE48358;
        Tue,  8 Aug 2023 09:48:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UT+zRncNfuOjkkyZB2821QroLODw3MeNc+6v2rDCaf5XjN7YjjAudYwYLG8DYqABZD8VJubkiyHIRz4+aTH1LUWUkLmzn4tlJV0DLiAudEOWRccBU1LWS01GLgB5NejZAyiSc8nK5sxqqJw20DcJLJQtWedARXxffwpovhe442GNVyilKiQC4irEAF1vWH8eDSCPFvZdB8XHUgQ+ixSQAA+TPE9ZZnLc2jsoJsq9DojmKV3k0mtpQ6/j/Kdpl8utXpnp+i6/QuRbacOnAG/qjuKF+SztBHGOYizxTvuYTsAJSmqNcvqZ6CnuOamFgsfuvsamfV63/RLtLa4CcCQSaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnlJ6o0g2M7Zlye9Az5CGBGRHjsrklRbVR0Lc4pyamI=;
 b=EaNd7GFofs9KO71I6vSsSb/8zD3F4X26DUR7iQWaSyC3BMMuOob0IEKIP2nYS2RUSfRm7CzasNzrpWVc+UzATEtk4yOu9VR78oNslwIJfSCJGaSawUkCBO+HyKA1u5Hqc+LY/riymbbgeHddke1UJZpXv8F6/WPpDvGbNoV64LdEaD1HPFc8zmVjVDOpIGupr8h/+s6hztuKg8HQtfXgLb35mUIZpwd34GQw9ChulBjgtzlgTMdrdayxIj2NoK1ER+lVE2P64lRDh+kNeJkJjPgn6uzdJr1i9BeW8nZ8PJP7aCLQJoRrXblVdhKcEzXxJfG/mZ7l3DttvG8t7FIepA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnlJ6o0g2M7Zlye9Az5CGBGRHjsrklRbVR0Lc4pyamI=;
 b=EOyyGxEpgrx7apRFueNONb7NqE8YMtLG4hR4oNS8Vps9UthWwFfZv3irRxQj9pHV2nbKrBXOyZQ0rTYg4YsKgvHA4qZMDs9YZNB0SuRFcLnVJCzeZ9lsiU/woFXMyjWmsWkUp9vhpfYZyKbnrIn4a1SGHkDhv3brp3aPs+jyev4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ2PR12MB8954.namprd12.prod.outlook.com (2603:10b6:a03:541::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 16:48:08 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8%7]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 16:48:08 +0000
Message-ID: <b44eba5b-7ff6-2fb1-c8c7-f5636b8ad464@amd.com>
Date:   Tue, 8 Aug 2023 11:48:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v6 0/8] x86/resctrl: Miscellaneous resctrl features
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
References: <168980872063.1619861.420806535295905172.stgit@bmoger-ubuntu>
 <TYAPR01MB633070C2DDE7BCE94F3128E38B0BA@TYAPR01MB6330.jpnprd01.prod.outlook.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <TYAPR01MB633070C2DDE7BCE94F3128E38B0BA@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR13CA0049.namprd13.prod.outlook.com
 (2603:10b6:5:134::26) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ2PR12MB8954:EE_
X-MS-Office365-Filtering-Correlation-Id: e5b0bbfe-ac1a-4f4c-6ecb-08db982f3e43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ij7lWKjmNZ7XV+I6X+lsI5cGY2ZZWRSqzS3ronEOR1yNbXOkt28od5E72f5pVIvWk9adntW1lasu0RLlrcvzLskjC1Ql54VJTLLcPTbCtXjX4MVUGkN9rqd5LVSag1wKlIjZ2oTm0z2ua2xdClHJ+R/ngApJy3kJeOcCBf3msPpXbRqo1BbnywmTiStWr2pdqELJtxZ7vcvjhEwnomyApb8Z1ZsET+FDU1LfN5W6eTp2Kmg3hUJv4Xhd3SAFW5FI9fQR7k0ctRnT3WvvmgDDe/truqPxwGMt3qvsfr6DBI0QAnJosm1M8VtW5ARXtkSAlIHhuO8Qkaqm3x3PApvXJ6IlQF1ci3GCMFn9uqy1qW1EzXea64orhVkw6LeApvyjZPYNRrPp9DJGjlp88dIABvJsRxMvKJt5bL71yfvtJ2hHpjRp/nN9qmry5CXTB21e0DD+8xJS+VgUjndoOgfo9rapdE0XPZCSJOS/eX/dh/BgfufodPfsOUpBKbT6R7dR3fjBcKI0ZUBkf9oW9D0t0lUOIo9JDyk6BByOkSiITa+YOpxLdY4F76oUV947yaTvTDVUcGXBca8tOW1x8t6Vozm5G71OH5K0RRaIs2j4pg4yVt0EJpYGrwPUf5VoDM8bTRdycJqzVjpbmnpYQsZv1vyx8ubeEJauVHnBSWf3s5Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199021)(186006)(1800799003)(2616005)(6666004)(6486002)(6512007)(478600001)(31696002)(26005)(36756003)(53546011)(6506007)(86362001)(41300700001)(8936002)(5660300002)(3450700001)(316002)(7416002)(8676002)(7406005)(54906003)(110136005)(2906002)(4326008)(4744005)(38100700002)(66476007)(66556008)(66946007)(31686004)(45980500001)(491001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnVkcjRrc1Vxd3FrZi9oV2NFUzB1WW4yVTErazNUbVc1UkdZV0V5bXE1clJC?=
 =?utf-8?B?cU1xZzYxdDBaa05VUUlxeDgrYzJyMUVpUTBjYUxhVE9xRHNqeXJLcDdDdlAr?=
 =?utf-8?B?Y1BKQkw4UC81bU80ZUorMUF1QmlGZWdUNHVvS1lmYXN6SGtqY1JlNnMyaFNn?=
 =?utf-8?B?R0lhY1YvRVlYSWxHRUNnRkcxNG9XV2xTb1ROVGtWVGtsVk9Ya1pRbEcwbWhr?=
 =?utf-8?B?Zkw0OVRBTFFlei9WRU1JTzhOb0lVY2JzdTNWbjlETlZ0ZU1uRmFNNEZleEJn?=
 =?utf-8?B?blRmOENnU2Zvak1NT3ppMFJSZEtyeGlwSm5OVVJJWWhpT2J2ZVV0Zm5NNUdR?=
 =?utf-8?B?dEJSZzNNS1FXVUVHWlFQVzFFV0xIZGQycWVoNS9BL1lPNjFIS2dJSXRnbUVO?=
 =?utf-8?B?TWhrMzdqbzRKY1V3SUNvcEdMMmJlSk1ycDNCeVpTczJLZmJZdk95RjV0RkQ0?=
 =?utf-8?B?Nm5uR3lrR0VZSFI1MU9KNlNxMTlGbVhGYU5PNVAzZFNLN0txcDFTcUdld2Y3?=
 =?utf-8?B?QWlScUlvNlhPMGRJRVpFSTZiMWRrbGdNRmxGQndjZTlzVzBoSGRIbDB5YlE0?=
 =?utf-8?B?clBsR0NmMUJWeHRxb2dDNlZ2aUhac3RxeWVncWZJSmh6VHRxeG1CL2xlWkRl?=
 =?utf-8?B?Sk1NcVFHM0ZYSlduZVFucE93aFJUNDRDUnh5eS9rT1ZFdWJUWnMvMjBodTVu?=
 =?utf-8?B?QWVMcHo1SFdhQ0ZjZmIzWEpXYlBrL09waGtjVncvOHhTRExzMThxT3YyWXJv?=
 =?utf-8?B?dDZuS0JzVzVVNk9RaERiTklPdDVjeWJMZjNSRTJoZlB1ZzZDYkpJQWNFdFRP?=
 =?utf-8?B?clpiSmt2dTZqOWwyMm53K25GSkwyQUh3UnhTdnJ4eGticTBPa0Mwbkd6amVO?=
 =?utf-8?B?Q3dnQ1h4TXloMFZBNnpHUEJQbkpES2l1bkZKQ2M2VnF1cWZMQnhBbnJIK0NO?=
 =?utf-8?B?d1VBb1dpOTRnRnQ1L2g3aGhVZXRtWWRydEhmQ0tMT2I1YU5raGRQNUEvWHA2?=
 =?utf-8?B?SXIzRitmSzhTVHkxTG9RK05teUYwRW9OcjhncDNmNDVXMFpaV3VIZ0xKVlBp?=
 =?utf-8?B?WGVxUld3eHM2bHYzVnorZWIwZThRSlZXVE50TjJHcENSYnBLNjUwaGVIY1RL?=
 =?utf-8?B?V212OTZIZkdIOFNNQW1OR0ZUNDlmNkhZVGQrM1pkZDdsYzJ1M0Vvb0tieWh4?=
 =?utf-8?B?UlZLWTBIanMzcCtzdlJMR0VjVk5yYnlVaVI5aElGLzBmQjVKUm1pdFVNeDEw?=
 =?utf-8?B?V0FKZVB3S3Bkb2MwZGhHdXN6ZUJZelEzRDNmeDVsOW9FaGpodzJVa2ZJY0dm?=
 =?utf-8?B?Rjc5c0tlRzBLdDEwbWVlRW4zU2FEYUtvWG05djhOM0g1Zyt1TUU4VTlSTTZ3?=
 =?utf-8?B?Z1JjOFMxRlpPQzBuT0dPazNKU2YrTC9VSmJhalhlL2tyS2tHZk1EV2hMREt1?=
 =?utf-8?B?Ykk5NHlSU1gxZ1NlNmZXYmpydGIzRUVuUGNNOWMzM05xRG1GQjI2OW5GUDI4?=
 =?utf-8?B?SWF5Z0tXMEdiVG1kd2ZQMkJ2TWFRS05IL0JJRGdkSTlpSkhnMjFzWGNBZ1dk?=
 =?utf-8?B?TVN6c091b1poMUN0dmZqMUFiMGNTSWk1Q2M5TzlTM05oZ2R2SldlcTNOZUZh?=
 =?utf-8?B?dWgyM0FkYzJLMUJFcHRHdGRGV0laR1JGS2szSWRxRnpBNUFzbzNBOUVmNUNr?=
 =?utf-8?B?bGpHMjd2K0FjdnJuRTNzamRqaStIbjJod3cyUXV1blZtNGNVb1lzYWIxZmVt?=
 =?utf-8?B?T0RvRVArMyt4eWR5Vzc1UjBhQlBjMjVBVHVsUTh5TzkzQWd1QUEyUktyNjFK?=
 =?utf-8?B?YzY5RGZ5OXh5Q2RwQzBjM1N3Ui9xWlJzWlRieldRdXpZaHdtQTlMYmRJSFA4?=
 =?utf-8?B?cUcrM3V4Njc2b0wrbXZucFFNVWVzQnNhYlJ0UGo1Rk5SR2FrTGY5anZSN1hr?=
 =?utf-8?B?WUVEcTdIMjJXZU04N0x6ZEJ3bVY3NEVNYzg4RVdvNk9JSi9uN3dDRzBvYXRP?=
 =?utf-8?B?eDIxdXpZWTJCQ0NUMW5hblF6NzUwYXJPNzNQZk5uSFdhREkxYldOc1Zua0I1?=
 =?utf-8?B?TEZmSitIM014dlVZc1R0blFBSW1sclpkcnhCdFF6bSsyTmszNnNYU0FrN2Rl?=
 =?utf-8?Q?5h6A=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b0bbfe-ac1a-4f4c-6ecb-08db982f3e43
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 16:48:08.1436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ycHBshzsUKzRcAny/K9SiJFUkcaLz9OKt+K9BXxbkwzr8Mt/+dIGHGp47HIkSSJU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8954
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/1/23 20:36, Shaopeng Tan (Fujitsu) wrote:
> Hi Babu,
> 
> I reviewed this patch series(v6) and it looks fine.
> I tested these features and ran the selftests/resctrl test set,
> and there is no problem.
> 
> <Reviewed-by:tan.shaopeng@jp.fujitsu.com>
> <Tested-by:tan.shaopeng@jp.fujitsu.com>
> 
Thank you.
Babu Moger
