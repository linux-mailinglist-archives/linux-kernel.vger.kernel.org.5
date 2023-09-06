Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E9D793B52
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239776AbjIFLbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239771AbjIFLbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:31:44 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3E119B9;
        Wed,  6 Sep 2023 04:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1693999876; x=1725535876;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=o9zJuMLw7spuMlM+DE8Ay2WGt2KYTu3GjxpNIsXai9c=;
  b=nirNJX8nJmljlGd6PnTiSD7w5IjzmkTLGPlbIRaChzxn8/RGD6VdO0+v
   TXsXa28fCl/hXlodCVIzzHX9RrRXf0qpE+Ii/0XSdPkGaxTSD+SQG9ArD
   /smlLejoL0JB9ADsBFvIHlt+nsn3afVRcqdR22hEXHQLHKgx0W6QGxUcS
   YyHTQ/Cn6wkX5CE92nB0Q8aL0ThopyiecOeSXhoVC+yqrD6D6f0o2DFDx
   eo6KZ8ufXFupATfuopnwCtO8AnQi1RpA4FWTSNxfmJLEHz6etuIPO6+qf
   tq6YZx+gnU+aNUcGy+ti7pZO6h5yXhlCfs2L3zwoYN27sDjMWV4yafXhb
   Q==;
X-IronPort-AV: E=Sophos;i="6.02,231,1688400000"; 
   d="scan'208";a="243462241"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 06 Sep 2023 19:30:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jj+h/7te6+L3QIuZb1ZYWHEzFtH6xudUzfc8iKkaRikelR5AEbT0umWLd5S2oYVR+N2BKagMPVjNsw2PB88TOzu4O7JlhODbC/4Hki6U66vtOONMw2U3SSoaHOE7eROBqBeJuH54aDnBAIOf9nkYq3cqw138j6x7ww0oF7/cQ6jofnGpUDO2Gfi7IivKGr5CsHNOoCfbOh4/T61SDNYJau0yJfHk+CdP3/2s7zOKq0/vItsWrorKWhjjUBgW7qLBwHtJO24ssdAH1IRUIcns1/itkFa4U2nSI5vDvhpmJ1eagIKF5XapTmVZbXGwsM7NViMz/3QJCGNLSgaH2I4icA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIpe7MslBrsGRvEqhjkEF9PT4b+nJHMJ/YmNnLReCLM=;
 b=bcPgrW60sqJLOSd8YhmZK5iMQK0sxxPrnNMTkRDDhMTwThTjByh9WUF48Gm/oSMPp5EAVmhr4d8KuUBJtzoSmgc8LGBF0HqCl3A8+weri05KxDccZMHaUFguGp/StC9rvAF3IBE/e1tgYSz8gdT9teLlYrwKuUq05fxFofzMzsHz2C9Gf/m0bjaNVZuZWCLJ9ExdTAT02xnBYB3gPR6h4FANW2c0bMQhaQD31+F4CmXbE9WkqAUmEiD4ZeziJFh9QC7ccGRl+ri50ImW/iSbNpw50UWTQl9oQFPyWtbzkF0nuTNxypUIwpqJJXBnKUy8oALc+HvYRoU84g/6DGXFcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIpe7MslBrsGRvEqhjkEF9PT4b+nJHMJ/YmNnLReCLM=;
 b=o857WNOx+sAiIcXMyyKhK2l98zdPZRB+QN2C5PTsnSy2+2D1prYScNXrXaI+aT1UF/rO3hiW2lcotdcN5u56B2UNIBNQ57F/8Tscf9OxNlFzX7WwAvOXTlhLj0yTQT8jfg3/nIfGnPZczRGnt+080lYYtA1niU3BWZUiithj+kk=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BY5PR04MB7043.namprd04.prod.outlook.com (2603:10b6:a03:223::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.25; Wed, 6 Sep
 2023 11:30:29 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5%2]) with mapi id 15.20.6768.024; Wed, 6 Sep 2023
 11:30:29 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Szuying Chen <chensiying21@gmail.com>
CC:     "dlemoal@kernel.org" <dlemoal@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jesse1_Chang@asmedia.com.tw" <Jesse1_Chang@asmedia.com.tw>,
        "Richard_Hsu@asmedia.com.tw" <Richard_Hsu@asmedia.com.tw>,
        "Chloe_Chen@asmedia.com.tw" <Chloe_Chen@asmedia.com.tw>
