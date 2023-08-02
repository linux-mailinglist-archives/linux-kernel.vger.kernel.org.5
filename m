Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF9176D8CF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 22:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjHBUr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 16:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjHBUr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 16:47:57 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C718B26B0;
        Wed,  2 Aug 2023 13:47:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJJnIPqMattsg5IIHC6wp2kDM+eFXR//Y5DMvT2yEGhqMH13tw2C053UjjgR+SJAtc4w9RIh6HX/9AzVI88La4eBv9xUJAmbfee1zudLARD4M5yEtzO11n9FuaSidtbcssZ/lPH7rHTOTz5Sc4qgxkYUOK6e+wEDg326U9kHkeNrI7LXS4xMgRzA+MARUoOVycTg4lAjHm18HIW7rjxqTYs09scyY8TUzPXER7BpUEZE8ZOKggMmpsTJ6YKCHfbzrHFg6bRdpvwwlVh9RipToLLilncxyqp8zsjn/Hn5N0aTQxtjjeDs5m9NlXc0nnDpxDJlDccO3u6rUFxzEK/cxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDdGX3HS3dZqYGiIPqXVisStJgI4LJJuz9bih9pIZJk=;
 b=SI/ioEPpmb8fDE3xwEe+VbxIW0xx8ycZT0Y4IB/ptFIhsR82+jHYcQAlIuwwxl7C+mbxGWiO8q3Vq6Z+X9LMCYiH7NkYdYVXLazA5wLVkynvipbcJOqUWzxZVEV/1mXcAJ2FtFuzwMFJA62oQ/qpjm8hujxM4/MNdNLx2Sch9AdE1l01mx+uZfshOgEwf/HlzkjQz9KzQYNJvU3t4plgVM0V/pVMTai1+hycvDE+UOp4jvFCkTh1YI3AlT+3bCaJE72wwEutB9IX7jhTHf4hlrMZtddlV/ukoOdYQbouWwHVp7YKRwiznNk/okZgLjZQQ1p3B4pwl5wVkHAJAPW/8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sightlineapplications.com; dmarc=pass action=none
 header.from=sightlineapplications.com; dkim=pass
 header.d=sightlineapplications.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sightlineapplications.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDdGX3HS3dZqYGiIPqXVisStJgI4LJJuz9bih9pIZJk=;
 b=pw5xMrNKj/qm0Tb21rcAXbNQD7hI7fkKYcUokKXFSEkEN4BJj9ITqEE1cZgsNZ8Pw7q3ErMdhGZI+0LaxBTLHCq2Xiqu8DAuiUwH176Jjjd4+7XTXIJ82+qFGzHUg8XqAxJSq56yKcRyVA+wlLS+x+DcoYmE4uGciUGKEen/kVbsQHa28o5spQrDZ+24ew5KxM6aG4WBzTstigcsK3By1pnRmuLRUzIpeNychfedvM81cZfIwJz4h2xLTCdyxYi5hG4+xyApmJ6W5FRzK7RWZv1vpyah3710FVTqpcijaB+CnTPS6zSnlEgAwWcqJdBoXAnm2R5LOOcfJaLZBm07fw==
