Return-Path: <linux-kernel+bounces-5502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4668818B6C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A977286E9A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812241D54C;
	Tue, 19 Dec 2023 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Tz1dZQn2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2069.outbound.protection.outlook.com [40.107.21.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616421D13C;
	Tue, 19 Dec 2023 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhHOXNC0JYz056zBYZkyQPtlhyePRKqZ31D0QDFc7htmiZ6IDQrIkrWOeUGC76s65sMkI8ijUL8gyhBzkmRyb+VcYpMFijBGe99SGXPshOh4GzaFFYSLGDGVCpqpmZICyjNp3fCjismtba9W32ih0I+o+hdPBPAXJThZgCAytJkuAH10VxpYw2sYwpRQY5ZLXuBV7nrk7ImdFU6KHo19rBwsqLZ3X1RMVYVg2RFB9KVq+wtL4ZCbIS2x8Tv+JTAmPYYMBsQEe/aiavEc4st56l8OJ9SaXiQNpriWWpD1yxJl0uUzl1ONoTAvpWKsMF1rnnfll4Smd7NYaAaruM26xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0+V9tL2eMzQrPbnFHFwfGh/NwrGLN2XW/UrPjEaqmM=;
 b=XdvdmHn7+IJ/mjsJW6jIPHp6jn6zeJhQrwfI+88ImPRrJIOkcsXPR1NkLu4fm1d2fBqxqsqHL7dgTuGCobVZ//Q3NgVt70pJwKIg3O2UzGoFvUHhUE0lEJVk0UykXrgcPHlyjgeBifo6Kb3xicpwwByy8lYPZYhmA6T5qm7FH77xGKv1wbMBHaP2GuEZZZie9msW1X0czzZyB9EeFSd31kye1FQxwt4QJT2dJNbJykvgF7klTWSeadmEPhD2g51uoArLwJ1/kG+P2CHtFdJLsOyQ/9pO1rOIy/yIoB89SDyBMmhwRbTDnXtLaN2AB7Tiyl7qE86NEzy2LAcn7RjdCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0+V9tL2eMzQrPbnFHFwfGh/NwrGLN2XW/UrPjEaqmM=;
 b=Tz1dZQn24/E7wSmYA1Hk+5U3cTwynUnpA+sxL5pNPRmnWmHoRhVUZ5cRe8uascnjelOHXpoxrtzLhr5aozEX4A33JabWgOGU6Ap980w8NbbvfvRfWxqHilZpNjxofquDizjhHbbc5ja/RqNCr1BJ1KttcJnYV+gOixBMZRQj5A/pcTGGkozxVQzMW1U7iympYczawtIt4vf3W0F62+NiE5LNHSir8EezqnbN1jtqHkBRru7h+GWtN6Hrvn/Ubgg44n7SzrryAJdS+OlrfmoDxSMTy6KP3mLa8Ks7pr0rP7KZf8MT/9ujbXThYFV4yM5Fk8VsN+FXH4OOtR/w+I+mLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5845.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:510::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Tue, 19 Dec
 2023 15:40:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 15:40:51 +0000
Message-ID: <29c030e1-c493-4521-b5e8-db3f484eefb8@siemens.com>
Date: Tue, 19 Dec 2023 16:40:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] dts: iot2050: Support IOT2050-SM variant
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bao Cheng Su <baocheng.su@siemens.com>,
 Chao Zeng <chao.zeng@siemens.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Li Hua Qian <huaqian.li@siemens.com>
