Return-Path: <linux-kernel+bounces-74340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4449185D2FC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626201C20FB0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955923D0C5;
	Wed, 21 Feb 2024 09:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UIqn0Bhj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iXolGIo7"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0C33CF72;
	Wed, 21 Feb 2024 09:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708506069; cv=fail; b=XFWw6uxK0Wc/Qp5Hqcbt/CmVtGGErUtaTUPZprEeI1hM+z1AmPKBZTX8P33IEznKBWHr518wkxd2nrXF0+E6djget7Qz+4SNVtUi4BIEf7HG223qMxa3/qnKCp0LIuLdyXxfVXv4Wao2vNj2p0n8FF7ckMcmo6HbRRm2+MVeXyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708506069; c=relaxed/simple;
	bh=yCdMT0XRUuNhgrQq2qMpigSCQ/h5wHpdF0xY0D08QTA=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jndH1qWdDc3czIlYeiFI2w1NhIfbG2rlf3Q7IzWR7vEXoyL89ELAGffwCSBxxhcCwBOWj9o6Bkv1awYSSb+f6nEm/8KhyOZuHim8w2mKs8OKp8em3sMR/aOVpmNiZutrMwCZsDC15EPn4Is+V8FRnZzVyean0Vil72wqirJcSp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UIqn0Bhj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iXolGIo7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41L6dCUT026198;
	Wed, 21 Feb 2024 09:00:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=3yWWJb0QUEBCFczZYI+Mi9E0zqDXIpITjbVssSMS328=;
 b=UIqn0BhjmMsgD9O8Xozdn7h4s0rpyLgeFfALOY8cCW4dIOwsmi/3beRexrpLZos4R48o
 kSNg01FfjPH8YN25RFTBvGKLFprA4gmCJPj/7AXiqeZUN5IwW5bb1QjuouiWjcca4Uw2
 6vn5pk0Gk5KKJ76UwKkc0ddU/Py4vCQjwyoj9WJBWa8tavhLgzYszw9779d95nAYH7W8
 uosk/zHkLd7J6x7kGetY7mPmgc9flnzOMzRALHmJIojeLxolwIKtJrAFnAGTolQ2PwYx
 2YcZ89KCJXMNlAQHMQgyET12PUS2Ht5/pSbHM8GMFWGq5fG5RutDxCz5yiT5UmocG9KS eA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakqc95ss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 09:00:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41L7iquE038126;
	Wed, 21 Feb 2024 09:00:33 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak88n74s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 09:00:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofmgY0nHF4Cf00GAIlJ18POm3YVpheVZwkNmeH5ugpfm2pgMeGkbojzijDVZG+ZboqDFyoddANdHRpHlKjeJgOzqJpOmN0vGIJ0rr3oyDtoDTc8O4gcg1j3gwqyHaKPRl+J39hRWVw2PKtTzR1Dz4P+L4Kh/XOe3eRE51uY4hUgZ4U/qycL25wphKE74Xs+AabULe2QLpGCyx45UnVkZqiCvyv8t6OBX+hd+gJnKSra9vOY7DbQMwjjwdrkT0q4AtRkw/08RBOyY+s8D3IS5jYZXALLcD6T5nSslXttp46J89hmADaFPPKjzGliWHjFvcumHrT7GhKNAC89gMG8+9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yWWJb0QUEBCFczZYI+Mi9E0zqDXIpITjbVssSMS328=;
 b=GDFVaXM8TbZO1opCqA/CIdKagps+Wa0gqa+jTqxkcbvJEVJFao2jSSP20txRfLgJzBb+eFR8Wy4kevHNXAIGrMt6yIG8/1Mwr72rR76+1i0EXU39u/HkPUSXnGDLs6ab8IySwQBsJY2ncqSv1pdIyd6D4TflHUi0UQOByJMNAeYgZu/xXME8U10It1Q2hoQ7NQdvdtFPFB2O//BR3pvONzGL7Cg1A46damZuf6lbC+MNMyNEefWhb27MjQm/QMc9xFopnWdHflhCudRQMYUpXJygim7vbktQFw/uEo+dqaY7elizNmEc39SDbOQMxwZBnP8Mc+w+GUOy2AwcHsgfsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yWWJb0QUEBCFczZYI+Mi9E0zqDXIpITjbVssSMS328=;
 b=iXolGIo7ZS0LVk72tK2HQSAiEpCF9uMCyIwK1+yHWIorutysXkrfAcfjfkVu01NDLYexpwGLc6S6vSPkgNIN/6715veQOCFwnbX2Dprc5zp8imAQlPE3obkPzKGyylITtKMCSG3vTToMzm6bQZKhAA5sSB2FvwSbQkAygXk4+Cs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6553.namprd10.prod.outlook.com (2603:10b6:510:204::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 09:00:31 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 09:00:31 +0000
Message-ID: <fb8d24cb-b5c4-41be-abf4-33bda08a1059@oracle.com>
Date: Wed, 21 Feb 2024 09:00:26 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/4] Introduce uts_release
From: John Garry <john.g.garry@oracle.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: mcgrof@kernel.org, russ.weight@linux.dev, gregkh@linuxfoundation.org,
        rafael@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        keescook@chromium.org, nathan@kernel.org, nicolas@fjasle.eu,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kbuild@vger.kernel.org
