Return-Path: <linux-kernel+bounces-4129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E48817830
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F9081C22A5B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEEF5A84E;
	Mon, 18 Dec 2023 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sFlRdBE1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA524FF84;
	Mon, 18 Dec 2023 17:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNRjwtJTV7zlmsY+JiKh93Z+5iOf/xo4JfqyT6UfeqCzeq8y+3Pxma0Es39wmQ4wXyX/hPRd5XBlYDGd8mpZ9LmGmShsB72jHV7ccDQwTLQly7uyBJM5T6dBz2wDlnnQJ4TTT05HMkihANUnMjZoLGDNsFE3ovbCC8PpP4OhHLZkijW0V4OQf5PfhmZ9m+6W3cntWh8TJFTRcDSEUgmMSHOYKAdXeKyAwtjK6lNxSfGdru9uwdk4vEiIBsA6YQUhBBy4L5Vgu+w0z9VTtsn5kdydgZmq2OoMxGOcXLGWMZ2xN4vB839Uc7bYzos47qBfyKeLAf9VsXf5Xho5EwRAMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XP2vqPz8MEx+ONysn6Cg0qyfed9UGHVNkpY22CmCQ8A=;
 b=KNHiM5fbaUuzFkVDY4+gnKFG9R2D/9446nH3gU3IjYYPP693p4gL9KeXN13elTXkRXuxS0np0ZeEcTB17jdPye+p4R/m73W4Ev9K4qLTm0QlrwPYVBOCVsS3hOJufCZm5VR96qj0BN0YJ2xTEWSX23T9CBXARhxWNbeS62r+Zg6Fs5qUaAo37ovsfGPe7lJkK/LIwPWHhMznBDR50USwj9sUq7Gac0Y7PsdzmplAl2uLlX7l8fivbUO3AVoSrDH10pAaBIztjjYpgrXI45UTrEwzmWbjWUjMzB51KVKIb9E39MdrGOSXpNpeNAF46a4Wce8UHDMnB4bOSQ4mB+p4Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XP2vqPz8MEx+ONysn6Cg0qyfed9UGHVNkpY22CmCQ8A=;
 b=sFlRdBE1shZB5we5k1qrHairpLKgf7vHoVtkInChTtJbFP77HrSc7E/8XiphBVTU6FKUMdlOAXZVNTLGmMvgxesQFQxs6Dxy8ZWp+ur9bu5zjN4K42yLHBBtxtQ20cG5qeIgJHmvmFyggSJIlsYjQd7FmdZ1YFx0GJ6vHPoKMtk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by CY5PR12MB6624.namprd12.prod.outlook.com (2603:10b6:930:40::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 17:09:45 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::e2:9f06:b82e:9a0f]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::e2:9f06:b82e:9a0f%3]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 17:09:45 +0000
Message-ID: <fbd8ebfb-b7a4-4904-86e0-5196be6cd99e@amd.com>
Date: Mon, 18 Dec 2023 11:09:45 -0600
User-Agent: Mozilla Thunderbird
Subject: [PATCH 0/4] Spanish translations and corrections
Content-Language: en-US
To: Jonathan Corbet <corbet@lwn.net>, Carlos Bilbao <carlos.bilbao@amd.com>,
 Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231211023730.2026204-1-avadhut.naik@amd.com>
 <87il4zqwvv.fsf@meer.lwn.net> <3c72323d-b3e1-46a9-a462-c1986667cf7a@amd.com>
 <87a5q7moli.fsf@meer.lwn.net>
