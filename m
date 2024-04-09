Return-Path: <linux-kernel+bounces-136069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6155789CFB6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 845C71C23C08
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62458A951;
	Tue,  9 Apr 2024 01:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="qFsN3J8x";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DWUJjBpA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ZrWClwLz"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B906028F0;
	Tue,  9 Apr 2024 01:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712625403; cv=fail; b=BT7IsqBT/G26EDwDEgXr+UDq5gHC3XvXgbl0bOm+YQVaTE86//2j65MbrDMIsyDEmh+/uVJm/026NmzHVrx5m65viOettRcKj/WK/Z67rLZuodC0w6Jv4dePFnfWBkjSYpP50l/dyQU4V9W1GP08MBfKElj3R2Zl4WTDxhD9Cz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712625403; c=relaxed/simple;
	bh=DONPOUxG9TVidPQocWXwIBErH1lxRQWPTghWhvtkA1A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JqTM2wQURFVSlfOVeTSDCUe1MBSFL1TtvJkTLk98bj8EKyhONcoJiS4ShzGmktnRkp2hXe6pLY/1l0B9bCFnn/ALGrFsdg2awcvs4QULiI9UqPb4/O4rwjm+6978Yi5ByOMUh9wLS0FwE3/v89Yes1onyRTvNJhQJ0pztSw8HQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=qFsN3J8x; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=DWUJjBpA; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ZrWClwLz reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4391GZs0002693;
	Mon, 8 Apr 2024 18:16:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=DONPOUxG9TVidPQocWXwIBErH1lxRQWPTghWhvtkA1A=; b=
	qFsN3J8xTf/qb1tf7ab6ecbQcYnjim6vZPojg8TQmJZLuArdlmzhl1BbZm0o5WOR
	P2+g9RgMswFCrOXsK9QSy3XVMy7wxhnWgVC3G1Yb0CsaLSMZUX4/U+Xu0M0EhUv9
	xCagYk4vcJADmGU1CPMGiu+aCdS7iD2/sCGFSF2NgBuj80cYUm7KIfliaUWx7/xJ
	6kVvYhFFeoKfKBRVIL2gi86d6fFLoiAmFVrdGd5wROJSpRpQYzloKSAKZl2Vytin
	NCQnmfiQQJABOcfcRn1RS8Oh3TnsfuFfFvZuwP65j5WPiQhnqURoWAUJTsBVg0gn
	5MlCIppPz+WGHExAwgi6uA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3xb5n3qbrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 18:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1712625394; bh=DONPOUxG9TVidPQocWXwIBErH1lxRQWPTghWhvtkA1A=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=DWUJjBpAVcKek5YgY6ADexovqD49I95g20gPiZZLZASip6/g0EGbaTmR2XhQW77Jz
	 9r0Aw9O+614Si2whD8B5aqxaW6zwdVfBpgMR0rT9L8n9a75EK81JsqWOF/TKX76QvO
	 KiQDZLHKuySAlYOPv0QLc0BsGDkGQUIAPMwjevvFm+ljjbZxsxt0ILgbrzuO9ZbPf6
	 4uiYM9QbhdFWvycffnQQknWWQmeMgzxg0W4N0DqSjdGoMqN1HD1uKM4yLt0e/RP1Hp
	 3IKv+1XN2/avLL80ITTugUwzmE97pdXOx8327EURqjQMhKphWBa3TN0dCZw7MR5iwE
	 5NO1zYYA6vEyg==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 07410404D1;
	Tue,  9 Apr 2024 01:16:34 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 90418A00AD;
	Tue,  9 Apr 2024 01:16:33 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=ZrWClwLz;
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 160D9400A2;
	Tue,  9 Apr 2024 01:16:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxREj1QYFnUzfGCWWSJjhKWhYHOt7CY8qXNwv5R1qP4dWn+Qb1cJ0O7TiW4K/NyAhvwtzxXwcj9FJ8Wp/H+Lxa7i25GI9FIuEsi+T/pcGwcvvSXAK90f1QMg6/HsNNbk2LnUO34t5kr3y39w7mbhY2uwL8K4GFtlZ92xWHzYDgoHZDHQqKHEKW4D4AB/5h1eJbYnRBROpk3pBKkPb2uq9+NFD2VeZW5mqi9nFOs5qDhJ65I4R/1fm6zwVLvrxfI0RLzNNolZr58xN7Hm0hFDecnBheTazUxTRe9FP5lldvHcrb5vPou5cCCUYa7GHZJ3Q/68ghQietvDkW16Rg/VJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DONPOUxG9TVidPQocWXwIBErH1lxRQWPTghWhvtkA1A=;
 b=U/vlmgcHyevHMNbe/MYsNbcPKs1zini/HnMhiQknSRsgl7PI1O8be2R6XTutVz0ZTg8X+5/RzDAzWVlcz756KUqlvNm8UjFPqfRyyHOKjAfEv4LLZFTS/XciSe4SiOnmRXiHqUqRDV7lQcjJzSd13b6H5tnVXS9c5rZEtDbx9Qjrz0joJ+dzCkF+xXA8s4vZe+CfaDMQshY+fYI4ku1xDnowad+c3XsZJPSnmPHbDxr7ePjKaLJ7i8RUxQRpxYpUkbHwjNIOiqziFgansapgGgz36EiYgEZZJOySBFHgO4VO8u89+H8365QHNb62TmZdXXgAast6TsdpDuRlgEkG0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DONPOUxG9TVidPQocWXwIBErH1lxRQWPTghWhvtkA1A=;
 b=ZrWClwLzlXToRESRVyKtfRK4alNmcmhtNgayFxCOOZYNjKUmYEpDZ7o8dKLK7qMq2W5ECOI/2ryg5mVpddd6T6VEF7zErWuJTbWOkkrKn+B8BD0Jwignc6HmxsLVTt2FuNUp4knb7w8Z/b2xlUeoBLcoc2pEtdD0TrprmMgxJuE=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by IA1PR12MB6233.namprd12.prod.outlook.com (2603:10b6:208:3e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 01:16:30 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c%3]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 01:16:30 +0000
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
Subject: Re: [PATCH v20 8/9] usb: dwc3: qcom: Enable wakeup for applicable
 ports of multiport
