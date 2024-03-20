Return-Path: <linux-kernel+bounces-108279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF218808B4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E1CDB215E5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07295231;
	Wed, 20 Mar 2024 00:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="qzYYsdNK";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ExgSE0Hd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="FPu4IgIJ"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72111860;
	Wed, 20 Mar 2024 00:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710895727; cv=fail; b=cZ6jU6xMytcyTQGEseLVUmUGW27H+a+bRr5o5IIR+3ewgvnP6FRsjIds48OUuSWYDOymxZn9vp14Z9q5q+coda/g3Wgd+mnOIuoi+G/kIAMCqq0HqjRwZbtg1BUs4ezlUZy6/UioX9WVyRG5548lG0TJYI98BcRsj1xnFUXj+SM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710895727; c=relaxed/simple;
	bh=dccE9EmfdwxNyBEc7CB9lVWj9hnVTeMDpPBhT3M3OAg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PeOwbncjU1HVAXFybAkM1ITQmD8hFyiJFYgI1wAjMzZbaV7tDliINYagRSPvSCivMeZnN95xYC2g+v5q5jT7RCJFzCo6/wDlFh7NSwUxrgq1TLsTk40y9C3fOpPfzD3wzXeIRu2wLqMXUFVLmNsE+ev8LD779X9a9VL0pzdm1wE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=qzYYsdNK; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ExgSE0Hd; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=FPu4IgIJ reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42JKPIeU029199;
	Tue, 19 Mar 2024 17:48:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=dccE9EmfdwxNyBEc7CB9lVWj9hnVTeMDpPBhT3M3OAg=; b=
	qzYYsdNK8RNPwXJo9SIBgzwEJUPPPyucHit8IG/HLx/caqDa8DtjJTBZuoq2kf04
	bYYfkJZjFjRsGDmgUuE7ryzctOQboCWkrhk7UTe7BcObO2GYTDcTj+UXZ0kbncrq
	QnSonW/WozUcigK4UhehVmYU78BbCeLJrwmhUD5q8jnAFrH8/s6O8OysUZNeHoXI
	zhGhgkY/1zAOLjsk1fXhfEDy4VuoPKrxbHi/J6SLLlBI2K0fkX2T1wtA5UGCfzkD
	fwB7rzqLbsawB9iFAFotopwENXHcjewRe288BvrW8BUCpQE9rZTiOsWbztdGW/pm
	FmM6t3OD6w6qxE5RZq204Q==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3wwaejyhb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 17:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1710895702; bh=dccE9EmfdwxNyBEc7CB9lVWj9hnVTeMDpPBhT3M3OAg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=ExgSE0HdJ3zrHj/kmkDf1PIoZFACOUawmqWkIHUGeNr80pgQrd6D8SvNt1KyhpYNd
	 2cFVFu7T+suR9eAbJ4GttUB0KieKiRrSyhvZZP8PsQ3rruZ38bFeGIOYBaQuSzqwT+
	 PThUOF3lTQ/RDIQniUEcxo9mBzVNPy+482pam8vPkGqYbmLxttKVw5YGgGU/EPK+jB
	 KzPnmaNH/Axxx/+XpUenoO60VheRS6Bt0sfGRDx/tOxBhnBlcZ8x0FCqY+W6Pjsb1v
	 zR+QryVve29JCeTNxZT09FPBA/dJGP1pq5dTIuY+zpO+VxdZ2+1TMSvH550TiyWO6W
	 Os8PnAJBqESDg==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CCD304035C;
	Wed, 20 Mar 2024 00:48:21 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 8E49EA0268;
	Wed, 20 Mar 2024 00:48:21 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=FPu4IgIJ;
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 8F7BB4035A;
	Wed, 20 Mar 2024 00:48:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NH95m1OmwNHPWmjFokwhCBmH3GOtXmgTmdVOTnuqljFRjf3VX60z4ERwLpVnKnjEARB099ayOokE+sDvabDZDAS1J5y559QEPiTRlnG9JcI+SyCYCkYw/4HUIaToz5uk3Eqtki9RE6BC3OvsW77KUvdupDX4LzYo/I1hOHF2I8e2IYQgPT7y3lAPtRO6B48golAWiDV7pMvs92ZJmdtUdNJ/p2Pah0VEiWpGihO2d/k+d/8aNGavc8uCdNkd+UlIRJ0V6/uDV2Y2WGvxCvB4tqUXYzO4AeVuUDuBKvN8H/m63wLpBlYI1MfriOLrjHlmqRpTTw6b8/9UpU8UJu9QPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dccE9EmfdwxNyBEc7CB9lVWj9hnVTeMDpPBhT3M3OAg=;
 b=OW+sib0f+UwX6WqJ37ShN/ZEkz+8dlZ14RF6U4S10YmJlCOvwR3PyUqlsDwZZjZyd2wxAW5995F40lBUNg/g4olxm9P8TK7NPZLnb38r7K8eBMHYJy/7COm+1kfJqQxBzf0oJGuwA1fDwoC0BD4kXjoz+AHqqvYe/5qjIL4gaomB98XC9qZNySRIeDgq5QqJy6hGUTnW7SVBOw8+A0x5E6LtJvFB5QBX3JKuG2swwRrrJSTxKo/i1ruozLHBrdA61bZWc/AZuBBoXh0EtnOy4NTrD/v8l/UbO6AnOHzoV81aCX4eFt0qdBGUfC+ykO/POdU129KneLVjW5mw4IjEog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dccE9EmfdwxNyBEc7CB9lVWj9hnVTeMDpPBhT3M3OAg=;
 b=FPu4IgIJOB/n+OqaIGHWZAVIF96/b1LFee7J1aM+1XCUcC+nNL+vzOEDlNPpgSm2/SrgBVWiCMofQ3xwZmrLeKIVp4x3RFGknY9s45vW79N7JQQ2cwWygh6Jzk83pqLHhn//UIl0ay/Ga6Oe+pXsAxZMWO09zea9N1haH/Mla6M=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.26; Wed, 20 Mar 2024 00:48:14 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c%3]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 00:48:14 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: Re: [PATCH v2] usb: dwc3: core: enable CCI support for AMD-xilinx
 DWC3 controller
