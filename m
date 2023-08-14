Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826E877B30B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbjHNHxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 03:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233924AbjHNHxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:53:23 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D889F;
        Mon, 14 Aug 2023 00:53:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJCY8GGp76jlTccEnQvI0n3j9TBoL6DejydBleJ4BuNWSw/usSyJ+C88dAxjabZbTuqjRd+a23Ufmx/vzPzHNxrSZoRhRhF6lPHl98U3YUVzpAvS5CfUEGdinV4nXg3RbGpiuOCpICHpTyTwCr+1tjvErnMcFwweaBSjFp/h8/0epX/DmMcTdE6CNYd6ywhHIvP853kHbor+eXAh6c7uX4r27gSJkZPKdPEi/wrgMJOxQTigqGJ5aOJAOj4Nl+TgHNfuWYUJB+HzpDX9KhTsuxmqisTbWCE+HVgQnm30OrU1O9OZr8V7OkdmFQacDRzCh5m3wju6VSY6SQ+Z5XS6RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfDt2NrruriqBaJ1ua2ubIf/j14sy39PZBDO4HDMc7c=;
 b=BH58dcrNfLIPAqb9mNz6pd7GovWVojKq8ZeY5FdNk+xspQELr8d//i/sMXljRFeydf0e/EIdrDW2MfkKyF3xYm1ZZP22FS4VCazknhbWxxkq7Uf/5k5wr1CCggaqVifcJB2gRrJG7VqNmA8l0Mxk774VrLuxYDFH5Y75OSVfhwc0ixu/U7KrY8ZSYVDv9yrc7kSV0EEeb76WkoKOJsCvuSTJWAUxggdYvY+STwbyvrcZrBpqq81AJnyVD0QiSaAiU8UmzVZjdrjOK2fdUEH0YWKPCn6MlzTQPsEiWYpUqod5Bs7L0ihHa99OrTv2H+MFR8YFhA0EvRDIGQBJzwdiEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfDt2NrruriqBaJ1ua2ubIf/j14sy39PZBDO4HDMc7c=;
 b=h0pBAJr9j0lO0VsW38xpqMF2ytl145sCGyG4PFGOyDApKom1gMcOoT1MC5KMtdWSGeGpugYoLtKzMtaAXM54ig9QhqcXo2EjCG7e7nC5ObrXoFda4a8U5eVYAI85zesZKAloffxH0a7m6Kg2kxM1A9Ey6X6NziJvuz9dDmMMHyo=
