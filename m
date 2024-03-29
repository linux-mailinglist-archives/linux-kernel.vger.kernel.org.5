Return-Path: <linux-kernel+bounces-125060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00328891F68
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55AE11F30CFD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445B1142631;
	Fri, 29 Mar 2024 13:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZdQP7ofz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OMVdZfvh"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C0E86269
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 13:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711718597; cv=fail; b=YWrkVenaaff1elcPZplNcMGxmxhsYILQt5TonpjMuC2I7Rn/2L9TxQxbkQtyLYNMRDMniedQQPDl4bKXuABe2gBuT8yJ4rCINoMJxPGp7EQ6G8Tc3tWmWZx5vDmZOAhdqZkH1Veojku3Ed+viZS/vc5flt+ppEUAn71OGQCiDbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711718597; c=relaxed/simple;
	bh=DhyrUYJ+y6exC42AAfbpEikKip9l6y+O/EEmGe11QJ0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uJ9elcZT63IQwzDai/RxDip0CfkwGRIf36fAg8Tgoa0IK6n/ueur1D+Isx3C0NqD4xVpHutYS07tkrJIfhco8HP3XMvejWd/uci0gOr+YXnHkjn+l7du1ru2lxc+agPhPzRdn9EY9nDmY3aDoWUAZ+pu8/OiGdDsvfQ3lIrgjjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZdQP7ofz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OMVdZfvh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42T0QBD3025272;
	Fri, 29 Mar 2024 13:23:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=wxDyexsHevLTbL6NNErkkIKos3cP0T2XGeevantNrOs=;
 b=ZdQP7ofzzc8tyiEfa6HIPnWVeI9ZDpXCF9z72kpUiNikxT657Fo+Ly/CMOMjaG/iC96A
 ZpZtSp5CxfWHmJu1YJPwRh7ld6TLH4V5GGNOrnNwpRjbpxT2fnQ0xCs8JAHhcFgdErBm
 UCOvUQ3AudtH+bN2G+tWEFO3Nl1z1GtgZPJd+lti3NDRlqUnEidSTQhE+4VcPGZzGYUW
 Xs0kzu4ks7Z+llkDvf+Fec6Xq0Dmd2fznwr5N2Te0D0TSBZtloJ+gBq+pCunoo1Gxca4
 LDgP03vvu3ncoI2Yt8taCSg/l2FE7oHXoGWQ/ac2z50Y/LyFCV8Od+1xF8qR641w136v kQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x2f6haefd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Mar 2024 13:23:06 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42TBoNfP012792;
	Fri, 29 Mar 2024 13:23:05 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nhb7hf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Mar 2024 13:23:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJ4hEJBqrNHIwsWNLDlgqxYXGyHyzLQaFxLdKM6ip6CG+b4YVkeH83yfoLEZQIpbRE9DIwnS2DH1KLa2keu64Q/J6oEkHaj1R4l+kGCBHUniPvnkD06dA0X4g69TB3rI/fKRYwKdRh8aKtf6Bp+Iy59x+6Gv18yR7ijuYh20K/9xhmOZJpdNzU0wb0Mhg/Zu/ihDGmSoJoVX01CQtdR3xwcR6/AwvEDPK2nW8tAIi2FYf6retop3gdIjHKwvnhotIXAJmxa2Uck/lfDhhuOcIBKE5TfwCFJffj9T2r+hyJ8qL866CCCAJD78uRuL2b+0BsMUhStWTpCrJcExZRJi9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxDyexsHevLTbL6NNErkkIKos3cP0T2XGeevantNrOs=;
 b=IQHc0P/1bqEyOlLdCXQaQhlKsSbS60qUeoSlUIhf8BbIAQ7zALuEWdv/ye5G+K+GowLF+UeqGVdM9Q9iKzYaBP3jH3yEtoz5bCZfgniXF/P7YU1+nW98+VNAQrGIws1/B33tQthMJct4lN+V8NGjot4ScIl5R5/EEvP68B8pbVSw2expOXwQ885DjVaDPnRpAWM3/pWWmMWw/5hTfLbLQh99g9fA46+LNl5PY8wtiiLfiq7f3QfFToctaoPT1LnL6nmjXaJoqcS7n8o7shJo/o2NxAKDNA5Cg+XRuZdAE9G8s1nQ46plQaDEMfFGjpT08m4PEXSo6SFqOiDe6JPkGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxDyexsHevLTbL6NNErkkIKos3cP0T2XGeevantNrOs=;
 b=OMVdZfvhUq3a0bEciy8GikJWhUZPZs+NyEuP2x2we7mjeODHVgxaTS3p/pONSfzVhao8iMbrFgphsiVvnslPpirA/EsX4ZAGHtD+dFsYAK/MeCWVtC20By4qZDKrWnaPEy6160OOBDBFuLg7gmyT5NYBf7vSAmgXw8zMo3JSwTI=
