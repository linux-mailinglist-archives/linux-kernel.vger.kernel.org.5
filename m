Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F87476CD41
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbjHBMoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbjHBMnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:43:51 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8362530F7;
        Wed,  2 Aug 2023 05:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690980211; x=1722516211;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Houb5Uq1/hNJIIwo2bmxK7+qir9H8Qp57XFhSB88IaQ=;
  b=AbO6zxi19isMXBUK+gGTZMXa43dMtf6GPZL3pi77ILjP/odXeSNSmUct
   Tj2cYNirH84zCjdXaudK4r9xLzXnXJl/9HxcFWgW9d/OPjrrUSA6oaUiM
   t+uu7bUFDVisTSLANPnE1j2u/Lt5BdkaAOVa1yYQv7M1aBMSYJf0+LEzU
   oDrMGq2MUSKtqsUVT9snDUqA2MZreD5Xar6BeJlN/irvWpIZ2X/apzdFC
   DQHJLDieff1TpptakibFJGogRM2bgKl0NzFPbJ2FYEoolW0/zHp0NToaQ
   pylO05KKooyu7sJMrbY9CwKSzQl654QAEmbii8Ai+P6pVM6L7jnVSwJjM
   g==;
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="226730999"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Aug 2023 05:42:54 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 2 Aug 2023 05:42:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 2 Aug 2023 05:42:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3M8GnjzFbq7jSNKFawhyIIlg5jf0IcKIw/6xpz6FbdYXbJ/FcR6YmMuwhIQ+Sec9v9IfUjkO7Whaqx6mr3krBVIB4aiE6iwD6BMNlsgXMasUbWMXqF6yqEOryQXwMT6cubP+D5EtYQyIznQ1FeM1E78pGjobpVmBNd47nwCSo+awsytt1kIgSxq8mBYR813rbXdinab+3RnyP2xO297z6XK0J1DRjQI7hbRTEm+3Dzvpw7tND2W/oV4Yo6UO2zR/8OjL1nyWbq9+CaZDaw7vqfRnRUrX6sy5of+oa4/JE964D1iqHhr+ObrQcMuBxM9gElJ88n++/ZxNL/GSU4pBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Houb5Uq1/hNJIIwo2bmxK7+qir9H8Qp57XFhSB88IaQ=;
 b=MJPQlu4RLN0PiY763RVBVk9dJk1OM5TBZI2xX2Ryfps3Kiu5ROeXCIgKImRfpGBSg33441H1jzVG2lHlABcJm3EQuQrsYKjd8s+qGLFvVpEhFCXUJXSH1phi4GgHRkAGs/MjYdvG8rbe8aFEShT/kLA+zqZ2JNvmTwxhAh1geL12lQIlY0W/Trv42KKgbDMMfd3UujHvmLurCIU5OsTxn1wkUHm9Mkpor2U8diZQ0XlAIMv4Xe4XG4cBpn28eh76iAU1/5UoqgUl59JSdVo3bjcYP2I6MQAYzvLHURJlaN3PuaiXoWZdHTl/f0z3T+yVKl+IKg6isgWiCibyb9oLyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Houb5Uq1/hNJIIwo2bmxK7+qir9H8Qp57XFhSB88IaQ=;
 b=Gqs2JUHnRCbh1eXAos9iO7fijwRuXmIgi18s4hWVP6hoS50DlxI95RYVaFbVWPPZ/SSJDEuTeHIn8rXW6Lb5dXeuyixMWFUiih9TOqFXVNidExYKjywDSMl/NIoTpg+fSmIFB4ppbNRwEtewr5Eske1+6sBz+tZS82T47pxy3NM=
Received: from PH8PR11MB6804.namprd11.prod.outlook.com (2603:10b6:510:1bc::6)
 by DS7PR11MB6103.namprd11.prod.outlook.com (2603:10b6:8:84::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 12:42:53 +0000
Received: from PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::c03b:7225:e395:9abf]) by PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::c03b:7225:e395:9abf%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 12:42:53 +0000
From:   <Mihai.Sain@microchip.com>
To:     <conor@kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Claudiu.Beznea@microchip.com>,
        <andre.przywara@arm.com>, <Andrei.Simion@microchip.com>,
        <Jerry.Ray@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Cristian.Birsan@microchip.com>
Subject: RE: [PATCH 1/2] dt-bindings: ARM: at91: Document Microchip SAMA5D29
 Curiosity
Thread-Topic: [PATCH 1/2] dt-bindings: ARM: at91: Document Microchip SAMA5D29
 Curiosity
