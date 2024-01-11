Return-Path: <linux-kernel+bounces-23772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BA682B179
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF3F61C2348B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7494CB3C;
	Thu, 11 Jan 2024 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HyyVl4/V"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2122.outbound.protection.outlook.com [40.107.21.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0034A987;
	Thu, 11 Jan 2024 15:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmOkfFf1tRiFqPwMtWPkepzPe/s3CcLmZTf1LzwhBTeA+pQuW8gYfBXq9MhSg8ix2eQ/ubTK+W5+tpEjAZ/TISn3ZfpCuN1dcOUn74MiV0wFxjK/RHO3URxSnOvB5BczMCLP35NvsdoFdcrfKNc4fqId+c5NdpZTLC/Boz+blhxX/fzL3aiJECAe8s3P7Bx+ppjp2Kqr+WcAsd/65+okw/rr+Sie6hfIqBSfw80drDMjLw3ysjld1WxIg21Ozkf/H+cRvwGvMErSdUJbPHBCTRQunBanFbsJ1+EcWW5KbAoh8eIkQBRXfF351JdsHT2L4KSRbIARpPe0cuOzdTkYvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plgIvsh5g+kwUbztWcyWbfOFT81SoYManphKDk2tlNc=;
 b=PRdP3O60AL19SkIj3eC6pwnMTwrPCRiIK/jlqmdgH6woLG0dq9U6xJOU125+gSGpErPPHyyJAx76wkLjoLSwusHLnBKKhkUox1/eLBtt6aNmeaoS1kGyV2XC/Zvx/SeMqTrKgXjIIPjKDbg4YRRk6GrG0DZ8tESYIFFe173QMN4AufvR+scwFxn0STJe5shIVcqt/EzDDabe/6/ChtOzaM1qTGCUUxXTMrUD/k4QZoDmoUyiLanJOKA+kNM431ZZ1fkLBxAoQGyUzq2bljODTnr7WA/zOiCX1Mw6T2SmwNcTRzln4lSWe/UIMPVq9VK7gQqnXuMNo8m4KrqiSbMnjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plgIvsh5g+kwUbztWcyWbfOFT81SoYManphKDk2tlNc=;
 b=HyyVl4/VpYK2Xh4zqBji800X8wjbs0DIz/RSWkwD9OPQs88UJFoQXAnvK4YAL1T53GWvY+Ph1JD2oNhUiUVFAnxE9TaslujGKHH+dMy3JudfvRBtmLcXmnBumiiBjpw78s2QYoT1+gbaT1rJiek670tLBk76e+iCMqkr5GVeM9IF26sZdNBYNxSl5vWqr8Q+XWToxyl1CWzr4gWacPvRExZzUI7ODRD6b3oNZ56mtn+i6MPSjBE9POnYGoBDYtuulYaL1DWpNEImITlsqrrybHKUb30oa4Dfl/56WtQNsphTavju14gS6SUkRRYUSOVvZddc2zDvEPcQDraH8ajw8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by PR3PR08MB5563.eurprd08.prod.outlook.com (2603:10a6:102:89::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 15:11:01 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::72c4:98fc:4d1b:b9ba]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::72c4:98fc:4d1b:b9ba%5]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 15:11:01 +0000
Message-ID: <6297c6ab-7639-4567-962c-3fc2ffa81891@virtuozzo.com>
Date: Thu, 11 Jan 2024 23:10:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] netfilter: propagate net to
 nf_bridge_get_physindev
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@openvz.org,
 coreteam@netfilter.org
