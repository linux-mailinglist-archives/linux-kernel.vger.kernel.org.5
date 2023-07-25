Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D32760A16
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 08:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjGYGN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 02:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjGYGN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 02:13:56 -0400
Received: from mo-csw.securemx.jp (mo-csw1800.securemx.jp [210.130.202.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA58173F;
        Mon, 24 Jul 2023 23:13:54 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 36P6D9Lb264566; Tue, 25 Jul 2023 15:13:10 +0900
X-Iguazu-Qid: 2yAbkFrWL9x946G4aR
X-Iguazu-QSIG: v=2; s=0; t=1690265589; q=2yAbkFrWL9x946G4aR; m=musnhbKOR9iyTNCtUX1cW7GvIwOiPY6sbFXXwZjOTI8=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1803) id 36P6D78x3091438
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 25 Jul 2023 15:13:07 +0900
X-SA-MID: 5052090
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EuNKGYFMstTz+lA1Y/1VXvO+NzsWYN9df1u56j/7i38AKseunIAWIJbPqREfQe8Xeq2NIqob6QqrVFmLyrCXvFzmwuFTjKgHDuiSPq4cqL1rd6RZ61+ohNCCo7GylgB35hlsZA35deYeXe9gXZGTEakXQU43JrHHTNlk9NlOdrz45GWpO55/xkE29IlKUY+b14zY0J5fsbTp9q0WQmQ4xHy3uzEApXcs/kwridEY4euMv0Q37YpZGJeBvIn+0rhh1hlocgD9RqQ9/aLOJZTJFHbzSU+1mHsUoAul/5SYmzg46e/wiAC4CHofLKfJE9f4bwuIYW8QI5eEPp9ACVbq8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYF3zxNKJRblMe9FzdMzRAbwRkjhdmenow+ksGIQisE=;
 b=XdqQmKBl8CVVRtTsrnJgX/VbpgoIuBlU7tFpRMxqVqZTM5T4WSKOXJt4L8UsMIfcYiI1zFUARHb9/VvbTLpnvgB8UTE9dRQFHTvTMsiStDPWQpG7mqmHWpKh05tE7zqLXXt4Y8QocZ/Vuorf7qT1Gpq5yRPSwjAjMRLWpZB1IFR2bbUpeglpJIa+pKhnb64ai8LuxsXOf3pwuIOIuCB0gbybfG+dS52dLCAatqj741ISoVmgYw6CrBv25txjsyFL9R20OgcsyILaBoNBkxOf2w/BgF3uwkQTTOOv7fKjDW9HDOLau1v0jIJvU3MTRanhDUP09dSQhqoJ6ShwMlyHKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <yuji2.ishikawa@toshiba.co.jp>
To:     <krzysztof.kozlowski@linaro.org>, <hverkuil@xs4all.nl>,
        <sakari.ailus@iki.fi>, <laurent.pinchart@ideasonboard.com>,
        <mchehab@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nobuhiro1.iwamatsu@toshiba.co.jp>, <broonie@kernel.org>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v7 1/5] dt-bindings: media: platform: visconti: Add
 Toshiba Visconti Video Input Interface
Thread-Topic: [PATCH v7 1/5] dt-bindings: media: platform: visconti: Add
 Toshiba Visconti Video Input Interface
Thread-Index: AQHZtfWuhoNhayuHXESbW1oZYxmrk6+446sAgBEs7tA=
Date:   Tue, 25 Jul 2023 06:08:01 +0000
X-TSB-HOP2: ON
Message-ID: <TYAPR01MB62012F7EA98012DBE0B383A29203A@TYAPR01MB6201.jpnprd01.prod.outlook.com>
References: <20230714015059.18775-1-yuji2.ishikawa@toshiba.co.jp>
 <20230714015059.18775-2-yuji2.ishikawa@toshiba.co.jp>
 <7aa255e8-1cf1-03c6-02c8-de7c737a5683@linaro.org>
