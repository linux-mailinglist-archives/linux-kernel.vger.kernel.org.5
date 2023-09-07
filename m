Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CE8797A9A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242458AbjIGRrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242212AbjIGRrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:47:11 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0254171C;
        Thu,  7 Sep 2023 10:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694108801; x=1725644801;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UL2bh0ZRsbv+b2Yel1Qb4FBpwWvH18+7f3RIup1TmgU=;
  b=E/yeCT0ojACLKN/xJT3PL7hm7SUReLv6XfrBrAsk4tPSy6XjOhUr/ftg
   FK7k3Iy+7Ap+sHbAsTU3uXrBzRxE7+eImIQgocBVUgwv+0Z4PHX4M2jP9
   w+SPia/pWEqigK7JE1jUZtafJ7JbEGME4ZFWlHBmjmz3TPixZUuBirX69
   It8RWItynGhwPC5FVliGScOPqwlUst3QnTHZ3kHquVjR5xKOoGOMwC7Hz
   m72r4CMeV1yOvFsK5kMVHpKLSh6Dc43q77xwZ8fAQ/4lnCt5Mz844nDHZ
   WNiV5WfZ6dUUvD8Lr4BO0aBhqooKKj0Uh6V13xSCJthu+LUrKPzSflvYX
   A==;
X-CSE-ConnectionGUID: DnO6vLcrQeifZxv4b440aA==
X-CSE-MsgGUID: dhRQu8P/SS2nScNZcbWXbQ==
X-IronPort-AV: E=Sophos;i="6.02,234,1688400000"; 
   d="scan'208";a="355274627"
Received: from mail-mw2nam12lp2042.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.42])
  by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2023 16:30:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DScqzK1+a7cae3oaBShu9TAj2dAKMmwGrPAZMpUc5VzNP46EK2URnxT3c6hnx2s/oiqoeguPYT3HmMI27qWpoQJzsK6rEBMgb/OLRTzrfRtkpOaMHn8fUIxAZV3TaJBJ3juGMStbP/LyQQWpTEaN0ShqSU7K9dIknkGcs8uUZpokglip3oLcNgQ90iZlwRx4a9AOtVl/BSv/m0w01m1B5P9OL9OiyKjJy39piF3gH3a208Wct6yW7QcyTuzkriEPlvz/XX39dPYjaFKeZq9dKCO5vcyLows0Q74JNZ4SOtRdcMTOVB0A21w2xYP2NJEE/EE7C9Z9KMSJ+3GgMibzYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFHPz0vPYHi3mZ81yaRseEUCo5RoVj9MRoLuV/P/H6s=;
 b=oOzMA2B5RJqBCIqtINGESKyP6H4+KZjOOpi0y0lRWj7JS7H7zaiivVYLMkYEdzEkzdPNdRSraPnT7SFSnOG2HvK/wxh8ctFVX38Te7jt1FF5Y51Bxia3Y16NRNsXl1X8TQQGemZXXYIDnMr6WeNjxj1mktKcmEt5N3aB1z/4zpkR+zGH7/hTqbh0McP90QNotAQqnjg+idOaieOMKpd3PcGHeSfR2D3MXXX6di4XRsi+QZaYdkg9nwcr6ODAB1ocIXyEjhwv4FEEGUubqbG7lAljH1UqKYW+TDyV7B4UMtRkuX4akSDXfh5rf7usHvM9A3MXR4TwWiEKohbAVxsD7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFHPz0vPYHi3mZ81yaRseEUCo5RoVj9MRoLuV/P/H6s=;
 b=yoLtZZ4XDFYhIfMzTdsVxRy1HNjMCdP+R5V+yGSlTcrNr+NVbCJcTVzHuzDOw1Xi3jbRt7HHiLAziiHct7ROFRIwXwmCyg74HMO1PcQBRBv1oqHEZ17bMA3bCFoUcEDgoD3prvJTS7uGiZZ61dEIHTqvf8u+UnpDmqAtsER21i8=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BN8PR04MB6370.namprd04.prod.outlook.com (2603:10b6:408:d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.27; Thu, 7 Sep
 2023 08:30:34 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5%2]) with mapi id 15.20.6768.024; Thu, 7 Sep 2023
 08:30:34 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Szuying Chen <chensiying21@gmail.com>