From: Avadhut Naik <avadnaik@amd.com>
In-Reply-To: <87a5q7moli.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0104.namprd04.prod.outlook.com
 (2603:10b6:805:f2::45) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|CY5PR12MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: a73282bc-0229-4e11-7109-08dbffec2255
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BjTp5/RhEMtUChhp2G3x1FLSlZcHYkLH2SdUQ629h1NjHJhK7so7s8qGaeEynjvckbm6+S8PUTBNEsBvxmOscpRzOThrkbdWieCd/MQjEyAMs83nrh4AnHhGllAtNdp5A8j5b4kDVfQuNvQYbDaF85S/Uc7RKbzSTf9RftAWmP/SmfaFzC0CbJpQH5pt/eazgofYXUL8lkpmihLfg/6IyHQeG2AW3R+2n/Pnc5M7s5NxyrPWRDhVmS7Zl2SJSgyoiszSFlJSnXqsKznW5KA685l0W1LiDeAKsAvnDKIsrAJbZRQzTOEW1vfV3vAoCiwQALEEKSOy0/Je0sa9mnuS/Vz8mZfL5PTxf3qIGtJbc/5iGJBSQOS9z8Hje1pRvN7CO/ybDl3r6+0Ym1f6hK1N/65QpqaB8KQpkpnjz0x1SQ7KmlZq+34RHkWAWD+kwkMWB+TkySlPg1XLhA+cg39ouksZo706tazuyE9obeX6jkNOWYPKOvmLbkdjLcdNReUNsfzFnERBVXu9ic2pR9oAe/8XUHs2i2lvIWZqVZIWKbI2ma0T9qxYlYYVJKiuUYiNXIhoiDAa3+dCQtmV275QBI58jsbQCbOnXje20wbp2DFG7piUkmMZh4wGARIHHnGCerJVTMQtiPKiHUXcInf61A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(66556008)(66946007)(6636002)(66476007)(38100700002)(36756003)(31696002)(26005)(2616005)(6512007)(53546011)(6506007)(2906002)(110136005)(316002)(8676002)(8936002)(478600001)(6486002)(5660300002)(41300700001)(4326008)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2xNeVk1WnFZQkZuS2dQakhhQVJYMlJmNlRrQWkzcGNSY09yTldTU2JzS3Rk?=
 =?utf-8?B?MUNxQWs0ZExLbjlidjc5TEllZTJ3MFlvM010TXRpT3gvcXpoSjQvVkJrellO?=
 =?utf-8?B?eEtYVlRBRUMvVG96OXBTZk9lTlJFOU85aDkrdHBGY1FUMG5hdHRtb2NEaDFT?=
 =?utf-8?B?YWp2NWxPWmQ1UjEzNHhZSkR5Vkx2TjM2ekZMRkkxMXJMOGdzaFlCMmFmVTBj?=
 =?utf-8?B?c05QSXgrc2kwY28vUDhPUjZXZ2VqZlJVVHNmL2NRUEVMM0g3N2huU0F6WlNn?=
 =?utf-8?B?eXJZWWFZVnJXQVRITU5rWDZUaU11SC85c3JmaHpHZWJlMEtlQks4V0oxYW9u?=
 =?utf-8?B?N05XVW0vNUF0WG0ycFNIVjF6Z2loUko4L3lvNDZKUmJBSjJUdXo0VUtQWWtn?=
 =?utf-8?B?ZCtYSTQ1N0VpSThDUmdWU3VaUStZdVNNTHFxVU1vblpPZVRJUSs5S2pmOXFZ?=
 =?utf-8?B?WEptNWpIOHlESzdua1dBTjJ3Ync4L0k2YUNRTCtCRFNqVkNRSmlCdUhqM3hU?=
 =?utf-8?B?dGhmN1NpUDVKWE1oV2h1endQeVh2bU9rQzhRNm9VN0gvMmxONzR0ODRuR014?=
 =?utf-8?B?OCtKS0NwQWtkZzE0UFJQbFdRMWNFc3pXWURoUm51VHRzcUM1R0E4dzB4TWJ6?=
 =?utf-8?B?NUIyNTg0NCttMk91WERaODNCcGVlUWdSSzZleXo0ZkxTVk1yL2RtOFdxU2Vk?=
 =?utf-8?B?RjJTTzMrNzU5cjM5bVNKZThVaVZLMy9jdzFLVXV4MTBrd0ZWOUZGKzc1Slcx?=
 =?utf-8?B?SXFrNWtRS1ZnOUVKL1hzYmI2V3JYUGRyd1M5aEhteThMVGEyWWRuQmJnWkM3?=
 =?utf-8?B?TTFlR2pwSE5URXdrdzNWMitIWkFtL2hleTFXSjc1eXNDVEc0ZjlDTmN0VVlt?=
 =?utf-8?B?QWNobmVvSk51a0kvSzdVMGdJbVh0NVZvc2JWNm41WDBMaGRDUGllWWsxbnNm?=
 =?utf-8?B?UG5xNElWVGdRSUZxQ2ltSDNWd0tPc2IxZTloVU0vdnAxalV5SjFuL1ZXWDJr?=
 =?utf-8?B?dmMycWhUeUloRVZJRHpuTit3NmwyZWswVjNTbDczYkxkVUZnZFdEaTY0dkNx?=
 =?utf-8?B?SGVxY2poRHp2emp4Ylg1Z2tEQ1FFUEVSaVd3czV3dEdPSE03RGtZS0h0UjNU?=
 =?utf-8?B?citnQzJZaFluT2MrZ3lOWWZ1WjNIM3A3KzRkY0JkQnJGb3NTQWRjdVZJVE8z?=
 =?utf-8?B?a1E1NktkeXB6blRGWE1mWVNlMzg2UUNZTkdVQ0VDU1RmTkltc0hlQ2xJQ3Vr?=
 =?utf-8?B?Q0RYTkdhUXJlaEVoUk9MaE80bW83L1ZOMjUwdHRBaC9WQW1wQmgrODZHK2tq?=
 =?utf-8?B?QmVBR00xbGVvQXA3ZlRURGZSVFQ2SjkzbmRoeDIreUt5bmlybGtoSWZoaVBr?=
 =?utf-8?B?czNnMWlzSTNpZHJFSmgxWDJFMDZ5VkNWTkphL0c4ajFVa25HWGxPNmpNa0VE?=
 =?utf-8?B?TWtLdmh0TUE3K1U5OGg1T3lBbktad0ZQMm0xZUYrdm1NcnpnaEZPUEttZmpN?=
 =?utf-8?B?R1FlNmZJR3M4TlNVSkwxLzc0NDduSEpIYXZzK29tbnh3NTZFR3Nvd2w1ZGlZ?=
 =?utf-8?B?SUJSVU1WUWFIT1lmamU5ekx1a0pLMGs1TU1Zb2V0U1hYSnArN3paTmJKUlV5?=
 =?utf-8?B?MDgrYUhPMStHSWFxYkt0SUJ0cnNjZFRpZEx2dWRvVytHS205Tk9TMFJ4dnVu?=
 =?utf-8?B?ZmpQc3h1R2k3L3Fhbk5zUmxBOU5OY0RCMWZpNUw4NVFHK2gyTGJnS3JTNGU5?=
 =?utf-8?B?K0pEN2VPTDF5MGJGallLeExpRXJpcjB0clZ1MjRhcU9YakJqTUZONmdSbWl2?=
 =?utf-8?B?VndlZ1ZycWUvSXo4bHR0R1BSaVg2ekhGbzZVNUZVdnBsSDBkekVIZWlKS1gx?=
 =?utf-8?B?MDN0RjBpTHNOSmkzek1BQ2ExbXN3bkRwb010QlR1L3F6L0lIRFRjS3JHRjhr?=
 =?utf-8?B?L1lJcW56OXRmY2hMdE85ZnE1YUVCVjRmeGFJZUZEbDlDN2NWTFJHakZpbzBv?=
 =?utf-8?B?V21RZFdMeHQzZGxMMDV5QVNwTTMvV01SNkIyRUpDL29CYjBteXhTK0c5VldY?=
 =?utf-8?B?SW9lc1VPdm1pL0JKemdWVHYzdS8yV01qeUlIUXUxaGhLdjVONU9VSFBwY0FB?=
 =?utf-8?Q?ET2yGk3U/ZpSCWai7CKG9hZLN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a73282bc-0229-4e11-7109-08dbffec2255
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 17:09:45.8488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eEc5CNDgDT+DgG8Y7cFzzzxXsivKNtOQccaGuL8dg5b+C59vQ//5S+gWm3ak2w2eRXVu7yNMo/YsPrbqUGwh4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6624

Hi,

On 12/18/2023 11:01, Jonathan Corbet wrote:
> Carlos Bilbao <carlos.bilbao@amd.com> writes:
> 
>> Jon, Avadhut has helped me so much this last year. I would like to ask you
>> to review the patch below so we can include him as reviewer of the
>> Spanish translations of documentation. Sending separately too.
> 
> Happy to add a reviewer!  Avadhut, if you could send an ack to the
> separate patch adding you, I'll apply it forthwith.
> 

Have acked the patch.

> Thanks,
> 
> jon

-- 
Thanks,
Avadhut Naik

