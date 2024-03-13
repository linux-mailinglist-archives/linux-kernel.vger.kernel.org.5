Return-Path: <linux-kernel+bounces-101515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA4087A824
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 211BFB2134C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71AB405FB;
	Wed, 13 Mar 2024 13:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QNfddu/R";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oG+wYbJA"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43243FEF;
	Wed, 13 Mar 2024 13:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710335769; cv=fail; b=NIfYBrJW1kntFlZQAXtxd4+jnsec25By5syNiOb68C+59XEp/uFkmgDpeltxd4n/OSBulz68KZdTFym6sdvhcMQgZqsM5E8vu/+yjLCyaRc8G+nLs2XZGT3zgzxD2pHP55GlW7RRkCjOHzBG3biaNPb7YP8jf1uczWsW7P9CTCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710335769; c=relaxed/simple;
	bh=8QB6xqKQN96AtUBY+Bj5TwuGN4JmXe07niNN7HlCiGU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ak61WPm+G+obuLWG8h9/iUylORkeg6/QAhvgH9ppRyU3af3c1iN8BLFq0bxFOxI+FHB7O8L4F59Lu4glImQGnF3ZllGcQKly63ZHsDb2P3bBkMRa5zhkyqE1QhSgokQd1REXOweCc97KqCwUMJuKDi/t55IHQVoH4zO7/Wzwq5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QNfddu/R; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oG+wYbJA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42D8hqDx000608;
	Wed, 13 Mar 2024 13:15:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=OocjH/UXRbn9tqumm9R+l7LequATtlUUMuy8CyQBw0Q=;
 b=QNfddu/R5WT3Kq8RSBdNuE6/1/5RtLuHgC4k91UYAHMV82z0hCjrL2mKcJzGH6IgYwUr
 +ec58L7/Z6omBJvhDXB6ScSDuh2OvdhXVAOe7AnqsNAAvTWUWUr53s2v4X1HJs/05FwL
 ISbioyopuDg6/OJfDXwd+rJ7edyALTWdE1ZAaU0W4X3pvT5MzRYa99KpzybRr13xBnM3
 +TD2ZHka+qCgQJgbYVeRjz1L3KJJZtIsQ5JAlyD5wPw0BXtI744yCStP8lB/DjfXKnPN
 BhcmTrlZFPgXbKIDxFuOebhRHHZ3rM85P5gEfKmX8B/n8uNX07m2LnHqq1Mu7OihAgRX 3Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrftdh1hq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 13:15:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42DBtRbR004925;
	Wed, 13 Mar 2024 13:15:30 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre791m5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 13:15:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vx1S0epEfaBiR4sTYIAwaEiNe2F5NKkAoQUaJ9xEXeBzlk8sqJLS9Mfj/BiCVILjgwnGpgzz7lXyp2fsMpxAY7HHzPH504a6qP4UpoKQoxlwdyoZFpDNf6CKQ4XYLC2qXUuZdPgp+goWzdanj04Nd4ieCGH0/DFmdC8XLNc8RtRv46mL9uvUlpMZVXdJ8Now4OYFFM5ycJpWC6GjvwwJDofEYKX19axv8ZllxMltTQFOMDwVGHBpZ8bW5CLaZ7qQsDpz0/Qrsa79g2OHtum5jl4sjRaRbVXworcK5SxR2LgtEfQHUiholAmN4TNwFLNc+mYfVhwsGr/J4WgPJJriow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OocjH/UXRbn9tqumm9R+l7LequATtlUUMuy8CyQBw0Q=;
 b=VjVRJ7wxf8/y9yX9mJGWFfWnQHcnRFfrpx+lc6ieAaVWeGxnJAhjqvysMZO9UCyOFcujDc3qS4WM6Pip57UqOo3kdMEgQOyr+zOYZ05QQ+3/8oCONXHSk15RRTERwpojcUSUcYv9nshFECUvum5P+NxUSFsa/qCKxo0KSCUFT33xhgy2CupR6/7WPPHNYHA2TYzeIXVpB6ilfYoIaLtwHpfms5OXfe1a2n47Tp7EhDSsksVWb5AhTz4x1HngtYRWrBxtiqeYAwmMva03fvog4B6wxjHvb32NbIKRluk+bWa/CY6fDZM0gav4VXgliHH6tkmWhuH4lPUwfYUdmYmpww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OocjH/UXRbn9tqumm9R+l7LequATtlUUMuy8CyQBw0Q=;
 b=oG+wYbJABjDQuMeSghgxDJSi0L9MgRDYOKb8pM16lZCV93QRDlLilLhWuIZMK6IPShuRgavBvyqkCWg4MzsEqj5lE3BIxndKxrZKG/JYhENGmWM5QfwMWZ2htB7GPND3YGeYdPVBKW3+KB2nbTzq0JurUDajBP2mb/3Sb4xBQJA=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by SJ2PR10MB7558.namprd10.prod.outlook.com (2603:10b6:a03:549::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Wed, 13 Mar
 2024 13:15:24 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::c671:c95b:c99a:d9e]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::c671:c95b:c99a:d9e%5]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 13:15:24 +0000
Message-ID: <a755e7ca-7079-4ba7-94b6-d27dc162352e@oracle.com>
Date: Wed, 13 Mar 2024 14:15:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] doc: distros: new document about assessing
 security vulnerabilities
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>
Cc: Jonathan Corbet <corbet@lwn.net>, cve@kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        security@kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Sasha Levin <sashal@kernel.org>, Lee Jones <lee@kernel.org>,
        Pavel Machek <pavel@denx.de>, John Haxby <john.haxby@oracle.com>,
        Marcus Meissner <meissner@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Roxana Bradescu <roxabee@chromium.org>,
        Solar Designer <solar@openwall.com>, Matt Wilson <msw@amazon.com>
