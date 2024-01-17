Return-Path: <linux-kernel+bounces-28422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A645882FE52
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9388D1C23FDD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4357017FD;
	Wed, 17 Jan 2024 01:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="kCZXSlqB";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Ri10Ys3L";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="wLxh5YBX"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D621F4685;
	Wed, 17 Jan 2024 01:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705454354; cv=fail; b=FYqqka6i88lO+/ByUVcL4Scqjl9JUhxI/m+A0P8yXl/f6JZOqP9tx2vDelN34WR1F14pGMT7px9u+xpPJQKQg8tENY2kpx2XDN3EpUnfQt6jTfPCqTmLVdJWEsRwj+qyGm6kuD9RwJvKcYOQ5oiuOD3G7CVEPBx2y00enkn39+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705454354; c=relaxed/simple;
	bh=LM0+N2lrsdlZgUQGBVDMg89wCG81sKzElWaX3+AZZvU=;
	h=Received:DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 Received:ARC-Message-Signature:ARC-Authentication-Results:
	 DKIM-Signature:Received:Received:X-SNPS-Relay:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=IE982STDXSe+UxLscqECrwBv+pMJ7Bsk/VCSgaKFPhNYSMTTQg5/F/Qpl3ABrfcFfgCBldXe7IjR40tpGD/bw6bEHKTDcgzpijFS0ga8pe8mxNm6aTtP3VSyeZshd+jJJgC4tBv6JFeEbFMVB6iA2GCVh5sFeO6RXnb3GzhCn5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=kCZXSlqB; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Ri10Ys3L; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=wLxh5YBX reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40GJSKkn011554;
	Tue, 16 Jan 2024 17:19:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=LM0+N2lrsdlZgUQGBVDMg89wCG81sKzElWaX3+AZZvU=; b=
	kCZXSlqB76i7pUL1Gy5SLBiXxyqu7clGmgh1bh7gkE/s5D3gqNfADCV2Ugz9lfpT
	Bu7fB233nKMz5wXY7j+zc87vP4OFoh+NvkJZ65H6p33OrmzVG2VPSsESQcG44vsS
	35AYrk5/Ipas5h9XDFdPXNXyu/rU8iNwI2E8P18H8+HqyNHxewtGsI8PKqziTQwQ
	+Q6S7hyge2vLPD8GJnwmXYrasXqgwGU3en6cpMYdBfakPXZ9lVj6R+9Ffco3dY2a
	LhAMhhHRzGSFoyPqJBhA3QEKa0sobsGJwyFP9Bpz9dvyPstv4IIJrd2f9k2fEsog
	Txr/D7u/t0tMrorpOIB7ow==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3vktn672m5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 17:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1705454346; bh=LM0+N2lrsdlZgUQGBVDMg89wCG81sKzElWaX3+AZZvU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Ri10Ys3LfgF0XNyFlt6hphXrLHtYM+fkFRCCrCDVND1AxATcbfujFp+mfO1K/XZZf
	 BHH1aQQWLPjX4GfCJD0Hgb9mZTY7ECQQAUdvMVkYtxAh433/qIFYlaio8ghKGXomsb
	 JhA9Y1PJSLWTrku/f6ckn38h3Diu6I4qSbF765nO2NC99fHacloelDEZ4IOOKecw3a
	 TIv/I0f24lf4Stb+QM5JzQFbixRDs1yAWOTNkxGnGWQnXynNpsQM/eaYMFSJcFWZuV
	 /nzRGHLjB1yXa9RPnfx4kehZnnfb7j87pPmZgiwBoPpxzFF+InKU5dwjCEZTwNDSaQ
	 TywkMn633j1pw==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5AEEB400A2;
	Wed, 17 Jan 2024 01:19:06 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 19707A0077;
	Wed, 17 Jan 2024 01:19:06 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=wLxh5YBX;
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 4404E40138;
	Wed, 17 Jan 2024 01:19:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GK0EZQmahL17OjJgoWD6sSvQv8ikZKAFYEJJdx6Yadq+r7J1UBajAbQP7qhnzLjS4Pep453HiefExqK5RP6XSQb2hW2noVh+OFJxJHXxFUfZGsJLeQUfji0Kjqa+IGMAr4KOTOAkXmTyC4Y6S/LI5O0uHjDpwXfQ2yuSihXs58Tq+Nj4OknJeUbZ17NethRyfPK9Ew7j9ppjcFyg4Q6CwmZjjyv0/Eot51hyEkx1dAzJr7K0Z1mpKzld8LfgugQuSRnJGSoM0Twep20+9n7Xnl/JTSUA5zD+5rvDxm2PSqB5hK0rGxVF4F8PENJgcspMURwnqEyYaw9sQJvJi/1sqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LM0+N2lrsdlZgUQGBVDMg89wCG81sKzElWaX3+AZZvU=;
 b=OCQWQYjuSit/BCjQglsrDt5XNQ72X4v9BFQz9EtOXvzQflpGv+LEstbYPO9WIC6MzrVOyHuPknDrzG1rBuU+nXIk1yb5NVipVYiCzwzVaDiCavS3l1NCv4hY4x1L5M02t9SbNfqSXkzRm6cUKXx910kPj86McP+FnmNXFbb0xQshnj7hToMXKh9xKvNV/+Nq6bwoxCpArYXOu87yO/wdHXdTKZ04QPLc5cuEfHacq3cb6/S59vHuusW8dgEIx020p7x5mzTWBKaQIHuZwc9Z+mQUaf/gqWkOjsOS0+eoGkGKYp2szm9VUNHGCvV+Ik37mDTg3EcExao3qW+oCdDeAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LM0+N2lrsdlZgUQGBVDMg89wCG81sKzElWaX3+AZZvU=;
 b=wLxh5YBX2i/jkSTGJ1aOoaDizYs4zPK74s3k5wesPHxepFoHG55eVNdCAU5dMzIaFuL1QL4D/Ajuxokid788/AcwAhIM8GGuFgn+f4whL5T5Tq24j5J32MrhUqeGMZQuUrqkH6aXpfcP1+3dgfinDJxl0NZ+d/l2n7IOF/M5+ro=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MW3PR12MB4460.namprd12.prod.outlook.com (2603:10b6:303:2f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.29; Wed, 17 Jan
 2024 01:19:01 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3%3]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 01:19:01 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [RFC PATCH] usb: dwc3: gadget: Fix NULL pointer dereference in
 dwc3_gadget_suspend
