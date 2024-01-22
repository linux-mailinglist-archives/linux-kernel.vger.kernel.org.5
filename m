Return-Path: <linux-kernel+bounces-33619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71712836C5E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0E111F24F96
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90A9605B2;
	Mon, 22 Jan 2024 15:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="U2t5yHk+";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WNXztdLV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ouYu6Pon"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADAF604C7;
	Mon, 22 Jan 2024 15:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705938315; cv=fail; b=bKOvaYF8IjZOX67FGlC8V70Zip12Apx0a5V9ftypTNadjuH6ttJcFN8tZV7k6C6NPQGE9CyH1cFJllpyl9Hc9rkJiQYT8Amcuf3gRAHZpj4IXmsJJwshjBs4Moebe8NQTuoYxuJ6LtnBipcbMqWuXTbGFr46Qcse+6zb6pOu4AM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705938315; c=relaxed/simple;
	bh=X1B1R6wLPU9yyyRcXAxBwxXGa5PLOqIacXYIR1GEzEk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CJvHZyhajEbw0HKbGgJVlCyO8+cUkfRNE8TIi1TVv3pkgBnjByqGdWrYMeLEzhi58LHow0d7jZykUQUwKiDJ+A+IAYLszDdUp6sTvjd2vD3H1ZIKK+3huquAyVBg0eK1I325hbCdu2KkJJ/FOiMtQVB7J19doCjmLkXr5hvqJCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=U2t5yHk+; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=WNXztdLV; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ouYu6Pon reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40MElGae004849;
	Mon, 22 Jan 2024 07:44:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	pfptdkimsnps; bh=X1B1R6wLPU9yyyRcXAxBwxXGa5PLOqIacXYIR1GEzEk=; b=
	U2t5yHk+DFa4eewRJSQMrAdTdI0E9GJTGTfVOutA8EV2ERDuR0YxVTem2Hgn8GOa
	u4+XT8P0IQh3mPSob0RbckaPZRWljARrV3nXkxklt4r+6YFniJWb2/eWN1COBfmF
	bw6BRnbj+wUYkyMnZzP71simmlNYFPUNxspSwz+coa/jck15ZSeTe+v5tT6P4/pN
	AFtKD3Kb8VVJK/3Xasnsivh+XyydR0szjrvHpaphs9nE4RRz75YuCSzkIehM7YBa
	Rt33spa3h0ndZRqJAQV8HTbArjvHIAP3pBVti4mh/TmxdAzKrPNhDHy6THbcUW0w
	g3byfKSnPEr8JIilM47oLQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3vrdywg29p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 07:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1705938275; bh=X1B1R6wLPU9yyyRcXAxBwxXGa5PLOqIacXYIR1GEzEk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=WNXztdLVNGQIE9m5zYM0aW9U+AeznRjNYDpKWaUwi6Uhrywh1xIH4tzlaMlwqt8nS
	 Lr4dbgNoRw9fBCn20gvFRFqCqWmKmNZL87fU1VFvIWcE+cHo0gZKCsZBacRPxC8jyF
	 Ln6sK1cYGRUWWWvdcJ33m3kb+C9x9FaMJBJIKQx7EEmeF4nxRPwR95UAiDE8EmXv1T
	 AI6Xn35GLkrl6XdgxRmXZ2EZdi98nqt2jQ7kJe5aZHsWZBx4lyiDryS48On5nBvS15
	 mbAwxoKQmjcOl9dyLWHZXBtRFEleqtBTi9aR5UiCHomlvH1YNvDgyas40Mhb8QG9mM
	 quN1StxUBktFg==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1084B4054D;
	Mon, 22 Jan 2024 15:44:32 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id ACB0CA00DE;
	Mon, 22 Jan 2024 15:44:30 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=ouYu6Pon;
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 81A65404D6;
	Mon, 22 Jan 2024 15:44:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qp6b5FvkiAzBJWmqPI2LzzpHicPfseSRL2zGyzzwKOEVUj/CsLdMP+zZ2EWlEkUPmG4qX6oxso3FTY7X1IAGbgnxsEKk2Bs6FYmWZRrg0OWtw2Ovdy4MGW1xYpfFBpu3bBl2sM7z6Lb9o7MMLQydWDQ6GjBRkCoWtqRR19Tc3TkvBZI6mhxPaH1dC+djqVVQYTw9/zOQPm1EHpXBBNyoQrPEHbqFInq79EVDICjExRZVrIePrB/RnmfRGw0C4QLMSyyCwWhVcwwXEmyOLARwmhlzJ+8Uqb8Yr1mTsakVON7FxI9M9RrYQm2sI5/HS3hwUNeFogmVVJpuWPHv9VQKLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1B1R6wLPU9yyyRcXAxBwxXGa5PLOqIacXYIR1GEzEk=;
 b=UhjfhVSYSPd3GFIhTiwFOH6eRkhGTuVWxEXtWDxgb/Vntpms738OtCnjAFqmXUmP1x7J4Dh8YR/iQm1Wa58XxZ8GusddMZSV8hTAEJwJ4NqUoP+56WumRaVciI+fQ8AoCpvlUhymHkOJblwOPZMpzbhtAln8DTlsZvla7/TWBp08QFGLBk6r+n/Q7ul9Z/jEVRZke0vhrVcPM7uBU/GeRkz9pMcau9XEsS/CYkAXGEaVQwh5daHbv7TwvHVbLZYQpp0u7AJgwysBJT+iQ+o5fbGz/2hLXmrZvFfnRNtIto0tJGi0cpnFamA9B0kjWn+NMnNLXFOPGcHrAabShFzo6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1B1R6wLPU9yyyRcXAxBwxXGa5PLOqIacXYIR1GEzEk=;
 b=ouYu6PonHmsJzbiEHYuiCCqogv9WL+qVD5A3E3AL3gUcO0UcypfwU9NnY+aLNf7ADaZGShyHi44jcS0cr0vrOB5k5ALaGF1hipgtNBZNeaMki+MW4i9VGg5NM5bs2NL620pzXpr8DgrTLg4Vn3/XTVx/kUvMexSogJr4nuSU6JA=
