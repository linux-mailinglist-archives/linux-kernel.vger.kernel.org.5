Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32A778FA69
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbjIAJEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235768AbjIAJEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:04:08 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F65991;
        Fri,  1 Sep 2023 02:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1693559045; x=1725095045;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Y9unzdqZHnXU18fukccuppCfpv0M2JFsRxHYFzDInqU=;
  b=TaMA/EcsyQ439jJomjYlz6LwSC0qLI+AB5utH7tblWB193odC8zOA4Os
   7y9Kiaq6s0bMe2iDx/7kf4I97LbTZaJIxSnxUqeJSZFIl6P0NQ97Uy/tx
   ofbOH0bYCEgDIcYwqDQQm8StRYh5D5uZQoG0UJC8l9mWYcqJXSm5TzLiS
   NdIFyzWUjmrEQfQb8Th8JIMoXo3UIdpRKqnNQFMWMhR6zLHIj5DOHejzM
   mzPbfPtJpboGdP2E4KSACI3nxk/6+qwo8rDQyWBy9SbBkJnL8SE9hU0c2
   /VFDkY52oe6b7zCUR+qZGux+CW2lbe58Gyy6571rxDO+oO1APNZF6O3Tk
   A==;
X-IronPort-AV: E=Sophos;i="6.02,219,1688400000"; 
   d="scan'208";a="242649716"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2023 17:04:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DnFt/5X3Ie9Wv2M9ip436NNK1kQ+np+0R8dS2EtSx9oHgrVcKsc/vS72A/s2ix3l9S31/22i8r6Bi2oK+ocNhhL5S6a8sm+M5yGu1/pw1n321eD7x7As7O0XJTAcnP9QZqFLQ37bphTjD6NK5wyRcDAGPeaw4Ok3ANqyn/pamkCuzoUhriBgMdGk/valjOyTeOZKFrAlucAegrhKfM7AhM8cRmMUFNQwhCIz4987cYCy5R1whbCdjo3NubBi9iDYKRVPBYurLl4jmL5sGgkahMSojssaAn+K0qzALnbWa9bZgZuRnxl40q0sK/ymklylH3ut+SDTZgrd2DCiu3yPeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nho5OuPob5EZzCOm54S9RAPLURonrmmJPImzFGd9t28=;
 b=nzZkxBy4Lr25Jdu+oRLKuExHzDgbYQPDpouF+wE/n8cCzmBd8FtqUDKjlCKl0xOg6MrJg/Naj866+HdrH/8pOPaAtB570mjZxzKGCjCIwOYbXECJlBq4qFyIx8z9JCUzXWB4wN+qDI0ghX+bW+e//UJXuzIoP1jXR1plWKosLjz8wwEdHuHJwySH71EXI5qo10UqFWAho2CxLHflt/Luo9uKEkIyMKIeFfJ/speHOfkPHPVO1Oqw5RvzShy90GU+PtV5is403G8bBTXMLLEGyrrk0BSDXP/APj2pXqNFrlItsrWInBoAr5UX0ZyMyNBiwqbHcKW0izCvO80WtA9UnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nho5OuPob5EZzCOm54S9RAPLURonrmmJPImzFGd9t28=;
 b=Ypt+6gkjQZeLIUeIx16ZSZfGcDtwfofQxAJBkvp1OJntbQEjhAoOu18FiX6nB0dJtCEEdnt/QjphLsqawQynHnsuikjdmfwBhW3Fa1+6H2q82z3MI/Vg8kbH+DXyvtxacqG0CrG2u4wXPcYd0olQU6WvURy+GHCAnovO5Cthm1w=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BY5PR04MB7091.namprd04.prod.outlook.com (2603:10b6:a03:227::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.15; Fri, 1 Sep
 2023 09:04:00 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5%2]) with mapi id 15.20.6768.014; Fri, 1 Sep 2023
 09:03:59 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Szuying Chen <chensiying21@gmail.com>
CC:     "dlemoal@kernel.org" <dlemoal@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jesse1_Chang@asmedia.com.tw" <Jesse1_Chang@asmedia.com.tw>,
        "Richard_Hsu@asmedia.com.tw" <Richard_Hsu@asmedia.com.tw>,
        "Chloe_Chen@asmedia.com.tw" <Chloe_Chen@asmedia.com.tw>
