Return-Path: <linux-kernel+bounces-136067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A13689CFB1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55BA1F226C0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F97A1427B;
	Tue,  9 Apr 2024 01:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="vSCQGf0A";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BpvOO7Yr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="tmMQSree"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36088C11;
	Tue,  9 Apr 2024 01:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712625286; cv=fail; b=j+Bs3ZcbmnN1+mpI64eVGfV2VsO48oh1c94UB0wZlDH//HMRWzRmPecDwCk657jmJ5BKAIlIFme0DWnm8N6N+LAOXchVmiOAPDISv7E0uRfP3NZPEz1sZXz9YZuI+VBlV67J6ygRG3N2o3efNoCdIM9HLS9Q5Buj6J7C37ub3nQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712625286; c=relaxed/simple;
	bh=X5WVMSDzwE2ULm1H1mviCQe04BtIgOESSThIh4XO2j8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ES3bLqX3iEZBSz3urH58zvlomVO1N8GSV4g3cDQRQ/b2hIe2UOi3MC/TYAfRX2giMaIx7KY5kEh1bEBt4/C5lQg9Jl19+hkLSbP4x1Yv9TNpiXagGYpDCO5VmwOhDazGDzslcA+B2KJ1DlaOcpeomysN7pSbEKEjxvs+AkMqTj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=vSCQGf0A; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=BpvOO7Yr; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=tmMQSree reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 438LA1Zj006944;
	Mon, 8 Apr 2024 18:14:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=X5WVMSDzwE2ULm1H1mviCQe04BtIgOESSThIh4XO2j8=; b=
	vSCQGf0AbNesbaeLjgwcwUoAY3OOjQe3n3k3vuEwn3F5oXY175uPQY51wCMVIAZS
	sbV0ke0sDhQ+xVy0nWvoyB06h0wXKXpa7rjkRWJDS/83/czjULRIT0AT5CgncSeC
	9U0cTLHCECEKUVn8mWp9mi0mYdbgjVOwe6kQwsaMLgMooEgtEUJQ8Gi2ElWq6YH+
	Xs0zdmsyRUyTn1PUHrUJUrBZKHqV83T3x8clanwbXtAjcrzg4pbOHePnXeNWT/jK
	yeyx6G1TuwN6asHdZGiYsGwgsuQO+r67MOEXlOpdLlSUxaKlaw4Dgm8IwGNxwt8D
	KNrhSIz3L3/ukAS8XurD+Q==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3xb5asfbuf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 18:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1712625247; bh=X5WVMSDzwE2ULm1H1mviCQe04BtIgOESSThIh4XO2j8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=BpvOO7Yr/X/7Nbw5QNQihFzMWv3oErsYbiIu3BwrWkhPUO7BcfYLG8dxyTAyoMcq9
	 9xm2heEWROvwGorVjV+hD1G1GPSgOhxj7sEMxuNPznu3aHTYtc3sq/5cqCX4pH9vHu
	 DUMFc7tN6niCpbW0DXvLpG6KyGNlZCYeqnsH3xQHI5wCEmnVTXLSR5nYsKIMdpQale
	 ADSm5qJtX4xWMunlsR5h3FKHy4yO06zfmQRwkJ4o4WdvEP56+2gxOtWQalvVoRQ/j0
	 vRvPkAHzjKD7jXWOiLMsibIDV4i6njYUDemETn0SEyOutnF5+Taxe5iOmLNbz5Sdio
	 K8drYTXCTZuYg==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8411C40211;
	Tue,  9 Apr 2024 01:14:07 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 35BF6A00C0;
	Tue,  9 Apr 2024 01:14:07 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=tmMQSree;
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id CB66A4035E;
	Tue,  9 Apr 2024 01:14:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acF0gG6P0Ao40TgmKVPm5azPygBV+2H79ZfHGNYNow1M6Er92l464pYiRtDZeIFNb34LR5tLM077JaI6VQNi1tzPAbJ4wxws2ebOeLuNaMwiBzThxzPG7MpFQT4we/tt11HQV3hWOyRGWAJ66GHm/kRjWBjKNq1Uhr//KtQpvK+ZaxmbDdED2Jm/J3zkV3SvV42x4irg5Lvo7ckOO85ni57I/sLVpXqEOmeBdo4erYylfkJryZppW6PIwGXxGbq9DSvNv+61Y++bnq42D0nU421KUav1q4YhhXVBIv8ok7AJtjV9xoli4ABBiKLmYp6owSp6t3GYY7nqf69bCLepeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5WVMSDzwE2ULm1H1mviCQe04BtIgOESSThIh4XO2j8=;
 b=HD1PQ/XzSnPWbbMeT+aWfYIBPv1/O50NXSu95DNPpJjwilIj99mbHaqx8tO5X6BXsWlDEtThT7qycWJcwIkdNA6TPxJhB17MSGYQ/GjWNJqhyizA7YOSV7zSccX2KajmqLeJjCTxsY1VQZQ9fSDj0gXUn2n5eHEcIC6VAH05mLhxHl1Yuuak73B4zljgkitBsLchnntHjsJqSprKZIXsgxDzA3F7CcRqg8DyS80DcbvgLsyJw8fZRmodhEoXWQ3P3udU6PXDe9eSGIBRvSXY+Q0PdFGVR5nBpy6h57S2ICgPc0Bmb9dZ0PDyhAp9RpgeiLpoHM9isFfk2I1mWqK5cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5WVMSDzwE2ULm1H1mviCQe04BtIgOESSThIh4XO2j8=;
 b=tmMQSreeezPogkOZSXYeXCy6FjDjL4ngY95ZHZahGmXxP01lhRuVvslaKOkSkYMtolnMLEUr0cIsaFLKGMbXM0hL3UgVBLuQcUi3URUpQ3cMwdENmMHpzUo7ghfiG7zgqjAyu0ZJkKT2dsVIjVEnbc3kTBr82VmZMIROC+ylzHM=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by IA1PR12MB6233.namprd12.prod.outlook.com (2603:10b6:208:3e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 01:14:03 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c%3]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 01:14:03 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>, Johan Hovold <johan@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v20 7/9] usb: dwc3: qcom: Refactor IRQ handling in glue
 driver
