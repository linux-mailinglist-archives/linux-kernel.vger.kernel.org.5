Return-Path: <linux-kernel+bounces-106454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A82687EEDA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C2331C22018
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F1855E7D;
	Mon, 18 Mar 2024 17:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mqGMHAjc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="M6dU3Kc8"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61A655C2D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 17:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710783161; cv=fail; b=KeEdi/Ol4wZm79VNhFdmT8bm0s8jQrQp82JaRzbzQeT70NMXYQdhZPbqkLUg+iFCOLfyRFNpk4t7rQxeOnYyFevE1g3PhR/xIIogRylULqAmjdIJ+YVUrjye55a0bLu9gRSrzj6aadvT6nUIqqrfVOz3UfvOgzYe/8/o11nwBg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710783161; c=relaxed/simple;
	bh=iyQSB8YOUKgM6mrnyTp8K/Pog3LfIyVU2DrIMUjFjJE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EypXhUt31DaJGH2S12iJzM+NyhdM9hqu+G5uJmbr7pKM7ab37It+2gtYIaVsqZ0v3LkDzjD5OLLxF+jH5WxN8t2hfadRyLrlrCeudfb7Ztgkv+EM/xKWrvdoLjJ5Fv5aQVnknBLzUt0K3cAZBvQMiVqO+Iz/29V5fM6mxZD2oYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mqGMHAjc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=M6dU3Kc8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42IDPQAd002537;
	Mon, 18 Mar 2024 17:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=bbyyy6PF+5oc5GlWC2FYOGBOWDxX1ELrMymNohHFJVY=;
 b=mqGMHAjchTJLefPKoSV3awUvj6/WrSXcI2BgLK+h5j8bpgbb2gDpJbk5wVdRptCgpXbE
 Xw35hKHA0UX4PIIppPllFnKx6QbJrPrFSvp0MZn7J+k9SREVEIbu3THdlBbHRREPGA5j
 yU7lq+dFe/dnkmanRdMU0xDDxnKn8Qim7P7aIO4oCDQqaTHZgpC/NG71mVQmjPz0rcZ6
 gUEJtcz/SwA6cLTywqTJYjtB250u1ng/B+Ln4EkrWlAp8i57k68ydHFcyza6FTnQe4ys
 fdYOo8stcPDzFbuDHpGpL5+AGd6BwZuZfusAfOuMoSTSNzpf+M+NVJVFo2TjQgNeHwgl Jw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww2113mf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Mar 2024 17:32:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42IHChln007776;
	Mon, 18 Mar 2024 17:32:24 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v55nwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Mar 2024 17:32:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2wWKzYZaJZuoD/W+tv7c5cg1cjanKN1CjN3FTY7EDtmdPlX0+ZdXgRvJPp5HUa40vjHo44OLq0fPRtWuXKlOi2S1iN0yJbqBJbrUpgZAWVFfcTxUoW1l469GsC9MzwZvdZXGupSJLRW4jCvfWgccZPzzm0dyL0ZSpQ7nl2+88utdZ36Uwk6LaoZgIzSXmB2ZZMDRg6GN/nIMEB6DOsRKKK0ctABNHu+73saEose/DijUZQzZosFEWmINXlmxTa9n2y5JyFWFxRt9/Or7E87HC7obpvmVw7K4mWldzXy5lyAkuWaxDbZhXHzlrnGRaADAsewq0a6swnJ4LURFwR/ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbyyy6PF+5oc5GlWC2FYOGBOWDxX1ELrMymNohHFJVY=;
 b=iM1WX8VuOpj262o+7FhnF6Lo0v9OrK4uca5feWNMvdoLXmra71LIku6HH/JIMXjf37m2Qt6/IG2HRXjzPAEWcU1W3K8AntVkAaNVVTZkR9/gxtAy3zueGd3cnWKurcdD9H5c7SEuHtKYGUgeRPTt0VYg6WnpqPvcWOyZt49nmVB4Ij6lPoI840gXgcJSKVCeD384C8ipdUsSHaMHKApr5orJHII3V0Z9RDbkDrNIFUzX6bvK4fHerGZ5D6KfG5ohnO7yO+ABTpHanTQlgVHLTYU4mYq4gNU8VJXz8lZJhGu9RwN9hSneH1FK/KMtrmjKxIUQlEFPmsM7/O/Z1xBCgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbyyy6PF+5oc5GlWC2FYOGBOWDxX1ELrMymNohHFJVY=;
 b=M6dU3Kc8rlNwH4W5ZWprNwncrTYBYLCfcfeZdmkNMTeWQa4ze1iIdfa957/LY55ulkLcGK2nCYd4JBaJS6E//v4o/5NdGXX0XRv1QbIWwfo3DuoOtyxv0f35KyAz9cYdMdJ0CVCb4Xa1+ktjX1lKgf2F86Gj8Wm/hGmcqedwFlo=