Subject: Re: [PATCH v2] ahci: libahci: clear pending interrupt status
Thread-Topic: [PATCH v2] ahci: libahci: clear pending interrupt status
Thread-Index: AQHZ3K95iFhlMDoJ90ixI2QcwUv7dLAFrRuA
Date:   Fri, 1 Sep 2023 09:03:59 +0000
Message-ID: <ZPGo/XWTPUA4MXs9@x1-carbon>
References: <20230901083613.5544-1-Chloe_Chen@asmedia.com.tw>
In-Reply-To: <20230901083613.5544-1-Chloe_Chen@asmedia.com.tw>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BY5PR04MB7091:EE_
x-ms-office365-filtering-correlation-id: 8b38cf9d-c4cd-4f8c-f662-08dbaaca6127
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4JluTnKwTN+59h7PddWfgQTdL32Ec4A/edDLGmC45SFV7I254O7mOvK1I1MbtLogBBxn+/rCBCsLwx2Ni95uksotQPf0e8J6sRaeSqkhyFk9KKJ7E20Rq+noWqQiWw6IhaeLnOKlZeJR/yvTKx5VmrxFje5oKIAF4HIPADPL/dvEg3PlzDd3/QrOe91cpPcpoC+MuXZwdip8bAAv9VHCLRSojGzolM0mLEL5tkbvex6rRhLljoQUMplFECasEtS12bE80an8JLNCRKQOGR+OeG/cWw1TnIsFE6SDSqjces/7v82GoQQnA+3VWn8sWeutITzJ5aNid2zL2EuJBsLkH2Mc0fBnLKM3JZg25o8DUKincIQMUdDQsDPxNNLLTorUuF/iEFengnVQBTaN6FewQjROsE2ps/vYmAlJGgPYNZaJrbL8hwH978BTtfH4b1avXDZhjMTw8ljuiTRcYluOz+TBn88wsaDscAV/PYb6JUysFGUGt/07z6JX8zq4RbR4H3JoJGZf//YrM+qhUuLvUQCnTOT2Xp0eR5iwsPvlLmvL26DS01Amq4cIAE+MUFRAHS1XXBtfKJRqnZTqPqiiTW27+xpCFl9eiS2sy5Mk0KY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(376002)(346002)(136003)(39860400002)(451199024)(1800799009)(186009)(33716001)(66556008)(2906002)(86362001)(5660300002)(38070700005)(38100700002)(122000001)(82960400001)(478600001)(64756008)(8676002)(4326008)(41300700001)(8936002)(83380400001)(26005)(316002)(9686003)(6512007)(6916009)(6506007)(6486002)(71200400001)(54906003)(966005)(66446008)(66476007)(66946007)(91956017)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ckr4iKoR01UX+7r+fbIhMutM4FRGaWuJsQ5x1/yDqv4LyGVdHWukJH9VzsSj?=
 =?us-ascii?Q?HnfD0mHb/FglaCORmZYAct3OzK3NDx+/gckKPPYTL/34t/Iyjj+GXaAVx5w9?=
 =?us-ascii?Q?o3N0aut8qWfz3AMQw3BF+4g4hcucfVhU4DHVBjgkBOi/tW7Ho0ddsxFlnc0J?=
 =?us-ascii?Q?Ua79zIsFXzpL68FFcN+fSP+/Jbj2ikyf9aFZczb5pJmsheI1F+lZM1Iy2NMk?=
 =?us-ascii?Q?DG72u/hkjsIWrMIPFajIm/VStz7C2hF85DtLRadEB0RnTrJUrwON5VP7NLi9?=
 =?us-ascii?Q?YLbtRxaczBpAqy+A88et+bkzmublEcwFFpjL9mKijjDcgpAZbzduJo2X1auc?=
 =?us-ascii?Q?jkqqJS4ey+aTrlZHMrldku0NeoUvS3GlR3A+No3Xzvym/06JYrUm9lHaR4uP?=
 =?us-ascii?Q?z2ILDwErjyzxZKyzOSVFdDi22cGLjAqZqGDb1fKFXbpV49MQMSt6Zti/hllC?=
 =?us-ascii?Q?7YoytLEQeB69gLaKbgY44szUEUzzr409nqjMobE7oJr54HTwZPMzB6lBpnAJ?=
 =?us-ascii?Q?oqsK8Ihe2elZHqMX1yRURenoRcnjBOSgW9I26NBoamo4vqKDZP92XHWNv9fl?=
 =?us-ascii?Q?lEXvBgz1DCfKsFMNSq72flKk0yMcv6Ssx4qdw0VaBmcVjZekkBF/FIGeqpC7?=
 =?us-ascii?Q?6Y7koI9+Yxaqz70w5oe6rcWqpDCzehCOnGa1RK5fy3TFTr295+nZOucD1YfQ?=
 =?us-ascii?Q?v+fwfsNEIwRjAYPFg3PsggtwOGeyvCfM/7vqPowa7H8gxhAoJBz9RW+SMdPP?=
 =?us-ascii?Q?c1cTr9tKUyF8u3kkn4uFrwp/MzlClaw7Kf1K6zt95dkVmr/Pb+La1LbA4WoI?=
 =?us-ascii?Q?6Uox4t8EcVHgiKiJL0xo/GTLBe9Jo2zoTy+dVS1jCD1vuRxFbt9u/0LoUCJc?=
 =?us-ascii?Q?qKRSvp2HxlHdr1zWc7kStpJdpZj/ygWQmMXbzGLrU7Yxg2Eza/KnwdPg2l5O?=
 =?us-ascii?Q?jKScDwQmicIizVlRrTTCQresaQGs5rSwcLtUhfqQ0aKC/evspTw/wi8ySE+k?=
 =?us-ascii?Q?bGSEKZa52Nr6aWEIeH+2vLTkJ1a13AoLdCjZAWQlU/bpdEQ5XjAZ1C23CqRw?=
 =?us-ascii?Q?zl5qttoEGCm+UomxPLW7ChUo3bIetD5dmYuXg6mWDvXpnculfh7W7J2bGE81?=
 =?us-ascii?Q?vnwqY+KcwwjZqMcAQfpTgyLWoJta2DVxBcdAPJZ6w+Ldwqq8e3/CCxT+Jle+?=
 =?us-ascii?Q?/ePuqEq6XbERfcy3j29maQvhr8EoUt6v5OKRRw4i6jrOlC3UfnqPFQ4A3vF9?=
 =?us-ascii?Q?fUDgAUDTkBUYk5UsHqL3tSh62bbG8m7G8M/sDxmS81VeRR7PdUeBoaomFmCL?=
 =?us-ascii?Q?1GOufSHNHJI4ttIf4UhS7a3QlVQbxBVzAPsH4gcSXV5TqeLsGSw8CP+9xK8m?=
 =?us-ascii?Q?YaNatRgjPglS/0VV63i6l8IZse1b39+LKJkf1HnYYkStN6Bx8k2a0iWirLM1?=
 =?us-ascii?Q?oX7aPqmExnXaTbF6aSXl1yc9hINg2jClceq+qrnyr4G3OwxrTpOwfXmtuxHH?=
 =?us-ascii?Q?yZiUZi3xvY5RhGdqcWkQ3nRGRRcU/BPdnw2RJk7m4jWNM5tXuslkQbxGbEKc?=
 =?us-ascii?Q?ltGW4kmPcl8Fh4tEJ3+KLl00ZSC0x/JcrdTlKYIm+uBUfV4HaO/j8qf+Pvbj?=
 =?us-ascii?Q?1Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A23789024E687D46B0452094EE91A585@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: R6nVkb6fLESy6jsonuyl6ZHgvoYxN3rwOk1lWaXbUz8boNIYJJ195XyZuhvAJJvvQUOxr7mvD5n/ww0zhUFs1Dr/RoXTPSlwn2QSPZoUpZ8OsauGtv+r+lyhmFku1n7Cw2KHzOPhSYJTOremJqFfR+XYtqmb598Dm9RQhnoZB0tw4+Y2F3LmSSYZml2xN2cFRnwASm5v9VUGvqvtmVG721PvlLT7e1eSWlaMInyJzXmKS+w63rsSzTopEsA9l4KPghN1nl3Dx3pOUJTGaH0t4MkXLQLAZRcWqmQuCIPSa/wBYwUJeszIx9QyTlf4AbGZ8RaVShl4a3bidZRdijkoaAK+wsbqG18+01apT5BDrHdu6iENbiG/eVwto0Nd2huVzt0prOP0owDnTEuxLvnVPyeATkcUKG/tvuFq2oKDr+uYItP0aNp1+X75NKMlKZW9K6U2FMlwSTcSGHbG8+iNVqBz1v6gxbAfxzKZ+70+T1RZdm+nSK6HwyZ2YFZ6+R7EOslSGgIPW7aPufn5FwUCahbJRJ1XB4GcXFMhoNzdvdWDR9j8KJX4wq0hgnMLOEUdhgNCu9YNqEQEN9+puR9YIOnTLh6cgpqUnQ5jKGdZUG4gRzwQqu0+uhYe3vCtiJhwufVKTkv8E9JTKm03La/79u1FF/Mt9cKdAXzzpyywtp6QUeMgDZvq22I6hhqcp6N4uZkRZtfU45cef/ZW+8ooYtpj/ruJIyme1RCUpPV/enWhUmD2TZevTpu0GyK4cVTgb95fTXfv73IUFK5tH78oVYgUfsombbS51vGTXMWB46iexLbqfcqmC30PdstMAW4MTrPAhrBhMQAcN7XhAIdf1+VYL6NnMHrduiwFiDUKmeRkGFtExRUCr+ucgv5bYqJl
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b38cf9d-c4cd-4f8c-f662-08dbaaca6127
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2023 09:03:59.2912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xHE9Z4SUc5U7gw3+4Lq9lX9w9h2E0NVvBsGZed5MgScBgwtR9MpYqd8CEBuHIFtDOVFu8VcSpJg14VTMUulyaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7091
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Szuying Chen,

