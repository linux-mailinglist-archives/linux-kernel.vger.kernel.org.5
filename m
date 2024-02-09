Return-Path: <linux-kernel+bounces-60142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5828500AD
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6381288F1A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717E238396;
	Fri,  9 Feb 2024 23:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gyGOMbgN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="R22KW9Q5"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F1E24214;
	Fri,  9 Feb 2024 23:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707520785; cv=fail; b=kFTLinrfnQ4vvLM8iZbBsVsEiXdIZqBzIupXRv6POz0Q3a4QhUfv2ORcahgRQFn/eb51MGgDjDxLdHSzHsu94WfHo+tqzpQJBVF3QnjlGCDik9iINhvp9rdQ3CdVY1kHLYmBkdyBn8n1/9HMHJOcxCU3PlrbELKvYXtN4U1PBoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707520785; c=relaxed/simple;
	bh=ELeTxJIZhjmMgXZccJXjgSGqfyena1P9Cnp+b4tXEb4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jlxnPouH/FrVRGzv1G4G/c6u+KQGa8Pp+zClUFkwNj3iY624Uc3hwOWqd2PaphrBTbhSO+K/D5jC+vhBBcnH7OmQplJ2kAUmtGv9EXGgmW5xNo24eAXqE68fPkVzwHl+f28497nWTskUnrOJMS7DTGVBVkPwLzwZeLn6UQotnIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gyGOMbgN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=R22KW9Q5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 419MiKq9030368;
	Fri, 9 Feb 2024 23:19:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=fx1CKXZEuBH0gR6qN8jwaqxFbJvV4Fhxp3XIsOO1dw4=;
 b=gyGOMbgN1E9HDPxV6IpdFQdafpIcnjeO4cjsujGgqkh7XzIfvlFToFWi5kEjofzc09yY
 p1Y6sOaRbtaWNF9hIyAwqs55XdvudNJi9fc/DJvgx+KSvlQ2hTBUf3A7+O6ZDZwodCat
 d4mYx8Vdj3H6zlowJCfocdhx4W5ZtLlM/aoPT9+xmU8vnvEPKGLqqBb5agDzIO0BHxLK
 UvbOIbU3iUYxMSYGBZLpiAoTMr0td/HbPYNSa9Z/vBBCYLQeDpazuWZ92tDjlwQdLTS9
 rkxKS76Vh4z/l3f/um9l1TrbWRg9dwNLHE8pbquXH6j5FHatG8fE3g9w5jNANZd4TjOj QQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w5w3ur1d9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 23:19:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 419LG8Z8019696;
	Fri, 9 Feb 2024 23:19:34 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxk4k0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 23:19:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/w4tacmgvamzyEjHKn298RmuiJMd5D/fIOFaJ0sHUJwJXmLz76aPcECh7xlfzu78RxSPlm/i+wKe0ev/uBSaPH04OeGnNDBFvQjaSdw+qKDLJvYejyqm0/bG2MDIx8XW2tOq1+mxjxcWv4zqlaltPJdYIp3J8DsuFglgJZs8Pk1wU+FMxSrid1OF8eJte5dmeu8vx8kkupQGAbhXyGv3DeaSkYVBKwcOT3qKli/PGHJ6gqEVPeoEH4LqMo8LpKBWN6PsuBkc/H7DgsIXLndOJi0qR7g7XbdX7Hg1uJNvdqi9zHS5M3w52BrjXlyrzoqtsiIevzOIr9PruP9pkgAOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fx1CKXZEuBH0gR6qN8jwaqxFbJvV4Fhxp3XIsOO1dw4=;
 b=nw1MGwn5LLPl3XXzW2nXaNiLwTdBOnDoNmKCMwtwvVolEADaF+l95iToY7ec+p8vTDiJTcBKZxxN7oFpZUjm939hOL/Awd8GvlVr360I/fTk71yqXzZF8fVFg59Jpm6zWU85PNPg0hgA5VB79zgUDi8AcH1UyYuvfQkDL1ZGpEjIefZkvOgNQE/KC3sVE3HK/KMgKR8dDxxv668WuE+aa4GgGdjs98jTmLbhaq+0aVs1y2iA77pTGx5qx8zOMY7Zmr6uFHUC5VzmJ9+q3KM9y5loMM/+MPODmU+A1qihyMSkoUucsu/lUsFoTQurQItJGxg95848q3UWC0W0SD8htQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fx1CKXZEuBH0gR6qN8jwaqxFbJvV4Fhxp3XIsOO1dw4=;
 b=R22KW9Q5qTdOvHp0bXZi6JPuOC7zSROylhwSxcmqXmbbLn26ER/F9yaabLx6H6kcGmBo/NEEGIBJzhQubJRhP0iHKJfRkJbBkXfE7tNaeqEFjDjD9Dh6diwEh6RLeFZJwDSbVN402GXW7/XnuZ/J7EiLew3JxhATDEN7T71JbLk=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CYYPR10MB7628.namprd10.prod.outlook.com (2603:10b6:930:b9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Fri, 9 Feb
 2024 23:19:32 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::5ca2:3187:d603:b044]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::5ca2:3187:d603:b044%6]) with mapi id 15.20.7270.025; Fri, 9 Feb 2024
 23:19:31 +0000
