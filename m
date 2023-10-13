Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF737C864E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 15:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjJMNCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 09:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjJMNCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 09:02:34 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AD5C0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 06:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1697202154; x=1728738154;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5G8iIOkrX6ieZXQn/Mvzn/d+WDp6Ndh2FBFTy8zVBVo=;
  b=Izcv6Ri3dA+gr2GdrPTFCKhWx27nOXCbK+rihivHrx9vgwiAItMKvmLH
   LSn6HoJiLj7frTJ4ZKecqBDk/4CioLSGTlySm2QljYtO2oKULTbcC7bvi
   9eCzvGCr1tQKfRx9e8B8cXbwbKfawsMGmQZJTM+9/LR/+0SLK1UjUeRir
   SP2Yo39m9oYsYUxP7E+SPywUqksAU8fNCD3OTuqmEmhmIn51M7DvQBrT0
   K+IJzpn3KG7zMFQ4cwpTDk2D9sqqXSS5ZK6SCCoUHTt84XbSAbtH5hwDM
   djwE7ZbAWdUlqQ+50e78IPaAfyspmynQSLH9IvyoXAP1u/5cSq8YXSHJ0
   g==;
X-CSE-ConnectionGUID: EDPm8LFVQce5RVhg3HVr8g==
X-CSE-MsgGUID: tZsayK84QWeEgrQ6z2JZoQ==
X-IronPort-AV: E=Sophos;i="6.03,222,1694707200"; 
   d="scan'208";a="246484674"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 13 Oct 2023 21:02:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gw05D759kDmCvgR1DehbrkesGGiVCwnl4gocDfnga8M19Ss9PPfNnIECZyerz7625kytA9mTElBKmBdU40ENcFJKiCKIi9By3IzMCOCmVbzjLyJcyoWvz+cmAk6oHpJxyUm4kr0MPapx0zBz0ByUpmfrXtK/EIOO5/xflUQoDEtHOPxm5U6MlGYiebRNqbTILljZb+HRH8zh2P6Fov3uh6NfvqnJmQuPVJvch+dhHgL2BjpdDLPS2H+tyJ+/4htSJgoTeInAKqyaCnC5xpF1r8n66LQXzFbbuuBzx3E+XBkEg/AJTfb1zstMU0s6pZt7YcOrWNgw6DB582/rauaGpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDlt1U+SCXD4yQdlRyklnTK3xOoYTywYh3VwFmjpH/0=;
 b=kBnOxDRyUWeVnYN1Ko+rQ1X7ZZrfS7LgKpmY5OTxmNU2JLOb08UBYdxyRRdsT1r2XB7u34g8XDmlScgGr9IHoCHrnd61yJzQwP9di+OosedCOEJ1XQxveneNt98iRqsqD4yjdqV4hMOggTHGdGpxJQC2J8sZDOUhE4tw2IKPPu6aniWt99ShVNKE1VmsCUXNAvEp0AveqrZMq7qyC4FxqtGiriNyHUqaamQmARIWiHLHt7ilZBbm8La9CapNIjGDV7YaWzwVtdoVAMDFe3YgnChy3wYkJlvirRIXsVTTKLd0bt74cpg01/hAYkzL8joblyPSCb1un1aWzHmYQ9y1OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDlt1U+SCXD4yQdlRyklnTK3xOoYTywYh3VwFmjpH/0=;
 b=LocEVy9vlVnKCJOBEFU+zhZvUXzQU8p6XTdRJHGtnTGKRwnAEf1CYJvlLBI7W3Y9XiCobyqn1r2L5uvqJu6fEx7LMH8VaxiyR6VK4GlwptDVggGqFpPkF/SNx+jTGvIDkHtFM7tLd4u7ayRtfndp9WyGjVV1wz6POR+h51occe4=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BY1PR04MB8654.namprd04.prod.outlook.com (2603:10b6:a03:52f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Fri, 13 Oct
 2023 13:02:29 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d%6]) with mapi id 15.20.6886.028; Fri, 13 Oct 2023
 13:02:29 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: update firmware version after commit
