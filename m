Return-Path: <linux-kernel+bounces-62028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD66851A7A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74B2C286EB1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9873FB3A;
	Mon, 12 Feb 2024 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KnCniSK1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TjtEd4Td"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911073FB0A
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 17:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757220; cv=fail; b=XZwQKcBZO483U4jXVrwgXIplJgvk/K8AONxPzBuI70FDSg9bEal2jezoNdHUaCuLfSVkuPtEx3QI7yXT54XXdJsuetQJcfZwfalhRFmyff6elSIm1ut3t3T2bNYgHgoUu5vXWtWBdIpDK/noJ2XgwsCzzl/t7zJtsrytGVo15hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757220; c=relaxed/simple;
	bh=7vXnTcTU2eUbtxnWaLyivcuOfStMLpnU1/y/xbEwDlo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hjLgqL90SZTcAc+ubnPwtXGe893Cseux6bZikhNWGcmo9zHcjmHpiG/j1Mhxd3FpRFG3UPdgYZnaXmfXiPX0Nb1TqUY5ahH/sDJBMxEmBAtR580fzwSvzGY6SFAx0lep4D3pAEwYLNICwpSrgFSXY6Lxv6o8x4EgxnbhyG99CsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KnCniSK1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TjtEd4Td; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41CGo9wV020953;
	Mon, 12 Feb 2024 17:00:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=zLIQmPSoOuU9ysG0EMnq3spLfm0Hxu3zBSywaeVs2Co=;
 b=KnCniSK1zfQuXQ4jVMMPjnvzbvvmsKZHV1aDNImmOuN1ASdPyKktJVx918cUHZgPfsgs
 WE+DIZOG4bO15KfmSQ/OyZzZF66M779j7rdZk8bNiFadQN5HhcCtrHlRvq8JxqgQeoOv
 H7XXQYFbv217QlYptIyEg2WZf51ynw6136sG0nU44uFA3obduX7fGXEKf/gVZuwBDlio
 EYRHUX5/DoSr/5dxhfqQUVwgn5Zdpt0H8MdlGxdqSCZxQDLCMVzHKQBaXfXaM+bM1XUC
 nr7kiGXqVQyb1an9PznfNrlOFToTDIslQo80r90F8jqTpTtXcd1SyWzVhd1/m1hBErLu dQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w7q6rr0jy-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 17:00:12 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41CFXSAN000755;
	Mon, 12 Feb 2024 16:37:20 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk60scm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 16:37:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6PcFOm3MXe5tkSV9hsXlQAjiYqyctJKdfXyhkD1C/owIfmE7SOKqZ17feT7JuuBm90m651+ve+f1yT2lJj21521ezl0NIy2yR4pUZg2mgAKD90XtIhow8r95Ta8UAWLrWm4+EPnweq+Z/4zWOsBhntFxKRKv5+VfuC4TUdU0qns1f0hK8xAUccd6IsZLh4cOuVP9QShIUq+XI9aNk0MBCbXZ64WE6lElDVQljwODmpEMeExhEraKYOhysvT1UffBiNdTCj9Ctvf5pionxIea+NG2NN4J40SQxbXVSDm3M0Ic+xZTy0T1h8eim8sYKilx86EklISHVFsV5mlEELKBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLIQmPSoOuU9ysG0EMnq3spLfm0Hxu3zBSywaeVs2Co=;
 b=FZL8UNLPpSP9Xt7fGj4ZD2jG4kSatdN9ayO1xh81te3i4Wa14z/c49WsNdKnH2VlARqz0i8Y42oT3QbzoOtMKuhLlr/dX8YztDDXGsKmSOOREg16I6n2JWZ9KAkJE6+8+YMkbtxTWhEl+626crxBosvB0ERgYU8Ecft09Uk2l2YWMEirPGvj6K4mY/QBeSuqhCnHqShJks7cTSlI87oDszMAIxGacS4ipxi4tWvoK/ZBb9tJSEXYUNSAbuDg9Bu0A7IDGRLAT80nNS/yojcA6o33lIRoRvAlSGATwHd8c+3bA7ObS2f1MnjWizPrY5vtecBg9vQ6goBiN5fNnHtkbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLIQmPSoOuU9ysG0EMnq3spLfm0Hxu3zBSywaeVs2Co=;
 b=TjtEd4TdIUv+cFIHu7TCxFXmzZvMXPEKQKFIJugS4n1KWYPa2qOs4WjNsYEL0+vgpda5CGEKqmn8UY9OPR2DcsunCPwITmcmf6z5WXEfuPLTkDCKG5k/PR98Vipw+MuJNfRzOBZmWYPO5TOl8wC2N7TH9C+RNY7T0dx5trdNoLk=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by BN0PR10MB5222.namprd10.prod.outlook.com (2603:10b6:408:114::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Mon, 12 Feb
 2024 16:37:16 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7270.036; Mon, 12 Feb 2024
 16:37:15 +0000
Message-ID: <e3515937-7d36-4167-84dc-a9c1721249cc@oracle.com>
Date: Mon, 12 Feb 2024 11:37:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] vdpa: suspend and resume require DRIVER_OK
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
References: <1707517799-137286-1-git-send-email-steven.sistare@oracle.com>
 <20240212031722-mutt-send-email-mst@kernel.org>
 <a4d2626d-7d74-4243-93a9-01d7adc8cda4@oracle.com>
 <20240212105604-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240212105604-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0110.namprd03.prod.outlook.com
 (2603:10b6:5:3b7::25) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|BN0PR10MB5222:EE_
