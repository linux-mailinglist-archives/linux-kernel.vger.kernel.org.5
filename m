Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C078D7A41A1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 08:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239963AbjIRG5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 02:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239932AbjIRG4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 02:56:42 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2160.outbound.protection.outlook.com [40.92.63.160])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B04F3;
        Sun, 17 Sep 2023 23:56:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBWjFif+pjQApDNm1UpMdOiFfAO69ZWu045GIrmoY4FFxakILjok9XpXE5a7C/LdTka/zh6bRgQWJ6rqcWc/nsenye7+kuYW5U8hDnkQ8GUI5Nwz/Ve2E1jBzGYUwoc+9B/C8ExuO7AgrlOreLyQ3RmpDDib86hlDYi8S3hg2djW1jgp+HsOXanvdBdw/e/zoDuvFSSWHqmiRTvxrKg8pAqFaskwu4Fr2Nk8oWtyflya9LVXTFaaBKnXz8IWsGXB3Eu1jb+RokbgMXw6DW97FJiJZLYNWRZedLILFO5WxXsZk/+kZAMsf7SeVHKjky+pd6Mo84ER0gGOWD7EcBgXqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPOhMrUTw8S/D9noVsZuz8HvstoI4IL9FecHvmZI6oU=;
 b=TJAmaoYGuH4/T2lAuGYWx8t3jc8KT2ZRMALyq1DU+0IR2JCf2ClT5spI/OjHUh2g/N17tuImlVB0HuTvYamMwzFmFjxZr0wWs5Coh6WYKz/o8NKlVqtTyiyTUs1i1i1lK88T0YDGWijLQj7P5BuYKIQRPEpl7zcSIFk0d5ydzQTcaXn6Gxsi30pebBFz6cmnaxrkX1n6Ad7ZFw0PjKE1LWKfpybFhyLv39IPoEdnorx9qb3bUnkrxcOUil2R3NafZ/+r7BLzWI/r0OeSiRk6g/L3NHpSaDJy1eOuuDRsGtmHkvvRP7GcgPJUJRvkND0IJpYekFoXrt/d1XwOMqnsGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPOhMrUTw8S/D9noVsZuz8HvstoI4IL9FecHvmZI6oU=;
 b=b5i1cbPSPWk0Vkcjq/Z0oV9kkyISAN3KEi8ilTsNDZFlZgSJqAn6l+6ygUVvNjuJNpLHpK3kIRdSr/FOlVuq48vk3T3G2prTT9sqE0y0KY+lJ+eMwttOafleTzF8teDSeEAnaG1ZQBenrexnA1Djr+BL7G10YX1cGzDz39j8bHA5MOSEOxz6ylKgCrg0e2qrsRUsBq/EMRFJqUEnLu09xdv97kLoQNoNDaJSG+7rp0bth4EKyPnC2+caoH0qgg8SUrP0/GTZEyGijJwEWPtri47M+QZaOe6Cz5QgHe2fn+6nS7c9Mil9XVuRlyhhbZ0LIK+TGgziHwq3Ot6MLRqdzA==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SYBP282MB2617.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:128::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Mon, 18 Sep
 2023 06:56:26 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::9ab5:8709:b0ff:ade1]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::9ab5:8709:b0ff:ade1%4]) with mapi id 15.20.6792.020; Mon, 18 Sep 2023
 06:56:26 +0000
From:   "SongJinJian@hotmail.com" <SongJinJian@hotmail.com>
To:     Jiri Pirko <jiri@resnulli.us>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "loic.poulain@linaro.org" <loic.poulain@linaro.org>,
        "ryazanov.s.a@gmail.com" <ryazanov.s.a@gmail.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "chandrashekar.devegowda@intel.com" 
        <chandrashekar.devegowda@intel.com>,
        "linuxwwan@intel.com" <linuxwwan@intel.com>,
        "chiranjeevi.rapolu@linux.intel.com" 
        <chiranjeevi.rapolu@linux.intel.com>,
        "haijun.liu@mediatek.com" <haijun.liu@mediatek.com>,
        "m.chetan.kumar@linux.intel.com" <m.chetan.kumar@linux.intel.com>,
        "ricardo.martinez@linux.intel.com" <ricardo.martinez@linux.intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nmarupaka@google.com" <nmarupaka@google.com>,
        "vsankar@lenovo.com" <vsankar@lenovo.com>,
        "danielwinkler@google.com" <danielwinkler@google.com>