Received: from SN4PR18MB4918.namprd18.prod.outlook.com (2603:10b6:806:215::8)
 by CH3PR18MB5794.namprd18.prod.outlook.com (2603:10b6:610:1b0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Wed, 2 Aug
 2023 20:47:48 +0000
Received: from SN4PR18MB4918.namprd18.prod.outlook.com
 ([fe80::44da:62f6:a0e2:812b]) by SN4PR18MB4918.namprd18.prod.outlook.com
 ([fe80::44da:62f6:a0e2:812b%7]) with mapi id 15.20.6631.046; Wed, 2 Aug 2023
 20:47:48 +0000
From:   Patrick Whewell <patrick.whewell@sightlineapplications.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        William Gray <william.gray@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk: qcom: gcc-sm8250: Fix gcc_sdcc2_apps_clk_src
Thread-Topic: [PATCH] clk: qcom: gcc-sm8250: Fix gcc_sdcc2_apps_clk_src
Thread-Index: AQHZwYgrnK1cgF9uoU6uIy4htmEHia/PjwSAgAfxn4A=
Date:   Wed, 2 Aug 2023 20:47:48 +0000
Message-ID: <SN4PR18MB49189350D03D4DF4A976B8DBE30BA@SN4PR18MB4918.namprd18.prod.outlook.com>
References: <20230728191423.13837-1-patrick.whewell@sightlineapplications.com>
 <c1726d77-ef6e-e224-3c3e-2f982fd29b79@linaro.org>
In-Reply-To: <c1726d77-ef6e-e224-3c3e-2f982fd29b79@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sightlineapplications.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN4PR18MB4918:EE_|CH3PR18MB5794:EE_
x-ms-office365-filtering-correlation-id: 45116dc6-89b1-4f1a-f3f5-08db9399bb5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JZ1FFS7S0vvY1p5rf3NivJzJs/HGu1rGvSuJ60EhXauku0N96tZZDIj2tzB3JkNoWjm+62uphU2nQgFGtc+rZO+/6IVd9esWyyRgucrR9u5cqqSe3tBVjK/x4TknPmE5ONxFh4y0KBKnA9QJnsC8DCc8XeQpAYtGiZ0e8tWfKwB7SmNQQ8hjnsLUG6vay+y+ZV3FFvS/MqHNv2drqhSDb0gDnOqdj3aDczUfzAzLyo2rJSHyshgudQE+4G5Be7HT6IoRK0p9EIf/ZBTKAzsXQHpY3vNqDSy24MAAp8JWfqFVAZvdu8OXnUF/kmySBWOTPFhGi0m5rv8aexq6OXMSRWXOWLiGSp+jfjIIpVoSF0u0ebU67GNWe4+7J9gCHmGf2apSglmQ2MDBpWwhGoGi6rm7xlinTEDwlK3f/liM/WUtmrCNJaFfY9KWMcvbbie3pkl3/LJHz+aAf1niw6VCUzziMFq5dfDdr0JPOErWcDRj0j1VAizVCxiL04GTCfIcBOKUtVYWBT6+VTNT1P5wm5OprOMrtU2aqbXHeZpQA1t6Dlhsg0TvGK+Tc/RbYNuQwjq9MbsO5bArNprm3MZ7YO5xGriGSW4+AgkB0eaRdgPTMH/ul035ZZ53Nz/82DZ/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR18MB4918.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39840400004)(136003)(366004)(376002)(346002)(451199021)(53546011)(6506007)(83380400001)(26005)(186003)(316002)(76116006)(2906002)(66946007)(4326008)(6916009)(64756008)(66446008)(66476007)(66556008)(5660300002)(52536014)(7416002)(44832011)(41300700001)(8676002)(8936002)(7696005)(71200400001)(9686003)(478600001)(54906003)(55016003)(38100700002)(122000001)(33656002)(86362001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXBnbzlma2dhVjRQS2tVZExiY29nQ0k4d3p5dW1pdU4xUFdQcjVpU2V3ZmZ1?=
 =?utf-8?B?TkExSTM5YVh1MFI5QlRGQjkza0hiR3BhTE5VUTVwdFE0WDNjZ3hZS1hIaTZR?=
 =?utf-8?B?T01DdjhINExGWUx2S3h1RkNHSFhTc2dHcHMxcFQ1aWp3VDJ1cjdXNk5CRUJE?=
 =?utf-8?B?Zmd2Z1EwSGZ5SllaRW5RVEI5MEtpMVNyWGEzdmgxL2YwMDEyV0xxVGdHRFR0?=
 =?utf-8?B?NTVGNW1kT3FCVlA0TDk0MGwvWDFsV3ZrZ1J6Rk5sUGFCc2Z2a00zbW1iY21l?=
 =?utf-8?B?TU9adFhuQ1VaYU4zSVhiV0VqR1E1SXcwK0ZTWE95Nyt5MzJsZ3FrTEFDOE9z?=
 =?utf-8?B?bnBlRkp3ZHJqRHRCV0REZ1dTZDI1UDFaK056VHhBN0dvSEhwUWlwUllJV3Bl?=
 =?utf-8?B?L201UkVGR255cTdaQ1A4NzdaZ3lZeFljcnpCWUJEU3ZPZUdlREN4OHBMd3Bt?=
 =?utf-8?B?NHB2N0NFZVZwRW0wVVNvM3FJT1BtNzlzTUR2c2RMWThKY1RFbHFYNm9MMHlL?=
 =?utf-8?B?T0lzazhMODh0VlhYaHpyb3FGK0xVUnlnSlFyQnBUb2wyQ1pwbWVzNEVXdWx1?=
 =?utf-8?B?UGloVVNRMFNoWnp4OUJJLzFORllERXN6dWpYOGc5Y1RuQkRHdkIySzRMRVVt?=
 =?utf-8?B?Sk94QnpnWDAvS2RWd002QWJLVkN1U0tseVE1L1doZkZTbG1WRHlvQlJhbk9z?=
 =?utf-8?B?U3Z4NUZ6c3V5Vmhkd28ydGQvVzBxc0lYR05yWm5rdFU1UlJYa25ONXlTeXc3?=
 =?utf-8?B?WUI5NUZaajFJRE1QZWhrT1M4MGt4TCtYa3ExazRBNWlzdEtoSXU5a0JnV3BH?=
 =?utf-8?B?UmtuRDUzSWU5VmxtMkRGV1QrUzNSZU5mekJ5dGtlVUp3dHRzU1gvakhEZDg3?=
 =?utf-8?B?Z3EwTXp3MGw0S3F1ZVVHdUFlUUNZZW1WSFF3VHZCeThqalpKUEYya0V2S2g1?=
 =?utf-8?B?eHBXb2g3NmZlbkNudzVMYWQ4SWNzWTN4TDY2WjUyM1Rmam5VWlNzT0cvTjRQ?=
 =?utf-8?B?REZPYVlNblpQZ1RhSm5iaTRBRENBWWlyaDFzeWh6Y0NwN2xQUWdUYjBSbSth?=
 =?utf-8?B?K1RyOTBIaUZKS2ZlbUE3a2xXMGRiMzhtVTVZTnpEL2hSQlFHTExvY094ak13?=
 =?utf-8?B?azJZUmtjUVpxQ0toSFl6cFZSSUQ0bFB5dVFyZVhzSjhmUjBqQVFOVjVBYUI2?=
 =?utf-8?B?RXdWdkZ6VUJnYk1JK0IyVXZaY2MyOUlVQ0NRU25SR1lNUm5xNEpYRENkR0w5?=
 =?utf-8?B?NjhuVDhvRFdLQ3ExYnh5VzVKamt6a2Y2bnRJWStUa1VWRUhOWDBTVmhXN015?=
 =?utf-8?B?MFNYV1I1VzM5a0lORTVBT09VN3lPTjF4MjdBcHpId2QrNUJpR1dzY0Z0WEtx?=
 =?utf-8?B?TnVpQmt6ZGJ2NFVmNTdIaWZHdjZSbEtZOVRaWVRuUjhCZDNtWFhjeSt3Vng1?=
 =?utf-8?B?QW40eFFqVXNCZkp2MHFrMG1FYXpkckFlUFF0TVRsU3VhWWJMamxBZ2VGYU1w?=
 =?utf-8?B?TXRUWTY2bkVEN29TWENKWWlTb3dUd1picGJQd1hvZFU2SEhOdFR6em1jTnl2?=
 =?utf-8?B?Rm9mMjhYaEpKcE83K0Y4K0ZUQy95Z1VpS3l0bWRKc25uUU0rY3ZmUnYzcEYv?=
 =?utf-8?B?VnBjRmE3a0JhbjZTaE1SeVhnaDd0ZnNqVXRJdnRKMTY0SUlaOUxYaFcvNmxC?=
 =?utf-8?B?OXhReUhUMkNiSXZ4aGk3Ukl3M2FzZ2JxYnhIaUh2L2hiNjVmbEZSTFVQbkRj?=
 =?utf-8?B?bXVTZWk2bTBmMXVrRXJ4QUNoQU9uUkQxQnl3cUZ5bGtHdlF6M1FQbXV1aFRL?=
 =?utf-8?B?aVZxby9EU1MzaUtYKzJCZ3V6ZkxtREtwUXcreFlMZEhWV3M2S21zRjcwWXhn?=
 =?utf-8?B?T0U5cmowb3VlL2FiUGFyNGlnbmEyQjRDRjFaRmxvcS9rNnhDeUkrMkkwSVVC?=
 =?utf-8?B?bXM3QVFGTHNxZHNDVld0b3RBdHBMNytjaDFqb29xVm9scmhMRkpkQmxMeXVW?=
 =?utf-8?B?YU9jWGJVbmxwa0lhMCtsWFcwdEIwNTBjZ2NCTnV3S1d0cWJYQmxOa21sbmc1?=
 =?utf-8?B?Yld4NE1aQ0JwQVFFd09oWDMwbVE4cC8zV2M5T1RsNC9xMit4RFZRYVJOeTFK?=
 =?utf-8?B?NGZhVDVMVVF6QXFKWWJnWDhrQ09pWjYxb1pOc2JpdDIvbHFwZFFMUnJrMmdN?=
 =?utf-8?Q?hSZ9fNQvOuMcYDTwkFeZlgc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sightlineapplications.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR18MB4918.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45116dc6-89b1-4f1a-f3f5-08db9399bb5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 20:47:48.5685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6f56283c-2197-4913-9761-239c8b420cf0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3lt6NI71aRKFEJOAzUZ3oyL8rTySg/PK9A5qwZOUSMb1EleUsLG5s1kpaUTMFNRHyedyrVahGD5BekVXdbBGvBmXGqWeGEbqVjce/vxYn+eFE80cwlG+6wtKbHTkyGw9iXZ5jFErb0J6I/ju7ii4dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5794
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpZGF5LCBKdWx5IDI4LCAyMDIzIDEyOjI0IFBNLCBLb25yYWQgRHliY2lvIHdyb3RlOg0K
PiBPbiAyOC4wNy4yMDIzIDIxOjE0LCBQYXRyaWNrIFdoZXdlbGwgd3JvdGU6DQo+ID4gU2V0IC5m
bGFncyA9IENMS19PUFNfUEFSRU5UX0VOQUJMRSB0byBmaXggImdjY19zZGNjMl9hcHBzX2Nsa19z
cmM6IHJjZw0KPiA+IGRpZG4ndCB1cGRhdGUgaXRzIGNvbmZpZ3VyYXRpb24iIGVycm9yLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogUGF0cmljayBXaGV3ZWxsDQo+ID4gPHBhdHJpY2sud2hld2Vs
bEBzaWdodGxpbmVhcHBsaWNhdGlvbnMuY29tPg0KPiA+IEZpeGVzOiAzZTU3NzA5MjFhODggKCJj
bGs6IHFjb206IGdjYzogQWRkIGdsb2JhbCBjbG9jayBjb250cm9sbGVyDQo+ID4gZHJpdmVyIGZv
ciBTTTgyNTAiKQ0KPiA+IC0tLQ0KPiBSZXZpZXdlZC1ieTogS29ucmFkIER5YmNpbyA8a29ucmFk
LmR5YmNpb0BsaW5hcm8ub3JnPg0KPiANCj4gWW91IGNvdWxkIGFsc28gbWVudGlvbiB0aGF0IHRo
ZSBlcnJvciBpcyBjYXVzZWQgYnkgR1BMTDkgKHRoZSBvbmUgcHJvdmlkaW5nDQo+IHRoZSBoaWdo
ZXN0IGZyZXF1ZW5jeSBpbiB0aGUgZnJlcSB0YWJsZSkgbm90IGJlaW5nIG9uIGJ5IGRlZmF1bHQu
DQo+IA0KPiBBbmQgdWx0cmEgbml0OiB5b3VyIHMtby1iIHNob3VsZCBnbyBsYXN0DQoNCkkgd2ls
bCBiZSBzZW5kaW5nIG92ZXIgdjIgc2hvcnRseSB3aXRoIGJvdGggY29tbWVudHMgYWRkcmVzc2Vk
Lg0KDQo+IA0KPiBLb25yYWQNCj4gPiAgZHJpdmVycy9jbGsvcWNvbS9nY2Mtc204MjUwLmMgfCAx
ICsNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9jbGsvcWNvbS9nY2Mtc204MjUwLmMNCj4gPiBiL2RyaXZlcnMvY2xrL3Fj
b20vZ2NjLXNtODI1MC5jIGluZGV4IGI2Y2Y0YmM4OGQ0ZC4uZDNjNzViYjU1OTQ2DQo+ID4gMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jbGsvcWNvbS9nY2Mtc204MjUwLmMNCj4gPiArKysgYi9k
cml2ZXJzL2Nsay9xY29tL2djYy1zbTgyNTAuYw0KPiA+IEBAIC03MjEsNiArNzIxLDcgQEAgc3Rh
dGljIHN0cnVjdCBjbGtfcmNnMiBnY2Nfc2RjYzJfYXBwc19jbGtfc3JjID0gew0KPiA+ICAJCS5u
YW1lID0gImdjY19zZGNjMl9hcHBzX2Nsa19zcmMiLA0KPiA+ICAJCS5wYXJlbnRfZGF0YSA9IGdj
Y19wYXJlbnRfZGF0YV80LA0KPiA+ICAJCS5udW1fcGFyZW50cyA9IEFSUkFZX1NJWkUoZ2NjX3Bh
cmVudF9kYXRhXzQpLA0KPiA+ICsJCS5mbGFncyA9IENMS19PUFNfUEFSRU5UX0VOQUJMRSwNCj4g
PiAgCQkub3BzID0gJmNsa19yY2cyX2Zsb29yX29wcywNCj4gPiAgCX0sDQo+ID4gIH07DQo=
