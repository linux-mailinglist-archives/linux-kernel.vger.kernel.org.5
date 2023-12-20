Return-Path: <linux-kernel+bounces-6276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CD28196A9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 102CF28837E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F4EDDC6;
	Wed, 20 Dec 2023 02:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NDIkSn7/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mT+pnZVO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451798F42
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 02:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BK0kFeU029382;
	Wed, 20 Dec 2023 02:00:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=9urVn8BKPLG8qc3TwoO0vKbNbXk2cHamkQ1sErDtgIk=;
 b=NDIkSn7/IZPi6ge8rzcuaJ9Fr1FWdqJaoN1SGlVe6CZ/qDPP5ERJAzDjSfINOZhw9U1U
 HtdwWRUechyMC2a2M0ZQhX1eSqicHp19HcIwGUFbA34nx5rox6ZzGxOCa/28zmvUhQuH
 98pKqKdQnpGSanzfdCx1AdI5p5CQx7CCOfE6ihsmYq/oPdnMrNI6iEgskjJYo0JzYWvl
 xCU4tClQWGYfsJJrineOJLSjVTGFExzQLt6sow2OKl6MU0bXUxknm6t8IK3VGoJd7i/E
 HLwpaWHsMgvRMC0NxcOvCO2QO0xwfQnpyPJO1Ufs8BtAEwRWxk8vg241vDTkgew00io5 uw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v12p47dyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Dec 2023 02:00:54 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BK0BVWH020935;
	Wed, 20 Dec 2023 02:00:53 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12b80jpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Dec 2023 02:00:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yzx/o75xVc/iCk+hZmrpdD8siNpu2VL0VKp0ZMvmhfRfmPmXiLoMI3J/VtYYZpq19IH6EWxLLBIh+Hu+dclW7Iqey26PSPJv/ndX5lwVT4yV+le84YuXZ7MG13ZVZPZb8P7Oth02RU1UMQSjrdU+CXfrh4uPBqy9OumlyX4ieg0XkO5iZYDJYTIjaBxcNN57vqMXczP8TeJvfUUSudRU3zBJDHrbAAMyoZR32XYmOn6aO887YSnFgUWMbwZxaJZC+Kcl3yriHq3kpAZm5yTQgA6yXLKtbv5878wUFZ1hHxaLJVhACmIIQVDMaR9702/od4gCISbRtvGVLic+5BOABA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9urVn8BKPLG8qc3TwoO0vKbNbXk2cHamkQ1sErDtgIk=;
 b=J+hvw20UB/h0I0/Kk/EM4sGWeniRYpATMyaESzMc3dX/tPayZkAIq6xyMuo3GZheMBxC+vpWqTCqBTNXAnlwWFK8TPLranBBNt0aM6OuJI7x820MVLSTEDmBDeLOw8N/O4NvRXl4TorWmZStQtcOI6YnLZ2DoRtJ/3P9vdQXBiM3fsMS15hT78P50HyjnRzJ2qnzgzRfxdD+7I2u/fgKGeNUrjulEhNAol8OP4vjXRyjuRxUPoklpRgeIsh0xb9ZxUah9AfajlLj2ChI5y/ujOF870mIW4DI1kHnGGFj0IuOvB1eNlw63QiEZS1NH3Rqz/W2U238Otw4YOzhyp6eQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9urVn8BKPLG8qc3TwoO0vKbNbXk2cHamkQ1sErDtgIk=;
 b=mT+pnZVOsKDXVRje0o6wojR3nriTrKHdVoUyXn2JWm24C2GpQnikHcihTcF2KcBkQUQ8X/Ky2zvKduGg5lRPJ13/7DnS8hDEoRyLFhk5XULLJveg7Wyj9/3RdpQRRPDnTv9l06zVU6aweE6cH+wVlYJWoblomf95Gp4x8kFEhO8=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CY8PR10MB6802.namprd10.prod.outlook.com (2603:10b6:930:99::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 02:00:50 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::5a0:6591:b3e7:75fc]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::5a0:6591:b3e7:75fc%6]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 02:00:50 +0000