Thread-Topic: [PATCH v20 8/9] usb: dwc3: qcom: Enable wakeup for applicable
 ports of multiport
Thread-Index: AQHaibj1PARsKUO4okyBG2nZoa1ucrFfI6WA
Date: Tue, 9 Apr 2024 01:16:30 +0000
Message-ID: <20240409011627.qfh524z7e7ipljop@synopsys.com>
References: <20240408132925.1880571-1-quic_kriskura@quicinc.com>
 <20240408132925.1880571-9-quic_kriskura@quicinc.com>
In-Reply-To: <20240408132925.1880571-9-quic_kriskura@quicinc.com>
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
 wzutqTAMp0zG8SbZ1Ig+aTOaV2CYM4qxYY+8bAqPhtXsvg0f1wqcdXAmxFAZL9lMGEesrqTJSGTunmF50/bpzs46ZSaxz8kH8XBD/1e3XmRIj9U3Kyq9/AS9hkIOUiAnOeZrjFu5eWnIj3IJ+BAq4Y+e5bhrTN7ovOPYVwBc1ZA3M3V2m65lhSzXoaoCPg/jUEIkAzX2DRa0iz1+XAM0rqYwTe4tsUEbCVnKmcAGGZ3yW0coEH2HyiZwu3ujXyCNDNswJibOHd3CCUhl4uYSOfU7TyVXznUHFkAQpcxu4Bil5SpQZ2cFkoUDC6phJ0ILrJvL2QGIl1fkebBCrVcH+yUQlT45WNH83CJS6RsrAluQALsxMbkCPHtV11d3ZofhEgijH7SzG9po5F06k1kU7xFuOghDDJfPeA+1CPPDZAzBhs4laSJx+ul5EaJyVzDGAjqDr5AKnZPXSyIFJiVVx/Lrqw57zpLQARtE4sGHjGFsogprzUP11SuNDyMK8DDQ0ukbiocLnCuhyV785lbFNmmPMhVPeCx/fpfQsuaX2DoHqZ9Za2GtBcxW/6QbCfG0hZoOFdK6O9fKVht9uF/lWmrhvdzFsEIFPbWPlV4RyOSnFSRDmDyxHuWIlKpnT4x+mhG5ydsDx05ocq3iG4FL4Qpx6i7eDnS62V+x65UQP3k=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?S1pkSzRHSTJIWTNrUUc2TjFkWnB2RmV0dVpyOUsrYmZDZSszNXBIYTljRTFD?=
 =?utf-8?B?Y2ZXSkEveVMvYzdRT0t4N2l3d0x2WE9qajNaRk1hRzE4TXJTWmp1NkZkQ0lF?=
 =?utf-8?B?LzBOWGMrdFBleTBGYU0wQmMxbDROaGMzZ0VJVU5rbkQwS1l2eit2Ui9YZUpm?=
 =?utf-8?B?MGd0SDl1SFhyZXFyY1VHSGxHZXErc3dqcHRIUlpzVS9EcklSK0JJVk1LTklH?=
 =?utf-8?B?a0JUdnBLbUR3Y3lKYkRmY1V4ZXZ1MFRtY0hlZDZBRkpKYVV0Y0p1VXNiNjdi?=
 =?utf-8?B?REpNNWxSc1YzTDl3QjhxRXEzeGc2TVVpZUtzcEtld3VDbzQ4dlF2WDk4Vndr?=
 =?utf-8?B?bTNPdGxIR0VKek4zcTJPUmpNcU56aFF3UWxrenNicUNPSmM3bDlPWEtNalJQ?=
 =?utf-8?B?V3d0UEZpTnhQYWlKdWxTWU1PVEtUSHRJbUpqaFBkVDd2SmgyZ3dxNlgvK3ZX?=
 =?utf-8?B?ejB0dWFGS1M5cFlmTWwxUkFRV1NLMXNpc3k0eHVwWUtPUldBN3cyKys1S1NW?=
 =?utf-8?B?OWRKMlRVekhNdlhwVFJUSlYxMXY1OE9Hb2FzWVN0MERWQnpCemMwWkl3R1ZU?=
 =?utf-8?B?NldGNjJvdE9mNUxvUVluUlcwVXdodUMycERhb0ZRRWxYcjZjM3N6bWpNdDBy?=
 =?utf-8?B?TklyajVHajgvOWlyVXRwVTlyUElpcURLNkptVHVqdEJJa0QxMFlETWhvNWw4?=
 =?utf-8?B?cjlNaFB1Z1M3c1ZoVW9LbWhKK2JzV2haY1hqQ3dUbTVrYklrMkxqelpiSTFL?=
 =?utf-8?B?YXY2T3h1ejhRMkJTRXRJNk42L2FwL1MrL01ILzVHNHZKUDBEayttYlhDZ0tR?=
 =?utf-8?B?ZHZoMXFyTDI4NUZwVndCKzJQK2Fhc3F1WVVoK2xDRWY1TnYzbWVqWStuR0pt?=
 =?utf-8?B?V0F6bmRqK2VxT1NydWM4MERCWnJNeEhvK003RldGYzFBNnJWTmR0NVIrdi9h?=
 =?utf-8?B?UWJkMlhaalBPTlBLZk1jQ1orS21tZTRWTzBnVWR2eVU2VSsvbU13TEFtamZS?=
 =?utf-8?B?Tk9yNDYvS0FGZVRhTGVyUFN3ME1tcjdvcXkxWlMrMTdWZDNBMlZpVjRTeGlW?=
 =?utf-8?B?SklrWS9JQkhFMTliY3crUldZV3QySEtuMGtzZUhwSE9STlNQYUdmOTBzY0pr?=
 =?utf-8?B?ck5sU3FTRC9qdFNxU1FCRjVocUlGKzVNZ0xCMlpSTFRVZlhYZ0hFV2V5UGdC?=
 =?utf-8?B?T3YwNU05aXRwNUJxbmtZY04xdGhpK05QdDMraUpjQ05lVXhPbFozS1NZa3Az?=
 =?utf-8?B?VDUxbXduaGJHaHdLNmV3SWwzVXJxdDZvczdnSis2WlJ1NTcyVmxZaUhtVDdZ?=
 =?utf-8?B?T3FXSXZuTFc3UFZyY1g2d3h5UnRvL1hVdkp3UWZNL2JTVGE5M1oyNzU2aUts?=
 =?utf-8?B?Y0t0TWU4YzB2UlMrMjVSZ2tnWjh1WFpmbUdjWk93a3NNWEIxOEo5dWhVOEhQ?=
 =?utf-8?B?SzUvWGpZei9pVS9aU1B6bXJLeldrc1ZnczJJZENoTExxalUrdU9JYTB0VmdZ?=
 =?utf-8?B?d3R6Z0x3ZWhvd1NwMUIreVR2aFRSZnE5QTg5WEh2RXBKQ2JXOXArUC95Skww?=
 =?utf-8?B?d09wNVRqZlJ4UlV2b2E5L1FnT0N5eGFseGpiYVRWQjVnWjhOYjFrWmpIbHYy?=
 =?utf-8?B?cTVWeWp3OFZVb1FqcGdlZ2orV3hyamlhQzRodmE0OGZPVTNWckdaaVVic2Vh?=
 =?utf-8?B?S3ViTUJ2cEhNekVOdXRxY3daUDU4ZitJZzZMT0ZjTklWa09OcnVzSlo4N1Js?=
 =?utf-8?B?NnRXY0N5VVh3ZXNkb2ZHNmozejZlZEVSSERVRnEwOEdnMGRnK1BpZ0tOMDFx?=
 =?utf-8?B?eFFqV0ZHOURlTEpDV0ZMT1cvQVNiOWRXeWRXazRRak1JSCsxUUd2YUVWMnhp?=
 =?utf-8?B?dDRXN3o5WWFIeU5JUlp1OWlKOHUrMU5IL3BKbzFJQ2hkc1FhWXNxQnoyRUJx?=
 =?utf-8?B?K1BzSHpXcllLVm1TSWJIcmtzU1VHQUNmSkxhVGc5anNJOUFpUzBRRC83YmxS?=
 =?utf-8?B?RlIwcnpkYkd6cG9sUldBLzhnSzI0TGpNL2F4cnlVcjBVQXpNbUhnSnJjZTM4?=
 =?utf-8?B?dmlKeHk1VlJ4bGs3QkFDcStnNU15a3czZ0ZEZlFCeXNZMEluZ3VQMk5ENEVV?=
 =?utf-8?B?ay96VDM1Qk1UdkJRdWROWm5ORjg2amY1UTUrdGx3eDNMSUQ0aEg5WTg3aHZL?=
 =?utf-8?B?RXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <77F2F2F8EC33BE45AF6A252C6DB5CA26@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	R09lGZhl+vDIQAiBsH1hIik4PZU8oceWsSuNiR5Dts+1uT5ysww1w2SQ2DALSsD0gdV2b2cJuHG537UEXufu1zu1b1SLD6lyvtWTaGIZyl0QnccMGB7ZiBBVg+wgdmIl5PQpyhCaOBy5+l2/VMiF1rVaZPgxzWyubWMubvFR/PDm5Tg1DtDym7TGbwG79DsUEmo+qp5UxKodFS0YpiIHix/EmoHaprkyDYGUvb9A6g2HHLPvrnlrahQ7TnQj9weFfk8Tba5gnzfCXVSDmnrxYbHfi1S8z55H1dOSc9PyBkDpSmuchL22RGe/ORNsVk7sG+6aQ9q8ghDNx2wOOQcQUR/9cDZLUDu5QKHOWNDgAej5e02iCnmqkgXCjuWh1GgpPjGzVXm0oxwluGRWI0cqJEJX6pXJ7XRnJjXmgkHUMsQ9vvNE75A+GA70cpto5Eqn5+lR/7fiBHPpmet5Cff0GY9zwJczV5QJQyBAdnrwonisjUIS6mm/BtZ/GRmSV+gr6uxkQXgNRCLZy8LEDKxq83SgpkkMJDkNphBJiQVg/5P4OQUANH9L5pBm3KEK1wHNfYQUPgtszcPH7dBvOkvMWWyE5SJmPZ0jlX/HKkpway7QWj3gVNujO+ApXXgaJlbDZkyoAo/pWEhflVl/MYNVTA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bedd708-204e-44b0-f787-08dc5832afe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 01:16:30.1707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ptl2qKTa0T6hyGYwbSy1MZKDCSn7PfvCu11N0VVgNO6PKU7nHC9aR7wTBSXUBfI0kC72G+XCzTBAoOZP2ErZOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6233
