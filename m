Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3529F80CB10
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343502AbjLKNbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbjLKNbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:31:04 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2128.outbound.protection.outlook.com [40.107.20.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9FAB3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:31:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJaPKcMYreexOcbJGSmaYzc3dngzOgoiX579QXRtCME6QasacebrN47yGI8hzuzGi//Tud5hGpuUOK0+f9EQg+vA42V/Rkse6flZdSL6S+uiVMsOvoaIHPyyrgLGNyzen1iXwxEeV+ZzILpNj4fw8Xkg46MFNGn/6g+NtXvnfTvbbr7eh9jWHG6wCqgnhv4ioqZTYHq9v+XoyepzkiL40dC+pgy1lJxl97e3pCa3zzguAztciVLuPTytuhXh6lJMhOQAXpVl55UfBeaqG5bp3b/YczSQztSuZLoB4yIk7m/gUiHxHbGitqldT/oXEU7izm9/3Ii/uPW7e3zXp3ovrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvSG3XpyAjP0LVHb5cLb0mq0nabmjI4fK0dTfIFDw5Q=;
 b=QiVoRJRZ824udaewuro/WATuNCILakGTCDFwYg8/SfNxMqgys4mHXBAhwAc/WyJ4mgW0CyAyZZ0u0Rlrp6i/JmfVX1FdZ/BrLtHlIH6L1nPioLXW/MyL4NSugX5f11z7PxOu9e/1R2PFzg3Y4cUe3MmWTOicMUco/n8e7rZi/32GIHcTBROGTA6pTmTsFD218unKIJzZ32Ow+EBEPTNwZrJpJ0nL2bfFBocQvTeAXj3vpXKb/sa6RlccRGa7zdO6txuOXcfyXKS8WtqepafM5oDxMRKAO9JyXS2Z4rq24NoukT+WKOSg+CmVLt9JlqrjTxJxXkI551cvATGl3ODWZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=raritan.com; dmarc=pass action=none header.from=raritan.com;
 dkim=pass header.d=raritan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=grpleg.onmicrosoft.com; s=selector1-grpleg-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvSG3XpyAjP0LVHb5cLb0mq0nabmjI4fK0dTfIFDw5Q=;
 b=XWlSf6i87TJ1xRpXAjp2HbE1FPdZsDVqnToflbiYIF+iZCfRaXAZj0mZT0SOOwLUnBK6jhoN8+nz1TeAxJtZAgSMkFVmuDP0qI2dtLpO0jV9+4+oLaHJDjG5KOy+JgsDtmUcQoVPDNUS8L63+w2WvpXlH87thzLPEyL0Fri+tAU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=raritan.com;
Received: from DB8PR06MB6539.eurprd06.prod.outlook.com (2603:10a6:10:12f::23)
 by PR3PR06MB7097.eurprd06.prod.outlook.com (2603:10a6:102:8a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 13:31:07 +0000
Received: from DB8PR06MB6539.eurprd06.prod.outlook.com
 ([fe80::98dd:e9db:b7d8:9001]) by DB8PR06MB6539.eurprd06.prod.outlook.com
 ([fe80::98dd:e9db:b7d8:9001%3]) with mapi id 15.20.7068.028; Mon, 11 Dec 2023
 13:31:07 +0000
Message-ID: <06e77692-4942-4657-9694-725d6de3e883@raritan.com>
Date:   Mon, 11 Dec 2023 14:31:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] stacktrace: check whether task has a stack before saving
 it
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Ronald Wahl <rwahl@gmx.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <20231030175854.12675-1-rwahl@gmx.de>
 <CACRpkdZ2CXiNsnh_VxAy0OK+s_=cDqP8k0PVmNiL4QJ+mMZ+GQ@mail.gmail.com>
From:   Ronald Wahl <ronald.wahl@raritan.com>
In-Reply-To: <CACRpkdZ2CXiNsnh_VxAy0OK+s_=cDqP8k0PVmNiL4QJ+mMZ+GQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::8) To DB8PR06MB6539.eurprd06.prod.outlook.com
 (2603:10a6:10:12f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR06MB6539:EE_|PR3PR06MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: 3042a3d9-03f1-4608-5b64-08dbfa4d6e03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7VCEkznnyEgRMxz5IR5oaLlO5N31WxZj1UXDgRQLSfuuKZpXMOc6oyVIZhL8fSPrG9/xEfPqUFHek7HEkFJPJqLzDFzv/K2GQAzt+UUxdRsrQmePGcRmjr8mihHE7S18BbYAblXVSRB9ZtvEPLa7AOdUjAr78sldZy+pAHFfRVM02lAyiuaShtVpJPmEbbEKkZimLH5S8dnKbF+mIuqL1ibMu2dYXHAL2NmnKYKkkbvlpC3S/2dVIpBpMF8O+1lnjn08XGqNxLkWQwrH08lkORsFSEj14VyXeIujQxC+AvjSa4s0iv/NL0Tp5Ap/L3ac0GfWdP/T+cBuJh7ewAGHTC4a7UF1rpBQ+x4jJHo7+2W5vPxWkmLRZ/8+upEdLIMmXp4hlKcLPiU7HrGTkCtTYcIsqFnBOBhTISJAt6KNl490IQlsGDM/sA0GhleaJYxCP8Z5rCmMBkfigadMTcIwbbyTnF5MMwumpM60C1kxiguKA66Emn+fUbxEWA/O9l8b3Gf/JeW3b86uVetc5p+O8gFjnhl6lactmuDB7bihJNm9JCOIbPyYb36VPhJXW0KUV8xWKqRFuPp6xkvYIjrC4H/bHE1nzSxY1xVAPveMjGY62WN0R1+iBRGbyMYdiZZFthJFGFDPzKaQ6jczneH3RuHHb+Ss2iOKSJADMBYF6OVsumvbx59dcmPmEUOTEbNXcykieu+UWOG9CTLDgg1jqqA4lle4IazGdmbojJjW6s0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR06MB6539.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(396003)(366004)(230922051799003)(230373577357003)(230173577357003)(230273577357003)(230473577357003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(66574015)(26005)(2616005)(83380400001)(86362001)(31696002)(36756003)(38100700002)(44832011)(5660300002)(316002)(8676002)(8936002)(4326008)(2906002)(6666004)(6512007)(6506007)(53546011)(66476007)(66556008)(66946007)(110136005)(478600001)(6486002)(966005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkgyMjlpcmVhMUM5NDdmQkw1cHZYeHAzbzRLZk05V3hjOU9KTkFtbGdxWlRj?=
 =?utf-8?B?aWlSVlNnamFPVk9OWmdwbXVkNFZiYVpMTEU1S0phRUJXNlVtdlRDNTNMaUl1?=
 =?utf-8?B?MXNRanpBa2hPQnluU3ZBKzBjRm9JYU5lcmZBaGZsc1RucGg1VTZiWnN3OTZy?=
 =?utf-8?B?Z3h5QXJpb0ViL3VXaGtmdzViQmJtWEFCUXNrbjBZaGFnaC9JMmNLMjNRN1BO?=
 =?utf-8?B?clB3S1RqTi9YODdZczArQXFJWnF1OEFheGI3QjJTTEliQVRPU0hsL3RWeW14?=
 =?utf-8?B?cXVXcjJHTkVJQ2ZIOGxpaEZpZTdGZ1lMYUlYeU1vNzkxQnpHU2VqaDNTbDZO?=
 =?utf-8?B?QVZ5ejQyQ29TVW1rQ1pOTjlSRlVnL2x6QnVuN0VzMkUwdk80TWdDNmN5SmNz?=
 =?utf-8?B?WW01SDlraWtLNEVSM2UvcGMxK3hIU1Y0NEJ5cnhLWS80SXhSdEhxK0lMelEv?=
 =?utf-8?B?Q2p4cG51akR2d2pPV3BRYU5WWUlHd2taelh1WnU2VkhZa29nWkZxU05kZzRp?=
 =?utf-8?B?eGNUUXZlQlI0c21RVDVsZDAyRXdRRnp4UkRLODNaaFNscGt1T0lDaVJycUZq?=
 =?utf-8?B?OWpBQWJ1dW1YVU8yVXBGeHUvY09qSjZ1RVlaK3k3cm9iTjAyTmVEajVTd0N6?=
 =?utf-8?B?SW9zb2N4S1dlbGliWVU1cjdHeCtXcVk4d1oxRVdxTlM0WHE5STJtS1cyOE9T?=
 =?utf-8?B?cEdHNzVEWENybXF0aTFBN1Q1bjFJaVZ2ZDJadGRwNTNlRWlGZUN1Z3FtSGhQ?=
 =?utf-8?B?dHQwbmR1ditQWnJIRnlkczFNSy9xazRyYVRKL0Z1WGFqUktUcUxPWTRrdFFa?=
 =?utf-8?B?cDh0L09WdWFPV2lIa0RuVGMvU3A2cjFhdGFTTWI4c08yVnFtSnJvYWdQOEFv?=
 =?utf-8?B?eXRnWERFMnNqWHpPMlZsOTV0NnlrUUgydWMrclNqZ1VVTzl5U2hUbWd0eExN?=
 =?utf-8?B?TzRoL2tobnFZNjU4a09iZXNXazhrSXBKU3RmMlo4SFBkQlJScFhBemNYbFZ0?=
 =?utf-8?B?aStscjFLOEl5REl4UVdySG1ueWRIb0RjUjBKMnJBU002cTVFRmgvbDJSbXB4?=
 =?utf-8?B?andETmkzQWkxbXJLZ28rZWxrTU9RV3Q0NjlodzB6eFNkajlPbUpieEdoMTEx?=
 =?utf-8?B?V08rY1lyTGx0bDVQTUFJYStDOC9JanN5QWl3OGw4Q1krRUdRdHl2THVtT0Fh?=
 =?utf-8?B?TnY5eldQYnlNQlNpL0dib0trRVVUMHpGTUt3ODZvK3BUQ0srMisxdFE3NnFW?=
 =?utf-8?B?UzVMejN4SWVLUjA5dy94WkJ0WlRsZGhDaGN2S3gwVis1dkI4Zkp6b3dnLy9i?=
 =?utf-8?B?MGhHMGxDajN3eGNXQmQrbU04VUp0VmsvUkgxZWlLOEpFOHpaYjNWYUMzcmNr?=
 =?utf-8?B?aStvZjFCcGdTY3NnYWpoV245NmVPWWNuME45dlM4ZVpQY1RacnF5MHhINXhm?=
 =?utf-8?B?amQ1cjZLaTc1OEVXTHdNVFNuMGdwbXd1R1ZYQ1JEcUxRSHVSazJQL1QraVZ6?=
 =?utf-8?B?bmI2eU14UkJ5NXJGb1U1K3VaTllhSFNTdVk5SnFLRWdMaVdDYkV3NkJMM0FI?=
 =?utf-8?B?S1B0MEFoWWRRWEpjdHRyVFNFdURsQ0tydm9XL213Nzl6QUwvQXVjN09NUkNy?=
 =?utf-8?B?TUhGZktDRjU0N3hPN1IxV0VHM0kvV0krMWV2bWRqUGRWWlRJa1J0ZDhDd3Nn?=
 =?utf-8?B?UmltNUkwczl3cmNrUlJudUJScy9JblFidmlpSVlpR2duNC9raWVHQitHd241?=
 =?utf-8?B?Z0dlV1ExUkRMTjdwZXozNkNBSFBWdnJBS0NocE9WbVhmWjBRVlJFTVJBOUJT?=
 =?utf-8?B?dC9ETnExSnp4Nk12WlZMWkt3WlY0SzZFWUhiWW5TSWFMLzRLdXFtSzVPK3ky?=
 =?utf-8?B?Q1B2M2RQQW5SVTdBdyt5cmRNMm5mUmJ5TiswcDUzTDBueTVtYkhWaVA2NE1p?=
 =?utf-8?B?V2ZKRnZnMVBjSlpVY1JRU0xFVVQ4RWJyckI0NFVwYnlMK0szQ3gwaEUvQ1kz?=
 =?utf-8?B?QkcraVo2ZTF1OWpZUm9vaXNaU0M0dUVmM2t6RUNFL1RyeWVtWHM3bmVHZnJl?=
 =?utf-8?B?TS9VMHRqZ09BN3ZOc0tuQ3JXVndIY0FOSHhXWktTeUp0V0xvQ3V2T3dqVjI3?=
 =?utf-8?B?THBPdW9lYkkxdFJGZXZjUjBtdk1xS2R3Vyt6V3plS3M5REJIK3lRSmdQUDZZ?=
 =?utf-8?B?Tnc9PQ==?=
X-OriginatorOrg: raritan.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3042a3d9-03f1-4608-5b64-08dbfa4d6e03
X-MS-Exchange-CrossTenant-AuthSource: DB8PR06MB6539.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 13:31:07.1235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 199686b5-bef4-4960-8786-7a6b1888fee3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /rzybCKI60VG9cUjgOSoGXeanZJa3a3fAjUPHhH140K3HG0/zjOAfdJhZRHKSE+Lbdnc7qwHz6/jEJovcgwmiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR06MB7097
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.11.23 22:59, Linus Walleij wrote:
> [You don't often get email from linus.walleij@linaro.org. Learn why this =
is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Mon, Oct 30, 2023 at 6:59=E2=80=AFPM Ronald Wahl <rwahl@gmx.de> wrote:
>
>> I encountered a crash on ARM32 when trying to dump the stack of some
>> zombie process. This is caused by a missing check whether the task
>> actually has a valid stack. This commit adds this check.
>>
>> Commit 214d8ca6ee85 ("stacktrace: Provide common infrastructure")
>> introduced this check for platforms that define CONFIG_ARCH_STACKWALK
>> but ARM32 is not one of them.
>>
>> Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
>
> Looks correct to me:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Unfortunately it causes a memory leak because I forgot to call
put_task_stack(task) now. Should I post v2 or a separate patch?

- ron


________________________________

Ce message, ainsi que tous les fichiers joints =C3=A0 ce message, peuvent c=
ontenir des informations sensibles et/ ou confidentielles ne devant pas =C3=
=AAtre divulgu=C3=A9es. Si vous n'=C3=AAtes pas le destinataire de ce messa=
ge (ou que vous recevez ce message par erreur), nous vous remercions de le =
notifier imm=C3=A9diatement =C3=A0 son exp=C3=A9diteur, et de d=C3=A9truire=
 ce message. Toute copie, divulgation, modification, utilisation ou diffusi=
on, non autoris=C3=A9e, directe ou indirecte, de tout ou partie de ce messa=
ge, est strictement interdite.


This e-mail, and any document attached hereby, may contain confidential and=
/or privileged information. If you are not the intended recipient (or have =
received this e-mail in error) please notify the sender immediately and des=
troy this e-mail. Any unauthorized, direct or indirect, copying, disclosure=
, distribution or other use of the material or parts thereof is strictly fo=
rbidden.
