Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19FB78D172
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 02:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240383AbjH3Axp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 20:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240111AbjH3AxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 20:53:17 -0400
Received: from mo-csw.securemx.jp (mo-csw1800.securemx.jp [210.130.202.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B324DCEC;
        Tue, 29 Aug 2023 17:53:02 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 37U0qAj13163884; Wed, 30 Aug 2023 09:52:10 +0900
X-Iguazu-Qid: 2yAb0Rwz53eOoTHfkm
X-Iguazu-QSIG: v=2; s=0; t=1693356730; q=2yAb0Rwz53eOoTHfkm; m=lWtJosSnTcFccDGopZU0g2Y8tPwQZ2N+HlV6eS8UBDg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1800) id 37U0q7Er2718305
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 30 Aug 2023 09:52:07 +0900
X-SA-MID: 7007644
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmD4GY+FtUEOH0RlIJRE8Fwo/PKQva59hLjBVjpCsnTGptzmhL+r6VUn5nkg6um1uI1AzY93YbwnsxlN6usDMHH2QErK6/xWlYl/35dUdpGpm9OIi3P6VHtbcvXAOWxNyEx8YO0nqo5e0Gpd+mTQSzJg7lMpElY5AsyzyN7Vkl4zDCHrV+qtaISvf5XhxreEr/4G4lTEoPkCK8gq3zIuFs9tyuusXaMvM1ZyOp6ABUe9Cmte6Nd99IfXJyEd86GxVg0dhQBtPWygDTfF+Y95jyFdgSTUyJmsofiPtXP1Vr1W64rQrIbCg4RoAEmojaIyyMfhHh3iG/5QuoHb4jQv2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SN3r+Vq647YIDZMooXhkfa/eGoAuZKi/OiNWnbm15BY=;
 b=hJe46Bf1WOkPCdYWIU377mR/Yxfs4rSXuNzpP2V9G+yDfsV3i1kY31ZaapB5eXje9DutTQ+qL1pH4zKg76MRktDOnk2TjvzgqCDbmR9jS2bdGj6Uj+0FAPnaWVDl+fzeBPhVciRZAWroFpjhmq2g1BTaMwClFEmdNeQKEwe5VpA0c5kn9ag07Bkj/XFYNjZzaPuY8uVviXRjTKaG+p+2SqH+Tork8KfOJK88Wu+E0TsMYoE+TGUb5O+DcvmYKZhud+1r2g4Nk2La1r7gzI3LuLJ0CHoLo1p6BZWLXzo2cZM9y6XShi78mSmjr7ywVLwTCOMl2bT3Ot5iuYgWkikwPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <yuji2.ishikawa@toshiba.co.jp>
To:     <robin.murphy@arm.com>, <laurent.pinchart@ideasonboard.com>
CC:     <krzysztof.kozlowski@linaro.org>, <hverkuil@xs4all.nl>,
        <sakari.ailus@iki.fi>, <mchehab@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nobuhiro1.iwamatsu@toshiba.co.jp>, <broonie@kernel.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <hch@lst.de>,
        <m.szyprowski@samsung.com>
Subject: RE: [PATCH v7 2/5] media: platform: visconti: Add Toshiba Visconti
 Video Input Interface driver
Thread-Topic: [PATCH v7 2/5] media: platform: visconti: Add Toshiba Visconti
 Video Input Interface driver
Thread-Index: AQHZtfW5hu3ISayHZk2QIdiCHPOlgK+45pCAgBEqX6CAKudBgIAABLaAgA1N7WA=
Date:   Wed, 30 Aug 2023 00:47:00 +0000
X-TSB-HOP2: ON
Message-ID: <TYAPR01MB6201D438D832B667FEFB823392E6A@TYAPR01MB6201.jpnprd01.prod.outlook.com>
References: <20230714015059.18775-1-yuji2.ishikawa@toshiba.co.jp>
 <20230714015059.18775-3-yuji2.ishikawa@toshiba.co.jp>
 <0d0cec7f-030f-ebc1-11f0-06214197a351@linaro.org>
 <TYAPR01MB620105AC2EDF36751EE654C89203A@TYAPR01MB6201.jpnprd01.prod.outlook.com>
 <20230821131903.GI10135@pendragon.ideasonboard.com>
 <e91dde98-b1ec-6e68-b823-9b5232a4774d@arm.com>
In-Reply-To: <e91dde98-b1ec-6e68-b823-9b5232a4774d@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6201:EE_|OSZPR01MB8123:EE_
x-ms-office365-filtering-correlation-id: 36fba08a-569d-47cb-b787-08dba8f29ef0
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aG6CjbLWfyVKCBXVNYiN93+w5n7mvkqY9hOMSdyoEIlg2en8LtMfdwpqVWZKcOB9S1a1ki/HOO/091xgW1N9rjuSRHGX7x6YJFf9mspAV58Y1R/eCspEgIQ8k8HvA9l3AMJU+qmGZY/2P7Ylot+WrA/d93/TbU8JiagcIWhOdtf7zALdF7tFe1ALTkGJ94FQBPN4M74FA7Xr5GsUwhJrTCx66byvBHKWfrCpjiTyxdbtRRZHZ02meP6RCXpujL5aLVnB3r5gMrF/K2btxJMWiOYVk8NtWOVwm8rI50xFiePmy90elF6FMft8mmn5Uws5CJ0juBkYyH4gIpEZGKReI04RmdXrp2LLweS6oqGoEMXj7TSUIStCXfN3tIhc4dF+1y97HK/7x85CRw19NTXO1yqUkBgki6+0pY7jkOtX7ccLkmdhbWyS7W6zN3DE0Fo+Y5V69v9KZunavAkIbpZcx5xjmdEM14eykAQ6uDn6rl6VHo1zRHnnnge85RgEFX2rQbbIHxJRFEF6/cMNsavhMgl44oJS6zpf7MAnc4PyS1KLpb1S3QmoKboAgsKKOyPN4HjCMuWwxUsproFtlpjQyyl0GyIjeNfkMdlAJpOMnVgVDpW2tp1kFXVX7DPe6cAV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6201.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(136003)(376002)(186009)(451199024)(1800799009)(7416002)(2906002)(9686003)(55016003)(54906003)(33656002)(76116006)(66476007)(66556008)(64756008)(66446008)(316002)(66946007)(41300700001)(4326008)(8936002)(8676002)(5660300002)(52536014)(53546011)(110136005)(6506007)(71200400001)(7696005)(38100700002)(86362001)(38070700005)(122000001)(26005)(478600001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0ZmSjM1QWV4N2hGUkI3a1FIM1hwVW81S0RSbUJEV3VGWFFiUVpzQzhEYVp4?=
 =?utf-8?B?RG9na1IyK2pVSGFPNlA2dFhSY3pLUDNFM0dCTlUvQnQwZGt2bmczVXVMN1Zx?=
 =?utf-8?B?Si9DdGdpUUdwN3hDOUtaRGZjWVNwMndpWHJPSm0wK1ZkSk1pSDRkZkF4L0gy?=
 =?utf-8?B?US83bXR4OXVKY241K0dxUmdHR1RYRXFtTkFaRm8ybldSR0dnem5ZajArdnhh?=
 =?utf-8?B?Yk4vbVF6bkwweTA1c1lLUzBjZlNuWHEyRzNQb1VlYmV6L2JmVUJWS1lxYTd5?=
 =?utf-8?B?V3JXc1NSWXIzakFFSldzT0FOdVVjQlBVdkRBdVVkUDJ4U3pJM3VmaVZaV2Jh?=
 =?utf-8?B?azkrdTJocUFpT3lmYW1WeDNqaWFJTWZoc2YyRmJSaFFPSVplZlo5ZHRSYnNF?=
 =?utf-8?B?c0xoQ01RWVc1RXJkU2xXakdLa3F0QlI2OEp0Y3ErZmVjNzA5WkFwd1IzVjA4?=
 =?utf-8?B?Z3hjY0JZaGdPdVdTRFhaMG03VkFGYjFzTTM1WGFDNGZJaUpVd0pNSUdSQXZS?=
 =?utf-8?B?ci9xcWJySHdVRDBWdEd3N2hXSFFyZEpYZ1RKNURPdmdiQWIvWG9kbVZFRFB4?=
 =?utf-8?B?SEdQZFZCMCtabjFKOHhmZjVtcnlKSVNFcDRXdFF0TENYU0RPWHo0RUNtN0xl?=
 =?utf-8?B?UWsyb1VUb3I5YnJVeUdlc0kxRWhjQmtFTUU5aVFKZDg1cnRCZy9iVW5VRmJ0?=
 =?utf-8?B?TGlZalI5aE1NamFKRXhGNUg2SzhPczRSU3ZVMVVGKzc4YWNMQ0xSVVlEU1ZN?=
 =?utf-8?B?cEladDdOZE1tK0dzNGd2cXhqUGtWNDBhYmZ4OFlUL2g4U2pNTndmcmxtODhk?=
 =?utf-8?B?bEJza2UxUm9URHg4NDkwYllPWnhMTkpadnd3WnVWU1pycEkxb0Rtbmk4eis5?=
 =?utf-8?B?d0V1RkIxdDdHSWY4NmRqa3JYaDBKUGh2QnJyR3p6MjJqaEF4b1dzYjF4dy81?=
 =?utf-8?B?Y3N5WXNycXozSmw5cmhsRCtJTDFXdU8zd0xtNk9yT2M1b1dyb01OdnFqeFFt?=
 =?utf-8?B?bHhON1FhbVFrc00vWFhDWEwwc1VBbUc5QkpUR3lSMHM4MVl6SDZJdG5vNHB4?=
 =?utf-8?B?SnBwUlRKVDUxeEg4enRKeUZ5bTJFczNyTXg4d29XVGFGd2xSR01nTWNTV2h0?=
 =?utf-8?B?L2RQV3NkcnNqcFFlVGtaVUZZc1FxOEQwZzJwTjRIQlQ5NGZreWV5REFqMGMx?=
 =?utf-8?B?TVJsc2gxaTZPTWY2WEc0K3BOcUxTajBDa0xuSUwxcDRrNFJMYnhkNTJBVFU0?=
 =?utf-8?B?VkVBUENyR2daZnl4SkQrcjZkUUZkeTNCVGdXL0RNS1Y0VlJBTDh2MjBhekll?=
 =?utf-8?B?a1NsQWZJdHNKZEs2N0J5RHkwaHhvYUxvZlNFWEJOcU1IT2tDVzBDS2sramRC?=
 =?utf-8?B?VHd6ZjYvVnpCdmVheGRLVEFyTlJMcWtyVnIvZTljdmVwcUxPYTd0V1k0bkx3?=
 =?utf-8?B?djY0T2RZekFpZ3FBYmh4Wk9nOFV6allCcHk1NVVBWndOZDQwd2hSaWF5NkR4?=
 =?utf-8?B?NDF5b3JqdDFXbFp4UlF0MFp0N0hBNzdFQjlTdFlUOUg4bG9MYkxaNmRicjdj?=
 =?utf-8?B?cmxJb011TzBrMng3U0NCc2kzbUR5VXJPZjdiTzFCalRkcVM5RS9jVzExN0hy?=
 =?utf-8?B?T21wK3dHUWtkOU9NUWh1bEVuM3R6QjVPUHc0clQyMEQyVEord216SlFkRDF4?=
 =?utf-8?B?c2RqalpHeDI2TnphM1BLUUd3NWhyRnNyZFRUdDhraGdOZTZNbFpyZXYxY2ww?=
 =?utf-8?B?SkQ5V1ZmWWlWTFpNTTJnTXV6dFpjTldEWG96RGZlOFBCOUpNOGNucHFSbXQ1?=
 =?utf-8?B?TkRXY2VnNFdUQVZJbjlhMEdyUWZpNDFJd0lYTk1zNGRQU2Q5eUtqK0w3Q2NL?=
 =?utf-8?B?WWszRkg3L3hyVXljL1BheWJ4aURQWVZRVzN0a09ra3VsNUViSHIvdmh3RVk2?=
 =?utf-8?B?NXppSTZ5N08xMTFhR2RNVm1pZFBCWERFOXVoSllYOS9ETzdraWhKK0tqSGRV?=
 =?utf-8?B?amhMck9PS2svVkhuem1KVGRlYUFZaHM0MVR2YmNMUHJ5QmJ1WTcvUHlhMURl?=
 =?utf-8?B?Q0ZEUEM5ME8zVzY0cjhjZWlmYTV5NmhHUW1ndjhzemdTdk95RHk5UytxMlQ2?=
 =?utf-8?B?QmdmTlFDdlVoVStiV0Zmd2x2RFhhbHdLNDFOcUdrRjZqVGlIRFI1NTVNampU?=
 =?utf-8?B?QVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?K0R0WVZ0L2ZkbzdwNXE5N0RMbG00S0pUQzFDSHRQR0d2WkFTaDdMaS9hTWRV?=
 =?utf-8?B?RDFtZmMwcW5rMUpPOEU4SUlGVnB4Mi9lYm40ck5xajVDTU16UFRxYlc2Mk5J?=
 =?utf-8?B?MTNydEFUMWJWdjdpS3pKVTJQSThrS2JNd0E5STQ4N1lidzdMUDNZcnUyc0M5?=
 =?utf-8?B?U0tTQWthVmxIK3N1a3AxK2NMN3VPVnV6SmFhbno0R2o4N0Z3Yys3UUN0Vy9R?=
 =?utf-8?B?VHlmcEswSXE2OHNMWUdFZ0hjN2VRdGYrdUkyU2lTckdJS2d5alJlblhjczJK?=
 =?utf-8?B?b2FkQlJZYkN0N2pQbnp6bmtORTlVNGxSQkhsRTA0Ukd2dnJmTnRkSWcxdkpx?=
 =?utf-8?B?U2hwTFNJdndrd2pwVUEvQkFtVzdRSHl1QlNmaWY2azlYMGs0WHFsZ3JPRVZF?=
 =?utf-8?B?VFMrVS9UbjlKYklZMmhMTVo3azFocUR2SDdCSE81RDNXVTRkdkFWQ3NaY3Va?=
 =?utf-8?B?OWhkcHhpRE5KSHV0dE9TZEQ3TTlzY24vMXhxaExFWU0rSHlKSExZaXdwQWxs?=
 =?utf-8?B?dlY3VjVoZy9lSFNrbzhVWUZvamw2UDZPdjczZ3ZqWXdweld6Zm5JelZLM2pu?=
 =?utf-8?B?OUVydnkyYVhUNDUrK3dySE5RajV3MkRZZ3ViaHZISG8yajB1blNUMUEyaXcy?=
 =?utf-8?B?dk1BWEhtZEtWNTUrRUdkakR5dVM3b0JvNWRCUUlqSEtVelN5Z0hVY0cxdEs2?=
 =?utf-8?B?UDc2bnQwQnl3M0xQNlcrSHhsUkY2anQrbjJTK2RPK2NXMWtzTkF3eVluNURX?=
 =?utf-8?B?WnU4RndBbGdwbjRKYUdZWmFEaHB3VVg4RlQ2L3ZqcXBqWGZEekdJQzZXVGw5?=
 =?utf-8?B?eXFzRW4wdW4zU0pyOTVGbTZrTGZhblAwRmJMeFd5cSthZnlzRGN5cXR4Ym53?=
 =?utf-8?B?MENvLytXb1QzS2NXRTlDTmNDVUd6V3g0YXlmYm8weTc4bVFwOGF0OE9UK0ll?=
 =?utf-8?B?eXI0Q2ltME5ZUEhkSE1EQ3NGa05sT1c0WjU1UW0vbGpIeHZENDE5dHBFNWl2?=
 =?utf-8?B?a296RzVMajl4ZmdTZHh3RElIdVlieFdBRmZLSmdWcHJiOW94dFVpUzFjKzNi?=
 =?utf-8?B?Rm9CMTRaTmp5UXl3VnR2TVM2Q05rMk5PLy9kQURyUElyZGNkVnhQTjdVck5r?=
 =?utf-8?B?TDA3VTY5NGhnMFZiYU82Um5haCtGRUVya0pZakw5UkJsODB1U2xBcVFFL0ll?=
 =?utf-8?B?cVJFL0tGejJudHVhL0xNRVEzNXVwdXp4Z1VGZEZLOG9JV3NWczZ1enJRSXRY?=
 =?utf-8?B?bVVBamRGU0FraWFMeStvY0xpdnJrRk1qQ01TQ1Y2NjllZHhTWkN1QWYzVXNO?=
 =?utf-8?B?a0tQQVBURjVMNWR2d1YxeW1JNDQvMG1nNzZwWkFvWTdKZ3lxaXVrdGtNQzZo?=
 =?utf-8?B?dXdKb3ErRG43TmFBM1Q4cGhUWXFGbVc4eDF6RTFyWkNhTTVBMDBObWg3UUdL?=
 =?utf-8?Q?mGZSOapL?=
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6201.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fba08a-569d-47cb-b787-08dba8f29ef0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 00:47:00.5081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZfUgO8YOAamstdczqFrjFiv7bvXP73+yyQTORwCwyob7CUXEENx04xNFHIAN+bQPqxkWHwgwAYicOXHt325qVF8M9EUg7lOC+9CVlUrTGq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8123
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gUm9iaW4sIExhdXJlbnQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4NCj4gU2VudDogTW9uZGF5
LCBBdWd1c3QgMjEsIDIwMjMgMTA6MzYgUE0NCj4gVG86IExhdXJlbnQgUGluY2hhcnQgPGxhdXJl
bnQucGluY2hhcnRAaWRlYXNvbmJvYXJkLmNvbT47IGlzaGlrYXdhIHl1amko55+z5bedDQo+IOaC
oOWPuCDil4vvvLLvvKTvvKPilqHvvKHvvKnvvLTvvKPil4vvvKXvvKHplospIDx5dWppMi5pc2hp
a2F3YUB0b3NoaWJhLmNvLmpwPg0KPiBDYzoga3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3Jn
OyBodmVya3VpbEB4czRhbGwubmw7IHNha2FyaS5haWx1c0Bpa2kuZmk7DQo+IG1jaGVoYWJAa2Vy
bmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOyBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFy
by5vcmc7DQo+IGNvbm9yK2R0QGtlcm5lbC5vcmc7IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDk
v6HmtIsg4peL77yk77yp77y077yj4pah77yk77yp77y04peL77yv77yzDQo+IO+8tCkgPG5vYnVo
aXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPjsgYnJvb25pZUBrZXJuZWwub3JnOw0KPiBsaW51
eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IENocmlzdG9waA0KPiBIZWxsd2lnIDxoY2hAbHN0LmRlPjsgTWFyZWsgU3p5cHJv
d3NraSA8bS5zenlwcm93c2tpQHNhbXN1bmcuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY3
IDIvNV0gbWVkaWE6IHBsYXRmb3JtOiB2aXNjb250aTogQWRkIFRvc2hpYmEgVmlzY29udGkNCj4g
VmlkZW8gSW5wdXQgSW50ZXJmYWNlIGRyaXZlcg0KPiANCj4gT24gMjAyMy0wOC0yMSAxNDoxOSwg
TGF1cmVudCBQaW5jaGFydCB3cm90ZToNCj4gWy4uLl0NCj4gPj4+PiArCXZpaWZfZGV2LT50YWJs
ZXMgPQ0KPiA+Pj4+ICsJCWRtYV9hbGxvY193YyhkZXYsIHNpemVvZihzdHJ1Y3QgdmlpZl90YWJs
ZV9hcmVhKSwNCj4gJnRhYmxlc19kbWEsIEdGUF9LRVJORUwpOw0KPiA+Pj4+ICsJaWYgKCF2aWlm
X2Rldi0+dGFibGVzKSB7DQo+ID4+Pj4gKwkJZGV2X2VycihkZXYsICJkbWFfYWxsb2Nfd2MgZmFp
bGVkXG4iKTsNCj4gPj4+DQo+ID4+PiBBcmUgeW91IHN1cmUgRE1BIG1lbW9yeSBhbGxvY2F0aW9u
IGVycm9ycyBzaGFsbCBiZSBwcmludGVkPw0KPiA+Pg0KPiA+PiBQcmludGluZyB0aGlzIGVycm9y
IGlzIHVzZWxlc3MgZm9yIHVzZXJzIGluIGdlbmVyYWw/DQo+ID4+IElmIHNvLCBJJ2xsIGRyb3Ag
dGhpcyBkZWJ1ZyBvdXRwdXQuDQo+ID4NCj4gPiBGYWlsdXJlcyB0byBhbGxvY2F0ZSBtZW1vcnkg
aW4gdGhlIGtlcm5lbCBnZW5lcmFsbHkgcmVzdWx0IGluIHdhcm5pbmcNCj4gPiBtZXNzYWdlcyBi
ZWluZyBwcmludGVkIGJ5IHRoZSBhbGxvY2F0aW9uIGZ1bmN0aW9uLCBzbyB0aGVyZSdzIG5vIG5l
ZWQNCj4gPiB0byBkbyBzbyBtYW51YWxseSBpbiBkcml2ZXJzLiBUaGlzIGJlaW5nIHNhaWQsIEkg
Y2hlY2sgZG1hX2FsbG9jX3djKCkNCj4gPiAod2hpY2ggaXMgYSB3cmFwcGVyIGFyb3VuZCBkbWFf
YWxsb2NfYXR0cnMoKSksIGFuZCB1bmxlc3MgSSdtIG1pc3NpbmcNCj4gPiBzb21ldGhpbmcsIGl0
IGNhbiByZXR1cm4gTlVMTCB3aXRob3V0IHByaW50aW5nIGFueSBlcnJvci4gSSBkb24ndCBrbm93
DQo+ID4gaWYgdGhpcyBpcyBhbiBvdmVyc2lnaHQgaW4gc29tZSBjb2RlIHBhdGhzIHRha2VuIGJ5
IGRtYV9hbGxvY19hdHRycygpDQo+ID4gb3IgaWYgaXQncyBvbiBwdXJwb3NlLiBNYXliZSBDaHJp
c3RvcGgsIE1hcmVrIG9yIFJvYmVuIHdpbGwga25vd24uDQo+IA0KPiBZZWFoLCB0aGVyZSBtaWdo
dCBiZSBhIGZldyBlZGdlIGNhc2VzLCBidXQgaW4gbW9zdCBjYXNlcw0KPiBkbWFfYWxsb2NfYXR0
cnMoKSB3aWxsIGVuZCB1cCBmYWxsaW5nIGJhY2sgdG8gdGhlIHBhZ2UgYWxsb2NhdG9yIGFzIGEg
bGFzdCByZXNvcnQgaWYNCj4gYWxsIHRoZSBtb3JlIHByZWZlcnJlZCBhbGxvY2F0aW9uIG9wdGlv
bnMgZmFpbCwgYW5kIHRodXMgY29tcGxldGUgZmFpbHVyZSBzaG91bGQNCj4gZXZlbnR1YWxseSBj
YXVzZSB0aGF0IHRvIHNjcmVhbSB1bmxlc3MgRE1BX0FUVFJfTk9fV0FSTiB3YXMgc3BlY2lmaWVk
Lg0KDQpJIHVuZGVyc3RhbmQgdGhlcmUncyBubyBuZWVkIGZvciBwcmludGluZyB0aGlzIGVycm9y
IG1lc3NhZ2UgYXQgZHJpdmVyIGNvZGUuDQpJJ2xsIHJlbW92ZSBkZXZfZXJyKCkuDQoNCj4gVGhh
bmtzLA0KPiBSb2Jpbi4NCg0KUmVnYXJkcywNCll1amkNCg==