References: <20240311150054.2945210-1-vegard.nossum@oracle.com>
 <20240311150054.2945210-2-vegard.nossum@oracle.com>
 <202403121515.A1DF92B3@keescook>
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 xsFNBE4DTU8BEADTtNncvO6rZdvTSILZHHhUnJr9Vd7N/MSx8U9z0UkAtrcgP6HPsVdsvHeU
 C6IW7L629z7CSffCXNeF8xBYnGFhCh9L9fyX/nZ2gVw/0cVDCVMwVgeXo3m8AR1iSFYvO9vC
 Rcd1fN2y+vGsJaD4JoxhKBygUtPWqUKks88NYvqyIMKgIVNQ964Qh7M+qDGY+e/BaId1OK2Z
 92jfTNE7EaIhJfHX8hW1yJKXWS54qBMqBstgLHPx8rv8AmRunsehso5nKxjtlYa/Zw5J1Uyw
 tSl+e3g/8bmCj+9+7Gj2swFlmZQwBVpVVrAR38jjEnjbKe9dQZ7c8mHHSFDflcAJlqRB2RT1
 2JA3iX/XZ0AmcOvrk62S7B4I00+kOiY6fAERPptrA19n452Non7PD5VTe2iKsOIARIkf7LvD
 q2bjzB3r41A8twtB7DUEH8Db5tbiztwy2TGLD9ga+aJJwGdy9kR5kRORNLWvqMM6Bfe9+qbw
 cJ1NXTM1RFsgCgq7U6BMEXZNcsSg9Hbs6fqDPbbZXXxn7iA4TmOhyAqgY5KCa0wm68GxMhyG
 5Q5dWfwX42/U/Zx5foyiORvEFxDBWNWc6iP1h+w8wDiiEO/UM7eH06bxRaxoMEYmcYNeEjk6
 U6qnvjUiK8A35zDOoK67t9QD35aWlNBNQ2becGk9i8fuNJKqNQARAQABzShWZWdhcmQgTm9z
 c3VtIDx2ZWdhcmQubm9zc3VtQG9yYWNsZS5jb20+wsF4BBMBAgAiBQJX+8E+AhsDBgsJCAcD
 AgYVCAIJCgsEFgIDAQIeAQIXgAAKCRALzvTY/pi6WOTDD/46kJZT/yJsYVT44e+MWvWXnzi9
 G7Tcqo1yNS5guN0d49B8ei9VvRzYpRsziaj1nAQJ8bgGJeXjNsMLMOZgx4b5OTsn8t2zIm2h
 midgIE8b3nS73uNs+9E1ktJPnHClGtTECEIIwQibpdCPYCS3lpmoAagezfcnkOqtTdgSvBg9
 FxrxKpAclgoQFTKpUoI121tvYBHmaW9K5mBM3Ty16t7IPghnndgxab+liUUZQY0TZqDG8PPW
 SuRpiVJ9buszWQvm1MUJB/MNtj1rWHivsc1Xu559PYShvJiqJF1+NCNVUx3hfXEm3evTZ9Fm
 TQJBNaeROqCToGJHjdbOdtxeSdMhaiExuSnxghqcWN+76JNXAQLlVvYhHjQwzr4me4Efo1AN
 jinz1STmmeeAMYBfHPmBNjbyNMmYBH4ETbK9XKmtkLlEPuwTXu++7zKECgsgJJJ+kvAM1OOP
 VSOKCFouq1NiuJTDwIXQf/zc1ZB8ILoY/WljE+TO/ZNmRCZl8uj03FTUzLYhR7iWdyfG5gJ/
 UfNDs/LBk596rEAtlwn0qlFUmj01B1MVeevV8JJ711S1jiRrPCXg90P3wmUUQzO0apfk1Np6
 jZVlvsnbdK/1QZaYo1kdDPEVG+TQKOgdj4wbLMBV0rh82SYM1nc6YinoXWS3EuEfRLYTf8ad
 hbkmGzrwcc7BTQROA01PARAA5+ySdsvX2RzUF6aBwtohoGYV6m2P77wn4u9uNDMD9vfcqZxj
 y9QBMKGVADLY/zoL3TJx8CYS71YNz2AsFysTdfJjNgruZW7+j2ODTrHVTNWNSpMt5yRVW426
 vN12gYjqK95c5uKNWGreP9W99T7Tj8yJe2CcoXYb6kO8hGvAHFlSYpJe+Plph5oD9llnYWpO
 XOzzuICFi4jfm0I0lvneQGd2aPK47JGHWewHn1Xk9/IwZW2InPYZat0kLlSDdiQmy/1Kv1UL
 PfzSjc9lkZqUJEXunpE0Mdp8LqowlL3rmgdoi1u4MNXurqWwPTXf1MSH537exgjqMp6tddfw
 cLAIcReIrKnN9g1+rdHfAUiHJYhEVbJACQSy9a4Z+CzUgb4RcwOQznGuzDXxnuTSuwMRxvyz
 XpDvuZazsAqB4e4p/m+42hAjE5lKBfE/p/WWewNzRRxRKvscoLcWCLg1qZ6N1pNJAh7BQdDK
 pvLaUv6zQkrlsvK2bicGXqzPVhjwX+rTghSuG3Sbsn2XdzABROgHd7ImsqzV6QQGw7eIlTD2
 MT2b9gf0f76TaTgi0kZlLpQiAGVgjNhU2Aq3xIqOFTuiGnIQN0LV9/g6KqklzOGMBYf80Pgs
 kiObHTTzSvPIT+JcdIjPcKj2+HCbgbhmrYLtGJW8Bqp/I8w2aj2nVBa7l7UAEQEAAcLBXwQY
 AQIACQUCTgNNTwIbDAAKCRALzvTY/pi6WEWzD/4rWDeWc3P0DfOv23vWgx1qboMuFLxetair
 Utae7i60PQFIVj44xG997aMjohdxxzO9oBCTxUekn31aXzTBpUbRhStq78d1hQA5Rk7nJRS6
 Nl6UtIcuLTE6Zznrq3QdQHtqwQCm1OM2F5w0ezOxbhHgt9WTrjJHact4AsN/8Aa2jmxJYrup
 aKmHqPxCVwxrrSTnx8ljisPaZWdzLQF5qmgmAqIRvX57xAuCu8O15XyZ054u73dIEYb2MBBl
 aUYwDv/4So2e2MEUymx7BF8rKDJ1LvwxKYT+X1gSdeiSambCzuEZ3SQWsVv3gn5TTCn3fHDt
 KTUL3zejji3s2V/gBXoHX7NnTNx6ZDP7It259tvWXKlUDd+spxUCF4i5fbkoQ9A0PNCwe01i
 N71y5pRS0WlFS06cvPs9lZbkAj4lDFgnOVQwmg6Smqi8gjD8rjP0GWKY24tDqd6sptX5cTDH
 pcH+LjiY61m43d8Rx+tqiUGJNUfXE/sEB+nkpL1PFWzdI1XZp4tlG6R7T9VLLf01SfeA2wgo
 9BLDRko6MK5UxPwoYDHpYiyzzAdO24dlfTphNxNcDfspLCgOW1IQ3kGoTghU7CwDtV44x4rA
 jtz7znL1XTlXp6YJQ/FWWIJfsyFvr01kTmv+/QpnAG5/iLJ+0upU1blkWmVwaEo82BU6MrS2 8A==
