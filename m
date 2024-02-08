Return-Path: <linux-kernel+bounces-58799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C15C84EBED
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BFD21C22A95
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14A15026D;
	Thu,  8 Feb 2024 22:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="eUkpCTq8";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="MZA4NIeW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="aXCLPmx5"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DF550245;
	Thu,  8 Feb 2024 22:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707432914; cv=fail; b=VBI5wSsuJ013807aP2iIyjsMH/kv+sFuhJm63dQOfzRbOi7xvZ1p8UC5C59gnYtHXGVL9sY28Bm29HKNpa1EsZksLxs9Sbsnsr/mRiFPe40pAhf9KGwJyxwvG5PjzEU48UuMxZrxOmheWC8sH9mshpesphYsa7Z7hh08ptuNhL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707432914; c=relaxed/simple;
	bh=ruqOyYkLmIK2CSUvjyPeE+bFlPHtk8VfoTi4fPb7vzc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IgziwHBGuJGIdH9VyfCG70ta3umYC5cjPDowUJbF/+VwAL9LhtVXQjkYkrwg+VhPHT7nDAjvPZQEttDn13h6Ic4xoXc82pDgPOuAHr+9WBsv5IJdtWXx3qFOaIr+jX0r0+mTfAJg6EfJq4N9Dsv6MXYCiypeCEJymyKCcO5Fz/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=eUkpCTq8; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=MZA4NIeW; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=aXCLPmx5 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 418Mse5k015787;
	Thu, 8 Feb 2024 14:54:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=ruqOyYkLmIK2CSUvjyPeE+bFlPHtk8VfoTi4fPb7vzc=; b=
	eUkpCTq8WiKCwGwiAO7jl8AeT4LZh+xPEkS58H4HzOX1qQMpmFyDMbMyu33lYA5M
	YNieDNa6uK9euvRg24dvov+c4BhpD+YmS0uegTvzdF+MyYttyjY0A4WsJS5xGF5R
	bBMIAOYBkpwlN3gamQtSPWu6n7qlmv/6yvoqQo3u3JBKDCEw1rK6Voia/ryoW3IR
	6zA3urdcTde70ptMy66iXOyKd1slGQ3KkcWApPd+vRYh5CAaXVdc5Rak6px5fGsb
	1ZXRo94DBvHv2MwPIjrOoC1InOZTD/XcMPDSsUU37wLe5FoZKystSbOzmSCzGnEj
	xtE2wx3hVXF5u77fw8PE5g==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3w1ncps19q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 14:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1707432879; bh=ruqOyYkLmIK2CSUvjyPeE+bFlPHtk8VfoTi4fPb7vzc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=MZA4NIeWPBeHYVj5Dys4wxxOjY6HofbdjUq7nbvnYxcgmfWy1ubZFsVprvtruKbrP
	 QcWKFy3V8P0sshxqAneTeL4qL2Yvy0vueFjq9CTihaeUHtkf01x8TAdBJhV65IsFnG
	 b31NpqXpFq2A4Uw3jim7+QVcR4+uUwAGit93oHoxUO2zITarJCOlwKHom9S1hma1cA
	 Y6N4AAe85BLq4SRmWuWgxERuDsYk3nVEWpD3aZVWNb8jbR8EafernULqQI1pAoA03L
	 TnZdjE8rHbxXbcjUTlg7CjQp7C3eecPLFD+Tbs29+/OcCt75xvaUzoO6NPcQ0TYm/D
	 /6VGNyZILprGA==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id EE68E404D1;
	Thu,  8 Feb 2024 22:54:38 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id A28A3A008D;
	Thu,  8 Feb 2024 22:54:38 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=aXCLPmx5;
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id CC6F340360;
	Thu,  8 Feb 2024 22:54:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvHS1+f0twlFNnERCQM6hppxpv6wEcTRlMS9Nv0FtJud4Z9aPgV5eKy6b/8jUxoIOopzuc+JtwJnWwNZPh9SLg/Z5WxIF9XL7T2FSg7n99ZYLRsMiP5hHq7e2wRso1uImmgGT+OB6Z85nPhLvyasb+Gf6dy6iLpSbXycqfQvfXxqTZR2cPn9J4z4MEngyYjqOx5llZS0u4eh8IwljSwbG++HqWS0Xer0PIGQhPUwhdaYgH8dIG4ZvQql9VGlc9W3llRON6mXqqMnPEOk3uMxE/QBjZsDUsUjC13/cM6s8fJ3u18apIfovViWstvWDXmzOch924IjcVg2GWSfEzHkHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruqOyYkLmIK2CSUvjyPeE+bFlPHtk8VfoTi4fPb7vzc=;
 b=CflOjqnsfCDklRrPtYnzM/KTSIqwMljeQmoc7YM3SI16MswaYGsqQ0+uRiSCWPV2hP+mnmcEVP9PlX2lO4Ytot3XbGd30ZFEujqIo09grZVYU8XWgkQenc1vSggfGn/er2g5mktEhfx/Gxpo99D5W5S04iMhI6VmI13wjUgA6fsSIfqgXH/I2Aqis9E1P4c7/HkTDHA4Bz+qZWf0f8RZiSLJAzD5z6X081WtxugDbfodVguIqQkFSW8sn1JwzT4lGh5E1QD1nwtFNuWwDMwmjSav0bdE2dAolAuxC1yeXTn9gzLu+FK7NMFyNcwfCqaPSsxyWHMz7FKm3nakB8UHZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruqOyYkLmIK2CSUvjyPeE+bFlPHtk8VfoTi4fPb7vzc=;
 b=aXCLPmx50iJ0ofb5+CJ1T/7P1E4nMyzGV7/9OlplLW5J5FFJNGL+PxB3n934QwpZ3iLcKfqjizskl/LGEP4jAE0vQKiXSpPoW7jtiRF+5zSYrCkD5Hmk6JvOr5ZeGY2KqU8+iFgaaQIstZ56a2QQ7GeRXRFyHCiRv1GMT4R2vdw=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DM4PR12MB5771.namprd12.prod.outlook.com (2603:10b6:8:62::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Thu, 8 Feb
 2024 22:54:34 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3%3]) with mapi id 15.20.7270.009; Thu, 8 Feb 2024
 22:54:34 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
