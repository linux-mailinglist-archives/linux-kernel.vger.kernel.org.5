Return-Path: <linux-kernel+bounces-139534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6728A040A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65FE9286688
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F333F8FB;
	Wed, 10 Apr 2024 23:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Rj3IAood";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="lOGW/1GH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="KxyzB5Uq"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4DC39FFB;
	Wed, 10 Apr 2024 23:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712791622; cv=fail; b=egU7z+lyQpt4wXW3/dt4sFBuvTVTrrvPVQcPouCljilAxdVm/xAU3I+GHu6edJejv6JhMdeUScpcMdf+xDodFHKlNPC5M+bJ/ncWW6GYoj+0OCfqMpJrFW3ZgwWpw0DwvvOq0pvDKSWswSAsRTDxpveUAY03MRpjKLybBeTfmr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712791622; c=relaxed/simple;
	bh=ITUGQlbxCalKLytOQm7JV3T4+nvfa8ZwQlWW60WJVAg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S/UETgWLe+OxMx2Ewc+mCFbJ6mIVx9DpJiMNY1nb4p9828h42tg3gBhZU6tCUxKv/mfA0Dn1VoyDABTr059cFcYjJ77oXBYhn3IXsBhZuBBQYzkf0tsh+UpIAROfEX6+LN1ptw4g2YdGjP75nh2lcs8HX5dxlMXeOeYOcAKhPH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Rj3IAood; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=lOGW/1GH; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=KxyzB5Uq reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43AMf8t4026145;
	Wed, 10 Apr 2024 16:26:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=ITUGQlbxCalKLytOQm7JV3T4+nvfa8ZwQlWW60WJVAg=; b=
	Rj3IAoodHiNOUEv7d0q6fmm1qOsv6V3HTtcsMQUEuXuOXm6nndaTxnNOQxklZdNE
	zojJUV96ce3H0R2+V9OXjLLrQS1314RC2r+4iVV6CIXsMl+N77axFdQ8xqYTdfOn
	3vUIJ3citusH2gvMrPZaAk4YckfalxkV9MUy3nEzF4cWqWv3wIJh44nYUzMP+QEv
	h8x9vXFf7Dp8IrKGRjwq9buKwprQyNHhHJRmV47YGAj9jyUaBo8Pu036CYHiz5Nm
	10xZJS7eoXqvgYqhCRqIxfDi24Z0BnsmpzgQ4rssRjKZW0bnImYaVYp9ILhk/6Kp
	7htuqFIUX9yP/OLMsdw1SA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3xb5dk5u6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 16:26:40 -0700 (PDT)