In-Reply-To: <7aa255e8-1cf1-03c6-02c8-de7c737a5683@linaro.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6201:EE_|TYCPR01MB10843:EE_
x-ms-office365-filtering-correlation-id: b2b139f0-2317-4ca8-34e1-08db8cd580b2
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SmrEvhRq+WsutFp/5A8FQWicv3PpwdzV97mnJp3/m4C8L1aOWOOKp1BAEWNnwubsrvRFn2YSuKraculaDrvhfOnG6x28EzOWueHEQdaHaJA4ZyDMb3dk4V8FlsD9l1n7+jCcKEP+h3nPN7hwAicoohDJ5pInATphgSQ8VfGI7gX57ypfmefLUKt0WZnH6BH9egK/xZnSuHAZRtWY4kNvSFI1syrU6lGPsBQ1VXpheISOs9PH4ZarQqNEOEXMkbojU8WjbLDizcTjzBlheKidw4vUeQJ0ZhKE69+oaH0nYh5RmC5wFv0x/FhwWfibA4owH1ZEtZyfs6ln4mOWCY6A6I4qRg3KjbQ9iG2hXHoOL4IrkzHjchnPcUe31PP/liRxu5Dje/AizvFkNosXM40z1BVMx6B1WDchD1+GgxVAcKLEdZXEXrnLUL98ha8jAnEL31DEz8hUp77aOgPjmiU6V76TO1pvBWaUvskXrtnm3VJsP2d2i8P5q0OKWrpls4SD2crBWSIlyJvdz1HFtamVgXpMhdJ9n3Hx1Oxn8gQE0jO5ySM95FHfvPrVxoYtJWCJjHdRP9JQWF3WrRfL+1vnJpg11NHv+ZitJTnYIRcKTN1vpESh0WF5OrHYRrXY+T/hAXk1zNW7bgkZGC7uCireqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6201.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(451199021)(86362001)(921005)(33656002)(122000001)(38070700005)(55016003)(2906002)(110136005)(54906003)(478600001)(38100700002)(26005)(186003)(6506007)(53546011)(71200400001)(41300700001)(7416002)(52536014)(966005)(5660300002)(9686003)(7696005)(8676002)(8936002)(66946007)(66556008)(316002)(76116006)(83380400001)(66476007)(64756008)(4326008)(66446008)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azBtWWt5UlJNcDR6ejJkTTY3dFJNS3N2WGtGYjV6ekJFb1AzdkZkcEVPMG12?=
 =?utf-8?B?M2U1M1dvb1RqNEdHM1paUEE5NWZLc05EM25sbTBCTi96MW5LeDl4Z2E0QnVE?=
 =?utf-8?B?aGNiUEZUUzlCcmdKNGdYU3dDYjBWY0phTyt4SmwxWW5ZQnZUWWsrOXVmOUhk?=
 =?utf-8?B?QWpQT3RxUHN3S3RYZW1UYTdQTlpqLzVlODNyYVVHZC81QjB5ek9aeGtCZTF6?=
 =?utf-8?B?ZlZjTFRzSG1uVDlLck5BQmZmUDZrNFNEc2VHVExOVklhbjYya3FQYVQvaGla?=
 =?utf-8?B?ZFlkb3RYK3o3Vy80QW04V0JycFJkUU9NQWY0OGVaSlpsMVhkRWRWYU9UVlJF?=
 =?utf-8?B?V0JkNzc0V3UwWU05SVZzVm1mY3VmNGsycnJPRWM4NTd5T3FVQW9mQTAyUW5O?=
 =?utf-8?B?M3VYdFl3U0hBQW5ZcU5oL0RLQy9wS05JMlNtRkt2Sjc0SVRQV0NRYlhOd1BN?=
 =?utf-8?B?UC83NmdGb0Q0bFBsRWJyUXNFUGNlM3kzNVVxUm5IWUNDN1lyRkQ2anM2eERM?=
 =?utf-8?B?ZVNnRHMzVmZjeUhSNnhnUzJ4bHE5K0d2V3paQnAxd3lQdEpTdlRGNXhyM3VB?=
 =?utf-8?B?SUx5TUkxZ3YzcENscnNJblQ1cDcvTXZSR1BBbTZFWnQ4WDl3THl5WSsvK3pW?=
 =?utf-8?B?WDdGa1RWV0ljTXJVc3NDbzFIWkd0ODIyRHZVakJDNGw1ZzNBcTVnNzdqY21t?=
 =?utf-8?B?cFc5NDRVN2hRcXVnZ1FBYUg5Q2RjZnNIcWs5b2poTlpvVG9WSWRXUFh3ckZz?=
 =?utf-8?B?MUFGWjAyUmxQOU8xWEFSYUhwdDZVQ0YzcDhtdzFnSzk4WW5EVm5odU5zMUlE?=
 =?utf-8?B?VnJ5QjZGNWRSL0ZiZ3FSTmpLb1kzVm9rUzR0TUk5d29uUEtIOFpoMi92SEhY?=
 =?utf-8?B?RnFKMCtDWFRFTG9HNHk2MXVBbndsRjA5a1g3NXE2ZTdkVWFlUFlTdHFpSTZS?=
 =?utf-8?B?MThIUHNFNWh5UWY1NXNwdDJFTEpqME15bXRsTjgyRlBLYndOakxwdGVMWWtx?=
 =?utf-8?B?UzZ3THFhbjhya1llRTB0REpJUEhrMkQ0UU4zTGNuSCtBZ1pFUnNCMW1ZS0p6?=
 =?utf-8?B?NlZkcGVucHdXRElMU202cE1ab2hXQUllbXkwbmN5V0lNd1dkM0tIM3hPa25J?=
 =?utf-8?B?bng2RjZUcHRTMkRTSmVwdDlTQkJQdWRBZVllOERPRVN3QmJnV0JaMkJlM0dk?=
 =?utf-8?B?c25sTlNyNWhFekoxdUNiUkFjRUkrK2RaNTdSeVRNdjUxUGw5cGRHREtIcGhZ?=
 =?utf-8?B?T3BzLzJwZC9idjR5ZWpmT0VCMnpHWEFrV0lZWlo1Mm1VQnE1dWJyS25md1c3?=
 =?utf-8?B?cFZVa1N1L09hZ2MyZDhwY0lQUW13dGsxRGRGNk9JeFJlbWI1aDgvdEFsdmpz?=
 =?utf-8?B?eDd2MVhuT3FsQ2N1UUI5c1hjeTJkNVp0VWwzczFuYVNiWkhCbnFzdW1LanR2?=
 =?utf-8?B?a3BsZHcxa0lrT285dGpiUXB2bW9wejE0a2dHSklCUVdxN3RKalhRcXltZ2Vw?=
 =?utf-8?B?MFd5TjFTQ2ZJdFJGbDFQWWxKSDNMa2pCR1NZMmpwQm5hUldTRmZ5YUVSSUJ3?=
 =?utf-8?B?U0VWeXo1MkZVQ2dXQ1ZWbnhNbDAzY0locXpCRksyM0ErL204aUxsOUlCL3Fu?=
 =?utf-8?B?Sm93bGtrRGN3ZnNqUWlqNXUzU2VHenpUdVdDK3QxY29JRzB6eUZLaTZOcDFJ?=
 =?utf-8?B?RDVOa2NLVG9Ka0hyMzdjMDhxRlVZQjEranZsUjE1cHl4eUVxQ3lneWxac0Rq?=
 =?utf-8?B?ckhPNUFGUElyVDIxZEJWUE4xanU3RExyVnB1UHEzbnUwaks3cHVLeHJNNmFz?=
 =?utf-8?B?R0wrZk11bW5lbE5GNEE4MUFkVHlwNHdNNlN3TzEyR0FSK3NYaXFsUDFIUFJj?=
 =?utf-8?B?cHF6N21iNVRjU3FlK3VNZExxWDZmdm9uUkppMmxNbFM5YTVqUnFnMisxT3BG?=
 =?utf-8?B?OFAwakxCNVV3ZFplSkp1K3FQU29JbG8yVlNXMEhablFIOS9iNGYvVytBK1VH?=
 =?utf-8?B?SWE5TWJhYU9LeVZPaUJpRGZnRnVZWEJoSEhVY0t5TDZTaEt3VndtemQ0WUl3?=
 =?utf-8?B?NjlZVWwrSVY0N1U2L3lmaDNta21BNk1DaFdqb0I0blRNUVIrd0tIRkNucVM1?=
 =?utf-8?B?cTVXckgweVRVbTVjYUF6VjBNcll4ZUNrRUJMa0pJSUpRdE9QNGN6V2Z2WFN6?=
 =?utf-8?B?OVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Ym1BL2ZobklzK1FScHhxd2dwVWViMmFIazNWSjZtbjlTRlpSTjllOWx6Qmpv?=
 =?utf-8?B?UXFkNGxlazNkNk1FajBDdlNrQnFUQ2c2d25YTjNXem9ZQXJwK2hyeEJEdXlz?=
 =?utf-8?B?ZjRIa2g0STE0ZFlhWkdSdzArdTBsTkp4SDBhd3lFa3pDQlNSWWNJcnM4OVVr?=
 =?utf-8?B?SUVlVEtxV2pLcW5PSisxdzlnSmlnZjhLWTJoSFZkTzVYd3ViZFdqUXNtVTJa?=
 =?utf-8?B?N1FhUGh1Qk5Xc01Nc0pEVTA3TDMzVzd3REhMZUxYTDZyNUZSc3ZtY0I2cDZ6?=
 =?utf-8?B?dHBGeWxTaFlHTUJNVHFYY2tSa3RTNHlrNzFLbXV2b0l6NmtmamRibFdPdnpW?=
 =?utf-8?B?TjZDNDlMTUpVWXNIM21iVHFNVTRpZWRUbVp4dGJzKzZFcmdDNzNFZjg5R1hJ?=
 =?utf-8?B?VGxwUlAvdzRYK0VvaWxpSitUUE1jYWhmYzlJT3VVNllRTjNsU3FYN1dnSjdM?=
 =?utf-8?B?cFV3bTJUbUhtR2c3Y1ZaRnhmREEwbWJsSkIrVzFRNFpVbjdXWEJFMnBQekNa?=
 =?utf-8?B?cUxaMkJQYS9ESTg1S294RjJUdi9SVndYRnRrNkQ5Vm5EaXAxUnd4aDE5Ti91?=
 =?utf-8?B?Ujk5WnFKTmp5YXJFalRUenJ1RUtoTWpIajkwVUpYZnVYWkxmSmtqL011T0Z1?=
 =?utf-8?B?TDN0clJHS2RkVWxoS1VjMUhtaDMrOEhicHpDOWFQZkt0bXdpTithd1JRQXhy?=
 =?utf-8?B?d3FUaGdhZ2xseEpGV3kzaUJLR3g5RytIWTRRZVdIRE5KbWxlVGl4clhLclBE?=
 =?utf-8?B?SGhENjJRL0x6KzR0ek93M0x0MmtVYkdLVzErTVorNkt2NDFmQzlaVk1LTzUr?=
 =?utf-8?B?Ylc0TkU0MVJIS0crRFIwWHRHK1EvckRBOW54a3hFTzBweW9lRFVtSkJ0ZEFa?=
 =?utf-8?B?cnRNeGFLNHM3bFlhNzhtTkRDa0g4N09XZjhxQ0xSMHBaSk9pd3pDY1lsM0JT?=
 =?utf-8?B?aFp3NHE3TFc3NTRWd1Bpck5zOHJMVXc3ek1zelRQc3g3czIwbnNPeFRsbTA0?=
 =?utf-8?B?Q3VvVXF3dURDMEQ1aVZoUC95RjFad3lhMndPY2p0b2RiZ3FYRHNlZnZOY2pn?=
 =?utf-8?B?L3V3clVUYWM4dndZZjBMd3dTanJSTTZJMnlTMEhIN0FNN2VwNUZlaEVOS1Ni?=
 =?utf-8?B?OGRJVVVEYitzcjNhWUF3KytrWTlPWGVWV3VsTFV5VFlTaU1pTHpUd2tKZlc1?=
 =?utf-8?B?L0dScnpTTWUvZUdzMUFTMHBuRnlaNzJhSWhvcDU3WHg5T09abnJkVmxzdHJO?=
 =?utf-8?B?K3BnN1Vqd2VpTFlFM1RpRFprWHBxYlNqQTN4elk5eXpkQ20rdE9kWXhPamdQ?=
 =?utf-8?Q?iCd8/Ttbx1lfupGTresiKc68DPiAfqo6qp?=
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6201.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b139f0-2317-4ca8-34e1-08db8cd580b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 06:08:01.7851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U0rKrqDv8xwY+HP7DYtMewm0OUYq9BUSiVAEKS7LfLw9notfc3vhtClcy2P0EJK8KezoApuEdRpyFpiJjssEs9BpbFGBVrJMReddPFab2ic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10843
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gS3J6eXN6dG9mDQpUaGFuayB5b3UgZm9yIHlvdXIgcmV2aWV3IGNvbW1lbnRzLg0KDQo+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtyenlzenRvZiBLb3psb3dza2kg
PGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gU2VudDogRnJpZGF5LCBKdWx5IDE0
LCAyMDIzIDQ6NTAgUE0NCj4gVG86IGlzaGlrYXdhIHl1amko55+z5bedIOaCoOWPuCDil4vvvLLv
vKTvvKPilqHvvKHvvKnvvLTvvKPil4vvvKXvvKHplospDQo+IDx5dWppMi5pc2hpa2F3YUB0b3No
aWJhLmNvLmpwPjsgSGFucyBWZXJrdWlsIDxodmVya3VpbEB4czRhbGwubmw+OyBTYWthcmkNCj4g
QWlsdXMgPHNha2FyaS5haWx1c0Bpa2kuZmk+OyBMYXVyZW50IFBpbmNoYXJ0DQo+IDxsYXVyZW50
LnBpbmNoYXJ0QGlkZWFzb25ib2FyZC5jb20+OyBNYXVybyBDYXJ2YWxobyBDaGVoYWINCj4gPG1j
aGVoYWJAa2VybmVsLm9yZz47IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBLcnp5
c3p0b2YNCj4gS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc+OyBD
b25vciBEb29sZXkNCj4gPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBpd2FtYXRzdSBub2J1aGlybyjl
sqnmnb4g5L+h5rSLIOKXi++8pO+8qe+8tO+8o+KWoe+8pO+8qe+8tOKXiw0KPiDvvK/vvLPvvLQp
IDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD47IE1hcmsgQnJvd24NCj4gPGJyb29u
aWVAa2VybmVsLm9yZz4NCj4gQ2M6IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZzsgZGV2aWNl
dHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHY3IDEvNV0gZHQtYmluZGluZ3M6IG1lZGlhOiBwbGF0Zm9ybTogdmlzY29udGk6IEFkZCBUb3No
aWJhDQo+IFZpc2NvbnRpIFZpZGVvIElucHV0IEludGVyZmFjZQ0KPiANCj4gT24gMTQvMDcvMjAy
MyAwMzo1MCwgWXVqaSBJc2hpa2F3YSB3cm90ZToNCj4gPiBBZGRzIHRoZSBEZXZpY2UgVHJlZSBi
aW5kaW5nIGRvY3VtZW50YXRpb24gdGhhdCBhbGxvd3MgdG8gZGVzY3JpYmUgdGhlDQo+ID4gVmlk
ZW8gSW5wdXQgSW50ZXJmYWNlIGZvdW5kIGluIFRvc2hpYmEgVmlzY29udGkgU29Dcy4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IFl1amkgSXNoaWthd2EgPHl1amkyLmlzaGlrYXdhQHRvc2hpYmEu
Y28uanA+DQo+ID4gUmV2aWV3ZWQtYnk6IE5vYnVoaXJvIEl3YW1hdHN1IDxub2J1aGlybzEuaXdh
bWF0c3VAdG9zaGliYS5jby5qcD4NCj4gPiAtLS0NCj4gPiBDaGFuZ2Vsb2cgdjI6DQo+IA0KPiBU
aGFuayB5b3UgZm9yIHlvdXIgcGF0Y2guIFRoZXJlIGlzIHNvbWV0aGluZyB0byBkaXNjdXNzL2lt
cHJvdmUuDQo+IA0KPiA+IC0gbm8gY2hhbmdlDQo+ID4NCj4gPiBDaGFuZ2Vsb2cgdjM6DQo+ID4g
LSBubyBjaGFuZ2UNCj4gPg0KPiA+IENoYW5nZWxvZyB2NDoNCj4gPiAtIGZpeCBzdHlsZSBwcm9i
bGVtcyBhdCB0aGUgdjMgcGF0Y2gNCj4gPiAtIHJlbW92ZSAiaW5kZXgiIG1lbWJlcg0KPiA+IC0g
dXBkYXRlIGV4YW1wbGUNCj4gPg0KPiA+IENoYW5nZWxvZyB2NToNCj4gPiAtIG5vIGNoYW5nZQ0K
PiA+DQo+ID4gQ2hhbmdlbG9nIHY2Og0KPiA+IC0gYWRkIHJlZ2lzdGVyIGRlZmluaXRpb24gb2Yg
QlVTLUlGIGFuZCBNUFUNCj4gPg0KPiA+IENoYW5nZWxvZyB2NzoNCj4gPiAtIHJlbW92ZSB0cmFp
bGluZyAiYmluZGluZ3MiIGZyb20gY29tbWl0IGhlYWRlciBtZXNzYWdlDQo+ID4gLSByZW1vdmUg
dHJhaWxpbmcgIkRldmljZSBUcmVlIEJpbmRpbmdzIiBmcm9tIHRpdGxlDQo+ID4gLSBmaXggdGV4
dCB3cmFwcGluZyBvZiBkZXNjcmlwdGlvbg0KPiA+IC0gY2hhbmdlIGNvbXBhdGlibGUgdG8gdmlz
Y29udGk1LXZpaWYNCj4gDQo+IFRoZW4gdGhlIGZpbGVuYW1lIHNob3VsZCBiZSB1cGRhdGVkIHRv
IG1hdGNoIGl0Og0KPiB0b3NoaWJhLHZpc2NvbnRpNS12aWlmLnlhbWwNCj4gDQoNCkknbGwgY2hh
bmdlIHRoZSBmaWxlbmFtZSB0byB0b3NoaWJhLHZpc2NvbnRpNS12aWlmLnlhbWwNCg0KPiA+IC0g
ZXhwbGljaXRseSBkZWZpbmUgYWxsb3dlZCBwcm9wZXJ0aWVzIGZvciBwb3J0OjplbmRwb2ludA0K
PiA+DQo+ID4gIC4uLi9iaW5kaW5ncy9tZWRpYS90b3NoaWJhLHZpc2NvbnRpLXZpaWYueWFtbCB8
IDEwOA0KPiA+ICsrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTA4IGlu
c2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlhL3Rvc2hpYmEsdmlzY29udGktdmlpZi55YW1sDQo+ID4N
Cj4gDQo+IC4uLg0KPiANCj4gPiArICBwb3J0Og0KPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvZ3Jh
cGgueWFtbCMvJGRlZnMvcG9ydC1iYXNlDQo+ID4gKyAgICB1bmV2YWx1YXRlZFByb3BlcnRpZXM6
IGZhbHNlDQo+ID4gKyAgICBkZXNjcmlwdGlvbjogSW5wdXQgcG9ydCwgc2luZ2xlIGVuZHBvaW50
IGRlc2NyaWJpbmcgdGhlIENTSS0yIHRyYW5zbWl0dGVyLg0KPiA+ICsNCj4gPiArICAgIHByb3Bl
cnRpZXM6DQo+ID4gKyAgICAgIGVuZHBvaW50Og0KPiA+ICsgICAgICAgICRyZWY6IHZpZGVvLWlu
dGVyZmFjZXMueWFtbCMNCj4gPiArICAgICAgICBhZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UN
Cj4gDQo+IFRoaXMgc2hvdWxkIGJlIHJhdGhlcjoNCj4gdW5ldmFsdWF0ZWRQcm9wZXJ0aWVzOiBm
YWxzZQ0KDQpJbiB0aGUgcHJldmlvdXMgZGlzY3Vzc2lvbiB3aXRoIExhdXJlbnQsIEkgYmVsaWV2
ZSBhZGRpdGlvbmFsUHJvcGVydGllcyB3YXMgcHJlZmVycmVkIGluIHRlcm1zIG9mIGhhbmRsaW5n
IHByb3BlcnRpZXMgbm90IGV4cGxpY2l0bHkgbWVudGlvbmVkLg0KDQpodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9hbGwvWTgyTnRKQ3RyK0NaZ1M5a0BwZW5kcmFnb24uaWRlYXNvbmJvYXJkLmNvbS8N
Cg0KRG8geW91IGhhdmUgY29uY2VybiBhYm91dCBkZWZhdWx0aW5nIHByb3BlcnRpZXMgaW4gdmlk
ZW8taW50ZXJmYWNlLnlhbWwgdG8gZm9yYmlkZGVuPw0KSWYgZGVmYXVsdGluZyB0byBvcHRpb25h
bCAobGlrZSBtb3N0IG9mIG90aGVyIGJpbmRpbmdzKSBpcyBiZXR0ZXIsIEknbGwgdXNlIHVuZXZh
bHVhdGVkUHJvcGVydGllcy4NCg0KPiA+ICsNCj4gPiArICAgICAgICByZXF1aXJlZDogWyJidXMt
dHlwZSIsICJjbG9jay1ub25jb250aW51b3VzIiwNCj4gPiArICJsaW5rLWZyZXF1ZW5jaWVzIiwg
InJlbW90ZS1lbmRwb2ludCJdDQo+IA0KPiBUaGF0J3Mgbm90IHRoZSBzeW50YXggd2UgdHJ5IHRv
IGtlZXAgaW4gdGhlIGJpbmRpbmdzLiBTZWUgcmVuZXNhcyxyemcybC1jc2kyLnlhbWwuDQo+IA0K
DQpJJ2xsIHVzZSBhIGxpbmUgZm9yIGV2ZXJ5IGVsZW1lbnQuDQoNCj4gPiArDQo+ID4gKyAgICAg
ICAgcHJvcGVydGllczoNCj4gPiArICAgICAgICAgIGRhdGEtbGFuZXM6DQo+ID4gKyAgICAgICAg
ICAgIGRlc2NyaXB0aW9uOiBWSUlGIHN1cHBvcnRzIDIgb3IgNCBkYXRhIGxhbmVzDQo+ID4gKyAg
ICAgICAgICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMi1h
cnJheQ0KPiA+ICsgICAgICAgICAgICBtaW5JdGVtczogMQ0KPiA+ICsgICAgICAgICAgICBtYXhJ
dGVtczogNA0KPiA+ICsgICAgICAgICAgICBpdGVtczoNCj4gPiArICAgICAgICAgICAgICBtaW5p
bXVtOiAxDQo+ID4gKyAgICAgICAgICAgICAgbWF4aW11bTogNA0KPiA+ICsNCj4gPiArICAgICAg
ICAgIGNsb2NrLWxhbmVzOg0KPiA+ICsgICAgICAgICAgICBkZXNjcmlwdGlvbjogVklJRiBzdXBw
b3J0cyAxIGNsb2NrIGxhbmUNCj4gPiArICAgICAgICAgICAgY29uc3Q6IDANCj4gDQo+IEFyZSB5
b3Ugc3VyZSBpdCBtdXN0IGJlIG9uIHBvc2l0aW9uIDA/DQo+IA0KDQpCZWNhdXNlIGEgVmlzY29u
dGk1IENTSTJSWCBoYXMgb25seSBjbG9jay1sYW5lMCwNCnRoZXJlJ3Mgbm8gbmVlZCB0byBzcGVj
aWZ5IGNsb2NrLWxhbmUgd2l0aCBkZXZpY2UgdHJlZS4NCg0KSSdsbCBkcm9wICJjbG9jay1sYW5l
cyIuDQoNCj4gPiArDQo+ID4gKyAgICAgICAgICBidXMtdHlwZTogdHJ1ZQ0KPiA+ICsgICAgICAg
ICAgY2xvY2stbm9uY29udGludW91czogdHJ1ZQ0KPiA+ICsgICAgICAgICAgbGluay1mcmVxdWVu
Y2llczogdHJ1ZQ0KPiA+ICsgICAgICAgICAgcmVtb3RlLWVuZHBvaW50OiB0cnVlDQo+IA0KPiBE
cm9wIGFsbCBvZiB0aGVzZSAieHh4OiB0cnVlIiwgc2hvdWxkIG5vdCBiZSBuZWVkZWQgYWZ0ZXIg
Y29udmVydGluZyB0bw0KPiB1bmV2YWx1YXRlZFByb3BlcnRpZXM6IGZhbHNlDQo+IA0KDQpJJ2xs
IGRyb3AgInh4eDogdHJ1ZSIgaWYgdW5ldmFsdWF0ZWRQcm9wZXJ0aWVzIGlzIGNob3NlbiBpbnN0
ZWFkIG9mIGFkZGl0aW9uYWxQcm9wZXJ0aWVzLg0KDQo+ID4gKw0KPiA+ICtyZXF1aXJlZDoNCj4g
PiArICAtIGNvbXBhdGlibGUNCj4gPiArICAtIHJlZw0KPiA+ICsgIC0gaW50ZXJydXB0cw0KPiA+
ICsgIC0gcG9ydA0KPiA+ICsNCj4gPiArYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+ID4g
Kw0KPiA+ICtleGFtcGxlczoNCj4gPiArICAtIHwNCj4gPiArICAgICNpbmNsdWRlIDxkdC1iaW5k
aW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQo+ID4gKyAgICAjaW5jbHVkZSA8
ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvaXJxLmg+DQo+ID4gKw0KPiA+ICsgICAg
c29jIHsNCj4gPiArICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwyPjsNCj4gPiArICAgICAgICAj
c2l6ZS1jZWxscyA9IDwyPjsNCj4gPiArDQo+ID4gKyAgICAgICAgdmlpZkAxYzAwMDAwMCB7DQo+
IA0KPiBpc3BADQo+IChvciB2aWRlbyBvciBzb21ldGhpbmcgZWxzZSBtYXRjaGluZyB0aGlzIHR5
cGUgb2YgdGhlIGRldmljZSwgYnV0IHRoaXMgc2hvdWxkIGJlIGENCj4gZ2VuZXJpYyBuYW1lKQ0K
PiANCg0KSSdsbCB1c2UgdmlkZW9AMWMwMDAwMDAuDQoNCj4gPiArICAgICAgICAgICAgY29tcGF0
aWJsZSA9ICJ0b3NoaWJhLHZpc2NvbnRpNS12aWlmIjsNCj4gPiArICAgICAgICAgICAgcmVnID0g
PDAgMHgxYzAwMDAwMCAwIDB4NjAwMD4sDQo+ID4gKyAgICAgICAgICAgICAgICAgIDwwIDB4MWMw
MDgwMDAgMCAweDQwMD4sDQo+ID4gKyAgICAgICAgICAgICAgICAgIDwwIDB4MWMwMEUwMDAgMCAw
eDEwMDA+LA0KPiA+ICsgICAgICAgICAgICAgICAgICA8MCAweDI0MTdBMDAwIDAgMHgxMDAwPjsN
Cj4gDQo+IExvd2VyY2FzZSBoZXgsIHBsZWFzZS4NCj4gDQoNCkknbGwgZml4IHRoZW0uDQoNCj4g
QmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0KQmVzdCByZWdhcmRzLA0KWXVqaQ0K