Thread-Topic: [PATCH v2] usb: dwc3: core: enable CCI support for AMD-xilinx
 DWC3 controller
Thread-Index: 
 AQHaZpDfVUYctKsozU2uHIlcC3QiPbEYiAkAgAAFHQCABge4gIAM/9wAgABlHICADCG3AIAF6rQAgAHtLAA=
Date: Wed, 20 Mar 2024 00:48:14 +0000
Message-ID: <20240320004810.6omwumwbcxk5as4k@synopsys.com>
References: <1708717523-4006664-1-git-send-email-radhey.shyam.pandey@amd.com>
 <20240223224940.y34qflo2azxrvksy@synopsys.com>
 <20240223230758.s7rodlxbsfa44frw@synopsys.com>
 <MN0PR12MB5953B24F0CB175D8C167E73FB7592@MN0PR12MB5953.namprd12.prod.outlook.com>
 <20240307014402.omtcsltp4pxpraf7@synopsys.com>
 <5e87b406-3301-410b-a479-d561d5b19f62@amd.com>
 <20240315010142.qmgx7dugwwb2ort2@synopsys.com>
 <MN0PR12MB59533C758566BC5A98588D74B72D2@MN0PR12MB5953.namprd12.prod.outlook.com>
In-Reply-To: 
 <MN0PR12MB59533C758566BC5A98588D74B72D2@MN0PR12MB5953.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DM4PR12MB6373:EE_
