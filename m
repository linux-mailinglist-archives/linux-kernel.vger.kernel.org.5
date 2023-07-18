Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0721757E22
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbjGRNuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbjGRNuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:50:07 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337F31A5;
        Tue, 18 Jul 2023 06:50:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oebZ4ZNXFPVFYQ4UDO5TikFgncNskJxukAoCEK+xBQ0KSMhmp89QnoeDMIoTYpwybbOHxAw3KszgpzKqpVePl8y0sCd0Ka22+pmDM9BkYDrQTJSU3fS9xhHwHiUmyfYkRZDK5CqrPE/jQlH1zZozV+h7y+puw8Kw1Gbp9iqLit14KZx4ct6J6L7y1og53n7G8rDYQP8C0YsSe01hB9Tj0nwpzRbRjdbxXnWxqeGkPmPi8F7To+LpTkoRkbmJguhBy2MOB97uzQlRFN/sSz8oyw4HPgoO+RVcKyj6JGeI1w2NgoFltNthb7tefIhnZfPuAKR5dqs2rbem05e+1GOOzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYdID+ysqHfqImTxnNrf1J2Wkyb/rRO/W3BNpQrQmaI=;
 b=VywN2BFdp8mL4hWzmgKSv2zZHqEAtCABf1TWY8L6TOEqfJcrWa8MrpxNxPevCErBxoFTybmYdYfKTElDwUks8jyffa2p+EWlERFLXGCa1UJeq7EZ2l8T8DKQZ7anTaZL1f5Vm8eg98yP4JpnIbRIfilP83b6Y47cQuyRUb59I1p4ZCmMebQSlTKAkKyyrVqbzKQiLZIIrzJr7lOpGKZrHzU50PicJnEhq5xzam8JvePyPwc+LWKF9I7MkHUFuNqheRU8euXODuvzoEBPwrDwuOz7yAS6HXuv/K9AI2X1qaah02fEEmmz1sfUglIOtprX+rWgsTNw2IL0pjEpp6GCtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYdID+ysqHfqImTxnNrf1J2Wkyb/rRO/W3BNpQrQmaI=;
 b=CUwaX/lRScE1myMvWqbnOaAQeTGZfyn8goVdFUVDzEQ0/nv0Zj+/lFBEYG7zB9mLhTewpyXFqHrwisJe07j9luthHsrHs2W4LBJX21OXKtKrCHxVZ0OZKCiS9WNbcfDoTAkYsVw5tk2OV/FzMowF4TR21h2zhBvcEZ9F+yMw3ZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by PH7PR12MB5975.namprd12.prod.outlook.com (2603:10b6:510:1da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 13:49:58 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::b7a4:9183:7942:5936]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::b7a4:9183:7942:5936%4]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 13:49:58 +0000
Message-ID: <f75bb80a-e49c-24e5-c897-7c4ecc804f84@amd.com>
Date:   Tue, 18 Jul 2023 08:49:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 1/2] docs: Move rustdoc output, cross-reference it
Content-Language: en-US
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     corbet@lwn.net, ojeda@kernel.org, jani.nikula@linux.intel.com,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, konstantin@linuxfoundation.org,
        Akira Yokosawa <akiyks@gmail.com>,
        rust-for-linux <rust-for-linux@vger.kernel.org>
