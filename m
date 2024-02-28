Return-Path: <linux-kernel+bounces-85020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8529A86AF37
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAD601F26398
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D75A145351;
	Wed, 28 Feb 2024 12:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mDEH1K7f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uzepz/MJ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A110208C5
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 12:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709123536; cv=fail; b=RDzUz8RlPbXW2HTfMRfjJXwGB22MSLMk1LamVh6sAvhjcpyrRG2CXiJtohIA6oLD+8VyFkZo2pK7xXIyOmwH0GmNBzrLtfv7R3hAO6rQjCjmDEiLC4Dze2iQPIr6wwc7RDSOWFaa8nc+T55iPXP0KBr0wVrUXrJxLa/oj14eBjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709123536; c=relaxed/simple;
	bh=Bp2+z+/Stx7USeSn+tHSjHVi3WX/GfPGXK4Xn/HUUcE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rFbvEJmZjT0uZRViknhT3oyuRJHlC/g7/Y8QHFvkKBGhwUgzw/j9S3ufIHle08YSz+T0GwTiDMvxsBHd19w2gp4kQFl0M4Wsg7RPB5lH27Aq4He1y/uLXbjJi9SMYmBPVQjcL4ya2cXIwF5QmZOgeVbaMCYmp/610OUFqFYeORY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mDEH1K7f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uzepz/MJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41S6irct010236;
	Wed, 28 Feb 2024 12:32:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=3CYsvNaItra9FsCVFd6G3Zk0MwNfUhLGw+yDguT+AI8=;
 b=mDEH1K7fB0iV1g9Xl2CX5wLxXc+saKlZD6+U5Jc+Ke/bodY0KS+pjfFvv0lYzKnEkZtO
 aipUQIbB4GWNUilcnylDNg4xg+yw66oxWEvxqMEavFPt+AsG6l2lSNDeqedvJ8TmZsh7
 2DthzA42rsyAsX937AUpHgexSeW/h4LxtS7+iuga6Xxf+/1V/tnFId6oDfR3fRxMx04L
 q1171wdnVZgrYs/ARD+3gozU0tmzNSbrrcI4Kl849OKSm4W3Kj/d0mYmtGvJ4Q8dj+Sz
 jLNiXpaJyqMaDLsY8YC6kRYwyiN0TcVf7HBfqKfec/5P4QfG0EQYtrhr054zwiaFklIl uQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf8bba0bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 12:32:08 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41SAutLD019051;
	Wed, 28 Feb 2024 12:32:06 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wgbdmnrmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 12:32:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8WtzGTcMW7tORuh8ul63Fpmz5ws0/6+wjymKgoLeQ/PmurtpawvqyT8SsNqIk/6XciztONxmklYIc14Yys49C7MdvLEYiUGwP4/xDSgmw40r4ci1ORdPpb1sFvBeWwqVW8eZ4A3R2dTZejvQEvV5fowIwZcqlIsCAW/Y3zr86vrgcYAnddg+h4YXuUzi4Rhcm0pMI/lvK4w7zczibhaphOqsgMRT2XdLa/n8GgujvncHqieihR/6wc1l74xV6ULLVl2TeXiC6mFD7nS9wgA6DMLDxg/azHf6iwX95JKfGKzBprtntKWfyI4r0OFEQLadzIORWpGbNCmNNFG3GkuTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CYsvNaItra9FsCVFd6G3Zk0MwNfUhLGw+yDguT+AI8=;
 b=lCFcn4CN9hchPnG4I1PekjN3uqdIIe9cm4c5m+81siwKgXQ9TdvcYvmq8fc9nW84ONPru5PZvERUGfDkFJGDh7p0VQM9yXPQ3hm7qQzBf8J+on41fInKbEbDHyxd/rFWqsl62gGTvtJU9qJYHBtnX1hE++TJBkxLVh5jLVpbNgqJZs5ru1hejA+ME+4ppCW4XEgXReSc7RD0P+JG6k4IxM1pgQyrKc3oSE1pd7fvynTyJ25UEjCGED+JYuT8oq/Vki8bc/pBfKoLzodJQh8nJFnbI/L9he1WyG0nT+IWa/gpcMaN7L2JtBzV6zPSEFvbB7kH/F1p2mqeozFXPEyQuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CYsvNaItra9FsCVFd6G3Zk0MwNfUhLGw+yDguT+AI8=;
 b=uzepz/MJwcb+uItfjOL7Fnl894zVZzstbAm17U3FcbnXiCdLKpX7tjVYgxq6gZCkB8T5EC/a+GH8bIBb9WO4faViMLvSdmS90uncEycUG+M03G8k2nd1t7xkg5Vm+d7VBTOJkCpkUMcLIMJI4jQZ5NUHClEDZu4mIWarlMJsAlQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA2PR10MB4443.namprd10.prod.outlook.com (2603:10b6:806:11b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.37; Wed, 28 Feb
 2024 12:31:46 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%3]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 12:31:46 +0000
