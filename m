Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9808136F5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443563AbjLNQwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235733AbjLNQw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:52:26 -0500
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B84C1AD
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:52:12 -0800 (PST)
Received: from 104.47.11.169_.trendmicro.com (unknown [172.21.165.80])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id D53A21000190A;
        Thu, 14 Dec 2023 16:52:10 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1702572730.532000
X-TM-MAIL-UUID: 8c3190eb-d14c-458a-9fa5-ce69c9bf40f8
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.169])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 822CE100003D3;
        Thu, 14 Dec 2023 16:52:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDLcX5RRYeZDVLgYP9XnsvEs87AEN+4LH2QlEMGcYvRVr4zXxu/uIjqI8Wwg/W3ShsCCX/j5g9r5bzSFnj1iZDE4258My4fKSYL3ZkALT1MIgRSNCQbqVd+VRV267ksu+dHkjT9KPLOUuV7g3bdhE54Vj6aUs0Mfp4Wj1954YWJdizC/3zn1C6X4l8pGtfTyJphrB/e/0dehn3sUJT4t5toV8K+T/gcmKJgdi4WdCmehinHQUMq/kdCih7UH2WNqMfeWU68HxIckhzvBgJz5lVwr5DLvjXyituOu8jbZEcUsgsJNWehnq+vULSl6qHYfLmuAOUitzMh4VNsUszrveg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uB1Ecejss1QajB3zz7dVkREaCkbp7TX9bsrpgEVegzI=;
 b=K8ItAV+twGhMvlKx3oqwYeD4jG8v0soUp0tyo/dICi3mdlLEZCWqs0Myq3a4Co4kXtP0mJd0RHv2pMXLxMsFk6UtNaCB5MwL/2lfkWhhnvhgWpuDaI1OJCfnb7zIVLp0LBc/9vzSf7grnb1OL5MCySLjvh0DnoXnzmrygvGDqg0y4xWTBGIFFNV1kECWKPvEXUahm/01mLbuhjSgGbBi0rCZBZf4NIHkV/OUIXTKvxPG9nYWhm4RqJKypgLWhxBNmuMY5FAYanHvJprZsRPIbIWcQA2iPc96ulKB1ATQMsIsnTlIUWpXJrk3H7vRHZzhrAaZ/zKEM4c/uxQk5skVLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <97c55071-642c-45bd-8c70-ecdcc3e48b75@opensynergy.com>
Date:   Thu, 14 Dec 2023 17:52:07 +0100
Subject: Re: [virtio-dev] [RFC PATCH v1 3/3] SPI: Add virtio SPI driver (V4
 draft specification).
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     virtio-dev@lists.oasis-open.org,
        Haixu Cui <quic_haixcui@quicinc.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Harald.Mommer@gmail.com,
        quic_ztu@quicinc.com, Matti Moell <Matti.Moell@opensynergy.com>,
        Mikhail Golubev <Mikhail.Golubev@opensynergy.com>,
        =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20231027161016.26625-1-Harald.Mommer@opensynergy.com>
 <20231027161016.26625-4-Harald.Mommer@opensynergy.com>
 <20231213095339.rurjk6mxjeap7tye@vireshk-i7>