Thread-Topic: [PATCH v20 7/9] usb: dwc3: qcom: Refactor IRQ handling in glue
 driver
Thread-Index: AQHaibjxx1sr6WGkHUyFTfHmu+cnuLFfIveA
Date: Tue, 9 Apr 2024 01:14:03 +0000
Message-ID: <20240409011401.fivjdet4qt3ibxks@synopsys.com>
References: <20240408132925.1880571-1-quic_kriskura@quicinc.com>
 <20240408132925.1880571-8-quic_kriskura@quicinc.com>
In-Reply-To: <20240408132925.1880571-8-quic_kriskura@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|IA1PR12MB6233:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 JQGirPXezPpKgBAvj6ne9UlS8zJbI/ZrvDZsLK2a7Q6+r+1j1dY6NIMepXDUNMhqbkoaG1EtWRfFXxGrqiWlzY8sSFyPFBM5bPKxOVBd7uLT7CTR1btORbo83EGif0Mlt96vGVumd3yuukf5fVg462Nh7w4otgfvEiRda/P7cpO+yUoXKgyrqfCrFkSOyypSZSC2itDTRl3ErKIO/ks86yKKSA+Cgb8AWvXdCJnOroXrskSPTW9dCzJ6g+1nQ7SdPBWzDwXe2GMa5L+7Y8oIo84OIXxI0De0GtW+hhQsOcfCeiZsYUjB6smZn/pb8jMzBIvUfHjVq7i9Mqxjd/8E2ecJ7D/i0rhObwRPfizr5hC66N9QoBS/371bhT19tGg/AiemDgRwGNYWty2oig5/821fRjd9Aw1nCNw5LXfSRnXHklnokjNWanEHU82u3N2h4rBJlP19wJBswctX9go+PKaGe0heVVbT3TJl8PmfmjtTicpV131OSz5nIhm2ehf7Rttj6/yEFWsymMoIUpbO9WcaTxctc2oaYqxJFd2CF3FH+cos0yYHX9Td5dJ3MMZXnxfUVVMmMgfg6VgLW1zog0wzX+NDD35X/OgPxc/wXoIF//0jNTEpX0m21cpGUD/YfZjhXgBvn98RTWFJin3LX5Q4yAv5ELipcspI3R5i5nk=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?b3NGSHFjckxxeExiZkdMSFI4a3NKK2NwNDh0dXFnRUlQcGw0eE1VTUNvNTM3?=
 =?utf-8?B?ajk0ZzdLNU05VHgxSG5ncWcweFVHK3BsQ1NGNlF0ZElyeVNKNE51T3hPeUk2?=
 =?utf-8?B?RE5Od1FneVMrZXdkczY0cXhBNFFiekVtWXVoUVlpSG40cVZxZERZZUtreXVu?=
 =?utf-8?B?bWRxSFVuaVNEall0WHJHbWpTRmhaaGZkN2FZbE5uV25WYVdLbmlEOXZkUWJs?=
 =?utf-8?B?Mmt1bWRPMzBrUmpzRVNNRUJ0QVhqUHd2b0kyeTRXSlFrbTNaVy9FdlJyU1RG?=
 =?utf-8?B?cXB6bFhTQy90YTFjREgyVGs2K0tVUmxHUVZJak5tSDVhSFVhKzhYSWxTcTVu?=
 =?utf-8?B?dEQyY3QvcEF1Tm5DSERPL1g3NXFLNGZQN1IwMXFVL2d2VzNDU1lzN052U1NR?=
 =?utf-8?B?RmZMb2kyWXBQYlZyREtxbS81VFdTV1dSUUk2ZElOTFhydUhkNklmTURpT0hG?=
 =?utf-8?B?MGQrTDhpbkc2aXMvbktvT1ZSVFdtMkZ3Uk5rVVBidnZ2dEZ3Q0FTYk1YSDF6?=
 =?utf-8?B?c0JZd0JZdXFmTDNTMjhDeWd4emF5YVczeWFqSU9IZzZrWFdGckw4Y2VWVis3?=
 =?utf-8?B?VExqYzZlOWJsQ0lnb0d5d1JuNHZPMkVlYmt0UENpd0UwcElCeVNBaXN2cHl2?=
 =?utf-8?B?MWVUVStmYU84eW0vMkdTRDFTeVlFVDNweUFiWmhDclVHTkt0YzVMQzN6QkdS?=
 =?utf-8?B?SFVlS2FLUk1odmtkMmI5UmZRRENqbm05V3lHQXBGNDZqT00vV0MyU2JEWFE4?=
 =?utf-8?B?QUYyQnk1bVhhNSs5MDZmODdOd0duczY2YkpnbTk1OEhCNXVBalZ1L0l6WmNC?=
 =?utf-8?B?aXJySkNsZVBybjRtcWN5Q09yRXBrUG05M200VDlxUzBrVm5VNTFzS2czOTRM?=
 =?utf-8?B?ZTZVb1FpYjFXMlNLUzAxWnBuSGtEMXZKaEFhVDV0Rmx5RzNLelovRG1YR0Jo?=
 =?utf-8?B?dFl3U3hoMUluWW9XZXU0dXozRXlqUy9sU3ljN2NBbFhNeExtR0FpaEVuNlRr?=
 =?utf-8?B?YnhnbUhKNHNma2F2UXNMMEtpY3RmTWRRZWN6aHk4T2RsSW0xZ1lJODZaYmZM?=
 =?utf-8?B?c3dlMzl3TzZuektaUDVKZE5zMFRPRjF6Vm84eE9QSzY4Y2YybGs1UkhqYzA1?=
 =?utf-8?B?dFJyWHhXMzZ6WE9zckFWYmhhczdUcVlrMFJTNnlpbW1UK1lmRGUwMkY2dE1T?=
 =?utf-8?B?YUxXQ3VGR1ZOOXV2anFUWVU0enVkWDI5T0VhYU4wWEp6ektmRnNzamVNb0Rn?=
 =?utf-8?B?a3l6SzBoemdCbmEwYWtBVGVhZDIrdVhlQ2hKV1pJWkNJaFJXZys2VDA1bXFh?=
 =?utf-8?B?eStvcFg5NGMwSHB3UUpIOUpMSGxhRW83VHNsSDJUaHlwNnFnYnVmOVFLQUpV?=
 =?utf-8?B?Mk1HYjU1dTJUY3JpNFZQY1Z1amlLb3BadUZHaUNVUnFlQUxJQWJtcWhtdVFG?=
 =?utf-8?B?OVlvS3pCR0s5L25HcHhUbU1DWTFXMlZiRi9iWGFYYUxqS1I2YVVZblg3SHdi?=
 =?utf-8?B?dytIWEJWSlVOdWdzUDlwSFpDR2NHNzFNOWsxTURzQmxoOFg4MnY2OXRDSXRM?=
 =?utf-8?B?L0xOQjVHMTducFhveDVMemV1MDFxaUNlejBCMXM1TDh2QmNJMjBKd0tKUGVs?=
 =?utf-8?B?Ri9nckNwTWxIMGVoTUpZaWRqbzEwSEpvY0o2YnpvL29hR0ZjazhKcEN4RmMv?=
 =?utf-8?B?OExURlpoZUJUTWkyWHpVdHJrSldwWWd2TEo4Yll5UFFlSU0xUnhTMXEyUXJh?=
 =?utf-8?B?UFcwZU5jWDRTQ2wzcDZ6TnVpMTFBMWtacnZ0eDUvNFptVnM3MkRGd09ZQ1FF?=
 =?utf-8?B?US9UWnlQaUNxSXlyYmZTUHFlRGgra3h4bG4reUNCVFhHVnNzQ1lWRVdiT1Bk?=
 =?utf-8?B?T2RjQ0VkTWIrRnBHV0ZnY201VWY0NkdFK2xnU2FuU2c4YTN1MlZoejc0WS9O?=
 =?utf-8?B?ZlJjVGVNN3g4NWcwb2xNVDNFTjdJYU9Kdk1BT3lFeW1lU2dVdjYzM05HNDFr?=
 =?utf-8?B?RFRHUldwanB4Y2txZ2ZvY2d1NG0xVkpYOTYxRmdzdUVPMjZBbk9uU0lKTTA4?=
 =?utf-8?B?b1hIaStFd1EzbVdQUkttWXRHMnY1QmdheHloS0tmcHgvU2dBZkgybGxLL3R4?=
 =?utf-8?B?WnhZWmhzY0RTQzVLZzY3N1dTaDlXUlAzOUNCRE9yakZqd3lJaVUybW5yRVhJ?=
 =?utf-8?B?dEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F0559ACD525B240A7CEFF3E5A8FBDF6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cHD0iC1iA08Ev0MNNsdPak4dc8fipkZLNLLfaqkXiiHAblGmH6UMv8jZp0DwNhfzDEwmITL3/l/yEg+9xRpnFWE050WeNDjasKsCVSwJogb+BhiRUWbHKWpYM5XYI6EQ6p0Nj9Gbm6Ro9corljHtCs/AcaDsUD4u1welqxnn0UV4nlqkJ6MIXFCTK5+mmw18b7Tlec2CCwTKlmTgAWJfsNELGOysXjW0I7ousbv4h+ikZ2T+EPviXFGBB36qVaIcA1cH41/g+6OuXR5/vinyd6aFwb+ewJskTUiecuOHxDYPvbWvSfVNea63gp3TQ7B5PvvtjR+aGInLi5Ckv4fCQ9DgBscvYJjvV6jcufbUMlApJ5dlOs5sVv6hP5LxSyL5oiaqBOOTA85YvtksymxmhWErXTGvvki2zv/1xPShjOe/T9imG4iJ7gu8WCtYHq2fLe1fwlsWZhicNQ7Wj+JNVpaUiPj0lhsGSwCDldsjMGpB82b/nWraogNIUKOUKbR2IzJBmXiAHG/FNRIEoRMgRVVGx36qb3vBukc7Ao4N+G1+YdP9tYLR8vz3Zsi9Tth1IVbooyk/WVfgxDpv4hS2OjFCeczwxOU0AXSvQBpZ0UJjxwbvKuTw9UwsPm0TsTwKJf/EAplkg7CWiXzTCRi89w==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7fd1bd-9757-439d-a88a-08dc5832587b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 01:14:03.5257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y/bMNJsZzCjcWZ7fRKH9ozsTogfIW6j+/rg0tTF5wXysx4AnxsNUP69Kn4qcqNQKfUPdSOfcE3Tb3p0YfQPZpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6233
