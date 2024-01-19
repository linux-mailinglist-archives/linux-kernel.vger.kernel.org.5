Return-Path: <linux-kernel+bounces-30662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2858322BA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 01:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5062E1F23002
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 00:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69E71392;
	Fri, 19 Jan 2024 00:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="FOIIUY1J";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="IyEOU1N5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="b4eVFMoV"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA3FEC2;
	Fri, 19 Jan 2024 00:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705625177; cv=fail; b=pr5W4HjGFqyYmb+8oJRUEMksOrZmsgRLB+pKjaD2m/bjpettMY0XulnRDh71NbeXaXnJIQiNxhafy57nPkcLYWX+6d2Vqc1DMhPT823/otb3k6nU43jHmRk8eCVhaW+PorpPi0vNwUfyIMR+tUZ2tjiJ+s1pmtDVZ7C8A2qMp6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705625177; c=relaxed/simple;
	bh=a6b7J2JM7zwtWD4ByMygr+8G9EwzamtdXcOC2aU+Esc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AYQqyuLzNjRDEkZHbzspESgz4e4qlbysFLlBILuy1D+rP+tRSaM4n8AnpqEyj+zzZyUbURl24fE8+t+LYls1RabTfd3ibi4+/1L6iGKW+ild3na0ChPtWJRYwImHQhC8x2yDCukiBEw0VFabJkCRM0NWBfaio3lIh0SOWv3rFx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=FOIIUY1J; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=IyEOU1N5; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=b4eVFMoV reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40J0UQSM001619;
	Thu, 18 Jan 2024 16:46:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=a6b7J2JM7zwtWD4ByMygr+8G9EwzamtdXcOC2aU+Esc=; b=
	FOIIUY1JEmoYrP8qQZ7KGfquQhPtxt4eJbxeU6KMxnmV/k1CCyJMGhrOU/MSkuwA
	RgRueA+qf7axh6lhy5YS+b4miZmkMoEY9040sXmCivxAEese4P8DB5OV/+bFSDra
	2RjyxOg4hxbSaEKf+foUDtmje2VBXb22WTSGLVKaYBGjTWBZivhCbEmEXYNNMQm1
	ff3uEzMHioYAkfEVxGe4XHcXlDej07T94FS7dJZg1oN+ZCx/TBxkPBbAqHY3y6qA
	2QZs8yGPoBIg33IkNemiPwXfiyzzbvm1CTLBNDnNUyA+KyrWPvsVo6/ZyDE6lBMh
	nm4YSPYNSLMpms3ksx31Iw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3vktavw3u2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 16:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1705625163; bh=a6b7J2JM7zwtWD4ByMygr+8G9EwzamtdXcOC2aU+Esc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=IyEOU1N5fxkx5voQt/EnASS6d2pu4gd4HFsk/FmvSiBaatR0hd3vdck0pwI7DVplO
	 /fmPs9d6SNCXt3PeduIFiDbITh4WxYrkr/aVoPZv5mur/laz+MoT/Qo/3fpyUbCKcM
	 18bGXKHZRttlyEp3FKEpcbvVbEm3Uutg75tB5x+S/1bX6ui+7H99Zpc7s4vQ/UOpNY
	 sm8Gz23q/YSxQCxXklry2DsRDBCzTrCZKtpPE27Mof956ax2jR5wc7H6NKuadEjDk+
	 LX9rocgprNRKepscUXC6ZNXSgk7sghH4XSlUg5Ky6HyLKZ+4SsF1T2DnQ7n0SCdZw1
	 /lLtHSNN/VVXw==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4154F40523;
	Fri, 19 Jan 2024 00:46:03 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id D05C0A0081;
	Fri, 19 Jan 2024 00:46:02 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=b4eVFMoV;
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 2A29440138;
	Fri, 19 Jan 2024 00:46:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iyssz69hzXdGA4XjFkzLdvnjKIziD4iMLZmi+Ya018PaCPNVtKlUGU8XJTO5x+UUmnk/n20LnuQfqurKNLzqk6uNuAynto1xPDELDpqEeu3xp2mi09CdpXqsbfqjnDCZGN0raLJckqrnmtC+I57P+iwcBWlZIbKDxVej6HurWjAavrqCjhlaim+0PWv6x+82e8k1ZySsqj/yqTEwhinSy5bGE48hqRknyktuO3iDI/oI1jgahpxyyuqRONf8QAbp+HZgcVqsmeBmIusjRYdykIPiJUr6qlitqiZJm9pRWs335/CSFJL0Dbm+zwtlGG2hWuejwwsgVANQ7Uon1nnEFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6b7J2JM7zwtWD4ByMygr+8G9EwzamtdXcOC2aU+Esc=;
 b=eG5zujTm7IG40x1QfEnL4eA41vf0kWOaJTqDMkY6PToMKu6KjO1Jx1CrtCOtD0LB1SClS/1TslyD68KH4W5+V9vbBIwFKTfjLA8PIz3ZboxD01xYlEiKNs2ABRxBJ8oGQ7K7kpQFd6tgC9QUabVtFGdIpHTJspOjBJ9u/+0Y7ivPx+K73y62sO0zbq0ZvQWgvGRjmzm0lq0HdzfnClrkA7q8bgkh02f+4UP3A11PQPDEcI0gQY7iHy90maf1gnukvsexy45ZljXL3vvB/0nJNVvvNK2j4UUzp6GUgUDSIZmPAPcW1gHIthvnJd2RnlFaz835gamsrEZhFLBR7oAB9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6b7J2JM7zwtWD4ByMygr+8G9EwzamtdXcOC2aU+Esc=;
 b=b4eVFMoVIrkzw6BTeDuDv+EodpjXE5lawSMzz6RfhCo7NYauRxwfB3czipXAgzSFrtSWz5qwjPj3HM7kA1AhQh+cJcpUqLaZdIrgKKTy/KqC++VrnIKgIQQxx3GshZyQ2wYb2ZQFb+5MemR9mAf+B2qa5HV81+Uod5eH6O3/jxA=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CH2PR12MB4875.namprd12.prod.outlook.com (2603:10b6:610:35::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 00:45:58 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3%3]) with mapi id 15.20.7202.020; Fri, 19 Jan 2024
 00:45:57 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: Fix NULL pointer dereference in
 dwc3_gadget_suspend