Content-Language: en-US
From:   Harald Mommer <harald.mommer@opensynergy.com>
In-Reply-To: <20231213095339.rurjk6mxjeap7tye@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::6) To FR6P281MB3419.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c5::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR6P281MB3419:EE_|FR2P281MB1701:EE_
X-MS-Office365-Filtering-Correlation-Id: a7e37a60-e892-4214-0770-08dbfcc502a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bp+xzFXiZ0Umr5meJp3cMa2DcChIklt9nfzBTfepQUqvFNVJaIDascV1oDVVmyBgLCEM7MTlV3YJbaXQsU+NrOq3GoGM1Ja29DBmnpGmKOqfT9bk7Z1athDD5bmvVN2tNrQ2bpMjAoxQrDuIy4cF53S3RPvph/pjRjKO0Mu9fju0j4sYrp+eiq7+DgtDnEheJwmV86Op2BaLhMsf0EspAh4wJ9I0h6jLzpB1bnJoC8CctC+9ZHlMu4GbaV4bqrIsCFP1wDb/zBB5jvqKXlOwB7770todm1Dr1GWV8x6xrjZ41clSEkYLKC19d/zw+0F1pKj3cgoBLnVIxQRTum227vVLAodPUfggVCR3ECMZFxbDJwZ0XTUPswN5aPWryZBDEg/fRsWDalTns9T6mDUVIFCUB69HICyaxlILJb7jecfaQsHWbjgKQajbm8Xd/nJbIIaGi32PsI0cG4X1rnbro6fplIwBg23Csqiaztfy6fMPzgqM74AIZVCAizoymEQwBYFN1idkGjt4DfJqxscW5SFJqzfVUNGh9pnWnryFm2/6fqJTGrqXam0OQLY0aA0/sJTvRlCjq5f5xXqBcNmpDjDa9gea2Fe7pfi9AJ5rrfC1XBEC+/6FUWCRl+89hPuN4lYrfZu7tdLyizGcIT8uuQvE0m5DAmC6opIKkhvCiSANRvBGy1RfEOQxe9UIXnaq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR6P281MB3419.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39830400003)(346002)(366004)(230273577357003)(230922051799003)(230173577357003)(451199024)(64100799003)(1800799012)(186009)(7416002)(66899024)(2906002)(30864003)(44832011)(8936002)(86362001)(4326008)(8676002)(31696002)(316002)(5660300002)(41300700001)(36756003)(31686004)(478600001)(26005)(2616005)(83380400001)(53546011)(38100700002)(42186006)(66476007)(66556008)(66946007)(54906003)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTRnL2gxRTNRZHNXOXlxLzYva1RJdTc4K0o2aU03WXRkM1p0NERZdGVuQ0Jp?=
 =?utf-8?B?eGE4Ui9CN3BSSGZrNFZ3SWxUS0NnLzBuVXBxRHlMajc3bHdEN2YvNmRkSHl4?=
 =?utf-8?B?ZkdYbVRnd0VuNzI3dExzbldrWDQySnFJRVRtK3RLU2h1dkRTamR1a1IzaVlM?=
 =?utf-8?B?VGQydEtHUnBtNExqVklNUFBYc2tOU0dFYjFvdFpXRDg4dU9tTEYxMTNNelF1?=
 =?utf-8?B?VjhRK3ZmNTJEc203U0Q3b2RiZEFaVWxUc1RqNExZV0hSYVZNWnZPKzE0VTdR?=
 =?utf-8?B?T2JneE53U3ZTVHp2b0lLc0d0amdGODlxRW51YUpNSXk2cU84ZUE4V1FURWg5?=
 =?utf-8?B?djU0TGx5THdmbk5rOE9JdkZLdFZDS1NhVXBXTjc1Q3d6WFU5Sk11dnZYL0di?=
 =?utf-8?B?WUdMT1BBdkNlNnFBQ3orWnZOajBnaDNEVWJMdkJlam05OXRDaTFNM2Nld2dO?=
 =?utf-8?B?Y2xLdWp6S2hLMkVqYW1URFFDY1hpU3JYNzlnamFoSCt2NjduT21sb2RxMjBX?=
 =?utf-8?B?MWNITHhTZllhUWZrYWM4dkpCYk02NytJOHhaQ3VFWFFuSzRoY2Vwd1hKRFU1?=
 =?utf-8?B?bGJ0bEdBZ3BwOC9LWC9NV2NrR1dDRmNSKzlZMXU1VTZuOFl4SENGd1duSUxn?=
 =?utf-8?B?WHV4dVE0NmF1YWU4WVhJRUFhcHVRSlJkanVlSkZpNDRHd0Y0WEhyb25iSkNv?=
 =?utf-8?B?b2pOTS9JTTlld1RLR2NodkNBNjBJNlFBUXhyK3h2UnB2UisvOEtPT2l6T3FO?=
 =?utf-8?B?TEh5ZHVRMG1LWVNDN0g3K0gxeGhXV0UzL2RRZUVDMU1OMDhJaW5KNVhMaGZM?=
 =?utf-8?B?ZnR0dkUwSGJ4a3lGNW1nMXlKNXZYbEt6TXVXU1FXMmZSQ3RxTksvazl6cW5B?=
 =?utf-8?B?MUttQndoK3d4dmUveWkwK1dBYWpXTWw5eENEdEJEK3QxYlVzWVRqR0FXT1pM?=
 =?utf-8?B?K1hHWFJxbVZFdWtzUWkzY2MxcDUxTHlGNEhyUGJveXBVdjgwZkVSOUFnbC9r?=
 =?utf-8?B?OUVZZHMyTHMyeWNzQmxGLzhobzFlUll3aUxENUhiZjh4b2x5YWgvaStoQ3BW?=
 =?utf-8?B?UlZGR3RWT0dSV2NsTmljVmU5MDAyalpteTFxRmxMZ2NnNElwNXpvNEgwOUMw?=
 =?utf-8?B?bFQyK3FuczVJNks4eUxLaXBTYkRNVkh4Y1NDOW1ERjdBbU5XNFEzWHF5UzBv?=
 =?utf-8?B?UDJPM290SUduM2taelpWTUtaOU15SVpDa2NPY25ERzB1UVUvZ3daN25WVkxX?=
 =?utf-8?B?V1Z1aWRiM0ZlWDFYMjFreVNjOU9VZytqaGE5VjdOdUJOM1lMcG42TVhqeUJj?=
 =?utf-8?B?Q3dVSG53STMra3dRbWhka2VwaWkxZGdkTTlCbFEvZ0RkR2xSMS9DYUFhRThw?=
 =?utf-8?B?dFliN0RldE9JTXA5SU9wc29aVTZDUisvRUtBbEtZaXFpZlJDbGZmWGx5WnRW?=
 =?utf-8?B?WDNJdHRnOXIyei9PQVI3KzJUUnlJMkZrd092RVRkZ21OMi9zYUJuRlZzR1Ev?=
 =?utf-8?B?MkVwcWR0OUNQSEJlbmhaaXZUSzgwdTRaL09saS82TmF0Mys1RU9WcGY1V3JE?=
 =?utf-8?B?d1d6TlErYTNFb3Q0SUo0S2pLRUdOci84dHZxeDVFZkVGOVhvUG44OEF1amVn?=
 =?utf-8?B?RzY1YjAwQ3RnV1Q4NzliOTdqbW1HLzN6UnRHYlV3a2ttSVBiMVg4TUMzZll3?=
 =?utf-8?B?WTlFdEZNZXVrRWNZZ2RZK24vQ2NGZ0NoSnBvalhKWjlNS1lSWGxGZWlKTGtG?=
 =?utf-8?B?VURIVUJ6OHA0MXI5TU9OdmpRM0NBTUZCS0lTTFE2ZlM0QTZocXI3ejNWY3U0?=
 =?utf-8?B?bHNsQTZxZjVYWFZxeU9CZEZVR3R0TlhHZU91Y0kvOHBqTDZidmdKNXlYeHJV?=
 =?utf-8?B?UkhUaUFaMFB0OW9hcFdPSGxBMWZUSW83V3FqWmwyUndqd0QrbFRZTG5SOFJw?=
 =?utf-8?B?VDBKYU1ScDRDME1DcGI3bWtyQ0J4U0ZxWXhLRlNjMnFKb1Jjdzd4aGFSa2xv?=
 =?utf-8?B?ZHdVSnliK3Y0ZURpa0NTV1dOelNwMDVKTkIxbjhrVHBvczZ1TlhTL1piKzFw?=
 =?utf-8?B?WHA1VjFQOGJCYlcyMlBqbU91a09zcFhjYzdzdXlGcXJZdVZKRXFRTjFrK1Q4?=
 =?utf-8?Q?0+BudKGKJDC99isYJro2SL1jL?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e37a60-e892-4214-0770-08dbfcc502a7