Subject: Re: [PATCH v3] ahci: libahci: clear pending interrupt status
Thread-Topic: [PATCH v3] ahci: libahci: clear pending interrupt status
Thread-Index: AQHZ4KgH0xm1jnrUEUi46VI4/h0EhLANqb6A
Date:   Wed, 6 Sep 2023 11:30:29 +0000
Message-ID: <ZPhi0ewDPozdfGED@x1-carbon>
References: <20230906095334.10310-1-Chloe_Chen@asmedia.com.tw>
In-Reply-To: <20230906095334.10310-1-Chloe_Chen@asmedia.com.tw>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BY5PR04MB7043:EE_
x-ms-office365-filtering-correlation-id: 59e22ae8-0345-4c44-58cd-08dbaeccacbf
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GP/FNMtGOTYvF494YA1ALCLm4URnLBTvOudW1Dc2It66ciQBJzSaJqN49eFLuV/djn/b0HkI9RP5bIoi1djeEUq9fBF8IcUv6WH7Mhxqg44AnCifzY4/slf3vRvw51Sb9PhSE3noHCDKZEj+mZz3w73pdMjaUeqwRszg7nXyph176AeDrLRsFtzvE/3+iPAI3aPfi3KXdQv/sK8k1UL5gWEtsMefrths+aiaR01OWF5uVdqQg/Dhu955r0hV4rN8anQUvvto70qnJ0Ggo5hR6tjWHfqCi7xGZU1+G5B+Mgzzxs/HoMIPAIlYeWR7w8vscwPEWQ5hqbND25XPFRL0w/ZqDWV2CUDP1bfoVQ48SsBsm4uYPFi3E+iv8bO2CZoTuLCpEgPZITXttr3t1QLqLs2077rAcMNpQANTaTsxDhUFO9cifcfiB1lZSwKtyCtoOnqz1ofVPIxIrJdRpt/7h1+gIhJVDII1WtgGnEovLmKkiyij9AZ8UGvsj5S7Zs4TSzCxo8AladM5agT/TIk/uYkJVHHQNTX8oopw0UdBCIwpWmGy/bfy+BYFJy0MFLB3bh+u4FIQzn9c7+qA5eA5etjwWVKunjRJSvPwbcmbYc9UhgWsVN1fnC8+7CiNaBse
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199024)(1800799009)(186009)(6506007)(6486002)(9686003)(41300700001)(6512007)(66476007)(6916009)(66446008)(76116006)(71200400001)(66556008)(64756008)(91956017)(54906003)(66946007)(316002)(26005)(5660300002)(33716001)(478600001)(8936002)(8676002)(4326008)(86362001)(83380400001)(38100700002)(82960400001)(38070700005)(2906002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IJMC5Eq3td2oLGwWXsDkDqpet5BLMdVg4+avQEtpgqVzYSA4bSN/Qj2modNy?=
 =?us-ascii?Q?100Hj90e0FkuGIpp2h4H1WccsxBizKqn+tdmjBV3TQaw9xxQcN+A8b37Lv5m?=
 =?us-ascii?Q?c/CBiMku5tFASdBXt8DsjX0g3mgTQ144sfzRI0/5STY/+G3Dve/I3DfnojDu?=
 =?us-ascii?Q?lTVYrOjTE3QedaeQQYFYvgPrmH7N1xMhhVyGjYjfitOPE0pI4whhVcOg8b6X?=
 =?us-ascii?Q?nQimzPOmod4ILYje0Hglq74iWnQZ403MIe48wESMF+n2vfvRA6iLw4qp9fKm?=
 =?us-ascii?Q?EkRrAN/qdnMJ3OEzOlYSEE+8A+SRPPuarPPan/h4Qt8H+zavWSOepa4FFBfu?=
 =?us-ascii?Q?3ss5BQv+L+ucyGoO5du2EJMKrFAdux+nOitRI4TxUGGAM56sh4BxShO8Jde5?=
 =?us-ascii?Q?xUbMgXcvBRX4qW2u043YG/AbObvy+uZNYvVZI+RQzCgpGaKezrC//lO8uwZy?=
 =?us-ascii?Q?5bN2FYaqZppNN4pYO6BjFuATL0y0drRi/wcSfj4qZljhFvMHJRieJ60SaOKV?=
 =?us-ascii?Q?PE3Xe29wmJylmqSjVOI4uzXHIT1n/IsUbkLvI3Zg/5CZM6xSInGBHb1HNYZM?=
 =?us-ascii?Q?M8qOvNLq5ff1gXAJfYfdEdr80DGFPrwajsMnBdOPcvSH9SNY4c7GTnc19uBb?=
 =?us-ascii?Q?/76B3RAhq7xe7HpNOH1oVGTqnyRtWFT9NycHgcSfROJIZPbwtLiAhAPMIC8/?=
 =?us-ascii?Q?JXkxQkgmkpshZLfAjdzhtBchEuF7lFsydoNEdIj796oVRw9BFZO5Ls6q1ArP?=
 =?us-ascii?Q?HH+EWx+lT4BMIFXBnKyNskBhqHDKVo/Nc0aeb1/yG47E0nCZJx/EFkPMYeg5?=
 =?us-ascii?Q?5ij96z6pcXBbM+JXQ4m37bRDmNCGVduAj4qy8W6BQVs4NS7HVR/z8TVNX7SH?=
 =?us-ascii?Q?M05nPALlsjqXbHvHDYk82Tp2ZqVk69tyu+wW7Lzyh77jqM7cJuOOcobnhIqd?=
 =?us-ascii?Q?qIqqZzuPHoM+i7qhC8YatSwFO0ZzvRgZta5Vr649yNeN/s956+n548MLkO4L?=
 =?us-ascii?Q?99wJhgq+93hy2Y+sWECJ1DeEkXo2NDb2DsvJBFYfEDII7MlW+vcBUO1z+dl1?=
 =?us-ascii?Q?EH9Q+czH7ZKyQMsSrZg5nwpWZ3QjlsvmWP/+gWqos2leoSHCISTBgOG89mJI?=
 =?us-ascii?Q?gjrm4Q/bxVJE7jd+JI88tKbaAuSaGTyZU5e7bLgpOgDhFC7qC7IDYyiWrOjC?=
 =?us-ascii?Q?gxty3IWwowxSWach3trRSVL+rq0Ivto26cDWaiCjncMtN6bnYnToxK3sXqfv?=
 =?us-ascii?Q?sSgZFb7IYPfanSFfa9z0BNJO8uh/rPwWH2cP/FAA9MSwFrM2bQnFv4e5/9Vq?=
 =?us-ascii?Q?hZ0+RDM4Q/Ze0Ki4h4Rb7S0JTLhaqMFgvaJ+ZCIpXMIfTGGXPvmDm7Ya7Hj7?=
 =?us-ascii?Q?/r8/H3b8R+uf2jHRi8ZNnns7pAFDNNA0oDQP2PEItfauKyRb2vCQCVKuSnOJ?=
 =?us-ascii?Q?9QhzY/XSuZfSAPl/W56gS3TM6GemAUq6DPxkgF32TGS/qT1xCkOTPx/AgSjn?=
 =?us-ascii?Q?Kk+1njp8axaDmm7cE5RfnGVj+KCzffdYlczWzvaMcQLUeOpqX3WAu13fpJ9v?=
 =?us-ascii?Q?WlT08rM3gUrhqvkGTBKayznURBu3UwoYMRSFJTRqnyVahpeEfvsp+AxHagBA?=
 =?us-ascii?Q?yA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AAE25CDA7BD3CA4AA842E45264998408@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7fgcZ7qyOBdeW5z7eRlECWc87wf8CLl9JkgQ4r8aqGPaplNXSCZOdjmbcKrkPOwU7Nv1II3tN2vuRkajQDuua6jd0KqVViMsKpuptTlLNZeRwlIBeK94Nl25/YLwMnYNV30qYG2Z53DmD0M/opMTi4aXl4XQZaA5oYe4ERczoHBlod5g49ICjWkNkoiPAm/o7HPasS68rsFmSdVsaFsLPquEsVIOSwCaDMc0qikzUguPMQRcWAJiDCkohs2gLZ1hpxT3r9fgaoZWS+yH8FPoj1mFwppdI0xWmoRedHTSyuNeIQf+G4reI98J/K/LNEiOPTCQTWJIsihEAbhq9x0TM9YFPzFFcbwHrmlSFwH4CNRdOPIAFdFJPEod5XTJEq0bXkI3xxhfYNIEO0W8Eo7JhwDG/tj09sXV8U9R9D4aBBjzVw/rz3TEo5cYdep9j0j9fwYYbUHgS9VmQTCx10Fs6z+DjB8KOBAV0OZXqno891cJsyUiYKemLU2Qw7s65dW0GJ3PJDM9b20Jh4QC79S7CUNtid6UEJqgpuyQizFtLSUkA2ERK+SBi8BhkwglDNIib8T9FkWV8X1cw55PzfMqVuZ3S/uKq+kJwJrl2IyEuPxcDLnvAgl9jnXfo71aICbdvXRlTITpTa/23/WXJ6ECQ5bvWGUjURgBXILKvvEhyR18duuoHM7PkUASHLmAo4ykaK+6Bu1Ze0wPZRXBtc3oak7oHz+NoWY3WjgbYOz9aSHDN/1i5T6K5tu+t6RsZvQyhHxnJPIwhO83X2s0pRaGQKmXuIcd/+twL2UkLk80PeiDFOhUbVRyGJevmy85/B+KHTxNr7wVckGeWOcRGgVYy4oack0fIltdJzFJ2vhRqPetwvxctu2qZS/MTRX+IIm1
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e22ae8-0345-4c44-58cd-08dbaeccacbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 11:30:29.7777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mpf8vkvx3WsYa3pbTK2z8WMomrnb2gqmU4nQEHpHpnV88fyrdZRCqtSKnHJ+YBeJjklMfd479CMisVBIAm4VnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7043
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 05:53:34PM +0800, Szuying Chen wrote:
> Cleared PxIS and PxIE with error recovery when ISR handle interface fatal=
.
> Then a SDB FIS with ERR (set PxIS.TFES) is received
> before PxCMD.ST is set to 0.
> When error recovery was finish and PxCMD.ST is set to 1.
> The HBA can't issue any new commands.
> Because the PxIS.TFES bit is not cleared.
> To avoid this,
> we adds the function to clear pending interrupt before COMRESET.
> It follows the AHCI 1.3.1 - section 6.2.2.2 specification.
>=20
> Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> ---
> V1->V2: On suggestion by Damien to renamed helper function and modified
> ahci_port_init() to make use of the helper.
> V2->V3: On suggestion by Niklas to modify commit log and delete the
> extra describe.
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
