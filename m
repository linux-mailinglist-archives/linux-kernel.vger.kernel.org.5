Return-Path: <linux-kernel+bounces-159357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFD08B2D8B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 01:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82B3E282BF8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F97156885;
	Thu, 25 Apr 2024 23:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jZG0Bc+n";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="P00bvYGk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="s4WOmlj2"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31AD156250;
	Thu, 25 Apr 2024 23:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714087347; cv=fail; b=tqEjBlQgQazgrgF50Lhpg9tB10WMLWGFQMn+osDrHM7pfI5bzT2TfFTaZ8EqPnUMI/lh8kmFri8JGJSGgeAymmq/9f3gTvFKF4arqk79bikMUfNl0Mefc/2jIUEz01EBxplNCl6zXh0UFrMxCg1v7HUESp8L5/PzLe+uzEjMMAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714087347; c=relaxed/simple;
	bh=fAdvmdhgutZVXWDKFFmE+8nr+L5xcxnPgjxXVgt6e68=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kaI1+rbP+gOoMvw9h32pm/aFJG/eUMMkctHin2JM1eQhcGDxk1vAL851crivDvV/Rui3pFjl/RyJR5yT0/7COkNUNOXQTqlOfrQtu7BmGqvEMDO4WlubEGtazfOSZqW1IuOdQ9D+CbHRTK/6s+63VlgxAdZP807rK3Vy45pl1F8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=jZG0Bc+n; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=P00bvYGk; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=s4WOmlj2 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PMZPNw032590;
	Thu, 25 Apr 2024 16:22:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=fAdvmdhgutZVXWDKFFmE+8nr+L5xcxnPgjxXVgt6e68=; b=
	jZG0Bc+nJ8l6OKPYRRro5ltXiOfIOoPXTuTdGOhXKLRfezZ8LdHnx79qTCZeu1Jd
	rTceGulNzVwKU1wpFFA8SmKZVju1acYk8GDWvy5MZnFwmfAnkQYH5amPx7atrozs
	bnar+2HDTUyX2oZjaGYGq3TlBVgt9CBOrH35rlcTRf15cT1ShpcLzZT3Qvij9lgJ
	2d5Jerdaz6orD2yvnInC4t7aP6BnZwUiB+VD+Us773NWprX75QtBUMwDemLgLS0Z
	T2f2hqfBfD1DqfbOX8hRoqyLETWs36y1aLv1Q/ZS0PEYwiFfVWU10SDnSH70aKqJ
	tqtICai0BvzHxu6wShdwRQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3xpf6xnrxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 16:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1714087335; bh=fAdvmdhgutZVXWDKFFmE+8nr+L5xcxnPgjxXVgt6e68=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=P00bvYGku0jH+AE0M3J9brjXUD8DnHNfPK6JvpDuVLSZn2OxefSKnfoUTUEefDIp8
	 W2EznJIQoz5h32fKdBujTmerbABFtVvLnJqQ1wIaQh/nNqsWzBpPVbSV7xanji8wlE
	 yJXGC53qzH5R6YprEvPG/dEtkVg2KC0XUoSMRpYHnc6Mu7dm4RyT9ALZoBJhJkArCR
	 +mZyDv+YN/ms6oozwovCgRUZ8WYZHFSXMciO+LEWdItcvMyuMgyfC8aydkq0Q23I2w
	 GpjrbBX6UDgnflmwj9pxfxupKw9L/n84IoLxsSq86UQu7yPKukK8UC4OpBFvQ1pW0p
	 ji1NYJqe5Apgg==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A7A0540467;
	Thu, 25 Apr 2024 23:22:15 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 43B3DA00C4;
	Thu, 25 Apr 2024 23:22:14 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=s4WOmlj2;
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 6B87940362;
	Thu, 25 Apr 2024 23:22:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ayOvmnKyRAvfOKgLYrz/oTA+/U+IxR6VjRzIAe8qjaK3tghVdQpkZMrzXLYKYh4JTT6/r/K3C2BJ4GU3sZRBMiD+0yGtcCfXxLmlkQqYP0MVi/i9ZAztLGT/H3dY4kbSozS93kgWofDu9rBxZG7phReC7m4dXaydfwZ87N9ZtYTURPTHj6t3DRCqr/ij6EJqBH5flynE8aiUw+OqQNebdgpNbu3LAg2MwNIupvzrnPJILJ2TgaVwOWLD6vvPnBmPUHfHlfCEEnwcIDX3LqcvsMk3OcB+INxC2tHTLlcaTuVlMSJd7fcD+iKslOMBc88BDzI9DA54ET+/E5G9NWt8wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAdvmdhgutZVXWDKFFmE+8nr+L5xcxnPgjxXVgt6e68=;
 b=iEDYi31+fYZLOEZtD8Jo00DlSTPHXagaEctZlLs++vWuczIOPzxZLuOAGWUPxJ5XNZP9TAWPNCiemftVd+xwfdNNs6Px70v+RfeN3CpnlV4slKzaBlyqmoitN3V8pU3uMdKA7TDBX4zCpamLM9Z1YG6KRBCko7UVnpOIBimnx7ldX8JXkPRcKzL3jU10blpkWhXb4W/4m4Kk9vYO8Rm3TrwBBe3il9Mur+8cwX5Dk1ddX6P1uYJZbaf7ZOsTOJuH0SqicmZ88JtjdkXpKpWs3TppC/NpBRgkSCoJCo9MRLmuJzfABfaLRaaujTor0jvUaza5Sfq8B6tjUUj6pxs3GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAdvmdhgutZVXWDKFFmE+8nr+L5xcxnPgjxXVgt6e68=;
 b=s4WOmlj2oCQXAaE859QfP3S6daq7FdQ7I/XVgoFqiTi6b/HTpTsN4caZldv3z5E3G9Zrgjxu/E5xS/MuBb7DzwI0SMx1mAFiYXG/Ckl3cvlWuC2Gzqp+Scg8L91WpN3WBkSOzboezmTqQsiOr/BIXhabxH+pTZ3Vkf6XFESBa+g=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH7PR12MB8777.namprd12.prod.outlook.com (2603:10b6:510:26b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 23:22:09 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d%7]) with mapi id 15.20.7472.045; Thu, 25 Apr 2024
 23:22:08 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Prashanth K <quic_prashk@quicinc.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: Wait unconditionally after issuing EndXfer
 command