X-MS-Exchange-CrossTenant-AuthSource: FR6P281MB3419.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 16:52:08.7862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8oMgztKpDSlvhg7F7ocWkr+ttfjBuNWwuFaTve+aJdF9M/SUfP50ycSDd4ZBCSvzphuc+eGDGJfi0tikiMqPwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB1701
X-TM-AS-ERS: 104.47.11.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28058.000
X-TMASE-Result: 10--19.696800-4.000000
X-TMASE-MatchedRID: IeZYkn8zfFr5ETspAEX/ngw4DIWv1jSVbU+XbFYs1xLaKzYmd3PcymYp
        wL5mBmjdFda01+7oiCix6frpJFf/MNPZ2M/sMqgOUlO0zoIcpU6B1fO2o4QGcNIbP1O/S9Qw9FF
        P2RWhMyCG4JQWzp0ZirZlBp+S1BEnBGdZpudIgG5JF1UGj9ejec7P4JpFsMVwWB/DYwvfuLWtRN
        3iuOz0L0sZV6Sat1Izjpjs1qqfu15zLIMOHzR0Hws6eGQ6Ral9LScSt1VLr5D5P5pewhMFH/TAt
        ayV47MA3DJPYBNSQacrzCE2pBa7C9wQshgLe4OSSIWxwjSbWag6JN46sPsfMN+KJh2ANID6kiJw
        FTNBGzJ/pAnS03zavlLmbsxklnnKnB85oWv6D9ydFMmljtUAp5bOkYpZpyLE0jekui0fU+OaruP
        PAUIkbAV5N3ggiv88yljcy3zgpZdqlD9CkfildqwODSO9Fuc1B/zLDQkZ8pVNbINBwEGUTSUgo4
        kch/w/FLHEabMBQhkkZIFYidq09X8cSqD6bHJz5+McUCLa9WcVJPUqXnrQdZsQxnk1R+AH6wNPM
        28WCQuLJFNA7G4zdIM1q2FyGwi0tUl1a3Br0cGzG+AMitSoBtZEjr6xrP/hqWgfIMWloSyuB14A
        DbID6mVvaFXrHqxVlVRZmqksLkuRt8XqEDZNJEI6361CO6Vp7gd5SqHIhjKc2JxbD3wPF41VnSH
        /ifaxL+BiIJvIflItwjoMC1HleXnyaV1NZjkoeWsf9OQoKxGRYC8MaT9w4XmiaGC762CcpIBEPM
        EkSZEScchbdZsRJDcfsO7nzy70YFTYUvWh+63FTQGAKRxj5No+48giqZwnEgg3cwDHl/1O85Jco
        T0w/WCMkDOCX51peG3erYjBbl1+3BndfXUhXQ==
