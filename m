Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1287643EE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 04:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjG0CpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 22:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjG0CpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 22:45:16 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7721724;
        Wed, 26 Jul 2023 19:45:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9sOQeDw5Hq6LB9dsprgC29w5V84OaGrRkuf+2gBUbnb83862qkYVHWqjeUc2itPSkcGxRpjXGQcQXS4E0y9ILvN6KHK/vgeHLe98JkPfMcSyqOcMuSw+mcNq0qbfcRPPjsl0YZCWx7D2/KfC/PJ9XAqd9HmSuo1N9mwnoPF/X/zxCAoVyZvVRV/Zb4BY6aklNKkbmh4vS4T9/qoz3foc7nE79drB341rE04d1yqZ2IOMwbtcKohUDbjvQXJ0HG56a50A32klUWa5/XdjjDvixPyy4guGCft5+cUhnryvaHB8PPwtVs/EWsQi+BhjXZ0Qjqbl2JEjs05sKJq6T/FjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gY9M+0LmptkYHfh+dLi6tGGNqsAp1cA+w3Y1BuUrUuM=;
 b=KRjzVJ+ZhsnZ6KtLoNMihHHd4L8iSdej6KDnvRuRmIzGpn9EfDgZK7Y0ZSOqetZa7ceuNHZ4gpkMLtJD6SwRd4BCYpgSNLfE9oouGOC/mAQzEQ5qjXQXNoWofDtRN6qgmsTCnKuHf7D3fsTCMifP8kcM+EUrEIJbTjsvZ3wPfbbQvC9Mbx/OA/rapQrhp19ahouObVZNEZr+SgDiKjUSHI2O9telOv80bxVcHFNoqP67TOIS5BcJet1PfoKtmbkZ32zdKRUEuSB1ZqZZi3fJirO5/GrQ+GNw/vP/PEwCnjA1lf6Qj2gjzAu1fPj8o4svtEJYrG0SYlK4zvk6mWV5jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gY9M+0LmptkYHfh+dLi6tGGNqsAp1cA+w3Y1BuUrUuM=;
 b=MKbT5ZK8HHfhYC7syFTNusC2JO0/0oN12vJATkycRsZ/1SXxre74ZMoZa7MRZuSRmTlvKQp+rFyxk7HU3EuX5Cai1a+DaB73ZSZMyeW/DUmc+sK31dTx2MHhXh3L3TkNx0EB73FHFFNaPW2AIyVd5RjWuuqtG8vDc4oMEkWtnpI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by SA0PR03MB5468.namprd03.prod.outlook.com (2603:10b6:806:b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 02:45:13 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::411c:e486:3837:cc25]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::411c:e486:3837:cc25%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 02:45:12 +0000
