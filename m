Return-Path: <linux-kernel+bounces-58875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DBA84EDFA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1791C1C2470A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E596050A7B;
	Thu,  8 Feb 2024 23:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="bvEF8IE0";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="fwocN1Gf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Y4ciRjr8"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A864F8AA;
	Thu,  8 Feb 2024 23:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707435769; cv=fail; b=ZZyZbRfoyba1QegD+nBW2H+YcASV2nYeSzePbEOodtQdlbTn92tpNe1IVa54bsP0vYI5POz6qt7zBhxHoCDee7XDjcn6icnKTMrhzxh29XAiz/UBsFYxdAumEctsOF8YG5Kf90FXqVzhq/gvzm4Z6a32lmKlqyoNVqsLXreoLlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707435769; c=relaxed/simple;
	bh=zbcJPcW0Tifw+x68r59dtGlCeQo9KdK1rPdxsIy3+OY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pw4EyIZIYW/rqZk0HNJw0bBTuYr5jWVOuJsOc9owHt3ziLVZ56Nv5qibhqVbhkeSJEygqgrt3zyrCOcGfbGmDxuOO9ZtEdkyVJnsFpp1qx5qK91ZCWWw3xDYiEeiEG5slo6pT1Cp03VUsZxJix6FwuGmsVows5uPXJsDkYvcO8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=bvEF8IE0; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=fwocN1Gf; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Y4ciRjr8 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 418NBBJM014939;
	Thu, 8 Feb 2024 15:42:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=zbcJPcW0Tifw+x68r59dtGlCeQo9KdK1rPdxsIy3+OY=; b=
	bvEF8IE0h5y3lyceCiyyYjXIAz+FatvN67Uqt1WkxjbF3SI1w3wbaIsisfBuPz75
	E0/27HMaAQQ/VRa8muWKuROsk4NliuO1I2pSxqNDhQ8XZgdpJv8TqZIyZBL/t3TH
	GBxUzFJI/tnvxDtWpsE8ekksxXpMjWomiAy9hd4G/XHd0qAmC3MNQLTDHzpocEYF
	peC7VXN+JQsN5r8BQRwKUgkHJwmc2FNKRnOAbPs4CwDT7wup5wqr+n/8qmu1gsV/
	1lOIa+UzpgTctIF5Fpc95201UuUw0H9TlmB2ZQkijYP5I7oWVsoan4ANc22MXd5o
	BGOhmKu1aO0bEDrQsq8yXQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3w1ncps5g4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 15:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1707435754; bh=zbcJPcW0Tifw+x68r59dtGlCeQo9KdK1rPdxsIy3+OY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=fwocN1Gfvs+UXc7RwGOI7yVWuIPS1YiWChR2r88uyjpJifUVFFC3LTOSf+kLuIMRu
	 OntlyepZ7TBrBkmzzfiYvUJTdeA8hY/wuRsnpEH/mO/iN6XlgYP4rhC1JmpFFMpiNd
	 qnWvPIZyVduXeDZu99RPS0FT4LWqD5JXqQsG/Ax/KDoiP5OCRRec0vx9e6hpTmDGyZ
	 Pp+tw6NQaYvbdnvczHyySbX8SWnI2WdAc+O59oijkbdB0dQ5ZBGKljFDMR78Gty0WK
	 80J7x3VMp1meralDWMI6k7obrL8AnC5KMnvq8Vh5Rfk7YPJkNxxaxgeLtDE5+Kysu0
	 uJroMWkSNfAoQ==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6D7E04035E;
	Thu,  8 Feb 2024 23:42:34 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id C1239A0096;
	Thu,  8 Feb 2024 23:42:33 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Y4ciRjr8;
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 72802404D5;
	Thu,  8 Feb 2024 23:42:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJcVJH2SZFaa3KOpjqBVRYLayflvkEpIVee517cFVQLWBMD3d7k3qn6F6G597RcvobthdI1Tyj/hMFz73EHZrfER/Rjg/NO+H8H3HWKk7bQd7hm6IWMxtme/IhKyBgUpmyMYmiaqjGBpue8ERKO7lGZvqEDCBv3CHyEhgsp/kwyJG08t0Y2NkrcL03XAY2oETXh3UplDMjfUgOr3iDWKGJq8JO/DfTd4OF+osy+efx2LR1RFYsZ5IjqCzQUzX/J9hLqoymIWrLcOANyACi6YMRDxJEVyuGVGJFN08n0T9c072OsxnLlynrv6PyM1SJdKiY6Eq7HVCUMHLkTHXvVzOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbcJPcW0Tifw+x68r59dtGlCeQo9KdK1rPdxsIy3+OY=;
 b=Ms6te9CO77tDUlF6L6wxZ507RusUMy3dcxtpaKXOfw8urKe+O9TjoAyPdB2f8EhHK7g5uibchgr1C/8IUpgov+JA2oBDIEune5rTRssiUYGdsDWgrMB9O/OG78dSM6oXEc81sOV+W4et3Mw+D9La8Cp9XaaRA4ldrY42U9iJk2KnJhyTxHKIQ0lCUO7uEDM4GORKDLDnzwt8LQhOMcQEpBC3pJUKV8/fBU2o5tbDfialh0MPLgTVrm8s5bbJbXuH7xN8GNCbVEWRIXKFC5m5+odEjhMYGoLw1TdFl+ydxO28f9+ug7Fwm4p97eKWxZAyMWGo6gOL4SHzHHXLEHlTLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbcJPcW0Tifw+x68r59dtGlCeQo9KdK1rPdxsIy3+OY=;
 b=Y4ciRjr852oWkJdNc6fQ8c2IZbGazaNI3ZO7AS9R//x0EbGY8Z6RlzjuMWtD9sc9EQldIImoR1e90RBtjwRqKzZDGIC3gVOHd78ENCm/KmaSCsihRjgxpnogYTZnHomVWhOcorESczMi0ysjwPblwOYDd8Lqq7h9agXkNz0vHh4=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by BY5PR12MB4275.namprd12.prod.outlook.com (2603:10b6:a03:20a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.12; Thu, 8 Feb
 2024 23:42:28 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3%3]) with mapi id 15.20.7270.009; Thu, 8 Feb 2024
 23:42:28 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v14 2/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Thread-Topic: [PATCH v14 2/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Thread-Index: AQHaWLwAq9n9dZO5RkmsM1wpNgusvrEBH1IA
Date: Thu, 8 Feb 2024 23:42:27 +0000
Message-ID: <20240208234154.6jq2oah6ondn3jlq@synopsys.com>
References: <20240206051825.1038685-1-quic_kriskura@quicinc.com>
 <20240206051825.1038685-3-quic_kriskura@quicinc.com>
In-Reply-To: <20240206051825.1038685-3-quic_kriskura@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|BY5PR12MB4275:EE_
x-ms-office365-filtering-correlation-id: c581b0a5-6272-4fe4-fe06-08dc28ff9c0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 vX849riDU+ny6res/6gZ/8bBtfigJUleIofbOiVV3TmckLNL8tstv/vfYiet1kTKvM3amsQSSGK1WyDDXFCnhF4/kpvvETrL0WRcshyXxDs55YUSGHOi3z7IaLmnEuMhrI6zIBxBafMy+XSFQOgRx4vBaa8TPyEmdMqLxYEUXoyIkESNEFryLrs65gAoeMkIukmHgw+RKWWFJSDGXDBWPRhx6VC4qJz8Uiw4MAdPpVTaZzHjZUDY7jXXE7d6kIZcajSPK/gMtzhYJ1d9RQ7A2NKu7JhsV0RmHtfHu4oE5eEeSs8DDVrY/9LZLTcJE+FuAVrRo1dYKtfWUcylIegYhfNpE6WQWX3q+pffs+ypwZjhXFDON2jKzx3J7r1SHD7toyVEcP3eoWxI0Ryb11XL5znjAXogtAtZpynMLEFoX13k2tyuRlWMEOBWJlhG0ABk2B8DXjfd68cd+fQ7oKRAY6DTr22gv7VYtqlY+otg996EP+tatNTDxA89eUkUlIcAjraqYf9fbOeYCuBpsu0XWNx/UHuT5dZv8jhsXOyKcKiMtxAcr9nA/1vkPrip0bUu4eci1w/qb73Ae/N44WGPY+9mgy0Aue7Z4YOzTy0//5R2hruaLKmFnNS3YZXaukb2
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39850400004)(376002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(38070700009)(66476007)(6916009)(66556008)(66446008)(54906003)(64756008)(76116006)(36756003)(66946007)(316002)(4326008)(8676002)(5660300002)(7416002)(8936002)(2906002)(83380400001)(122000001)(38100700002)(6506007)(71200400001)(478600001)(6512007)(86362001)(2616005)(1076003)(6486002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eGZQejZnZmJuTmpxWk14V2FFLzVMWmpZNHV2QXVib0MzdVROZjZwUkpYK0VZ?=
 =?utf-8?B?ckY3VXk3U2kzaFVoQ1RsMlJpSm1mR2dSd2RHd3JQcjBWQUdDMGRWbE16a3dT?=
 =?utf-8?B?YXdVRFR4OTBmdWtJN0RuZXh5d0NmRzJFcVRxQ0k5Wm1sWFlhNEtaK0NNUXRY?=
 =?utf-8?B?S01vSkU5U1hFRFlMMy9UdG1mSUxhTytLeFM3MGJ3RUs4Q1hrQithOXkwVldp?=
 =?utf-8?B?b2hNMDFScU1IYkNQZkhjT1RRa2JwTW1aK3hnMTZ3a21JaDRhVTVTTFVBQ2h1?=
 =?utf-8?B?b3RtSXZ2d3BBS2c3bkFNUGkwK2hoOGxlMmNQRHpkWDc4TmFzTGluOWVRd3Ra?=
 =?utf-8?B?RHZlWnlTbjY5SXpCRElSK3FVNTFZbkZMVmFuMDlQb2g5OGJFOU40TkFTRkhy?=
 =?utf-8?B?Ui9Db1pMSEFlaGc2YnNOMzJEdVNody9hUHhQZk15QWpoV1kvVk1qc2tGUCtN?=
 =?utf-8?B?ODQ5ZzN2c1NUaW54eTRDajU4dnRaT0pjdVNjQ01WcWtPVUQ3VE5pUXlYb3FK?=
 =?utf-8?B?ckx1b0FPWmVvdGROdGxlR2xnUS9VTUVxUjJjZnJrU1RXWGpLbzBFcXlWZmUx?=
 =?utf-8?B?T011TkYyYW9YZDNXd0trSTdnYnVrNmpoSmFBeTdRejl4RWJ6SndMU0x5ZkVP?=
 =?utf-8?B?UWVLQ3VBRzlSTVk5c1lEYzBDaDhiVm1PUFp1UUI3d1FDRXJ4NW91QmlrTm5N?=
 =?utf-8?B?RkcxdjRYWmRXSllFdEVVVUZ5ZE9EZFhOY2ZVRUMyS29jVTVCZEVCWUpORncx?=
 =?utf-8?B?dkRqNFFFZ05hVzR0RFE5TnBvZWhEQkI5bnlkSGJodmNBTXdnQVFRR1hPRU5Y?=
 =?utf-8?B?TXhBeFkxOG1UVVhGK3NuYitPL0ZzaVg0bldVRWcvYkJWUUlNcXVEejNQb3A2?=
 =?utf-8?B?RmtLNlBJUmZJd1h6V1llRU5lc0JpWkFRcHYvRjFuenRrYVFYY3pBNU9Vckds?=
 =?utf-8?B?Yjg1NVdTVjhPb085T2dGcnJiZmJuMUQ0Z1A0Z3NraHJlM1A3TUh5ekFCU0Iy?=
 =?utf-8?B?eE1kVjdYTmdpUHcwSEQvcWpaMGNBdEg4VGU0eElwSFAvblkyQjRzeTFlVGc0?=
 =?utf-8?B?NFFUYlFWTy9vWnhtVm1QdmhZT0JXeUttWDJocDdVckpxT0VENmppOURRUGhC?=
 =?utf-8?B?cHJFdFpveEhwaTZLWXlpMXByVDdQRTJXQmFzYkJsVU9COGV4enNvbmJ5MjJR?=
 =?utf-8?B?bmdOc283SDV5ZUlDd2pMY2JQMVVhUkRYZ29HYUNrZC85TEI2MUVqM05YK0Vv?=
 =?utf-8?B?bEJxV1dXZ3NSVVcwajdzbUJHeEZiMW1hVXpMZlpKWUFESXhDbm5OdXJ3aTZ5?=
 =?utf-8?B?L3VpaFVseGlHVVd3bnZEaVRLTDQrZCt4dmswMGZCeHhkVm1qMS9BVFkyREhF?=
 =?utf-8?B?d2FOYkJrN0VzcjJVV05Fa0Y0MjdtTGUvVzZHNEtHSDZXWDltOXFQRVhtQUkr?=
 =?utf-8?B?VFVaOThYN3RRL2I5VGJvamNIMG14OTR1emUyTTlrTldoOTQrWC9pSThCVU5Q?=
 =?utf-8?B?MWlGVmkzeklLNkRLaG9LMzZOejQ1Z0J5K1RXVWZUY2JreGJ1Ynh3TDd1akN1?=
 =?utf-8?B?bnZvOVA2Tkl6N0JLczNGOGJEbVUxTUdZS3VWdlJXVVdaR2xhL2FYQjJpeTlG?=
 =?utf-8?B?WFVvZHVMTlBqNWM1SUk2blMwNm5LY3Y4TE5TTk40SVBMRUFGT1d5SkwwOUp6?=
 =?utf-8?B?NVorV1A5eUR4TS8zeXpRYmQ5bXVSeWl6ZEVlK21TZkh0Z0tBVUlXNXFUMkdi?=
 =?utf-8?B?ZU9PVS8zaFp5ZTdvamIxVVp6Wnl2Z0g3SzJzamhJQ3BNUW1pVGt3THRIUndP?=
 =?utf-8?B?dGtSYnRFNVcwdk91SmQ4b0d4UENsZlJDWjRCSFJVZFFmRVVLdERWMmJHa2dX?=
 =?utf-8?B?d011VHh3WVJVOEprbytvdTZiZGNIazV6WGd0QTRqOU91eHlpVmtmOVdCcXVT?=
 =?utf-8?B?b2JzUkdkb25rYXBWTDVIdmhxRjJ0Uk1tR3BhdHY4bk05NUFKTUJ0c0FUYW1W?=
 =?utf-8?B?Vkx1ekRsQnJVdGFZbDMzMEJoNmJqVDJBcDBlZzFKQzk4dEtiZDRIMmpIdDZI?=
 =?utf-8?B?SXZlNGhFczVTZzl6KzladERETHR0Zmw3VXQrUUVLY0krTkRSQWVRTVFwa0Ru?=
 =?utf-8?Q?k9jFkZmgxvKDVC1fl4NdpMk8Q?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0602C846F09C4741B2562AC16633D1D7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	OnBekODAFVc+EyE2GdvQ0EHWDGay3PUHMDimnDnLi91UD9hXc1SawzKps0lA+TtkNLILtmDwP82mIgHVySiGH5p3P1BM03dlUAd/ut9ZNFDnK8dzWKxcHt1cVVhpFuRtcKReBsysaUOPtPMeTw4D4mndTfqlLIdp+yLl/Pol6gE6AUIRAbExTYNcZzeSObDwAdFLCwUrXmUI9Ex3JVy0RHZ5nIkjbipYjSsx84biz/svaHl/Hul9UVq1OMxo9h9YfArhJ/3D7XAAocJ0ydjQ2c78ochoVRJYU7v8cdIqLHsvXG+G8dMe+CJ2NH2Y1puip4ru9qNJ5VDBQN5WnlabXwhQNIMxgHGvrKamn4MKkjQ59mcEzYv5GU5H+0pXn5mZblo6xjVPmifOizm4/ZG8eux4S8IiOTV5fT96gPnRmnc2Za+jDY4VzKu8CR7tTkOCglnXzSWyd75qR4riIuGfNrRfZFiSng/1bH1klkJe/2gOlDxy81aShKZzPqy6ks/2eGGbmE3kmSv/vND7ayBalonO96pl54OOiReZk+/LiYmOZhISBP/tpCZftv7A2Z3NRchl/OpRZsKnfj6sZESNOYXVpXk6mkFJuc7Q56qksaYY0HGQQID8JTo1CoduLF8rEONdbu4R/xGvj4wqWu4qAw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c581b0a5-6272-4fe4-fe06-08dc28ff9c0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 23:42:27.9568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dfrAdqKf7xYxlONqzfT7EEXjSBoHrWPxhcntkaD96nUvmDv+MTG5mjobfxQx6S/AK8pwbHGhxaj8oowmrUth8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4275
X-Proofpoint-GUID: H-vpRSORLiBFGgLO0cv6OR06LmbGqNNc
X-Proofpoint-ORIG-GUID: H-vpRSORLiBFGgLO0cv6OR06LmbGqNNc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_12,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1011 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402080135

T24gVHVlLCBGZWIgMDYsIDIwMjQsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+IEN1cnJlbnRs
eSBNdWx0aXBvcnQgRFdDMyBjb250cm9sbGVycyBhcmUgaG9zdC1vbmx5IGNhcGFibGUuDQo+IFRl
bXBvcmFyaWx5IG1hcCBYSENJIGFkZHJlc3Mgc3BhY2UgZm9yIGhvc3Qtb25seSBjb250cm9sbGVy
cyBhbmQgcGFyc2UNCj4gWEhDSSBFeHRlbmRlZCBDYXBhYmlsaXRpZXMgcmVnaXN0ZXJzIHRvIHJl
YWQgbnVtYmVyIG9mIHVzYjIgcG9ydHMgYW5kDQo+IHVzYjMgcG9ydHMgcHJlc2VudCBvbiBtdWx0
aXBvcnQgY29udHJvbGxlci4gRWFjaCBVU0IgUG9ydCBpcyBhdCBsZWFzdCBIUw0KPiBjYXBhYmxl
Lg0KPiANCj4gVGhlIHBvcnQgaW5mbyBmb3IgdXNiMiBhbmQgdXNiMyBwaHkgYXJlIGlkZW50aWZp
ZWQgYXMgbnVtX3VzYjJfcG9ydHMNCj4gYW5kIG51bV91c2IzX3BvcnRzLiBUaGUgaW50ZW50aW9u
IGlzIGFzIGZvbGxvd3M6DQo+IA0KPiBXaGVyZXZlciB3ZSBuZWVkIHRvIHBlcmZvcm0gcGh5IG9w
ZXJhdGlvbnMgbGlrZToNCj4gDQo+IExPT1BfT1ZFUl9OVU1CRVJfT0ZfQVZBSUxBQkxFX1BPUlRT
KCkNCj4gew0KPiAJcGh5X3NldF9tb2RlKGR3Yy0+dXNiMl9nZW5lcmljX3BoeVtpXSwgUEhZX01P
REVfVVNCX0hPU1QpOw0KPiAJcGh5X3NldF9tb2RlKGR3Yy0+dXNiM19nZW5lcmljX3BoeVtpXSwg
UEhZX01PREVfVVNCX0hPU1QpOw0KPiB9DQo+IA0KPiBJZiBudW1iZXIgb2YgdXNiMiBwb3J0cyBp
cyAzLCBsb29wIGNhbiBnbyBmcm9tIGluZGV4IDAtMiBmb3INCj4gdXNiMl9nZW5lcmljX3BoeS4g
SWYgbnVtYmVyIG9mIHVzYjMtcG9ydHMgaXMgMiwgd2UgZG9uJ3Qga25vdyBmb3Igc3VyZSwNCj4g
aWYgdGhlIGZpcnN0IDIgcG9ydHMgYXJlIFNTIGNhcGFibGUgb3Igc29tZSBvdGhlciBwb3J0cyBs
aWtlICgyIGFuZCAzKQ0KPiBhcmUgU1MgY2FwYWJsZS4gU28gaW5zdGVhZCwgbnVtX3VzYjJfcG9y
dHMgaXMgdXNlZCB0byBsb29wIGFyb3VuZCBhbGwNCj4gcGh5J3MgKGJvdGggaHMgYW5kIHNzKSBm
b3IgcGVyZm9ybWluZyBwaHkgb3BlcmF0aW9ucy4gSWYgYW55DQo+IHVzYjNfZ2VuZXJpY19waHkg
dHVybnMgb3V0IHRvIGJlIE5VTEwsIHBoeSBvcGVyYXRpb24ganVzdCBiYWlscyBvdXQuDQo+IG51
bV91c2IzX3BvcnRzIGlzIHVzZWQgdG8gbW9kaWZ5IEdVU0IzUElQRUNUTCByZWdpc3RlcnMgd2hp
bGUgc2V0dGluZyB1cA0KPiBwaHkncyBhcyB3ZSBuZWVkIHRvIGtub3cgaG93IG1hbnkgU1MgY2Fw
YWJsZSBwb3J0cyBhcmUgdGhlcmUgZm9yIHRoaXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLcmlz
aG5hIEt1cmFwYXRpIDxxdWljX2tyaXNrdXJhQHF1aWNpbmMuY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvdXNiL2R3YzMvY29yZS5jIHwgNjIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysNCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5oIHwgIDUgKysrKw0KPiAgMiBmaWxl
cyBjaGFuZ2VkLCA2NyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91
c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBpbmRleCAzYjY4ZThl
NDViOGIuLjk2NWVhYWQxOTVmYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3Jl
LmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gQEAgLTM5LDYgKzM5LDcgQEAN
Cj4gICNpbmNsdWRlICJpby5oIg0KPiAgDQo+ICAjaW5jbHVkZSAiZGVidWcuaCINCj4gKyNpbmNs
dWRlICIuLi9ob3N0L3hoY2ktZXh0LWNhcHMuaCINCj4gIA0KPiAgI2RlZmluZSBEV0MzX0RFRkFV
TFRfQVVUT1NVU1BFTkRfREVMQVkJNTAwMCAvKiBtcyAqLw0KPiAgDQo+IEBAIC0xODgyLDEwICsx
ODgzLDU3IEBAIHN0YXRpYyBpbnQgZHdjM19nZXRfY2xvY2tzKHN0cnVjdCBkd2MzICpkd2MpDQo+
ICAJcmV0dXJuIDA7DQo+ICB9DQo+ICANCj4gK3N0YXRpYyBpbnQgZHdjM19yZWFkX3BvcnRfaW5m
byhzdHJ1Y3QgZHdjMyAqZHdjKQ0KDQpJIHRoaW5rIGl0IG1heSBmaXQgYmV0dGVyIHRvIGxlYXZl
IHRoaXMgZnVuY3Rpb24gZGVmaW5pdGlvbiBpbiBob3N0LmMuDQpCdXQgeW91IGNhbiBhbHNvIGFy
Z3VlIHRvIGxlYXZlIGl0IGhlcmUuIExldCBtZSBrbm93IHdoYXQgeW91IHRoaW5rLg0KDQo+ICt7
DQo+ICsJdm9pZCBfX2lvbWVtICpiYXNlOw0KPiArCXU4IG1ham9yX3JldmlzaW9uOw0KPiArCXUz
MiBvZmZzZXQ7DQo+ICsJdTMyIHZhbDsNCj4gKw0KPiArCS8qDQo+ICsJICogUmVtYXAgeEhDSSBh
ZGRyZXNzIHNwYWNlIHRvIGFjY2VzcyBYSENJIGV4dCBjYXAgcmVncyBzaW5jZSBpdCBpcw0KPiAr
CSAqIG5lZWRlZCB0byBnZXQgaW5mb3JtYXRpb24gb24gbnVtYmVyIG9mIHBvcnRzIHByZXNlbnQu
DQo+ICsJICovDQo+ICsJYmFzZSA9IGlvcmVtYXAoZHdjLT54aGNpX3Jlc291cmNlc1swXS5zdGFy
dCwNCj4gKwkJICAgICAgIHJlc291cmNlX3NpemUoJmR3Yy0+eGhjaV9yZXNvdXJjZXNbMF0pKTsN
Cj4gKwlpZiAoSVNfRVJSKGJhc2UpKQ0KDQppb3JlbWFwIHJldHVybnMgTlVMTCBvbiBlcnJvcnMu
DQoNCj4gKwkJcmV0dXJuIFBUUl9FUlIoYmFzZSk7DQo+ICsNCj4gKwlvZmZzZXQgPSAwOw0KPiAr
CWRvIHsNCj4gKwkJb2Zmc2V0ID0geGhjaV9maW5kX25leHRfZXh0X2NhcChiYXNlLCBvZmZzZXQs
DQo+ICsJCQkJCQlYSENJX0VYVF9DQVBTX1BST1RPQ09MKTsNCj4gKwkJaWYgKCFvZmZzZXQpDQo+
ICsJCQlicmVhazsNCj4gKw0KPiArCQl2YWwgPSByZWFkbChiYXNlICsgb2Zmc2V0KTsNCj4gKwkJ
bWFqb3JfcmV2aXNpb24gPSBYSENJX0VYVF9QT1JUX01BSk9SKHZhbCk7DQo+ICsNCj4gKwkJdmFs
ID0gcmVhZGwoYmFzZSArIG9mZnNldCArIDB4MDgpOw0KPiArCQlpZiAobWFqb3JfcmV2aXNpb24g
PT0gMHgwMykgew0KPiArCQkJZHdjLT5udW1fdXNiM19wb3J0cyArPSBYSENJX0VYVF9QT1JUX0NP
VU5UKHZhbCk7DQo+ICsJCX0gZWxzZSBpZiAobWFqb3JfcmV2aXNpb24gPD0gMHgwMikgew0KPiAr
CQkJZHdjLT5udW1fdXNiMl9wb3J0cyArPSBYSENJX0VYVF9QT1JUX0NPVU5UKHZhbCk7DQo+ICsJ
CX0gZWxzZSB7DQo+ICsJCQlkZXZfd2Fybihkd2MtPmRldiwNCj4gKwkJCQkgInVucmVjb2duaXpl
ZCBwb3J0IG1ham9yIHJldmlzaW9uICVkXG4iLA0KPiArCQkJCQkJCW1ham9yX3JldmlzaW9uKTsN
Cj4gKwkJfQ0KPiArCX0gd2hpbGUgKDEpOw0KPiArDQo+ICsJZGV2X2RiZyhkd2MtPmRldiwgImhz
LXBvcnRzOiAldSBzcy1wb3J0czogJXVcbiIsDQo+ICsJCWR3Yy0+bnVtX3VzYjJfcG9ydHMsIGR3
Yy0+bnVtX3VzYjNfcG9ydHMpOw0KPiArDQo+ICsJaW91bm1hcChiYXNlKTsNCj4gKw0KPiArCXJl
dHVybiAwOw0KPiArfQ0KPiArDQoNCj4gIHN0YXRpYyBpbnQgZHdjM19wcm9iZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgew0KPiAgCXN0cnVjdCBkZXZpY2UJCSpkZXYgPSAmcGRl
di0+ZGV2Ow0KPiAgCXN0cnVjdCByZXNvdXJjZQkJKnJlcywgZHdjX3JlczsNCj4gKwl1bnNpZ25l
ZCBpbnQJCWh3X21vZGU7DQo+ICAJdm9pZCBfX2lvbWVtCQkqcmVnczsNCj4gIAlzdHJ1Y3QgZHdj
MwkJKmR3YzsNCj4gIAlpbnQJCQlyZXQ7DQo+IEBAIC0xOTY5LDYgKzIwMTcsMjAgQEAgc3RhdGlj
IGludCBkd2MzX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJCQlnb3Rv
IGVycl9kaXNhYmxlX2Nsa3M7DQo+ICAJfQ0KPiAgDQo+ICsJLyoNCj4gKwkgKiBDdXJyZW50bHkg
b25seSBEV0MzIGNvbnRyb2xsZXJzIHRoYXQgYXJlIGhvc3Qtb25seSBjYXBhYmxlDQo+ICsJICog
c3VwcG9ydCBNdWx0aXBvcnQuDQo+ICsJICovDQo+ICsJaHdfbW9kZSA9IERXQzNfR0hXUEFSQU1T
MF9NT0RFKGR3Yy0+aHdwYXJhbXMuaHdwYXJhbXMwKTsNCj4gKwlpZiAoaHdfbW9kZSA9PSBEV0Mz
X0dIV1BBUkFNUzBfTU9ERV9IT1NUKSB7DQo+ICsJCXJldCA9IGR3YzNfcmVhZF9wb3J0X2luZm8o
ZHdjKTsNCg0KVGhlIGZ1bmN0aW9uIG5hbWUgaGVyZSBjYW4gYmUgcmV3b3JkZWQgYXMgaXQgZG9l
cyBtb3JlIHRoYW4gcmVhZGluZyB0aGUNCnBvcnQgaW5mby4gUGVyaGFwcyBkd2MzX2dldF9udW1f
cG9ydHMoKT8NCg0KPiArCQlpZiAocmV0KQ0KPiArCQkJZ290byBlcnJfZGlzYWJsZV9jbGtzOw0K
PiArCX0gZWxzZSB7DQo+ICsJCWR3Yy0+bnVtX3VzYjJfcG9ydHMgPSAxOw0KPiArCQlkd2MtPm51
bV91c2IzX3BvcnRzID0gMTsNCj4gKwl9DQo+ICsNCj4gIAlzcGluX2xvY2tfaW5pdCgmZHdjLT5s
b2NrKTsNCj4gIAltdXRleF9pbml0KCZkd2MtPm11dGV4KTsNCj4gIA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy91c2IvZHdjMy9jb3JlLmggYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiBpbmRl
eCBkZjU0NGVjNzMwZDIuLjRjNTJmZWY5OTgzOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2Iv
ZHdjMy9jb3JlLmgNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gQEAgLTEwMzks
NiArMTAzOSw4IEBAIHN0cnVjdCBkd2MzX3NjcmF0Y2hwYWRfYXJyYXkgew0KPiAgICogQHVzYjNf
cGh5OiBwb2ludGVyIHRvIFVTQjMgUEhZDQo+ICAgKiBAdXNiMl9nZW5lcmljX3BoeTogcG9pbnRl
ciB0byBVU0IyIFBIWQ0KPiAgICogQHVzYjNfZ2VuZXJpY19waHk6IHBvaW50ZXIgdG8gVVNCMyBQ
SFkNCj4gKyAqIEBudW1fdXNiMl9wb3J0czogbnVtYmVyIG9mIFVTQjIgcG9ydHMNCj4gKyAqIEBu
dW1fdXNiM19wb3J0czogbnVtYmVyIG9mIFVTQjMgcG9ydHMNCj4gICAqIEBwaHlzX3JlYWR5OiBm
bGFnIHRvIGluZGljYXRlIHRoYXQgUEhZcyBhcmUgcmVhZHkNCj4gICAqIEB1bHBpOiBwb2ludGVy
IHRvIHVscGkgaW50ZXJmYWNlDQo+ICAgKiBAdWxwaV9yZWFkeTogZmxhZyB0byBpbmRpY2F0ZSB0
aGF0IFVMUEkgaXMgaW5pdGlhbGl6ZWQNCj4gQEAgLTExODcsNiArMTE4OSw5IEBAIHN0cnVjdCBk
d2MzIHsNCj4gIAlzdHJ1Y3QgcGh5CQkqdXNiMl9nZW5lcmljX3BoeTsNCj4gIAlzdHJ1Y3QgcGh5
CQkqdXNiM19nZW5lcmljX3BoeTsNCj4gIA0KPiArCXU4CQkJbnVtX3VzYjJfcG9ydHM7DQo+ICsJ
dTgJCQludW1fdXNiM19wb3J0czsNCj4gKw0KPiAgCWJvb2wJCQlwaHlzX3JlYWR5Ow0KPiAgDQo+
ICAJc3RydWN0IHVscGkJCSp1bHBpOw0KPiAtLSANCj4gMi4zNC4xDQo+IA0KDQpUaGFua3MsDQpU
aGluaA==