X-Proofpoint-ORIG-GUID: qf2X5TeO9qEcRTNygqob-q0jdyYprqVW
X-Proofpoint-GUID: qf2X5TeO9qEcRTNygqob-q0jdyYprqVW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_19,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=999 mlxscore=0 clxscore=1015 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404090003

T24gTW9uLCBBcHIgMDgsIDIwMjQsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+IE9uIG11bHRp
cG9ydCBzdXBwb3J0ZWQgY29udHJvbGxlcnMsIGVhY2ggcG9ydCBoYXMgaXRzIG93biBEUC9ETQ0K
PiBhbmQgU1MgKGlmIHN1cGVyIHNwZWVkIGNhcGFibGUpIGludGVycnVwdHMuIEFzIHBlciB0aGUg
YmluZGluZ3MsDQo+IHRoZWlyIGludGVycnVwdCBuYW1lcyBkaWZmZXIgZnJvbSBzdGFuZGFyZCBv
bmVzIGhhdmluZyAiX3giIGFkZGVkDQo+IGFzIHN1ZmZpeCAoeCBpbmRpY2F0ZXMgcG9ydCBudW1i
ZXIpLiBJZGVudGlmeSBmcm9tIHRoZSBpbnRlcnJ1cHQNCj4gbmFtZXMgd2hldGhlciB0aGUgY29u
dHJvbGxlciBpcyBhIG11bHRpcG9ydCBjb250cm9sbGVyIG9yIG5vdC4NCj4gUmVmYWN0b3IgZHdj
M19xY29tX3NldHVwX2lycSgpIGNhbGwgdG8gcGFyc2UgbXVsdGlwb3J0IGludGVycnVwdHMNCj4g
YWxvbmcgd2l0aCBub24tbXVsdGlwb3J0IG9uZXMgYWNjb3JkaW5nbHkuLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogS3Jpc2huYSBLdXJhcGF0aSA8cXVpY19rcmlza3VyYUBxdWljaW5jLmNvbT4NCj4g
UmV2aWV3ZWQtYnk6IEpvaGFuIEhvdm9sZCA8am9oYW4rbGluYXJvQGtlcm5lbC5vcmc+DQo+IC0t
LQ0KPiAgZHJpdmVycy91c2IvZHdjMy9kd2MzLXFjb20uYyB8IDEzNyArKysrKysrKysrKysrKysr
KysrKysrKysrKy0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEwMyBpbnNlcnRpb25zKCsp
LCAzNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2R3
YzMtcWNvbS5jIGIvZHJpdmVycy91c2IvZHdjMy9kd2MzLXFjb20uYw0KPiBpbmRleCBjYWU1ZGFi
OGZjZmMuLjM1ZWIzMzg1MTRiYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9kd2Mz
LXFjb20uYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtcWNvbS5jDQo+IEBAIC01Miw2
ICs1MiwxMyBAQA0KPiAgI2RlZmluZSBBUFBTX1VTQl9BVkdfQlcgMA0KPiAgI2RlZmluZSBBUFBT
X1VTQl9QRUFLX0JXIE1CcHNfdG9faWNjKDQwKQ0KPiAgDQo+ICtzdHJ1Y3QgZHdjM19xY29tX3Bv
cnQgew0KPiArCWludAkJCXF1c2IyX3BoeV9pcnE7DQo+ICsJaW50CQkJZHBfaHNfcGh5X2lycTsN
Cj4gKwlpbnQJCQlkbV9oc19waHlfaXJxOw0KPiArCWludAkJCXNzX3BoeV9pcnE7DQo+ICt9Ow0K
PiArDQo+ICBzdHJ1Y3QgZHdjM19xY29tIHsNCj4gIAlzdHJ1Y3QgZGV2aWNlCQkqZGV2Ow0KPiAg
CXZvaWQgX19pb21lbQkJKnFzY3JhdGNoX2Jhc2U7DQo+IEBAIC01OSwxMSArNjYsOCBAQCBzdHJ1
Y3QgZHdjM19xY29tIHsNCj4gIAlzdHJ1Y3QgY2xrCQkqKmNsa3M7DQo+ICAJaW50CQkJbnVtX2Ns
b2NrczsNCj4gIAlzdHJ1Y3QgcmVzZXRfY29udHJvbAkqcmVzZXRzOw0KPiAtDQo+IC0JaW50CQkJ
cXVzYjJfcGh5X2lycTsNCj4gLQlpbnQJCQlkcF9oc19waHlfaXJxOw0KPiAtCWludAkJCWRtX2hz
X3BoeV9pcnE7DQo+IC0JaW50CQkJc3NfcGh5X2lycTsNCj4gKwlzdHJ1Y3QgZHdjM19xY29tX3Bv
cnQJcG9ydHNbRFdDM19NQVhfUE9SVFNdOw0KPiArCXU4CQkJbnVtX3BvcnRzOw0KPiAgCWVudW0g
dXNiX2RldmljZV9zcGVlZAl1c2IyX3NwZWVkOw0KPiAgDQo+ICAJc3RydWN0IGV4dGNvbl9kZXYJ
KmVkZXY7DQo+IEBAIC0zNTQsMjQgKzM1OCwyNCBAQCBzdGF0aWMgdm9pZCBkd2MzX3Fjb21fZGlz
YWJsZV93YWtldXBfaXJxKGludCBpcnEpDQo+ICANCj4gIHN0YXRpYyB2b2lkIGR3YzNfcWNvbV9k
aXNhYmxlX2ludGVycnVwdHMoc3RydWN0IGR3YzNfcWNvbSAqcWNvbSkNCj4gIHsNCj4gLQlkd2Mz
X3Fjb21fZGlzYWJsZV93YWtldXBfaXJxKHFjb20tPnF1c2IyX3BoeV9pcnEpOw0KPiArCWR3YzNf
cWNvbV9kaXNhYmxlX3dha2V1cF9pcnEocWNvbS0+cG9ydHNbMF0ucXVzYjJfcGh5X2lycSk7DQo+
ICANCj4gIAlpZiAocWNvbS0+dXNiMl9zcGVlZCA9PSBVU0JfU1BFRURfTE9XKSB7DQo+IC0JCWR3
YzNfcWNvbV9kaXNhYmxlX3dha2V1cF9pcnEocWNvbS0+ZG1faHNfcGh5X2lycSk7DQo+ICsJCWR3
YzNfcWNvbV9kaXNhYmxlX3dha2V1cF9pcnEocWNvbS0+cG9ydHNbMF0uZG1faHNfcGh5X2lycSk7
DQo+ICAJfSBlbHNlIGlmICgocWNvbS0+dXNiMl9zcGVlZCA9PSBVU0JfU1BFRURfSElHSCkgfHwN
Cj4gIAkJCShxY29tLT51c2IyX3NwZWVkID09IFVTQl9TUEVFRF9GVUxMKSkgew0KPiAtCQlkd2Mz
X3Fjb21fZGlzYWJsZV93YWtldXBfaXJxKHFjb20tPmRwX2hzX3BoeV9pcnEpOw0KPiArCQlkd2Mz
X3Fjb21fZGlzYWJsZV93YWtldXBfaXJxKHFjb20tPnBvcnRzWzBdLmRwX2hzX3BoeV9pcnEpOw0K
PiAgCX0gZWxzZSB7DQo+IC0JCWR3YzNfcWNvbV9kaXNhYmxlX3dha2V1cF9pcnEocWNvbS0+ZHBf
aHNfcGh5X2lycSk7DQo+IC0JCWR3YzNfcWNvbV9kaXNhYmxlX3dha2V1cF9pcnEocWNvbS0+ZG1f
aHNfcGh5X2lycSk7DQo+ICsJCWR3YzNfcWNvbV9kaXNhYmxlX3dha2V1cF9pcnEocWNvbS0+cG9y
dHNbMF0uZHBfaHNfcGh5X2lycSk7DQo+ICsJCWR3YzNfcWNvbV9kaXNhYmxlX3dha2V1cF9pcnEo
cWNvbS0+cG9ydHNbMF0uZG1faHNfcGh5X2lycSk7DQo+ICAJfQ0KPiAgDQo+IC0JZHdjM19xY29t
X2Rpc2FibGVfd2FrZXVwX2lycShxY29tLT5zc19waHlfaXJxKTsNCj4gKwlkd2MzX3Fjb21fZGlz
YWJsZV93YWtldXBfaXJxKHFjb20tPnBvcnRzWzBdLnNzX3BoeV9pcnEpOw0KPiAgfQ0KPiAgDQo+
ICBzdGF0aWMgdm9pZCBkd2MzX3Fjb21fZW5hYmxlX2ludGVycnVwdHMoc3RydWN0IGR3YzNfcWNv
bSAqcWNvbSkNCj4gIHsNCj4gLQlkd2MzX3Fjb21fZW5hYmxlX3dha2V1cF9pcnEocWNvbS0+cXVz
YjJfcGh5X2lycSwgMCk7DQo+ICsJZHdjM19xY29tX2VuYWJsZV93YWtldXBfaXJxKHFjb20tPnBv
cnRzWzBdLnF1c2IyX3BoeV9pcnEsIDApOw0KPiAgDQo+ICAJLyoNCj4gIAkgKiBDb25maWd1cmUg
RFAvRE0gbGluZSBpbnRlcnJ1cHRzIGJhc2VkIG9uIHRoZSBVU0IyIGRldmljZSBhdHRhY2hlZCB0
bw0KPiBAQCAtMzgzLDIwICszODcsMjAgQEAgc3RhdGljIHZvaWQgZHdjM19xY29tX2VuYWJsZV9p
bnRlcnJ1cHRzKHN0cnVjdCBkd2MzX3Fjb20gKnFjb20pDQo+ICAJICovDQo+ICANCj4gIAlpZiAo
cWNvbS0+dXNiMl9zcGVlZCA9PSBVU0JfU1BFRURfTE9XKSB7DQo+IC0JCWR3YzNfcWNvbV9lbmFi
bGVfd2FrZXVwX2lycShxY29tLT5kbV9oc19waHlfaXJxLA0KPiAtCQkJCQkJSVJRX1RZUEVfRURH
RV9GQUxMSU5HKTsNCj4gKwkJZHdjM19xY29tX2VuYWJsZV93YWtldXBfaXJxKHFjb20tPnBvcnRz
WzBdLmRtX2hzX3BoeV9pcnEsDQo+ICsJCQkJCSAgICBJUlFfVFlQRV9FREdFX0ZBTExJTkcpOw0K
PiAgCX0gZWxzZSBpZiAoKHFjb20tPnVzYjJfc3BlZWQgPT0gVVNCX1NQRUVEX0hJR0gpIHx8DQo+
ICAJCQkocWNvbS0+dXNiMl9zcGVlZCA9PSBVU0JfU1BFRURfRlVMTCkpIHsNCj4gLQkJZHdjM19x
Y29tX2VuYWJsZV93YWtldXBfaXJxKHFjb20tPmRwX2hzX3BoeV9pcnEsDQo+IC0JCQkJCQlJUlFf
VFlQRV9FREdFX0ZBTExJTkcpOw0KPiArCQlkd2MzX3Fjb21fZW5hYmxlX3dha2V1cF9pcnEocWNv
bS0+cG9ydHNbMF0uZHBfaHNfcGh5X2lycSwNCj4gKwkJCQkJICAgIElSUV9UWVBFX0VER0VfRkFM
TElORyk7DQo+ICAJfSBlbHNlIHsNCj4gLQkJZHdjM19xY29tX2VuYWJsZV93YWtldXBfaXJxKHFj
b20tPmRwX2hzX3BoeV9pcnEsDQo+IC0JCQkJCQlJUlFfVFlQRV9FREdFX1JJU0lORyk7DQo+IC0J
CWR3YzNfcWNvbV9lbmFibGVfd2FrZXVwX2lycShxY29tLT5kbV9oc19waHlfaXJxLA0KPiAtCQkJ
CQkJSVJRX1RZUEVfRURHRV9SSVNJTkcpOw0KPiArCQlkd2MzX3Fjb21fZW5hYmxlX3dha2V1cF9p
cnEocWNvbS0+cG9ydHNbMF0uZHBfaHNfcGh5X2lycSwNCj4gKwkJCQkJICAgIElSUV9UWVBFX0VE
R0VfUklTSU5HKTsNCj4gKwkJZHdjM19xY29tX2VuYWJsZV93YWtldXBfaXJxKHFjb20tPnBvcnRz
WzBdLmRtX2hzX3BoeV9pcnEsDQo+ICsJCQkJCSAgICBJUlFfVFlQRV9FREdFX1JJU0lORyk7DQo+
ICAJfQ0KPiAgDQo+IC0JZHdjM19xY29tX2VuYWJsZV93YWtldXBfaXJxKHFjb20tPnNzX3BoeV9p
cnEsIDApOw0KPiArCWR3YzNfcWNvbV9lbmFibGVfd2FrZXVwX2lycShxY29tLT5wb3J0c1swXS5z
c19waHlfaXJxLCAwKTsNCj4gIH0NCj4gIA0KPiAgc3RhdGljIGludCBkd2MzX3Fjb21fc3VzcGVu
ZChzdHJ1Y3QgZHdjM19xY29tICpxY29tLCBib29sIHdha2V1cCkNCj4gQEAgLTUxNyw0MiArNTIx
LDEwNyBAQCBzdGF0aWMgaW50IGR3YzNfcWNvbV9yZXF1ZXN0X2lycShzdHJ1Y3QgZHdjM19xY29t
ICpxY29tLCBpbnQgaXJxLA0KPiAgCXJldHVybiByZXQ7DQo+ICB9DQo+ICANCj4gLXN0YXRpYyBp
bnQgZHdjM19xY29tX3NldHVwX2lycShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAr
c3RhdGljIGludCBkd2MzX3Fjb21fc2V0dXBfcG9ydF9pcnEoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldiwgaW50IHBvcnRfaW5kZXgsIGJvb2wgaXNfbXVsdGlwb3J0KQ0KPiAgew0KPiAgCXN0
cnVjdCBkd2MzX3Fjb20gKnFjb20gPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsNCj4gKwlj
b25zdCBjaGFyICppcnFfbmFtZTsNCj4gIAlpbnQgaXJxOw0KPiAgCWludCByZXQ7DQo+ICANCj4g
LQlpcnEgPSBwbGF0Zm9ybV9nZXRfaXJxX2J5bmFtZV9vcHRpb25hbChwZGV2LCAicXVzYjJfcGh5
Iik7DQo+ICsJaWYgKGlzX211bHRpcG9ydCkNCj4gKwkJaXJxX25hbWUgPSBkZXZtX2thc3ByaW50
ZigmcGRldi0+ZGV2LCBHRlBfS0VSTkVMLCAiZHBfaHNfcGh5XyVkIiwgcG9ydF9pbmRleCArIDEp
Ow0KPiArCWVsc2UNCj4gKwkJaXJxX25hbWUgPSBkZXZtX2thc3ByaW50ZigmcGRldi0+ZGV2LCBH
RlBfS0VSTkVMLCAiZHBfaHNfcGh5X2lycSIpOw0KPiArCWlmICghaXJxX25hbWUpDQo+ICsJCXJl
dHVybiAtRU5PTUVNOw0KPiArDQo+ICsJaXJxID0gcGxhdGZvcm1fZ2V0X2lycV9ieW5hbWVfb3B0
aW9uYWwocGRldiwgaXJxX25hbWUpOw0KPiAgCWlmIChpcnEgPiAwKSB7DQo+IC0JCXJldCA9IGR3
YzNfcWNvbV9yZXF1ZXN0X2lycShxY29tLCBpcnEsICJxdXNiMl9waHkiKTsNCj4gKwkJcmV0ID0g
ZHdjM19xY29tX3JlcXVlc3RfaXJxKHFjb20sIGlycSwgaXJxX25hbWUpOw0KPiAgCQlpZiAocmV0
KQ0KPiAgCQkJcmV0dXJuIHJldDsNCj4gLQkJcWNvbS0+cXVzYjJfcGh5X2lycSA9IGlycTsNCj4g
KwkJcWNvbS0+cG9ydHNbcG9ydF9pbmRleF0uZHBfaHNfcGh5X2lycSA9IGlycTsNCj4gIAl9DQo+
ICANCj4gLQlpcnEgPSBwbGF0Zm9ybV9nZXRfaXJxX2J5bmFtZV9vcHRpb25hbChwZGV2LCAiZHBf
aHNfcGh5X2lycSIpOw0KPiArCWlmIChpc19tdWx0aXBvcnQpDQo+ICsJCWlycV9uYW1lID0gZGV2
bV9rYXNwcmludGYoJnBkZXYtPmRldiwgR0ZQX0tFUk5FTCwgImRtX2hzX3BoeV8lZCIsIHBvcnRf
aW5kZXggKyAxKTsNCj4gKwllbHNlDQo+ICsJCWlycV9uYW1lID0gZGV2bV9rYXNwcmludGYoJnBk
ZXYtPmRldiwgR0ZQX0tFUk5FTCwgImRtX2hzX3BoeV9pcnEiKTsNCj4gKwlpZiAoIWlycV9uYW1l
KQ0KPiArCQlyZXR1cm4gLUVOT01FTTsNCj4gKw0KPiArCWlycSA9IHBsYXRmb3JtX2dldF9pcnFf
YnluYW1lX29wdGlvbmFsKHBkZXYsIGlycV9uYW1lKTsNCj4gIAlpZiAoaXJxID4gMCkgew0KPiAt
CQlyZXQgPSBkd2MzX3Fjb21fcmVxdWVzdF9pcnEocWNvbSwgaXJxLCAiZHBfaHNfcGh5X2lycSIp
Ow0KPiArCQlyZXQgPSBkd2MzX3Fjb21fcmVxdWVzdF9pcnEocWNvbSwgaXJxLCBpcnFfbmFtZSk7
DQo+ICAJCWlmIChyZXQpDQo+ICAJCQlyZXR1cm4gcmV0Ow0KPiAtCQlxY29tLT5kcF9oc19waHlf
aXJxID0gaXJxOw0KPiArCQlxY29tLT5wb3J0c1twb3J0X2luZGV4XS5kbV9oc19waHlfaXJxID0g
aXJxOw0KPiAgCX0NCj4gIA0KPiAtCWlycSA9IHBsYXRmb3JtX2dldF9pcnFfYnluYW1lX29wdGlv
bmFsKHBkZXYsICJkbV9oc19waHlfaXJxIik7DQo+ICsJaWYgKGlzX211bHRpcG9ydCkNCj4gKwkJ
aXJxX25hbWUgPSBkZXZtX2thc3ByaW50ZigmcGRldi0+ZGV2LCBHRlBfS0VSTkVMLCAic3NfcGh5
XyVkIiwgcG9ydF9pbmRleCArIDEpOw0KPiArCWVsc2UNCj4gKwkJaXJxX25hbWUgPSBkZXZtX2th
c3ByaW50ZigmcGRldi0+ZGV2LCBHRlBfS0VSTkVMLCAic3NfcGh5X2lycSIpOw0KPiArCWlmICgh
aXJxX25hbWUpDQo+ICsJCXJldHVybiAtRU5PTUVNOw0KPiArDQo+ICsJaXJxID0gcGxhdGZvcm1f
Z2V0X2lycV9ieW5hbWVfb3B0aW9uYWwocGRldiwgaXJxX25hbWUpOw0KPiAgCWlmIChpcnEgPiAw
KSB7DQo+IC0JCXJldCA9IGR3YzNfcWNvbV9yZXF1ZXN0X2lycShxY29tLCBpcnEsICJkbV9oc19w
aHlfaXJxIik7DQo+ICsJCXJldCA9IGR3YzNfcWNvbV9yZXF1ZXN0X2lycShxY29tLCBpcnEsIGly
cV9uYW1lKTsNCj4gIAkJaWYgKHJldCkNCj4gIAkJCXJldHVybiByZXQ7DQo+IC0JCXFjb20tPmRt
X2hzX3BoeV9pcnEgPSBpcnE7DQo+ICsJCXFjb20tPnBvcnRzW3BvcnRfaW5kZXhdLnNzX3BoeV9p
cnEgPSBpcnE7DQo+ICAJfQ0KPiAgDQo+IC0JaXJxID0gcGxhdGZvcm1fZ2V0X2lycV9ieW5hbWVf
b3B0aW9uYWwocGRldiwgInNzX3BoeV9pcnEiKTsNCj4gKwlpZiAoaXNfbXVsdGlwb3J0KQ0KPiAr
CQlyZXR1cm4gMDsNCj4gKw0KPiArCWlycSA9IHBsYXRmb3JtX2dldF9pcnFfYnluYW1lX29wdGlv
bmFsKHBkZXYsICJxdXNiMl9waHkiKTsNCj4gIAlpZiAoaXJxID4gMCkgew0KPiAtCQlyZXQgPSBk
d2MzX3Fjb21fcmVxdWVzdF9pcnEocWNvbSwgaXJxLCAic3NfcGh5X2lycSIpOw0KPiArCQlyZXQg
PSBkd2MzX3Fjb21fcmVxdWVzdF9pcnEocWNvbSwgaXJxLCAicXVzYjJfcGh5Iik7DQo+ICsJCWlm
IChyZXQpDQo+ICsJCQlyZXR1cm4gcmV0Ow0KPiArCQlxY29tLT5wb3J0c1twb3J0X2luZGV4XS5x
dXNiMl9waHlfaXJxID0gaXJxOw0KPiArCX0NCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiAr
DQo+ICtzdGF0aWMgaW50IGR3YzNfcWNvbV9maW5kX251bV9wb3J0cyhzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KQ0KPiArew0KPiArCWNoYXIgaXJxX25hbWVbMTRdOw0KPiArCWludCBwb3J0
X251bTsNCj4gKwlpbnQgaXJxOw0KPiArDQo+ICsJaXJxID0gcGxhdGZvcm1fZ2V0X2lycV9ieW5h
bWVfb3B0aW9uYWwocGRldiwgImRwX2hzX3BoeV8xIik7DQo+ICsJaWYgKGlycSA8PSAwKQ0KPiAr
CQlyZXR1cm4gMTsNCj4gKw0KPiArCWZvciAocG9ydF9udW0gPSAyOyBwb3J0X251bSA8PSBEV0Mz
X01BWF9QT1JUUzsgcG9ydF9udW0rKykgew0KPiArCQlzcHJpbnRmKGlycV9uYW1lLCAiZHBfaHNf
cGh5XyVkIiwgcG9ydF9udW0pOw0KPiArDQo+ICsJCWlycSA9IHBsYXRmb3JtX2dldF9pcnFfYnlu
YW1lX29wdGlvbmFsKHBkZXYsIGlycV9uYW1lKTsNCj4gKwkJaWYgKGlycSA8PSAwKQ0KPiArCQkJ
cmV0dXJuIHBvcnRfbnVtIC0gMTsNCj4gKwl9DQo+ICsNCj4gKwlyZXR1cm4gRFdDM19NQVhfUE9S
VFM7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgZHdjM19xY29tX3NldHVwX2lycShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiArew0KPiArCXN0cnVjdCBkd2MzX3Fjb20gKnFjb20g
PSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsNCj4gKwlib29sIGlzX211bHRpcG9ydDsNCj4g
KwlpbnQgcmV0Ow0KPiArCWludCBpOw0KPiArDQo+ICsJcWNvbS0+bnVtX3BvcnRzID0gZHdjM19x
Y29tX2ZpbmRfbnVtX3BvcnRzKHBkZXYpOw0KPiArCWlzX211bHRpcG9ydCA9IChxY29tLT5udW1f
cG9ydHMgPiAxKTsNCj4gKw0KPiArCWZvciAoaSA9IDA7IGkgPCBxY29tLT5udW1fcG9ydHM7IGkr
Kykgew0KPiArCQlyZXQgPSBkd2MzX3Fjb21fc2V0dXBfcG9ydF9pcnEocGRldiwgaSwgaXNfbXVs
dGlwb3J0KTsNCj4gIAkJaWYgKHJldCkNCj4gIAkJCXJldHVybiByZXQ7DQo+IC0JCXFjb20tPnNz
X3BoeV9pcnEgPSBpcnE7DQo+ICAJfQ0KPiAgDQo+ICAJcmV0dXJuIDA7DQo+IC0tIA0KPiAyLjM0
LjENCj4gDQoNCkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5j
b20+DQoNClRoYW5rcywNClRoaW5o