Thread-Topic: [RFC PATCH] usb: dwc3: gadget: Fix NULL pointer dereference in
 dwc3_gadget_suspend
Thread-Index: AQHaQ6tPP1s5O3H+ik2KO8Fm7lDy17DdPvWA
Date: Wed, 17 Jan 2024 01:19:01 +0000
Message-ID: <20240117011859.dv5d27cf7qhwxuxf@synopsys.com>
References: <20240110095532.4776-1-quic_uaggarwa@quicinc.com>
In-Reply-To: <20240110095532.4776-1-quic_uaggarwa@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MW3PR12MB4460:EE_
x-ms-office365-filtering-correlation-id: 0148d59f-7564-44dd-4ddf-08dc16fa49c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 U49WkEpEWvfF2tJky1ZtG+vgPMRCQi0cpVvKiF+Xke/0p/pX3lsxa9LhScOMy8s7uDuO1F4m6peVf+haaYKwQD/8Rk14k6e/aNrcYk0bmltuCy6x1qKSRnRRPwQUlIqSwvcVEGSTj/sbhUqvhG65Hj40SWN5wCcKYvIznx1woQ1kOicjhStoCL6W2CorijNLkay/6nBZtFE4D2rOy5If795k3wuPqE/BCXcF+M9Vy1ts3+XsN8kV0eGRfQqTerwxPodWyfpjQ9eZP3vmP3Rk7QojvQeE8zlA1cXN/M8yl3UsSziSDpcC+iKWVkCpNmym0E2J/kqUH8xBilRVYemWU3txQ84c3iRSDNcpaF2NchC3zi/1Veteqv/PF5iW4p1NaP2mjIOkqlwbhEPn23mFaRxjqe7JXPo09GM5VTLo+/GAjJqKWAje0ywMf14oSodUWpDps3oBvt5KDbe5pBFw4bcrcxrv4fLVVMgxsMQizh7nYBlGS/L9GtHBCzjWwffCLFgO8Pfku2r8tQoEzMjg7WpayGVX0FaqFjav84M511zu8LhOkc6wp1k6pX4Sw9ODb4u9mIlZujJ3OkdbxzMMgPi0Crgl9FslFYLs/hHzixyzo0nqNvI0uiV0xgnWF9Mu
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(346002)(39860400002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(41300700001)(122000001)(38100700002)(83380400001)(38070700009)(36756003)(86362001)(76116006)(91956017)(66946007)(64756008)(66556008)(316002)(54906003)(66446008)(2906002)(66476007)(8936002)(6916009)(4326008)(8676002)(5660300002)(2616005)(1076003)(26005)(71200400001)(6486002)(6506007)(478600001)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UVZLVkp2bVo1N3FWeHplQ24yZCt6cWJQdlNLZnM3N1BnUjhOZUhpaTNkZUtM?=
 =?utf-8?B?VEtLZm9FQWZSYUdwT2xwbmlxWGoyd1J5dkhlS0NsYmRCbmQ2Y2JxMjJRR0tF?=
 =?utf-8?B?M3NJUTdCQ0JCS01DT2VwNGFyWVlRSXpqUVhzeGh5SDBZWmFGWEVvRCtQdmFN?=
 =?utf-8?B?bUFCK1plSVpURisvdUZuQy92WDJFZG5rMTV0bCtubzZKTlQ0dWhnZFJXOVRp?=
 =?utf-8?B?cGw4ZTFTVHVobTR2b1hNRWtCaWFPUm4wNEIrdDlUaFBualFGT0o5N05hRjZj?=
 =?utf-8?B?TmtjY3FkTEJCT2ZMa0dvM0dNZXBPcDJYSnQxK0VGTU5SZ1U3S2FFVGl0TWpS?=
 =?utf-8?B?dTYxazBhUnpwUlh6b0NTNEwwaW1IQUtqUFd6a1JNdWc0Y2ZRZDdqK29MbVFD?=
 =?utf-8?B?MExKb0g2Ui9FeUVrRjYvbEovcnBUL3ZteUlmMEhpWDZKRFZPcStVUnJZZVU3?=
 =?utf-8?B?ZTJFL3N0ZEZWNkZ1ekIvTFZSbGFJa0hPV3RYUWlSSVJsQ2s1U0NoQ0tBdnAr?=
 =?utf-8?B?MytJUERsZkRDcGs1L3BsMGtoNWN2TVlOczdLaWRlR3JNaWY5WlBaSlpIL0tE?=
 =?utf-8?B?NGUwWjhFMlFaMnlnSUp5Zmk4Q3FWangwaGsxbGFjSFkvYVFiRENQVU05TGlM?=
 =?utf-8?B?dUF2REd4cXo0My9yYnNGR2dEMWJkcmlXUStiYUcxUlhyaGg0aTR3ZHZqd3B2?=
 =?utf-8?B?QlhVQWxRbUJEL0VSNWNEQzVqMmo4clB5WUNteEZuUVhYTEZGSXFDR1JiZ0pK?=
 =?utf-8?B?KzdscnBRaW9XT0tRZC9tamovQmV2cW9mbkNrb0hvbzdkZGZybjYyWmg3VFpF?=
 =?utf-8?B?QVcxYjN4QzVpV1Y1UTRIWklGQTgyR00wR05RWlJRVTRhTWZjcTJBeFVTbzFN?=
 =?utf-8?B?WFpWbjVHWGViamFJaXFNU3B5VnBrUi9kai9iUGdwdFdjdzNOQ1ZCQjI1TXE2?=
 =?utf-8?B?eE1PYkRIN2xoZWpEVGpTaFBzR0JFc1h5YldYekhrSi9Ca3dac0hWUVZKVzEx?=
 =?utf-8?B?YmI2TXJEbWF0Y01meTdFUlNPUGVzTlNnK2k5YVAwTXlEVmdCcmVNWU53L2VM?=
 =?utf-8?B?UVF3T0pXV1U3TlVGalRGZHh1VDdYMjZCQlh1ZTk4eGJianRxY01FQjgvM3c4?=
 =?utf-8?B?aFV6WTFDdnhLdG85QzBTTXBhbkxsZ3hsSGdtZXloWkd0R21ISnQrMGhQeGl0?=
 =?utf-8?B?blJ3djFOQW5tcVJhOUlQU1QwbE5LSjJBRHJMMm01RHFCTUxYTXRSeTBsdzdN?=
 =?utf-8?B?MHFvU3ErT0xDTFlWNDZ6Z1dmd2t3U3ZkYWYxdkNDbGo1UWViZnRubFVZczVx?=
 =?utf-8?B?Skp3QzBCQkoxMVNQQnRRL0Y3dGxRRnVqbUVRTW0zRDRGanBkV1hhZmZaNmdi?=
 =?utf-8?B?OUdQWkpaWlN1SFE2UmRxVjVHWGEwdVVLTE0zRUpOSjljVlhWakk5TWF1S3BT?=
 =?utf-8?B?SFBqWTlzenE3dGIzTkw5Q3N4V2RGcDF4eHc3aEpBNGN5OU5zSkg3RGd3Z3BW?=
 =?utf-8?B?NE9ZOHpFV1FBd2pNZlZHMGhiMGxKcElFQXJ0MXlacTU5cDk2U3Q2RkhrM1Vx?=
 =?utf-8?B?cjlINTFDM3hVdWxycExwMFVrS2s3dkk1dWR6NDk0dnUrcHB2TWV3RVcxSExJ?=
 =?utf-8?B?eWZ3bkwycnV2RHk2d3VkZlZnTGgzNGowcGNZMFdFZmkxVmZGdGhTR0kxMXdX?=
 =?utf-8?B?Rm1VTFArSEZTS0xFUE02Zm92eE1SRERuYnVvV1pDUGNFSUNyQmI2bnBNRjhR?=
 =?utf-8?B?U2J3SHBONjBjTWZOWGJxWWFLc1Bvb0Q2blh1aVo5ZXp0dFowczVhTjNGZDZV?=
 =?utf-8?B?VzVld2s1R0hPeE51WGw3R0VWdC8rNG53T2p5cXhRRkdMZ0sveXRpWDVha3Jx?=
 =?utf-8?B?OEVhclBGRGlSZk1ybzFJVjRVZmt4MG5USEh3dG1EdUZnZDZOTFQ1dFhuakVN?=
 =?utf-8?B?aWtCb25UVTNZejlsSXBNL2gxZ0tiT05OeU16WEh1ZE56K0l0VXhaWmxsZFVT?=
 =?utf-8?B?dUZWYzdDVVp3SERGWVVRb1NId0lGMjJXZlRuRlcyY1lpR3VXL0pZbHZPM2dS?=
 =?utf-8?B?bktidStTSzdQRDdrQ2szbGxOS0Mycm0xTGJXMnlkK1Q5NEgveTNjWU5zdnNN?=
 =?utf-8?Q?V7jNK378zcIOj84Q7hJg9FwVH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <562E9BDED04745479D3D6E14AEBE531F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QXUiYhVEKXTo8Fd6utOBNzgfnK2yHcHtJr1tZMisfhDwwjVBKtd5KN69kkiGW9Orwjrc7e9Gv2yht2hvnl7lBSDnR70twjERGwqK952WcZgIqh+RdaFzEk90BwuI1D5DcFtFZ8GemysM9wvffxL+aV26QDInuS0r50D07rvEICnCLTc3TtvzUVjZAkd1/5aSGGKtcWLSV0PWanZay0Sgn+joiJYaJGop27OQLiHWPugpN/++GBy9JD/t78N0N9U6rDts0Resjn+iumozSk73Y3m1GPJ8wmI77Ex39mAWQtaWUVjvu1Vz+RvDZFy32GvLuEQlnYqLB5AnLWbH3TtRbG1JZH8Z+bchfnhEEQHcesrS0NfU0A8B+M3w72zmlkmgbGIrnhB2VBVnPyFKv50oKzMvfBOYAKFwySnqxo2VIe0ZLC2wPe4lHK3cjSB7hRdsvmOm39FXfNcrMs8F267uGw8EVYXj+akONhlm2V6aK27vQbqILNme2JhKypPJCMjMYOoYLgIRT10cWA7Jh6EAtQzSM111DJYQbM2Ttilnn8WpGdGrXK9mQ7AS6K7r/OWMhbiMcA3dfGalp7ogw5AszVe1SgJL/Y6cAINR6ONMrHbGtCOzRbM7iSmKZsIlHzS1YiXBvUbMCIJK6uGu5H43dg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0148d59f-7564-44dd-4ddf-08dc16fa49c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 01:19:01.4849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dXB1aDBMjMwFr3aOYB7wePCE+GJittdyC9qyIqNleMjRe865IN9eRlzBtHaKR6gTLW0lPmCj/SOqSWtvWgL3EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4460
X-Proofpoint-ORIG-GUID: W2u26N4jsJp13hsfuhKHgExlX7D643Ok
X-Proofpoint-GUID: W2u26N4jsJp13hsfuhKHgExlX7D643Ok
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_14,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=622
 priorityscore=1501 malwarescore=0 clxscore=1011 suspectscore=0 bulkscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401170006

SGksDQoNCk9uIFdlZCwgSmFuIDEwLCAyMDI0LCBVdHRrYXJzaCBBZ2dhcndhbCB3cm90ZToNCj4g
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
Y2ggdGhlDQo+IE5VTEwgcG9pbnRlciBkZWZlcmVuY2Ugb2NjdXIuDQo+IA0KPiBUbyBwcmV2ZW50
IHRoaXMsIG1vdmluZyBOVUxMIHBvaW50ZXIgY2hlY2sgaW5zaWRlIG9mIHNwaW5fbG9jay4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IFV0dGthcnNoIEFnZ2Fyd2FsIDxxdWljX3VhZ2dhcndhQHF1aWNp
bmMuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgfCA2ICsrLS0tLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdj
My9nYWRnZXQuYw0KPiBpbmRleCAwMTkzNjhmOGU5YzQuLjU2NDk3NmIzZTJiOSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2Mz
L2dhZGdldC5jDQo+IEBAIC00NzA5LDE1ICs0NzA5LDEzIEBAIGludCBkd2MzX2dhZGdldF9zdXNw
ZW5kKHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gIAlpbnQg
cmV0Ow0KPiAgDQo+IC0JaWYgKCFkd2MtPmdhZGdldF9kcml2ZXIpDQo+IC0JCXJldHVybiAwOw0K
PiAtDQo+ICAJcmV0ID0gZHdjM19nYWRnZXRfc29mdF9kaXNjb25uZWN0KGR3Yyk7DQo+ICAJaWYg
KHJldCkNCj4gIAkJZ290byBlcnI7DQo+ICANCj4gIAlzcGluX2xvY2tfaXJxc2F2ZSgmZHdjLT5s
b2NrLCBmbGFncyk7DQo+IC0JZHdjM19kaXNjb25uZWN0X2dhZGdldChkd2MpOw0KPiArCWlmIChk
d2MtPmdhZGdldF9kcml2ZXIpDQo+ICsJCWR3YzNfZGlzY29ubmVjdF9nYWRnZXQoZHdjKTsNCj4g
IAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4gIA0KPiAgCXJl
dHVybiAwOw0KPiAtLSANCj4gMi4xNy4xDQo+IA0KDQpEbyB5b3UgaGF2ZSB0aGUgZG1lc2cgbG9n
IG9mIHRoaXMgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlPw0KDQpUaGFua3MsDQpUaGluaA==

