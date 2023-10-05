Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33CC7BA5C7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241536AbjJEQQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240773AbjJEQNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:13:39 -0400
Received: from mail1.bemta33.messagelabs.com (mail1.bemta33.messagelabs.com [67.219.247.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401D92755C;
        Thu,  5 Oct 2023 08:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1696508336; i=@lenovo.com;
        bh=v1+aAx47a4VG6qc3iGIn7MkK5wiJwZrqulAxguRoTEQ=;
        h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
         Content-Type:Content-Transfer-Encoding:MIME-Version;
        b=J4nnFeLwJaHCcnqAh63cReGrLByuPnZO92bOsZvjPtCr8zPSKox1hjqB7+/LNbMl2
         dyH+E/RBdBSVLT03A3jj4AjtkgebNUGoJkE7s9Ws2zUpKIwPzPcB5VzWy4D5PKCpU5
         MH3wxMGo+tXiA1PuUAX2f5UTwyqDaQCRIWja9D+o3/3CEM53SD1gvGhrRPcR0xjgek
         0XGdaI6wcIOz4r0K4T5ORV0KSPthUOTXkxXfuh8MUdOGPMB7/cIiWwntiFkMuLmwMF
         XZ3n0GZzoNpSoSK1wssSJFZI9ryu+c6BjXSif+5dXPJYQqBZR94CGlQQaGX1Ee6Xf2
         neyHdyTXB4aDg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDJsWRWlGSWpSXmKPExsWSoS+Vobt+pVy
  qwYR2dYvLu+awWdxYt4/d4snCM0wWj1/+Y3Zg8Vi5Zg2rx87vDewenzfJBTBHsWbmJeVXJLBm
  nHp5k7FgP0fFo2vX2RoYN3B0MXJxMAosZZZ4OGUpM4SziFXiWMM3JghnA6NE96/PjCCOkMBcJ
  olNfd+ZIZx7jBLL+3cCOZwcbALKEl1Nj9lAbBEBNYnmUy1sIEXMAjsZJW7secICkhAW0JFYOe
  8aI0SRrsTEHZdZIGwriesvJrKD2CwCKhJz528Fi/MKxErM2LKNCWLbJEaJlvVtYAlOAQeJFxe
  XsoLYjAJiEt9PrWECsZkFxCVuPZkPZksICEgs2XOeGcIWlXj5+B9UfYnErZfr2SDishKX5ncz
  Qtj2Ekd3b4Cq95VomjIRKi4nsar3IQuELS8xbdF7dghbRuLBje1gX0oIXGCV+Pj3CAuE85xF4
  uT8N1BXGEjM+3YEqmqrqMT/GbuBxnIAnaopsX6XPsTVihJTuh+yT2DUnoXkiVkIVbOQVM0CB4
  ygxMmZT1gWMLKsYjQrTi0qSy3SNbTUSyrKTM8oyU3MzNFLrNJN1Cst1k1NLC7RNdJLLC/WSy0
  u1iuuzE3OSdHLSy3ZxAhMSClFLkw7GP91/dM7xCjJwaQkypvbK5cqxJeUn1KZkVicEV9UmpNa
  fIhRhoNDSYLXbzlQTrAoNT21Ii0zB5gcYdISHDxKIrwzZwCleYsLEnOLM9MhUqcYdTmubNu7l
  1mIJS8/L1VKnFdhBVCRAEhRRmke3AhYor7EKCslzMvIwMAgxFOQWpSbWYIq/4pRnINRSZhXBJ
  j2hXgy80rgNr0COoIJ6Ah/VbAjShIRUlINTMcLuoN6uD6K8J+QuHwxrkXwgxnTPQ79L0maV6q
  u9pZcsjz82fR2S2xm7+pPW15XrD+qFFS/atGDY4X9ac71ld3/EvUdlvss0LbtO7R+wpvOz6u8
  tyvVzW4tPhin0RDxXf7O3/sbVn15v2G5bMra14faHCY7zhLLOvfp15ddmcuFOz63xHIcmh6zL
  /g76+ugfwbCpsZVPUu5Nc5WJzEKq+w+z2C3OlsxVP2wiHxV8O95J/ctY2yTEPFjC316KSWbxf
  LnNcsWzsPBvJ2P5LJU7s4IWn1vx1I+yfCGFxtWLf1zfOV6qdR172dVujQI3XpXZvZpwYSkFfb
  2lxNboj8KMGlVtr8x8KtW4v/EJqtkpsRSnJFoqMVcVJwIAMhXHj1PBAAA
X-Env-Sender: dober@lenovo.com
X-Msg-Ref: server-2.tower-715.messagelabs.com!1696508333!16171!1
X-Originating-IP: [104.47.26.104]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.107.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 4291 invoked from network); 5 Oct 2023 12:18:55 -0000
Received: from mail-sgaapc01lp2104.outbound.protection.outlook.com (HELO APC01-SG2-obe.outbound.protection.outlook.com) (104.47.26.104)
  by server-2.tower-715.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 5 Oct 2023 12:18:55 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPjW2GxcKlgfsq7p3N48clF9jh2MXXU2Vkhd9s4zTW8I9zGYi+FJdPneZZIUIGpLUZrW+BKuRjI35VdmEFAfiwff9z7Zs+Hv15ezxe3NRPGa7Enzxtsm35YXhejG681AE6konc2wTqcE23pi65NMk7PRgmMdoyITVID51FwgHx9HGcF/I7A6Yxm8auoCW+iMAaeGtrW8KJjJkKCycKum9/ufJsV2lOrpsluEbws4pvaYi1P4CJWROAMS6ISEGjFqvVYUYeJV24sgsZDChBuGuKF2/81CkDRpdTwj0l1tjMGEUW9HhyqJWrW8BGaTxog7CjJwzUd08iq5Zilq6ZSVUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1+aAx47a4VG6qc3iGIn7MkK5wiJwZrqulAxguRoTEQ=;
 b=eXn6AdVfPO3XR7+T/HndOFlfB9WpCiREZIc70NTNyMi2uvr4n2jTPjNfu20NfWpxRhexq41Hj9AKEwLbutepcAk/A1LZoKxTZgKcHb16dCfo333Iu5g2xe22wOQARJDDwh+3SDopk6IJzpSqFkCAiBNEoqBowZFdM8H+wNzRJd+vUrkJ3rdTISt+2W2x0yTeICYE1hLg4wzjISXbwqqfrjB8iyUy0GN5Nwj4V+7+fztE43NiarcP7NPsQ+EWs0E19kVVFsnbrQD2yMUtFs8INJhBa93Zf4Wck5+d9jB5dInEyuaXFUwbbCcL/XuzmVXE5tt+B8yQvXmS9sYIHQx7Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
Received: from SEYPR03MB7192.apcprd03.prod.outlook.com (2603:1096:101:d5::9)
 by SEYPR03MB7861.apcprd03.prod.outlook.com (2603:1096:101:178::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Thu, 5 Oct
 2023 12:18:51 +0000
Received: from SEYPR03MB7192.apcprd03.prod.outlook.com
 ([fe80::fe3b:d5ca:39f8:eae8]) by SEYPR03MB7192.apcprd03.prod.outlook.com
 ([fe80::fe3b:d5ca:39f8:eae8%3]) with mapi id 15.20.6813.027; Thu, 5 Oct 2023
 12:18:51 +0000
From:   David Ober <dober@lenovo.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: RE: [External] Re: Watchdog patches
Thread-Topic: [External] Re: Watchdog patches
Thread-Index: AdnGuYfve3Nj/PKLTa+mTLIbzcubzgBuI+OAC8TWz0A=
Date:   Thu, 5 Oct 2023 12:18:50 +0000
Message-ID: <SEYPR03MB719214D0CFFAA04B17748321DACAA@SEYPR03MB7192.apcprd03.prod.outlook.com>
References: <SEYPR03MB7192579DF7D0130F699CB7D1DA09A@SEYPR03MB7192.apcprd03.prod.outlook.com>
 <3c51b285-6691-14e7-e3e3-9e111e8561a8@roeck-us.net>
In-Reply-To: <3c51b285-6691-14e7-e3e3-9e111e8561a8@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7192:EE_|SEYPR03MB7861:EE_
x-ms-office365-filtering-correlation-id: 87ef788a-10f9-4a7e-2e8c-08dbc59d3bf7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nJeA/zwwOs+s1M8y/MABiAm+k/9trw8YBqnFBTTO/nKonPpYBgkemw426QjbfkwfP6rVCY+/qTK2kV53mG7t1SSxJ0i1fIrUls8nBzBTS2xYq8scJAPhfZLaiKgJb1+DQebwZZ8eutxq+BhMq/f/J3eD1IgSnpKpQigflpgI4VZ0Gf6Q5ang+EMHx0fpO41w6ePomWrqO11qRv1UyWgcXnVCeFALr42B2iKColgM3oMfdgbBC5H+NW/tPFZ+KJEIt8pb5fjKtLbwEFQMi83+S/EtwzGVRsrc9hqITCF2cfhlyB47KNfAwiWu18qEk6EmYOyEJpmUeG5NG1emepk/YmpdF7i001dE3pGz6oit+WlAGOyhgud5z2uOxeym6oajOKEu9QjscVVM3nSygcNh3NtaPM5ZNwSWx6oOeIQA4GXGl8cd+32vfCDbRSmai/1apqMHvVf2VLQQZao1mQnIAxydU5U5A4ZFyNINkHdo7h7sEZY/jjszN6cf65HSaDihka248sznMkxNLkQ8T02Vuhp77ORdXVDVricPxRxFMFzwKfvpjvJQitskeTkA2c0/x8wrHvCknEW4qv5/zdV2dk8aeelCgAX8Ul1k6bDo5LICmsUywuMi+df/R4nmitdAdbHUUbjlJjvuL+2N9hi4Uv0bxwTESRVkZK3ecAFzj44=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7192.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(346002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(55016003)(7696005)(6506007)(71200400001)(478600001)(53546011)(86362001)(38100700002)(38070700005)(122000001)(82960400001)(4744005)(2906002)(41300700001)(83380400001)(9686003)(5660300002)(33656002)(8676002)(66556008)(66476007)(66446008)(54906003)(64756008)(316002)(76116006)(6916009)(66946007)(4326008)(52536014)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QURCcmw5ekZTbUp4Tng4Mlgyai91MGFGUThnYzZ3N0picElDeWJHODNjdklY?=
 =?utf-8?B?aS9FSWJJM2I3SXdxbm1wdjhBUllSb0R5MzBhR1NSdUdqMkdEVjVsVFhuNHZX?=
 =?utf-8?B?bzNYT0xMYkVHZDdIclZLQi82RXNjRERmaXE3RVhUOU1Tc0NpczB5cXZSVmRS?=
 =?utf-8?B?YnI5YVJaU0tsdUdIcmtZenQyZG9mMko0MkJvVU9mTDZldERqQjhCMWFmbkVL?=
 =?utf-8?B?ZnNtRXd6Z0RpZURqY2VmM0YxaVJmRklreXZmQlh1WHhwbTdRZm9oNzNENzh3?=
 =?utf-8?B?N3ZvNDZ4VU9rbTZnalRiaGtFSDY5c3NOK3plSW8ra1p0eWJ5WXFzYk8zQld0?=
 =?utf-8?B?T3A3eXh3WGJRL1FEOVF5ejFnRDM5aHV0empuLzFnRFFMZ0g2N05Cbm5adXRZ?=
 =?utf-8?B?ZFhaY2FwaDJqNXZpVzloT0ROcE1rbjRKWlhBSUd5TXVEeUxDQnhNT0ptbFhn?=
 =?utf-8?B?aGFpbDlvcGQ1RGRqRm1MQU9iaXgwSXhMRWZna1NEbDFmRTNtc0VaVjdKM1Mx?=
 =?utf-8?B?RTJEM1NZUkFpY3ZzNzNaZExrL3k0alhJWmJ5OENrTnBtbGJ4Z0lzdUlORllM?=
 =?utf-8?B?dWtQaDFrQ1FXWFc0aExsaUpkZlpveUpHZzcrQk5HTEkxMUZyd1dMOC9qckZD?=
 =?utf-8?B?M1NaN2Z3SUhETTVqeFJ0U21uc29KOUg1MUZ0Rnl1emUvbnkxZGNreVZRaWFO?=
 =?utf-8?B?QXVteSt2VlJvL3ZRYXkwZy9YNU9mSmtNcTVqb013eDRhdmg3dW9FVnJ4Nys5?=
 =?utf-8?B?a1RYZS9zRFBmcndkWll3NDI5Q1g1RmY3QUtVRGNFYjRXa3ZuNWp5T2hqOTNH?=
 =?utf-8?B?d1A3WEcyT3F5UWV5ZEtPamxkMU9MVm5VNlp2MmF0Q0p6WkRkR2taQ3hiNzYy?=
 =?utf-8?B?cXBuR282TGR4ZnJxQVh0U0NHc2Q1dXJicmVSdzJqYU5SRW9WZkVNeXVTSkVI?=
 =?utf-8?B?dUNSUHJNVWhEK2kvczF3b2ZVWHlSOHd5Z1FjRGMybGVUQWFTSVkxZVpPTW1P?=
 =?utf-8?B?RXUvcWpEdm1JUzF0cXd5cmxiKzA5TERhaFZ0dnlZMFRsZ0tXRG45dDA3NDBE?=
 =?utf-8?B?RlJFdjVRNGtTdFhiVStqbXg3U2pNR1p1WS91N2Q5WS9UTGppSlBlVUVvU2Ja?=
 =?utf-8?B?OWFyQVFLczArVFBBQWZSRk5OdWEvc0E5U1I1QjBtMXVGV3dKeEJqOUdRYzhW?=
 =?utf-8?B?TEhHSGdWaDExdmFuNmVrMWM1WkJYaEVCUlBxOFB0YkJxSGI5ZGsrWU0zbnZy?=
 =?utf-8?B?ZGFYcmk5L055QTZYK1VETlk5ZTNjOTZheEhUQVZ0SDRaOTk5VGtVYUxBWHpR?=
 =?utf-8?B?RDZUVEs4NFdKY3pKZWc5c3NsNmp5K1ZMdThiNUJPNys2N3F4aVRlbDFMWEN1?=
 =?utf-8?B?N05ieGkyTS85R015cHJrODBIdXpUQkhXNXZkOWQvVi9TVVd0dEZFS1BxbU1O?=
 =?utf-8?B?RFpBVVp3VWpXZGFqNXBaL1h3ZHc2VEZuNkF0T0lzcEw5VjhObkxnb2t6TFpM?=
 =?utf-8?B?R09qMnJkaVNWSFM5Wlo0WFg1OG44SmtQNkdRSVk4bUVKY05xSjJHamNuZERS?=
 =?utf-8?B?UXlBNGZ0YlphTEFQZXpDN0QzTVVlZXBYRnY1akI1YXZRektTVDhCOTNWM1pp?=
 =?utf-8?B?cW53Uk52U0xUQjl3MGEwK09PSm9KN1h2eFZQV1dvUjMzTVRjME95ejlKQzJ4?=
 =?utf-8?B?WXhVY09xWDQydHlXVWFpV0tyazlCMDZFeEZab3dlcmJPOWxWNEswaHZlUlRX?=
 =?utf-8?B?TXFiZDRYVS85WUVXb3p5N3QrMk5Zcy9hU3U3RG12NU1sWTRTUDlobjRiS296?=
 =?utf-8?B?QTZsMUJPdFlNMGZUTXAvOWhiWDNOOGpqdHdzNzhubUFqbExBYnlwbDRMZGMr?=
 =?utf-8?B?aFFqSUZ1RUdOdFFKNDlZUER0NlFWZklYUjJaSWpCaUoxbzk1c2xvUnhQbWoy?=
 =?utf-8?B?ZE1WN0RKM3cwelBES2tGdEN2WjRncGFyZGZuWkptMktlbFlwZEtRUThpTGJ0?=
 =?utf-8?B?L0grMzdqK280UkR6L3hCOWhSemN0bkJGc0Z0QjRzUzdQNHRSUHo2MlJyVHZJ?=
 =?utf-8?B?VnhRWDh6UVVJYWNkd0JtejNxRWdJNUk0Z1JycTFDdmhiR3pYSUV4NTVHWEI3?=
 =?utf-8?B?ejhIVTZFeTZlWXVNeU1jVnJJSWNJMEczSXdGQ3duY21wMGp2YW9nUjJDdlRh?=
 =?utf-8?Q?WCLbcc2ua85Ti8As7NovSGI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7192.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ef788a-10f9-4a7e-2e8c-08dbc59d3bf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 12:18:50.9029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r6WAyhDE1+xROovLqIws1zVYSxwS5B5X5DEHaB2NjL4hvBiNGqTPnUl5mGwjvZmN28ylrYFmzzWXjCICLOKBUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7861
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TnVkZ2UsIEkgbm93IGhhdmUgdGhyZWUgd2F0Y2hkb2cgcGF0Y2hlcyBwZW5kaW5nIGFuZCBubyB1
cGRhdGVzIG9uIHdoYXQgbWF5IG5lZWQgdG8gYmUgY2hhbmdlZCBmb3IgYW55IG9mIHRoZW0sIGFu
eSB1cGRhdGUgb24gd2hhdCBuZWVkcyBjaGFuZ2VkIGFzIHRvIHdoeSB0aGV5IGNhbiBub3QgYmUg
cHJvbW90ZWQgdG8gdGhlIG1haW4gbGluZSBrZXJuZWwuDQoNCkRhdmlkDQoNCi0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBHdWVudGVyIFJvZWNrIDxncm9lY2s3QGdtYWlsLmNvbT4g
T24gQmVoYWxmIE9mIEd1ZW50ZXIgUm9lY2sNClNlbnQ6IFN1bmRheSwgQXVndXN0IDYsIDIwMjMg
MTA6MjcgQU0NClRvOiBEYXZpZCBPYmVyIDxkb2JlckBsZW5vdm8uY29tPg0KU3ViamVjdDogW0V4
dGVybmFsXSBSZTogV2F0Y2hkb2cgcGF0Y2hlcw0KDQpPbiA4LzQvMjMgMDI6NTUsIERhdmlkIE9i
ZXIgd3JvdGU6DQo+IEd1ZW50ZXINCj4gDQo+ICDCoCBIYXZlIHdhcyBsb29raW5nIHRvIHNlZSBp
ZiB0aGVyZSBpcyBzb21ldGhpbmcgZWxzZSwgSSBuZWVkIHRvIGRvIGFzIEkgaGF2ZSB0d28gcGF0
Y2hlcyBpbiB0aGUgcGF0Y2h3b3JrcyBzdHJlYW0gdGhhdCB5b3UgaGF2ZSByZXZpZXdlZCBidXQg
dGhleSBoYXZlIHlldCB0byBtYWtlIGl0IGludG8gdGhlIGtlcm5lbD8NCj4gDQo+IERhdmlkDQo+
IA0KDQpCb3RoIHN0aWxsIG5lZWQgY2hhbmdlcywgYW5kIHRoZSBkcml2ZXIgZm9yIE5DVDY2OTJE
IGdvdCBsb3N0IGluIHRoZSB3YXRjaGRvZyB2cy4gaHdtb24gY29uZnVzaW9uLg0KDQpHdWVudGVy
DQoNCg==