Received: from m0098571.ppops.net (m0098571.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.24/8.17.1.24) with ESMTP id 43ANPVHF007645;
	Wed, 10 Apr 2024 16:26:40 -0700
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3xb5dk5u6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 16:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1712791599; bh=ITUGQlbxCalKLytOQm7JV3T4+nvfa8ZwQlWW60WJVAg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=lOGW/1GHzhCCoRBIx2sQIGlAgTr80hxsQWjKwdAg/veF6pKtw9BVAssovlqATlKVW
	 IqoF8Ouqd/0an6lzNwGz++G10SM+wJ3PwcRk62ElNMq+5mNFN1HMpHcLwzrDWkjBk9
	 CHa100opOHtqf9vobdnMdgLq6AxcVcaPQt88qaTashlCbvvrXu8aHvNM/PJ3A5RME1
	 tvnESrUGrUaisX+UlLw+xiV97HmhGoJ+1gGf1io0G0yFCXnoa7Z89RIXqaDRXagUaL
	 BTzQxfNtntS5X66PUi78kJhDcZG19vCtrIRm/GvroOjZt4gXU2YK1hZ99ODs0DaJPF
	 4HhVwnKzJ1vTw==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5E8E240211;
	Wed, 10 Apr 2024 23:26:38 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id E7D62A0077;
	Wed, 10 Apr 2024 23:26:37 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=KxyzB5Uq;
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5211D404D0;
	Wed, 10 Apr 2024 23:26:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpcijC2wb9BIXIExiggBNYvRSkM46IUa1AWwmoZFQKSAAohVAjQr2z0PQU6T+B5WCr2ZluNj4cV/MoTwUNZknHY4eptE3lF4gvOiz4Cam/Zixwh87sSdVqut1r9/OgI9NwXEvlXOrHVhFsjGv2Wz23AOMlGEhCJE5L7bWydzsqTF3MTbdbWGK82uQC3X8Sg0R6/ld5knyvVqPSHZexJjh143uHU8IlC6bmgte5XWxDRtL9k6cOIHXEfGqZo3A3oh1CMuUL7jwxhipO7d5sa2gM30WIS+56j2aVawiL6cDrVz5EjnzUEPtyOgbkGA4Fd1FngyedUOFuvqj42c2EsOwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITUGQlbxCalKLytOQm7JV3T4+nvfa8ZwQlWW60WJVAg=;
 b=df8fV5JLPGxh+Gul2W7rfqc50jaHC0YNq/0i0i0vRJtSGPq+NBXPYIumI129+saWPRazTFdIlPfyDVGFb5iydch9nx3NHMZdV6JDbYdo9tuXe4gcNjWF2BMVtIBz3lpztoU1M2Jbk/6ZEnTqdBTfAC0WqcddlicIzzplg5b01yYMQRVSQiQ9YeBqr306c8zYGO7akhqnHFrJKySlWPJo+VKoQRaq51HSVct/2HzhhtuIRkEYWQN8KeAQgAl4Py7xX/5YHURHjmkuJaRmOZTMCgYavv5dxSe/lxRC/7i2jT1CzeYFh5qs3K4gc9LFDScwuJN1cs1VxYHEzJJgUnB0Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITUGQlbxCalKLytOQm7JV3T4+nvfa8ZwQlWW60WJVAg=;
 b=KxyzB5UqQOZNZHZ4eO4swr7Kzg2OJ/KtKRdgzj0hN2LQ0E5B5kxCHAxR599iMATKItMQvqsp12cVfQLrwSaySDC90spDoZNulQcmVf8Phe/mk7BFFLsx2dFgWuWNcpiKDkI+AvtpNcEWQL3bf7/CB/1jmdnTC0WJuZMKFCGN+WY=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CH3PR12MB8534.namprd12.prod.outlook.com (2603:10b6:610:15a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 23:26:32 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c%3]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 23:26:32 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Anand Moon <linux.amoon@gmail.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Johan Hovold <johan@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 6/6] usb: dwc3: exynos: Switch from CONFIG_PM_SLEEP
 guards to pm_sleep_ptr()
Thread-Topic: [PATCH v2 6/6] usb: dwc3: exynos: Switch from CONFIG_PM_SLEEP
 guards to pm_sleep_ptr()
Thread-Index: AQHahl/kJDrJTmdr+Ua3V0pkAR86KrFfNPmAgAHK9ACAATBTgA==
Date: Wed, 10 Apr 2024 23:26:32 +0000
Message-ID: <20240410232623.6gaupt6t725hhype@synopsys.com>
References: <20240404071350.4242-1-linux.amoon@gmail.com>
 <20240404071350.4242-7-linux.amoon@gmail.com>
 <20240409015352.ocpjbgxrx636jmk4@synopsys.com>
 <CANAwSgQtfOG9FSygNMsNfgdmxsr-HyvyqaYr=UXE2UC_mxKJQA@mail.gmail.com>
