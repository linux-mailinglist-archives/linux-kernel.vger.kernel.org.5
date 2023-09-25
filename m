Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DFB7ACF68
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 07:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjIYFWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 01:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjIYFWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 01:22:12 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB190DA;
        Sun, 24 Sep 2023 22:22:04 -0700 (PDT)
X-UUID: 70ec15705b6311ee8051498923ad61e6-20230925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=AznRIICahdzV825YF6kwtchoWm1Jez+chMvzAEVD4MM=;
        b=XRMD9/p/MK0cirQ4Zh8tME8Ll+Mj3f2TW5gD+cvN7GSBt1g17MPuR7i5JRRDlqVZJubRH8Um25Om22EdGZ7dfzaSn/+CQJYBJA+/Orj+S3ssiupUaHzfrbvSsiH6MjxOvd7DUxCRQkDCUCRKbkamQYWNPLm6HI/XmryrYLBRL3Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:cee31d71-ed1c-4308-9afd-ac48e2926238,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:94093bbf-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 70ec15705b6311ee8051498923ad61e6-20230925
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1697014448; Mon, 25 Sep 2023 13:21:54 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 25 Sep 2023 13:21:53 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 25 Sep 2023 13:21:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJh275rLXwVR28Fr8eVvqUT0Cz6v01rdf9or5pc/LZ43UEXjPylI/4qQMx3WlmR4mvVsKF4Tlo+59uYz7MZzCoFRkzN7RByfWx9IMOUOO9gsmq1ulv85OMTT03O4iavdiVMdWklFftqwbHkufK3U8XUnWnYF+Y7dBcf2AdQOEO//1P5ih9q02LVk2ba2a3g8hsb04yp4q8sLLrWJijoXtLqjq3Eo27jTlw0BwHIYOfz3jL7rT+FjBeOOJDUK+uuJRh3EKcNdxrZkI1ddXby7066NlFNPgpugGR0wLx0wT78uvISS91wEhB+UD4K17fQoIleUmDkVOdD5b29DQHbaiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AznRIICahdzV825YF6kwtchoWm1Jez+chMvzAEVD4MM=;
 b=IP9bI45zEA1mZB6AJfSSDdjTVOzyaP+OOQgVaBf+RTpn5II1B/HKtBqs/IZ84yEevrp4mkcU7r6N3VMRQfPmHtbf1yA/6T7qNQVLbhSp6MGiceYMdBdOhsA0AYQg5zvMe692MIygnPPDHySBVItxPUKA3npNkxwN0BILfNvIbDdegt1DtLqgTu2ayajfGcdAMfflgw/j2Sd6OleO0gZcN9Ue8TEPpwMVnA3nadIWMOV0uToL/i7mZCf2773Va77FWdNrxwfLUXOqNyySml3PvmsXJl4qC8p2AlUgflFI4LWWU37OxKUs5ux5lmSnFajG/X2LkirZwx2D92UxBEs3Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AznRIICahdzV825YF6kwtchoWm1Jez+chMvzAEVD4MM=;
 b=ZQo3LtYlICjCCPJtY2O3PVANIJ4oFC1aD820HVYGhl7VQO0XRH985dhgDsS2HcCsdi9BUV4LU1fw4BjT3UNp3dLT14WK4LKoZUd139FQCgIR3+ePmCHpr2QTY68GnjUnAxQ9MMuWwo8JPhg7iz1JMIO1TW+9e8ZmK4D37ZHMtwc=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by PSAPR03MB5208.apcprd03.prod.outlook.com (2603:1096:301:41::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 05:21:49 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8%4]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 05:21:48 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        =?utf-8?B?RWx2aXMgV2FuZyAo546L5YabKQ==?= <Elvis.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH 07/15] mailbox: mediatek: Add loop pkt flag and irq
 handling for loop command
Thread-Topic: [PATCH 07/15] mailbox: mediatek: Add loop pkt flag and irq
 handling for loop command
Thread-Index: AQHZ6mWD5oVOGVt6VEG40kMSI9VJYbAou8iAgAJPyIA=
Date:   Mon, 25 Sep 2023 05:21:48 +0000
Message-ID: <00f0bae9940be7b397c587c651e23c6c1e19a174.camel@mediatek.com>
References: <20230918192204.32263-1-jason-jh.lin@mediatek.com>
         <20230918192204.32263-8-jason-jh.lin@mediatek.com>
         <5d528036-e506-7b95-69bb-7748b26d2aa8@linaro.org>
