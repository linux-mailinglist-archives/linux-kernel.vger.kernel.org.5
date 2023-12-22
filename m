Return-Path: <linux-kernel+bounces-10086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF2381CFDC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 23:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ADB0B23A36
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 22:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C0E2EB07;
	Fri, 22 Dec 2023 22:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NmLuwRxT";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="FoqtDGLZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ORp7rnM1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8142B2E84D;
	Fri, 22 Dec 2023 22:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BMK4kR9011106;
	Fri, 22 Dec 2023 14:41:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=EkdXQk6jgXf7hit7i47vn5RugB2Lqyq8i23WxUL1hyE=; b=
	NmLuwRxTZVBCQCftGQ0QelMI6KPdObrqNuW9u3dfjWkscn5NFwO5vEvCTk0vWFiH
	8SWCcgWiQ2nsizaEkuB5gRNOd/tqzuOumD5PA+qEDv3aMT4+1LfrkkzeTsbGqFvS
	Wtce7dmSBHshtoYX+Gn8y5o8J3KleRc/0bMJqVnplFPUtxtoS6K/gN1KaSudfv3o
	5f+gVo6NCUVfxNA6JLU/hFjLdw1zSmrPt7E5YGT2DHzK4mSZnNiOvRTc7AVy0b/7
	D9nLxRthhEmQDakQoBiXGPl0sNvUvgqpNZ2396YxXAaFe5gTedpHXTvCrM4jaa3A
	IZRxucsupE7Azogu21d5OQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3v5gpw8fta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 14:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1703284913; bh=EkdXQk6jgXf7hit7i47vn5RugB2Lqyq8i23WxUL1hyE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=FoqtDGLZaFQytatkG5qHssHlkp0J0lOjYf3JILKBpVt9oEbJW60WhqkTzgTJ1v/nR
	 K8JqsKGY9FlBK1W2BMAErfpGRgCeDxLM1om2CCoQuTr+eICg5N8rThBYT+fWI5X9cf
	 B6JvJ75WTPmmr5RaxzB1ghiTukomXFNz/RBqz2a0llAuV+GffiPgERY9XY7i8px/dJ
	 6FeNcRetYntL8pGeZz0myccy2VeylVQlBwozcdw3tEHRQ53WAgeuIk1VBkeIEytxqa
	 AhmboW7yFec/xKPVtKNCwHQUwGAU1WLhxuswiNaeffnnjUw3wJwpU7hA0dkmuLHdua
	 QSnIdz6XfmmsA==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B2B89403B9;
	Fri, 22 Dec 2023 22:41:53 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 6AC3CA007A;
	Fri, 22 Dec 2023 22:41:53 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=ORp7rnM1;
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7EB3640361;
	Fri, 22 Dec 2023 22:41:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jozZ8UyOO9/xyzbqqWqKixKiqXCupv57cYXEXY4RGrmZJ9kaOtWTDq3EaKng4zPxNLDVHEjjUqSeRHahtyQt0y2ePrkd5CoYHA1Sj44jiNeVHBeHcc+25gbrrbfGqK4HjV5Kr0RYaN21nZKFZrX2hDdX5GK+Ukwu++3KiKk7n/ExqIr+634yIL/bJBxfImZRjlsQzhvz1n+k5yN+uyaYSDRBLoZeuMGFfwBE66ItGDl7lh8QsjuwoyyozdJhL+3o+ey7lYET9/PbRZT3FH8XMdLq5YUesQg0x/QnWuDcYi+nwRcksNo4sR1BZN8bBbmEmU63t8dhNzz7fz5DifOsIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkdXQk6jgXf7hit7i47vn5RugB2Lqyq8i23WxUL1hyE=;
 b=aNo0NaMMRPIe1MXEmvuc/Pk3A2PhQ7Q3vAKBE7HFcxJjIVNJhUjLVRhLGcojqERLuLMfeY4JqrHFmO3C0y6m2Buc4O1Yd7uxzhlKOszDupXuc0IgOJsI1E4XFwmfCKn8RU4gwVReRbqQK2cJqrJsdOQS6KOrQDcZIOWKsshjC4eiBbvPaFE21bh7MN9kLY8159vr69l8YEGSQp2e9kkDHyWyeg62VbvHEAO/FyG6+FangBM+gTh8ceG4tJOZKSIUQLDZd6TnnRqARMou0OqpuPOhk0Kaz5VJiCLQ/S5NthFTVHwuuIJZzqpggpBor8cvOSkrFmLBLJVzwHT0CjCWUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkdXQk6jgXf7hit7i47vn5RugB2Lqyq8i23WxUL1hyE=;
 b=ORp7rnM1hP1x72UawJzhdKpp4e3SNVHZvHiRbmj10FdvZs/gBerxyVwtRrDH1My1fYWDQc7+Wc9aCV/Xu8X6yvmRQfwyF/PPmo7GlsS4szXOQuCAHgC/SfwqKQ5bO3w1IWSWAIRtFxNeIUF6MM7PUD40K3cXOVGpZ5NuSrtKrEY=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by IA1PR12MB7518.namprd12.prod.outlook.com (2603:10b6:208:419::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 22:41:48 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::d931:a262:ec3b:3e56]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::d931:a262:ec3b:3e56%4]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 22:41:48 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Wesley Cheng <quic_wcheng@quicinc.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: Handle EP0 request dequeuing
 properly
