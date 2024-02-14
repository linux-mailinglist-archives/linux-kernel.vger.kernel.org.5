Return-Path: <linux-kernel+bounces-65716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C708550C4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA45D28EE0A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58447126F34;
	Wed, 14 Feb 2024 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A+WOpF8b";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C+DX2Khu"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C718126F3B
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 17:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933055; cv=fail; b=b0YSiFHTU/2zt+eP/FWxGFwsqTTh9aBfaFSXET+HzsmfmeOxWcT+n/JL9OkZW8UR8jiFYwuGk0lCXE+bPDs1pb9S5/IvEOMHrPuC7+uCryUizzLNyDIWleAa0JuDCTE3R+kQPCq2FX13zWoICfnfEfFF0PaWle2KHoFEoSJOLWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933055; c=relaxed/simple;
	bh=WeUkSGp+20A2w4Hn7cT+oglL7QDYLF+kBEJ0ngFMxWM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FbUDfzRVo1xSCLPYl3zmxSIDEs+G3DqaoUf/yif4h2vKJ2CKt876Da9KXbOdpC/1GlVWCiVaOg+j0hJW36n0rshuwOX0HhaXpFQ6DMxMEd0a58Ia9AqmNyZ0s+dRPkbwSSAq5qRApiJnOIyvbadR1U+0/48tgvv+jVeMvxkSozU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A+WOpF8b; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C+DX2Khu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EHPVnX007117;
	Wed, 14 Feb 2024 17:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=mOi6NOdNBrTmngK6N2ZiUbQeyvZEKx0eSZly8iw7TCg=;
 b=A+WOpF8bPZ5k+aOBZffeOwQNPQhwiJkciNCjQxEnq6QdJgH+xu4C//2Kqc1stXeHFV2m
 8o0cre/p1IbuFcvhEIT9gTH/ILPWtdINhoD/WIN20hJVprKDDi2spGjm1dzJ+WQYsouK
 yTa+0x1EpE3emtleITfrFEiasBOFJzdnKAAhtuZ8gogXxW0a4Syc0npvIqFASZiGJSYi
 NIzwezb91lxhkKZY4mDLKytebi8ozNBwHG3nFZGQU0it5793s2X6hzvTwepGznI1q/vU
 bawEycqcsSfIHaKX+RGh/VmR90yuozwBO5z7LPvo8zL2aENL8vAn5zFFvrd1Byrvenr+ 9w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w91w6r2hd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 17:50:39 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41EGZ90A000601;
	Wed, 14 Feb 2024 17:50:38 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk9aff5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 17:50:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilp4rmC2/pgZXvHr6ps+UKaKt4sd9cFR5I7U7gFHZUuXL1vyrp26dJ5XbMrTRQ/o/UJ76E+CdMGNVCRkDxXrdBX9XIIC+UDS/v9nyEZfb8oFxOqZTtM6dcB9F9Gl6haunSW7ojaAmLLeLQNakjs0jA3h6RB3BuC/c+saErpaHHoHE1+31CqzhgUaXgnzTDARl3ws00UY4FCLgI1qMpZs4+4xr/DVI0QJv9B/0eC+mHNbVSH3VdKMBwEof/E9KqlbNqtNWHzBsVlWZncq7+y0zukuAJh1dIKZ7hStLWxzd9dl2vMU1itX+Ev8/w5w3DodAlSLzCeyaGYSbSnF3xDPtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOi6NOdNBrTmngK6N2ZiUbQeyvZEKx0eSZly8iw7TCg=;
 b=cDMCK861gTyLYxsweFJmtOHcipq30ghKaZOOeh5dcN4gwic2FyaE7fgF1PquUPjCqdYk3ZUBCk9j9NGPH0Do33rBjCX9Hz7k+awkYSM2pPeFVH2DnnpoddKqHvh6SbasF9sUooEnw02BpKdQhce2GkPmcChHAtqC+BPyvb8OSoKZK96xCBeGxmpiru7XbAgiCSPl7GnQv9h7TNHAaWT3mMYLs9HapQ+TtS14PdGorpM2qEhQNYpNFkT9dSAm219SiDFP9oAkXXlIlMTgIudF+w5f8kijB0xpMvY+Kl9XloNNY4tNkM1NDdGV7vKwdCBdLuLRnSgDk6SiuSnCHx5Uxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOi6NOdNBrTmngK6N2ZiUbQeyvZEKx0eSZly8iw7TCg=;
 b=C+DX2KhuqeDMVcRS0RWtTsyPPliA0iuz+4far+v6w62iuiyupCITG8R+sV/X47OQizRJ5nBHS6Qkwe/LDCciK5Ms1gNqFgLzqKXSdUHf3QmJzXfV2vvJyOf684UfStx7g5uUS2qTojl8Oz8lYl0Jg9Q3G6G90iQ3Bb+0thuThVw=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SJ0PR10MB5551.namprd10.prod.outlook.com (2603:10b6:a03:3d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Wed, 14 Feb
 2024 17:50:35 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7292.022; Wed, 14 Feb 2024
 17:50:35 +0000
Message-ID: <e1b80fee-30df-4733-9072-ce67e3edc72f@oracle.com>
Date: Wed, 14 Feb 2024 12:50:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/3] vdpa_sim: flush workers on suspend
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Stefano Garzarella <sgarzare@redhat.com>
References: <1707758174-142161-1-git-send-email-steven.sistare@oracle.com>
 <1707758174-142161-4-git-send-email-steven.sistare@oracle.com>
 <CAJaqyWfYHqf2=8BMo5ReKEB137fxGZR4XEJ2d4imXOOXAX2wHQ@mail.gmail.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWfYHqf2=8BMo5ReKEB137fxGZR4XEJ2d4imXOOXAX2wHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:254::28) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SJ0PR10MB5551:EE_
