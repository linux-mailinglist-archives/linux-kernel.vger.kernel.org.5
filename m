Return-Path: <linux-kernel+bounces-138198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE3789EDFB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 921991C22478
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD7F156996;
	Wed, 10 Apr 2024 08:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P2IjRw5k";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XqEYo8yK"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ACB154BE4
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 08:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712738785; cv=fail; b=C0J0//x9JYkCjKMIPjJWirB0TU4D2GfdoOIIM/kQ+y8bFuaUBD2pL0i5Ue2IZUHmiWItbki1lxCyc/7p7PIx0iU+Kv4K5yO8vs71cJILljpuTzZWE8Ao0dzgSPlm4OleydvJt/AdaC49GCQPHIXVtyqmoaHgc4ulrqNKNcxjlNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712738785; c=relaxed/simple;
	bh=BQD8YEbN9OiWh8O7zkV3wH7ZWucr4KZzopoylCYUmks=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SbH6bExOuUkgZ2922cj1fbP/Jn+wdloz5nY0J4gXYJpB2Gy+5PNcUkAKhd22pCTvNDih8QzHwaYwh308dZMRg1yGsWaa4GHvxaeFiUDEHREGh/TMc2B0LCsi+gtsQLSUqHvvViDjmYbU+Ny83p8s9PHCr0rKTT3x7aqdFancJmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P2IjRw5k; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XqEYo8yK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43A7k1hA030740;
	Wed, 10 Apr 2024 08:45:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=W58LRElyN245gLBnfsZEqawoNOy6ooMlDxYR8J8PHnI=;
 b=P2IjRw5kZ1k+kWonVzj35nNG80INTW9Dl18tFQ4JBzhV9BPbDO/ojGz5HYBqb8Q9437p
 bD1OElNtiCzFvgEmy8uKZfT3VXnn1ASzBDy5uIJNeKnxit7uB5yov/IQ1x/osRtGo2e0
 HrRqvVkK4VG/fER11MZAcWo2FFN2RtSpAldV4OkYswGbe1MDDhmqynk6Fycslsa0Gsd5
 VuB8qUHRHnk0D3XqtXKIbU4r2kt1kQEIZr5le4ahiAzCfRnmzioPhRPcPGM3QK1k8v1Z
 8rikfE9eJJyoGA73JYHoz/JiKreM+MF9akC/l/jvQ2/k3Csc8jnam5MvYkOLoft9z1XO lA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xawacpvbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2024 08:45:57 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43A73XHM010733;
	Wed, 10 Apr 2024 08:45:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavu7u4gq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2024 08:45:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPDmNVGdLOgZhlliWWMNEY91uOBIBw0FmbIeY6KVigzMmq9//qmqAizqbqx7vIGatS+rLzV0k+PdiCtOg570tyi8m22HDEAW54nscZVoR2E2v0YWfAFEVk/0NdPp4nCtQVvQcIyluf9rpPjjiZfXUhgvrE0rHcPghIY9547vsavqpxgD2guSsPavOqRmHRbmZpgyTXX7Lr/wTLm6APciZPG64WwI6xTfyvSVz5WETFewjREazyZWnFIsOB1MgkRwEb+BlFXg8D83fOAUemWYRyWf5EiArxxYoSwe4xODIjFPOGjdBzRKCE40AXMRWVrWisR/PA6j9yfzCbjILDq6HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W58LRElyN245gLBnfsZEqawoNOy6ooMlDxYR8J8PHnI=;
 b=R5WIYLqT2Fz1BMYYPC6sClqmR3j5CVrKtamgIDj2kgh3zkA/1UV4oG/BWPf0Dcczqj4Qk/xL0NIFCjR2zWiHhSppDO60b1M3Dijb1Ue4mQeSIc/Q0dkeh1DALvINzDu5uNoviFNWOgeHj3YxkbSQVoLaOsqvDz0Cu084QfLDZlrmtSjiXy/oohZZGn1TTfRE8rtoqRsis4hyJGTeRYV5ClYUOgFchz2VOdAZKR7n0alydwAFncvEOBBDr5JJNIv1inNvQNnisseL2oEtmE1KQUcJbQwaiiC3sX3U1XoadBTylida7VwS56M3nqWUbUz/juAevFadG+vRgXrgQk4d8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W58LRElyN245gLBnfsZEqawoNOy6ooMlDxYR8J8PHnI=;
 b=XqEYo8yKIuKSCML9SJQws3LhfwaEnKc4ijMmmO+VAmctUWlB3ckYQqleT10CWmg9swdLxhoezqUhi0hYuc9s1qRowI/P/LSktIcS3ieTPmhNIz1RtvLK+qtm2CTJSy/QH/A2O0OWM5ISDjpzpmCOuQXEE8mU1O69aARi+9mNZZA=