Received: from SN4PR10MB5622.namprd10.prod.outlook.com (2603:10b6:806:209::18)
 by PH0PR10MB4645.namprd10.prod.outlook.com (2603:10b6:510:31::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.41; Fri, 29 Mar
 2024 13:23:02 +0000
Received: from SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::1481:809a:af18:ac44]) by SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::1481:809a:af18:ac44%5]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 13:23:02 +0000
Message-ID: <e95bd083-3501-465e-be48-aa8d37f4f55d@oracle.com>
Date: Fri, 29 Mar 2024 14:22:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] objtool/x86: objtool can confuse memory and stack access
Content-Language: en-US
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org
References: <20240328134634.350592-1-alexandre.chartre@oracle.com>
 <20240329013932.vxqzc74szrckxqdq@treble>
From: Alexandre Chartre <alexandre.chartre@oracle.com>
Autocrypt: addr=alexandre.chartre@oracle.com; keydata=
 xsFNBGJDNGkBEACg7Xx1laJ1nI9Bp1l9KXjFNDAMy5gydTMpdiqPpPojJrit6FMbr6MziEMm
 T8U11oOmHlEqI24jtGLSzd74j+Y2qqREZb3GiaTlC1SiV9UfaO+Utrj6ik/DimGCPpPDjZUl
 X1cpveO2dtzoskTLS9Fg/40qlL2DMt1jNjDRLG3l6YK+6PA+T+1UttJoiuqUsWg3b3ckTGII
 y6yhhj2HvVaMPkjuadUTWPzS9q/YdVVtLnBdOk3ulnzSaUVQ2yo+OHaEOUFehuKb0VsP2z9c
 lnxSw1Gi1TOwATtoZLgyJs3cIk26WGegKcVdiMr0xUa615+OlEEKYacRk8RdVth8qK4ZOOTm
 PWAAFsNshPk9nDHJ3Ls0krdWllrGFZkV6ww6PVcUXW/APDsC4FiaT16LU8kz4Z1/pSgSsyxw
 bKlrCoyxtOfr/PFjmXhwGPGktzOq04p6GadljXLuq4KBzRqAynH0yd0kQMuPvQHie1yWVD0G
 /zS9z2tkARkR/UkO+HxfgA+HJapbYwhCmhtRdxMDFgk8rZNkaFZCj8eWRhCV8Bq7IW+1Mxrq
 a2q/tunQETek+lurM3/M6lljQs49V2cw7/yEYjbWfTMURBHXbUwJ/VkFoPT6Wr3DFiKUJ4Rq
 /y8sjkLSWKUcWcCAq5MGbMl+sqnlh5/XhLxsA44drqOZhfjFRQARAQABzTlBbGV4YW5kcmUg
 Q2hhcnRyZSAoT3JhY2xlKSA8YWxleGFuZHJlLmNoYXJ0cmVAb3JhY2xlLmNvbT7CwY4EEwEI
 ADgWIQRTYuq298qnHgO0VpNDF01Tug5U2AUCYkM0aQIbAwULCQgHAgYVCgkICwIEFgIDAQIe
 AQIXgAAKCRBDF01Tug5U2M0QD/9eqXBnu9oFqa5FpHC1ZwePN/1tfXzdW3L89cyS9jot79/j
 nwPK9slfRfhm93i0GR46iriSYJWEhCtMKi9ptFdVuDLCM3p4lRAeuaGT2H++lrayZCObmZxN
 UlVhZAK/rYic25fQYjxJD9T1E0pCqlVGDXr2yutaJJxml5/jL58LUlDcGfIeNpfNmrwOmtUi
 7Gkk+/NXU/yCY17vQgXXtfOATgusyjTFqHvdKgvYsJWfWZnDIkJslsGXjnC8PCqiLayCPHs+
 v+8RX5oawRuacXAcOM66MM3424SGK5shY4D0vgwTL8m0au5MVbkbkbg/aKDYLN33RNUdnTiz
 0eqIGxupzAIG9Tk46UnZ/4uDjdjmqJt1ol+1FvBlJCg+1iGGJ7cX5sWgx85BC63SpKBukaNu
 3BpQNPEJ4Kf+DIBvfq6Vf+GZcLT2YExXqDksh08eAIterYaVgO7vxq6eLOJjaQWZvZmR94br
 HIPjnpVT9whG1XHWNp2Cirh9PRKKYCn+otkuGiulXgRizRRq2z9WVVQddvCDBDpcBoSlj5n5
 97UG0bpLQ65yaNt5o30mqj4IgNWH4TO0VJlmNDFEW0EqCBqL1vZ2l97JktJosVQYCiW20/Iv
 GiRcr8RAIK8Yvs+pBjL6cL/l9dCpwfIphRI8KLhP8HsgaY2yIgLnGWFpseI3h87BTQRiQzRp
 ARAAxUJ7UpDLoKIVG0bF4BngeODzgcL4bsiuZO+TnZzDPna3/QV629cWcjVVjwOubh2xJZN2
 JfudWi2gz5rAVVxEW7iiQc3uvxRM9v+t3XmpfaUQSkFb7scSxn4eYB8mM0q0Vqbfek5h1VLx
 svbqutZV8ogeKfWJZgtbv8kjNMQ9rLhyZzFNioSrU3x9R8miZJXU6ZEqXzXPnYXMRuK0ISE9
 R7KMbgm4om+VL0DgGSxJDbPkG9pJJBe2CoKT/kIpb68yduc+J+SRQqDmBmk4CWzP2p7iVtNr
 xXin503e1IWjGS7iC/JpkVZew+3Wb5ktK1/SY0zwWhKS4Qge3S0iDBj5RPkpRu8u0fZsoATt
 DLRCTIRcOuUBmruwyR9FZnVXw68N3qJZsRqhp/q//enB1zHBsU1WQdyaavMKx6fi1DrF9KDp
 1qbOqYk2n1f8XLfnizuzY8YvWjcxnIH5NHYawjPAbA5l/8ZCYzX4yUvoBakYLWdmYsZyHKV7
 Y1cjJTMY2a/w1Y+twKbnArxxzNPY0rrwZPIOgej31IBo3JyA7fih1ZTuL7jdgFIGFxK3/mpn
 qwfZxrM76giRAoV+ueD/ioB5/HgqO1D09182sqTqKDnrkZlZK1knw2d/vMHSmUjbHXGykhN+
 j5XeOZ9IeBkA9A4Zw9H27QSoQK72Lw6mkGMEa4cAEQEAAcLBdgQYAQgAIBYhBFNi6rb3yqce
 A7RWk0MXTVO6DlTYBQJiQzRpAhsMAAoJEEMXTVO6DlTYaS0P/REYu5sVuY8+YmrS9PlLsLgQ
 U7hEnMt0MdeHhWYbqI5c2zhxgP0ZoJ7UkBjpK/zMAwpm+IonXM1W0xuD8ykiIZuV7OzEJeEm
 BXPc1hHV5+9DTIhYRt8KaOU6c4r0oIHkGbedkn9WSo631YluxEXPXdPp7olId5BOPwqkrz4r
 3vexwIAIVBpUNGb5DTvOYz1Tt42f7pmhCx2PPUBdKVLivwSdFGsxEtO5BaerDlitkKTpVlaK
 jnJ7uOvoYwVDYjKbrmNDYSckduJCBYBZzMvRW346i4b1sDMIAoZ0prKs2Sol7DyXGUoztGeO
 +64JguNXc9uBp3gkNfk1sfQpwKqUVLFt5r9mimNuj1L3Sw9DIRpEuEhXz3U3JkHvRHN5aM+J
 ATLmm4lbF0kt2kd5FxvXPBskO2Ged3YY/PBT6LhhNettIRQLJkq5eHfQy0I1xtdlv2X+Yq8N
 9AWQ+rKrpeBaTypUnxZAgJ8memFoZd4i4pkXa0F2Q808bL7YrZa++cOg2+oEJhhHeZEctbPV
 rVx8JtRRUqZyoBcpZqpS+75ORI9N5OcbodxXr8AEdSXIpAdGwLamXR02HCuhqWAxk+tCv209
 ivTJtkxPvmmMNb1kilwYVd2j6pIdYIx8tvH0GPNwbno97BwpxTNkkVPoPEgeCHskYvjasM1e
 swLliy6PdpST