Message-ID: <a07db8f8-39f8-44ad-b466-10ac02f3da13@oracle.com>
Date: Wed, 28 Feb 2024 12:31:42 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware_loader: Use init_utsname()->release
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: russ.weight@linux.dev, gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org
References: <20240222145819.96646-1-john.g.garry@oracle.com>
 <Zddt-U-6SdxkxqmD@bombadil.infradead.org>
 <51483aaf-d64a-4eee-b256-ab126483ad6c@oracle.com>
 <Zdy9gKO5Q6K4IE8J@bombadil.infradead.org>
 <ZdzGF9bxLn3Slbgi@bombadil.infradead.org>
 <cb0c185c-54f8-4b43-856f-685cc5ed3fc4@oracle.com>
 <Zd3cz7yYezir-P7e@bombadil.infradead.org>
 <e88b76c5-1b13-4ad7-a97d-c34722cfde19@oracle.com>
 <Zd3oke0pAL2G05Rj@bombadil.infradead.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Zd3oke0pAL2G05Rj@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0051.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA2PR10MB4443:EE_
X-MS-Office365-Filtering-Correlation-Id: 874cad47-7ac6-4768-0841-08dc38593a24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	MyymOzCNoz1fJFI1KsCX2I3KBp4f8WmZCdVcGFD0ZA6UKMQiBuJvrUHvvQ9oj1QR1AQr17/4YQjV5eH7dEC2Xt4M+bTZD+sFeYtMMGf7RIlfKJ8tYNg716SSrvvsmac+i0Ow4Eq8m99yBJAhuYSRGHhRlloE7JNHM/QvGC+m2+nCatgEKAYjMDlPIcVp5LJGES5tXRgs7QIlUuybKcKJLj0Tj+68V+3dEhrdmRpyReiYBLzXObwOLnOAfWh/U+u0bY5GRAo08c145r/JacgnxIXr6p7j/FDRRbtPWO4Pi4nMnMysMzQ3xscIzkFryUwhhl8402QMJmBq+Bu7XEDc5h1cBaBqSfFLD4vLSLn1hGSALNMpjb02wsBYy9mxAzzhgP3KDhdaE81k580fJaeFs4VW0UCuEtRqZLfop19v72GSLaF6zTnrAg7SCeO0m6bFbJVn6YhA5TcPztgZmNxCaN0maPGiApy7QfjqklvX3m3v+4o9RMKHyzGJCFEdUvi4pM9VsKPM2DNDFjxD9EH8FoQsxQIlU9432xSePut3gPI7MnbdJQpzKEUODX6hpaepucD1TwN4YEBafRr7Q9hZMhabRnJdnD3cWWf2/YKQJm1egyWhvth8Mv5GPrysi58DMPmIwG+Zw2MuMTFNgxe3xg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OU9wVHNGVGoxSnd3T0pzSEhIb3plNVBldUhycWRYN3NrNGpoanBIVDFuSklG?=
 =?utf-8?B?SGwwY0ZJYU1XLzRQSDZIdjd2bjJYTzlXZndyYW9SdzRjb0NBYXNsUHBXRzZr?=
 =?utf-8?B?UnRPcW84d3ZhTW5CT3BCWllha1dQUkFzVXMvbGQxUWtKcEowTi83MFk5Nnd5?=
 =?utf-8?B?cVVPVlVwVVNOS3BiRG90bGs1dllhVGZDakZLN0ZQZjdpOHhoYy91c3VCV3ls?=
 =?utf-8?B?dURKZjVGbjgrZUk4OHdvSVpBWEdoVForNWFCblB1VjhpUHlYY0FlVDBZRjBw?=
 =?utf-8?B?NUxNVFJIVnVaRnNvSzZQVDdYOW9YU2ptRm5FS0Mwb0NXbmtoaFRpNDFqRjhh?=
 =?utf-8?B?Yyt0NTBwa0VKUFBEMUdaVEE4bXFNUzdBb0N0emM4QTNKczlRMCt5RW9HY0JU?=
 =?utf-8?B?ZkJZSEJ0YUtXWVFuZG9kd3hqbVdDMDV1VHg0UFdZaVlON1BBWlBQNUxTbUEr?=
 =?utf-8?B?QjYrWmFXdTBzR0k1dVBGWEpoREJSNWoxQkFyZHQ2RjhaT2MwK0REZnBlQWpR?=
 =?utf-8?B?UTQ0SlYvS2lqSFRvM2trcjhwcjZ2VVYzd0RpbFFPTzE1eU1GK2QyZ3lTbkR0?=
 =?utf-8?B?TE1Fb3hWTnJHa3dxZk5sQ2tuN1NxNk1ScXNxTWtaOFpzeHRoRnl3QmV2dm1R?=
 =?utf-8?B?QzA0T3RhelYrdzBPeVNiT3JiaHBIemFwZkNUT1N3T0ExOFA4UDUxZ3VLQmFq?=
 =?utf-8?B?NnkxRnozY1Uxa3pGdnpiVVdad0VFL1hEZWdtdlNMdTR0aTdCQW5GQTZVRFZ1?=
 =?utf-8?B?bU9sbm0weHIyWUpLck9GNERaSGNrYlo3aFI2d3RydTRUYjJxaThZSXZmRTZa?=
 =?utf-8?B?c0g3RldGR2VsREJDZUU4NEJ5eVgvaDhJa1hSNlpwRXdDM1FqZ2pYNzdwdzZ6?=
 =?utf-8?B?OHJVRDZyN3dnVVQyN1ZZNHZCWmo1cU5KZTZZRHVia1JubUd0V1RpY1RhcUlU?=
 =?utf-8?B?MENpNStxUXpWS2ZkZzIzOVV6T3BGaFZLNXM3S2xJNUY5ME85MFluNzBseTZl?=
 =?utf-8?B?amRzL2RFTkhLUDNaTXVYMGJuV0krWG83S0tZYVNnY211bkpSOVkva3Y5a2t4?=
 =?utf-8?B?dHlLdUtZMVJTQzBpN0dVSktON0tBMm5FdU1tNmZaYmhSYVNzMEo2bWNWemR4?=
 =?utf-8?B?bm16N0ZNSFZPNk5MSUlUdEluL0FLYUMwZXhSRzRNREM0U1RhTlhVWWNmUjBy?=
 =?utf-8?B?VStIUThuQm5wWDhJaUphdnErTDF3L0Y5elMzZVp0YnY4SGRieGN0eUcwWjFJ?=
 =?utf-8?B?UC9RYWFKbkZ5S2NuUDZHMVhtQWpFdUpScWhTSmg0SlBNNSsrMUwySU80VElx?=
 =?utf-8?B?RitXcWNnU0ZyTXBjbG9FaFprSmd6bVBiRk9jb2NqR1l5TGZDOG41QVVXNGlZ?=
 =?utf-8?B?Z2lVdzZmZUswODh4WmFvVDZkUGN4dDZnZjgzRW1WcTErZjdBKzZZaCtkRnpn?=
 =?utf-8?B?Uk1PaEdZN3NoOG5STE9jeFJNQlJKQkVUVnVoY2REQXVURGdqOTVKS2hXMkZH?=
 =?utf-8?B?RXNZY0ZOVHQ4V3pKTXZWZXMreXRMazllY2JPUkV5cDg5NzloekVCQW9Tcmll?=
 =?utf-8?B?a0g2NlQzZkdidXhLUlRPc1pKK1c3QXd3K05ZbXhwNm5kK2FsSWF1SmZOQ1d0?=
 =?utf-8?B?dVZHckZBQTdKbkRxc2s4SWo2WEUrY20xU1ppejlqd0lyRnAzYlNQY25nU0tV?=
 =?utf-8?B?c3N2cUdQTmlvSmpTd0ZobzJEeHNBVU5pTExHeXhwdWh0bnNoRmhCdTBNK1pR?=
 =?utf-8?B?VmZpTE1lNW4xek1CVmJPRjVsam1DQUE2OVFlRDJFNGVwSHpqZHlZOW5GUG8z?=
 =?utf-8?B?WTkxTFh0ZjZvWEVZQ0J3dS95dGdZQ3BkZEhmdjdLbFdMOEQrK2JGYVVmTHlq?=
 =?utf-8?B?WE9IeXZ1Z2dtYkdlYzRkbC9ZZzFCQ0E3RmJsM3ptZTJoNDRTbGJvSDJPWDRq?=
 =?utf-8?B?TXJLbUxhU3YrcFcwUkJYU25CdFNqYjJ4K1lxYlhjZjAxRm1halNzN2U3OFpD?=
 =?utf-8?B?T1hXOEQwbzFCcDZIdE1SaXYrYzNJUHhkK1U5YW1CMmdqbXVaQy9HV1Vqb2FB?=
 =?utf-8?B?dGlLVTNqdnMvL3JaVitRTkNaRjY3ZXVZUXRXOEQ3ZUsydXZmTElGWCtaNldl?=
 =?utf-8?Q?o5SwGSWrE2sBJ9GeKdA+s/Nqu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	EZvg3cSq4yhdMtE3793b4sEv3ncklKnfq5tp6Jh6iz9CumdUIZ38AaXJmDAv2/L9Z6U1wLsZgIxi45Fls/zhR+3QiCGLw9WvSfil/dIw1N7KpYD/ZqIz9zvHN6z4aAUoEQyP+sUaf3etlONzoeyc4x9HTvgt7OwtV/YmY5NDeKAGOhaAKbz+LATuwPhM8Oma0M31k/JNxmOeQyaHIHhpb9cQ+lbwSO/ykWFstf+DnpU33gJTFRVeZz8ETAE6FNQVw/4FCFoFwMfTjjWoIltmZUJ/vM5vx/fi5FWC8szjHvUTQrd4WuLbx89GT/F7/AtOlshfJDdEdCxLqjf4gO6eXsGKrhAprLUaN7YhdhJxL5aPUe9bqml0hXV0hOEQA9V9AIqlyEGkI/ZlZ95P43x/8Q0+mpqcL1EB78Wse84FoiUe/qemq++TOVBTQublY/3kLd3q5wBB/6VlwUBAltWmucN7uAeOfpZt07pl6KlYmYP717+URIvAhSrqrWOz/IasqeNNc4I52liE2wAcHqMsq/1CBe4NR2PocjS9yxvvUF7dKXUchW6fP9kUK2nqQBZcJzmq76+y+hWgGNOr1WV3SSvlkrJZ7yk0Prkx1+O3aAs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 874cad47-7ac6-4768-0841-08dc38593a24
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 12:31:46.0503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGFUDP4xGFmFqeYNABEbbiUgpAPKrrioGOOhOMk/674L0hJpy5TQ6Fa43yXFJTnyuLMNCiF5zZHGLM5Vwd81eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4443
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_05,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402280099
X-Proofpoint-GUID: KrA18q3OYdgl0d1nb32DzZs2MTMZlCz8
X-Proofpoint-ORIG-GUID: KrA18q3OYdgl0d1nb32DzZs2MTMZlCz8

On 27/02/2024 13:50, Luis Chamberlain wrote:
> On Tue, Feb 27, 2024 at 01:02:26PM +0000, John Garry wrote:
>> On 27/02/2024 12:59, Luis Chamberlain wrote:
>>> What kernel are you seeing this issue on?
>> I was testing v6.8-rc5 last week
> I cannot reproduce a hung task there either on that kernel.
> 
> I see this:
> 
> sysfs: cannot create duplicate filename '/devices/virtual/misc/test_firmware/nope-test-firmware.bin'
> 
> But these are expected as the selftests tries silly things to ensure
> they are not allowed.
> 
> If you can reproduce it there, it would be appreciated if you look underneath
> the hood a bit, or share anything glaring and obvious which may help
> reproduce this.

Update: commenting-out /lib/udev/rules.d/50-firmware.rules seems to make 
the test reliably pass for v6.8-rc5, but not with my patch on top - I 
still get a hang there. I'll investigate that hang with my patch.

Thanks,
John

