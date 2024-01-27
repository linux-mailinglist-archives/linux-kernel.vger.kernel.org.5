Return-Path: <linux-kernel+bounces-41081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4198983EB7B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 07:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ACE7B23E69
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 06:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30421D52B;
	Sat, 27 Jan 2024 06:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N1wY0Wzw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZSNZdxfd"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234791DFC4;
	Sat, 27 Jan 2024 06:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706337794; cv=fail; b=cGcvz8un1/9LpWrXDDx8NZ9bY1kBf9GDRKGxC3wvHa54kudYqiO2o5C+QxL5RYJC8grJuTkyN+VpjOJzfIqwYYgPvjclAEV4yKa4uvyZqiNyWThGkKyf2snCe6RFqrfzX6/9dabS5/Fzy0r8XynxZk+ynLIhtau5bw0bmGJA9BU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706337794; c=relaxed/simple;
	bh=uhGLcIPdxI7efdE0jOrxVmgGjHSYp2NvaGWnFLfJbys=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=upJWAhWec1Da7NeL7UIl19fCyEn4LFZQsFCfq+a5YW25e6+7IhC7jxsUf/jRRUibGlAKd3hHtdCcNdQ6kDZaCfEC5SE2ZTfqhRabOepYMsxSQUBtZ24kz2ya3stgSt6TQIk04k069189r1qgKwQEfm/hyznK0uup/4mOLU2rfG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N1wY0Wzw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZSNZdxfd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40R4hw8R005317;
	Sat, 27 Jan 2024 06:42:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=V/kbai+zGAMxcamrvrhNej9s2GsaZowyZnavorlDgwo=;
 b=N1wY0WzwOF8g7Aa5uk/5hKZ0gzHyl5Z8sKdKpBXsQ8RWkkvJsMlm4arz83MXr0qHQsel
 6qyn5nxMKA6qjH91l/R2Zf21PHv/0+OMzMAw9okgPm5NA8dumKgTKjrgL03Pn7LQPxy6
 TqRdRnoioh8nDFmMxQJq5JEbfphICt9NZpWnW3efJ55MhvtBtYdMTDT7ZUSredY85wp8
 gUUrxksUzb3PYvSvPEDXtkxb2epdo3ffxpxmj2/Lce9L+bj5EPB5Ht+24FKORUziQGu8
 X7oObVapfUnIwbjRdRQGMt/JEU09iXOo0r+BNmjYXotS0pNO1kL/6BIK03Q6+KItm+ft bA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvseu859b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jan 2024 06:42:33 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40R5KiVF031380;
	Sat, 27 Jan 2024 06:42:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr93wrb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jan 2024 06:42:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Twz2x+wuF6Mqhu8UIp6/XL/ybNNW8v4jGhqi511rnx3gm4/czQ1zm5c00aQAalVQg8idnZ5Ek7bVkmBWTDeG9OtEbE+XenUBP6lgz/uzgJSx8wgZqiA5CTpYsZHHbOTu7nKr5DdMWzF3h1za8FBVecBOQANYIGi3lJ9l9SXdbIDk28UC4Uci/ANswoBpgWPnxwWBO/7f/oLFuYLYVDtc6eZNa9/oyclX7vFnWkt8NhWa7eS7JbzP/LR4gpGNyT7FjqVlQkSxRDP+HLg6GUzKiW982PoRtAg/T4jjdrtc66gKB5b8QoN7AU60xrTIJIMcL3jMO/U80thDM/CVKsejKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/kbai+zGAMxcamrvrhNej9s2GsaZowyZnavorlDgwo=;
 b=JCUlpLL+3D87Q83T/cwndghDSI69h6ON9b+YRzz+BEuhuTXg9B+2aVZyta1mSKIIAo7SabDYRfxv6bZiEv6TSJPLRkM8dX9DkOdsKX+SAomLiVeEf1F7bC7tIPJLa9R9dGYZNglw5PdYqG9vUJrMiToNh4UJ23hRG1T3M63Bn/7ogdcs1L6A0YhM0DHBAlyyk/JHp11CnPC8j6cqwYkhDBeNWsP9g+CE+Lh0sHJ1+VpxghpKn9uqk+O0pWzPN+TrKBB0BzbbgUEtZUugQowjftnsSjD9j4RT17ynKSTwPVOm6PdXYV3N72V/pV59Y8CEChOm8l+sCATDMLVzeqeJag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/kbai+zGAMxcamrvrhNej9s2GsaZowyZnavorlDgwo=;
 b=ZSNZdxfdGLA1EFEX67zvLwswXaYwoQHX42FsO1HQnayarduCrBiQjyTLI5Dbk1LvU3cgb4OJ8z23IOqN8sLykr82pxMKO46HSI9rDC7GFeMvcRVYNOC65fUUOCQDH+kmkWw9GsjfDXG/M5D+lvkh7aa3WdgX2Uhaiq0yZ9c0B7M=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by DS0PR10MB7051.namprd10.prod.outlook.com (2603:10b6:8:147::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.28; Sat, 27 Jan
 2024 06:42:30 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5%4]) with mapi id 15.20.7228.022; Sat, 27 Jan 2024
 06:42:30 +0000