In-Reply-To: <202403121515.A1DF92B3@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PAZP264CA0054.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fc::6) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|SJ2PR10MB7558:EE_
X-MS-Office365-Filtering-Correlation-Id: 11ff8488-b224-4958-a7ff-08dc435fa45f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6fF1g5UT6k/bQnXn4EmSpVhJmRxGplNIOUjsmMb5wWlKoY9BOSs3RGk6HkpR0z3OJ0NWgULqmhvdhbk1XvEZ4g9UcFVSewlowSLgxYo6/7T9HuW6EIkhrtVo/oApI0Rj9y9YnmBHWNggiYj50B2ssgj8SOUBgWVtQAsvOwSUh4ZeeR8y0qaJF3aokY1K3SbS0OKIFR/G/eG6jTk/do6lKFnRIk5Nk72vtEJqkc3I2/H/swvl1ImCgD+DJL6p3CIChcCeLvsi2L42TLEpuAPVjbIPqdSAwYtd8O8LQ18eGiGA2IwwTs+dFHB8Lq8Pyk3lDBxbHzqI+VFMqI5LMKlUKm3pNkXxP3fWB+Vd6BHnp4oyuxU6wCRHcJxBVyOem36PExE6yUs7ZJKqiV2vjBrBYG0cmGp+FUmzBPszebCK2+RFZUVrwiN1lTPyCMjuuPhm57+Dih80Mg13CIMvvn1ClD63CcQAHphDi67MLPjEGo9BQvXfB6z+ThEwlQ7b5vdjncuf/ymHHsnXl/KQ2lVcWuYJrhyeKtgvk1TNfZ20C3QkYfDWzM6ufV0DMZTk3xkHEFLub4P+KB+CoSDaPlAl8e1SVADsQd3YmQ1i/l/VVfIraXFEDYeAHseO8QOu5Qrs
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WWtxY3lkNFBZU0t2M2o2c3dWMEZaUWxrOFE0SXQ2RndpcWlvVkt0M2VCWHhm?=
 =?utf-8?B?YVFPSFRBUVpBQXJRYVZGT08wMERmcUcxQ2hkaFQwTzBFZEFHZk1iV2xFYmxo?=
 =?utf-8?B?bi92T3VYTStUSUoyME9wdGNyWTkwa2E1bkNMd3JGYkROcXBMRS9GUWpyc3N4?=
 =?utf-8?B?Yis2NGJKM1hzZGFTamhkQytPUnRVcGZJUnhockloN290NWtuaFcwZkZlTkMv?=
 =?utf-8?B?VjJNblU4K0FodGpZYmllUGs3Z2tTWHhVaGtleXlvY0lscjJRUmdPZVV3Qkd0?=
 =?utf-8?B?UjI0Qm1KOHd5aElJbW5jZ0dYQU03SzliUnMwMkZ1di9zTkZoaFhEbUE0T3FN?=
 =?utf-8?B?U2pnbHE2ZXlqVkpXYm9ObldldHY5NllUdk80dlRqaHMwRDh1dzhZSkliS2k3?=
 =?utf-8?B?NGJMVkl2ZVdDQkZ4VVJoQXRoUTZyaDR6MXYvMk1ZWFhhYUwxOVR5eGtMS0FE?=
 =?utf-8?B?dVloZFFZekRPUTRkZVhyRUxKRjRlWlFMNkpyTEROVUoydUdSU1JqSjNvMmZO?=
 =?utf-8?B?ZTFIMHk5b1VoNEtKY3lwT0NXeGVmbGM5VjJ2amczMmxBV2ZRK2h1TG1WM3ND?=
 =?utf-8?B?NENEbll3VjBIKzBBdTJTdnFqOFpjMmQ3QU9LWUVhTnhsOTVvZThyVTFUdlMw?=
 =?utf-8?B?U25iTVVpTTh0TTF3em1DQzJzNHd6R1FNUGhwL2w1aWtNeXMydmRzbnI2ZjZt?=
 =?utf-8?B?YWZWTVQ0Ri85Tyt1eE1TM2pDSGtkL0FldzFHVy81Mng3ckNzUkNoK1dWbURT?=
 =?utf-8?B?YzJXU1BJUjVkaGV0RW5FNFlnS1BiSjh2ZGgxeHBjS1IzTEg5bUtZWTJtRXQ3?=
 =?utf-8?B?MTFMQjJDckNRd0t3cldqWjhZcmtIUzVwWFBnUSsvYXVEd3BEeUY3QWp2MUVD?=
 =?utf-8?B?QnRzdlAxb1JLeFNBLzVlZHVNaEJCSWpyL2h3VE9iWEhFbDkwT2Z2SmpVQ0FI?=
 =?utf-8?B?ZmVWU2dhdlh3RUkvTWJOUks3UzFEeElQT016OFVIcWtFcmFSSmNoZ2J2RDRH?=
 =?utf-8?B?L0xRTlhHQnQvQ1krbkUweGt4MWFHN1R2SDd3bXIzTXB2VmVWdlZrdFNWTVVL?=
 =?utf-8?B?eThLK24rVTc3ZmI5QlJEM2dsYWVxVDFyb2NFeDBZZjViaUFpbm9mQktmdEhD?=
 =?utf-8?B?OGx6QU52QVVELzlSSng5VStXNmRxUktTK3ZHWHMvazMvVTd1bmFPNUxoQTFX?=
 =?utf-8?B?TWx2NUtOOVpwWTNsTWQ0NHRmNDFHZkYxdlRiL25Gd1NBMkt4bFRUMDV4akFy?=
 =?utf-8?B?UWJNa1FhcmswNDg4WUNnTi9NSW4xQTlCWERmcVhMVFVMUjI0eU9Ka0pCOG5y?=
 =?utf-8?B?WVg1cGk2OXhGMFI3WWFaK29TMng3eS90ZzhQK2picE9Sb1laQithWmhsUE9u?=
 =?utf-8?B?OWVyaDdtSExTSm9iK0RzQmw1VUVaL2YwYXk0QVZBQXJpZFJaUEhjMW9wUFEy?=
 =?utf-8?B?NzB4UU1ZeE15SzBpR3JpdHYrSWljMXhEdWF3L0ZVRDY0akQwQ1BsQTQraSs5?=
 =?utf-8?B?QlhwMWh2SngyZlhBSXhDNjJGZC9SaUpSTE1UUDJ3ZWRPakZxUEpkNzc1NDg2?=
 =?utf-8?B?NkprL3VpUlJOZkljVDhCTThST0ZjUVdtd0MvSjJtMW1pQWs2SEhxRjFzeGk1?=
 =?utf-8?B?SnZLUWI0V1V3QXhSN0lpeEdrNmJ2L0l3RlpWNTNBN1RvOHlwTUV2Y2dkOWtK?=
 =?utf-8?B?ZEhtcnY0TFZUVEc4WVoxQk0rL2ZnSVI5YmFCMGw2MEtQZ1RUR2pCWEdldTFt?=
 =?utf-8?B?VFR1dXVKUGd2aE1DUnM2NyswZHFwaW1uVU9zTkphRkhWelJiRHJXQkJLODVh?=
 =?utf-8?B?N2ErU3hzZFZCV293bEo2c0xuNzdWTy9iakhUMjdqdmZoQ1NSVURNbVZvYy84?=
 =?utf-8?B?L0lHR0ZGRFJkdFFkUUZBUmRocXM2ZEkzanhjbnNkMlk5MVNjdDIrbnZ0YjFU?=
 =?utf-8?B?cXM4bnFEcDZ5U2FOOGlkeExuSG1GNnhSWU94RjFtVExidWR1enRJOHd0L3Ax?=
 =?utf-8?B?TTRMeEFzbWxxT25qcEx0eVh5d3BNUGlqNTFUK2R4TFkrNlZ0LzkzOW1TdWRO?=
 =?utf-8?B?WUtnbmt4UUVkZ20yYWlWcUxjd0VUMUpwL3J0V2ZvSU5YYnZ5MTBmTm12ckNu?=
 =?utf-8?B?MndqYW1qM3pLSEViOG5tM0ZMN3NrZDJlOVowTThLRDRLOWNhNXcraEU2T21M?=
 =?utf-8?B?UHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	xgqUV/CUDgSvBMHLBCYjcVop6BUDuBrmdtZVsuCu9nVNZLTe0851fKh6/Q0LVQrESmyf7dsIkQdatW/cGc/ZGaxVcxG17k7rvwBX+s0qsLHmP1I9DR92omI9X4GGFhvaHFGFYQAOEx9XSPzXX4hfyy5N6nOLG2Qdm2hD12KWNWjfaUbtMpCno5UpfW2zRw86eTK4kPva5Pm6uipbcuzExvd6eMGKU8QPTQh+vDUlmHKb4MNvcRkS55cOrzCVbxz8nzj3zmrqlAxGkyAcpyI4CurBDnhUQ4pqY7sEBU2bN2l9mr+58IkYO6JH1zgcKpGawZ0jzS1rJN9UGPQisDrf1buhc+Nhu2Kh7PuvuALQR1mEl/15ipz/YD2A0v5LTAJwKlIrvwM5U6LBH/cWSSOzLftv2jMnmHmFH/9osF7yp0gvDk1QCgM38Xyxn46huxzhyt+9XryzeF2D6GOJCAq3GZkfWFAQ/2aUWtZc/xOQDETKBr85ugEBYQC9wrLS4UGfDGDjx0yCGhtOarL1n6a+086vHttyHFc/wc/LEmBoad51j35fYMw9uImMdPbNd01C/h5+92aWBFhjewPb4pd7zwQY+0TPGVeufxSbb3ENfmg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ff8488-b224-4958-a7ff-08dc435fa45f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 13:15:24.1299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UiP6E4mwoy4ZCQSDSOLlxa6cd/0Wpjk0sPqJ+yheX7zMCqR4F8TpArGowclioBPEnsHmp8C7nEWzlvL/NGMyOzqwPg96PjP+RS14TaM4uTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7558
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_08,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403130099
X-Proofpoint-ORIG-GUID: ktlNmrlHTFrl1igetccGVNYFHdv85dW2
X-Proofpoint-GUID: ktlNmrlHTFrl1igetccGVNYFHdv85dW2