Thread-Topic: [PATCH v2] usb: dwc3: gadget: Fix NULL pointer dereference in
 dwc3_gadget_suspend
Thread-Index: AQHaSe5nUpNPTjPBP0SUvO+PmozBWrDgTdaA
Date: Fri, 19 Jan 2024 00:45:57 +0000
Message-ID: <20240119004551.234tvv5w2fhhsqrv@synopsys.com>
References: <20240118091146.3101-1-quic_uaggarwa@quicinc.com>
In-Reply-To: <20240118091146.3101-1-quic_uaggarwa@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CH2PR12MB4875:EE_
x-ms-office365-filtering-correlation-id: 8ab4afea-6e81-4244-6825-08dc1887ffe3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 TqDh91AJQlC9fGIetaj/Yr7wmkQ5gSefAY2z9GUTWrm9As1Pb3UtAAUlm58NXDynqpCyMsXBvXeffB9gX2wx+laFOJfCO40gMsrKI5/S/drONf8VA6a33WoONvJ0nVKF9mHanr+F3zBPVKaqdVs1SOwgCu6e7AtmfpqX7POa+OctrpEgmOwGwIeFPuCaIaHGa78+6xU8mNLuLj0pbVa2wDu0G8eappGJfuxikI8kPeJUppG8m+e8DqZs25eFhpdKVuuOseppoGcI29mUHgiS2eWnym1wroN9tPMP9qBRcqOwNWyasJdmBwc834ba+cGteNLlAfiA/dfGwPrs0eFco+9KmRVvDZ2+SflMgfV32ndM9mdLeFK2S57+0oUAnGKWZaTw47CksnY7fvuaFsTure26Wet2GF8aGc6s8kvK7plCK61yic+DO0P5/aEaVRlV8ZIk6cunoPDWj3D2QeC3A+tEhJsn8jLEqUzMzfnr/kT141FPcPKqMfY+XBHLYynpXVS7Wn323clyQ0vTFaAVDzXTxWqeGQxQ8EqeiBtEbQX+w+6fG+HRi1s6b1V7XKPScnC5veWzy3q7S/NxzsfpbmWRHmP3avUR/TUnKvC0PdgnAXIdFjx5SWOiNMFCbmioxj1kVkW+4GRYG65MlO+9vQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(39860400002)(346002)(396003)(230173577357003)(230922051799003)(230273577357003)(64100799003)(451199024)(1800799012)(186009)(86362001)(91956017)(76116006)(6512007)(6486002)(36756003)(38070700009)(38100700002)(83380400001)(122000001)(2616005)(66946007)(26005)(1076003)(4326008)(66556008)(71200400001)(478600001)(6506007)(5660300002)(6916009)(966005)(54906003)(41300700001)(316002)(64756008)(66446008)(2906002)(8936002)(66476007)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WEpzVk1tUmFlUVY2V0ZOTzhZNUxYM3dZN29PSi9xZGM5S1c3SjFpdjEzeU9N?=
 =?utf-8?B?QUtOUE5IMTFuZ2swK0dvVmE1cGdkZGs4N0hrQzh4Z1pMK3MxSDBRMWFrRVBY?=
 =?utf-8?B?dVp4YWJ1ZVlueUJTREwwYlplMjU3TS9yWmliUVdmNDFDNDVJSkozZ3pTamFM?=
 =?utf-8?B?aDZNQ0JycWVtdlhjQlIrTDZnMTRoZHBNcHBkK0FIdW5pZWRlSVozZjRpcGpa?=
 =?utf-8?B?aU9wMURNbnhYVEprdnhBY09LaWV5ZGRBaDF0a0hqV3RhQ3RxTkFHVE5aUnFi?=
 =?utf-8?B?bmNpQjY4WTlLUVZwVmJsTkt5S203V3YwRlZYMEtlbHkzaUJYVEJPMk1VL1k3?=
 =?utf-8?B?ZVJQdzZ0OVdyYzJxQnpTZ2w5NWd0MW1rNCtoVXVTTE9YaVVQZ1RWODBIWWxK?=
 =?utf-8?B?bWFSelphSm5hOVRDcGJSVUpWRkhMRmxNTHdEZTZSUjEyVXhWektRWlhkT3FW?=
 =?utf-8?B?UGdoa212UC93Yk5TZHJ6MnFoZ3dPbTgrSkR0YmtXQk01cGtzNEFEQzhFZ3FE?=
 =?utf-8?B?dFVpN1huZ1dUTmVTN1JoSFNzdHNrTytTSVNkMkExK1c2WGNNbjRaZUVSdGd5?=
 =?utf-8?B?Um05Q0dBVk9UVUlGSTlneWtDOFFDQzlkYkI3d21tamJiMXZlaGVXaG0xdElu?=
 =?utf-8?B?QVZTZ2JVSGlPS0dQR2k2b1dDK3VRQTE2cTFScW4rVWdQWEdEZytaeUVLRyty?=
 =?utf-8?B?K0lWQnp5NjcwWCtSQytoM3BobUhQN0RwQmtORlpJOURLUktlOG5BRFhDaXNk?=
 =?utf-8?B?T0tIdW9xTWJnNEpJK3BMNkJpUjV6aWhxVVA4WXg2Vk84c0VPT2FjR0NKRnBk?=
 =?utf-8?B?UDAyekxPOEF6SDkyZ0hUa1hDZko1UDFVTDRYbHVFbEw5elpwYVBvbnY4K1hs?=
 =?utf-8?B?UndPSDVQS2xuQlpBNHcwVHNxaDZwTlJVbUVBY3pYVGxnZXZ2dXpZV1VvSTJq?=
 =?utf-8?B?VXZzUTE0L3BOYVI0R1FLUExmQ2l2S2phVUF4Mm1MUU42OG4wVmFxQ0NsQS85?=
 =?utf-8?B?SjJVbEtubWh2NTRuUElEc3B0bnFTRmhaN3FhU29lS2dSak9xZjNQaXI4TDVU?=
 =?utf-8?B?Uk5ETkNVbTJQK2ZmUFU5MG14b2Yyekh1eVRzNVp2QlVxNlJGb1pnWlhMTUw4?=
 =?utf-8?B?RTFDd3MyeHJFbXZteXFITXVKZ3czMXZVQk5MNjBwTXpmWnJZU0JvY0YwUE1Z?=
 =?utf-8?B?N0UwL1lBelY3b1NKRm53RXNHSnFuTGxJRUhKbU5ZMEluT0RJOVA2bm00byts?=
 =?utf-8?B?SW43WUYrSGF4Q2NvSlB2R3VDTXpQVU15RXNPb2FYTXV5cDVDclMvV1A5Y0N3?=
 =?utf-8?B?Q3FLb0VOWWE1blhxSnZLTTU5Y20vMng1ZTFJRHFyNEZQaE5zQUFXS0w1U1Zl?=
 =?utf-8?B?V0NOODYvYkFDa3NCYUdyV29Gc3lRYSt4a3ZQK2daMHRzOVA0bUFENW0wVjFu?=
 =?utf-8?B?MlBHUkV5cXRzbUd5M2ZrYldQOGlRTWtyWGk0VHZEZmhHKzFVVXliZkhRK05o?=
 =?utf-8?B?SDRHL01FN2dCd1FpbWFKTlp4SU9iOFFRdC9aeURETjZYV010OEw3bTVjYUlk?=
 =?utf-8?B?RzVGbzdzNkVGUGpBNzUyQjZMMUI1ZE9FMDg0aWtISkgrZmhMcGZ3R0hCTDY1?=
 =?utf-8?B?VUNxMHQrNnZOWkVFeTVwSzd2aDYzUzAweEw0OE9CRGNUMG9VeFZOZk50S1hk?=
 =?utf-8?B?MmxkTFI5aGRqU3I0RklpZitWd3NkTWd1ZzI5d3hWbERHNWQ3Ui95M25vaXVz?=
 =?utf-8?B?OG9jQWkyM3FKSVZuN0FxQ3JLQVpzYkhmREpvS2tqMmN1UGFUTWk3blAvZUVR?=
 =?utf-8?B?alRZUjZDTm1BSEJLMHQzZHpQUmxBb0ZhTmcwbkZUNGg4dEQvTzFxeEh3bnBr?=
 =?utf-8?B?MTd0aFdwaTFCb3JRNzM5MGVJZlBGN2tBRWFYYkxYT0tsRkFkM2F6Z2ltcUhk?=
 =?utf-8?B?T2E1VnRRSnNhaGwwcWIyTDZ5YWE5MFRiUG1zaC9RS201TVJCcXB3cVdiYmZz?=
 =?utf-8?B?NUkvV0o5NXVycEFwRjdIaGNaN1hmN01Kb3BuZndYQjk1dE1oWWJkdTVKUHV2?=
 =?utf-8?B?RUpNZ3Zpczl1aEhBQ0ZoSUU3RTlzNURDRzRLdVUrVXF5eGpiejJCeWFNY29a?=
 =?utf-8?Q?KwtJJivD90H9QKU9IY2aXkFH8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A5CA241C30DCD4DA0434E3B7617F501@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RtkV3mly/ZJX2jXMoD1P/PnJtkhG0XVjLieJ81GI0nUauuUyKQvx9nf+gJXrDFS4ri2q0+rP7Wbs5exD8kDKR69MJMtRzkkSo8t8M92HB/RtJbwoZVGI5Pz8teyWEyHadWZ3Z9iSdRv/1h35fqs9Kl+5Q4cK5Ya/l9l84naWFeEBLveiD0TA/fxVWtsNq8DxbAArMqORdTBKP5X/pUtVRnwhIQPuti4kTW4tFvJyKoGhLzoFDE6jvSPKoPIb5nKicmdHpnNjck9p+MK3S9gh4Nim6fLeMq73KDbYF/EA3BjoXzhKhO/kpH6UG/ibNAyFXGVdIXwR+lm9+fKm9Ja5d+FlhpiDTZx0mAg+kofx1sVhFwuBY8DRCAdHCaBuVq22+VnyRIsy1Y22tR9x8LFrddaMuMAsq+Q34eFi8+agLKpRFJZhhBss0M9ZqmTyFisOLS+pyyEm19Dy2R9qAOsnxuXX/QVDkXN2zqE+XX/qXuiyN/P9n1f7hZdsXoUGViJK4nZ01cKeUtEmYvWmHJdCue80m9dLva6XzaWKlkeFdvKJIO5YPe/f4fQae6YLx6wSZg9Y1abM5CCuDJ49CHPEQcakdaqIMg7dlMvukmMn8gJdswO2k1PeVLz65iItNAwO5Bj7IpqN/MeSdDS2LcwXtA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab4afea-6e81-4244-6825-08dc1887ffe3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2024 00:45:57.2079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lht86xW7SYtoIEqduZ0ISNXMbv7jQ+fiw1FnzqACuxAXPdA0vlL0yFb8B8PRyACzyP9m7jU0ATFzhJDRwLvLIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4875
