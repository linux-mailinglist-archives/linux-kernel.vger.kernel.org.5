Return-Path: <linux-kernel+bounces-156094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7AE8AFDE0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F24CB23BCD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173FCBE4D;
	Wed, 24 Apr 2024 01:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="K/7W4bF7";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OfXVk7gn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Xdf+iZMa"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC00C23D0;
	Wed, 24 Apr 2024 01:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713922440; cv=fail; b=frh0Ix/e9KScrBIMiKqWL908DF3nfk1nraol3AOThXQuRqoUGXfAN+rO+a6kr9tjP0ty2JMikutc0BOx+sTLmO2OzYZDbBQzrCYZ08nTLPWY+ppDCZKwLlKguhVRHoYBkeu7smbd1sWxtMOjr+pMxh3de6J+zXs2GxT9D8Rp8f0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713922440; c=relaxed/simple;
	bh=AGkf1MzUA8+xRL5RI8V66RthGDy94A65uQTQhzGKZ78=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LRj7p4NbdnxLr4yUnZ5TzZSOtfqzrYpxrxoXAYQFjm0nJK6ovhcgc1DsmvdE/Rt9IW4mb+GTrsS/36aFNUam5F+BxMUTC2xQaRB7qeOU8Npg2X1Gs+5dkKoZUY2miEXjztE4v6aS1WYw7c8isc3mJZOb02f+C1o6PdQ9T5S9fiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=K/7W4bF7; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=OfXVk7gn; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Xdf+iZMa reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O0mgG1015086;
	Tue, 23 Apr 2024 18:33:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=AGkf1MzUA8+xRL5RI8V66RthGDy94A65uQTQhzGKZ78=; b=
	K/7W4bF7B3bkax/DdLMxTC12uXkH2WLjnA/WsPhe6KIRcUniM4HcCliiVhnr+hPa
	71UD28GvxX/9TTN8w+IJqfWkWmB3OsuuDphxalGZw1V0QxlFwyoiA0/2X+9bqB3S
	B6uXm+UKVUZfVPbvfCzJh3K4WYNeWbd063K4ydYpfU2PzfqzKHbQznN5UdzhH2of
	wC1E+9HAnleEnKK2/HGTnLSmG9awaA6MZKdEfE+Sky+LqJfemI6hFloXh5SE6Utt
	es9pH0CyVGTqz5dPDafS6mz+O+TN4JpMnIKPWVbMS+JzbI1L1lmg7aMVqU6ahGHl
	33Ada/VPhB9tqYgQVpgE9w==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3xpf6yafae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 18:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1713922433; bh=AGkf1MzUA8+xRL5RI8V66RthGDy94A65uQTQhzGKZ78=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=OfXVk7gnF3vAhSi40yPSQf/fE9VuH8nDHhjxh/2k7xIStIZau6PEkyh6bOWPTk5jU
	 /mNiKNKFsjOrErpHwCQSHjJmgJ9gVgbGh+OZAP62AYPhqkfJ/l09gNzUWcgxCDSaEX
	 SqAwQutzljd1CasFC4GBVI68QgRFxkDj1n6wjI/mhY/LyT7dFU0cO1JCjM9ksoPqck
	 AziQmlQoZ04Y0FtFZfDJu25yz2lD5e16dWz9/JT3mZbMkcojJI6O/if2o8/H0dhEiO
	 hfJksfZInISV6b9Cd7W6JwxWQgo5b7L1fqkiQ0hWxm+cyEJlnsEaCSV4cf0sMV5q9N
	 HHgo22T8CzZQg==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BF79A4048E;
	Wed, 24 Apr 2024 01:33:53 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 8F35DA0076;
	Wed, 24 Apr 2024 01:33:53 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Xdf+iZMa;
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id D6DA64034A;
	Wed, 24 Apr 2024 01:33:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPhZLR6x0txlkUK0I3JI32yNXTbAorB1d1xSzqq7hyOEIztZOWRz94awEEZgLn17R8Pt4z8ZLUTgFT6J+ACRiTZzCkvlmTABYDkm7axCFokytjfgc/nos2A3O9PXYaiPndhLhmy2EaZujE/ZF23vKI3IPU9u8jVz8tuVZXOna5CUPtlIQC7oNANN1OHh9XxgNBe+g2hnJ2Ml6YAwB/GlGEF919XEqjXDbYKOsQEM3LEjzjbtNdk72zY4OaQAhH7IyLjl7S5HLnMlyUbwuGvJb+F6afpS0zfp3GChCG2roMlNRTjsw0+BVJYVJQqpzHmiDXedfXH3cXXg6CTK14RVBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGkf1MzUA8+xRL5RI8V66RthGDy94A65uQTQhzGKZ78=;
 b=n5DY3KUGMRZjJsnQROzaQo3vNwrZUaiNmV3KDQ1hP5L85jaEYwkMhrZ6vtoi0RfSHU2uq/ReQxr9d8ZZZBABn0dqCdioXhGJiK7W9KAmy3GweCC3qdRHd7yn+A7cRmITIaquYNzt+n0fgdlpY5VKazHvOUXf66W89e5Rz5ZOioo5F7uRaDhC6uIV18jdtUcQ5e2edmOt7pJ95Gg2DSxUC6ql4iANbntRtQhU8n73ro/r4Pteo0kpIgYS9cwXWiOuxda75+fFsVKm0psZv3+GFS6VThxnEtt8LKvqRu9Lz519Q+cmo1CtImrR+7I4MHXy1bKC2nOHTbXtaTQCtVRu/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGkf1MzUA8+xRL5RI8V66RthGDy94A65uQTQhzGKZ78=;
 b=Xdf+iZMa0gGdCB9fz41y9jgE/msvnli3ku2T12LnR/ooJsVuHchHnsXxFR9fYX4nWC+8B4r2TCSvtJXJc9kxRYfCKuhdQwFTOKdoltsSyoXf5Jgy7RBf8dQWb+lEOr3fAkv60Zl+ERyJR9PPwRk+k8iG7BcQ9ui9nQQVKiMSo2w=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH7PR12MB6834.namprd12.prod.outlook.com (2603:10b6:510:1b4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 01:33:45 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 01:33:45 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Prashanth K <quic_prashk@quicinc.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [RFC PATCH] usb: dwc3: Poll CMDACT after issuing EndXfer command
Thread-Topic: [RFC PATCH] usb: dwc3: Poll CMDACT after issuing EndXfer command
Thread-Index: AQHalJRPHyu5Rgz0VUSI068GgFefBrF2pbgA
Date: Wed, 24 Apr 2024 01:33:45 +0000
Message-ID: <20240424013342.5itkoewx7jdonyk4@synopsys.com>
References: <20240422090539.3986723-1-quic_prashk@quicinc.com>
In-Reply-To: <20240422090539.3986723-1-quic_prashk@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH7PR12MB6834:EE_
x-ms-office365-filtering-correlation-id: ae0cd54d-d5c1-4ea8-c3f3-08dc63fe9533
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?utf-8?B?Zy96NDY1dkpWNlpoaFdLdU1pQUZHQ1FZcTJXZkhhMXNxMmdveVlQaDQrU1o2?=
 =?utf-8?B?aDRUaHRvRnA2YWJYZWV2RHk3TDUxUnZOMTVBRldzN2NsM0ZiTThvYmZDNmdx?=
 =?utf-8?B?OU1ZYjIrTXlNb0ZDL2YyeGRvTTJ1cytTd0E5SEw4NDJZNmVaaXNMdjYxMnAr?=
 =?utf-8?B?SHZQVzhxdDF6eURTQ1U5di94TVN2QWlZRGp0OFdDNk9NWTNkT0E5ZDNYOWo1?=
 =?utf-8?B?UWhsYy9MWThNQVNJczVPT2NwZWVFSDIvUzg1R3kwNG1iQlNiT29UNWF3VVZ4?=
 =?utf-8?B?VG9HK2dWVm5Kdi9iczlFNElxaGxXZ2hDZmtyRmxDRUhJYWxoMXhwTHhpZ05O?=
 =?utf-8?B?UUpmeUt1M2NiYnpnWW5YNDVraW9WazRtTkNVRDBuSmFwT3VQV0drV3ArN1NE?=
 =?utf-8?B?d0ROVVdtb3VPcGRQV0dEVkhFYUlCRkhVaWZlWU9Ed3orbXlPZzFHL0JwalNM?=
 =?utf-8?B?c0tNcngxd3Y5WmpVaHBtWTg3T2VPN1ErL3MzSmdZcURtMmwzaC94K2EyWE9G?=
 =?utf-8?B?N0hvcFNNeWpsNWcwOXlMbWpHbmxyWGF5NWZ4am1LaTlsaVFxSjZKOTdDaHNq?=
 =?utf-8?B?ZkR1ZjhjdWU5WmgyU0J2Q3JOU2tpSWsxK1RqNExnYzJ2S05TZ0s3SWxXUDZr?=
 =?utf-8?B?MUVNWGlRMkZJRjBNdWpRZmIxTU5wcFRLMEU4M2daaGV2V2x5aEdrUFlQNTc2?=
 =?utf-8?B?N2NLVjlCSVovaEV0M0NXanU4L1o1bHF0dWNCbG9MOUVlTzRsOE1SYUVvTGIz?=
 =?utf-8?B?clNFcDBYRkFyMjA1ckk2S2J6TzRpZFhrSmhXWE50TWorQTRwR3YxZ2JLUzV6?=
 =?utf-8?B?bWZuby8zZWROR0YvQnlsUGpwaGcwMWF1VHdTZU1vdXNnZGd2aFZrNHRlNHdH?=
 =?utf-8?B?RXlKTGNWZERuUFY0cjJva21TVTYzNHN0SDgrK0FDZWs5YndyV2E5K2I3VWxH?=
 =?utf-8?B?QzVSeGI0aG81M0FYZWRxQ1FMYTVuNnJVM283RHVVWGRocXgyWkVxdTk2bXIz?=
 =?utf-8?B?NzU3Sm9pOEozbEhUOG5kZ3ZpUm9HMlFEb2Z6OVpNd0ZFcHIwckpjR2prWWtt?=
 =?utf-8?B?ZUoxempJaFpQOUgvRTZWdy9KYXNBNTVOVVdqMUhBVEg5Q3BoK1VVKzhrTW1j?=
 =?utf-8?B?WjllTnVwSUFMeGdUMUJRSWp6MzBjbnU0TlBKYVdjbEprT0kxTmoxS0hhUDRS?=
 =?utf-8?B?MHZFbUh0QXdHeEFQZ3VWRFA4dStmbkRSbFJxVjhPR0lDRHh2L2UrQmF6TWZG?=
 =?utf-8?B?bEptTjZ2U2lIQ1AvZ2Nabm80aEdXWGFUa0pkRjhQSjhoOU9CVXFoSmc2c1Vj?=
 =?utf-8?B?VWdibzZZOXI3K1NSaWNXajdFVExraDVmbzBNdUlaUlFLRTFxUTFKWUJ3akpP?=
 =?utf-8?B?aEpiNERnUDhOd2RUWVpjRnM4YTBaVHVCR0c3dEp5Vmdock5NQ09EK2cyOEdC?=
 =?utf-8?B?MDAxeVRHWWdCSWIwMTNoRnF0T2poMXkwcjk2QTBJckVnL3pxSWp0SURxRnpq?=
 =?utf-8?B?UHdjMlZRUi9pR3hSdzYxeWt0RVp2b1d2cktnWVZOTHZ2RzlkVW5FWGEvbVk0?=
 =?utf-8?B?RTJVbXRXOHhnV2hkN0VibkRBcXdJaVR1TkRnSzY5ZVRnV3Y4UEZEcVlVanlm?=
 =?utf-8?B?a00wS2ZFWkNrNVlSbTN3SVVZZG8rakNMWERtM1JmRHorZDBVWEZJb3VCZjBX?=
 =?utf-8?B?ZFlNRUpEOWpQa1YybGsybUxoa1hUcG5MbHRobzlRYzRDcmh3dlFlUjUwU3BX?=
 =?utf-8?B?K0owWlovcG1WUllVTlZQVmZmT29xemo2V0VRRWFJTGgvb3BKNGtnM3E2bVo4?=
 =?utf-8?B?SmZvaVJ4MHhub0lpQTV5Zz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ckQralJna05rRFRrMDVMNU90YnZHckZJalZYY2FKc3ZrWmQ3V2FEZnBKOFNY?=
 =?utf-8?B?bS9YUmJINXR1U05wTEtOeXE3eDZsRGsvUnNialY2a1p6cUVPWXFlK0F1UVU2?=
 =?utf-8?B?MzlmQmhTa3krWXJ0S1Jabk03Y2c2R0lEZEhhTFY2bFNFSEIwcWdBamVITlI3?=
 =?utf-8?B?S0xXUnZMUmVWMlBieGhmeG9DVkU2ZFBZdDIrYzc0Y1RJL0ZLRzJ4cnEyR1Nu?=
 =?utf-8?B?eDdwM3BlY3ZZSWVIcSthOE13UGRQdkhVVFFzaGUrbTVZeTVTcDhYbDYraFJZ?=
 =?utf-8?B?eU91eEJRMkd1QjMxVmJ2NWdyemNBbmZhdXVUbXNuYzFuNUt2ZHJPTjdCa3o4?=
 =?utf-8?B?dk5CTFJmN1A0SnNERERzbVJZREpySGgyai9pRFYzTmhtUE1zTExHb294WkYz?=
 =?utf-8?B?MjNndVFJaTRpaWFwUTQzUVJBK2JJYzd0UC92UjJsNnA3T1BTNUFkVENlOG4x?=
 =?utf-8?B?amNmKzl3UkJSem1KRFR4Tk0zTXVzNHFKK1FiSjRxRklDQjAwWlVQZ2d6RWty?=
 =?utf-8?B?aVdsVUlCRzZYSFc1K3BHdFZwL1VEcW9NTkkvcmNFZXBBQ3grQnovbFZJRHFw?=
 =?utf-8?B?RkZ3cFJQYklqUkNzTzRLc2RCd3N6MXdMSzlRc0VWSVBKVW5HbEVhQ2tXUXUx?=
 =?utf-8?B?aUVNcmZIN0ZTUnB4VnV2WjNrdXhXZWRPRXJ0WkNRUCsxQWRBbHNYZStqc0hD?=
 =?utf-8?B?alkxUnNYaHZYVmg4ejROY3BFdi9PWmptbERqY1JQQ05JaTRFdERqL1ZBWUc4?=
 =?utf-8?B?Ris4NHBCamYwWFlNWWU0QWpuNy9zODFvM2tZcW95Yk1DcFI2Y2Jxc3RFLzBR?=
 =?utf-8?B?TXc2RkNwZWpmY1FlVGpUNENCRmFrc1g2NUZicnBBQm1GRUx2VHdMMnhheVM2?=
 =?utf-8?B?aytNTVRaNjJ3K2NLdVlxMTNpQVBlcEJTcUR4QXlkdmpaeVltWnljVUd5TnBu?=
 =?utf-8?B?cStoUlY2dFhhbGVxWFk4WC9UYWhQM3VqSDZmWjcxRElDQ05ZM0F6d0NBSWxp?=
 =?utf-8?B?L09ONkNDN05YK1ZVZG9RNkRqU3BTZGNDcnFXQm5EcGYvTTZNZjBTd25RWC9u?=
 =?utf-8?B?d1Y5NE8wRzVXNGM4UjRYanY3L3hOWHJzcVQxd28zTnMyc05mUzgrY2REZTVF?=
 =?utf-8?B?R0RLUDNveGJSaGl3ZzVwVVdoM1VYWW91SDFpcnQ5MEtPcm5KencyMUpRZWpQ?=
 =?utf-8?B?NGlZdkFUNnhJODZJZXoxbGllUGxtcGxHMm1qaUJMTm05SUV2V0l2eU8ydWpp?=
 =?utf-8?B?OUJOWnh5aXp0MW4vRWc4Mmp6WTlCTzJnU2dMSFVoNjdjOGoyRXRxZ3l0OHBn?=
 =?utf-8?B?cUFaWkE0VUxvaTNHZkFJcGNOOWVGWjhFSHJhRjkzcnF5eWQ0YjNwdGhNclEx?=
 =?utf-8?B?ZExpdFZFQytRUVo4RVVzcGhKV0pQcmFwS1Y3cXhROVFQZGt5bGRpdXNFODJt?=
 =?utf-8?B?QnoyYTRESHMwMkc5ZWNrQ0I2L0FMMEJ5dit1Y3d4N1E5Ui9vR3J4SmtPNFpn?=
 =?utf-8?B?LzZRRnQ3dlAwNVllODZEdGxxYUo2UHRnYXRJOEJpRm92eFdzMlViTnd0WWlB?=
 =?utf-8?B?WC9pZ1VrdUtFZVg5cUZkdXNOTzg5L2dMdHRjWTJZMmJHUVBMdDNWM0pvRWpl?=
 =?utf-8?B?a2tmeHA4OStHb1A2K0RMQkR6NEoxc2xabmZWZGJmV3ZqclVYMlVhbjZnWWQy?=
 =?utf-8?B?MXY5R1ZZa0toQk9xK1IrN2xBbzNSN1Bld1YyM1RiRTQvSUdTUFpzbTB5Qzlr?=
 =?utf-8?B?UXhQTThoUTh1SG90SWxBTVU3Z3BscmpKaEoxMEs0bEZNTVB4cDJPNEI3U0I4?=
 =?utf-8?B?RFpsMFZnbnRLalBsOG11RmV0VFpsMGtKdXpwNmNOUkh5MFMraFhTSTk5NmhP?=
 =?utf-8?B?c1lYY2hZWWtFUnFTWUVvN3poRE95ZlJHWWJMWjNzV0pnYmZEM0hlbktnQU81?=
 =?utf-8?B?RjU4SHRobnJEZ0JpMEQwSUxIaitLU1NCVWpmSU5KcDlsWVdEMExLMGRFa0xz?=
 =?utf-8?B?YnVYWmdQaGl3R2tveDRZNFl1K2x6aXlLVkQwU2tXdElEd2p4eThUWnRnUXY5?=
 =?utf-8?B?cFFXUDZJUjVGUWltbVNFVlhGME1yZHc3andkc29MN0FsNGc5ejk1bkhRWTg3?=
 =?utf-8?B?YUlmeUpoVTZxWXpaOGdRRmthdjdTQmNuNlQ0cm5qWmw3aFozM3Zjb2VYZWRi?=
 =?utf-8?B?bEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5B63C496CE7EC419A4F972DD6D6E722@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DzhtLElW4PCfvi6Bj+JgzEpYntKtzCAR48XSbFJBGtHE+muLpsjq4fg6DAC+AbwaAF70is/mfGNHf6DEOjhS4qIpERJnOHQFojyS+hBkNdOpCRUo9O+VDbzYBfwDHif8Ny/IeusFqQ3HriiINA4ugUbgglpkf+A3QTk0g8wGVwGA2B+Nzzu9yJ92zFEvEO8+Kxburd1YK3vMKdCF9vvX2h+JCv2hpPJEtxjhx7RsxoscjGL95e194BcQ+dV7Hln3eTTjOc0hD9UNcqUmu3Yidgn29Fj7gs9bxWzGzMyjX6rvLYhaJF3njEggyROmF6trAwLasSZDFClxqwSS/YGVgjycU3SmDpQky/nveUrkYSf7M5yolLXbvkcw9uVYGDBDXJXkKpFbXdgSYMuReRkYJ6NA88L+MMPrYiYgI1YIDXIKyTPNeUfJLNIrU1wHe/rw0b/1bX7tCOyT7rMa5sgDr0rEAyySbFyvhyFCyS7vPlAHA7bRE68JLY3U6hjGP8NMLGrWXawkkl8OWphb/lkIUWnjNtzNyIYeP1yuX1efwb6tUHsExfwqza5zn4SS17yAxY++imIDIwWjR38kZS80TIfFwe7RxYWHe2JgMfKF45+Y9pv5kwjJk9IfWIjPGclAiZpq/PnTkg8N6e+YFtSgUw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0cd54d-d5c1-4ea8-c3f3-08dc63fe9533
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 01:33:45.5420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PW3bUEFbtd8iyPkI4dd+6E8y8N+mN4JcGQWWXbkba5D1vxR3yPpjTeKNhiAQK7yT3Q3RgXu78Kec1Qgx1KuoxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6834
X-Proofpoint-GUID: 8FL2BM47AAB7V-3giK5y1cYH6jsc-snL
X-Proofpoint-ORIG-GUID: 8FL2BM47AAB7V-3giK5y1cYH6jsc-snL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_20,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxlogscore=678 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404240006

T24gTW9uLCBBcHIgMjIsIDIwMjQsIFByYXNoYW50aCBLIHdyb3RlOg0KPiBDdXJyZW50bHkgRFdD
MyBjb250cm9sbGVyIHJldmlzaW9ucyAzLjEwYSBhbmQgbGF0ZXIgc3VwcG9ydHMNCg0KRFdDMyAt
PiBEV0NfdXNiMyB0byBoaWdobGlnaHQgbm90IGJlaW5nIERXQ191c2IzMSBhbmQgRFdDX3VzYjMy
Lg0KDQo+IEdVQ1RMWzE0OiBSc3RfYWN0Yml0bGF0ZXJdIGJpdCB3aGljaCBhbGxvd3MgcG9sbGlu
ZyBDTURBQ1QgYml0DQoNCkdVQ1RMIC0+IEdVQ1RMMg0KDQo+IHRvIGtub3cgd2hldGhlciBFTkRY
RkVSIGNvbW1hbmQgaXMgY29tcGxldGVkLiBPdGhlciByZXZpc2lvbnMNCj4gd2FpdCAxbXMgZm9y
IEVORFhGRVIgY29tcGxldGlvbiBhZnRlciBpc3N1aW5nIHRoZSBjb21tYW5kLg0KPiANCj4gQ29u
c2lkZXIgYSBjYXNlIHdoZXJlIGFuIElOIHJlcXVlc3Qgd2FzIHF1ZXVlZCwgYW5kIHBhcmFsbGVs
bHkNCj4gc29mdF9kaXNjb25uZWN0IHdhcyBjYWxsZWQgKGR1ZSB0byBmZnNfZXBmaWxlX3JlbGVh
c2UpLiBUaGlzDQo+IGV2ZW50dWFsbHkgY2FsbHMgc3RvcF9hY3RpdmVfdHJhbnNmZXIgd2l0aCBJ
T0MgY2xlYXJlZCwgaGVuY2UNCj4gc2VuZF9nYWRnZXRfZXBfY21kKCkgc2tpcHMgd2FpdGluZyBm
b3IgQ01EQUNUIGNsZWFyZWQgZHVyaW5nDQo+IGVuZHhmZXIuIEZvciBEV0MzIGNvbnRyb2xsZXJz
IHdpdGggcmV2aXNpb25zID49IDMxMGEsIHdlIGRvbid0DQo+IGZvcmNlZnVsbHkgd2FpdCBmb3Ig
MW1zIGVpdGhlciwgYW5kIHdlIHByb2NlZWQgYnkgdW5tYXBwaW5nIHRoZQ0KPiByZXF1ZXN0cy4g
SWYgRU5EWEZFUiBkaWRuJ3QgY29tcGxldGUgYnkgdGhpcyB0aW1lLCBpdCBsZWFkcyB0bw0KPiBT
TU1VIGZhdWx0cyBzaW5jZSB0aGUgY29udHJvbGxlciB3b3VsZCBzdGlsbCBiZSBhY2Nlc3Npbmcg
dGhvc2UNCj4gcmVxdWVzdHMuDQo+IA0KPiBEV0MzIGRhdGFib29rIHNwZWNpZmllcyB0aGF0IENN
REFDVCBiaXQgY2FuIGJlIHBvbGxlZCB0byBjaGVjaw0KPiBjb21wbGV0aW9uIG9mIHRoZSBFbmRY
ZmVyLiBIZW5jZSB1c2UgaXQgaW4gc3RvcF9hY3RpdmVfdHJhbnNmZXINCj4gdG8ga25vdyB3aGV0
aGVyIHRoZSBFTkRYRkVSIGdvdCBjb21wbGV0ZWQuDQo+IA0KPiBTZWN0aW9uIDMuMi4yLjcgQ29t
bWFuZCA4OiBFbmQgVHJhbnNmZXIgKERFUEVORFhGRVIpDQo+IE5vdGU6IElmIEdVQ1RMMltSc3Rf
YWN0Yml0bGF0ZXJdIGlzIHNldCwgU29mdHdhcmUgY2FuIHBvbGwgdGhlDQo+IGNvbXBsZXRpb24g
b2YgdGhlIEVuZCAgVHJhbnNmZXIgY29tbWFuZCBieSBwb2xsaW5nIHRoZSBjb21tYW5kDQo+IGFj
dGl2ZSBiaXQgdG8gYmUgY2xlYXJlZCB0byAwLg0KPiANCj4gRml4ZXM6IGIzNTNlYjZkYzI4NSAo
InVzYjogZHdjMzogZ2FkZ2V0OiBTa2lwIHdhaXRpbmcgZm9yIENNREFDVCBjbGVhcmVkIGR1cmlu
ZyBlbmR4ZmVyIikNCj4gU2lnbmVkLW9mZi1ieTogUHJhc2hhbnRoIEsgPHF1aWNfcHJhc2hrQHF1
aWNpbmMuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgfCAyMiArKysr
KysrKysrKysrKysrKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdl
dC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBpbmRleCA0ZGYyNjYxZjY2NzUuLmFj
YjU0YzQ4NDUxZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiAr
KysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IEBAIC0xNzAxLDggKzE3MDEsOCBAQCBz
dGF0aWMgaW50IF9fZHdjM19zdG9wX2FjdGl2ZV90cmFuc2ZlcihzdHJ1Y3QgZHdjM19lcCAqZGVw
LCBib29sIGZvcmNlLCBib29sIGludA0KPiAgew0KPiAgCXN0cnVjdCBkd2MzICpkd2MgPSBkZXAt
PmR3YzsNCj4gIAlzdHJ1Y3QgZHdjM19nYWRnZXRfZXBfY21kX3BhcmFtcyBwYXJhbXM7DQo+IC0J
dTMyIGNtZDsNCj4gLQlpbnQgcmV0Ow0KPiArCXUzMiBjbWQsIHJlZzsNCj4gKwlpbnQgcmV0LCBy
ZXRyaWVzID0gNTAwOw0KDQpQbGVhc2Ugc2VwYXJhdGUgdmFyaWFibGUgZGVjbGFyYXRpb25zIHBl
ciBsaW5lLg0KDQo+ICANCj4gIAljbWQgPSBEV0MzX0RFUENNRF9FTkRUUkFOU0ZFUjsNCj4gIAlj
bWQgfD0gZm9yY2UgPyBEV0MzX0RFUENNRF9ISVBSSV9GT1JDRVJNIDogMDsNCj4gQEAgLTE3MjYs
NiArMTcyNiwyNCBAQCBzdGF0aWMgaW50IF9fZHdjM19zdG9wX2FjdGl2ZV90cmFuc2ZlcihzdHJ1
Y3QgZHdjM19lcCAqZGVwLCBib29sIGZvcmNlLCBib29sIGludA0KPiAgCWlmICghaW50ZXJydXB0
KSB7DQo+ICAJCWlmICghRFdDM19JUF9JUyhEV0MzKSB8fCBEV0MzX1ZFUl9JU19QUklPUihEV0Mz
LCAzMTBBKSkNCj4gIAkJCW1kZWxheSgxKTsNCj4gKwkJZWxzZSB7DQo+ICsJCQkvKg0KPiArCQkJ
ICogRU5EWEZFUiBwb2xsaW5nIGlzIGF2YWlsYWJsZSBvbiB2ZXJzaW9uIDMuMTBhIGFuZCBsYXRl
ciBvZg0KDQpUcnkgdG8gbm90ZSB0aGUgSVAgYWxvbmcgd2l0aCB2ZXJzaW9uIChlZy4gRFdDX3Vz
YjMgdjMuMTBhKS4NCg0KPiArCQkJICogdGhlIERXQzMgY29udHJvbGxlciAoVGhpcyBpcyBlbmFi
bGVkIGJ5IHNldHRpbmcgR1VDVEwyWzE0XSkNCg0KRGlkIHdlIGNoZWNrIHRvIGtub3cgdGhhdCB3
ZSBzZXQgR1VDVEwyLlJzdF9hY3RiaXRsYXRlciB0byBzdGFydA0KcG9sbGluZyBmb3IgQ01EQUNU
Pw0KDQo+ICsJCQkgKi8NCj4gKwkJCWRvIHsNCj4gKwkJCQlyZWcgPSBkd2MzX3JlYWRsKGRlcC0+
cmVncywgRFdDM19ERVBDTUQpOw0KPiArCQkJCWlmICghKHJlZyAmIERXQzNfREVQQ01EX0NNREFD
VCkpDQo+ICsJCQkJCWJyZWFrOw0KPiArCQkJCXVkZWxheSgyKTsNCg0KdWRlbGF5IG9mIDIgaXMg
cmVhbGx5IHNtYWxsLiBUcnkgYXQgbGVhc3QgMjAwdXMuDQoNCj4gKwkJCX0gd2hpbGUgKC0tcmV0
cmllcyk7DQo+ICsNCj4gKwkJCWlmICghcmV0cmllcyAmJiAoZHdjLT5lcDBzdGF0ZSAhPSBFUDBf
U0VUVVBfUEhBU0UpKSB7DQo+ICsJCQkJZGVwLT5mbGFncyB8PSBEV0MzX0VQX0RFTEFZX1NUT1A7
DQo+ICsJCQkJcmV0dXJuIC1FVElNRURPVVQ7DQo+ICsJCQl9DQo+ICsJCX0NCj4gKw0KPiAgCQlk
ZXAtPmZsYWdzICY9IH5EV0MzX0VQX1RSQU5TRkVSX1NUQVJURUQ7DQo+ICAJfSBlbHNlIGlmICgh
cmV0KSB7DQo+ICAJCWRlcC0+ZmxhZ3MgfD0gRFdDM19FUF9FTkRfVFJBTlNGRVJfUEVORElORzsN
Cj4gLS0gDQo+IDIuMjUuMQ0KPiANCg0KRGlkIHlvdSBvYnNlcnZlIGlzc3VlcyB3aXRoIERXQ191
c2IzMT8gSG93IG11Y2ggbG9uZ2VyIGRpZCB5b3VyIHNldHVwDQpuZWVkIHRvIGNvbXBsZXRlIEVu
ZCBUcmFuc2ZlciBjb21tYW5kPw0KDQpJIHdvdWxkIHByZWZlciBhIHNvbHV0aW9uIHRoYXQgYXBw
bGllcyBmb3IgYWxsIElQcy4gRG8geW91IG9ic2VydmUgYW55DQppbXBhY3Qgc2hvdWxkIHdlIGlu
Y3JlYXNlIHRoZSBtZGVsYXkoKT8gSSBkb24ndCBleHBlY3QgbXVjaCBpbXBhY3Qgc2luY2UNCnRo
aXMgc2hvdWxkIG9ubHkgaGFwcGVuIGR1cmluZyBlbmRwb2ludCBkaXNibGluZywgd2hpY2ggaXMg
bm90IGEgY29tbW9uDQpvcGVyYXRpb24uDQoNClRoYW5rcywNClRoaW5o

