Return-Path: <linux-kernel+bounces-147434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7208A73FA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEE911C2118B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6D713791E;
	Tue, 16 Apr 2024 18:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GxC0TPfF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Sh5npkEV"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C32B137777
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 18:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293962; cv=fail; b=YCNsrjuD+RsH0kYeYcqAUMeEKOn1He58DG714r6XX48kCM4GJMpcJz5J640ympcwJX740Dp16flMXieYT38Oum9KSBxLq+XqKBN+B9IoEQgAkVNZBtKGm2h9MrNuFErT3gITaly2HU6jo0ADPsxV2CJv/eMj5iL1LEmIKJUb7ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293962; c=relaxed/simple;
	bh=wFVyCa28SyrJfDiUStBF4ga1gz5QdMSugbYGDdRzYdI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P/d8E3o3zlWPESaNvpq1sxN5w0rlnkJ7pxMdHJNLS80VSG038lGByemdbuALIXpJLczUmTSbnowuNzIRFVd13N+YrtfhoB56czUoWeeoTbn0wSJ6mjQM/9edF2si6C2IfHnnfnwT4Q+SonvINaLYyFJoxsmvZJXyY3x98UxuGSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GxC0TPfF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Sh5npkEV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43GHht81024400;
	Tue, 16 Apr 2024 18:58:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=mgc3RYKS5V62o6xT52q8tYMBUj7LW2piJf4yazog4G0=;
 b=GxC0TPfFBbwGys0AuvCRARnlCUNg+vx/q2r4OpNMAXMK2GJrYdaM5m+z/Wxwne8/1Al7
 k/YBBLCasEGix9bOkkejNryOjvD5WU3PXNx8QadUACsWfad/yiffDUPxgeCTKOOguK2a
 mVOv3fM1Wc4hHla6G3nl8tMxVn8cQyEZjgHImLN56cZTZ75YWJFqsheIpCMPg9EYpW1d
 4mJkqE43jklHtZz1WWW/kqhV/WwKfSwoSNZvwiugEu4aWv3PqHaDEzdn4iZ062HZg99M
 z1UYDgo8Z+eMJY7YpAs0DZjLmFxdmmnlcS4OJUoMMoOZN42JvOczJdue4/fdXPq0EGWa nA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfj3e66cx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 18:58:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43GHVnFL012545;
	Tue, 16 Apr 2024 18:58:55 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xgkwfns4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 18:58:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxGBKFU1zFFHFC2/4JSOb9T3G9MnckVk6ZAP+B2+9KBXBeZWXY67VTYfaLn0P+QGFnIWvn/oML77+EDLMGDH3ICVvrIUo7zI1hPfZadO2UAnDRXCmyQC4I9nbsKGVQsh7l/huubCnkFdlNrt/d8zvHc0+3d+8swOP4qBEARcqZGQ3yMEXRKl+HN0CI1o6do7TWhee+tkRqdegGEYEEC5oQenIEim6SD4u7iNyIIERcKsdD1tslvrgGkZmBVef9X/VEhgz8NwEA5jlyzClabXeK6at7yx6P8yAooT0uLTW6zuy8vAOu+q2xrddoqGDWIow0Tg5ZWroond49S7cpHKVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgc3RYKS5V62o6xT52q8tYMBUj7LW2piJf4yazog4G0=;
 b=DZNXifqerPnlFf2njlfEQWIegmUKach0TvlGKlx4zKZriCDltUrnC6oMkFkScu/PhsYVDPf5HJplzFUvdy//qVQdyWwRHsFnECF8rOnBsloBS8m01Kell+Lq3hN5sfFjXH6FlEu998FoXAwkYr6owk9b7lkSRvS+co6R3jHElWsVjRSM6x+8cwb1w96dJ/aBlhpBmFIsR8JHpu4cgpy48mbiHCAoNCihcRY2UIqE+Cl0Km0eGwm9CK/bAUaSWgAuIJG8m5HzH0FBlp+Zda8ovoANYYh5LnjhpGghatAT8z1u/2FQepgzgum8AeegLgbrGRiBpsq27cH5zsUGYM80Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgc3RYKS5V62o6xT52q8tYMBUj7LW2piJf4yazog4G0=;
 b=Sh5npkEVIDEkVImfFpxZ8rgCIAbEiH8jh1ORCR/qjboqaaTS6mgzEICMd42rB0hfD8OaHzVAQTTHWcRVxPPTUeHpPql6df9GCbMhKd0CQGqPdfc8Lc8EnVHFH1qWC66qxuQaud5PAGlrydnJE1jVEDp3/cHe2KwN1o2ZG2QIwcw=