References: <20240131104851.2311358-1-john.g.garry@oracle.com>
 <CAK7LNATDMjzmgpBHZFTOJCkTCqpLPq8jEjdrwzEZ3uu7WMG7jg@mail.gmail.com>
 <23c67ffc-64a5-4e19-8fbd-ecb9bfe9d3ff@oracle.com>
 <CAK7LNASfTW+OMk1cJJWb4E6P+=k0FEsm_=6FDfDF_mTrxJCSMQ@mail.gmail.com>
 <3e2c2def-e7d6-458f-81b3-ab666b41ad21@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <3e2c2def-e7d6-458f-81b3-ab666b41ad21@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0080.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6553:EE_
X-MS-Office365-Filtering-Correlation-Id: b2f347a6-8d12-4821-f1e7-08dc32bb8e51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7crI+W4V9zsKqCUibifJu9AHz7dTuspvvdS4CpIU0SNC2ZvHJNq2/ysVXwt3OuZ/Qu+izhhWRPBrS+2o794n6DZ0HBNbosF64rLBYkgviC+fvUekrKkiOqElW9jhlHWSe5YTwOGj7/6b9FKXL7ELA+R43pnYy743VlLO5bA7Bk2P3myMXEE5IGqkHREwzwywX5DEudXTHRH40oWY80arl62q0vhbbNiU4OGLGArPCdXn7unv4Uf+W6D62XGi021igELF9jILrvUgTfb44ljeGJco7GCJB3xxpPHqdnvWQpgp/Y2/xdJAxZEH7x5ocu1sUMZKIxQmO1pNERl5hkkrUn4AvpNtnfleXtWMuWAQ1Jh4YSiXcX20sNvn7LoCyOvGWLhVS46RbmBNQte0c+eyk7gF4ulOuB52rK0pfUV5NPboRe/T8Dj2oecFbKOAG3ms/9ZFwTL+oQhx567XO/0Dx+eS+lRsahLbUqoTVYAfQ5z/4jXiafU6aT04rmFO6gq/nu8dqAjRBmUV3UulNmnCgoeHx9/oyPGnumtiqeFRU+g=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VlROQjFySGVIV243RDF2TGlnbDgwUlJ4WUoyZTNkMUxDWHdZcGh1TFgzdEpR?=
 =?utf-8?B?TFpueVpKR3MydC9YMCs1RTRzTDJDRWY0UTlLdW5yd1g5WWZZd0J0dnlqNnlx?=
 =?utf-8?B?R3JTbG1Ra0tPNnQ1QVNkc05wQ0Q5cDVlYmFUM1hNS2NEdndvdzlNWjFneXF5?=
 =?utf-8?B?aXdqY245TUZHT3R5L2JldHIvTmg2TXhNdXdMaWIvWmk3SzIyNGxIK0hMS3do?=
 =?utf-8?B?dkNXL2dmUG9rellTL2JqUUo0YStjL3hWTWhrQ25ub2k0RzNmbmR3cmVzU1hG?=
 =?utf-8?B?TWhrK25vQ1o5TEwvdUUyUXZMWm9vbXJtL3lxYWhCM1dlM0xqQlRmSG02b1lo?=
 =?utf-8?B?bm1Id09ZMjNYMFNmSFFFbkZOZTFpUnRWdjRXcnJpUTRvbnhGd1ZGUU9pUGt3?=
 =?utf-8?B?bzNWY0g4UGtTRHdBQ3orVTVOQVp5UmVFNFplaGhYR3BPM2RDNUlKYlI3UVBu?=
 =?utf-8?B?YVZKMXJpOTY5K0RtUjJ1blZVM2thRzdCcXhhb0h1Z29nK001SjVQSm9LQUxl?=
 =?utf-8?B?V1ZRcEVCMjhJV25ucFNyWkxtc0RoUzhJL1ZLVTc4SDZrcXp3MHBMR05aWWwr?=
 =?utf-8?B?dWlXcDZwSG1WSTlNMHNiNys4NkVpK3JQNENpRTZnUDlQU3FrR3JLc1RwTXpJ?=
 =?utf-8?B?OC9RRDJHZ1BiYXZmTktPKzNJMngrSTJXdlM3emVNTCtqZ2ZnaFJEU2g4NHN0?=
 =?utf-8?B?dHoyMFk3dHpxdkNmMnM4M3o5Sml2NXZUZ3IwWmZlM3BLSE9XazlOWG5hdXFB?=
 =?utf-8?B?cWZWS0J2SW1WV1BObWxGM1FPMG1yUndvdEdmWlQ0THJlNzIyLzdhaFBkWFpT?=
 =?utf-8?B?QjU5ZjZtTGYvampiais3cGNHN1ZGb2hLOFpNbEs5ODZYUFdnZWNJNHI0Q0Rs?=
 =?utf-8?B?OGFJYVhaS2IxeHNlVy9zT2ZKQkxPOFFWamxSSVNPT01ldjBVYlExL3B3amY2?=
 =?utf-8?B?d0hNMWw4M0Q0SlJsMDlqS2gwRlBrdXYyNUE2YnFqaHovdlVneWVsK2J3TnhK?=
 =?utf-8?B?b0wrY0V0Rlh5RTFXN0R5ekY1Slg0NmQrRUlLbWduZ3h3clJmU3dkUlRYUEtK?=
 =?utf-8?B?Nm1kYmJYOExDNUY2RGZ1eHRyRG5EdGNidWFzOTkxakhibndOTC9wdVFWaEhQ?=
 =?utf-8?B?ZkczSVBFNjFjbDM3em5CNHVjdFlwMXJjSVRKQ2phOHMzOUNURVdEbityeFJl?=
 =?utf-8?B?Y0U2SHVscmxWMEI1YnRyTGxSbGQxMzNGQ3RIemRIUVdNbWxuQlpnOTYxa01K?=
 =?utf-8?B?TERhVlBTUlNzb0Z1eUtEeDUzLzRlWGFMaVhvdU5ENUhkOU4xR0lrRnFGb1hk?=
 =?utf-8?B?MmU1cEt1TzNCMUZoTU4wQlF2SW91c3hRbWgybUtaL3VCM1JJaC8zb3FsTm0y?=
 =?utf-8?B?SGRaKzBOZU5ZNG16dzFoUWVNRzJIWklIemptSENRcU83aU4vYmdQUXdsRzA2?=
 =?utf-8?B?WDNXb3N1cXFpZVYyS3lVS1cvenR4cEdiZDVZbzlqQ2pnaGNUYnhOQlhEY05l?=
 =?utf-8?B?Zmo2aFlrZWJIVmVCQUU0Uldwam56QS9VOWhHTUgvZFFhNnlEVm0vdDg4SUdN?=
 =?utf-8?B?UXBmYVB3ZjQybHZ0QmdTSGk2UjVFMkVUbm1WaERqRFJnZGZTVGpWSi9BeHNK?=
 =?utf-8?B?eHkrRFBMTm1ySXNkT2FzWGhPNk5ZUkovTVNaZkFhbThNeFVtcGRUNmEvKzVP?=
 =?utf-8?B?Q3dPRmwxWEFCZWFLamRDWnVpL0NGQ08zeVpMS1Z6Mmc3MXFaMzJOSXdVRzhr?=
 =?utf-8?B?dFdTeUc0ZVR0SFFvdEMrNTVDRnMxK3Q5Q1NSK09SanQwYis2dURmM0p1Y2Q4?=
 =?utf-8?B?VE41cWExOTVKZTRqTlhJZGlmMDJzbEI3RnZLL2t0dUVpNU45em5iTUZ3WElV?=
 =?utf-8?B?cE1EKzcwUjIrWGZPa3A1NlUwaXFBbjVvWk0rRXJ5ZFF6VHhKWWdEbE80RmJW?=
 =?utf-8?B?aHpaQktuUDRka1o4UWlQVVY5U2F4bjhtenhKZ2g4cFVvcmZ0VHNkSktQZlVW?=
 =?utf-8?B?MndEQmdySGN3aTRjWi93d1VCeTR4dzBjMVNOMjFhUXBPcE1oQzltTUttYUNs?=
 =?utf-8?B?S1BrZy9zS0VhcHNlMEQ5VDkvQlRRUEZzTU9kSHNPUGRLWklIQWV3QmJ3Qlhy?=
 =?utf-8?B?NEJrbzhBRGJDUHZtV21waU9BUXA2SGg5UTNGZ0o2NERCTHdmcjRERXBPbC9O?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	sdaVZuEGsKLBFda5oaapyQctESl20p8+kirVNy2RsSLCpAVEHfJTyzh4qxotfiqvDnlqRI0pqV0W8ZSOaE9UMET5uqHH4LpBdTJF5G//EN58G09RTiru6/WIUPfv1q32MoxXdMLdsa1ZDOnzS2+OpkwpTvqSkLetoMqqZ/cSkWJyefBU+MXtcazwsZReroY0jt5Cljx9VREyNfKxLNZeEPsdGThYz5/NYgyiP1evxTJp1DqhY4it88Y6kQFcJNd3mIWPweyJ4ry6cROF1aMfOM6y4E3WrT2xfFG/GLR7kk/dK+J8uR6w9Idjz3llSOkcGneVlE2++M1tLEVspY+shGdOhxxv5gkoc2jwwI1ALWCMniU0FsxOJlz4fW9zNU2w1jccapt/QdbW+h7jHmdDFe3Sjgz2hR4ZNYXy9Jn1sqHI57luCuxlkXSoL3TQyZanij24lFcws7lnrV959k0xUKZqSLl8sjqZn51rdjJaBUm8BGUepxywf/Fdmus8vMZxbzYzTYsxqKeBuaLHbYHCRWIJXp/LSt7HZ7r9QiGQYv5pFtSazslNRQ1I2q1zspnFyGetmvERJmi0GX900elieFMMH4f0ZpwKCzG9iMvL3VU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f347a6-8d12-4821-f1e7-08dc32bb8e51
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 09:00:31.0883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: crNZ2iTtI3FEULCmn6PTg4YuUYGRNm1hXMgz45IQRXhIxM68cLL2Ak1Hb+3DhfAHOOITQIbZflun4v2+3w/xjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6553
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402210069
X-Proofpoint-GUID: bte4BEvFiQYujsdECVXqsN9eEgE5wzKe
X-Proofpoint-ORIG-GUID: bte4BEvFiQYujsdECVXqsN9eEgE5wzKe

