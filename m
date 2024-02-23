Return-Path: <linux-kernel+bounces-79243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC45861F77
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6701C22856
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFBB14D431;
	Fri, 23 Feb 2024 22:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="iusDKpKu";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GtG6KqEI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="eURiTiei"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530941493AC;
	Fri, 23 Feb 2024 22:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708726483; cv=fail; b=gr2YHIb8P5Uga8I0ujDOvPBLgvH+gncVJilc+jIOhh5/VHEL2rsLbdWpZOIX4Y49eCO9jVstv4nZl3KTEEzP474NrbeohZieea+fOz2N+lyFv9FkyU6rvF/lachYPgiDbt39DHHHae+xKxnunvopBsZIJPRUAKr6Zii+v1i1heA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708726483; c=relaxed/simple;
	bh=KHmZlIJdXxWpy1r4F5rVlmKAHM0Nl9VdqwEhirDpGk8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pElfdmjwn5Xe/11HrXvO1pIiw3jnvl2UDvXcKpUkovBMC04582IZufh2e8xmVESJvBKDFF/7qjuhb1vYUHeT6etaY9fE2+sWhjKQDcBpEoKQtne28b/fN3RNSkzd3NBhjlsevT1HEkAt+4FAdR+wqWjrU+3VHGxG6X8ELXd3jQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=iusDKpKu; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=GtG6KqEI; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=eURiTiei reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NGjZkH028456;
	Fri, 23 Feb 2024 14:14:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=KHmZlIJdXxWpy1r4F5rVlmKAHM0Nl9VdqwEhirDpGk8=; b=
	iusDKpKuyhB4RVWM16k7emKqS2kt1EVvIuO2sp7+1qDq1NwfX19RQUPXfwi4cFcF
	3sJ3JqzKlc1jd92+WUEfkzh/txbRkf4BhOz7SUId1bqMRMsMD05zAfoKpVC/ClGr
	owMVRBAmEmxTFcke1hqKv/Eyal7LSosFf7L2wCu6/1YG1SdwQFRY8p7dxCd3AYQD
	BcyDMUk/70CKyIoQWugzoqE7/zTGi+DM6z08q73tyWX8StKfgEcfhO2GClHh43q4
	jmmMJ05yMyf0n9UrDvACNBlAeiYn1o2KsUEuZ9QXswHtUBFO8o3OZRSVb2ASC6KG
	TELvufizymGU/JUhiVuxQA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3wd22411b9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 14:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1708726455; bh=KHmZlIJdXxWpy1r4F5rVlmKAHM0Nl9VdqwEhirDpGk8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=GtG6KqEIm3U2XcAIuUktZzHaUM1n9dJe+6v5XqJQGebYHo3avZTIiUXPcPIOh3YHd
	 bt+ZcICb6N9sPeSHM2IiLN4SJL3n6/x5nl6Ffe0PjGU0ixrcD+xcKwio8cApHIUmtN
	 5dLz2iBVw/2qKjjFywcQOeTktfpbE6l+SMFjtKZibCA1UGLcKXXMHPISya2DTcUdfe
	 a0uwpnTKHksWu/5//+wUdXwrZq5Y96+5ZSZLtoNDc8gM53v+Puy3VfwS1p/9Y0z3bI
	 ay9oVjvIY8KpQ4Rzp6EJmoa4C7+LfyE5Ngfoyxh5Qa9sRajYLuq4O5M0vCimyewXyL
	 L564+PSyNjCXQ==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 28C6B4035A;
	Fri, 23 Feb 2024 22:14:14 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 3500DA007A;
	Fri, 23 Feb 2024 22:14:14 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=eURiTiei;
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5DC29401CA;
	Fri, 23 Feb 2024 22:14:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3wsipIha1UvSR0Rj89XqTjeblLL5PQA3gnAXKwZ70Pk+AJLDlnTuvawmUwdxa0jHEEQUGOUj6M5UYApJ4ma5g1CRmKrR+qDMIas8kwJovNYTHVxdZGVThIuXl0R4DoPVQHbt4G5EVWEXQ5PCuA8RtzbjHDpLqi30vG+53Al3uTpdUWAwVfG+2OXMSUiiKRUlOomDGLOFU71WclUC/koejBmJ7igci+De8jAFGUMGVV4h4qs4FsYSnGYenS7DAsFM2X0JhvEeVdVYacKNxYPNEXVqZ/l2+ZftvEpWksQ5IhbMMKR2972IvFwaTMVt4wjLoe0pfpQ5rwLk78rVCVsvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHmZlIJdXxWpy1r4F5rVlmKAHM0Nl9VdqwEhirDpGk8=;
 b=FdZt6TxCBdI9tSxL6qNc03yYhJJXTcqsDbUkAHCDEp4uXgV/lTcbtbTw5iOCLG5c9+gz/CKAFbUVksiOpZT7HMZnhatPSiNPJdGPGkJ+0TlpOolVnKCD4emyh+1X72rzRdQoNo1ZPwmNnU7RNe/mZaeSvg52hks8p+SPVEsJ+sdNkJLOcU46XbWjE52cjBvKoIoFcKAfQ1+0cjybmMmvdYav+cROQKQQlCa1m85JH86lQjBJo2PnV43uYXCwl94n8bLSAIGCQo6vxR3b+EXlePYDTYWLBXpuIRMMAAZiWtheBgyKjQthyWQ4WSYZPZnPQbLN6yzMTKmxS9mNDySG3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHmZlIJdXxWpy1r4F5rVlmKAHM0Nl9VdqwEhirDpGk8=;
 b=eURiTieiLiGr31u07TuqX8f202MbKMyIq1ZCbuYaR9iOjfmd1hto9pfT/gQFjbM4lg7FmEIr7QaZehfBMBQHNq1P1Ygs4ToGdVwjhmDsAK2i+Ct+O/tBz9Ri1JVQLXur2UYek2piYJmM8g1SaAbcZQfy5REvuLU30nqZq259frk=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SJ0PR12MB6685.namprd12.prod.outlook.com (2603:10b6:a03:478::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 22:14:09 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3%3]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 22:14:08 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, "nm@ti.com" <nm@ti.com>,
        "r-gunasekaran@ti.com" <r-gunasekaran@ti.com>,
        "afd@ti.com" <afd@ti.com>, "b-liu@ti.com" <b-liu@ti.com>,
        "srk@ti.com" <srk@ti.com>,
        "francesco@dolcini.it" <francesco@dolcini.it>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] usb: dwc3-am62: call of_platform_depopulate in
 .remove()
