Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D77A7F173D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbjKTPZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbjKTPZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:25:51 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2135.outbound.protection.outlook.com [40.107.22.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0131DBE;
        Mon, 20 Nov 2023 07:25:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGYssHpliU+e3fL3RutwgpOgVIx6n3vEQHOX+rQiCqh5Xcd/IX533GxCV3Mo5W0yq8hFVC1KVOzfKp++XwTosc8sKZYh1YTz3i/kY9fBhtQ/ABxNMobTFBWpK2QRRDhPypWOEnY1JTHY4WZE3ZK1OaSA4miSJAse0nkt5gYwn/Rl3R727sW7PKfh0wBK2bfHLCZkjtlHCDyn4apnukyprz1D7eHNWz3b9UWRIgFdVwBUDB3rpo/C//YNEwCncOwscLpCT71Y8BrNEyG6jKpk55a4DdRIN0d3C7+YXs7rfOz8c7zkAlVGG29JzulgD27W0mOGT83ZKlvt1gu/2bQUXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=586KetFGvi4d1ofIQ3K5DD7/FW3WXxMjEthdMwTG0e0=;
 b=nFuw17Sr0T6jWbEWAcNfbQn7jjlSCp0G1VEPqt+hu3EWhh8k1Sj9BGwjWNWI8bgT5EqmNwGSdVzX3i/12/BbZDNigoaVUT2j8+N3Ejrj/0s62G5peKdQvMm3wRBBwWGJ6kdQ7H0c2H/QMPUPslq3GguUYi6ikZT8w8YXx2vyJ4iBbtPaeqbySrDuilr2uyolR05DoZnIb+keBaC7QmfJENiSrGM3cm5pJbjOwOT8YWTHVKrKdGBaaMeUeBVWHI4Br6pNAiM4JUBQWma6wRdIC8+p9MpIY8ulZd/N4bM2ZSJLcBtP8uzbefWWWJ+oEo0XXpuT+o7AiZBglUywglwFDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom-usa.com; dmarc=pass action=none
 header.from=silicom-usa.com; dkim=pass header.d=silicom-usa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=586KetFGvi4d1ofIQ3K5DD7/FW3WXxMjEthdMwTG0e0=;
 b=TxwWM9p7byIJ8YcJoWJBQEPe3FTJ25zi7z7jiNfm6N3gh0qvQD28OjosDHqwv35K8apEwSU3SSxRe3Vd+YbDrHNod6jjWmMlzEZLlwuVH4dTU2rTp0c1I6W63jMcCBh+b6B3hOaI9KGcvb5pAgRRlcddKMHY35hYVtAm7zufHU0=
Received: from PA4PR04MB9222.eurprd04.prod.outlook.com (2603:10a6:102:2a1::18)
 by DB9PR04MB9329.eurprd04.prod.outlook.com (2603:10a6:10:36f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Mon, 20 Nov
 2023 15:25:44 +0000
Received: from PA4PR04MB9222.eurprd04.prod.outlook.com
 ([fe80::fdd9:46:1ee:6f4]) by PA4PR04MB9222.eurprd04.prod.outlook.com
 ([fe80::fdd9:46:1ee:6f4%2]) with mapi id 15.20.7025.014; Mon, 20 Nov 2023
 15:25:44 +0000
From:   Huibin Shi <henrys@silicom-usa.com>
To:     =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Henry Shi <henryshi2018@gmail.com>
CC:     "hbshi69@hotmail.com" <hbshi69@hotmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "hb_shi2003@yahoo.com" <hb_shi2003@yahoo.com>,
        Wen Wang <wenw@silicom-usa.com>
Subject: RE: [PATCH v13] platform/x86: Add Silicom Platform Driver
Thread-Topic: [PATCH v13] platform/x86: Add Silicom Platform Driver
Thread-Index: AQHaGjzQKTGu1aiRwU2iKK6v6UoxVbCDGwqAgAAluDA=
Date:   Mon, 20 Nov 2023 15:25:44 +0000
Message-ID: <PA4PR04MB92222C42B50F1F088C5AEB569AB4A@PA4PR04MB9222.eurprd04.prod.outlook.com>
References: <20231118163214.27937-1-henryshi2018@gmail.com>
 <17e30d-4477-2fed-3ea6-e6dbad98644@linux.intel.com>
In-Reply-To: <17e30d-4477-2fed-3ea6-e6dbad98644@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silicom-usa.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9222:EE_|DB9PR04MB9329:EE_
x-ms-office365-filtering-correlation-id: 96dd7338-bf9d-45e1-d021-08dbe9dcf6b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PcNgsIbiXwudwXi1C8st9wh34tNIG5bwXd+X/9Xv+cuW5ULwTd0sK3Iwf5E1JfF6/VWglSZuNTpwtLoJSfyjUEp0GAe2tRCTvDDUVVc0L10bx4188fUrl9aCm3n4TR7095rYVqfoafC5EvjESZi7mA3xB1u6yxt34ggpXCqJQYeJEob5LOU3odkEhQ531rCpa54HPwYxW3sONap/cz14kkpmgR8mJ3bzrlP3YeGQD66tN6UYzzLJpdZH97CRQ00gSAmnuCdjEImSC2saddEaLp5JtySyDgOr81PcIBB4nBRBXuc9jhdNAcaPCW+4YdOQLQA/H+ZVhWXJlPyc6JnQfTD1j08vdk33XMhDOEpCOa1wK3/etQsA4A5AXb0KiWAWVa5heasl1NUW4ZIw5pWjyOAE/Biza0NKhL/Arkg0rjUNmsL3VTMM5XUVeafUG8UWP31m/8bkD9rs7jgqYPimVYG+/dw8//P/26v3B6O4dsqMEWSpTzGSz6Qb+qa+DmBrrrO+PNkiraDAv7D7UjMN0ZtwXbx0x/yACkIPL5eYXVTNm6bPjcWkdeHt3a/x5FGyCixFB3DWDkGo8zCq+0qO4pbnrXpYtms0i44p5WVXvso=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9222.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39850400004)(136003)(346002)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(5660300002)(86362001)(7416002)(2906002)(54906003)(64756008)(66446008)(66946007)(316002)(66556008)(66476007)(76116006)(110136005)(4326008)(8936002)(8676002)(52536014)(38070700009)(33656002)(41300700001)(9686003)(55016003)(83380400001)(122000001)(478600001)(6506007)(7696005)(71200400001)(107886003)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?S+H7aI9WIhsoAbgFy1hYFk2fAuN2i3VvumZVSm6251LNnRcQ9oKfTKFXV8?=
 =?iso-8859-1?Q?GnY+A30+KkY/9Q8QNzqz4O19ugQwxgso45N/iggh8CrFB2M4d+a5QBNCPo?=
 =?iso-8859-1?Q?wUmu7IBDFjM6P0XsvO7WLm1gC18XCHYTMDt9sW7FDqbpFLq1GmogMu/NcE?=
 =?iso-8859-1?Q?mdGbj1ug/3/frnYtsG7Lz8XmZ3/59YDmXcjb3bS2bDGesSVBEKTwUnh41K?=
 =?iso-8859-1?Q?VHK5VFKF7LfOxVG56OsfeB+/FnKtd/n4Omtinb95wjRi160eOr9jvUSd9Q?=
 =?iso-8859-1?Q?B/HVHDf3ZoJkTrBD1VcLKVYEQusSHHEz8PCkYj09TAA5FLlpQ2FgFMnN1I?=
 =?iso-8859-1?Q?m4y7oLaGlsYrJihNErj3le/aKfZXSiyamwwiNXnxHI4kFUGEAPd7imFXDB?=
 =?iso-8859-1?Q?IO+jYqltSExLP99Rk0dkze4OLVtU9JKIVWCTYK8nAC1580HjtrbilL5c3E?=
 =?iso-8859-1?Q?odEOS6yQjNElqOlk9JBggPltRyGOerztZRj03D1LP9V0WbklkrV34HRt0M?=
 =?iso-8859-1?Q?0TSI5oz5a2CYNszX+2MzKV+dOHyml7gtkemQCF4ZkYNuaV7Sj4sjiwismX?=
 =?iso-8859-1?Q?I++bswfPJ3yooqpiTKIA3G3Mv5Cq/s1Yd9KRkjDT7tqijIeXFDK16NbbFu?=
 =?iso-8859-1?Q?3jhOzipV2RfpNjODKIRww9S2ywesIrhb88Pp5mwRd4t0AmGewrtpyoNNhf?=
 =?iso-8859-1?Q?nrf0RNxJPgyzptKGQKXKO2TZGNPw5Ey5BlQ53N3PUvbad9MjdinEu4jfGi?=
 =?iso-8859-1?Q?68P3iKZk1eajzpGKN+ow1sYb08IMWGEN+xa7dA1rvLmDFoHoK2ETVXFIOG?=
 =?iso-8859-1?Q?lOSK09jBNWuoKSF4snh2JTDSXLY4PfrWHdcJZPnRNGLgC/ayhWwnxJ5ygi?=
 =?iso-8859-1?Q?ZxzN/mXEqXVdfszm08H3GNe0yFGAGp920I6LN2mgP2qLA99yDiB1ka9wrG?=
 =?iso-8859-1?Q?Mr/YXcdxhhPHprOqjazbtbFZWczruHp0078T4Z27FIxk4yi7AmnJmMzvkV?=
 =?iso-8859-1?Q?qNzRFaRbCM6afbwiGoXOm88Eqb1EakcFdNWFyt2bupiICWMbFRaaZO/lju?=
 =?iso-8859-1?Q?E9jqh6q40Ay3dWhlzuT8wIjIKLeWdzr0dIhxAIVhwq84qqABVmcl1+qT2G?=
 =?iso-8859-1?Q?mmEV6SvhIYLtjZ+qXVqeh+9D9xkh+PQE5oCgIVx5hRNZMB9dQHoYu8QAX/?=
 =?iso-8859-1?Q?dwlTRgtPCpnC8Q0u8MT2ElAnvkHvz7lVCAqRLtnun8n/E23Vd0p6uj7v51?=
 =?iso-8859-1?Q?v0k6ICVwRTxBOtDFdN/VGXf9MQmfuOyt+1s7XgHbQXmZNHgpn/45s35JnL?=
 =?iso-8859-1?Q?BC9TV/7jdmo/5OVZWWkJCIC+5IdGnp3vnVaAzOOGFbPBIL1PwZgi+zC9r0?=
 =?iso-8859-1?Q?MYp8DItWnMu9l71slbYtZetwqSZOmshplV/fHG0UEOrNq6zFrxYHgc9oba?=
 =?iso-8859-1?Q?Ho2ljdgpZ4AkqE1pBaMakUG1zmo9vf+Au895SDeJ7pkyvLGxFeQJ4J4dQP?=
 =?iso-8859-1?Q?iKNpA6oiZRr07sogMN0JTqzH6TrMRkduGfqz6sYiEH24oZmE51az7EPA+R?=
 =?iso-8859-1?Q?x3+jZ78+Vn86w+s5SZvK+Y+DNNklSg9GYovRtyMSxxnaSc/ox6e088rX+9?=
 =?iso-8859-1?Q?B3/BNsm2j33oFTHkT/+bBIjWDC7aSi3owVIg6HVNJ5Sy5PURuYuVt59XPd?=
 =?iso-8859-1?Q?HHurlZmLw+DF3KsNgL+UW+5L2Hv2F+QGKdGLQosV?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silicom-usa.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9222.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96dd7338-bf9d-45e1-d021-08dbe9dcf6b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 15:25:44.4095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LZK9wjvBnU+NjViubpGYmYgdnWNWM2L24D7u2u5gZ4EWn4k/u12TS5+DsVANZuycYspCVxTnLxrvVgGXPqrdGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9329
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ilpo,

Thanks for your comments. Regarding your comments:

> +               device. It returns to default value after power cycle.

to default value -> to 0

What actually sets power_cycle variable back to 0? I couldn't find such cod=
e.

Also, writing 1 and then 0 to sysfs power_cycle causes reads to return garb=
age unrelated to the whether there's power cycling currently going on or no=
t.

I think you should first parse the string to local variable in power_cycle_=
store(), after checking it's okay take the mutex, and only then update powe=
r_cycle variable.

Henry: According to hardware design of this board, when powercycle_uc() is =
called, it will cause the whole platform to go through a hard power cycle. =
So Linux system will restart and this driver will be re-installed. There is=
 no chance that power_cycle value will be read after powercycle_uc() is cal=
led. This is why I did not set "powey_cycle" variable value to 0 explicitly=
 in function power_cycle_store(). Maybe I need add comments to explain this=
 in function power_cycle_store(). Any suggestion on this?

Thanks
Henry