Message-ID: <472d92aa-1b49-43c9-a91f-80dfc8f25ad3@oracle.com>
Date: Sat, 27 Jan 2024 12:12:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] smb: client: fix "df: Resource temporarily
 unavailable" on 5.10 stable kernel
Content-Language: en-US
To: kovalev@altlinux.org, Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, keescook@chromium.org,
        sfrench@samba.org, corbet@lwn.net, natechancellor@gmail.com,
        ndesaulniers@google.com, "pc@manguebit.com" <pc@manguebit.com>,
        "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20240126193143.245122-1-kovalev@altlinux.org>
 <2024012613-woozy-exhume-7b9d@gregkh>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <2024012613-woozy-exhume-7b9d@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0366.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::6) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|DS0PR10MB7051:EE_
X-MS-Office365-Filtering-Correlation-Id: ace35667-5308-4f13-0cf1-08dc1f032223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+sxeB3Byl15K2MctF0bOuFHlkvOySADZLPw46JMeUL0KOBBj9buLnF9BIzo+YyC2XhSk8Gdj85gRs80U+GFAhJ+PnpdMCJKGijP0LY8dr19QxkZ9FgqV+TM541wlt0EsHxEgvMZj7gl8UQ2WV6ak5D8CfhyEMSLJB+IudN+O6W2Z8EOzExyJuw9HaPPoi02ms/T0dnbYt+/fxq6APRjB8PTigvDQ4jW97IemE9/ZJFDKUd6feKHEOj7LNYhMXCY8I+a0xhI87+KN9xKTJEForz0Ylo1r9Gc09s3FSLa+GlxNdr8UfrL8yE8EZ0ENExxkFUdNVb8Zd9r26BKTbbl+Myej0LzoWWUUP2SJgXpc7j26RYnYDpMhginBRiEx0uBKTJPY3ECxFJ5buvb5+umTEdHO5jAPfnLojhG7dJ++ufdcsHvge4sg/VrHafc8SrYKYOyHx+dVAX+auEtrbQP2QVrQCVEnr/x9/ajI1J+L1RDSY8jF16DFUwxxGdZR0Dtut2WzGPi0qlT1h1yyMp9eFSXGumoUaTSSnYkiSHEL5KBcv2BiJqGBnXuyL8zR8981RTei6hvUjVjimswxIRlCkoLRyuVQ3Qc1YYvrCwkgjyU5ZNYh4ONwlzC0nLgiRpiGgaMQXfeNmQfgP+Efxrt1zw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(346002)(366004)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(7416002)(5660300002)(2906002)(36756003)(41300700001)(6512007)(2616005)(86362001)(31696002)(6666004)(53546011)(6506007)(107886003)(26005)(66476007)(66556008)(66946007)(54906003)(316002)(6916009)(478600001)(966005)(31686004)(38100700002)(6486002)(8936002)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?THdoRlBZWHJ1NVExaVJxUHlOUi9QZWVpaEN4cUdXSTdiK25WUlNrbzJLNDNM?=
 =?utf-8?B?cXlrV29kRTRHdVQ3dHdXM1hOZ082eWkrQnU1aVFsemhJQzBKbWMyUVVBb09h?=
 =?utf-8?B?MmF1R1VNRVBDKzdQNFlZbmtMNk5xWDR4Q3JTMVZFTmw2NVR3MXdlby8weVhL?=
 =?utf-8?B?UHFTdVJFdmRoejhCRnhLcG5MblV2NnJNUHVKN1prbWdNRU1sdVBQVUFIZlYz?=
 =?utf-8?B?NWwvdUlOY21MK0t0MmxLak1WQzlmR3BsVmgwc0JRY1BLYlB1eUJXSWQ1UXNB?=
 =?utf-8?B?WkIweCs0UDNPY0dGclR2ODBhWERvYno0bDl6bFNzQzVsUGk0KzMxVXV3QU05?=
 =?utf-8?B?cHdqT0tJSVBXSVpHWlZBa0J5OEM5YzQ1UXU3SzIrYTdxcEg4djJVQUVwQnpR?=
 =?utf-8?B?UlhCSkV0UnRhc3U1L3MzbnRRV3F4dkQ2T3RyYUNYOUF2SnZLa1Uzb1BMMEFo?=
 =?utf-8?B?UDJLTEd6Y09jSzB3ZTBCNXRaOVZaenNxQlg4OTRtb1VQOFNlU0RlL0ZxL25p?=
 =?utf-8?B?MmNOVW1weW5TMVBsdkRzV20rQkdCMlVPV2RwdjUyTG91TXMydGtPSjZsdDd3?=
 =?utf-8?B?dkVrMU03YW9mRWJDbnJrRW5YbW1pZ0lUeGR5ejVkblZlOHZhdGRBd0pnRlhk?=
 =?utf-8?B?V1hNeG1TdGZJUzFLOUorVzBVZzVXSlIrTzF1WnN3QU1tZW4rUkJuZFFZcm9r?=
 =?utf-8?B?RUR2OVJhZUNoRmhTVzV0ajFxQm5SQnRmNHJVWlpqWlN4bjkwUzNlQ0Z1MVlr?=
 =?utf-8?B?ajZDZHArWHY4Zm9LWUVoUDZkdG9BY3JVWmRsQ0ZMdmxRZlhYeVFXeXVJNUl1?=
 =?utf-8?B?YS9pQkpYUmJpdlpxTFNXU3BRZkpsajNLN1JjRkNLMlRTazFDTzB1cU5xak1a?=
 =?utf-8?B?clBKalc3Q0g5SjVJVnk1SlFWZDk4VzZFc0tjR01iTkxaTDdpQXgxSTBNYUNN?=
 =?utf-8?B?SDdOS2krOHJNejNsOFZ3RDlma0F5VUNMYUFpQTE2Uno5TndUeFNXRW45NUps?=
 =?utf-8?B?azFPZXA3Nm9Xb0U2S2Z1a2RHSnIxUysyUWRxTEdTOHFmTTBkZURqeEFTRlh5?=
 =?utf-8?B?dWNKc294di9tcVJSOE9DendwNDNFY1hLcStvVGJQUGFlQTFuNVZjamd1TWxV?=
 =?utf-8?B?R0dtaVRmVURQaFIyQmxhbkd3MXdVb01peENjSGpnM3pkYWI1N2dFRjl3Q3Nm?=
 =?utf-8?B?T3FtRFQ3ZGMyL21LdXVSRzk4MGh6bTNVY3dCZTIvdkVSQ2owZGF5ZUZXc0cv?=
 =?utf-8?B?K3M3amVkNnJ4dWxPa2ZwbHJWRU80MFR2ZS9QYXU3cHRZWFNCVWlJVS9PN1Mw?=
 =?utf-8?B?MGlOQjVDM1JocGs1UE1VdTVHMTY5enROaFZQYTUrUk9UZnE3S1B0VVRFbmhK?=
 =?utf-8?B?N3NpZ1FZS25UU21odlZKMFJmMmRKakF3T0JkTk1udGJEcDdiaXdPbXN2MDVU?=
 =?utf-8?B?M0VDU0k4ZUFKeXFLV3FFS1NTOVVVOWU4ZnlZT21PUDY0M09pc0lPYlgxLytD?=
 =?utf-8?B?ZlphZWFUZ0Q3Yy9zSUtCN3RvSGpyQjRhdkt6RnB1aG1hTlYydk4rWTROVCtO?=
 =?utf-8?B?d09jSGxKTThjVDJhUnUzcW9wcnpGalNpamcrZm5ZSG9ybWtaZzg3R1lvT29k?=
 =?utf-8?B?SVpiWTFDWVJqSFU5b0IwYjltcllDNW1XNndMSFo3a1JZK1MxaUt4dzNXaVBk?=
 =?utf-8?B?MXZnT3VBY0VKSU10K2N1bWFNeHh5dXY5ai9VWWVVeDUzQ2tBU3htT29LNGdx?=
 =?utf-8?B?c3hqMkdHUHoxSnp2QnlzcW9qSWdRaTBiNldkb0RxMG1HbGpheTNRekJLU2d6?=
 =?utf-8?B?aDJGWSs0QmtMUW5BeERGVmZoNm5GL0tTR2VnQ3NyUjB0YVd2dHRhbWNHRTl6?=
 =?utf-8?B?S2dtS1RIU1JQNjV5K3Z5Tm1VL0gxZUdIR0RnVWZla1l5eXVpd2ZvYng5bk05?=
 =?utf-8?B?ZUpkMkZqdjZJV1RObEVIVlF0R09yWlNDMGl3Z1UrVEFMVlM5SjJtN05sOGFF?=
 =?utf-8?B?QnJTY0VRSE92SlhDU09JdExMdUlHaFdRQXREdUUzRTdmZkhXd2hjTCs3WWE2?=
 =?utf-8?B?WmVHdzl6S0RqR2NXR3BBSW1GbUdOSTY5WkhhdHFNZTNDUVpWQ0JubDlYRm9T?=
 =?utf-8?B?cGFBRy9CN0dWZnJlRXBZTmtWb1lmZkNpb2ZhaWZmeGV2TDhkUzlSUDh3Y0t6?=
 =?utf-8?Q?C98gRWb6tZBHTzFNIX1kEnU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	aVYW3lWYmQpseIuVfbO3IKhmLXhecZf+uOyVpd944QiWJGeyHauuZI59Vay4QiDuSFOLaL6so88ikvjV4GKbgPptCs++AImXGxL9jau9n8W3fHyG45trN095ixl3mWJAFMVVEDmHO6+++L9lCXejb4UGhCai4eQHOvyTWsL56ffQSxG3bVHeFED7pvJL5nHcId99Z0hy3O2kr6tXQGdHhQ9mmwrr7ObERFbsYrN/d05qetEUYDyLAaSBWiusqrILGQuDKhgZK7Dm4WX5AOv2oZ7+JgmHXfjNczZMClBs4FN/8KYOBH7/xBzzf/oE5G6HZHiTtfizZs/Bk45IoWS56mZ70gD29tvTErRZBq6XHDY4DyPFrB2RjaTA9pKgIQ3+s5tpGlQBgBYqZZuaqB4u9C20ydYLVv6BWDz1F5IKdLQk+/nWwv1set2Rzg66THG6U161eDLm5VwOS6C5P39qJe4at2JUj0bZvAqSp4ETujSLE63ujCp8O4XYBur79aXnFjtfnOar88JUFnAnYZe15opI28qotKtrWeyl17PLqGeUTrwMXhYGJl3dbV/krb0jxsBcv+003tb9JbE1iAvnCDsZGfQSuTgNtMHxxjl7cDA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ace35667-5308-4f13-0cf1-08dc1f032223
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2024 06:42:30.0688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/TkUi02sigyCjjJs/Eyggr8cuajUZQJL//fY43RCgsjQKhIbq1BJazNrsTUsYwXZoon/GBbaLrHjzMtmDgfKv4oaZN9jBrgmLopRP//VrAKdCFt0LPgxyLzEuLMRSRD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7051
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401270049
X-Proofpoint-ORIG-GUID: 7VnGMP38MIj9s6Zg7Ep3dbdHgUBE0llq
X-Proofpoint-GUID: 7VnGMP38MIj9s6Zg7Ep3dbdHgUBE0llq

