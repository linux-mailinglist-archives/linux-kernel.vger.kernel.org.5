Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CFC7BA1F8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjJEPIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbjJEPHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:07:03 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on20612.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::612])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7201927B18;
        Thu,  5 Oct 2023 06:38:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSTTp4Enkd9V3ItoVf+lFAzVX3xa4gUw3csJcuSAAMr3XTJJn4T6pjYt6dB29sBdvgCxYbCiHJQqAAfopHaW84PG22+1LEwrTn5h71RkS8KoMtoT6r8mrdABFybDwb6RPH15VKoinwdq5Jhi8rkr+3XtUsNryT0tbwq8IVoW9GhSe6SB/0zHTk9QcBP2Js+1HylILqIAedALvnxcu8gmhFt6gUWQh6mkL5r35semsc3TSGo8YNxDY0gY34SCn8woomGvDwtgYsDEZQJXsYCPVG2rDKVKnBx9Gv4CkIZBAO9L4BHb+if1YQ7SnC84cTQuc1Taqt2TrB0NKWEGga44gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzmTStI14H8mc6nWA6voZyNOvYrkqmW0XC4GJ5wW1LA=;
 b=Wov5OrkYvOSjOm7qQQ5Y/MGcJHx4L1neS4CL4XIkBVipD1a9cCNTtoz2tT0/r0vBz45ePCd7EoKTR9vFiKBDxPPx9txphz0tj2/wq2dy8D4/ICp0NbNCRQrIKUrfIARFVBqy0Xq9fN093E2xZ/OzMRFW4PJ0I6b+Gk4JWuuuI0XX3pFbbHj2YOXp4yOdyj+ZoYzOWrOIDCBHykLdMkmCJ/0cQMN6afKSQ2ORgLsMQQOYMjUb645X9ztcGEcGz1PKOJfQdi4vOUHG1cqixEI1bL7jOxMlq9eHcqL+LlHd/MCj5tMldFcLQe0ECpKNrL6KZ60dUxIf2SXAQxP++Cx+gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzmTStI14H8mc6nWA6voZyNOvYrkqmW0XC4GJ5wW1LA=;
 b=qjo4rZIfjruFgGvGzlaNXqgxW024mVfpZxLfKgSqlXYVSbSFYCl7FNuVNidKe4Qc1wigoqvjdEvevhkLjhgVJbnyJ3S8G7fxTk4pbDryI2D0QSn8iEawy6sptXBCU24JYvPu9VSafsFYmuGz2doUOxgQe3Cl+1wHdy3C1uFbK5U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by PH8PR12MB6819.namprd12.prod.outlook.com (2603:10b6:510:1ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Thu, 5 Oct
 2023 13:38:00 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::1ec:3e1e:98f4:b1b9]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::1ec:3e1e:98f4:b1b9%7]) with mapi id 15.20.6838.029; Thu, 5 Oct 2023
 13:38:00 +0000
Message-ID: <1c8e4e94-8781-7126-2ded-e4198db4129e@amd.com>
Date:   Thu, 5 Oct 2023 19:07:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] soundwire: fix initializing sysfs for same devices on
 different buses
Content-Language: en-US
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Mastan Katragadda <Mastan.Katragadda@amd.com>,
        "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
        "Hiregoudar, Basavaraj" <Basavaraj.Hiregoudar@amd.com>,
        "kondaveeti, Arungopal" <arungopal.kondaveeti@amd.com>
References: <20231004130243.493617-1-krzysztof.kozlowski@linaro.org>
 <6628a5f6-ed22-4039-b5c2-2301c05c7e3e@linux.intel.com>
 <2023100453-perfected-palm-3503@gregkh>
 <624b044a-1f0f-4961-8b57-cb5346e7b0d3@linux.intel.com>
 <2023100452-craziness-unpopular-7d97@gregkh>
 <04c5911a-a894-44b3-9f0e-fe9e6de203f2@linux.intel.com>
 <d648c3d1-53ac-4021-ac7f-6a81f1a72dd3@sirena.org.uk>
 <bf4ee895-293f-4bc3-ac4b-30df6361e973@linux.intel.com>
 <c7fb4ead-13af-438b-a199-c52105545047@linux.intel.com>
 <c0cf1873-f72d-3cd3-0b70-db70d76546f5@amd.com>
