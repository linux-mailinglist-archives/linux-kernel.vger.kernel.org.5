Return-Path: <linux-kernel+bounces-27207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E9082EC36
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39145281E46
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB05134A1;
	Tue, 16 Jan 2024 09:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="uNfgpjdS"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2040.outbound.protection.outlook.com [40.107.15.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E1F134A0;
	Tue, 16 Jan 2024 09:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxU27n1DeediDMxrt7QWgkpN6SH6bppN2+4w4l+KuGm08XLsObs7GeG3JD7CSdH1v/6ZI/rLDDZgiV59zdIDYU4ODs8oX/B2w0CSH5RnkdB9uXud9qvS2SsJIFE7TK03eJmHbDIsW1jSfBtQnf8ZnqS1si1RvNGaa/7u1r6PIsLvSKoVvLeFL3CEiBXl76sgBnPYN8nNKt0/cgHXf7kfqCO0+lt3wEXNZBYgSYshCEwCaymZ3cfM80ZYlaihDXJar75KvBx+HgxsIJSIktjcWiHG/8KKr3CGsgsoUO3YzPSm3L6cvtKKz37dQlA7DsstRO9fYaQZg2EPN3Br1ncmTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOw0eUpiGNz2iAoGWqOmWCbLp500rV7i4UxtdoMIkNU=;
 b=YWA8yYKOmusawQ5Dr9el1gpxCPapWKtYef8ybx7BuKV3hVqE/7/ue8MbIhIhn+exB0vHtjrVkgYoX4GCePLKtMXuN2axp8rTfe99p1/YHp1NvebHFPEKr4hPX4+9ixtEgXIPPDRvL14cKGvj7OdryNxozIpT1pQnwrKvnQjVNroD29ihz3CGWPvqHJjwMyDZoyEt5LJtTLrUIV2HempupUSrFYQgjnH6zL73TidsMZndsxS1QYEgbYIRCBikWpyYDFyJYdBXH57MnnsfO7e3BRKtti8xRpill8C3CL21g+5/WMCgSSxQKVodoDaDqJlOpIem810Hqo8KspxI2luYMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOw0eUpiGNz2iAoGWqOmWCbLp500rV7i4UxtdoMIkNU=;
 b=uNfgpjdSmNdvd7lBBtZ62n0O8w6cnkULDTSxvsmf2gbtVXLNjKdSQIZekeKBhvv3FjYnkfBhGgSb/jcOEPnfUY/tUcUrBmc4ZfpwB/LmP+nAsm4eGSzalL1GiXaEiiQD6FF9UniDAOdTWO3ThBFcJh912kEmTYstDrEWfYOwnS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AS8PR08MB6421.eurprd08.prod.outlook.com (2603:10a6:20b:31c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.29; Tue, 16 Jan
 2024 09:52:22 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab%6]) with mapi id 15.20.7181.027; Tue, 16 Jan 2024
 09:52:22 +0000
Message-ID: <4a16a651-62d6-4fba-8e18-1da029c52768@wolfvision.net>
Date: Tue, 16 Jan 2024 10:52:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/4] Input: touch-overlay - Add touchscreen overlay
 handling
Content-Language: en-US
To: Jeff LaBundy <jeff@labundy.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>,
 Bastian Hecht <hechtb@gmail.com>,
 Michael Riesch <michael.riesch@wolfvision.net>,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20230510-feature-ts_virtobj_patch-v6-0-d8a605975153@wolfvision.net>
 <20230510-feature-ts_virtobj_patch-v6-2-d8a605975153@wolfvision.net>
 <ZZB9x+0eNL8e+xI3@nixie71>
 <12ac3718-2c69-4d11-8ea4-b555f2321232@wolfvision.net>
 <ZZ/zR+GybLjR8Dcb@nixie71>