Thread-Topic: [PATCH] nvme: update firmware version after commit
Thread-Index: AQHZ/dWF0dRhBN2aLEGNUx8fLCrV/A==
Date:   Fri, 13 Oct 2023 13:02:29 +0000
Message-ID: <ZSk/5Fubv+BYPQ3z@x1-carbon>
References: <20231013062623.6745-1-dwagner@suse.de>
In-Reply-To: <20231013062623.6745-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BY1PR04MB8654:EE_
x-ms-office365-filtering-correlation-id: f31e9a21-0a34-4234-b7c7-08dbcbeca7ff
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1KjpUTR5WBX3QKUFTu0vsDvlqGhrf2tV0GJcTzBK06GJ55d/DvpWTsZvfWvx840E2qNuwCwefAF5AE+iYHan+6b+YvbfLigHb8c+Ag/NXTlYN3DQtF3H6ZEjH6wa/NOQCFSMhGga/lk48DHaGL+cIEWJFVJhNuTXSHMg4Bk7MTPU884BE6NqBZT4Iq7Q58nyRS1Mu7374nwTiyZEDFWmUK3Gs0A6Vyl2iA2ybU61r9Ymy/M9vT0uqPHQZ6no7KZH4m121yh4I04FTVYfHHKVdCoqAJa7v9b9vZTcZTQ0B+WMxXEAGXuB+m3J2ETREFKyyBRvIqQOXmd/ShgnM5lRNr+vPW/yVSeJOeQ86xo0pDonEb1LzihEU+fmQm/k1UzKuEjrafJ3xHuVLMs1M03WbRnhxAQOaKmrw/bC4Efm3EneIPhHOivITu7N4acRwkLXl6ZTtqjmY8KIXMnug6F0H3Sn3I7QNhYoUCOmV17koeC/t1uCTaqPj/iZufu75F91gWuYoda/x2INBaKwpBHQhF4G3mmS1kKbTN2hq14cbkUXRNvGGtV7uEqGGkSIxpmBcwDXpGCegULF0Z3voC0QyNNKD8oGcCIsWLK3eYT+hFA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(376002)(39860400002)(366004)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(41300700001)(66446008)(76116006)(26005)(6916009)(66476007)(91956017)(64756008)(66556008)(316002)(83380400001)(66946007)(54906003)(5660300002)(15650500001)(2906002)(8676002)(6486002)(6512007)(478600001)(71200400001)(6506007)(4326008)(8936002)(9686003)(38100700002)(38070700005)(86362001)(122000001)(33716001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p2CQKyqxAUriglKrm2vKTzaYYaxnT6NkHpnv+SNc1E/yha9D4WVdU2SYR4QE?=
 =?us-ascii?Q?1jHmdsGEXASeV1/byFlUxGPGWUImm+ZGsUZG36rx0f7ZCy6enPRcWsI5cp/W?=
 =?us-ascii?Q?v2ZgF31ig4Fe2qJQb/lj45D9rDTQJ93de7RO6ZnSCD6z5r2g6LnHs1dJN1Da?=
 =?us-ascii?Q?X742jgkfmaK8ZRj6GOQywMbhz6awuQgNvCckYNnumZ0pq9fq8yUWGerYVywO?=
 =?us-ascii?Q?ExaLUAwzQHZHSZQPiq3mK6zBoTn0jPBWpFbfmi0dOY15kti4xdskz2zFrdIo?=
 =?us-ascii?Q?Eob8DME7iMp95iZCK4dhTsG8Dqc7x07Ga1bVjjbRAqAU5ju9E0SCpMsyJDF+?=
 =?us-ascii?Q?8SHnNCD+i6+uzkPAkRv6bkHi+hZBeKYrPIUmUWvBq1KUnBo8RizTdTOpjCoM?=
 =?us-ascii?Q?VtkuKRanrzoeFPIJyft2m/YK1BfGQzIjjm9+O/2aBHqnbro2rvCa0gkNQyOk?=
 =?us-ascii?Q?MjX6zVY1NqHoTKgflagy5Mgsxh06W6PN7bN0gHOufC04lz1P1WbqKwOgKyVE?=
 =?us-ascii?Q?KGAHfJUUmJ8oifyGP1cPbAt8NknnDakw4ZuNpR0kt+Ga9RclHtuHJSb4G+uE?=
 =?us-ascii?Q?TVpYop0NNoBrMmPXR4K7vREYUteD8hfo4aDH+IyRwALTfeJl0s3BADUCYSm1?=
 =?us-ascii?Q?vSQYW8LNUDHHyld0AJUA0oFPUlPRl9PHp3Ciov33TzHMn2pwy9lY1Z0fZySw?=
 =?us-ascii?Q?mO+hwjnPqPZ50j/8cBfDvXQSEqi0CFgI9kpiOT1EZ9B/z3luh2Bg/krFIu4K?=
 =?us-ascii?Q?PcMTwiEP+NTl5mUuT6iGZSjq/ffqlm7t0pXpPoeZYWYCv3I6Zh/vJNHiZn91?=
 =?us-ascii?Q?KNthZvO3l79RIcQo6+hPq/2+awBYrUAt+qVdPVn6BLp5+DledqJWRS/qObr+?=
 =?us-ascii?Q?FRPGXlv12hacgrQIO+HBMA/WV6ck8fr4nfYgOonIVKHMXNCldgun+cPRUw1r?=
 =?us-ascii?Q?DmgimV9opgREzW4RXUHNE8r2qvyrkgEsVfc5m7EGi15zYh8s9xDeOmWUZG+W?=
 =?us-ascii?Q?ONUUScisWmVorSml70PaQcOqu7WsRfAdcovzWD4s+wmWl7ciA1WaWgIm1/W4?=
 =?us-ascii?Q?AOUkBwZ9PXhKzL1lhC5tqPwg3KP5FtqjTisfP7Lj51Oswt+0fnVtwRR3c0CG?=
 =?us-ascii?Q?s+vrdKk5hp0Eg97fz74vYvJRWUMc/2GZ1VwrgC9Kb63mhbrBiEU14xWsDdWq?=
 =?us-ascii?Q?iH8y8rN7R1KH4JYPciBKzM3VbalUm7A+FXPOweCxCElWhKhEbB5PCNZCZkcY?=
 =?us-ascii?Q?nvvi9ZQaNAwB8QHpEKs9/fmn/jR7TP7ugHIXc0k96IYaG+xDdZo8xB/dfDHh?=
 =?us-ascii?Q?T0w07n/OR0NVIOA0DqgRAPd1F3mgtCOOG1o0Yfh4jPfEYy7Phasx0WIw0iiE?=
 =?us-ascii?Q?yyRDfrTVtWWoql6+VzrPzdiuIFGHQXAhbQB0bA2pVmhUW9agOElFhI/jfBWm?=
 =?us-ascii?Q?3DNP7hOoPfwY9X3g5pSylIpvb7nw7FFO7RGcsdjGESC+rxyehCEdq5E35NXK?=
 =?us-ascii?Q?2joKBq3OENMFigvsDVsG7x17iTA+CWl8QCpslNusFTpsM7Hj7K06xMcn0eq2?=
 =?us-ascii?Q?hq7io2/G17A3bmYsqbuLiJAKn+3BJF5Jkx5VkmtHVp21U5iDsnp9piuXWva2?=
 =?us-ascii?Q?Og=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1482F93DE0DD924998543B56762120EE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LOFdtKRZ5LN4En4V5IdKsYePZJpZbfE/23eFAHKsbx3taQ02quqWBh2WoE2Y07i+HmKbjo9cgHlwDKDIxVOlrLYzd7c2jlCEP2cwNsMYzXRO35PK7NTjASHTGycjbCh5MdFf35P9bY5AFz6nwT3PmbYBAW5egWU03iWPzik8ttH59WVOhkV0ryy5s7Hbki3FFUJ0DGpuijSu6PTYE2Jpsa9bSzK4YzzHK+CYdorrzLnVoYoKG/oVnqZrnOzEh3qmpn5p6hd0HNhl30iR2S6WCoq8MV9EFyuk+ncx3VxzULOzsJmk2vrs3W0ugNdXrDC+3f94L+83X6IvF7blqi6fBw18vYqx4e1CUZGdz3xTHeKPNC2Wy8F9q/3azghybIBqGjWe1E/WWAeSpcSwtp9rmvlHHyVrOezKCnVdTc7ra2Mu2ihxFZmgR9UvH/KVPBfWqe9d3wgJPshIE5PDMlbuY4ssCelQbUxVC0LuhfMumAXUiEYJeSK2pQ3cRA9oM3WYRS0xMsTIJdNUft4Py6dmgmnV9gbPXXY/GSHqcINuMv7E5CZS9GaPcm+6oIC9wwQxgp44H1OdwTqdhHFWjTM2JvTx0nwlX9EvKCyKsDDFOrHrqy/cFTXkCg28szew5wXHdkbLFmgQBtWHbYaW0r96nFusM4FaxsvOe6DVJZD32QFZ2mJBJhvTJ+yLL/6fk/+rjAyFDN0Bo90llhkaqfCdqFXVRdWbVJKGTTw/ItqTDYbdImvlf6iaAbR2L+51r8BdPsHhnSoMl5JsUEk44fLxvgozTS9tpY/PIXqL/NWk2wV2nYDAcZUlirB2EdfKrrx0bDzd7YxtggdClqkk/tIKV1EPINTXsAiJyKmcPjdZ1YU3vAzZERtndbC3onXFTmlgAWRIqAVmkiH0cVcBU1n7Gw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f31e9a21-0a34-4234-b7c7-08dbcbeca7ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 13:02:29.3835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vZUdYhfJhpJMh/pKzCX5hUGfAQbjIbh6yD1ZrbMnmqjfQgQmDsL9L6ARtOybCX/jl7q3jMHRWkcohhMrM1p13w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB8654
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 08:26:23AM +0200, Daniel Wagner wrote:
> The firmware version sysfs entry needs to be updated after a successfully
> firmware activation.
>=20
> nvme-cli stopped issuing an Identify Controller command to list the
> current firmware information and relies on sysfs showing the current
> firmware version.
>=20
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  drivers/nvme/host/core.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 62612f87aafa..bb15d878e8a2 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4079,6 +4079,20 @@ static void nvme_get_fw_slot_info(struct nvme_ctrl=
 *ctrl)
>  	kfree(log);
>  }
> =20
> +static void nvme_update_firmware_rev(struct nvme_ctrl *ctrl)
> +{
> +	struct nvme_id_ctrl *id;
> +	int ret;
> +
> +	ret =3D nvme_identify_ctrl(ctrl, &id);

Hello Daniel,

I understand that nvme_fw_act_work() is called when
receiving a NVME_AER_NOTICE_FW_ACT_STARTING AEN.

This AEN is received when a Firmware Activate command was
issued with value 0x3 "The image specified by the Firmware Slot
field is requested to be activated immediately without reset."

However, when upgrading firmware (even without a reset),
can't more things other than FW version change?

Sure, I understand that there is no need to do a reset
(as in the cases there the firmware deems that a reset is
needed to do the FW activation without reset, the Firmware Activate
command with value 0x3 returns a failure), but it just seems like
more fields than FW version needs to be re-read.

Theoretically, can't a FW upgrade go from NVMe 1.4 to NVMe 2.0,
and that firmware can return success for the Firmware Activate
command with value 0x3?


Kind regards,
Niklas=