On 12/03/2024 23:58, Kees Cook wrote:
> On Mon, Mar 11, 2024 at 04:00:54PM +0100, Vegard Nossum wrote:
>> +==================================
>> +Assessing security vulnerabilities
>> +==================================
>> +
>> +:Author: Vegard Nossum <vegard.nossum@oracle.com>
>> +
>> +This document is intended for distributions and others who want to assess
>> +the severity of the bugs fixed by Linux kernel patches.
> 
> Perhaps add, "... when it is infeasible to track a stable Linux
> release."
> 
>> +We could consider *everything* a security issue until proven otherwise, or we
> 
> Who is "we" here (and through-out)?

In this case a "general we", as in "One could consider...".

But in general the document was intended to represent a consensus of
Linux distributors who need (for a variety of good and bad reasons) to
know the security impact of what they are shipping. (Note: I'm aware
that there isn't a consensus yet -- that's why this is an RFC and I'm
actively trying to _build_ that consensus :-))

>> +What is a vulnerability?
>> +========================
>> +
>> +For the purposes of this document, we consider all bugfixes to be
>> +potential vulnerabilities. This is because, as stated in

(A kind of "academic we" here, though more referring to the general
community of distributors who might stand behind such a document.)

> 
> The CVE definition makes a distinction here, instead calling a
> software flaw with security considerations a "weakness" rather than
> "vulnerability". I find "weakness" more in line with people's thinking
> about attack chains.
> 
>> +Documentation/process/cve.rst, whether a bug is exploitable or not
>> +depends highly on the context (threat model, platform/hardware,
>> +kernel configuration, boot parameters, runtime configuration,
>> +connected peripherals, etc.).
> 
> Exploitability is an even higher bar, and tends to be unable to
> disprove.