X-Proofpoint-GUID: hYCqB8fUARfBw3Hs7aTgx0bD4PMTc28q
X-Proofpoint-ORIG-GUID: hYCqB8fUARfBw3Hs7aTgx0bD4PMTc28q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_19,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404090004

T24gTW9uLCBBcHIgMDgsIDIwMjQsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+IERXQzMgUWNv
bSB3cmFwcGVyIGN1cnJlbnRseSBzdXBwb3J0cyBvbmx5IHdha2V1cCBjb25maWd1cmF0aW9uDQo+
IGZvciBzaW5nbGUgcG9ydCBjb250cm9sbGVycy4gUmVhZCBzcGVlZCBvZiBlYWNoIHBvcnQgY29u
bmVjdGVkDQo+IHRvIHRoZSBjb250cm9sbGVyIGFuZCBlbmFibGUgd2FrZXVwIGZvciBlYWNoIG9m
IHRoZW0gYWNjb3JkaW5nbHkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLcmlzaG5hIEt1cmFwYXRp
IDxxdWljX2tyaXNrdXJhQHF1aWNpbmMuY29tPg0KPiBSZXZpZXdlZC1ieTogSm9oYW4gSG92b2xk
IDxqb2hhbitsaW5hcm9Aa2VybmVsLm9yZz4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2R3
YzMtcWNvbS5jIHwgNzEgKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgNDEgaW5zZXJ0aW9ucygrKSwgMzAgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9kd2MzLXFjb20uYyBiL2RyaXZlcnMvdXNiL2R3
YzMvZHdjMy1xY29tLmMNCj4gaW5kZXggMzVlYjMzODUxNGJjLi4xMjE4MmUwZjhmNDUgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1xY29tLmMNCj4gKysrIGIvZHJpdmVycy91
c2IvZHdjMy9kd2MzLXFjb20uYw0KPiBAQCAtNTcsNiArNTcsNyBAQCBzdHJ1Y3QgZHdjM19xY29t
X3BvcnQgew0KPiAgCWludAkJCWRwX2hzX3BoeV9pcnE7DQo+ICAJaW50CQkJZG1faHNfcGh5X2ly
cTsNCj4gIAlpbnQJCQlzc19waHlfaXJxOw0KPiArCWVudW0gdXNiX2RldmljZV9zcGVlZAl1c2Iy
X3NwZWVkOw0KPiAgfTsNCj4gIA0KPiAgc3RydWN0IGR3YzNfcWNvbSB7DQo+IEBAIC02OCw3ICs2
OSw2IEBAIHN0cnVjdCBkd2MzX3Fjb20gew0KPiAgCXN0cnVjdCByZXNldF9jb250cm9sCSpyZXNl
dHM7DQo+ICAJc3RydWN0IGR3YzNfcWNvbV9wb3J0CXBvcnRzW0RXQzNfTUFYX1BPUlRTXTsNCj4g
IAl1OAkJCW51bV9wb3J0czsNCj4gLQllbnVtIHVzYl9kZXZpY2Vfc3BlZWQJdXNiMl9zcGVlZDsN
Cj4gIA0KPiAgCXN0cnVjdCBleHRjb25fZGV2CSplZGV2Ow0KPiAgCXN0cnVjdCBleHRjb25fZGV2
CSpob3N0X2VkZXY7DQo+IEBAIC0zMDcsNyArMzA3LDcgQEAgc3RhdGljIGJvb2wgZHdjM19xY29t
X2lzX2hvc3Qoc3RydWN0IGR3YzNfcWNvbSAqcWNvbSkNCj4gIAlyZXR1cm4gZHdjLT54aGNpOw0K
PiAgfQ0KPiAgDQo+IC1zdGF0aWMgZW51bSB1c2JfZGV2aWNlX3NwZWVkIGR3YzNfcWNvbV9yZWFk
X3VzYjJfc3BlZWQoc3RydWN0IGR3YzNfcWNvbSAqcWNvbSkNCj4gK3N0YXRpYyBlbnVtIHVzYl9k
ZXZpY2Vfc3BlZWQgZHdjM19xY29tX3JlYWRfdXNiMl9zcGVlZChzdHJ1Y3QgZHdjM19xY29tICpx
Y29tLCBpbnQgcG9ydF9pbmRleCkNCj4gIHsNCj4gIAlzdHJ1Y3QgZHdjMyAqZHdjID0gcGxhdGZv
cm1fZ2V0X2RydmRhdGEocWNvbS0+ZHdjMyk7DQo+ICAJc3RydWN0IHVzYl9kZXZpY2UgKnVkZXY7
DQo+IEBAIC0zMTgsMTQgKzMxOCw4IEBAIHN0YXRpYyBlbnVtIHVzYl9kZXZpY2Vfc3BlZWQgZHdj
M19xY29tX3JlYWRfdXNiMl9zcGVlZChzdHJ1Y3QgZHdjM19xY29tICpxY29tKQ0KPiAgCSAqLw0K
PiAgCWhjZCA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKGR3Yy0+eGhjaSk7DQo+ICANCj4gLQkvKg0K
PiAtCSAqIEl0IGlzIHBvc3NpYmxlIHRvIHF1ZXJ5IHRoZSBzcGVlZCBvZiBhbGwgY2hpbGRyZW4g
b2YNCj4gLQkgKiBVU0IyLjAgcm9vdCBodWIgdmlhIHVzYl9odWJfZm9yX2VhY2hfY2hpbGQoKS4g
RFdDMyBjb2RlDQo+IC0JICogY3VycmVudGx5IHN1cHBvcnRzIG9ubHkgMSBwb3J0IHBlciBjb250
cm9sbGVyLiBTbw0KPiAtCSAqIHRoaXMgaXMgc3VmZmljaWVudC4NCj4gLQkgKi8NCj4gICNpZmRl
ZiBDT05GSUdfVVNCDQo+IC0JdWRldiA9IHVzYl9odWJfZmluZF9jaGlsZChoY2QtPnNlbGYucm9v
dF9odWIsIDEpOw0KPiArCXVkZXYgPSB1c2JfaHViX2ZpbmRfY2hpbGQoaGNkLT5zZWxmLnJvb3Rf
aHViLCBwb3J0X2luZGV4ICsgMSk7DQo+ICAjZWxzZQ0KPiAgCXVkZXYgPSBOVUxMOw0KPiAgI2Vu
ZGlmDQo+IEBAIC0zNTYsMjYgKzM1MCwyNiBAQCBzdGF0aWMgdm9pZCBkd2MzX3Fjb21fZGlzYWJs
ZV93YWtldXBfaXJxKGludCBpcnEpDQo+ICAJZGlzYWJsZV9pcnFfbm9zeW5jKGlycSk7DQo+ICB9
DQo+ICANCj4gLXN0YXRpYyB2b2lkIGR3YzNfcWNvbV9kaXNhYmxlX2ludGVycnVwdHMoc3RydWN0
IGR3YzNfcWNvbSAqcWNvbSkNCj4gK3N0YXRpYyB2b2lkIGR3YzNfcWNvbV9kaXNhYmxlX3BvcnRf
aW50ZXJydXB0cyhzdHJ1Y3QgZHdjM19xY29tX3BvcnQgKnBvcnQpDQo+ICB7DQo+IC0JZHdjM19x
Y29tX2Rpc2FibGVfd2FrZXVwX2lycShxY29tLT5wb3J0c1swXS5xdXNiMl9waHlfaXJxKTsNCj4g
Kwlkd2MzX3Fjb21fZGlzYWJsZV93YWtldXBfaXJxKHBvcnQtPnF1c2IyX3BoeV9pcnEpOw0KPiAg
DQo+IC0JaWYgKHFjb20tPnVzYjJfc3BlZWQgPT0gVVNCX1NQRUVEX0xPVykgew0KPiAtCQlkd2Mz
X3Fjb21fZGlzYWJsZV93YWtldXBfaXJxKHFjb20tPnBvcnRzWzBdLmRtX2hzX3BoeV9pcnEpOw0K
PiAtCX0gZWxzZSBpZiAoKHFjb20tPnVzYjJfc3BlZWQgPT0gVVNCX1NQRUVEX0hJR0gpIHx8DQo+
IC0JCQkocWNvbS0+dXNiMl9zcGVlZCA9PSBVU0JfU1BFRURfRlVMTCkpIHsNCj4gLQkJZHdjM19x
Y29tX2Rpc2FibGVfd2FrZXVwX2lycShxY29tLT5wb3J0c1swXS5kcF9oc19waHlfaXJxKTsNCj4g
KwlpZiAocG9ydC0+dXNiMl9zcGVlZCA9PSBVU0JfU1BFRURfTE9XKSB7DQo+ICsJCWR3YzNfcWNv
bV9kaXNhYmxlX3dha2V1cF9pcnEocG9ydC0+ZG1faHNfcGh5X2lycSk7DQo+ICsJfSBlbHNlIGlm
ICgocG9ydC0+dXNiMl9zcGVlZCA9PSBVU0JfU1BFRURfSElHSCkgfHwNCj4gKwkJCShwb3J0LT51
c2IyX3NwZWVkID09IFVTQl9TUEVFRF9GVUxMKSkgew0KPiArCQlkd2MzX3Fjb21fZGlzYWJsZV93
YWtldXBfaXJxKHBvcnQtPmRwX2hzX3BoeV9pcnEpOw0KPiAgCX0gZWxzZSB7DQo+IC0JCWR3YzNf
cWNvbV9kaXNhYmxlX3dha2V1cF9pcnEocWNvbS0+cG9ydHNbMF0uZHBfaHNfcGh5X2lycSk7DQo+
IC0JCWR3YzNfcWNvbV9kaXNhYmxlX3dha2V1cF9pcnEocWNvbS0+cG9ydHNbMF0uZG1faHNfcGh5
X2lycSk7DQo+ICsJCWR3YzNfcWNvbV9kaXNhYmxlX3dha2V1cF9pcnEocG9ydC0+ZHBfaHNfcGh5
X2lycSk7DQo+ICsJCWR3YzNfcWNvbV9kaXNhYmxlX3dha2V1cF9pcnEocG9ydC0+ZG1faHNfcGh5
X2lycSk7DQo+ICAJfQ0KPiAgDQo+IC0JZHdjM19xY29tX2Rpc2FibGVfd2FrZXVwX2lycShxY29t
LT5wb3J0c1swXS5zc19waHlfaXJxKTsNCj4gKwlkd2MzX3Fjb21fZGlzYWJsZV93YWtldXBfaXJx
KHBvcnQtPnNzX3BoeV9pcnEpOw0KPiAgfQ0KPiAgDQo+IC1zdGF0aWMgdm9pZCBkd2MzX3Fjb21f
ZW5hYmxlX2ludGVycnVwdHMoc3RydWN0IGR3YzNfcWNvbSAqcWNvbSkNCj4gK3N0YXRpYyB2b2lk
IGR3YzNfcWNvbV9lbmFibGVfcG9ydF9pbnRlcnJ1cHRzKHN0cnVjdCBkd2MzX3Fjb21fcG9ydCAq
cG9ydCkNCj4gIHsNCj4gLQlkd2MzX3Fjb21fZW5hYmxlX3dha2V1cF9pcnEocWNvbS0+cG9ydHNb
MF0ucXVzYjJfcGh5X2lycSwgMCk7DQo+ICsJZHdjM19xY29tX2VuYWJsZV93YWtldXBfaXJxKHBv
cnQtPnF1c2IyX3BoeV9pcnEsIDApOw0KPiAgDQo+ICAJLyoNCj4gIAkgKiBDb25maWd1cmUgRFAv
RE0gbGluZSBpbnRlcnJ1cHRzIGJhc2VkIG9uIHRoZSBVU0IyIGRldmljZSBhdHRhY2hlZCB0bw0K
PiBAQCAtMzg2LDIxICszODAsMzcgQEAgc3RhdGljIHZvaWQgZHdjM19xY29tX2VuYWJsZV9pbnRl
cnJ1cHRzKHN0cnVjdCBkd2MzX3Fjb20gKnFjb20pDQo+ICAJICogRFAgYW5kIERNIGxpbmVzIGFz
IHJpc2luZyBlZGdlIHRvIGRldGVjdCBIUy9IUy9MUyBkZXZpY2UgY29ubmVjdCBzY2VuYXJpby4N
Cj4gIAkgKi8NCj4gIA0KPiAtCWlmIChxY29tLT51c2IyX3NwZWVkID09IFVTQl9TUEVFRF9MT1cp
IHsNCj4gLQkJZHdjM19xY29tX2VuYWJsZV93YWtldXBfaXJxKHFjb20tPnBvcnRzWzBdLmRtX2hz
X3BoeV9pcnEsDQo+ICsJaWYgKHBvcnQtPnVzYjJfc3BlZWQgPT0gVVNCX1NQRUVEX0xPVykgew0K
PiArCQlkd2MzX3Fjb21fZW5hYmxlX3dha2V1cF9pcnEocG9ydC0+ZG1faHNfcGh5X2lycSwNCj4g
IAkJCQkJICAgIElSUV9UWVBFX0VER0VfRkFMTElORyk7DQo+IC0JfSBlbHNlIGlmICgocWNvbS0+
dXNiMl9zcGVlZCA9PSBVU0JfU1BFRURfSElHSCkgfHwNCj4gLQkJCShxY29tLT51c2IyX3NwZWVk
ID09IFVTQl9TUEVFRF9GVUxMKSkgew0KPiAtCQlkd2MzX3Fjb21fZW5hYmxlX3dha2V1cF9pcnEo
cWNvbS0+cG9ydHNbMF0uZHBfaHNfcGh5X2lycSwNCj4gKwl9IGVsc2UgaWYgKChwb3J0LT51c2Iy
X3NwZWVkID09IFVTQl9TUEVFRF9ISUdIKSB8fA0KPiArCQkJKHBvcnQtPnVzYjJfc3BlZWQgPT0g
VVNCX1NQRUVEX0ZVTEwpKSB7DQo+ICsJCWR3YzNfcWNvbV9lbmFibGVfd2FrZXVwX2lycShwb3J0
LT5kcF9oc19waHlfaXJxLA0KPiAgCQkJCQkgICAgSVJRX1RZUEVfRURHRV9GQUxMSU5HKTsNCj4g
IAl9IGVsc2Ugew0KPiAtCQlkd2MzX3Fjb21fZW5hYmxlX3dha2V1cF9pcnEocWNvbS0+cG9ydHNb
MF0uZHBfaHNfcGh5X2lycSwNCj4gKwkJZHdjM19xY29tX2VuYWJsZV93YWtldXBfaXJxKHBvcnQt
PmRwX2hzX3BoeV9pcnEsDQo+ICAJCQkJCSAgICBJUlFfVFlQRV9FREdFX1JJU0lORyk7DQo+IC0J
CWR3YzNfcWNvbV9lbmFibGVfd2FrZXVwX2lycShxY29tLT5wb3J0c1swXS5kbV9oc19waHlfaXJx
LA0KPiArCQlkd2MzX3Fjb21fZW5hYmxlX3dha2V1cF9pcnEocG9ydC0+ZG1faHNfcGh5X2lycSwN
Cj4gIAkJCQkJICAgIElSUV9UWVBFX0VER0VfUklTSU5HKTsNCj4gIAl9DQo+ICANCj4gLQlkd2Mz
X3Fjb21fZW5hYmxlX3dha2V1cF9pcnEocWNvbS0+cG9ydHNbMF0uc3NfcGh5X2lycSwgMCk7DQo+
ICsJZHdjM19xY29tX2VuYWJsZV93YWtldXBfaXJxKHBvcnQtPnNzX3BoeV9pcnEsIDApOw0KPiAr
fQ0KPiArDQo+ICtzdGF0aWMgdm9pZCBkd2MzX3Fjb21fZGlzYWJsZV9pbnRlcnJ1cHRzKHN0cnVj
dCBkd2MzX3Fjb20gKnFjb20pDQo+ICt7DQo+ICsJaW50IGk7DQo+ICsNCj4gKwlmb3IgKGkgPSAw
OyBpIDwgcWNvbS0+bnVtX3BvcnRzOyBpKyspDQo+ICsJCWR3YzNfcWNvbV9kaXNhYmxlX3BvcnRf
aW50ZXJydXB0cygmcWNvbS0+cG9ydHNbaV0pOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCBk
d2MzX3Fjb21fZW5hYmxlX2ludGVycnVwdHMoc3RydWN0IGR3YzNfcWNvbSAqcWNvbSkNCj4gK3sN
Cj4gKwlpbnQgaTsNCj4gKw0KPiArCWZvciAoaSA9IDA7IGkgPCBxY29tLT5udW1fcG9ydHM7IGkr
KykNCj4gKwkJZHdjM19xY29tX2VuYWJsZV9wb3J0X2ludGVycnVwdHMoJnFjb20tPnBvcnRzW2ld
KTsNCj4gIH0NCj4gIA0KPiAgc3RhdGljIGludCBkd2MzX3Fjb21fc3VzcGVuZChzdHJ1Y3QgZHdj
M19xY29tICpxY29tLCBib29sIHdha2V1cCkNCj4gQEAgLTQyNyw3ICs0MzcsOCBAQCBzdGF0aWMg
aW50IGR3YzNfcWNvbV9zdXNwZW5kKHN0cnVjdCBkd2MzX3Fjb20gKnFjb20sIGJvb2wgd2FrZXVw
KQ0KPiAgCSAqIGZyZWV6YWJsZSB3b3JrcXVldWUuDQo+ICAJICovDQo+ICAJaWYgKGR3YzNfcWNv
bV9pc19ob3N0KHFjb20pICYmIHdha2V1cCkgew0KPiAtCQlxY29tLT51c2IyX3NwZWVkID0gZHdj
M19xY29tX3JlYWRfdXNiMl9zcGVlZChxY29tKTsNCj4gKwkJZm9yIChpID0gMDsgaSA8IHFjb20t
Pm51bV9wb3J0czsgaSsrKQ0KPiArCQkJcWNvbS0+cG9ydHNbaV0udXNiMl9zcGVlZCA9IGR3YzNf
cWNvbV9yZWFkX3VzYjJfc3BlZWQocWNvbSwgaSk7DQo+ICAJCWR3YzNfcWNvbV9lbmFibGVfaW50
ZXJydXB0cyhxY29tKTsNCj4gIAl9DQo+ICANCj4gLS0gDQo+IDIuMzQuMQ0KPiANCg0KQWNrZWQt
Ynk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCg0KVGhhbmtzLA0K
VGhpbmg=