Message-ID: <b2d75cf6-2e57-65ab-ebf1-caaa17f479e0@synaptics.com>
Date:   Thu, 27 Jul 2023 10:45:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Stateless Encoding uAPI Discussion and Proposal
Content-Language: en-GB
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-media@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <ZK2NiQd1KnraAr20@aptenodytes>
 <c46d0c53b7e5dc8dcdf7925f3d892024390a8b2b.camel@collabora.com>
 <ZK6zjaJtulRSrn7P@aptenodytes>
 <bbd62e1b-dd0b-e351-110e-040b42d02974@synaptics.com>
 <ZL-8yBhWWChKBDHM@aptenodytes>
 <c15805b0-261b-114a-c29d-b63f00dd8da4@synaptics.com>
 <87cfcdfadee89984496c3f52d01b4f1e10c12cae.camel@collabora.com>
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <87cfcdfadee89984496c3f52d01b4f1e10c12cae.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::13) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|SA0PR03MB5468:EE_
X-MS-Office365-Filtering-Correlation-Id: da94ef18-8e04-49a8-0a39-08db8e4b7fdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ofTe8gV8tfoorm9uUd1taPB0kgO5PhhafEo+EO9a4zNkyEX8mFHQ6v2ICbmnV9mrwqq660oEgWFAAEDoGfGhvCBczL0I7rVvCl5hhI/dyVIprepE5DAEtoXzkGH5K4IWBgwyPGS+hmNpMfEeZoCQMpqzTF/pr7g219Jn9jJ5CGI8V3DkG8rvDIAdVV/re9rnl2KKjxdVg29g6i4YnIF0FfIbkHQjzP2+M46QDU9QEKdY8TyPEIwK9YskaiSkTsfVmG47i723vujAPn/2x0UdHiarIOFpSUemdfOHDo05D0WpJgeOGSDLEeEO4OcCPvt3Ng2LI5qRk88Ay57pyRbHS9t+7eSSMYOhQAf8aMirwzFZg9WlTMyGIyjex4VIPg7lsvmv1jPb5f3aF8udlBwaSM29D8R/9Ha9cMDLw4qU2Taui8IaiMEtMWqVAe1n5AvG0kRULUOle/1fFiuKVGOHW0ROCF/Lidrl7Ewlt+NfeC/uWuCx010pPsirzhWIGpccPKY3/cssGQp2G5OGYr1xwMCvCoZYFV5iqOMdX9CO8q0+Yzg7kvvCFR3lWdrpIPC3uvUQf/K25jshSI9S6Vf+ncYZ2qBmq0OVNv9g/8lWmYC9nU1lUQF3XD+rvu313gRe0e9AngtmyTyFAWhDvBvbFmzV/2USFlrRh4MdLLxtpLdmICm5mulk3wyH2CGP4Hmx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199021)(83380400001)(54906003)(38350700002)(5660300002)(2906002)(2616005)(7416002)(6666004)(6486002)(52116002)(66574015)(53546011)(26005)(86362001)(6512007)(478600001)(38100700002)(41300700001)(316002)(186003)(66556008)(66946007)(66476007)(31686004)(31696002)(6506007)(6916009)(8676002)(8936002)(36756003)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akU3OXhuMGttNGhOL1lOYVZXYmMvL0lxNERjOXNFZlR0T1V4cHRoVVQzeHF0?=
 =?utf-8?B?ZEM3c1Jxb1h3SG9TNzZiUU5xTnE0OU5mQ0NuWHBBRHVPQVN0SS9vRlFPK0Ur?=
 =?utf-8?B?SUdEWFo2ZHRVT0dhWUhSS2k3OVdqeHJrUVJzS0ZyMzBrWUlZR1RHbUFMYzZW?=
 =?utf-8?B?bXl5THluM0J2bEpxd1N3Y1hOUGwvNFkzN2dIQk9zaEo1YTlpSUc3MVZoVE1r?=
 =?utf-8?B?TmNTU2pOM0plbHFuMW5WQ0JQZFhQN0hYVDJ3eWw0S1dhOW5MK3BIVThIRmJ0?=
 =?utf-8?B?clJjZnpIUGhxdHFwZ3UvVG8vWVZnSFh3c2JWa1JDRHhhUjBSYjBxcEpDUGZj?=
 =?utf-8?B?aC9BS3ROQzhiMEVLKzNKN3RWN1Npa1lqMlg2dGZpaTVNaWF1RTFXdDNLT2J4?=
 =?utf-8?B?Zk92MTJETkhLazNOcFhpZWQvNG0wUnllT1dKTEVGVW5ZbVFiVnA2YXJOZXlC?=
 =?utf-8?B?UEJVK1VaUzRIczFycHIya09ZVFBJZWN4cGRnSDR2R1FQSFVhSFYzU0JOWGFL?=
 =?utf-8?B?Skk4SURWaTd0U2pJaEF2ZGd6UGZWZENrblFKQlFFWW5WYk1wUHdkWHFVZFR5?=
 =?utf-8?B?bDF5UDA1ZUlTdXVDN0Z5VkZmMnM5NVlidE0zOGhZSHUzNlZPNE1pT1hJNXF5?=
 =?utf-8?B?Q2VTSDd1OTU1S2dGYk1JcVM5VzVpLzJBSERUbTJGMW45VTJ6SC8xb01wZTNW?=
 =?utf-8?B?ZGJCUEM4NlA2MGMyS3FCMjNGMEpYWG1rR3dHeC9YYTFyL3J5Z3NJWGsyS3hH?=
 =?utf-8?B?QS94YTVRMXlCSVBRUlJsQlZRZW4rWmh6a3RmZ2lMVm1tbmRYSUFVQjA0RUhL?=
 =?utf-8?B?YXljVUhMUGszdDVFZytGanpCR0ZHckVEL0ZrUlRFdTRjWkZTN3VaL28yZkdE?=
 =?utf-8?B?TUNHMGhZTm8zc0FiS0NKdU84Y3pGVi9BbHQ5OWpRTWd2VGZvS1lUOVpMREJZ?=
 =?utf-8?B?ZFRrZnJSM25lMGRnZ0NYWXpxdWhiZCtKZmczZkZuVG9lbWJIM0czMDVDWG9E?=
 =?utf-8?B?QWtTNXFWNGF5N3JjS1hRSTZJTEpwcm9IUW5qWGM4aEFhdWtvMDVRYXlRUnFk?=
 =?utf-8?B?RWJRYkQwNFFhQUttdE93VXNDQ1FRVkJIV0JiVDV4L2FNRjE5MGlLWlFFSnBZ?=
 =?utf-8?B?cTMwVlM4Nzk5dWRCNWgxc3RPWlI0SStxMXp3YVJHbGdnVEY3azZhcGVucVBJ?=
 =?utf-8?B?MGptSmU2WmRFaFpSem5FSVF4YmRRWjB0QXBjTWFUZTk4V3VtblZud1o0cVdl?=
 =?utf-8?B?SjdoSkU3Z1RwTzdtK3lSREx5QUFmRDdZS3FrRmFOc1NQcWIzek16OC9Wb2VP?=
 =?utf-8?B?ZitEUjNBdlJsY0tLYjFDeUtqbkNWVUtDWHg5TDZWRmNSelI4emtNQVRuNDhS?=
 =?utf-8?B?T1p5RlVnV3BTWTBtNUpvT0Z6cUxhUEpYM0lQZDRlZlZEWG9SQk1mbmFwbC9a?=
 =?utf-8?B?ZWdqWCtGYVZBN09NZFk3VnYyOC90L29hRWw4SjhudUhDQng4VVlud1M5aTRa?=
 =?utf-8?B?dXppRVErUnp2ZHFxQ2dFZUN6VmpZc1BhOFVpUHJTZEFQb0xnaDluZExYRlRQ?=
 =?utf-8?B?NkxBdDAzd25rMW9sQ21qT3BmVG5BZS9RemNCQXlRN0tERmYrRXhWRVZDRVlH?=
 =?utf-8?B?dE9zN1Nscit5NTlFYitXN1hWRnRtZEVrYlllQ2h4cUYwOEVHblZBSHRkTUxQ?=
 =?utf-8?B?anJFdGl2SHNXZlNwZytDNTlacTRQbGZhUk1ic1R2MVJmbm5zckxWUTlJNFA0?=
 =?utf-8?B?dVZFczF0bTNyS2QzZDNxWkZwdEdicXl3STVVOUdQZUZ3ZGo2NDhFbkhFbUhI?=
 =?utf-8?B?amxDYUMvb0M3MUd1V1FVMWE1V2l2WnBONUpSbEw3cURmWVEwY0RnU1VIZW4r?=
 =?utf-8?B?VmdSUHYycmdocWdtdUxnRUZEVklrSWwzeTNmRjh3amFTaEdMTHo3bUg4MjZw?=
 =?utf-8?B?d3d3L1NlME9GaVFnc3JZM2k4U1J4R3RSSTFoVVdKV2toVjkyemw2dXRiZEhq?=
 =?utf-8?B?MFFXUC9qK3IxVkgxbmo0dXZYZTRqTGFHS2IyQWsyMmhXMW1FbGpHQXJDNy9G?=
 =?utf-8?B?WFZ5YW9XTndmVWFmd1JGWDFTRCtkemJScGwxTW1lRHNvSkJsdTlIcm9EMkVL?=
 =?utf-8?Q?O7vpDOnHMhnT1qVio5ipdj++V?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da94ef18-8e04-49a8-0a39-08db8e4b7fdf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 02:45:12.3652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CaXQqc0IF7stLnlfDxAAP5IZ35yqiobqZ7v62d+NbTYfDaSDYkh/TCy8CXADJ8PLvDClbHsbhpvoDDH4Or6B0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5468
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/27/23 03:53, Nicolas Dufresne wrote:
> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> Hi,
> 
> Le mercredi 26 juillet 2023 à 10:49 +0800, Hsia-Jun Li a écrit :
>>> I am strongly against this approach, instead I think we need to keep all
>>> vendor-specific parts in the kernel driver and provide a clean unified userspace
>>> API.
>>>
>> We are driving away vendor participation. Besides, the current design is
>> a performance bottleneck.
> 
> I know you have been hammering this argument for many many years. But in
> concrete situation, we have conducted tests, and we out perform vendors stacks
> that directly hit into hardware register with stateless CODEC. Also, Paul's
> proposal, is that fine grain / highly close to metal tuning of the encoding
> process should endup in the Linux kernel, so that it can benefit from the
> natural hard real-time advantage of a hard IRQ. Just like anything else, we will
In a real case, especially in those EDR/DVR, NVR, re-encoding could 
happen occasionally. The important is feedback the encoded statistic to 
the controller(userspace) then userspace decided the future 
operation(whether re-encoding this or not).