Agreed.

>> +2. **Common configurations**: assuming kernel defaults, taking into
>> +   account hardware prevalence, etc.
> 
> I'm not sure I'd call this "Common", I'd say "Kernel default configuration"
> 
>> +3. **Distro-specific configuration** and defaults: This assessment of a
>> +   bugfix takes into account a specific kernel configuration and the
>> +   distro's own assumptions about how the system is configured and
>> +   intended to be used.
> 
> And this just "Distro default configuration".
> 
>> +4. **Specific use case** for a single user or deployment: Here we can make
>> +   precise assumptions about what kernel features are in use and whether
>> +   physical access is possible.
> 
> i.e. a configuration that differs from distro default.

Will change these.

>> +Latent vulnerabilities
>> +----------------------
>> +
>> +It is worth mentioning the possibility of latent vulnerabilities:
>> +These are code "defects" which technically cannot be exploited on any
>> +current hardware, configuration, or scenario, but which should nevertheless
>> +be fixed since they represent a possible future vulnerability if other
>> +parts of the code change.
> 
> I take pedantic issue with "cannot be exploited". Again, "exploit" is a
> high bar.

I am here specifically talking about patches that aren't really fixing
anything because the condition is provably never true; by definition,
they cannot be exploited.

Take the first example from the text below -- there is a NULL pointer
check in the module_exit() that generates a compiler warning because the
check happens after a dereference, but we really do know that the
pointer can never be NULL in the first place by looking at the rest of
the code.

It is only a latent vulnerability because the rest of the code could
conceivably be changed (in the future) in such a way that the NULL check
actually matters, but this is not the case for the specific kernel
version where the compiler warning was fixed.

We cannot take all future potential changes into account when
considering something a vulnerability, that would be madness. If I
started submitting patches to add NULL checks everywhere in the kernel
on account of "some other code may change to make this NULL check useful
in the future" nobody would take that seriously. Those patches would not
even get into the kernel and should not have CVEs assigned to them.

Another example might be a patch changing a sprintf() into snprintf()
(which is a nice cleanup, don't get me wrong!) even when we can clearly
see that the buffer _is_ large enough to contain all possible printed
strings.

> Also, why should hardware limit this? If a "latent vulnerability"
> becomes part of an attack chain on some future hardware, and we saw it
> was a weakness at the time it landed it stable, it should have gotten
> a CVE then, yes?

Maybe...

I think what I had in mind when writing this would not satisfy your "we
saw it was a weakness" criterion.

How about this as an example: We're reading a value out from some device
register and using that to index an array. There isn't an explicit
bounds check because the hardware never returns out-of-bounds values.
Meanwhile, we also sometimes do lookups in the same array for values
coming from userspace. A cleanup patch adds a helper function that does
the lookup, with a check, and replaces both lookups with a call to the
new helper function.

The check is added as a byproduct of a cleanup, but we have no reason to
believe future hardware is going to start returning invalid values.

I don't think this should be considered a vulnerability, but I'm open to
hearing more arguments.

Note that I'm not saying distros should not take the patch (they
should!), just that we should make a clear distinction between latent
vulnerabilities and actual vulnerabilities.

