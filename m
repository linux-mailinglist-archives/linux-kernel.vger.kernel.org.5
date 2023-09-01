Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0457902C0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 22:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350701AbjIAUO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 16:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjIAUO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 16:14:26 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270A1E5C;
        Fri,  1 Sep 2023 13:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1693599262; x=1725135262;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xeRSjcY/y1hsW7FFJ5cLDcDB9Cj01AGe5caz7qXuSqE=;
  b=rVTYpc6PWeX4ENKYCEl7w2uirbg1s9VH8Q29/p70E437BJgs+CvqUG4m
   m1SaGvIi4L+auHK/lZmMG79gx6kXKUre0x8S0h/O5BZg6u8KXm6XBLJxt
   ovfFv2Li1ggbu4kX4yszN2C5MkTgCITBzTFUqsEuWoS2VFMdEKcTgyzaJ
   jVatEg86ixDoUZb96B0rEi5egNh2GExOlqT0N3OdOQNlnbHFd9sicwbpl
   KygJFtDnko2o146/Vyns1SXagcO6HtD9sQoVSJx6+9q1dIavG7VwX5HD+
   /C2EJHXe9MotYGrahTf9VDArmjChn4odqChbQv8AmxpQRMj/IJslelPva
   w==;
X-IronPort-AV: E=Sophos;i="6.02,220,1688400000"; 
   d="scan'208";a="354786797"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2023 04:14:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUEpttFEo3BWBMC1zXp3npAeR6gBd9eABXfPmIdzvXBiP8NBOa9dUfmIqmiyXSEQSTcslSapLzzmUoS3GlyMbnzDEz9yItPWdRw4UgjPBnseaBLC+64exJMJ810PGENfLUlxw9JLG6+rESGhf+dVxGkr+NEPXRpLU/30sxlyMdG7nA+2y4zLWNO3RtEvdsZv50cnyszBtdxVX6SOoHOtfrx8SlGY7ndTW5lfZXf5dwf6HNCw967HQZ/BzBI841ixZyaPZlHpe/XLdCes+U+mZMKY1KSnCxYzzDn9hGPULaSIgckBWtzKpDddahXAXuuyqoEEAYt6OPzrHHKZRvK+jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VlxpkMPSgFv1D8kpbGwnIkfWdbN/OopfwvFcxSA1IpU=;
 b=AwZ22Hto+wfJhMQ3r6VXo9p/qkxJWzjghrRTzCHgfmI/3xuLNlS6ZpZeEQkJoF/mxeYWn2dgb8BOOH61OFGRQXyNHEQtWdvu4fbFupwK85f1Ls8vBvxUv82Wn+hpXqgXWoqEEWkxCrw82pd7IDD0wBlNCeCoCAEV7z7sOB/UuZtGaFz0VQtm4xXfZrfWevOSH2GTuC5RYaY56bGF01Nh/IbHjrVP7lS75fZPcgRYQ6BYA4Az3fPB2ems0qgJ/f8YkcalBPpo6m4oKD8AvRx2U5JocZHTQZN5cp3wx8ENoy/zivFre0AEBpiVoIZRTxLIN/59Gn21pGEx8oy0uUdU5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlxpkMPSgFv1D8kpbGwnIkfWdbN/OopfwvFcxSA1IpU=;
 b=epTWJsnGWl6+7nIaJAwm5OZDB6W/YblFKY2xLzLEnQHtKdvGS9BriKEZBwY4rcP3dXV+IGn/6UmtX1e9ShPTPia1a+kOKciFWEn5pDhuHD3OBJlIAs/eI4VaLsnU8KYiQ/6Sreb6JkJpgEiDo1gX4TsXbFDMVtDoMWlHZDOGB7o=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by SA0PR04MB7243.namprd04.prod.outlook.com (2603:10b6:806:db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.17; Fri, 1 Sep
 2023 20:14:20 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5%2]) with mapi id 15.20.6768.014; Fri, 1 Sep 2023
 20:14:19 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Koba Ko <koba.ko@canonical.com>