Received: from AM9PR04MB8211.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::17)
 by DB8PR04MB7081.eurprd04.prod.outlook.com (2603:10a6:10:fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 07:53:07 +0000
Received: from AM9PR04MB8211.eurprd04.prod.outlook.com
 ([fe80::3df9:f31a:be7f:4b97]) by AM9PR04MB8211.eurprd04.prod.outlook.com
 ([fe80::3df9:f31a:be7f:4b97%4]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 07:53:07 +0000
From:   Varun Sethi <V.Sethi@nxp.com>
To:     Pankaj Gupta <pankaj.gupta@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "clin@suse.com" <clin@suse.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "pierre.gondois@arm.com" <pierre.gondois@arm.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Wei Fang <wei.fang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Bough Chen <haibo.chen@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        Sahil Malhotra <sahil.malhotra@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: [PATCH v4 6/7] firmware: imx: add driver for NXP EdgeLock Enclave
Thread-Topic: [PATCH v4 6/7] firmware: imx: add driver for NXP EdgeLock
 Enclave
Thread-Index: AQHZtLpKAfPHv7WBBUqYX9KZenNkwK/pkDEAgAAMhHA=
Date:   Mon, 14 Aug 2023 07:53:07 +0000
Message-ID: <AM9PR04MB82112F4929914E5DD241B818E817A@AM9PR04MB8211.eurprd04.prod.outlook.com>
References: <20230712121219.2654234-1-pankaj.gupta@nxp.com>
 <20230712121219.2654234-7-pankaj.gupta@nxp.com>
 <DU2PR04MB8630694397EEE3275F01A4E59517A@DU2PR04MB8630.eurprd04.prod.outlook.com>
In-Reply-To: <DU2PR04MB8630694397EEE3275F01A4E59517A@DU2PR04MB8630.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8211:EE_|DB8PR04MB7081:EE_
x-ms-office365-filtering-correlation-id: c62b79e9-bd93-42f0-2f51-08db9c9b7f67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /gmkGlpi1mcOMXRSa6PBf5jm+EEa2Cug0XQkAelENHUjm88Q3HNanhVhDQvKTyVWBDwD1ILpPM0dl8cfhFKVhp0fbriaWA/pqXHyjeLG71CPzrpKHVyhSXbkCAtvT5vh+/H2syfw8+t+uTx+2QflvC2h76o6NhpqnrasIar6ABG/QfftAKyqvfir2vi5W0RNTUaCg1xuqWhjlsyX8QbCJ9svygc33shzpOmRA38P8BmCvn+MbFJipXhdyfphf0tXxKW+zf+6XZJfnGz+9rowhlpswiKPwhlpvwUbhFSCoh3dxtZR+LjV6GrmmQRqdvzK+rDJqhtuy8FUBlhzcg8+0Fn6FYbNaLiT7KfdnOzFl1tHsSfkk6XdSK9/9zmmoXFhf5iVpN+S9NcHfGlsfwsuKb5+TOvI3PIk046L2HxB1j7g9Ke+QkfDRQUB2mDWjPN3U7I4pX9rgCz3fWAORN56ZyXTMHWz1wkoPQmHcRbdHdQf51dn0EoZYB6SALPriKlfgNsQSfJ+POdK4poUJwZdyHJHyT/vbcAUR9NWagW16VqrnH4OmVHuAY7E7xtunE335BcW8A53bt9yl7pEevZlfCeYP4/Kf1+xXku2paOhaZfa3JqsOsJln78GPf9FB+POeODvtV5HzhcuWU33IIIVJw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8211.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(396003)(366004)(39860400002)(1800799006)(186006)(451199021)(478600001)(71200400001)(110136005)(76116006)(6506007)(7696005)(26005)(53546011)(9686003)(66946007)(2906002)(55016003)(7416002)(41300700001)(8936002)(8676002)(66556008)(66476007)(66446008)(64756008)(6636002)(316002)(30864003)(52536014)(5660300002)(38100700002)(38070700005)(122000001)(921005)(99936003)(86362001)(33656002)(83380400001)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eMvPS0eCtuallpKuYhM2iDsWLaYOq0xzqneDaq85MYbzZbkrHmNvZWTPQvD1?=
 =?us-ascii?Q?mMQRPcErpcrY+CEbSnSWX/GYKRuftsK4cID/DxO8Qyf3qzwSwLpqrfC8dgLW?=
 =?us-ascii?Q?AnkcxAJ2VSOYQOangc6BkXWhLOFt2URDBRkUvoqb7X8+iQj2jHLh60LWgkem?=
 =?us-ascii?Q?enoI6DOdsaiQRzaWIbvEFk2okHNVqE1Hf4c2wwkuRfOwKHymUWP77b4+nFL7?=
 =?us-ascii?Q?53sRsyDwnTcYLvE0LBOVKRnyRMHoSgQkopsAv2jEJeIsKQikTVbTAFPlYmDY?=
 =?us-ascii?Q?voxjk74jnCt5/xd6/wIENxbbrF6Z8noIZIiN5YOuyQHNEdETBa0oY4essVZz?=
 =?us-ascii?Q?PLiuqTiO5oNo9aA3qKtflzmmWEKkfh5t8BdxfTXDkDVJzFFH1AI3JK3pTDTO?=
 =?us-ascii?Q?DD/AtYo0NGAR+PRm5n8piwKUcGR3cFCbrhfLn9XII60Sd3doBb+db+uhCoFL?=
 =?us-ascii?Q?Y7kyHgw6KgM3s75Q1hLCD888mDojkh38G+TdT5m9qC76a4UUGFGkGJ7Hun3B?=
 =?us-ascii?Q?ER8n5woRemIUIg3IC8guIo+k9a0G+JZTi32LoID4orkBXv6ltUqCpXvZFco5?=
 =?us-ascii?Q?nZBaOV6JVP83d3/T+AifV1w9oBtGvLBJo6qiIiNtzuDp8/0EWVsl0BXQYVJT?=
 =?us-ascii?Q?Qu6PUc9/ijfHj+mz8TZGH7hup/dU3khRsoaj03R+eScj9VFOu4HN+SZM8bJ6?=
 =?us-ascii?Q?Eyke1LO49GAYKdUnoNGCVW6IHERCRAiHIaxah3uomBxPH09AakOXE/YbWAo7?=
 =?us-ascii?Q?rEKsAs/KAeeeMpwJNfxpqHHvohKgOzBhyrWo56K0xu3vQw0bepbgPKYZLwYF?=
 =?us-ascii?Q?sEqjq7aVC8Rqph4b8aB4w7LVmv3z22HkbcdHC1a9OD0e/GsjWWQjniBLWdSo?=
 =?us-ascii?Q?D5PMQD3fFb9t+rNu8JN+NpZuj7ofKBCsIurNt7vn4gO85TbIsjCoCE4ks8Gs?=
 =?us-ascii?Q?Oy2kYCJKFo/f2ZzL5g2S/gdfR7k/216CRE8weYNnRLipUpcNakgF+XAgfkk0?=
 =?us-ascii?Q?2qhnc55dt81mTh8sp7fuVRzU7RkGZ35Md12j4EX9jcjW6oF1gL3lUYgKluWv?=
 =?us-ascii?Q?xn5qboWIVGo3ZLSn5FaOtiU+/t4bO6yqCklzbt4VmiX7D6tmwY3ngzrxN1MY?=
 =?us-ascii?Q?Dv7+mQS7hIIyPGrQm4bwonfzjzbE7I7vus8/mnEOdSzNKK2VOl7MzT3avc0O?=
 =?us-ascii?Q?1IDw078GuLL77I45+IahBF5KtdQ23UhUKLC5lRmiPGUwF5zvY66un2EadC+Z?=
 =?us-ascii?Q?wvbto0M97FTFkmHwl+ueQ/kh3FN4bu5xr6H4iriBXaIDxKvsI4oqsthSMaXF?=
 =?us-ascii?Q?9iDnIG6R3bfZ0zdhZ0ROMecTIfD+VMesNhqW+uWCaMK/lW67Eyc/K4FZXKJY?=
 =?us-ascii?Q?IByO5brEQaqwvFMennb7kgXDfpLPXIslzZwS7ZQ2y7HNRGNg/cZ8Nt0VvNK+?=
 =?us-ascii?Q?ucNl+hxYMbcaFKigKFhzHIUjUTCJphE39OE//AIYgc4w0oW3wrNx/hqQhrdR?=
 =?us-ascii?Q?/Cr8sGg+wrqDilgGp09pBthBxzkzp0gmMfye5YJpqqoq9YRGpfQAZes2KvgK?=
 =?us-ascii?Q?+rDBZamObMo5Me0ospE=3D?=
Content-Type: multipart/signed;
        protocol="application/x-pkcs7-signature";
        micalg=SHA1;
        boundary="----=_NextPart_000_0509_01D9CEB2.742320A0"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8211.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c62b79e9-bd93-42f0-2f51-08db9c9b7f67
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 07:53:07.3831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pdqfp27Hrm0KlhjU4qYZKuAVl2yEPra+JtN6HUtXjNqJPcD8Xnh6rkzVN+QxfxY2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_NextPart_000_0509_01D9CEB2.742320A0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Please find comments inline.



Regards
Varun

> -----Original Message-----
> From: Pankaj Gupta <pankaj.gupta@nxp.com>
> Sent: Monday, August 14, 2023 12:29 PM
> To: Varun Sethi <V.Sethi@nxp.com>
> Subject: FW: [PATCH v4 6/7] firmware: imx: add driver for NXP EdgeLock
> Enclave
> 
> 
> 
> -----Original Message-----
> From: Pankaj Gupta <pankaj.gupta@nxp.com>
> Sent: Wednesday, July 12, 2023 5:42 PM
> To: shawnguo@kernel.org; s.hauer@pengutronix.de;
> kernel@pengutronix.de; clin@suse.com; conor+dt@kernel.org;
> pierre.gondois@arm.com; Jacky Bai <ping.bai@nxp.com>; Clark Wang
> <xiaoning.wang@nxp.com>; Wei Fang <wei.fang@nxp.com>; Peng Fan
> <peng.fan@nxp.com>; Bough Chen <haibo.chen@nxp.com>;
> festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>;
> davem@davemloft.net; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Gaurav Jain
> <gaurav.jain@nxp.com>; alexander.stein@ew.tq-group.com; Sahil Malhotra
> <sahil.malhotra@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>; Varun
> Sethi <V.Sethi@nxp.com>
> Cc: Pankaj Gupta <pankaj.gupta@nxp.com>; kernel test robot
> <lkp@intel.com>
> Subject: [PATCH v4 6/7] firmware: imx: add driver for NXP EdgeLock Enclave
> 
> The Edgelock Enclave , is the secure enclave embedded in the SoC
> to support the features like HSM, SHE & V2X, using message based
> communication channel.
> 
> ELE FW communicates on a dedicated MU with application core where
> kernel is running. It exists on specific i.MX processors. e.g. i.MX8ULP,
> i.MX93.
> 
> Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  drivers/firmware/imx/Kconfig              |   12 +
>  drivers/firmware/imx/Makefile             |    2 +
>  drivers/firmware/imx/ele_base_msg.c       |  372 ++++++
>  drivers/firmware/imx/ele_fw_api.c         |  112 ++
>  drivers/firmware/imx/se_fw.c              | 1443 +++++++++++++++++++++
>  drivers/firmware/imx/se_fw.h              |  180 +++
>  include/linux/firmware/imx/ele_base_msg.h |   62 +
>  include/linux/firmware/imx/ele_fw_api.h   |   19 +
>  include/linux/firmware/imx/ele_mu_ioctl.h |   52 +
>  9 files changed, 2254 insertions(+)
>  create mode 100644 drivers/firmware/imx/ele_base_msg.c
>  create mode 100644 drivers/firmware/imx/ele_fw_api.c
>  create mode 100644 drivers/firmware/imx/se_fw.c
>  create mode 100644 drivers/firmware/imx/se_fw.h
>  create mode 100644 include/linux/firmware/imx/ele_base_msg.h
>  create mode 100644 include/linux/firmware/imx/ele_fw_api.h
>  create mode 100644 include/linux/firmware/imx/ele_mu_ioctl.h
> 
[Varun] This diver needs to be refactored. Break this into the following:
1. Base driver functionality.
2. Services using this driver (HWRNG, ping, fuse read)
3. Also, consider moving services to separate files

> diff --git a/drivers/firmware/imx/Kconfig b/drivers/firmware/imx/Kconfig
> index c027d99f2a59..2822e5d4b24c 100644
> --- a/drivers/firmware/imx/Kconfig
> +++ b/drivers/firmware/imx/Kconfig
> @@ -28,3 +28,15 @@ config IMX_SCU_PD
>  	depends on IMX_SCU
>  	help
>  	  The System Controller Firmware (SCFW) based power domain driver.
> +
> +config IMX_SEC_ENCLAVE
> +	tristate "i.MX Embedded Secure Enclave - EdgeLock Enclave
> Firmware driver."
> +	depends on IMX_MBOX && ARCH_MXC && ARM64
> +	default m if ARCH_MXC
> +
> +	help
> +	  It is possible to use APIs exposed by the iMX Secure Enclave HW IP
> called:
> +          - EdgeLock Enclave Firmware (for i.MX8ULP, i.MX93),
> +          like base, HSM, V2X & SHE using the SAB protocol via the shared
> Messaging
> +          Unit. This driver exposes these interfaces via a set of file
descriptors
> +          allowing to configure shared memory, send and receive messages.
> diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
> index b76acbade2a0..f586feaf807d 100644
> --- a/drivers/firmware/imx/Makefile
> +++ b/drivers/firmware/imx/Makefile
> @@ -2,3 +2,5 @@
>  obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
>  obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o
> rm.o imx-scu-soc.o
>  obj-$(CONFIG_IMX_SCU_PD)	+= scu-pd.o
> +sec_enclave-objs		= se_fw.o ele_base_msg.o ele_fw_api.o
> +obj-${CONFIG_IMX_SEC_ENCLAVE}	+= sec_enclave.o
> diff --git a/drivers/firmware/imx/ele_base_msg.c
> b/drivers/firmware/imx/ele_base_msg.c
> new file mode 100644
> index 000000000000..f6cedbef82f9
> --- /dev/null
> +++ b/drivers/firmware/imx/ele_base_msg.c
> @@ -0,0 +1,372 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2021-2023 NXP
> + */
> +
> +#include <linux/types.h>
> +#include <linux/completion.h>
> +
> +#include <linux/firmware/imx/ele_base_msg.h>
> +#include <linux/firmware/imx/ele_mu_ioctl.h>
> +
> +#include "se_fw.h"
> +
> +/* Fill a command message header with a given command ID and length in
> bytes. */
> +static int plat_fill_cmd_msg_hdr(struct mu_hdr *hdr,
> +				 uint8_t cmd,
> +				 uint32_t len)
> +{
> +	struct ele_mu_priv *priv = NULL;
> +	int err;
> +
> +	err = get_ele_mu_priv(&priv);
> +	if (err) {
> +		pr_err("Error: iMX EdgeLock Enclave MU, used before
> probing.\n");
> +		return err;
> +	}
> +
> +	hdr->tag = priv->cmd_tag;
> +	hdr->ver = ELE_BASE_API_VERSION;
> +	hdr->command = cmd;
> +	hdr->size = len >> 2;
> +
> +	return err;
> +}
> +
> +static u32 plat_add_msg_crc(uint32_t *msg, uint32_t msg_len)
> +{
> +	uint32_t i;
> +	uint32_t crc = 0;
> +	uint32_t nb_words = msg_len >> 2;
> +
> +	for (i = 0; i < nb_words - 1; i++)
> +		crc ^= *(msg + i);
> +
> +	return crc;
> +}
> +
> +int imx_ele_msg_send_rcv(struct ele_mu_priv *priv)
> +{
> +	unsigned int wait;
> +	int err;
> +
> +	mutex_lock(&priv->mu_cmd_lock);
> +	mutex_lock(&priv->mu_lock);
> +
> +	err = mbox_send_message(priv->tx_chan, &priv->tx_msg);
> +	if (err < 0) {
> +		pr_err("Error: mbox_send_message failure.\n");
> +		mutex_unlock(&priv->mu_lock);
> +		return err;
> +	}
> +	mutex_unlock(&priv->mu_lock);
> +
> +	wait = msecs_to_jiffies(1000);
> +	if (!wait_for_completion_timeout(&priv->done, wait)) {
> +		pr_err("Error: wait_for_completion timed out.\n");
> +		err = -ETIMEDOUT;
> +	}
> +
> +	mutex_unlock(&priv->mu_cmd_lock);
> +
> +	return err;
> +}
> +
> +static int read_otp_uniq_id(struct ele_mu_priv *priv, u32 *value)
> +{
> +	unsigned int tag, command, size, ver, status;
> +
> +	tag = MSG_TAG(priv->rx_msg.header);
> +	command = MSG_COMMAND(priv->rx_msg.header);
> +	size = MSG_SIZE(priv->rx_msg.header);
> +	ver = MSG_VER(priv->rx_msg.header);
> +	status = RES_STATUS(priv->rx_msg.data[0]);
> +
> +	if (tag == priv->rsp_tag &&
> +	    command == ELE_READ_FUSE_REQ &&
> +	    size == ELE_READ_FUSE_RSP_MSG_SZ &&
> +	    ver == ELE_BASE_API_VERSION &&
> +	    status == ELE_SUCCESS_IND) {
> +		value[0] = priv->rx_msg.data[1];
> +		value[1] = priv->rx_msg.data[2];
> +		value[2] = priv->rx_msg.data[3];
> +		value[3] = priv->rx_msg.data[4];
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int read_fuse_word(struct ele_mu_priv *priv, u32 *value)
> +{
> +	unsigned int tag, command, size, ver, status;
> +
> +	tag = MSG_TAG(priv->rx_msg.header);
> +	command = MSG_COMMAND(priv->rx_msg.header);
> +	size = MSG_SIZE(priv->rx_msg.header);
> +	ver = MSG_VER(priv->rx_msg.header);
> +	status = RES_STATUS(priv->rx_msg.data[0]);
> +
> +	if (tag == priv->rsp_tag &&
> +	    command == ELE_READ_FUSE_REQ &&
> +	    size == ELE_READ_FUSE_REQ_MSG_SZ &&
> +	    ver == ELE_BASE_API_VERSION &&
> +	    status == ELE_SUCCESS_IND) {
> +		value[0] = priv->rx_msg.data[1];
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +int read_common_fuse(uint16_t fuse_id, u32 *value)
> +{
> +	struct ele_mu_priv *priv = NULL;
> +	int err;
> +
> +	err = get_ele_mu_priv(&priv);
> +	if (err) {
> +		pr_err("Error: iMX EdgeLock Enclave MU, used before
> probing.\n");
> +		return err;
> +	}
> +	err = plat_fill_cmd_msg_hdr((struct mu_hdr *)&priv-
> >tx_msg.header,
> +				    ELE_READ_FUSE_REQ, 8);
> +	if (err) {
> +		pr_err("Error: plat_fill_cmd_msg_hdr failed.\n");
> +		return err;
> +	}
> +
> +	priv->tx_msg.data[0] = fuse_id;
> +	err = imx_ele_msg_send_rcv(priv);
> +	if (err < 0)
> +		return err;
> +
> +	switch (fuse_id) {
> +	case OTP_UNIQ_ID:
> +		err = read_otp_uniq_id(priv, value);
> +		break;
> +	default:
> +		err = read_fuse_word(priv, value);
> +		break;
> +	}
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(read_common_fuse);
> +
> +int ele_ping(void)
> +{
> +	struct ele_mu_priv *priv = NULL;
> +	unsigned int tag, command, size, ver, status;
> +	int err;
> +
> +	err = get_ele_mu_priv(&priv);
> +	if (err) {
> +		pr_err("Error: iMX EdgeLock Enclave MU, used before
> probing.\n");
> +		return err;
> +	}
> +	err = plat_fill_cmd_msg_hdr((struct mu_hdr *)&priv-
> >tx_msg.header,
> +				    ELE_PING_REQ, 4);
> +	if (err) {
> +		pr_err("Error: plat_fill_cmd_msg_hdr failed.\n");
> +		return err;
> +	}
> +
> +	err = imx_ele_msg_send_rcv(priv);
> +	if (err < 0)
> +		return err;
> +
> +	tag = MSG_TAG(priv->rx_msg.header);
> +	command = MSG_COMMAND(priv->rx_msg.header);
> +	size = MSG_SIZE(priv->rx_msg.header);
> +	ver = MSG_VER(priv->rx_msg.header);
> +	status = RES_STATUS(priv->rx_msg.data[0]);
> +
> +	if (tag == priv->rsp_tag && command == ELE_PING_REQ &&
> +	    size == ELE_PING_REQ_MSG_SZ && ver ==
> ELE_BASE_API_VERSION &&
> +	    status == ELE_SUCCESS_IND)
> +		return 0;
> +
> +	return -EAGAIN;
> +}
> +EXPORT_SYMBOL_GPL(ele_ping);
> +
> +int ele_service_swap(phys_addr_t addr, u32 addr_size, u16 flag)
> +{
> +	struct ele_mu_priv *priv;
> +	int ret;
> +	unsigned int tag, command, size, ver, status;
> +
> +	ret = get_ele_mu_priv(&priv);
> +	if (ret)
> +		return ret;
> +
> +	ret = plat_fill_cmd_msg_hdr((struct mu_hdr *)&priv-
> >tx_msg.header,
> +				    ELE_SERVICE_SWAP_REQ, 24);
> +	if (ret)
> +		return ret;
> +
> +	priv->tx_msg.data[0] = flag;
> +	priv->tx_msg.data[1] = addr_size;
> +	priv->tx_msg.data[2] = ELE_NONE_VAL;
> +	priv->tx_msg.data[3] = lower_32_bits(addr);
> +	priv->tx_msg.data[4] = plat_add_msg_crc((uint32_t *)&priv-
> >tx_msg, 24);
> +	ret = imx_ele_msg_send_rcv(priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	tag = MSG_TAG(priv->rx_msg.header);
> +	command = MSG_COMMAND(priv->rx_msg.header);
> +	size = MSG_SIZE(priv->rx_msg.header);
> +	ver = MSG_VER(priv->rx_msg.header);
> +	status = RES_STATUS(priv->rx_msg.data[0]);
> +	if (tag == priv->rsp_tag &&
> +	    command == ELE_SERVICE_SWAP_REQ &&
> +	    size == ELE_SERVICE_SWAP_REQ_MSG_SZ &&
> +	    ver == ELE_BASE_API_VERSION &&
> +	    status == ELE_SUCCESS_IND) {
> +		if (flag == ELE_IMEM_EXPORT)
> +			return priv->rx_msg.data[1];
> +		else
> +			return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(ele_service_swap);
> +
> +int ele_get_info(phys_addr_t addr, u32 data_size)
> +{
> +	struct ele_mu_priv *priv;
> +	int ret;
> +	unsigned int tag, command, size, ver, status;
> +
> +	ret = get_ele_mu_priv(&priv);
> +	if (ret)
> +		return ret;
> +
> +	ret = plat_fill_cmd_msg_hdr((struct mu_hdr *)&priv-
> >tx_msg.header,
> +				    ELE_GET_INFO_REQ, 16);
> +	if (ret)
> +		return ret;
> +
> +	priv->tx_msg.data[0] = upper_32_bits(addr);
> +	priv->tx_msg.data[1] = lower_32_bits(addr);
> +	priv->tx_msg.data[2] = data_size;
> +	ret = imx_ele_msg_send_rcv(priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	tag = MSG_TAG(priv->rx_msg.header);
> +	command = MSG_COMMAND(priv->rx_msg.header);
> +	size = MSG_SIZE(priv->rx_msg.header);
> +	ver = MSG_VER(priv->rx_msg.header);
> +	status = RES_STATUS(priv->rx_msg.data[0]);
> +	if (tag == priv->rsp_tag &&
> +	    command == ELE_GET_INFO_REQ &&
> +	    size == ELE_GET_INFO_REQ_MSG_SZ &&
> +	    ver == ELE_BASE_API_VERSION &&
> +	    status == ELE_SUCCESS_IND)
> +		return 0;
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(ele_get_info);
> +
> +/*
> + * ele_get_trng_state() - prepare and send the command to read
> + *                        crypto lib and TRNG state
> + * TRNG state
> + *  0x1		TRNG is in program mode
> + *  0x2		TRNG is still generating entropy
> + *  0x3		TRNG entropy is valid and ready to be read
> + *  0x4		TRNG encounter an error while generating entropy
> + *
> + * CSAL state
> + *  0x0		Crypto Lib random context initialization is not done
yet
> + *  0x1		Crypto Lib random context initialization is on-going
> + *  0x2		Crypto Lib random context initialization succeed
> + *  0x3		Crypto Lib random context initialization failed
> + *
> + * returns: csal and trng state.
> + *
> + */
> +int ele_get_trng_state(void)
> +{
> +	struct ele_mu_priv *priv;
> +	int ret;
> +	unsigned int tag, command, size, ver, status;
> +
> +	/* access ele_mu_priv data structure pointer*/
> +	ret = get_ele_mu_priv(&priv);
> +	if (ret)
> +		return ret;
> +
> +	ret = plat_fill_cmd_msg_hdr((struct mu_hdr *)&priv-
> >tx_msg.header,
> +				    ELE_GET_TRNG_STATE_REQ, 4);
> +	if (ret)
> +		return ret;
> +
> +	ret = imx_ele_msg_send_rcv(priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	tag = MSG_TAG(priv->rx_msg.header);
> +	command = MSG_COMMAND(priv->rx_msg.header);
> +	size = MSG_SIZE(priv->rx_msg.header);
> +	ver = MSG_VER(priv->rx_msg.header);
> +	status = RES_STATUS(priv->rx_msg.data[0]);
> +	if (tag == priv->rsp_tag &&
> +	    command == ELE_GET_TRNG_STATE_REQ &&
> +	    size == ELE_GET_TRNG_STATE_REQ_MSG_SZ &&
> +	    ver == ELE_BASE_API_VERSION &&
> +	    status == ELE_SUCCESS_IND) {
> +		return (priv->rx_msg.data[1] & CSAL_TRNG_STATE_MASK);
> +	}
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(ele_get_trng_state);
> +
> +/*
> + * ele_start_rng() - prepare and send the command to start
> + *                   initialization of the ELE RNG context
> + *
> + * returns:  0 on success.
> + */
> +int ele_start_rng(void)
> +{
> +	struct ele_mu_priv *priv;
> +	int ret;
> +	unsigned int tag, command, size, ver, status;
> +
> +	/* access ele_mu_priv data structure pointer*/
> +	ret = get_ele_mu_priv(&priv);
> +	if (ret)
> +		return ret;
> +
> +	ret = plat_fill_cmd_msg_hdr((struct mu_hdr *)&priv-
> >tx_msg.header,
> +				    ELE_START_RNG_REQ, 4);
> +	if (ret)
> +		return ret;
> +
> +	ret = imx_ele_msg_send_rcv(priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	tag = MSG_TAG(priv->rx_msg.header);
> +	command = MSG_COMMAND(priv->rx_msg.header);
> +	size = MSG_SIZE(priv->rx_msg.header);
> +	ver = MSG_VER(priv->rx_msg.header);
> +	status = RES_STATUS(priv->rx_msg.data[0]);
> +	if (tag == priv->rsp_tag &&
> +	    command == ELE_START_RNG_REQ &&
> +	    size == ELE_START_RNG_REQ_MSG_SZ &&
> +	    ver == ELE_BASE_API_VERSION &&
> +	    status == ELE_SUCCESS_IND) {
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(ele_start_rng);
> diff --git a/drivers/firmware/imx/ele_fw_api.c
> b/drivers/firmware/imx/ele_fw_api.c
> new file mode 100644
> index 000000000000..2a3fdc42294b
> --- /dev/null
> +++ b/drivers/firmware/imx/ele_fw_api.c
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright 2023 NXP
> + */
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/firmware/imx/ele_fw_api.h>
> +
> +#include "se_fw.h"
> +
> +/* Fill a command message header with a given command ID and length in
> bytes. */
> +static int plat_fill_cmd_msg_hdr(struct mu_hdr *hdr, uint8_t cmd,
uint32_t
> len)
> +{
> +	struct ele_mu_priv *priv = NULL;
> +	int err = 0;
> +
> +	err = get_ele_mu_priv(&priv);
> +	if (err) {
> +		pr_err("Error: iMX EdgeLock Enclave MU is not probed
> successfully.\n");
> +		return err;
> +	}
> +	hdr->tag = priv->cmd_tag;
> +	hdr->ver = MESSAGING_VERSION_7;
> +	hdr->command = cmd;
> +	hdr->size = (uint8_t)(len / sizeof(uint32_t));
> +
> +	return err;
> +}
> +
> +/*
> + * ele_get_random() - prepare and send the command to proceed
> + *                    with a random number generation operation
> + *
> + * returns:  size of the rondom number generated
> + */
> +int ele_get_random(struct hwrng *rng, void *data, size_t len, bool wait)
> +{
> +	struct ele_mu_priv *priv;
> +	unsigned int tag, command, size, ver, status;
> +	dma_addr_t dst_dma;
> +	u8 *buf;
> +	int ret;
> +
> +	/* access ele_mu_priv data structure pointer*/
> +	ret = get_ele_mu_priv(&priv);
> +	if (ret)
> +		return ret;
> +
> +	buf = dmam_alloc_coherent(priv->dev, len, &dst_dma,
> GFP_KERNEL);
> +	if (!buf) {
> +		dev_err(priv->dev, "Failed to map destination buffer
> memory\n");
> +		return -ENOMEM;
> +	}
> +
> +	ret = plat_fill_cmd_msg_hdr((struct mu_hdr *)&priv-
> >tx_msg.header, ELE_GET_RANDOM_REQ, 16);
> +	if (ret)
> +		goto exit;
> +
> +	priv->tx_msg.data[0] = 0x0;
> +	priv->tx_msg.data[1] = dst_dma;
> +	priv->tx_msg.data[2] = len;
> +	ret = imx_ele_msg_send_rcv(priv);
> +	if (ret < 0)
> +		goto exit;
> +
> +	tag = MSG_TAG(priv->rx_msg.header);
> +	command = MSG_COMMAND(priv->rx_msg.header);
> +	size = MSG_SIZE(priv->rx_msg.header);
> +	ver = MSG_VER(priv->rx_msg.header);
> +	status = RES_STATUS(priv->rx_msg.data[0]);
> +	if (tag == 0xe1 && command == ELE_GET_RANDOM_REQ && size ==
> 0x02 &&
> +	    ver == 0x07 && status == 0xd6) {
> +		memcpy(data, buf, len);
> +		ret = len;
> +	} else
> +		ret = -EINVAL;
> +
> +exit:
> +	dmam_free_coherent(priv->dev, len, buf, dst_dma);
> +	return ret;
> +}
> +
> +int ele_init_fw(void)
> +{
> +	struct ele_mu_priv *priv;
> +	int ret;
> +	unsigned int tag, command, size, ver, status;
> +
> +	ret = get_ele_mu_priv(&priv);
> +	if (ret)
> +		return ret;
> +
> +	ret = plat_fill_cmd_msg_hdr((struct mu_hdr *)&priv-
> >tx_msg.header, ELE_INIT_FW_REQ, 4);
> +	if (ret)
> +		return ret;
> +
> +	ret = imx_ele_msg_send_rcv(priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	tag = MSG_TAG(priv->rx_msg.header);
> +	command = MSG_COMMAND(priv->rx_msg.header);
> +	size = MSG_SIZE(priv->rx_msg.header);
> +	ver = MSG_VER(priv->rx_msg.header);
> +	status = RES_STATUS(priv->rx_msg.data[0]);
> +
> +	if (tag == 0xe1 && command == ELE_INIT_FW_REQ && size == 0x02
> &&
> +	    ver == 0x06 && status == 0xd6)
> +		return 0;
> +
> +	return -EINVAL;
> +}
> diff --git a/drivers/firmware/imx/se_fw.c b/drivers/firmware/imx/se_fw.c
> new file mode 100644
> index 000000000000..14e4bb4225e1
> --- /dev/null
> +++ b/drivers/firmware/imx/se_fw.c
> @@ -0,0 +1,1443 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2021-2023 NXP
> + */
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/completion.h>
> +#include <linux/dev_printk.h>
> +#include <linux/errno.h>
> +#include <linux/export.h>
> +#include <linux/firmware/imx/ele_fw_api.h>
> +#include <linux/firmware/imx/ele_base_msg.h>
> +#include <linux/firmware/imx/ele_mu_ioctl.h>
> +#include <linux/genalloc.h>
> +#include <linux/io.h>
> +#include <linux/init.h>
> +#include <linux/miscdevice.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +#include <linux/sys_soc.h>
> +#include <linux/workqueue.h>
> +
> +#include "se_fw.h"
> +
> +#define ELE_PING_INTERVAL		(3600 * HZ)
> +#define ELE_TRNG_STATE_OK		0x203
> +#define ELE_GET_TRNG_STATE_RETRY_COUNT	0x5
> +
> +#define ELE_GET_INFO_BUFF_SZ		0x100
> +#define ELE_GET_INFO_READ_SZ		0xA0
> +#define ELE_IMEM_SIZE			0x10000
> +#define ELE_IMEM_STATE_OK		0xCA
> +#define ELE_IMEM_STATE_BAD		0xFE
> +#define ELE_IMEM_STATE_WORD		0x27
> +#define ELE_IMEM_STATE_MASK		0x00ff0000
> +
> +#define SOC_ID_OF_IMX8ULP		0x084D
> +#define SOC_ID_OF_IMX93			0x9300
> +#define SOC_VER_MASK			0xFFFF0000
> +#define SOC_ID_MASK			0x0000FFFF
> +#define DEVICE_GET_INFO_SZ		0x100
> +
> +#define GET_INFO_SOC_INFO_WORD_OFFSET	1
> +#define GET_INFO_UUID_WORD_OFFSET	3
> +#define GET_INFO_SL_NUM_MSB_WORD_OFF \
> +	(GET_INFO_UUID_WORD_OFFSET + 3)
> +#define GET_INFO_SL_NUM_LSB_WORD_OFF \
> +	(GET_INFO_UUID_WORD_OFFSET + 0)
> +
> +#define RESERVED_DMA_POOL		BIT(1)
> +
> +struct ele_mu_priv *ele_priv_export;
> +
> +struct imx_info {
> +	bool socdev;
> +	uint8_t max_dev_ctx;
> +	uint8_t cmd_tag;
> +	uint8_t rsp_tag;
> +	uint8_t *pool_name;
> +	/* platform specific flag to enable/disable the ELE True RNG */
> +	bool start_rng;
> +	bool enable_ele_trng;
> +	bool reserved_dma_ranges;
> +	bool init_fw;
> +	bool imem_mgmt;
> +};
> +
> +static const struct imx_info imx8ulp_info = {
> +	.socdev = true,
> +	.max_dev_ctx = 4,
> +	.cmd_tag = 0x17,
> +	.rsp_tag = 0xe1,
> +	.pool_name = "sram-pool",
> +	.start_rng = true,
> +	.enable_ele_trng = false,
> +	.reserved_dma_ranges = true,
> +	.init_fw = false,
> +	.imem_mgmt = true,
> +};
> +
> +static const struct imx_info imx93_info = {
> +	.socdev = true,
> +	.max_dev_ctx = 4,
> +	.cmd_tag = 0x17,
> +	.rsp_tag = 0xe1,
> +	.pool_name = NULL,
> +	.start_rng = true,
> +	.enable_ele_trng = true,
> +	.reserved_dma_ranges = true,
> +	.init_fw = true,
> +	.imem_mgmt = false,
> +};
> +
> +static const struct of_device_id ele_mu_match[] = {
> +	{ .compatible = "fsl,imx-ele", .data = (void *)&imx8ulp_info},
> +	{ .compatible = "fsl,imx93-ele", .data = (void *)&imx93_info},
> +	{},
> +};
> +
> +int get_ele_mu_priv(struct ele_mu_priv **export)
> +{
> +	if (!ele_priv_export)
> +		return -EPROBE_DEFER;
> +
> +	*export = ele_priv_export;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(get_ele_mu_priv);
> +
> +/*
> + * Callback called by mailbox FW when data are received
> + */
> +static void ele_mu_rx_callback(struct mbox_client *c, void *msg)
> +{
> +	struct device *dev = c->dev;
> +	struct ele_mu_priv *priv = dev_get_drvdata(dev);
> +	struct ele_mu_device_ctx *dev_ctx;
> +	bool is_response = false;
> +	int msg_size;
> +	struct mu_hdr header;
> +
> +	dev_dbg(dev, "Message received on mailbox\n");
> +
> +	/* The function can be called with NULL msg */
> +	if (!msg) {
> +		dev_err(dev, "Message is invalid\n");
> +		return;
> +	}
> +
> +	if (IS_ERR(msg)) {
> +		dev_err(dev, "Error during reception of message: %ld\n",
> +				PTR_ERR(msg));
> +		return;
> +	}
> +
> +	header.tag = ((u8 *)msg)[TAG_OFFSET];
> +	header.command = ((u8 *)msg)[CMD_OFFSET];
> +	header.size = ((u8 *)msg)[SZ_OFFSET];
> +	header.ver = ((u8 *)msg)[VER_OFFSET];
> +
> +	dev_dbg(dev, "Selecting device\n");
> +
> +	/* Incoming command: wake up the receiver if any. */
> +	if (header.tag == priv->cmd_tag) {
> +		dev_dbg(dev, "Selecting cmd receiver\n");
> +		dev_ctx = priv->cmd_receiver_dev;
> +	} else if (header.tag == priv->rsp_tag) {
> +		if (priv->waiting_rsp_dev) {
> +			dev_dbg(dev, "Selecting rsp waiter\n");
> +			dev_ctx = priv->waiting_rsp_dev;
> +			is_response = true;
> +		} else {
> +			/* Reading the EdgeLock Enclave response
> +			 * to the command sent by other
> +			 * linux kernel services.
> +			 */
> +			spin_lock(&priv->lock);
> +			priv->rx_msg = *(struct ele_api_msg *)msg;
> +			complete(&priv->done);
> +			spin_unlock(&priv->lock);
> +			return;
> +		}
> +	} else {
> +		dev_err(dev, "Failed to select a device for message:
%.8x\n",
> +				*((u32 *) &header));
> +		return;
> +	}
> +
> +	if (!dev_ctx) {
> +		dev_err(dev, "No device context selected for
> message: %.8x\n",
> +				*((u32 *)&header));
> +		return;
> +	}
> +	/* Init reception */
> +	msg_size = header.size;
> +	if (msg_size > MAX_RECV_SIZE) {
> +		devctx_err(dev_ctx, "Message is too big (%d > %d)",
> msg_size,
> +				MAX_RECV_SIZE);
> +		return;
> +	}
> +
> +	memcpy(dev_ctx->temp_resp, msg, msg_size << 2);
> +	dev_ctx->temp_resp_size = msg_size;
> +
> +	/* Allow user to read */
> +	dev_ctx->pending_hdr = dev_ctx->temp_resp[0];
> +	wake_up_interruptible(&dev_ctx->wq);
> +
> +	if (is_response)
> +		priv->waiting_rsp_dev = NULL;
> +
> +}
> +
> +static void ele_ping_handler(struct work_struct *work)
> +{
> +	int ret;
> +
> +	ret = ele_ping();
> +	if (ret)
> +		pr_err("ping ele failed, try again!\n");
> +
> +	/* reschedule the delay work */
> +	schedule_delayed_work(to_delayed_work(work),
> ELE_PING_INTERVAL);
> +}
> +static DECLARE_DELAYED_WORK(ele_ping_work, ele_ping_handler);
> +
> +static phys_addr_t get_phy_buf_mem_pool(struct device_node *of_node,
> +					char *mem_pool_name,
> +					u32 **buf,
> +					uint32_t size)
> +{
> +	struct gen_pool *mem_pool = of_gen_pool_get(of_node,
> +						    mem_pool_name, 0);
> +	if (!mem_pool) {
> +		pr_err("Unable to get sram pool\n");
> +		return 0;
> +	}
> +
> +	*buf = (u32 *)gen_pool_alloc(mem_pool, size);
> +	if (!buf) {
> +		pr_err("Unable to alloc sram from sram pool\n");
> +		return 0;
> +	}
> +
> +	return gen_pool_virt_to_phys(mem_pool, (ulong)*buf);
> +}
> +
> +static void free_phybuf_mem_pool(struct device_node *of_node,
> +				 char *mem_pool_name,
> +				 u32 *buf,
> +				 uint32_t size)
> +{
> +	struct gen_pool *mem_pool = of_gen_pool_get(of_node,
> +						    mem_pool_name, 0);
> +	if (!mem_pool)
> +		pr_err("%s failed: Unable to get sram pool.\n", __func__);
> +
> +	gen_pool_free(mem_pool, (unsigned long)buf, size);
> +}
> +
> +
> +static int imx_soc_device_register(struct platform_device *pdev,
> +				   struct imx_info *info)
> +{
> +	struct soc_device_attribute *attr;
> +	struct soc_device *dev;
> +	phys_addr_t get_info_addr = 0;
> +	u32 *get_info_data = NULL;
> +	u8 major_ver, minor_ver;
> +	int err;
> +
> +	if (info->pool_name) {
> +		get_info_addr = get_phy_buf_mem_pool(pdev-
> >dev.of_node,
> +						     info->pool_name,
> +						     &get_info_data,
> +						     DEVICE_GET_INFO_SZ);
> +	} else {
> +		get_info_data = dmam_alloc_coherent(&pdev->dev,
> +						    DEVICE_GET_INFO_SZ,
> +						    &get_info_addr,
> +						    GFP_KERNEL);
> +	}
> +	if (!get_info_addr) {
> +		pr_err("Unable to alloc buffer for device info.\n");
> +		return -ENOMEM;
> +	}
> +
> +	attr = kzalloc(sizeof(*attr), GFP_KERNEL);
> +	if (!attr)
> +		return -ENOMEM;
> +
> +	err = ele_get_info(get_info_addr, ELE_GET_INFO_READ_SZ);
> +	if (err) {
> +		attr->revision = kasprintf(GFP_KERNEL, "A0");
> +	} else {
> +		major_ver =
> (get_info_data[GET_INFO_SOC_INFO_WORD_OFFSET]
> +				& SOC_VER_MASK) >> 24;
> +		minor_ver =
> ((get_info_data[GET_INFO_SOC_INFO_WORD_OFFSET]
> +				& SOC_VER_MASK) >> 16) & 0xFF;
> +		if (minor_ver)
> +			attr->revision = kasprintf(GFP_KERNEL,
> +						   "%x.%x",
> +						   major_ver,
> +						   minor_ver);
> +		else
> +			attr->revision = kasprintf(GFP_KERNEL,
> +						   "%x",
> +						   major_ver);
> +
> +		switch
> (get_info_data[GET_INFO_SOC_INFO_WORD_OFFSET]
> +				& SOC_ID_MASK) {
> +			case SOC_ID_OF_IMX8ULP:
> +				attr->soc_id = kasprintf(GFP_KERNEL,
> +							 "i.MX8ULP");
> +				break;
> +			case SOC_ID_OF_IMX93:
> +				attr->soc_id = kasprintf(GFP_KERNEL,
> +							 "i.MX93");
> +				break;
> +		}
> +	}
> +
> +	err = of_property_read_string(of_root, "model",
> +				      &attr->machine);
> +	if (err) {
> +		kfree(attr);
> +		return -EINVAL;
> +	}
> +	attr->family = kasprintf(GFP_KERNEL, "Freescale i.MX");
> +
> +	attr->serial_number
> +		= kasprintf(GFP_KERNEL, "%016llX",
> +
> (u64)get_info_data[GET_INFO_SL_NUM_MSB_WORD_OFF] << 32
> +			    |
> get_info_data[GET_INFO_SL_NUM_LSB_WORD_OFF]);
> +
> +	if (info->pool_name) {
> +		free_phybuf_mem_pool(pdev->dev.of_node, info-
> >pool_name,
> +				     get_info_data, DEVICE_GET_INFO_SZ);
> +	} else {
> +		dmam_free_coherent(&pdev->dev,
> +				   DEVICE_GET_INFO_SZ,
> +				   get_info_data,
> +				   get_info_addr);
> +	}
> +
> +	dev = soc_device_register(attr);
> +	if (IS_ERR(dev)) {
> +		kfree(attr->soc_id);
> +		kfree(attr->serial_number);
> +		kfree(attr->revision);
> +		kfree(attr->family);
> +		kfree(attr->machine);
> +		kfree(attr);
> +		return PTR_ERR(dev);
> +	}
> +
> +	return 0;
> +}
> +
> +static int ele_do_start_rng(void)
> +{
> +	int ret;
> +	int count = ELE_GET_TRNG_STATE_RETRY_COUNT;
> +
> +	ret = ele_get_trng_state();
> +	if (ret < 0) {
> +		pr_err("Failed to get trng state\n");
> +		return ret;
> +	} else if (ret != ELE_TRNG_STATE_OK) {
> +		/* call start rng */
> +		ret = ele_start_rng();
> +		if (ret) {
> +			pr_err("Failed to start rng\n");
> +			return ret;
> +		}
> +
> +		/* poll get trng state API,
> ELE_GET_TRNG_STATE_RETRY_COUNT times
> +		 * or while trng state != 0x203
> +		 */
> +		do {
> +			msleep(10);
> +			ret = ele_get_trng_state();
> +			if (ret < 0) {
> +				pr_err("Failed to get trng state\n");
> +				return ret;
> +			}
> +			count--;
> +		} while ((ret != ELE_TRNG_STATE_OK) && count);
> +		if (ret != ELE_TRNG_STATE_OK)
> +			return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * File operations for user-space
> + */
> +
> +/* Write a message to the MU. */
> +static ssize_t ele_mu_fops_write(struct file *fp, const char __user *buf,
> +				  size_t size, loff_t *ppos)
> +{
> +	struct ele_mu_device_ctx *dev_ctx
> +		= container_of(fp->private_data,
> +			       struct ele_mu_device_ctx,
> +			       miscdev);
> +	struct ele_mu_priv *ele_mu_priv = dev_ctx->priv;
> +	u32 nb_words = 0;
> +	struct mu_hdr header;
> +	int err;
> +
> +	devctx_dbg(dev_ctx, "write from buf (%p)%zu, ppos=%lld\n", buf,
> size,
> +		   ((ppos) ? *ppos : 0));
> +
> +	if (down_interruptible(&dev_ctx->fops_lock))
> +		return -EBUSY;
> +
> +	if (dev_ctx->status != MU_OPENED) {
> +		err = -EINVAL;
> +		goto exit;
> +	}
> +
> +	if (size < ELE_MU_HDR_SZ) {
> +		devctx_err(dev_ctx, "User buffer too small(%zu < %d)\n",
> +			   size, ELE_MU_HDR_SZ);
> +		err = -ENOSPC;
> +		goto exit;
> +	}
> +
> +	if (size > MAX_MESSAGE_SIZE_BYTES) {
> +		devctx_err(dev_ctx, "User buffer too big(%zu > %d)\n", size,
> +			   MAX_MESSAGE_SIZE_BYTES);
> +		err = -ENOSPC;
> +		goto exit;
> +	}
> +
> +	/* Copy data to buffer */
> +	if (copy_from_user(dev_ctx->temp_cmd, buf, size)) {
> +		err = -EFAULT;
> +		devctx_err(dev_ctx, "Fail copy message from user\n");
> +		goto exit;
> +	}
> +
> +	print_hex_dump_debug("from user ", DUMP_PREFIX_OFFSET, 4, 4,
> +			     dev_ctx->temp_cmd, size, false);
> +
> +	header = *((struct mu_hdr *) (&dev_ctx->temp_cmd[0]));
> +
> +	/* Check the message is valid according to tags */
> +	if (header.tag == ele_mu_priv->cmd_tag) {
> +		/*
> +		 * unlocked in ele_mu_fops_read when the
> +		 * response to this command is read.
> +		 */
> +		mutex_lock(&ele_mu_priv->mu_cmd_lock);
> +		ele_mu_priv->waiting_rsp_dev = dev_ctx;
> +	} else if (header.tag == ele_mu_priv->rsp_tag) {
> +		/* Check the device context can send the command */
> +		if (dev_ctx != ele_mu_priv->cmd_receiver_dev) {
> +			devctx_err(dev_ctx,
> +				   "Channel not configured to send resp to
> FW.");
> +			err = -EPERM;
> +			goto exit;
> +		}
> +	} else {
> +		devctx_err(dev_ctx, "The message does not have a valid
> TAG\n");
> +		err = -EINVAL;
> +		goto exit;
> +	}
> +
> +	/*
> +	 * Check that the size passed as argument matches the size
> +	 * carried in the message.
> +	 */
> +	nb_words = header.size;
> +	if (nb_words << 2 != size) {
> +		devctx_err(dev_ctx, "User buffer too small\n");
> +		goto exit;
> +	}
> +
> +	mutex_lock(&ele_mu_priv->mu_lock);
> +
> +	/* Send message */
> +	devctx_dbg(dev_ctx, "sending message\n");
> +	err = mbox_send_message(ele_mu_priv->tx_chan, dev_ctx-
> >temp_cmd);
> +	if (err < 0) {
> +		devctx_err(dev_ctx, "Failed to send message\n");
> +		goto unlock;
> +	}
> +
> +	err = nb_words << 2;
> +
> +unlock:
> +	mutex_unlock(&ele_mu_priv->mu_lock);
> +
> +exit:
> +	if (err < 0)
> +		mutex_unlock(&ele_mu_priv->mu_cmd_lock);
> +	up(&dev_ctx->fops_lock);
> +	return err;
> +}
> +
> +/*
> + * Read a message from the MU.
> + * Blocking until a message is available.
> + */
> +static ssize_t ele_mu_fops_read(struct file *fp, char __user *buf,
> +				 size_t size, loff_t *ppos)
> +{
> +	struct ele_mu_device_ctx *dev_ctx
> +		= container_of(fp->private_data,
> +			       struct ele_mu_device_ctx,
> +			       miscdev);
> +	struct ele_mu_priv *ele_mu_priv = dev_ctx->priv;
> +	u32 data_size = 0, size_to_copy = 0;
> +	struct ele_buf_desc *b_desc;
> +	int err;
> +	struct mu_hdr header = {0};
> +
> +	devctx_dbg(dev_ctx, "read to buf %p(%zu), ppos=%lld\n", buf, size,
> +		   ((ppos) ? *ppos : 0));
> +
> +	if (down_interruptible(&dev_ctx->fops_lock))
> +		return -EBUSY;
> +
> +	if (dev_ctx->status != MU_OPENED) {
> +		err = -EINVAL;
> +		goto exit;
> +	}
> +
> +	/* Wait until the complete message is received on the MU. */
> +	if (wait_event_interruptible(dev_ctx->wq, dev_ctx->pending_hdr !=
> 0)) {
> +		devctx_err(dev_ctx, "Err[0x%x]:Interrupted by signal.\n",
> err);
> +		err = -EINTR;
> +		goto exit;
> +	}
> +
> +	devctx_dbg(dev_ctx, "%s %s\n", __func__,
> +		   "message received, start transmit to user");
> +
> +	/* Check that the size passed as argument is larger than
> +	 * the one carried in the message.
> +	 */
> +	data_size = dev_ctx->temp_resp_size << 2;
> +	size_to_copy = data_size;
> +	if (size_to_copy > size) {
> +		devctx_dbg(dev_ctx, "User buffer too small (%zu < %d)\n",
> +			   size, size_to_copy);
> +		size_to_copy = size;
> +	}
> +
> +	/* We may need to copy the output data to user before
> +	 * delivering the completion message.
> +	 */
> +	while (!list_empty(&dev_ctx->pending_out)) {
> +		b_desc = list_first_entry_or_null(&dev_ctx->pending_out,
> +						  struct ele_buf_desc,
> +						  link);
> +		if (!b_desc)
> +			continue;
> +
> +		if (b_desc->usr_buf_ptr && b_desc->shared_buf_ptr) {
> +
> +			devctx_dbg(dev_ctx, "Copy output data to user\n");
> +			if (copy_to_user(b_desc->usr_buf_ptr,
> +					 b_desc->shared_buf_ptr,
> +					 b_desc->size)) {
> +				devctx_err(dev_ctx,
> +					   "Failure copying output data to
> user.");
> +				err = -EFAULT;
> +				goto exit;
> +			}
> +		}
> +
> +		if (b_desc->shared_buf_ptr)
> +			memset(b_desc->shared_buf_ptr, 0, b_desc->size);
> +
> +		__list_del_entry(&b_desc->link);
> +		devm_kfree(dev_ctx->dev, b_desc);
> +	}
> +
> +	header = *((struct mu_hdr *) (&dev_ctx->temp_resp[0]));
> +
> +	/* Copy data from the buffer */
> +	print_hex_dump_debug("to user ", DUMP_PREFIX_OFFSET, 4, 4,
> +			     dev_ctx->temp_resp, size_to_copy, false);
> +	if (copy_to_user(buf, dev_ctx->temp_resp, size_to_copy)) {
> +		devctx_err(dev_ctx, "Failed to copy to user\n");
> +		err = -EFAULT;
> +		goto exit;
> +	}
> +
> +	err = size_to_copy;
> +
> +	/* free memory allocated on the shared buffers. */
> +	dev_ctx->secure_mem.pos = 0;
> +	dev_ctx->non_secure_mem.pos = 0;
> +
> +	dev_ctx->pending_hdr = 0;
> +
> +exit:
> +	/*
> +	 * Clean the used Shared Memory space,
> +	 * whether its Input Data copied from user buffers, or
> +	 * Data received from FW.
> +	 */
> +	while (!list_empty(&dev_ctx->pending_in) ||
> +	       !list_empty(&dev_ctx->pending_out)) {
> +		if (!list_empty(&dev_ctx->pending_in))
> +			b_desc = list_first_entry_or_null(&dev_ctx-
> >pending_in,
> +							  struct
ele_buf_desc,
> +							  link);
> +		else
> +			b_desc = list_first_entry_or_null(&dev_ctx-
> >pending_out,
> +							  struct
ele_buf_desc,
> +							  link);
> +
> +		if (!b_desc)
> +			continue;
> +
> +		if (b_desc->shared_buf_ptr)
> +			memset(b_desc->shared_buf_ptr, 0, b_desc->size);
> +
> +		__list_del_entry(&b_desc->link);
> +		devm_kfree(dev_ctx->dev, b_desc);
> +	}
> +	if (header.tag == ele_mu_priv->rsp_tag)
> +		mutex_unlock(&ele_mu_priv->mu_cmd_lock);
> +
> +	up(&dev_ctx->fops_lock);
> +	return err;
> +}
> +
> +/* Give access to EdgeLock Enclave, to the memory we want to share */
> +static int ele_mu_setup_ele_mem_access(struct ele_mu_device_ctx
> *dev_ctx,
> +					     u64 addr, u32 len)
> +{
> +	/* Assuming EdgeLock Enclave has access to all the memory regions
> */
> +	int ret = 0;
> +
> +	if (ret) {
> +		devctx_err(dev_ctx, "Fail find memreg\n");
> +		goto exit;
> +	}
> +
> +	if (ret) {
> +		devctx_err(dev_ctx, "Fail set permission for resource\n");
> +		goto exit;
> +	}
> +
> +exit:
> +	return ret;
> +}
> +
> +static int ele_mu_ioctl_get_mu_info(struct ele_mu_device_ctx *dev_ctx,
> +				    unsigned long arg)
> +{
> +	struct ele_mu_priv *priv = dev_get_drvdata(dev_ctx->dev);
> +	struct ele_mu_ioctl_get_mu_info info;
> +	int err = -EINVAL;
> +
> +	info.ele_mu_id = priv->ele_mu_id;
> +	info.interrupt_idx = 0;
> +	info.tz = 0;
> +	info.did = priv->ele_mu_did;
> +
> +	devctx_dbg(dev_ctx,
> +		   "info [mu_idx: %d, irq_idx: %d, tz: 0x%x, did: 0x%x]\n",
> +		   info.ele_mu_id, info.interrupt_idx, info.tz, info.did);
> +
> +	if (copy_to_user((u8 *)arg, &info, sizeof(info))) {
> +		devctx_err(dev_ctx, "Failed to copy mu info to user\n");
> +		err = -EFAULT;
> +		goto exit;
> +	}
> +
> +exit:
> +	return err;
> +}
> +
> +/*
> + * Copy a buffer of data to/from the user and return the address to use
in
> + * messages
> + */
> +static int ele_mu_ioctl_setup_iobuf_handler(struct ele_mu_device_ctx
> *dev_ctx,
> +					    unsigned long arg)
> +{
> +	struct ele_buf_desc *b_desc;
> +	struct ele_mu_ioctl_setup_iobuf io = {0};
> +	struct ele_shared_mem *shared_mem;
> +	int err = 0;
> +	u32 pos;
> +
> +	if (copy_from_user(&io, (u8 *)arg, sizeof(io))) {
> +		devctx_err(dev_ctx, "Failed copy iobuf config from user\n");
> +		err = -EFAULT;
> +		goto exit;
> +	}
> +
> +	devctx_dbg(dev_ctx, "io [buf: %p(%d) flag: %x]\n",
> +		   io.user_buf, io.length, io.flags);
> +
> +	if (io.length == 0 || !io.user_buf) {
> +		/*
> +		 * Accept NULL pointers since some buffers are optional
> +		 * in FW commands. In this case we should return 0 as
> +		 * pointer to be embedded into the message.
> +		 * Skip all data copy part of code below.
> +		 */
> +		io.ele_addr = 0;
> +		goto copy;
> +	}
> +
> +	/* Select the shared memory to be used for this buffer. */
> +	if (io.flags & ELE_MU_IO_FLAGS_USE_SEC_MEM) {
> +		/* App requires to use secure memory for this buffer.*/
> +		devctx_err(dev_ctx, "Failed allocate SEC MEM memory\n");
> +		err = -EFAULT;
> +		goto exit;
> +	} else {
> +		/* No specific requirement for this buffer. */
> +		shared_mem = &dev_ctx->non_secure_mem;
> +	}
> +
> +	/* Check there is enough space in the shared memory. */
> +	if (shared_mem->size < shared_mem->pos
> +			|| io.length >= shared_mem->size - shared_mem-
> >pos) {
> +		devctx_err(dev_ctx, "Not enough space in shared
> memory\n");
> +		err = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	/* Allocate space in shared memory. 8 bytes aligned. */
> +	pos = shared_mem->pos;
> +	shared_mem->pos += round_up(io.length, 8u);
> +	io.ele_addr = (u64)shared_mem->dma_addr + pos;
> +
> +	if ((io.flags & ELE_MU_IO_FLAGS_USE_SEC_MEM) &&
> +	    !(io.flags & ELE_MU_IO_FLAGS_USE_SHORT_ADDR)) {
> +		/*Add base address to get full address.*/
> +		devctx_err(dev_ctx, "Failed allocate SEC MEM memory\n");
> +		err = -EFAULT;
> +		goto exit;
> +	}
> +
> +	memset(shared_mem->ptr + pos, 0, io.length);
> +	if ((io.flags & ELE_MU_IO_FLAGS_IS_INPUT) ||
> +	    (io.flags & ELE_MU_IO_FLAGS_IS_IN_OUT)) {
> +		/*
> +		 * buffer is input:
> +		 * copy data from user space to this allocated buffer.
> +		 */
> +		if (copy_from_user(shared_mem->ptr + pos, io.user_buf,
> +				   io.length)) {
> +			devctx_err(dev_ctx,
> +				   "Failed copy data to shared memory\n");
> +			err = -EFAULT;
> +			goto exit;
> +		}
> +	}
> +
> +	b_desc = devm_kmalloc(dev_ctx->dev, sizeof(*b_desc),
> GFP_KERNEL);
> +	if (!b_desc) {
> +		err = -ENOMEM;
> +		devctx_err(dev_ctx,
> +			   "Failed allocating mem for pending buffer\n"
> +			   );
> +		goto exit;
> +	}
> +
> +	b_desc->shared_buf_ptr = shared_mem->ptr + pos;
> +	b_desc->usr_buf_ptr = io.user_buf;
> +	b_desc->size = io.length;
> +
> +	if (io.flags & ELE_MU_IO_FLAGS_IS_INPUT) {
> +		/*
> +		 * buffer is input:
> +		 * add an entry in the "pending input buffers" list so
> +		 * that copied data can be cleaned from shared memory
> +		 * later.
> +		 */
> +		list_add_tail(&b_desc->link, &dev_ctx->pending_in);
> +	} else {
> +		/*
> +		 * buffer is output:
> +		 * add an entry in the "pending out buffers" list so data
> +		 * can be copied to user space when receiving ELE
> +		 * response.
> +		 */
> +		list_add_tail(&b_desc->link, &dev_ctx->pending_out);
> +	}
> +
> +copy:
> +	/* Provide the EdgeLock Enclave address to user space only if
> success.*/
> +	if (copy_to_user((u8 *)arg, &io, sizeof(io))) {
> +		devctx_err(dev_ctx, "Failed to copy iobuff setup to
user\n");
> +		err = -EFAULT;
> +		goto exit;
> +	}
> +exit:
> +	return err;
> +}
> +
> +
> +
> +/* Open a char device. */
> +static int ele_mu_fops_open(struct inode *nd, struct file *fp)
> +{
> +	struct ele_mu_device_ctx *dev_ctx
> +		= container_of(fp->private_data,
> +			       struct ele_mu_device_ctx,
> +			       miscdev);
> +	int err;
> +
> +	/* Avoid race if opened at the same time */
> +	if (down_trylock(&dev_ctx->fops_lock))
> +		return -EBUSY;
> +
> +	/* Authorize only 1 instance. */
> +	if (dev_ctx->status != MU_FREE) {
> +		err = -EBUSY;
> +		goto exit;
> +	}
> +
> +	/*
> +	 * Allocate some memory for data exchanges with S40x.
> +	 * This will be used for data not requiring secure memory.
> +	 */
> +	dev_ctx->non_secure_mem.ptr = dmam_alloc_coherent(dev_ctx-
> >dev,
> +					MAX_DATA_SIZE_PER_USER,
> +					&dev_ctx-
> >non_secure_mem.dma_addr,
> +					GFP_KERNEL);
> +	if (!dev_ctx->non_secure_mem.ptr) {
> +		err = -ENOMEM;
> +		devctx_err(dev_ctx, "Failed to map shared memory with
> S40x\n");
> +		goto exit;
> +	}
> +
> +	err = ele_mu_setup_ele_mem_access(dev_ctx,
> +					  dev_ctx-
> >non_secure_mem.dma_addr,
> +					  MAX_DATA_SIZE_PER_USER);
> +	if (err) {
> +		err = -EPERM;
> +		devctx_err(dev_ctx,
> +			   "Failed to share access to shared memory\n");
> +		goto free_coherent;
> +	}
> +
> +	dev_ctx->non_secure_mem.size = MAX_DATA_SIZE_PER_USER;
> +	dev_ctx->non_secure_mem.pos = 0;
> +	dev_ctx->status = MU_OPENED;
> +
> +	dev_ctx->pending_hdr = 0;
> +
> +	goto exit;
> +
> +free_coherent:
> +	dmam_free_coherent(dev_ctx->priv->dev,
> MAX_DATA_SIZE_PER_USER,
> +			   dev_ctx->non_secure_mem.ptr,
> +			   dev_ctx->non_secure_mem.dma_addr);
> +
> +exit:
> +	up(&dev_ctx->fops_lock);
> +	return err;
> +}
> +
> +/* Close a char device. */
> +static int ele_mu_fops_close(struct inode *nd, struct file *fp)
> +{
> +	struct ele_mu_device_ctx *dev_ctx = container_of(fp->private_data,
> +					struct ele_mu_device_ctx, miscdev);
> +	struct ele_mu_priv *priv = dev_ctx->priv;
> +	struct ele_buf_desc *b_desc;
> +
> +	/* Avoid race if closed at the same time */
> +	if (down_trylock(&dev_ctx->fops_lock))
> +		return -EBUSY;
> +
> +	/* The device context has not been opened */
> +	if (dev_ctx->status != MU_OPENED)
> +		goto exit;
> +
> +	/* check if this device was registered as command receiver. */
> +	if (priv->cmd_receiver_dev == dev_ctx)
> +		priv->cmd_receiver_dev = NULL;
> +
> +	/* check if this device was registered as waiting response. */
> +	if (priv->waiting_rsp_dev == dev_ctx) {
> +		priv->waiting_rsp_dev = NULL;
> +		mutex_unlock(&priv->mu_cmd_lock);
> +	}
> +
> +	/* Unmap secure memory shared buffer. */
> +	if (dev_ctx->secure_mem.ptr)
> +		devm_iounmap(dev_ctx->dev, dev_ctx->secure_mem.ptr);
> +
> +	dev_ctx->secure_mem.ptr = NULL;
> +	dev_ctx->secure_mem.dma_addr = 0;
> +	dev_ctx->secure_mem.size = 0;
> +	dev_ctx->secure_mem.pos = 0;
> +
> +	/* Free non-secure shared buffer. */
> +	dmam_free_coherent(dev_ctx->priv->dev,
> MAX_DATA_SIZE_PER_USER,
> +			   dev_ctx->non_secure_mem.ptr,
> +			   dev_ctx->non_secure_mem.dma_addr);
> +
> +	dev_ctx->non_secure_mem.ptr = NULL;
> +	dev_ctx->non_secure_mem.dma_addr = 0;
> +	dev_ctx->non_secure_mem.size = 0;
> +	dev_ctx->non_secure_mem.pos = 0;
> +
> +	while (!list_empty(&dev_ctx->pending_in) ||
> +	       !list_empty(&dev_ctx->pending_out)) {
> +		if (!list_empty(&dev_ctx->pending_in))
> +			b_desc = list_first_entry_or_null(&dev_ctx-
> >pending_in,
> +							  struct
ele_buf_desc,
> +							  link);
> +		else
> +			b_desc = list_first_entry_or_null(&dev_ctx-
> >pending_out,
> +							  struct
ele_buf_desc,
> +							  link);
> +
> +		if (!b_desc)
> +			continue;
> +
> +		if (b_desc->shared_buf_ptr)
> +			memset(b_desc->shared_buf_ptr, 0, b_desc->size);
> +
> +		__list_del_entry(&b_desc->link);
> +		devm_kfree(dev_ctx->dev, b_desc);
> +	}
> +
> +	dev_ctx->status = MU_FREE;
> +
> +exit:
> +	up(&dev_ctx->fops_lock);
> +	return 0;
> +}
> +
> +/* IOCTL entry point of a char device */
> +static long ele_mu_ioctl(struct file *fp, unsigned int cmd, unsigned long
arg)
> +{
> +	struct ele_mu_device_ctx *dev_ctx
> +		= container_of(fp->private_data,
> +			       struct ele_mu_device_ctx,
> +			       miscdev);
> +	struct ele_mu_priv *ele_mu_priv = dev_ctx->priv;
> +	int err = -EINVAL;
> +
> +	/* Prevent race during change of device context */
> +	if (down_interruptible(&dev_ctx->fops_lock))
> +		return -EBUSY;
> +
> +	switch (cmd) {
> +	case ELE_MU_IOCTL_ENABLE_CMD_RCV:
> +		if (!ele_mu_priv->cmd_receiver_dev) {
> +			ele_mu_priv->cmd_receiver_dev = dev_ctx;
> +			err = 0;
> +		};
> +		break;
> +	case ELE_MU_IOCTL_GET_MU_INFO:
> +		err = ele_mu_ioctl_get_mu_info(dev_ctx, arg);
> +		break;
> +	case ELE_MU_IOCTL_SHARED_BUF_CFG:
> +		devctx_err(dev_ctx,
> +			   "ELE_MU_IOCTL_SHARED_BUF_CFG not supported
> [0x%x].\n",
> +			   err);
> +		break;
> +	case ELE_MU_IOCTL_SETUP_IOBUF:
> +		err = ele_mu_ioctl_setup_iobuf_handler(dev_ctx, arg);
> +		break;
> +	case ELE_MU_IOCTL_SIGNED_MESSAGE:
> +		devctx_err(dev_ctx,
> +			   "ELE_MU_IOCTL_SIGNED_MESSAGE not supported
> [0x%x].\n",
> +			   err);
> +		break;
> +	default:
> +		err = -EINVAL;
> +		devctx_dbg(dev_ctx, "IOCTL %.8x not supported\n", cmd);
> +	}
> +
> +	up(&dev_ctx->fops_lock);
> +	return (long)err;
> +}
> +
> +/* Char driver setup */
> +static const struct file_operations ele_mu_fops = {
> +	.open		= ele_mu_fops_open,
> +	.owner		= THIS_MODULE,
> +	.release	= ele_mu_fops_close,
> +	.unlocked_ioctl = ele_mu_ioctl,
> +	.read		= ele_mu_fops_read,
> +	.write		= ele_mu_fops_write,
> +};
> +
> +/* interface for managed res to free a mailbox channel */
> +static void if_mbox_free_channel(void *mbox_chan)
> +{
> +	mbox_free_channel(mbox_chan);
> +}
> +
> +/* interface for managed res to unregister a char device */
> +static void if_misc_deregister(void *miscdevice)
> +{
> +	misc_deregister(miscdevice);
> +}
> +
> +static int ele_mu_request_channel(struct device *dev,
> +				 struct mbox_chan **chan,
> +				 struct mbox_client *cl,
> +				 const char *name)
> +{
> +	struct mbox_chan *t_chan;
> +	int ret = 0;
> +
> +	t_chan = mbox_request_channel_byname(cl, name);
> +	if (IS_ERR(t_chan)) {
> +		ret = PTR_ERR(t_chan);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev,
> +				"Failed to request chan %s ret %d\n", name,
> +				ret);
> +		goto exit;
> +	}
> +
> +	ret = devm_add_action(dev, if_mbox_free_channel, t_chan);
> +	if (ret) {
> +		dev_err(dev, "failed to add devm removal of mbox %s\n",
> name);
> +		goto exit;
> +	}
> +
> +	*chan = t_chan;
> +
> +exit:
> +	return ret;
> +}
> +
> +static int ele_probe_cleanup(struct platform_device *pdev)
> +{
> +	int ret;
> +	int i;
> +	struct device *dev = &pdev->dev;
> +	struct ele_mu_priv *priv = dev_get_drvdata(dev);
> +
> +	if (!priv) {
> +		ret = -EINVAL;
> +		dev_err(dev, "Invalid ELE-MU Priv data");
> +		return ret;
> +	}
> +
> +	if (priv->tx_chan)
> +		mbox_free_channel(priv->tx_chan);
> +	if (priv->rx_chan)
> +		mbox_free_channel(priv->rx_chan);
> +
> +	/* free the buffer in ele-mu remove, previously allocated
> +	 * in ele-mu probe to store encrypted IMEM
> +	 */
> +	if (priv->imem.buf) {
> +		dmam_free_coherent(&pdev->dev,
> +				   ELE_IMEM_SIZE,
> +				   priv->imem.buf,
> +				   priv->imem.phyaddr);
> +		priv->imem.buf = NULL;
> +	}
> +
> +	if (priv->flags & RESERVED_DMA_POOL) {
> +		of_reserved_mem_device_release(dev);
> +		priv->flags &= (~RESERVED_DMA_POOL);
> +	}
> +	if (priv->ctxs) {
> +		for (i = 0; i < priv->max_dev_ctx; i++) {
> +			if (priv->ctxs[i])
> +				devm_kfree(dev, priv->ctxs[i]);
> +		}
> +		devm_kfree(dev, priv->ctxs);
> +	}
> +	devm_kfree(dev, priv);
> +	return ret;
> +}
> +
> +static int ele_mu_probe(struct platform_device *pdev)
> +{
> +	struct ele_mu_device_ctx *dev_ctx;
> +	struct device *dev = &pdev->dev;
> +	struct ele_mu_priv *priv;
> +	struct device_node *np;
> +	const struct of_device_id *of_id = of_match_device(ele_mu_match,
> dev);
> +	struct imx_info *info = (of_id != NULL) ? (struct imx_info *)of_id-
> >data
> +						: NULL;
> +	char *devname;
> +	uint32_t tmp_dt_value = 0;
> +	int ret;
> +	int i;
> +
> +	if (!info) {
> +		ret = -EINVAL;
> +		dev_err(dev, "%s: Incompatible Device.\n", __func__);
> +		return ret;
> +	}
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv) {
> +		ret = -ENOMEM;
> +		dev_err(dev, "Fail allocate mem for private data\n");
> +		return ret;
> +	}
> +	memset(priv, 0x0, sizeof(*priv));
> +	priv->dev = dev;
> +	dev_set_drvdata(dev, priv);
> +
> +	/*
> +	 * Get the address of MU to be used for communication with the SCU
> +	 */
> +	np = pdev->dev.of_node;
> +	if (!np) {
> +		dev_err(dev, "Cannot find MU User entry in device tree\n");
> +		ret = -EOPNOTSUPP;
> +		goto exit;
> +	}
> +
> +	/* Initialize the mutex. */
> +	mutex_init(&priv->mu_cmd_lock);
> +	mutex_init(&priv->mu_lock);
> +
> +	priv->cmd_receiver_dev = NULL;
> +	priv->waiting_rsp_dev = NULL;
> +
> +	ret = of_property_read_u32(np, "fsl,mu-did", &tmp_dt_value);
> +	if (ret) {
> +		ret = -EINVAL;
> +		dev_err(dev, "%s: Not able to read mu-did", __func__);
> +		goto exit;
> +	}
> +	priv->ele_mu_did = tmp_dt_value & 0xFF;
> +
> +	ret = of_property_read_u32(np, "fsl,mu-id", &tmp_dt_value);
> +	if (ret) {
> +		ret = -EINVAL;
> +		dev_err(dev, "%s: Not able to read mu-id", __func__);
> +		goto exit;
> +	}
> +	priv->ele_mu_id = tmp_dt_value & 0xFF;
> +
> +	priv->max_dev_ctx = info->max_dev_ctx;
> +
> +	priv->cmd_tag = info->cmd_tag;
> +	priv->rsp_tag = info->rsp_tag;
> +
> +	/* Mailbox client configuration */
> +	priv->ele_mb_cl.dev		= dev;
> +	priv->ele_mb_cl.tx_block	= false;
> +	priv->ele_mb_cl.knows_txdone	= true;
> +	priv->ele_mb_cl.rx_callback	= ele_mu_rx_callback;
> +
> +	ret = ele_mu_request_channel(dev, &priv->tx_chan,
> +				     &priv->ele_mb_cl, "tx");
> +	if (ret) {
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to request tx channel\n");
> +
> +		goto exit;
> +	}
> +
> +	ret = ele_mu_request_channel(dev, &priv->rx_chan,
> +				     &priv->ele_mb_cl, "rx");
> +	if (ret) {
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to request rx channel\n");
> +
> +		goto exit;
> +	}
> +
> +	priv->ctxs = devm_kzalloc(dev, sizeof(dev_ctx) * priv->max_dev_ctx,
> +				  GFP_KERNEL);
> +
> +	if (!priv->ctxs) {
> +		ret = -ENOMEM;
> +		dev_err(dev, "Fail allocate mem for private dev-ctxs.\n");
> +		goto exit;
> +	}
> +
> +	/* Create users */
> +	for (i = 0; i < priv->max_dev_ctx; i++) {
> +		dev_ctx = devm_kzalloc(dev, sizeof(*dev_ctx),
> GFP_KERNEL);
> +		if (!dev_ctx) {
> +			ret = -ENOMEM;
> +			dev_err(dev,
> +				"Fail to allocate memory for device
> context\n");
> +			goto exit;
> +		}
> +
> +		dev_ctx->dev = dev;
> +		dev_ctx->status = MU_FREE;
> +		dev_ctx->priv = priv;
> +
> +		priv->ctxs[i] = dev_ctx;
> +
> +		/* Default value invalid for an header. */
> +		init_waitqueue_head(&dev_ctx->wq);
> +
> +		INIT_LIST_HEAD(&dev_ctx->pending_out);
> +		INIT_LIST_HEAD(&dev_ctx->pending_in);
> +		sema_init(&dev_ctx->fops_lock, 1);
> +
> +		devname = devm_kasprintf(dev, GFP_KERNEL,
> "ele_mu%d_ch%d",
> +					 priv->ele_mu_id, i);
> +		if (!devname) {
> +			ret = -ENOMEM;
> +			dev_err(dev,
> +				"Fail to allocate memory for misc dev
> name\n");
> +			goto exit;
> +		}
> +
> +		dev_ctx->miscdev.name = devname;
> +		dev_ctx->miscdev.minor = MISC_DYNAMIC_MINOR;
> +		dev_ctx->miscdev.fops = &ele_mu_fops;
> +		dev_ctx->miscdev.parent = dev;
> +		ret = misc_register(&dev_ctx->miscdev);
> +		if (ret) {
> +			dev_err(dev, "failed to register misc device %d\n",
> +				ret);
> +			goto exit;
> +		}
> +
> +		ret = devm_add_action(dev, if_misc_deregister,
> +				      &dev_ctx->miscdev);
> +		if (ret) {
> +			dev_err(dev,
> +				"failed[%d] to add action to the
misc-dev\n",
> +				ret);
> +			goto exit;
> +		}
> +	}
> +
> +	init_completion(&priv->done);
> +	spin_lock_init(&priv->lock);
> +
> +	ele_priv_export = priv;
> +
> +	if (info && info->reserved_dma_ranges) {
> +		ret = of_reserved_mem_device_init(dev);
> +		if (ret) {
> +			dev_err(dev,
> +				"failed to init reserved memory region
%d\n",
> +				ret);
> +			priv->flags &= (~RESERVED_DMA_POOL);
> +			goto exit;
> +		}
> +		priv->flags |= RESERVED_DMA_POOL;
> +	}
> +
> +	if (info && info->init_fw) {
> +		/* start initializing ele fw */
> +		ret = ele_init_fw();
> +		if (ret)
> +			dev_err(dev, "Failed to initialize ele fw.\n");
> +	}
> +
> +	if (info && info->socdev) {
> +		ret = imx_soc_device_register(pdev, info);
> +		if (ret) {
> +			dev_err(dev,
> +				"failed[%d] to register SoC device\n", ret);
> +			goto exit;
> +		}
> +	}
> +
> +	if (info && info->imem_mgmt) {
> +		/* allocate buffer where ELE store encrypted IMEM */
> +		priv->imem.buf = dmam_alloc_coherent(dev,
> ELE_IMEM_SIZE,
> +						     &priv->imem.phyaddr,
> +						     GFP_KERNEL);
> +		if (!priv->imem.buf) {
> +			dev_err(dev,
> +				"dmam-alloc-failed: To store encr-IMEM.\n");
> +			ret = -ENOMEM;
> +			goto exit;
> +		}
> +	}
> +
> +	/* start ele rng */
> +	ret = ele_do_start_rng();
> +	if (ret)
> +		dev_err(dev, "Failed to start ele rng\n");
> +
> +	if (!ret && info && info->enable_ele_trng) {
> +		ret = ele_trng_init(dev);
> +		if (ret)
> +			dev_err(dev, "Failed to init ele-trng\n");
> +	}
> +
> +	/*
> +	 * A ELE ping request must be send at least once every day(24
hours),
> +	 * so setup a delay work with 1 hour interval
> +	 * to ping ELE periodically.
> +	 */
> +	schedule_delayed_work(&ele_ping_work, ELE_PING_INTERVAL);
> +
> +	dev_set_drvdata(dev, priv);
> +
> +	pr_info("Misc-devices on i.MX enclave MU is configured.\n");
> +	return devm_of_platform_populate(dev);
> +
> +exit:
> +	/* if execution control reaches here, ele-mu probe fail.
> +	 * hence doing the cleanup
> +	 */
> +	return ele_probe_cleanup(pdev);
> +}
> +
> +static int ele_mu_remove(struct platform_device *pdev)
> +{
> +	cancel_delayed_work_sync(&ele_ping_work);
> +	ele_probe_cleanup(pdev);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int ele_mu_suspend(struct device *dev)
> +{
> +	struct ele_mu_priv *priv = dev_get_drvdata(dev);
> +	const struct of_device_id *of_id = of_match_device(ele_mu_match,
> dev);
> +	struct imx_info *info = (of_id != NULL) ? (struct imx_info *)of_id-
> >data
> +						: NULL;
> +
> +	if (info && info->imem_mgmt) {
> +		int ret;
> +
> +		/* EXPORT command will save encrypted IMEM to given
> address,
> +		 * so later in resume, IMEM can be restored from the given
> +		 * address.
> +		 *
> +		 * Size must be at least 64 kB.
> +		 */
> +		ret = ele_service_swap(priv->imem.phyaddr,
> +				       ELE_IMEM_SIZE,
> +				       ELE_IMEM_EXPORT);
> +		if (ret < 0)
> +			dev_err(dev, "Failed to export IMEM\n");
> +		else {
> +			priv->imem.size = ret;
> +			dev_info(dev,
> +				 "Exported %d bytes of encrypted IMEM\n",
> +				 ret);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int ele_mu_resume(struct device *dev)
> +{
> +	struct ele_mu_priv *priv = dev_get_drvdata(dev);
> +	int i;
> +	const struct of_device_id *of_id = of_match_device(ele_mu_match,
> dev);
> +	struct imx_info *info = (of_id != NULL) ? (struct imx_info *)of_id-
> >data
> +						: NULL;
> +
> +	for (i = 0; i < priv->max_dev_ctx; i++)
> +		wake_up_interruptible(&priv->ctxs[i]->wq);
> +
> +	if (info && info->imem_mgmt) {
> +		int ret;
> +		u32 imem_state;
> +		u32 *get_info_buf = NULL;
> +		phys_addr_t get_info_phyaddr = 0;
> +
> +		get_info_phyaddr
> +			= (info->pool_name) ?
> get_phy_buf_mem_pool(dev->of_node,
> +						     info->pool_name,
> +						     &get_info_buf,
> +						     DEVICE_GET_INFO_SZ)
> +					    : 0x0;
> +
> +		if (!get_info_buf) {
> +			dev_err(dev, "Unable to alloc sram from sram
> pool\n");
> +			return -ENOMEM;
> +		}
> +
> +		ret = ele_do_start_rng();
> +		if (ret)
> +			goto exit;
> +
> +		/* get info from ELE */
> +		ret = ele_get_info(get_info_phyaddr,
> ELE_GET_INFO_READ_SZ);
> +		if (ret) {
> +			dev_err(dev, "Failed to get info from ELE.\n");
> +			goto exit;
> +		}
> +
> +		/* Get IMEM state, if 0xFE then import IMEM */
> +		imem_state = (get_info_buf[ELE_IMEM_STATE_WORD]
> +				& ELE_IMEM_STATE_MASK) >> 16;
> +		if (imem_state == ELE_IMEM_STATE_BAD) {
> +			/* IMPORT command will restore IMEM from the
> given
> +			 * address, here size is the actual size returned by
ELE
> +			 * during the export operation
> +			 */
> +			ret = ele_service_swap(priv->imem.phyaddr,
> +					       priv->imem.size,
> +					       ELE_IMEM_IMPORT);
> +			if (ret) {
> +				dev_err(dev, "Failed to import IMEM\n");
> +				goto exit;
> +			}
> +		} else
> +			goto exit;
> +
> +		/* After importing IMEM, check if IMEM state is equal to
> 0xCA
> +		 * to ensure IMEM is fully loaded and
> +		 * ELE functionality can be used.
> +		 */
> +		ret = ele_get_info(get_info_phyaddr,
> ELE_GET_INFO_READ_SZ);
> +		if (ret) {
> +			dev_err(dev, "Failed to get info from ELE.\n");
> +			goto exit;
> +		}
> +
> +		imem_state = (get_info_buf[ELE_IMEM_STATE_WORD]
> +				& ELE_IMEM_STATE_MASK) >> 16;
> +		if (imem_state == ELE_IMEM_STATE_OK)
> +			dev_info(dev, "Successfully restored IMEM\n");
> +		else
> +			dev_err(dev, "Failed to restore IMEM\n");
> +
> +exit:
> +		if (info->pool_name && get_info_buf)
> +			free_phybuf_mem_pool(dev->of_node, info-
> >pool_name,
> +					     get_info_buf,
> DEVICE_GET_INFO_SZ);
> +	}
> +
> +	return 0;
> +}
> +#endif
> +
> +static const struct dev_pm_ops ele_mu_pm = {
> +	SET_SYSTEM_SLEEP_PM_OPS(ele_mu_suspend, ele_mu_resume)
> +};
> +
> +static struct platform_driver ele_mu_driver = {
> +	.driver = {
> +		.name = "fsl-ele-mu",
> +		.of_match_table = ele_mu_match,
> +		.pm = &ele_mu_pm,
> +	},
> +	.probe = ele_mu_probe,
> +	.remove = ele_mu_remove,
> +};
> +MODULE_DEVICE_TABLE(of, ele_mu_match);
> +
> +module_platform_driver(ele_mu_driver);
> +
> +MODULE_AUTHOR("Pankaj Gupta <pankaj.gupta@nxp.com>");
> +MODULE_DESCRIPTION("iMX Secure Enclave MU Driver.");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/firmware/imx/se_fw.h b/drivers/firmware/imx/se_fw.h
> new file mode 100644
> index 000000000000..a606a49cb60f
> --- /dev/null
> +++ b/drivers/firmware/imx/se_fw.h
> @@ -0,0 +1,180 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2021-2023 NXP
> + */
> +
> +#ifndef SE_MU_H
> +#define SE_MU_H
> +
> +#include <linux/miscdevice.h>
> +#include <linux/semaphore.h>
> +#include <linux/mailbox_client.h>
> +
> +/* macro to log operation of a misc device */
> +#define miscdev_dbg(p_miscdev, fmt, va_args...)
\
> +	({
\
> +		struct miscdevice *_p_miscdev = p_miscdev;
\
> +		dev_dbg((_p_miscdev)->parent, "%s: " fmt, (_p_miscdev)-
> >name,  \
> +		##va_args);
\
> +	})
> +
> +#define miscdev_info(p_miscdev, fmt, va_args...)
\
> +	({
\
> +		struct miscdevice *_p_miscdev = p_miscdev;
\
> +		dev_info((_p_miscdev)->parent, "%s: " fmt, (_p_miscdev)-
> >name, \
> +		##va_args);
\
> +	})
> +
> +#define miscdev_err(p_miscdev, fmt, va_args...)
\
> +	({
\
> +		struct miscdevice *_p_miscdev = p_miscdev;
\
> +		dev_err((_p_miscdev)->parent, "%s: " fmt, (_p_miscdev)-
> >name,  \
> +		##va_args);
\
> +	})
> +/* macro to log operation of a device context */
> +#define devctx_dbg(p_devctx, fmt, va_args...) \
> +	miscdev_dbg(&((p_devctx)->miscdev), fmt, ##va_args)
> +#define devctx_info(p_devctx, fmt, va_args...) \
> +	miscdev_info(&((p_devctx)->miscdev), fmt, ##va_args)
> +#define devctx_err(p_devctx, fmt, va_args...) \
> +	miscdev_err((&(p_devctx)->miscdev), fmt, ##va_args)
> +
> +#define MAX_MESSAGE_SIZE		31
> +#define MAX_RECV_SIZE			MAX_MESSAGE_SIZE
> +#define MAX_RECV_SIZE_BYTES		(MAX_RECV_SIZE << 2)
> +#define MAX_MESSAGE_SIZE_BYTES		(MAX_MESSAGE_SIZE << 2)
> +#define ELE_SUCCESS_IND			0xD6
> +#define ELE_FAILURE_IND			0x29
> +
> +#define ELE_MSG_DATA_NUM		10
> +
> +#define MSG_TAG(x)			(((x) & 0xff000000) >> 24)
> +#define MSG_COMMAND(x)			(((x) & 0x00ff0000) >> 16)
> +#define MSG_SIZE(x)			(((x) & 0x0000ff00) >> 8)
> +#define MSG_VER(x)			((x) & 0x000000ff)
> +#define RES_STATUS(x)			((x) & 0x000000ff)
> +#define MAX_DATA_SIZE_PER_USER		(65 * 1024)
> +#define S4_DEFAULT_MUAP_INDEX		(2)
> +#define S4_MUAP_DEFAULT_MAX_USERS	(4)
> +
> +#define DEFAULT_MESSAGING_TAG_COMMAND           (0x17u)
> +#define DEFAULT_MESSAGING_TAG_RESPONSE          (0xe1u)
> +
> +#define ELE_MU_IO_FLAGS_USE_SEC_MEM	(0x02u)
> +#define ELE_MU_IO_FLAGS_USE_SHORT_ADDR	(0x04u)
> +
> +struct ele_imem_buf {
> +	u8 *buf;
> +	phys_addr_t phyaddr;
> +	u32 size;
> +};
> +
> +struct ele_buf_desc {
> +	u8 *shared_buf_ptr;
> +	u8 *usr_buf_ptr;
> +	u32 size;
> +	struct list_head link;
> +};
> +
> +/* Status of a char device */
> +enum mu_device_status_t {
> +	MU_FREE,
> +	MU_OPENED
> +};
> +
> +struct ele_shared_mem {
> +	dma_addr_t dma_addr;
> +	u32 size;
> +	u32 pos;
> +	u8 *ptr;
> +};
> +
> +/* Private struct for each char device instance. */
> +struct ele_mu_device_ctx {
> +	struct device *dev;
> +	struct ele_mu_priv *priv;
> +	struct miscdevice miscdev;
> +
> +	enum mu_device_status_t status;
> +	wait_queue_head_t wq;
> +	struct semaphore fops_lock;
> +
> +	u32 pending_hdr;
> +	struct list_head pending_in;
> +	struct list_head pending_out;
> +
> +	struct ele_shared_mem secure_mem;
> +	struct ele_shared_mem non_secure_mem;
> +
> +	u32 temp_cmd[MAX_MESSAGE_SIZE];
> +	u32 temp_resp[MAX_RECV_SIZE];
> +	u32 temp_resp_size;
> +	struct notifier_block ele_notify;
> +};
> +
> +/* Header of the messages exchange with the EdgeLock Enclave */
> +struct mu_hdr {
> +	u8 ver;
> +	u8 size;
> +	u8 command;
> +	u8 tag;
> +}  __packed;
> +
> +#define ELE_MU_HDR_SZ	4
> +#define TAG_OFFSET	(ELE_MU_HDR_SZ - 1)
> +#define CMD_OFFSET	(ELE_MU_HDR_SZ - 2)
> +#define SZ_OFFSET	(ELE_MU_HDR_SZ - 3)
> +#define VER_OFFSET	(ELE_MU_HDR_SZ - 4)
> +
> +struct ele_api_msg {
> +	u32 header; /* u8 Tag; u8 Command; u8 Size; u8 Ver; */
> +	u32 data[ELE_MSG_DATA_NUM];
> +};
> +
> +struct ele_mu_priv {
> +	struct ele_mu_device_ctx *cmd_receiver_dev;
> +	struct ele_mu_device_ctx *waiting_rsp_dev;
> +	/*
> +	 * prevent parallel access to the MU registers
> +	 * e.g. a user trying to send a command while the other one is
> +	 * sending a response.
> +	 */
> +	struct mutex mu_lock;
> +	/*
> +	 * prevent a command to be sent on the MU while another one is still
> +	 * processing. (response to a command is allowed)
> +	 */
> +	struct mutex mu_cmd_lock;
> +	struct device *dev;
> +	u8 ele_mu_did;
> +	u8 ele_mu_id;
> +	u8 cmd_tag;
> +	u8 rsp_tag;
> +
> +	struct mbox_client ele_mb_cl;
> +	struct mbox_chan *tx_chan, *rx_chan;
> +	struct ele_api_msg tx_msg, rx_msg;
> +	struct completion done;
> +	spinlock_t lock;
> +	/* Flag to retain the state of initialization done at
> +	 * the time of ele-mu probe.
> +	 */
> +	uint32_t flags;
> +	u8 max_dev_ctx;
> +	struct ele_mu_device_ctx **ctxs;
> +	struct ele_imem_buf imem;
> +};
> +
> +int get_ele_mu_priv(struct ele_mu_priv **export);
> +
> +int imx_ele_msg_send_rcv(struct ele_mu_priv *priv);
> +#ifdef CONFIG_IMX_ELE_TRNG
> +int ele_trng_init(struct device *dev);
> +#else
> +static inline int ele_trng_init(struct device *dev)
> +{
> +	return 0;
> +}
> +#endif
> +
> +#endif
> diff --git a/include/linux/firmware/imx/ele_base_msg.h
> b/include/linux/firmware/imx/ele_base_msg.h
> new file mode 100644
> index 000000000000..d344820bbe7f
> --- /dev/null
> +++ b/include/linux/firmware/imx/ele_base_msg.h
> @@ -0,0 +1,62 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2021 NXP
> + *
> + * Header file for the ELE Base API(s).
> + */
> +
> +#ifndef ELE_BASE_MSG_H
> +#define ELE_BASE_MSG_H
> +
> +#include <linux/types.h>
> +
> +#define WORD_SZ				4
> +#define MESSAGING_VERSION_7		0x7
> +#define ELE_NONE_VAL			0x0
> +
> +#define ELE_PING_REQ			0x1
> +#define ELE_PING_REQ_MSG_SZ		0x02
> +
> +#define ELE_OEM_CNTN_AUTH_REQ		0x87
> +#define ELE_VERIFY_IMAGE_REQ		0x88
> +#define ELE_RELEASE_CONTAINER_REQ	0x89
> +
> +#define ELE_READ_FUSE_REQ		0x97
> +#define ELE_READ_FUSE_RSP_MSG_SZ	0x07
> +#define ELE_READ_FUSE_REQ_MSG_SZ	0x03
> +
> +#define OTP_UNIQ_ID			0x01
> +#define OTFAD_CONFIG			0x2
> +
> +#define ELE_GET_INFO_REQ                0xDA
> +#define ELE_GET_INFO_REQ_MSG_SZ		0x02
> +
> +#define ELE_SERVICE_SWAP_REQ		0xDF
> +#define ELE_SERVICE_SWAP_REQ_MSG_SZ	0x03
> +
> +#define ELE_START_RNG_REQ		0xA3
> +#define ELE_START_RNG_REQ_MSG_SZ	0x02
> +
> +#define ELE_GET_TRNG_STATE_REQ		0xA4
> +#define ELE_GET_TRNG_STATE_REQ_MSG_SZ	0x03
> +
> +#define ELE_GET_RANDOM_REQ		0xCD
> +#define CSAL_TRNG_STATE_MASK		0x0000ffff
> +
> +#define ELE_BASE_API_VERSION		0x6
> +#define ELE_SUCCESS_IND			0xD6
> +#define ELE_FAILURE_IND			0x29
> +
> +#define ELE_MSG_DATA_NUM		10
> +
> +#define ELE_IMEM_EXPORT			0x1
> +#define ELE_IMEM_IMPORT			0x2
> +
> +int read_common_fuse(uint16_t fuse_index, u32 *value);
> +int ele_ping(void);
> +int ele_get_info(phys_addr_t addr, u32 data_size);
> +int ele_service_swap(phys_addr_t addr, u32 addr_size, u16 flag);
> +int ele_start_rng(void);
> +int ele_get_trng_state(void);
> +
> +#endif
> diff --git a/include/linux/firmware/imx/ele_fw_api.h
> b/include/linux/firmware/imx/ele_fw_api.h
> new file mode 100644
> index 000000000000..74108c7be4a8
> --- /dev/null
> +++ b/include/linux/firmware/imx/ele_fw_api.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2023 NXP
> + */
> +
> +#ifndef ELE_FW_API_H
> +#define ELE_FW_API_H
> +
> +#include <linux/hw_random.h>
> +
> +#define MESSAGING_VERSION_7		0x7
> +
> +#define ELE_INIT_FW_REQ                 0x17
> +#define ELE_GET_RANDOM_REQ		0xCD
> +
> +int ele_get_random(struct hwrng *rng, void *data, size_t len, bool wait);
> +int ele_init_fw(void);
> +
> +#endif /* ELE_FW_API_H */
> diff --git a/include/linux/firmware/imx/ele_mu_ioctl.h
> b/include/linux/firmware/imx/ele_mu_ioctl.h
> new file mode 100644
> index 000000000000..3ad93ded23ed
> --- /dev/null
> +++ b/include/linux/firmware/imx/ele_mu_ioctl.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR BSD-3-
> Clause*/
> +/*
> + * Copyright 2019-2022 NXP
> + */
> +
> +#ifndef ELE_MU_IOCTL_H
> +#define ELE_MU_IOCTL_H
> +
> +/* IOCTL definitions. */
> +
> +struct ele_mu_ioctl_setup_iobuf {
> +	u8 *user_buf;
> +	u32 length;
> +	u32 flags;
> +	u64 ele_addr;
> +};
> +
> +struct ele_mu_ioctl_shared_mem_cfg {
> +	u32 base_offset;
> +	u32 size;
> +};
> +
> +struct ele_mu_ioctl_get_mu_info {
> +	u8 ele_mu_id;
> +	u8 interrupt_idx;
> +	u8 tz;
> +	u8 did;
> +};
> +
> +struct ele_mu_ioctl_signed_message {
> +	u8 *message;
> +	u32 msg_size;
> +	u32 error_code;
> +};
> +
> +#define ELE_MU_IO_FLAGS_IS_OUTPUT	(0x00u)
> +#define ELE_MU_IO_FLAGS_IS_INPUT	(0x01u)
> +#define ELE_MU_IO_FLAGS_USE_SEC_MEM	(0x02u)
> +#define ELE_MU_IO_FLAGS_USE_SHORT_ADDR	(0x04u)
> +#define ELE_MU_IO_FLAGS_IS_IN_OUT	(0x08u)
> +
> +#define ELE_MU_IOCTL			0x0A /* like MISC_MAJOR. */
> +#define ELE_MU_IOCTL_ENABLE_CMD_RCV	_IO(ELE_MU_IOCTL, 0x01)
> +#define ELE_MU_IOCTL_SHARED_BUF_CFG	_IOW(ELE_MU_IOCTL, 0x02, \
> +					struct
> ele_mu_ioctl_shared_mem_cfg)
> +#define ELE_MU_IOCTL_SETUP_IOBUF	_IOWR(ELE_MU_IOCTL, 0x03,
> \
> +					struct ele_mu_ioctl_setup_iobuf)
> +#define ELE_MU_IOCTL_GET_MU_INFO	_IOR(ELE_MU_IOCTL, 0x04, \
> +					struct ele_mu_ioctl_get_mu_info)
> +#define ELE_MU_IOCTL_SIGNED_MESSAGE	_IOWR(ELE_MU_IOCTL, 0x05,
> \
> +					struct ele_mu_ioctl_signed_message)
> +#endif
> --
> 2.34.1


------=_NextPart_000_0509_01D9CEB2.742320A0
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIg+jCCBaIw
ggOKoAMCAQICCE4Rpu+H69FRMA0GCSqGSIb3DQEBCwUAMGUxIjAgBgNVBAMMGU5YUCBJbnRlcm5h
bCBQb2xpY3kgQ0EgRzIxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJ
RWluZGhvdmVuMQswCQYDVQQGEwJOTDAeFw0yMzA0MjEwNjQzNDVaFw0yODA0MTkwNjQzNDVaMIG2
MRwwGgYDVQQDDBNOWFAgRW50ZXJwcmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQ
IEIuVi4xEjAQBgNVBAcMCUVpbmRob3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmS
JomT8ixkARkWA3diaTETMBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTEL
MAkGA1UEBhMCTkwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDAWrnSkYP60A8wj4AO
kATDjnbdgLv6waFfyXE/hvatdWz2YYtb1YSRi5/wXW+Pz8rsTmSj7iusI+FcLP8WEaMVLn4sEIQY
NI8KJUCz21tsIArYs0hMKEUFeCq3mxTJfPqzdj9CExJBlZ5vWS4er8eJI8U8kZrt4CoY7De0FdJh
35Pi5QGzUFmFuaLgXfV1N5yukTzEhqz36kODoSRw+eDHH9YqbzefzEHK9d93TNiLaVlln42O0qaI
MmxK1aNcZx+nQkFsF/VrV9M9iLGA+Qb/MFmR20MJAU5kRGkJ2/QzgVQM3Nlmp/bF/3HWOJ2j2mpg
axvzxHNN+5rSNvkG2vSpAgMBAAGjggECMIH/MFIGCCsGAQUFBwEBBEYwRDBCBggrBgEFBQcwAoY2
aHR0cDovL253dy5wa2kubnhwLmNvbS9jZXJ0cy9OWFBJbnRlcm5hbFBvbGljeUNBRzIuY2VyMB0G
A1UdDgQWBBRYlWDuTnTvZSKqve0ZqSt6jhedBzASBgNVHRMBAf8ECDAGAQH/AgEAMEUGA1UdHwQ+
MDwwOqA4oDaGNGh0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEludGVybmFsUG9saWN5Q0FH
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
HwYDVR0jBBgwFoAUWJVg7k5072Uiqr3tGakreo4XnQcwggFGBgNVHR8EggE9MIIBOTCCATWgggEx
oIIBLYaByGxkYXA6Ly8vQ049TlhQJTIwRW50ZXJwcmlzZSUyMENBJTIwNSxDTj1OTEFNU1BLSTAw
MDUsQ049Q0RQLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZp
Z3VyYXRpb24sREM9d2JpLERDPW54cCxEQz1jb20/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9i
YXNlP29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlvblBvaW50hi9odHRwOi8vbnd3LnBraS5ueHAu
Y29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybIYvaHR0cDovL3d3dy5wa2kubnhwLmNvbS9jcmwv
TlhQRW50ZXJwcmlzZUNBNS5jcmwwggEQBggrBgEFBQcBAQSCAQIwgf8wgbsGCCsGAQUFBzAChoGu
bGRhcDovLy9DTj1OWFAlMjBFbnRlcnByaXNlJTIwQ0ElMjA1LENOPUFJQSxDTj1QdWJsaWMlMjBL
ZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPXdiaSxEQz1ueHAs
REM9Y29tP2NBQ2VydGlmaWNhdGU/YmFzZT9vYmplY3RDbGFzcz1jZXJ0aWZpY2F0aW9uQXV0aG9y
aXR5MD8GCCsGAQUFBzAChjNodHRwOi8vbnd3LnBraS5ueHAuY29tL2NlcnRzL05YUC1FbnRlcnBy
aXNlLUNBNS5jcnQwDQYJKoZIhvcNAQELBQADggEBAEEfsA0F+xNIIHRidw1YMWKTkWBmsGRri99r
6fQ1dL6dBG2KEsPRiF9y/Uf7jadR12HglTbmWUM5xdqxCWqf4UAxQDH1OoXn2xdvaP4ApmIMI2i8
Wwa8yJT8fBdmQQn5NEfqu9zPpfQL4NHEmvUqgXMhZzsa2dGrJoX/oNe7zw2UPnUNL+KB6B7N/P3o
Pupu18TuxAMIKYnGr+cb4Xx6iecFuncI7OLu3t/AkwUYtUYO/H8tr1E8YSj52rlSPb8xAD6VHGxm
daNqC79xMXbXx7SdgzRkb8kJKBTQhNcYz1xmsGTtP5ZE9FE8m8MgRq5Bh+7q8TWzMdeA9mIQIDE0
qOwwggg4MIIHIKADAgECAhMtAApIQhnEGx1xgCPsAAEACkhCMA0GCSqGSIb3DQEBCwUAMIG2MRww
GgYDVQQDDBNOWFAgRW50ZXJwcmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIu
Vi4xEjAQBgNVBAcMCUVpbmRob3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmSJomT
8ixkARkWA3diaTETMBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTELMAkG
A1UEBhMCTkwwHhcNMjMwODA5MDk0ODE0WhcNMjUwODA4MDk0ODE0WjCBmjETMBEGCgmSJomT8ixk
ARkWA2NvbTETMBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA3diaTEMMAoGA1UE
CxMDTlhQMQswCQYDVQQLEwJJTjEWMBQGA1UECxMNTWFuYWdlZCBVc2VyczETMBEGA1UECxMKRGV2
ZWxvcGVyczERMA8GA1UEAxMIbnhhMDY0NzUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
AQC4HbZ3M7z3dSiGvIB/e1S8Vk9d1Ll7qBV5X9aGUQ4ufPKfd+3PLNCVmKGnzlULLKuZGhZdGWgL
6ICnJYksySHcRhfMaaX3r7Cp/M/Y2JCqaf2baJ5wtwq5IHfGWBj4XL1E7tv6Z3UzGdnAsxis2MjV
FvdzqS5w5qgI52pkmVXpHqUn2bazRlkXnIYbhSQZL4hZf7kzJGlgJmQyWYbr51PMWyn/JHfSEVjz
GgghaLLdZU9rEm3x0rvAV/GZCTJPp/lrpHHA/SC+CFteDosHoDTHqN4mlV7zfg/sAKy4QEnMmlHq
jQXxx00DiwyjTzg/7ZvEVVvo0GUBVl8aMtGGujHFAgMBAAGjggRXMIIEUzA8BgkrBgEEAYI3FQcE
LzAtBiUrBgEEAYI3FQiFgsB+gY70VYbthTiC65lLmpJWP4Xmim6EteF+AgFkAgE7MBMGA1UdJQQM
MAoGCCsGAQUFBwMEMA4GA1UdDwEB/wQEAwIFIDAMBgNVHRMBAf8EAjAAMBsGCSsGAQQBgjcVCgQO
MAwwCgYIKwYBBQUHAwQwgZQGCSqGSIb3DQEJDwSBhjCBgzALBglghkgBZQMEASowCwYJYIZIAWUD
BAEtMAsGCWCGSAFlAwQBFjALBglghkgBZQMEARkwCwYJYIZIAWUDBAECMAsGCWCGSAFlAwQBBTAK
BggqhkiG9w0DBzAHBgUrDgMCBzAOBggqhkiG9w0DAgICAIAwDgYIKoZIhvcNAwQCAgIAMDsGA1Ud
EQQ0MDKgHwYKKwYBBAGCNxQCA6ARDA9WLlNldGhpQG54cC5jb22BD1YuU2V0aGlAbnhwLmNvbTAd
BgNVHQ4EFgQU02lKsh6BFAv1r0HH4kII7jSbHEwwHwYDVR0jBBgwFoAUWJVg7k5072Uiqr3tGakr
eo4XnQcwggFGBgNVHR8EggE9MIIBOTCCATWgggExoIIBLYaByGxkYXA6Ly8vQ049TlhQJTIwRW50
ZXJwcmlzZSUyMENBJTIwNSxDTj1OTEFNU1BLSTAwMDUsQ049Q0RQLENOPVB1YmxpYyUyMEtleSUy
MFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9d2JpLERDPW54cCxEQz1j
b20/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENsYXNzPWNSTERpc3RyaWJ1
dGlvblBvaW50hi9odHRwOi8vbnd3LnBraS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNy
bIYvaHR0cDovL3d3dy5wa2kubnhwLmNvbS9jcmwvTlhQRW50ZXJwcmlzZUNBNS5jcmwwggEQBggr
BgEFBQcBAQSCAQIwgf8wgbsGCCsGAQUFBzAChoGubGRhcDovLy9DTj1OWFAlMjBFbnRlcnByaXNl
JTIwQ0ElMjA1LENOPUFJQSxDTj1QdWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxD
Tj1Db25maWd1cmF0aW9uLERDPXdiaSxEQz1ueHAsREM9Y29tP2NBQ2VydGlmaWNhdGU/YmFzZT9v
YmplY3RDbGFzcz1jZXJ0aWZpY2F0aW9uQXV0aG9yaXR5MD8GCCsGAQUFBzAChjNodHRwOi8vbnd3
LnBraS5ueHAuY29tL2NlcnRzL05YUC1FbnRlcnByaXNlLUNBNS5jZXIwUQYJKwYBBAGCNxkCBEQw
QqBABgorBgEEAYI3GQIBoDIEMFMtMS01LTIxLTE5MTUyMDcwMTMtMjYxNTA0MDM2OC0zMDc2OTI5
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
gwQAv8jN0eIGoEYAAAAAAAA=

------=_NextPart_000_0509_01D9CEB2.742320A0--
