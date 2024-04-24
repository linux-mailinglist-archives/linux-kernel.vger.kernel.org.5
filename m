Return-Path: <linux-kernel+bounces-156109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E558AFE0B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 712771F2406B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49942F4FB;
	Wed, 24 Apr 2024 01:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Jp0MZewC";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="AIexWbki";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Tt/FZkRF"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D781FBE4D;
	Wed, 24 Apr 2024 01:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713923475; cv=fail; b=Z5otjPx2/X80wo86x/J2gk5VTSGikHa3KnCsEs5lTUwxUA/H0Byc7u7Msuaj4KS6VddaQyNOh+S0rlJOlekk/mVvTCn3XaqKV2p2uOSeBz9hNf7Zs6cJ5mn1ss3krV2eDxIerCgUeEkeFgnl7igrP7BbqsTQ5pglTkqhCcDfNwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713923475; c=relaxed/simple;
	bh=qtHJFetc+w+iqy1ptVtm9Tuu6h++7gLSmMZYQR4MUCg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CfSR3zGNvN6nVD68gY4N2QnxTCzGntK1ywEYIIT8r8Q3Lsn2p7VTOeVnZCitKo58T23G5G2u3j1IJAKZdm4csdkRnHjnkwolkvjNxos7ooRtC0TwC4888+NjvEcYznSvxMI6aFuD0v7fkPTRfDm49XiRdGiWDlbPrvPrum2rs8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Jp0MZewC; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=AIexWbki; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Tt/FZkRF reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O0xLwB015983;
	Tue, 23 Apr 2024 18:51:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=qtHJFetc+w+iqy1ptVtm9Tuu6h++7gLSmMZYQR4MUCg=; b=
	Jp0MZewCXgtZYsm5lMliFjI1k1JSnWMuCVb70vezVLFqGhHh00ESVG8H+HO5hBy3
	JAGIJKv4ljDDaDM1qoJsoyXc5Wf0dNWHWFgPi+HLpA+m6eKBxBpnCwHNZcual9ml
	bEF13M1Rq3GljCn6Oki8p/4FALBuk/N7JkXAVpI57ceqS8FpybMTC125o7veR4FO
	F/RbJXQOkRMw+bucOigJQ4diAegkPoyuGfpnQrYgeU2OOvsUKw1J/J0GJUWGEwD9
	hOWb1O0reL/9FiqNwibF6peszBuN2LIL5EI0F0rDsE3An0uwhYPcRBmFf6Xsq8y3
	j23BllpCDSjRCmtlp9navQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3xpf6xagqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 18:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1713923466; bh=qtHJFetc+w+iqy1ptVtm9Tuu6h++7gLSmMZYQR4MUCg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=AIexWbkiOVJIJqNg4z/nKx+Y6EDCnyvN8lDkjESEwr/tVqy61FZIpY5xMazuBBGyI
	 yqw51LMyEuDN/XB3lLO0hiJI19OM6uAIcJVz6UU0Yp1zjzys/bI2rbppreUWtHPjlZ
	 //42jTAV4+VDIlYFo8cHbBYFyMMzVrVAksVbrUmIG3dSIts4r8wHAlQSlCF6qGIdw2
	 3XM93hrLUA1jSz5RrejM6/tNVS5jY53HM/uFStArase8SU3o4Wxsx3CfYVSP/cMtn4
	 BsDgT5WYmRVTu4Dd04DdKRRG6RjMu22Air1E2tBuvwkQSTKSBnHBLRDPm1PK/hGxXQ
	 Cr+EU3xYPL9kQ==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 677BC4034B;
	Wed, 24 Apr 2024 01:51:06 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 28EF2A005F;
	Wed, 24 Apr 2024 01:51:06 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Tt/FZkRF;
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7DF9740363;
	Wed, 24 Apr 2024 01:51:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7+esRswTcNDWbkRKM83VJ2oxq9gY6md+TaIAEvO73j6+rVQoAoHFD37yDgIhJ2TYfo6j4B9DC2DGzAc4pMQL3Rv8reb4yR67mch3Cd5aINKiS2z9tjAPzY/eOM+AymYWsIRNA1WwbizcrIbq0RxvhYwfX2sB+M46j3gktEeP2+6Mm9QIEydkyU/GNIMZabRY3HN40y4L8tiUmpsXoZBOy7oO5qYkbUFCO3b1aUHeE8ZvNPpGFcHcxr+aC4j9IqRRkLPvKz941k9stopCLQBgchFWlEJPowsf9pbIQS3vdd9fa1JWn4ZcB1fi0JM8bvidnMOQjuhwd2RRkiLa3eg4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtHJFetc+w+iqy1ptVtm9Tuu6h++7gLSmMZYQR4MUCg=;
 b=FOaUuNW7GNs4fdJ8KPmtI5BMxl1WiRDG/zy+ZdKJ9gcTuM9itSNB8H7fC983K32ekopJRnTFjERdBR6gvZHvnkGqtC/k/BSjvsNcDM4m8flZpSOUME8KFy+6uhkofJ4DjK6rKwsyfYILxRjWYhmYCLA6OHXMh2lJBS/Y5Eia3catoNkSgc/7cVSrJ6wA5ge92TRccwi3qC2NTqm88Bc4vXtwFyUN/DdqVksmHh7sNvk9F0oYXpBI4FdrhD2JkOofZLt4PCxn8xowiyQEU0nG/bfBpKU80CxRyEJewYKqpK93PAw3o3JUKJqz4B9N31k5KeH4xvvEZ+MdoHjd8i118w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtHJFetc+w+iqy1ptVtm9Tuu6h++7gLSmMZYQR4MUCg=;
 b=Tt/FZkRF8xdAwPr8Aw/m5Ptxk3Gvsb9CJ/A6cgPxDDxth0SBYJjknQohSPKKRPQQukLQ4TtoUo4r5uJEi4328ROeXLYo4IYilexTcGQF8yqDkzOI3pRmZsnkO5GBiFikTaV0tjaNDl+5mUYrvF3yF3F8ABlcyX47oZGkgWw6wHc=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SA1PR12MB8947.namprd12.prod.outlook.com (2603:10b6:806:386::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 01:51:02 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 01:51:01 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Michael Grzeschik <mgr@pengutronix.de>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: check drained isoc ep
Thread-Topic: [PATCH v2] usb: dwc3: gadget: check drained isoc ep
Thread-Index: AQHahUf+Fjbt0R5rsESCdAPrKfiIcbFVmhGAgAADmgCAAaX5AIAeuKwAgADM1YA=
Date: Wed, 24 Apr 2024 01:51:01 +0000
Message-ID: <20240424015059.w7hsee4tt2ixkp5y@synopsys.com>
References: 
 <20240307-dwc3-gadget-complete-irq-v2-1-8c5e9b35f7b9@pengutronix.de>
 <20240402230555.xgt5uilc42diyr4m@synopsys.com>
 <20240402231848.4hzzrxegjrcmdab2@synopsys.com>
 <20240404002906.wk6xbz2wp2tf2xwn@synopsys.com>
 <Zie5sN473m2rgNTK@pengutronix.de>
In-Reply-To: <Zie5sN473m2rgNTK@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SA1PR12MB8947:EE_
x-ms-office365-filtering-correlation-id: 25c1e070-c61f-4732-8090-08dc6400fee4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?utf-8?B?azN6QzdTd0NpTGlyTlFxV0FNNnF2VWJzdHN2QXhIL3pQbTBOQXdCcGswMVlm?=
 =?utf-8?B?YWJ5dHAwUC84clRuMWdURnI4YXdYdkYzYms0VGszd1o3TzBnYStQUzdjVVIr?=
 =?utf-8?B?RlBmS0JtYitXVGYzYUw5ZVlBcWxPdEpVZlVQeHdHblZWejJleENGakU5VEJp?=
 =?utf-8?B?TGE2RnNIczFSRXcxeEpJSFFKMG45UWNHWFN5WXJhKzJsaXlvaWtCWnZOTW5l?=
 =?utf-8?B?RjB6cDRmeFlMM2hjVVg4dm9HbVdJMHJCU3ppSVBQVUNsM24rQncvWkJHTndk?=
 =?utf-8?B?TU1CZndSMUVIR3ZvbHVBTW9zRjY3dWd6NHF5Y1c1aGZJTkxzQ3hXOXFtNUFt?=
 =?utf-8?B?dUNnVUhMd0lXZEZhWTEvTldIbzdjcGJ0REZFK0VRUGUxKzZ6c1V3MVJuc0VI?=
 =?utf-8?B?T0lQWEdIbFY5RUJOdHFaaDVaK1FQeEE1R0IwNklMNDBEQVpYc1dwbXVZbUF4?=
 =?utf-8?B?YnRrNzQ3VDU2UFR3YnlDV1FJeW1ES0E5MndyRDlHRjc4SG5RUUdIdEJOSG1V?=
 =?utf-8?B?L3FPMEZBUHVLbU5hSGRZUzcwbmg3ajlzVnV5U01MQU03S3dTT2FDNGx3MjNC?=
 =?utf-8?B?N0xyaVNhSUZld2JaRG9yV3hjRVlaRnVpdkdTNUZzb2hvQStmbGJ0L3V4c0x2?=
 =?utf-8?B?Mnc5dTJocG1nMURIcFdjb3BHQXM4QWRxampuUzBGeXZZSkxMTGkrSEZmTUtI?=
 =?utf-8?B?b2g2d296MXdoTUpWcmdib1p1YzlORDNHSFZibWpQbks1NHVmQXhPek51T1BG?=
 =?utf-8?B?ejZEb29zQURiRUZpTUJmK3FSSEltUUVsOS95MUZlUmF1YUZSZG5oVkdGRzR2?=
 =?utf-8?B?YVpoNmxDekNFNExIa2RoZDVnTkFwMXpsYUlrUzRtM2tuVHFJa0V4czFvUzNU?=
 =?utf-8?B?b0RBa1lmWUFNL0hSQ3FVWHorWmQyKzkzcFhhN2NlVWUrbGxVVjJLaDZFeGlZ?=
 =?utf-8?B?YnVjVkJQeHFod0NDUnJXbUZiRlMvajA0N1FDdU5vQk41dHBVVktYN3F0V0pz?=
 =?utf-8?B?bEJVVnByN1crc0hHLytBZkhwWXMrNFhieXZES0NJUUlXQmE1WlRaVFVkeDZC?=
 =?utf-8?B?ZWU4b3MvYjRBQ0ZJbWFiREIrSG13aTk1QjVUU1N6VVNabTlPbjJkdlVyaWky?=
 =?utf-8?B?dy9jMDdBNE5uNjhiWDBBRmlnTGU5L3k4Ky84TDRaNnlORWJhak9kNXBjdWVC?=
 =?utf-8?B?eXJOQ2RHTi9GZDQ5ZkpWY05uenZCbTd1YnpEVnpKaDZXU3hCTVpBR3pVbnJp?=
 =?utf-8?B?VHlRV3Q1T2xTNmtydTE4dkZnd3hsbnhiTnlsVVd3R3ZHNXZSa0dFTWw1aFpN?=
 =?utf-8?B?cU9WUVNEQ2NuQWdBaEhVSVRwNE9BVDN1NHpmdFhCMkFMUVRoUlhpTjh1Yldu?=
 =?utf-8?B?SnhCUXdFL0F0Vk5EZEEreStjSHVxMm5MSnpleGp1QzZVNjJ3L1diS2pKZ3c1?=
 =?utf-8?B?Y1ViZEMwb3FzMGg2NXRwbGlWZytDZmtCSHdZalJjS0Y2TWxnYS95aDRFRjFY?=
 =?utf-8?B?cTFSTE1iSUt0NW5VZEEyZUN0emtJTUFZK21GejlUa2lMblVkT0VLTTNQUUU2?=
 =?utf-8?B?cUUvaVd3VjRSNnFDbE14M2NPVmFnbVlhNnhTRGlXOFc2VVowcmtKbDZqNnl0?=
 =?utf-8?B?amtSZk9xMkt0Njd2Ky9tdG8vMWh5RTBxRUozUjU1YzFIdlByUzVTWTF3L1NB?=
 =?utf-8?B?MS85bkR0bmRuemttemlXVUYzWWdXb2pzK2FoZzNMcGZYa2lxOFZkcEk3LzYy?=
 =?utf-8?B?Y1JXNXAvV3ZxR1htaGR1MGg0cW9BdjFXOSsxZ0d6K3ZEKzhrZjNpMWdwclpu?=
 =?utf-8?B?M214OExINzA4Wm9ZdE9Jdz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZktaM0FHMkJ0Wm83YXZIRXF3aS9HMEVTSFAwZjl5UWhzaDY5bWF5MEM0NUVY?=
 =?utf-8?B?MlZ4clovYnBLaG9QUXViWmlvZWdSdEU3WDRJeG9NaStNTmREdVhnR2NKbzdq?=
 =?utf-8?B?cDBQSlpYSnZlRkhCbDRYSTJhSUpRTlNyblYwcDVVajJmSDNVc1RDRTJDakc2?=
 =?utf-8?B?c3VNK21HUU83RFRqTlphZ0dmSFJLYk1QR2h2K251di9meTVHMjhFWGxPSm5K?=
 =?utf-8?B?TXo0eTJXZWYxMjRSREhKTzNCcTlseWtKY0lyL1pvTTFhKzRuaGRzZkRTWmxn?=
 =?utf-8?B?WTZoUzhuTnVaWG9jV05WNXM1NVdEcG5WQ0lUbExON0QwRGZTeWg4dTlUYWF6?=
 =?utf-8?B?aUw0UkhYZmt5SjdiUk1UYmlpTDI5ZW9ZL0Y4NGVORnJPcTF0TUVYTFJWN2k3?=
 =?utf-8?B?UHNlMzhHOGp6em9uZ0ZmWitsemNKeUxFZnRnaC8wZi91U05VMkJ2S2gxRHVX?=
 =?utf-8?B?L0FOMGNkVS92dTl0ck9RUElOZnUvZkZ6QUlSUEplY0lJNzN5Q25GNVNuUUtF?=
 =?utf-8?B?V0xueFFJa3l5NzQzU3BmekIrN3VuKzdTOVZmamI3M2U0ZGJVZldORHc4TTB1?=
 =?utf-8?B?czIzazk1ekNKZG43L2hhb1JFNmMvd08vUU1XQm9CZER5RDdDcUJGZGh0Z2dH?=
 =?utf-8?B?MHhlVEFnczVqcHU4OCs3aFIrd0pmLzN4czNwVktEZHVaclhPRFNUOXo2YWxp?=
 =?utf-8?B?YXdQL1JJMUV4U0o1OUtvRlBwVmFTWE5TV3djQVpBNVdDZEVsNUovdzk3L1NW?=
 =?utf-8?B?QTVCdXlEcWpHRG9nRUpWemV6RkczdzNEbDFQYnpac2xEYWF3L0xJR1lwdEJv?=
 =?utf-8?B?aWpMbjU4NGNnUEt4NmpBU0pzOTBFOGxXbHBRZkZBUXMxdzlnU1c2dnhkeU1t?=
 =?utf-8?B?ZlBBVmxWUzMxdEZ0dTY1b0hCMlNPWXc5K0M3WG5mYU83T2U3UDBPQzcrbC8r?=
 =?utf-8?B?ZDVOSVQ0cVE2SnJzdkFjNGt5YTVYdjFRNXowd1NEWUg1L1RESS8yVzMrSDlS?=
 =?utf-8?B?bmFwS3JGaGJ3dUNXZVdrYlhNU0Nxc1d1L2pQeUNxSHhBb2VQRU1Zb2JUaER5?=
 =?utf-8?B?RjdxUGRFMGRXSHJyTTRtbDZpNERqaVRYa1hTQTRaY0xuRzNBWkpGc1RtMkVV?=
 =?utf-8?B?NUdmUTRKemhMcFhDeHZlQnZ6ZFJvV2pYbEI4NUk3VVdjdWF6ZEFrdGlBZDBr?=
 =?utf-8?B?b3RRWGVDdUN0VEFzQW9UMS94OTJteGdldFpQajJBaDlSOEdid05nS1NWQk56?=
 =?utf-8?B?N3ZsWGIzS2ljcExGa1ZwN1FjU2JHb2NQUXg1NURrRllnZ3dMQnlNcWI2dmtL?=
 =?utf-8?B?V0YraGNXNzBSeGVacmNxMllLNm1Vc2JJRTFOZEdFYkdKZS8zRll5eDR5VHRi?=
 =?utf-8?B?SHVIblVSU1RTc0pXU0VZYkxUdHEzLzZjeXk2WllHQm5wa0ZvZ3R0Q00yRlpK?=
 =?utf-8?B?Q05sUVNPK1l1azFTaHNVWWlFZzRsMkhRRDdETExaK1JBRDNFeGZXQmNBTURs?=
 =?utf-8?B?ZUs5bFVrWTNReVZoNXYvSTQwSFBZN1lPOExBUjVOZU12T05IVUh2Zng3all5?=
 =?utf-8?B?Y1FMQzEvTWZLdENQMGU1cXVYYnFzWmpPYVVETElLRnF2VU1kSlJzVDVaV0Zv?=
 =?utf-8?B?Yk5seDBYTmw1Tmh0SG9vY3FPRnU5dCt2U092S2tsVmNMYlJZeWtnUzF3Z2lW?=
 =?utf-8?B?VXhRMXJGWXJ2WmswaTFibDhMZFBIVkFtWnIwcWl5UlFDQ3JXSitON280TkRV?=
 =?utf-8?B?aEJ6TUl0VWVUSlVnblRadXVyd3pIUEw4WmV5cWllT1plZE1SMG5FWWlrZWJs?=
 =?utf-8?B?NHEvU3Y3UGFTSlZkdDVaTW51ZUNWZi9LamZuM1QzRERoZFZPei9KMVBGRUFt?=
 =?utf-8?B?RW93SUdwdFc5cG5iVm1Oc1BmUXJSUjRvTHM1UUZJOG1ITTFxcEc0U2tzbGFp?=
 =?utf-8?B?bjM4eXVJOEpDeFpBSFhncjBkSmRPL09wVGF4ZVBXZVdsSlVsNmdTenphbHJR?=
 =?utf-8?B?dlBINGw2ajNXWFpPck83a21xUnZ6VlprR0lLNFNvd1dnSU42NzVhc2NIZXpr?=
 =?utf-8?B?NkxLdnlWU2Z6R1ZGTFpyMDVQYXJGcFdFNDFyN0p1ZWREdE1Ta1pwekdnSk9r?=
 =?utf-8?B?Nkc4UDF1WjVVNEpnbGFSOEJoalk3U0VjRzlDU0tiVkx6NmNGeWVMNEIvVVFH?=
 =?utf-8?B?eVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB4897B79CA0FA4384C9EA7A894FC8A6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	PvXxXAetul5Fkyzfln13yl/7B8rN2QMJVVKPzYYhr1SCFjMkljgADfDQG/6vyI6Yqc3qx3ZWkWXkGEhPFkRurUN2IAHxIBDQeT6J80RXn9VLI//4Bj8f5UZWeTb3W4xEVK5YzlBlzFndjDTWXRmW++KngvUVYYxwR9k0EcbC4oktbl2pDqPO8+VH3o/i52H0s15sSIcZ8w1arujetYJFoGLTwPPkc9fIbJITUgcgivtDwuI+imYpOkRkAfbekXELFWF4htLuRQ+ZHopwDR8A/5np6F4W3D/m/OjZ48aVV9d5joLmkSaQ5ViPrHDdSitkAtVRgPNIMAqQPZrRueG0Gi9AS/XzJnhyfBUGYYs276Vw6URmQaJF3hUYPjUjS+wSybVyM2GWKVy56Jl7tEsxGal+3eMR0AUK9MSHn3CuSvxANRo7pICk7838K0BY+ro0FTByyYueYarKFMJNl2yj/VHVtc66ogWKXtWNCul3fYPPG4F0hlGQGGFZxXQjUTW0m3pI3HcBrKAGs6FgCiAz1YUjzo/SESSlteE/I7BRhfGEk/S7lcYwkQXWAtPHbwiYbNtw9+/NYSpcv6T+4DfCooZlO/LdhfzsOeSQ9s4qUYvjORlqh6ENHAuDJORAWySVy3mtHw+9OlaYAK70gUqatA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c1e070-c61f-4732-8090-08dc6400fee4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 01:51:01.8823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S8JjINrD7cv8ycMcHWybDWOKtzCB8Mi70s1sBfFN5Y+eVya9zBuSc5b7xpB4FpMgkhNcnfT4XOQ2VnAWOcug0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8947
X-Proofpoint-GUID: 9Yjj-6SKa00g-ilnEqL4Qcp5hPridyOI
X-Proofpoint-ORIG-GUID: 9Yjj-6SKa00g-ilnEqL4Qcp5hPridyOI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_20,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=467 priorityscore=1501
 adultscore=0 spamscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404240007

T24gVHVlLCBBcHIgMjMsIDIwMjQsIE1pY2hhZWwgR3J6ZXNjaGlrIHdyb3RlOg0KPiBIaSBUaGlu
aCwNCj4gDQo+IE9uIFRodSwgQXByIDA0LCAyMDI0IGF0IDEyOjI5OjE0QU0gKzAwMDAsIFRoaW5o
IE5ndXllbiB3cm90ZToNCj4gPiBPbiBUdWUsIEFwciAwMiwgMjAyNCwgVGhpbmggTmd1eWVuIHdy
b3RlOg0KPiA+ID4gT24gVHVlLCBBcHIgMDIsIDIwMjQsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4g
PiA+ID4gTXkgY29uY2VybiBoZXJlIGlzIGZvciB0aGUgY2FzZSB3aGVyZSB0cmFuc2Zlcl9pbl9m
bGlnaHQgPT0gdHJ1ZSBhbmQNCj4gPiA+IA0KPiA+ID4gSSBtZWFuIHRyYW5zZmVyX2luX2ZsaWdo
dCA9PSBmYWxzZQ0KPiA+ID4gDQo+ID4gPiA+IGxpc3RfZW1wdHkoc3RhcnRlZF9saXN0KSA9PSBm
YWxzZS4gVGhhdCBtZWFucyB0aGF0IHRoZSByZXF1ZXN0cyBpbiB0aGUNCj4gPiA+ID4gc3RhcnRl
ZF9saXN0IGFyZSBjb21wbGV0ZWQgYnV0IGFyZSBub3QgZ2l2ZW4gYmFjayB0byB0aGUgZ2FkZ2V0
IGRyaXZlci4NCj4gPiA+ID4NCj4gPiA+ID4gU2luY2UgdGhleSByZW1haW5lZCBpbiB0aGUgc3Rh
cnRlZF9saXN0LCB0aGV5IHdpbGwgYmUgcmVzdWJtaXR0ZWQgYWdhaW4NCj4gPiA+ID4gb24gdGhl
IG5leHQgdXNiX2VwX3F1ZXVlLiBXZSBtYXkgc2VuZCBkdXBsaWNhdGUgdHJhbnNmZXJzIHJpZ2h0
Pw0KPiA+IA0KPiA+IEFjdHVhbGx5LCBzaW5jZSB0aGUgcmVxdWVzdHMgYXJlIGNvbXBsZXRlZCwg
dGhlIEhXTyBiaXRzIGFyZSBjbGVhcmVkLA0KPiA+IG5vdGhpbmcgaXMgc3VibWl0dGVkIGFuZCBu
byBkdXBsaWNhdGUuIEJ1dCBzaW5jZSB0aGUgcmVxdWVzdHMgYXJlIG5vdA0KPiA+IGdpdmVuIGJh
Y2sgeWV0IGZyb20gdGhlIHN0YXJ0ZWRfbGlzdCwgdGhlbiB0aGUgbmV4dCBTdGFydF9UcmFuc2Zl
cg0KPiA+IGNvbW1hbmQgd2lsbCBiZWdpbiB3aXRoIHRoZSBUUkIgYWRkcmVzcyBvZiB0aGUgY29t
cGxldGVkIHJlcXVlc3QNCj4gPiAoSFdPPTApLCB0aGUgY29udHJvbGxlciBtYXkgbm90IHByb2Nl
c3MgdGhlIG5leHQgVFJCcy4gSGF2ZSB5b3UgdGVzdGVkDQo+ID4gdGhpcyBzY2VuYXJpbz8NCj4g
PiANCj4gPiA+ID4NCj4gPiA+ID4gWW91IGNhbiB0cnkgdG8gY2xlYW51cCByZXF1ZXN0cyBpbiB0
aGUgc3RhcnRlZF9saXN0LCBidXQgeW91IG5lZWQgdG8gYmUNCj4gPiA+ID4gY2FyZWZ1bCB0byBt
YWtlIHN1cmUgeW91J3JlIG5vdCBvdXQgb2Ygc3luYyB3aXRoIHRoZSB0cmFuc2ZlciBjb21wbGV0
aW9uDQo+ID4gPiA+IGV2ZW50cyBhbmQgbmV3IHJlcXVlc3RzIGZyb20gZ2FkZ2V0IGRyaXZlci4N
Cj4gPiA+ID4NCj4gPiANCj4gPiBXYXMgdGhlIHByb2JsZW0geW91IGVuY291bnRlciBkdWUgdG8g
bm9faW50ZXJydXB0IHNldHRpbmdzIHdoZXJlIHRoZQ0KPiA+IGl0IHdhcyBzZXQgdG8gdGhlIGxh
c3QgcmVxdWVzdCBvZiB0aGUgdXZjIGRhdGEgcHVtcD8NCj4gPiANCj4gPiBpZiB0aGF0J3MgdGhl
IGNhc2UsIGNhbiBVVkMgZnVuY3Rpb24gZHJpdmVyIG1ha2Ugc3VyZSB0byBub3Qgc2V0DQo+ID4g
bm9faW50ZXJydXB0IHRvIHRoZSBsYXN0IHJlcXVlc3Qgb2YgdGhlIGRhdGEgcHVtcCBmcm9tIHRo
ZSBVVkM/DQo+IA0KPiBBY3R1YWxseSBuby4gV2hhdCBJIHdhbnQgdG8gZG8gaXMgdG8gZW5zdXJl
IHRoYXQgdGhlIGR3YzMgc3RyZWFtDQo+IGlzIHN0b3BwZWQgd2hlbiB0aGUgaGFyZHdhcmUgd2Fz
IGRyYWluZWQuIFdoaWNoIGlzIGEgdmFsaWQgcG9pbnQNCj4gaW4gbXkgY2FzZS4gU2luY2Ugd2Ug
YXJlIGFjdHVhbGx5IHBvdGVudGlhbGx5IGVucXVldWVpbmcgbmV3IHJlcXVlc3QNCj4gaW4gdGhl
IGNvbXBsZXRlIGhhbmRsZXIsIGJlIGl0IHplcm8gbGVuZ3RoIG9yIHJlYWwgdHJhbnNmZXJzLg0K
PiANCj4gQ2FsbGluZyBraWNrX3RyYW5zZmVyIG9uIGFuIGRyYWluZWQgaHcgd2lsbCBhYnNvbHV0
ZWx5IHJ1biBpbnRvDQo+IG1pc3NlZCBpc29jcyBpZiB0aGUgaXJxIHRocmVhZCB3YXMgY2FsbGVk
IGxhdGUuIFdlIHNhdyB0aGlzIG9uIHJlYWwgaGFyZHdhcmUsDQo+IHdoZXJlIGFub3RoZXIgaXJx
X3RocmVhZCB3YXMgc2NoZWR1bGVkIHdpdGggdGhlIHNhbWUgcHJpb3JpdHkgYXMgdGhlDQo+IGR3
YzMgaXJxX3RocmVhZCBidXQgd2FzIHJ1bm5pbmcgc28gbG9uZyB0aGF0IHRoZSBIVyB3YXMgcnVu
bmluZyBkcnkgaW4NCj4gYmV0d2VlbiB0aGUgaHcgaXJxIGFuZCB0aGUgYWN0dWFsIGR3YzNfaXJx
X3RocmVhZCBydW4uDQo+IA0KDQpSaWdodC4gVW5mb3J0dW5hdGVseSwgZHdjMyBjYW4gb25seSAi
Z3Vlc3MiIHdoZW4gVVZDIGZ1bmN0aW9uIHN0b3BzDQpwdW1waW5nIG1vcmUgcmVxdWVzdCBvciB3
aGV0aGVyIGl0J3MgZHVlIHRvIHNvbWUgbGFyZ2UgbGF0ZW5jeS4gVGhlDQpsb2dpYyB0byB3b3Jr
YXJvdW5kIHRoaXMgdW5kZXJydW4gaXNzdWUgd2lsbCBub3QgYmUgZm9vbHByb29mLiBQZXJoYXBz
DQp3ZSBjYW4gaW1wcm92ZSB1cG9uIGl0LCBidXQgdGhlIHNvbHV0aW9uIGlzIGJldHRlciBpbXBs
ZW1lbnQgYXQgdGhlIFVWQw0KZnVuY3Rpb24gZHJpdmVyLg0KDQpJIHRob3VnaHQgd2UgaGF2ZSB0
aGUgbWVjaGFuaXNtIGluIFVWQyBmdW5jdGlvbiBub3cgdG8gZW5zdXJlIHF1ZXVpbmcNCmVub3Vn
aCB6ZXJvLWxlbmd0aCByZXF1ZXN0cyB0byBhY2NvdW50IGZvciB1bmRlcnJ1bi9sYXRlbmN5IGlz
c3VlPw0KV2hhdCdzIHRoZSBpc3N1ZSBub3c/DQoNCkJSLA0KVGhpbmg=