Received: from PH7PR10MB6379.namprd10.prod.outlook.com (2603:10b6:510:1a9::15)
 by SJ0PR10MB4656.namprd10.prod.outlook.com (2603:10b6:a03:2d1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.45; Tue, 16 Apr
 2024 18:58:50 +0000
Received: from PH7PR10MB6379.namprd10.prod.outlook.com
 ([fe80::de1f:84ac:fe86:2865]) by PH7PR10MB6379.namprd10.prod.outlook.com
 ([fe80::de1f:84ac:fe86:2865%6]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 18:58:50 +0000
Message-ID: <91e70916-d86a-450e-8cf7-a083fc25d665@oracle.com>
Date: Tue, 16 Apr 2024 11:58:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slub: limit number of slabs to scan in count_partial()
To: Vlastimil Babka <vbabka@suse.cz>,
        "Christoph Lameter (Ampere)" <cl@linux.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Junxiao Bi <junxiao.bi@oracle.com>
References: <20240411164023.99368-1-jianfeng.w.wang@oracle.com>
 <e0222219-eb2d-5e1e-81e1-548eeb5f73e0@linux.com>
 <38ef26aa-169b-48ad-81ad-8378e7a38f25@suse.cz>
 <a8e208fb-7842-4bca-9d2d-3aae21da030c@oracle.com>
 <1207c5d7-8bb7-4574-b811-0cd5f7eaf33d@suse.cz>
 <e348dfcd-6944-4500-bf84-c58b8c2e657f@oracle.com>
 <5552D041-8549-4E76-B3EC-03C76C117077@oracle.com>
 <567ed01c-f0f5-45ee-9711-cc5719ee7666@suse.cz>
Content-Language: en-US
From: Jianfeng Wang <jianfeng.w.wang@oracle.com>
In-Reply-To: <567ed01c-f0f5-45ee-9711-cc5719ee7666@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:a03:180::35) To PH7PR10MB6379.namprd10.prod.outlook.com
 (2603:10b6:510:1a9::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB6379:EE_|SJ0PR10MB4656:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c422c47-ffa9-4095-9daf-08dc5e47408c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NElVY1R2blNCNXFTazg2c1NsVWhhS2wyY1lRZm5vK2I0NGcwdGZVRUY5RStO?=
 =?utf-8?B?K1o1RDlWRjZxS2FZZ3B2VE5kT2Y3NEsyd0QyaTIreEdRN1N4UVMxMTBhOHBU?=
 =?utf-8?B?UHVHUnZoUWNNSDFibWpaV09OQjNYK3ZyUUpCa3FIaU9va0N6WmR5ZFB3NDd5?=
 =?utf-8?B?aksrejhEdUN1b1QvalJoM0gxVTEvakN3R3BTMTRKWW9saUJvVnZsY3J1N3lK?=
 =?utf-8?B?M1U4c2ptVEJscWVsd1NkbkJEQWI2c3RoYkU3NGdxbnJmdVpHNDNJZTErZUVV?=
 =?utf-8?B?dnBNQ0YxWkdPUUNiR21uLzdHZDNvaGdDQmI3K1VIb1dZRUZETVNPZnpLaGRk?=
 =?utf-8?B?QnFRaWV6d2NpUVpwVW5YdWdmdThmTHFWUTM3dmdjR1RZcXpaVnJaUXR5S2Fh?=
 =?utf-8?B?RHRwdWZZMW1EYzNjZXJraE5VaUwwYnRUaGxaYmd1bDY3b0V1bjF0dkQycVg4?=
 =?utf-8?B?OWpSQ05xd1R1cXRKdkhTUGpYOGtpSGpaQkwwTjJzWUlIc0I1QlA3QzhEanFw?=
 =?utf-8?B?ejdnc0tSSEpjd0xjNWFLb3FuNFRlRTdVZ3kxZlNuOExwcU1FVVJLcWNCKzR0?=
 =?utf-8?B?ZHB3cGRDMGI1ZVB5ek44L25kQ1RMbENtdDFYMEl2aHdKVlAyZjhTVlkzTHNi?=
 =?utf-8?B?OGNkUFErY0FmaktOMWJ5V2FGM0MySGw0WXI5Ujl3YklhNWZwOHIwekY4RVVP?=
 =?utf-8?B?Q2pPK0dtcytFMi8valpRMVlNTUR6TmtKZkVIWmFWeWNDSkhTdi9oSGFvTEN0?=
 =?utf-8?B?RmpKRkV3YmhLRFc3cEVNZTZyUXkvU004TDdIRFJOa1JuZTdZY1k1QU05ZGk2?=
 =?utf-8?B?NTdPaDR3UEtnWUs4Qmg1aFBtZGxkSUhiUk81Mk1JUC9YWG9GZmwvTEFKQ3lX?=
 =?utf-8?B?bzIvcXJHOFRycWR0MGtENFB3clRtTFRrdGQzMXNDTUJWSG8wV0NCTkt2TDRm?=
 =?utf-8?B?Y2N1ejdBSzBKNFNUVXRzRTlkcVNjcUh6S3lrSVB6aGlXcVEwcDhDL2owRG1R?=
 =?utf-8?B?R2VkaS9kWEJVTVNhWnJibyt6bFFMMGhUYTVpVnZ3Y2oxUlJjTVl6L0FlWTdo?=
 =?utf-8?B?Qm16VnlPN0VrdHhhWEFRUXVJa2xyV1VlajFTWkF3UmlTTlJjcGI3MzFtTXIw?=
 =?utf-8?B?QUFxSVFYWEdWNE9JdFlEbUVsdWdOWm4rUXdvOC9DVFlNNmZWeGo4L3NUMXVo?=
 =?utf-8?B?YlNtMEtlWnd3bDk4SDVOQnBhcnlGNUZjenNCMUJHN2ZvSkNuWjZzeXpJWm1G?=
 =?utf-8?B?eFVaOGhiUVVsT0xWeXBJQzVaWVp0NDBYbVJ2czV0bkRpd2IxcHBVbzFaVkVE?=
 =?utf-8?B?RzI5K1FaRGU4bU5MdGwyOWdEQm04UnVsczQrQnRIY3V5ekRjQnFoRnRFdEFp?=
 =?utf-8?B?TzdKQzlqR0hFdXgxN2dZTmdUR1pPNlJQZy9sRWhSQU5sMFBmU2FmdDF2ZDNQ?=
 =?utf-8?B?NGVrRlNJTzFiSnZSdkZuakV2M2luSUdVYUtkdCtGOHFDb01DcWRIbU5QRksy?=
 =?utf-8?B?M002QUpGQUQzUWJ6RW5Jc1llam5nVFVLNmVaTHB0TFQycW5NWlRkQTBtTFVp?=
 =?utf-8?B?N2lvRGkwMWNHbFJZNHNOak1vWTBXZjFBbHlSa1phREFTK25GTVVSNWxwbzF0?=
 =?utf-8?B?UTZ0TUVGSTRxeStRWVpYZWRnMVRObDdSWjRVYkRUSmsyTXFYZGp5eDBaTG9n?=
 =?utf-8?B?U0pnYk5TSUdlSXlvWWc5ZlZBOEpVaksvK3MvMTYzQnBvenJVUEIzVlRRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB6379.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z1IrSVZGR0V6bjAzSVR5MEpCWk5DQXoyYU56d3ExY0Eza2QyakRxeGc1SkdO?=
 =?utf-8?B?dlNoN00zdEZwYWZ0RlVRbE0xRS9TeHBIc1ljd3pGKzFMR3JkRjI3YzgzWjhO?=
 =?utf-8?B?RUticG1Oczh0MGFLYkdlNFFWN2N2RCtHenQxWE1yZHpDV1pkMG5EY0N0dUdY?=
 =?utf-8?B?TjRLVlI5V080NFdCanY5UHEzQzNWWG1TOVVTSi9oMkdnUDZQREt6d1g3Y2M4?=
 =?utf-8?B?dTRoNXVramEvUFBlb1BPZXJKQkRjR0JkZUs4UVJSbHl2bnJTaEcvbG9WV2lY?=
 =?utf-8?B?dDBMNXNwcmdQZmt0T2RNQmxaZ2F6K3o0QzlBTldYeWc5VHBQbE04U2p3WVc5?=
 =?utf-8?B?ak5KbTRDSzlEK3FZZEtnTFRaTlNFcjd6dW16RTlwdHRZVFFENmdDVFd0bnRH?=
 =?utf-8?B?TXBQUWFrQk50cE9JUy9NQnZralhPbWdyY1dOTlQ5SmpNZ0pnYjN1WEdkME1K?=
 =?utf-8?B?L0NtUE92UjFtVnMwQlFHd0trNjV3UGN4SGRKaU1TRm9GVFdQMzUzalJJMkdB?=
 =?utf-8?B?R1N6dEk5KzQwckNncWdiSDI3R1ZpVzJUa1hodm9aZ3RiV0szNzdEM0Viell2?=
 =?utf-8?B?d1VTRzZ0TnEyZ05CcGlNVDlLS3NtVnVTU0V1K0pNNkNjZ0wzYnRzWVRRL2M5?=
 =?utf-8?B?TzZKL2VkM2hpS2pwc2dCdWRMdTRtbmxwVDcxdS9kWC9kSzVOejdLOHovekVO?=
 =?utf-8?B?NWhLc1ZYdWpPbkIvMzFqMFNLaFhDVXgzdTdiaGVqd2sxejR0NWk3Mk9RcWRG?=
 =?utf-8?B?UjJDRVVyc095RW1rNXU2TkJTRWJ2YjltT0svQ2VPUmlxcDZ6M0dkOXpuNjk5?=
 =?utf-8?B?RUtJaEY2c014a1Y3bkpnNEx3czRrTzkzaWlrRHoxWTBVNmlaQ0VVZzNSb3I4?=
 =?utf-8?B?OUhjbnY4T2Z4bnJnUUQzQlBPT2dad1MvSW4rdFpzaDg5b1M0dFRtMFBLOURE?=
 =?utf-8?B?U2J0UjYxSEVQNjhKTW13VjJLdmdlREpOa3JERXgrRXJISC9pMXBlZHZQL1ds?=
 =?utf-8?B?aTNDelU0ejBQbU0xOHg4ZVB2RVBWOFFOMm5DR3R3RFRIRU1NeWZWZDZRUnUv?=
 =?utf-8?B?NVdrUHNRQ1hPZEdlandZa3VxdXhURlhlSWV5Y3RwNmovY1RpOThyS0RhZnBa?=
 =?utf-8?B?OE55azRYMy9XY0tZREdTUlVvZi9rN2lpTitqS1VWeVpzTVlOeURxdUIvSmEx?=
 =?utf-8?B?UHZRQjduWC9Wc3VubU1lOFBLMklFOXJhdWdQVDdSYnRlWkZYbXR4YXQyUjJC?=
 =?utf-8?B?VXo5WDJTL3hUUDUxK3AwVGcwVzZTdUg2WWtRSzh1YXhPajlHck0rcHc2bU9i?=
 =?utf-8?B?STkyRGNZYWVPZzE2V2Q3TzhnQ2NCUjhTT1JWNExzcyt4dDFiWHVnVEwyWWFC?=
 =?utf-8?B?VzdsYVlNMTJOWitCRVZ5bW81ZWFYTUNsUXBwMTlxeVpvemZBUlhwSUY5SWRI?=
 =?utf-8?B?dE1YejN6ZlZiTFBGMXV5VWVJZzRBNzFvUVBpTWdxT2J6K2tCdG41b1V1ZjdS?=
 =?utf-8?B?SGl3MElLRmR1NjM1WGRobzNzWkNHTU9zdnVJSHBrSXNrc25IeklJSGtVa3o4?=
 =?utf-8?B?MndnanFTRWVzVXc1VnBuMWdlTkhJNE5HaldxSThyeXgxMFlRdmtmaTFZdGRm?=
 =?utf-8?B?Q1B0MGprNmsxeVB1a2JvM3pWQ0ZuQkxLeEZ4WGNkSTEyUms2MnFqMTZIelIz?=
 =?utf-8?B?V1h3dnUzS3Q4QmdXMmhHZk1ORWtoTHprMm5KSitBaXUvYU1lS0piQmRES1NP?=
 =?utf-8?B?RnRDUGhPNDkrN2tRbFlFY2xMemJtVmYzNTlDbWovOE5pRzhzRFo2L0VwTjdl?=
 =?utf-8?B?NDFYbTZPR3hYREd2T2Q5a0NYazl6VjVDWmlCTExsU21BT0dsclRGTzdFazdv?=
 =?utf-8?B?WGp2bDAwL3VtVEpSbzdldVBkNVBpNTlyNkxiNzIzNWVoR0RwZ2RHUG91VHZB?=
 =?utf-8?B?dks1eUtXYWZZRk9zQVVoTnk1bDh5SmduSkRQOTVIcmxDZ1ZKbVV0UDB2SzlK?=
 =?utf-8?B?YUhVUE41TnhEQ3ZJa3c0VHRGR3pxbkZ2RGZ6aExteWNqaTR0QnROdzdFRWpS?=
 =?utf-8?B?blpJZi9iUmZBdkIvQjd3OVpGd2EwTEt3RStUaG0vS0NuZEFNSC9SRDFuMlR5?=
 =?utf-8?B?OEQ3bWFzNmZCVEpHOWNoZDNsekVGQmw0VDVZQU5pOUpUcWY4aFVwNWxKdGNn?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	x8pAiZgyspYgtX8pjpAAIAGuA0NP7s8Kbw/BIROBmkd+ZQkrqCdwLVHn9sT+kdfZLiTWZ5blfQna5COLrB2w7RnSxdBl75rOySn5S4gUQiGvK5KW4OjCP4HUrUkvJC60R6oFSyL+vpKmTiU3MciYYJ3IIhBWM69OfW+3EkZO+Fi4lYoYgP5jLwwsmPRjk/3c+jfu2c7MIuCQSYx7yyNF89TKiy6APdqJZoEkBZ1vYe6Qp9Oi+X8mF0w8mlCufObCCmtg38itf894NKJs++bhVycSSG0WxRoKv/CwhfRv+dtdaD+pb0sRHLmvUFqffyC2oWImMyJxItVu2gyfq9ZBNYB5DHvwaT5fb9XGD9RD2o820E2ukx+AzMnyl6EwH2ugXO9ga7D1tz6ESW+fAr8EdaviXZh+gID1MK4AtkW8EpUTTgUBPvARDP3QuJcF5REdnEh4u106x/U0J0Hw3A3zLn7zaHvXfR2dQYyOg0B8ih/YAp8q78k1ldSwtOVCu57k+r4OIQtVwhfTeqeXRl4Kkph3bJdbkUuMYC/BIPEF8KAXb3eFw4t831WL24hQe63ixAvEKDuXBdEwDba1yVEAm2bvpDQqIrrzwVZCVfOkKgg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c422c47-ffa9-4095-9daf-08dc5e47408c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB6379.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 18:58:49.9907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8BJnAV0nVkwgAVroCya+nshwlAt2y/hxETtr4WINEIO/XMe8g0FKAM/bFTbixaWVohG+GfL3niO+9pkCHCTQdINjzawCaByU16gR0qM+4fU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4656
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_16,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404160120
X-Proofpoint-GUID: 16miysIs9uLKa8SjjG_DFwgORCioSTNl
X-Proofpoint-ORIG-GUID: 16miysIs9uLKa8SjjG_DFwgORCioSTNl



On 4/15/24 12:35 AM, Vlastimil Babka wrote:
> On 4/13/24 3:17 AM, Jianfeng Wang wrote:
>>
>>> On Apr 12, 2024, at 1:44 PM, Jianfeng Wang <jianfeng.w.wang@oracle.com> wrote:
>>>
>>> On 4/12/24 1:20 PM, Vlastimil Babka wrote:
>>>> On 4/12/24 7:29 PM, Jianfeng Wang wrote:
>>>>>
>>>>> On 4/12/24 12:48 AM, Vlastimil Babka wrote:
>>>>>> On 4/11/24 7:02 PM, Christoph Lameter (Ampere) wrote:
>>>>>>> On Thu, 11 Apr 2024, Jianfeng Wang wrote:
>>>>>>>
>>>>>>>> So, the fix is to limit the number of slabs to scan in
>>>>>>>> count_partial(), and output an approximated result if the list is too
>>>>>>>> long. Default to 10000 which should be enough for most sane cases.
>>>>>>>
>>>>>>>
>>>>>>> That is a creative approach. The problem though is that objects on the 
>>>>>>> partial lists are kind of sorted. The partial slabs with only a few 
>>>>>>> objects available are at the start of the list so that allocations cause 
>>>>>>> them to be removed from the partial list fast. Full slabs do not need to 
>>>>>>> be tracked on any list.
>>>>>>>
>>>>>>> The partial slabs with few objects are put at the end of the partial list 
>>>>>>> in the hope that the few objects remaining will also be freed which would 
>>>>>>> allow the freeing of the slab folio.
>>>>>>>
>>>>>>> So the object density may be higher at the beginning of the list.
>>>>>>>
>>>>>>> kmem_cache_shrink() will explicitly sort the partial lists to put the 
>>>>>>> partial pages in that order.
>>>>>>>
>>
>> Realized that I’d do "echo 1 > /sys/kernel/slab/dentry/shrink” to sort the list explicitly.
>> After that, the numbers become:
>> N = 10000 -> diff = 7.1 %
>> N = 20000 -> diff = 5.7 %
>> N = 25000 -> diff = 5.4 %
>> So, expecting ~5-7% difference after shrinking.
>>
>>>>>>> Can you run some tests showing the difference between the estimation and 
>>>>>>> the real count?
>>>>>
>>>>> Yes.
>>>>> On a server with one NUMA node, I create a case that uses many dentry objects.
>>>>
>>>> Could you describe in more detail how do you make dentry cache to grow such
>>>> a large partial slabs list? Thanks.
>>>>
>>>
>>> I utilized the fact that creating a folder will create a new dentry object;
>>> deleting a folder will delete all its sub-folder's dentry objects.
>>>
>>> Then, I started to create N folders, while each folder has M empty sub-folders.
>>> Assuming that these operations would consume a large number of dentry
>>> objects in the sequential order. Their slabs were very likely to be full slabs.
>>> After all folders were created, I deleted a subset of the N folders (i.e.,
>>> one out of every two folders). This would create many holes, which turned a
>>> subset of full slabs into partial slabs.
> 
> Thanks, right, so that's quite a deterministic way to achieve the long
> partial lists with very close to uniform ratio of free/used, so no wonder
> the resulting accuracy is good and the diff is very small. But in practice
> the workloads that may lead to long lists will not be so uniform. The result
> after shrinking shows what happens if there's bias in which slabs we inspect
> due to the sorting. But still most of the slabs will have the near-uniform
> free/used ratio so the sorting will not do so much difference. But another
> workload might do that.
> 
> So what happens if you inspect X slabs from the head and X from the tail as
> I suggested? That should help your test case even after you sort, and also
> should in theory be more accurate even for less uniform workloads.

Yes, the approach of counting from both directions and then approximating
works better after sorting the partial list.

Here is what I did.
---
+static unsigned long count_partial(struct kmem_cache_node *n,
+                                       int (*get_count)(struct slab *))
+{
+       unsigned long flags;
+       unsigned long x = 0;
+       unsigned long scanned = 0;
+       struct slab *slab;
+
+       spin_lock_irqsave(&n->list_lock, flags);
+       list_for_each_entry(slab, &n->partial, slab_list) {
+               x += get_count(slab);
+               if (++scanned > MAX_PARTIAL_TO_SCAN)
+                       break;
+       }
+
+       if (scanned > max_partial_to_scan) {
+               scanned = 0;
+               list_for_each_entry_reverse(slab, &n->partial, slab_list) {
+                       x += get_count(slab);
+                       if (++scanned > MAX_PARTIAL_TO_SCAN) {
+                               /* Approximate total count of objects */
+                               x = mult_frac(x, n->nr_partial, scanned * 2);
+                               x = min(x, node_nr_objs(n));
+                               break;
+                       }
+               }
+       }
+       spin_unlock_irqrestore(&n->list_lock, flags);
+       return x;
+}
---

Results:
---
* Pre-shrink:
MAX_SLAB_TO_SCAN | Diff (single-direction) | Diff (double-direction) | 
1000             | 0.43  %                 | 0.80   %                |
5000             | 0.06  %                 | 0.16   %                |
10000            | 0.02  %                 | -0.003 %                |
20000            | 0.009 %                 | 0.03   %                |

* After-shrink:
MAX_SLAB_TO_SCAN | Diff (single-direction) | Diff (double-direction) | 
1000             | 12.46 %                 | 3.60   %                |
5000             | 5.38  %                 | 0.22   %                |
10000            | 4.99  %                 | -0.06  %                |
20000            | 4.86  %                 | -0.17  %                |
---

For |MAX_SLAB_TO_SCAN| >= 5000, count_partial() returns the exact
object count if the length of the partial list is not larger than
|MAX_SLAB_TO_SCAN|. Otherwise, it counts |MAX_SLAB_TO_SCAN| from both
the head and from the tail, and outputs an approximation that shows
<1% difference.

With a slightly larger limit (like 10000), count_partial() should
produce the exact number for most cases (that won't lead to a
lockup) and avoid lockups with a good estimate.