On 08/02/2024 10:08, John Garry wrote:
> On 05/02/2024 23:10, Masahiro Yamada wrote:
>>>> I think what you can contribute are:
>>>>
>>>>    - Explore the UTS_RELEASE users, and check if you can get rid of it.
>>> Unfortunately I expect resistance for this. I also expect places like FW
>>> loader it is necessary. And when this is used in sysfs, people will say
>>> that it is part of the ABI now.
>>>
>>> How about I send the patch to update to use init_uts_ns and mention also
>>> that it would be better to not use at all, if possible? I can cc you.
>>
>> OK.
>>
>>
>> As I mentioned in the previous reply, the replacement is safe
>> for builtin code.
>>
>> When you touch modular code, please pay a little more care,
>> because UTS_RELEASE and init_utsname()->release
>> may differ when CONFIG_MODVERSIONS=y.
>>
> 
> Are you saying that we may have a different release version kernel and 
> module built with CONFIG_MODVERSIONS=y, and the module was using 
> UTS_RELEASE for something? That something may be like setting some info 
> in a sysfs file, like in this example:
> 
> static ssize_t target_core_item_version_show(struct config_item *item,
>          char *page)
> {
>      return sprintf(page, "Target Engine Core ConfigFS Infrastructure %s"
>          " on %s/%s on "UTS_RELEASE"\n", TARGET_CORE_VERSION,
>          utsname()->sysname, utsname()->machine);
> }
> 
> And the intention is to use the module codebase release version and not 
> the kernel codebase release version. Hence utsname() is used for 
> .sysname and .machine, but not .release .

Hi Masahiro,

Can you comment on whether I am right about CONFIG_MODVERSIONS, above?

Thanks,
John