>> +An example of latent vulnerabilities is the failure to check the return
>> +value of kmalloc() for small memory allocations: as of early 2024, these
>> +are `well-known to never fail in practice <https://lwn.net/Articles/627419/>`_
>> +and are thus not exploitable and not technically vulnerabilities. If this
>> +rule were to change (because of changes to the memory allocator), then these
>> +would become true vulnerabilities.
> 
> But for kernel prior to that, it IS an issue, yes? And what does "in
> practice" mean? Does that include a system under attack that is being
> actively manipulated?

Depends on what you mean by "issue". I think we should apply patches
adding missing NULL checks for all kmalloc()s.

"in practice" means that we take into account the way the memory
allocator is currently functioning (i.e.: small allocation requests
cannot fail) as opposed to the common and more general assumption that
any memory allocation request can fail at any time.

With "system under attack", are you alluding to these requests possibly
failing while under memory pressure? If that were the case then I agree
this would not be a latent vulnerability but a real vulnerability. But
that does not seem to be the case, see the linked LWN article for the
discussion.

>> +We recommend that a "worst-case scenario" assessment don't consider latent
>> +vulnerabilities as actual vulnerabilities since this is a slippery slope
> 
> I wouldn't use the language "actual", but rather reword this from the
> perspective of severity. Triage of severity is what is at issue, yes?

By the definition of latent vulnerabilities given in this section, I
would personally like to see CVE requests for such patches rejected as
they are (again, by definition) not vulnerabilities.

>> +where eventually all changes can be considered a vulnerability in some sense
>> +or another; in that case, we've thrown the baby out with the bath water and
>> +rendered assessment completely useless.
> 
> I don't find this to be true at all. Distro triage of kernel bug fixes
> isn't binary: it'll always be severity based. Many will be 0, yes, but
> it is up to the specific deployment to figure out where their cut line
> is if they're not just taking all fixes.

I don't think any distro wants to have CVEs for non-vulnerabilities as
every CVE adds extra work -- and I'm not referring to triage work here.
The triage needs to happen anyway; that's why the parts about latent
vulnerabilities is here in the first place: to clearly distinguish these
types of patches from actual vulnerabilities that are plausibly
exploitable in some known configuration.

Think of this whole section of the document as a shortcut to saying
"this is not a vulnerability in current mainline or stable, no need for
further analysis".

Perhaps I didn't outline the next step of this process well enough, but
what I had in mind was a shared list or repository of analyses where the
individuals performing triage for distros could share their notes and
cut down some of the duplicate work that is likely happening right now
across distributions. We don't always have to agree (and we definitely
don't need to have the same threshold for which fixes get deployed in
practice), but it would help to try to make the determination as
objective as possible, i.e. independent of factors like configuration.
And analyses (such as information about reachability or assumed
capabilities) are typically easier to verify than they are to perform in
the first place, which is why cross-distro collaboration on this would
be so useful, regardless of what the final impact/risk would be for any
particular distro or user.

I think it makes sense to draw a line between latent and actual
vulnerabilities where that is possible.

>> +Types of bugs
>> +=============
>> +
>> +There are many ways to classify types of bugs into broad categories. Two
>> +ways that we'll cover here are in terms of the outcome (i.e. what an
>> +attacker could do in the worst case) and in terms of the source defect.
> 
> Before breaking this down into examples, I would start with a summary of
> the more basic security impact categories: Confidentiality, Integrity,
> and Availability, as mapping example back to these can be useful in
> understanding what a bug is, or can be expanded to.

I have tried to avoid going too deeply into "vulnerability theory" and
keep it more practical/down-to-earth (a bit more about this below...)

>> +
>> +In terms of outcome:
>> +
>> +- **local DoS** (Denial of Service): a local user is able to crash the
>> +  machine or make it unusable in some way
>> +
>> +- **remote DoS**: another machine on the network is able to crash the
>> +  machine or make it unusable in some way
>> +
>> +- **local privilege escalation**: a local user is able to become root,
>> +  gain capabilities, or more generally become another user with more
>> +  privileges than the original user
>> +
>> +- **kernel code execution**: the attacker is able to run arbitrary code
>> +  in a kernel context; this is largely equivalent to a privilege escalation
>> +  to root
> 
> Yes, uid 0 and kernel context are distinct. I don't think I'd say
> "largely equivalent" though. Perhaps "Note that root access in many
> configurations is equivalent to kernel code execution".

Fair enough.

I guess in my mind, uid 0 means you can load modules (however, not true
with lockdown enabled) or otherwise reach a bunch of code that usually
isn't that well protected (including potential lockdown bypasses), which
implicitly gives you kernel execution. I guess in a worst case scenario,
lockdown is not enabled, which would make them the same.

(And if you have kernel execution, uid 0 is trivial.)

But I can use your phrasing instead.

Do you think it's worth including the bit about lockdown or is that
going into too much detail at this point? We could make it a separate
section next to user namespaces (further down) as there are probably
more details around it that would be interesting in the context of
assessing security vulnerabilities.

>> +- **information leak**: the attacker is able to obtain sensitive information
> 
> Instead of "leak", please use the less ambiguous word for this, which is
> "exposure". The word "leak" is often confused with resource leaks. This
> is especially true for language like "memory leak" (... is this content
> exposure or resource drain?)

Agreed, although "info leak" is VERY commonly used and in some sense
probably less confusing for the intended audience of this document.
Especially also given the definition that is given right after: "[...]
obtain sensitive information [...]".

What if I just changed it to: **information leak (exposure)** ?