X-TMASE-XGENCLOUD: d0d14248-327a-4747-a74f-5ee27198cba7-0-0-200-0
X-TM-Deliver-Signature: 3B3A2A3B83429ED9A68234B7513A59D3
X-TM-Addin-Auth: iEo/acXkBZ9uc7sLvIFrDMtdsgr7CO+oa4B4E4suRAjsxEigZvx1PEgWAPv
        kg7NwLWuzQlPQ6te+7p2RHpRPn1W+93O1xESeTCFoDP5dVbDF2tscN9NsS5n7kqkzFlGxGPHEA4
        StjmEQUdmBN5VXdbpkgEBGGQH3XAHeidhQNxk7IezqZWdLVnAezPFkFd9xzedsvvM3Kq24gXhHl
        I87SNhxzvcMN1QM3PEEj7LjwwmAyFHybKQEoWe79ZzwXsdZk8n8Wv5up8mww8huePeU5LXA6i2d
        PUtcRfTeZ4a+JXE=.0IqRop8BR2Ffyjn4tTcwX2E+2KXnwphjazhtzyHH3sqr/rW8pflSiR4dqV
        zuBFi5aZdxrtgYljtOW1RVSzqDGsnwMs2ardhgzBoHq7AWvEy+sgGUIU2HZxK8XizWsUaU7/hQM
        wfWyha6JP0HtaTlheK/2ZLY6/TObkWCsBSDe7wEO2+7FGewBJmuK6uKWpw5g7VKpqNWEXp938KN
        ZYGNitzw+oXdPw1c+pHx7GRYsyzAq7AhRPuz/+YC1REDUhtZwtCSBufTAaaOu8CiRdbFBJdbDcj
        bQpZXjzrWJeiAZTdtSiIxFHdRFJhDQmmkjWkZSHPRuMYHAW7mIENP708vwQ==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1702572730;
        bh=7EXv3vPskE6EptHvkFircqCBTWlK4zMD1n7uJbTElIE=; l=21900;
        h=Date:To:From;
        b=IlQhaeIofQrCsAdw0bys+VSFFSMagrWvzvi82Dn7nKhYxVoG8saYClVyP98YTkKdA
         5S8pUFYoE/TRoz4Yh/f5y33y15ZcTfsNSH5JbLHMMrARX+AUIeQc1lUp/2vGBhx9AS
         WnGncbuU4Az23dIaSVpbdX4BOsMPSVw0B0w+peqQHV8ri8vqqxJ/aaTQ+pCh3z2eJe
         A4U/GtP0ChPedZx0GCoSO3uNa96Srq8gwWHXRUp4fsV1qa8pPawGm11dQLW8jgkeFB
         H6X2zzXMDQ2PR12cfHOR8b5DN4BqU9RG3WXBHO0UFQG8gDJkjc2DFzdSuRBPDacXEI
         bpgvAHzZWF4tA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Viresh,