In-Reply-To: <c0cf1873-f72d-3cd3-0b70-db70d76546f5@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0089.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::7) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|PH8PR12MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: baf0e308-1e0d-48da-6cb1-08dbc5a84a5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g+HihGqKgzr6fYEOJwcDKbhI3FU5ziJU/txFw+cV4BZ9E6z7DSdbAgqXs1XIp77D74tWq+RxkDsmKW9G3d3vlxVpUoYMQWmonKtgKYM5lENuaLe6vBo8+9Ec7VtqnXchlgbn6Dz4X8Z4k7Xd2L+rE57Egv+CzgsnrYnHELEs21LbYRBN3Nsv0Ty2XS2nV16fCnxDZx312T+22LAiEnj4dR7qjIg1GUJhFYIkFnxLjEmon28DPSv9RKq714IubHIvlYFkIvFruO7+NRn2TzMlwP+8lt2xx1wYthIwhHONkq97MBAja2+Fg62h/Lf3Pgtc1gbSHKCUNMxCFuxwoU3yTDnWQuZHhoTTEdypsQD6Udi0WccJZCdnZq2VxlijP7OFUBD529ClvVxlzJLQJn+g5qhuvOok63hx4QXILdyJMKJ3AOad0su4bJCf1XVZvpSsVQJUM7hY02zB7IuWQbdYTTZXtBbDwtYcZ+CFma9s6/PMga/Ov3qCMEFxEbeMBPtMiTuVi4kkVXdicVXkMA/qYkuROYiGp3GvawdW9KvCyW9MtAWBv++vfHE5trKCQUVDctcOzu1gjrINPxkx4ITqucy4aRWSV17FYb5KHqnPQn7BVNmDfrjDb6TkM891Qaz0trd+S5bNvbWwrEw6OLxrKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(39860400002)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(66556008)(478600001)(54906003)(8676002)(4326008)(26005)(36756003)(316002)(66899024)(2616005)(41300700001)(966005)(86362001)(6486002)(6506007)(6512007)(6666004)(38100700002)(31696002)(53546011)(110136005)(66476007)(66946007)(2906002)(7416002)(8936002)(5660300002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmFrVzljUi9RNGlaWXkrakRMemc0OTFsYndWQlFFb1lid2FaMWorSEY0VHZI?=
 =?utf-8?B?dGlDdGJMYzIwNVE4WXVPZDZ3Y2U1VjdiaVZCWURjbExUOGU3a3N0UEh3L0h3?=
 =?utf-8?B?eG0xSUZBRmdIRm8zeFJVQ2x0aVAyQ1lJRDhzb213ampJRldRMFZlUHlqT2pq?=
 =?utf-8?B?N1ZORU1WbzJIekhHMmllNXZXcTdsSEdPQndRQ2xudW1ON29VSkdrS1pRZEJj?=
 =?utf-8?B?YWFMSVNQZ0lJb1pkcWJheXBzUXpPb1hyZXE0ejhGT21EM3JrUG5qcEJkbUJv?=
 =?utf-8?B?clo4bmNIRWg5bUhoZUZkSnA5S0FxT0Q0ZFRNZEVaMERtQUxkSTBseHdvbmFI?=
 =?utf-8?B?dzNxdkt6SDRjdHZyVFZ3amhmbHV2SHR0YjBpZWY5ajREV1NNb29BeFNRSWU5?=
 =?utf-8?B?ZXRiRkowOHQ3UmQ5RDI4bHREc0VLeEx2aGVranJBMHFMOUJKb09lQ1dFZ3RU?=
 =?utf-8?B?OGh4VjdrWUpMN0RZR3lJUlJiODF1VzdrVmFkVHBJNm5PTWVRc1ZvZHFxbGI3?=
 =?utf-8?B?aCtvbExjRDM5M2p4aTFvU1dUZGM5TnVjYTdic1RSU2dqTWRIeWluTDNaalp4?=
 =?utf-8?B?alhLVU1zVmFTcEZjanJEZUEzSENWYURIbEU2SkNpd2J5eXN3dHp0YVhYLzd3?=
 =?utf-8?B?Y1VFQ3JTVXY3N2NWQU9RcCtiMWpPSTliQ1hCeS9UVGxhakhhaEdtQmVHWmVP?=
 =?utf-8?B?R2lvRys3OGJaaVVLVWdRVFNObFArZGxaa001bXNudjJsc0dTY0JQUEdoSC9N?=
 =?utf-8?B?WW44Wm9UYXNTVGh3dWdFb1NRRXV2dkI2UkNnSHRlUVh4K2dmYS9nTE81bHVS?=
 =?utf-8?B?QS92M0dyVTRBKzlFcSt1Y0FRMlh0blg5MUV1Nm5mbEEwY2duZ2dIMUJIMkIr?=
 =?utf-8?B?MThYenZBbXNaakk5a1NzdEkyVk1DaVJmZTQ2UnIrN2NlMjdsVXVoam5WZjBo?=
 =?utf-8?B?TGtFUHp4NEx0WlEyYWlaY2NKbG9keEVlV0R5bnVSTlBmcGQwTUtxTmE3eGVX?=
 =?utf-8?B?TGZSeTZla1VOY21MbzhlblphaXlENEJMdGNYeU1qVThFQzZodGxkOTZuenVD?=
 =?utf-8?B?Vk5lMXpDSmk5NmRsdXlvK1RDV2N6OThlbzdLSy9ndEFMSkkwZC9RZ2V2YUpQ?=
 =?utf-8?B?Wmw2U01GakNoNTRzQ2pURnExYzNyZ3NVOU05WTgxcDhKbytvOWdoOHJrN251?=
 =?utf-8?B?amNUU1l4QzhScXlhNTZUT0ZZdElFSm4zdVVaelhHU09ISmFqaVVBdzhOVldU?=
 =?utf-8?B?WEgvMDVoZlIyQWpGRDBzb0xzZnJmMGhzbGkxTXBaNFJlMS92YW9BN0NBUlZK?=
 =?utf-8?B?QU1sV1RsOW43VXJFam5PckM4OHJ3SWRQbGhBL003VzZGbERQTDRFMXdjanQ5?=
 =?utf-8?B?QkZkYXVJQzkvSEJuRW9uUi9pZnAwYXlONjNobmtITWpWTWgybWhuNGI3R2xi?=
 =?utf-8?B?OGpoSXBhclFjeGhjb3hxNStwR3IzemJva3JFOEQ0eEZWdEdlRjd3N3hIRUkv?=
 =?utf-8?B?eEs5TlVpNHpLKy9sQmVUNEhuOXpkL0NudUxGL1A0RUh4Nk1EbzhnRG9lUHdF?=
 =?utf-8?B?Ymt1SzllaFEvSnhTM2U4TVRFdG9VRWtWMWhzZWlkQ1d6NlFGNU4zUndSd3hP?=
 =?utf-8?B?TndCSFdaNWVvMXdqVXE4T0FkVndBT3F5ZUJHU3daK1ZZTmsybkJMU1hSQ0R1?=
 =?utf-8?B?ejkyL2NycVpYWlFWVEJ6QVRCVWlRMCt3Slh3L0I2RWFZdXhLaWI3TTRuMGV1?=
 =?utf-8?B?WXQ4Q1ovZ3BVUnhEeTNnenhTbm8zK29QSDJ5QXNlbGxqcWdOeHBBUTdGdXVh?=
 =?utf-8?B?am9maWJpbnBWWDVxaTA2a2ZYV2pXQ1d3cURKcXNlUlZqYU9nb1FhaThGenpa?=
 =?utf-8?B?djdVR29NUlRtRE9YSlo5TzB0OGZIajZWNUlpb2ZOTHc3Qy9iQWFkclVnZkQr?=
 =?utf-8?B?OFBhdDY5WkNzd3ZlOU1hTlhIdjRFMWhjcW9sOUNWb3g4dlVDcUlHWXhNNVBp?=
 =?utf-8?B?cnVIKzJrU25YblltQ0JNVHZMU3p3U0orcmF0UXFVbDhjYW5wbmZSZnQyVG5m?=
 =?utf-8?B?eGRiR2RIdDVVSFpDczFTbzg5V0pBbE1GS3lhQ2VibDB5WWJlWS9mZEQ1d01S?=
 =?utf-8?Q?/K3LN79cMxL20x3UFsp96EMON?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baf0e308-1e0d-48da-6cb1-08dbc5a84a5a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 13:37:59.9308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MtwO4q7R+JKVlsafuOLSm3iN6LVQroxrWG2vRfyjrw53R6lPacraml3ACEHtTHRuGBEcGtbofbqeDDQFTkCBHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6819
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/23 18:08, Mukunda,Vijendar wrote:
> On 05/10/23 17:54, Pierre-Louis Bossart wrote:
>>
>>> I think we keep circling on the differences between "Controller" and
>>> "link" (aka bus). A Controller can have one or more links. A system can
>>> have one or more controllers.
>>>
>>> Intel platforms have one controller and 4 or more links.
>>> QCOM platforms have one or more controllers with one link each.
>>>
>>> I am not sure how this IDA-generated bus_id helps deal with these two
>>> cases, since we can't really make any assumptions on how
>>> controllers/links will be started and probed.
>>>
>>> What we are missing is a hierarchical controller/link definition, IOW a
>>> controller_id should be given to the master by a higher level instead of
>>> using an IDA.
>> Tentative patches to introduce a 'controller_id' that's not an IDA are
>> here: https://github.com/thesofproject/linux/pull/4616
>>
>> Initial results are positive for Intel devices. it *should* work for
>> other devices but I can't test. If folks at Linaro/Qualcomm and AMD can
>> give it a try, that would be much appreciated.
> Will test on AMD platforms and let you know the result.

"soundwire: bus: introduce controller_id " patch  needs to be modified
and controller id should be set to zero for amd platforms as we are
populating multiple links under same controller id.

>
>> Thanks.