Thread-Topic: [PATCH v2] usb: dwc3: Wait unconditionally after issuing EndXfer
 command
Thread-Index: AQHals01ikh+2ijgpkeouSgG6Gru8LF5oSQA
Date: Thu, 25 Apr 2024 23:22:08 +0000
Message-ID: <20240425232200.kozymtwjxjs7nmoz@synopsys.com>
References: <20240425045749.1493541-1-quic_prashk@quicinc.com>
In-Reply-To: <20240425045749.1493541-1-quic_prashk@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH7PR12MB8777:EE_
x-ms-office365-filtering-correlation-id: 18d29300-4ed5-4125-11ca-08dc657e871f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?YXI0ZFE1ZUZFUURkTmRSS0RGSGQ0Wm5HUnFMWDF3UkpHV0J4dEN1clhvbmFO?=
 =?utf-8?B?cnlIamJMb0Voc3J0aVIwWWhjWjZpMDBwc21Sbk9jSlA4VVRZeUdxQUtHNlpx?=
 =?utf-8?B?VjNpU2lxMEFucnZGSnJENnVhWE1jVzVBWndBOW5NWjZXK3RzNnV2Y3dmTGNs?=
 =?utf-8?B?aXZJTW5GSXNLV1lLdlBVdGpYeTYwK284QTA2L1BtSHpiMW95bGV0YVNaZ1Q0?=
 =?utf-8?B?TzVBREVubDN2ZzdDMHVONnNYN1ExV09CSUljMFdWWEFTaFNUekdqWlZCemRF?=
 =?utf-8?B?UldzUGY3c2tCVFVyYUhzRTFES3JnaDJTa25FNlErZDdTY2dGL1VVcFNSQmcx?=
 =?utf-8?B?NHVON0tCS3dCQzg5RzVuWEp3ditQWS81T0crQWtEdWp6Z0lSZmg1R2ZOUUJJ?=
 =?utf-8?B?NWxIR1lGZ1RwSlpUck9BMEhSQ0NTbzFSdW84Z3dXYlRKanFtYzJuNDlkWEVu?=
 =?utf-8?B?eFVPV3J1TjhpRFRJNmZzK2tSRXBEZ3NrUW9aRHp0YmVVRXhLOG9sY2lGM3Zw?=
 =?utf-8?B?amdCM3ZLT1ZYSGI0d3B0NnRYeFFaSHVnd0ozZE9MNWJOaXc2VEMxZlhxYUZQ?=
 =?utf-8?B?S2V1eE5lK3N2MU93aWZsS1VkSE9lRUxiLzlWOHFDZHA2R092Q3l2U1E0VHNi?=
 =?utf-8?B?ZmtaYisxUXZpODhuM0I4WW1GbU1GTCtDbWZxQ3BhZkQ5Mm9uV0lCczJaQjl4?=
 =?utf-8?B?MWVBYlpaNUtGcFNHbVRZbXErUFptWUxwQk9FbWVHcEd0RFhMdTNnbHNwUVBO?=
 =?utf-8?B?NEp0Z28vT3Jjb3ZnMmNIbTFyYjVOWnlnNHRFSGIyWnVMVmdJTVg1TFNpbCt1?=
 =?utf-8?B?QStRRmtiSjFScnNxeUNiUVBJN29Qelk3ZERMcVdXd2hNYVI4MXdaZ1NkbHJ5?=
 =?utf-8?B?eFQzeHFjQzc5YStMalFWMHFONUJqYmU1bTEyM0NGWXpEcFMvd0pPVXN6WmxJ?=
 =?utf-8?B?MTczazJWU1Aza0pVSW1aR0piOFZoVlV3cCtadE9vV0lHdy9zVC9vYlVLQVF6?=
 =?utf-8?B?d1VxNWNNckhPVDREUmlqYXNxcEowSWFLREtBWXRoVHkxSFEyc2pWUlY3aGo2?=
 =?utf-8?B?Yk5FKy9EemRMS3hZWGRackhqS3JnT0kwU3pFTGwxTFgyUUpKZmxpUkwwSFNH?=
 =?utf-8?B?VEErdlJMcXhhc1B1WWZpK05lREU0ckF1aCtaS2ZGVVhqZDlLaWxHU2JRRWtI?=
 =?utf-8?B?TTJxdFJpbEFnbHd3ZjRRRDBxQ0hQSHJzQ2htM0FQTnRjWSs1dWl2cE5qcFFi?=
 =?utf-8?B?dXo5R2htTFRhcmcvNWJDemdQc1FWdzJla3NzYVFWM2w4RDlKcms5ZWpJejVB?=
 =?utf-8?B?MS83clJxV2dMRkE0UFZZQSs2QmtpU3FpNkNBQjdRQUs1b1liNTNMdG5UK0ZP?=
 =?utf-8?B?RXJpOGtINTN6RkhpYnNubExVVUcwd0N2UlFPYnNsZGlFamY0S21uczBCdnpw?=
 =?utf-8?B?UHljbDlqVmJUcjdZTFBXbWRMekVRZDJYM2NCQWpLWXBLZzd5YmZ5dWRLMnBo?=
 =?utf-8?B?SFlnRjFTOUY3RXFJV1gvVHdxME5IMTZCUXdVRXRuTUZHdzBOVWZBMVdvQ0h6?=
 =?utf-8?B?dXA2Zy9CenN2MnVxTkcrYTQ2RVl5NmNpZ2F0ckhFazZqMHM0ajZLdzlRcW9T?=
 =?utf-8?B?ZXYzODBhVGFJdER2Y05NUWs3M3Z4VjdWOVNDd1NrQmY3dThtVHkreXdtZVRw?=
 =?utf-8?B?bkdtazZZRzJraEF6ellnWGlCRHRrK3J2NTl0MmgxNkM4U1J4RmNVMzJnPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WkYwQTI2UGhLeUVHNnVvTlFWMEJScThDU3ovaUFsaFpwdmV6eFVuTVhEOGky?=
 =?utf-8?B?eHQ2ck9qbGZETFNSdUhOY2wrVW9GbXExVDk2WHNIcUdIN2wwUU16WXlLcldV?=
 =?utf-8?B?OFpRaVBJQXJ3ZDlwdndOd2FyZEJWQmhNKy91amx6VGxLQlltdnhkL0R2T2hZ?=
 =?utf-8?B?OFZLRk4vZk0wc1FORTVjUnd2T1Y2Q0J0YTZCdEVOTWtIeDBaY3ZUL042TW9R?=
 =?utf-8?B?VWdlRnlETTBJdmJ6aktNWVdsNFk4N1llMlZVYmNFVEZrc01ZRzkyMkRaYmEy?=
 =?utf-8?B?YjBHQmlGRGI1WGtheXJRNXgzNUo4Tm1PWlVMS1lDUUhteGN3a3FhSWwxTGdo?=
 =?utf-8?B?L0JldHFtNlRGdGFKa0NIQ2p2ckxaNFRPaVRsMHZQMzFnMFpOSWhhVkFjckYz?=
 =?utf-8?B?WlJIYXZ2V2Nwb2pVNmtrQllqeWRONjlxSWRTNEc0ZFRyUnpjWGEwa0NzVWh1?=
 =?utf-8?B?RXM2cTBYRDNBbGdJbmVMSmZwYjkwTTYrbkcrUW4xZU1TeEd4UmNrbXZUTDlI?=
 =?utf-8?B?bHZqUTR5S3RxcXFLME9UUnhsOUtIMkxhK1M0K285d25QTVpic1ZhcStrcHhM?=
 =?utf-8?B?dThnbG1yZnZIdlZTYmt1OWpxaW9LUUFRZlJrTXIyZE9oQTU5MENpbG5GZFZH?=
 =?utf-8?B?WVQxSTNuRXkxaVdnSjJqVWZqQk5BYmlhQXdaRmo4bWdNaVRabHI5YlJiMkF5?=
 =?utf-8?B?UE1PTm56VUNrejRkVWNlMWYwTjJucFJkUlFYUGhZQ0RkRFZJNEVReDZDYUlV?=
 =?utf-8?B?NmFWSlV2aENwR1p0eXkzWHBNUzJFTjg1M0JtbVdNM2h3NUUzck9Fdyt3ZmpV?=
 =?utf-8?B?Q3BtTkw3dDJlM1lwN2ZHU2lPUnM5OWJDUHJoQktYdjdIMCt3bjRjVmViNnhl?=
 =?utf-8?B?ZklNaXdoUGZKc0tBb0RuL05OVXM4bGJ3NHpqUDdmejE2YlAxMUZTZzA0NzAv?=
 =?utf-8?B?WnVOTmsyL0VnVldJR2Fvcyt5SC9pL2F2S3hPVysrWEFOU3ljb3c4cWk2WnlR?=
 =?utf-8?B?QUFBdzBoblUzWkRKSzROc1NLRnJ2bUN2WE94bGFPOG0waHNJRHkrZDBMeEVO?=
 =?utf-8?B?SXBBcEx6VllqV3JhWDczK1l1TCtHYVBNUHFEdGg3MXlnQTNJdGN3UEF4U2ph?=
 =?utf-8?B?UWhvMFYrbE1GTFdobzU4bkl2U1YvSHJMaFpkNlZ4endLbHlNejM3M21Md3hY?=
 =?utf-8?B?WGRSWWxNNG5MaDhDelMvSnovWlVnNlRyMlFUc2VZUlhxZzlEUGlCQUNTdTJK?=
 =?utf-8?B?U0s2UTI5MzdWaWhrNXR3U1l0NDQ1Y3ErMkplZnczVXBUN3d0aWY4aURLUFkx?=
 =?utf-8?B?bzNwaDI0UHZLNU1Ld0wzdnZHRU50YVUxWkNsbGRnQ29GajhCQXNTYTNoYkRn?=
 =?utf-8?B?NEIxRmx1ZGZncHR3WGxtWVUzVmpnd3hWRVVqOExkalB2ekd0TFUwWGdQRkd5?=
 =?utf-8?B?Ni9TVy9PTWdFV2h5Y1BOOXV5QVNnRVFBeTlqb1BSZGEwOVZrNTd4eWIrMnhu?=
 =?utf-8?B?YmdPWTk4aEZWOWVtUXEvYjlDcWVwcmFteXcrS2FFV0FhNGErbHU4UnNuZ01F?=
 =?utf-8?B?aEoweFZqRDBDKzlkemw5QkQ4dmp0T04zeE8wWGJoa2NZL2ZHWGZoU3hMZDFT?=
 =?utf-8?B?Rmc5OFBqbkxoVTZWTWhsc3dnSTFJMlh2cHJDL3p1Z0Z0M1Yzb2dWaE8va0xy?=
 =?utf-8?B?Tyt4TWF5bnVZa0xvVTVCZHlZUzFQN0grWW9aMlRHUmVVbTZhd1plaURrRENN?=
 =?utf-8?B?V0VxMVdYVi8zUFZPNXJWT0VVZG5ZQlMwWjJCeUdkZVhuZkFYajFiOSt5NkFZ?=
 =?utf-8?B?aUpSWHN5Skh1SzBFa29lQjNhT2hwdnNoR0g0VUtXNS9CcUtrV3NYRSs5N3ZO?=
 =?utf-8?B?clh6cWFnRE1sSmtBakZsUjdGNjlCRkZZdVVuZkZldTVCMldJK2xFSzFQb2hn?=
 =?utf-8?B?UzRxcS9rWmJKT3RkVHEvNEtnc3MrWXhHd1VuMy9WS1dxSXNmOTRuM1RST0Mr?=
 =?utf-8?B?K3NDSnN0RjhkaEdpN002ZUJQdkRXMVE3T3dNa2hlb3FOYzVmb2JYdUV6eG9O?=
 =?utf-8?B?QWV6c3BHOEViZTM1Q3ZjU0czTlp0YnI4dndrY2xJdUJNT1ZRVWZlWmRKNElJ?=
 =?utf-8?Q?z0E4XAZ27mQndVQhhkH4fdl+N?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A1EBDFE281B394D87591E9D2112C68C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	b09pQVNiKFixwZNY5XOWqaeDKqB5a0BjzqtdplUmRKXZm/k7pTmcXFZyPgdMXSPrLVpUPCashQ5ofE+GfX6sWCwnrUUaO5/V012mvTuloGJklrwpm2Bix5j6CbcK8ANbN3vLaUasOn4gyx+I5fdSdUWISswspjrGI2L4P6wMH+bYo1xRt/fUXmYmR5TdvTkhtgug91RVoEkcmJb2U1+CEWohe1CGupnWoLoWu0Zaec8SVrr4fpqOJxHj/a9uIUzWvlkZX8hcCGa+U2L2kiPx+rpGfR/aDj5HoGMJiJZYN0cg5HNXUZASFBMyxwhDB5hRXHKIF3p21zmz4GVhIb/aRGoFrLAaG6VzOFlKuKlW3P2OZnRKw8VdJ4KpPNRxMmEfrivcBJYkpdath6J9yQRuf50NmeFzdtYX6uKbPugBpwWk0ibXET+Vs2JvGltJ+KAxuxR+xjZ+Agjkpk3PhdoLhHwXWWl2y/HUCsarYsM6KfeL4zyYfdngA8CLz4JAVWQKo+HAaX1iCXpILnAYBbW1C5KTbhA5KpyFyaAMoZ4NOxASOT+Xv/VYrBouMidq1qpqMhOLw4Vm7AEGCdaiDhxM9WUKXpSfDzdFmmP0AQMk51okp09LT0+MRN2eoTU57lx+qTE9oR+nNoZD2+DSYuszDQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d29300-4ed5-4125-11ca-08dc657e871f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 23:22:08.6687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eN48MtE1+6D/vmbD/4NqJKq1PxcrF6gA808ZMLyV4YyWfkI0wJEd5Q23C79O2iBWEYem7hQ7aHOn52OZIjEE/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8777