On 13.12.23 10:53, Viresh Kumar wrote:
> Hi Harald,
>
> On 27-10-23, 18:10, Harald Mommer wrote:
>> From: Harald Mommer <harald.mommer@opensynergy.com>
>>
>> This is the first public version of the virtio SPI Linux kernel driver
>> compliant to the "PATCH v4" draft virtio SPI specification.
>>
>> Signed-off-by: Harald Mommer <Harald.Mommer@opensynergy.com>
>> ---
>>   drivers/spi/Kconfig      |  10 +
>>   drivers/spi/Makefile     |   1 +
>>   drivers/spi/spi-virtio.c | 513 +++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 524 insertions(+)
>>   create mode 100644 drivers/spi/spi-virtio.c
>>
>> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
>> index 35dbfacecf1c..55f45c5a8d82 100644
>> --- a/drivers/spi/Kconfig
>> +++ b/drivers/spi/Kconfig
>> @@ -1125,6 +1125,16 @@ config SPI_UNIPHIER
>>   
>>   	  If your SoC supports SCSSI, say Y here.
>>   
>> +config SPI_VIRTIO
>> +	tristate "Virtio SPI SPI Controller"
>> +	depends on VIRTIO
>> +	help
>> +	  This enables the Virtio SPI driver.
>> +
>> +	  Virtio SPI is an SPI driver for virtual machines using Virtio.
>> +
>> +	  If your Linux is a virtual machine using Virtio, say Y here.
>> +
>>   config SPI_XCOMM
>>   	tristate "Analog Devices AD-FMCOMMS1-EBZ SPI-I2C-bridge driver"
>>   	depends on I2C
>> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
>> index 4ff8d725ba5e..ff2243e44e00 100644
>> --- a/drivers/spi/Makefile
>> +++ b/drivers/spi/Makefile
>> @@ -146,6 +146,7 @@ spi-thunderx-objs			:= spi-cavium.o spi-cavium-thunderx.o
>>   obj-$(CONFIG_SPI_THUNDERX)		+= spi-thunderx.o
>>   obj-$(CONFIG_SPI_TOPCLIFF_PCH)		+= spi-topcliff-pch.o
>>   obj-$(CONFIG_SPI_UNIPHIER)		+= spi-uniphier.o
>> +obj-$(CONFIG_SPI_VIRTIO)		+= spi-virtio.o
>>   obj-$(CONFIG_SPI_XCOMM)		+= spi-xcomm.o
>>   obj-$(CONFIG_SPI_XILINX)		+= spi-xilinx.o
>>   obj-$(CONFIG_SPI_XLP)			+= spi-xlp.o
>> diff --git a/drivers/spi/spi-virtio.c b/drivers/spi/spi-virtio.c
>> new file mode 100644
>> index 000000000000..12a4d96555f1
>> --- /dev/null
>> +++ b/drivers/spi/spi-virtio.c
>> @@ -0,0 +1,513 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * SPI bus driver for the Virtio SPI controller
>> + * Copyright (C) 2023 OpenSynergy GmbH
>> + */
>> +
>> +#include <linux/completion.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/stddef.h>
>> +#include <linux/virtio.h>
>> +#include <linux/virtio_ring.h>
>> +#include <linux/version.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/virtio_spi.h>
>> +
>> +/* SPI device queues */
>> +#define VIRTIO_SPI_QUEUE_RQ 0
>> +#define VIRTIO_SPI_QUEUE_COUNT 1
>> +
>> +/* virtio_spi private data structure */
>> +struct virtio_spi_priv {
>> +	/* The virtio device we're associated with */
>> +	struct virtio_device *vdev;
>> +	/* The virtqueues */
>> +	struct virtqueue *vqs[VIRTIO_SPI_QUEUE_COUNT];
> There is no need to make this configurable since the specification
> fixes it to 1. You can simplify this a bit.
Yes, i2c makes it "struct virtqueue *vq;" and this makes also sense here.
>> +	/* I/O callback function pointers for the virtqueues */
>> +	vq_callback_t *io_callbacks[VIRTIO_SPI_QUEUE_COUNT];
>> +	/* Support certain delay timing settings */
>> +	bool support_delays;
>> +};
>> +
>> +/* Compare with file i2c_virtio.c structure virtio_i2c_req */
>> +struct virtio_spi_req {
>> +	struct completion completion;
>> +#ifdef DEBUG
>> +	unsigned int rx_len;
>> +#endif
>> +	// clang-format off
>> +	struct spi_transfer_head transfer_head	____cacheline_aligned;
>> +	const uint8_t *tx_buf			____cacheline_aligned;
>> +	uint8_t *rx_buf				____cacheline_aligned;
>> +	struct spi_transfer_result result	____cacheline_aligned;
>> +	// clang-format on
>> +};
>> +
>> +static struct spi_board_info board_info = {
>> +	.modalias = "spi-virtio",
>> +	.max_speed_hz = 125000000, /* Arbitrary very high limit */
>> +	.bus_num = 0, /* Patched later during initialization */
>> +	.chip_select = 0, /* Patched later during initialization */
>> +	.mode = SPI_MODE_0,
>> +};
>> +
>> +/* Compare with file i2c_virtio.c structure virtio_i2c_msg_done */
>> +static void virtio_spi_msg_done(struct virtqueue *vq)
>> +{
>> +	struct virtio_spi_req *req;
>> +	unsigned int len;
>> +
>> +	while ((req = virtqueue_get_buf(vq, &len)))
>> +		complete(&req->completion);
>> +}
>> +
>> +static int virtio_spi_transfer_one_message(struct spi_master *master,
>> +					   struct spi_message *msg)
>> +{
>> +	struct virtio_spi_priv *priv = spi_master_get_devdata(master);
>> +	struct virtqueue *vq = priv->vqs[VIRTIO_SPI_QUEUE_RQ];
>> +	struct virtio_spi_req *spi_req;
>> +	struct spi_transfer *xfer;
>> +	int ret = 0;
>> +
>> +	spi_req = kzalloc(sizeof(*spi_req), GFP_KERNEL);
>> +	if (!spi_req) {
>> +		ret = -ENOMEM;
>> +		goto no_mem;
>> +	}
>> +
>> +	/*
>> +	 * Simple implementation: Process message by message and wait for each
>> +	 * message to be completed by the device side.
>> +	 */
> And why not send all the messages once and speed this thing up ? Just
> like how I2C does it.

Because this is more complicated when I looked into i2c. First I wanted 
to have a working driver which can be delivered to our internal project. 
This internal project has no sophisticated performance requirements. 
Better to have something for the internal project when you have to 
deliver to them instead of having nothing at all because you wanted 
initially too much nobody asked for.

To minimize risk and not to extend the scope of my existing tickets too 
much I will address your comment not by a code change but by a comment 
in the code. Nothing is broken, this is an optimization only.

>> +	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
>> +		ret = virtio_spi_one_transfer(spi_req, master, msg, xfer);
>> +		if (ret)
>> +			goto msg_done;
>> +
>> +		virtqueue_kick(vq);
>> +
>> +		wait_for_completion(&spi_req->completion);
>> +
>> +		/* Read result from message */
>> +		ret = (int)spi_req->result.result;
>> +		if (ret)
>> +			goto msg_done;
>> +
>> +#ifdef DEBUG
> Drop all temporary things please.

This is an RFC patch, not an integration request. Until the spec is 
accepted by OASIS the driver is code under development tracking a moving 
target and will have to remain RFC. Removing debug aids is something to 
be addressed before we are going for non-RFC.

>> +		if (spi_req->rx_buf) {
>> +			pr_debug("Dump of RX payload\n");
>> +			print_hex_dump(KERN_DEBUG, KBUILD_MODNAME " ",
>> +				       DUMP_PREFIX_NONE, 16, 1, spi_req->rx_buf,
>> +				       spi_req->rx_len, true);
>> +		}
>> +#endif
>> +	}
>> +
>> +msg_done:
>> +	kfree(spi_req);
>> +no_mem:
>> +	msg->status = ret;
>> +	/*
>> +	 * Looking into other SPI drivers like spi-atmel.c the function
>> +	 * spi_finalize_current_message() is supposed to be called only once
>> +	 * for all transfers in the list and not for each single message
>> +	 */
>> +	spi_finalize_current_message(master);
>> +	dev_dbg(&priv->vdev->dev, "%s() returning %d\n", __func__, ret);
>> +	return ret;
>> +}
>> +
>> +static void virtio_spi_read_config(struct virtio_device *vdev)
>> +{
>> +	struct spi_master *master = dev_get_drvdata(&vdev->dev);
>> +	struct virtio_spi_priv *priv = vdev->priv;
>> +	u16 bus_num;
>> +	u16 cs_max_number;
>> +	u8 support_delays;
>> +
>> +	bus_num = virtio_cread16(vdev,
>> +				 offsetof(struct virtio_spi_config, bus_num));
>> +	cs_max_number = virtio_cread16(vdev, offsetof(struct virtio_spi_config,
>> +						      chip_select_max_number));
>> +	support_delays =
>> +		virtio_cread16(vdev, offsetof(struct virtio_spi_config,
>> +					      cs_timing_setting_enable));
> Instead of reading values separately, you can also read the entire
> configuration structure in a single call to virtio_cread_bytes.

Cannot.

Virtio spec 4.2.2.2 Driver Requirements: MMIO Device Register Layout

...
For the device­-specific configuration space, the driver MUST use 8 bit 
wide accesses for 8 bit wide fields, 16 bit wide and aligned accesses 
for 16 bit wide fields and 32 bit wide and aligned accesses for 32 and 
64 bit wide fields.

>
> Won't you also need to convert all the values using le16_to_cpu() ? I
> have done it that way for drivers/gpio/gpio-virtio.c driver, just in
> case it helps.
virtio_cread16() does also already exactly this conversion in the same 
way virtio_cread32() does.
>> +
>> +	if (bus_num > S16_MAX) {
>> +		dev_warn(&vdev->dev, "Limiting bus_num = %u to %d\n", bus_num,
>> +			 S16_MAX);
>> +		bus_num = S16_MAX;
>> +	}
>> +
>> +	if (support_delays > 1)
>> +		dev_warn(&vdev->dev, "cs_timing_setting_enable = %u\n",
>> +			 support_delays);
> Why is this a warning ? And not just debug or info ?

Here only stuff is printed when something is wrong. So this is not a 
debug or info.

For bus_num which will in the next version come optionally from the 
device tree the device tree value is silently ignored when it's out of 
range in my current code. Now I think about even to make it dev_err() 
making virtio_spi_probe() return an error. Not sure yet.

>> +	priv->support_delays = (support_delays != 0);
>> +	master->bus_num = (s16)bus_num;
>> +	master->num_chipselect = cs_max_number;
>> +}
>> +
>> +static int virtio_spi_find_vqs(struct virtio_spi_priv *priv)
>> +{
>> +	static const char *const io_names[VIRTIO_SPI_QUEUE_COUNT] = { "spi-rq" };
>> +
>> +	priv->io_callbacks[VIRTIO_SPI_QUEUE_RQ] = virtio_spi_msg_done;
>> +
>> +	/* Find the queues. */
>> +	return virtio_find_vqs(priv->vdev, VIRTIO_SPI_QUEUE_COUNT, priv->vqs,
>> +			       priv->io_callbacks, io_names, NULL);
> Since the vq count is fixed by spec to 1, I think you can directly use
> virtio_find_single_vq() and simplify this a bit.
Yes.
>> +}
>> +
>> +/* Compare with i2c-virtio.c function virtio_i2c_del_vqs() */
>> +/* Function must not be called before virtio_spi_find_vqs() has been run */
>> +static void virtio_spi_del_vq(struct virtio_device *vdev)
>> +{
>> +	vdev->config->reset(vdev);
> virtio_reset_device(vdev)
Yes, not only shorter but does also additional things if 
CONFIG_VIRTIO_HARDEN_NOTIFICATION has been enabled.
>> +	vdev->config->del_vqs(vdev);
>> +}
>> +
>> +static int virtio_spi_validate(struct virtio_device *vdev)
>> +{
>> +	/*
>> +	 * SPI needs always access to the config space.
>> +	 * Check that the driver can access the config space
>> +	 */
>> +	if (!vdev->config->get) {
>> +		dev_err(&vdev->dev, "%s failure: config access disabled\n",
>> +			__func__);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
>> +		dev_err(&vdev->dev,
>> +			"device does not comply with spec version 1.x\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int virtio_spi_probe(struct virtio_device *vdev)
>> +{
>> +	struct virtio_spi_priv *priv;
>> +	struct spi_master *master;
>> +	int err;
>> +	u16 csi;
>> +
>> +	err = -ENOMEM;
> Why not do it with the definition itself ?

Replaced in the meantime all definitions containing the word "master" by 
the word controller when they existed so I'm not using the compatibility 
layer containing preprocessor definitions any more. For some reason 
there is no function spi_alloc_controller() so this here is the only one 
which cannot be replaced. It's already the function.

Update: In newer kernels there is now an identical spi_alloc_host(). Why 
now host instead of controller? I get mad.A lot of people still use 
spi_alloc_master().But this is a new driver so a change to 
spi_alloc_host() is most probably required.

>> +	master = spi_alloc_master(&vdev->dev, sizeof(struct virtio_spi_priv));
> sizeof(*priv)

Some people do it this way, others the other way.

> and there is a devm_* variant too that you can use.
Not that I'm aware of now.There is spi_alloc_host() as alternative 
frequently used now.
>> +	if (!master) {
>> +		dev_err(&vdev->dev, "Kernel memory exhausted in %s()\n",
>> +			__func__);
> I think we removed print messages for allocation failure earlier, as
> the alloc core handles it now. This may not be required.
Seems to be that way. Other people print nothing.
>> +		goto err_return;
> We don't need to free any resources, maybe just return directly
> without an unnecessary goto here. Yes it is normally cleaner to remove
> all the resources at the bottom with a single return point, but we
> normally return earlier if the resources were not required to be
> freed.

Again here, some people do it this way and other people the other way 
around.

>> +	}
>> +
>> +	priv = spi_master_get_devdata(master);
>> +	priv->vdev = vdev;
>> +	vdev->priv = priv;
>> +	dev_set_drvdata(&vdev->dev, master);
>> +
>> +	/* the spi->mode bits understood by this driver: */
>> +	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST |
>> +			    SPI_LOOP | SPI_TX_DUAL | SPI_TX_QUAD | SPI_RX_DUAL |
>> +			    SPI_RX_QUAD | SPI_TX_OCTAL | SPI_RX_OCTAL;
>> +
>> +	/* What most support. We don't know from the virtio device side */
>> +	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 16);
>> +	/* There is no associated device tree node */
>> +	master->dev.of_node = NULL;
> No need to unset a field which is already NULL.
Yes. And reminder for me: I need to check this line, there is a change 
now in my WIP version which is probably wrong.
>> +	/* Get bus_num and num_chipselect from the config space */
>> +	virtio_spi_read_config(vdev);
> Why call it in the middle of all the initialization. Can we do it
> before virtio_spi_find_vqs() ?
We have to do it for V9 spec earlier as certain initializations depend 
now on config space values.
>> +	/* Maybe this method is not needed for virtio SPI */
>> +	master->setup = NULL; /* Function not needed for virtio-spi */
>> +	/* No restrictions to announce */
>> +	master->flags = 0;
>> +	/* Method to transfer a single SPI message */
>> +	master->transfer_one_message = virtio_spi_transfer_one_message;
>> +	/* Method to cleanup the driver */
> Some of the comments are not useful at all. The fields are self
> explanatory and don't need a comment, unless there is a reason for
> initializing it in a certain way that you want to mention.

Maybe. Here really seems to be over-commented in hindsight.

>> +	master->cleanup = NULL; /* Function not needed for virtio-spi */
>> +
>> +	/* Initialize virtqueues */
>> +	err = virtio_spi_find_vqs(priv);
>> +	if (err) {
>> +		dev_err(&vdev->dev, "Cannot setup virtqueues\n");
>> +		goto err_master_put;
>> +	}
>> +
>> +	err = spi_register_master(master);
>> +	if (err) {
>> +		dev_err(&vdev->dev, "Cannot register master\n");
>> +		goto err_master_put;
>> +	}
>> +
>> +	/* spi_new_device() currently does not use bus_num but better set it */
>> +	board_info.bus_num = (u16)master->bus_num;
> I am not sure if you need explicit casting here and while converting
> from u16 to s16.

First the code is made that way that master->bus_num is in the range 
0..S16_MAX so that we have no loss of anything in this assignment with 
or without cast.

Played around in user space with int16_t and uint16_t. Without cast

- MISRA C 2012 Rule 10.1 violation but we're not doing MISRA C here so 
this may be considered as irrelevant.

- Cert C I am not really sure, would be CERT-C INT31-C and the examples 
there show a cast. We are not doing CERT C here but I take this now as a 
small hint.

- FlexeLint warning "Info 732: Loss of sign (assignment) (short to 
unsigned short)" in the default settings. May be irrelevant for people 
never having used FlexeLint but I personally take this already as a 
stronger hint.

- Searched around: With "gcc -Wsign-conversion" or "gcc -Wconversion"

warning: conversion to ‘int16_t’ {aka ‘short int’} from ‘uint16_t’ {aka 
‘short unsigned int’} may change the sign of the result

Learned now that also for gcc exists a warning setting which makes the 
lack of the cast a warning. The cast may not be needed for the current 
settings but for my taste it should stay in.

>> +
>> +	/* Add chip selects to master device */
>> +	for (csi = 0; csi < master->num_chipselect; csi++) {
>> +		dev_info(&vdev->dev, "Setting up CS=%u\n", csi);
> Should be a debug message ?
Yes, this is too noisy.
>> +		board_info.chip_select = csi;
>> +		if (!spi_new_device(master, &board_info)) {
>> +			dev_err(&vdev->dev, "Cannot setup device %u\n", csi);
>> +			goto err_unregister_master;
> What about freeing already added devices (before we failed) ? Is that
> done by the core automatically ?

Looking what others do I see spi-xilinx.c not even checking for the 
return value...off-topic.

The function spi_unregister_controller() has a comment

"/* Prevent addition of new devices, unregister existing ones */"

and there is a line below "device_for_each_child(&ctlr->dev, NULL, 
__unregister);".

I would say it's done by the core.

>> +		}
>> +	}
>> +
>> +	/* Request device going live */
>> +	virtio_device_ready(vdev); /* Optionally done by virtio_dev_probe() */
> Normally a driver shouldn't be calling it unless the probe function
> uses the virtio device, like it is done in GPIO. Since it works for
> you just fine, you can simply remove this.
Yes, this device does not do any queue request at the end of probe so 
the line is here not needed to get the device live before return.
>> +
>> +	dev_info(&vdev->dev, "Device live!\n");
> Debug message ?

This or remove.

>> +
>> +	return 0;
>> +
>> +err_unregister_master:
>> +	spi_unregister_master(master);
>> +err_master_put:
>> +	spi_master_put(master);
>> +err_return:
>> +	return err;
>> +}
>> +
>> +static void virtio_spi_remove(struct virtio_device *vdev)
>> +{
>> +	struct spi_master *master = dev_get_drvdata(&vdev->dev);
>> +
>> +	virtio_spi_del_vq(vdev);
>> +	spi_unregister_master(master);
> The ordering should be just the opposite. Free the users first and
> then the resource.
Yes. Actions are started by the master so first this guy has to be 
stopped subsequently everything it depends on. This is not the device 
side logic, I'm on the driver side.
>> +}
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> +/*
>> + * Compare with i2c-virtio.c function virtio_i2c_freeze()
>> + * and with spi-atmel.c function atmel_spi_suspend()
>> + */
>> +static int virtio_spi_freeze(struct virtio_device *vdev)
>> +{
>> +	struct device *dev = &vdev->dev;
>> +	struct spi_master *master = dev_get_drvdata(dev);
>> +	int ret;
>> +
>> +	/* Stop the queue running */
>> +	ret = spi_master_suspend(master);
>> +	if (ret) {
>> +		dev_warn(dev, "cannot suspend master (%d)\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	virtio_spi_del_vq(vdev);
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Compare with i2c-virtio.c function virtio_i2c_restore()
>> + * and with spi-atmel.c function atmel_spi_resume()
>> + */
>> +static int virtio_spi_restore(struct virtio_device *vdev)
>> +{
>> +	struct device *dev = &vdev->dev;
>> +	struct spi_master *master = dev_get_drvdata(dev);
>> +	int ret;
>> +
>> +	/* Start the queue running */
>> +	ret = spi_master_resume(master);
>> +	if (ret)
>> +		dev_err(dev, "problem starting queue (%d)\n", ret);
>> +
>> +	return virtio_spi_find_vqs(vdev->priv);
> You need to setup the queues first and then resume the master.
Same driver / device side view mistake as made above which needs to be 
fixed.
>> +}
>> +#endif
>> +
>> +static struct virtio_device_id virtio_spi_id_table[] = {
>> +	{ VIRTIO_ID_SPI, VIRTIO_DEV_ANY_ID },
>> +	{ 0 },
> The 0 value here is optional. This can be just {}.

Maybe. I just looked here what others did. And others (virtio_net.c for 
example but not only) have { 0 },

>> +};
>> +
>> +static struct virtio_driver virtio_spi_driver = {
>> +	.feature_table = NULL,
>> +	.feature_table_size = 0u,
> You can skip defining them and they should be initialized to NULL/0
> anyway.

Yes. What others do here is what you propose.

>> +	.driver.name = KBUILD_MODNAME,
>> +	.driver.owner = THIS_MODULE,
> Or:
> 	.driver = {
> 		.name	= KBUILD_MODNAME,
> 		.owner  = THIS_MODULE,
> 	},
Some people did it this way around, other people did it the other way 
around.
>> +	.id_table = virtio_spi_id_table,
>> +	.validate = virtio_spi_validate,
>> +	.probe = virtio_spi_probe,
>> +	.remove = virtio_spi_remove,
>> +	.config_changed = NULL,
> Here too.
Adapting to what's general habit.
>> +#ifdef CONFIG_PM_SLEEP
>> +	.freeze = virtio_spi_freeze,
>> +	.restore = virtio_spi_restore,
>> +#endif
> This is how we define them now a days.
>
> b221df9c4e09 i2c: virtio: Remove #ifdef guards for PM related functions
I see. Not so recent. But recent enough that I don't have it yet on the 
target. Someone had to point me with the nose on it.
>> +};
>> +
>> +module_virtio_driver(virtio_spi_driver);
>> +MODULE_DEVICE_TABLE(virtio, virtio_spi_id_table);
> Maybe add right below the table without any blank line in between.
checkpatch.pl was happy. Looked also elsewhere. No issue here.
>> +
>> +MODULE_AUTHOR("OpenSynergy GmbH");
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("SPI bus driver for Virtio SPI");
> Maybe just: "Virtio SPI bus driver"
Which is the wording i2c uses and sounds less clumsy.
>> -- 
>> 2.25.1
>>
>>
>> ---------------------------------------------------------------------
>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

