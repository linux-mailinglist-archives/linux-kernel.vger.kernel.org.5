Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6822A7DC448
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 03:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjJaCOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 22:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbjJaCOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 22:14:04 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D072CFE;
        Mon, 30 Oct 2023 19:13:28 -0700 (PDT)
X-UUID: 12c6cf48779311eea33bb35ae8d461a2-20231031
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=rllkAjhVVuHRlgAsevvLNeW7LTb4EJKvaBjjfpBkG8M=;
        b=Ql4iP+tQ0D4+AoA9Qh3cfJf3zkCoUF3bqRgTfi+id5jClN8MTPAejgtPtBbpCivSIrIS8FsOBRzRg3jVBPQsK9bOgGyE8q+z6+uAiaKBNiU1I54CfNXRqCC7dzkb/i5VsU4vimY7VKpyYe/8Jn4n0yxHOE8cRp+hEwtIUUEbebE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:f8a158c0-ebdd-4c20-8f9a-6439d52e036b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:0146f5fb-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: 12c6cf48779311eea33bb35ae8d461a2-20231031
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 276114062; Tue, 31 Oct 2023 10:13:25 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 31 Oct 2023 10:13:23 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 31 Oct 2023 10:13:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeqRSEkQHsZM0k3JASXpXlsifdfwWrD5ra2x6YMcFJq9xKa9Kx47DZSR+lMi5DXf8X58zHWTCbTheTmVIZGjeb434X/2M/zvuehDcSj2dF7aahzrYyc0G8V7kQfes5cdSNqYC3FSN/yBYGR2xoxC/NVRYfot4+KB4kPqfq0a8ewsDeurTBVu2TmCMw5w2gpy2d3AQKToyIBNcvAEJcKFti0H1bkU+4hQQZmFwye+NfEPbqEYul+LRVNtoWTrFp3VKZyT54MVGPBxTTErb69IdQ9YkGZr3G0c0AqrNlNAtv/y1Hf6uMQ+yFgxq31KhDHSuz7F6tpK/Xa9BfHtZkPtAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rllkAjhVVuHRlgAsevvLNeW7LTb4EJKvaBjjfpBkG8M=;
 b=MAb+7h9A0ODupnqWCinyhM5Use3I7ibMpRKRX3CKtBdMiXDrsFRi8cIU73ZBTRpqZhOhvv8Kso2lNrTlE0a7S4rI8/4gode/+7CZTdN1EnuNL3HIoimUjRGo9RLBc61bITRE1V6owXmhuHxQqNJByv+aUqOR5gHbGWn+mTrw66UqTTLQJuePavtaMj0S30wcKY69JqdisqMDff9CmDF2wT0oH9AzzuucEi+3QKGLdEtzSAjRtG+4YMSok8CkCepokDPEAfBjsI6aVFzXbtZ72aveu04trlqSpjFrDshGvz/4mpCWVIyLNiiDD4+HgwkCX/cafG4YxpX5evzsuyNMPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rllkAjhVVuHRlgAsevvLNeW7LTb4EJKvaBjjfpBkG8M=;
 b=MZ16LMadu+P5/Cw4+TEqfWQxnAsBr0WdIos1xQK/xgiRF9nEFVwSn2Xk67q1SKBpMKWlTs2YMqWFQMo4msXUwZxkTSbMNxq83A9P1rjjCNJMJyhE9VvteQ6lPEHr5vW97mh3OCVW4hyIwaVN/2v6KrO4ch7pfZ7dbztTxKa6XDA=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TY0PR03MB6425.apcprd03.prod.outlook.com (2603:1096:400:1af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Tue, 31 Oct
 2023 02:12:19 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::fe5a:c0e7:4b72:64f3]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::fe5a:c0e7:4b72:64f3%4]) with mapi id 15.20.6933.023; Tue, 31 Oct 2023
 02:12:19 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        "jkardatzke@google.com" <jkardatzke@google.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 00/11] Add mediate-drm secure flow for SVP