Code wise, I think this looks good, it just needs some improvements
to meet the standard for kernel patches.

On Fri, Sep 01, 2023 at 04:36:13PM +0800, Szuying Chen wrote:
> This patch adds the function to clear pending interrupt before COMRESET.
> It follows the  AHCI1.3.1 - section6.2.2.2 specification.

No need for double spaces between "the  AHCI1.3.1".

Also:
s/AHCI1.3.1/AHCI 1.3.1/
s/section6.2.2.2/section 6.2.2.2/


Damien asked you to describe your changes better:
https://docs.kernel.org/process/submitting-patches.html#describe-your-chang=
es

The commit log should first describe the problem,
then it should describe how the problem is fixed.


>=20
> Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> ---modify function name and substitution related behavior.

This does not look correct, I think you accidentally removed the newline
after "---".

The patch format is:
https://docs.kernel.org/process/submitting-patches.html#the-canonical-patch=
-format

So this should have been something like:

Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
---
V1 -> V2: Renamed helper function and modified ahci_port_init() to make
use of the helper.


>=20
>  drivers/ata/libahci.c | 38 ++++++++++++++++++++++++++------------
>  1 file changed, 26 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 06aec35f88f2..f8ecd9956ea1 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -1256,6 +1256,27 @@ static ssize_t ahci_activity_show(struct ata_devic=
e *dev, char *buf)
>  	return sprintf(buf, "%d\n", emp->blink_policy);
>  }
>=20
> +static void ahci_port_clear_pending_irq(struct ata_port *ap)
> +{
> +	struct ahci_host_priv *hpriv =3D ap->host->private_data;
> +	void __iomem *port_mmio =3D ahci_port_base(ap);
> +	u32 tmp;
> +
> +	/* clear SError */
> +	tmp =3D readl(port_mmio + PORT_SCR_ERR);
> +	dev_dbg(ap->host->dev, "PORT_SCR_ERR 0x%x\n", tmp);
> +	writel(tmp, port_mmio + PORT_SCR_ERR);
> +
> +	/* clear port IRQ */
> +	tmp =3D readl(port_mmio + PORT_IRQ_STAT);
> +	dev_dbg(ap->host->dev, "PORT_IRQ_STAT 0x%x\n", tmp);
> +	if (tmp)
> +		writel(tmp, port_mmio + PORT_IRQ_STAT);
> +
> +	writel(1 << ap->port_no, hpriv->mmio + HOST_IRQ_STAT);
> +

Remove this extra newline.


> +}
> +
>  static void ahci_port_init(struct device *dev, struct ata_port *ap,
>  			   int port_no, void __iomem *mmio,
>  			   void __iomem *port_mmio)
> @@ -1270,18 +1291,8 @@ static void ahci_port_init(struct device *dev, str=
uct ata_port *ap,
>  	if (rc)
>  		dev_warn(dev, "%s (%d)\n", emsg, rc);
>=20
> -	/* clear SError */
> -	tmp =3D readl(port_mmio + PORT_SCR_ERR);
> -	dev_dbg(dev, "PORT_SCR_ERR 0x%x\n", tmp);
> -	writel(tmp, port_mmio + PORT_SCR_ERR);
> -
> -	/* clear port IRQ */
> -	tmp =3D readl(port_mmio + PORT_IRQ_STAT);
> -	dev_dbg(dev, "PORT_IRQ_STAT 0x%x\n", tmp);
> -	if (tmp)
> -		writel(tmp, port_mmio + PORT_IRQ_STAT);
> -
> -	writel(1 << port_no, mmio + HOST_IRQ_STAT);
> +	/* clear pending irq */
> +	ahci_port_clear_pending_irq(ap);
>=20
>  	/* mark esata ports */
>  	tmp =3D readl(port_mmio + PORT_CMD);
> @@ -1602,6 +1613,9 @@ int ahci_do_hardreset(struct ata_link *link, unsign=
ed int *class,
>  	tf.status =3D ATA_BUSY;
>  	ata_tf_to_fis(&tf, 0, 0, d2h_fis);
>=20
> +	/* clear pending irq */

Personally, I'm not a fan of this comment.
The function name is already so descriptive that the comment seems
superfluous.


> +	ahci_port_clear_pending_irq(ap);
> +
>  	rc =3D sata_link_hardreset(link, timing, deadline, online,
>  				 ahci_check_ready);
>=20
> --
> 2.39.2
> =