CC:     Damien Le Moal <dlemoal@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [V2] ata: libata: add workaround to flip LPM during
 suspend/resume
Thread-Topic: [PATCH] [V2] ata: libata: add workaround to flip LPM during
 suspend/resume
Thread-Index: AQHZ3RDjZssD+z2Q802FXyHBZZ5bIQ==
Date:   Fri, 1 Sep 2023 20:14:19 +0000
Message-ID: <ZPJGGlAQYSXguJEk@x1-carbon>
References: <20230901023457.8655-1-koba.ko@canonical.com>
In-Reply-To: <20230901023457.8655-1-koba.ko@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|SA0PR04MB7243:EE_
x-ms-office365-filtering-correlation-id: 44490403-1136-4c72-c253-08dbab280627
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N4T+be8YJsBLvJnuRSfo1WD/4PjZei+hNfc/lxFJbltn6USDI49UqAEzzfllA2nwbBlRBDiT0lyGDACbE3VjlY6RBSP2vPGZ2RANdVLlJNFcZHMxjydPO42j6YkrpsDcyAEALoLOgKWRTkKW5J9b8BE6k15B76g0i9Q8KPzAufDF56QFLQG8/q8IbJRJKjW/sJqGghmJzkGBNYxDjcPihf269AXzqgFeZGF4JMLOwnfnIwI+ly0cVxYkftDZXl5FIwkUYYHP96Mu6ti9ZD29nKjTgS5uOP4HUgNCPcC2XVWpZcWmeGUHoc/pia3LO0LK2w8CRhhBgykXdncLhMZge+hcosu+asBfBMPsGEzLxKY685/qvWDbbsqgnBcGwiTV/YSEWaIrhjAWPy7zn6Obw0806W+5ZolikCMlEE3a/zX4y909TxPnM8Ej/vxhkAMafmLVXZlz2oTaB/1EggReLqt+KaJIgbhynTaisCAxyKw7G43723eMdw2xVy45UTgRHNlz0BuSrcAifoTkNXJPQJF36Axg9i3Z0cIAeRbwDZiEJWBV85m4xxdGJxM3RKwnc2++toKwRuDKvsvId9flN4j2tCkvb1ImrhapSXIagqI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39860400002)(396003)(366004)(136003)(376002)(186009)(1800799009)(451199024)(6512007)(71200400001)(6506007)(9686003)(6486002)(83380400001)(26005)(2906002)(6916009)(966005)(478600001)(91956017)(41300700001)(76116006)(66446008)(54906003)(15650500001)(316002)(8936002)(8676002)(64756008)(66476007)(66946007)(5660300002)(4326008)(33716001)(38070700005)(86362001)(82960400001)(38100700002)(122000001)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PJHMcpBREH2se9wb858JANnuehn/wpgI6E+5fiDnWHB5WPh2Ciq9qL0f/YFi?=
 =?us-ascii?Q?u+ZNjZYfVYWO1tHSHklZQyK9l/SGItf0nwyMWKKe30HXdlNdmQaiRRU2Y0Cr?=
 =?us-ascii?Q?K09/YqKyMWKxcgp+O/TBc5GrUPU28o/CGjuNbo0GdP0rYl/dtmCXraX8wLnq?=
 =?us-ascii?Q?5RIs0S+LFjg1HLIm5K5iqbh0+f55d2XsBqPt1OuirctKk5LKrHzZG3IJ5aCo?=
 =?us-ascii?Q?3+bfflrYGhjherKDLncR4qHwS/qfT3vHpNkKygZaDLrDlOdwH+YlOnRxP1Hn?=
 =?us-ascii?Q?r9TUsu2XAz3r2UAlzL0Nji7vT7HUZHDKgPnTB/5R4Uetx5Yi8sR/2rr4suzp?=
 =?us-ascii?Q?S6dYhyMIZomtnSR2ukXfSFJRljAsPEd/4H5N5Rd4ekuvSk6aWgys3LiV923h?=
 =?us-ascii?Q?TV6KtElcLO946T+eBDIiATK43n7HlJpW5lHW6RQY70RZBHrI8kNAmpy3DyMh?=
 =?us-ascii?Q?SwXxCEQIelSJzcAXODgjxjDTYufJBGJizE6AQwc+rkp5b7FYPCmpXIxOgSt+?=
 =?us-ascii?Q?xW/oIn9UdZpChebTqyiOLVQtsmu8iXFZgLwFC6/WulyR6EEEKd+mCr9uFh4i?=
 =?us-ascii?Q?C8XGj/KHaAspOcFQDXZvbg9i5+ZXHjOW642GdcfzQIWrJ+g8zMeBWboKyRpE?=
 =?us-ascii?Q?2qwZR6AMiHsXrHmcnVvgjki4X4yXcXjSOaALZCSi7jO9jEm+NyMXc3/ZMUU1?=
 =?us-ascii?Q?w6yHEGbSXEhmuPNTA482BB5tF/x2ZMiy3Va4hFfWBBidpO2viJB/nmUXONTZ?=
 =?us-ascii?Q?OAdlRiTMVK5Kp+e6MWhvWh4c30cIzVssbpDy+6uXDiu+QEFPEwU1TOfEbEWu?=
 =?us-ascii?Q?dWEXSKEFcquI1PeOL0HCgkqXmsI4Y1amD2Dlfij9csIfLQbKKEVpBIXiS11V?=
 =?us-ascii?Q?UbGIojougegTvc+6fsDoBh5ShXxJ/zw1YSuBtOAORCDvpvN/asl5sLhb4lN9?=
 =?us-ascii?Q?hjV+UMs5wFfpaX6SovdjDzKkqf0YgFbJPkldKdGbxHWmvatuoLuav+YUa6+3?=
 =?us-ascii?Q?aE3FJvhGSHkq4t4Jox3fhHZRBZYYc7dO2o56f5yOwOdYdRdtUec6HfFeClKg?=
 =?us-ascii?Q?qnjiXac9DYyBYJPsnq+CUtSjO0I8tpJfRtNAflc4OzTgRNQ4Ui6NrYXncC9e?=
 =?us-ascii?Q?RT4fKKih11wpdWXwuWjTWQCf509sZt8iYENzmbScdnzOWLsHv5WPwhHQBh+7?=
 =?us-ascii?Q?arOoGdDiwy/5JVE4pBVJ2KVSQXZR9IXI0nObBM6k81HoWGvaZxl1vM5gkV7I?=
 =?us-ascii?Q?kPBPamelvTkygAVCP9LaVzIWGAmtGJuH3uDywTzMZZOKkpAnct+sFxNkpb9v?=
 =?us-ascii?Q?XLBB7jbgJ5xVPYyChgHzeEth5qTXFOmew5ZZ/vYbj9LlASY0oTJf+YEbIcEJ?=
 =?us-ascii?Q?VpVMQIHQA/oCk6Nm4GwD2+9ZnzSyhxla4K46qWvB2jK0jc/ZuhryHTna2Tgn?=
 =?us-ascii?Q?5HVVEWu7I2ZG4XEaJTS/2UqQPOiEH5g4IgOJL8AjNzHVVmxv52k6LRXdztS0?=
 =?us-ascii?Q?DyK19dqfisvmu95MrcPVkaSFA9Succ9MtOBbFC4dQdhABlWoB434J20s74SZ?=
 =?us-ascii?Q?sQjQreP8CN2J4ThxFskBXIHCeKpXuMcU0WEbXygxUOhXoBYXZcoe6DS1opgN?=
 =?us-ascii?Q?DQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F1EF17E47EE45F49BC0CD50EDC5918FD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xn1ZY2t213POmSWQbpIf1ZlOKzQ14fMO7PURyZX66FnxzkI/DTeitp0kU0gn9OCJ9hChzndTR4lAMkhQWAlfIvXSDFL3niXft11/yJWei/JpWK9+xE6yxViwNOtdPgb36CUqGRbxX7KTG8XGRSfso/QfnPK+uLmy7giJljwiQtP6JQjk7Bi3ZP5nR4pLV4gRQUS1EicjT7t8Ondb4EIzJWRgIfRmvUZteZP3WLX8BxEMxL9ECIgub4YaNkhfCgYglc9n+nb1Px+Ds4bqQMuAvOvGkm1NvVl3zXmvaBS4Lfmx2ZMDeJSVGnFZpGJ8ztzQvkl28wR1i1LyHEBcMLdCIyKr0PrPMnE39t0Ylu+z4/0mpWlAeS7PHUIGLyCq8lgRBnZGpyXD7VdqFxK3c2h7gRgv162d5GnIMbgbW77fnyVJZ3diJKCmqGMJy57YQGWJzf0H2+pGOtqZrjK9+dmSsCZGCvhvRAHJt4RTj7L2sasLZ/6JGuUZbvzpuc1IvxVz/5U8usCPkNPij06gG+aR6rmGojggJEaS8igAnC7SGYE7thPdJZG4a/eaAzlWpI1SARqhtfuMoVA+zHrvxvwl6kH8AxXZa4UIoziCozwldVcyY7NTIIR4WfHsSBoC4HHPrVfUeTK8a6FKTwoSyWY49j2mEqLEQVt8ea3cEcrvLweXp+SrDIMHx4hFA1vTq2K3AYRvjyJbYnkQiUzF+32ypuOGB1QV2B4bzO0sgmO0DpL7LvvinwoDCsoq93+2wh/RiEn85uVQr0isJR26x19KBzujWsG4jIe3956NJQgCwK1km38VjlLqdrVA39pUYh5a5/oyJkush6Ej28/p9xnkbA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44490403-1136-4c72-c253-08dbab280627
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2023 20:14:19.3124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a4TUn693XJGTwaaFDFuSZYiTxAXAo8+OOHLKqJQtEr+Zoj8EeXZyKOLR+IJcspq9LW24CdZYfOVusLBppmwG4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7243
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 10:34:57AM +0800, Koba Ko wrote:
> Due to TigerLake/Adler Lake AHCI controller's LPM regression,
> can't apply LPM on TigerLake/AdlerLake AHCI controller.
>
> Add a workaround to flip LPM during suspend/resume.
> When suspneding, apply LPM on TigerLake/AdlerLake AHCI.
> Restore it to target_lpm_policy after resuming.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217775
> Signed-off-by: Koba Ko <koba.ko@canonical.com>
> ---

