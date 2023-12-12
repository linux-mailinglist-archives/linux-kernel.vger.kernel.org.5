Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7936980E460
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 07:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjLLGlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 01:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjLLGlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 01:41:18 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40F1BF;
        Mon, 11 Dec 2023 22:41:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LiwQyc4yxSunkinzFAXNLAyFzb1n09DUaKqpkZx90Nqj1KCd8R78QxaFTmNcEhyAFpf3Qp2KxPZRgPlWVxeDCKAp9BH8lVqYqqJQ+LOTayQVBmurbZey24UECORkbRR0LTyFPrpdLrFVmntV6UQ5jZ+fyyHur+jMCJy+5cR+3ExkP6RZL3JGfZxMWlfG+nB5/+EJkel1sMPH+yDVwYXLBICiKngHoA/r41NI9/fWO3AmD8b79cEBHDMmD1i2tMj9nTuAyB3CfnckiAZpJGRNcfoGlh1S6ry1xnpA/eCotfYJXV3AoRko3mfVk2i8ft08f7TxJAL78/oyd+Y6UWHnpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OtZMo4HwpgZwlyA0ho0C6ELXfCpOcO4rC4XP3PC8+BI=;
 b=oeOl3fucDvFogNGjsAjCkfPKEn/aU+b7nowPCrP5mBYqW3BZMR+jigbzX8AXpxJAhOUk08i5EDMAvOsORyiewUt/MFCniYVwr3RxrwTsQS/tX8bNUINUXWDB364M6Q7lvmm9969fw6MRZMZyk2DCUtaaFVrg0dQ3hcSIJTTp+0nZHchyTS2tOllHBbeRfndosHa6u7egbnxVlbx5xzBZltE5R/0euAzSYn+BjQu1b3SgJfM0r6K2FWLRFYcHlXHZYoQw09qNEz+L5w50PZSc+7UtP3wlET0aBkzhF7L4BybdSoh4x53fYjz69V3mOmS2WYyJugPFML3ARKozHa3Nww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtZMo4HwpgZwlyA0ho0C6ELXfCpOcO4rC4XP3PC8+BI=;
 b=beUK0vuTO9STHdUeMQQDG0s9BkdL7PvUwo3nUXMe9A7nFbBI4d8wexBw2QkB0gibAT0DxYUmNLw/+pySnnw/nDgsYErs90WwyDm9qpcwrsyp4JBtwP8xlMUalgPzYtQC4dmfJdIBtYh4cLhBLKm9NlmGitpXdb0AgjbIEXa9YC8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 06:41:21 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::59d1:c9f5:2c67:1da6]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::59d1:c9f5:2c67:1da6%4]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 06:41:20 +0000
Message-ID: <bfb6d995-ed93-4bb8-923e-db0aabc88946@amd.com>
Date:   Tue, 12 Dec 2023 12:11:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] ASoC: SOF: topology: Add new DAI type entry for
 SOF_DAI_AMD_BT
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marian Postevca <posteuca@mutex.one>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Mastan Katragadda <Mastan.Katragadda@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org, kernel@collabora.com
References: <20231209205351.880797-1-cristian.ciocaltea@collabora.com>
 <20231209205351.880797-12-cristian.ciocaltea@collabora.com>
 <fad8a055-eabb-4087-94d5-9e1de00933e4@amd.com>
 <aa830670-e544-43a2-9ba9-a64f1964a9f5@collabora.com>
 <318470ce-1631-4c46-b425-755c877dda65@amd.com>
 <421128f7-6a17-4be9-a72b-272ea4017fbd@collabora.com>
 <ZXXEsyBUCrBULNgk@finisterre.sirena.org.uk>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <ZXXEsyBUCrBULNgk@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0206.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::17) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|MW4PR12MB7016:EE_
