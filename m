Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C54E7F5556
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 01:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344398AbjKWA2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 19:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344205AbjKWA2C (ORCPT
        <rfc822;linux-kernel+unsubscribe@vger.kernel.org>);
        Wed, 22 Nov 2023 19:28:02 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2130.outbound.protection.outlook.com [40.107.114.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822E2189;
        Wed, 22 Nov 2023 16:27:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJrumn8WMWrogswuIWeKDq2wa+dE59e+b9mPZ4amYKk1FpyeK3JEU2uDZJO+YoQuTvtBNvTPtYpReO5WImZs79NXR1PIxz1qd1R9ZvYVJJtCpjQOdSU1XTiqX7b0hKYcH5SXrfa3LSeubQWsq3mnI1UzauyuQ/bgjWoTtpcjHFxIyetAmLrrV/ILkp1nbpZ4ccbp1Qrtzo/Q+JwFVbkN98VAh4HMaoXsMDXlc4b4RZ4Lasm3COhYfGX+TpCgR5jUEW+PfA9svj4Tp343dVQF8KRfOF+UTWhjAG5qRqEuc8jEvYOzCtA7Iwcw2VvtHwaff160J0vm2CrIQW5L7CbySQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hX1Egv9KWc67xXf8R/Zi5rAqHAqZ9jJLl88FM1/ygkc=;
 b=AhTXGoiOfK5CdZQhRsm7VO8rA+HuhZNQJZHB5+XdssT1dbD/pDlVs4YRPqxugPg8Eh7uF/xfgsAc/iOSR3/gEgsQyex3osO2HCxfPj5Akd+546vuq3LQ477JX9d3JrSb4QbrrYd3oiCva5MkI3maRVgcT6AqTk7L55DddaFx8Xdw9XWf5mPnoMM0o6I116TEIdbEandbAFWkcbGLLgB3A6b0R/uVtL/V/Na5ts9IQ2rC7K0M7Ynhu0HkOvth7UEIf/v/dMKPBUwnJAp+ELMZ9hBPLoHz+ThqowSLhO8qO9Z9/cqDoqzmMhmfmSt95rfD+3geeEOymrRe1Pm9CHlwzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=riken.jp; dmarc=pass action=none header.from=riken.jp;
 dkim=pass header.d=riken.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=riken.jp; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hX1Egv9KWc67xXf8R/Zi5rAqHAqZ9jJLl88FM1/ygkc=;
 b=QFa+EgXUjSWIiOapD9Ru8gmnLhC7nOkIWRXuA6GPzv81+v0Ke91N8r+zxoJuIYIOAN98g20xJ3cdM7aQ6+VGX5sNJO08jjyZEdfPCdpQVJ29BgU/tZS4VItvyzc6TSmBUNDNs+/Bg1Za0PRYXyX2ed4YoGhpSaRMmz7gPjL3pOcyrgrw6yJ1xyXabpKlm/OAGWdf4/IDlr+Y/B5ikEjVDePmBgCul/RIoKJYBzbOUree/VsRyJTVwZc0A3+JDEnNEogMXyoX0WUlm15A4s0g7TV789OB4prNrtFFGpPJ9uu0S6wA4HEqTZbY0x8Wyg61Bf2XfcHUKKW2DQayIXdgbQ==
Received: from OS3P286MB2343.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:152::9)
 by TYCP286MB1779.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:11c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 00:27:55 +0000
Received: from OS3P286MB2343.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2d8:700a:54b5:baa4]) by OS3P286MB2343.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2d8:700a:54b5:baa4%7]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 00:27:55 +0000
From:   Kento Sato <kento.sato@riken.jp>
To:     "linux-kernel+unsubscribe@vger.kernel.org" 
        <linux-kernel+unsubscribe@vger.kernel.org>,
        "virtualization+unsubscribe@lists.linux.dev" 
        <virtualization+unsubscribe@lists.linux.dev>,
        "x86+unsubscribe@kernel.org" <x86+unsubscribe@kernel.org>,
        "dri-devel+unsubscribe@lists.freedesktop.org" 
        <dri-devel+unsubscribe@lists.freedesktop.org>,
        "netdev+unsubscribe@vger.kernel.org" 
        <netdev+unsubscribe@vger.kernel.org>,
        "linux-input+unsubscribe@vger.kernel.org" 
        <linux-input+unsubscribe@vger.kernel.org>