In-Reply-To: 
 <CANAwSgQtfOG9FSygNMsNfgdmxsr-HyvyqaYr=UXE2UC_mxKJQA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CH3PR12MB8534:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Z5Vx+3y/ptqied3jxwERreW1AOfqe/NYDYSYvh2Lrlk6s+7KdhSkBIbcpeMT79oOyFQfndBsieqDurfAxONtP+wadth7Je6nve1vzTYrDky3Wdk9jWsuR0xJxAiy75Muq1lfaFsfdJh62YhDJOgd4te4HYZGxuio4t7FR9J/AxlJifXyjzaV87eMKfZrGxiF4iFrvGuu4uVvAk+WRq5jJEE7SITUn99ZPt34NBCQRXQgUbXJ6dfYDh9egDjjKyfCEus3DgHYW1QsH6kdueuH1oEIrVWVX8IP/lrbsWy7kH1qCsM23Ak13xe08fRP2gM2iP70tvFV+2CjXYnzD/lpCzsDHHIIEOEHkopp2riM4ElBM6Mk5zbLC/Bmem8QCFEQIJQc4spRNlPmbYVh1MRPTUzSBBeAohOLYamHbRCjqROvzp5/8fL4GRpL0PXxu5KBPQAfFyh5asXOiq2s+2NPS8E3PS6vnLDpVUMPzxVr5HrZDq7aC2kSuX0hep8NzudJ7mA8zOC/Ce8hbs5usnaujrXxXCvW1WCM6C2ZYOVML8xci3k2FGzZEt3B+chGcQgt4ZyhX70uYklRUuvHbZKcd1Y4XdX+suBwTfN/CAKQr55wp4mouTO0M+mFKdNr4A3E4jOGlaVoNS9ibCmVUJ3En0h/g+8E7mcJShMBv1fAaBk=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UnNESFlFNVZXWkR2RXY5RHJKMzN1ZVJDWTBKTmFNYS9EY3hqZExwZ1VGMHg2?=
 =?utf-8?B?ZS9jTndGNUQrNmtGaFRZYlV1UVBHQkp4ZFA5b1NoSDBsQmxLdEhYTkVHd29J?=
 =?utf-8?B?aVpvWjJUQ1VUOEc1am5zenBNb0FVZW1BdDNWYUtoMWNTU2lqWWpXZisrSzdi?=
 =?utf-8?B?ckhyY1gyZmcvNXUyQ3NCZGtUSXJndHhJbG9ONXkyM0U0NGovT3RmYVdWbVlh?=
 =?utf-8?B?VDhjR2tENGVjSFhCUTFkQ0hHaGxSaWcxMEpuckozUlgvK3FhVUpsZlBXaHFi?=
 =?utf-8?B?TWxOV1BFS2pFbnJQWE9Fc1pJUW9jcEZsWkVJckFnRUROV2E2QVc4eDZWbW14?=
 =?utf-8?B?dXVPTzhvZ2pNK3VpNi80bnFtaXF2aCtNeERhL0IwVXkyNGpWVGJGZkdmdjhT?=
 =?utf-8?B?bXJLaWtEL2ZLZm5nU2VLdXc2VDBlK1YzdlRjaEpzT2hlczJOVC81czBFaXJK?=
 =?utf-8?B?eVc5ZGJTMUNXdzNuN1Q0blZEL09pU0hMN0dnUi9lTllMZEkwQldnY1hGa2Fq?=
 =?utf-8?B?NDNNWG5ZWW9uREhjVGowcmZScXVhUmVJN2ZObW01M05PODhrMVFUcWgxYWRS?=
 =?utf-8?B?dHlubHFzSklhSkZCaDRqTzd3ZjBvdHVFbUJJeVkwZUk5SDN0QzladnVGQ2xJ?=
 =?utf-8?B?RjN4bmdXQURiZURIZ1ZPVzdQK2hBN0VtWWVCQ24vRWVYcmI2cXRUNE9HOUF6?=
 =?utf-8?B?SnNXTGJEbFhrcW9ldkN3QjZOY3AwRm5wQ1lCcEkzek4wTmNiMDNqZmV4WUl6?=
 =?utf-8?B?bG5EdzV4cVVyWkVWSVpCVUxsSjc2K2lqWlEwOW5FSHgzQzBEQmxiMTYya2Fp?=
 =?utf-8?B?enI2VEt1UzNnRUtqSmdiaFF3V2RnS29qRkkwTUlzK1RuVlVaMmZHWlVncjM1?=
 =?utf-8?B?VVpEc3NZdm4ycExLcUMxZU0wS3ZkclZsWmRoVDRmZTlaNmptMm01YWtyZFd6?=
 =?utf-8?B?UVFTQ0JycVVsZm9HTEE1bTFvUExRRWpBR0NDVDVOSmtQZFlHVW1qbXJvVzZW?=
 =?utf-8?B?ZTVuWG1yZFFlWkVSTGJDaHJoMUxVeWdHU05uMDk3U3dZenRoSFcrUmE5S2dG?=
 =?utf-8?B?R205amQ2dERvTER6dE5TbjYxNmtHdmk1cmphYkZtRVBOYUJkZTEvNWQxMWFT?=
 =?utf-8?B?WXZnck1PY1lGU1A4V2lqeVN0dlFqQVhOUmd5bkFHaE9TZUdkSkVkakFoa1lF?=
 =?utf-8?B?V0hzcGpGS2xadmN1Sy82WU9FaFlONGVUc21QV01IVUl4U3FjTzhEY0lPTWY2?=
 =?utf-8?B?Ylg4ZnlRSXJZMkl1aVZGMEduOGxaUytjcDRJMzdaU0puTWsxTjJIaHN6cElr?=
 =?utf-8?B?N2lMelZ2RUxsai9DWHdEdTE0NXRCSEMreFlsQVJzeXNlVjJ1UW9Ody9FZzdi?=
 =?utf-8?B?Q2YrMERrMHpWZW9sYWlHbVJEMVFIclRFM3pzeTVmdjdJKzlHZUhoUGJUMlYr?=
 =?utf-8?B?Lzd1VGg2NkhNZktFN2ZzbkZCOWRlOXd0bXpaWkdUOEpGL1d6WDJaZkowSnFw?=
 =?utf-8?B?NkhPYWl5d2dHQUNBS0NFRVBnQm9zbjlWZ0hYdHZqam13WHhOQzBMYmVvaHQz?=
 =?utf-8?B?T09jTDZuS1UzWGZiSUxwVS9yVTVrVHZVaUhaaHFnY1RYbmxuRkQ2czgzNkt4?=
 =?utf-8?B?c2szdjZ0OXVtUUhiSVpqQkxTWjFCTiswWnZHWHhzcjlHVUQvVXd6dmFDeFk5?=
 =?utf-8?B?bzE2VWlrVnVYVkdTSUo5dEtBbVJzenJ4Nmt3K203VHc3eDIwNUhsa2ZiTWk2?=
 =?utf-8?B?ZW5kdGt0VGFJcTVWRVN2SGVMem4xcHJmRnYzRS92ek1ETHptN3ExVUF2Rm5w?=
 =?utf-8?B?dFdvdXFXSXhUaDBSckQvc29XcmFUTzNLVTE1Z1J0QTZSaEhiZEJhbEZtNWh4?=
 =?utf-8?B?elNxdDM3RUpVdCtCN0tNUzYzK0QvSU16VHFoMWlVb0xmR0NSUWlrV0xaM2lm?=
 =?utf-8?B?T2hMbFpVOHoxNGpCU2wxbXpnSWFwdEFsYUZvaXBteG85ZlpVWFErQ3RKdjBl?=
 =?utf-8?B?WjYzWEpCSGtUN2FvZTB6b3NyYzZkTGNVa2hKYVRmcVVTVHI5aVBCdVZSWEY1?=
 =?utf-8?B?VEVqZFRUSCt6QnpLd1lmMlJqZEE1bHljS1JaTEN3OVFPN3RPTU5FRHB5cnVm?=
 =?utf-8?Q?aiHHXFRxi+0afE8JF3ZrfCkcu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ECA612FB73D4454CB25123FF19099795@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	wYILUUtx6oTCRJFLrTREa+TWdj4syuXL7IsHz2hx1Dug4GhyLWLBlMiDnZOgdWHq8XaZve0rrLQqhCMvv31pY9w9MqUyJQzw6E7kD4K4MUSnn1JqPFV6oQrScQ7li4C/eFx04XqGEv3uWZDmouGcZBK1pJ2LmLlZmXJr4rXobVsVscPdV7nwLVepiyUpdYhFI1So4j46umPWIPdwSX/+ywIA8wIMU/MTHvanqWCP6N5b+/WOCszaFADTE6jeJTf2e239jrPrtvaRe3kMtMnGTVVQGcC+GXgfFZUjxq3KQ2P6spSxxyqbh5zFEBC7eUwmlUGkaTdzo/NL4O/fhcFNLIB7825d+4pP48rzI+9/XKQvoloFwnV/jW3gCv4tcpPOhTrCtvwGekPJ2z1N6IJAtEsq9mfb3dJ9MySGwNFBbgLdSiZVjd8mkdLUPbh7NDCCKCCHYHWk9tDqXts37lxBant4Ffiz+VlLAXIO/izYn2ZHnprguDnl/8XR+u6u+HV7ah/kcq7p3ahml2vAB1EQgY6BVhNFXETxSeQ6OuMuTPoAV9cu/r6FDuoKlhIKG+IJy+vhM73K8lsLkm1MbJANnYdiQPstP49Gu3nP8ylcoGpM98tGKIav1yKXao9YiT2rA0mRDCqjKQ7aakkuZ4xhmA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bcacdc0-c6d6-4e43-593e-08dc59b5a7e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 23:26:32.0458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d5PGTrqCg19sIlSVKUvX/y1sqY+scw4Ox1oS+vEYoqbGUQCILL7oydGmP5ZYGsNlW9yGRICr3bAznqZqGGLj4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8534
