Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E0B782ADB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbjHUNv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 09:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbjHUNvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:51:24 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BB2BC;
        Mon, 21 Aug 2023 06:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692625882; x=1724161882;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TEWqR1JLO8eErfCPcDmN+7QmZh2zBIlQ28CDK73TsjE=;
  b=GcygPfVhDSV0bXicJU6G47iQfwFcl/V7x1q3NA3HtT3rynoi4Ebkm/4m
   B9STJH+zWRJ4Q31LjQiYL9ejyPBC0IR/xvLhMZZs/DuskXhLOmyIj4fDl
   EScwvW92G9ra0rdT9n8+GbnmYkVsrqiGMx4maiDPowqKNIYN3p96T03G+
   MS9cGfFq/sKU8qBeoPog7I65bRCUT6WiTowDPp/EDza987dQwUK7mfuzZ
   kaFwGqZRlQcR7Im1qS3WAkOp71F2XTF0OBZlvJ/ZlYxYUzEpwDcYRol1V
   RRWe4HWh2VKmJNN0hXKZ+9dKRB2sqDoElx15XXQbQ0569KSGOviN+2tWa
   g==;
X-IronPort-AV: E=Sophos;i="6.01,190,1684771200"; 
   d="scan'208";a="242030426"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 21 Aug 2023 21:51:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dowydE9sYOnidtUlorNqySOWCCHA0SRmfj3hhGromrHje14QV7L8LUvflv+cXOfYIJU4h39irPjEImLp9WC1QErK+eqMauAjGvcPD6XXdD52FMdz6AazsZcTncJ57fcEvozCgSy5pChs17eA93eI+4XSYtnyPvRhWw+Cod5Ez2kblkL12VnuMAgv3VFQaU1YMgAbfu9iNE7SRWKtVJlDGQVtUCg70Y6sG/o7duSnifV8VsfBDiYH5o/3IFFuRWfhUOCC3ul/zUYJy3sgdeeyZgds5HvJn7HsKGSnpC0rHG4EXiDuryDQurYa/WFSbu68CjeIG6eFwuAZUgQ2R/TZLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTe+yQpZXQVCqIrC5CqOpExxxYApSANXEkTMkvDwwoo=;
 b=L7oKMvkBzAGfdtNAUeJsDadrvyiDmYT6tXQo3MMcuNgHJePv57Elr1R5YTIEQs4plR6/TBZulE/P7sI5dOqzZpqpIosCn9/0rBBwwugMX+DAGZ8F3OSih75GUl3QNT4ZMrIJXEHRGtzxRj+FT0UDNQEFa0TDJQHDiucrbq1r9wZ6VU2QWvGqGocyrY3tuOzZ+uOTggbUxKj3mD7ODAXTpi7m9oMbXPsNgjOh85cHKEzfifS44BZH+LDiEc66FvuVTiEQ15kG6xtOOw2FKawIQMZIC3xfcmLDSS0ANmB+QTpAcCNYSi1utCX4ZSXjd7YkVp2F6SEYtFQt6LnUs5Pd9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTe+yQpZXQVCqIrC5CqOpExxxYApSANXEkTMkvDwwoo=;
 b=RcYrG/tCey9IimmasihIN/BhBy2ZaEYbxZR1EfrmaObdABYT3zKnMC0O+sgPfgedflVikAfC3eXtR0f/umpNeO3bPDZkLah6pLCWtngRFQsgDK4gZtupnDvsy2ljeqTPdUCf/wXbwy2Wo/KOs2MBhXFcFkuRj1wAeOSFpYwM+MY=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BL3PR04MB8009.namprd04.prod.outlook.com (2603:10b6:208:344::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.14; Mon, 21 Aug
 2023 13:51:19 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d093:80b3:59e5:c8a9]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d093:80b3:59e5:c8a9%6]) with mapi id 15.20.6723.013; Mon, 21 Aug 2023
 13:51:18 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     "linan666@huaweicloud.com" <linan666@huaweicloud.com>
CC:     "dlemoal@kernel.org" <dlemoal@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linan122@huawei.com" <linan122@huawei.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "houtao1@huawei.com" <houtao1@huawei.com>,
        "yangerkun@huawei.com" <yangerkun@huawei.com>
Subject: Re: [PATCH] scsi: ata: Fix a race condition between scsi error
 handler and ahci interrupt