Received: from DM4PR12MB5088.namprd12.prod.outlook.com (2603:10b6:5:38b::9) by
 MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Mon, 22 Jan
 2024 15:44:19 +0000
Received: from DM4PR12MB5088.namprd12.prod.outlook.com
 ([fe80::5d56:80df:e884:3a2e]) by DM4PR12MB5088.namprd12.prod.outlook.com
 ([fe80::5d56:80df:e884:3a2e%6]) with mapi id 15.20.7202.034; Mon, 22 Jan 2024
 15:44:19 +0000
X-SNPS-Relay: synopsys.com
From: Jose Abreu <Jose.Abreu@synopsys.com>
To: Bernd Edlinger <bernd.edlinger@hotmail.de>, Andrew Lunn <andrew@lunn.ch>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiri Pirko <jiri@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jose Abreu <Jose.Abreu@synopsys.com>
Subject: RE: [PATCH v2] net: stmmac: Wait a bit for the reset to take effect
Thread-Topic: [PATCH v2] net: stmmac: Wait a bit for the reset to take effect
Thread-Index: 
 AQHaR+f2GstLsKb9/0S+PUQyg8BFNbDdCMAAgAExZgCAAACJsIAChBOAgAAsIgCABIFvAIAAlR4A
Date: Mon, 22 Jan 2024 15:44:19 +0000
Message-ID: 
 <DM4PR12MB50880D31E415D0DD95D991F9D3752@DM4PR12MB5088.namprd12.prod.outlook.com>