Thread-Topic: [PATCH v2 00/11] Add mediate-drm secure flow for SVP
Thread-Index: AQHaBWv+DtPKKTElakCPQS1xZAUuxrBjNIAA
Date:   Tue, 31 Oct 2023 02:12:19 +0000
Message-ID: <83ab8f76b48b27a5406a03c50467c968598b23db.camel@mediatek.com>
References: <20231023044549.21412-1-jason-jh.lin@mediatek.com>
In-Reply-To: <20231023044549.21412-1-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TY0PR03MB6425:EE_
x-ms-office365-filtering-correlation-id: ea4814aa-f9ab-4cae-6e91-08dbd9b6cfbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: StvZH7hDXDpTZv7n02AzeKVn7j/NkmcuEijj+AyYts2P7lqcVJ/4vXv+QDoX8ai6WR9BnAggRhD7oo86SX4F6lPUwWutwxkh6Uo9MgNwZFLkn7ucJnEKs4gJKIRhiIYIBL8hbS1uerQQb9TSrudxzte0Mj/sVGmTZr1URrpjK1d5FuM8EjmzA7Uv/cjNuOMO2Cgs4FkKAZvF43ETEnzDAV7h7E2fBIjB9p+h8iXo7m46mu2xQdzgYHOp8BO3deDJDr8/9Eo5MfGL7V526P6Do7piBDzOtAQ5WHceJTv7V+yDV8C1q9Y/EwZ38RUDLJUyYIZmWPbEYYCulArL/PCaHo9zCEUN955OKPVq/GE0S5dPYHugXY2JpGIEO3wN1XXHV+3p6MErjr/Es/E2RigDNXaKDpt0+FQ3gXSzvZHrKCXkE5Wi1mRcdyK0hyTm2becKgzxb4zE7mNVZ8PFik23J2nj8vCtYl10CKqsJgEg4jxGuj/SpHKBtiZhk1vHkM+SiO5bxPWPIaytz3TicBGgHGP23nDNA/VMZ17Z9k+4i/P47daGDNqU32RlNLSjpT31IEOSXJMvLN2iHQSl1MBnRVrajnMzUtG5K4cUnSs+k8FXPrroJ3QNe0xOPlYA3KWhCwaMZi8zVfKdSVdMWgz7saqb+MW3UmplWGyjOkiXz0rpTc1jC2ZlB+dkNekUXWye
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(366004)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(4001150100001)(2906002)(8676002)(7416002)(5660300002)(41300700001)(38070700009)(86362001)(4326008)(8936002)(36756003)(85182001)(6512007)(316002)(38100700002)(66476007)(54906003)(66446008)(6506007)(122000001)(64756008)(76116006)(66946007)(83380400001)(2616005)(66556008)(26005)(966005)(110136005)(6486002)(478600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2FReUM1dWxLK3cwZXpqc2JPQm9oMEVDWFNFd2ZUTi9SVVpHV2xGUlo3aDZ1?=
 =?utf-8?B?S2ZRK0ErY0FwcjFPY1BTbTY5UjVQLzdBOStXZlBIY1YzNVdCSmx4emlDNXcx?=
 =?utf-8?B?YllpMitxZmZ1UitCNUo1Y0pCNEpYelY2dFlVTjArUkd5SFlPby9neUpERWdk?=
 =?utf-8?B?TUJpYXQ1ZWJsdDk5eWprNDY2azBjYUpITWdMODI3T3ZwM25lSHRMMEpPM0lj?=
 =?utf-8?B?OXJ6N0ZKL1lMUUpRWjlYbG9vZGsxNHpVS2FkcTdlc0IxbGdvSjArblNVOGxi?=
 =?utf-8?B?eHhkeUlmcm1XcWdiQUZnRWl2aUkvUFc0UmVhYkJRb3RZYjdUbW9xbi9xQVdn?=
 =?utf-8?B?ODJlVXhjNGo0dDg0dG9JdWpGK2JiR3dGZGdCMmtxcHZNQnpMSHBaNG1oNXY4?=
 =?utf-8?B?bk96Z3lMalk5QWFIWDFCem9XTXFsTzhDdlE5RDFJaXhGaGhPWUhFbFFxVjRj?=
 =?utf-8?B?Z0Q1QnFtNHVsZlk0T3RJbFpWU2JKR3NoK2xpWFBtNzdRcVdvSEZ4c29rSTNr?=
 =?utf-8?B?eGliMzFzd1BGVUxSSEhSakhHMCtEc3A4YkNJZ0VLdE9CVTM2YTZYSlhaZmVi?=
 =?utf-8?B?cHZIS3ZjMEVIQzYzL1d2QTF4cGpGTURNRFJrMFB6cXd1enFSTVhSVXhzb0JX?=
 =?utf-8?B?T2VmMmtsbWRMdzZXaTkyZXR0eE1oeW5KUk9vRjZYMlhBc2ZKcG44dEV3Mjls?=
 =?utf-8?B?TlRQb21NWDVwQUhFd2NqU0M5N0tsQ2QydXRVMGVUSVIzSklGZGdYT0R4Y2E5?=
 =?utf-8?B?MGFMUjMxK3lsMVF2VmdBT1R3aUZBTFp5NDZJMUtHMlBWNmdCdmRvQ2ZXOFdk?=
 =?utf-8?B?WmZnRmZZb2tKcjM1bkxjdmZiZUVTTDFDTE1OdzFUVENXOHF4TGp1bXhvSlQ5?=
 =?utf-8?B?V0ovbjY4R1g5M2wxSUtsdUVUSjhsdVZ5WTdDa1QwakZGRGZMTzNZU2gzTkJN?=
 =?utf-8?B?dlFRdnRnSWxBSFczazF4eW82eU15S201M1hvbDdtYmprR0lVaDVWMmRnSW1v?=
 =?utf-8?B?YnQ2T3llbDJRbDltckkxL1YvVENIaVlKZGVmZFBLNUxrWHFYMFN6T2hzRmRT?=
 =?utf-8?B?QWZEVWQrWE9Pc1Jwc2doZFpGanlJem9LVXNCZ04xaTM3R2YyZGp0UjhTZmR5?=
 =?utf-8?B?djNaWkZ0VzU3bER1UmVMWnI5aFNuNmVKR3NyaEJHYlZ0TngyT3YzRGc1M2xy?=
 =?utf-8?B?VXhLZXNDdnZpOGRGbWtHWEgreE1BOEZmMkRqOGRsbzh5blh4bGl6cnJUVmow?=
 =?utf-8?B?T2NoM2NsUE9HeU1BTzRYZDNyUEt4Nm5MWk5nR0NaM25NTmNwTTBxWmlnQjBD?=
 =?utf-8?B?T2tzY3Z6a0g2U25UMGhuZkRaZ3FKd0tCbVZFeGsvbThiUTFWdEZxZlZrS2lt?=
 =?utf-8?B?eWo5WEY3clZUUS8zZktweGpMMklLQkdlekw5aXNveGFsUHQwWGFVcWZCeGV6?=
 =?utf-8?B?dEhmVy9KZXAxa1lrdlZSUnJTY05OTW5qTUFVeVhWNkJNSGlOd2JaVXJFTFVv?=
 =?utf-8?B?eHdtNGcrV1gzeitDNlFnV3FFSW5Wc1lia3BFdDdKVlVvK2dabVMvSVpjcHNl?=
 =?utf-8?B?cHpOZDllZjdINFRwdFByaE5abHRxWEVreVVOeEFkbEJnNGJIUHo4WFA4QjBW?=
 =?utf-8?B?cURGMkxGV3d2NWxuRmFrSWJyOW9qeFFzQ1FBbGhFdDhEemlLQVpKOVRscjNn?=
 =?utf-8?B?RU4raHA2czU3VlFXdVg5RlZrd2RFY1FudlY3YWJteEQwdDc4emp0WDFGWG8x?=
 =?utf-8?B?cEpMeHNPT2JFQ0lQR3ZsazdZZGc1ayt5eGg3b0J6TUxvclo2V0VqRUtxNFFx?=
 =?utf-8?B?RERZMm9ETjlVRjRzUjMva01wZUhpOTVoM3YyVXcyMDVzcWZUay9weW1mSFNx?=
 =?utf-8?B?OXNZSWFpK2NrdXVhMTUzNjJycUFZNGlFaHVWUzF6WWRkU3V2Tkl4MnI5Ylpp?=
 =?utf-8?B?QS9PRjNuSm9JR2crazVkMDhPUHZuSlIxRDFJZ0NTcVhrLzhzdzhlSVFHb2Jp?=
 =?utf-8?B?dWp5aGVJYk82ZnFCTGVpU01uc2NERmgwSmVtNXhxL3ZXbEh3cTJPUVZtYXpD?=
 =?utf-8?B?bkd6N3RPMWl2ZERxOXc5WnpYaC9XZnF3d1RnWFJOTkNCcy9aWXJvR0QwaS8r?=
 =?utf-8?Q?xl5HnDyZH6Tse8YsmSRHoyotC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0A6578CED5C4643AD2911D52FCC6CB1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea4814aa-f9ab-4cae-6e91-08dbd9b6cfbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 02:12:19.5379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YfDP1fR8Yub27AWFO5YhlPfzHPkBnNBoYXkBXhqZ6Z+XGMv3I9wiR5NQMo4W6QdhgZrntxR2O9MOuE6tQukihA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6425
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--14.169600-8.000000
X-TMASE-MatchedRID: X4bcv0S75Kn4OiVTWoD8RCa1MaKuob8PC/ExpXrHizz7efdnqtsaE6I6
        QrGFi8fqppLZg3jsYJiFECvR4Kt3tFFej9EwCdZzqeBupNgLgYfvL703X40xpw2Y8xyy93kWfqA
        M3SHome/m3bPTvaCIpjC6030+aK6579anDjdLGg8DSdxA8LlApX2/mTu5B5RIO+q6pkBksE/zPv
        RcNNSOxq6F8OyjenkRUNHYJMizeW4z3xviWTbUKcnUT+eskUQPmX+W7bzPOQHFJnEpmt9OE8EvF
        O9NXtNuT3l0AnIWQ5yxbHx5MoZ64uhKL24lXrDJYEtx50+o73/YiuwHRIepTdiCsYPC4Ul2Zvo+
        mFW19mArIhHNwiG1WXATsg8MODVIQv21zJNl0CyDGx/OQ1GV8upJOqLi8uKO1GcRAJRT6POOhzO
        a6g8KrX4AFF9Z5bSKD2nHPgfDnmGqjCHDkYwtwpDpY6nz2vRFqkWlFE7hSrE=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.169600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: F3ACE9F0CFE844598F79EA8A89DC5086515876BFEB8AEFDDE27EC6C7245DDE132000:8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEphc29uOg0KDQpPbiBNb24sIDIwMjMtMTAtMjMgYXQgMTI6NDUgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gVGhlIHBhdGNoIHNlcmllcyBwcm92aWRlcyBkcm0gZHJpdmVyIHN1cHBv
cnQgZm9yIGVuYWJsaW5nIHNlY3VyZQ0KPiB2aWRlbw0KPiBwYXRoIChTVlApIHBsYXliYWNrIG9u
IE1lZGlhaVRlayBoYXJkd2FyZSBpbiB0aGUgTGludXgga2VybmVsLg0KPiANCj4gTWVtb3J5IERl
ZmluaXRpb25zOg0KPiBzZWN1cmUgbWVtb3J5IC0gTWVtb3J5IGFsbG9jYXRlZCBpbiB0aGUgVEVF
IChUcnVzdGVkIEV4ZWN1dGlvbg0KPiBFbnZpcm9ubWVudCkgd2hpY2ggaXMgaW5hY2Nlc3NpYmxl
IGluIHRoZSBSRUUgKFJpY2ggRXhlY3V0aW9uDQo+IEVudmlyb25tZW50LCBpLmUuIGxpbnV4IGtl
cm5lbC91c2Vyc3BhY2UpLg0KPiBzZWN1cmUgaGFuZGxlIC0gSW50ZWdlciB2YWx1ZSB3aGljaCBh
Y3RzIGFzIHJlZmVyZW5jZSB0byAnc2VjdXJlDQo+IG1lbW9yeScuIFVzZWQgaW4gY29tbXVuaWNh
dGlvbiBiZXR3ZWVuIFRFRSBhbmQgUkVFIHRvIHJlZmVyZW5jZQ0KPiAnc2VjdXJlIG1lbW9yeScu
DQo+IHNlY3VyZSBidWZmZXIgLSAnc2VjdXJlIG1lbW9yeScgdGhhdCBpcyB1c2VkIHRvIHN0b3Jl
IGRlY3J5cHRlZCwNCj4gY29tcHJlc3NlZCB2aWRlbyBvciBmb3Igb3RoZXIgZ2VuZXJhbCBwdXJw
b3NlcyBpbiB0aGUgVEVFLg0KPiBzZWN1cmUgc3VyZmFjZSAtICdzZWN1cmUgbWVtb3J5JyB0aGF0
IGlzIHVzZWQgdG8gc3RvcmUgZ3JhcGhpYw0KPiBidWZmZXJzLg0KPiANCj4gTWVtb3J5IFVzYWdl
IGluIFNWUDoNCj4gVGhlIG92ZXJhbGwgZmxvdyBvZiBTVlAgc3RhcnRzIHdpdGggZW5jcnlwdGVk
IHZpZGVvIGNvbWluZyBpbiBmcm9tIGFuDQo+IG91dHNpZGUgc291cmNlIGludG8gdGhlIFJFRS4g
VGhlIFJFRSB3aWxsIHRoZW4gYWxsb2NhdGUgYSAnc2VjdXJlDQo+IGJ1ZmZlcicgYW5kIHNlbmQg
dGhlIGNvcnJlc3BvbmRpbmcgJ3NlY3VyZSBoYW5kbGUnIGFsb25nIHdpdGggdGhlDQo+IGVuY3J5
cHRlZCwgY29tcHJlc3NlZCB2aWRlbyBkYXRhIHRvIHRoZSBURUUuIFRoZSBURUUgd2lsbCB0aGVu
DQo+IGRlY3J5cHQNCj4gdGhlIHZpZGVvIGFuZCBzdG9yZSB0aGUgcmVzdWx0IGluIHRoZSAnc2Vj
dXJlIGJ1ZmZlcicuIFRoZSBSRUUgd2lsbA0KPiB0aGVuIGFsbG9jYXRlIGEgJ3NlY3VyZSBzdXJm
YWNlJy4gVGhlIFJFRSB3aWxsIHBhc3MgdGhlICdzZWN1cmUNCj4gaGFuZGxlcycgZm9yIGJvdGgg
dGhlICdzZWN1cmUgYnVmZmVyJyBhbmQgJ3NlY3VyZSBzdXJmYWNlJyBpbnRvIHRoZQ0KPiBURUUg
Zm9yIHZpZGVvIGRlY29kaW5nLiBUaGUgdmlkZW8gZGVjb2RlciBIVyB3aWxsIHRoZW4gZGVjb2Rl
IHRoZQ0KPiBjb250ZW50cyBvZiB0aGUgJ3NlY3VyZSBidWZmZXInIGFuZCBwbGFjZSB0aGUgcmVz
dWx0IGluIHRoZSAnc2VjdXJlDQo+IHN1cmZhY2UnLiBUaGUgUkVFIHdpbGwgdGhlbiBhdHRhY2gg
dGhlICdzZWN1cmUgc3VyZmFjZScgdG8gdGhlDQo+IG92ZXJsYXkNCj4gcGxhbmUgZm9yIHJlbmRl
cmluZyBvZiB0aGUgdmlkZW8uDQo+IA0KPiBFdmVyeXRoaW5nIHJlbGF0aW5nIHRvIGVuc3VyaW5n
IHNlY3VyaXR5IG9mIHRoZSBhY3R1YWwgY29udGVudHMgb2YNCj4gdGhlDQo+ICdzZWN1cmUgYnVm
ZmVyJyBhbmQgJ3NlY3VyZSBzdXJmYWNlJyBpcyBvdXQgb2Ygc2NvcGUgZm9yIHRoZSBSRUUgYW5k
DQo+IGlzIHRoZSByZXNwb25zaWJpbGl0eSBvZiB0aGUgVEVFLg0KPiANCj4gRFJNIGRyaXZlciBo
YW5kbGVzIGFsbG9jYXRpb24gb2YgZ2VtIG9iamVjdHMgdGhhdCBhcmUgYmFja2VkIGJ5IGENCj4g
J3NlY3VyZQ0KPiBzdXJmYWNlJyBhbmQgZm9yIGRpc3BsYXlpbmcgYSAnc2VjdXJlIHN1cmZhY2Un
IG9uIHRoZSBvdmVybGF5IHBsYW5lLg0KPiBUaGlzIGludHJvZHVjZXMgYSBuZXcgZmxhZyBmb3Ig
b2JqZWN0IGNyZWF0aW9uIGNhbGxlZA0KPiBEUk1fTVRLX0dFTV9DUkVBVEVfRU5DUllQVEVEIHdo
aWNoIGluZGljYXRlcyBpdCBzaG91bGQgYmUgYSAnc2VjdXJlDQo+IHN1cmZhY2UnLiBBbGwgY2hh
bmdlcyBoZXJlIGFyZSBpbiBNZWRpYVRlayBzcGVjaWZpYyBjb2RlLg0KPiANCj4gLS0tDQo+IEJh
c2VkIG9uIDMgc2VyaWVzIGFuZCAxIHBhdGNoOg0KPiBbMV0gZG1hLWJ1ZjogaGVhcHM6IEFkZCBN
ZWRpYVRlayBzZWN1cmUgaGVhcA0KPiAtIA0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19f
aHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL2xpc3Qv
P3Nlcmllcz03ODI3NzZfXzshIUNUUk5LQTl3TWcwQVJidyFtRkt4R2ZwWExFRjgtQXpobGpHR19O
MTJiay1oN1cwLUpaZVRaWmtxeEpnQjVXRmJNVHhlRWphbHJzbExyQUozaXdZRjYtazI3M2pnelhL
U1FYY2JnUFUkDQo+ICANCj4gDQo+IFsyXSBhZGQgZHJpdmVyIHRvIHN1cHBvcnQgc2VjdXJlIHZp
ZGVvIGRlY29kZXINCj4gLSANCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8v
cGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9saXN0Lz9zZXJpZXM9
NzgyOTIyX187ISFDVFJOS0E5d01nMEFSYnchbUZLeEdmcFhMRUY4LUF6aGxqR0dfTjEyYmstaDdX
MC1KWmVUWlprcXhKZ0I1V0ZiTVR4ZUVqYWxyc2xMckFKM2l3WUY2LWsyNzNqZ3pYS1NJUHlDUXhJ
JA0KPiAgDQo+IA0KPiBbM10gc29jOiBtZWRpYXRlazogQWRkIHJlZ2lzdGVyIGRlZmluaXRpb25z
IGZvciBHQ0UNCj4gLSANCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vcGF0
Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9wYXRjaC8yMDIzMTAxNzA2
NDcxNy4yMTYxNi0yLXNoYXduLnN1bmdAbWVkaWF0ZWsuY29tL19fOyEhQ1RSTktBOXdNZzBBUmJ3
IW1GS3hHZnBYTEVGOC1BemhsakdHX04xMmJrLWg3VzAtSlplVFpaa3F4SmdCNVdGYk1UeGVFamFs
cnNsTHJBSjNpd1lGNi1rMjczamd6WEtTck84Z21iSSQNCj4gIA0KPiANCj4gWzRdIEFkZCBDTURR
IHNlY3VyZSBkcml2ZXIgZm9yIFNWUA0KPiAtIA0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3Yz
L19faHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL2xp
c3QvP3Nlcmllcz03OTU1MDJfXzshIUNUUk5LQTl3TWcwQVJidyFtRkt4R2ZwWExFRjgtQXpobGpH
R19OMTJiay1oN1cwLUpaZVRaWmtxeEpnQjVXRmJNVHhlRWphbHJzbExyQUozaXdZRjYtazI3M2pn
elhLU3Bvc0QyUmskDQo+ICANCg0KU2VjdXJlIGRpc3BsYXkgZGVwZW5kIG9uIHNlY3VyZSBtbXN5
cy4gUm91dGluZyBjb250cm9sIHNob3VsZCBiZSBzZWN1cmUNCnNvIG1tc3lzIGRyaXZlciBzaG91
bGQgaGF2ZSBzb21lIG1vZGlmaWNhdGlvbiB0aGF0IGNhbGwgaW50byBzZWN1cmUNCndvcmxkIHRv
IGNoYW5nZSByb3V0aW5nLiBBZGQgbW1zeXMgc2VyaWVzIGluIHRoaXMgZGVwZW5kZW5jeSBsaXN0
Lg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiAtLS0NCj4gQ2hhbmdlIGluIHYyOg0KPiANCj4gMS4gcmVt
b3ZlIHRoZSBEUklWRVJfUkROREVSIGZsYWcgZm9yIG10a19kcm1faW9jdGwNCj4gMi4gbW92ZSBj
bWRxX2luc2VydF9iYWNrdXBfY29va2llIGludG8gY2xpZW50IGRyaXZlcg0KPiAzLiBtb3ZlIHNl
Y3VyZSBnY2Ugbm9kZSBkZWZpbmUgZnJvbSBtdDgxOTUtY2hlcnJ5LmR0c2kgdG8gbXQ4MTk1LmR0
c2kNCj4gLS0tDQo+IA0KPiBDSyBIdSAoMSk6DQo+ICAgZHJtL21lZGlhdGVrOiBBZGQgaW50ZXJm
YWNlIHRvIGFsbG9jYXRlIE1lZGlhVGVrIEdFTSBidWZmZXIuDQo+IA0KPiBKYXNvbi1KSC5MaW4g
KDEwKToNCj4gICBkcm0vbWVkaWF0ZWsvdWFwaTogQWRkIERSTV9NVEtfR0VNX0NSRUFURURfRU5D
UllQVFRFRCBmbGFnDQo+ICAgZHJtL21lZGlhdGVrOiBBZGQgc2VjdXJlIGJ1ZmZlciBjb250cm9s
IGZsb3cgdG8gbXRrX2RybV9nZW0NCj4gICBkcm0vbWVkaWF0ZWs6IEFkZCBzZWN1cmUgaWRlbnRp
ZnkgZmxhZyBhbmQgZnVuY3V0aW9uIHRvDQo+IG10a19kcm1fcGxhbmUNCj4gICBkcm0vbWVkaWF0
ZWs6IEFkZCBtdGtfZGRwX3NlY193cml0ZSB0byBjb25maWcgc2VjdXJlIGJ1ZmZlciBpbmZvDQo+
ICAgZHJtL21lZGlhdGVrOiBBZGQgZ2V0X3NlY19wb3J0IGludGVyZmFjZSB0byBtdGtfZGRwX2Nv
bXANCj4gICBkcm0vbWVkaWF0ZWs6IEFkZCBzZWN1cmUgbGF5ZXIgY29uZmlnIHN1cHBvcnQgZm9y
IG92bA0KPiAgIGRybS9tZWRpYXRlazogQWRkIHNlY3VyZSBsYXllciBjb25maWcgc3VwcG9ydCBm
b3Igb3ZsX2FkYXB0b3INCj4gICBkcm0vbWVkaWF0ZWs6IEFkZCBzZWN1cmUgZmxvdyBzdXBwb3J0
IHRvIG1lZGlhdGVrLWRybQ0KPiAgIGRybS9tZWRpYXRlazogQWRkIGNtZHFfaW5zZXJ0X2JhY2t1
cF9jb29raWUgYmVmb3JlIHNlY3VyZSBwa3QNCj4gZmluYWxpemUNCj4gICBhcm02NDogZHRzOiBt
dDgxOTU6IEFkZCBzZWN1cmUgbWJveCBzZXR0aW5ncyBmb3IgdmRvc3lzDQo+IA0KPiAgYXJjaC9h
cm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxOTUuZHRzaSAgICAgIHwgICA2ICstDQo+ICBkcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmggICAgICAgfCAgIDMgKw0KPiAgZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jICAgICAgIHwgIDMxICstDQo+ICAu
Li4vZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRhcHRvci5jICAgfCAgMTUgKw0KPiAg
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jICAgICAgIHwgMjc0DQo+ICsr
KysrKysrKysrKysrKysrLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0
Yy5oICAgICAgIHwgICAxICsNCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rk
cF9jb21wLmMgICB8ICAxNCArDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9k
ZHBfY29tcC5oICAgfCAgMTMgKw0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
ZHJ2LmMgICAgICAgIHwgIDEzICsNCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJt
X2dlbS5jICAgICAgICB8IDEyMSArKysrKysrKw0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kcm1fZ2VtLmggICAgICAgIHwgIDE2ICsNCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHJtX3BsYW5lLmMgICAgICB8ICAgNyArDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RybV9wbGFuZS5oICAgICAgfCAgIDIgKw0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19tZHBfcmRtYS5jICAgICAgIHwgIDExICstDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX21kcF9yZG1hLmggICAgICAgfCAgIDIgKw0KPiAgaW5jbHVkZS91YXBpL2RybS9t
ZWRpYXRla19kcm0uaCAgICAgICAgICAgICAgIHwgIDU5ICsrKysNCj4gIDE2IGZpbGVzIGNoYW5n
ZWQsIDU3MCBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkNCj4gIGNyZWF0ZSBtb2RlIDEw
MDY0NCBpbmNsdWRlL3VhcGkvZHJtL21lZGlhdGVrX2RybS5oDQo+IA0K