Subject: RE: [net-next v4 0/5] net: wwan: t7xx: fw flashing & coredump support
Thread-Topic: [net-next v4 0/5] net: wwan: t7xx: fw flashing & coredump
 support
Thread-Index: Adnp+oTwuzOkM6dYQWOPIN479eLIVw==
Date:   Mon, 18 Sep 2023 06:56:26 +0000
Message-ID: <MEYP282MB2697B33940B6E9F3BA802729BBFBA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [d5rNtAB6SfKHi6rrV5eRtA4MnNcFi5IU]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MEYP282MB2697:EE_|SYBP282MB2617:EE_
x-ms-office365-filtering-correlation-id: 97beed9f-f758-4be3-7229-08dbb81460e4
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6TYeB4qJfql4OFZXCsEJoVIgC1xme31nqxnWS5GV5moe02IR5DK9D72hh9LSrKsO8XZxYnpVrn0L7cqktZxFR0nUkQ593NnLVClp/OfcjjzELDRRIxpPYBbzpMHqiVR1+mB3xkDl/PsUd1OhmoSBEcUhXd75IweqxJiowBPjh5d/T2TvYAceAd7tivN//wPyIB86mkEx1BYsklry0p4ViXWrjf02SfEpaZCspZGD/5iLAWrzu0MfTGIMu7T72nuTTtv1WW4j+Uhl/419Z+MkOdqr5/WFQehEQ7mjTq2sA9V3FqsBsiYLeusFoz5Q1UOMTShyQcbQs/YSuFe9VMoSoyaJj216VGNBU+suyLQV7PdGrdGSj1kiDi+Ga9qQfKvXgrZpiHWkYepdc3Jf8tXK6Z4znG4WDCQfo2KPVd4EdnsFn5gvHSgKFpiNJ+UDzpc9esc+TJCpm9K9x+l15zWnaGSVFN3KR5wsCiSqhbuAKphwi8Ms18X0rlT7z+LPrBBRBaIxeXLaqeMaML1Fuf1dJAmHZD3NU+8zoASwaAcfEx9IM3KXWtLC2GFCtdqcZWUUIN86SrOhb+4rIVWdeUpDiSekEXTDtHMnSOoO0Mx7WmI=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CphVz4XvS7f1OC/47JSSgmC8lIHu6O1AuzNpAMdvvKLrIZR+C4cWHJ8k5LmG?=
 =?us-ascii?Q?aPFZevUJOAZI1OiId37ixylgnhmO9RE9K9S+rIDPyzTTxOLel42cLRS6Hr4z?=
 =?us-ascii?Q?x7GV0Niyxfz+c2FTbhX2Rq+7YZsReMXVkfdVMG9xEDg24bywKRTDOUK6OipZ?=
 =?us-ascii?Q?p1kp2Dg6zBanCpOzEHyhM+eFw8Bxi+x+uTYRNN1zvaEgXFIGAWm0Z8jKt5v4?=
 =?us-ascii?Q?SUTT/Rw9me58neVwqfxDxJ++oAk9OojOVO3m64mxYfaY0hpqxJPkUiXhwobA?=
 =?us-ascii?Q?kJH2vyQm8ei56XuHf+A/hp/bOifIVdwE/8p1IPxp7MeX+IWV7bgsZJRARva+?=
 =?us-ascii?Q?ztA4IP6zqO8PBBZ3NGMQgM78nITm+XdCCX57uAZ7CtBViUbiYUhPQUimF8zg?=
 =?us-ascii?Q?+EZYWv+8NGs4IhOmkV9YAw1ZyZ+HOx0a2PwlRLczoaN7PAt8/NSDkUu5TRZ1?=
 =?us-ascii?Q?6Ddo8fHe0Jjwr/RPpBhWUJ0IkMc0MmmdwY+UkC/6XXFIv46PcxwSjgn7dNGs?=
 =?us-ascii?Q?KXY0QzXQBXV0zqvw669oI8P/w+TcODblfgDEwYeE4FpfTN0XkBNFPUPxYRxo?=
 =?us-ascii?Q?sSQ8I+wCy1lyW0V/O6T2PxPuAPdzCGaRRc5IXsyp8ajV7xarGTNLcNxu8Oy/?=
 =?us-ascii?Q?vZiTABUuaYP2sQEZ5hRG3Snopg+VPDIvBDk6w+wFJ3rqd24uz/rXGb9nj36j?=
 =?us-ascii?Q?3PIfaULknfTraXxQ+dZJuqhlsvKWxVqsDE2wqpDDpHQuG4+puuJyVptBJF+j?=
 =?us-ascii?Q?OWbJYgiLSCo6fi+PxeCH6GOTGidVsPzrpAZ5YR5vM57SgnTJmH7C/QzLR12x?=
 =?us-ascii?Q?/mIuA+uSXTnUhcBF4gt8Z6T1c8HhaXPvIuUcuBVP+1crOAOXfBs4ur9Ya8lC?=
 =?us-ascii?Q?26hp4VejcqIlcDvoYXcBIpcPejepvuOFfHa38+GJ1GVxnJbKPug/Ge6gOhC2?=
 =?us-ascii?Q?uIMcY82QfFiVyenEqdbrC1006+fVXOppC42S7jl2nOUb2Xo2m+yCCyam+4yM?=
 =?us-ascii?Q?/0nbvEG0gfzxRJWnbd9cGvXjdTZlY4Sx9dZ2ZniIfiUfyspYNNOUf38tmGTD?=
 =?us-ascii?Q?e9iPKEwRMC3meE0Up1R7p7F7sSyU1mqH3NgMEHs2Ikd/sxwPkVyE/faevgGt?=
 =?us-ascii?Q?0WTWasuElmRP0lbe5dRlVo3pAdL8GR9Z0eIXutpf98npx4lVcwSPVyNGOa8X?=
 =?us-ascii?Q?UXkV/H+K38/7HsAeZQAWjXpjk+dY6TO2rF6s3A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 97beed9f-f758-4be3-7229-08dbb81460e4
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 06:56:26.6937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBP282MB2617
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Sep 12, 2023 at 11:48:40AM CEST, songjinjian@hotmail.com wrote:
>>Adds support for t7xx wwan device firmware flashing & coredump=20
>>collection using devlink.

>I don't believe that use of devlink is correct here. It seems like a misfi=
t. IIUC, what you need is to communicate with the modem. Basically a commun=
ication channel to modem. The other wwan drivers implement these channels i=
n _ctrl.c files, using multiple protocols. Why can't you do something simil=
ar and let devlink out of this please?

>Until you put in arguments why you really need devlink and why is it a goo=
d fit, I'm against this. Please don't send any other versions of this patch=
set that use devlink.

 Yes, t7xx driver need communicate with modem with a communication channel =
to modem.=20
 I took a look at the _ctrl.c files under wwan directory, it seemed the imp=
lementation can be well integrated with QualCommon's modem, if we do like t=
his, I think we need modem firmware change, maybe not be suitable for curre=
nt MTK modem directly.
 Except for Qualcomm modem driver, there is also an Intel wwan driver 'iosm=
' and it use devlink to implement firmware flash(https://www.kernel.org/doc=
/html/latest/networking/devlink/iosm.html), Intel and MTK design and use de=
vlink to do this work on
 'mtk_t7xx' driver and I continue to do this work.

 I think devlink framework can support this scene and if we use devlink we =
don't need to develop other flash tools or other user space applications, u=
se upstream devlink commands directly.=20
=20
 Thanks.
>NACK.