>> +  (secret keys, access to another user's memory or processes, etc.)
>> +
>> +- **kernel address leak**: a subset of information leaks; this can lead to
>> +  KASLR bypass, usually just one step as part of an exploit chain.
> 
> Again, "exposure".
> 
>> +
>> +In terms of source defect:
> 
> These are also very specific. Perhaps a summary of higher level issues:
> Spatial safety, temporal safety, arithmetic safety, logic errors, etc.

Again, I feel like this is going too much into a "technical-theoretical"
direction and using the terms as they are commonly used in kernel
development (and the kernel development community) helps us make the
connection between what a patch describes and how the vulnerability is
assessed.

At least for me, as a non-native speaker of English, I have real trouble
with the terms spatial and temporal; they don't have much to do with
programming. I know what they mean, but I always have to stop and think
about it. Maybe that's just me, though!

That said, I was considering grouping some of these into a "memory
safety" category, however I decided against it for a few reasons: merely
reading uninitialized memory is a memory safety issue but depending on
the context and how the value is used this could be an info leak or
snowball into something worse (I mean, it is UB but we typically have an
idea of the possible consequences by reading the code). Also, many
people believe memory leaks are a memory safety issue, which they are not.

What if we add something at the end, maybe with links to more complete
reference material? (Do you have any?)

>> +A useful rule of thumb is that anything that can cause invalid memory
>> +dereferences is a potential privilege escalation bug.
> 
> Even an "unexpected" dereference. :)

True.

>> +To calculate a final CVSS score (value from 0 to 10), use a calculator
>> +such as `<https://www.first.org/cvss/calculator/>`_ (also includes detailed
>> +explanations of each metric and its possible values).
> 
> Why not NIST's website directly?

The CVSS specifications are owned and managed by FIRST.Org, Inc. and the
calculators were designed and developed by them.

NIST operates NVD which merely makes use of CVSS. At least that's my
understanding.

>> +A distro may wish to start by checking whether the file(s) being patched
>> +are even compiled into their kernel; if not, congrats! You're not vulnerable
>> +and don't really need to carry out a more detailed analysis.
>> +
>> +For things like loadable modules (e.g. device drivers for obscure hardware)
>> +and runtime parameters you might have a large segment of users who are not
>> +vulnerable by default.
> 
> These 2 paragraphs seem more suited for the Reachability section?

Good catch, that's where they came from :-)

>> +Reachability analysis
>> +=====================
>> +
>> +One of the most frequent tasks for evaluating a security issue will be to
>> +figure out how the buggy code can be triggered. Usually this will mean
>> +starting with the function(s) being patched and working backwards through
>> +callers to figure out where the code is ultimately called from. Sometimes
>> +this will be a system call, but may also be timer callbacks, workqueue
>> +items, interrupt handlers, etc. Tools like `cscope <https://en.wikipedia.org/wiki/Cscope>`_
>> +(or just plain ``git grep``) can be used to help untangle these callchains.
> 
> 
> Before even this, is just simply looking at whether it was built,
> whether it was shipped, if a CONFIG exposed the feature, etc.

Yes.

>> +Examples
>> +========
>> +
>> +In the following examples, we give scores from a "worst case" context,
> 
> ...for an generic distro...
> 
>> +i.e. assuming the hardware/platform is in use, the driver is compiled
>> +in, mitigations are disabled or otherwise ineffective, etc.
>> +
>> +**Commit 72d9b9747e78 ("ACPI: extlog: fix NULL pointer dereference check")**:
>> +
>> +  The first thing to notice is that the code here is in an ``__exit``
>> +  function, meaning that it can only run when the module is unloaded
>> +  (the ``mod->exit()`` call in the delete_module() system call) --
>> +  inspecting this function reveals that it is restricted to processes
>> +  with the ``CAP_SYS_MODULE`` capability, meaning you already need
>> +  quite high privileges to trigger the bug.
>> +
>> +  The bug itself is that a pointer is dereferenced before it has been
>> +  checked to be non-NULL. Without deeper analysis we can't really know
>> +  whether it is even possible for the pointer to be NULL at this point,
>> +  although the presence of a check is a good indication that it may be.
>> +  By grepping for ``extlog_l1_addr``, we see that it is assigned in the
>> +  corresponding module_init() function and moreover that the only way
>> +  it can be NULL is if the module failed to load in the first place.
>> +  Since module_exit() functions are not called on module_init() failure
>> +  we can conclude that this is not a vulnerability.
> 
> Sounds right.

Right, so I came across this while looking for examples, as this was
assigned CVE-2023-52605:

   https://lore.kernel.org/all/2024030647-CVE-2023-52605-292a@gregkh/

This is where I think the distinction latent/actual vulnerability is
useful: this is a latent vulnerability in the sense that if somebody
were to change module_init() in such a way that extlog_l1_addr could be
NULL, then the dereference/check ordering could be a local DOS by users
with CAP_SYS_MODULE (yes -- admittedly an extremely contrived scenario,
but admissible under worst case assumptions).

>> +**Commit 27e56f59bab5 ("UBSAN: array-index-out-of-bounds in dtSplitRoot")**:
>> +
>> +  Right away we notice that this is a filesystem bug in jfs. There is a
>> +  stack trace showing that the code is coming from the mkdirat() system
>> +  call. This means you can likely trigger this as a regular user, given
>> +  that a suitable jfs filesystem has been mounted. Since this is a bug
>> +  found by syzkaller, we can follow the link in the changelog and find
>> +  the reproducer. By looking at the reproducer we can see that it almost
>> +  certainly mounts a corrupted filesystem image.
>> +
>> +  When filesystems are involved, the most common scenario is probably
>> +  when a user has privileges to mount filesystem images in the context
>> +  of a desktop environment that allows the logged-in user to mount
>> +  attached USB drives, for example. In this case, physical access would
>> +  also be necessary, which would make this Attack Vector **Physical**
>> +  and User Interaction **Required**.
>> +
>> +  Another scenario is where a malicious filesystem image is passed to a
>> +  legitimate user who then unwittingly mounts it and runs
>> +  mkdir()/mkdirat() to trigger the bug. This would clearly be User
>> +  Interaction **Required**, but it's not so clear what the Attack Vector
>> +  would be -- let's call it **Physical**, which is the least severe of
>> +  the options given to us by CVSS, even though it's not a true physical
>> +  attack.
> 
> "let's call it" -> "For a distro that doesn't have tools that will mount
> filesystem images"... I'm not sure if "Physical" is "worst case" :)

