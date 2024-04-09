Return-Path: <linux-kernel+bounces-137451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 599A189E258
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D8151C220F2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D5D156C54;
	Tue,  9 Apr 2024 18:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="kEhhHQRn";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="lFMUJGF8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="uiRJHa+7"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A569156996;
	Tue,  9 Apr 2024 18:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712686466; cv=fail; b=f1CiL8cvzUqxGJXrXfm2mjL1X5hsyWmIIlJiUSENBPMECceie3xrtEKZe0r4lzxIwYV3vShDkW9fjg8hzqr7aAaBPLSkifeOR7Ug4sRxvLn0M61+lTDooB47b4KFA5kerfVLMa7AT71MxZU+LV1URkrEaExFK+vz0NozJolseRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712686466; c=relaxed/simple;
	bh=B2RB2jP5UiODNtpKdQlfdTPbT0XY22Ruh7ZWb1EqOuc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u3DO0tmUxSErdsJGVpxahl0GcmfQDbQabkvw4TWOyuWrpmVMPPWgI8TM4xzb3nc4R5hMXiZaIFHLJslNMQ0UGOwnlJOYFY45MIMEO1IjzF6uC8YWUEqhJFZwhJWYrbQH/JJFD9CVAsDMLqQMrCYt3KHM1r7ePWXUVl/Xo8LQAyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=kEhhHQRn; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=lFMUJGF8; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=uiRJHa+7 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 439HwpYO027512;
	Tue, 9 Apr 2024 11:14:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=B2RB2jP5UiODNtpKdQlfdTPbT0XY22Ruh7ZWb1EqOuc=; b=
	kEhhHQRnqUfPK492yYQUrzZWjeC4Zv3YTHldaVhlFyreBS0Ey/NKYrv0pkEHo4F7
	t66kKJRT3rVQE1tNgvludKSzGemHqalM9DjjlH6Gw6aCzf9nbBbsA0aLMdQnnWsr
	0ICIeD2GXcpnxHzW0WIULRrdDtpE48w0t6fqUzj949ivQ7ORh20XHxrX9lM+dYVc
	wXWu8TdI+MPgmDZ5wGVK2mMdb/A+CIlq8FKKU/mgRVciHKsR6fIRzIL8vwu7UC3X
	90WV5DSi8jiB0eryc5GfHTsxDgUdhlQtSqMkg8SAV1r10anSxfO+QpwsbSag3FXn
	f+Jz9oNeSSb8HZTm2uc0Ew==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3xb5asjy4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 11:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1712686446; bh=B2RB2jP5UiODNtpKdQlfdTPbT0XY22Ruh7ZWb1EqOuc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=lFMUJGF8jdbnWFCo/XjnMwJEasDGneR1t6k99PL8mxJOsvJ7SbLM2mKhBurA0U6FC
	 OlD8D4tOKyTmNX2qK0C6ptavxSY7IeeV+F7b5isLNEDCE2r//8VRemTSfZ0OtMtCDJ
	 8O/Qy/aYOC49nc7rsO3FVaML25vupDtMHNi+COvt0PrmMj9DG7lEMQWhJxfSgqaQSh
	 uqmJANvhZ8wcL6yO9r2SS6UN01l4h4MnhkFr7ElX1aszICVKjr6x5zKBg5ET5gQNQc
	 cEShkU0qGi/vNQnPGrbCG44FN2xZkNfNYpKFRrkLYYqcEV6p5a1ZzVuTr2cej8X93h
	 tLGwxH6SkmfTg==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3F77640363;
	Tue,  9 Apr 2024 18:14:06 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id D97F2A0096;
	Tue,  9 Apr 2024 18:14:05 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=uiRJHa+7;
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id C33A040363;
	Tue,  9 Apr 2024 18:14:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iir1YEN+Wc8LNPv3+r6Yy7dWG83PXedUXwsAIerobw1tnwda4KUkXRoO5korIzWSYeL523TAH2SS0Ix9sVlZJlJOkXeAPnW98kcXUI/LqPZAnv2VxDoT660s4AJdmxGHf7q4esE0R4l1BGZkmYWke52uC/sdNS2RTxIQBB7LkiKKxWGxCQYlOk0v02Whxs3XcNYmdFLeR5uNK1eT1H9Da7ikyN5KaNopseBzCR15A0DysYrbBHSLMEfA/P3KJso08+8GAjtWdkSEd+YeLgeA71S0E8migFEsP8CtpAh9g3+iNBBwBw/bjI0hIXwz3Ux/SRixMqmf6azDEzy/kgJ6Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2RB2jP5UiODNtpKdQlfdTPbT0XY22Ruh7ZWb1EqOuc=;
 b=HZuUsMQIjKdSHrwfovcuzOaIgiSsYslkc4PVtP3zmFnYW4vhH2uMjVAPpjra8lM/Rx9Q7NV5da2x5GGcbSkOZLC9pEBo2zMT8GdAv1wyF4lEae/vlrNUPY1LamPjCIWHgKWGM/fvRIKSZBmv+Xl810/9nHGNgi1vvH6h9ExYrowPnQrs2zJENj3/txvKTkhnaUa5C2IhhLlmrgA4iMTH+zzK1IvKStfuigADQL3MMGaapTSbW9yx2qAZXta3b8GG6MD46yhK/QK1u3qDsUF0SQikGkWFtizLAXy916I4ddAiY/ha+bU6Z/kbBqABgJklTM1eZ3qPXrnmi6RoVJF6VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2RB2jP5UiODNtpKdQlfdTPbT0XY22Ruh7ZWb1EqOuc=;
 b=uiRJHa+7vqIaP64UVsvqmEhcdDm5WMx2TuvP7+FCbBTmRVZ8B6gIVgczrCEaqGucy26p8/UGtLMBJSmFXH6NDVm/LWCSSj59t9DoRCm8IbeDRJPw4v54LSgpgc6TGoHUeq0aVIhZD/T4zy3/PUVJNcHYXUAGkcgAYs05J4psnXg=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SA3PR12MB9177.namprd12.prod.outlook.com (2603:10b6:806:39d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 18:13:58 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c%3]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 18:13:58 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v20 4/9] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Thread-Topic: [PATCH v20 4/9] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Thread-Index: AQHaibjrQsWFlN8oQ0+zdNhqnOxOLbFfIg4AgAEVMwCAAAibAA==