X-Proofpoint-GUID: Qd5FILFenoiklD2Q3vVidx3qq9B1nJEU
X-Proofpoint-ORIG-GUID: Qd5FILFenoiklD2Q3vVidx3qq9B1nJEU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_11,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 mlxscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 mlxlogscore=927 bulkscore=0
 spamscore=0 malwarescore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401190002

SGksDQoNCk9uIFRodSwgSmFuIDE4LCAyMDI0LCBVdHRrYXJzaCBBZ2dhcndhbCB3cm90ZToNCj4g
SW4gY3VycmVudCBzY2VuYXJpbyBpZiBQbHVnLW91dCBhbmQgUGx1Zy1JbiBwZXJmb3JtZWQgY29u
dGludW91c2x5DQo+IHRoZXJlIGNvdWxkIGJlIGEgY2hhbmNlIHdoaWxlIGNoZWNraW5nIGZvciBk
d2MtPmdhZGdldF9kcml2ZXIgaW4NCj4gZHdjM19nYWRnZXRfc3VzcGVuZCwgYSBOVUxMIHBvaW50
ZXIgZGVyZWZlcmVuY2UgbWF5IG9jY3VyLg0KPiANCj4gQ2FsbCBTdGFjazoNCj4gDQo+IAlDUFUx
OiAgICAgICAgICAgICAgICAgICAgICAgICAgIENQVTI6DQo+IAlnYWRnZXRfdW5iaW5kX2RyaXZl
ciAgICAgICAgICAgIGR3YzNfc3VzcGVuZF9jb21tb24NCj4gCWR3M19nYWRnZXRfc3RvcCAgICAg
ICAgICAgICAgICAgZHdjM19nYWRnZXRfc3VzcGVuZA0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgZHdjM19kaXNjb25uZWN0X2dhZGdldA0KPiANCj4gQ1BVMSBiYXNp
Y2FsbHkgY2xlYXJzIHRoZSB2YXJpYWJsZSBhbmQgQ1BVMiBjaGVja3MgdGhlIHZhcmlhYmxlLg0K
PiBDb25zaWRlciBDUFUxIGlzIHJ1bm5pbmcgYW5kIHJpZ2h0IGJlZm9yZSBnYWRnZXRfZHJpdmVy
IGlzIGNsZWFyZWQNCj4gYW5kIGluIHBhcmFsbGVsIENQVTIgZXhlY3V0ZXMgZHdjM19nYWRnZXRf
c3VzcGVuZCB3aGVyZSBpdCBmaW5kcw0KPiBkd2MtPmdhZGdldF9kcml2ZXIgd2hpY2ggaXMgbm90
IE5VTEwgYW5kIHJlc3VtZXMgZXhlY3V0aW9uIGFuZCB0aGVuDQo+IENQVTEgY29tcGxldGVzIGV4
ZWN1dGlvbi4gQ1BVMiBleGVjdXRlcyBkd2MzX2Rpc2Nvbm5lY3RfZ2FkZ2V0IHdoZXJlDQo+IGl0
IGNoZWNrcyBkd2MtPmdhZGdldF9kcml2ZXIgaXMgYWxyZWFkeSBOVUxMIGJlY2F1c2Ugb2Ygd2hp
Y2ggdGhlDQo+IE5VTEwgcG9pbnRlciBkZWZlcmVuY2Ugb2NjdXIuDQo+IA0KPiBDYzogPHN0YWJs
ZUB2Z2VyLmtlcm5lbC5vcmc+DQo+IEZpeGVzOiA5NzcyYjQ3YTRjMjkxICgidXNiOiBkd2MzOiBn
YWRnZXQ6IEZpeCBzdXNwZW5kL3Jlc3VtZSBkdXJpbmcgZGV2aWNlIG1vZGUiKQ0KPiBTaWduZWQt
b2ZmLWJ5OiBVdHRrYXJzaCBBZ2dhcndhbCA8cXVpY191YWdnYXJ3YUBxdWljaW5jLmNvbT4NCj4g
LS0tDQo+IA0KPiBDaGFuZ2VzIGluIHYyOg0KPiBBZGRlZCBjYyBhbmQgZml4ZXMgdGFnIG1pc3Np
bmcgaW4gdjEuDQo+IA0KPiBMaW5rIHRvIHYxOg0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3Yz
L19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtdXNiLzBlZjNmYjExLWEyMDctMmRiNC0x
NzE0LWIzYmNhMmNlMmNlYUBxdWljaW5jLmNvbS9ULyp0X187SXchIUE0RjJSOUdfcGchY2JjQXVT
SnFzRkdiTjNZdkh3OHhscTBkZjE5MkxUVmptQVIwem81Zmh6cGtDa2lGbl96Q281bXM5THdWSmxK
YThrYkhiUmc2Z0RtWk82V1NJNlZmX2s3b1JWaVVGUSQgDQo+IA0KPiBkcml2ZXJzL3VzYi9kd2Mz
L2dhZGdldC5jIHwgNiArKy0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRn
ZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gaW5kZXggMDE5MzY4ZjhlOWM0Li41
NjQ5NzZiM2UyYjkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4g
KysrIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBAQCAtNDcwOSwxNSArNDcwOSwxMyBA
QCBpbnQgZHdjM19nYWRnZXRfc3VzcGVuZChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCXVuc2lnbmVk
IGxvbmcgZmxhZ3M7DQo+ICAJaW50IHJldDsNCj4gIA0KPiAtCWlmICghZHdjLT5nYWRnZXRfZHJp
dmVyKQ0KPiAtCQlyZXR1cm4gMDsNCj4gLQ0KPiAgCXJldCA9IGR3YzNfZ2FkZ2V0X3NvZnRfZGlz
Y29ubmVjdChkd2MpOw0KPiAgCWlmIChyZXQpDQo+ICAJCWdvdG8gZXJyOw0KDQpKdXN0IGEgc2lk
ZSBub3RlOiB0aGVyZSdzIHN0aWxsIGEgcG90ZW50aWFsIHJhY2Ugd2hlcmUgYm90aCB0aGUgcHVs
bHVwKCkNCmZyb20gZ2FkZ2V0IHVuYmluZCBhbmQgdGhlIHNvZnQgZGlzY29ubmVjdCBvY2N1ci4g
SG93ZXZlciwgZnVuY3Rpb25hbGx5DQpJIGRvbid0IHNlZSBhIHByb2JsZW0gd2l0aCBpdCBmcm9t
IHRoZSBjb250cm9sbGVyJ3MgcG9pbnQgb2Ygdmlldy4gSWYNCmJvdGggYXJlIGNsZWFuaW5nIHVw
IGFuZCBoYWx0aW5nIHRoZSBjb250cm9sbGVyLCBpdCBzaG91bGRuJ3QgYmUgYW4NCmlzc3VlLiBJ
dCB3b3VsZCBiZSBuaWNlciB0byBhbHNvIHByZXZlbnQgdGhhdCBmcm9tIGhhcHBlbmluZywgYnV0
IEkNCnRoaW5rIHRoYXQgbWF5IG5lZWQgYSBiaWdnZXIgY2hhbmdlLiBUaGlzIHNtYWxsIGZpeCBp
cyBzdWZmaWNpZW50IHRvDQpyZXNvbHZlIHRoaXMgaXNzdWUuDQoNCj4gIA0KPiAgCXNwaW5fbG9j
a19pcnFzYXZlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4gLQlkd2MzX2Rpc2Nvbm5lY3RfZ2FkZ2V0
KGR3Yyk7DQo+ICsJaWYgKGR3Yy0+Z2FkZ2V0X2RyaXZlcikNCj4gKwkJZHdjM19kaXNjb25uZWN0
X2dhZGdldChkd2MpOw0KPiAgCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmR3Yy0+bG9jaywgZmxh
Z3MpOw0KPiAgDQo+ICAJcmV0dXJuIDA7DQo+IC0tIA0KPiAyLjE3LjENCj4gDQoNClBsZWFzZSBy
dW4gY2hlY2twYXRjaCBhbmQgZml4IHdhcm5pbmdzIG5leHQgdGltZToNCg0KV0FSTklORzpCQURf
RklYRVNfVEFHOiBQbGVhc2UgdXNlIGNvcnJlY3QgRml4ZXM6IHN0eWxlICdGaXhlczogPDEyIGNo
YXJzIG9mIHNoYTE+ICgiPHRpdGxlIGxpbmU+IiknIC0gaWU6ICdGaXhlczogOTc3MmI0N2E0YzI5
ICgidXNiOiBkd2MzOiBnYWRnZXQ6IEZpeCBzdXNwZW5kL3Jlc3VtZSBkdXJpbmcgZGV2aWNlIG1v
ZGUiKScNCiMzNDogDQpGaXhlczogOTc3MmI0N2E0YzI5MSAoInVzYjogZHdjMzogZ2FkZ2V0OiBG
aXggc3VzcGVuZC9yZXN1bWUgZHVyaW5nIGRldmljZSBtb2RlIikNCg0KdG90YWw6IDAgZXJyb3Jz
LCAxIHdhcm5pbmdzLCAwIGNoZWNrcywgMTcgbGluZXMgY2hlY2tlZA0KDQpBZnRlciB0aGUgZml4
IGFib3ZlLCB5b3UgY2FuIGFkZCB0aGUgQWNrOg0KDQpBY2tlZC1ieTogVGhpbmggTmd1eWVuIDxU
aGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGFua3MsDQpUaGluaA==