X-MS-Office365-Filtering-Correlation-Id: abb479f9-8a28-427d-d6d8-08dc2be8df45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2AUYLDWh2Ua/RyCaF+jR/0iU/rzAijisyH1mFNsNjIIAUBIShWaAjd2v+UuYHDH8J+opgoH9DdpWHygMFYXy5OpKE9xSx/PLkM5Yd/HBVvNWg0rfXmipGFk6H2RaIK52Z9JNor6UAN8lBDk2w99dVvvuYly+ou4IyBXbCeK6t6PdQVumV5ZttTOd2D9EOMRj3DRS8dF8I7WWIovJTiXNADWS2hytQzGRez8pBVgYFICKP+5ZENL/+BIZRA6ZuwPI0pQzzUORrsHw8Fdx719M+UZBsggKru3ZeFGBKckflAsFjS/W6jSEhCoXJV7AKm6ecA9mR3w3Pc4S4Ygtmlyc8Xm2XitIlxMhzgVcawlRMxB5FV7nrtUksC/fqUFFDAyMnFBJtimvTrKBPELMHpZSBU9MVCwXzhEYX3WwGRHeYu22q+uD4kW8pxKZCH15PsyP3CRIKKfOXB0RdKgk/S3RSTMhAyGokBcI9YXm0fkXGKvTTN/HHdq14JRBPzPL3w7PeJq7Wrt6o9jIrCZUB+MCkELmRSleI5oXa4ulg5W6Oq8QuqNHW4IFPbpQDSateKxT
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4684.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(396003)(346002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(2906002)(44832011)(8936002)(8676002)(4326008)(5660300002)(15650500001)(83380400001)(2616005)(26005)(38100700002)(36756003)(31696002)(86362001)(316002)(66946007)(66476007)(54906003)(6916009)(66556008)(36916002)(6506007)(53546011)(6666004)(6512007)(6486002)(478600001)(31686004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aWN4Vmw0VzFyajlKZWtlQ3h1THU4S0RBSHVDbEY2YWh0Y1NiOStmYlo5SWJO?=
 =?utf-8?B?akNJU0JLVDNQMTZXMmNVY295V0NtRWVYZFBPVnUwb05DTjFoK0c4WWNaTXNW?=
 =?utf-8?B?TlZMaE1MSXdLZXBQQjJZOGdtdWtkb1ZncVM1d0RDREEwS1VLYUltVW96TS93?=
 =?utf-8?B?WFJ3TnlxTjNwWXJmWTZVMlFveTFTV081T3VWQnQ0QWZ2dkYxOXVHOFUwYXBv?=
 =?utf-8?B?QnBtTkZELzlQb0tjTkpjbzFyTkExSktjTS9CMkZ3bjk4RFJpSzdZelYyaitt?=
 =?utf-8?B?aDVuc081MC9hZjBadUNNY1BneS8yVzVUTnhjN29LU3FYbVdtcHVYVWhzeDZJ?=
 =?utf-8?B?V3RwMyt1NXd4Ylp6OWIyc1M1SjFzK3FhVkJnOGtuVFl6ZGx2Y2drOGdJcEhD?=
 =?utf-8?B?aytBRDlnakJtRUFKLzZPTnlSb0FObWtvWkNUVEtKcXM5d1ZBMllGL0tOUmZH?=
 =?utf-8?B?ZVRDZkE1aDRJYmJqR1RTMWk5VjZmdHdPOGxZQXN6WGNiemdEaVlBcWNmamxN?=
 =?utf-8?B?anVWVlJkNUZmUGRUMmg4dkJEdnpySHpHRUdDVWFVNDN0cDd3VFh1SHpMaHdM?=
 =?utf-8?B?M1VDeXk1Q3JRVVo2Zk5XZHFSQW80KzRUa0VXZEF5aTlJUTNIeFJGeDZjMmw0?=
 =?utf-8?B?WUszdlpnaHNrRHQzaDZaUUdwV0FydmgwSzZBTDZaeXM1cGVVUWFndVhaRlJL?=
 =?utf-8?B?MEs3UXYzZVcvMm9PUzAyVGpoV0xRQmVsQkhsR2NmWVVVeVczTjRUT3lSUzRI?=
 =?utf-8?B?M1U2K0NHa0QwaWxxS05ISHU2OGdzNVdPcEVsYVpzM2NGZUxrZkVkUVFJeEU5?=
 =?utf-8?B?WXM0Q0JkRGZURXBrQVgydXhTVDhxQnZRbkVYd3U2dGNuVmNKOWFnaGZQN3dP?=
 =?utf-8?B?WVpBckpSakxqaXdRTk1UZWFjMWZRc2x0WmtDbHlIWTlNMndDVEZkMzFYQmxz?=
 =?utf-8?B?ekpPTWYyMFBQNlB2dm9zbDZUYWJHbGxwZXJWdThuME5yTG8rZjBoeS84d1ZH?=
 =?utf-8?B?Z01QQ1FyU3ZIZ2drV2E1ekRQODV0akF4RXFHRWV5RVZSd3lKYlZuWVl2czhs?=
 =?utf-8?B?RXdBVExhQUsxTzB0d0x5THFsYnRUaVdkWHhHdWsxSzBoL0g4Y2o3azE3S205?=
 =?utf-8?B?ZHg1aFViRDJ4UWNIU0JLV0p1bDFUZyszODNrbUVnQVNTWXFNcHpOeTV3anh5?=
 =?utf-8?B?eDFQYURiamNSZlZCYjZhbkcxOXkzZ2ZHcWJuRHQ1eDF6THZadHZ5RXoxc0Uy?=
 =?utf-8?B?bW95R2FHTDk3UTlqMTQ3OFBXL1VnbWd4ZWtaVTMydDl0Y1FmQTJNQmJEb2Rq?=
 =?utf-8?B?SndrSHZmVVIwYlNmYmdEZytDYUdBQklXV1Q5Z01uVEswTnEvVC9QazVkYmhQ?=
 =?utf-8?B?TkpvZGtuQmV5UWV5V0tmQUU4RCsvVG8vY1Y0TzdSbHNmQTRuZklybzNKLzZ3?=
 =?utf-8?B?b3Zsd3ozblRMMGxBbGtLR29wKzVSTzhMWFNWOUNtTHEzUmRiNkZUL01Xb282?=
 =?utf-8?B?L2JsN3hzQ0plSXdoZVZVL2JKSFpvZlNiSmNESnFhNGdxZklsQVlwVGJjN0d1?=
 =?utf-8?B?WXdOMGRpTTBHNXFpVmdrVW10UEM2QW1DRHg4UVplNlB4Q1AwOS9DajNGOGNT?=
 =?utf-8?B?dkNMTGtsSytQTVIvUHpwWmpndTY3WVNsSFRRdHM5ME9aZHRxQkxONW4xaE5n?=
 =?utf-8?B?ZzRyYTcwM2pON25USWhUekduNWMyQnA3VUNKdHVUV1NJUm0vUVNha2NrdDQ3?=
 =?utf-8?B?RHJDelN6MVdSNWNKbHlmOU8xWkdhcm5RV255ZGNxdklMNVR3eEZ3TC9Gb2lD?=
 =?utf-8?B?eUZzSG9pMlY2MC9EYW5SZjVITkpQcUVhb01KMXBiZUV1WGZyN1I3cTA2ODZ3?=
 =?utf-8?B?ZWVnRlhkbGdPWE1sODVmVnc4cVF2RFJsSmt6cUVhd2JXSmE0MDYybjZId1R4?=
 =?utf-8?B?bFRWSzFoRlZjcFZBVVVPR0VWV292TGJGdmdFdjZhbnoxTTdteEUycnFObE9z?=
 =?utf-8?B?S1dUZFVzRFBhaEdPMXp3NnAxa3pWeVZTTkd4SWd4ZmI4MTRCWjliRnpMVVc2?=
 =?utf-8?B?dGsrRllsTUJsRXBZVW5SK1ZCdlJnT2ZJc2FOZmJqRFFTSFBLa3pucS91V2Zq?=
 =?utf-8?B?K1FLd1NZZ0lGSm9UaG1yUy91SWcwVUZZQ1k5cUI5UTNublRXVUdSMnRrTzBp?=
 =?utf-8?B?Z2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+f5UqvWdsV1txnN/TDQL7rxn1aNVW51hfVL0WlnLrxDWEJqSf5DqwkCT2vJBMcz5D9231M0dCOa1v2TCsOeETPuH8HywP9Wm/bF2mAZhhG5J+ukDSdpnbJRMIe+llbTFSwoqWnX1KJqV27eEnwOYIjjEH+Pnjiyruivt9cFyZ0bE3JTeSP4B2sGfgVib1qVj+2hf94l5DKpev67B8QfkeSjfos5jcvZbRDr3dQ+nKqVQXjevGOK9RRf5+enOy6NaE6dpZdVTabeoI0lEOWCbixNakBhn80RbnCKkv+t2n3J6wZqXT7XSUevyLWuHSNRF1JfXOf+tpZ4Dzope67dTsXlZHsZSGEuRJlaH+fmK6wUkbqlkpkOO0fHd0C3absQzdwsp4draCLiKjWy2yoPZtqjd/g6JxfpTWqzQ7bBIzypNkIXv2xzwWLnDveGtagaF3IO3Ik0vEmGbNYnCcUxKZhARL1QZorE4gY6etc2JBwOvUN3Py+SR4BYKwGNg0tBTq5V9wwltQHo1HJtcPb7XE3HzKYAnA2C6nAnHpkZL763BmUtrlUJnvnpRPnVqcSixmiIYwh24SydTxOAtkckCLvJCWUXVUPLjmSHoRNDmA2g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abb479f9-8a28-427d-d6d8-08dc2be8df45
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 16:37:15.9478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PI8dTsSgGCKaE+zSoNOIJtb7DfANTO0+CfJVcAn81AbgmRxtb+B4QUQCEwmlTtn0nvNj7pUuu/prK3vTY3tjDbnShYlQMXRI9ZgEmmyW+TM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5222
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_14,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402120125
X-Proofpoint-ORIG-GUID: PKCLQD6eemIfghxpV_2xkOGNz_OxChXG
X-Proofpoint-GUID: PKCLQD6eemIfghxpV_2xkOGNz_OxChXG

On 2/12/2024 10:56 AM, Michael S. Tsirkin wrote:
> On Mon, Feb 12, 2024 at 09:56:31AM -0500, Steven Sistare wrote:
>> On 2/12/2024 3:19 AM, Michael S. Tsirkin wrote:
>>> On Fri, Feb 09, 2024 at 02:29:59PM -0800, Steve Sistare wrote:
>>>> Calling suspend or resume requires VIRTIO_CONFIG_S_DRIVER_OK, for all
>>>> vdpa devices.
>>>>
>>>> Suggested-by: Eugenio Perez Martin <eperezma@redhat.com>"
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>
>>> I don't think failing suspend or resume makes sense though -
>>> e.g. practically failing suspend will just prevent sleeping I think -
>>> why should guest not having driver loaded prevent system suspend?
>>
>> Got it, my fix is too heavy handed.
>>
>>> there's also state such as features set which does need to be
>>> preserved.
>>>
>>> I think the thing to do is to skip invoking suspend/resume callback
>>
>> OK.
>>
>>>  and in
>>> fact checking suspend/resume altogether.
>>
>> Currently ops->suspend, vhost_vdpa_can_suspend(), and VHOST_BACKEND_F_SUSPEND
>> are equivalent.  Hence if !ops->suspend, then then the driver does not support
>> it, and indeed may break if suspend is used, so system suspend must be blocked,
>> AFAICT.  Yielding:
> 
> If DRIVER_OK is not set then there's nothing to be done for migration.
> So callback not needed.

OK, I missed your point.  Next attempt:

   vhost_vdpa_suspend()
       if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
           return 0;

       if (!ops->suspend)
           return -EOPNOTSUPP;

- Steve
>>     vhost_vdpa_suspend()
>>         if (!ops->suspend)
>>             return -EOPNOTSUPP;
>>
>>         if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
>>             return 0;
>>
>> - Steve
>>
>>>> ---
>>>>  drivers/vhost/vdpa.c | 6 ++++++
>>>>  1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>>>> index bc4a51e4638b..ce1882acfc3b 100644
>>>> --- a/drivers/vhost/vdpa.c
>>>> +++ b/drivers/vhost/vdpa.c
>>>> @@ -598,6 +598,9 @@ static long vhost_vdpa_suspend(struct vhost_vdpa *v)
>>>>  	if (!ops->suspend)
>>>>  		return -EOPNOTSUPP;
>>>>  
>>>> +	if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
>>>> +		return -EINVAL;
>>>> +
>>>>  	ret = ops->suspend(vdpa);
>>>>  	if (!ret)
>>>>  		v->suspended = true;
>>>> @@ -618,6 +621,9 @@ static long vhost_vdpa_resume(struct vhost_vdpa *v)
>>>>  	if (!ops->resume)
>>>>  		return -EOPNOTSUPP;
>>>>  
>>>> +	if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
>>>> +		return -EINVAL;
>>>> +
>>>>  	ret = ops->resume(vdpa);
>>>>  	if (!ret)
>>>>  		v->suspended = false;
>>>> -- 
>>>> 2.39.3
>>>
> 