Date: Tue, 9 Apr 2024 18:13:58 +0000
Message-ID: <20240409181342.wmjvi6rwtxphnv3z@synopsys.com>
References: <20240408132925.1880571-1-quic_kriskura@quicinc.com>
 <20240408132925.1880571-5-quic_kriskura@quicinc.com>
 <20240409011046.zgjqvhewldch3snu@synopsys.com>
 <3ab9badd-2cf6-4fe0-aaf0-d08614418968@quicinc.com>
In-Reply-To: <3ab9badd-2cf6-4fe0-aaf0-d08614418968@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SA3PR12MB9177:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 +Cm+ZKGMJbNj6SnHmkVmReuyGs1DZ1ddmX5jOKVMem2a7jnCf63UOYKg8t+ef4dY1qBtI5HUBpZ/Hv1WHbu36ZRvGa6+3XL3nNbK7/qEbf+lIacxmPnCJ7TQhoecNiq3VmPIstqUNcuiJCn6ibWyVIynEHRchH4C/CZfFzzjMvZlXmnoGzEnhpskSYYwf6UXUKhaleV6Hg2J8c9hQpL5/mBCmciJHhryB4VrDX4KCOW9bfL8h/V6vU6FXq/R3tMGwD9LWH8lQNtnm7YxXcBiiEOo0+yEU81L/Jcegy9HDnivLWyRoUdmGc7j1kzM2AyVw3AnEaOGbOjYHZ+g/QbzQXRxblV6BhwQvPhmJdkg0OkAw9qROQq5SWEoLRIwOT3kdqtjVu0tMSVZw9JaWvuHGHNoli8Ikq0x0hst1Ehf9XByjdwSzx/D3YcgTZ8F8CrGl417f+dOTnZlCb70JiWHYZ2xQwDo6JsWySDuWrAg/3GKMY6ny6MKPDFQDo7yB12FQsstUVCZwL/GjzciBTfM3kRf31sU29BDT9enyK+/YPZEJ7RWpEHTZENpjwdxg/lkTaJD3FHENsjNraIoXWp+crl14OAG6b6c9g1mY5ynKYdQi5h8HwkQSDFHT/YriyZz9j7Z0V9RiT4HTU3DCLIYJEG8exed2nzj3D3LzzkiLpI=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YU5zNXpuazFRNDdWSjZleVIvWWw1TDd1ajFEeGFRbHcrWEFwbEs4QWs2Mlll?=
 =?utf-8?B?eVluOWpSTmJySEE5S1FXaHNORU5ueSsvcTJ2bmRGbEIyaGNxODN0aW54QTVu?=
 =?utf-8?B?R016czJENDhHMWxyS0pia1FZNXZTVVlPTGhTTEgzYkRqVXBGVHlNMU1DNGVS?=
 =?utf-8?B?WnRHeDJQdk1BZUoyRFhITnhpajJuNFJhWjhpc3ZjckhuVHRPa3RXUFJjalZy?=
 =?utf-8?B?SVBJSThIL0Jwb2hUSTVnNm1UZFA1NlMwWGxnTTNVeElJQm5Vd1ZIamg4bnVr?=
 =?utf-8?B?Qk1acnBuK2JFZ3kvek1pOXZVQit6bTdDN3huSENuTDJPckl1MXR2cjdXYkNw?=
 =?utf-8?B?Zm1SdW96Qmp5ZnduVklZNDArWWVFTDdUTEpCS3JJdzlrU1NVQ1RBZFB1T0U1?=
 =?utf-8?B?S0xtdmNEYTNuU3daZUQzL0xFNW4rZzhXVnQ1RnBLaHVSMnhQdmQwcWdNL0hj?=
 =?utf-8?B?MnMreTFvTStRcjZINklTY1BHbkRrc2tpblBtbndYUVlKZ2pTZFJ0TXY2T1Vz?=
 =?utf-8?B?S3RUUG9JN1crWWdKa3pFcEtkb2VSaDBEZXlNcTJ3YVg5ZEVHYlpXWm5SVzEx?=
 =?utf-8?B?dFRFdTN0TjRqaHpCZlR2bm9jS2UxaWZOSnBsdFdFeWhYOUpncmtIMFRlOVV3?=
 =?utf-8?B?SisxZCtiSVlSQTNuN0p3b2wzYWY5Rm1TUGI3S2NzaXJWcEh4YXdmZTlOZ1R3?=
 =?utf-8?B?UDhUeXRJRGYyTjhhc2ZIS3RjbHJaTFVrc09MQVBiWkxuSkZIUmRYQmU5TVQv?=
 =?utf-8?B?SHhKVXFMVVhveUtKN1BGTFNrY3ozTWhDSFd2N3dBUkRXRERJaU5NU3VhbFIy?=
 =?utf-8?B?TjlMcjk0S09zNEV3MEdvWTZhV1ZGbWliZk9xZGRWUHZFVDVqUGdZRGhUSE0v?=
 =?utf-8?B?aFZvUHNVa1lkVjAvM2w3ZC9nRnBVckU0bVpKTFZwSW5uZ29QR0l2UDJUVTgz?=
 =?utf-8?B?eW5maXF6VjB5dnEvSkgzTHl0d1RmY3J3WDV4RVoxck15TVZVNmphN0VlK2hX?=
 =?utf-8?B?RG9BZGV0eTAzb0lRRm9tV2tCRmNPVnZLKzB0MGgxNGNSZnMyQ0RSc0s1b1ZW?=
 =?utf-8?B?QjBjNDZpcjJtQXZiNlI3TnNVenFkU2VMdEVMT1g3d3d6T1MxNjlVaTh1NFlU?=
 =?utf-8?B?dFlZeWpPSkhIMkZMRUlvMnErZlZmTGdJdFpVRklJWGYzR2FxUWxLNWRwaWl3?=
 =?utf-8?B?dVI1bFQxVUpvVXVtTkh0YTYzU3Y1WmhGMDhIWDRwV1ZnVzhFUVlPV2J3Q1pX?=
 =?utf-8?B?dXNjOVJ5VkliOUVFUGY5TFgvTDNyeTRNNUZVbU1PQVB2aW43SlcyeWUvc2Js?=
 =?utf-8?B?a2dHbjJPRzFvbG8yamRWSnd3czYyZStoUlR3YWpKYWY3Y3ZSOWkxSWVhS3Q0?=
 =?utf-8?B?NVh5MW9lUGw0bWlONXZQUDNkWE1Gc0dReXcxbUxBczk0dldUdVIxT0FTNmZC?=
 =?utf-8?B?UzBZU0ZZS01NNmFwQXQ3NDBDYXE2cnR5aWNWeGt3K3BZMEJacDBjYVlxcGJu?=
 =?utf-8?B?K0pPZkVvU3lHUWxBYjJIejdyL21rNVRqRnBLdmNBMThGejVncXUrRnNoajRq?=
 =?utf-8?B?MkFnWGVUZ25KclBOemVDZld5TkIxSXpmMVVRYVVvUitNUjBxTi9aNDBvS1FU?=
 =?utf-8?B?T3ZLT054SmZ6cUxlUXFzUjFPbWE0N1JybWtIS0VlSE9ULzMzMWZpV0RDYnpa?=
 =?utf-8?B?Q0ErSm8wbU51YlA5WEZqSjRCWWVhbFVrWk5lMzZocHgvV3p6d2FBbDRNM2FX?=
 =?utf-8?B?eDZKNFVxTnpuYU1xbE5SK216ejdVUjh0bU1FSUh6aHlpaExiOEorQ043M1Rk?=
 =?utf-8?B?RU1HOWlMbEg4MU9tZWpqYnE3b2N4Y3ZWVUluUzdHVXgyVDdvMWZocitqczM3?=
 =?utf-8?B?Qk83V3BZYW92VDlOdzR1ZTB4NTBPUkVCVXB0eEx6ZDIwRXBJSXlwVWw3MDBM?=
 =?utf-8?B?WlRJYTB4TlhmRVErcVpuS052djRNdzIwYWtPdlNGVGxBYXBnRVNUR0p6WVNm?=
 =?utf-8?B?SGZhR1dpSHJJQXREVEJmVENNd01TWlhxNnczYWpaVXpKRDc2SzBwVmlQc2RS?=
 =?utf-8?B?S2ZwKzR6RG0zVWkrOU80UVQxTzd6T3F6QVFQa0ZUVXVZYjRLbDJ3aWdTRkdH?=
 =?utf-8?B?Q0xtdmlhK1pvd2d6SzFpbmFoUGNjZkFlYUdnZkRwaEQvMlc1VTJZUmU3SnJu?=
 =?utf-8?B?MHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B3021A24E53A44C95891CB4B48806E6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gcWgFgXPNFrioxtSVdLyRHMW372AF8Tbj9w0fD3Xv10jL6Eu6wtVZiHSyDuVgWxNzJrxUF4w24rq3T2ICQiFgM3ivoIO8iv372EWCiAEBTo+M7rZh8S8zgKCvD++uQZdH1/oQcjuTkkff8RrBa5llMbCrt6OVJGTA3wAUNhSAkmMpC22OPiLswgwraQSm8kb0QNk8njuWQwAWz5jVUf0XZMDyYLSTiUv58GqNUiTTSV4uCycO4qSwyncqGPj11G9pDO1yWIkD1Uqe4qqjWmMARpY2hWUJ771qO1g01Yo9RdB9DO4+eJR8/Yj5YGjnoVdMM6rZu66AYu6LU6q6+/6aQc3207kwqM+Wc6Y0vxbRpRvZ1eXcGFxiScdgRZKhnKQq4ctjBWNjTlnU39o7nGCwN9xpDKTOOWs2IZgdgv/oqsA/gwcXcjAf2xE70MDcZmeOEj8z+TM7Zi8l1+oiM0LaRB/Tcqpd6BuDPgdDPibBY3WUWKu9r6hXnRkHdiS0k9y5ilw/zmUzwONb0mxk25/3F6bnV7N9xPA6GzYRONzs3weXHxkt9ZlyzoGLhHEvkXkYs/O/8ktKS5WEjR28jHqJ9Uz3F/WURzJq0T6vQptQhtXTAiq3SKP06sBeHSH1cadKjFiPavBb5c8dCTM+BrL+Q==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f741e41c-1ab8-4804-7650-08dc58c0d375
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 18:13:58.4270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FNx3XLtSSSBTrS2D3ebc92Vu6OolMKadkpYNqZI/eOK/XJUPASVv6cUxCIPK+boPm4vKvdyFbRHVx5LFQkfR1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9177
X-Proofpoint-ORIG-GUID: CwygDVjKnxKDZapGuWrNWzEfmQ7G04gR
X-Proofpoint-GUID: CwygDVjKnxKDZapGuWrNWzEfmQ7G04gR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_12,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=999 mlxscore=0 clxscore=1015 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404090120

