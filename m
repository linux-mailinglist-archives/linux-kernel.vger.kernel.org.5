Return-Path: <linux-kernel+bounces-29420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B32C830E00
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A78A1F23D26
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D6F2554C;
	Wed, 17 Jan 2024 20:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fYU+69L0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nWmfRrxE"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A9A25542
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 20:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705523498; cv=fail; b=uu4b/wdZ/m4xP2dTWnpP5QAFbM0Wytwfihctcc2ypSO0i8X7bXqZ/KpvS0uD0a3s4rp4MONhj6sY1vy5DrNC//pYaxr46yxGH2f5VTJ82OnLWlMP/cezj0KRVisMK/N7DO73PtHB3auk8gXJi1ieP2/aSsOfJfY2ESF1eCj7KvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705523498; c=relaxed/simple;
	bh=TAN9YLv8CyKW1JbMuXIje7NiFACs1uU3wY3cqHW9L5k=;
	h=Received:DKIM-Signature:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID; b=Gn5elxNsgSNewAoDR6ixY0KHIONmDFuvKcDm/oRclQJxx2T9j9g5bPLEhJifjuQUTUQp331vO3KY2zs1Vt0wTtlJsEUDRnH2nJZpDy+TysL4Fh5ptk3uiCRVaFjFIqh3PiJ4XUEooFlU4iGHVNVNml/YFn0sDTjXn5i/28mNrQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fYU+69L0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nWmfRrxE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40HJctTT027955;
	Wed, 17 Jan 2024 20:31:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=tWlVWQW8Fga4CVZVEJQsWLzdMu9GJdPXkZtRQGxPPiA=;
 b=fYU+69L0EiLsDLHWJaoAwe7GUKhcaolFUQWQH8Nz2xPULKzuuWcE/zT5oRl0DjSXso7q
 kBby5rfes2EI+7SZ7h4ap+vDdTuPcqcm8skwjZIOrRaB0C2cRIhm+HuM8tiMuvmdh2ZW
 F+0CrSv0K3qfUS5yMjl39PyvLnJOzxbu8WHbOrYSRys0fRctahKPm+DFjZtsz34FMtC1
 3lOuwLmOyMUqEawXCRKcp05DzOEiHno+5x9xTnp1kMbuB1ywutFmE+DuGcAShZKwCkZC
 0UQNE1aysA/rBEhusnzCGIQ4CDHNEN25Qq0d/d7nYqDYZOpRt2x8m56y5835oQhq1k6V fQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vknu9rk4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 20:31:22 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40HKL0mP005115;
	Wed, 17 Jan 2024 20:31:21 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgyh3ewp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 20:31:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmdk74GExFmgSjFb7hMYD3tm7W/tjMMl7eDHEgJfGCc9v7SB1ttRn1fEDcyF0DTN0XV4QjHRLSUzmcsndlGIDiBITnJU3VTLy9qh4/neSY14D+qAfdy3hXKZPRsRvG1dBXmCKjOM2n1nV/gztPiT2JWFShBOYpXXkNUkR65HNsTp1OuFTQ7LIZ5NreJt2tW4ysgqxycpDFtBF7F9Q6Vq6LG3A+7R0IB0bk4HOIegwv0Sz0y2AUoGsy3+jG8gqBuQct17nKYNOq2cwe35WxnwuObJuxTou/G/ipaYg3ePSNcph5sSPb5YuPI0bai5c24G+xa1ddeLE6iQrPiklZ7J8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWlVWQW8Fga4CVZVEJQsWLzdMu9GJdPXkZtRQGxPPiA=;
 b=iqZ4SF0xAlTb3KwwRzAdW+w+9YSQRhD3hxMHdMx4RwAvTJ570wOmiM0QBAxCfEWPkSLRZuAEVk5nIRGsyln4DnS1Qns8/+u2zSvn4oagJpoJ+1PMsbYAE6Iin/dHr2KEVM7HnodEoJErxWgGsff94b+aj5DHhNvLlpr8Orh/1Cd2Is04E/VDGImsDWJ7E+pSfGgFwYq/ep3DbCRXE11iGZZZniLCSYg+/JOQ2qNZZ+S1OrbT98INxi5UA9eGtCmQOlFTqN/UpMukQ1Qrx8wu8xODRcb7lESqHstqnA4GbV3HQn8LozrPwMD3XEqw2aQNnMZhAa0NKFyibX2gvu0C/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWlVWQW8Fga4CVZVEJQsWLzdMu9GJdPXkZtRQGxPPiA=;
 b=nWmfRrxE16QsaFgPJshoJtEqA8OEiwKC3o6fZrtRNAu6hbR0apxwhTPU6+3Xf+Ksm67myPIF9V3AuczRzy3uEe4RE6y0sAFEHLQzeSltHbGLwb/4O3mtwjvROlMhzYC/kTPek57SHSm2jJN5Y8mcai6W6Ao/VaZ4A3qJThJMlR4=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by DM4PR10MB5942.namprd10.prod.outlook.com (2603:10b6:8:a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Wed, 17 Jan
 2024 20:31:19 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7181.026; Wed, 17 Jan 2024
 20:31:19 +0000
Message-ID: <3c417ae0-16af-4c63-aca7-6f4a7578cb04@oracle.com>
Date: Wed, 17 Jan 2024 15:31:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 08/13] vduse: flush workers on suspend
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dragos Tatulea
 <dtatulea@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        Xie Yongji <xieyongji@bytedance.com>
