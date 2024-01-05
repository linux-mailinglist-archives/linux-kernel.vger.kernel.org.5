Return-Path: <linux-kernel+bounces-17818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58543825325
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 12:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 675931C22DB8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EE82CCBD;
	Fri,  5 Jan 2024 11:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="q4exUntM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2075.outbound.protection.outlook.com [40.107.104.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C58B2CCB2;
	Fri,  5 Jan 2024 11:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UIg/xDn+u4vjcslrGd510lxk7gTa1fSEY2XW7c2xvxDh/69w/khxPEjMPIGVU/u6iJb1QiFhkCJX1XMqzEd5+Yuw0l97skR6h5F5/zcbdLCJH0vs5K4HKQ/1WmHiN94CduMeb19HYN5rp0umA4RiOc4gvML1mLMV85hNuBRIBO8gGWQcuvbqCt0H9A0O+HgXPdVjkTeta5iCtEa0StFe72Ng240ki+Y/IxFLX/xpl6+SjTF523INUoSHYRmfzPXLRDcisnZ6gW6LEWwPEQweQMQ7mVbQXarR3gqquztlaEkmefdYIi8e2aQR+dp3QemHfGOSgAJ0i46BkTd6KbrBvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oX7D06d5OKgW+/t0rQ5j4cn7f+ujdLtl0MK9BsCNVyc=;
 b=Loyg5iwnmj2J1teizUpCaMVTAXHItocQCFj47+W5p4mtx6iPMC97coKNuqkv9E0lEqpiyxb67VxQvRpSU+/eQXE3U0ClMq/vcjw1zRIPhkaIB7PiOMxdOjQKdTOfXb/6EVmHMIRPwawSAsGwDeWjr3aNiMtqp9v0ExSRLBbw2A8YMtguSxKbbvkHaYRobVlP08hEUvuyn9Le6P3VLZ56yXC957ZzqWp42acHkHWDLOPneK0WRi7aB7Y82rOawVWMI8I+6/ucCfl+IVdcC1UH2dpUj4bVB8i+TxxKg3WFAOmp6D4YKs1dtbazuokM1sbX4C37F9XHiboPpsXVyzd+2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oX7D06d5OKgW+/t0rQ5j4cn7f+ujdLtl0MK9BsCNVyc=;
 b=q4exUntM7Vc5t2f/X0qC/OkuGBN6/6nmPsZKV5g5YIhDdwXBQMxWex1q2KkQ72lqKRbVvQJlfVjN7HOTVGc+VO+VNi9gRuEWQdkE3+5z4AYnl5+zY1nPTmj15oZMrMApQ7Q9srL/H5dJpMmnMEen0XmV5NlA3Q9v7e6eA/NL7ZxkSRUi4wfSn/73g2JLJgu+R8cPmaL7Fua2dNAwGzReXssoHKPsyTAX5eqshth01aHeYKaJ6SOAWhbXwyGD6PZCojGBpZ/moK8DkNyTwFWK6FKVlMAk1w7jmQ8c14Ea9SrYYFl7HGNHs+6XS/Nlv0IHehSuiTTYKf5zbyodYW3Bdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com (2603:10a6:20b:4e2::11)
 by AM8PR06MB7074.eurprd06.prod.outlook.com (2603:10a6:20b:1d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 11:56:38 +0000
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::820:f7b6:7f2b:324b]) by AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::820:f7b6:7f2b:324b%4]) with mapi id 15.20.7159.013; Fri, 5 Jan 2024
 11:56:38 +0000
Message-ID: <522eb2bb-95d0-4e2f-a426-9347f14f51cb@vaisala.com>
Date: Fri, 5 Jan 2024 13:56:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: core: Make default authorization mode configurable
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jaaskelainen Vesa VEJ <vesa.jaaskelainen@vaisala.com>
References: <20240104163203.7381-1-niko.mauno@vaisala.com>
 <2024010413-portable-lingo-3c11@gregkh>
