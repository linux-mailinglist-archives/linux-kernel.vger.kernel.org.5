Return-Path: <linux-kernel+bounces-136045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A3B89CF57
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 02:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 278961C217B9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 00:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417E915A5;
	Tue,  9 Apr 2024 00:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NhB/sRQ6";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="masI8aff";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="e/AhIWAH"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF5B370;
	Tue,  9 Apr 2024 00:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712622543; cv=fail; b=eGnRYtbMwu5PqV37ZXz0kgn64sPJbVCeGx1AT9im7/6cp/fclZa+e8iR/rsuk3sw+SFbNSMyzujogLK+5EyW7WXqYh2UDLWobnh5mQyC4LQFs+dJ5A22E46ZSGiOYnV9MQiWG3YEeeAtflNP5MJAdbVn8Ocfx3ViM2cyqIYqGR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712622543; c=relaxed/simple;
	bh=364Ys0aIzo/bysP6jrBrcce8ErFwsUrK/QdtIgqc4oo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rpDfsuNrRddqW6w8HjnvGfelQCxIpiLxDkol+5B5YHxr7T3za382diKKyCZLus8OzFHPCbLc9O6zbrFkQPB17Zx9vICW5Sfw9ss3gU8M52XYdf4mP8QV+55Qf0vcjXzW8yy0WHeki+GxYBH2AbLD++hNkHvDZQd4wvsNBrofhn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=NhB/sRQ6; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=masI8aff; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=e/AhIWAH reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 438LA1Qh006965;
	Mon, 8 Apr 2024 17:28:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=364Ys0aIzo/bysP6jrBrcce8ErFwsUrK/QdtIgqc4oo=; b=
	NhB/sRQ6cp/nyK9Bqb86qMXBbuSOktyK7WYVZ6dF98/sVZYUtxGFGG0jP/YC9wei
	nClNwRbNpe0xpvmFcvhCyXgUVZInYUZsS2Yv0lGRQfO4DlAuAxZu4kg6F2h+/42H
	cuzWAFDSo9w7kAz9R4vLFDZkoXEycn9NTF+7JLfV/rx8LGwwqFSKi4YPC4HYWsg6
	FNucAk/Bx293YZSJe6z8cgJGyvMjp8bSVBEXtIjNjUpqhBxnti+mfVp8rC34ItL4
	Sr0CJS8i8FCPKhbTn7unffnZgpLP+ogyPZJOuRFcxOXO2qKF1N56UMlKY3ox1WAr
	12ltV8MnbbKRvLagZFXokQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3xb5asf8h8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 17:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1712622526; bh=364Ys0aIzo/bysP6jrBrcce8ErFwsUrK/QdtIgqc4oo=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=masI8affS/3Xb68mfNgZ9knSENsYHFSzenrNwOeWALRzcg1TiLx/b+XTdDrWrI0sP
	 eF/XyqYRbhcXFl0V7D2K9wvsdTf5dbe7gHtH5a+SId8v8mz03YI4H6lxXhP/FtaEFT
	 bcXtDx7HAclaCchAjP3835Y/lEbWnMLmHZdJhRy0VdST2oTteJmq+YstrUcdZoayHo
	 9I0NsidqJB3bQNDggmHH74gMc2MUIlYcS9W0McNBdq+ecAgOr9aIGe2KV8qjg6XqVe
	 BpNGLquTYFcN2kqyKGxcW8OdVV7rE9p1vK5aefvd77at0ejME8Aa6zgggTeBT3bMY5
	 6iq5KSicVbPoA==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 236FF40355;
	Tue,  9 Apr 2024 00:28:46 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 5427AA0081;
	Tue,  9 Apr 2024 00:28:45 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=e/AhIWAH;
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 8964C40408;
	Tue,  9 Apr 2024 00:28:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fA86icthrfGBN45BvciTZ+urAqomC5udsxb+RG0X7Uuz2Qr+vsYdOhbE1NfPyTSN0NWOq0FtJJ3dJT6UTYW8NpsGfb+6FbJnHh/oo3/fEtq+vOgYQJzpgq17iNyxcZFnhHQqjQ6iRF9P9z/RRnFJv1rfLEBvQGPOo6WIb0xd2ZfQLUcXTfc+R7W/u/dmqWqvI+af5xvtS9o7+o7ajl1pH6Wgp3ra7Vb7qHXtqs2nZlgZYWmSw+pdA30x0QfLExBAaLrXjM0Zl5ZKPZKxxF62fmLeCa7Lc0n17ac5MLDKOMsYVZzrEAaj/kXAhIjgLFe+PIySmaFQeOLeWXSkOQ515w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=364Ys0aIzo/bysP6jrBrcce8ErFwsUrK/QdtIgqc4oo=;
 b=hqzRBPq7CCajW439zSvwVCqD2ublE+qQldssq/ps1em1ufwiHBP9s3QrR8ZzSrigKdhlvrjkyxOBCmfXOnPomV3ZP5TghxJjm6oeMGRgLMPyMykwplJRYrpfWkdi5nHDu0Tl/M2WCpue5ZxMO8tQPtv7nQfkBCYqhZuUcSXVn5L9No95SImtwcbiwBCjLdg3jWfY+CciuI6l63E9WfTr+bh3irvqkBd5dD3fFiyBQO4S0Tou31BN8j0YYPLNb77MNEIWfvSRIfBi2MZ9gWPq6JAl6ZE1uilCmwcTBMWBDDh/dHdAVsC+0JvQT1gZIVmeTDJUnaU0GJKKUHdLzn8TVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=364Ys0aIzo/bysP6jrBrcce8ErFwsUrK/QdtIgqc4oo=;
 b=e/AhIWAHmbHpdZSLkmIdoiOJZ8MriLjOgJMeklWwHvlyXl4NNzptd6my2XHwQ4D2pl8LKyGVesgb9L1dACoViNW98WtHIowFXbSRueZYfH9Bz3d72u7qYZCYZX8dSer9UAF4JNJX2+Xzi1W3s1fyAIb73USa+5vCcoF0XgkazFg=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by IA1PR12MB6234.namprd12.prod.outlook.com (2603:10b6:208:3e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 00:28:38 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c%3]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 00:28:32 +0000
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
        Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH v20 2/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Thread-Topic: [PATCH v20 2/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Thread-Index: AQHaibjgWY0dUGVHmESzZZp88oI8TLFfFj6A
Date: Tue, 9 Apr 2024 00:28:32 +0000
Message-ID: <20240409002829.e6gyt3zp65o35srz@synopsys.com>
References: <20240408132925.1880571-1-quic_kriskura@quicinc.com>
 <20240408132925.1880571-3-quic_kriskura@quicinc.com>
In-Reply-To: <20240408132925.1880571-3-quic_kriskura@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|IA1PR12MB6234:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 N1w3zhOzMHapQi6H01OmWCPd9UgG8HPppwEPbhVcK249d7y99hhUNAk+AEDAorBOKX9jHHYwxRzNtOWHc1+93J1pMdzcb1NHm1z/NxuHjDyXfGcmiIJYoEueoBCdQHFZZXMiNp4xdH7k+QGM7drz7HW447UB/J/J9frJk+u5y2I4PNxVwWsTDRE1rSy7ahQeXoW0FDu+t5Cz+0oop6GhpGtRiT8JvC8iYCZjB5CkTNI15fBVFOPo9Ilnlx+mGhxI1D1ReGsIFIyUDJabjjHAt721QCRnzQ1n06muvA7ORse84HyPEo/qr3Ku7Cmixm2IasADpeGU0+iJVqwvrKHCxRtFxs+wA+jWx1EryumAVq6WS5nE+kwE53eQk/XUkEV5wQKwsROMjcBCQfs1m1UkqJlobO/9sF1LjZ0TGLmNqbmJsWN/NzBxhjtabOuM69VQcXUxXUHOPfRRHK3pdSl2VTW/crXiQ9G0WFhzmP/5y8qbBgUH1CB5hmvjM7zQ6+UDO5jM0mLrd9U3SKpvmiK/djLxkykxuak7+5FBUNMSGQcaA+HrsDP8d+fl1YboJQx8zdY4E6x2gfaHf66v/OdT7BUvnLP9KGhxa0iChAKU486vCFBw0Bz+p5S0c4EdCqqcZi5ivhovMJR1S1Lw8OiUkDYTRvDbLfLRlIv62ucSoFs=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WHdCNjJvTy9USkIwZjBMZ3o2RTVjeGc0Qm5oVmYxZm94ZzBYMnU4S1hKeWIy?=
 =?utf-8?B?cXRQek1jOWs5WU85MENUOXBQN3FlbU5uWUovVEk2NTlVV2h0a1VKaWp2MFU4?=
 =?utf-8?B?Sks2aCtMRFQ5WmFFZW5CTCtiWlptSGZqKzdqM2ZpbHlCN0R0RkJCNFhrcEpo?=
 =?utf-8?B?eVc5U0xvaTFNbjUvdGZ0YWdHRi9Rd05uSXJIWng1RmMvc0x5NHcwaG9BUXQ5?=
 =?utf-8?B?RVJzb2U0N2paYkVlbFF0RnRJWC9aUStwTFpuYkplVlFtVEt0Qzh4UUhrazQw?=
 =?utf-8?B?R29JSWlZYUg1TUN4a0MrYzI0L0UxNWEwbU9md3RXalU0OUcyNzFlOHlrc2Nv?=
 =?utf-8?B?V2k4UGQrRGVrWkZEbERNMHRCSW92eVpjV0pqYStVOERBMG9sbnZOVHhOaVFn?=
 =?utf-8?B?djBWM3U2dTNGQm9jUEtESm9ZbENaUjBWVkRNUzJ1c3YvcGhpSDFDaVZ0U1gz?=
 =?utf-8?B?eEswZHB4UWY3MS8xVjN0YWpTME4rMURaSW01TkIzaGJCdHRqS0hlMWtBbm0v?=
 =?utf-8?B?UDZtbmEvMkNYcW1ZMFRIMy9hOGJYc3cyc3g0L2JySms1SXBNcGkyMFh3QVpI?=
 =?utf-8?B?c3JuUHZaK0JicXp0T1grQnVFcC9kekR2ZURXYnBFWWdsbTl1QTB1UUVSL01k?=
 =?utf-8?B?WDVnMUNVZ3BSdmNRbHRmeHBsZ3oxQkIrdjJVUGRaMmRwT2hYbHAyd1JVT01a?=
 =?utf-8?B?OUxEaDBRaDI2Si9UWnVXZVlmemxVMEQyYmV4WG5DbmRZd0VPT0k3TWZFYmsz?=
 =?utf-8?B?Q3pobzN4aGw1VklJQVNjRWZaWmdjV1JEQmxEK2pDeldFYjhrUlRFSXN0cVNK?=
 =?utf-8?B?YUkvZ1RPcC95dXowZ1habVVZUmM5SVVUNHhLcDdjdVpqdDVDM3FOTDBWbi9I?=
 =?utf-8?B?VVF3dUVET2ovc0dITU55ZkFmK1RGc2MzenM2WjBtSHVnR2JUcWdDZ3pyOTVC?=
 =?utf-8?B?ZW9MVlVUdlFVa0VKTTRhZCtDS1RYWHlNOE1laEw0NUs4dlRUQVNnQzltQ1hu?=
 =?utf-8?B?WXJ2ZExKdEZIRWIzVWt3eFhuU2NOc25KTGd3YmhZZm1HWDlvUFA0N0pFaUVi?=
 =?utf-8?B?T01zZlZBdDY2ZmFzL1BSZ1ZRMjBrU2s4aE1wSm53MnBOVzRNTFo3ZjlFb1R4?=
 =?utf-8?B?RzNRQ3BvN3hXMnEvK0FoZFBkTERIRmIvSHVET3lQeVI1cWFEdUZHRGhIajBs?=
 =?utf-8?B?MWVodm90RzhvQ21HU0tySmdNdzBPak1EZzExN3oxbGc1SnhYYmlLeGMyQ1lR?=
 =?utf-8?B?a1gwbmpNZzQ3VFJ0eTlLRk5md0pWZ0hvVnJ2QkRjeGljdkd1UXZMdWhzSUxT?=
 =?utf-8?B?QXdnUXF0UUVQZWFvSFRoT1VCM1hOeFFLZjVBVndkUFBRVXVkM045OEt0cW9G?=
 =?utf-8?B?V1ZXWkJzY3JlVjJPd0VjdXpYenBSTkJXZFdhUkRJcy82dGR1SzJFTHVWcXps?=
 =?utf-8?B?enlrOGNqWnNIVy92dFVuNDVNaWNFY0ljT2V1Rk5scFJhOFV6S0R6M1VZYkJG?=
 =?utf-8?B?YmhtS25EYXVma1lReitJakQwaU4zTVNzTEJJRmZnRUtTaTFsVklSUkd2dlo0?=
 =?utf-8?B?emt0R3M3OU9XVEJSdG1SVGlXTGYvNmU5YVRzeDZFNjVLcUdjU2hPd252SnM1?=
 =?utf-8?B?akRiLzZkbTJaUUNuM2RJU1pFNWR5alF3S0pNTEpSazluRW5vVjNFZEJvazlm?=
 =?utf-8?B?cWpwNEgyZW1wTVdtQVIwQzUyYmkwOHJxdzdLRVplMWFoVkVoTFkrN2xLcXI5?=
 =?utf-8?B?QnBHV1VBOGZ0dXV1cVFjSnZ1N0drUnlITXlNTDZWVG02WVI2ZVdTV3FLUnpx?=
 =?utf-8?B?eHUxVmp6OE1kUklJR3p6R2Z2VnVSK3A4aFovUU1Zd2hmREYvdC9OYkVJRFov?=
 =?utf-8?B?V1lpcXhpMFJERllDcmhGejFaQlV3T2VFOTVBRkxvWkxEY3BLWWZzQ1NTazFr?=
 =?utf-8?B?ZUdQclJtcUJ5MUdOWlNJaFBkWkFzNUNkNFhVQjFQL2ZLNWJCK24vRWEyQWJC?=
 =?utf-8?B?bW1lbjFET3VZdTRtTk85RUhncUhjSzRXTXZIdUU4UWFCZk82blJwemhXNktu?=
 =?utf-8?B?UytwUUo5dVNjNE5Hb1RZbVBIc0RSdm1PL2hCNXRHdUVyd1IzTjRnM0R1RGQx?=
 =?utf-8?B?Z0Z3N2JsbzZtQUFNcm13ZFp0NW9nMkNndE5DTGhRL2tsN094ajFxc1R6NUU1?=
 =?utf-8?B?bUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <637DA3392CC9D947888579C55AEDE05F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	j56MvEmmO0F0Nl90n+LbQJwVSTfofXdXrT9xLD6DkDzLLIVl3yf2S9y9k/FKPzo3oj0mSds8oNqMxNXTwQghHMV5IBvSsX4PQTi+enT8yg+FnObZ/S01UYTCRvB85ct4dE3u+xfv8OPhtUpX23tedxage4WTgkt/kHjwq4Ck4nLBaN0Xm/ncnaCZrBqiykAw6KdzhDFku1kOrE+CbkO+0CMADvFTtPrFTLTD2EH3vme7DWBFoSE25xXASCbcflfDrWB8qop86nkjpMaCSx+JaLbB105shE6lzMrCNGT8cdxdJhgq44D7XikVDY/fs5P9UYQ6uk/k2FJQp9CDmh0fWLSzvj8oPRLi4e69peK3YFDQPMgjBnOcACgbVHXswGBEKLEzBel9wmlCbF/Rcc4gLbihRTiqUNhkyQ9jhmbyJ/ueOLlLQcx+lKJlZ5c8B0C9gH98PNPlBorHZmGK2sQ6wr2aL1JayN+Swv4AlC5RTMzceQ0g/Qo1kltWlv+4t2JHDOePkJewauwkes/mrGP+SQD0LsIgySErE7Hntv4ArGHtbXPd4pW0lcZ3ri3qvyTKtJwNkeYLlkM3UHTey4pnXh7rHNUYx9fpaWQmGv6weVkp8SUiqk6Y8wKMr1GLDgn5xx7P3pHVs8+vRhkPjI9iEQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2093bb53-d38e-4e4d-1681-08dc582bfca1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 00:28:32.4893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sX7CeXIEDqs5eVwcKhhMHhfiXGYV0nyVWBY8ZsWwjktIW9ZrxaL9aTGti/L5Aw/7mF+asw4Cste0hq6ZoBVyUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6234
X-Proofpoint-ORIG-GUID: Qd7Y4d3-GD5C_nYYhcctwM0HshVJYkzu
X-Proofpoint-GUID: Qd7Y4d3-GD5C_nYYhcctwM0HshVJYkzu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_18,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=999 mlxscore=0 clxscore=1011 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404090000

T24gTW9uLCBBcHIgMDgsIDIwMjQsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+IEFsbCBEV0Mz
IE11bHRpIFBvcnQgY29udHJvbGxlcnMgdGhhdCBleGlzdCB0b2RheSBvbmx5IHN1cHBvcnQgaG9z
dCBtb2RlLg0KPiBUZW1wb3JhcmlseSBtYXAgWEhDSSBhZGRyZXNzIHNwYWNlIGZvciBob3N0LW9u
bHkgY29udHJvbGxlcnMgYW5kIHBhcnNlDQo+IFhIQ0kgRXh0ZW5kZWQgQ2FwYWJpbGl0aWVzIHJl
Z2lzdGVycyB0byByZWFkIG51bWJlciBvZiB1c2IyIHBvcnRzIGFuZA0KPiB1c2IzIHBvcnRzIHBy
ZXNlbnQgb24gbXVsdGlwb3J0IGNvbnRyb2xsZXIuIEVhY2ggVVNCIFBvcnQgaXMgYXQgbGVhc3Qg
SFMNCj4gY2FwYWJsZS4NCj4gDQo+IFRoZSBwb3J0IGluZm8gZm9yIHVzYjIgYW5kIHVzYjMgcGh5
IGFyZSBpZGVudGlmaWVkIGFzIG51bV91c2IyX3BvcnRzDQo+IGFuZCBudW1fdXNiM19wb3J0cy4g
VGhlIGludGVudGlvbiBpcyBhcyBmb2xsb3dzOg0KPiANCj4gV2hlcmV2ZXIgd2UgbmVlZCB0byBw
ZXJmb3JtIHBoeSBvcGVyYXRpb25zIGxpa2U6DQo+IA0KPiBMT09QX09WRVJfTlVNQkVSX09GX0FW
QUlMQUJMRV9QT1JUUygpDQo+IHsNCj4gCXBoeV9zZXRfbW9kZShkd2MtPnVzYjJfZ2VuZXJpY19w
aHlbaV0sIFBIWV9NT0RFX1VTQl9IT1NUKTsNCj4gCXBoeV9zZXRfbW9kZShkd2MtPnVzYjNfZ2Vu
ZXJpY19waHlbaV0sIFBIWV9NT0RFX1VTQl9IT1NUKTsNCj4gfQ0KPiANCj4gSWYgbnVtYmVyIG9m
IHVzYjIgcG9ydHMgaXMgMywgbG9vcCBjYW4gZ28gZnJvbSBpbmRleCAwLTIgZm9yDQo+IHVzYjJf
Z2VuZXJpY19waHkuIElmIG51bWJlciBvZiB1c2IzLXBvcnRzIGlzIDIsIHdlIGRvbid0IGtub3cg
Zm9yIHN1cmUsDQo+IGlmIHRoZSBmaXJzdCAyIHBvcnRzIGFyZSBTUyBjYXBhYmxlIG9yIHNvbWUg
b3RoZXIgcG9ydHMgbGlrZSAoMiBhbmQgMykNCj4gYXJlIFNTIGNhcGFibGUuIFNvIGluc3RlYWQs
IG51bV91c2IyX3BvcnRzIGlzIHVzZWQgdG8gbG9vcCBhcm91bmQgYWxsDQo+IHBoeSdzIChib3Ro
IGhzIGFuZCBzcykgZm9yIHBlcmZvcm1pbmcgcGh5IG9wZXJhdGlvbnMuIElmIGFueQ0KPiB1c2Iz
X2dlbmVyaWNfcGh5IHR1cm5zIG91dCB0byBiZSBOVUxMLCBwaHkgb3BlcmF0aW9uIGp1c3QgYmFp
bHMgb3V0Lg0KPiBudW1fdXNiM19wb3J0cyBpcyB1c2VkIHRvIG1vZGlmeSBHVVNCM1BJUEVDVEwg
cmVnaXN0ZXJzIHdoaWxlIHNldHRpbmcgdXANCj4gcGh5J3MgYXMgd2UgbmVlZCB0byBrbm93IGhv
dyBtYW55IFNTIGNhcGFibGUgcG9ydHMgYXJlIHRoZXJlIGZvciB0aGlzLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogS3Jpc2huYSBLdXJhcGF0aSA8cXVpY19rcmlza3VyYUBxdWljaW5jLmNvbT4NCj4g
UmV2aWV3ZWQtYnk6IEJqb3JuIEFuZGVyc3NvbiA8cXVpY19iam9yYW5kZUBxdWljaW5jLmNvbT4N
Cj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyB8IDYxICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCB8ICA1
ICsrKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgNjYgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMN
Cj4gaW5kZXggMzE2ODRjZGFhYWUzLi5kZGFiMzA1MzFmOGEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvdXNiL2R3YzMvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IEBA
IC0zOSw2ICszOSw3IEBADQo+ICAjaW5jbHVkZSAiaW8uaCINCj4gIA0KPiAgI2luY2x1ZGUgImRl
YnVnLmgiDQo+ICsjaW5jbHVkZSAiLi4vaG9zdC94aGNpLWV4dC1jYXBzLmgiDQo+ICANCj4gICNk
ZWZpbmUgRFdDM19ERUZBVUxUX0FVVE9TVVNQRU5EX0RFTEFZCTUwMDAgLyogbXMgKi8NCj4gIA0K
PiBAQCAtMTg4MSwxMCArMTg4Miw1NiBAQCBzdGF0aWMgaW50IGR3YzNfZ2V0X2Nsb2NrcyhzdHJ1
Y3QgZHdjMyAqZHdjKQ0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgaW50IGR3
YzNfZ2V0X251bV9wb3J0cyhzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiArew0KPiArCXZvaWQgX19pb21l
bSAqYmFzZTsNCj4gKwl1OCBtYWpvcl9yZXZpc2lvbjsNCj4gKwl1MzIgb2Zmc2V0Ow0KPiArCXUz
MiB2YWw7DQo+ICsNCj4gKwkvKg0KPiArCSAqIFJlbWFwIHhIQ0kgYWRkcmVzcyBzcGFjZSB0byBh
Y2Nlc3MgWEhDSSBleHQgY2FwIHJlZ3Mgc2luY2UgaXQgaXMNCj4gKwkgKiBuZWVkZWQgdG8gZ2V0
IGluZm9ybWF0aW9uIG9uIG51bWJlciBvZiBwb3J0cyBwcmVzZW50Lg0KPiArCSAqLw0KPiArCWJh
c2UgPSBpb3JlbWFwKGR3Yy0+eGhjaV9yZXNvdXJjZXNbMF0uc3RhcnQsDQo+ICsJCSAgICAgICBy
ZXNvdXJjZV9zaXplKCZkd2MtPnhoY2lfcmVzb3VyY2VzWzBdKSk7DQo+ICsJaWYgKCFiYXNlKQ0K
PiArCQlyZXR1cm4gLUVOT01FTTsNCj4gKw0KPiArCW9mZnNldCA9IDA7DQo+ICsJZG8gew0KPiAr
CQlvZmZzZXQgPSB4aGNpX2ZpbmRfbmV4dF9leHRfY2FwKGJhc2UsIG9mZnNldCwNCj4gKwkJCQkJ
CVhIQ0lfRVhUX0NBUFNfUFJPVE9DT0wpOw0KPiArCQlpZiAoIW9mZnNldCkNCj4gKwkJCWJyZWFr
Ow0KPiArDQo+ICsJCXZhbCA9IHJlYWRsKGJhc2UgKyBvZmZzZXQpOw0KPiArCQltYWpvcl9yZXZp
c2lvbiA9IFhIQ0lfRVhUX1BPUlRfTUFKT1IodmFsKTsNCj4gKw0KPiArCQl2YWwgPSByZWFkbChi
YXNlICsgb2Zmc2V0ICsgMHgwOCk7DQo+ICsJCWlmIChtYWpvcl9yZXZpc2lvbiA9PSAweDAzKSB7
DQo+ICsJCQlkd2MtPm51bV91c2IzX3BvcnRzICs9IFhIQ0lfRVhUX1BPUlRfQ09VTlQodmFsKTsN
Cj4gKwkJfSBlbHNlIGlmIChtYWpvcl9yZXZpc2lvbiA8PSAweDAyKSB7DQo+ICsJCQlkd2MtPm51
bV91c2IyX3BvcnRzICs9IFhIQ0lfRVhUX1BPUlRfQ09VTlQodmFsKTsNCj4gKwkJfSBlbHNlIHsN
Cj4gKwkJCWRldl93YXJuKGR3Yy0+ZGV2LCAidW5yZWNvZ25pemVkIHBvcnQgbWFqb3IgcmV2aXNp
b24gJWRcbiIsDQo+ICsJCQkJIG1ham9yX3JldmlzaW9uKTsNCj4gKwkJfQ0KPiArCX0gd2hpbGUg
KDEpOw0KPiArDQo+ICsJZGV2X2RiZyhkd2MtPmRldiwgImhzLXBvcnRzOiAldSBzcy1wb3J0czog
JXVcbiIsDQo+ICsJCWR3Yy0+bnVtX3VzYjJfcG9ydHMsIGR3Yy0+bnVtX3VzYjNfcG9ydHMpOw0K
PiArDQo+ICsJaW91bm1hcChiYXNlKTsNCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+
ICBzdGF0aWMgaW50IGR3YzNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4g
IHsNCj4gIAlzdHJ1Y3QgZGV2aWNlCQkqZGV2ID0gJnBkZXYtPmRldjsNCj4gIAlzdHJ1Y3QgcmVz
b3VyY2UJCSpyZXMsIGR3Y19yZXM7DQo+ICsJdW5zaWduZWQgaW50CQlod19tb2RlOw0KPiAgCXZv
aWQgX19pb21lbQkJKnJlZ3M7DQo+ICAJc3RydWN0IGR3YzMJCSpkd2M7DQo+ICAJaW50CQkJcmV0
Ow0KPiBAQCAtMTk2OCw2ICsyMDE1LDIwIEBAIHN0YXRpYyBpbnQgZHdjM19wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCQkJZ290byBlcnJfZGlzYWJsZV9jbGtzOw0KPiAg
CX0NCj4gIA0KPiArCS8qDQo+ICsJICogQ3VycmVudGx5IG9ubHkgRFdDMyBjb250cm9sbGVycyB0
aGF0IGFyZSBob3N0LW9ubHkgY2FwYWJsZQ0KPiArCSAqIGNhbiBoYXZlIG1vcmUgdGhhbiBvbmUg
cG9ydC4NCj4gKwkgKi8NCj4gKwlod19tb2RlID0gRFdDM19HSFdQQVJBTVMwX01PREUoZHdjLT5o
d3BhcmFtcy5od3BhcmFtczApOw0KPiArCWlmIChod19tb2RlID09IERXQzNfR0hXUEFSQU1TMF9N
T0RFX0hPU1QpIHsNCj4gKwkJcmV0ID0gZHdjM19nZXRfbnVtX3BvcnRzKGR3Yyk7DQo+ICsJCWlm
IChyZXQpDQo+ICsJCQlnb3RvIGVycl9kaXNhYmxlX2Nsa3M7DQo+ICsJfSBlbHNlIHsNCj4gKwkJ
ZHdjLT5udW1fdXNiMl9wb3J0cyA9IDE7DQo+ICsJCWR3Yy0+bnVtX3VzYjNfcG9ydHMgPSAxOw0K
PiArCX0NCj4gKw0KPiAgCXNwaW5fbG9ja19pbml0KCZkd2MtPmxvY2spOw0KPiAgCW11dGV4X2lu
aXQoJmR3Yy0+bXV0ZXgpOw0KPiAgDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2Nv
cmUuaCBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+IGluZGV4IDdlODBkZDNkNDY2Yi4uMzQx
ZTRjNzNjYjJlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiArKysg
Yi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiBAQCAtMTAzOSw2ICsxMDM5LDggQEAgc3RydWN0
IGR3YzNfc2NyYXRjaHBhZF9hcnJheSB7DQo+ICAgKiBAdXNiM19waHk6IHBvaW50ZXIgdG8gVVNC
MyBQSFkNCj4gICAqIEB1c2IyX2dlbmVyaWNfcGh5OiBwb2ludGVyIHRvIFVTQjIgUEhZDQo+ICAg
KiBAdXNiM19nZW5lcmljX3BoeTogcG9pbnRlciB0byBVU0IzIFBIWQ0KPiArICogQG51bV91c2Iy
X3BvcnRzOiBudW1iZXIgb2YgVVNCMiBwb3J0cw0KPiArICogQG51bV91c2IzX3BvcnRzOiBudW1i
ZXIgb2YgVVNCMyBwb3J0cw0KPiAgICogQHBoeXNfcmVhZHk6IGZsYWcgdG8gaW5kaWNhdGUgdGhh
dCBQSFlzIGFyZSByZWFkeQ0KPiAgICogQHVscGk6IHBvaW50ZXIgdG8gdWxwaSBpbnRlcmZhY2UN
Cj4gICAqIEB1bHBpX3JlYWR5OiBmbGFnIHRvIGluZGljYXRlIHRoYXQgVUxQSSBpcyBpbml0aWFs
aXplZA0KPiBAQCAtMTE4Nyw2ICsxMTg5LDkgQEAgc3RydWN0IGR3YzMgew0KPiAgCXN0cnVjdCBw
aHkJCSp1c2IyX2dlbmVyaWNfcGh5Ow0KPiAgCXN0cnVjdCBwaHkJCSp1c2IzX2dlbmVyaWNfcGh5
Ow0KPiAgDQo+ICsJdTgJCQludW1fdXNiMl9wb3J0czsNCj4gKwl1OAkJCW51bV91c2IzX3BvcnRz
Ow0KPiArDQo+ICAJYm9vbAkJCXBoeXNfcmVhZHk7DQo+ICANCj4gIAlzdHJ1Y3QgdWxwaQkJKnVs
cGk7DQo+IC0tIA0KPiAyLjM0LjENCj4gDQoNCkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5o
Lk5ndXllbkBzeW5vcHN5cy5jb20+DQoNClRoYW5rcywNClRoaW5o