Thread-Topic: [PATCH v2] usb: dwc3: gadget: Handle EP0 request dequeuing
 properly
Thread-Index: AQHaKIHm0EuTqu8hOUu3YwYN1uVLWbC1/xOA
Date: Fri, 22 Dec 2023 22:41:48 +0000
Message-ID: <20231222224147.hq6kyogys53eyhtf@synopsys.com>
References: <20231206201814.32664-1-quic_wcheng@quicinc.com>
In-Reply-To: <20231206201814.32664-1-quic_wcheng@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|IA1PR12MB7518:EE_
x-ms-office365-filtering-correlation-id: 0d91164c-b396-4904-1b3d-08dc033f2f17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 +9MJj6OAkOHmPjkNtWi4wBHjUth9ZZAjrbwlwvBQ2eFUJo6SFy9uxo3Y3xKPkuIyl5+Cy7WiucZP8UhpqGfPnjmnYnbs6SsIEXZNrtF9AQSp26xHBtN5jdxNq36cr6y3oh1AEjdJyUVOH6GEGlC4iXiEc6zWL78L55IlsfR7sxntF9Z6l6miczxoIuQiOk4S2rgXrvBFdvZ3qE/wT1fMWOaZq/ni8Uq87308QlP3dJwSY/OlBlk1Qihnjba2zu7OS5QZF00ocVQ06U8mm2M/LY8sJyiRiSsvKRLozB6UjEXJ/tc+y4KRV0Nay62+nbYV8AfZTd8ZqmihIco/H5wNBkFhqC2GJON5JxkPyiXTxdLXb7RuaOKU/1H7VRcLaZg3iZRue4Z6cn0wmRZJl/kQ2Q0wV6YoNy3uiPggc3WBFqZrcdtQrXY74DTdA/Wt68Sm/v6k0tXKew3Nm/JSfWw62tHTTlYFUKIek9RM7HgqiWckM2RExCf5u5QToA4L0xovRZyBOZyynLK8pbaZAPlDYeTNDhGG6lJybtdUVzjfG1ZtlJbXnyTYqlLnCTaOvEKnqKPoMA4SCilhl/ZQP/sWv7n++Bbsrn7GQiH8TywR3MLgiFIwt4ZdiqJMl3Q2HPfQ
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(76116006)(64756008)(6916009)(316002)(5660300002)(8936002)(66446008)(54906003)(66946007)(66476007)(8676002)(66556008)(1076003)(2616005)(83380400001)(26005)(6506007)(38100700002)(478600001)(122000001)(4326008)(6486002)(71200400001)(36756003)(38070700009)(2906002)(6512007)(41300700001)(86362001)(66899024);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ODJkbUNjbEUzWkdUYVhSMzVUTGVKMFBqNnJpcDl6MnFiMW9Dc3ZNUVJsK3FV?=
 =?utf-8?B?eHpXdW4yRzRta09TaXY5aGl5S3YwUytFV0RyWjNHeldaNjRscnBiWGltY0RX?=
 =?utf-8?B?YkpSRm9NV1VaS3k4cUI3SFl2NmJSbUQxMlIxekZuYUlwaS92TmpIbzYwWFJC?=
 =?utf-8?B?M0ZGaDJ5dk9IYW5Va2ZnR2hsNjBpNm5pRE81QmNkTXpxcGgyTXBsdHpXblNU?=
 =?utf-8?B?N01jRG9UMmlwRjRNdjBkZlZRdW1DNGFnalNneGxEaHRoU0ljR1VOZG1DK0ht?=
 =?utf-8?B?ckp3N1dQeEtzRkxndnhScm5scUNCKy9nQm5KTDFsTVRaTUY2N1ViUHNwYXFw?=
 =?utf-8?B?SlFOVWxnOEU3cmt1eUlPaFJkZlBZK0krN3h3UTQvc0s0S1BzUzh0YS9sVWNT?=
 =?utf-8?B?L3lsRnJTV3VCTnJmM1VBQ2JWNFhQRG1YUzlYbXdBRTJRY2dTTUs5TVlNUDFn?=
 =?utf-8?B?a0dvNUZnNFl2UTd0TzI3cnRaekl1aDR5aWp4aDVadFl0WkpxdEF4MkZsMEMz?=
 =?utf-8?B?eGVUNE1MZ25kdmVuUmNTUGJFcTNGd2lZSDV2NGN3bTdFTjVPaG5nZnp5ajFD?=
 =?utf-8?B?R2xTemUvbURlTWVsRjNQL0pPSmtoQTR3RXNiMDc5VTJWVk5HOHBONUhjRTA2?=
 =?utf-8?B?di96UkE4bnRYUGN6Wnl6WFI1VWszajh6bFVVVUVMUmd4bGdxd1AybW01SmlY?=
 =?utf-8?B?aDRaSW1zRWNEZC9ZRnpwL0M4RERWZVJUY3h3Z3NwU1l2QkpMazY2NnpLcFBP?=
 =?utf-8?B?REQzc1JWM2JNeCs2ckIvMlBYN2lzbWxHZmk2STVjK0V5NloxZ0JmTWUvSWtn?=
 =?utf-8?B?eGRiQ1VkbGZRZytXRGVWWEorVzN3K2pBZ1JvODBqWWZYckFCTUh5YVB0M2ZV?=
 =?utf-8?B?ZDhSK1hhc1V0VkNFNkNrWElxeWlEakRVNFVjNlI1KzdPTC9Wd1ZpMUdZb2Nt?=
 =?utf-8?B?UUtXZGoxdXNkQ2NXa3AyWXFIdEhXZ0Nia210ZVlDQjhaWFdSU3dueWFJcHhB?=
 =?utf-8?B?Q3FYVlh4VjZGRlA0OFlVT1lWU0dMMkFOSTVqb0dZVzN3UWhYck5BVFozMGVQ?=
 =?utf-8?B?RmpjeG1qR0JxRjgweE1Zb1c0VnRKVExWK2JkRmpMdklTZWJQZFVId1RmWmt2?=
 =?utf-8?B?UkdvVkNDQmFvZUViRDErRUNrRE1BMkc0SG4ybXlpT1NwOGxXZm5Db0hYZm5k?=
 =?utf-8?B?eEFJOURPVkN4amM0cE9iV3pJRGRoT0FqWE1vWGZlS3N3RXhVd3lIMlpnaDdL?=
 =?utf-8?B?ak03Q0VGOHNuYThUblNyVVZ5d09HcEszWEd5enRUUTcyaWJuSmNNTWc2bUxT?=
 =?utf-8?B?NzlkcTk0ZVhhL1ZEUC91TlNyNDdkV0EzODBVWHMzT0tERjdmeHJWeUd6a21N?=
 =?utf-8?B?ZVV1eU81SFBrOGx2bU1vOUJSRENSZmlNY01lNS95MVdDYmFhY1Q5clh2ZXFS?=
 =?utf-8?B?NHY3Z2dOQzF6K3VIV01UWk0xUEJyNmhRZmN2WWZickpWQ0tOU0duRGwxZ0lv?=
 =?utf-8?B?SEkrT0cydkV3NUVlWGw4cWFmbUdpNEpXNFZQMk9BcHlBeVp0bS9uRUtqZk9Y?=
 =?utf-8?B?VzNjYWo0UFZUWmFsMjR0c3ZzMHd4ak5TSHdMZCtuSnZJTi9uSlljUmcvYmxx?=
 =?utf-8?B?K25DZ2pNbVBSUTVpTnA3UWF0amE0ZnMwcGxXWStaRm5tOVRjRmdVYkVuUVFo?=
 =?utf-8?B?WEJ4YTFLa3V4cnExT3hNYnI4T3o2Wmw2a2t4bm1DOXFsVWJFRjB6eFVYWTJk?=
 =?utf-8?B?ajJONVF5NDlkQU50dGZkTm4yMHdITFlVYzBFODFxOWRVR3NsK2NJbCtTc0NU?=
 =?utf-8?B?UXhFV2RDc3NycXZIOGlVS2R5VmszUUtnb3N1WEJyQWRIV0pGNWd0NW1zNHk2?=
 =?utf-8?B?ZE9yZjdGeHRHNVptNFpRaURmN1UxbmhSZlhBbENBZEptWGJxNVNwUkJQMVlj?=
 =?utf-8?B?ZHZhVEt1QlY5Rzh5b0JYNzhDajFDbVJVVENhcmcvSElOZzBURHVlQzJ1ZUtH?=
 =?utf-8?B?YWo2UjZDRy9MZnpUUnpVVWxIa3JVN1M4TVNaTlhod24rNmRMSVNFdnpneExi?=
 =?utf-8?B?bjZhUjlsYVpUMnpkdlg2TmZGTFBBQzJRamI0TUpVKy9tcER5ZG5idmdDRkVs?=
 =?utf-8?Q?oDPfrGw6R+tEtP9MjZdQesl8+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69432550C18ED44EAB4B9F302C74F071@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0kSY6YNmJWnNzQylOeuvGmX1YEQ8hXt2bpTP0pBcxuDR5HZchNi1TRAZTGOg8yEMjQw0MG+1/OOrprAwwZG3dwFmGzJhNJ3xqHW2GTBwt8CCjeKJwrI7IjmZ8EQUL5g2mWcTqZ5R6gQJ+Gg6hkHwr9NzSK0M9I3/gsZgHyNleteKd63MAeeUmEDdEBFQWLbDUohLOkbDXkn8nLx2ftSRt/23K+WykZg/0ttTO/QMmx5F9xoEwZGmxFdOn5dzipf7EntBCdqgIHe+i1/Bnrmwfvi7oxTpO0K3u6OGvqMTN9U+wkAp39q6oBzhB9Uu0fmZdZv2QRQpNeY9hxQBIsClkUiqYBrkiIETDbDn5tuQAKtrFaW+k7804a4hIC4U9r5PvynAG0z7zPT8ZQGjY677xVPe6AH4A/eY3kRvLM1OMvHgXodosx3qY6wUzbnk9sU8h9+ER6Q9SveBOs/Nd3O15CyWAf/8VObcAWbED99vuo/xzMITsjw6lHt7M8UzKAKeM7OhuGd1LEMldPSwEgBk7y53cBblEQ5/D4Sq9wAviOrAQj7+QzvNdWqjzi2VwTmM+XVTRJgj4S1yUYGEo7+x7uK4u0LFIouN9jHmGXIUZirKBSz/0h7xr3Vc1wqKy67+MGU0X3jU/crc4yo9w5+wSg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d91164c-b396-4904-1b3d-08dc033f2f17
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2023 22:41:48.7256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d4mlx+HVZFVAhJkSBh71LmWszu7PQT9uHN6BA2MfVn/xdVqWf2ZHc1yRTs6U/F+YVWN8FlfBKFbXD4hYx6aWvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7518
X-Proofpoint-GUID: 6rUowHah4J4Mv9BYX_MOtOfalLcKD1dE
X-Proofpoint-ORIG-GUID: 6rUowHah4J4Mv9BYX_MOtOfalLcKD1dE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 phishscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312220167