Thread-Index: AQHZxGkZvHXvIeEFPkCakwKNOHNxaq/VkraAgAFe0YA=
Date:   Wed, 2 Aug 2023 12:42:52 +0000
Message-ID: <PH8PR11MB6804073D5A1F26D8699756F8820BA@PH8PR11MB6804.namprd11.prod.outlook.com>
References: <20230801111151.6546-1-mihai.sain@microchip.com>
 <20230801-unbalance-baguette-cd0d4e7e0107@spud>
In-Reply-To: <20230801-unbalance-baguette-cd0d4e7e0107@spud>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6804:EE_|DS7PR11MB6103:EE_
x-ms-office365-filtering-correlation-id: 7523928f-eaba-4bca-7f49-08db9355fd11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0o3HIFhxrrw0sCAUlOjKqY65+q6PHZmhJfdW1p/v+PhdhiQUIJR367ia1LQY1Nkbdl++iEVVFukQKkgQ7+U5QQbuvygGEEigAXnAEC1DofwPG2z9YmOLxbBiz61X2xHJ/40h2Alw2cPHc3btpe7xmJMdjvPCM6P29aRA5X7x7VVtGBinjF7WTcDg3lDoUyuYg1BvyNoQywa4zZdqons4AdfixN5jrHWSFaaAF0SIHcV9bjjCVJh9VUdb9QmZBszZBQrFlFPrnLmspgLxBuQq3vcF7eJq3PzCwxquF/ii9sXuhAQkU4EvopDgUXhSADDBAijN+owbLU53kiU2vYYiDO2TGyXgG8PXWBTsN0RLy/vBw9RMY6SrzrNiwOBhguxO37yYsjzIgz+J63xQDMyhpCpYx3sz9ZSK11AgRBMCgSBfs0SHB2kwQRbnreOxh56DOsB/VtLAdC7mzN/a0aLlqJTx5u4oKyqWq9E5x4OOVtnWUlnc/T74E4dSxS1KI+bAu/SsdAV7jSKy6d4XGnLVfy9Ob8cSPeAkvAxaUDId6at/pwm+0st2h0UwzvWRrEqsqOgAblqo2oY0jJXSylj+Q/zA+EHhi4toH5uiIPt+oOhMMX3qVJ1nGN0+GiOOE/W+dHRDQ4FqSKfdGvkuebjb0IS0TDPjStV1NQ7ie3dvBOg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6804.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(52536014)(8936002)(8676002)(5660300002)(26005)(41300700001)(107886003)(2906002)(38070700005)(55016003)(478600001)(54906003)(122000001)(38100700002)(316002)(86362001)(6506007)(64756008)(7696005)(76116006)(71200400001)(66946007)(66556008)(66476007)(66446008)(33656002)(4326008)(6916009)(186003)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEZ2NE1oVzE3MzZmdVFTOWQ2S0VCMlFFVUs4ckkwTFQ0RkYrOXhQZmNoMWRa?=
 =?utf-8?B?aVZ2V1JMUk1IQTllRW10dkFTOFB1T0haODFMdStKdWZzQzFTTTJDVUxDdnM1?=
 =?utf-8?B?bk5udVdXWkZPT2JlcG95RStGa0Jvd1ZERzlWZm5wWHgwdXovdHg3ai9DOFJT?=
 =?utf-8?B?Sk5QSXFBZTNLdVNBZDIwZm8zNjFsdmk0eTZzR3VaNWcwOVIwUFdXS2lYTlF4?=
 =?utf-8?B?NUZBeVBYc01FYkI4d1lnRHN2c2hlTldMVGRoNkJuKzFMOUswUTVYREMrVEpD?=
 =?utf-8?B?SzY3dWtzNlJxMDQ1cmxyNXM5b0VzTjQzcW8zK0JnYzVoV29jTnJ4L1BXNjlk?=
 =?utf-8?B?N0x2dTRiYk1GMTZ3TFFrN0t5S3c1a2F3MG9MWTZLZFc2YkdYWEFOanBiVHE1?=
 =?utf-8?B?ZmhLVGd1YVBVeUZZOGdtQjBaQ0JobmRYclBGVXdqUWFZanN2cmhtNGM3QnRw?=
 =?utf-8?B?bitTVFRCY3hQRGpPbXNkb2E5MVgvUFpsWGxJNEI2TS9weWxvMlNQeTBES0FI?=
 =?utf-8?B?MzJ1NDdZYzdaUE5MM1Rzek9PYmY1YmpZRm9UVy9iVEd5U2ZSNmRnT3FGa2kx?=
 =?utf-8?B?UEwxSnVkekprVDNPTzJLSm9sWVRwSFZOUFQwb2lobnR0YVkxRVQ3Rjd0VHk5?=
 =?utf-8?B?ZGVvKzRvMWw5ZFByMDlGNzdPclFLQU5xaTJyOGFkajVFSUJkaFNtSFRZQk9M?=
 =?utf-8?B?ZVpWYU9kaWlXSXZlL1BwYjdDYzF1eDdRa3B2M3NOb2gwYzlKNVM5cXcwMFFU?=
 =?utf-8?B?bHlPVUYvZ1g5VzhrNHdvcUhYZmoyaFpQdXZTY2p2SDY1bjg3OG4yNDVPSXBC?=
 =?utf-8?B?T0JqSkx4K0FrNjVDNTlnZUFLR2oxMzZiZ2wxVXBmeWxoV0VYUndxNEkxRkRj?=
 =?utf-8?B?aGtJU0RkU0g2UFN5UUZtaTJVQXo3ckF2b1VxMnl1cStTWWdYVFlHTGtSNHFs?=
 =?utf-8?B?Z1pjVWcrZ3UrcUYweHZmdlIrWWc0NG5mc3VKMjIyd3lJRVduYWhNQmFrdTVX?=
 =?utf-8?B?b0F4Q052OXkwb1YyTFA3eHlMTkZqVFlhaWZrT3NzRTlETjlrcHJTVTFsdlFs?=
 =?utf-8?B?dGkzMFFPSHZ3d0JpdkNxMmN4R0UrMjRzVWg5cXZRWS9GTmRrMUM3N2U1SDFj?=
 =?utf-8?B?TWYySlpUZHVYVU92WDZIRXlXYzhRTENVN0RDWlh6emtXejRkL1l2YU5rSDlC?=
 =?utf-8?B?WWptRG00ZW0vdnRVSDZueWhVMG0xdEp1cXgwcHFTeWkzeEdwbjRROUIvL0pZ?=
 =?utf-8?B?eTJpNEtJWkk4NFhVRTlZNDVCb3cwbW5ZYk5lcC91K016NVlKZVM3ZjE0ckJV?=
 =?utf-8?B?THRlZkh1djJCSTVvem0xVG5ONnJTUTFIMmVQZDVEZzBKRnVaSy8rak5UZjQx?=
 =?utf-8?B?UFQzdXRKdkZFcGpFTlU4VkxCQjFDY1NMZU9xMkZuWXB1UmZ0TFdmMjdYWUZw?=
 =?utf-8?B?WVFtMXJmakVPM1hvdDEzMzB5YjlXeHpBZ0R6LzVjT0xZSzVNdiswNFBhOFNu?=
 =?utf-8?B?cE9Sd2pyYlRybU9aS1ZNVm1WL3Q3Ymg1eGs4NTZtYlB5RTNMVVRsN0ZrQTVy?=
 =?utf-8?B?Y2FzTzlDVGZGVVF1d2FVSFp5OGpwbUhxUlZ6N2lrRXNFMTFZaUprbGxjQXZY?=
 =?utf-8?B?M0t1ajk3ZHNhZWxxSG1laEhGK0lsaDVOQW84RGZGM1RjVENSZnl4QVFlUDc5?=
 =?utf-8?B?ckRjNHJTUG1Ud3lOb1hlN1JCemsrdU1CQ1ovWUlsbzN3YmtCdWZNN0tyMkRn?=
 =?utf-8?B?MFJuVHV5ZStURDV1Y3FQaTl3ellmLzNydXphVytLWU1Ta0hCRzF2V3R1VXpJ?=
 =?utf-8?B?KzhaUkpmWWJwZEpuK0lCTHRTV0pCdjJWMW5ETksrTmNjdXZRRTMwZ2tYVmtS?=
 =?utf-8?B?R0x5cmZEQ21ONDFod0d5ZmdjeWRYQVBhN3Z3N0NYcVZ0NlU5eERuL0VGVjMx?=
 =?utf-8?B?UjlBRHQxY0p6eU5vVnJnR0laL05Ud25wSmFYZytyOWN1ZU9GT3NQWGFCZGRX?=
 =?utf-8?B?RGJVNGRKK2lkaXZsYll2V3VQc1NsdWtjaHlkOVBYaFBseDNNZDM4M2REaEFp?=
 =?utf-8?B?a2hndzcvYXB0V2hKbmVaVU9ZZVBEMkUrc2l6S2I5N1lZakh1U2o2WDVCTUxE?=
 =?utf-8?Q?5shMHWZAW8DkRQuRoVT2JoMbq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6804.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7523928f-eaba-4bca-7f49-08db9355fd11
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 12:42:52.9862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: crzHVSsJnOeoOk01gFmL1tGhyFVRA72bOPODVG2A9QemnK91f6JcBMJnqj63A9jN3J0rBlyFEVLrEGvZchWNiO3Moygs5k8G1wZZnsXLCXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6103
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ29ub3IsDQoNClBsZWFzZSBmaW5kIGJlbGxvdyBteSBhbnN3ZXJzLg0KDQpIZXksDQoNCk9u
IFR1ZSwgQXVnIDAxLCAyMDIzIGF0IDAyOjExOjUwUE0gKzAzMDAsIE1paGFpIFNhaW4gd3JvdGU6
DQo+IEZyb206IEFuZHJlaSBTaW1pb24gPGFuZHJlaS5zaW1pb25AbWljcm9jaGlwLmNvbT4NCj4g
DQo+IERvY3VtZW50IGRldmljZSB0cmVlIGJpbmRpbmcgb2YgU0FNQTVEMjkgQ3VyaW9zaXR5LCBm
cm9tIE1pY3JvY2hpcC4NCj4gDQo+IFJldmlld2VkLWJ5OiBNaWhhaSBTYWluIDxtaWhhaS5zYWlu
QG1pY3JvY2hpcC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEFuZHJlaSBTaW1pb24gPGFuZHJlaS5z
aW1pb25AbWljcm9jaGlwLmNvbT4NCg0KWW91ciBTb0IgaXMgbWlzc2luZyBmcm9tIGhlcmUuDQoN
ClN1cmUsIEkgd2lsbCBhZGQgbXkgU29CLg0KDQo+IC0tLQ0KPiAgRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2FybS9hdG1lbC1hdDkxLnlhbWwgfCA3ICsrKysrKysNCj4gIDEgZmls
ZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2F0bWVsLWF0OTEueWFtbCANCj4gYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2F0bWVsLWF0OTEueWFtbA0KPiBpbmRleCBk
ZmI4ZmQwODkxOTcuLjg5ZDc1ZmJiMWRlNCAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9hdG1lbC1hdDkxLnlhbWwNCj4gKysrIGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9hdG1lbC1hdDkxLnlhbWwNCj4gQEAgLTc5LDYg
Kzc5LDEzIEBAIHByb3BlcnRpZXM6DQo+ICAgICAgICAgICAgLSBjb25zdDogYXRtZWwsc2FtYTVk
Mg0KPiAgICAgICAgICAgIC0gY29uc3Q6IGF0bWVsLHNhbWE1DQo+ICANCj4gKyAgICAgIC0gZGVz
Y3JpcHRpb246IE1pY3JvY2hpcCBTQU1BNUQyOSBDdXJpb3NpdHkNCj4gKyAgICAgICAgaXRlbXM6
DQo+ICsgICAgICAgICAgLSBjb25zdDogbWljcm9jaGlwLHNhbWE1ZDI5LWN1cmlvc2l0eQ0KPiAr
ICAgICAgICAgIC0gY29uc3Q6IGF0bWVsLHNhbWE1ZDI5DQo+ICsgICAgICAgICAgLSBjb25zdDog
YXRtZWwsc2FtYTVkMg0KPiArICAgICAgICAgIC0gY29uc3Q6IGF0bWVsLHNhbWE1DQoNCldoYXQg
aXMgdGhlIGJlbmVmaXQgb2YgYWRkaW5nIHRoZSB0d28gZmFtaWxpYWwgY29tcGF0aWJsZXM/IElz
IHRoZXJlIHNvZnR3YXJlIHRoYXQgYWN0dWFsbHkgdXNlcyB0aGVzZT8NCg0KVGhhbmtzLA0KQ29u
b3IuDQoNCkN1cnJlbnRseSB0aGVyZSBpcyBubyBzb2Z0d2FyZS4NCkluIHRoaXMgZmlsZSB3ZSd2
ZSBqdXN0IGRvY3VtZW50ZWQgdGhlIHByZXZpb3VzIGJvYXJkcyBmcm9tIHNhbTksIHNhbWE1LCBz
YW1hNyBNUFVzLg0KDQpUaGFua3MsDQpNaWhhaQ0KDQo+ICsNCj4gICAgICAgIC0gaXRlbXM6DQo+
ICAgICAgICAgICAgLSBjb25zdDogYXRtZWwsc2FtYTVkMjcNCj4gICAgICAgICAgICAtIGNvbnN0
OiBhdG1lbCxzYW1hNWQyDQo+IC0tDQo+IDIuNDEuMA0KPg0K