CC: Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v3] usb: dwc3: gadget: Fix NULL pointer dereference in
 dwc3_gadget_suspend
Thread-Topic: [PATCH v3] usb: dwc3: gadget: Fix NULL pointer dereference in
 dwc3_gadget_suspend
Thread-Index: AQHaSry3jkVH2byjC0K3CaHiHYrIybD+5LoAgAJJM4A=
Date: Thu, 8 Feb 2024 22:54:34 +0000
Message-ID: <20240208225359.pvnunirbzh32zjop@synopsys.com>
References: <20240119094825.26530-1-quic_uaggarwa@quicinc.com>
 <CGME20240207115929eucas1p1dc7c6bb3f9aa2ac983dd95d345661aec@eucas1p1.samsung.com>
 <4b5683cc-8e61-43c5-be0f-b5378639276a@samsung.com>
In-Reply-To: <4b5683cc-8e61-43c5-be0f-b5378639276a@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DM4PR12MB5771:EE_
x-ms-office365-filtering-correlation-id: 57d6949d-1ff5-4fda-6151-08dc28f8eb28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 gxsrHiUPI5O5Bh6Fnb9TDOErymYddazZRODFW29xDm78v3B2EuUrsjS9b0Q5ShxQyPvy9RX5TmYnVlyUhK4PDdIKGCq0OOXH/qjEYEBGLDR/az8Yb5m0skGXmIs5wrEs1Pw0qa68TrDA48rtKB1iY1vFBISblKeP5ur7cqfGpkpeRcvqs/MB0XBu3u7/3nNHo8U7GX8dNxl3R4NqHhRBsLvutOSZCIYYFoioUSqZ1fntuRvwvroT2bp15xCh05IBkxh9a/ilH5UFwmytlSE+UoMZaIj9mgY5zKn9FoBAWM67n6YclTf28OgaSQZqdHKCa5ya55PxPTYTVAY+wXrHsupC9AlHKNtREpTL/ONSvxCNOCQuFe3gz/I+exFCEiam/oGS6oSQOXrluGPqVVJiFfd+UnehTjccecNaGM1cO5H6N2QPISzjoyjjhqrutP0k8UDiyfRtOxdAI//n235EA5Y+s90Y2gwYmfdtG/7IWFdqBRu0DU3tHYb7M4fXLYJxHHV7lYPHFHKfrD/l7p1cMNfFEP1XNCY4YQe8sY4kQS6rKdz2yPfIT9GzegwFu1ABsxHHvTN2/+v+2P+mVjoVCaPZIVq0tCRd1yvwWeQp80OnRrappidjU/Y68+nbPwYE
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(39860400002)(346002)(396003)(230273577357003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(1076003)(41300700001)(26005)(2616005)(6916009)(71200400001)(122000001)(6486002)(316002)(36756003)(6506007)(53546011)(45080400002)(83380400001)(6512007)(478600001)(38070700009)(64756008)(8936002)(38100700002)(54906003)(86362001)(66946007)(2906002)(8676002)(66446008)(66556008)(4326008)(66476007)(5660300002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MHcxSmVkd3VtU0JoV0x5WVVURzQwaFc3eGxxVG14OVN0S3liTmpmZUZmMEtF?=
 =?utf-8?B?QzN0bEFqSWc0bkNPdExoc1dCOVg0dmRXU1EzVW5GSTVSQlNWVldVc3dld1Ry?=
 =?utf-8?B?Znd0WTgxd09lWWtiYmo1VGxFaGJBcGZZR0x3UElSK2hIdHlBeEE4QWNNTXpt?=
 =?utf-8?B?aXpjVU1ta2h0VHlUVjkwRThoSVkvejFFS1NpK2E3U29HVmN5V3pZOG91eXFN?=
 =?utf-8?B?RHB6WUFnVjZuN0x3OGVGU1dNUVNOQWFFbmptZG5mSjZ2WjJDUkNHZ2szdkdG?=
 =?utf-8?B?MjdXTlh0aUlUa2wvSDJiVmV5Sk42RDA4ZEs2MEFHTStKbU5vbHdGZVB4MHdI?=
 =?utf-8?B?V1RaeDVoaG85dFJ2OXJtd0QyNHFrT29GeFdsY3FMRXRXMWg0ZXFhbVJGWHJH?=
 =?utf-8?B?WXVGRUtZQUU5Q0FaVThDT0JncDhqeWtMSWlmSjUyKzJ4N0pESW1La2x0MjVo?=
 =?utf-8?B?REhML0RYTk5qZlNDUmhRMUtGRWJhTWozb1lPa1VQVFRvNEVhb3dJZEs4WnN3?=
 =?utf-8?B?ZTgxZm9wVUdVZ21jdDZJaEE1bk1SbkUyLzloOVV3VFRvcGQ1VldicERNVjBZ?=
 =?utf-8?B?V2toRmoxcndwT2pnUEY2OXliTjNFWDdsSnF4TVdYZ09XcCt5a3lJOHByQlVj?=
 =?utf-8?B?eTNRZ3BCdFpxK0RoV2hhYVVJdm9INzVpTk5EUFlSNE0vUThZQkRDNFIyeDNt?=
 =?utf-8?B?UXNmR2RLRHVVUFoza1U3UWdneEMvTVlVMFlvMmIxclhreUZjU3d6UzZDRVY1?=
 =?utf-8?B?V1hFSUUzcm5Fa3FWSllFSURpejNPclRLV3hLTmo4ZGJuRWt2ZWV6RkNTZEhu?=
 =?utf-8?B?d3QxS0dKQUJidzR5d2M3YSs3RmltQWszODlJaXVDV1NFdTRKVXhodTdRNTVq?=
 =?utf-8?B?VVkyVFZQMDBFUjc2bDVWR0oybmJKS09qbDVBV2kxWExUc2doTWtiNWRBeXZ2?=
 =?utf-8?B?OUZwYkhTUW9PQTBHSXE2d1UvRUFTbHd0QlFzTWxjMjc0NjFNVndaRnRiMFp4?=
 =?utf-8?B?ZFdNbzFFTExjZGVlMk5CRFUxUm9kZWNQTWtkZFpIc3dXTjJYOGx0aVFHRS9Q?=
 =?utf-8?B?VGhqck1DbFVJZ2hyYUY4Qzc4Skh3c3F1cWVHalYxS240dXErTFZwVnBOdDZn?=
 =?utf-8?B?RnAxQ00wVGdWOWRBbkhwekl2NDdaY2xHTHc5Sm9zLzZLazhRMnVFNTNrUTFx?=
 =?utf-8?B?OW5EL2I5elozWnRPV0NueFo5OW14UlNVeGVuaVFLSis2a0tRaWdtZ3JTQ0ZW?=
 =?utf-8?B?SUVTTXhRZHdGYVcwdTNOTlJ1Szl3NFVTMXNtc2xFYWpQTG5uWDBTek41WDll?=
 =?utf-8?B?SjBXRUFvT1JQM3d5ZC9neGlZc0RLU1RLUTNQaG5aSktLL0x1Vi9QWjhTSkpj?=
 =?utf-8?B?YzJHMTArVXNvN3U0WW5MS29CdkF2Mlh3N2NGUEtxZXNIYXpua0o3NTQ5b2l6?=
 =?utf-8?B?SzFLTjNMc0NndUEzdUdHdklqZEdxVVl3TTRndzRNN25GVU1QRXNIWnMxUGh5?=
 =?utf-8?B?ekhnRmhodldKZksvMkd5aTBDbU1oeWdYeFNTWWE5NDRPOHAxdm8vK0VaVUZJ?=
 =?utf-8?B?bEtpS3BFRk1jc1ZXMEt1a29UNkxmSnBLTWJoenBwU2NudGNEV3JQejBpeWEx?=
 =?utf-8?B?Sk9zZnZ6My9uOXFMcEE4bnFmSWRmNWttRERaMEZPbU5SWHNIeWtMM0VTN0dJ?=
 =?utf-8?B?cjBmd3RlMGMzQlA2UTZCVnE0My9ZQnJ4YXFjcEhpa0YxbWRPQnp1bFdUN3M3?=
 =?utf-8?B?ZFNHUlh4Ny9pUjN0NEhiYXlDc3YzSmkxc2JRRTdsOUxPYVdDVzRERnhyNnRD?=
 =?utf-8?B?bE42OC9ROS9Sd2laVW11QnRHMFpmcU1hV0Y4UU9WVlR1MVIvTkNjeCt5ek5n?=
 =?utf-8?B?YUl1cW5kS3lhcSsvaDBVYUZMTzdWZXNzc3BzWC81dUZBM1ZBWW5pOXFoanYr?=
 =?utf-8?B?cm9LdkpkdzhaRWhna0xjL1RudU85eXJxdE1wNHJDRW5sZFVFNHNwSzdxYVZF?=
 =?utf-8?B?VVByaUNDSXlkVldhTUhJd2hWaXljVkVpWWkrbndaQUwwNmhWSnROVUZMZlNu?=
 =?utf-8?B?NTkrRkxHZ2dPU2NrVjFRRitpcXBhOHNVYTB1L1FNWWZyZFJHVS9JMHdUR2hx?=
 =?utf-8?Q?jJu8/ifPAucDhkcI1Xz4Ygxk3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9EA0BA7B83E4543A8C736D46066F9D2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yYcMyv2NofraxCHpg3Vm4s4/d4TnKfaGsJy+r7AJCMZgUrRva9psjSOcLO+F77UBGlboGqBw+Orew06m/lgYkq1xKAU+UWs6wNwDrNEgDapbMe3IpGT6YxMujGpG5LuwkuPTL0b/T9tMaGlChw6LS7p5eEgvy7Ta5KqnPwIY54wzTVJI0rghE6LSZFvyEQGCb554YPtddAlVaWAzdm+/N74GGeyT+PWiVIttwPa7WTDCRW+sCxCVy23Cbs1X6KhEBNBNBqueH4uOhE/SQ9bN+K7A2awp2kTU0hS8J4cOmK6+SI0BBKbrsbi7iOXRfICCfng3GgsmklYkjStr5THmkf21ByC/f2RJ8wpZdrW34F4xg4T3Mr4cZ9Cju5eOvhYGhbQ6LkbEMCv3OfY90r8y2U2FhyJaEZ3lGlzkwER5Q6Ga5Z9yh0/0/l+Rsz9lE+/sHbd3q+X9kXPLLQoI1tVpDfmWTWmRtV79tjCegiiiL8Zkp1GxZha5J+kvIoWVaApcwjoKeFVsQj8mF+EhhFCfm/NGwL+Sz4wS0ru1ZdVi0Zz2ciIQmc47T+WwE5Yg4qy1ztpOd5Nym0RkgbOipxWiEiR03MtRcBJ+5wQY6ySc927cd9WPqy0/g2+CX+HLaZDEI1CR4cCHA7OSiscRW2biqA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d6949d-1ff5-4fda-6151-08dc28f8eb28
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 22:54:34.1598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gFmqLk7bXjX7xbtNi/VDUbUCuYUg/F0Sw+0DffeVn9wQnAoeZ1WOxLPFlSPMvPpSGs4qEmSxya7ChYLklJruvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5771
X-Proofpoint-GUID: GoZirNS19bZsUmunI_q_s3d4MwSmlpyQ
X-Proofpoint-ORIG-GUID: GoZirNS19bZsUmunI_q_s3d4MwSmlpyQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_11,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1011 malwarescore=0 lowpriorityscore=0 mlxlogscore=562
 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402080128

T24gV2VkLCBGZWIgMDcsIDIwMjQsIE1hcmVrIFN6eXByb3dza2kgd3JvdGU6DQo+IERlYXIgQWxs
LA0KPiANCj4gT24gMTkuMDEuMjAyNCAxMDo0OCwgVXR0a2Fyc2ggQWdnYXJ3YWwgd3JvdGU6DQo+
ID4gSW4gY3VycmVudCBzY2VuYXJpbyBpZiBQbHVnLW91dCBhbmQgUGx1Zy1JbiBwZXJmb3JtZWQg
Y29udGludW91c2x5DQo+ID4gdGhlcmUgY291bGQgYmUgYSBjaGFuY2Ugd2hpbGUgY2hlY2tpbmcg
Zm9yIGR3Yy0+Z2FkZ2V0X2RyaXZlciBpbg0KPiA+IGR3YzNfZ2FkZ2V0X3N1c3BlbmQsIGEgTlVM
TCBwb2ludGVyIGRlcmVmZXJlbmNlIG1heSBvY2N1ci4NCj4gPg0KPiA+IENhbGwgU3RhY2s6DQo+
ID4NCj4gPiAJQ1BVMTogICAgICAgICAgICAgICAgICAgICAgICAgICBDUFUyOg0KPiA+IAlnYWRn
ZXRfdW5iaW5kX2RyaXZlciAgICAgICAgICAgIGR3YzNfc3VzcGVuZF9jb21tb24NCj4gPiAJZHdj
M19nYWRnZXRfc3RvcCAgICAgICAgICAgICAgICBkd2MzX2dhZGdldF9zdXNwZW5kDQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkd2MzX2Rpc2Nvbm5lY3RfZ2Fk
Z2V0DQo+ID4NCj4gPiBDUFUxIGJhc2ljYWxseSBjbGVhcnMgdGhlIHZhcmlhYmxlIGFuZCBDUFUy
IGNoZWNrcyB0aGUgdmFyaWFibGUuDQo+ID4gQ29uc2lkZXIgQ1BVMSBpcyBydW5uaW5nIGFuZCBy
aWdodCBiZWZvcmUgZ2FkZ2V0X2RyaXZlciBpcyBjbGVhcmVkDQo+ID4gYW5kIGluIHBhcmFsbGVs
IENQVTIgZXhlY3V0ZXMgZHdjM19nYWRnZXRfc3VzcGVuZCB3aGVyZSBpdCBmaW5kcw0KPiA+IGR3
Yy0+Z2FkZ2V0X2RyaXZlciB3aGljaCBpcyBub3QgTlVMTCBhbmQgcmVzdW1lcyBleGVjdXRpb24g
YW5kIHRoZW4NCj4gPiBDUFUxIGNvbXBsZXRlcyBleGVjdXRpb24uIENQVTIgZXhlY3V0ZXMgZHdj
M19kaXNjb25uZWN0X2dhZGdldCB3aGVyZQ0KPiA+IGl0IGNoZWNrcyBkd2MtPmdhZGdldF9kcml2
ZXIgaXMgYWxyZWFkeSBOVUxMIGJlY2F1c2Ugb2Ygd2hpY2ggdGhlDQo+ID4gTlVMTCBwb2ludGVy
IGRlZmVyZW5jZSBvY2N1ci4NCj4gPg0KPiA+IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4N
Cj4gPiBGaXhlczogOTc3MmI0N2E0YzI5ICgidXNiOiBkd2MzOiBnYWRnZXQ6IEZpeCBzdXNwZW5k
L3Jlc3VtZSBkdXJpbmcgZGV2aWNlIG1vZGUiKQ0KPiA+IEFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4g
PFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogVXR0a2Fyc2gg
QWdnYXJ3YWwgPHF1aWNfdWFnZ2Fyd2FAcXVpY2luYy5jb20+DQo+IA0KPiBUaGlzIHBhdGNoIGxh
bmRlZCBzb21lIHRpbWUgYWdvIGluIGxpbnV4LW5leHQgYXMgY29tbWl0IDYxYTM0ODg1N2U4NiAN
Cj4gKCJ1c2I6IGR3YzM6IGdhZGdldDogRml4IE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBpbiAN
Cj4gZHdjM19nYWRnZXRfc3VzcGVuZCIpLiBSZWNlbnRseSBJIGZvdW5kIHRoYXQgaXQgY2F1c2Vz
IHRoZSBmb2xsb3dpbmcgDQo+IHdhcm5pbmcgd2hlbiBubyBVU0IgZ2FkZ2V0IGlzIGJvdW5kIHRv
IHRoZSBEV0MzIGRyaXZlciBhbmQgYSBzeXN0ZW0gDQo+IHN1c3BlbmQvcmVzdW1lIGN5Y2xlIGlz
IHBlcmZvcm1lZDoNCj4gDQo+IGR3YzMgMTI0MDAwMDAudXNiOiB3YWl0IGZvciBTRVRVUCBwaGFz
ZSB0aW1lZCBvdXQNCj4gZHdjMyAxMjQwMDAwMC51c2I6IGZhaWxlZCB0byBzZXQgU1RBTEwgb24g
ZXAwb3V0DQo+IC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0KPiBXQVJOSU5H
OiBDUFU6IDQgUElEOiA2MDQgYXQgZHJpdmVycy91c2IvZHdjMy9lcDAuYzoyODkgDQo+IGR3YzNf
ZXAwX291dF9zdGFydCsweGM4LzB4Y2MNCj4gTW9kdWxlcyBsaW5rZWQgaW46DQo+IENQVTogNCBQ
SUQ6IDYwNCBDb21tOiBydGN3YWtlIE5vdCB0YWludGVkIDYuOC4wLXJjMy1uZXh0LTIwMjQwMjA3
ICM3OTc5DQo+IEhhcmR3YXJlIG5hbWU6IFNhbXN1bmcgRXh5bm9zIChGbGF0dGVuZWQgRGV2aWNl
IFRyZWUpDQo+ICDCoHVud2luZF9iYWNrdHJhY2UgZnJvbSBzaG93X3N0YWNrKzB4MTAvMHgxNA0K
PiAgwqBzaG93X3N0YWNrIGZyb20gZHVtcF9zdGFja19sdmwrMHg1OC8weDcwDQo+ICDCoGR1bXBf
c3RhY2tfbHZsIGZyb20gX193YXJuKzB4N2MvMHgxYmMNCj4gIMKgX193YXJuIGZyb20gd2Fybl9z
bG93cGF0aF9mbXQrMHgxYTAvMHgxYTgNCj4gIMKgd2Fybl9zbG93cGF0aF9mbXQgZnJvbSBkd2Mz
X2VwMF9vdXRfc3RhcnQrMHhjOC8weGNjDQo+ICDCoGR3YzNfZXAwX291dF9zdGFydCBmcm9tIGR3
YzNfZ2FkZ2V0X3NvZnRfZGlzY29ubmVjdCsweDE2Yy8weDIzMA0KPiAgwqBkd2MzX2dhZGdldF9z
b2Z0X2Rpc2Nvbm5lY3QgZnJvbSBkd2MzX2dhZGdldF9zdXNwZW5kKzB4Yy8weDkwDQo+ICDCoGR3
YzNfZ2FkZ2V0X3N1c3BlbmQgZnJvbSBkd2MzX3N1c3BlbmRfY29tbW9uKzB4NDQvMHgzMGMNCj4g
IMKgZHdjM19zdXNwZW5kX2NvbW1vbiBmcm9tIGR3YzNfc3VzcGVuZCsweDE0LzB4MmMNCj4gIMKg
ZHdjM19zdXNwZW5kIGZyb20gZHBtX3J1bl9jYWxsYmFjaysweDk0LzB4Mjg4DQo+ICDCoGRwbV9y
dW5fY2FsbGJhY2sgZnJvbSBkZXZpY2Vfc3VzcGVuZCsweDEzMC8weDZkMA0KPiAgwqBkZXZpY2Vf
c3VzcGVuZCBmcm9tIGRwbV9zdXNwZW5kKzB4MTI0LzB4MzVjDQo+ICDCoGRwbV9zdXNwZW5kIGZy
b20gZHBtX3N1c3BlbmRfc3RhcnQrMHg2NC8weDZjDQo+ICDCoGRwbV9zdXNwZW5kX3N0YXJ0IGZy
b20gc3VzcGVuZF9kZXZpY2VzX2FuZF9lbnRlcisweDEzNC8weGJkOA0KPiAgwqBzdXNwZW5kX2Rl
dmljZXNfYW5kX2VudGVyIGZyb20gcG1fc3VzcGVuZCsweDJlYy8weDM4MA0KPiAgwqBwbV9zdXNw
ZW5kIGZyb20gc3RhdGVfc3RvcmUrMHg2OC8weGM4DQo+ICDCoHN0YXRlX3N0b3JlIGZyb20ga2Vy
bmZzX2ZvcF93cml0ZV9pdGVyKzB4MTEwLzB4MWQ0DQo+ICDCoGtlcm5mc19mb3Bfd3JpdGVfaXRl
ciBmcm9tIHZmc193cml0ZSsweDJlOC8weDQzMA0KPiAgwqB2ZnNfd3JpdGUgZnJvbSBrc3lzX3dy
aXRlKzB4NWMvMHhkNA0KPiAgwqBrc3lzX3dyaXRlIGZyb20gcmV0X2Zhc3Rfc3lzY2FsbCsweDAv
MHgxYw0KPiBFeGNlcHRpb24gc3RhY2soMHhmMTQyMWZhOCB0byAweGYxNDIxZmYwKQ0KPiAuLi4N
Cj4gaXJxIGV2ZW50IHN0YW1wOiAxNDMwNA0KPiBoYXJkaXJxcyBsYXN0wqAgZW5hYmxlZCBhdCAo
MTQzMDMpOiBbPGMwMWE1OTljPl0gY29uc29sZV91bmxvY2srMHgxMDgvMHgxMTQNCj4gaGFyZGly
cXMgbGFzdCBkaXNhYmxlZCBhdCAoMTQzMDQpOiBbPGMwYzIyOWQ4Pl0gDQo+IF9yYXdfc3Bpbl9s
b2NrX2lycXNhdmUrMHg2NC8weDY4DQo+IHNvZnRpcnFzIGxhc3TCoCBlbmFibGVkIGF0ICgxMzAz
MCk6IFs8YzAxMDE2M2M+XSBfX2RvX3NvZnRpcnErMHgzMTgvMHg0ZjQNCj4gc29mdGlycXMgbGFz
dCBkaXNhYmxlZCBhdCAoMTMwMjUpOiBbPGMwMTJkZDQwPl0gX19pcnFfZXhpdF9yY3UrMHgxMzAv
MHgxODQNCj4gLS0tWyBlbmQgdHJhY2UgMDAwMDAwMDAwMDAwMDAwMCBdLS0tDQo+IA0KPiBJTUhP
IGR3YzNfZ2FkZ2V0X3NvZnRfZGlzY29ubmVjdCgpIHJlcXVpcmVzIHNvbWUga2luZCBvZiBhIGNo
ZWNrIGlmIA0KPiBkd2MtPmdhZGdldF9kcml2ZXIgaXMgcHJlc2VudCBvciBub3QsIGFzIGl0IHJl
YWxseSBtYWtlcyBubyBzZW5zZSB0byBkbyANCg0KSSBkb24ndCB0aGluayBjaGVja2luZyB0aGF0
IGlzIHN1ZmZpY2llbnQsIGFuZCBJIGRvbid0IHRoaW5rIHRoYXQncyB0aGUNCmNhc2UgaGVyZS4N
Cg0KPiBhbnkgZXAwIHJlbGF0ZWQgb3BlcmF0aW9ucyBpZiB0aGVyZSBpcyBubyBnYWRnZXQgZHJp
dmVyIGF0IGFsbC4NCj4gDQoNCklmIHRoZXJlJ3MgaW5kZWVkIG5vIGdhZGdldF9kcml2ZXIgcHJl
c2VudCwgdGhlbiB3ZSB3b3VsZG4ndCBnZXQgdGhpcw0Kc3RhY2sgdHJhY2UuIChpZS4gZHdjM19l
cDBfb3V0X3N0YXJ0IHNob3VsZCBvY2N1cnMgd2hlbiBnYWRnZXRfZHJpdmVyIGlzDQpwcmVzZW50
KS4gVGhpcyBpcyBhIHJhY2UgaGFwcGVuZWQgYmV0d2VlbiBiaW5kaW5nICsgc3VzcGVuZC4NCg0K
SSB0aGluayBzb21ldGhpbmcgbGlrZSB0aGlzIHNob3VsZCBiZSBzdWZmaWNpZW50LiBXb3VsZCB5
b3UgbWluZCBnaXZpbmcNCml0IGEgdHJ5Pw0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdj
My9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCmluZGV4IDU2NDk3NmIzZTJi
OS4uMTk5MGQ2MzcxMDY2IDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0K
KysrIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KQEAgLTI2NTYsNiArMjY1NiwxMSBAQCBz
dGF0aWMgaW50IGR3YzNfZ2FkZ2V0X3NvZnRfZGlzY29ubmVjdChzdHJ1Y3QgZHdjMyAqZHdjKQ0K
IAlpbnQgcmV0Ow0KIA0KIAlzcGluX2xvY2tfaXJxc2F2ZSgmZHdjLT5sb2NrLCBmbGFncyk7DQor
CWlmICghZHdjLT5wdWxsdXBzX2Nvbm5lY3RlZCkgew0KKwkJc3Bpbl91bmxvY2tfaXJxcmVzdG9y
ZSgmZHdjLT5sb2NrLCBmbGFncyk7DQorCQlyZXR1cm4gMDsNCisJfQ0KKw0KIAlkd2MtPmNvbm5l
Y3RlZCA9IGZhbHNlOw0KIA0KIAkvKg0KDQoNClRoYW5rcywNClRoaW5o