X-MS-Office365-Filtering-Correlation-Id: 6804d48b-b3fb-4eaa-36b0-08dbfadd598d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pLTmue9jE8rlL6oPBQmTE6q9gKphNLNObiaO1UHWBHG1eV+t8YVwy+IdBdeULw39xTzwOFhBEDb3IfskpK5Tn6ruaeyD42Go5+6Gg0/QOqUDv/58lNH2KG6kjz1w/TE8KiMgOkd2/e3rv9vIFGKNxp3h0I472/vxCMZSNjyHV7/562b+YeXNWXptKx8UVbe5B67NZSnCO8LpZs310J0fONDqTG1U0EcmN1OLuIjAntxgTP8PNHWsfN+5VGVkrjkkPnCb4qeR543gdzp3AFQRB8L8umJfuoS53u2fncvSF6FzJ5HfYmux4jUBbBGx1vKGKdFI/rFLaC4P+4VV9jWo5jWzTn+p9LjDVdVdsLzZLN+WqjQuIrTvh8Cla/90Zn4fMPKBNOTYQiFQUAYUF4UIN4Os7fFFPy2zXkD4WpEDZFGC3G4OQ8x532RJdmUb09WUIS25ePx7yqDsUNpPBHWCjlufzG5KISiFQLDZYB9W1+iSQyqhVDkqgCdzNbZBi6vR0wykQUUk3tX5dRzpg5w1o0PiAsPd/63IJb3MK3uXxqWJKeMIPHHqeWXQMULPZDinkmBpH68nCgTlptoXT6o3f89OD7jQmL+YlfpHX/oyOPfBbKHobcbvIJ68OAw910HNG6zP0r8m7jqFB8IEDXu3rA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(346002)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6512007)(6506007)(5660300002)(26005)(2616005)(36756003)(53546011)(7416002)(6486002)(66946007)(66476007)(66556008)(54906003)(966005)(2906002)(83380400001)(31686004)(86362001)(478600001)(41300700001)(8936002)(4326008)(8676002)(31696002)(110136005)(316002)(38100700002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWlxVmgvM0lqOTFoRnlmdmx2a1U4dXdyZUxFUnFpVGZucmczb1VvZHpHeTdo?=
 =?utf-8?B?amtyUm1uM3YvRXdyYTFuQXQ4UW15bTUyQ2k5WUgyZFdSSW12ZWprQVlBNXZl?=
 =?utf-8?B?MjUwWnNJU21rSXNPUEJHclM4WUVBWXpTK3V4YmJmK3J6Z0JHc2NQUzlZWEFS?=
 =?utf-8?B?c1VDSkJsK1hhejlPSThCN2piVTJZSDNVb2J1T3lTbUZIMWlldW5nOVlkbHVL?=
 =?utf-8?B?bm92Z1I0QnJyRmtvbW5vdncxb3J5MmhhRG9vYWh6aU8zYkJCUXdreUNYT1lk?=
 =?utf-8?B?cktXSlNNc0w5aW1Mbk1Xa0cwdWFHUUtZeUMyNHdQdGZLcTlvNTQ2aDRlekRO?=
 =?utf-8?B?L0NKclVHOW5JT1FKRWpjK3ZoZWl5cndBbXdwNmlnUHZmOVZaNlNJQitaYlZm?=
 =?utf-8?B?c1BJNkV3RFYwR3pVSURNY25SMzZhY3Bxby9ibFFIM0E0T3paWW5ETG9FbHk3?=
 =?utf-8?B?c1p3QXlOSXduOGJSMERTZE1WUUV1WmhXa1lXMDF4cEJDOFUyUDUyVFo2TGZR?=
 =?utf-8?B?MnIwU3BlSTVtcU4yajk0cEx6RXJxU3RKUWtOcEU5WEIybUl2SXZkeGc1cW54?=
 =?utf-8?B?aTVKMjNEemhBU3lKS0RGUXdQTXp4WEJQQjhqM3Y5b01FSkwwSlhZM0lSa2ND?=
 =?utf-8?B?S3ZHR0pDUGQ2ZnRMMCtzN285L1o0UTR5TjdPcktzUHhkNDhRNVJTRVJXYmdC?=
 =?utf-8?B?bDV1eUpmYjNEd3FCYU91eWN6dUFQMG1OblFjRWltYmRNTDhyWVRkQTliRjR0?=
 =?utf-8?B?SXNEOWZCZm5LeHNZMXpZRW1RUHVGbUlYQzB3eVd1UEZoUTRpNVQvRGs2S0Uz?=
 =?utf-8?B?cjNEYktrcEhlMHh0SlZiV3JnNlRpeUQzVjZqOUFmSkpXcTcxQWg0d2YyMHlM?=
 =?utf-8?B?TU9qMnU3YjBySVdUM2U0UUFxcm5PQVhlVlAxMHRGVmpNdm9TKzFCdXRFOXkr?=
 =?utf-8?B?aG91eDFZcURuY3REZ3lraVlxNWR3YkZwU2JMa2FQcUIvWkNqek8xVEZqZFlU?=
 =?utf-8?B?SHdMcS8vOU5ybHVBSmdiaDMxeXhjRjRQR2lEOHgxWmlHK2dldFhBejVRNURw?=
 =?utf-8?B?R0h6TTVtUFRWdVA0ZHN5WDc3QWxBWFFOcDU0RzRRcUY4ckhTa0lkakJCZTdh?=
 =?utf-8?B?MXRoVnFiSURPalgvcld6ZkdONUhEeXROQktkOHRUdGhBRmtaZTF3RG5sYVhF?=
 =?utf-8?B?SEJLTk9ISFAyRkxkeW9DSmZNSWpJRE82RmJ1WStmNGdWNmx5ellEZnV1d1hX?=
 =?utf-8?B?N2RhcllITStLUlo3NVE5SVRpaldYWmpReVNsMkR5d1F2QlJyWnhmMnZPWDZo?=
 =?utf-8?B?VGc4WTVZR0RkNGhqM1JBM1FBNWE3MFNqNlFOZkpHVzZTOXJkdnRXcSs1c3Ft?=
 =?utf-8?B?cGxTSWNmM3JMUmN4NXBNQTNTeDFiK3hVdlN4bUJ5YS91WGVHQTdrQXNMN2F5?=
 =?utf-8?B?VWxmTzB3VnBreVcxdnpjOFlLZ1pzTUY1ellTbnk4YjNQSjNMU29ac1FUNTdM?=
 =?utf-8?B?OHNVU3czWFRCdzRFZXB6WFQvckdmRGY4MTM4QVJ6ekE1M3NxK1hHdmdRMS9F?=
 =?utf-8?B?ZUl6aXptRE5GY0syeklKVFl4VmVCZW95aHFSUk8xTjNqVUxzY2hXSGdEWkFJ?=
 =?utf-8?B?NHdqRGF6TkR3RS9vRGF3NTE2QnFOU2FNcDNzdjRUUkw5cGp2Y2pNNDVNKzgw?=
 =?utf-8?B?Njhxam0wQ2FSMU4wQUprbEhOWmFwTUpyM2ZZYzNsTjd3dS8wNlZROUhhSldX?=
 =?utf-8?B?RUZDZlVGRHVxZ1JTV2JsRTIwY1U0a2ZqM2RDbkRPdW5GRURVZ2tHbjFRa085?=
 =?utf-8?B?dTU2MkJyUFM0VXRSY1Yra01CbTY5ZzlWZzhkVEEraDlLODB2Um0xWGJQZjJQ?=
 =?utf-8?B?a1RQQ1k5NVE1S3dFZU9ZZldXb1BHelpCQWE3T0llZnlVVTBqZWtkOC93ck5L?=
 =?utf-8?B?clpmVE9rUmFCaXhiZ3U5bFViSFlUbWZ4Ykh4cFJmWGs4ZmdZQlk2Y1hOTjc5?=
 =?utf-8?B?dVVoQU1XTnVxUkZNZUo1NjU3dTdsYnpVUjN2V2hoZTZzU3Y3OEpua1FsbnE1?=
 =?utf-8?B?THNCSEkrL0E1Z2J1MnlWT01CM0c5TnJSTmJDRW8xdlRqekJodFhDdkgzNmF4?=
 =?utf-8?Q?f0nd2cs24IsccCmQkhvKorH5R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6804d48b-b3fb-4eaa-36b0-08dbfadd598d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 06:41:20.1952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LVOe7KXDn1FKokmxxdSGlRGiJ2Bi822QWy3Iuw0C+SAzpk6d4GTfd/5SAVCi65mxp4hxYTeCVOpAo0LWYQxVCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7016
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/23 19:31, Mark Brown wrote:
> On Sun, Dec 10, 2023 at 12:12:53PM +0200, Cristian Ciocaltea wrote:
>> On 12/10/23 11:51, Venkata Prasad Potturu wrote:
>>> This should send to SOF git repo for rewiew, once SOF reviewers approved
>>> this, again need to send to broonie git.
>>> All the changes in sound/soc/sof/ path should go to SOF git.
>> Unfortunately I'm not familiar with the SOF dev workflow. So it's not
>> enough to have this patch cc-ed to sound-open-firmware@alsa-project.org?
> The SOF people basically do their own thing in github at
>
>    https://github.com/thesofproject/linux
>
> with a github workflow and submit their patches upstream in batches a
> few times a release, however my understanding is that their workflow can
> cope with things going in directly upstream as well.
If patches are directly pushed to alsa devel list instead of creating pull request for SOF patches
It will break SOF github work flow.
Validation across all the platforms is a potential challenge, and it will also create an overhead
to pull the patches which got merged in to for-next branch, before the all the patches pulled in to SOF
GitHub.