CC:     "dlemoal@kernel.org" <dlemoal@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jesse1_Chang@asmedia.com.tw" <Jesse1_Chang@asmedia.com.tw>,
        "Richard_Hsu@asmedia.com.tw" <Richard_Hsu@asmedia.com.tw>,
        "Chloe_Chen@asmedia.com.tw" <Chloe_Chen@asmedia.com.tw>
Subject: Re: [PATCH v4] ahci: libahci: clear pending interrupt status
Thread-Topic: [PATCH v4] ahci: libahci: clear pending interrupt status
Thread-Index: AQHZ4WO5uiby/Pbc+k2nL3bBHZzyU7APCFcA
Date:   Thu, 7 Sep 2023 08:30:34 +0000
Message-ID: <ZPmKJglA9NOpwjF9@x1-carbon>
References: <20230907081710.4946-1-Chloe_Chen@asmedia.com.tw>
In-Reply-To: <20230907081710.4946-1-Chloe_Chen@asmedia.com.tw>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BN8PR04MB6370:EE_
x-ms-office365-filtering-correlation-id: 5f719ca5-c8a0-4a01-d0ed-08dbaf7cb489
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rmS4rHEVk71ldTvwYkXf8cVwfqLLN1XJj8Sos4jXXAT0n4xAPbAweWiGRRyWsGPaC1adKcw5i0S1h5t49CdqIIqzZHrPJ8okDkopsyI7Kk3d/gavriK1vP52/SnmIt4MDMgsb3+p3VO4gJcK+7+h6w7fwkGK2ITYklwmAu9r91GrOfEZKwHQtE/v1bg5VlgOObvZ9vuSjq+CGql0rueR9/Yz8TssLSjDU7TPcStCN7vgKv7r9IoTt6HgaDQJqyR7kHjfdrMJa14z35FkSsydiP41GcYpP8VrVUFmirqY7P5aTRekxVl/hjftXTXGMt+8Cg3Ta9N1isfwd2+r1hfcd6SZ1HhAomcmWWWqzlqM+3+oKWVoCbU/d2UGn0P71vWkO5p50/L73ccWzNsuAISEDOYlxwoQ+/3WzTYCuVtlkNn0hl7QmSpl4ljKUCxHEy85fI5k8c0tkXCvLamCdwhCVS8EH2B2Nm5icqClGeIwWYOHFdYaOAOEMBi4897xC5esFhIT0rbiJL7a41/7sRz8Jw2tLHtRXtv8OQG2NW/AKiwvIwGNXcujWSCCfpJUBQaQRxRJUwmfSQCn/2pj5rFZFkYKCS915PlQoFvgN509pYmcBUy0HSLGFhgDmV1vjkqo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199024)(186009)(1800799009)(122000001)(9686003)(6486002)(6506007)(71200400001)(38100700002)(82960400001)(38070700005)(86362001)(2906002)(26005)(83380400001)(91956017)(66946007)(316002)(8676002)(76116006)(4326008)(8936002)(478600001)(5660300002)(6512007)(41300700001)(6916009)(33716001)(66556008)(64756008)(66446008)(66476007)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f9uuQKJlRDe2MBxTwz5gAZism4sjTIp2csuhESOcOevjTVzXVmStnMuHmeX1?=
 =?us-ascii?Q?S0LcJkqW3IXrkTHmHpF3yvs9533bzy971HRx+Xg0Dbqn1bUjnMtbjO3LJm1K?=
 =?us-ascii?Q?LaC/2pKgkr91iVRXtCZMJzMrFb9UgiKbpwNSdl5fwz1zeBwUyOwMCIU+VwKz?=
 =?us-ascii?Q?z2ePcbjAWiqiE8flTCIYqVJjgGBMFmlu309XqGg90k2mnC52RhWxeh+KTX+3?=
 =?us-ascii?Q?ll768ooUzkLIu7rEhiNQ4vA34cTwa30omVp8YEjpnIPqlbHFBKSWXngQUw0G?=
 =?us-ascii?Q?fDFyT89s8ymN0wMyrAWSX7/Qnr0dad2SKZdW+fposJg4zOCFCw5ZHe5YRyu4?=
 =?us-ascii?Q?/e5N8FYqSe9GjZG1z05BnJtoIWlEF6VzscbwQjV9Ypzckj/h0hsbw10goL3w?=
 =?us-ascii?Q?+lPvEwSE4CVwLAkcIqmh57Vc/8owpfKee+3nbZdwwOnQ/30bu7dVXbErXaUm?=
 =?us-ascii?Q?evWOjyuiMwJak+AaSiG2B8Ni+Z1DgUYE8lV7rL9DzxDRlvFHHpm+DTkH/L6I?=
 =?us-ascii?Q?3EDkIJurSjia0L62At27xEmMAJRI+sZAJ37DJhM5BhnbJwG8tzIN/cVQW3Gm?=
 =?us-ascii?Q?1QHFJ6LSHPy/Ll5Kp95ThGWsUUwlp2HNNsysaHzzyygELbfe5HaDWmudneTh?=
 =?us-ascii?Q?msar32q5573PbkbXzi3tfNDBawsuzHIJQUVjrM/uXtYRIQv6geU4k3Gdfbvj?=
 =?us-ascii?Q?N6O3efyZ1PNzR/pWiHfWoxndqG4xbSvvwt7gtjlQQLO/SCr5pFyr4tQw6dP+?=
 =?us-ascii?Q?KYIQDQxil6AgFwJnaQuoyHTVGndGI6tTWv5fMwDuAoAwfJn5cqeKNR/wVktp?=
 =?us-ascii?Q?McXPNDIkwCG5tNz5uac/DffkbwopCtJEOKZSfRlXtXlWhqyMQTsCxRwdjqUH?=
 =?us-ascii?Q?GPJtRHxJgDgRIePGweOlrM3RW8a8mVM41jUYkg/a5UNrTCDdI6uVS6+F8UBc?=
 =?us-ascii?Q?FrHQwz0tZ+uAoa7LhLjZZ3/p9gXks4NKmz2KnF30QtF9IcU/0EPjXI++JTpZ?=
 =?us-ascii?Q?MjNAjjsPv3qOYMsz4UCMm/UHgDAvIOdMAGIjdSGFLhAZdTHfQZWo4Q/QIiWG?=
 =?us-ascii?Q?shanLY8Q7MetfTwf0PMsXyxXA53NjMW3JfXB1gCbYa0FLezYoZABkqRJRxju?=
 =?us-ascii?Q?naWMy56uEDe06cqLLBArLuV2Kn15lxSMOFBhb4vkvryx7NdtBRU3MDEtna/+?=
 =?us-ascii?Q?i+nbiqCHcDgtbDIszMBkpfB50vdpVFz/2IyObU08g8J2JoRy7yeKMMokOVFt?=
 =?us-ascii?Q?b5KkPwoa4NeircJhNxKc1v3nCANIj90jQc9d2NXe1NGTv3yqLmdVzICRIm3d?=
 =?us-ascii?Q?e9s5ppCtowXWM+Lvk0GzJRa4lbBm97mTTP0V9qCIyS4J+M3yOVrDme1fUsrW?=
 =?us-ascii?Q?5fDU37EFnBH60krzG4s0gb2PsvYkvYs/DFB15jDqRt7oMbJvUi63RCg6EP7v?=
 =?us-ascii?Q?ONphDsRwBx6j3tPatKnxFLR/P6Vw+tS+wZB0mH2agpKmmDxycddT17ZJYunT?=
 =?us-ascii?Q?8e0neSYGMy1fBPMJfMLAUVy57YMkKz7d4jbog95nqMtRHsNM/Bf/dnOT4Gjd?=
 =?us-ascii?Q?pibvj2ITHEA2YCwCHVCs47i1wm3KUL/3sslw/BB4QsfqZxO/2snJGf6+EWLx?=
 =?us-ascii?Q?DQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B2BAB38EA654B44883190BA83F96CF65@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KG9ie6NAKuSRyps6l4BBwnYINuOJ6zKqyTUsqf/oKW4IcOMRQevDzgjVhJAtaMDZbdvVePYYR+aHVH72gmdwujx5ET+mQQ/im/RWeKia73ebiM0CucoHYxsPkZ1uMI7e8keq8MlRW11smYS+jGAkceWfz+FXAAlee/FLxk1Yd4JT29lSLq8PPEisrNp73D0NFV/7HXYI7lYx5wx7r35zficNNsaqpkuCb9FvVlXndKFHli4y5oLDa3stv5uEldcNP3BaVT1hORbl7ekG1sZrVHizk/EBC981oJL3LMjbvL9SnCE5J1VtAi+u4x2GEi3llvX44zFVLvFYQ/A3iZUObh/B078LLO1bUKpMB0v5T7XncwDb5q4l60yNxV3EQ7niGV2Vc84NvHXvHZjAcIAJGuywHKqOy3dhmDp5WRD6rGg/azdb7/+UKu9vAoKxgqdL23zhzkqSQpDWnHxGUZhM/GBRyEI3SZjr1+LilM2UI72IqQlasuxoIGEnseOYwUFUhKEPokgasRtNL9LIgusSomzjJ5y1WuZBkX3Gf7CzJEKeGNUM5a+m8SE2TPkEpCsF6yaUiGEUuxE5BfYZnwDKHPYZo+/gqJ8jYZpXZFa4GQvgd9N2g01aXyG8OFKJiYFno3PyTMCqnDpvELlLn53lOH3B1iuxz2/3FlrWs/33v3yHdT7rYFNSVIPj7RIL3ZImGvrOKlxq8N7gWVST+eOHr7u6akcuee4r4fc3is8dgZSd2Y3dfK/9Jrosb+nTTic3e01/gBzI4kj0lIuuSJPQxyNy1jVyDwwPgDSzpaZAMrvXJaQR5cCA2+lrUFm2RANZLtL4hjotciDJPnvR98GhpzO3h50uWJSCFNHwnSKNftZrYuW0Ch9dr2lVJ0dlQcLT
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f719ca5-c8a0-4a01-d0ed-08dbaf7cb489
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 08:30:34.2752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qlgcyzNTNMxaXGuPdtkWZPqnR3tH1GjcqdF9os7/nKC9AQniEir71KnJw2H1XNiS+SdedncywALA4NUaFqsB5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6370
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 04:17:10PM +0800, Szuying Chen wrote:
> When a CRC error occurs, the HBA asserts an interrupt to indicate an
> interface fatal error(PxIS.IFS). The ISR clear PxIE and PxIS, then do
> error recovery. Before recovery process, HBA receives another SDB FIS
> with the error(PxIS.TFES) from device. This can't be serviced due to
> PxIE be cleared already. During error recovery process, the HBA can't
> issue any new command after setting PxCMD.ST to 1 due to PxIS.TFES
> still alive.
>=20
> According to AHCI 1.3.1 - section 6.2.2 specification. Fatal errors
> (signified by the setting of PxIS.HBFS, PxIS.HBDS, PxIS.IFS or PxIS.TFES)
> will cause the HBA to enter the ERR:Fatal state. In this state, the HBA
> shall not issue any new commands.
>=20
> To avoid this, introduce the function ahci_port_clear_pending_irq()
> to clear pending interrupts before executing a COMRESET. This follows
> the AHCI 1.3.1 - section 6.2.2.2 specification.
>=20
> Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> ---
> V1->V2: On suggestion by Damien to renamed helper function and modified=20
> ahci_port_init() to make use of the helper.
> V2->V3: On suggestion by Niklas to modify commit log and delete the extra=
=20
> describe.
> V3->V4: On suggestion by Damien to modify problem statement on commit log=
.
>=20
>  drivers/ata/libahci.c | 35 +++++++++++++++++++++++------------
>  1 file changed, 23 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index e2bacedf28ef..f1263364fa97 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -1256,6 +1256,26 @@ static ssize_t ahci_activity_show(struct ata_devic=
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
> +}
> +
>  static void ahci_port_init(struct device *dev, struct ata_port *ap,
>  			   int port_no, void __iomem *mmio,
>  			   void __iomem *port_mmio)
> @@ -1270,18 +1290,7 @@ static void ahci_port_init(struct device *dev, str=
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
> +	ahci_port_clear_pending_irq(ap);
>=20
>  	/* mark esata ports */
>  	tmp =3D readl(port_mmio + PORT_CMD);
> @@ -1603,6 +1612,8 @@ int ahci_do_hardreset(struct ata_link *link, unsign=
ed int *class,
>  	tf.status =3D ATA_BUSY;
>  	ata_tf_to_fis(&tf, 0, 0, d2h_fis);
>=20
> +	ahci_port_clear_pending_irq(ap);
> +
>  	rc =3D sata_link_hardreset(link, timing, deadline, online,
>  				 ahci_check_ready);
>=20
> --
> 2.39.2
>=20

Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>=