Thread-Topic: [PATCH v3 1/5] usb: dwc3-am62: call of_platform_depopulate in
 .remove()
Thread-Index: AQHaXyr7mTvlFiGrwE+k1uN2tCu9C7EYjN4A
Date: Fri, 23 Feb 2024 22:14:08 +0000
Message-ID: <20240223221400.qyjlsymkqlflmmul@synopsys.com>
References: 
 <20240214-for-v6-9-am62-usb-errata-3-0-v3-0-147ec5eae18c@kernel.org>
 <20240214-for-v6-9-am62-usb-errata-3-0-v3-1-147ec5eae18c@kernel.org>
In-Reply-To: 
 <20240214-for-v6-9-am62-usb-errata-3-0-v3-1-147ec5eae18c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SJ0PR12MB6685:EE_
x-ms-office365-filtering-correlation-id: e1c6c567-9604-4015-0cd3-08dc34bcc1a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 m4nikpLTEA2/frbzN74f6nXAzA9PiVGR+jVk7+jeUknBxIaESRxyp/kTNYfaqZx+i2niGjKu1KiuyJgxjmlE9n6/nIY4Kwn9cH4S5bnHDwyRZG+nsw6rhxb1py+nzUIW7pEnj3JBSJJDVqTN1uLU7N+VCK/DFujxHRgYhgbKT0HMc9uTwdlsmza0TAaJStoIHYRhF6BHqTFEGoSwlFYgfTCKOIDuvAqqdaz2K+QI1FReDMlQN6sc1IC0BjaTdL+7A7mZLuziVbKpz86Oz4CShTZDIo/SNnl8MogNy0leY6yIznqCDYmeZNFk0lyAqs2sCe5l2RqLd8dpThwJa462rp/j4FsCLcAt6zFRazbaFkccoAUjnv5HJBgDc/CK+SEB/PFPUw9QudHfJUOdfliKBDG2HUKsBtE8w53WHb0ML3ZxQ/D4n6BblpA7N2yDXjM3l3XdveQWuae0S61KQbLkm/2g92qbfuX0dgw5GWjhudW/eS6IF99/c4YSSIrFi+jlciRsJUxN+ymYVQVhKmLPnlM3OZY6k228r4CYGcMJFwwp+EYacldouwjaiYAGl2boApISVKFFtynbxDIPfxN3pCF4+XGJF/t+PfF5nZ2tuxU=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RktFSjdKZ1htN3dOSVhuUTIxSitheU9OR21EeDhpM0dmSUo4bkRIdXJDYnlJ?=
 =?utf-8?B?SmxkM1JOcWYrTzJaYlpGZU4yc0t1STk5ZWF0d0x3bzQ1U0dXNXNWYXFoaGVV?=
 =?utf-8?B?a3J0enc1a003U2V5eFRjTkdyVlpocVZnOWtubDJ4RkNkc2x3TmdMRkNiWHp6?=
 =?utf-8?B?SUhhTVAyQ21NWVMyOUNldndwQ1d3Myt6SU5adG5SaUVtSHM1OWJXNEk3OVBH?=
 =?utf-8?B?cjI3amR2NlRmNW4xQ3NRUzRyY1dJV1lwY3lkZ1VFa1JFRGh3cG11a1h2NTl4?=
 =?utf-8?B?K3RUR3dDM085bUcxZkViSUs0R2ZiUFZOYnVIYlZsVlhJNW55U0dSQ0ZQRnQw?=
 =?utf-8?B?UUhWWUF0NjczaUs0cktXMGRJOFFEZ01JNzBkUTRoS0k2ODNKaU5Dd09HUWtP?=
 =?utf-8?B?SFhtVXU1UHJVQUNmTVA4eEUybHhaYm91OUQ4dDVTOUdKdWZmYURLQ2lGNnJX?=
 =?utf-8?B?eWFiZk5pN2gwRHE0b2twSEp4TXRQYlBhUHhSRXlDVUxWNnlMVnpzTndzbTZP?=
 =?utf-8?B?RFRrSU9EbExldEkyZFhFREM5dW51ZzZQN29QZlJ6eW8rK1FQTjAzWWx0VEsv?=
 =?utf-8?B?Uk1rVFNvMTB2TUlKWjBsby9lZXIvS2xlb2JmQTdyZ2g3aUxZaGVmQThyY0tR?=
 =?utf-8?B?bGkxNnNWcG5FTVBEekZDckc2a1RpL3RDTWQ3eWtLRG04VGFQR3VmYjcyRmd5?=
 =?utf-8?B?VDUyV3d0dFVRZW5MMisvZWtwSGxubTUwbGJZWUFmY2ExQXhJeW4rVCtnZ2lu?=
 =?utf-8?B?aGdheWRRSno0T05iS2wzTjZhNTVidFMwZ0Joa1N3d2kwWXBPYzFIb2RJNjRl?=
 =?utf-8?B?bGhidmpvbFhPVi9FMmU5MTRacExtaXY4M01kbkNJSWUxVmNGQzJJUER4NDhP?=
 =?utf-8?B?T1BiZmI0QlpCY0JSbk5wemJiVmZLdGV1NG9hTU1RZmlnVDJ1K2RiRU0xZFlG?=
 =?utf-8?B?TnhFSDlyWmUwczZoT0hST1NreUM0ZFRsdFR6YVBEc0dnUHM1cS9KV0JpTERn?=
 =?utf-8?B?UDlpV0RHazFxbzZsRXdDRWJtcDY4VXdZMkhDUGxoMW4wMFJ4VHcrenNNT1Jy?=
 =?utf-8?B?eVZQbFBQYXJuN0s1RUZ4K1VyTjZ5UEdxam9UZjZhNEZhZ09sZFBZRDBiekR4?=
 =?utf-8?B?R1VqWDAxL080dlVQM0txdmF0ZERjeEJIMGhQd2ErZUZ0L0luSGZ2ajJpOUZB?=
 =?utf-8?B?VHBSTXo2Q2lHYU93TnpJL1kwSFNYZmxKMU5FTk1uM0tzYVhScW1iQnFpVEpo?=
 =?utf-8?B?QTNuQWlkeUlXK3E1MVJiRU9vSXJKVnE0bDkyRWtuTDZ5Z3JJK3czbDNNU3Fh?=
 =?utf-8?B?VXlrVml4dVFWSXNnaFJPYXdxaU9tYlRGaGY3S294SGV1U3VBWDFCMS91Qk54?=
 =?utf-8?B?Nmk1UGoxR0lBeHQrdTVVVjRXckd1WmVFUVBMR0FtaFFuWUkrOC9IOS9Vcnkv?=
 =?utf-8?B?Tk83eThIRVVZWE5DUkhQRk1iaTFvciszK2Z5QUQwcWdYWk1WZGVTOXcrNG80?=
 =?utf-8?B?RU5TeHNIUGlEc21vaW5jcDFsV055WUxwZ2NPTEYrS1h0QUVkdldtQWpIaWRH?=
 =?utf-8?B?dlg2T3FqNU9lQnZwZzFWVFdQMXRDaEtZNW9yTDJxY2pSVTN6UzRHVXVTRWhv?=
 =?utf-8?B?SVBrc09JNmU4OEhFc0VuNU5oeG1pV0R5ZHI5L2pPTlNqc0xQTlhOejVQVmta?=
 =?utf-8?B?eFRCLzJEUmU4M0k1ZDZsNkNKZTZKUktYc1gvWHhvL0oxYzZZeVJRVFFiUnpO?=
 =?utf-8?B?KzZ3NFZ4c05DVTJSZ3l1eFBwN1A2bUhKUmVwRGt6UEw1WVJGemV2RDRkVldM?=
 =?utf-8?B?MU9vZEZTQ0RiV0NzUnBxUVVjMzZmaXkyMzZnemMwNG5CK2xVd2VtU1FYSVZM?=
 =?utf-8?B?NzFOaXVtM3BSZ01jK1VkY3dLU2s1RFhQeG5iTE5weHBmRkRwYXlEOW9TMGJB?=
 =?utf-8?B?UmJnQWlMS3RsRzN3RjFHWEhFYmZ3Q3l2NWNFdU5NSkNvbTJkSUNTWkNuNGd2?=
 =?utf-8?B?RVVOTkhza0g5RmpLU3Rtc25qWGFiK3VmUkpoenE4TkRUU0R6KzUvZ1RHS0FN?=
 =?utf-8?B?VzkrVEJQb1JLNnZrRjI3OVk2ZlduS09tU1dla2RGV0NZdWpXWG5YLzlUZ1dG?=
 =?utf-8?Q?8ilCL5N724TuqekdBxA3PyNZy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0C10CCD6B5D2D459AB5A263B7309E4C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	JYRC7XhDsiq8nr0v+9bXwEWplMjJcOnhlg1myu12Jozxmt+Std0XHoDmUA4f24fIqK4c6PrApKjmfvMWu8vS/aayVlm56E0AyG4DEncBSxP1tUyVNKcRQ3kHG83+UeP3TSah+PrvJpp4k+loTLG1zrBCE2+rfxnRrbKI4QmVaslmQVOONoGcK6Z5C7DqWSL/BEXKvxKSKAIucPUjz9vBHOmBnkHwmcVBdmR6avJ7Kl3C7zAObpAdFUeYhYSktNxCBbwiTQJwwKRyhkPJZSeivPNj53lNmG3E7Gz0rcxiIGV86Fg81+IliaUAuCLQw7eC+pAg01sPWWZbB0C76IvV4OTQ1vqN1wDKUN062J7NK3M6o7AtzQsiW00+8+x19uUKR8rD/nWoBjfUfDTqFQvjgoijPoeKZFjEAnRcuqWxNUf1bhrC3aeLUW6zSVeuE5WhzN1ndCA3MXHHdmQ4cOquhHA/FP3JkOxfQxUiPcU3VIDPJSLO87HuCd6aFHoGWjeKHMuHEU9Am09ksmVyV+FgTuR4/7cg4+ZKiS4METqckNl4csJSvecRkh+lDHb31w2XpaJELwYleQEPJh9xILMLj2NdD+pCrFVZd723F7Lq7FPvCuRT66avV9Q24EWrHBbHU5KxxwWvWXERtBpDlZN1JA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c6c567-9604-4015-0cd3-08dc34bcc1a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 22:14:08.6680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tsvQ4vJ3rP6QMVNswCJRcC9Rh4RSH/NzAhlFKB5Q0gzovrSKQJm+Da72jvme/CrDujDWb6ZkQju1GcY9zYpZtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6685