References: <20240110110451.5473-4-ptikhomirov@virtuozzo.com>
 <20240110141457.17205-1-ptikhomirov@virtuozzo.com>
 <6122c87eb7e605c2b8de1cd377ad2a751dd757c0.camel@redhat.com>
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
In-Reply-To: <6122c87eb7e605c2b8de1cd377ad2a751dd757c0.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:194::9) To DU0PR08MB9003.eurprd08.prod.outlook.com
 (2603:10a6:10:471::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9003:EE_|PR3PR08MB5563:EE_
X-MS-Office365-Filtering-Correlation-Id: 64b84ad0-fc5b-4f6a-88c9-08dc12b785f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	v4Nn/AXx59s2SBWguUuh6dbwT9cJEPiE87iiqoItNgiluMtW+jugyIZF5QThuwluw4k7klQmxF6n7Vz5UzNPMm4hmx0G2xkFD5m1tg/iLM741PfC0+H+Dy/HV6S9XECjziedetF6cQY6do3S65c6ryvUu6G6+UE/4iWxKCJKgMphD7Qn7ZQMtBgjSSuyJ+KMjLmO/dl77DJ7RXz9L0nS0k2ks3n6XquGunICA94QmccFtp81wCJZTWpBzyUAIUEJoPr8tUHKQNdxgFvlyMNvIuA7Y4u/6Gt5o9xIsPzJgwbz75KCwPBqtxDCs/FaY9WPs93P6fOqJyncOnO9Zsq5B3la+5ri7E0WOdat026wmQ3vmX1xUV0AVV+xtjANmb53ekzWSTkPWldiwxOeUt6x4A2z0frlpF3hhhwIMQ2KEZYp8qxwf4wwQGBH2FGzWm2i80z9v55HGG9LxcWkOkO35kxaGwjtafMcoJ08udtlmwWKlkwPBcxsfU8Kph7ZBAlIOYxi5Kh+ab9e9VwVuQdTvbNMDRa8845N7P/0ZnnKCjltp8yy9vtLJ6o24PWh7Qhs8O7QADGxlXQIHVliqIfPxYJng8To1JxeA6FNH1nFI7ATaEKGYDcV2ejl6DFJDay/wRomb8PM1+pNmufeRRrfXA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(366004)(39850400004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(6486002)(31696002)(478600001)(86362001)(66946007)(53546011)(31686004)(6666004)(2616005)(66556008)(66476007)(6506007)(6512007)(316002)(38100700002)(110136005)(4326008)(2906002)(36756003)(8676002)(8936002)(4744005)(5660300002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2FXQTMzTkpKcFU1TFR0a0hoQWIxY2UySVdXcnJCY1FEZkZhbm5LOTEvR0Zl?=
 =?utf-8?B?YllIckRucGxaekFXTjZKQ25jRE9PK2Q2ZkhXdFlvMzVWNmNLamNPcUYxU0Jv?=
 =?utf-8?B?SS80eVdtZnQxK3A2aXhpWThBTStzVzVYOVJ6TkU2MVZ3dmdHbnYxZUYxNkJE?=
 =?utf-8?B?dkpPWmhSUUllV3RwVzlTT0hGWG5rZm1SYlJPRG13WjUyTlV3Z2FFVjlDOUU4?=
 =?utf-8?B?OFBubFJ6TFVuTEpQbzVxd09RdmZ4NGcrUlZvTlVEUzVybkp1QmQwT2RhYjRE?=
 =?utf-8?B?U05Ka09uT2U4VllFQkdrYTRSWDZsSEhmdkREQ1Y1RlJ3YnpDZ29ERUwzVWFa?=
 =?utf-8?B?K0pPd0IwOUh2akxmeU9VSlUrazBkR3Y5U3BOMlJvYWRvR3BGaXFLTmp5blVm?=
 =?utf-8?B?dVVnTE9ySlUzeUxPdjdkMzJkOGNCT0NIbTluQURRMVdxaE91RzJSSVpLTDVn?=
 =?utf-8?B?SVFOdEZWejAwQ3laeXY1L1h1bXlncEVFSGtjRG82dTFyOWVsWjJwTGpVbUxp?=
 =?utf-8?B?bjZPQWhPRzk5Ly9Ec290eVl1L3diMXFpTTIwaVhOV3F5UXZBNFcydS8wOFVW?=
 =?utf-8?B?NUZaUC9jVi90NGN6bjhyRHNiTk5wS0JuR0lHOFdpWVIvdUUrcGZkaXUrdFhm?=
 =?utf-8?B?b1pUbmg3Nm0wc0lpWVU2cDZ1aXJ3MUphZXU0M3p0RWdGcTBzayt0RHNUU2xF?=
 =?utf-8?B?UGM2UXhIRjFRVHVESGVnTUorWElIRHFadWxZR0dZWmRGcVVZYUlyUTZXM2gx?=
 =?utf-8?B?WVJ1OTA4aHc3TDNWeEc2aCtLWGdHWGNsN2VlVWRlQXNBaGRWSTZncGF0OWRi?=
 =?utf-8?B?QVF3QzFmdFlOZHA1dUhMT3JKUHRKZE5YZ3h2RlFOa3NvVXhYVVlId092YTB5?=
 =?utf-8?B?KzhqSnlneUlVNll0bjViZUpLS2JTQW82VmN0eVQxVEJROThnTmJDY1BMV0R2?=
 =?utf-8?B?ZWk2SHcxbHVPa01telJVT0tMOTAybEJsaVNQYkdQdnJLTGRuK1lPQU5USHh3?=
 =?utf-8?B?a08yWThjTEkzWnVaTHBEdDdSeFY1b3hZK2x4YVozamQxa0syZG00UVMrTGNn?=
 =?utf-8?B?aEQ4d1FpMDZLYS8zRnJ4RGNvOHJvSy93SWZTQURhUFB3bW02UERhQk85akx4?=
 =?utf-8?B?TkJkRkVvR2kySXd5Q05KZ29yY2J3b2t4WXMxSC9DdndpYk1BK05SeGRKVkVO?=
 =?utf-8?B?WjIzdVJKSlVGV2lMSk85V05ncitRRVFiMEZ1SFk1QkoyRTZEZmNvYXl3eGZ2?=
 =?utf-8?B?UloxcVNZbEFqQ0VoTGxlSUM2czc4YlFlZXFqS1hKY0RSbzVUYXBmZktBNXJ3?=
 =?utf-8?B?eVVRRU50cDBwVTNVRzlTWkR6Nm1TUWpZVlNlb3VLZmxzUy9zcU1XdGkwcU5i?=
 =?utf-8?B?YmJIemJCRUdWRHQ4eUdYUHc4ZE56TmdXaHpoTkJZcnRMYTV0dVBiUGVJQWs1?=
 =?utf-8?B?TXlSWUxnelhST1A5aXVFcEhoVFVaMnlTenhGQ05BSHljM2EyU2txMDdyTTdE?=
 =?utf-8?B?QUhDbi85Q3JiWE9EZURMSXdPMS9yMytNVjR0R1RZUHNmVWRYc2ZYVzRSd3k2?=
 =?utf-8?B?bkJzSXIwdVFCQXhxcElwV2xvSEtJLzY4MTZTc3p0a0Y0eWYrNTliaUtwWFU4?=
 =?utf-8?B?OWZ0UXkzcFdwd2l2Q3ZJbHNhOWZEdzlqSTFtdWxzTkZGa3ZaZlVHOEErUEVU?=
 =?utf-8?B?Z1g1M0xJenNMUXF5ekVaQ0k0WTFyN2Q5dXhKa1JLSXYvcGt3bU5VelM3b1N6?=
 =?utf-8?B?WldXWWlIMGdzZlpRMS9PQTlIM2FlQXpDdU1qL1dBNzRhWnNlYm5kRUNyVm9T?=
 =?utf-8?B?N1NWY0JJWDVhODdNNEoxOXZsVzNsN3F5THdUWkRYMGY1a3U0SzFZOGxUbXhl?=
 =?utf-8?B?b0wyT2VMUzJuR0hWejY0ZElSYm16cnRLUm9qODRLM05NZkQrMXNrVHJvZk5Y?=
 =?utf-8?B?Zi9aRGFtREt4Vm4xcVVncFpldGJVb0FJWkdRT08zaHBWbzhMVCtaQjRYOGZI?=
 =?utf-8?B?TTlQUE9xalFFTTFucFYvdTQ2Z3JYSE1vT2RkNnB0WVJHdmF0NkFEeW1JL20z?=
 =?utf-8?B?TlNka3I1MVNFUElhbkd1WjVxZHJwZVFZb0N1Vjd5NjNQZUNMWTNZQ0F2Smdw?=
 =?utf-8?B?V281SU9Qb3hMd0FOamV1c0xRemF2T1VWTWFxYXhMUXl6dk9DUDl6dVppaEk2?=
 =?utf-8?B?RjZIK2hDcnYrZnpmS3pjNXVSNkEvMUpqVFh6SGhCak5ZcGdaMHVOT0hjeHZ6?=
 =?utf-8?B?UkhMNmc4Uk1hYjV0MW56VGpUOWVBPT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b84ad0-fc5b-4f6a-88c9-08dc12b785f1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 15:11:01.7989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0UPgc4wZewwOeOi+hcU2JxOKEuZQB6xcGhGQlNjpL3UMfpsQdLJ4H+PwWSHKEkmgpPlc+eLWuAXYgSvIZYt6+yQkqPlRJvgGqjcFlktoVoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5563



On 11/01/2024 22:40, Paolo Abeni wrote:
> On Wed, 2024-01-10 at 22:14 +0800, Pavel Tikhomirov wrote:
>> This is a preparation patch for replacing physindev with physinif on
>> nf_bridge_info structure. We will use dev_get_by_index_rcu to resolve
>> device, when needed, and it requires net to be available.
>>
>> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> 
> I guess this should go via the netfilter tree, right? But you omitted
> coreteam@netfilter.org from the recipients list.
> 
> Additionally, at least for netdev submission, when some change is
> required, you should resent the whole series.

Sorry. I've sent v3 as a whole adding missing maintainers and lists, and 
fixing spelling.

> 
> Cheers,
> 
> Paolo
> 

-- 
Best regards, Tikhomirov Pavel
Senior Software Developer, Virtuozzo.