Message-ID: <890de365-f844-4ed9-af9d-90f5ff4bccbd@oracle.com>
Date: Sat, 10 Feb 2024 10:19:24 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] connector/cn_proc: make comm length as TASK_COMM_LEN.
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20240209121046.1192739-1-imran.f.khan@oracle.com>
 <20240209075032.1deb447a@kernel.org>
Content-Language: en-US
From: Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <20240209075032.1deb447a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::14) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4468:EE_|CYYPR10MB7628:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b4deaf9-fc09-44ed-7e30-08dc29c591f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7MGcYmXx3g0AWqiwrdN7qQwfGblYIraGp2gMEjiOIycCKzjuFgYpS55I3kElGNHE20wsH0ubtGTRqUHvn4SNAjeqMKv00NGxsGmrIhjj4Js/9RSz5P8hbdnWJXfhTF8hMtyZM+H+/S51FwAo9kUfcsgbTXSr0k5ckAXd6EqqCPNy3zckrt+EEoi4YjVGxg4fQoW34ci/WbjIONiZcAeiWJU6r3kGE+lhhkH9jxTpBLFurA5fdqBoGtkO8jZa/Nl18oVfvflH+GWOaTdCcKqx05OSYr9afQn7du1PYaK/0baTEq9v60NnJaDLmT22LPLGo3y/CXZ9nfrY+3/TKMC36yhRdQGffLEaeSvjnKcpExpHK87VVAaThdBp6SG7sIQsZw/cIG9mSJxEOPS+2EC8v2sbzz8N6e/2XOWT4Z6kQsuwchXGG68J7TNNWXwJesQzE0hwG01QwiJc5nj9JxBiRTjMmntFtGcpBml+HCv3vDkotR4kNR+4LLP8vSAtjY8Tq2Mpz1cKnwG2At9YuAoM6wyzoFy9RxdD6h2Q5y0+n7WsRkiNwptAy1r74WMONymL
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(346002)(396003)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(8676002)(38100700002)(6916009)(66946007)(8936002)(66476007)(66556008)(316002)(5660300002)(4744005)(26005)(2906002)(6512007)(6506007)(2616005)(53546011)(6486002)(6666004)(478600001)(4326008)(86362001)(31696002)(36756003)(41300700001)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bUpvbXlZTThlWWczSEJKQTR3WU1ZZmJnRTU2eWVDdDBaOGdoZ0NKR3RlVUdO?=
 =?utf-8?B?VjhLNHNtYU85N3k3ZVppd0o0b0QxTytiaEVGdGlIV3RIZEFHK3NOZmNlbXpT?=
 =?utf-8?B?MFBPcWVldzJjUHNIWmhZZTZkeVhTaXI0a0xWazRFR1JBMStvaURxa1FvWU1h?=
 =?utf-8?B?clpvV2F2VGx1SS9SaW9UQ2xlemFta0hkY21jSUlCbGVDUEtpZWtNLzNDUGZ2?=
 =?utf-8?B?R1E5cTlzUHFtTVR2RGtXMEJrcDZSLzgzSWk3QzJPdktzcW1vRVdNWHQ0MURh?=
 =?utf-8?B?aWdpZ3RRNkFCYjI1OXJCTk9OYndCRTlrT3JpcmYxSFBjQkFHUVZGVTlUbnZt?=
 =?utf-8?B?OS9JMjdqc3hZQzcwaGhlSTJmbUoxYWQzcHFjcjZyQXNqdFhpTWcvcE9WNGRT?=
 =?utf-8?B?dWpDanBjS09CTHZ1NnVGMHVSV0k0VXlxOHNNUjBrc251Q0Q2aUNTczJkc0NG?=
 =?utf-8?B?OS9BQmJaNlE4RmNJcC9wN25qZFFVdUpXUjVrS2pSMWEzeTQwOWVjdWVGTXFt?=
 =?utf-8?B?TGc5Vm5LWUNhUmZDVkZIN2tUVzFOakdOMmR0OVJ0Z0tzVEMrR1RqRnpDbzlm?=
 =?utf-8?B?eWZsbDBvM2FxZ0J3VmZRZGtNOE5oNnYvbUpGYnp6THlUaVFwaW1YWXJmYWl4?=
 =?utf-8?B?bTFSaFhoMm85Rk8xUHFFQlhsTjVuaithODhVc1Njd3QvdGxKSGN6ZW96bUxm?=
 =?utf-8?B?RldyS1VLaEs1c3NDTGVLRjVma2hoc3FlU1dOV0g0WTVuakhtZ1lURnJ6NE9M?=
 =?utf-8?B?ZGdTVS9RNDNmbGNzejhHakxsaXNzcmJGWFZOSUkwYXlqMXV6MURuZzE2aFhq?=
 =?utf-8?B?cHd0YVF1Z21ld1FlNDdnSjBLL0ZsckZnbWlUUldTQmdocW1UY0czQ2lXUHVV?=
 =?utf-8?B?RjdCOTZWeVBQTFRVSXNJZ0lPUnBXK0w1TVBjUkYvNncrenZEejJNbWlGcVd5?=
 =?utf-8?B?YUgwVno3Z21JNnc2bGJ4WVFJajc1eEFGazBwa05HUkRBZEcxTXNJZjh3Vm96?=
 =?utf-8?B?aGc3RWNLZTNiWVZiRWFjTHl2VGFWT3lkT3JQdU9Zb1RzdVdlK3RNdkphYllN?=
 =?utf-8?B?ajBwM2E3UXVSUEJmSGNmbW8ybEE1aGxQMFN5YTBRS0Q4MGRJT01oeFJkWmJz?=
 =?utf-8?B?NjBMekxwUDdVdVN0R1dEL2xXenk2V2pvaGhOaEFucWNiMkZGVlhmUUx5MTJr?=
 =?utf-8?B?aGZXL3lBSmJOc2p1NXNjRGtXRXNBSGNCbmNUZ3VqUS9SNVdPNWZFMjA5NDJ3?=
 =?utf-8?B?V29Da0JmUHlvQ1BuZFVoK1pmWXB3SXloN3BWT0paYnpzU0tFQ1JRTXhWOWN5?=
 =?utf-8?B?QzF1Z2d6c2VQS2cxTnhOWTc0MDN6RXBPem9nRi9RNGV0TEZ4U2o2V0R1K09q?=
 =?utf-8?B?MTZKMzB5UW00RFlWUGxrSlRIdEFOcE1DbXdUeDZlMFZUSHZkUGhvNzQydVpU?=
 =?utf-8?B?WjFtVU9VZ0dJS0piSkt4ZzZBTVFOUGx5c1RTVGtTK25tbmgveHo4N0lvdjVy?=
 =?utf-8?B?cW1QQmNRV2d0aDhkUGdXd3M1SC9KQnpaY2tFN3J0TFpWMEdnZmNhUGRtTys4?=
 =?utf-8?B?M2lGYjdYei9FYVNzc3ZhOW9ZYzFXK1pIU0drWk9kUFFxalB2MEphc2hMSXZP?=
 =?utf-8?B?KzBMTU9ocDczNUxVVW5Vc2NubFcyRnNqRkpQazdpTUFzejJFYVFpYUZBM2tK?=
 =?utf-8?B?Mng4YW1DbCtSWGRXUlFlakg3dHM3RFRiWmdWY0tnZmwvMStnaFRSZFVuUlI3?=
 =?utf-8?B?U3VSdk9jZHdjYVVvamc1WXN0eThNOW56M0xwZG9QL0RzcUtVaVdnOFY2aHZ3?=
 =?utf-8?B?SmhWeXBwYmNnWFgxNlBoT0JlZ1l2dDVwYlYrS0pGT09yd3lzZmQwc29IMUp4?=
 =?utf-8?B?ejRiU0wxcWViNFZONzlnNzl0V2JNNW0wV2p6djFIZWkxN1FkMERNTzRSbzgz?=
 =?utf-8?B?d2NsM3ZKR05yb3JKdzFqMksyQ2RnMTNUbVJCcmxlK2NUek9DWWd3K0lVK043?=
 =?utf-8?B?N1Q3bWNhU2hlVXdYTWFyMllNUjFuSndGRWZiQzhKd3RTS3NrUzdTVWl5WHps?=
 =?utf-8?B?MjNrSGlRWUtvYm40Z0NVc090bVA5NUVCZHBQOWpYU1NicUdpaWFPRXI3Z2pR?=
 =?utf-8?Q?skHLBMxebjQ7mgZukBH+2tIkW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	kn8uiZi4w1xXgbApWDH2PRf+opOQjfN8KnobRtBbnoeNcQ90tU9rFDhfE1lV1E6cHr+uNg/Lx5p+LpHja2kMwTYEkX9YZ8IT3ysbw7JFuaC18PCg5pwvcFFTxPzxev0Nfl9iqLRD+8HR4p2v6vbIc2AF+3tILcVGzo6dseLTAdYKdRtDHLcksD8J5WVUd2qwCTBlTyO0UcCainPPZO/lhzrqGElEH9+c5Fi3+Ocg69Z5A0op+amNZcnBNG8Eu6Ok2hBTENG/vLXfYVnPRRiHJTTIz5y+gHptLfsNWUDPd9liS4R6wxUUVJ0bziwSsRS5WyH4r2slS9GkyczqgdkT4cer836nmQ+xUPnllJ+AMrKNQnyP9iVxi6z5UT9TpNmLE+aMuE3dpEUP7fMi1ZMXkx84G9YbvQiN9elucRVSt9v7yza+4szEhhibWXHQVyv2L+WoV8VnYSsAe5DOP4sUtPTlHQM1BkQXbDKqK0mdEBJemhFjrYMyxMayxgooeflT8nV6lKDuWBNXFxLiIcXQR5O3XFCSXkJlnBGYV1XWY+ODqvE84rI04drRvTfQO7ePlUsFZR6zqAiakuRImYWgukAONMs8lAQUXc3hjyhr9mc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4deaf9-fc09-44ed-7e30-08dc29c591f9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 23:19:31.9009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +EFRsD7PrtQ7NAXn4PcEEbKGt07+97oqrToXW+sXMAk5CGy/9WCbEjtKTo2fazM1bupUx3btsv+0IgVyJudRHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7628
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_19,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=666 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402090171
X-Proofpoint-ORIG-GUID: 6wvw7wYFi2bC69YacUP779m3JmAY9q_Q
X-Proofpoint-GUID: 6wvw7wYFi2bC69YacUP779m3JmAY9q_Q


Hello Jakub,
On 10/2/2024 2:50 am, Jakub Kicinski wrote:
> On Fri,  9 Feb 2024 23:10:46 +1100 Imran Khan wrote:
>> Since comm_proc_event::comm contains a task_struct::comm,
>> make its size same as TASK_COMM_LEN and avoid magic number
>> in buffer size.
> 
> missed CCing netdev?
Thanks for getting back on this. Actually get_maintainer.pl for cn_proc.h was
not showing any maintainers, so I took the "To" list from cn_proc.c.
For CCing I stuck with what get_maintainer.pl was showing.
I have added netdev in CC now.

Thanks,
Imran