From: Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <ZZ/zR+GybLjR8Dcb@nixie71>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0130.eurprd07.prod.outlook.com
 (2603:10a6:802:16::17) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AS8PR08MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fffe39e-8f4f-4084-d54d-08dc1678d5b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mZYGJb7exunLG8HtZRB3Y67f9Zqi5BJ4WrjUShtRMWjkfVo5ytH6hFVBBYCaD8/C6hUYUIwx16xM6YjZvKmt95Ymmn328xuPQUbEnmJVypEmeAJ8kcQObPQbrXVs6DrSScDWZfR5h8/reEPaC/uvNyU4S8q4aF+mZgw8T9UHHIbX/WfNXTm4bAEczeyis4duuyxcN6ETREapZEpTZrfQPG/LNMLTYefeAVQ/KfoSCRgjnq3Cp8Vrc3pgOvMwkVZF0F551chwAU6G4z21j+O230J7kHaMZAc7VI81uqci8soguxA6jHFEUmFuXXP2LNHqUoHHXKcwaTTsIKlO1Uuy/87tWYoiJNWQRl9zZ/FuEiRRapAGrTJ8K0Ahg+YrXZ168AivpFXDYG7456BjTygsbDIZRkL/mkH0/03apy7cm0MB8V+ezFFfn4zm5Vnh5yeS97dxsYuCfveuvPsyZrs2NBKWI4q+DVU6uVbb6izSwq81jwN/mOUzQdMOZVp/Ps4s0nndGzk6eCue1Z46SlNqA7Bk32v19FDlXnazbHdUqRt8vbzYzzNJueLtIkxwjWpvyCu4t7IW1G2ktWHO7evnh0n58ZWP2JHHdaVKtgQqyUQ49r0QFZYIbEB3hRwuvxcag0/yUVay4PZ+vXdAJCl3RQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(346002)(376002)(366004)(136003)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(2616005)(83380400001)(38100700002)(41300700001)(66476007)(8936002)(8676002)(6916009)(66556008)(316002)(54906003)(5660300002)(2906002)(7416002)(4326008)(44832011)(478600001)(6486002)(53546011)(6506007)(6512007)(66946007)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkJFaDdpeXZQSExaTk8wc2FhdWF1TVJoM0xEMUY5ODZwZzVzdk5DTjFUMld2?=
 =?utf-8?B?dmcwaDdRcDVYZUhUanFWaG80YmwxdmNlK1gxc0N5V3V6TzdNclZieExkWDU2?=
 =?utf-8?B?elNSelp2R2h0Nm4zTXlHZERwR1F3aDZSS0FIOWtCY05ZTHdSRkFXR1JmK0Ft?=
 =?utf-8?B?eTBDaUhEdFpIUXNSMUFBRjIwdUlvSWRrSThmbzczK0pKbTgvTzltcW1WZmlK?=
 =?utf-8?B?Y1JpYjI0RlNYVjcvZlRLTTlDU3lJcUZOS1VTaHdYUlc4cWVJVFR3UmJWa0RN?=
 =?utf-8?B?UGZrelBXU3MwQ1ZCRXBVVnRMQ28xd29FeFFrNnpvWXI3VnZZSFloTzd6Y1B1?=
 =?utf-8?B?Nys1a1BVTmQ0cHNhU1lPNDJkTzlCMDdUMlM1UFRpZjFjbTFwSTk2NjVHN1Jy?=
 =?utf-8?B?M3hWQXI2QnZqekU1c3JOZ0ZBRmJyUlZsYU5SUUwzWmVYWTB2UmxXY2M4NnI4?=
 =?utf-8?B?ME5OTHIxY3JtbG80REE3Yjdzd09UN3hkSGJ6cDQzTDlFVUNKR0ljaGhZUTMv?=
 =?utf-8?B?L1UwOVlvbkFubkdFWnBkNHdjaWZZRlArdnJxYUl6R1o3cEZFRkNlM25LeFZh?=
 =?utf-8?B?MkdkU2xtT1doNElRZWtIWElMeVF2QkptRUJXOFgwOW94dm5QMkJ3d0Z1eHN1?=
 =?utf-8?B?K3QyNjE0QkJ1OFNQcHk3ZmtuVnlVU29ucmgxWnNRVDVWSTZEbW1lblYzUkdP?=
 =?utf-8?B?dEZBU202MmZrRFlnRk5oUlQrUHdxOGpuemo5TDBRZS9Rc2hwSUJWSVd4Nndy?=
 =?utf-8?B?MmZsTy82dEt4R2V6bmxFMTdtWURNSlViTmxDcnpyWU5OdU4vSVVmTGR0dkNr?=
 =?utf-8?B?dzE5ZGRkRVBiU3lqTm9RdGNsL2Z1aWt1Qkpwc2JPbG9rV2ppYjA3eit0ck84?=
 =?utf-8?B?OGdBQXJtdG1YR0h3eVdSbmNCMUM0Z3dDZkZiZmU3Wk5tOWZmYlFpeTRGOXpk?=
 =?utf-8?B?bTB3VndRU2Z3TWxkcUFJaVo4VXpRVXB1Vk5MY1lnUzBHK0lOTGwyakM2dlBO?=
 =?utf-8?B?V2p5NUM5Y2JyNWtWZDJlQngrT283R3BBcHorVUovNElvUkV4Zk5OZ1p6MDUw?=
 =?utf-8?B?Ykxid1NraS83R1lmTmN1eXNpVUxMUFFaemRzc1RzWld5Q01RNDJlckZNOWpJ?=
 =?utf-8?B?NHhiRGZIT3BvQkxjd0RmVTlFSDdSWnk0THlmd2NEazdIaElOQzNrN2cvR3pO?=
 =?utf-8?B?eUpjMkpNanQ1c1h0UmJCRm55SStHc3FWd1VRbWxybGdoVFUxOFBsYU44a05M?=
 =?utf-8?B?aFI1NDB4aHM5bGxML1hLWVlpVEZGN3Njc0FiYjgzODVuN2dCTiswczB3L0g2?=
 =?utf-8?B?dUEvZThHRTk1azdZM2xXOEYxQWlDUEpMUkd4ZXNEYnl6TW90TmptUi9lcjFN?=
 =?utf-8?B?aVJkNjZoUmpXVVRERWpZeCtmWTBMS1pPZVhTOG9rdnE0d3EyZFVHNUxmY3h4?=
 =?utf-8?B?a2E2NVlBdmgvMWJxekxEUENVMlRaQlFqWXVSajFPdytwemVobWVBeWhNaHF6?=
 =?utf-8?B?NlRBd0RzSXFFcGxHZ2JBcGJZOElwRmMzYVhhVjhYclljZ2FGOEdIVEQ5em5m?=
 =?utf-8?B?TjhPaXJKVlBNbHl1WHgyOG5IWHA2dkNjeTFYcUVBVHR0S2tqd2RwU09HbFZJ?=
 =?utf-8?B?VktrZE9IVm9mZlhUa3JhY3RoUUhIMHo0aFlSb0c1WmllaGV3L1dhd1hRclE0?=
 =?utf-8?B?aEVSdkdqM3pGMXQrRDJRZGdLTFdRT0tNQWlWMytGYUwvSWxNcHAvay91QjdK?=
 =?utf-8?B?WU5mWFVBZm5RUHZEUVY1cmtwdUcvQ3VJbHZQUFdzMnh2L043WHBRekZqZjE2?=
 =?utf-8?B?V0VYNzBIcWgrTVA3Q1dDSG5vVmFFY3F2YlZwaFZsNjIzOFdJTExMUkdhZ3h4?=
 =?utf-8?B?akJaTzVQYUY2OG5CaVFBVzBXTk4wQjVFZGpoTjFTU1lKUkZvOE4yeUhrMWs5?=
 =?utf-8?B?MDFUS0QwbEM5SXNXUDQ2U3V5WHc1d2RrK3V4VnhuTjgrR3EreU1MVFRPT2p4?=
 =?utf-8?B?a1c3bTdDMDZZVWUzakRsYmlYaVRSUXpMTGhCKzhqeG8rb2Q2SEFmVGI5QTZv?=
 =?utf-8?B?UExGNUdwK2hhNDZTNytXMndOUXZSUm9WWVR3bzBPdkhTeE9RRmF0MlhhaUhN?=
 =?utf-8?B?b1JUcWxHMzVmL1NIK3BjeEpIUE9rdW9Xa01WNmF3WUtzbHJxaTlqaTVRNlQ4?=
 =?utf-8?B?ZWc9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fffe39e-8f4f-4084-d54d-08dc1678d5b1
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 09:52:21.8656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4onupTeVV71bmrzVj9XZqdQ8L2CX225VgCLHwQt0mhQ8LveKlCp5tKSf5b5/TL96iy4XKXhdwFcNOyraApN1GBFjYkwv17t6ZVcxPDaZULs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6421

On 11.01.24 14:55, Jeff LaBundy wrote:
> Hi Javier,
> 
> I agree with you. Thinking about this more, immediately introducing this
> feature to the core is a relatively high risk that would be shared by all
> users. I like your idea of introducing a preliminary version first before
> making heavy-handed changes. That's the beauty of helper functions; they
> only impact users who explicitly opt in.
> 
> I don't have an immediate use case, but I've been looking at this from
> the perspective of a future customer of it. Maybe the right path forward
> is as follows:
> 
> 1. Stick with the same general architecture of v6 and its "limitations",
>    which in practice are unlikely to be encountered. I imagine the overlay
>    layout you have been using would be the most common use case.
> 2. Make the handful of small changes that have been suggested thus far.
> 3. Consider updating patch [4/4] to combine the touchscreen and buttons
>    into the same input device as you had in v1. This sets a little simpler
>    precedent for the first user of these helpers. If later these helpers
>    do get absorbed into the core, thereby forcing a single input device,
>    the st1232 would continue to appear the same to user space.
> 
> Does this seem reasonable?
> 

It seems reasonable, so I will go for that approach in v7: single input
device and less modifications in the consumer drivers.

Best regards,
Javier Carrasco