Received: from SN4PR10MB5622.namprd10.prod.outlook.com (2603:10b6:806:209::18)
 by SA1PR10MB7831.namprd10.prod.outlook.com (2603:10b6:806:3b5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 08:45:55 +0000
Received: from SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::1481:809a:af18:ac44]) by SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::1481:809a:af18:ac44%5]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 08:45:54 +0000
Message-ID: <c0bfa2cb-b328-4468-a952-03a8b297c22e@oracle.com>
Date: Wed, 10 Apr 2024 10:45:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/bugs: Fix return type of spectre_bhi_state()
Content-Language: en-US
To: Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>, "H. Peter Anvin"
 <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>
References: <20240409230806.1545822-1-daniel.sneddon@linux.intel.com>
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
In-Reply-To: <20240409230806.1545822-1-daniel.sneddon@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0070.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cc::10) To SN4PR10MB5622.namprd10.prod.outlook.com
 (2603:10b6:806:209::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR10MB5622:EE_|SA1PR10MB7831:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9FHrYwuyZ0g+RSL2DRQM6WnyeMgmxKVwLHEUcEHSswQ1ZpVd4iePX13LD11yre360gl7zk5S0HjylX6J+xESX1A8A3B/8L9ipwrEyTR7spCgq5XAXlbNY5zGBqyS1xRDrq3c1snwQu4bAnDjiz75MKVfY3ieEnjRbdGhyYTXft2i60d4Aq19tfgivB/YO8SwdRqMbKQ9GWsXZTkfWGeIADSwPGSTV63yhCMlyxdRVlgvdA4kr6GTz80XHT8oV8xWBcSqbFTZQ2X2YTnbVGACi0hs/eB46HrrNB5p+jjBdlL/iFMtM6TmK82r33HVua6vLkWIDh6LZ1VxaXKCtvKCVGxN3pyJ3mhHKmMHXXlQdFMQ4s5Vz+YJcMtll1kDtbwNSuU5tVBMdduUTq4oGG5vu3T3UTaRei1ehWytx6fppaboIsTAzKfm+gce/vkld0ZiV8qlcI9fEewpfSiXGC4GRsAsEn8Tl9YrG1R5KZ0JTbQXW4W+lAAVklXBthsnVcYqFlI5H34bAPy4n5UTpNTr12n5HKVMMvRX37Rk6j+e7bJbnki5YgZJ79HzCWO1BOQlErOlyJD6Dl1sCcKvXpXSCkun+e2fGeTfxIpZs6ro5MZwMQ5PQNVQioWS+KMmoI+mtvZAPxBDJdXDWYG+lYuJ+BNQ6Xt8/S+IQU1bDxRgghg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5622.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UzRCb0VDQ2Z2SkhuVERRSGRWNHg4RncwNGFxMUdkMEl4T3BYRzhRZjdiVXFI?=
 =?utf-8?B?T2ZSUmM0eldYNlhDYlVmT1pXQXI1UzZFdXdSejVVNFpaTEEyczlWMUtlQVdw?=
 =?utf-8?B?bXJkMmk0OGVnZVI3a1hYczVIc1o3U3NrNWVMMmtKdFdyL0pPKzdtdUxnVy9F?=
 =?utf-8?B?SEszcUJlY3ZoNkIvaHpaWjBoWWZhM2pZeTd1VXRJSDBmRlIwSS9mTHVGZVZu?=
 =?utf-8?B?N1k2UExGdXZTVEw3YjZqNkJ0UVdjbVNkMHJFd0gvMFlsa2ZHSGlUM3FsNU1x?=
 =?utf-8?B?K1FGZjhhb21yblVBcWxIeU13Vk9yaXNnSlVwTHlYelN2K1VSM2l6SnFzOENS?=
 =?utf-8?B?c0l2cjVFZlJ1eGNzVDErUDJvcmM4RnNGRDZqY2t2R1Bka2JXbGxDd0g1aTFE?=
 =?utf-8?B?SE5QSUtwb2FIRjIyN1pNaDRzWUsyaVBTdHA0bU80YXVWdHB1WkFMZ0sxZWJ0?=
 =?utf-8?B?a1dvN2ZvbU05ZjBuV2FvL2Y0V1lDWnhmWllhVlRrUVN2YjIzS01JZFpwRmM1?=
 =?utf-8?B?RlBMa2NodjFBc0J6OVdQY25HUHVGcFYyQ24zTDBYMGFFWmhScU5QZ0FaY1ln?=
 =?utf-8?B?S1JNaTZpby9xNlFSQm9rUnp2ZnAxZ3hJRDFTeVBDM0V0M2F0RWpLb284eWJZ?=
 =?utf-8?B?Q2xLR2RocmhBYW85T0dOdjd3SDk3c3ZScndoTFcvWndXOGsyZUliZWRmRTRn?=
 =?utf-8?B?eWdLeittTElxb0x3RlhNNW00Rm43TEhLdnZRbnZyd3VoaFJhTmkrcWI3ekR1?=
 =?utf-8?B?cjF0Q2lHMzNjZDNJdFFUYVZjZTU1Y3ZNZlVMV0VjVUZwdU5DRG45ZzF6V2or?=
 =?utf-8?B?ZlYwM3FQRmdIT1hRZVlFbDJZOU51U2VtVEQwNmhFV0prTGRKOWc0R0R4RjVp?=
 =?utf-8?B?OHhaNTdaaHBDZjlOb2JhdSs3OElBUEhqcWxFcThjU3gvc3FKOEFxSkpQYWUv?=
 =?utf-8?B?OUM0bHBsMVhoRDZhVm5jVElQSTExVzdHeHRxZXBDcWx4Qk5IcHdoQmVFUWZJ?=
 =?utf-8?B?VXhvbGdyU0VXY1cyc2lBb0creHNYY0RhZGtOYjBHMkNuV0p0Qm50OXJMV1lq?=
 =?utf-8?B?cEx2cnVzdnUrek55eDd0ZWRFaURKMkxGQkJBWXR2ZE52M3UvdFlMeUQwZVhM?=
 =?utf-8?B?QVJLNkFvUmtiL2ZQV1hLTHdiNG9yS04xU0IzT0RYMDdWejFIWit4YStWS3Zs?=
 =?utf-8?B?anBRNkwxazJVdGFQKzZJbEpSTUd2R2VEaWMyaHhpT2J6bEZnVGFOcHdOaHFO?=
 =?utf-8?B?cVRaK3JNWXVtaHJsVnFZenV2TnNXdzlWakFramtvbmFZdllqeUJ0NHNWcUZh?=
 =?utf-8?B?WmZPbEhEaEprZk9wem04bXFjVXZjRHlBazdjKzArd0JZVGhvNEg3RTZ0TWJS?=
 =?utf-8?B?dWxsTmlCR2FkM3k4R3A5K1dGd2ZhOWx5Yk1TTE5lV3RaTmgySndhUkwxRC9t?=
 =?utf-8?B?b0xrdDJ5ZjgyeEg1VkY4L1QzQ0s3dFBBcnppaVBWR0c4VEFza3dPWDVDdHBa?=
 =?utf-8?B?alpXelowZzk4ZWRJWjlHN0ZlMmxaNUlYZXRoVnZ6Y3BGZEpHV1Jscm5EbElF?=
 =?utf-8?B?OEtFa3NJVkJzRStONmFsV0M0L3pOMnQyQXBnVzdIWlZyb3JGQ3JQV2U2YVJm?=
 =?utf-8?B?STJ4RDV2R2FZOVlJMzVUMkFHRDdPaTVKWnZ0S0FyVTJObWhYL1B6R1kzV213?=
 =?utf-8?B?bWI1MkpMZGlmRG1xU1ZnMG1JRjFrMC83K015czJEU3BqSHBwRFY4NUlJR1Fs?=
 =?utf-8?B?bHJYcjN3bG1RVWpGY2lFdnNxREpQV05MSU8vcjd1V0x3SkpsdWFaSnY5MkJE?=
 =?utf-8?B?QUtMQTVBWGZEbkUwVHVOaGpDWHQwSHcxYUxDTkN2cm83dUdpRE5WSnNraDUy?=
 =?utf-8?B?Ymg4QUFIWkJDM1k5MnQ1VVg4ZHJvZDhrL1NXR0xOZEljYmIvd2hHMHBzdkF5?=
 =?utf-8?B?YzdQd0x5MG12ZXR5MkhSdGJhL0JJQlFRalVoZDNMMDQ3UVU3STgxQTdGNnFq?=
 =?utf-8?B?WTZqZnRydG8rVTZGdFFhaHIrSVZKVGg2L09yWklsMGlBeVp2Q2tSUUNFN0t5?=
 =?utf-8?B?OC9PNnNsaGlVdjAzdTNRVTdxUTBMYUM2RG1lOXQ0SDNMRmhTOUptZE91Z2lW?=
 =?utf-8?B?dWtIZXVkZVVXRU1xUXZLdUp6WDhiekpsdW9idEU0bjJweVNMUHVsRFk1QXdP?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	l3J9sBvGBrIrPtX7RmuES9b7WOP2uhF9PnPAEj5nXgZafT/FAyl3pPI4xCd6jUkivk4AKhENTQ63Uf29e+B4emiGUehTw1qWSH70wQa0av1B7KsJWlsnstK6zFwa8Fo6CSa6DXJiNt8CsS429YdNlqffwvUE793aoQDMVl9X742DY8fbts4IJnGJ+Bw7HAvfHlCl4V5Dt6giIvFQ/pCh6xgn0jxPj6lIS8csQpYZDmo3aVNhRwKZtcs987oKT2B0njK7kEk1A9rVSa6rEx+kteGrzNW7pA4g+h/RpB0vRcei/ooeNyude7QC4l6BYcBQMvs2h5ekfGAwcfPcboBHdBOykcQbVL4Fem2TfvAHngnKGTLOz6c/vTI6PNWB9GClp5XLMJFJkm+QOj27UrTrP6cdZHALIOwTpWS26kPMukpGkYx6PU4127IV2+7ecnWTfGpp21yWlF97JQf614mRvcAwuS/oBjckzryU1t98MUnP0Qoq97N5da43czN7Q3TtrTquNvVw2jEdvCf85pznVrLCIw/5vAtbj5xisnPVZULGcsMNfSv+aRKV6lK2psJnTn/4mCc1gctIiKjEzIu5/7meaZHbOk+uX97WKVudJow=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0b3d90-1246-4ae1-7df2-08dc593aa260
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5622.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 08:45:54.9671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rniUd9bRTuq5Djs06qY/k/4P+RT0ZRD2WkboSZOwWLJk6P8qvShxm7u3SAEQcQb6Ympdf6yhb8ROFcF4vT7oDYEmBMDP9uLmNIeTjSeXoOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7831
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_03,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404100063
X-Proofpoint-GUID: SywfAyRfA9_sYaA82OSX1yBnVNQ6EjIk
X-Proofpoint-ORIG-GUID: SywfAyRfA9_sYaA82OSX1yBnVNQ6EjIk


On 4/10/24 01:08, Daniel Sneddon wrote:
> The definition of spectre_bhi_state() incorrectly returns a const char
> * const.  This causes the a compiler warning when building with W=1.
> 
>   warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
>   2812 | static const char * const spectre_bhi_state(void)
> 
> Remove the const qualifier from the pointer.
> 
> Fixes: ec9404e40e8f ("x86/bhi: Add BHI mitigation knob")
> Reported-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
> ---
>   arch/x86/kernel/cpu/bugs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index e1775debeafe..7e4a706cad80 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -2809,7 +2809,7 @@ static char *pbrsb_eibrs_state(void)
>   	}
>   }
>   
> -static const char * const spectre_bhi_state(void)
> +static const char *spectre_bhi_state(void)
>   {
>   	if (!boot_cpu_has_bug(X86_BUG_BHI))
>   		return "; BHI: Not affected";

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.