T24gV2VkLCBEZWMgMDYsIDIwMjMsIFdlc2xleSBDaGVuZyB3cm90ZToNCj4gQ3VycmVudCBFUDAg
ZGVxdWV1ZSBwYXRoIHdpbGwgc2hhcmUgdGhlIHNhbWUgYXMgb3RoZXIgRVBzLiAgSG93ZXZlciwg
dGhlcmUNCj4gYXJlIHNvbWUgc3BlY2lhbCBjb25zaWRlcmF0aW9ucyB0aGF0IG5lZWQgdG8gYmUg
bWFkZSBmb3IgRVAwIHRyYW5zZmVyczoNCj4gDQo+ICAgLSBFUDAgdHJhbnNmZXJzIG5ldmVyIHRy
YW5zaXRpb24gaW50byB0aGUgc3RhcnRlZF9saXN0DQo+ICAgLSBFUDAgb25seSBoYXMgb25lIGFj
dGl2ZSByZXF1ZXN0IGF0IGEgdGltZQ0KPiANCj4gSW4gY2FzZSB0aGVyZSBpcyBhIHZlbmRvciBz
cGVjaWZpYyBjb250cm9sIG1lc3NhZ2UgZm9yIGEgZnVuY3Rpb24gb3ZlciBVU0INCj4gRkZTLCB0
aGVuIHRoZXJlIGlzIG5vIGd1YXJhbnRlZSBvbiB0aGUgdGltZWxpbmUgd2hpY2ggdGhlIERBVEEv
U1RBVFVTIHN0YWdlDQo+IGlzIHJlc3BvbmRlZCB0by4gIFdoaWxlIHRoaXMgb2NjdXJzLCBhbnkg
YXR0ZW1wdCB0byBlbmQgdHJhbnNmZXJzIG9uDQo+IG5vbi1jb250cm9sIEVQcyB3aWxsIGVuZCB1
cCBoYXZpbmcgdGhlIERXQzNfRVBfREVMQVlfU1RPUCBmbGFnIHNldCwgYW5kDQo+IGRlZmVyIGlz
c3Vpbmcgb2YgdGhlIGVuZCB0cmFuc2ZlciBjb21tYW5kLiAgSWYgdGhlIFVTQiBGRlMgYXBwbGlj
YXRpb24NCj4gZGVjaWRlcyB0byB0aW1lb3V0IHRoZSBjb250cm9sIHRyYW5zZmVyLCBvciBpZiBV
U0IgRkZTIEFJTyBwYXRoIGV4aXRzLCB0aGUNCj4gVVNCIEZGUyBkcml2ZXIgd2lsbCBpc3N1ZSBh
IGNhbGwgdG8gdXNiX2VwX2RlcXVldWUoKSBmb3IgdGhlIGVwMCByZXF1ZXN0Lg0KPiANCj4gSW4g
Y2FzZSBvZiB0aGUgQUlPIGV4aXQgcGF0aCwgdGhlIEFJTyBGUyBibG9ja3MgdW50aWwgYWxsIHBl
bmRpbmcgVVNCDQo+IHJlcXVlc3RzIHV0aWxpemluZyB0aGUgQUlPIHBhdGggaXMgY29tcGxldGVk
LiAgSG93ZXZlciwgc2luY2UgdGhlIGRlcXVldWUNCj4gb2YgZXAwIHJlcSBkb2VzIG5vdCBoYXBw
ZW4gcHJvcGVybHksIGFsbCBub24tY29udHJvbCBFUHMgd2l0aCB0aGUNCj4gRFdDM19FUF9ERUxB
WV9TVE9QIGZsYWcgc2V0IHdpbGwgbm90IGJlIGhhbmRsZWQsIGFuZCB0aGUgQUlPIGV4aXQgcGF0
aCB3aWxsDQo+IGJlIHN0dWNrIHdhaXRpbmcgZm9yIHRoZSBVU0IgRkZTIGRhdGEgZW5kcG9pbnRz
IHRvIHJlY2VpdmUgYSBjb21wbGV0aW9uDQo+IGNhbGxiYWNrLg0KPiANCj4gRml4IGlzIHRvIHV0
aWxpemUgZHdjM19lcDBfcmVzZXRfc3RhdGUoKSBpbiB0aGUgZGVxdWV1ZSBBUEkgdG8gZW5zdXJl
IEVQMA0KPiBpcyBicm91Z2h0IGJhY2sgdG8gdGhlIFNFVFVQIHN0YXRlLCBhbmQgZW5zdXJlcyB0
aGF0IGFueSBkZWZlcnJlZCBlbmQNCj4gdHJhbnNmZXIgY29tbWFuZHMgYXJlIGhhbmRsZWQuICBU
aGlzIGFsc28gd2lsbCBlbmQgYW55IGFjdGl2ZSB0cmFuc2ZlcnMNCj4gb24gRVAwLCBjb21wYXJl
ZCB0byB0aGUgcHJldmlvdXMgaW1wbGVtZW50YXRpb24gd2hpY2ggZGlyZWN0bHkgY2FsbGVkDQo+
IGdpdmViYWNrIG9ubHkuDQo+IA0KPiBGaXhlczogZmNkMmRlZjY2MzkyICgidXNiOiBkd2MzOiBn
YWRnZXQ6IFJlZmFjdG9yIGR3YzNfZ2FkZ2V0X2VwX2RlcXVldWUiKQ0KPiBTaWduZWQtb2ZmLWJ5
OiBXZXNsZXkgQ2hlbmcgPHF1aWNfd2NoZW5nQHF1aWNpbmMuY29tPg0KPiAtLS0NCj4gQ2hhbmdl
cyBmcm9tIHYxOg0KPiAgLSBBZGRlZCBmaXhlcyB0YWcNCj4gDQo+ICBkcml2ZXJzL3VzYi9kd2Mz
L2dhZGdldC5jIHwgMTIgKysrKysrKysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3
YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IGluZGV4IDg1OGZlNGMy
OTliNy4uODhkOGQ1ODlmMDE0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdl
dC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gQEAgLTIxMDMsNyArMjEw
MywxNyBAQCBzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X2VwX2RlcXVldWUoc3RydWN0IHVzYl9lcCAq
ZXAsDQo+ICANCj4gIAlsaXN0X2Zvcl9lYWNoX2VudHJ5KHIsICZkZXAtPnBlbmRpbmdfbGlzdCwg
bGlzdCkgew0KPiAgCQlpZiAociA9PSByZXEpIHsNCj4gLQkJCWR3YzNfZ2FkZ2V0X2dpdmViYWNr
KGRlcCwgcmVxLCAtRUNPTk5SRVNFVCk7DQo+ICsJCQkvKg0KPiArCQkJICogRXhwbGljaXRseSBj
aGVjayBmb3IgRVAwLzEgYXMgZGVxdWV1ZSBmb3IgdGhvc2UNCj4gKwkJCSAqIEVQcyBuZWVkIHRv
IGJlIGhhbmRsZWQgZGlmZmVyZW50bHkuICBDb250cm9sIEVQDQo+ICsJCQkgKiBvbmx5IGRlYWxz
IHdpdGggb25lIFVTQiByZXEsIGFuZCBnaXZlYmFjayB3aWxsDQo+ICsJCQkgKiBvY2N1ciBkdXJp
bmcgZHdjM19lcDBfc3RhbGxfYW5kX3Jlc3RhcnQoKS4gIEVQMA0KPiArCQkJICogcmVxdWVzdHMg
YXJlIG5ldmVyIGFkZGVkIHRvIHN0YXJ0ZWRfbGlzdC4NCj4gKwkJCSAqLw0KPiArCQkJaWYgKGRl
cC0+bnVtYmVyID4gMSkNCj4gKwkJCQlkd2MzX2dhZGdldF9naXZlYmFjayhkZXAsIHJlcSwgLUVD
T05OUkVTRVQpOw0KPiArCQkJZWxzZQ0KPiArCQkJCWR3YzNfZXAwX3Jlc2V0X3N0YXRlKGR3Yyk7
DQo+ICAJCQlnb3RvIG91dDsNCj4gIAkJfQ0KPiAgCX0NCg0KQWNrZWQtYnk6IFRoaW5oIE5ndXll
biA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCg0KVGhhbmtzLA0KVGhpbmg=