X-Proofpoint-GUID: D5KiX1DjIkKzPrSkliroaZk6WQX6k1a3
X-Proofpoint-ORIG-GUID: gdPpp8NcnY1iFisTvQMxEjZhnsm43Xsc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_08,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=933
 bulkscore=0 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404100173

T24gV2VkLCBBcHIgMTAsIDIwMjQsIEFuYW5kIE1vb24gd3JvdGU6DQo+IEhpIFRoaW5oLA0KPiAN
Cj4gT24gVHVlLCA5IEFwciAyMDI0IGF0IDA3OjI0LCBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXll
bkBzeW5vcHN5cy5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gVGh1LCBBcHIgMDQsIDIwMjQsIEFu
YW5kIE1vb24gd3JvdGU6DQo+ID4gPiBVc2UgdGhlIG5ldyBQTSBtYWNyb3MgZm9yIHRoZSBzdXNw
ZW5kIGFuZCByZXN1bWUgZnVuY3Rpb25zIHRvIGJlDQo+ID4gPiBhdXRvbWF0aWNhbGx5IGRyb3Bw
ZWQgYnkgdGhlIGNvbXBpbGVyIHdoZW4gQ09ORklHX1BNX1NMRUVQIGFyZSBkaXNhYmxlZCwNCj4g
PiA+IHdpdGhvdXQgaGF2aW5nIHRvIHVzZSAjaWZkZWYgZ3VhcmRzLiBJZiBDT05GSUdfUE1fU0xF
RVAgdW51c2VkLA0KPiA+ID4gdGhleSB3aWxsIHNpbXBseSBiZSBkaXNjYXJkZWQgYnkgdGhlIGNv
bXBpbGVyLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEFuYW5kIE1vb24gPGxpbnV4LmFt
b29uQGdtYWlsLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gdjI6IGFkZCBfX21heWJlX3VudXNlZCB0
byBzdXNwZW5kL3Jlc3VtZSBmdW5jdGlvbnMgaW4gY2FzZSBDT05GSUdfUE0gaXMNCj4gPiA+ICAg
IGRpc2FibGVkLg0KPiA+DQo+ID4gVGhlIGNvbXBpbGVyIGRpc2NhcmRzIHRoZSBjb2RlLCB5ZXQg
d2Ugc3RpbGwgbmVlZCBfX21heWJlX3VudXNlZD8NCj4gPg0KPiBFYXJsaWVyIHZlcnNpb24gaGFk
IG5vdCBhZGRlZCB0aGlzIHNpbmNlIGJ1dCBJIHJlbW92ZWQgdGhlDQo+IGd1YXJkLkNPTkZJR19Q
TV9TTEVFUC4NCj4gYWRkZWQgX19tYXliZV91bnVzZWQganVzdCB0byBzYWZlZ3VhcmQgdGhlIGZ1
bmN0aW9uLg0KPiANCj4gSSBoYXZlIHRyaWVkIHRvIGJ1aWxkIHdpdGggY29uZmlnIGJ5IGRpc2Fi
bGluZyBDT05GSUdfUE0gYW5kIENPTkZJR19QTV9TTEVFUA0KPiBidXQgY291bGQgZ2V0IHRoZSB3
YXJuaW5nIGNvbXBpbGF0aW9uIGJ5IGFkZGluZyBmbGFnIFc9MQ0KPiAtV2Vycm9yPXVudXNlZC1m
dW5jdGlvbi4NCj4gDQoNCjxzbmlwPg0KDQo+IA0KPiBCdXQgc2luY2UgdGhlc2UgQ09ORklHX1BN
IGFuZCBDT05GSUdfUE1fU0xFRVAgY2Fubm90IGJlIGRpc2FibGVkLA0KPiBJIGFtIG5vdCBnZXR0
aW5nIGFueSB3YXJuaW5nIHJlbGF0ZWQgdG8gdGhlc2UgZnVuY3Rpb25zLg0KPiANCj4gRG8geW91
IHdhbnQgbWUgdG8gcmVtb3ZlIF9fbWF5YmVfdW51c2VkID8NCj4gDQoNClRoZSB3YXJuaW5nIHdh
cyB0aGVyZSBhcyBleHBlY3RlZC4gWW91IHNob3VsZCB0byB1c2UgaXQgYWxvbmcgd2l0aA0KREVG
SU5FX1NJTVBMRV9ERVZfUE1fT1BTKCkuIExldCBtZSBrbm93IGlmIHlvdSBzdGlsbCBzZWUgdGhl
IHNhbWUNCndhcm5pbmcuDQoNCkJSLA0KVGhpbmg=