References: 
 <AS8P193MB1285DECD77863E02EF45828BE4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285EEAFE30C0DE7B201D33CE46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <6e33c038-45a7-4941-b5d9-ce5704e13d48@lunn.ch>
 <AS8P193MB128591BBF397DC664D7D860EE4722@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <DM4PR12MB50883D41B18E8627FBDF5E32D3722@DM4PR12MB5088.namprd12.prod.outlook.com>
 <AS8P193MB1285B34B71F3143FA9B0A053E4702@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <DM4PR12MB5088435544A3D355C94632DFD3702@DM4PR12MB5088.namprd12.prod.outlook.com>
 <AS8P193MB1285D9F82E8065739C0AD962E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
In-Reply-To: 
 <AS8P193MB1285D9F82E8065739C0AD962E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcam9hYnJldVxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTE4ZGFmNDFkLWI5M2QtMTFlZS04NjNjLTNjMjE5Y2RkNzFiNFxhbWUtdGVzdFwxOGRhZjQxZi1iOTNkLTExZWUtODYzYy0zYzIxOWNkZDcxYjRib2R5LnR4dCIgc3o9IjI0MTUiIHQ9IjEzMzUwNDExODU2NjM5NTEzOCIgaD0iWjNqb3I1cFFPOWNZRm91WjV3STVTa2RHWHVjPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5088:EE_|MW4PR12MB5667:EE_
