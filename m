Return-Path: <linux-kernel+bounces-3970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC374817628
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 455A7B2436A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAF142377;
	Mon, 18 Dec 2023 15:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SOPcniNt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD7C74E1B;
	Mon, 18 Dec 2023 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnvaxIGr91pmh7XsRw9JzC6YmRkJPcOQ3BTerQT4/0ptt7fJtyxd4oCiweCZMw2XgwkX1ihsmExfoynYwXmTIVJI6sf4Kago8A/9TZavMx7/jkE9UxsTfQu1QAOppNzW8CR3Eeytu2w6OOkc3c9dQ4azNHglJQp9XiYmsX9pY5vAADe32U6S/hdPqjHnZN4HSc4vugA3peTI6ADz/QhKHne9jkusnCoFb336+uBbiO1TMLM60qE/vgtn5vXvwwzVC+sxJJ9T6yC2kjjaSp5Ul3+dxedFmEzAn9PrCtE5OcmrkWwfX8Jfe0yV5f/hIyg86bFWpaAYBRrXww4rhfBUNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnoKg0KIAiX9IPjucSSUkQHePf2miY4ZA+PDZf+aDEM=;
 b=MZdOzGt2xivu2P5LJmLYRaobvSMgKYEAL+F54s/dzEZywZ2dhSVSuczgUF2KHU+aJ5sHHT1rsjra9U/PQQn/6PPeYG6Oh181+KeLxConEOPYy+JFSd5Zs+fPklCOQw2euU/ebGsaD8iXW+eY9HdQAnHVQKoZh7y+guzMI56qtWBgu1bIsttaWIfaOwEhgEjPSdQqRJgUVl29up4SbOkC9dDDw83IhtmeZnuhAIOX0Rzz9d79FAlx/CVenD5Ek473CzXQGaKM/Qutb/VIZEd9UYs8pKfSDQYoK8or3h6JGtI1jBvZ+ZUKgJv8AkmOJyjQd5wsFLB1wIiFaU6KWEmEbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnoKg0KIAiX9IPjucSSUkQHePf2miY4ZA+PDZf+aDEM=;
 b=SOPcniNt4ovy2YRfUQbO6DXqqFImfSaKQmjwblw+Mhefb9n3DfIUz9zVufXIQev2BJbAghcmXQwk9nqjEdCtsbNXFdIwatFsa+YWlXemXwFU/HSnGL+B80GUEoy+wyDov0UBd2+YJevM5ENpafvcBDY8qU06XXKg08mWSTvdnq4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by PH7PR12MB7377.namprd12.prod.outlook.com (2603:10b6:510:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Mon, 18 Dec
 2023 15:42:29 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::6452:1eb:50fa:311d]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::6452:1eb:50fa:311d%4]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 15:42:29 +0000
Message-ID: <3c72323d-b3e1-46a9-a462-c1986667cf7a@amd.com>
Date: Mon, 18 Dec 2023 09:42:27 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Spanish translations and corrections
To: Jonathan Corbet <corbet@lwn.net>, Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, avadnaik@amd.com
References: <20231211023730.2026204-1-avadhut.naik@amd.com>
 <87il4zqwvv.fsf@meer.lwn.net>