From: Niko Mauno <niko.mauno@vaisala.com>
In-Reply-To: <2024010413-portable-lingo-3c11@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVX0EPF0000ED9B.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:3:0:13) To AS4PR06MB8447.eurprd06.prod.outlook.com
 (2603:10a6:20b:4e2::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR06MB8447:EE_|AM8PR06MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: e8de5be4-0951-4c7d-42fe-08dc0de55f75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BR86871H2YtkTJAIC++bAc0LTZZlhmtdsflHXpWH4T+v08fEzCgskrJaUxWFK7EsNJ4jFmRZ9DYDoR/mQ7sn5Qi5cCHZMWzqPckEZk1sr6aG01ncH0YLwHl1fdySr/SDwwJ5UH6mVVIO4rBR/7G9kuYzeYRVpo9UHvWIYjvyzexomShCW6b+n0EM9qmNJjucEZPgH8SFUe4GqC0pkfa5TYPahZRo5o/6CiUk4CRnaVomfZrKFrukASJUwTog753GyrQEeHQCTk9+AXdaRJi4eVnETtCqQOSWcChBJf9vfO7oJEgDHBBIEeH9/3gEMJxkhO/ffoXCWq2JM5HHHj1joRnckk+F8DnQ8A5cDcC7XVoMOP3C52Ud+y67Sb1xWc0RZHWIH1yxZlteaAImpvQWbe9all/4MimiBh5oPl0UAPOOQREG8dAcc7Y0zfsNAFKlE8akpdr1U0xxvzuieiOZS/gi+75dIKFt9LTnwUgziUa5Vd0rr8l4F0pOTwEsK7XYQ/szX/5EM6g9LdNjDVFPUrAdImCGLm/rscxtnb6g44mY9v1oMGj1sEDztYERcoiCtDzw6AHRPX3RvNoDWy/FzzZpKPF5HysKCEzMfzeMjcf1gUIqr1a1fdqMypCJh86mKiftnpaB5davR2x1vHfCTA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR06MB8447.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39850400004)(346002)(366004)(136003)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(31686004)(6666004)(26005)(2616005)(83380400001)(107886003)(86362001)(4744005)(5660300002)(31696002)(6506007)(478600001)(38100700002)(6512007)(6486002)(36756003)(41300700001)(6916009)(66556008)(66476007)(2906002)(44832011)(4326008)(8936002)(8676002)(316002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDhvTnhoMDlFcDdJVXkxSTFQVklnUDRTMytMSS84c1FwUFNFMHVRbGJjSUZ1?=
 =?utf-8?B?RjJkSWEycXNGL3hWSDY1L3E5WkhDY3VCNzlORUZuSzFEMTA5cm90TVRIam0v?=
 =?utf-8?B?OEFZK3BjOXNCMXdXMG1DYjJXbjlVdW1PVFFQN2FlQUtzeUtwZHJvWGdYVjll?=
 =?utf-8?B?N1BnYjU5c29ETjh3VFJXbUgwejNncVRIbXBCUUp4Rlo4MmorVDU2aTYzYTJX?=
 =?utf-8?B?akdHc3cySjVaVncxTU5SbGxyeTlIRm1uUUtRcFQ3S2k1bnRxZ3I1emdkUXIv?=
 =?utf-8?B?OUF1bThtaWZDTHFGOXM3MGl5ejloWEo4Z3d3clNiazUralRreW9hZ29aQi9o?=
 =?utf-8?B?eTR1c0VUMjRlN3hvZm1ORlhkSDVMQ1NXQkhPc0lFTlNEZDBGeExsV1RrSXVW?=
 =?utf-8?B?VU8vSklmRjZTK2lZV3c2N0I4RzRxbUZtamk5Q1lVdGd4VnV3dkZBVmtYUjhF?=
 =?utf-8?B?Z2lyZFFKR2tsUnczOFFLbW1jaGgzRUFyZmU2cXhDMWs3YzIvNFlFSnU1VUsw?=
 =?utf-8?B?WXhpU3NtM0FubVRheVltbHQxL0lDNWxkVDlUKy8rUFlRTzNGYWdnamM1Q1dM?=
 =?utf-8?B?UndhYWFERkpSVjFmU0dZVzQvSXpBYTRCVGYxN3RxdmF4M3JRMDM1b2FVVTdL?=
 =?utf-8?B?ZVAwRUlrbjZaOUFzbENoMmxBVDZKbWkrNitwVTQ1RGhtS1c4a3Y3Z1dPQzdK?=
 =?utf-8?B?T1lqdk9GYmhwN2F6TktmSVM3Zy9zakthTlVrMnBKaTlxRmNmM3BDZll6Yzk0?=
 =?utf-8?B?elcrZERyd0s3K2ZmUTZCbXZWanNwZ3hPMjZRMEdNaWxzbjFORlNSaXEvTnBI?=
 =?utf-8?B?Z1ZTclUzOTB0YjRSYmFSK003N1lpbHNrS3I3eHVqUC9STzlqQ1FHSHdxaWVH?=
 =?utf-8?B?WGJzZWF0eWhRbEt0TGtBL2RvZ29FME1abVNHUzNrZ1J3RW5Wem1Sb2VJK2hm?=
 =?utf-8?B?bjRoUmwvWlFqNTVOT1AxVGF0SGhmY0g0RklFSkUxcUx3ZHZ4TnB4bnZHQWJT?=
 =?utf-8?B?SlR5R0U2VGhLdkxtYmp4N3grZ3BBZExCdlVBeFZYYUk5eVV5K2VGSEEyRmJC?=
 =?utf-8?B?RTVyVmk2MzJwSVNjNUlTdG0rWlRPTUZiZVphazd2WFBRV3BiM3JRbmN2SlVW?=
 =?utf-8?B?TVFsRnBleldXUFd6cEZrSUlhTFhWTlcwREZ1NWw3VGFIZm9ld3RyYlhIWHN3?=
 =?utf-8?B?bytLclpUUjJYbmtNa1BNeWNLUzNPbTJrVDVjWUdaWUZnVkdxcklFdEV0RUFz?=
 =?utf-8?B?TUNlaVMySzRISkxiRkxQdU9WNDZuSlBFc1djb0t6bTR4Q0N6RDRsUnlreWtS?=
 =?utf-8?B?ODBEMjNFYURPWDFKMTY1djU4WTZZZkxmeHF6MEVwdVcvZEM0N1V2c3pZN0lz?=
 =?utf-8?B?RldwTE95Qk1VVHBhMjhQZnlnNkh3VGo2ZVZVV1NMOU9HMXVaQ3prTFk4VmRN?=
 =?utf-8?B?WHNrajZiSFZzSlhPbG91UDd5ZlNHQUF0NTVkcnlVK0lXOFp0TGpEbXNuTkZj?=
 =?utf-8?B?bkVheEZCR0NWY0RsRlJTRDJmWThHbHVXT0FoM0pUQlVlblc3bHg1UnpPcUZC?=
 =?utf-8?B?b05MdFNKaExhN28rc1ZMcVJ2Nnh2WG5QbktpTzM4WHBCaG56ZFRkMUZpdkxK?=
 =?utf-8?B?YmQ5Y21XUG9hRjQ0Q2hUNVBwM1Zhb0ZzRUdrTXhqN3o0cmE0VlllcUNHZ1NM?=
 =?utf-8?B?MVY0Z0pOcjVNSXV3TkFMZHN3K2t6ZzlhWmkvenpjVm13RkZ6Z3VTZjdZaEFM?=
 =?utf-8?B?Tjg2SG9obitvbDFBSVQ4ZUZNcjVNajI5MU9vdERQRVRJVHRuNjIzOXBRbjBu?=
 =?utf-8?B?M21uLzNhc01zWG1FRGNpWlVJTm1pdTd1NGlPWXo1cTloRjh0OXo2MitQc1c4?=
 =?utf-8?B?NkNia3BPMmVHWkswd3VXOUJ1bDdzbkhHd0hZY0tlUEZPemhwNmJkMVlBN1NM?=
 =?utf-8?B?WXRGdzlBZ1pOV01vL0RKMUxUd2F2NUIrTTNtczNnalJ0UllFNDYzZ3hPWTE3?=
 =?utf-8?B?ZUJwYnF6QUV0eDZOU3RQV0Z5L0FuRjk2eDVDWWRIRXhtU0lFU2VuVkNMaWVB?=
 =?utf-8?B?c00wNVBWQURyRWVWSS8ySkVwM2RmdFpOSjllcG9LN0MxMkVQYXRqd0hwd0Q2?=
 =?utf-8?B?ZUZYWktyQStHaHluYUVEWHdGRWhhZmVQRHJweitWNlo5OWdLbUFRQWF6Qndl?=
 =?utf-8?B?bkE9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8de5be4-0951-4c7d-42fe-08dc0de55f75
X-MS-Exchange-CrossTenant-AuthSource: AS4PR06MB8447.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 11:56:38.1730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GIGrvJB8spPTua0mFq2nJQ1Phz2B580bVze4imrq4EJ3iHLubolzkp6N4aYw8jkaaTzOE7A43nA81dbrz/ygDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR06MB7074

On 4.1.2024 18.41, Greg KH wrote:
> On Thu, Jan 04, 2024 at 06:32:03PM +0200, niko.mauno@vaisala.com wrote:
...
>> +       The available values have the following meanings:
>> +             -1 is authorized for all devices (leftover from wireless USB)
>> +             0 is unauthorized for all devices
>> +             1 is authorized for all devices
> 
> What's the difference now between -1 and 1?  We don't have wireless USB
> anymore as that never turned into an actual product, so we shouldn't
> reference it anymore, right?
> 
> We should get rid of the -1 option entirely, but keep the module option
> and properly map it to '1'.
> 
> 
>> +             2 is authorized for internal devices
> 
> Needs a "if you don't know what to select, please choose X" text here.

Thanks, submitted v2 which strives to address also these considerations.
-Niko