Not sure I get this -- there is some kind of inversion of best/worst
case here I think.

The worst case analysis does not make distro-specific assumptions. What
we know is that two system calls are necessary: mount() and mkdir() (or
possibly some other filesystem-related system calls that would end up in
the same vulnerable code). The question is: how do those calls get made?

Anyway, I would welcome more thoughts on this specific bug because the
lines are very blurred (at least in my mind) between what triggers the
bug vs. what the attacker can do and actually does.

If somebody gives you a USB stick with a shell script on it that removes
your home directory when you run it, is that a vulnerability? At which
point is it simply the user's fault for running unknown code? Is it a
physical attack vector because the user's action was something physical,
or was it the attacker's action of handing over the USB stick that was
physical? Does auto-mounting play a part in the analysis?

I'm sure you could model it mathematically with an adversarial model but
we shouldn't have to invoke that whole machinery to do a best effort
evaluation of a patch (though it could be interesting to include a
summary of the results of such an extensive analysis for specific
examples to gain a better intuition).

>> +  This is an out-of-bounds memory access, so without doing a much deeper
>> +  analysis we should assume it could potentially lead to privilege
>> +  escalation, so Scope **Changed**, Confidentiality **High**, Integrity
>> +  **High**, and Availability **High**.
>> +
>> +  Since regular users can't normally mount arbitrary filesystems, we can
>> +  set Attack Complexity **High** and Privileges **Required**.
> 
> Why not? Many distros ship without automounters for inserted media. Some
> docker tooling will mount filesystem images.

You mean a regular, unprivileged user can get docker to call mount() on
behalf of the user for JFS filesystems? That's a bit of unfortunate
attack surface given that most filesystems are deliberately restricted
to root because (as I'm sure you're aware) their implementations are not
as hardened as one would hope for (latest LWN article on this topic for
reference: https://lwn.net/Articles/951846/). I would honestly consider
this a vulnerability in Docker and/or auto-mounters if the kernel is
well known to not provide a guarantee against crafted filesystem images.
Maybe it just needs to be documented explicitly?

>> +  If we also set Exploit Code Maturity **Unproven**, we end up with the
>> +  following CVSSv3.1 vector:
>> +
>> +  - CVSS:3.1/AV:P/AC:H/PR:H/UI:R/S:C/C:H/I:H/A:H/E:U (6.2 - Medium)
>> +
>> +  If this score seems high, keep in mind that this is a worst case
>> +  scenario. In a more specific scenario, jfs might be disabled in the
>> +  kernel config or there is no way for non-root users to mount any
>> +  filesystem.
> 
> Your worst and mine are very different. ;)

What is your worst? (Honest question! Learning from each other is very
much also a goal here.)

>> +**Commit b988b1bb0053 ("KVM: s390: fix setting of fpc register")**:
>> +
>> +  From the changelog: "corruption of the fpc register of the host process"
>> +  and "the host process will incorrectly continue to run with the value
>> +  that was supposed to be used for a guest cpu".
>> +
>> +  This makes it clear that a guest can partially take control of the
>> +  host process (presumably the host process running the KVM), which would
>> +  be a privilege escalation of sorts -- however, since this is corruption
>> +  of floating-point registers and not a memory error, it is highly
>> +  unlikely to be exploitable beyond DoS in practice (even then, it is
>> +  questionable whether the DoS impacts anything beyond the KVM process
>> +  itself).
>> +
>> +  Because an attack would be difficult to pull off, we propose Attack
>> +  Complexity **High**, and because there isn't a clear or likely path to
>> +  anything beyond DoS, we'll select Confidentiality **None**, Integrity
>> +  **Low** and Availability **Low**.
>> +
>> +  We suggest the following CVSSv3.1 vector:
>> +
>> +  - CVSS:3.1/AV:L/AC:H/PR:N/UI:N/S:U/C:N/I:L/A:L/E:U (3.7 - Low)
> 
> Though for many distros this issue will be a non-issue unless they ship
> s390...

True, I just didn't want to repeat the same line over and over again. Do
you think it's necessary to repeat it again for this patch?

Finally, I'll ask this very straightforwardly, as this seems to be your
main objection: What is your reason for wanting to assign CVEs to
non-vulnerabilities? I don't really understand the motivation for this.
Some people still believe the whole CNA thing is an attempt to "burn
down" the CVE ecosystem; maybe I'm naïve but I don't think that's
actually the case. I also think you care enough about real security to
see that this (burning it down by swamping it with non-issues) would be
a mistake.

My own reason for NOT wanting to assign CVEs to non-vulnerabilities is
the fact that this makes a lot of people's jobs harder for no good
reason. It also does not improve security. Distros will need to ship and
evaluate these patches anyway; I see it more as a collaboration between
the CNA/CVE team and distros to get the best possible quality and
outcome of being a CNA as opposed to working against each other.

Just to be clear: This document is not meant for CNA/CVE team to follow,
although I would be happy if they found it useful too.

In any case, thanks for the review. I will incorporate at least some of
your feedback for a v2.


Vegard