x-ms-office365-filtering-correlation-id: 4bba7fba-ad1a-47c5-ce30-08dc48776ccb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 w1ykgnUCi+3525CWXGDY0TJ67KT0vBX1ASxM8BCRz9PexGBSZTYUUyKw2fueU4GwYRoSP9wyH2hCnRrvktg0DjIABzHkxUrfykeYSiiDA+MwQcHWBNO8TTGjBbsNeIrD4M2jeXZHtMfSH07uvveq/3XUkE/e5ov61+j4UUBk8I07JmwEn2XPD8vZqJXWHtf1D5JgzSOM/QCFJTlEm2H/G40ZCcYka30PySO+FIYSEjFt0HimkpPRrIheHUa3SeHo/H4HazBiw6uF2WeUodpejVDrrhBanMD+eD1h02/Jkj4++oaxQJclf3mqVdM2O5SYYUMS5xz21MLp92hXEf+vru9dGWpQZev5ygCeAZQmYANLukub1xRXrF7BbZRo+X4uloP2ESEQ40hy+ipVwVUqmq4Ya1HfJ8cMo0J25H7QOzf3DM2xgY1RgalcvzJiZgjt1re5vQyp/efi84dpXrcUR85zAmVqEVccJiqHlF11x7swmyipqL6RlpU3PWhTIfoXTuL93PAapxtuOY8O+Xtoyu7qMc/ansU7XHqoIZn2WQimduJ4j/Q64m6pfrNb+ONdaRD0cP4INr5vSlMD0nLLz0kTUF/KMPYXLHx/xSxPOriFP531TKD+Uaf9g+9Z/ydRXCi1Suv43zCRPC41/mlVqxyvjLqxgyFTqfx7D0w3yJ5suArfeEpjxVOcUfv8Eu+vN/VuVc2TqO5XvW1ZvtlQPHCoxzMTvUpYf+LL1Rn6g3Y=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?OUxXRVd5Mm9NRjN4SDZ0YXVGUzhWQ0FpVTY1cFkwL2pYNW9reWZVUnFFclNt?=
 =?utf-8?B?dkI3aVFaUTNxSGVSOTZpU0RrZWpXV3N2K0dYYWhmZTZqcmQrV3BFMHdObUph?=
 =?utf-8?B?cjMwVUpTYnFJL2JvTktpd1ArcXhxR0dmdTkzWExIWnZkRXZVM09jTTFmQTN0?=
 =?utf-8?B?TnpZL2hUaHRyRW9ZaE52TnBOdlFYODg5VkFrME11cWVOaTJkNVJWUVZ1OHZn?=
 =?utf-8?B?bXMxY3pUd0lzamROOVUyamlBT3hPMFNJWXF2SmdQblYxQWN4SEMrY0NCSGth?=
 =?utf-8?B?M2M4MUp3SE43cGR0Zkp1ZnIxYi9zcSs2ZVBnQnYzSytsc2lLV0Y0UUY3TFpJ?=
 =?utf-8?B?dXV5LzhIcXZPcmI4T3lYeFJaa3g0NGlJMW9Xd0ZMUUFVekorcTlXMis2dFI5?=
 =?utf-8?B?N3lIdEtCL2l3QzBXTitRQUR4VTBVOGdJRzU4dW5xVmY2cktEZU15eXpCWDNB?=
 =?utf-8?B?WjdyLzlPekN2SG1VOVJnMnVhZ0dZdXo3SFdYblpER25XWEh5U3hzazMwR2lP?=
 =?utf-8?B?Tk9venY2M0NmTTByME8zSHphbWRRL2QyNkY3MkJvTXI5V08vWGs2c2NDSVBP?=
 =?utf-8?B?V3RhcEZvUGo1NGZjUDJhRHVmU0JCc08xemVsR1F1L01jNEJiVkp5aGtZRGxo?=
 =?utf-8?B?K3FaODBXbk9zMHlsbjR4TmNOb0NpU3dta0t4S2tXdmpXWnRwL2Z5WWl1L3RR?=
 =?utf-8?B?eHh6cncyU2RuTCt5NFJDT2FzRkpzQXNEbnltUHM4MXc5bG51Rmlna1lqbG5t?=
 =?utf-8?B?MCt3eWgyY1JEUEc3aG1qSTJPM2h2YldFZUw2RWQvTHgwSnIxRVhXN2dmTkhp?=
 =?utf-8?B?UUp3MWRFSDNCTTRhSVN6aDJnZ2hOSmwxb3R1TXowYlhUZ2ZXZjYxZDJFVHB4?=
 =?utf-8?B?cjRsOVZQWXBNUExuSkltWStpOTBGdHUyNHA3T3owRnNmZk81ZGFMTXB5WE1i?=
 =?utf-8?B?aFFlMmM3amEvRlBTWGNYMXlMLzA0VmVSUFo1WGc0V2RudE14T3lJK1lzSFV0?=
 =?utf-8?B?WCtVYUMvUzdZelhJQ3pKT1Y3WW4rd01yQjZzNnhBY3E3RDNEbGcwVkJiYnpK?=
 =?utf-8?B?N3h2STkzZkw1S1FJTEptd2ZiTE41d2Jxa0E5aU50NHZzaW1ldEkxa0h5RjZB?=
 =?utf-8?B?L3NZK3R0N2tGK2t0cnBTaURIUnNYdzdVblVVV3JBd0N4TVE5ell6elhTV2Ew?=
 =?utf-8?B?UEVXY1ZqWk5QL3Rvdk9DQUtzeVNSRlNlZjdQTzlPejZIWFZiVDhjS2VPTG9S?=
 =?utf-8?B?NFlNNjZINFFST1ZYKzA0UjZEWkV0bjRLRnRaU1cwR01RYjE3V205WW51RXJy?=
 =?utf-8?B?cWxmL0RGZjNZcUJyVVdjaHROcE4vTC9hUFFaamhBdE83Uks4M1doMGxqTUJo?=
 =?utf-8?B?UkQvVnpteWJFTjVweGFkSGlPbExiUXJ5TTl5Z0hBQVQ2UzFydHByMTc3TE5X?=
 =?utf-8?B?NHAxSUZwYjREUHdXdzFCMDUxRFN0M21oeHd4WTArNWJvaUpKczlYK0NybW1O?=
 =?utf-8?B?TEFUVVMrckdNc05EbVo2RHpFanJmTEN4cTNsTk5seThvYStYN2VBVk9OVUha?=
 =?utf-8?B?MVFiT2dZVW50VFlCQ3FGbXpnZXhPWUZFRHl6VEFBcnBPalZHdW5xZW5EYkhk?=
 =?utf-8?B?MUp2bk82SEtHckEyZXBUNEdEU0g1dEpHUkxHSkttY3pEa3NEVHJqMkFRWStL?=
 =?utf-8?B?aWtRN2xuejJqKzJyUVBrOVE1N1JrSUxDR01nVFc1TVEvVEx2bXk5SHNWSWJY?=
 =?utf-8?B?VEx2Lzk5QkpUa1dranFVVUFPZDVnMWlMNVJVNmtsU1hKM01sQzN5c3BnRDBz?=
 =?utf-8?B?MktBL1NUTU9nS2JGcisyZWFsdkx0R2s2MWNTS2R0SFdDaTdPZFY1eGFUZFdH?=
 =?utf-8?B?eUthUkRGNUVQdlY0bm12OGFYWmk1NmdHbEdMSHNDRDhZR2ovaEVGb2ZYNjBJ?=
 =?utf-8?B?emRneTZ6aUFCaWtxYmF3WVpuekFEaEh0ZXlNOGlSNGtDLzNpZVFrN3h0ZXRk?=
 =?utf-8?B?RjUwdTVjaERpeG81ajUzMEdya1JyMXNtNmpsRExoSkhjZVF1TnlJMWFBT0c1?=
 =?utf-8?B?NnhaNXFYd1Y2TzdxUEtBVDd1RUxSSVZJK0pXSzNnSHhqUG5jaUVqS2QwUFdR?=
 =?utf-8?Q?N8KCujnCGWyD4I/MUunimRIwN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7CC86C197FE49D448B5F3D4D171F6B8D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dUZO0dj756VQqws75EIoO+EHRWsTyUj0Oh1TSjTwNii6qjAhBB1J7ZI7x3pIltv3UZ0jxlidtNo2hMfzEDu2HaTPjMmAChogmaqLNiNeqo2DRss6To9uDVqxHxtIip3SH+nMg3seHybJf26Lb4/7sFKjlLQNHVcTg/0q0gEYxHOeV6T3HltnfqH3p/r6/OiTeRgIGf/2D6RlUCBDZVNzr3KsOZ/AsPa+riwXMaRPF6JN+Pbq1p6EGf/z9FLhi0PU0++iY//nTTvmnVIxef4AUh0f21dzRplc3OOKK7gYvWl31kfGzS8kReeZ2w7CIS9OwoOpJC/6MvUdADO8ZMOdXhrojfa0aiPHOU/+IgXM3QWyQ1RmXRNYcJoq/wnVgy+H0TtIxgLQOzcxe4MLaerAJufNTxaxOB/IoBfmYQGXbVUASCtjvwy3GZzqlepqo6ATBY8hPNzAdtYdNTKvyUje6hVOqNO7AlRT/sNz+9kNNOgkNgR7iitY2pofaf0xz8nixjfDKBCXh3X4TbrmnEiTjQeAC4Um0lSbzuLM7rJZZUmEp1eGb3+WkMNwTX0x8iej2XAMjuo58Zr7iyKgTDReTd/NGvAZugcSn5pgoF/XxjMoZlRUAkwIZgiCzinsBTXGMbhULv11F4n0VgCXqL9glg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bba7fba-ad1a-47c5-ce30-08dc48776ccb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 00:48:14.2791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vKSGfZv3uNgnZl+eWUZSmmuXmK1pOk5UoDqOcOp8xUkD5qncPEnIndIzMkzGrbfyrboNgNMHlqHnlgyvcquvWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6373