T24gVHVlLCBBcHIgMDksIDIwMjQsIEtyaXNobmEgS3VyYXBhdGkgUFNTTlYgd3JvdGU6DQo+IA0K
PiANCj4gT24gNC85LzIwMjQgNjo0MSBBTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IE9uIE1v
biwgQXByIDA4LCAyMDI0LCBLcmlzaG5hIEt1cmFwYXRpIHdyb3RlOg0KPiA+ID4gQ3VycmVudGx5
IHRoZSBEV0MzIGRyaXZlciBzdXBwb3J0cyBvbmx5IHNpbmdsZSBwb3J0IGNvbnRyb2xsZXINCj4g
PiA+IHdoaWNoIHJlcXVpcmVzIGF0IGxlYXN0IG9uZSBIUyBQSFkgYW5kIGF0IG1vc3Qgb25lIFNT
IFBIWS4NCj4gPiA+IA0KPiA+ID4gQnV0IHRoZSBEV0MzIFVTQiBjb250cm9sbGVyIGNhbiBiZSBj
b25uZWN0ZWQgdG8gbXVsdGlwbGUgcG9ydHMgYW5kDQo+ID4gPiBlYWNoIHBvcnQgY2FuIGhhdmUg
dGhlaXIgb3duIFBIWXMuIEVhY2ggcG9ydCBvZiB0aGUgbXVsdGlwb3J0DQo+ID4gPiBjb250cm9s
bGVyIGNhbiBlaXRoZXIgYmUgSFMrU1MgY2FwYWJsZSBvciBIUyBvbmx5IGNhcGFibGUNCj4gPiA+
IFByb3BlciBxdWFudGlmaWNhdGlvbiBvZiB0aGVtIGlzIHJlcXVpcmVkIHRvIG1vZGlmeSBHVVNC
MlBIWUNGRw0KPiA+ID4gYW5kIEdVU0IzUElQRUNUTCByZWdpc3RlcnMgYXBwcm9wcmlhdGVseS4N
Cj4gPiA+IA0KPiA+ID4gQWRkIHN1cHBvcnQgZm9yIGRldGVjdGluZywgb2J0YWluaW5nIGFuZCBj
b25maWd1cmluZyBQSFlzIHN1cHBvcnRlZA0KPiA+ID4gYnkgYSBtdWx0aXBvcnQgY29udHJvbGxl
ci4gTGltaXQgc3VwcG9ydCB0byBtdWx0aXBvcnQgY29udHJvbGxlcnMNCj4gPiA+IHdpdGggdXAg
dG8gZm91ciBwb3J0cyBmb3Igbm93IChlLmcuIGFzIG5lZWRlZCBmb3IgU0M4MjgwWFApLg0KPiA+
ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBLcmlzaG5hIEt1cmFwYXRpIDxxdWljX2tyaXNrdXJh
QHF1aWNpbmMuY29tPg0KPiA+ID4gUmV2aWV3ZWQtYnk6IEpvaGFuIEhvdm9sZCA8am9oYW4rbGlu
YXJvQGtlcm5lbC5vcmc+DQo+ID4gPiAtLS0NCj4gPiA+ICAgZHJpdmVycy91c2IvZHdjMy9jb3Jl
LmMgfCAyNTEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQ0KPiA+ID4g
ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCB8ICAxNCArKy0NCj4gPiA+ICAgZHJpdmVycy91c2Iv
ZHdjMy9kcmQuYyAgfCAgMTUgKystDQo+ID4gPiAgIDMgZmlsZXMgY2hhbmdlZCwgMTkzIGluc2Vy
dGlvbnMoKyksIDg3IGRlbGV0aW9ucygtKQ0KPiA+ID4gDQo+ID4gDQo+ID4gPHNuaXA+DQo+ID4g
DQo+ID4gPiBAQCAtMTkzNyw2ICsyMDIwLDEwIEBAIHN0YXRpYyBpbnQgZHdjM19nZXRfbnVtX3Bv
cnRzKHN0cnVjdCBkd2MzICpkd2MpDQo+ID4gPiAgIAlpb3VubWFwKGJhc2UpOw0KPiA+ID4gKwlp
ZiAoZHdjLT5udW1fdXNiMl9wb3J0cyA+IERXQzNfTUFYX1BPUlRTIHx8DQo+ID4gPiArCSAgICBk
d2MtPm51bV91c2IzX3BvcnRzID4gRFdDM19NQVhfUE9SVFMpDQo+ID4gPiArCQlyZXR1cm4gLUVO
T01FTTsNCj4gPiANCj4gPiBUaGlzIHNob3VsZCBiZSAtRUlOVkFMLg0KPiA+IA0KPiA+ID4gKw0K
PiA+ID4gICAJcmV0dXJuIDA7DQo+ID4gPiAgIH0NCj4gPiANCj4gPiA8c25pcD4NCj4gPiANCj4g
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCBiL2RyaXZlcnMvdXNiL2R3
YzMvY29yZS5oDQo+ID4gPiBpbmRleCAzNDFlNGM3M2NiMmUuLmRmMmUxMTFhYTg0OCAxMDA2NDQN
Cj4gPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+ID4gPiArKysgYi9kcml2ZXJz
L3VzYi9kd2MzL2NvcmUuaA0KPiA+ID4gQEAgLTMzLDYgKzMzLDEyIEBADQo+ID4gPiAgICNpbmNs
dWRlIDxsaW51eC9wb3dlcl9zdXBwbHkuaD4NCj4gPiA+ICsvKg0KPiA+ID4gKyAqIE1heGltdW0g
bnVtYmVyIG9mIHBvcnRzIGN1cnJlbnRseSBzdXBwb3J0ZWQgZm9yIG11bHRpcG9ydA0KPiA+ID4g
KyAqIGNvbnRyb2xsZXJzLg0KPiA+IA0KPiA+IFRoaXMgbWFjcm8gaGVyZSBpcyBiZWluZyB1c2Vk
IHBlciBVU0IyIHZzIFVTQjMgcG9ydHMgcmF0aGVyIHRoYW4gVVNCMiArDQo+ID4gVVNCMywgdW5s
aWtlIHRoZSB4SENJIE1BWFBPUlRTLiBZb3UgY2FuIGNsYXJpZnkgaW4gdGhlIGNvbW1lbnQgYW5k
DQo+ID4gcmVuYW1lIHRoZSBtYWNybyB0byBhdm9pZCBhbnkgY29uZnVzaW9uLiBZb3UgY2FuIGFs
c28gY3JlYXRlIDIgc2VwYXJhdGUNCj4gPiBtYWNyb3MgZm9yIG51bWJlciBvZiBVU0IyIGFuZCBV
U0IzIHBvcnRzIGV2ZW4gaWYgdGhleSBzaGFyZSB0aGUgc2FtZQ0KPiA+IHZhbHVlLg0KPiA+IA0K
PiA+IEFzIG5vdGVkWypdLCB3ZSBzdXBwb3J0IGhhdmUgZGlmZmVyZW50IG1heCBudW1iZXIgb2Yg
dXNiMiBwb3J0cyB2cyB1c2IzDQo+ID4gcG9ydHMuIEkgd291bGQgc3VnZ2VzdCBzcGxpdHRpbmcg
dGhlIG1hY3Jvcy4NCj4gPiANCj4gDQo+IEhpIFRoaW5oLA0KPiANCj4gIFRoaXMgbWFjcm8gd2Fz
IGludGVuZGVkIG9ubHkgdG8gaWRlbnRpZnkgaG93IG1hbnkgVVNCMiAob3IgVVNCMykgUGh5J3Mg
d2VyZQ0KPiBzZXJ2aWNlZC9vcGVyYXRlZCBieSB0aGlzIGRyaXZlciwgbm90IGhvdyBtYW55IGxv
Z2ljYWwgcG9ydHMgcHJlc2VudCAobGlrZQ0KDQpUaGF0J3Mgbm90IHdoYXQgeW91IGRlc2NyaWJl
ZCBpbiB0aGUgY29tbWVudCByaWdodCBhYm92ZSB0aGUgbWFjcm8uLi4NCg0KPiBpbiB4SENJKS4g
SSBkb24ndCB0aGluayBpdCB3b3VsZCBiZSBjb25mdXNpbmcgY3VycmVudGx5IGdpdmVuIHRoYXQg
aXQgaXMNCj4gb25seSB1c2VkIHRvIGlkZW50aWZ5IG51bWJlciBvZiBnZW5lcmljIHBoeSBpbnN0
YW5jZXMgdG8gYWxsb2NhdGUgYW5kIG5vdA0KPiB1c2VkIGZvciBhbnkgb3RoZXIgcHVycG9zZS4g
T25jZSB0aGUgbnVtX3VzYjJfcG9ydHMgYW5kIG51bV91c2IzX3BvcnRzIGFyZQ0KPiByZWFkIGJ5
IGdldF9udW1fcG9ydHMoLi4uKSBjYWxsLCB0aGV5IGRpcmVjdGx5IGluZGljYXRlIGhvdyBtYW55
IHBvcnRzIGFyZQ0KDQpUaG9zZSBmaWVsZHMgYXJlIGNsZWFyLiBCdXQgZm9yIERXQzNfTUFYX1BP
UlRTLCBiYXNlZCBvbiB0aGUgbmFtZSBhbmQNCmNvbW1lbnQgb2YgdGhlIG1hY3JvLCBpdCdzIG5v
dCBjbGVhci4NCg0KPiBIUyBhbmQgU1MgcmVzcGVjdGl2ZWx5LiBLZWVwaW5nIHRoZSBzYW1lIGlu
IG1pbmQsIEkgcmV0dXJuZWQgRU5PTUVNIGFib3ZlDQo+IChhcyB5b3UgbWVudGlvbmVkKSBiZWNh
dXNlIHdlIGRvbid0IGFsbG9jYXRlIG1vcmUgdGhhbiBEV0MzX01BWF9QT1JUUyBhbmQgaWYNCj4g
dGhlIG51bWJlciBvZiBocyBvciBzcyBwb3J0cyBpcyBtb3JlIHRoYW4gdGhhdCwgd2Ugc2ltcGx5
IHJldHVybiBFTk9NRU0NCj4gc2F5aW5nIHRoZSBkcml2ZXIgZG9lc24ndCBzdXBwb3J0IG9wZXJh
dGluZyB0aG9zZSBtYW55IHBoeSdzLg0KDQpUaGUgZXJyb3IgY29kZSAtRU5PTUVNIGluZGljYXRl
cyBvdXQgb2YgbWVtb3J5IGZhaWx1cmUuIFRoZSBjaGVjaw0KY29uZGl0aW9uIGR3Yy0+bnVtX3Vz
YjJfcG9ydHMgPiBEV0MzX01BWF9QT1JUUyBpbmRpY2F0ZXMgaW52YWxpZCBjb25maWcuDQpUaGVy
ZSdzIG5vIGFsbG9jYXRpb24gaW4gdGhhdCBjaGVjay4NCg0KPiANCj4gPiBbKl0gaHR0cHM6Ly91
cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXVzYi8yMDIz
MDgwMTAxMzAzMS5mdDN6cG9hdGl5ZmVnbWg2QHN5bm9wc3lzLmNvbS9fXzshIUE0RjJSOUdfcGch
YXpIcWdtOTJFTmtGUXJwdjZGaHM2UENlMjEwVkdPQUlyc3VHRmhyZ21mYW9yOE5fa1dMdTZyeGtQ
cGJlQ0JUTEw0TmJVcE9XbFEwdWZtUDlERndPOWlGYzBYZFNFZyQNCj4gPiANCj4gPiA+ICsgKi8N
Cj4gPiA+ICsjZGVmaW5lIERXQzNfTUFYX1BPUlRTIDQNCj4gPiA+ICsNCj4gPiA+IA0KPiA+IA0K
PiA+IEJ1dCBpdCdzIG5vdCBhIGJpZyBpc3N1ZSB3aGV0aGVyIHlvdSBkZWNpZGVkIHRvIHB1c2gg
YSBuZXcgdmVyc2lvbiBvciBhDQo+ID4gY3JlYXRlIGEgc2VwYXJhdGUgcGF0Y2ggZm9yIHRoZSBj
b21tZW50cyBhYm92ZS4gSGVyZSdzIG15IEFjazoNCj4gPiANCj4gDQo+IFNpbmNlIHRoaXMgaXMg
bm90IGEgYnVnLCBJIHdvdWxkIHByZWZlciB0byBtYWtlIGEgc2VwYXJhdGUgcGF0Y2ggdG8gcmVu
YW1lDQo+IHRoZSBtYWNyb3MuIChJZiB0aGF0IGlzIGZpbmUpLg0KPiANCg0KVGhhdCBpcyBmaW5l
IHdpdGggbWUuIFRoYW5rcyBmb3IgeW91ciBlZmZvcnQgcHVyc3VpbmcgYW5kIGNvbnRpbnVlDQp3
b3JraW5nIG9uIHRoaXMgc2VyaWVzLg0KDQpCUiwNClRoaW5o