In-Reply-To: <5d528036-e506-7b95-69bb-7748b26d2aa8@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|PSAPR03MB5208:EE_
x-ms-office365-filtering-correlation-id: fb1e127b-4c1d-4f44-16e6-08dbbd875162
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0dlrCq/79pqpLS8oC3ruoWE7X6kfUrf6j7b8H9hO9dMhlqq33gNbGLud+G+7fMZJVrTY+6JHBLWH/ANdIkIKj8xYeaUM0aw+wQzC2i0oZ9sCdN8Qz5Ctl62CLldHqcT64FBeYgvdgIVlA5CWKYyBUSdtJ7RC+fKepV5xFW//Z3xOia6oAVSAv8hCqUkd1n3t9YnGSsjTvmGD5g0qoQ93v7vP+ONOJTMkOTta8F/8YvD00ev73ARR9i+PFvcvlm65shSIi3rs35UaZr+x7pFneUio5y9kjWTGwzKPK946M8SSBy6jNq/panvxLrBfCpzSJht4Ql8GDM8VDO6r0FRMkS9ZPgD6gR7yWos3k2yuCVGzXteAUpwC5Vq02kY/rDXiTPjiRPDu9MZ/IosTtTY91ln34uZXe41W5mNC1nFBX6OApiH6wlIqxqhirwKofU5zRdkuJzHuis0UBTInk6t2dspiV0dIU01jpHPwoHoK/wPuwmCuWbW7lLL9/t5mt/08ddDKwJAsn7DcxkPNr4DE6mycQeA9MhgvwNa6Bqe9uz5AEkium/DOKAD8n4vscUVN8ISVn+z/Pkr6fOpd4os027UVVuDcLYJj0aToVPLJUeJJpjLxDzRQlvt2df8PQIqXU+ejw9bj3M12ZplLFanTszd2CLY/Pn5io0JUjRsthig=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(39860400002)(366004)(230922051799003)(451199024)(1800799009)(186009)(8936002)(4326008)(8676002)(26005)(15650500001)(91956017)(110136005)(2906002)(478600001)(316002)(7416002)(41300700001)(76116006)(66556008)(66446008)(66946007)(54906003)(64756008)(66476007)(5660300002)(6486002)(6506007)(71200400001)(53546011)(6512007)(107886003)(36756003)(85182001)(2616005)(83380400001)(122000001)(38070700005)(38100700002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFVNdU0yUXJsbGhmWjhKMmpYNytMTXVQYk40SUNTOEZCclpzL3RnOHp6SHlW?=
 =?utf-8?B?Wm84R3Iyazd6aElGZVFkbTNYMGdzVXVUekx3cFhHclByVC9Hc2JMa085ZEVD?=
 =?utf-8?B?WG4remdJRXRtL1kzVkJzMFViVERTMmRRSU5QeGdObk8yUks2NWxvZ1VzbjBw?=
 =?utf-8?B?bG5YdE42ajBzOFU3eE9NTUVMMHdNQnFOdmZNQndWYld1b3l1TU1tbWhHdXJ2?=
 =?utf-8?B?NmVkMk12T1l5RFVZc3NaeG5XSkN6dWdVVm5JMDRsTGpjQmx2RG9SS0tVNktW?=
 =?utf-8?B?WTFieGllMmxpajY0b2JtV1l0aVNmRXFGNngwa05KRjFaNXF0QTNQeHBFRWpi?=
 =?utf-8?B?aHF3SHdEa1pncXNmYmhQdFVHVE1hVVgyRUpTNk1SeXl2ekVPZ1hFRWR1eHFH?=
 =?utf-8?B?dDRYMngyMFprREw3V2U4OGZ6SUcxUHczbEMyaHMvTjJQbG0rSWV3dU01NG5L?=
 =?utf-8?B?Y0JjOXNmMExzRjRpNjJvdGt6TkpWWGlvNGcwZ0cvSkFBUCtCMU9heWtpdVlP?=
 =?utf-8?B?S1AvWFovck1oaTB0OW9DSmNJeTMzMnVLNUJXMVJYdmRNRDRXNFhRQmh5eVN3?=
 =?utf-8?B?Q2hiYitxNUZkZzdoNHJ0QWNZcER6V2NwNWpSOGpEMzFxV2xkRUtwQjlkcWt1?=
 =?utf-8?B?bStzenY3a3JsTXA0TzJaV2JPYlprQnhtdEh6S1AzR3lVTkpmZWxYc1hUWUY4?=
 =?utf-8?B?bXRnQWRkSmlmTlM3NGFoVEhUU29rTUtET0xneUI1Zmk0TmlLamNuTnNZTU8y?=
 =?utf-8?B?TFhkQWwzRjhRZDFwb2lqelRFWkl4U0JJV3IxOWpVYUxaMmFha3JVWGdvRkpu?=
 =?utf-8?B?dlBMWWtma2dDS3loVlJMSlduanRsSXRDTXRpY0kyclZQODlyWW5WSTJCZjZH?=
 =?utf-8?B?ZDFicm5PaWcvNkJzaWdTb25ybW5RMzFJeVFZK3RBNXBTQ3FYemhubVRtK1Z2?=
 =?utf-8?B?NW5Tc3JkNnJvRGt6TW1EckNqV1d5d2VjTllVSjFNcURPSjRHa3VCL25RUGl0?=
 =?utf-8?B?dmJnOG91NFR0U3JXRDRGK1BwbWVwa1FGTTJiRWlERnAyaTUxSy9lUkFMLyt2?=
 =?utf-8?B?NDlIU0xUeTRhMkk4ekxRZzdVSWJZZUhQMjlUM1RLWERzVlRWWGM5VFhjZXdq?=
 =?utf-8?B?UjExWmJ4OUdmZjRmV1A5bEFiZm1xeVR3WlNMZmlkbzMxZkJSWmlpSndNOGpV?=
 =?utf-8?B?N0xKQWtLYW56RzdVWW16WUErb1NmemEyN3RmVmd4elpSeGltRmtKdjd2TENm?=
 =?utf-8?B?SG5xMEw3aHRmbW9sSjVKb2tPNFNUU1hCdHlPUlg1Yzg3U2ExMkVGaFpEQ3Z6?=
 =?utf-8?B?S2NYaEFmSmJPdDZocUlQOURzTC9wOFhxY2kxTUw3d3ZlaEdOcGwwby90dFJJ?=
 =?utf-8?B?cGI5a2VwVGJ6SkYrK2pBcmRZeVlxdkFXRTFBc1BvRnhKdVJmMDFPVG1WMUI4?=
 =?utf-8?B?TTcyZmFOcGJhTFhQb1JLWStVOW82dDdKUnAvcW5BaVJJV05VRUw5WTJ3S2xZ?=
 =?utf-8?B?bmdlZ0hwZlUwWnhTQWlsaW5rTmxSN0tIRWVUYWp1a2d2MnQweGlpZEh3SUtq?=
 =?utf-8?B?cmxOK1VPaVRtOUVUa0hSN2EwRjhtQ2l6am5WMGl1djhCYTNrNTNsc0cray9l?=
 =?utf-8?B?R1BWNGpqMnBEZXkwZ0ZuNDFqc2puemNSVkdtclBoQmU1UHlvODczbjlySmln?=
 =?utf-8?B?MEFVREZ2dmZpVTEzL2wwVjdLb2VvUUNFNTQxR1lwOWZJNmZMUE4wZ3RtTGZs?=
 =?utf-8?B?bU5wUnd3N1J5UXhtWEl1cEdKNENCWURqdzJDQktvWU14TDczaGhFdHExYTln?=
 =?utf-8?B?bXJWWVUwMnd5TWZtb21wVTlKMGFZemc1WERVNUl6eityNG5sRllIakw2Rlcz?=
 =?utf-8?B?c2JrclcxN0M2MFcwSUlNU3BPeGV5MDE2YkgzOW9uZ2xBc0s5bHV2dnl2VWh4?=
 =?utf-8?B?VkVGMlRHWWt3V1Y2R3h1a3BReU9aTHIxZTBMYzVTdUZ2cjFsZFQ5empaTmY1?=
 =?utf-8?B?TmQ5eFdMOWVqUVBkYlNJaCtFaVcwNDR6cFJienpWUkh4cEZrcWNkUExXSHB2?=
 =?utf-8?B?SlZvdzF6SlAyU3JVR1NrVXB2RkVrNFQ2T2ZDbEd2WG43M25aT09ZMWdxcFdD?=
 =?utf-8?B?Y0pEYXRwTVJYZnc0U0cvTzR1U3ZSTUNCUXRpNHo2dnhYTUZvYTRyRHBGSW1i?=
 =?utf-8?B?anc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1303383A9834D47BB495D2FFBD0616A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1e127b-4c1d-4f44-16e6-08dbbd875162
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 05:21:48.6354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WyWGF09nneXDLDVBixvCjgy+0Dt6ll6QPp8K4l3tlcCs54OIjw2aU2XAj4rMuXc0tB1kuIWBdjErCMnCNk4ACKyM/mZu1r3oGtkxFRfSL90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5208
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--12.997400-8.000000
X-TMASE-MatchedRID: VPleTT1nwdSnykMun0J1wmjZ8q/Oc1nAjLOy13Cgb4/n0eNPmPPe5KWz
        WoIRiV9DM/Se/q/gEyf5MiS7M8c1eGmXMi7Ntyo2mlaAItiONP1QCOsAlaxN7zaULO2AzDKgwbD
        ngUleUcLUevTYXV31fjvwttBqz9vyMRXV8lvz/l0c9jA4mLo8uRHlzzcojFNO2oLGTNKlb9eIMV
        4nweffzWGrMb9FxqvtkZOl7WKIImrS77Co4bNJXQtuKBGekqUpI/NGWt0UYPBNoa3iZGVDamYS2
        ZSrmzgWLbpduW+PjQ+NL0PBcqyQSkIb4fU9zdME
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--12.997400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: D55A8F4253E23613A6450A45F2C5F3ACA8192428430CD1792D108D3216DE16EA2000:8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXdzLg0KDQpPbiBTYXQsIDIwMjMt
MDktMjMgYXQgMjA6MDMgKzAyMDAsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+ICAJIA0K
PiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250
ZW50Lg0KPiAgT24gMTgvMDkvMjAyMyAyMToyMSwgSmFzb24tSkguTGluIHdyb3RlOg0KPiA+IENN
RFEgY2xpZW50IGNhbiB1c2UgYSBsb29wIGZsYWcgZm9yIHRoZSBDTURRIHBhY2tldCB0byBtYWtl
IGN1cnJlbnQNCj4gPiBjb21tYW5kIGJ1ZmZlciBqdW1wcyB0byB0aGUgYmVnaW5uaW5nIHdoZW4g
R0NFIGV4ZWN1dGVzIHRvIHRoZSBlbmQNCj4gPiBvZiBjb21tYW5kcyBidWZmZXIuDQo+ID4gDQo+
ID4gR0NFIGlycSBvY2N1cnMgd2hlbiBHQ0UgZXhlY3V0ZXMgdG8gdGhlIGVuZCBvZiBjb21tYW5k
IGluc3RydWN0aW9uLg0KPiA+IElmIHRoZSBDTURRIHBhY2tldCBpcyBhIGxvb3BwaW5nIGNvbW1h
bmQsIEdDRSBpcnEgaGFuZGxlciBjYW4gbm90DQo+ID4gZGVsZXRlIHRoZSBDTURRIHRhc2sgYW5k
IGRpc2FibGUgdGhlIEdDRSB0aHJlYWQuDQo+ID4gDQo+ID4gQWRkIGNtZHFfbWJveF9zdG9wIHRv
IHN1cHBvcnQgdGhyZWFkIGRpc2FibGUNCj4gDQo+IEhvdyBvciB3aGVyZSBkbyB5b3UgYWRkIGl0
PyBJIGRvIG5vdCBzZWUgaXQgaW4gdGhpcyBwYXRjaC4gWW91cg0KPiBwYXRjaHNldA0KPiBsb29r
cyByYW5kb21seSBvcmdhbml6ZWQuDQoNClRoaXMgd2lsbCBiZSB1c2VkIGluIGNtZHFfcGt0X2Zp
bmlhbGl6ZV9sb29wKCkgYXQgW1BBVENIIDgvMTVdLg0KDQptdGstY21kcS1oZWxwZXIuYyBhbmQg
bXRrLWNtZHEtbWFpbGJveC5jIGFyZSBub3QgaW4gdGhlDQpzYW1lIG1haW50YWluZXIncyB0cmVl
LCBzbyBJIHNlcGFyYXRlIHRoaXMgdG8gYW5vdGhlciBwYXRjaCBmcm9tIFtQQVRDSA0KOC8xNV0u
DQoNClJlZ2FyZHMsDQpKYXNvbi1KSC5MaW4NCg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5
c3p0b2YNCj4gDQo+IA0K