> find a lot of common methods and shareable code which will benefit in security
The security for a vendor would only mean the protection of its 
intelligence properties. Also userspace and HAL is isolated in Android. 
Security or quality are not a problem here, you can't even run the 
unverified code.
Or we just define an interface that only FOSS would use.
> and quality, which is very unlike what we normally get from per vendor BSP. The
> strategy is the same as everything else in Linux, vendor will adpot it if there
> is a clear benefit. And better quality, ease of use, good collection of mature
Any vendor would like to implement a DRM(digital right, security) video 
pipeline would not even think of this. They are not many vendors that 
just sell plain video codecs hardware.

In such case, we can't even invoke in its memory management, they may 
even drop the V4L2 framework.

Somebody may say why the vendor want the stateless codec, they could 
have a dedicated core to run a firmware. It is simple, if you are 
comparing an ARM cortex-R/M core to an ARM application core, which one 
could performance better? A remote processor could make the memory 
model(cache coherent) more complex. Besides, it is about the cost.
> userspace software is what makes the difference. It does takes time of course.

Anyway, despite those registers and controls part, I think I could input 
the buffer management part here.

Please DO ***NOT*** make a standard that occupied many memory behinds 
usersace and a standard that user has to handle the reconstruction 
buffer holding with a strange mechanism(I mean reconstruction buffer 
lifetime would be manged by userspace manually).
> 
> regards,
> Nicolas

-- 
Hsia-Jun(Randy) Li