Content-Language: en-US
From: Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <87il4zqwvv.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0036.namprd08.prod.outlook.com
 (2603:10b6:805:66::49) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|PH7PR12MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 99af7567-0419-4402-774f-08dbffdff12d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uIzjWJmhzh4PLDeIeoYJ3m7UCj7QrEj7eczLwk0EtQ/m+/tGX/7DWSfhpYd3xEZ8puo9zQnXbLihlJG+Gj91b8oR45IYWzTWlmhDfowuF1RBfWwMvPNrDOK5pCkt4ZiXUZlzplNKVMTwh0ngU8Bl0yI/VwG9camn2SZYIRPZ4PG+Egx2VwUWhK8yoOFi4nsPkfDwihB1SGWyXBzsoJQ0xuT2J616Zw4B13Bjw1Xb4HmMZxkn1wJv9UrmpTKswmjcRGPKUPjHJekeRstVJqZZKPCxaXbF1BJnJM/lHfvoeK+ekF0yH512bkNqV5ChqnWP8b7Mp/6Myb3rtnZj2gwCtjrn+/h6G/K5m8mFmLaqswcpm9VBXxFE3qSbN5/CPBsugmozNdLFXT1rB9xRp64rBULI3avDW0qBD9+HAci+ryfqu1Xl14Ww2cs4cw3+ftkozhRPcaeJK+k+WFzAFxDztVHIoSrEvIgz9lIlois20XW3Nw0jg3My5s45oYi0X7JM1QFTyaT/qBtnAlwlOvh4YH6jUgUTKFrVfUCq2cfo48ic7U3vg7eRt2AeKphgdN5o+/+Jke9q+8PZJbdgyF/aAUTKMZOiJ1wVP56XJK3W9p3f7djoq62JPTVon+SWMsMwSph9iAoglxFg24CwwEl79w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(136003)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(2616005)(6512007)(6506007)(53546011)(26005)(6486002)(38100700002)(86362001)(31696002)(36756003)(44832011)(8936002)(8676002)(4326008)(110136005)(478600001)(2906002)(5660300002)(41300700001)(66556008)(66946007)(66476007)(6636002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejFGSk5mMTdER1Q3YkxZbWRnWlZEL0NoNU9OeE8rTUU0MWUxMC9FSXNrcDAy?=
 =?utf-8?B?Q0pCcytyRUFLNkI5WWluNUFwR293RlloQUNoOE9wVDJVb3JOUDJPS2ttdjgx?=
 =?utf-8?B?N3plbUNESjkrNVREd0lPKzVEUktlaXpsaGErWEdlN2JyZ3k4Ymh6VHRUalJv?=
 =?utf-8?B?aFBLQVhoNmxTYitmTVRJNXlEWC8yMUV6RkhSMzFSLzdtdFBHRFllQjNseWNw?=
 =?utf-8?B?dS9FVkZjbTJQdXpDNU5uTGxITzRuUWJwOTNMVFZRNUhRa1haQjhuOFlFZ0VW?=
 =?utf-8?B?M0lQdjVqSy9ZZHRxREtXNmZNMDZuMmhiMHBoRUo5RmRKUHdMalQyTlcvMW9J?=
 =?utf-8?B?dTFMZmRuM0tmaDBMVCtOeDg2NjFtZVhoZlVRVlR5dHlJbVg0UW1YZWptNGxy?=
 =?utf-8?B?QTVzOCtHMU1OSURZZkx2RHpWbFJzU1l3U0ltTzkxY3htbXRIbnJsZFJHMFNF?=
 =?utf-8?B?K0dpY2tJWmFjcmorZzlwdVFUeml2bFRRdFZ2QVUwandrVTJNY1dScW5kdDVH?=
 =?utf-8?B?WTRaSkU3U0JzSEJJNjYyaVZLeGpqeG0xcGt1YUFtaUxJcmx4QVVpbFZDdUpn?=
 =?utf-8?B?RFZwTVN2c2laeFJWV2NaN0RHUC8waS9GbFRTd2lJeW5PV2RHWWdqMTRjSEtX?=
 =?utf-8?B?dkxYenhIK2U3NWlBeXRSY211eHgycEw4dGtBZHFHQVFzRG0rTlBCVmxia2tR?=
 =?utf-8?B?bWp2SzN0SWRmRDBYNTQyMFR3VnFhK09QWjVZNTZtTk9uSmJNbldSSmxTQjE1?=
 =?utf-8?B?Q2lMRDFoY0I2R2lBSnhoVzd5ME8wbGtQYjg4elFmT2c4OVVaR2UyV0hmc3lB?=
 =?utf-8?B?NklIOHhheUpEZGIrTDhjU2JrNkhITEx0Tm1adEZtWFUzU09pUUl0TGMzRGp3?=
 =?utf-8?B?WEpRZEhCNnlCZlFscXBtdW9BR2N2YVBQM1dMbXpCN3N6aHJnZWM2TExsaWk1?=
 =?utf-8?B?ditLK1BXSzg1RTNXS2VxRzE1MlAvWEpvd0FCamFHUXNwZGxIM0xuckpjbHN5?=
 =?utf-8?B?QXpIZnVXRXluRmZpWGhhYWhpMTJBRElEY1Y1WnFCZVZQTThGNGRBNHNzNktV?=
 =?utf-8?B?Wi8wNi9HQ1VFMHJQKzUwbWY1UENIR1FHS1VyMnhBeDFEMlFScU1HVkY5NCtS?=
 =?utf-8?B?VWl5RUkrQ0hjYlU5Vlg0OEhVSGw4dlpXbGlOOFh4Uzd0TUNZTlpLb3IraVBP?=
 =?utf-8?B?eHh0cFdaOW1sMVNPZXlqTHBNVUtBVURJa1E5V0RHWDdzS2s1aU1IZ3V2aVAy?=
 =?utf-8?B?SlgyUXRKRWlhQXVXMUpCSXFwcUppN0UwS1hydEFEQUVkQTh0TE12RFF1eGNw?=
 =?utf-8?B?NzdSNmd0UUtLNmFXZFJ1RCtTVHQ4S0lIMEZTdjA3K0UzUFRjcjFKZlYxbElo?=
 =?utf-8?B?S21FcStwUkMvR2FUcG1Fd0VvaEcybXB6NG1rMmVzaEthVjUrVDRLQVpvQnN1?=
 =?utf-8?B?VjRYZTR0WWg0MUZxaXlrcGgxZGRwL29zdW5OU1k5UkpvVFBYK3dvY0ovcWFF?=
 =?utf-8?B?djlPRitxMkhhbGRjSDVPeEx0Sk1kazhHM2tFNHRJdUdvbDNxTjhTdkJscnFW?=
 =?utf-8?B?WjRCVVZpZHpTYStrR0ZIY0s3eWJaamcyYjdrR0x6R0tOdnNmR25vSlF1Ynd5?=
 =?utf-8?B?V3ZiRmFJeTVrMm91d0JnNTUyWWtGNDkzSVpjaXhuWHZqNU9JUXNJcXdKUHhB?=
 =?utf-8?B?OGx3Tk5RU1NkTFMzaUFiVjV1bEFrNExPam5uY3hkY3NqSzNaU1ZTZXlJWHVo?=
 =?utf-8?B?YllGT1J1RDlWL1RueFkwNnF3ZjFNU3puRk5iY1ZIZWZWMUM3U0F0VlIyWXNh?=
 =?utf-8?B?ZVNnRGdlMkNNaHFnaHh4c0VoZDRUMmFnMnR4Nit4WnU2QTV0Qm5xWGNWdERs?=
 =?utf-8?B?UHdpckVjRkN5cFlFMStwTTJqUXBHeFNkOEVsRXZkaVQzdzNMU3o5Q0lLeFFC?=
 =?utf-8?B?aFdtVHE1TzdCNEVURU40MFJSZkJmbVgrdUJ2SnM0bWNYZks4SCtVb1B2S0F5?=
 =?utf-8?B?bU4rYkNXTE90VGxhaTRHZ1cwVjRoWi9UT2FhOExHYWxtaHZncFFJWnluM3dB?=
 =?utf-8?B?MEgrU3BTazdKb2xTaU1XT05OQTR5ZzRLQXNZYVN3a3FnMlUrVEhsVkxOVWJI?=
 =?utf-8?Q?b1XXFQUoHQ6mMXH2c3+aL+xy1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99af7567-0419-4402-774f-08dbffdff12d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 15:42:29.3828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AAVwPNyR6zO5CMWK2aD/UPoUkqR/B8PxctygUW3DFcw6Glr6x2fG8jOaVCOwHZeW3NYzq+Pr1fDdP4Aw5frnSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7377

On 12/15/23 10:00, Jonathan Corbet wrote:
> Avadhut Naik <avadhut.naik@amd.com> writes:
> 
>> This patchset translates two documents into Spanish and also warns of or
>> fixes existing inconsistencies.
>>
>> The first patch translates process/management-style into Spanish.
>>
>> The second patch translates process/submit-checklist into Spanish
>>
>> The third patch warns of some links in Spanish translation pointing to
>> English documentation.
>>
>> The fourth patch moves howto.rst file into the process directory for
>> Spanish translation per the original English documentation.
> 
> I've applied the series, thanks.  One little nit:
> 
>> Reviewed-By: Carlos Bilbao <carlos.bilbao@amd.com>
> 
> While there are 400 instances of Reviewed-By (capital "B") in the commit
> history, they are rather overshadowed by the over 250,000 instances of
> "Reviewed-by" (lower-case "b").  I think it's best to stick with the
> crowd here, so I changed those tags.

Jon, Avadhut has helped me so much this last year. I would like to ask you
to review the patch below so we can include him as reviewer of the
Spanish translations of documentation. Sending separately too.

> 
> Thanks,
> 
> jon

Thanks,
Carlos
---

Subject: [PATCH] MAINTAINERS: add reviewer for Spanish translations

Add Avadhut Naik as reviewer of the Spanish translations of the
documentation.

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
  MAINTAINERS | 1 +
  1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6024d1d5ebf8..0506d14340f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20360,6 +20360,7 @@ F:	drivers/media/dvb-frontends/sp2*

  SPANISH DOCUMENTATION
  M:	Carlos Bilbao <carlos.bilbao@amd.com>
+R:	Avadhut Naik <avadhut.naik@amd.com>
  S:	Maintained
  F:	Documentation/translations/sp_SP/

-- 
2.34.1