References: <1704919215-91319-1-git-send-email-steven.sistare@oracle.com>
 <1704919215-91319-9-git-send-email-steven.sistare@oracle.com>
 <CACGkMEuJ4yf4reW2SzDqgNZGBWo5Rcqeg+cFS=N7pa_gQmmDXg@mail.gmail.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEuJ4yf4reW2SzDqgNZGBWo5Rcqeg+cFS=N7pa_gQmmDXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0269.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::34) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|DM4PR10MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: e3e3aa92-5cd4-4217-0f65-08dc179b42d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	XMswhNLwPqmU1T1jy9aYj4CbVJMtzOdsv9tIBiLoqwkgxAuSwwpv8LAIU9WrqqRbBef+LJziQbSnAs4H2wBLZPVYq6T8IaPt/u4G9QsFWmgSnngmYsOdceZICy4WWhUQMiAA8oV+KVZ18IajHN55zPsUtEVeHQH7oFyEEHfi88Zq1kKvD6ZzTGrB1myZt7cgSpgmAHH8ifsKF2qm/5J0kijEXlHtpM6S2RccsAV4zBGV/VAMxZN3qBu9PHKJHRaLP43oIK+Ofn8mVByRXLZXSQGNhFXyrRpak2YxMSbvEg7PFMuRLlOGTf9F1t+qvViHMq8X1fG1mMYFuc/rypqEBm4VoHRnLuY9Akm5YEus4Qj8lBkJT6aooHBbe8DNxkOgCRSfIaxq1U8G6Cy/xycy9vYO2joHo5M/NHXuZoBdeI6HGEZ2go73mcUTAUqXXgCDScU1HNXUymbEVsWSnDaaKiKjp4QKq94/RkImyzkiP41zWyBcweIxUUqJc49kfE1hoqSIgmbkScl63QM8tKCueYYkbRlr0PS+9aBdgg6yY08qYhscA8/BuTirCeZxonXwz2KWcN3YiVuHKF+BIcPD6xWGJtbmxHhU9560+86Bmf4srvSerRCdancQi5SGrKExTl0KpOzIdXBgFFzLPwM+OA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4684.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(346002)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(44832011)(8936002)(4326008)(31696002)(5660300002)(15650500001)(8676002)(316002)(6916009)(86362001)(4744005)(6486002)(66946007)(66476007)(66556008)(36756003)(478600001)(26005)(6666004)(53546011)(6512007)(54906003)(2906002)(36916002)(2616005)(6506007)(83380400001)(38100700002)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z2RiTnNJc1cyQmloNU1RNDhzSlJuMElIcnNBYzFER3M3akZGMlRXWUdOZjJn?=
 =?utf-8?B?QkQwTXRWcHVpTUlnMTc3QkltYWtGZEVmKzJBNzBxV3Z2MThaaGRWZi9KR2p2?=
 =?utf-8?B?LzUzVmg4YzBPWlpQR2lzb21NUFd1NDRmd0V1cm42S2p4SWxDTWxmaXV2b3Zy?=
 =?utf-8?B?WjNZRnZ4WlBSRDZRdXp4M1BPTUo3byt0b05zcUhLRE5MaHBub2trbmR4YXdZ?=
 =?utf-8?B?UXdtaXlsbFRzSVA0WW1JV0hkYXd0cWpTTVl4L3RCT0lBZHpuSklVTmltaThO?=
 =?utf-8?B?QXlIWEJKZFlaY2k0OTVaSVFub2t3dVkwbmZZYzZQb1E3dHNuNllhWXJsanRq?=
 =?utf-8?B?Tndaazd3NlhQM0g1Q21TWExoZmFmUTBnaEFZdnZBMHd4RDZiUzI4dnJRbk9l?=
 =?utf-8?B?T3JhRnVzMzYwU2dZSmNjZjVWVSszcERSVEYvTjJJcGdhbWlvaTFUZ29xMjJo?=
 =?utf-8?B?SWFPSCt1VlNuT2x5M3l1SzFZNTA3aXM3L05qVFUyU1Z2NG5wSHlHTjI0VUxC?=
 =?utf-8?B?UlEyYlIzNEZQY2k3VDBlYisvdXlkeHpCYjNaOUJjVTVoZUtReFBIRHlQSy9V?=
 =?utf-8?B?K2k4Szl4cC9LUFBDZzVMQzVOM3BvdFpkM1ZrRjlnbTY0dWRIZ1RMOURZVFdz?=
 =?utf-8?B?S3UwOWE2ay9mUkxmNkdxWUVOMnhMazduSUh2aFNSUXdUeFhUZmZRL0hGZkkv?=
 =?utf-8?B?U0E4NGwzMnZwYWttUnJmbWVzMElRVG5KK0lFNEhpVG5Ld2xrdU5ESWFPY1Fi?=
 =?utf-8?B?OU84Ly9WcUJ4Q2E0SUVydDhWWjVDWDdVaEhROHAvYUczbE82c2JNOUN3OFIw?=
 =?utf-8?B?bmRPWkdyWE4yUWUrM1ZGRS94V2gxN0tBVlpySjJTZ1IwOVRBVk1WOFQwUklZ?=
 =?utf-8?B?OTFGYm9WUXhmbGRrTW1oSkNnVUQzQ24yMU1NMmxyMStHS2JDTU1MNGJDYTd5?=
 =?utf-8?B?WUFMOE5GS3d3cklxUmF4L05jQ1IrTE5Seit1ZFZ6VkV1bjZSREFUaXROQVZT?=
 =?utf-8?B?eHcvSGh5U0piUXM2b21QUFBVOHRsL05vUUpHWmVRWnI3Znh2andnQVZWdnZv?=
 =?utf-8?B?Y2ZzYk81ZUlCYjM3Q2c2a1k5OGwxeGhIVEJxUi9lTnU1VklKZkRUcks1SXdw?=
 =?utf-8?B?U0xkNE4yK3MzeHIydUNNRlRBRkpOZlFzak5udy9iQXQxRFlpZWk0MjJsUHAx?=
 =?utf-8?B?R0I0YzJWY0lvSFFieWJ0QTlwSWFZekt4Q3FkaXloaWtjODdjN29vT2dNNkpt?=
 =?utf-8?B?bnlWbi8xM3IyTFptb2VRVm9uYWErclVML3lsa0VBTFRteVluVVRDeUtFQ3lL?=
 =?utf-8?B?bTMyZzF1YkNjTkFJWjk3cjJ4c2ROWTdUckhuRUFUa2YwZXRZMnFsdmdyTHg5?=
 =?utf-8?B?YjkwWUZyZys3eWpoSlhZV29COXpzcnVZc0NwWkE2R2JNMDJyeGpQSlpWZTBF?=
 =?utf-8?B?VE9SOG0zYWRIRk9PWWlVRkpmdEZ4eGFTRkFnaHNiNkl5YWhLVElNWWtrbFFv?=
 =?utf-8?B?dzBiYkJFb2srZm5jTzFLT2hrTTdOWDJtdmpFRVVBQzR5TkV2Zlo0RnlyaTl6?=
 =?utf-8?B?Q3daUFhWZGdUZDdZMTJyZTFVOWJ4YlNacjl6RlB6WVFYUGJuVytCK3JaYjFX?=
 =?utf-8?B?bWJYTDBaNEtFcndYVGdjaXBhY0ttVFFzbG9OUG1oNUplR2cvTUYwaWdjeUlS?=
 =?utf-8?B?dytrNFl5U1YzamZ6enJreUN3dHZrMU5EVFFwaWtqMHhnaUpjMDhFa1lha1FD?=
 =?utf-8?B?dWJGSmtjeFZ4bmp3dFEzdm5NUjZ3RTZ6L3FGbUdPQ2FLRmdyYzBoTFQ0QVdw?=
 =?utf-8?B?OFdxd0tVSEJ6WitvK2NKUTk3Y2lER2pKZEJzM0JNdlVjN3ljWnk3MnBvb05n?=
 =?utf-8?B?NWpjTG5VcXBvYXlNY1ZkMDlNL01STm9hL2VRRDhnNTZ6U1prd1lZNDdWQ3FD?=
 =?utf-8?B?NENVMmdlOUZlckt1QlJKZEFhdkFka1c3dTYvVDNHQ1pZTnNOWUpxZnc1cUYy?=
 =?utf-8?B?OXRCc3MzWWY0cXgxeTlzbHlVdUN5elgwNVNQVVlzOXhkT1ZDVEVYN3FCNEZh?=
 =?utf-8?B?d1hmVC8wUjFIak94TzFpc1BLNU5PQTJVYmxyWDZSb09FUUVIeFdYMHFDb0Ru?=
 =?utf-8?B?QS9pbk9Ld25YcnR1N3dUWHl6YklOZVBRVTVlZkxSbkczRVNlb1pWWjFHQTVt?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	OXOIHnsBnO8g4Wj2yzm3RtUND2QGHuojIGtW5yTlOz0xFIiK3exqu0zgXz83vsPVR7DZRyaSl7PsLkGBOScVP7dErzuqjY/LG9yiBnczZisseMzBJnAqmhfNQ5DlvW2+w/j7r7qP5kXFYzW3tCsBryszyljD2lKoqA9GgED5XPXWnuZqVuUJbwoJhuYt2fBj9PL0LLnWDUpJYbOzO3p/25WCQXuy1ys1Gzsbh/uYAxN69+eQfc9XDhSdj+Qf9f/OsyH8kW89yMOsWwLgAFP0vDn9kn0NE5mZMf7KA8PVcQZpO8NBdA9VAvuwJYaaU8dkP23vX4q0movypWeyQe/dI2sqzBugInpni/k36hqZrHcNHfnJ1rPt2xKc605Ed4SSRAsOSASSLDZxaEKloOrRfbwAD3Nb0MHW/hHne5LSTyKQqutUuL6cC4BPUSnjiWAsk9k91vL1VDzPVl0J7uJRO4yxCTUOkptXGZMqDvEQOQPiZSX/zZ/JU6U6oZ4M7cn/NDq8rBi/1zFs5O6RUAerMWypAa7iC19BOokpyqVZbbzNzPoOwmC+0ePiSQwwgr74QKH3cUAuU86DOGclJKwpcFNZkk8tMz4Lfr7GEKY5+vQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e3aa92-5cd4-4217-0f65-08dc179b42d5
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 20:31:18.9434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N3LUjHy82Tzn3RPBTnqls09ddtZGiJYEbK7UY35aHOzlFNjFDH8feXZFgSUzW1i6AhR3xrjHcBdwujk6h1x/uiKOLDY4Rd1kPY/amJnksI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5942
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_12,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=888 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401170150
X-Proofpoint-ORIG-GUID: TGF9nf1mguWDtVvZy_QhIyJ6DzMsKyVE
X-Proofpoint-GUID: TGF9nf1mguWDtVvZy_QhIyJ6DzMsKyVE

On 1/10/2024 10:09 PM, Jason Wang wrote:
> On Thu, Jan 11, 2024 at 4:40 AM Steve Sistare <steven.sistare@oracle.com> wrote:
>>
>> To pass ownership of a live vdpa device to a new process, the user
>> suspends the device, calls VHOST_NEW_OWNER to change the mm, and calls
>> VHOST_IOTLB_REMAP to change the user virtual addresses to match the new
>> mm.  Flush workers in suspend to guarantee that no worker sees the new
>> mm and old VA in between.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> It seems we need a better title, probably "suspend support for vduse"?
> And it looks better to be an separate patch.

Will do - steve