In-Reply-To: <20240329013932.vxqzc74szrckxqdq@treble>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR09CA0010.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::14) To SN4PR10MB5622.namprd10.prod.outlook.com
 (2603:10b6:806:209::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR10MB5622:EE_|PH0PR10MB4645:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ndBs/3Ug+e/K1LIbX0iXQibhELVn/39swjUVqNWy5RkN5ewyFVW+Ls0G7nQgFVQwW/PLZc9H2Q33a4XhDiARIxDbDO6wA3pOwoEByLw7LZTbS2E6vHvYVgZzWE5uzY8fwVHZrrSI56p7LAkHWJ/SL1Y3DBnlwNw5w+qBbyecrSafkwiuElF74RAfpyqhemZ7uuJYU3VqWYnI6Zky/93LOZ7AWJe1tl5AmOdJfVCR2jjLNccJ8SI6esCVOzmMdBerH7elgmyb4VUUlMUojs38JbiVAmW5T2StHtyP9zgkXqlQKie10sitlhkslhtC/zz4gF9NyDFRqequx2VuRGK0Wah4eqeDm9YSqQmJBU6d+KJy+TuyxCJme3MR7wPBqLOe790YnbrJaVb38VygJZUB74N3v10yqz2DHJiu7kIN+0YqxgcjusLbvAaMeLtYn98ai29pTHurSyP4bLHZWkVxayErFmhOxUYwa1VtZTZawPpQ5edsVk8antLkuuLMK9j06CUoBlwG3/sPbOf4i5QN2J2q/d1c++ydTUveGBSktIartXBNjISEhHywjLluXQBkRmcXT8iqURcqi/3VRDlz7dRsE1ozTcNTlEY21+A3Mrg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5622.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TFdmNDRvYXVIKzd4bkFTeWpKdk5ReTBDdElxQ3JOU3RISmJCWGFiUWNuRXJQ?=
 =?utf-8?B?N2J2ZDJrYWJueDJiOFBrN2NmNXlnVVRBeEYxT2ZiY0RUNEtDYWIwSjYzb2lP?=
 =?utf-8?B?SnJCUHZTVk5HTWRoektacHJ5ejRSelNxbFg0WHhPMnNVYUN2MmNkUTFvU3Za?=
 =?utf-8?B?QW1IbzNwakd4R0lUQUFad2VrNmJnMWlQSHRYRy85WGZXbzJyc2M3eTRjNkkr?=
 =?utf-8?B?aXpVS1Mwc3BqVDFqV2F2V09WbGFiWGJ3ZVNjY1pQVTFmYXVUMU11bXIvYk5a?=
 =?utf-8?B?THJhMTBZcTM3Y1VWZEVZVjVuRTlOWFErOXpZZGRPVkxkaU1qdVZqKzRMdFJH?=
 =?utf-8?B?UXdrU2FpMFNjN1ZITzZtdHVzN2cxd2YwVEYraDE3Kzhmd3BxbUZVeFNJTHo0?=
 =?utf-8?B?Ymd3VldJNVdtRXhjam5IZ2tJeGhhTUxyK0F2ajdVSThxeUluT0JBRUo2Mk8z?=
 =?utf-8?B?NGc2M2FmNEwrSk8vd3VFRWxpZG0xMFAxSW5GZlk4a2V6NUpJN1E1VkFFOStl?=
 =?utf-8?B?RGhIZzFhY2ZYd3BRTEYwci8vUnhnUW8waldXeXJTTk5NWWhySjBQOXFTNU5H?=
 =?utf-8?B?cllVYytwdlVFZjhrcHZacGlOK1JtUk0rNUp6SThiOUZnRGN3djhuVk1Ka0ZM?=
 =?utf-8?B?ckxSSUdWWFdlSWxTcnFUQ1Z1T3hSTElhQmdxQVU4UmNVWnNXazZVUDFEZUcv?=
 =?utf-8?B?dWFyM05kODg1QnMzMEZ4V3NqZDQvQXZIOU1mZ2F4ZDdna05pL3p1L3NVYmlh?=
 =?utf-8?B?VUxDOGNOWDBDLzUrUVl3U0ptdEZ0eWpXSFQ2UTZlMnUxUi9iNlhUUWVyeks0?=
 =?utf-8?B?RzcyalUvbVdKczRwU2xTTHZycTFXWWN3S1BETmhETm1vZHNVRFhOSlN2azUy?=
 =?utf-8?B?RjFib2lOSm9tamZ0d3BEeFpXZzFBTi9jb1U0ZEVBR2NUeEwrWkUrSERlR0hh?=
 =?utf-8?B?U2NpczhSUjNVVUNJSnRzR2xUclJ0N0RxUTYyOWE5ZVpFRThpd0Q4eU9kQlQ4?=
 =?utf-8?B?QzFOU3Y1YlJUaDdiTklhWVQrb0QvWkJHWnlHcStzVEdWNVowanpMYkNXTlZZ?=
 =?utf-8?B?UG9BUnRDa0hFS213MWFFOC9IM1Vvc0JoRmRKZ3NsRmU0RGFrMGdjZVorOUkz?=
 =?utf-8?B?cVZJdDJMc3R1S1RWR2xZdGJOYU9aRDNUQTZRVm4rSVE0MW5ieVFsUlIzdktj?=
 =?utf-8?B?UjBOUVhQVGo2bGVwUmdWME5KWVptNU9EWTNucktZMm5LZzE3VHlCcnUxdXB2?=
 =?utf-8?B?b0U2TGRNZU9yZytrRkpwYUZpVC9TOEoyc0VZeHVsNkdTRGx0SE1BZ3BoaTQ5?=
 =?utf-8?B?L0dkWTliNEwxNThkVGJjM0l0UTJlVW9YSHBHbTBHZ3Mwc2JMNUpNU0xHM0JT?=
 =?utf-8?B?ZWgzZTlTbVFuTmc4b2tNYkIrRGJOVnU1dXRBMmNIdHk5WDU0MGZZVlY4VUpa?=
 =?utf-8?B?bGdoRGU0Y3g1LzFWMVh1UjcyQ2dZbkhyZGJRSVVzUEoyb0Fsa0FvVEd6WEdk?=
 =?utf-8?B?czg3cFBQbTcxbTJrbFdyKzMrUkp2Q2hsMkl3QjFRTXdkektQZkViNzhmMUVn?=
 =?utf-8?B?cm1NVWJKVUIwSG5xSFFEdGNRUEwxOTZ0ZXh3YW1tZFhQRmk1eXRHN3ZJSkR0?=
 =?utf-8?B?a29lb3lDMWZJSWI0cFNHZzU2Y29nMkkwajNDMWZxdzhUS1R0dURXdThGczBT?=
 =?utf-8?B?MzZaRFVVVElJTEpxSytPU1JEVkwxbThvb1RTbDZ0ZGZPT1dzMEkrd3grSWZR?=
 =?utf-8?B?a1pXZTZhSjNSQzE3RFNxbExCRkNTS3cyZFpDbi9OYURJZUZxZVo0Y1U5YXJ1?=
 =?utf-8?B?RnEwMlRoMHhDSVhUb0VhYlduT0Y0Q2xqQUI3eFlPaGNFdzdaUVI5UGlINkZ1?=
 =?utf-8?B?UGZITFdLWkRHNDVyNHRWZFRneWJCOXZacDMyT3V5SW1GUHpzNHVPUy9tNDBY?=
 =?utf-8?B?TTNvcW9ZRk1LbVVFaGVIK3phWmNzQXRiNVRMTzhXNjdpOUdHaUp2WkdIOTZB?=
 =?utf-8?B?Uy9uRjhjRUZxSnc4VW9KcW1RUFFxbFRUMG9oNVZNNHZUWDQxK0lBVHlhdFFU?=
 =?utf-8?B?TDFja1g3YTBjYjhTVUtiemVjQjBPblRHRXJWL0d5NmJSRlVkN29aT3FhQThV?=
 =?utf-8?B?NHJMbnlKTXZISVBhM2RDdGFBeVNaZjZ4Z00zR2ZlOEU3MjVhVnlENHFsQm9w?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	z1e46uJcFjJhCUnF6IQK/6yDhfEGWZB8H7nbfLt2iEaq+ZoeEHKzWyeXRaiNOnscSEJBti2M1hCF19yv7xACCIiNvGjIMoWBtmwv6MZNVyxB4bBb1SongrHjXkDouvjahOYlZM79jOuGL6S/bd7pwqNKop2R16Dw5/rLU55rfrFlNbe44Z4XGkwa0uFWbP7i+DfGta2xE7VswVpkTieoOSJcynSicw0w4dHqrNbkauGQC6pm483nikuSvGi7yHHP2gu919DToPPiRCbQsEtlViI+bR+IKZjqKBwWdIEWpyGltMmMUr2lU7l6kUyT2mhmta6OVOf2lo9n750yjuA3toxOj2qYZrvBshd/McWfVg2lY31d0FeE43gRdfMHrcR3SDg+6d/jdTO+kzUAMjmhA7GVV+Qxgc0Phlx8Z7Lq1hWNMd3gzre+gEA7zi4WjpA+llXs3L54m/EC12dlexx0o3eRorIVyvWgk1NMcJabL2PIBZ1BqG/fSYe9GjZNMtd46I6v9Xb1I/3KSzqLlPMD2XqCiURMuoW7K/9wuQCcImMwo+54JtNO2cJNFuxbb8lH9EQ+w7O5N+dcbnAAAqZk+qyNhO91dFjQjLMCmfJd1aE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3172eaf4-2a38-4160-74f9-08dc4ff35c0a
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5622.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 13:23:02.1823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5YWiBP/hJsTYFEsmqJDGGiDTLMu2fxY9E9EQhpVt2xYA2kIiSkRnL6cfl9ADiZh8ET6CRK2fnWATgtDklhiVrHCvWcoY1QZLSL+XcyridCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4645
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=944
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403290118
X-Proofpoint-GUID: XmkKsTN54LPQ1XOihH0sov1EhovliTVG
X-Proofpoint-ORIG-GUID: XmkKsTN54LPQ1XOihH0sov1EhovliTVG



On 3/29/24 02:39, Josh Poimboeuf wrote:
> On Thu, Mar 28, 2024 at 02:46:34PM +0100, Alexandre Chartre wrote:
>> The encoding of an x86 instruction can include a ModR/M and a SIB
>> (Scale-Index-Base) byte to describe the addressing mode of the
>> instruction.
>>
>> objtool processes all addressing mode with a SIB base of 5 as having
>> %rbp as the base register. However, a SIB base of 5 means that the
>> effective address has either no base (if ModR/M mod is zero) or %rbp
>> as the base (if ModR/M mod is 1 or 2). This can cause objtool to confuse
>> an absolute address access with a stack operation.
>>
>> For example, objtool will see the following instruction:
>>
>>   4c 8b 24 25 e0 ff ff    mov    0xffffffffffffffe0,%r12
>>
>> as a stack operation (i.e. similar to: mov -0x20(%rbp), %r12).
>>
>> [Note that this kind of weird absolute address access is added by the
>>   compiler when using KASAN.]
>>
>> If this perceived stack operation happens to reference the location
>> where %r12 was pushed on the stack then the objtool validation will
>> think that %r12 is being restored and this can cause a stack state
>> mismatch.
>>
>> This kind behavior was seen on xfs code, after a minor change (convert
>> kmem_alloc() to kmalloc()):
>>
>>>> fs/xfs/xfs.o: warning: objtool: xfs_da_grow_inode_int+0x6c1: stack state mismatch: reg1[12]=-2-48 reg2[12]=-1+0
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202402220435.MGN0EV6l-lkp@intel.com/
>> Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> 
> Nice, thanks for finding and debugging this.
> 
> Would it make sense to make the check more generic by putting it into
> rm_is()?
> 

Yes. Making the change.

Thanks,

alex.