Message-ID: <a9993f8b-6449-4452-a168-db966d9bae49@oracle.com>
Date: Wed, 20 Dec 2023 13:00:41 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] sched: fair: reset task_group.load_avg when there are
 no running tasks.
Content-Language: en-US
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
References: <20231215052652.917741-1-imran.f.khan@oracle.com>
 <CAKfTPtD85OSem=7RMquLWokVp7gffvDaY3mtwevkxp1mSSVVqQ@mail.gmail.com>
 <d8507f86-2458-4b01-a774-5102473e657e@oracle.com>
 <1c13b0cc-098c-4f75-9f37-a53a66965409@oracle.com>
 <CAKfTPtDqqAYNCFb6US-4Yd=-xvj8mhMuO0PkUhWsqekxp__M4g@mail.gmail.com>
From: Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <CAKfTPtDqqAYNCFb6US-4Yd=-xvj8mhMuO0PkUhWsqekxp__M4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0075.apcprd02.prod.outlook.com
 (2603:1096:4:90::15) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4468:EE_|CY8PR10MB6802:EE_
X-MS-Office365-Filtering-Correlation-Id: 988f2015-daf3-4330-654e-08dc00ff7d30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UAyNQ5w3OWKVjR7tai+91KKxCLciISYtjlAjmPohX5my+5IswlUF4wmO8EKDyEJ+DclcruxVEK9wgonaoQTiGnilmV57hVhep6m51xRrbvZQ4Wr2tqK6WA7aZ2AF3LNAfUxxT7RSNdSIwziawhYVT0QNqdFX45ySt3guSTytWAwAWllL6sU4B0UaXvcEVXyplb5lGWLDb8CDAWy015wyZINdX+PcSc5jaVVz/wMVdkruHDtXZazujHPaPdq6fWrF7nZ6FQTC+8ukOQ5ToT/Op5VFePeOy0aFEi0htNjF4f61K+pKcse1CHfWulZtxrhCRX/bcLti4WdqxQi7VYUEQvhf6bnd/r8KCGeAN9XynF5z/w0xEvPkJl2dg2UUWDzExj3Wi7b8ks8ZP6OwteWneZGHdghvrCphoe2x8Xg1FGj6p5F1iLTXCO5C2L5XFduJNfn/bW0dwdizLs8+yGs/OBLllSzGEO/U+ofZURJyZTGfN31/ByN7duIHqakY6wfji18m3hUGfOgfZftp9O7OOClZasG4Vew/aEgfZSW9lREWL8yAjoVCpEBhEzJI3bOrpa4/KpTg8YrdtYLmK5SgnnNpx/QSqaSBUKMYwlu7MmECf6h/kR5n7avUo5jCVGrPCU9Fh0ruMDeOo6Q/Figr0w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(66556008)(66946007)(2616005)(83380400001)(66476007)(53546011)(6916009)(478600001)(38100700002)(6486002)(26005)(8936002)(316002)(8676002)(4326008)(6506007)(31686004)(6512007)(6666004)(7416002)(5660300002)(2906002)(86362001)(31696002)(36756003)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N0VqUDM5WDhOdHhoV01Yd0NiMThzT25pR3h1TXhVRlNFZ3QxaiswSTdFTWhk?=
 =?utf-8?B?Z1Zvb0UyMXpOYmgzeis0a29FVGhFczkzYWRUMzhKdmppV3RTQUI0b1VGSmhV?=
 =?utf-8?B?MkZEckl2TGZtVGNvd2tXZGRQd1BoWHd4V0QwSnA3UXB2anR5RDBVdnlCVWpj?=
 =?utf-8?B?dy8rN1dJMXhXRE1CTzZhaS9ZY1dPR2ZBeEN2Wk1HRXVYREYzSTY1QXVYRlJv?=
 =?utf-8?B?RWdWNE5HMVdSSGVNU0xRMXRmUm9wYjY1Y0VZV0w3eDNoa0FhNDRFMTNBWThh?=
 =?utf-8?B?TVdHMTl2R3ZmZTkxd0tjZDdTVU9zVEVYem9DbGtpYXlhTGlrSVFqQmdxOEpo?=
 =?utf-8?B?QVdURmpWSlNqQ3JQUk5OM2ZzV0Y5azNUa05QR0lEVFlZNDF0UzZtRUVJRnlV?=
 =?utf-8?B?WFY4QXRaR2pFSkhZcDRqUzRNeERCSDMwYVJWdDM0WTRhc2pGQWdBYWMzdit4?=
 =?utf-8?B?Y0lQQWpzZGRpK0cvaVFkN244YWZCS1VhYkpJWjhUcXZ1OVhiZGFJTFQ4NnNz?=
 =?utf-8?B?MjhTWXhCZ05sWHIzNEVldFJnYU02NUVmTkZlcGlSNzJudzVmQ0ZoWjcrZ1BN?=
 =?utf-8?B?WWQyRUluYWdUTStGSnpmd0s5RzN5d1FlUGhEZmd4VGFkUm5UZ3JqRWIvMFE4?=
 =?utf-8?B?VWdHdUpHbXRwekRMMG14N3A3Q2JXV2dUTW1Rc09pN0pLbzFzOU1wSld4ZDc5?=
 =?utf-8?B?VDFNWFdzTjBWaGg0TitlK3dVTjV1ZFVhNklLd21oZ0M5TXl5QXZmYjgwK01C?=
 =?utf-8?B?TzM5bi9Tak16dVl1Z2o2TUpXSGsyNWZiUVlrSURnd201M1NoUWNLRm1sTi9n?=
 =?utf-8?B?cjE1ZTdkQlFlNmsrSWJqT2tyODIxQ2RCRU9jeWdPNWxhRG5NejJMdUxvL3cy?=
 =?utf-8?B?MmxwS3I1aG4vV09MNFVmMFNBRDF5SjZpa09YNXJGQmh0RUZmblRNck5xYWw1?=
 =?utf-8?B?SEhYSGxFTzFSRzJIekVISmg2Q1dtZzRZd21Na2RBWUw0OHExS1hwQk5uU2ZS?=
 =?utf-8?B?cUx2RUR5YnV5VlROSElXY3ZFRDFrTUpPM3AxN2pOWUJ3VjE0Y09lNXoxaVJm?=
 =?utf-8?B?SnhzK1psdlJaTHg4aHUvdy9oYnBKYXpZVVNwTjNhY2IyZTdzMTMxUDZwdGk0?=
 =?utf-8?B?akNWT0xKdldGRUtpYXlXNkpTOTNZZnFqZSszTG00eUo1WG9FaDNZeENEQTk4?=
 =?utf-8?B?SHZuZGswWWJoQmhDWlNmblkvNkpQZHFLKy9xb29icG4zZktJUE8yNUlLdlpn?=
 =?utf-8?B?aHFrTXhrZEZpTmhjbXA5V3hqNytFemdYQlB4NGZpeDFzenJqeVFTWWZqNHdr?=
 =?utf-8?B?NU9NZG10S2VLWGc3cnB1VGwrZmFwNm5sS0xaOEl6TjdNVFQ4bU81Y21JSEZI?=
 =?utf-8?B?ckpCd2hJYmk3ZjMyTFFsdWlTSXhaWVVjSGxBQlhGVDRaNWRRVkNZTkkyc1RR?=
 =?utf-8?B?L1Zsa1BBeG9lVkZnOHkyRklPYWo4SGlMM2pwL012VkkyY3VZZlc5TGZ1dVgz?=
 =?utf-8?B?WHpRSU4xRVJ0WGxZTWwrNlJHTWI3SHJhQkNZNmtTWHVDdk91aFB3TkJqRzFr?=
 =?utf-8?B?SmNndkkwUHVuT2Y5b3NET2xQanlRVEF5YmZwOXRxQjJtaEZWNyt2RGd6N3Bk?=
 =?utf-8?B?TlNBUnAyVTN6dDRxTjFFek8rZEJ3MVBIdkRQbjdSbXo2c25QVTlFZGlsWlpV?=
 =?utf-8?B?ZFpnSWYrcStycHM5bHRnSWdEMjVCQkxUY0hITkVCdS9pRWVvWE5OT2w5citZ?=
 =?utf-8?B?aS93TXlSRlNlT2MwamZGVlNCN0o0VDZFYlVwdFhYTENGaEdUUXBXZ044bFky?=
 =?utf-8?B?dy9XdE01V1JCbnRRNUNmZW5tT1BxcW5tbmxkTkRyMm4zdXArazhUYnRYZktS?=
 =?utf-8?B?TXVYOXNqT2phRVdkQTg0Rzd4bWVOK0M5UGVQZVJaS2Q1bmVlbVlibjRtbGhp?=
 =?utf-8?B?SXY2RHh3N25aU2RPUG1tVEJlRGp3K0gxSEd3Wk9Sb1dyTUlTbUVaTXA2blZw?=
 =?utf-8?B?Uld4NEYrVFRaNy9PQ2dJUnhrb3FHdnd1OHora2NlbnZwZnhVajRFbU5QV0JP?=
 =?utf-8?B?SlY2NjFDQlA3ajBrTVZuT0NKS2tQZThieEtMZVlWTm5nQ20wSlRJZDRtNzRV?=
 =?utf-8?Q?1VDs9ZngqlN8XIQzh9agITWp/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	zVQRujY9caOkaVkhvIYzO0WwrhwwpSEd+mEoK6U4VydKrJCLfRA0FzYd85PjJSFEIgtgvg1pPJEAMbNuoNClga1G3HcnOxOpJqo4YJyF+++d+NDDU2oxZELLmHe0OrK9ysNh+SV5vraHDnZMbvQhskSfZl2YoUPQ8bmOzfXGEXSFu3cBTP27K+jiE3Nw8PvUFzrgvkN9/zFrnBYqVsJW2NKU7mDmoy3ODr2bfVQt0+xavLYbvsNphC4LFSaHBJe1g+mZKbVZp3aEyCLPeYh86/wpkA3FqQXk/76jzx8/OsDiIY7u01vWZTygFbv1GHhj60JUFUoINjsPfZkJKjigCQyUEbfxrv7/nlLCX9+O1/IpZEdr00hIgbCnzU35k5aTGb1BUqEzlvGa6W5S7l4KLyeehhpw3ucI03OzVEpSik8qPrzjej8qyErS7qeOpx2LeLqEEaKL1D5Q08ltz3KQZzhVjfReUGgMsCDMQgJvjbUtPUSabd07EgXVQAT0E2YR9x27TZgXWRkRlfwR86CChoAGU1dTvFyC6izxEQ1WW3fMLv0VkwcdyWNNL4wwuBcZp+keS2aoaa6EPdlbvD+7HeQrK903UrPd9+MzXO1giCU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 988f2015-daf3-4330-654e-08dc00ff7d30
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 02:00:49.9957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LnJ6vqfz4ug2XglUwQs3xTM4qGhLYoTUxmJfYzVF4jUibtVlZpgVuMY395wvXpYVrYc5IsPqDPVWnHJPTJuM9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6802
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-19_15,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312200012
X-Proofpoint-GUID: IysCPvtXwJdY5MpV1oPbWJOL-Z-v2sO_
X-Proofpoint-ORIG-GUID: IysCPvtXwJdY5MpV1oPbWJOL-Z-v2sO_