Thread-Topic: [PATCH] scsi: ata: Fix a race condition between scsi error
 handler and ahci interrupt
Thread-Index: AQHZ1DaPr2epsK7l90GFuVSrpD3hog==
Date:   Mon, 21 Aug 2023 13:51:18 +0000
Message-ID: <ZONr0f26IT/QKsSu@x1-carbon>
References: <20230810014848.2148316-1-linan666@huaweicloud.com>
In-Reply-To: <20230810014848.2148316-1-linan666@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BL3PR04MB8009:EE_
x-ms-office365-filtering-correlation-id: 7c9ac0a8-29d3-40c9-cb7f-08dba24db22a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FhIgw3qvP6bK9UCAFXhT8QA4Cqgt79PZJ52pDS/+jIY1T8U519VIhtJ+hz33qyKUkPe9LZKsNWwMqdLzMu5E9/vn37jAiw9fd+i5LkvRik3O7L3hyPE7EfNRHBQBEfNdjJblqAt1rrojFhFi4NT9HzxE65hBhimn9UK8ghTwzYg3okkNVYspp0pK23VDwZvgv79yMVnR5hfCDPfi70yh/Uim+JDeFU7plOLvCnIFANCB7CT901VWgZ/rLveCjDXeVrxlv4h2zeHKBP3CqI8MB2c4lV90aH08O79awEk43u9MlFSMkLLZ9PK+g70xu/JtzUr9xiw9JyNk6bkK26C6cpgIA3b7bSewicIexgS99TcQEsWDakbqqKenre4LTMYBuYCOdxhFcAD/d4jHrCFkdZaoJrpghwJfeogp/UUGYi9uBPycmtmTJPkrLXJJrtsX+LhuhPgrZGUEqpgjXffmsystD5EPU/QL2JFengZFmIdOD5zPSrzeJ2XJK2xy/xDMJmm4u0UDtqfmw1wy2By6UTKxZpQd8MdOf0no3S5xh5Gty3yArx6EI1EjsUMMyb7fCNylqVDfl0KpDDY7djrMFusQ2Pb+y7NCuNUoR7nIxJ4BKC5nItHc0BKT+h1mGf6ItcpQj9c1LCLzketXxmVnLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(38100700002)(38070700005)(6506007)(6486002)(5660300002)(26005)(86362001)(8676002)(8936002)(4326008)(316002)(9686003)(66946007)(6512007)(64756008)(54906003)(6916009)(66446008)(66556008)(76116006)(66476007)(91956017)(82960400001)(966005)(478600001)(122000001)(71200400001)(41300700001)(33716001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4Ms++/jmgYS0g8o7D6Vmlek16CseRUJnopqqGnvqTh3cInwixIwYBkvvgy7O?=
 =?us-ascii?Q?09SSnSotaYo9LXQvKSlScf90KqqwYwKN4eNl5rAU+W7zlU6eNatr1VBU5Zzt?=
 =?us-ascii?Q?gNOoyZsSIosQTAaoZ08Gsbw5gdQyxz/dNiEhhfuHylJTSsHjkpFvYg7nN66y?=
 =?us-ascii?Q?0TaFuxBhirBc+UKE7Di1/N5+Jg8MNoslYI4gx6ueLVzhViP4U0pEvXj+rDBU?=
 =?us-ascii?Q?kZpcZuz6KCYzC5rrqKI88z7GUyKT/2CgThGW47xiXmok5w2FF5O7o+IFM49j?=
 =?us-ascii?Q?6v5Jz2tfoKR68EyfJngHkIfUyO2+kr2QKHUUNWIpWD6VXSg8v+YoXQ7sszVa?=
 =?us-ascii?Q?P4byG0oUTBt3j+dtLzXOxu2ww8Ih6cbg81CAacoeaDRsF3c/VRvxeX5BJhrw?=
 =?us-ascii?Q?1XXnFbWtpOWcluXYbZ7uZgXJo2xvMb9ooF2IGNLFJHIS8qUWAGnmy9Qw7520?=
 =?us-ascii?Q?cRLNBML3FuBNub+/PaCeq4x6EvmXvoBsYZe2MY/kRIiCcstdV+yliM1RjNZ4?=
 =?us-ascii?Q?+qjPYthX47GHPuCRkyknkAbfCe5ewzm2TyM5bVb9KIXcnGV3YEaEG0XescQw?=
 =?us-ascii?Q?hw9Jz1Jpcut1OZ6U0i2AddlUD9RiEtnI/DF+Kh0oWTprITajfKIacgK+5ywC?=
 =?us-ascii?Q?wcvcHnuXmKW8TjuBA5HPCHmfnTCmx33qgySAG7wOtXzc82tTWG4Af2G/aPJ9?=
 =?us-ascii?Q?vMvmufw1Yxrl3DzuqVGRJ1beoOmxwOq9uOKtXkpmMK/mNd2/twoV1ls4QS/H?=
 =?us-ascii?Q?2VNDs3yWx/LM9BJJ+mEShxy81OxKX2gmfU3dmcrRbNsXb7gy2yW45JNdIGSB?=
 =?us-ascii?Q?lyMefFLdrIgEAtXXu3idiiA3jDFWcE48o7Eg84Zr+RO6larMyfUxJrsldaDj?=
 =?us-ascii?Q?lTs8SX/dM7hFKr0zsV+nn+cVcW29iasKpfHVgIEUje8Yfd3GXgs4umJ6XGa4?=
 =?us-ascii?Q?V11sTb8H3JSZFFWQ7/iSgzi1AkzCWgQYOAdrYerITWUc1c3mow3zmWaCp+HY?=
 =?us-ascii?Q?6jg/ti3UUwBztgq15aQJW86HLdSaYZldGYxuafWPPFvIBb1Mm0n6B+JUxn+x?=
 =?us-ascii?Q?69Lx9HOALGu5Cu9Y01L5/qPaD2VOCGrpSmlmTvLv+tanVXk4ir+fschdw2Hp?=
 =?us-ascii?Q?mpBFSyyVsxvVjK7y0aC441BlIda+DMHsVehtSkYiapAsAMd/KBAJBOlt3x20?=
 =?us-ascii?Q?xTvG+WK4oSDu7NkDFvdcPzMXFjhK3y8QPkRWyL4imF4O3OA30lq9pnrEqlbw?=
 =?us-ascii?Q?AnqXWwsx40u+7Wi7hyRmDPsWRpjMYya0d21rYj0e3HmCOXAKoIRh/tGMjpZ8?=
 =?us-ascii?Q?gPq8Tk5ZanOwkpwBk68id2HlsFfuvFLnHBh6R659FkMxZOZZNJlnPWtyJzOL?=
 =?us-ascii?Q?7ntz/Cd8HsP6snub1UHBDtYSJUhv77AjPjnidQUqbmBrCyqx3ISFd4VrttFX?=
 =?us-ascii?Q?Erb6Qe47so0f9OwTEslZgTPZbx+DP2RFJDczgGFChf7ChFsPe3SFzpv/q81d?=
 =?us-ascii?Q?Fg1ChedHeQM0pIe8ytEyNv3zPByP7fmFIcPJXD7tBamZwaXeEiYHEK1wurk/?=
 =?us-ascii?Q?NZM+3qM8d7iF7c1PHcozfzcLTa91lmABgt1xWZGhD7DoBKTZJno36AaqypDR?=
 =?us-ascii?Q?YA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EC08F64B11430B4C817480857E698731@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QfhjErLLrkEQL71FRBXUbnfmIN/vphyqsmdJCvQUQNfj/hMpHPBv1DxWMhUx+sLDg9xYecgXqhGc2sE6QRq2/keWsYT3STWQrXaIgdD/ZzEr27+zwsmTCe2AJCBRPUdE7zHg0KdwezXfcVnGrIm0jPSEdxpg+mgYBy5+GgDrqJ/34K7WTEDlJjaVTpg78zCZnazIudymaifB6zI9dCwGcsfadMZenDbw9iRFd9pr6BpG0Y0rB7d3xWXcAfKSNN1KJzyLMHALHg072ci9biiFJOXaNOjNbVAaQsi+FnjiPKGLv2dFbBw2DfAb87i7NAHsdCN1nVoNB+Bv8ZxJrV3bqKS+Q4uNJEKasHdrYKmU5PlTclKHgS4vvQ5reNpVtI4PK+UfQRf/d+5xgDL5xIEtvLuYcnKMDk8J8ca3eHM4mU6sWk2/3ofNZQIBlbDggteMoMDSltwI4wDT3KpoY6c5ik5quACoN2LcVJJ98XAsY7BhpZd9FPQh/rkqo5arOh5P6iEmWZNnv35DLoyR1n8xYrY/WDstXXgZo/CWRnYEkgu8nI1x270OBZ3ISGr9WKuPxHkqDtgGBg2P45F0DxbaOnCnKqYrffGHCCa+rtL4bEKe8HgV9zEGbjpKTigDl/0v0W2/hzqWmkGBRmHVXHGc4PsIKa5JZD10NwS6PHbKUuqOE6Lm+IeRMVP390RIhQlHIRY8Jsd9613+vMjEzQiV5sb/G0Z4ewzgVxFDp9Wj0iCi5NyZVL4FIRaV6DSCM9CkybtMc/G3Yw8npzcomUIKjQfiUSxzXgtarKtUIOaMGGAdqHCIbfEvXTA18Z5ciQWd5mr1zariG66fTCLdmhJFWoWiffDd7qTfTDjq0t1N+ut+ffby5CNxeYXp9kUxIBPZ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c9ac0a8-29d3-40c9-cb7f-08dba24db22a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 13:51:18.8157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sCRdefl8+JRU4EI6sScgd2V1QOiFsOJkmvAPXLqCpgPWsXSB/WvkqR+A7uJ7SpGASdHMIoLMPwuYW7piKDZkyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8009
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 09:48:48AM +0800, linan666@huaweicloud.com wrote:
> From: Li Nan <linan122@huawei.com>
>=20
> interrupt                            scsi_eh
>=20
> ahci_error_intr
>   =3D>ata_port_freeze
>     =3D>__ata_port_freeze
>       =3D>ahci_freeze (turn IRQ off)
>     =3D>ata_port_abort
>       =3D>ata_port_schedule_eh
>         =3D>shost->host_eh_scheduled++;
>         host_eh_scheduled =3D 1
>                                      scsi_error_handler
>                                        =3D>ata_scsi_error
>                                          =3D>ata_scsi_port_error_handler
>                                            =3D>ahci_error_handler
>                                            . =3D>sata_pmp_error_handler
>                                            .   =3D>ata_eh_thaw_port
>                                            .     =3D>ahci_thaw (turn IRQ =
on)
> ahci_error_intr                            .
>   =3D>ata_port_freeze                        .
>     =3D>__ata_port_freeze                    .
>       =3D>ahci_freeze (turn IRQ off)         .
>     =3D>ata_port_abort                       .
>       =3D>ata_port_schedule_eh               .
>         =3D>shost->host_eh_scheduled++;      .
>         host_eh_scheduled =3D 2              .
>                                            =3D>ata_std_end_eh
>                                              =3D>host->host_eh_scheduled =
=3D 0;

Hello Li Nan,

I do not understand why the code in:
https://github.com/torvalds/linux/blob/v6.5-rc7/drivers/ata/libata-eh.c#L72=
2-L731

does not kick in, and repeats EH.


EH_PENDING is cleared before ->error_handler() is called:
https://github.com/torvalds/linux/blob/v6.5-rc7/drivers/ata/libata-eh.c#L69=
7

So ahci_error_intr() from the second error interrupt, which is called after
thawing the port, should have called ata_std_sched_eh(), which calls
ata_eh_set_pending(), which should have set EH_PENDING:
https://github.com/torvalds/linux/blob/v6.5-rc7/drivers/ata/libata-eh.c#L88=
4



My only guess is that after thawing the port:
https://github.com/torvalds/linux/blob/v6.5-rc7/drivers/ata/libata-eh.c#L28=
07

The second error irq comes, and sets EH_PENDING,
but then this silly code might clear it:
https://github.com/torvalds/linux/blob/v6.5-rc7/drivers/ata/libata-eh.c#L28=
25-L2837

I think the best way would be if we could improve this "spurious error
condition check"... because if this is indeed the code that clears EH_PENDI=
NG
for you, then this code basically makes the "goto repeat" code in
ata_scsi_port_error_handler() useless...



An alternative to improving the "spurious error condition check" might be f=
or
you to try something like:

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 35e03679b0bf..82f032934ae1 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -962,7 +962,7 @@ void ata_std_end_eh(struct ata_port *ap)
 {
        struct Scsi_Host *host =3D ap->scsi_host;
=20
-       host->host_eh_scheduled =3D 0;
+       host->host_eh_scheduled--;
 }
 EXPORT_SYMBOL(ata_std_end_eh);



...and see if that improves things for you.



Kind regards,
Niklas=