x-ms-office365-filtering-correlation-id: bbccede2-2c51-40c1-fc95-08dc1b60ff1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 PlW8B+Yr+6TTBeD47HUxNfB7e2mAgO776JokbuHYtBbimJpa9LUiP/Tmqzmwhdo/I42CGDCLutBtOPncNBEu4PM0o+HLRh+Zh21xgLtlX85JVfumDxF0555NR81AiGCnTFVKahdtDwDt6kUBdNgNcwxYj9UQYhQEv9R3Rx0Lyc1qRLgxJCRoTnipdgBc2SX0sXJXkpVAwhftJq29Kt39fCwYsUNAy/OziOlRnZgwWPz5QxS61Hvg/EWiGPjJWOcv3EBVs5mVn2cp5XAJerw49KgCncDGx2ARLqLNs4Q01hR6FnByiXreuj599dFEFWRi06rwXXLMkq2Jtw3KJdWFlR6foUkApVhCAD3+tS1Dhkvd4lAICsqZgky9RQD83ekgBxK46QHpVg9jHzePIHviqrNhxWbM2pVcC416SMcMU5awPsZX77pTTUGzY1n6hX6V3kAsAVoxbI4PyWHlhkMAkpKau4OcZWc7RcXPfD3Wx744kjHcGfoBT0xKiwNlmZ3nTRyJV2mhGuY9DbEEYUqRndtUJ5n/adQhP16m0rw5tpFjDikZzHZpGtk2M5jQP7/tqjKM+kMkp5vsSSrYNvkkh18rczeGD4K/WmsA0Ej+SdX3N9DPNtlrPjqxINpEhTg1
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5088.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(396003)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(71200400001)(53546011)(38100700002)(41300700001)(86362001)(33656002)(2906002)(8676002)(122000001)(7696005)(478600001)(6506007)(316002)(76116006)(66556008)(66946007)(52536014)(7416002)(83380400001)(5660300002)(64756008)(9686003)(4326008)(66446008)(66476007)(54906003)(107886003)(110136005)(26005)(8936002)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MGFOUk5HV1BNWkJ5VWxZOXNlWUxERlJidWFiQTFTcGdiZlRRMWhPMFZad01o?=
 =?utf-8?B?UU0veEpZWHdicHFOQlNpRU5ydnBYUUhpZm9RWUljY0UxeXlWMzYrT1V5a0pE?=
 =?utf-8?B?a0dob3NWVnJYMjYyVlIvZ002UmNGL0RhYlhXVlNHR0xiZk84ZHkvdHQzeHla?=
 =?utf-8?B?UTNNMWRWOE1Jc3lMOGZna2U0SW5rc01aSDVBdWxGQWx1Y2JvZXNtRWt1WEJt?=
 =?utf-8?B?WmR1K280NzdTQkxvSUllUWRZbzVFSW1DZG1nZXFXc2hHeHIxU2pZbGhjMW9E?=
 =?utf-8?B?WWZ0S2hVYWFiQWNYSVJ2a1RDd0hhQnZ3SEUzU3c2dStnSnBWNTdYNXRDZTEv?=
 =?utf-8?B?OW9hVDZLdE93ZVF6TE1LUWg2c0g1dG9tWm5JMHVoU2lBWkJvTjhXYmliSnc2?=
 =?utf-8?B?SXlSM3RXaVVGRU1WbkdCTk1qR2R6aWx1enpVcHA1WGZaVVlDSkJna05CQ1lq?=
 =?utf-8?B?bzdyTDNObEtHemFUd010NVdEK3ZYVFZ6cTBEcFYzKzBxclhxNjVvU1JDM2Mx?=
 =?utf-8?B?VU82R0NhTWxlVjFTMmo3QXNCL1pHcExWMHhzYldPNmdhZWl2N00vVFdCSDcr?=
 =?utf-8?B?SWN6aFhlMU5rNDVhYTB2YjNXWUJ5RlViYUlsRWlpbWFDNGJyd3d2dmpMTWo3?=
 =?utf-8?B?U1ZDQUhiRS9EQTVLaUlhUlRSak9wSWsxOG8xRGxGeUphcmRKZGJtb21MMkNy?=
 =?utf-8?B?cGpzbVVSSUpUTU9qb3RTa09uYWowemJibWxGUm9PNGJkL3VWakF3RUFCcmRL?=
 =?utf-8?B?VDg3VnhFbDY0Y2ZON2puNkh3dlI2cWF6dVRYcng3Ymh1UlRsUHJuRnEyTW5P?=
 =?utf-8?B?RCtOMmtnNVF4MkZaMS9FdW5UUlRSMXpJb1pSckpLWHVBaCtFeFhqRlJPMnpz?=
 =?utf-8?B?alNla2NVZ0dWME1td0kzK1AwdlpqQlQrSW9WWEVnVUcwa3RaMEpRSHZERVp5?=
 =?utf-8?B?L0xrRTloMlhJWFVJSWpnZE1VZ1RoMFc3QklVZ2ZHS1FNVmhuTDUyaXJpNWZk?=
 =?utf-8?B?UE5IZS8rNG9lczNqRHRXeE8zM1IreU5CcW5UK2diQ0RHU1R6Sml1c2dRaGJ6?=
 =?utf-8?B?Wnk5bmhCWjBZSWNsVE5QOHI3UVBmeWx4eWZyS1FpS2FYZlhaTllSc3hleU12?=
 =?utf-8?B?M2ZtWElPWGk3RlhNbFBWZ2RhcExmSUZTeFhhZThuNkpIT01BbzExSlhONVh6?=
 =?utf-8?B?ei9FNTFBcm4yNGZOUis0R09MWXIwNFMwYkFXNUNlcFd6VE5mc25yWFFsS3FY?=
 =?utf-8?B?elNDQjQwSzB0ck5rcmxwck8vcmRuc2xrN1hCRmlWVnlMQ2ZNc1ZRMS85clly?=
 =?utf-8?B?MHh1QStaK3N1ekh0N0h1Q001TWxMTXQyNXdMU0RLeGEvakswZWpaN0hQY09i?=
 =?utf-8?B?VnZDaGhyMkZ6MzdTS0ZLMTJFdnFEb0NOYmlPelA5ZW02bzVCcWg4ZzRFeHZy?=
 =?utf-8?B?Vjk4cXgrRXFzYVY2WENWWE8vZlZIaTJ3SG8vRXBmSnAzeDVhYm05cDFRMWJB?=
 =?utf-8?B?blJ6V00wZU4rVUliTDBLNndyTWwvNkhkNmtVZDcvQlZOeUd5eEphZXplRDdo?=
 =?utf-8?B?RlpVK2dFY095bGlqVGJzUGFuVkJSVXMvRFJpQWZwM0ozanRNZGk5MW9JL2hB?=
 =?utf-8?B?b3RTUUJkbFl5S1RVWk52UVJTQUhxNjZTcG5TWG9jRDB4YVBxL0UxWlBvSWJk?=
 =?utf-8?B?dHpKd0RjNlpKVVJoMkU1S2pBc3c0bG1waXpYeENQclpzZHNNYktJbWhrajVV?=
 =?utf-8?B?eWRtS3lnbS9vckZPVXpZbWNjbExKNHFyV2E3TDhpelRGZE51akdFdkQzSTFh?=
 =?utf-8?B?S2UyZE5GVUpFTXQwNUs0b3RmT1BtUlJYekpBWEl0WXorY1QwRHRMTUtmN0RG?=
 =?utf-8?B?Y0Y3ZTNRbHF6K3FSQXZ0WTdzMWtub2tsb2szZFNoS3hWU1lGWU1oVkRKWkdo?=
 =?utf-8?B?dWtpUlovcktEejdhemc3SFhGMjVpRkF4Y2hZd1p1cytUWXhRNit2V1IzcmQx?=
 =?utf-8?B?U29ITWdVaUFNRW5OYmJBNExNVmcrWmpqdndFZzN1RDVaOXRBcDZVcGNQNzB3?=
 =?utf-8?B?dGJaZUdoS3IreEZrbElkZEVSSEZZQ3JMaDRPNzBQQkVXM3FxM2EwZ01DREhk?=
 =?utf-8?Q?7pWpn5cA8YGWjeib+PbAQZnUb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Hwmq7jdcPfPkmNqJlw11RpCY2ZxK3YYFQcKYjgtVjr8ZfE4ucr7r2e3PFISbPESCgslDfAGV63EViPDYZUjGSwXxZgVVH6sJuWGD7jhEBKnvaALl/wfmhvThplyAlp77tnvHQpPKJqjC/DgpYVXvgrlnkn7jmP3RKNJunLqwDYdJB4tePVPANADoIHxbHlpJWJVpcOA22lswn8DM1sfRnJSlk1YDECeYFhLp8Oz+ivXpddu272/VQYwk2muXHtnTA7vk5Dum2/ZtVY0aSadJEFRDNdM+W15Fg6CYtRMChP3tnvmfdJCcEtpMeJhZJrL5zyXAemq9HwAi1rpopwnKR5xVQH5HdWSdbL+akdYiWMPC/UwVhwLBpD2nH+IK8D8XsNzbBeuIfct2ss3B+CAXfJIkVhHHsnqArohRiHCaw0oixRiocvMdTeU3IWUZCe75/FRcdCx9TQc29ml+3DWtjsgcYGAmjro2n13t3A2eu5SvuwVjBNl+/YzSHI0dof2gP/Wp6dJVzAgrY/0PgRCDctCwSLLLeJ+Uebc3AjQH/t2Kwo3UN0gJGr7nLKBGjrDjX+2gd8in54r4ZzVJoeCEHlJ55PJBVpah1wm4EpBVHGTNYR+N5yloLVXM28YAovjW4mXtJ7P7aVXDEHIiYEBwtg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5088.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbccede2-2c51-40c1-fc95-08dc1b60ff1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 15:44:19.0557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QUOCSdV4LBDvbn7dkphgRmnfIyO5j9Y74fbqai6N3gOzWwvs3D4gzCW3YcFq23ABXTsR1gFVA7NlWZYhxlp+xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5667