References: <20230717151624.3470714-1-carlos.bilbao@amd.com>
 <20230717151624.3470714-2-carlos.bilbao@amd.com>
 <CANiq72k+uB4Px=_kGNEiduc0AewC05XO2zTqC3+ABa0hcxui9w@mail.gmail.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <CANiq72k+uB4Px=_kGNEiduc0AewC05XO2zTqC3+ABa0hcxui9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0065.namprd11.prod.outlook.com
 (2603:10b6:806:d2::10) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|PH7PR12MB5975:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fff4b9f-69e9-4ea7-dbf3-08db8795e013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7dEopKmjfhYUgCN03dXF56XZNOVPhInsNVg2cX0814faUHSrtMilkIVadta0SNfMK3l3o6f+Qz7Cbijwy4pgOc74GqjJ/PERFnu9UtC/mwW6Nv/LacHe35msER30o1L5vStlxDNJUt0ouwmwLr9Em/1pRXZIvLJviAYfPPeQJN75fBR17alxD6M3mnjG4qQ8UoedT9ahstpKFyqbbH9XKBFxUByIy4UbmvYx4bwcfKgG7e9NGAJNxdkgFJjN8AlHkYlAT3+i6vXe1IThHD9Zs3NXNMx60DESV5sKwxJDa1I8y8N4eE3hyTxc1kc0/bJVdMsnl7AIKHduKOY1SaO0fiyynY6GHNRUNZIVuochMckQ4HSiga/xjrtC/HpNyFIDE2zvb7qu+BY+GRNuH4wpnar8I2EFHjEkYZ221Z0/7IoJzp6D5sgszaujle9dLuyj32bprtsz5JD5TPO++RY001odOvbiDS2aTginrm7GSW14Hnzla3piMaT4SHPbNiO6H33Z3QYHY2mxgWvxKYiNEii5KTK6GygYjeKNtGtqHQ5KL2nSLRbQ1gpURUlB7BdWsDaZc4wbG9BYWQgWa2qUM4e41qSiLyzfRlSi4K+66pBujmRs52gsaiOkgxY8aP+qt+UYXz9a6VjzdDfofHeNcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199021)(54906003)(66476007)(66556008)(44832011)(7416002)(186003)(66946007)(6916009)(4326008)(86362001)(478600001)(41300700001)(316002)(6512007)(6486002)(31686004)(6666004)(38100700002)(8936002)(8676002)(26005)(6506007)(2906002)(83380400001)(31696002)(36756003)(2616005)(5660300002)(53546011)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2QxM01UdHd4VllGY1RTZHV6ZUlaS0pWS3BmbThGY2EvcEJJbXdxSlFlSUVM?=
 =?utf-8?B?MkNoNjd0NTVaS3FxZC96K0ZhRUk3ZUdQdDZmUkJVNVlQTWJacWxCU1d0NFhU?=
 =?utf-8?B?eGlQS1NqMmxJSy9KWk1mWkhJRllZOTNEL29qMlpydzNtWjlIajluME5LS25B?=
 =?utf-8?B?NnYrVFlNbkNYL3dqRzVTSlFZWWhkdGFHeC9VYmdJOG9pRWFvTXNvY2ZiZlJV?=
 =?utf-8?B?MXQzVXp2eVN6dVBxaWhRdEljYkR5aEtIUjhRTU01SFhucDU4Wmx4cU9TWlhM?=
 =?utf-8?B?aFNYRmZWWUJLQ29SYVB0TTc1MDBtWjkyQVBkZmw5dXliVXp6T2paVmJ2VjVO?=
 =?utf-8?B?MG4xbW1pdkJXOW5adTBHc2U2S1E3NDhyMHE4RVFEaXloTnpnQ0VMVFFrSVMr?=
 =?utf-8?B?QXpKT3VFWU9Zb0JlbUIwYlpiVm8yaTZaUW5BZzg4OERBd0JxZlFxUHpMMS9a?=
 =?utf-8?B?OGw2TFJhWWlIcHZvUGNkUytSMWx5Y2xjaVlBNzI4em9HV0NRQ3dDRklUbGli?=
 =?utf-8?B?NmF6VEZMbU12SktlaXVNWHFOaTEvQytCb083RG9TR2s0d2pvTER1aGV3RCtM?=
 =?utf-8?B?QXBPbzR5ME1JNnQ5VGdkc29XbmN2S09YenNFZThXS2Q2WmE3ZGVsWlNmdnpx?=
 =?utf-8?B?dDFuZ245SHJqczlUU25HdDU2aDhwT0FRb2xyMmxiZ0gwOXlWZmVxNVJCS2RS?=
 =?utf-8?B?MndOTHBGandrQUoyOHR2MmRmZlBpSlQ0T0dqeDBNdjBiTDJGS3RIb2o5YkR1?=
 =?utf-8?B?bkVibUpXY0hrM09NTnZteUZJbHdiWGppRm1kM3lZSUNqZEl2RzRDNThLMHRL?=
 =?utf-8?B?RlpXNlpwanNPaFBtZ2tOL3ZUY1NxL1NxMGxUWXR5OHM4QThYT3B0eTNsbmZI?=
 =?utf-8?B?SE9Fc3M0ZXJpckFHS2NhMU1rYnVGbzNXb05XWnVOZTY3bUppbmFvSXk5ODJw?=
 =?utf-8?B?SXVrZnJLSWpPd1lMN3h2WXpTN0lhaVp2RS8yZlE4a3luUnhDcWpzclkxR05S?=
 =?utf-8?B?SE9taGZLYXZyVHBGTFhPOXgvRmNQd2R6aHJNQVZLdVY2OG1abUJaMVJadTlT?=
 =?utf-8?B?cU80RENnVzJYQm1hdmluVUlPbTBocWl0Vnhtdzh2WEpRMEtWWjY4WXBMOWN2?=
 =?utf-8?B?a0Fham9nVzE1bDNIaUJXQ3l3SngrN3JFcEdmVkNLV1JQQkFKekZoSUFESkFX?=
 =?utf-8?B?MHpKOTc4Y1VRdjBhQzMxOGRsQTR5bHlzKzVwb3BLa0V2VzhvNkp4RVJLN3pn?=
 =?utf-8?B?aTdobUZzaG8rbkQ2cHNxVTJqbGVuaFRLSWpPZ29QeCtYSjRPc2hPQmVzNXBm?=
 =?utf-8?B?enZ5Z3oxZFNPME8xSmZCY2pFM3RmcXhBYXFuV3FiOEVGSmg2KzZVREY5c3Zi?=
 =?utf-8?B?aS8reXBjb3hzcTNaUDhzSGpXcVE1cmhpc1RnSnlqN0c3Q2NBMG1xTW0vTm9h?=
 =?utf-8?B?RWNKV1dOV1l5VTIxYUtTMnQraU1WTGFGdnhUOG1Nc05ZOFN6a0MwcW0rTFNy?=
 =?utf-8?B?cU5xNDBCYy9FV1FEcEdkM0dIbWtzOTdtQjIzLy84MWpNN0o3TEJnYlAxaFFh?=
 =?utf-8?B?bzZ5NHdRRzBoZTdoZE1ya2JpelhMNnBheVoxUHZLQVNjUHNMdlU4Z1JxU3px?=
 =?utf-8?B?OWFrc09ra1JQQ3pZWGVNYU05azByd0NsOHR1L1V5Qk9IMFp4KzQzK0xUQ3Fz?=
 =?utf-8?B?N3hRc1hJVWFPUjFIdXdYZG4wamw5T2NDNEZkaWVZMnVsdE16VkQ0MGtaR2Q3?=
 =?utf-8?B?UHUvcDVYUWZIWXpveUowckhCUG0veEEraGhVNzA3RExXSjJMeHRUYXpVNFBX?=
 =?utf-8?B?bWh5ZURFbTJSQjMyREh1Z0l0SG8xY2FOeUtOWGNIVnl1UDM2ZEJQTEF2MEkw?=
 =?utf-8?B?MmxlbTBHQndXQlU3RTJTdXZoRkgyUUxnNnZoV0JETmZrL0Z4ZXJjcTZwaCtp?=
 =?utf-8?B?T0M5aHFXMjdrTEZIRDVyblZRNTl6SjdCMHVsaVpadGl6OXRmY1V2cTFwUVFr?=
 =?utf-8?B?VG1JUStQNzY0eHZwc3NNRGxmWHpjeXZheUlhS3Nyd0RlM3NFakRUR08ySk9T?=
 =?utf-8?B?ek1wQ0p2M1Z0K0lSSStIcVU4RWt0OUsvRWdSZzBmTEpBL1VLaHREd2JxQmxt?=
 =?utf-8?Q?XLtwUUFm81rA8HvZeD3MJ1R/V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fff4b9f-69e9-4ea7-dbf3-08db8795e013
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 13:49:58.5308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nXosdutXoI3srJdZnzIfA78WXSgnYvQZrFKF1BJjThs+n7c2xePpH83FAH6Ajaio8KcxoJw/pmt/pj+mgzUUdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5975
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/23 11:37, Miguel Ojeda wrote:
> On Mon, Jul 17, 2023 at 5:16 PM Carlos Bilbao <carlos.bilbao@amd.com> wrote:
>>
>> +# Where to place rustdoc generated documentation
>> +RUSTDOC_OUTPUT = $(objtree)/Documentation/output/rust/rustdoc
> 
> I think we may be able to get away with just `:=` instead of `=`.

Yes, for v8 we can simply use `:=`.

> 
> Also, I assume this is intended to be overridable by the user, right?
> i.e. that is why you wrote the identifier as uppercase.

That's true, I don't see any reason to make this uppercase.

> 
> In addition, I thought about basing it on `BUILDDIR` from the Doc's
> `Makefile`, but that probably needs moving that one so that we can
> access it here (in the case where we are not building as part of
> `htmldocs`), and thus maybe it is not worth it.
> 
> (Cc'ing the rust-for-linux list, by the way)

Thanks for CC'ing, I should have done it.

> 
> Cheers,
> Miguel

Thanks,
Carlos