Received: from PH0PR10MB5641.namprd10.prod.outlook.com (2603:10b6:510:f8::22)
 by CH2PR10MB4230.namprd10.prod.outlook.com (2603:10b6:610:a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 17:32:21 +0000
Received: from PH0PR10MB5641.namprd10.prod.outlook.com
 ([fe80::f1e0:54dd:de44:3648]) by PH0PR10MB5641.namprd10.prod.outlook.com
 ([fe80::f1e0:54dd:de44:3648%5]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 17:32:21 +0000
Message-ID: <426cc161-a419-42bb-9860-5b628b0821ab@oracle.com>
Date: Mon, 18 Mar 2024 18:32:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] x86/pkeys: update PKRU to enable pkey 0 before XSAVE
Content-Language: en-US
To: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Eric Sedlar <eric.sedlar@oracle.com>,
        Andrew Brownsword <andrew.brownsword@oracle.com>,
        Craig Schelp <craig.schelp@oracle.com>
References: <20240314172920.2708810-1-aruna.ramakrishna@oracle.com>
 <4bd2aea0-3cea-4ef8-9607-40447cd531e5@intel.com>
 <349322E5-5E6C-48D5-BA12-1CF47CE82930@oracle.com>
 <ce99c89d-f7ed-4d9d-b04d-4699245c55d1@intel.com>
 <67F8113C-8E0F-4560-8967-FFF9ABF4FBEF@oracle.com>
From: Matthias Neugschwandtner <matthias.neugschwandtner@oracle.com>
Autocrypt: addr=matthias.neugschwandtner@oracle.com; keydata=
 xsCCBEt6wlURAwCfrIdPJNzEQJvzkZFVwaLI9MNISG402hcnwkTl4MfS84OtwGspRqmqyKfd
 hshvd45SsPbofon651t9J1ZuL4dMa+iCFVbwZeOGwqJacz9coNO8I001lTtK8wWvq0bQEfsA
 oNpOowgZWxnUpLrK50m3PIEzH4PjAv9ARynrWgP8x3f1vpDEYRXsYTGcakZrZKt7PI85XXN7
 mze0zbEHerwVb8Y01jGZK3A2itPJSrI2wX6T7HDcrOkFtkX4jhZRqGWm1GUc0yjnjKzsHdll
 VAvLbQRVnaxl2WYC/jVsQTelYtnA6eh/7WqoM/+U7LTTsVhBiCdguhXRMP2lQCspnPi+Vn3x
 QGVcf0biCKTetUUlVtbngowVTGci/eszjI1pgzRa12m+4SAbqxAcewNkTTcocbTdwAQJtvfQ
 6M1FTWF0dGhpYXMgTmV1Z3NjaHdhbmR0bmVyICh3b3JrKSA8bWF0dGhpYXMubmV1Z3NjaHdh
 bmR0bmVyQG9yYWNsZS5jb20+wngEExEIADgWIQQ8TIS7B8KK3jy7XTGoujPDPTFcWAUCY0Vu
 9AIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRCoujPDPTFcWIyCAJ49aCbYFz5xHgr9
 JT6AhRyJ4T71SACgh0+K3MTFZzWwCyNHTxJr9wp3+NvOwA0ES3rCVRADAPY+U0nuHCpWHYUR
 W5qkTQVVegFIKTRtmbaUyc39iuHftdJQhTYhaoHBdly3ijxN872SkwZSwn2DY2uZgpPMGARM
 yZpikLp01qVw2Kv8e7hJuL+drqU4VPscg2b+Iz42FwADBQL+Ip3OM9glu3XQ3SWM95NwkLJ/
 qC+jtps+ACgEqpYqL3/wCSOjjrTuHJkTJeJAS4i4p12C16QZnyCKBY9WM5qPUnUCeo3UV09s
 uJcOniIixZYx4h4UsCM+d4h/1bvX7yWzwkkEGBECAAkFAkt6wlUCGwwACgkQqLozwz0xXFjI
 1QCgxFVHhXdj4eM9I+aHUqsAfVa2mPwAoIGw3ifQlFDKrmb3qw4tnN/98SEU
In-Reply-To: <67F8113C-8E0F-4560-8967-FFF9ABF4FBEF@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P190CA0007.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::20) To PH0PR10MB5641.namprd10.prod.outlook.com
 (2603:10b6:510:f8::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5641:EE_|CH2PR10MB4230:EE_
X-MS-Office365-Filtering-Correlation-Id: fbbf03fd-267e-4714-8369-08dc47715e01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	j36UzoytpvQHWfEc2uDQVja0X9N7Aw//0Y9lUoMbQpyxtgRvwcYy96ZY8/iQAuz553VPeqb7T9h5mvlbpk/60gDmcjQ94XAs+f2K4JH+Xw4w4C9gipkHrcgIhxSD8+mIv+uKKbyMNFIAt457x1ZYZEHW3offjZxa41xDJo/Wkly7FD4qIZNibee6FaVvw8U90b/f9vVER2+tusAu5gSirorgBavCFOo28D1i/ZkL24r0pcdPeGRAR0bA66TV0wSxplNwDRTjd7JWgk/UUWLExJBEz9wyqcAaD3MCUewTtmjkwW1Dt2bVyV0YqW99tfMuU7ZxTTjdIQpA9LtUF5qcH2sTKH3Nk+ujpzDIONuAONwjb6owvA2y8zlMQpCVwPopHD8XA4W9LE4yr2Fhgk1y7S1tTDjMZfhrJ+ExT8ugPrYhE1Gxm/abkM3sj9GCEd2ROuk7CUZnHW+POqM11ELAnqlWpboVoWyPe+W7kfIYbupaAD52vi3MeaD3XftUS9QpAUeszdGfO18Ub23PmIO22HuVCVJ63K7QEzFVpIw9CNsLDa7k4xUfPABverj0mHU03vHdL855N20BllgISCQTeKKrLtHEq7M08QGsqkYv2sg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5641.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZzdXZXBDcjV1Q1ZiSE9pSllHTDVlTWgvMEJlZkpmZU9DZlUxMTN6OHBzenhU?=
 =?utf-8?B?OHd6cXh5emhzNnVmN3pnb0NMV1M5VzllK2ZxckFQYjkvVEtwK0EweFJ4b2RY?=
 =?utf-8?B?a1pHWGQzLzEwY2NJbnZhajVYQmllRXZZRnBpOGxBQVhINjJLT1lxSG5Ydy9w?=
 =?utf-8?B?WGNmWFVLb01lWVN6Y3o2UzA5TzV5Z0dxS1NabU8vR0M1a3diMVJNaVBkWXFG?=
 =?utf-8?B?V2tpOHZlVXpTZFc4VVp3eVMraWVtcVFpdmZ5ZHUvNUhndCtDdytOa3hYNDEv?=
 =?utf-8?B?aTlsaUFwKzkxSUdFNlpYWisySlA0Y1hEUEhHeFpqdTFRczNGTUljTlhOMyt0?=
 =?utf-8?B?K2NoVVdkZmlURFFQUFZRM3JueFZrb096R1lLSXFpQzNybnpjNGE0OXlRMHBw?=
 =?utf-8?B?aGkzeStpQUg3WTZleEdDOEtxZDdmUWtKdzlLcERielVMWmZoaEpFNzM2VmVH?=
 =?utf-8?B?OWxkczJFV3JCd3VPK3VjQzRuTjdpTW51MmJRUVlUNWxKY0czaXNYM1dhcTZK?=
 =?utf-8?B?U0hKdERhRkxkNjJCblRiTmpBZlRQeTZKV0pLMmxLUlRrSlFDRS9lNWYzWGNq?=
 =?utf-8?B?ODFWNk1xZUwzQ2p2Wm12aXczTWZkVEZhbUFmY0NBeWVWTG1TbmV3TTdTcGtI?=
 =?utf-8?B?UWtMQ0VaempzZW9KUlhiY2FuK0w1VWdNTXlEdmlVNkgwcWwwTzNKd0NVbnlL?=
 =?utf-8?B?QzlGNUhsSDdvbWVnQTQyTUhEMzJraUJ3VkFLWmNIUDhaSEoydDFMTnRRdmxM?=
 =?utf-8?B?Q0p4MGhaS2RuaS9oRHp5djh5c25WcVpwZDhtS1ljaUhyVVdWS0U4RDhjWUZK?=
 =?utf-8?B?ZUNQdzVwOXJRNkRVeWhzMmRpTEo2Ukp3Z3oxVkZnekY0SnZ3Vmt3SWlLZVVh?=
 =?utf-8?B?UGNWUlFFUWdPb0w1MHNLajVqTURzVGlCTU1NelgwSXpXbGNKL01XazM3UnhQ?=
 =?utf-8?B?dXFHZGI2VWk2NlRJR1ZzRlN0SURVKzNSMmdUMjdUVVRZcXVkc1lGTWo4cXNn?=
 =?utf-8?B?OGw5VUJWaTVPVFVwYVI4RU5YcjAxZ28vOXl5ajlCTzZIQ1Z0M3dlTW51WXdv?=
 =?utf-8?B?amNEQ1lISHR2eWwrNnFOTHNJRDNRUFdIb21Hc1lOV2p0YWhZalBSSnIySm9t?=
 =?utf-8?B?dzlLa3V6S1RRSWxnU0FPM2plcmwwZnMwMWs0bG5jYzRNeDRXelZOeHNaOFRQ?=
 =?utf-8?B?dmdoSE1wYjVCZEl4dk5Kdks3cHYySDI4TXRYL21iK045M2V3MWpEeXltRmdq?=
 =?utf-8?B?RGgvWnVySHhBTy9TVXNRYkd3MHMzaFppSkx5RE5ZMjFDOHRtVG9Va2N5WUp5?=
 =?utf-8?B?djUrcmt2NCsrdDJ1OXY4SWNUcERwK2E3UGtTblNEOFk3bGE0czQ0aWRmT09n?=
 =?utf-8?B?SVZaSVhSeGlQT2RWU0RRb2srNkxBK1Z5NW5wbXhMRlNYdkM5Q29aWERaSllV?=
 =?utf-8?B?WkZ2YWNnek9Ka0NDQ0dUNnk4TjdQYjh0dG1MK1VXOEZ3QXA0RjZxN0Y5ZDZl?=
 =?utf-8?B?OGRtZHBvYzdtZG56ek1SOVVFVHVXbHBJZzNiWFgvaE5XRDN6RURKRWs0QzJu?=
 =?utf-8?B?S3h5UENIcVM4ODJ2M0NzVWlHTm9EZ3Q3OXkvR0ppdWlWQWNaVG1vbEttY0Jo?=
 =?utf-8?B?N01EVkVlaHNkekxTTHdSeTBndEhhUk1CU1hEQXBxZE40dWwvcmc4THNwbU1X?=
 =?utf-8?B?QXc0bnJUVUdPY3NHY0pwWEx1REJ4dnRRWEtjWUJMWExjdEVCU0V1RGMraG13?=
 =?utf-8?B?bm9nY3VtSHNtZCtvaCtjMmljMENQSHlvQ05TeHoyTENJNmkyTG5zWUVMbWR1?=
 =?utf-8?B?ZVJ3MHBwbEcrd3RyR201SzA3OUJYOW8vZmtobDJoVW1HZ2I0YUdZMVhhSzdG?=
 =?utf-8?B?SEcveWo0YjdndTFhNzF2VlpOTmZYamhmbmprNzV0ZUY4MmQ5L0xYbjdGUUNY?=
 =?utf-8?B?ZzQ5aXNOM0JzcDFFM3ZlaklVenN0WmhFZldPNjhQMGlZb2NwWk84WW1weTFI?=
 =?utf-8?B?VXVRZERlVmFxVW9HK1FOOXJPbmFEc0tXcXlCY3VtMzQwSlhZZWZ6QytCVEND?=
 =?utf-8?B?R3AyR3NPcThBN2tmWGNBcXZmNyszSEVjSWlWbGx0SmpHNEIrdHpKQnk4V3l4?=
 =?utf-8?B?bmJ1dVFKa0FWOFk2VjVjT2p1a3hWOUpYUU5XMFdaNjdvWG9SM2ZBTEY5OEMw?=
 =?utf-8?Q?CwWSMNUkqN7cNejIBcbBuHw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	idKcqOkiJbMnrYhP9jXELZCyV1iSQW5NyU7in95kBqpWdgHjoAYPxKkDeKTEGF2VrUEArgW+Epztz7Ih4luLRo4L6MZRei+gRXzSAO3CaZ/MY+UiSobDX4mcWAeoEKTdpl0JqUKgtUh9NQz+IBwzgZ+LkylNATKK7KfyU4pHuoSeQt9oJ+39C0FLGMQCjKlmJEPe1agUkY4v8UFjKd7c1vVJnXHgE5N5N+Wor+tcfAMQjX0Ay1k3xTTCg9mvdAgHtNY60+L2n/KtWp8KVqpSFtqIexjQgBL47vSiXfEmWh7PlXrRCZnTWp9TVw1vMVUAhOQW1IgO280j7gu4kojTBHHj+ZiX6D3DhrFdQMu7U3QX5YIh5juRB15J7YWmvkAlPQijH/pwE/LRchNtikORUJOYlKpFej51SYXL0QfSbLx/x8WD2jBKWQ2cyNk5mmGPIQN7bVcA3A7zcDGkIZ8h48RR0Pck1KJrpeNM+rS5YaLRNFRtoAPco5ICETFHppZPj6LB43MMCC9pQgMz5pJ4DZDP8dcovRyQXDzqtJEIUn5jCviLp2qFf0crmCpNUeqsVe9WciYs7erw6MuWuvPhnO+KhmvHJ3iWd+3r0xnYerQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbbf03fd-267e-4714-8369-08dc47715e01
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5641.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 17:32:21.6308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 04cX74udDMJj3mkCG2mXS4ZG6KpvegysWRCh05Qx6O9P4Tq8LoJsy1xNcavYV3E5spxsYfla9Uc7BlyXQw0lu3c4qnXISUAIXGVzwp/2zZ2/hAmWnS3dh1GptKLl0Z9B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4230
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403180132
X-Proofpoint-GUID: 0bDgdcMkt33bMTImaMX-NycFKXQurCUw
X-Proofpoint-ORIG-GUID: 0bDgdcMkt33bMTImaMX-NycFKXQurCUw

On 3/15/24 05:47, Aruna Ramakrishna wrote:

> It’s not about the man page - it's just that, my understanding of this flow and this use case stems from there. I think we assumed that we can turn off pkey 0 and still be able to set up the alt sig stack (and have the kernel reset it to init_pkru anyway) - and when that didn’t work, it seemed like a bug. :)
> 
>> In other words, you're not going to spur me into action my thwapping me
>> with the manpage that I wrote.  You've got to convince me that your new
>> use case is valid, this is the best way to support your new use case,
>> and that your implementation of the new feature is sane.
>>
>>
> 
> Matthias/Eric,
> Can you please talk about the use case in greater detail?

Sure. The core use case we are trying to handle is inspired by the seminal 
ERIM paper [1] on using protection keys for in-process isolation. We want to
protect the memory regions of an application from corruption by a component 
that co-resides in the same address space.
Since all memory allocated by the main application is tagged with pkey 0 by 
default, we remove access to it when entering the component. If a signal is 
triggered at that time, the kernel subsequently fails to set up the signal 
handling stack.

Thank you,
Matthias

[1] 
https://www.usenix.org/conference/usenixsecurity19/presentation/vahldiek-oberwagner


