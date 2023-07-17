Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B13755AEB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 07:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjGQFlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 01:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjGQFlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 01:41:49 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2048.outbound.protection.outlook.com [40.107.15.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33B8138;
        Sun, 16 Jul 2023 22:41:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHuGiotM22BL49S+qb3NBSUHIJ7WfIkvTasIRxNaUpADhPX9KNowcCHbg6bZboUVtibAZ3YCm5NKS6cQ9aK4qgdlN02cw26WtZSQzocKMdwZFeq6ku1a8uVvfuLUT1uIvKxjsdM4nX/x8urFL4J3DxQYFQTR9VNEtZ7hpNcKLRHopLRnj2Ou/EQGZddwCGbgOExZ3ditNC5ReINHFyY7thmxe9xhuDcOjIGAW2SuZi5SmbKQA5lwUH/58oDiuj3yiD6BoXXQh8ONKfrno+lVQuQhE/hEL3lerpnt5poHBHInbf+hBClBg6bWfRWmUFmhp1gx42bE9UQFGKeNya5BGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCCQ1liYnjbIS2Tk8xWYRsIy2N1yKY9EZ9Md3rD8H00=;
 b=KFqH8eFS/iCXBQwmK8M+4QiTNesDKxWVvTBGoqeZfcHqfRRBTk4WdI/QLMeHqnDgnkYnJnR853n4gGO+V5db8hBAqejUkVTdgUBEW8evJLJ4wko0n1CqWLOhrqcR7AeEJ6a+kUnOy990kYoAC1OpSRz8vTO19uyADJK6pEhakAQJMxsZh1t8Es7IhSXX+hBiADeRcBlOZd7YQyksSq3Cz0TUGc1oONUd+bk9JuDnAUSfEU7tY0hrJTaiCAJq15XddEyVlNIliXbJTPGGxHQOxuBCZlttoA6yvtNH80WMzuyBOvBKBbGCxCpyz99IUE+wIwx4iG2HYgWtuH3JXB7SnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCCQ1liYnjbIS2Tk8xWYRsIy2N1yKY9EZ9Md3rD8H00=;
 b=jgX//rkptEiBpqozBPflES1SZAJ3nm4Z0+G5k73kFXlKb3Dnl/Ip/H+4QyQFhDsjIvLoGWik3BtSUfHlGkUEMlhtV6ppiWMydyY1KarZgzRsonqmAsCRDgLbkVzo7kRmUNwa6TDEOhIUbVwLXbOP3ZFZaZ9Ta4jIPo4aR0xIhJM=
Received: from VI1PR04MB6013.eurprd04.prod.outlook.com (2603:10a6:803:cb::15)
 by AM0PR04MB7185.eurprd04.prod.outlook.com (2603:10a6:208:19d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 05:41:46 +0000
Received: from VI1PR04MB6013.eurprd04.prod.outlook.com
 ([fe80::d375:ff5f:2ab0:d6bf]) by VI1PR04MB6013.eurprd04.prod.outlook.com
 ([fe80::d375:ff5f:2ab0:d6bf%5]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 05:41:45 +0000
From:   Gaurav Jain <gaurav.jain@nxp.com>
To:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/2] Add power management support in CAAM driver 
Thread-Topic: [PATCH 0/2] Add power management support in CAAM driver 
Thread-Index: AQHZtIcu6rl23Yv0lUibpSP6mPlkJa+9eaWg
Date:   Mon, 17 Jul 2023 05:41:45 +0000
Message-ID: <VI1PR04MB60130F3AC609998E954F321BE73BA@VI1PR04MB6013.eurprd04.prod.outlook.com>
References: <20230712060728.3562376-1-meenakshi.aggarwal@nxp.com>
In-Reply-To: <20230712060728.3562376-1-meenakshi.aggarwal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB6013:EE_|AM0PR04MB7185:EE_
x-ms-office365-filtering-correlation-id: fa680300-b59e-4f79-8548-08db86888200
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eNkGWSI/lxL+ImOr6afyBHjtBwbaAjezYEa0jprPW7P9rLj0EcOyzZW0HyEBlvi2EnFwpyHxJoBoDkr4ultEynlVTxwjfpLrbkbEvXOuoU+oWx5kavui2NMUy10glvLslwP19dEyKZoyTkTNfPrEILk8M46X9hU1Qm9p6FgoLC9I437McL5H+Z3mLubv75SeSe6EPLW06fhe9Eour9P2J0ELUHEoY/2SRZ4A3CnP8NoFgOu6OOH+/4DYX1TX7pLhIyCCEiMoS07N7gp3cfh9eTHsVdHCjjXyCZCw89jwHMWTRSpBY2O0QnL+0mjpYpYghfWAYEC6nHYRsv6pTYY99ZNWTHSdULf8io0PEvKdtXEriSUN9gqH/VXrV4lg/u3Lbb2CWoGmoQNO0ohOYRJHaOUrVIQLwUaZEuayLVw4KSCPlGJ2Zix1r9tKBuY3rSmqFhsy7VB0bSF3xPcc22T02iOWrTIAQPc8NtBCswDPnguMW1SeHfv9gWDh98Gp6Ubac0pVQZUfNt7Y/nB+R8kOmE5bwXKShw5AHVGqJ1tH8VrY71IFQRkwz3jTMJxnQ3ks5ZksZTlToyyjkoejNE/Znl2tXWchKtbXfbaJblla+nG6EDNlAtDhevBKLcvtFw8K
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6013.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(451199021)(55016003)(122000001)(110136005)(38100700002)(7696005)(478600001)(41300700001)(5660300002)(71200400001)(8936002)(52536014)(8676002)(316002)(66946007)(66476007)(66446008)(64756008)(76116006)(66556008)(4743002)(186003)(83380400001)(53546011)(9686003)(6506007)(86362001)(33656002)(44832011)(38070700005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1JoSUJveS9YdzJnOWRIUDlRdE5HRHFYYU53N3dMVnhFTDViVnRyOWR3UmFk?=
 =?utf-8?B?Zm80U2gyOGZQaWVrdjllTjkzaEZ4MUhkWVAwUEs2K2xCcDFzRmJWTjVHQm0y?=
 =?utf-8?B?NVNWWUhDNlh3cmR6dGkvWkpYb0RRWDNIYnkwc2ZXNFpUSE1HQm5IUThBSFJH?=
 =?utf-8?B?RStWUFFpL05aWHVFb1lYd1VjajJCaGE3OHp5SGIrY3c2cE5pZnY2T1M5dEJa?=
 =?utf-8?B?ZjliUVpPRDJ3QU1TQkNRZkdVYnRzM1ZwaDJ0eDlUdVZYTXk4UUp2QWVVMHVm?=
 =?utf-8?B?dUtnNWVRVnNRditVN3c2Mm9takpLQTE5aTJxQ2M2Nk94OUQyMzFVNXlJUFV3?=
 =?utf-8?B?YWV2WFd1eXZSYWFqYWYxZTNPUGpoUjRIVzhvZUdzREVyeWFlaHlEOUFqRGdO?=
 =?utf-8?B?ZVQrOGZjcnBjclNVcVRhNG1EbVBua3UzbmQ3Nlh4ZS82Tm8yVFloekpLVlBS?=
 =?utf-8?B?MThXcmZXOE91MjIrQW5ldmNQRmNEUHVrSjc4a2JsYkZFME9nbSttblBHb2FH?=
 =?utf-8?B?UVEyNDNIaTZTaHpjK2diZE4xWnFNMmM4V2xVZzNOclAwVmIyVnNVRnREQ21k?=
 =?utf-8?B?TlA3ZzBhMWhrZE9FWjZKbHljeUI3akhBMG9TS3BsRXpvRUlvaVNqQTVoYnQ1?=
 =?utf-8?B?Mk56MytMK3FRZFVIR2RIelE5ZDdrNlQwUVBFUEVrMVBZVy9xMzQ3Z0NRR1pm?=
 =?utf-8?B?N3BQYTJMTmlaNEtaa2xLN091aHFqZUtYZm9wR29ud2hFQXMrNFRGSFdrQ2VZ?=
 =?utf-8?B?SVdQMnhrb2hnMm9SSU9TaXRkam15bUVJQkhpd21CbVc2TUxGcVBRUWlsWWU2?=
 =?utf-8?B?NjRXb0JkVG92SDk2ODZoUjZvNFpKaE9BTkV4V1RZTW9KeEZqV2hzSzFUMk5H?=
 =?utf-8?B?S1hjRjJEREFLNDBWelQvbnp0bWhhS3dEMlJqMDhxc0hTL09BNGQ2dlVDQmYx?=
 =?utf-8?B?RHN5Y3FVRnFON1dWZCt2dGZhU3BVZ0Nub2FHU250L0E2VHpxVTZBd25aaEMw?=
 =?utf-8?B?Q0ZocVhVSmZxQWdyQ3VKdEFjR1pMbHYrVkZLRFcwQ0hUb01RZnBIczA0YUpx?=
 =?utf-8?B?MGMvMU5VTmtFZFZHQWlEdUg3OXd4N3ZnKzFjZEhsblkyZFZadVpuUUw3V0RS?=
 =?utf-8?B?ZDlVOVk0VHAxMVVTemlvVnIxMkhYSjU2dDhFVnRmckhlZUpxdWdiOUFhMEQy?=
 =?utf-8?B?cFlmZExSdTZxcVZRTDFpRnpRNjBHY2wvSFVlU0RMME5STXlGc2luZmd1QVRP?=
 =?utf-8?B?dmZMbXNCZUVCcjMzZ0FJcGdIQ3hIRExTTzVjaGtiZ3UrdVNxZVlhbGdYcE04?=
 =?utf-8?B?ZjBwc1pqSjVQa3JQWjkyV0N2NzNlYkhjRE5SbjNwS056ZTZhejgwaHhneU5L?=
 =?utf-8?B?RzMyRitxQnplMTNBR0tDQ1RSR0ZPejVIYW5ZY2xTQmZwejJDak5iaFR2ZG9V?=
 =?utf-8?B?UTBrZmIreHFEMTVyMDlsdHhMa2lLaVFZaGFRdzFKczRKZ0h5UnNzV0NEc3NB?=
 =?utf-8?B?eWhicWZ5M0JlL2I2M2lsc2pJUFZMN0tnT2h3QStSdk1sbDlHK1hGY1ovVTFI?=
 =?utf-8?B?NTZweVA5TTlvenVRS0YzYmd3ZXhJWDhDYVN0Zm9FRlh4RzhlRkZzTGFDY2ZH?=
 =?utf-8?B?MkoxUVMrbU5SK1VySlF5empvOWtkdFNMRFZMaUR1eVFqN2J6bFJtdjVrVUlT?=
 =?utf-8?B?Qkd1WG4wOHpRTVVuSkpTTEEyandDRlUrd3hEaVlJQ0k1STQzM3ZsUEZHK3lM?=
 =?utf-8?B?K1E2U0dpbm4rWVFCZW4veWVpYTNYSitRUGN0TDF6Y01uelJpOUVjemJnUnFs?=
 =?utf-8?B?aVlydDhLUFlGS0FDaDI2TVRjY29OTjQxMmJTSEdlQTRYanh6eGNhcnJhNjBC?=
 =?utf-8?B?Z2pwUjFaWndveXA1UHVZR1J4dTk5MUFFMENEZ2RkUGFScGVldW50dWlUUVBS?=
 =?utf-8?B?OXgwWHh3eVlodnBTbjJ1bU9TbXVJaGx4WkVvOWNXN05jY2V3bkZjQWQrUEdK?=
 =?utf-8?B?WHY5WURDRG93NzdzM280TXk0eldmYVArS3IwRFNhSWdSV2tVTHJBQTNVUWx6?=
 =?utf-8?B?azQwRDFaOFE5R3cya2JGa0ZRT005bjZZL1JKUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6013.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa680300-b59e-4f79-8548-08db86888200
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2023 05:41:45.7298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9uDsRC04ZBySvrn6impssz6I2tFTaBqbzDnqjGsElJjb1yLzo21umHdN2EuiPABkPbKDveBJ5Ns9VNnTh2wYLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7185
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmV2aWV3ZWQtYnk6IEdhdXJhdiBKYWluIDxnYXVyYXYuamFpbkBueHAuY29tPg0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1lZW5ha3NoaSBBZ2dhcndhbCA8bWVlbmFr
c2hpLmFnZ2Fyd2FsQG54cC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSAxMiwgMjAyMyAx
MTozNyBBTQ0KPiBUbzogSG9yaWEgR2VhbnRhIDxob3JpYS5nZWFudGFAbnhwLmNvbT47IFZhcnVu
IFNldGhpIDxWLlNldGhpQG54cC5jb20+Ow0KPiBQYW5rYWogR3VwdGEgPHBhbmthai5ndXB0YUBu
eHAuY29tPjsgR2F1cmF2IEphaW4gPGdhdXJhdi5qYWluQG54cC5jb20+Ow0KPiBoZXJiZXJ0QGdv
bmRvci5hcGFuYS5vcmcuYXU7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGxpbnV4LQ0KPiBjcnlwdG9A
dmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBNZWVu
YWtzaGkgQWdnYXJ3YWwgPG1lZW5ha3NoaS5hZ2dhcndhbEBueHAuY29tPg0KPiBTdWJqZWN0OiBb
UEFUQ0ggMC8yXSBBZGQgcG93ZXIgbWFuYWdlbWVudCBzdXBwb3J0IGluIENBQU0gZHJpdmVyDQo+
IA0KPiBGcm9tOiBNZWVuYWtzaGkgQWdnYXJ3YWwgPG1lZW5ha3NoaS5hZ2dhcndhbEBueHAuY29t
Pg0KPiANCj4gVGhpcyBwYXRjaCBzZXQgYWRkIHN1cHBvcnQgb2YgUG93ZXIgTWFuYWdlbWVudCBp
biBDQUFNIGRyaXZlcg0KPiANCj4gV2UgYXJlIHNhdmluZyB0aGUgc3RhdGUgb2YgdGhlIENBQU06
DQo+ICAtIEpScyBNSUQNCj4gIC0gQWRkcmVzcyBvZiBpbnB1dCBhbmQgb3V0cHV0IHJpbmdzDQo+
IGluIHN1c3BlbmQgZnVuY3Rpb24gYW5kIGdldHRpbmcgc2FtZSBzdGF0ZSBpbiByZXN1bWUgZnVu
Y3Rpb24gb24gcGxhdGZvcm1zDQo+IHdoZXJlIHBvd2VyIG9mIENBQU0gaXMgdHVybmVkIG9mZi4N
Cj4gDQo+IEZyYW5jayBMRU5PUk1BTkQgKDEpOg0KPiAgIGNyeXB0bzogY2FhbSAtIENoYW5nZSBz
dHJ1Y3R1cmUgdHlwZSByZXByZXNlbnRpbmcgREVDTyBNSUQNCj4gDQo+IEhvcmlhIEdlYW50YSAo
MSk6DQo+ICAgY3J5cHRvOiBjYWFtIC0gYWRkIHBvd2VyIG1hbmFnZW1lbnQgc3VwcG9ydA0KPiAN
Cj4gIGRyaXZlcnMvY3J5cHRvL2NhYW0vY3RybC5jICAgfCAxMTQgKysrKysrKysrKysrKysrKysr
KysNCj4gIGRyaXZlcnMvY3J5cHRvL2NhYW0vaW50ZXJuLmggfCAgMzMgKysrKystDQo+ICBkcml2
ZXJzL2NyeXB0by9jYWFtL2pyLmMgICAgIHwgMTk5ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKystLS0tDQo+ICBkcml2ZXJzL2NyeXB0by9jYWFtL3JlZ3MuaCAgIHwgICA5ICstDQo+ICA0
IGZpbGVzIGNoYW5nZWQsIDMyOCBpbnNlcnRpb25zKCspLCAyNyBkZWxldGlvbnMoLSkNCj4gDQo+
IC0tDQo+IDIuMjUuMQ0KDQo=
