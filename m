Return-Path: <linux-kernel+bounces-111955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FFB887334
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B09362858A9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B518A67E8E;
	Fri, 22 Mar 2024 18:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="EgIaRzrr";
	dkim=pass (1024-bit key) header.d=onsemi.onmicrosoft.com header.i=@onsemi.onmicrosoft.com header.b="Sbgd9CPq"
Received: from mx0a-00183b01.pphosted.com (mx0a-00183b01.pphosted.com [67.231.149.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2889C273FA;
	Fri, 22 Mar 2024 18:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711132318; cv=fail; b=aKjoHRx5uOrT0BMZeFi6b98+pVrkjDSKhjdaoTOHbfaQGDs4QeID7NrZdhDrQcdhF1RWhEVvgRK3tv+39MiraZuUDZWlYEbprXILzkuUmdYEKtMuNYBLjlmK1sVI8zMeFifjXCbPSCVVoI+2i4yHKYiXPON2XChx4kZTrsaqkvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711132318; c=relaxed/simple;
	bh=ekNJ98oSL4Y7doKZOzh3plMaAPrzWZ+d9pLs3QhDSmk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UcxgPvhRIMj2zU1c004SZthIa3TAbogG/PQCRlp4W8lfmFhVNPafQlNHIhZQ7FA/LSa623MyGDgu1tMADNyDACmXYNgC++8EchRburLUmW02/IgheHu01PfdefhLs5dWhQFb6T3tCdzp+lvTWIuyMOQ8xtdOVqIdh8h3fVLgsLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=EgIaRzrr; dkim=pass (1024-bit key) header.d=onsemi.onmicrosoft.com header.i=@onsemi.onmicrosoft.com header.b=Sbgd9CPq; arc=fail smtp.client-ip=67.231.149.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Received: from pps.filterd (m0048106.ppops.net [127.0.0.1])
	by mx0a-00183b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42MCn1r4017857;
	Fri, 22 Mar 2024 12:31:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	pphosted-onsemi; bh=fMn3A64c+BrclsU44gMCsj4gzPl4sLz3va3evB39Zqo=; b=
	EgIaRzrrKEmJnq6S+cUpDkUl1XRLAix//B+BdoHCYW9dWV9Y+yyTs7Y9T6YUL8g/
	STOibP6n/U/PTkrZ7mMHh2XFED6iIhybyN47f5qG6xKsocGpB2GsJbk83ceCJ3Uy
	DLARify5cqxyLgtX+DzjqkOx2litK97qsbh9waW/AQbPV6wf4UK24XgmRmIz9Pbl
	rEKAUIQF1U1j2uDJFvtkulZ/t4lu4RgGeGiOUmO7moO+TcTu0539x6RO01jVE7ga
	lGj3sqCLO01qq7su6s6eMNADN3KvjGJhVXVMJ8GIIK+ajq2GqLtOSnpbazx+YVnA
	b0ASdaiJNT39WTblYApbfQ==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0a-00183b01.pphosted.com (PPS) with ESMTPS id 3x0wy4ae4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 12:31:08 -0600 (MDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgajLDijJVOqH4YrSMC9GDqAQNNuMvA46nqaNK4P+jLXz0PggtjlZgQJWL7orH0RcNy2wy5LLw9dx2xa6G2OZVqIhtn7NgASkOzlWirOlaFOZGpQLzFMYFb99I85u9Nt9si05+VWVuTwPh77vRZIRNxyhUix0sXAOludp76VAcnFaWFbdSgZreGHMWh1g/5yJ6wYK6pnDm5ENeJZQhPeSfGwgVYWcsDSjtvypUHcnbTzROD/OTKJgwQE7l22H19j/YC+q8Fk8MptVQEPw5cb5XJ8JWhqrabwryk9vI3FaM3oRuDFj9SFI/DjmPxZy2LJk+7v2SSZYHm2EIHUKUPvDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMn3A64c+BrclsU44gMCsj4gzPl4sLz3va3evB39Zqo=;
 b=iS8OXArhaqJM6e0yfgs/AEi97+00s5vcazPk6XTubWnv1Y6XTZHcFRducsYK47dg6ENrZq/dJBD2c8hGv6l9YBbIBUQyLO5pwkl2iniCfyWZx0U84KzP75Lda+weiyzbvPYFcyyTbnuMdiFOuTEegkPgmD7GHPGPGaTbren6WFb/ioKvW8VWLwiwFFKulyFkXGV0GkOQURWfZ0nLAP70U6Yg+t/7ZN3JgZVlnfjwlenb2GdzYgs/sZlx663tPlbAoIaqlPttOQ8KL7s3lyDM0sZztk2t+S5pX6FN1SXHQQpa6IQ5rue88yN03RbZ52L+dWDxzc2IX1h1DN5V0p7zcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=onsemi.com; dmarc=pass action=none header.from=onsemi.com;
 dkim=pass header.d=onsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=onsemi.onmicrosoft.com; s=selector2-onsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMn3A64c+BrclsU44gMCsj4gzPl4sLz3va3evB39Zqo=;
 b=Sbgd9CPqJO98EqDx7E2/1vFnKpC+fFabk/r8jyZBX1Jti3xWwp9q4VKmNGODsPtb8PSsFB7AEBxAANqVr9H7cE56NJI1YP1kyKAg/GPALfFbPCEOUQUtdwzvbHnKb5HcA6GVNjHXM8Cnia9NOxyvQ+YLsEmHkM9XAqYQLlCafLU=
Received: from BYAPR02MB5958.namprd02.prod.outlook.com (2603:10b6:a03:125::18)
 by CYYPR02MB9887.namprd02.prod.outlook.com (2603:10b6:930:ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 18:31:05 +0000
Received: from BYAPR02MB5958.namprd02.prod.outlook.com
 ([fe80::6b99:a19b:d0bf:bfc9]) by BYAPR02MB5958.namprd02.prod.outlook.com
 ([fe80::6b99:a19b:d0bf:bfc9%4]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 18:31:05 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "Parthiban.Veerasooran@microchip.com"
	<Parthiban.Veerasooran@microchip.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "saeedm@nvidia.com"
	<saeedm@nvidia.com>,
        "anthony.l.nguyen@intel.com"
	<anthony.l.nguyen@intel.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "robh+dt@kernel.org"
	<robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "Horatiu.Vultur@microchip.com"
	<Horatiu.Vultur@microchip.com>,
        "ruanjinjie@huawei.com"
	<ruanjinjie@huawei.com>,
        "Steen.Hegelund@microchip.com"
	<Steen.Hegelund@microchip.com>,
        "vladimir.oltean@nxp.com"
	<vladimir.oltean@nxp.com>,
        "UNGLinuxDriver@microchip.com"
	<UNGLinuxDriver@microchip.com>,
        "Thorsten.Kummermehr@microchip.com"
	<Thorsten.Kummermehr@microchip.com>,
        Piergiorgio Beruto
	<Pier.Beruto@onsemi.com>,
        "Nicolas.Ferre@microchip.com"
	<Nicolas.Ferre@microchip.com>,
        "benjamin.bigler@bernformulastudent.ch"
	<benjamin.bigler@bernformulastudent.ch>
Subject: RE: [PATCH net-next v3 08/12] net: ethernet: oa_tc6: implement
 transmit path to transfer tx ethernet frames
Thread-Topic: [PATCH net-next v3 08/12] net: ethernet: oa_tc6: implement
 transmit path to transfer tx ethernet frames
Thread-Index: 
 AQHab6OUNkEIC/2nOEKl31mx3SAVeLEshPoAgBKU6ACAAAbvgIABZr4AgAIaygCAAA4oAIABfYQw
Date: Fri, 22 Mar 2024 18:31:05 +0000
Message-ID: 
 <BYAPR02MB5958165A052E6EA11C353E6883312@BYAPR02MB5958.namprd02.prod.outlook.com>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-9-Parthiban.Veerasooran@microchip.com>
 <208fb61b-4740-46bf-8c70-29ab59cbb965@lunn.ch>
 <f9d8a18c-b1fe-450c-a5ca-d91f96793a04@microchip.com>
 <96dd422f-0bf9-411d-8cc2-5755c1e60e27@lunn.ch>
 <53b090b1-d7bb-4a81-9f0b-9979db8dec59@microchip.com>
 <BYAPR02MB5958A04EF61FF6B7512CE7EE83322@BYAPR02MB5958.namprd02.prod.outlook.com>
 <f9ded7f6-7f7d-4564-8b06-e73e603ef927@lunn.ch>
In-Reply-To: <f9ded7f6-7f7d-4564-8b06-e73e603ef927@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR02MB5958:EE_|CYYPR02MB9887:EE_
x-ms-office365-filtering-correlation-id: 0fb4fd04-4f2e-427c-13fb-08dc4a9e3c42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 TFtWuItc4NepVd+8MhAUBY5EEeTZdWwhrkKxoUATKsAPa6CG/1Y4ym6K5DUNYyRrPE406SZbj+GaoGb7O3o2Uzj/YhM56gRu6vBnEDG5HccdJGiBJRFC/4Zqki3MAJj1xnWzyIn6C294bqaCdDNN7cHr593qaMSK4AIUtXyXzX/8EYkeaVtKYjJ7IiSByaOj7zkZEurozb30fC7uvNkc0OB6aC+mIAt3X61X8FI4lRWDWpCLrfED7qoVAl+uJq4Vw7tmEIoOMGq4vCfC1th5NiOQ5iGv4AS2LYGz075/xgD/ijfu48XH2O2l2n6resZiOHI1MvSEGQZbuMRYJsMRrhTDsyRZfCRFTznx/6Wp6x2Xwhjhn8MchMcN5pmIvKaWGj2WuzqOBbPT4fZEB515QXyC+10aJzpwnkJzke2c174sJvM7Kwmke5AcDtoAxfayhlicwF1LKmdXWf94ZPC9+9qW2fljhCJAWUg5ifoIgDq/iXbhWMQGKQAUggjmGHe63SGdQ0hHvxpPW6VNP8I3OjknVd2ir167Se0j+eXlD44yGeor2AKuumemLxArFQaZBUpMsp0GfrVuzlFu3CbJlkVzAGiKU50q9BNHno6f/i/Uud8MEl/ZHyYrkLq+r3eoWqJRdAS+uNtW+bfbWQhmG6pXW6lVo1Jqm9F6VJrkyg//l0ho/pf4RRiF8fw3+MfQcraHRRU5XdOHPVsk41m3UA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5958.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?3pCtqOwTFJLM91rqyMTyXVnxTLDQ+W2hjA3yoWAlPIBIiQJ2cw4ME/gMeCsx?=
 =?us-ascii?Q?d84LsuaCeKs6MPoCii+s4tUs1fOSGjrdxOh83mYUuGE8to/mLRT8Bmkt/G5W?=
 =?us-ascii?Q?WAsVKzrDAzYYatGzbR6TLYiD+R+L2dDqilW7+Zda6pTrGBdyJk3ID+KTxE5t?=
 =?us-ascii?Q?oN/Kts3s/VUPg3JojPEV8ufPU5JB8Qhn7d8Lv2Pwz6jCM4YlRYyv+0Q6xuib?=
 =?us-ascii?Q?+lw6j1L8csLPsQWOwgsPw47AN6r2NNEgapTU2kAHFd47Mg/r91BNXHrUBtqE?=
 =?us-ascii?Q?weSAQrvBHVomrz9VGSzEEpYSUogCWLhP1S1OWMwV8fRL6VMJrencQiqAO8xP?=
 =?us-ascii?Q?U3wpf4cpsicK/nhGHWlyfB+M5AtMh9FGpGjqhhaKZqbuCTbAOi6HncdVH1mP?=
 =?us-ascii?Q?S8CYwd5bB5atN026AjXSlNKmHutHDX3wx7yfl3vp4t4GhGrLYiFJkYP/MNoa?=
 =?us-ascii?Q?VDgLn7nIS9QpMziv2K6ACeEeHp301zaTYT3d9mxADyTBw/l0oDbEoYG46Plv?=
 =?us-ascii?Q?TTWbtlzp5X05OqHUKBNVry6A51dL6/sYd4gMOTMR9+ZtH2kCKhreYVgFSUNO?=
 =?us-ascii?Q?BzlVr0D0iUrgU58//Qh15RKks94tA/wgRgGsD6bYDNQA5aKuKSUlCIvJLogi?=
 =?us-ascii?Q?3sTckQHydhYRPwn374Ly3hDcBiQzVYqwgae6DINF4/Ig5GTBjMe+NF15JwwM?=
 =?us-ascii?Q?OL+kGDwa5PXJKTdYwdhOJZvy337Vd24sb3/p5xI0iRp6fz6ru02qIQ0pkpCD?=
 =?us-ascii?Q?Cl7UP5fdjGIHvGROTHDgzAQLOeslK2WlEjXNoKsj9A/EyJiqCt728lb+6OGD?=
 =?us-ascii?Q?NXnuBeuCskqCEgtxBuIA1SgcUk02wewjc2SWKx4yFUK02QbEFovCqvlNbj99?=
 =?us-ascii?Q?eKOkc2S3mVMq0Sl907eS6qNDszx2b1idaerGniNjNqJBZcdX9u88XZ5rvyyr?=
 =?us-ascii?Q?EsY8BJix/8paamX1kB+gVoRgevxVjGLv9QjqvbYSG3mWgWHrldTQe8ROBCWu?=
 =?us-ascii?Q?sML/IihrptsgSABaF1Te5oQe70mEHBBvzeIdZY6Dhd7vNiyJ2Of5HIk9N6K6?=
 =?us-ascii?Q?AFa8rEb26xb2eLvHeDwOhKlMswLHqulF3EqEaW9qpg5XLL0NA2j3o4D56N4M?=
 =?us-ascii?Q?ZLkhx97TJzFoElBKEyThKHjw7EqBUj1GRWHDy882g1OhF6dFR4WqOZxP3cYU?=
 =?us-ascii?Q?J81uSmk+a0slJzH77Ik+yTVbV3smz0UnESssUPvOdKm5ucgNWAdxiqFcrFCN?=
 =?us-ascii?Q?JohgR5/gz+UqzRVqX/9DLKZwh1sQRBdz6h2ntiHZSGy7F9lb4vaghH+lHxcM?=
 =?us-ascii?Q?wXZWKIo0f8V6etAwNkTkTawdzMRoY5rKOH0l8irFWIsJ87sxVJvsLW1wVW+C?=
 =?us-ascii?Q?QC3fUF5cP3a6LxITVkeMU1NvlmH2pyBtaS+kfcWGBOTfb2pZOwvhVrXGTxBA?=
 =?us-ascii?Q?ll3+iYef0dDmldmp26lYtXOVBvulvyWoZAYK1tzy3QEEzBxGeRsp7n7pauWL?=
 =?us-ascii?Q?/OmaxjrZWdrM2Q0xiXlem+kcnAYZeXs21ABQPowATR7FO2HuFQOnVEqxm+vo?=
 =?us-ascii?Q?/oaoFP/pfeyyHqUJX63vWeasZuNr8tQNXr9m/eoodg9jBT8VZCWR3UIfmxhC?=
 =?us-ascii?Q?hA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5958.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb4fd04-4f2e-427c-13fb-08dc4a9e3c42
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 18:31:05.5683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JmX9cEBf0rTXvlgirdMCKk1hCQj9ahjqdnOt3w9GmK8zMoJl93r2ddP2k+e6K74DkJB8dgHWtIUSQfedTR9nAQBaSS3/gz1PiG3eahXDl1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR02MB9887
X-Proofpoint-GUID: Ct7RQOx_ZdQybCC5oVylzW6WTF4NGalK
X-Proofpoint-ORIG-GUID: Ct7RQOx_ZdQybCC5oVylzW6WTF4NGalK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_10,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 impostorscore=0
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403220133



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Thursday, March 21, 2024 12:42 PM
> To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
> Cc: Parthiban.Veerasooran@microchip.com; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> horms@kernel.org; saeedm@nvidia.com; anthony.l.nguyen@intel.com;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; corbet@lwn.net;
> linux-doc@vger.kernel.org; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
> devicetree@vger.kernel.org; Horatiu.Vultur@microchip.com;
> ruanjinjie@huawei.com; Steen.Hegelund@microchip.com;
> vladimir.oltean@nxp.com; UNGLinuxDriver@microchip.com;
> Thorsten.Kummermehr@microchip.com; Piergiorgio Beruto
> <Pier.Beruto@onsemi.com>; Nicolas.Ferre@microchip.com;
> benjamin.bigler@bernformulastudent.ch
> Subject: Re: [PATCH net-next v3 08/12] net: ethernet: oa_tc6:
> implement transmit path to transfer tx ethernet frames
>=20
> [External Email]: This email arrived from an external source - Please
> exercise caution when opening any attachments or clicking on links.
>=20
> > > > This second part is clearly an optimisation. If you have lots of
> > > > full MTU packets, 1514 bytes, they take around 24 chunks. Having
> > > > the last chunk only 1/2 full does not waste too much bandwidth.
> > > > But if you are carrying lots of small packets, say voice, 130
> > > > bytes, the wasted bandwidth starts to add up. But is there a use
> > > > case for 10Mbps of small packets? I doubt it.
> > > Yes, for sure there is a possibility to get into this scenario and
> > > the protocol also supports that. But as proposed by you below, let's
> > > implement it as part of optimization later.
> > > >
> > > > So if you don't have the ability to combine two packets into one
> > > > chunk, i would do that later. Lets get the basics merged first, it
> > > > can be optimised later.
> > > Yes, I agree with this proposal to get the basic version merged first=
.
> >
> > While latency is important, so is using the available bandwidth
> > efficiently. Here is a suggestion.  We know that the tx credit
> > available basically tells us, how many chunks could be transmitted
> without overflow. Instead of stopping the netif queue based on number
> of skbs queued, why not stop the queue based on number of bytes
> accumulated? Basically, at any given point of time, we enqueue the
> tx_skb_q until we are have enough bytes to cross the threshold of (tc6-
> >tc_credit * OA_TC6_CHUNK_PAYLOAD_SIZE).
> > This way, during the next transmit, we could utilize the whole availabl=
e
> credits. Bandwidth utilization between bigger frames and smaller
> frames would be not be vastly different.
>=20
> Please configure your email client to wrap emails at around 70
> characters.
>=20
> tc_credit is 5 bits. So it is a maximum of 32.
>=20
> A 1514 frame takes around 24 chunks. So you only need two full size
> frames to consume all your possible credit.
>=20
> If you happen to have smaller voice packets, say 130 bytes, you need
> three chunks to send it. So you might want to have 10 such packets on
> hand in order to make use of all your credit. But if you have 10 voice
> packets to send in a burst, your voice quality is going to be bad, they
> should be 10ms to 20ms apart, not in a burst...
>=20
> I don't like the original idea of having lots of packets in a transmit qu=
eue.
> But having 1/2 dozen should not be an issue.
>=20
> In general, we prefer things to be simple. We can then optimise later,
> and use benchmarks to show the optimisations really do bring a benefit
> to justify the added complexity.

True. I should get some performance numbers to see where we are
with the current code. That would be time to look at the improvement.=20

>=20
>    Andrew