Subject: 
Thread-Index: AQHaHaPn4bLhpsrXekOkldnCBKbPqA==
Date:   Thu, 23 Nov 2023 00:27:55 +0000
Message-ID: <83EE21F2-F177-4DEB-886D-466FF84810B2@riken.jp>
Accept-Language: en-US, ja-JP
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=riken.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3P286MB2343:EE_|TYCP286MB1779:EE_
x-ms-office365-filtering-correlation-id: d4c1ba39-9e0e-45fb-560d-08dbebbb099c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ochB0lmjP4glszzBEgg6JRWY1JWx42ZbMXByUKItTQYHjRXq0TMhLLVkDhX+nKTjV+FnaDoQLWFGF0HWi+dXkvES1S2dOkGZnJYeUgbW/FmBYM5SNMPed9JLnvovbsgSPeB+Jw8J6qlL+wZFPwThKmA5wpG+lGbtPu597ndz7HDrwmkWA9U0566MLiBGqeeLgTrKYVS0WONaxPoeD1J/zuMgUEPX9ivBmQeaDZ+tQt30PjGoBgLzJNi7wgamJyhnGm1Azj35nFbd67Mmm7vYtLYgrqSzqQVCgaZyzoRgWWiwOX8xJSrTT/iApRtoxwKjVL8+NGY1MvGLNH/adhO7R297DOBGwkBAT2JwH5zCbBKKlJ345NVv8ucYku2+pPslCCnwXZVBP47uNDF99otYfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB2343.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(39860400002)(366004)(309900001)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(8936002)(4270600006)(2906002)(110136005)(6512007)(44832011)(6486002)(33656002)(316002)(26005)(86362001)(64756008)(6506007)(66446008)(66946007)(36756003)(2616005)(66476007)(66556008)(73894004)(621065003)(76116006)(91956017)(71200400001)(41300700001)(38100700002)(38070700009)(99936003)(478600001)(122000001)(5406001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rjz89YjTjQirlRiSJ8RSaMtXDRq2bGd0Q8LmD8BfeQH7Qt76JT3vb/Jfpfh7?=
 =?us-ascii?Q?XV9+MB3YnBxfn7PDxt+1CGsm+0czk1dnqV0Fois01I4O9+TGZXoWARA7LNiO?=
 =?us-ascii?Q?AF47Oe4Y/Pkbeq0d47zBvnDc4p+8S0ntyPtb8GDRUss6nKLRMC7XF1T5329U?=
 =?us-ascii?Q?LXHYgwsaKKY7rK6N/icbFBB5r76WfJSsnajjAhY5qCt/gBuUZuVHSq9ZsKt3?=
 =?us-ascii?Q?Be7naO+t6YfWY9FmyrsFgjh8oaQOIeD2/9cYb2Kg4jmyDNWJ5wSwkgPloBPo?=
 =?us-ascii?Q?1V+TRUnHZa0YvUKEiq1FlZCUHCTorCDT7CGflCmsHPsy86efx1wkF4tqm9ub?=
 =?us-ascii?Q?R5niWaZyVT3B5XEhHFgFcXw7YzIdgIT5kwblSbo2/OhpEm7v2i3VnzD18M+y?=
 =?us-ascii?Q?my54pSTPnMi1oOlp3XILn1XbHY4sZ4v1qWt5WQs/4Nhz4T/IC0nLqBoUdmaB?=
 =?us-ascii?Q?KHvcqJSF82pKM9//9k8sHaxC4sOBxGFbvDe3yFb5zQFjfsC/hvT+qkiuUvg4?=
 =?us-ascii?Q?u2jdYb4O9urX8gmn45HeRnLDPYDj4GW7kMnx7skiO7kwYHW9THLT0mu5ZLa/?=
 =?us-ascii?Q?PsmNGEGrTMc5PcPNAJVICL0EemRb849QZW6vd9NkUnTfQ1OoBQ0DKIVx/QUx?=
 =?us-ascii?Q?EVaCPjLE18yG5QOyV33/qNr0YN5OOxivykVYFmGfCmoo0GfoVVfG7w7soBpa?=
 =?us-ascii?Q?WhCKrPvDH8MxPq5Lk6ssdQ7bLaJ8Yv3Z0qz/ExTsdfjRm/qPWAJtGK3AGY6s?=
 =?us-ascii?Q?HfA+0ELf7D8DSa0iCFOq/YWGNWsKdbe5gpRh8WUaFzUj2M4WG7KE2kkpQAXC?=
 =?us-ascii?Q?Puxkh5BhXxdFbKz9Td3DFFxL1Es32oUdg4EJQe5uSwLLLahmNdJb74s1Mj/Q?=
 =?us-ascii?Q?cnGvCw1YvIEd/97HHS2JnkrXEScVJnhe8ZHYXYp+a4W0evtQemThHtGFdf9T?=
 =?us-ascii?Q?7DHYANfnlJL0cP3EedOXKm7vQFECkQ4Fl+ReR5rS8FcI5WGdLdhWjuSRyGfo?=
 =?us-ascii?Q?3icAEJPFJMtxq6y4yfjW9vogz0L+0tDVcxKYvbQlGvNyIchCRD8uixPcG4e2?=
 =?us-ascii?Q?FgBTzQMgexPA/e8nVWHZR+uVCCM4PHetqnYJpZjtLleaxWOP4pjj/BxLFKbT?=
 =?us-ascii?Q?ovedWV7I4mPKk1lprxo9DoclTvWoxLDXt5g4QJ1iSK2m24CdmTYbwdGeHdRy?=
 =?us-ascii?Q?Ju2uwgwqFLk5RqWl/ia1+jcPiA0oP7UJ7x3FiQsAejiSxw6DGBrs/nWFbuJR?=
 =?us-ascii?Q?U7opf36odFp5dT/06KNpqqH8VLuoCTXTYQIk4tpyhxbIHCwoWmAhQn2OEqrg?=
 =?us-ascii?Q?uxltAuden6Iqci8lT3eYz8NUAt1ql7E/aL7s8Xk8D6ylWncB4Bdzc042eeqp?=
 =?us-ascii?Q?Ye5XX2ejEsIKgCWnALWxF9kCTF2Ssi+juH/+WzDqDP4mw2gh0tN8xRAuNTOj?=
 =?us-ascii?Q?21clhvC4XF8ssbEiJHnKDlgUPrgPi1w3eR/YhNU6LGuHKy5ezkNMXhnYK8KL?=
 =?us-ascii?Q?wkdKg3a/YwnfM/A7bE/WWOVN1eueHnkHp/K2rRmggX/m5yxQZ1qVNBza95hG?=
 =?us-ascii?Q?c6vYIhnWUS1cNKEVREihZKrACrYj7fDH6CR7q0Kw2ljAO0+/SGxI83sbkOZE?=
 =?us-ascii?Q?7w=3D=3D?=
Content-Type: multipart/signed;
        boundary="Apple-Mail=_5656FD09-228A-4935-9E58-178B94413A3F";
        protocol="application/pkcs7-signature";
        micalg=sha-256
MIME-Version: 1.0
X-OriginatorOrg: riken.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB2343.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c1ba39-9e0e-45fb-560d-08dbebbb099c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2023 00:27:55.5331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fce8b959-27d5-4b4e-a4e9-1014a2f95c90
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jmtgSCazrtAe+m44tUsAFUxABZUu0u8hgW6x/AmYeLsDiVYc0gTf3qRTmn7f3RKNQ7gyKmlp8bnn2lzqRX2exg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1779
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,SUSPICIOUS_RECIPS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_5656FD09-228A-4935-9E58-178B94413A3F
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii



--Apple-Mail=_5656FD09-228A-4935-9E58-178B94413A3F
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

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

--Apple-Mail=_5656FD09-228A-4935-9E58-178B94413A3F--
