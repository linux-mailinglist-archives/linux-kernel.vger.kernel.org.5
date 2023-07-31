Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4030769BB7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbjGaQCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjGaQCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:02:51 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1CC1B4;
        Mon, 31 Jul 2023 09:02:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QegXG+rS97OTtEZQcU0E5CGr3KeJ4n92i/xHm5EbSW20iqHTm+LToUwmncUfNVGKOOb2/UqNb6Ny6DkShVsU1PFOLIM/zJ3MrzY7NiM4v38Gn3NJo/eNi/6atdmM3hbL9w2ubsItD/IMuZspmxRNHZ9JVvHWNU1cjhLesKlzawKD5tZNRZMrf7uXmnQ7DT2riW5H4zUWGQANji2Mx+iqqe8Fkd9NQXkDmgRtvkqhIUHTvtfj64i+4dMhx+VSWxWlg3iXQ1ucKXetYRSb4zkSHPlvTFesbq3qY9k2ElE2ATqEfwk/RW3dKQVLjtnCY7F0jkLtHI2pauXzw+vaNLNvGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gt/l4GT3t2A5I8Uk0HlKy7jIu7i6g5lmrALO+TmdaM0=;
 b=dShOkjZmEabL9CknOyAviE5/dWNok3sf1B5IglTlK57XO00CIf5AHXFR/ttPKv4HV6xZoS6WIW203ebjdQ20Wj6ydM+jQ5DOzkMCdXiVXsKf0BgghsKKfH/iD/VL9olcIdtpO/SdUOs/S/JSKfuzNqlPu1KFwRaoSEVn1UTh/HXLuI/2aRLTvKbVQNnu05AGLkyWRbWDS+qOD8pgUxutOER43IuMZBwt3c655QcbW0ChPLS83mML2/HxVis8aDQRrIt+5/3LjW4v3fslb7sBWNyKK8Imq6LVqKBcFX03RrPohe2dUOxKfb+ipaJMADbDy2p0x1n/mP4HOqWCOwrdkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gt/l4GT3t2A5I8Uk0HlKy7jIu7i6g5lmrALO+TmdaM0=;
 b=iEriNiR0ZOceiSxCn0kQWqknY0FSlcAJUMsqOVMLlurEa5ZA43zyHO5mpGNnrbtYlm9XGrFFQCZbl4MhEQxIrjsQDmIDPx1fiCu69A8RoCUs37SOQXHT4xkRc92rZb9dPX2Ws5iTDyA9fv0dr93AQD5xNZFa7Pot1lRtaCH9C9Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB8041.namprd12.prod.outlook.com (2603:10b6:8:147::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Mon, 31 Jul
 2023 16:02:44 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 16:02:43 +0000
Message-ID: <0bfd445a-81f7-f702-08b0-bd5a72095e49@amd.com>
Date:   Mon, 31 Jul 2023 11:02:40 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
Subject: Error 'netif_napi_add_weight() called with weight 256'
To:     kuba@kernel.org, hayeswang@realtek.com, edumazet@google.com
Cc:     LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        davem@davemloft.net, linux-usb@vger.kernel.org, pabeni@redhat.com,
        Paul Menzel <pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::6) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: e70a3419-0ff1-461e-ed03-08db91df92ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PlSYz6ogKlLBD3rah92YPTpL+WDelhjVRz1F0N4ftgov/ObuTz2G3d3o/95irmDO6z3MfmuPtQQTR/JuwOqdwJazf4S4LVLPjoY1EBRiKH1NI+UyjJTMoIu+afat8eJ17o4EpZ+Oif4AZw1O0/4N0OAYlDoWQKLA9mFyQ1kpG9yew6fOOi+d+Php57Wuuwh6xTsj+yBQKc6ifbW7pkitMn2wKO3gsdM3CMwliPoqTivdTeCmzF7KeMv08HKi5yF6yWc791LO4iUDdbbIWKNleGWlhQlUSJrVvFnuXzSlaDg1L6SVWf5H12tECB6LJG9DW4B6pmX26LNEeSDeGmSDoUs0+H8lxbRVg6uF3VwiUOJ/wMz84bI3o6+TOHBLdzqn+etdtpG5PAGmBCrWm3YqX60M/9Y3bxZjMv0AMkNYloZNNrf/MbWIteuMORy8N0eI45tXmjZiY9Mp2Gdqsl0RiwG8EOZy9LNj3QMKvW7TpgEuKvl0GNGBIULwjoRPcX3n4MPFALEbbWSvgLwdVl6NDssjjnTG/RJKpb3WGGIPXDHll4R8/IMn4W3XG8nzwksTVVfIqquY1CGx4ECH6BgZNavdMJjxfnPEFPEeVkFLUdIZwjI7hQiJF3AUMP4I+NUEMThE+cVd9k+a3V9i/YRQ7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(451199021)(6486002)(6512007)(31696002)(86362001)(2616005)(36756003)(186003)(83380400001)(6506007)(26005)(38100700002)(8676002)(4326008)(41300700001)(8936002)(31686004)(66946007)(5660300002)(66556008)(66476007)(2906002)(4744005)(316002)(478600001)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anRXR1JFOXA5QkdzeTVscGl6aGhYN0piZGxMMXl3dmZuVFZnVDZ5OExmbFdh?=
 =?utf-8?B?MmplRUpNSmpUcEpmTWZTengzYkQwSCtmUEhSVjZuaE0rWlp4ZnRXcXQyRGxS?=
 =?utf-8?B?VWRBL3hjYm9RYTFaK0ZWNG8zTXd0MGM1OWkvYWpBWDUrOU8xdHJYUjd5eGly?=
 =?utf-8?B?TjdKQjNTb0pvWU53ME5kbmRFTnhsQnJCdzNWTDZpc3h1KzloUW5ybDhkc2xs?=
 =?utf-8?B?alkvSThERytqMlExem9oOXNGSTZIa2xLRE9UcWhWQUhwNFZ3cmN6ZUxUR1Ny?=
 =?utf-8?B?aDY5ZmdoOWFpcXlvOGkxNUNSMWtkVUdSd2RjSEpPZUhCRWMyeHFXZzVOZWhl?=
 =?utf-8?B?S0t3MFBzOHVlZG1LVWZubUc2RU4wb2g3NTRzSXpOVFBMWkVBQmtaUm1Dbkc2?=
 =?utf-8?B?Ylo0djRId3JOSklNOTdUZFpkZ3R6TlBTc0hlQ2ViRGVRcCt3ZEtVa0VvZmsy?=
 =?utf-8?B?SFVoekVrK0h3TEJrSWl2TTVnOENXL2RLazIwalZxRWtHc1VDbFV5NXNoRFM3?=
 =?utf-8?B?T3J1a0EvbVd4c2IxRmo1TlpZYUZ2YUF0TEVDNkxlbUdWSFRSYUNSZUg5Q29Y?=
 =?utf-8?B?R0RsQjV0OXBYQ2Y0Ly9xLzdmNEZKUzdWc2U1NmFRakhUeXV4Tm52YzVKSHdS?=
 =?utf-8?B?ODJlM1pWOTJ4UGhJcURRblBmYUVRZ3JtN3Z6OWNFUGh3YzhLNm1NNFFQWG5u?=
 =?utf-8?B?S2JkVitlMmYxRE1TVnByYndXR2ErR2xqNCt3RUpiVi9wNE0zUmZpbDBHOHFK?=
 =?utf-8?B?RjEwVy9LU3lqMERoUGhZc01XdDQ2SFF4VllEL0pzcysrcU9XaTh4MkpsTkhS?=
 =?utf-8?B?a1UvdlRQY3NmWFdLYThPSzIxM1ZCdlVnQUtNb3I0Q2hUVXp5MkxocWZibnAr?=
 =?utf-8?B?anhSWmh6TzU3aXpjeUlRRGMwTy9KZmpzaE1TRFB5c1hYVndXb1JvVWJOdzRz?=
 =?utf-8?B?a1ZlWXZJMnA3Mnp6OTdNZWZ2UXNOdTY4Y1BoZXBibUlMUzhhV05OUlpmQUUw?=
 =?utf-8?B?NmZIMVBNTjNnVG41dXV3RWpwQVFoalpyemVqaGZGcmFNQ3F5aEJlaE9zYzZj?=
 =?utf-8?B?ZVBuK01ZUTZRVmdBTjFjYXZXZThKcTBVS0orOFcvdmo2eWlZdW9rTE9hZkYw?=
 =?utf-8?B?QWNRMjA3RzU4Nk95cldJMGprMWV5STg0T1dVUE0wbG0zK2d3UHZKR3Nnb05n?=
 =?utf-8?B?NUpYb0kyajdTdXp5ZlRzNVI4RW5MQ0I5WmduUUowaHdaM212V1Fvb2h2Uy8v?=
 =?utf-8?B?U0QwZEhBSWtBS0JoZE5XRVRNSVhMaWp0dEFGOHgvNGV5SFExTzNPTDV6V0U3?=
 =?utf-8?B?RVZJWXU5VnhaWHpRYkJjR2tMenpnaGk5U3g0QjVBRDVXNElmT0JqMG5zcllO?=
 =?utf-8?B?NHIzREFsZklJeElMWVk1dFBrbWhVOEZRbU9vUUdNWmZFNExWbERhTi9Gb29Y?=
 =?utf-8?B?SmxjWEo1ZGZ5b3VGRVlyY3NZQU5OMzJFa2FjTWtKT3pQUXM1M2h4b3ZmWkRu?=
 =?utf-8?B?QUp2WE4xYmhDeGRmbHdXeCtUVHhMSy9UUmUxNTdqd25hdXNVMnBjdzFnZE1M?=
 =?utf-8?B?aG1KaExibmZHanBmSUVQRG1EZGIvcGxKSU5RQnFBMHp5c21iN1AxNmRhb0RQ?=
 =?utf-8?B?NHdPV3U0Nnk3aXJpMGtwc0FVYnQ5ak1wc3NCZGE3WWVqZUxHc1JDSWZBWVVq?=
 =?utf-8?B?Q3NtcWo2UEwyMjh4SzNUem0wVFpIZXUwZE9BeTZaU2ZVODA4Z3NqSkFJTWx0?=
 =?utf-8?B?bmNrTVVPYVZUWndOWDBnN1VrSzk1Zzg5ZHNiL0c5NkRmbFIyc3cxR2p5cnZ2?=
 =?utf-8?B?ODR6VTlpbE5INnVIOTBWN3JwMlVOOEFobFlmeXgrUWhQNGgwTWw3dnJzMG1G?=
 =?utf-8?B?aU9UUVBMaGhrUTNteFRxajBMRVJuSWNXNXJibEcwZHk0Q3BTck54Y1JJVlBt?=
 =?utf-8?B?d2F6UTRQWko3WDNpWk5MK1F1eVlwZkE5aG5xamNKdUUvSllMQ3dSU0FmYU5p?=
 =?utf-8?B?L3Z2S1dBcXNsOHRqUEsvcWJzVmRPREo0T0VQM3BhSFlqLytJUHcrUGFLeFZV?=
 =?utf-8?B?UnBHK1ViTlJEdnV2cERaT2lTZWxVRDdJY1FGc2E2LzF5TitRdmN5RkFPYWxJ?=
 =?utf-8?Q?Z6/H23YBZi5FRJTqY54rvB14V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e70a3419-0ff1-461e-ed03-08db91df92ea
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 16:02:43.3958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eRIetQ8/8M8sVPKA6UiUcXRQmpEbf9HWdYfTC3qjAEEH484bO+jeLWNbY4KMnHCg7Rsw1aGYnY14M4ROqDd1Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8041
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed today with 6.5-rc4 and also on 6.1.42 that I'm getting an 
error from an r8152 based dongle (Framework ethernet expansion card).

netif_napi_add_weight() called with weight 256

It seems that this message is likely introduced by
8ded532cd1cbe ("r8152: switch to netif_napi_add_weight()")

which if the card has support_2500full set will program the value to 256:

	netif_napi_add_weight(netdev, &tp->napi, r8152_poll,
			      tp->support_2500full ? 256 : 64);

It's err level from
82dc3c63c692b ("net: introduce NAPI_POLL_WEIGHT")

Why is this considered an error but the driver uses the bigger value?
Should it be downgraded to a warning?

Thanks,