Hello Vincent,

On 20/12/2023 5:49 am, Vincent Guittot wrote:
> Hi Imram,
> 
> On Tue, 19 Dec 2023 at 07:42, Imran Khan <imran.f.khan@oracle.com> wrote:
>>
>> Hello Vincent,
>>
>>
>> On 15/12/2023 8:59 pm, Imran Khan wrote:
>>> Hello Vincent,
>>> Thanks a lot for having a look and getting back.
>>>
>>> On 15/12/2023 7:11 pm, Vincent Guittot wrote:
>>>> On Fri, 15 Dec 2023 at 06:27, Imran Khan <imran.f.khan@oracle.com> wrote:
>>>>>
>>>>> It has been found that sometimes a task_group has some residual
>>>>> load_avg even though the load average at each of its owned queues
>>>>> i.e task_group.cfs_rq[cpu].avg.load_avg and task_group.cfs_rq[cpu].
>>>>> tg_load_avg_contrib have become 0 for a long time.
>>>>> Under this scenario if another task starts running in this task_group,
>>>>> it does not get proper time share on CPU since pre-existing
>>>>> load average of task group inversely impacts the new task's CPU share
>>>>> on each CPU.
>>>>>
>>>>> This change looks for the condition when a task_group has no running
>>>>> tasks and sets the task_group's load average to 0 in such cases, so
>>>>> that tasks that run in future under this task_group get the CPU time
>>>>> in accordance with the current load.
>>>>>
>>>>> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
>>>>> ---
>>>>>
>>>>
>>>> [...]
>>>>
>>>>>
>>>>> 4. Now move systemd-udevd to one of these test groups, say test_group_1, and
>>>>> perform scale up to 124 CPUs followed by scale down back to 4 CPUs from the
>>>>> host side.
>>>>
>>>> Could it be the root cause of your problem ?
>>>>
>>>> The cfs_rq->tg_load_avg_contrib of the 120 CPUs that have been plugged
>>>> then unplugged,  have not been correctly removed from tg->load_avg. If
>>>> the cfs_rq->tg_load_avg_contrib of the 4 remaining CPUs is 0 then
>>>> tg->load_avg should be 0 too.
>>>>
>>> Agree and this was my understanding as well. The issue only happens
>>> with large number of CPUs. For example if I go from 4 to 8 and back to
>>> 4 , the issue does not happen and even if it happens the residual load
>>> avg is very little.
>>>
>>>> Could you track that the cfs_rq->tg_load_avg_contrib is correctly
>>>> removed from tg->load_avg when you unplug the CPUs ? I can easily
>>>> imagine that the rate limit can skip some update of tg- >load_avg
>>>> while offlining the cpu
>>>>
>>>
>>> I will try to trace it but just so you know this issue is happening on other
>>> kernel versions (which don't have rate limit feature) as well. I started
>>> with v4.14.x but have tested and found it on v5.4.x and v5.15.x as well.
>>>
>> I collected some debug trace to understand the missing load avg
>> context better. From the traces it looks like during scale down,
>> the task_group.cfs_rq[cpu].avg.load_avg is not getting updated
>> properly for CPU(s) being hotplugged out.
> 
> Your traces are interesting and I think that
> task_group.cfs_rq[cpu].avg.load_avg is updated correctly but we don't
> call update_tg_load_avg() to reflect that in tg->load_avg.
> 
> Could you try the patch below ? It forces the scheduler to clear the
> contribution of all cfs_rq of a CPU that becomes offline.
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 466e01b2131f..e5da5eaab6ce 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4087,6 +4087,11 @@ static inline void update_tg_load_avg(struct
> cfs_rq *cfs_rq)
>         if (cfs_rq->tg == &root_task_group)
>                 return;
> 
> +
> +       /* rq has been offline and doesn't contribute anymore to the share */
> +       if (!cpu_active(cpu_of(rq_of(cfs_rq))))
> +               return;
> +
>         /*
>          * For migration heavy workloads, access to tg->load_avg can be
>          * unbound. Limit the update rate to at most once per ms.
> @@ -4103,6 +4108,48 @@ static inline void update_tg_load_avg(struct
> cfs_rq *cfs_rq)
>         }
>  }
> 
> +static inline void clear_tg_load_avg(struct cfs_rq *cfs_rq)
> +{
> +       long delta;
> +       u64 now;
> +
> +       /*
> +        * No need to update load_avg for root_task_group as it is not used.
> +        */
> +       if (cfs_rq->tg == &root_task_group)
> +               return;
> +
> +       now = sched_clock_cpu(cpu_of(rq_of(cfs_rq)));
> +       delta = 0 - cfs_rq->tg_load_avg_contrib;
> +       atomic_long_add(delta, &cfs_rq->tg->load_avg);
> +       cfs_rq->tg_load_avg_contrib = 0;
> +       cfs_rq->last_update_tg_load_avg = now;
> +}
> +
> +/* cpu offline callback */
> +static void __maybe_unused clear_tg_offline_cfs_rqs(struct rq *rq)
> +{
> +       struct task_group *tg;
> +
> +       lockdep_assert_rq_held(rq);
> +
> +       /*
> +        * The rq clock has already been updated in the
> +        * set_rq_offline(), so we should skip updating
> +        * the rq clock again in unthrottle_cfs_rq().
> +        */
> +       rq_clock_start_loop_update(rq);
> +
> +       rcu_read_lock();
> +       list_for_each_entry_rcu(tg, &task_groups, list) {
> +               struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
> +               clear_tg_load_avg(cfs_rq);
> +       }
> +       rcu_read_unlock();
> +
> +       rq_clock_stop_loop_update(rq);
> +}
> +
>  /*
>   * Called within set_task_rq() right before setting a task's CPU. The
>   * caller only guarantees p->pi_lock is held; no other assumptions,
> @@ -12414,6 +12461,9 @@ static void rq_offline_fair(struct rq *rq)
> 
>         /* Ensure any throttled groups are reachable by pick_next_task */
>         unthrottle_offline_cfs_rqs(rq);
> +
> +       /* Ensure that we remove rq contribution to group share */
> +       clear_tg_offline_cfs_rqs(rq);
>  }
> 
>  #endif /* CONFIG_SMP */
> 
> 

