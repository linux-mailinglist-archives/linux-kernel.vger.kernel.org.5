Return-Path: <linux-kernel+bounces-138242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1377089EEA6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB65E2826FC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC4115A4BB;
	Wed, 10 Apr 2024 09:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UsZ63w7E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ibTl5Ypf"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE67D157497;
	Wed, 10 Apr 2024 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740669; cv=fail; b=axP/ljHBUu5T5ztBae1zljNAFy+SCBhagKp4O14FcsgqbDvKzxXeg6H1Lthy9JJLeTlXuQ7pFaeV5RRrujeaXgxYrRtc/ahb+OXtvxurxDX9RfgfeFrlD6TbbG3+Pi6iXuqESqA7XocKqwYzaTeuGabkSnM54gzFWM8Wyknm6LI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740669; c=relaxed/simple;
	bh=UR3QSC0oLLO5svJh1sJZnlqJlSU3+L1qBg9XN1wDlhk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kekk7XZxvTMdBgg7agQit5lw83PktaT91Ph42FFCb8j75VB0pzKgwmvJcb8HGIBVRrzLwS3aAAzF4LTzKVfcqGPlhWFUpYTNSYydcxCzVWXPqLpoUZSqPepAUgVUpkAhKGxYe/AbxyghHg/kL1Jg9GztDVem0lPm1kjrrOwcnEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UsZ63w7E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ibTl5Ypf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43A9GHbX020156;
	Wed, 10 Apr 2024 09:17:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Bf+UewUXpYx0PEt0j/iU/N8hwWuWJYc1FPfhdyGEdtQ=;
 b=UsZ63w7EgAachgxg9aQZlGu5ixBzAPR1KkVyFUn0Fi5ecjLz2u368kg2//dlm4Yrsmem
 3SsAYi8foneTj9cs4va6T6nVb4Y+rk2nDilX9NylWLy2M4C/DaKzwPhZaMQRAHbjfB4n
 fkBQ8NJCLfWg5ijtrmzKqnkNUD3U2sEsTEQ+lC/K9MjnNTkc6LkhlSFpaB4k5BSTVW/+
 /6QdShQR4FBadnPsPtVQSnynwzdB3JEqYyNsrzSA3cqECXifD1pzPgqZvglEuv8e6uT0
 xX1CxKzkGpVVDQwNgPNxXHzj7/e8onTPjJbfbSehvB0DV5MYCmGKfQAoUUTxCFIBo3qF GQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaxxvever-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2024 09:17:17 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43A7bdjj019999;
	Wed, 10 Apr 2024 09:17:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavudw65k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2024 09:17:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdUda4wfnklDwChjxxi0Zl/HZrOUO18KKWT7URetgh9S7Ms0rERbZKBAP25KQXosUVAsKC0P5rf3IPurPSR3DX8+iNKGUquCJAgtlAl0nNw3aCByNYebMbKf+dWgPzyBsxt/adoSrjKRlxng4d4ZT9Q+MwYBWjs+LNxHwVleuFXEzcR9xoUFcvTqeEEnCKkS6urGz8tNvJxet875cPFDsNbtZiqXiKOFnm+4XrD43bhBnFBX2OEFBpxNok9CkJc4+VRGNKIQm9Nzvuu5ydSwa2S7bf1QnUn4d4Zsj94bgJh8CifH+B1cTd++/2fO3ovTmijJcy6GlKtkqf/7dh0SAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bf+UewUXpYx0PEt0j/iU/N8hwWuWJYc1FPfhdyGEdtQ=;
 b=AnhbnuXjPnHOytwk69u2WUJeeOFoAn+Dxtc0Qaj5p6q98GkdTcuHsjtARX7+vkE4FZYxqqIXbgP/aBYPduTdg4gxHKD5VT/PZVrlgBS3qeOw6q7pnVdU9ACINskAIhk/pqRSg7/pewAGRcvphdla4DFxZDedgZ+jYlZagaMoipFEu9RSHcVUAkBcUzqaPNn4p3lg9CkRCLj9oQ53olGCc8mLg7xBbUBZbrzlX4/FKykLV+F9jnPMQR3oV466xNLyBA0kQvPphO7TiWJMh6hK27/KZHU6v68uPThz8iq+xjKwNGpwXeiOAU8Q6HlWqur9rCSYZBMHTpUIhmc844TKmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bf+UewUXpYx0PEt0j/iU/N8hwWuWJYc1FPfhdyGEdtQ=;
 b=ibTl5YpfXJpS3+ybRilEnXwQC+60+rz8QKymP+JrIRMQF97oHvFAHJNcsbXdwFUlkElSNLNcrdoHySDcEFE3LfuthLR/ZhtdEhoU2MTUSJ1c03zWdl7XsbSh4cJp+2i2fvUCED0ZwRYxFqRwxXbtE7Sen1KWhUImlobwHgaTuNY=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by PH7PR10MB6459.namprd10.prod.outlook.com (2603:10b6:510:1ee::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 09:17:13 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f5ee:d47b:69b8:2e89]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f5ee:d47b:69b8:2e89%3]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 09:17:13 +0000