X-Proofpoint-GUID: Ct69kI4nFtTr_tM_VOS1VkB775GxmKHR
X-Proofpoint-ORIG-GUID: Ct69kI4nFtTr_tM_VOS1VkB775GxmKHR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_21,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=993 priorityscore=1501
 adultscore=0 spamscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404250171

T24gVGh1LCBBcHIgMjUsIDIwMjQsIFByYXNoYW50aCBLIHdyb3RlOg0KPiBDdXJyZW50bHkgYWxs
IGNvbnRyb2xsZXIgSVAvcmV2aXNpb25zIGV4Y2VwdCBEV0MzX3VzYjMgPj0gMzEwYQ0KPiB3YWl0
IDFtcyB1bmNvbmRpdGlvbmFsbHkgZm9yIEVORFhGRVIgY29tcGxldGlvbiB3aGVuIElPQyBpcyBu
b3QNCj4gc2V0LiBUaGlzIGlzIGJlY2F1c2UgRFdDX3VzYjMgY29udHJvbGxlciByZXZpc2lvbnMg
Pj0gMy4xMGENCj4gc3VwcG9ydHMgR1VDVEwyWzE0OiBSc3RfYWN0Yml0bGF0ZXJdIGJpdCB3aGlj
aCBhbGxvd3MgcG9sbGluZw0KPiBDTURBQ1QgYml0IHRvIGtub3cgd2hldGhlciBFTkRYRkVSIGNv
bW1hbmQgaXMgY29tcGxldGVkLg0KPiANCj4gQ29uc2lkZXIgYSBjYXNlIHdoZXJlIGFuIElOIHJl
cXVlc3Qgd2FzIHF1ZXVlZCwgYW5kIHBhcmFsbGVsbHkNCj4gc29mdF9kaXNjb25uZWN0IHdhcyBj
YWxsZWQgKGR1ZSB0byBmZnNfZXBmaWxlX3JlbGVhc2UpLiBUaGlzDQo+IGV2ZW50dWFsbHkgY2Fs
bHMgc3RvcF9hY3RpdmVfdHJhbnNmZXIgd2l0aCBJT0MgY2xlYXJlZCwgaGVuY2UNCj4gc2VuZF9n
YWRnZXRfZXBfY21kKCkgc2tpcHMgd2FpdGluZyBmb3IgQ01EQUNUIGNsZWFyZWQgZHVyaW5nDQo+
IEVuZFhmZXIuIEZvciBEV0MzIGNvbnRyb2xsZXJzIHdpdGggcmV2aXNpb25zID49IDMxMGEsIHdl
IGRvbid0DQo+IGZvcmNlZnVsbHkgd2FpdCBmb3IgMW1zIGVpdGhlciwgYW5kIHdlIHByb2NlZWQg
YnkgdW5tYXBwaW5nIHRoZQ0KPiByZXF1ZXN0cy4gSWYgRU5EWEZFUiBkaWRuJ3QgY29tcGxldGUg
YnkgdGhpcyB0aW1lLCBpdCBsZWFkcyB0bw0KPiBTTU1VIGZhdWx0cyBzaW5jZSB0aGUgY29udHJv
bGxlciB3b3VsZCBzdGlsbCBiZSBhY2Nlc3NpbmcgdGhvc2UNCj4gcmVxdWVzdHMuDQo+IA0KPiBG
aXggdGhpcyBieSBlbnN1cmluZyBFTkRYRkVSIGNvbXBsZXRpb24gYnkgYWRkaW5nIDFtcyBkZWxh
eSBpbg0KPiBfX2R3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXIoKSB1bmNvbmRpdGlvbmFsbHkuDQo+
IA0KPiBDYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+DQo+IEZpeGVzOiBiMzUzZWI2ZGMyODUg
KCJ1c2I6IGR3YzM6IGdhZGdldDogU2tpcCB3YWl0aW5nIGZvciBDTURBQ1QgY2xlYXJlZCBkdXJp
bmcgZW5keGZlciIpDQo+IFNpZ25lZC1vZmYtYnk6IFByYXNoYW50aCBLIDxxdWljX3ByYXNoa0Bx
dWljaW5jLmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgaW4gdjI6DQo+IENoYW5nZWQgdGhlIHBhdGNo
IGxvZ2ljIGZyb20gQ01EQUNUIHBvbGxpbmcgdG8gMW1zIG1kZWxheS4NCj4gVXBkYXRlZCBzdWJq
ZWN0IGFuZCBjb21taXQgYWNjb3JkaW5nbHkuDQo+IExpbmsgdG8gdjE6IGh0dHBzOi8vdXJsZGVm
ZW5zZS5jb20vdjMvX19odHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDA0MjIwOTA1Mzku
Mzk4NjcyMy0xLXF1aWNfcHJhc2hrQHF1aWNpbmMuY29tL19fOyEhQTRGMlI5R19wZyFmYTN6b0po
bWZkQ2hHMzJsSHRBYS03YnhKcHhQc3cyd2d6UXdRQXE5Z1dHMkx3V3lyOVduSXptOUVvbDZobWlL
TEVPVEp1cWpPZVRZVllaX3NObkVSNnBfdUY0JCANCj4gDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2dh
ZGdldC5jIHwgMyArLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIv
ZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBpbmRleCA0ZGYyNjYxZjY2NzUuLjY2NmVhZTk0
NTI0ZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiArKysgYi9k
cml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IEBAIC0xNzI0LDggKzE3MjQsNyBAQCBzdGF0aWMg
aW50IF9fZHdjM19zdG9wX2FjdGl2ZV90cmFuc2ZlcihzdHJ1Y3QgZHdjM19lcCAqZGVwLCBib29s
IGZvcmNlLCBib29sIGludA0KPiAgCWRlcC0+cmVzb3VyY2VfaW5kZXggPSAwOw0KPiAgDQo+ICAJ
aWYgKCFpbnRlcnJ1cHQpIHsNCj4gLQkJaWYgKCFEV0MzX0lQX0lTKERXQzMpIHx8IERXQzNfVkVS
X0lTX1BSSU9SKERXQzMsIDMxMEEpKQ0KPiAtCQkJbWRlbGF5KDEpOw0KPiArCQltZGVsYXkoMSk7
DQo+ICAJCWRlcC0+ZmxhZ3MgJj0gfkRXQzNfRVBfVFJBTlNGRVJfU1RBUlRFRDsNCj4gIAl9IGVs
c2UgaWYgKCFyZXQpIHsNCj4gIAkJZGVwLT5mbGFncyB8PSBEV0MzX0VQX0VORF9UUkFOU0ZFUl9Q
RU5ESU5HOw0KPiAtLSANCj4gMi4yNS4xDQo+IA0KDQpBY2tlZC1ieTogVGhpbmggTmd1eWVuIDxU
aGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGFua3MsDQpUaGluaA==