References: <cover.1702917360.git.jan.kiszka@siemens.com>
 <11e0b0c8b828254567a8ff89820c067cacad2150.1702917360.git.jan.kiszka@siemens.com>
 <8b3daa3c-dbf8-4286-b04e-011cd9b0efa5@linaro.org>
 <4c31adc5-3fc5-47bc-9766-6d3d1eeddb65@siemens.com>
 <fbb29d81-9ea0-4468-ad47-f6668c2be277@linaro.org>
 <de3f4778-51d6-48ab-9d4d-451f2ba01a3c@siemens.com>
 <3d2662be-3a55-4390-bd2a-cfa5cc53510f@linaro.org>
 <ef5a6cf0-4350-483d-a1e9-ce8b0ef71280@siemens.com>
 <ce6b002b-f2a6-4056-bf81-53a6c948b946@linaro.org>
 <62be89bb-1ae1-4bf6-9f9e-b6eb68e6504d@siemens.com>
 <f6241b58-202e-4624-ae83-ce52fc286edf@linaro.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <f6241b58-202e-4624-ae83-ce52fc286edf@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0207.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5845:EE_
X-MS-Office365-Filtering-Correlation-Id: 41bb5639-fe15-410d-2308-08dc00a8e13e
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qo1/4HL3FgJr7JKx+uOJMa7zJiAYf6AiBE6ANEbTWdFFlrLC9vVXA4kzi+QoMkKdn4Jb5E08qx4KEz2ximfozwNvPbYn7FN7aAAjkxRmr4QjK5T2fM5KI5EW/Gh0g1FlDpK65jui4zMweTuAS1pxPMLfwKc7HvQb4l8ZbiRUjaEj6L3+T+b7qwAoreiEK8PeAJXmdJyHa2VeAVTguQ1rKeAjepiPtgF+dbU4n80+S66FDJGLYnItH4JBNtOaj6bYAlkTuZ1PRggaic6nIipk6mMnIFx9y7SwnvgJWWdoVGcRmkXecV8hg4/7YCr5nMgb37d+2MevFzAPjO77IEvV1dlSVOGAME9wyD9AFwpZ4blMM1w1pLlQpkgCWliG6k6CcabIOUY3xbJMP0RWoXAIB+STx5qFukIb3LQtqKNcRp+bJuouFBBeOAo+iXpRg9YqHovMilwwHdsTjs+jkUdPu7gPGSThnGVY7qxYKeuhnZmrg3h+xuqZHUKGoT0twT18YI6AOgH9YgcohwvdJfljuXob+DBKk0JykaxeiwBumqJ2AT047WR+cUjjpxxr3XxHjtQafyNlEhgp5iOndCnpcg0wZf3D5VC6V9E/b+/jNmVOXsyR0a9kvSVxbfWt2/CoSq+eJtFqghFTeV4hQiYIPA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(366004)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(6512007)(26005)(2616005)(107886003)(6506007)(53546011)(6666004)(83380400001)(2906002)(7416002)(478600001)(5660300002)(4326008)(8676002)(110136005)(41300700001)(8936002)(44832011)(6486002)(6636002)(316002)(66476007)(66556008)(66946007)(82960400001)(38100700002)(31696002)(86362001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjVKQkQ2alU1YTdSSWxQMjVyS0RyL1h5ejZKSHkrZFZkUkdKTHRqVmxKQjVp?=
 =?utf-8?B?K3RURFZpVmRiblVadnpyRFFPa2w0dncyTUM4YW9UbW9ZcTkwa0U0K0Z6Q3FV?=
 =?utf-8?B?R0t3WkF6d3NvV3QwWFloUEYyWDJ6VVpYY1NvbVhqRVRXZE1OTW1tSVJhMXU2?=
 =?utf-8?B?UEVkVzZyRElMcThGTUJ5emxOSUViTExWVlozcEF4SkxBdG1pRW5TUUN6N2pU?=
 =?utf-8?B?R1lLRWwxejdLWkhhT3ZabFlQc0FPZ2xHMTZXRDhZL3RjVjZ6OUNXZmhMUit6?=
 =?utf-8?B?Ymw3V0Q4VlduRFgvRmNGR0VORkVOcFk1aUhnK0liZlNVRXJNWEF6SkhDdXRj?=
 =?utf-8?B?M0ZSbjBsL3hUZGQzNkplWHQvTUkxcS9ZdnovU1I5c1BsbmhyckhzZC9LZ1NK?=
 =?utf-8?B?WVIycThuRExPNkxrTjNkRGxkN0lUcVV6cXd0eTlGZVpzTjdwdjQzdmVlT1dM?=
 =?utf-8?B?eld2cFBRdjJEK2Z6WUJuMmcwd2xlcHNoTFV6cDBpZHh4UGVCZEhCcFJ0d0Vj?=
 =?utf-8?B?blp1UGhuTWs1bk8xZXlDeHhESXVrZXFYcEZIOVIweDNBTlVxTCtZMytTMTB3?=
 =?utf-8?B?L1kvZktiMnJwaU1lUWZoWUZtMUlLcllDQnVBNDVFbGp5dVFxVC9tVzZpZDFs?=
 =?utf-8?B?UmlHWGVyMXFOZFdjbCtPTGFhZmZhc0FXUDl2dW1jaGEvZXlkaHk3ZmhyYU5s?=
 =?utf-8?B?cmdtSUF2MkRmMmhycUN4SlpkOHZLOVZaTnU0cnBWWWs3aHlyeDhmdXdmWjFG?=
 =?utf-8?B?cXdwSGRpUlFrdDF4TzhBMUhMWjhqVVBxQXI1ejhmbHluVTlxZXhmbVhmTGsr?=
 =?utf-8?B?Q09hNmVLRDVmbE8yRzU4bG14djdMYlYyVlNrR1Iyczdta2VYTXJneFRmaU5m?=
 =?utf-8?B?dkZDenp2WjZzQ2JyY25UTXR4RGptMC96K3cxNTBSOCthSzdOMnhORWNGUjBV?=
 =?utf-8?B?cUJ0QVUxNzQzOXZOKytCbndOOTJHbXFTSmNjU2QydWJENGJ3aGpvWFhVcFl5?=
 =?utf-8?B?UklhLzVkblF6QXhhY0tOL2J2NVdxb3N3MFJvM2lHUW1iQnNsN0F5TTIycFVH?=
 =?utf-8?B?VVhkYTJHT1c2ZWtWT2dqNU5pMmI2cjBDWFYzMEd1ak4vOTEzSWxBV2ROTFBL?=
 =?utf-8?B?NVlaeE81Z0QyZU13bHBJRzJUcm1oQVdDenhKdUZ5RjQxVkJNSzFKc1ZQVzVB?=
 =?utf-8?B?SFY1N1JVQUt0QUd6aUp1YlFDYTRSRmYxbDlCZVp6aENrc0JEaDdabVZXNHRP?=
 =?utf-8?B?aVR2Q0FpSHJ1djFXSitZSkljY1Q4TDdDdks0bHZ1MThjRXpvVTZ5bVJKcFky?=
 =?utf-8?B?OW92MFVhOVhHZ1pPRG91Z29sbjdDNVJ1VU9kVEw3VDFETW0xWE9nSEFCVUJC?=
 =?utf-8?B?Vk5XOWlQclRkY3VoU1ZUbEZmWUE5Mks0OXdUQ3E0bDdMUXpQYjRSTzRkdU9Q?=
 =?utf-8?B?UTNuQldSd3BKajl6T3pneEppVkcvaGZWMlErbStrOWtjdm54UTl5U3RoamJn?=
 =?utf-8?B?blp1d1U5YnkyNkxQMVZ6NS9SL0tWZmtCSFdicmpuZmlSeWVjWlFRdStDODVQ?=
 =?utf-8?B?OWV3VHh4RjFtSTg1TFF2UG1yaGZQUUUrUDlGVVYraUNjUWFzaGFMc0t0LzRq?=
 =?utf-8?B?cUxhQXpkQWNWK3UzNVV3NDBUWnpnclVPSit1MitjNm1MMlAyWTBNTEFiNVhJ?=
 =?utf-8?B?UFNRd2NMQ0JQalVIRXlzOTZ2NmM0OXFINnNpdXFjczV2b0xxVkE1VjBHaTI3?=
 =?utf-8?B?TXdudlVJaU8rcGo0dFpOMlVxV2s4UStIQmFhUVo0T1FsUFJIakQxcDNZNUFL?=
 =?utf-8?B?NWp0OWhEdzlhRmo4ajYxUjd0ajhlRzZCZHU0a0N6ZEFEeGpjYTByNHY1NXpV?=
 =?utf-8?B?Q2xIQ0RBZk5RUldKcXZrSEdRcHZqSk0xWVBNSWVGaTVBL1FrR2liMkc0a1pF?=
 =?utf-8?B?ZE1la09iallxRzlwaUg4ZU5SU3pSQTljTFo0cDZUUzZMa2hncFJBenVhK2tZ?=
 =?utf-8?B?RDFkdVcyQmxEd1FaS0xNSFk5RU5QNXBneEdXWUxiQ1liQkovc2NhVFBtb0M2?=
 =?utf-8?B?UjBSazFWZFF6bk9KQVBGa0tYWmlVakl1T1cxR2JMZEpmZHlZamlJYTZoZW9i?=
 =?utf-8?B?YlpDUUxrYTh0bTZ3RE16OFB1RklseUltOUhpZ3N2ZjAzS3lTTElRb2M5cFNu?=
 =?utf-8?B?d0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41bb5639-fe15-410d-2308-08dc00a8e13e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 15:40:51.4280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qbHQdDXQcGgWbMgmE1zCJ6lr42K/Bre/HYGA45HssEMwwuSkxH96d1kpz+Ke7Hb5mQ0T2uOiqtZ0Kg+BV89Wdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5845

On 19.12.23 16:39, Krzysztof Kozlowski wrote:
> On 19/12/2023 16:37, Jan Kiszka wrote:
>>>>>
>>>>> You have label for that... Somehow all these nodes are half-baked,
>>>>> without all the expected properties and now you call node name as ABI.
>>>>> The node name is not the ABI.
>>>>
>>>> Well, existing userspace uses those names, and adding the properties
>>>> would break that interface. Now, does Linux do that?
>>>
>>> I don't think you understood the concept. There is no change for
>>> userspace. Same interface, same names. No ABI break.
>>
>> I do understand the impact very well:
>> open("/sys/class/leds/user-led1-red") has to work for all the variants,
>> consistently and backward-compatible for userspace.
> 
> And it will. The name is the same.

Nope, it's not - I tried that already :)

root@iot2050-debian:~# ls -l /sys/class/leds/
total 0
lrwxrwxrwx 1 root root 0 Dec 19 09:49 green:indicator -> ../../devices/platform/leds/leds/green:indicator
lrwxrwxrwx 1 root root 0 Dec 19 09:49 green:status -> ../../devices/platform/leds/leds/green:status
lrwxrwxrwx 1 root root 0 Dec 19 09:49 mmc0:: -> ../../devices/platform/bus@100000/4fa0000.mmc/leds/mmc0::
lrwxrwxrwx 1 root root 0 Dec 19 09:49 mmc1:: -> ../../devices/platform/bus@100000/4f80000.mmc/leds/mmc1::
lrwxrwxrwx 1 root root 0 Dec 19 09:49 red:indicator -> ../../devices/platform/leds/leds/red:indicator
lrwxrwxrwx 1 root root 0 Dec 19 09:49 red:indicator_1 -> ../../devices/platform/leds/leds/red:indicator_1
lrwxrwxrwx 1 root root 0 Dec 19 09:49 red:indicator_2 -> ../../devices/platform/leds/leds/red:indicator_2
lrwxrwxrwx 1 root root 0 Dec 19 09:49 red:status -> ../../devices/platform/leds/leds/red:status

Jan

-- 
Siemens AG, Technology
Linux Expert Center