Message-ID: <c7d5f4ad-124d-4bbc-b679-2bdc9bce0428@oracle.com>
Date: Wed, 10 Apr 2024 14:47:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/697] 5.15.154-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
        broonie@kernel.org, Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20240409173628.028890390@linuxfoundation.org>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240409173628.028890390@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:194::15) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|PH7PR10MB6459:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ZhBX63mx/2WFI0N79lcVrZqAOoKToPYT6Yn53CKMUS3TUb2FMzHhzEKaDGKbneHHy0Xpff8zGOngPg873L5uZZPNUTiqb2edvovTCz5TYyprb6IzVCHH5/VMwSgN0c+Pphx942ikoQOFq5SWhRYhWynlS9u2oEClSeWmw42MjHamizQPmg4l1PoTAfeH1y5O64izPSAWCWywS8ZJVH0PzMuzPocEwh+tVYj9NF/OPEkslJIRsqOxkWT4Qs6+tvOyHy7DddEG1v4g8E97jebRDwuaIyXdvcnSE6/lFhVBar63wx+I0f0IZesTbIlSI6/T8aMY/XZWa9WGP1WvQ3LqlwmCNpsltcNWEIdgiYYHKeNK5NQUzWWibf+GYZbORPzKf7be7KDad5z7IiDcTkKJ6XgefdJz0sQnIUNn89YQHZxhqlzApykr0p4mrSOc39d/U9p2/52H6OVgoGMfTkRAGzj8A5tzHPYxnuRs6WTf5zTytXI4SePpWNoIllzp5y+8/f4tfQZQCkWBes1ITy0/hOgRBJZ5/9KC3vNRWyTmYn8T5ayFeli5qHrcE6qxdBUN/gP8FI7swGeh8d61vQYQpnOgsa26sXW5RUCmSjne5ok1ITI0o1Cpd0lwS28kWz0PNs3/adXGQY+hhUhHlis0wiMVytJfWLzEXbmAWZYnkaI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NDRtTjlTditjZmxSdnhvTFFkVTV1ODVRdlNvdFp2cUN1VFQwVEhqZ0RiOXNp?=
 =?utf-8?B?ZjJzZHM4NmFWc3g2UzZiazFvUGZwMTNZalo4bmw2d05uRFFWS0ZIRmpRNmk3?=
 =?utf-8?B?NzdsRzlucHM2Vm1PNlN2V0QyOWFPSzZjanY2RjRieU9FckgzSzZHK0dzUnN5?=
 =?utf-8?B?OWF0QllENE5wRE5mOGwwb01RN0c5WVp3ZURlY0xORkF2clowN0xDVWNKem9n?=
 =?utf-8?B?dGJwa005YjFsYTU5VUJadHN2WGNJNTMzcEVNeDk2bW1RQVczZGJLMU0zZXhj?=
 =?utf-8?B?ekU5NldJcjZmSzZNN3h6bHpJNXkxcWxEeFZ6WFdvelQ5cjJyWStDek9YNVQ0?=
 =?utf-8?B?MWYzNEN5QzYrelVjbThBM1FxcndOeXZnT3FEVHBUQ3lvbUZQSVF0L2JxRmUv?=
 =?utf-8?B?My9OZm53QXRVWWl1a1BwWlYvTkNnc1NObGd6bnFlQVM1R3VHZUx1ZzQwVk1h?=
 =?utf-8?B?cUxTRm9wQS9uZ0ZxMnNsaXVndWJaRGtUTmNRLzlBUFFhRTNFVEJKaXZHUVV4?=
 =?utf-8?B?MEhjL0xlVXVJK3krTWtvQVRnRldzRHNMQkdZVEpJNlFGbFJoY2JuMjJqdXJo?=
 =?utf-8?B?ZmF5NkR4S0FHZWN6NDlJVVhQclFIaEFkL3JYb3hEUHV0d0VyaC85K2wybTJK?=
 =?utf-8?B?NjQ2b25RU2tGUFJ6NUFCTStWb2lJVFRKWGpKSUpmT01JSlRxZHZoNDlBdWVP?=
 =?utf-8?B?YnYxRFk4WjFnV1BrM3VBc1RaVEFxR1lsTjVhN3hQQk5BSWlGUS9VVXVEdFJ4?=
 =?utf-8?B?K2JxT1NhOVVEVy9NOHVTMWNrdnArK2dBN2VVV1dJK2JxcXlBNDlIWFJyN1R5?=
 =?utf-8?B?ck5Wb1BRNmxSVzkxSEd2cWhpTEh2YnVnSU03N3ZBRUVnUC9saVVTdW9Xd1Jt?=
 =?utf-8?B?aUxsM3NRUDBnaGR0ZnZqMXdJbkpMWnFXamt2TTFZK0tQbm50ZUxaanFoZE9I?=
 =?utf-8?B?L1EzaWR4azNPbFJJL1FRbWJOQStadGFLVzNnNHArck90d2N4MjZxemZLNFZp?=
 =?utf-8?B?ZTRFUGlhcG0zUTZwRXVyNWdreWh0VFNyWDJlWlUydHNWV3FUMzErUkkwb0kw?=
 =?utf-8?B?T0FveE14OXc2Mms4M3RjU3hPcDZ4dTFFY3RyeGxXVm9NV04yV2I3YU5KdVBz?=
 =?utf-8?B?a2lBL0M0Q2NCZ1V2bDZ5akE2ajFyTUh2UGxDeE80a3p1N1ptQVp3d3dVM1Fn?=
 =?utf-8?B?SnBkTEFua2NiNjNRaHZKZDlCTWtpUndnS1BZOExZOEt1WUhHNi9FWmo2OTcz?=
 =?utf-8?B?UVlMcnh6ZUl2eGM1OFVyUzU1M0V2dW5XNjJ3dS9HTkloVFFmSUFyWThDVStq?=
 =?utf-8?B?OGYxby95ZVlWM2VoNzU0NmZsQS9IeTE0ZW9PTFpLZUFQaHJrSzRIMHJxalRM?=
 =?utf-8?B?ZVJ0dnNTbVh0L3dNZ3IvQkF5TTIyL1ViMnBEc3puVEN5eXBacEhsZEZraFZS?=
 =?utf-8?B?a25RdktsRysxbVJ5SW9pQkRRYkFPYVJaRVBJNHlPTkM5RWd3bTU3cmdya3N1?=
 =?utf-8?B?NWNaUW9OTlpRMDFZRU9ScjNKYnlNN0ZaMVRNYkNVTEd4YnN5NXp4L3pMYUtO?=
 =?utf-8?B?NDBUeDdFbGV0UkJaTGhXcjdyWDNyT2tJdG5Ecm5JbzVyaEpXNmNuREo1dFo0?=
 =?utf-8?B?bkU4N2p2bERMZVkrWjVoZSs2TE1FYmFWYlcxSkQzQjJXV21CbU5UbTh2UTNp?=
 =?utf-8?B?MXBobkUvMlVVL1ZtZnVGdjh3QklaOXkxeWFDbkY5ZWo2Tm1BRU9wTlFlZGs1?=
 =?utf-8?B?V0doWURnazFicUtxZHBvRksyNDU3N2tGZk1YTGxEd1RJU1VaSytreExoOG0y?=
 =?utf-8?B?ZjAyTklwL0xXYTdMN1FHOE5SdGFOelFMeENYNGhVamhkMnNOM0N3QTVnY2Jl?=
 =?utf-8?B?dTliRTJ0UTRtTUczOXBST0hDVkZtakoweHVNVzBhSW1laXNZSU1ZZDltci9N?=
 =?utf-8?B?bGFlbzJQTTllcFZQK3V3ODgzSHUzQzRKZEF4SGFzVTFYcHpwUWlWakl0dk55?=
 =?utf-8?B?bjIzOXovNGNqTVhSUmJ6eVpPVllWZ2lBVzh6RVBqendJTHJiR1BhUXFLTVVn?=
 =?utf-8?B?ajlvZXIrQVRtNmJscHBGKzZJbjNyNUtxTnZ1SDBkcCtYRVg4YktxYzhpOVJM?=
 =?utf-8?B?Ky9tbGdYMkUvM3dEeFhvOXpodVU3dzUxWXRXTmw0WkFQRDVldDFaZVdXZitX?=
 =?utf-8?Q?u1o4WYTsCAw+w03tnPQ7hUU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	owthRb6S6faQNbs9TK1P+oAzDDIoMz7f1Vk6+2w5T4mCE6Q+w6x76uH/C9AVLZ0kgnZHGkGs6TAQgcXZol+yFz5/DVLkXgHSkIFgTy+Bo5L3LaJOT/t+zSibc4OLQ6GvhiPmYSh+LwME08abOLjw2gBiImWbWQRjQ4g/fefp7315vSYUp1X3WVHc1RqIw8OitVqOHKSzfxbBoyNO24SFtkRFEPihoGemqO2ydFkv9POIwHKR9zGpraDN3G5phAxRx90OYGySRkEg5rVykZunsB1D+1RNgjh+SejZxAS4fdb4/VH2hvHONsVOrDWkOCU621+SrHdsrVd1ppe3T7OQVmBbZj5uBDaNtswK4Ef2C9S1gUWodVE3PUB8kZs/8spx756/KZjF9sm8hBWX7UR51TmauUDg1wtdZhvzMYQDIkuTFpoIB6ONh7hbUwNS+of5X20p2vAdA+/XNVx3KYFtNMLDsGvBbVoNx/nQKYIaznFluE86nQpSNIbdqHMpRkE9KfyxwgP2QH1YSj5Q6CadHmjfnu4ZKc0vPbRUdvqw3HJQ0lJq3sFGPO9GQcvQ3kdvBxAqb+58mlMWPqfAByIegpHfSJ7VJZJZ0HYfbDt0rEk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4cbde8d-dcdf-40e1-0ff4-08dc593f01cd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 09:17:13.0778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQbdsRICO+qidGjin9LsDCV7ZFtGn8FIcL4SVDB8e9TSNtDh8X/EPZZHbCNANf7JMqisGRStTogP3hHCy73srzwnaRR4kOAOlJLgjHaq96/OOjgASqJGZa5scrZmGPzn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6459
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404100066
X-Proofpoint-ORIG-GUID: I0yAwNmi9U4ySiSS7Qb-FmUAsMP7VUyU
X-Proofpoint-GUID: I0yAwNmi9U4ySiSS7Qb-FmUAsMP7VUyU

Hi Greg,

On 09/04/24 23:15, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.154 release.
> There are 697 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 Apr 2024 17:35:00 +0000.
> Anything received after that time might be too late.
> 
No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.154-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