X-MS-Office365-Filtering-Correlation-Id: e54c1c7e-5a5a-40d5-4658-08dc2d857270
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Q51XxadJUyw32x5WjVlJhzzKGJ5kw2HFfsbkWLLNSxcv7SQpV9vjYd/2W0cM81ShjpO4ujNQK9Jb0uTir2MnGX2i6wQcT/Pf0HP7RZHbMm1M0Q1GuUTS5uipOx3bVqmG7MeZBroF6rG2mhfj7/mUFLn72pGDolFqFzEFBBF9HV6xCpLeNm/x4+BLTeyzYkfmJlaGjVN6aMt5ZCmox+NFMWoShIPIIzjPJdfCux2d3FQ1SZ8pWnR8tuzPZawn2fjvLogbfR0WG0Z9ablQyUlROixoIq+j5w81ycIrAenqcyPSXRAHzprZLckl086ECiW/lktSiwX0bwLNvUgx4IcRL8rVxd1363MQTTjQ4K4IqlqdbI5LmP0qMVo5vIs9u4iqzGLQ9EBQItpmbUDXhUvTCtK+F5C6kSuSJaEyJ9+OAysRi9wBfTQ5cVAY0cKox+rc8LsK/vD9UUUqnRr9pViclP+XaayeD9YwPyhT3hnRhiT96iN23aMdaqa4pwqNwmxnM8DGx5BkLOKJNQnImjeyDO15m7PAfCYmzDABN3N+qzVxcIoBnWAKIjbV9I/42sY5
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4684.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(5660300002)(44832011)(2906002)(8676002)(15650500001)(4326008)(8936002)(31696002)(83380400001)(38100700002)(26005)(86362001)(36756003)(54906003)(53546011)(6916009)(66556008)(316002)(66946007)(6506007)(2616005)(36916002)(6666004)(66476007)(478600001)(6486002)(6512007)(31686004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V1JVaGI3eGxXY1dMT2ppMlhDTEtRVlN6REkwM3VVdUExaDArZFQ0QVlwMDlt?=
 =?utf-8?B?SGtxbTNsSStMN2ZMV2N3ZjdheVRwNXozWmkzb1E0Yzd5ZWF0VC9pUHlvNi91?=
 =?utf-8?B?RVRRL25IZThPZm52elVzN2FOM1BiOXQxQnh3ZXhxRWhWT1FNS2RQZUZ0emlk?=
 =?utf-8?B?dEtSMi85eDhYUGtkUWpkTFNBSDlFQ2IwSHljUlJaa2VRMUJydk9XT0x1K3E0?=
 =?utf-8?B?aWhoTTFNckF0WHI3bGQvY0tWRkxIOFVrOUR4K3pzbUZsVlRrWVNNVHRUL3RK?=
 =?utf-8?B?UkRWM2NNRUM3UC8zSmN0ZnZwZW0rMWt6c2V2TlFQcWt4WE11dFlFNmY4TXRH?=
 =?utf-8?B?T1Zta29ydDNQMzRxVmhtUjNWY3NhYitsOU9vZ25NWDQ5YThBVFo1NXpwSDdC?=
 =?utf-8?B?Q05sRmNOUDAwV0JKZ0ZrbHpLL1lNZzhETnl4MjFIc2VvRFJJZXBDZUNRUmlH?=
 =?utf-8?B?YjFEOEJYVW02b3BsM282aHpDdHhaUytEaW8zYURNYk90QUk1bnJqVDk4aDVh?=
 =?utf-8?B?WE4wOVVoaWpFMStEeUxZQng1Vll2M2c5KzluU2dqRnhWWEhkRHJ2U0pldlpO?=
 =?utf-8?B?NGVHdWpxQ0kveTVERmUycHVoV0Nnbzk5ZE41UVlBbXovaTJWL1J3cVY4Zi80?=
 =?utf-8?B?ZU15S0NVK1ErQ3QvMWNYY1Ayd2ZzUXZ5bUZzWXpzSHpPRlhwSXMzYkJmbmdl?=
 =?utf-8?B?cUxnSXRVZHVOM3FVTExaSFJERVNTT0V1azd3ZVBGdWpwelpTd2VoTHREU1J4?=
 =?utf-8?B?R05RMVZCN2F4LzBobFc3K3lONHFMS3RDS3RiZ21jZlg2NkRHYnAzUUM3WnJB?=
 =?utf-8?B?RFFSRHE3UWRGT1RFK1JXK2VFUkZ1SE84azFMdFl6Q0s0OHlPSUE3c1laWVd4?=
 =?utf-8?B?Vm0rVEV3Y2trWVVDcjNUMGRUSXZTMFFQTzY0bG81M251Tm84YnQzKzZaTzh1?=
 =?utf-8?B?N0hWdnNsTkxqbklYd0pmdlJaa1ZlTWNWUDNPTGgrbmRIQXFvMGFzQStYREJp?=
 =?utf-8?B?V0J1WUtXYjVQRzQ2S2JJSU1GN0duQnBaN2xKMXIxeUFyQU92TmYrc3Y2cTI5?=
 =?utf-8?B?UW1aRFBuemllcWttYWNncmFPdXdma3ZFNWN1c25HeW1vdGlxQ05PQTlPeGdw?=
 =?utf-8?B?MFFORXBnaitXRXpIU1VXZW1mM3FGVU1JUEJxa3M5b2ZKc0FaUGlXbUIwYmRU?=
 =?utf-8?B?UncxNE1yWmdMNkFBWDF1R3REMGVJRmtKay90c2ZSYXpkejN0LzYrU1owSnRa?=
 =?utf-8?B?M1VqSXJDVThGc001bWZpQldRU3FwQU52OS8zYW4ramU3RUZLckYzN21qSlVG?=
 =?utf-8?B?ckVqUDhtWkhad3RoNk9CUFZ3NE4wNWNNUVVacHNMVDU2RHVQaGZxR2lSMWl2?=
 =?utf-8?B?YVdUUlBVUHMxQ1ZlRXBodEdMVFlrZmJWMUFIbEFoUXFvenB5c1kyS3VOOW42?=
 =?utf-8?B?clMrK0VJQlUyeW5lYnlYOElqaDhVSU5YMmpRQXhNVG5IQVo3VENTU0xlanI5?=
 =?utf-8?B?SGxvRXAvV2diTDZKZmc3eWtkZGJaK2RydUdHd3RZMmV5eWlFVVdNVEs1NWlr?=
 =?utf-8?B?VEk1aTZhMUpPVHAvdzU0dFBSV2plV09kVmdudjdQbVJhTldKblp1T2NPV1dw?=
 =?utf-8?B?dkEwOENuUlFaKzZQY2pRS2ZUbDdFUis2eDROWXAraFhTSHZKUE5aZlpTeFF3?=
 =?utf-8?B?Wnp4eVlqMW1ucmtRT0RMSHNPdFREOXAvVytzUFpQd1F6bUZxY3NJMTV3WE82?=
 =?utf-8?B?QWNxd3NuZVhjTWhmL0VEZVp1OWp5UVFyK0g4M1N6MHMyaXBVbGdWZVhubEtk?=
 =?utf-8?B?TjFVSEJldkcrM0ZVd3JsSzJCcjQrVXg3R2piYkZ2eTU4M2F3ZXBaRFJKVlJy?=
 =?utf-8?B?bmZXQkVCcW15dHVoc0h3NHJuN2NwQ0UxMmNnSldCWlpnQnc4N0xHSzhBNllX?=
 =?utf-8?B?YkUvODhtVENtbWY1bFR5dGl0VGVWalhLYS9YbVlEcXA4ekJnWGs2eFN5aE9u?=
 =?utf-8?B?SGhHNVBDKzQwaER4a05tRGdIQ1ljbW9ySnZaTmZpdnFRNktGalVtR0J5emQ4?=
 =?utf-8?B?TVNRLzd1SVJPWHRYc3pad054azVsYUZhZFRtT2hvSWhUdU9EcFBpYzlhdm12?=
 =?utf-8?B?UHZBazhiZDlNT3Jsakc2NE1Gbyt6aTYvYWwvblNKZXVybldxdHdlSWRxZTlN?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ueXHhJmPkX4+S6NqeRFXSPc7tl2tL/6RobbHBMVzdwIN30dLQWDlYMMgzTmF2lvltMzO5tsXemCvV+xgx84xVfNBmtnjUVnfAV0X00B8SlFWCcWgS6iLbiiCLqd+TwC5aKDrTb41/Jvy8MykSN3mIfiOd3guIIITnlro1Tir6RIeNEx5H0cjyGFgGePRT+zBEjsve/XMuhgYA1Ui8Ptg7Ai5c/kTVLK7XMRUy2lAorXLW1RLbLkk/IAnTHlqc+axZuNV3vrE9UqGiJ/ye0PIpqGJIjevdFynaZK/TSrfZLwcQCJEa0H7Gkdjw6McF63UfSLb3XKiAn0MPTwsequnZ9T4t78VBPb3lzTkFaqE9J3bnfBBhamD4jB9cH/hVKb/IzNs/E9uLJU9pexn1TrFs9sqb6Cw5Iu3jooOwRNB0TW+yRvdTThzItz3Qv25c1ia/wq+Pz3KjulSz9zfVtngZIBWBQZKcWCHjjfwYXOqm446XgBjcS+L7TCcZs9J6C7XsQb40xbCNlRBEDYJ44kQLJGrYaljL2aY6tyY51zuaGjMLbLBqEsrq3cR6mN1lNUkRKwEjQ3UtP1vFU7VVxgI0EhYH2wZAnhSlZDFb4idRXw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e54c1c7e-5a5a-40d5-4658-08dc2d857270
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 17:50:35.4704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJQi43yykvXyc0uv66h0qHBKclSGLv9AZGsobLrdz8M5gnvtMQUc2Uknwsqn8/in0VzRpFKlIuo2pjMqY7QTZ0bOCaa7hI92zy0Yd/vQELI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5551
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_10,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402140139
X-Proofpoint-ORIG-GUID: OX3ltFf26ux8nknJfT4aLvQei1PYMdAe
X-Proofpoint-GUID: OX3ltFf26ux8nknJfT4aLvQei1PYMdAe

On 2/13/2024 11:10 AM, Eugenio Perez Martin wrote:
> On Mon, Feb 12, 2024 at 6:16 PM Steve Sistare <steven.sistare@oracle.com> wrote:
>>
>> Flush to guarantee no workers are running when suspend returns.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> index be2925d0d283..a662b90357c3 100644
>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> @@ -74,6 +74,17 @@ static void vdpasim_worker_change_mm_sync(struct vdpasim *vdpasim,
>>         kthread_flush_work(work);
>>  }
>>
>> +static void flush_work_fn(struct kthread_work *work) {}
>> +
>> +static void vdpasim_flush_work(struct vdpasim *vdpasim)
>> +{
>> +       struct kthread_work work;
>> +
>> +       kthread_init_work(&work, flush_work_fn);
> 
> If the work is already queued, doesn't it break the linked list
> because of the memset in kthread_init_work?

work is a local variable.  It completes before vdpasim_flush_work returns,
thus is never already queued on entry to vdpasim_flush_work.
Am I missing your point?

>> +       kthread_queue_work(vdpasim->worker, &work);
>> +       kthread_flush_work(&work);
>> +}
>> +
>>  static struct vdpasim *vdpa_to_sim(struct vdpa_device *vdpa)
>>  {
>>         return container_of(vdpa, struct vdpasim, vdpa);
>> @@ -511,6 +522,8 @@ static int vdpasim_suspend(struct vdpa_device *vdpa)
>>         vdpasim->running = false;
>>         mutex_unlock(&vdpasim->mutex);
>>
>> +       vdpasim_flush_work(vdpasim);
> 
> Do we need to protect the case where vdpasim_kick_vq and
> vdpasim_suspend are called "at the same time"? Correct userland should
> not be doing it but buggy or mailious could be. Just calling
> vdpasim_flush_work with the mutex acquired would solve the issue,
> doesn't it?

Good catch.  I need to serialize access to vdpasim->running plus the worker queue
in these two functions.  vdpasim_kick_vq currently takes no locks. In case it is called 
from non-task contexts, I should define a new spinlock to be acquired in both functions.

- Steve