X-Proofpoint-GUID: oR6XvQHme7N7FoyIzpoYRUexSXdExKvy
X-Proofpoint-ORIG-GUID: oR6XvQHme7N7FoyIzpoYRUexSXdExKvy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0 clxscore=1011
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403140001 definitions=main-2403200003

K2RldmljZXRyZWUgbWFpbnRhaW5lcnMNCg0KT24gTW9uLCBNYXIgMTgsIDIwMjQsIFBhbmRleSwg
UmFkaGV5IFNoeWFtIHdyb3RlOg0KPiA+IA0KPiA+IEluc3RlYWQsIHBlcmhhcHMgd2UgY2FuIGRv
IGl0IGFzIGZvbGxvd2luZzoNCj4gPiAgKiBLZWVwIHRoZSBzZXR0aW5nIG9mIHRoZSBjb250cm9s
bGVyIHJlZ2lzdGVycyBpbiB0aGUgY29yZQ0KPiA+ICAqIENyZWF0ZSBhIHNvZnR3YXJlX25vZGUg
dG8gcGFzcyBhIHNvZnR3YXJlIHByb3BlcnR5IHRvIHRoZSBjb3JlDQo+IFRoYW5rcy4gQnkgc29m
dHdhcmUgcHJvcGVydHkgeW91IG1lYW4gZmxhZ3Mgb3IgY2FwcyB0aGF0IGNhbiBiZSBwYXNzZWQN
Cj4gZ2x1ZSBkcml2ZXJzIHRvIGR3YzMgY29yZSBkcml2ZXIgPw0KPiANCj4gZHdjM19zZXRfcXVp
cmtzKHN0cnVjdCBkd2MzICpkd2MsIHU2NCBmbGFncyk7DQo+IA0KPiBEZWZpbmVzIHF1aXJrcyBp
biBjb3JlLmgNCj4gDQo+IERXQzNfRkxBR1NfQ09NTU9ODQo+IERXQzNfWExOWF9DQ0kNCj4gRFdD
M19YTE5YX0lQRA0KPiBEV0MzX1JFQUxURUtfUkVTX0ZJWA0KPiANCj4gVGhlbiBiYXNlZCBvbiB0
aGVzZSBxdWlya3MvZmxhZ3MgcHJvZ3JhbSBpdCBpbiBjb3JlLmMuDQo+IElzIHRoaXMgYXBwcm9h
Y2ggZmluZSBhbmQgYWxpZ25lZCB3aXRoIHlvdXIgdGhvdWdodHM/DQo+IA0KDQpOb3QgYXMgYSBm
bGFnLiBDcmVhdGUgNCBwcm9wZXJ0aWVzIGZvciBHU0JVU0NGRzAuREFUUkRSRVFJTkZPLA0KREVT
UkRSRVFJTkZPLCBEQVRXUlJFUUlORk8sIGFuZCBERVNXUlJFUUlORk8gaW4geW91ciBnbHVlIGRy
aXZlci4gUGFzcw0KdGhlbSB0aHJvdWdoIHlvdXIgc29mdHdhcmUgbm9kZSBhcyBQUk9QRVJUWV9F
TlRSWV9VMTYuIFRoZSBjb3JlIHdpbGwNCm92ZXJyaWRlIHRoZSBkZWZhdWx0IGNvcmVDb25zdWx0
YW50IHZhbHVlIG9mIEdTQlVTQ0ZHMCBiYXNlZCBvbiB0aGVzZQ0KcHJvcGVydGllcyBpbiBkd2Mz
X2dldF9wcm9wZXJ0aWVzKCkuDQoNCkNoZWNrIGRyaXZlcnMvdXNiL2R3YzMvaG9zdC5jIGZvciBy
ZWZlcmVuY2UuDQoNCj4gDQo+ID4gDQo+ID4gVGhlc2Ugc29mdHdhcmUgcHJvcGVydGllcyB3aWxs
IG5vdCBiZSBkb2N1bWVudGVkIGluIHRoZSBkZXZpY2V0cmVlDQo+ID4gYmluZGluZy4gSnVzdCBk
b2N1bWVudCB0aGVtIGluIHRoZSBkcml2ZXIgY29yZSBoZWFkZXIuIFRoZXkgYXJlIHNpbXBseQ0K
PiA+IGRyaXZlciBwcm9wZXJ0aWVzIHRoYXQgZ2V0IHBhc3NlZCB0aHJvdWdoIHNvZnR3YXJlIG5v
ZGUuDQo+ID4gDQo+ID4gWW91IGNhbiBhZGQgdGhlIHNvZnR3YXJlIG5vZGUgdXNpbmcgZGV2aWNl
X2FkZF9zb2Z0d2FyZV9ub2RlKCkuIFRoaXMgY2FuDQo+ID4gYmUgZG9uZSBiZWZvcmUgY2FsbGlu
ZyBvZl9wbGF0Zm9ybV9wb3B1bGF0ZSgpIGluIGR3YzMteGlsaW54IChjYW4gYmUNCj4gPiBkb25l
IGluIHBsdGZtX2luaXQoKSkNCj4gPiANCj4gPiBMZXQgbWUga25vdyBpZiB0aGlzIHdvcmtzIGZv
ciB5b3UuDQo+ID4gDQoNCkhpIFJvYi9Lcnp5c3p0b2YsDQoNCkp1c3Qgd2FudCB0byBjaGVjayBp
biB3aXRoIHlvdSBmb3IgeW91ciBvcGluaW9uLiBUbyBzdW1tYXJpemUgbXkNCnN1Z2dlc3Rpb24g
dG8gUGFuZGV5LCBoZXJlIGFyZSB0aGUga2V5IG5vdGVzOg0KKiBQbGF0Zm9ybSBzcGVjaWZpYyBz
ZXR0aW5ncyBhcmUgc2V0IGluIGdsdWUgZHJpdmVycyAobWF0Y2ggdGhyb3VnaA0KICBjb21wYXRp
YmxlIHN0cmluZykNCiogVGhlc2Ugc2V0dGluZ3MgYXJlIHNldCBieSBjb250cm9sbGVyIHJlZ2lz
dGVycyB0aGF0IHNob3VsZCBvbmx5DQogIGJlIGFjY2Vzc2libGUgaW4gdGhlIGR3YzMgY29yZQ0K
KiBTbywgdGhlIHN1Z2dlc3Rpb24gaXMgdG8gcGFzcyB0aGVzZSBzZXR0aW5ncyBhcyBwcm9wZXJ0
aWVzIHVzaW5nDQogIHNvZnR3YXJlX25vZGUgY3JlYXRlZCBmcm9tIHRoZSBnbHVlIGRyaXZlciB0
byB0aGUgZHdjMyBjb3JlDQoqIFRoZXNlIHByb3BlcnRpZXMgd2lsbCBub3QgYmUgZG9jdW1lbnRl
ZCBpbiB0aGUgZGV2aWNldHJlZSBiaW5kaW5nLCBidXQNCiAgb25seSBpbiB0aGUgZHJpdmVyDQoN
CldlJ3JlIGFscmVhZHkgZG9pbmcgdGhhdCB0byBzb21lIHByb3BlcnRpZXMgc3VjaCBhcw0KImxp
bnV4LHN5c2Rldl9pc19wYXJlbnQiDQoNCklmIHRoaXMgc3VnZ2VzdGlvbiBtYWtlcyBzZW5zZSwg
d291bGQgdGhlIHByZWZpeCAibGludXgsIiBmb3IgbGludXgNCnNwZWNpZmljIGJpbmRpbmcgb3Ig
InNucHMsIiBpcyBhIGJldHRlciBmaXQ/DQoNClRoYW5rcywNClRoaW5o