X-Proofpoint-GUID: zfngRYfthnivuaEmr8e_ANuYU7VU2UKQ
X-Proofpoint-ORIG-GUID: zfngRYfthnivuaEmr8e_ANuYU7VU2UKQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_05,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 spamscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401220107

RnJvbTogQmVybmQgRWRsaW5nZXIgPGJlcm5kLmVkbGluZ2VyQGhvdG1haWwuZGU+DQpEYXRlOiBN
b24sIEphbiAyMiwgMjAyNCBhdCAwNjo0MTo0Ng0KDQo+IE9uIDEvMTkvMjQgMTE6MzgsIEpvc2Ug
QWJyZXUgd3JvdGU6DQo+ID4gSSB1bmRlcnN0YW5kIHlvdXIgcG9pbnQsIGJ1dCB0aGUgZGVsYXkg
c2hvdWxkIGJlIG9uIHJlc2V0IGZ1bmN0aW9uIGl0c2VsZiwgc2luY2UgaXQgZGVwZW5kcw0KPiA+
IG9uIHRoZSBTb0MgdGhhdCBzdG1tYWMgaXMgaW50ZWdyYXRlZC4NCj4gPiANCj4gPiBQbGVhc2Ug
cmVmZXIgdG8gcmVzZXRfc2ltcGxlX3Jlc2V0KCksIHdoZXJlIHVzbGVlcF9yYW5nZSgpIGlzIHVz
ZWQuDQo+ID4gDQo+IA0KPiBPa2F5LCBpbiBteSBjYXNlIHRoZSBTT0MgaXMgYW4gQWx0ZXJhIEN5
Y2xvbmVWIGFuZCByZXNldCBjb250cm9sIHNlZW1zIHRvIGJlIGFuIGFsdHIscnN0LW1ncg0KPiB3
aGljaCBpcyBpbmRlZWQgYmFzZWQgb24gdGhpcyByZXNldF9zaW1wbGVfcmVzZXQuDQo+IA0KPiBT
byBpdCBpbXBsZW1lbnRzIHJlc2V0X2NvbnRyb2xfYXNzZXJ0LCByZXNldF9jb250cm9sX2RlYXNz
ZXJ0LCBhbmQgcmVzZXRfY29udHJvbF9yZXNldC4NCj4gQnV0IHRoZSBhYm92ZSBtZW50aW9uZWQg
ZGVsYXkgYWZmZWN0cyBvbmx5IHRoZSB3aWR0aCBvZiB0aGUgcmVzZXQgcHVsc2UgdGhhdCBpcyBn
ZW5lcmF0ZWQNCj4gYnkgdGhlIHJlc2V0X2NvbnRyb2xfcmVzZXQgbWV0aG9kLg0KPiANCj4gSG93
ZXZlciBpZiB5b3UgbG9vayBhdCB0aGUgY29kZSBpbiBzdG1tYWNfZHZyX3Byb2JsZSB3aGVyZSB0
aGUgcmVzZXQgcHVsc2UgaXMgZ2VuZXJhdGVkLA0KPiB5b3Ugd2lsbCBzZWUgdGhhdCB0aGUgcmVz
ZXQgcHVsc2UgaXMgb25seSBnZW5lcmF0ZWQgd2l0aCByZXNldF9jb250cm9sX2Fzc2VydC9kZWFz
c2VydDoNCj4gDQo+ICAgICAgICAgaWYgKHByaXYtPnBsYXQtPnN0bW1hY19yc3QpIHsNCj4gICAg
ICAgICAgICAgICAgIHJldCA9IHJlc2V0X2NvbnRyb2xfYXNzZXJ0KHByaXYtPnBsYXQtPnN0bW1h
Y19yc3QpOw0KPiAgICAgICAgICAgICAgICAgcmVzZXRfY29udHJvbF9kZWFzc2VydChwcml2LT5w
bGF0LT5zdG1tYWNfcnN0KTsNCj4gICAgICAgICAgICAgICAgIC8qIFNvbWUgcmVzZXQgY29udHJv
bGxlcnMgaGF2ZSBvbmx5IHJlc2V0IGNhbGxiYWNrIGluc3RlYWQgb2YNCj4gICAgICAgICAgICAg
ICAgICAqIGFzc2VydCArIGRlYXNzZXJ0IGNhbGxiYWNrcyBwYWlyLg0KPiAgICAgICAgICAgICAg
ICAgICovDQo+ICAgICAgICAgICAgICAgICBpZiAocmV0ID09IC1FTk9UU1VQUCkNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgcmVzZXRfY29udHJvbF9yZXNldChwcml2LT5wbGF0LT5zdG1tYWNf
cnN0KTsNCj4gICAgICAgICB9DQo+IA0KPiBJIGRvbid0IGtub3cgd2hpY2ggcmVzZXQgY29udHJv
bGxlciB0aGF0IHdvdWxkIGJlLCB3aGVyZSBvbmx5IGEgcmVzZXRfY29udHJvbF9yZXNldCBpcw0K
PiBhdmFpbGFibGUsIGJ1dCBpbiBteSBjYXNlIHJldCA9PSAwLCBhbmQgZXZlbiBpZiBJIGNvdWxk
IGdldCB0aGUgcmVzZXRfY29udHJvbF9yZXNldA0KPiB0byBiZSB1c2VkLCB0aGUgaXNzdWUgaXMg
bm90IHRoZSBkdXJhdGlvbiBob3cgbG9uZyB0aGUgcmVzZXQgbGluZSBpcyBpbiBhY3RpdmUgc3Rh
dGUsDQo+IGJ1dCB0aGUgZHVyYXRpb24gdGhhdCBpcyBuZWVkZWQgZm9yIHRoZSBkZXZpY2UgdG8g
cmVjb3ZlciBmcm9tIHRoZSByZXNldC4NCg0KU29ycnksIEkgaW5kZWVkIG1pc3NlZCB0aGUgZmFj
dCB0aGF0IG9uIHNpbXBsZV9yZXNldCB0aGUgZGVhc3NlcnQgaXMgZG9uZQ0KYWZ0ZXIgdGhlIGRl
bGF5LiBCdXQgbXkgcG9pbnQgd2FzIHRoYXQgd2hhdCB5b3UgYXJlIGZhY2luZyBpcyBleHBlY3Rl
ZCBzaW5jZQ0KbW9zdCBvZiBTb0MgY2hpcHMgbmVlZCBzb21lIHRpbWUgdG8gcmVjb3ZlciBmcm9t
IHJlc2V0LCBhbmQgdGhpcyB0aW1lIGlzDQpncmVhdGx5IGRlcGVuZGVudCBvbiBpbnRlZ3JhdGlv
bicgcmVmZXJlbmNlIGNsb2NrIHZhbHVlIChsb3dlciByZWZlcmVuY2UNCnZhbHVlcyBjYXVzZSAi
cmVjb3ZlciIgdG8gdGFrZSBsb25nZXIpLg0KDQpJIGhhdmUgbm8gb2JqZWN0aW9uIHRvIHlvdXIg
cGF0Y2ggc2luY2UgaXQncyBpbmRlZWQgYSB2ZXJ5IHNtYWxsIHZhbHVlLCBidXQNCkkgYmVsaWV2
ZSByZXNldCBmcmFtZXdvcmsgYW5kL29yIEFsdGVyYScgcmVzZXQgbWFuYWdlciBzaG91bGQgdGFr
ZSB0aGVzZSBkZWxheXMNCmludG8gYWNjb3VudCBvbiBkZWFzc2VydCwgc2luY2UgdGhleSBhcmUg
ZXhwZWN0ZWQgdG8gaGFwcGVuLg0KDQpUaGFua3MsDQpKb3NlDQo=