Hello Koba,

I understand that it is very frustrating to not be able to go to the
deepest C-state.

If you want LPM, we should add the PCI device and vendor id as a
board_ahci_low_power entry.

I am awake that a lot of people reported regressions when that entry was
added, and that is was thus reverted.

But adding hooks to temporary enable/disable LPM during suspend/resume
does not seem like the right thing to do.

Since you are enabling/disabling LPM, even if it is only during
suspend/resume, this should once again cause problems for those who
reported regressions, no?

Perhaps you have tested this on one of the laptops that reported
regressions and know that his workaround is safe?

If you do own one of those systems, isn't it better if we instead:
1) re-introduce the TigerLake AHCI board_ahci_low_power entry
2) debug and fix the root cause of the regressions on TigerLake laptops


Enabling/disabling LPM only during suspend/resume seems like a huge hack
(and I don't see why this wouldn't once again break peoples systems).


Kind regards,
Niklas


> V2:
> * remove the unused declarations
> * add a condition for ATA_LFLAG_NO_LPM_RECOVER during suspned/resume
> ---
>  drivers/ata/ahci.c      | 27 +++++++++++++++++++++++++++
>  drivers/ata/libata-eh.c | 10 ++++++++++
>  include/linux/libata.h  |  1 +
>  3 files changed, 38 insertions(+)
>
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 02503e903e4a8..658fac695adf1 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1025,6 +1025,30 @@ static void ahci_p5wdh_workaround(struct ata_host =
*host)
>		ap->link.flags |=3D ATA_LFLAG_NO_SRST | ATA_LFLAG_ASSUME_ATA;
>	}
>  }
> +/*
> + * Intel TGL/ADL workaround, when suspending, put port into LPM,
> + * recover to max power after resuming.
> + */
> +static void ahci_intel_ahci_workaround(struct ata_host *host)
> +{
> +	struct pci_dev *pdev =3D to_pci_dev(host->dev);
> +	int i;
> +	static const struct pci_device_id ids[] =3D {
> +		{ PCI_VDEVICE(INTEL, 0xa0d3)}, /* Tiger Lake UP{3,4} AHCI */
> +		{ PCI_VDEVICE(INTEL, 0x7ae2)}, /* Alder Lake AHCI*/
> +		{}
> +	};
> +
> +	dev_info(&pdev->dev, "enabling Intel AHCI workaround\n");
> +
> +	if (pci_match_id(ids, pdev)) {
> +		for (i =3D 0; i < host->n_ports; i++) {
> +			struct ata_port *ap =3D host->ports[i];
> +
> +			ap->flags |=3D ATA_LFLAG_NO_LPM_RECOVER;
> +		}
> +	}
> +}
>
>  /*
>   * Macbook7,1 firmware forcibly disables MCP89 AHCI and changes PCI ID w=
hen
> @@ -1905,6 +1929,9 @@ static int ahci_init_one(struct pci_dev *pdev, cons=
t struct pci_device_id *ent)
>	/* apply workaround for ASUS P5W DH Deluxe mainboard */
>	ahci_p5wdh_workaround(host);
>
> +	/* apply workaround for Intel AHCI */
> +	ahci_intel_ahci_workaround(host);
> +
>	/* apply gtf filter quirk */
>	ahci_gtf_filter_workaround(host);
>
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 159ba6ba19ebb..0743a9986a5ac 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -4000,6 +4000,12 @@ static void ata_eh_handle_port_suspend(struct ata_=
port *ap)
>	int rc =3D 0;
>	struct ata_device *dev;
>
> +	if (!!(ap->flags & ATA_LFLAG_NO_LPM_RECOVER))
> +		ata_for_each_dev(dev, &ap->link, ENABLED) {
> +			ata_eh_set_lpm(&ap->link, ATA_LPM_MED_POWER_WITH_DIPM, &dev);
> +		}
> +
> +
>	/* are we suspending? */
>	spin_lock_irqsave(ap->lock, flags);
>	if (!(ap->pflags & ATA_PFLAG_PM_PENDING) ||
> @@ -4087,6 +4093,10 @@ static void ata_eh_handle_port_resume(struct ata_p=
ort *ap)
>	if (ap->ops->port_resume)
>		ap->ops->port_resume(ap);
>
> +	if (!!(ap->flags & ATA_LFLAG_NO_LPM_RECOVER))
> +		ata_for_each_dev(dev, &ap->link, ENABLED) {
> +			ata_eh_set_lpm(&ap->link, ap->target_lpm_policy, &dev);
> +		}
>	/* tell ACPI that we're resuming */
>	ata_acpi_on_resume(ap);
>
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 52d58b13e5eee..e720fed6dbd7f 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -147,6 +147,7 @@ enum {
>	ATA_LFLAG_RST_ONCE	=3D (1 << 9), /* limit recovery to one reset */
>	ATA_LFLAG_CHANGED	=3D (1 << 10), /* LPM state changed on this link */
>	ATA_LFLAG_NO_DEBOUNCE_DELAY =3D (1 << 11), /* no debounce delay on link r=
esume */
> +	ATA_LFLAG_NO_LPM_RECOVER =3D (1 << 12), /* disable LPM on this link */
>
>	/* struct ata_port flags */
>	ATA_FLAG_SLAVE_POSS	=3D (1 << 0), /* host supports slave dev */
> --
> 2.25.1
>=
