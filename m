Return-Path: <linux-kernel+bounces-54619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2BB84B191
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF377B2381C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991D512D15F;
	Tue,  6 Feb 2024 09:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h4Hbg4ku"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71BF12D148;
	Tue,  6 Feb 2024 09:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707212890; cv=fail; b=q6o7WL7CyGYGgQkRqYOCiTSCXymLeqx/rzmikI8l+fbWI93g7LdBhlBok1MjKihcJM3YPE5CQ+G9o03Nq/y3xEKmIb3aByt0zyeELkwZ6YRnUL5NukAc2oSXrL3O8pqkHsqEDo55Qjy7VUJFh6W1ttRUJlj7R12jOBbwgQmuUwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707212890; c=relaxed/simple;
	bh=rqMrqGnq8Hon97CEu6ZbHjCjdHUuNxCMXE3cUMh9hc4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LV1rVNuNTq5gEuKQM3KnK1z7cFnOHv+kxE/h0K3n7dQp/unMH6TG5PZHbuPCB8hDFCUEfGCILflpzMD+6qBgJC56xy1wTAYh0t1jMQwNu2ShoFAvE3v3yezueAvLZZjw9DCvdW6NEZbzOGA6ohtltRwlBnBLlUQGuIu89k0VuKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com; spf=pass smtp.mailfrom=qti.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h4Hbg4ku; arc=fail smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qti.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4166R66W022375;
	Tue, 6 Feb 2024 09:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	qcppdkim1; bh=dYaoBLsoCqCDOf7erDAQOC1TnBl/kcwLhjgKTDnb2HY=; b=h4
	Hbg4kuMI0a7ySDkPrztBHuCqoxFpC3hDLnaN/wxSRJxcq19kGuRwooicqWtCStE9
	Vcx4CCzUdMKZ95OsXgkW5wSZyXvW9EbeRrfLFybC8ASANh3Zm/hZX/V1Ow5hTKB+
	5l01hAfvWEXfbZD97RT9b8eJzlOMJ9mMrasJeCrBa7zqbVjhQdFQtSRgeTFnHFlq
	oQKfuXvnsirJqxvE7jC2rgjodnowAubHopfBMSA9I0keD8e3lCpb+prfF9nZEfWZ
	3hBvdUaiTYUzN3uXrZro2IX+ynjtrbdBXKpaF5ufuKp4sW4x/HNwWjWFif0OnJIi
	D38K3kOh781bcvovU/fg==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazlp17011010.outbound.protection.outlook.com [40.93.1.10])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w3a1bs0e0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 09:48:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISaXWzUFevdoV2FMZxR+WHkMvAJ7GAeu/bZrj2HPH2uiq+pQyt9yz98ShPYlioqw1BNM3dQmOKeadLir7OvuzHqd/4Ms7vuc6G7p1KAYS7PcXbMcVCI67xJZMJEHtUgbKAyZkOLTmYJGaLo+TczTqrR9urBTnt5SgaikWIQTITno1AG+DPogIisUkN9aXkFIGgOD/Jpy5mjzyr/m79J091PD7FA6K7Wc4Kr5pVbZ84+6M6KvflQ8wKpGFmcjRBZ0AGPRunM5OZDiO54t5sgJfFfqaFibnfQFROzsZoiO/X4Fy27C6PwReU3toTxiNcUqqyEG1/YV5grCEdLIdP8zug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYaoBLsoCqCDOf7erDAQOC1TnBl/kcwLhjgKTDnb2HY=;
 b=TxQzW9fSA9FKI30IU0VaFaxUCjkqJ/3rIg5BG/tm4oEj4/sM7+/6z6IbHf/8A5lulFG9K3WDmtNR6Fxbwh2l9EzG/sooa6KOZkpq+u9mh2RnvflixBFoUa0BuhKx4RzP5+BHfizuCO6nXH6La7ze29Izo+Lnn14OVm3JTOlHsN5cSVc8WE0G3VIqE01v/s1Z+QFnrLO+13xm4YyWOKYcv70tMvyDIyrOCWkpn7GekdM6c7iqLqDUuoQMzuhbUxT/o9Q2KmhPiUY5s1jgWTDnz+NLQO4wan070i8MLJK1Cpu9w+k3aXi+i0HykbOLDhbJ5B0cVs0V65PKHRZ83fIluw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from BY5PR02MB6770.namprd02.prod.outlook.com (2603:10b6:a03:20c::17)
 by SJ0PR02MB8499.namprd02.prod.outlook.com (2603:10b6:a03:3e7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 09:48:02 +0000
Received: from BY5PR02MB6770.namprd02.prod.outlook.com
 ([fe80::9751:c2a:4e52:1e96]) by BY5PR02MB6770.namprd02.prod.outlook.com
 ([fe80::9751:c2a:4e52:1e96%6]) with mapi id 15.20.7249.027; Tue, 6 Feb 2024
 09:48:01 +0000
From: Mukesh Savaliya <msavaliy@qti.qualcomm.com>
To: Viken Dadhaniya <vdadhani@qti.qualcomm.com>,
        "Viken Dadhaniya (QUIC)"
	<quic_vdadhani@quicinc.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "konrad.dybcio@linaro.org" <konrad.dybcio@linaro.org>,
        "robh+dt@kernel.org"
	<robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "linux-arm-sm@vger.kernel.org"
	<linux-arm-sm@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "Mukesh Savaliya (QUIC)" <quic_msavaliy@quicinc.com>,
        "Visweswara Tanuku
 (QUIC)" <quic_vtanuku@quicinc.com>,
        "Chandana Kishori Chiluveru (QUIC)"
	<quic_cchiluve@quicinc.com>,
        "krzysztof.kozlowski@linaro.org"
	<krzysztof.kozlowski@linaro.org>,
        "Viken Dadhaniya (QUIC)"
	<quic_vdadhani@quicinc.com>
Subject: RE: [V2 RESEND] arm64: dts: qcom: sc7280: add slimbus DT node
Thread-Topic: [V2 RESEND] arm64: dts: qcom: sc7280: add slimbus DT node
Thread-Index: AQHaLQqc0CWrBASSo0alQjO9H82ywbDyHUaAgAtIbvA=
Date: Tue, 6 Feb 2024 09:48:01 +0000
Message-ID: 
 <BY5PR02MB6770D6FD0FF4E98C92CBE364E6462@BY5PR02MB6770.namprd02.prod.outlook.com>
References: <20231212145026.20828-1-quic_vdadhani@quicinc.com>
 <SJ0PR02MB77584EC82BA714E5F1011E6CEB7D2@SJ0PR02MB7758.namprd02.prod.outlook.com>
In-Reply-To: 
 <SJ0PR02MB77584EC82BA714E5F1011E6CEB7D2@SJ0PR02MB7758.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR02MB6770:EE_|SJ0PR02MB8499:EE_
x-ms-office365-filtering-correlation-id: ecb02684-3608-4eba-a07c-08dc26f8b543
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 6MEcnR+xXpXrVSwoebDa7b2MlARiUv4XtmgEuZKZDTKin6qYRcZzD2yaPLkKf/+1+dWPSea1HOYWmhO9uT9v0/c0ug5fg7y6YNgUDytqGW45xTkt24jWIAkYB/28bf5VI9JqiKLgVC8rfGKLpfO+FLckJ/jKqHxRP6ZMFuQeeYKFBWYo/saL68nAKpM7vYTyHnt0uEkIuH3NSxLo+65XhY/24cGIOIcyFMtq8GrNP3v6bE3O9a2onG1lvFW7bM3W09v6OoH8X2emN23ajvocPWTHNQp/0G9kMFxgsPUjMG49Uc2XQVdBw7Cv+8tpmfM/Sld32ho3yb/sIvjkP6yJHt7SdPavNn5k19MlyRxI955gL8lzcEADgGwPA4xcow7njMsF6gHGn9aMkQKhp15lckO2frWg50QT+WapAlsTNj4B2vpOGTKBv+c26BzOyB8rS3Jgh+3JQLOY6EPoaRiL9wvHAsz/VtmXQ/1PSfxusAmWqW41gvxIjB/WLbmF+ErbwjidXuEavvjYnLx7kjmX+u+LbVpGIwq7zKVU3fpJj4/dKe650LI1m5Y93fhyK3Cb5s04Zw0QhhvAbOUMljAk/QBGSuC+S+ebrS/1RXBhPjPUsMf+OxUl0fyKO6aW8MyBn3ubEkmPryT7HKAcdOmrqQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6770.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(41300700001)(86362001)(52536014)(8936002)(8676002)(4326008)(107886003)(478600001)(921011)(5660300002)(33656002)(9686003)(6506007)(53546011)(7696005)(71200400001)(38070700009)(110136005)(26005)(316002)(76116006)(66556008)(66446008)(64756008)(66946007)(66476007)(54906003)(2906002)(83380400001)(38100700002)(122000001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?0dhpaT3JtmkMBQWGNCkRQAsb339rasGf+3DQ4MqvVzJ1wmNh3iFuAcLMCywE?=
 =?us-ascii?Q?RZaLuWm5dQKUhRDksL01ovfSxdSLXO3GS9Rrd6bcgyMJ3AXc9vSKELGNrLs+?=
 =?us-ascii?Q?zYl+Q0c5yoQPg+K13UtOG+VyRDNjzruYUNCKY6m9KcRQG4cpKx6wwzQ7el6h?=
 =?us-ascii?Q?XYcAzRTMvGGyMlpRQ9IrL8dB1GvwErHeDXHubgWA5opRWInMo5dZS7j2vS6x?=
 =?us-ascii?Q?t22IXujoG4asgd6ILPPCJeSHYCJJCfvDw2nejUIhjrceYKQ/Ff+ak/hM++CA?=
 =?us-ascii?Q?0kBZkSl9ZUUvEwLZdWOySai7ziYbmhjXIKzpncvQyvlBRppw1fChRNz8N6tV?=
 =?us-ascii?Q?wIJenSlacrfgE5834NrBAqff/r1v43l0aG8q6KRp8n4wHhuWzYIBXPO67y1+?=
 =?us-ascii?Q?bggZRxRQwNQSwWGfB3fsIGFO2VNr4Hl5l2aPlpahQcK5oIpO+vJ7GwFL3AsN?=
 =?us-ascii?Q?lwE+lVlYHrWmyXi17EULlr+E4Jmyf8v5S9FtedUUldw33pgtwW6g2HKtLqHq?=
 =?us-ascii?Q?v2DE+IZ0t8+jo6IQ+IZZmSXzPHRjE3Ux5SFCQNBHGcngrozLg1J8E0ZKRDpq?=
 =?us-ascii?Q?6ryK2d5X0nw1fgeH1EnFM4cPoDPjc5ib9W0dSMu/FzylCtaJ1FJ6+NAvYMEm?=
 =?us-ascii?Q?I0teY67vYFNBENaGpRUAfnnN680umBKgCcLEWZXaF5PACYAUvxQ9sWkqvKfg?=
 =?us-ascii?Q?Nhhk5R8hiQ8HwAES8C8cKtvpDEAL0RRfLumZGfNf8Vi9DC35qbYY1iCnZpQt?=
 =?us-ascii?Q?i941IXJykgHYdM1WiBr8H7QQeW+r4kjKFJlNeWf+LCHxYYOg+126QMQnH75e?=
 =?us-ascii?Q?KkJIS9jSQavQODv6QSsQLU4Dz/XdKs/WL341Rq8c0v9sPVVYw6xsiZnnq3Yg?=
 =?us-ascii?Q?I17H90CUDRwIZlYq5C41GcuxIoAOmZNb1gh/ucZ69nGPahgmcqG3gcfLn4MW?=
 =?us-ascii?Q?VmrVppFbV68LeUTUfJpbt2xRdd25YdB/Wo5Cgdl4mInNAFHMF/CdBh0hS0Si?=
 =?us-ascii?Q?Qlf3MdpoRpwUIQ1iV5mw3L///Bxo90Am/IP5fVK2JECd7XdxWXyvndDZaztI?=
 =?us-ascii?Q?+egqVA7f2OHkLfeUSz7JXv4MFUiceChuSG23gSeuNz2k1qRq64GWwSQszSN8?=
 =?us-ascii?Q?gtICstZv8ncUjQ9vFuJgzyTJVm0FQO3mm7q0didSou0qn70DO1gf98mZvUxJ?=
 =?us-ascii?Q?I2IkrxOcAqoAhYgvjZ6S2lu+k7HGUjLAMKkgOkgw39zIVJFrKAfiGmBjwsiA?=
 =?us-ascii?Q?Sn6lNRPhjpWSMF6fTRTSNsghgj5PArpMqm4njanM3HxGN8M9wOFf4zZ24Xch?=
 =?us-ascii?Q?9iBktXvkOnMx3wqfiP/dibkzjLntsWCk5hR+GO6raEfo59VKGkvhCYXjDUrg?=
 =?us-ascii?Q?18Ew4Ya7eJOJsRGq+9PO76uNCMon0NxuiX48Vy5/vREky/8abSTAXGUD7jW2?=
 =?us-ascii?Q?o4xRF4s/utSOELSk2w+zBuPmndVEQR83TQbLDAYL73FCfgCjwvfGPBrdIeao?=
 =?us-ascii?Q?mzc3QFhGztyrifXeQHstGyEGr3ymqT1XWps0uc8PuS3gMLPFNFgiJPEw6gc1?=
 =?us-ascii?Q?uYsr6AX0WOePAv6P7Qs9x2H++DJwKGKCH+9CESA6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lJvYrdU8aaRwijiEqa/XjIkmI/nnlVRJ1+eAlWEktkpkfXMha+yU16rYk5q3FFzhcirW0u/kZztpr5IWJbfEaAybpDLodfF9lI1nOjk1WCxFAuk/ax7GHgdLLON6Mdp2WZGDwymmUqz2ZQ9sSlfw8o9kgfdaRatk1jlWyG0dT8gXGSRD9+j0yZ/lsyVQBcG3jyVJ7+BpgFsrKQQv1N+RY6gw3S+KV7cS1zS6DF0CdWlqTdpqpE/wI4Ued1xAjHoNW4plusIDedQDPPV7K4v3fLk/z+e1FhwllRG/ByKfSdk50vgqai4wtcDgVUsQWMsQp6wKGGA4z87Oxnv8gNQXbvl2+yD4PWlxI2rAgtUvJisEmmaW6JTZp5xiGxBEGyOolgmYCM5A3/74mzCjhRO3wB7rZ11uemk6s+GrcN+szrMhHPxAGKw/vMKn1I9YUBBUcJwQu3hB7PhdsvKwYeEeoBX0MHgp/Kd2LmbpjLzHxZdo75H1VeRCRVjJcXuIszf+kagGTQMQhlFCVarYBgQ6pg9PwOQr6c9cncCVNaoRcy3Rppbtt35J0uyueqrLhrm8vXA2HXOnJ0Sww/zxubGIiQ3kBYC8/calgZXhQ7YgVz+ZLIxaZFsTRMZGL+GmJXb9
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6770.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb02684-3608-4eba-a07c-08dc26f8b543
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 09:48:01.4388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0V6hyOn4JbK6WwGc1KcuiY4M8celTpdrBfOA9MvHVDzpwo/Pi9QfBGpEBhwUhzgWyf5keGA1FHTHOSZck4AiNf0F/4h7LRDZeP6mVwpDPtY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8499
X-Proofpoint-GUID: lNaveijc9eGH1PT27GTC21251NxDOjxq
X-Proofpoint-ORIG-GUID: lNaveijc9eGH1PT27GTC21251NxDOjxq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_02,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=848 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 clxscore=1011 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402060069

LGTM, Acked.

> -----Original Message-----
> From: Viken Dadhaniya
> Sent: Tuesday, January 30, 2024 10:48 AM
> To: Viken Dadhaniya (QUIC) <quic_vdadhani@quicinc.com>;
> andersson@kernel.org; konrad.dybcio@linaro.org; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org; linux-arm-
> sm@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Mukesh Savaliya (QUIC) <quic_msavaliy@quicinc.com>; Visweswara
> Tanuku (QUIC) <quic_vtanuku@quicinc.com>; Chandana Kishori Chiluveru
> (QUIC) <quic_cchiluve@quicinc.com>; krzysztof.kozlowski@linaro.org; Viken
> Dadhaniya (QUIC) <quic_vdadhani@quicinc.com>
> Subject: RE: [V2 RESEND] arm64: dts: qcom: sc7280: add slimbus DT node
>=20
> Gentle reminder for review.
>=20
> Thanks
> Viken
>=20
> > -----Original Message-----
> > From: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> > Sent: Tuesday, December 12, 2023 8:20 PM
> > To: andersson@kernel.org; konrad.dybcio@linaro.org;
> > robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > conor+dt@kernel.org; linux-arm- sm@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> > Cc: Vijaya Krishna Nivarthi (Temp) (QUIC) <quic_vnivarth@quicinc.com>;
> > Mukesh Savaliya (QUIC) <quic_msavaliy@quicinc.com>; Visweswara
> Tanuku
> > (QUIC) <quic_vtanuku@quicinc.com>; Chandana Kishori Chiluveru (QUIC)
> > <quic_cchiluve@quicinc.com>; krzysztof.kozlowski@linaro.org; Viken
> > Dadhaniya
> > (QUIC) <quic_vdadhani@quicinc.com>
> > Subject: [V2 RESEND] arm64: dts: qcom: sc7280: add slimbus DT node
> >
> > Populate the DTSI node for slimbus instance to be used by BT FM client.
> >
> > Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
Acked-by: Mukesh Kumar Savaliya < quic_msavaliy@quicinc.com>
> > ---
> > v1 -> v2:
> > - change 0x0 -> 0 to reg property.
> > - reorder the DT property.
> > - change node tag slim_msm to slim.
> > ---
> >  arch/arm64/boot/dts/qcom/sc7280.dtsi | 25
> +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > index 04bf85b0399a..9fec8743e19a 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > @@ -2528,6 +2528,31 @@
> >  			status =3D "disabled";
> >  		};
> >
> > +		slimbam: dma-controller@3a84000 {
> > +			compatible =3D "qcom,bam-v1.7.0";
> > +			reg =3D <0 0x03a84000 0 0x20000>;
> > +			interrupts =3D <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
> > +			#dma-cells =3D <1>;
> > +			qcom,controlled-remotely;
> > +			num-channels  =3D <31>;
> > +			qcom,ee =3D <1>;
> > +			qcom,num-ees =3D <2>;
> > +			iommus =3D <&apps_smmu 0x1826 0x0>;
> > +			status =3D "disabled";
> > +		};
> > +
> > +		slim: slim-ngd@3ac0000 {
> > +			compatible =3D "qcom,slim-ngd-v1.5.0";
> > +			reg =3D <0 0x03ac0000 0 0x2c000>;
> > +			interrupts =3D <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
> > +			dmas =3D <&slimbam 3>, <&slimbam 4>;
> > +			dma-names =3D "rx", "tx";
> > +			iommus =3D <&apps_smmu 0x1826 0x0>;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +			status =3D "disabled";
> > +		};
> > +
> >  		lpass_hm: clock-controller@3c00000 {
> >  			compatible =3D "qcom,sc7280-lpasshm";
> >  			reg =3D <0 0x03c00000 0 0x28>;
> > --
> > QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
> > member of Code Aurora Forum, hosted by The Linux Foundation
>=20