Thanks a lot for this suggestion. I have tested it in my local setup and it is
fixing the issue.  With a little tweak (remove usage of
last_update_tg_load_avg), it works well for older kernel (v5.4.x) as well.
I have not yet tested for v4.14.x but should be fine there as well.

Thanks,
Imran

>>
>> For example if we look at following snippet (I have kept
>> only the relevant portion of trace in the mail), we can see that,
>> in the last invocation of update_tg_load_avg for task_group.cfs_rq[11]
>> both the load avg and contribution of this cfs_rq were 1024.
>> So delta was zero and this contribution eventually remains undeducted.
>> In this case scale down was done from 16 to 8 CPUs, so CPU 11 has been
>> offlined.
>>
>>
>> cpuhp/15-131605  [015] d...  6112.350658: update_tg_load_avg.constprop.124:
>>    cfs_of_cpu=5 cfs_rq->avg.load_avg = 0, cfs_rq->tg_load_avg_contrib = 0
>>    tg->load_avg = 0 delta = 0 ###
>>  systemd-udevd-894 [005] d...  6112.351096: update_tg_load_avg.constprop.124:
>>    cfs_of_cpu=11 cfs_rq->avg.load_avg = 1024, cfs_rq->tg_load_avg_contrib = 0
>>    tg->load_avg = 0 delta = 1024 ###
>>  systemd-udevd-894 [005] d...  6112.351165: update_tg_load_avg.constprop.124:
>>    cfs_of_cpu=5 cfs_rq->avg.load_avg = 10, cfs_rq->tg_load_avg_contrib = 0
>>    tg->load_avg = 1024 delta = 10 ###
>>
>> .........................
>> .........................
>>  cat-128667  [006] d...  6112.504633: update_tg_load_avg.constprop.124:
>>    cfs_of_cpu=11 cfs_rq->avg.load_avg = 0, cfs_rq->tg_load_avg_contrib = 0
>>    tg->load_avg = 3085 delta = 0 ###
>> .........................
>>  sh-142414  [006] d...  6112.505392: update_tg_load_avg.constprop.124:
>>    cfs_of_cpu=11 cfs_rq->avg.load_avg = 1024, cfs_rq->tg_load_avg_contrib = 0
>>    tg->load_avg = 4041 delta = 1024 ###
>> .........................
>>  cat-128667  [006] d...  6112.504633: update_tg_load_avg.constprop.124:
>>    cfs_of_cpu=11 cfs_rq->avg.load_avg = 0, cfs_rq->tg_load_avg_contrib = 0
>>    tg->load_avg = 3085 delta = 0 ###
>> ..........................
>>  sh-142414  [006] d...  6112.505392: update_tg_load_avg.constprop.124:
>>    cfs_of_cpu=11 cfs_rq->avg.load_avg = 1024, cfs_rq->tg_load_avg_contrib = 0
>>    tg->load_avg = 4041 delta = 1024 ###
>> ..........................
>>  systemd-run-142416  [011] d.h.  6112.506547: update_tg_load_avg.constprop.124:
>>    cfs_of_cpu=11 cfs_rq->avg.load_avg = 1024, cfs_rq->tg_load_avg_contrib = 1024
>>    tg->load_avg = 3010 delta = 0 ###
>> ..........................
>>  systemd-run-142416  [011] d.h.  6112.507546: update_tg_load_avg.constprop.124:
>>    cfs_of_cpu=11 cfs_rq->avg.load_avg = 1024, cfs_rq->tg_load_avg_contrib = 1024
>>    tg->load_avg = 3010 delta = 0 ### <-- last invocation for cfs_rq[11]
>>
>> ..........................
>> ..........................
>> <idle>-0  [001] d.s.  6113.868542: update_tg_load_avg.constprop.124:
>>    cfs_of_cpu=2 cfs_rq->avg.load_avg = 0, cfs_rq->tg_load_avg_contrib = 0
>>    tg->load_avg = 1027 delta = 0 ###
>> <idle>-0  [001] d.s.  6113.869542: update_tg_load_avg.constprop.124:
>>    cfs_of_cpu=2 cfs_rq->avg.load_avg = 0, cfs_rq->tg_load_avg_contrib = 0
>>    tg->load_avg = 1027 delta = 0 ###
>>  <idle>-0 [001] d.s.  6113.870541: update_tg_load_avg.constprop.124:
>>    cfs_of_cpu=2 cfs_rq->avg.load_avg = 0, cfs_rq->tg_load_avg_contrib = 0
>>    tg->load_avg = 1027 delta = 0 ###
>>
>>
>> If I understand correctly, when CPU 11 is offlined the task(s) on its cfs_rq
>> will be migrated and its cfs_rq.avg.load_avg will be updated accordingly. This
>> drop is cfs_rq.avg.load_avg will be detected by update_tg_load_avg and hence
>> the contribution of this cfs_rq will get deducted from tg->load_avg.
>> It looks like during hotplug load of one or more tasks, being migrated are
>> not getting accounted in the source cfs_rq and this is ending up as residual
>> load_avg at task_group (if these tasks are members of a task_group).
>>
>> Moreover this looks racy and dependent on number of CPUs or some delay.
>> For example for scale down from 124 to 4 CPUs I always hit this issue but
>> for scale down from 16 to 4 CPUs I hit this issue 8-9 out of 10 times.
>> Also for the cases when residual load_avg at task group is low (like < 10),
>> I can see that both of my test cgroups get similar CPU times which further
>> proves that the unaccounted load avg ending up in a task_group is eventually
>> leading to uneven CPU allotment between task groups.
>>
>>
>> I am debugging it further but in the mean time if you have some suggestions or
>> need traces from some specific portion of sched code, please let me know.
>>
>> Thanks,
>> Imran
>>
>>> Thanks,
>>> Imran
>>>