Hi,

Adding more people to CC.(who have looked at this issue)

On 27/01/24 6:19 am, Greg KH wrote:
> On Fri, Jan 26, 2024 at 10:31:41PM +0300, kovalev@altlinux.org wrote:
>> After mounting a remote cifs resource, it becomes unavailable:
>> df: /mnt/sambashare: Resource temporarily unavailable
>>
>> It was tested on the following Linux kernels:
>> Linux altlinux 5.10.208-std-def-alt1
>> Linux fedora 5.10.208-200.el8.x86_64
>>
>> The error appeared starting from kernel 5.10.206 after adding
>> the commit [1] "smb: client: fix OOB in SMB2_query_info_init()",
>> in which the buffer length increases by 1 as a result of changes:
>> ...
>> -      iov[0].iov_len = total_len - 1 + input_len;
>> +      iov[0].iov_len = len;
>> ...
>>

We can reproduce this on 5.15.148(latest 5.15.y) and Mohamed reported 
this on 6.1.y, so we need backports there as well.

https://lore.kernel.org/all/09738f0f-53a2-43f1-a09d-a2bef48e1344@oracle.com/


[root@vm1 xfstests-dev]# ./check -g quick -s smb3
TEST_DEV=//<SERVER_IP>/TEST is mounted but not a type cifs filesystem
[root@vm1 xfstests-dev]# df
df: /mnt/test: Resource temporarily unavailable


This two patch series doesn't cleanly apply to 5.15.y.

Also I am unsure, which is the better approach to go with

Approach 1 - suggested by Paulo:
https://lore.kernel.org/all/446860c571d0699ed664175262a9e84b@manguebit.com/

Approach 2 - this series
Pulling in [PATCH 2/2] smb3: Replace smb2pdu 1-element arrays with 
flex-arrays like this series did.

I think approach 1 is better as the changes are minimal, but please 
correct me if that seems wrong.

Thanks,
Harshit
>> [1] https://patchwork.kernel.org/project/cifs-client/patch/20231213152557.6634-2-pc@manguebit.com/
>>
>> Error fixed by backported commits in next two patches  adapted for the 5.10 kernel:
>>
>> [PATCH 1/2] stddef: Introduce DECLARE_FLEX_ARRAY() helper
>> [PATCH 2/2] smb3: Replace smb2pdu 1-element arrays with flex-arrays
>>
>>
> 
> Now queued up, thanks.
> 
> greg k-h
> 