X-Proofpoint-GUID: UZe3-vNzvcOkqZtwKpK6q7HPjPQeqhwz
X-Proofpoint-ORIG-GUID: UZe3-vNzvcOkqZtwKpK6q7HPjPQeqhwz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 mlxlogscore=928 phishscore=0 impostorscore=0
 malwarescore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402230159

T24gV2VkLCBGZWIgMTQsIDIwMjQsIFJvZ2VyIFF1YWRyb3Mgd3JvdGU6DQo+IFdlIGNhbGxlZCBv
Zl9wbGF0Zm9ybV9wb3B1bGF0ZSgpIGluIC5wcm9iZSgpIHNvIGNhbGwgdGhlDQo+IGNsZWFudXAg
ZnVuY3Rpb24gb2ZfcGxhdGZvcm1fZGVwb3B1bGF0ZSgpIGluIC5yZW1vdmUoKS4NCj4gDQo+IEdl
dCByaWQgb2YgdGhlIG5vdyB1bm5uZWNlc3NhcnkgZHdjM190aV9yZW1vdmVfY29yZSgpLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogUm9nZXIgUXVhZHJvcyA8cm9nZXJxQGtlcm5lbC5vcmc+DQo+IC0t
LQ0KPiBDaGFuZ2Vsb2c6DQo+IA0KPiB2Mzogbm8gY2hhbmdlDQo+IHYyOiBubyBjaGFuZ2UNCj4g
CWh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwv
MjAyNDAyMDUxNDEyMjEuNTYwNzYtMi1yb2dlcnFAa2VybmVsLm9yZy9fXzshIUE0RjJSOUdfcGch
Zi0zMTdvREJVZW40dFFqTTRLa18xYkJrRDRPcnZWVnlkN1h2SUtqb3R1UWx4c1FWWHhab3EtUTZT
WklWX1g3VzJuRnFmc0F1d1RyTWhQVjNIcmVxJCANCj4gdjE6IGh0dHBzOi8vdXJsZGVmZW5zZS5j
b20vdjMvX19odHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDAyMDExMjEyMjAuNTUyMy0y
LXJvZ2VycUBrZXJuZWwub3JnL19fOyEhQTRGMlI5R19wZyFmLTMxN29EQlVlbjR0UWpNNEtrXzFi
QmtENE9ydlZWeWQ3WHZJS2pvdHVRbHhzUVZYeFpvcS1RNlNaSVZfWDdXMm5GcWZzQXV3VHJNaExo
STBCWnIkIA0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvZHdjMy1hbTYyLmMgfCAxMCArLS0t
LS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDkgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9kd2MzLWFtNjIuYyBiL2RyaXZl
cnMvdXNiL2R3YzMvZHdjMy1hbTYyLmMNCj4gaW5kZXggOTBhNTg3YmMyOWI3Li4xYmZjOWU2NzYx
NGYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1hbTYyLmMNCj4gKysrIGIv
ZHJpdmVycy91c2IvZHdjMy9kd2MzLWFtNjIuYw0KPiBAQCAtMjY3LDIxICsyNjcsMTMgQEAgc3Rh
dGljIGludCBkd2MzX3RpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJ
cmV0dXJuIHJldDsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIGludCBkd2MzX3RpX3JlbW92ZV9jb3Jl
KHN0cnVjdCBkZXZpY2UgKmRldiwgdm9pZCAqYykNCj4gLXsNCj4gLQlzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2ID0gdG9fcGxhdGZvcm1fZGV2aWNlKGRldik7DQo+IC0NCj4gLQlwbGF0Zm9y
bV9kZXZpY2VfdW5yZWdpc3RlcihwZGV2KTsNCj4gLQlyZXR1cm4gMDsNCj4gLX0NCj4gLQ0KPiAg
c3RhdGljIHZvaWQgZHdjM190aV9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikN
Cj4gIHsNCj4gIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiAgCXN0cnVjdCBk
d2MzX2FtNjIgKmFtNjIgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsNCj4gIAl1MzIgcmVn
Ow0KPiAgDQo+IC0JZGV2aWNlX2Zvcl9lYWNoX2NoaWxkKGRldiwgTlVMTCwgZHdjM190aV9yZW1v
dmVfY29yZSk7DQo+ICsJb2ZfcGxhdGZvcm1fZGVwb3B1bGF0ZShkZXYpOw0KPiAgDQo+ICAJLyog
Q2xlYXIgbW9kZSB2YWxpZCBiaXQgKi8NCj4gIAlyZWcgPSBkd2MzX3RpX3JlYWRsKGFtNjIsIFVT
QlNTX01PREVfQ09OVFJPTCk7DQo+IA0KPiAtLSANCj4gMi4zNC4xDQo+IA0KDQpBY2tlZC1ieTog
VGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGFua3MsDQpUaGlu
aA==

