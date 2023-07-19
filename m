Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E78D7594BC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 14:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjGSMCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 08:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjGSMCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 08:02:04 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BE5C7;
        Wed, 19 Jul 2023 05:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1689768121; x=1721304121;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CzCXW6q/z0qBO5mS8BSklEnup/9+zZXr+GcGxi4UjfE=;
  b=PXeZWCUn8DfqvH6X6skbUxDk7rPNSN7aes1iWu7TmwmIKizHlBCwpweX
   x9x9SPkciwmtASd+DHB5cuj7sS5sA9T/pUjEBtVlLqCgbfcnyFyTpYjHw
   uDirmstIYToijlzpdqnMbGPkoyx3geYgIdYYPcJnW3tiXvWrhSVG3wXDF
   NvETnXG5e8+aj6b6zehJzQ9/b9BURLpSlDAh2mUnmKROnrT4w2UJ8j46l
   HiTwhJXKO+lGf2JNq1E7Xl7hVTKc3Sak/naZ6ZQyJ0wutYwKW/2Y6MI4p
   xqkrPOON4T3Zs5C28XgG1Tn5Zr1aDLT7xgYC5/hnQT/uShptTULCu7yo9
   g==;
X-IronPort-AV: E=Sophos;i="6.01,216,1684771200"; 
   d="scan'208";a="243150058"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jul 2023 20:02:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXvIr0N2HdELTthdM7sMLwE9wqxfqNr8JFp28c7+Dl2ABHmSatkLf5biaMByM24lZCZ7YCucNYSc56jeX96u33Kk+v5Zmuz9ypnXYWJ4NbiFOufGVRVU0yunyf4d6zp7Fmvbw2nDh+yKaqza7pvDT1AQYFWa5iCNKSrgjWAPDTItlXCTAqKAa0nOZOLGsW1znUJiPnfvB4G50XHIovqs8MCsjjDqzC7WwaeBRIsXy8xp9X89jYe5/IJxoqL2c8SL2MCs0xYMXvciIHmXJLqzb0pj9bsMVEbR42DomhAYpPCePu1yGMqOFHDg6LdgWrWjqrZRFZ4rNSv1SI4YjCn0bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFwxGkIinxpbe8tWFq7aOB7MaDmHVyyAngiY+yP6gPU=;
 b=CR1Ohzs8VI0mRU23GPcDCfHaxy70uKtV0kXoTQJCuI0ZhB0wzxrkqnm1J8Ol8w6epf2NDCm364PO+8zxVOTlJcXDu88wwLu5JJPSIMSixwtRNR2PzCxBKdPR4UiQMd3ZEDRy1MJiouZ5PCbmFizGUpwP7qhyg9CR/Ks1CkbPw6/Q4en2QLOjQRBkYeHqShFVrYl0PvUv3lqMH/JyPo63mZNrZ6ZQXu/ZvcYKhlO/sZTrLEgwY/+WPeRtdtddLp1cnLWRoYNPexeAuefEPE/z/ARpR1sbhquso1/Fdq7lB8fiWJ/8ZqyrY/jW6bEuSLRp84UF0BNIeIZ8I5qa6kXSOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFwxGkIinxpbe8tWFq7aOB7MaDmHVyyAngiY+yP6gPU=;
 b=y5pVc3XqXKmvd0Ty5KDr5JiWWZRjuaNmn4G2ERLGOiNIJnwAqDfoJHVszebn/Xfd4AFAW9YIboKN2aUpwV9gbgCZPeBnxaAXaZf/lNxVqUchJCEJ4Jep1ejmCJc0EnoDC5eEHjK9Ge345VAKdFrYBy29fqfp95N5dFsaKLvu6ec=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by DM6PR04MB7115.namprd04.prod.outlook.com (2603:10b6:5:24c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 12:01:58 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d093:80b3:59e5:c8a9]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d093:80b3:59e5:c8a9%6]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 12:01:58 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Andreas Hindborg <nmi@metaspace.dk>
CC:     Ming Lei <ming.lei@redhat.com>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        open list <linux-kernel@vger.kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "hch@infradead.org" <hch@infradead.org>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH v9 2/2] ublk: enable zoned storage support
Thread-Topic: [PATCH v9 2/2] ublk: enable zoned storage support
Thread-Index: AQHZujjR8MHYu8QnSkan/Tn6GMGsmw==
Date:   Wed, 19 Jul 2023 12:01:58 +0000
Message-ID: <ZLfQjNK5j5lB68C/@x1-carbon>
References: <20230714072510.47770-1-nmi@metaspace.dk>
 <20230714072510.47770-3-nmi@metaspace.dk>
In-Reply-To: <20230714072510.47770-3-nmi@metaspace.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|DM6PR04MB7115:EE_
x-ms-office365-filtering-correlation-id: d9dd34a2-26c9-438e-c57e-08db884ff423
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q0MG3sIVYU9S48LFYG61s3Na4IcdNv8rc3Cx8sgVzyV4EmGbXRuGpQvRI3BFzqCvmic3feY9CEJedKxwJzVsA5IGQP6oG4yKFTS0R+rhXa7gSQfQExuV32cRYGjSD/rTW7zlgSIs/tNSM4/6zRZiz9Rz+9xNWesLReJeQQMO4g1sdhzbbpQE7YdQdolYtJHaM3WqFgrsYgSEiYLAIp7WlFQLapsR7kaemhZLedlB83YPWXpzg+ldqgi4CpbLidZbDYY5exVgYJCLVWzEF1F/gaVMqhBiQ3jmQYzoGOrrSknWhlPKfsmGuLUJwUXOtb4eTu1gVr1FXBqzPac+fyFjU/nKTUTwrFx8IXbl1jk1jo1ImLjnF/j6I5JmhWjPr8lQ6BYFQ6ryZUDB6QFt9DZbZvi3rHx+nQ7Gtciu4aHK+aUye0Q3fx4PUbdwxM9cl62ry70to0RtOZAmpm+A+0OjxIek92tcHMJ4j+DlvwfxU5Cxi26YDz13a2XNYwx1Zqi5aY0B+16cVW4GELfbKfwc4VAmAsCc38kpZPTY2fzTBMTIVfZ+fpFrTt1RUrUWg/85lqzg17h47s7+478WL/ZQnk7w6LORMZzd5vGXZ3EX1dCre7ADuxxm+5mVUkJDgwW2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(451199021)(30864003)(2906002)(41300700001)(316002)(7416002)(5660300002)(8676002)(38070700005)(86362001)(8936002)(33716001)(6512007)(9686003)(26005)(6506007)(478600001)(6486002)(71200400001)(83380400001)(186003)(82960400001)(38100700002)(91956017)(6916009)(122000001)(4326008)(76116006)(66446008)(66476007)(66556008)(64756008)(66946007)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?k8wIehqpMXlB3tasUnQby8Gsd7+NzoeCeBiQECLQ1oFJW2gSwfgNzN7AVz?=
 =?iso-8859-1?Q?3X4MMo62NJJ8nP6IZs0/+anRZALd7mNIKExdDEWyH+548Dtpp9Oq69Bm+9?=
 =?iso-8859-1?Q?OWEQZrAOg49PJPYVzDUGgcN5MJL8XiyH7DJXAp3QosypW2PR0dL5qyeoSW?=
 =?iso-8859-1?Q?PKSf3t3JZpsaUrWIai7LEYBMvRUchJxG+U8YQqLix/s0/MPYIF3nOwrYiR?=
 =?iso-8859-1?Q?6vibMKBFgwY6HCszGvaklAL4Ht6A0QWeyZDwRZ9nmFDlSiwexC2SeLsWr5?=
 =?iso-8859-1?Q?kqHUYrAVRObd0/93+damcbmvNcdsgn75rho0VMsMD/59IuIAr7VN9sIs5b?=
 =?iso-8859-1?Q?d6Um6gH++80Z2r3btzit757tJlCwTfZ8uIQNH/itumKIdzR51nsGHjibHe?=
 =?iso-8859-1?Q?Ous8FAlwtC7UkQHikWBdnUGjbzdyP/kBs17qzEFg/BkDFGGH4Mps6fXmUR?=
 =?iso-8859-1?Q?6tA5A56KEgcdKDKqzWwLiimRtWJgvrnUK5qaOFIdsnsHU7+z1V1ON6Ot3D?=
 =?iso-8859-1?Q?GtMK1L7V8nCUapZUxbIJ7+rFYNgCyLoNFuVxA2JljRzlhuPMGjj5BMqHPJ?=
 =?iso-8859-1?Q?Gzvb4YwhkRSigo2yRO8iP0646/FdpxeuyLfFwMhtIHOfq7Bx+8d+C0yL93?=
 =?iso-8859-1?Q?U+3gadCIZkFTDKsSCRKRcWw7MMA0+vB9oVsCxX3DfaZ1n/ZvosAuaEsey9?=
 =?iso-8859-1?Q?U9Z2SDR9Mu2X6COdM+SrNdMg3SFLLlwf6b8wWfCyg7/Ge3j+//497vjIhD?=
 =?iso-8859-1?Q?+qwm4ix6evsWZjcDbqOqxnimcaoxUJ9yMi1GrZKlLXJUmy4IQ/8STVLDt/?=
 =?iso-8859-1?Q?gBmxyYZzB9C29M8x5BerEF+8IusunTXvTq+OI0qeWIHZAxiMPJ/K3i6ba/?=
 =?iso-8859-1?Q?WdcAy/2gTOe3gzWqz9pwt5p3+6YIAT5jH34sUijFv/5tqtDLvh2Z1TD3/m?=
 =?iso-8859-1?Q?Xltt+0MJ5hvOTOYXvKrvdMVA01lE7Hv2/+RSUTjm/0f/Sw6REHQTrBiVY1?=
 =?iso-8859-1?Q?anknew8sWCkzP+K2Mc1/IwUxNj504e27jOVuRgCDYRRDafcdvphzmFrrog?=
 =?iso-8859-1?Q?2X83B3quoVfZACrAeGe8BoNJSqufDf4sK/KPYz0CFhiNRBlxfKZhUq9oX+?=
 =?iso-8859-1?Q?A49EGPTbeYRmWyWisau8ems0xX21MspvCSuI6Q8ApBmhj3KwPgC3Oy0N4U?=
 =?iso-8859-1?Q?/EueVlf3UGv/G6U/rM2EIOSBgih3IcT0OOPx9WfON0SaFeUNEdAfSr2Fy1?=
 =?iso-8859-1?Q?TNp6pEeQgpJOtdWbJduD71za7dLd2HQqaOC5M3OSdrtY423b6w6GrnEXA4?=
 =?iso-8859-1?Q?sV2pCVlm0yan4Q41tja/vWUOoITM8P9D9sASMwFdESV1+oJkr8fOqwJgD9?=
 =?iso-8859-1?Q?kBSi4oCd9z4CzPs+qTFnyrJTNS0/ytBakTk1oOef1rCELr70weMZICSJeT?=
 =?iso-8859-1?Q?hQC1NmYBf4GnI1/OubfN6EiAcjqcW/XOlog6IXgskwJme4khCEpff546fB?=
 =?iso-8859-1?Q?npOxHv6/fSEWAl2hZ1+YZCEft23l0LSw23o+mlYn2vDbng2XPch9r+Cwiy?=
 =?iso-8859-1?Q?+6tm60UWuWh44uFpFAmfP9hKBf1LlAfPt++OR4qTmUdPBFoUpHuSD1f9ds?=
 =?iso-8859-1?Q?/vl5TiUpQJ9o2PGZVT9rd/thVemUy3tWzvQkXrojtr6FgMA5UEUbX6Jw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <E579B3DEF1F9E3438F685DE4B8912028@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?N9yAEWeBW8lVofa3OxRp6/zlNNTyeo8FVh3tgic99uDwieA22FHNA3IEIi?=
 =?iso-8859-1?Q?qOAHTdghAkivQK/UM96131gj51sxFac8dcaEXoD0bmELsAL5avc1RrrXAL?=
 =?iso-8859-1?Q?csx+DdGI8QAAXUi8WaNbbk99N+pXcNfg7uPggBRzvOk5nJOHS7umNOEcFq?=
 =?iso-8859-1?Q?90So4HEG/bq/xpRaiWNqphCfP2DSDGDFioqGk7pMKRr0nfeKUeTAGkh3ga?=
 =?iso-8859-1?Q?jOcOklmcIIPZwCpjWMIuya9sdAEnMMl20mQLZUCnA+kJIx4FqzpydUD06R?=
 =?iso-8859-1?Q?RVc5Sx2LO5mkx9gSBMEuGTm7SsyGJ8M6SlDNjv8Xo2LKtW9kYfAB/KUolx?=
 =?iso-8859-1?Q?fWvQ6mnU3xkoxESHM8N29KSDa0TEHckK+Ruknq3FARJyTQ6mKUQxn7kkm9?=
 =?iso-8859-1?Q?2BEFq9As2Z7HzfL3yTOeRh3ZrwXt55z8ljhNo7nehMUzN4NpjfOnk7n1jE?=
 =?iso-8859-1?Q?p4LawRdwhpmhkbXcsX5vYtJJR7G0Rt3XpgyF/Fs6xwZB1wIrFo14Xel60p?=
 =?iso-8859-1?Q?nslNPZglSBgLaiqCnMyAq2dUJdcT9R5uq6SqJMKsRhmMrjPFCRMU0kk5tg?=
 =?iso-8859-1?Q?U/gKvO7EdVWqejAHMCf+GP8rmOnbAxpvxq3/wFKavMgGVJie4ge7yZGBcQ?=
 =?iso-8859-1?Q?eddD8accNU+8DPg9St+xVpa/vC6gt5s3XIyUYa4MitSseavRZTTu/1xKPM?=
 =?iso-8859-1?Q?VU97pJYKHFQRh8JuKTRNLsYE7aUr8t29xyDh2Z4DfKqJ5fYEE8JUWZwb1g?=
 =?iso-8859-1?Q?MWkcPM4mjzbchRUx1X9d65mjcEK8ICb7Mlb6j8wte3EYFErGkZKDHmUpo3?=
 =?iso-8859-1?Q?Z2yDEu91QJM+kJHOssHDecuELCYJS1H1zzcbs6xS9mkKihKOtVRaiMwgud?=
 =?iso-8859-1?Q?Wp+MCNf3KOBJ/Uj5x2hiMw1I0Kru1AI2LZhhfh8Bu5eh6KspHcvaYSSFtF?=
 =?iso-8859-1?Q?vC/9tBxx+VaN+0AYrWFaHz8s028LVlGtr4hhXSgzuzKXCLJTAPBryjrkrs?=
 =?iso-8859-1?Q?vca8/3sTvPrkWe9612XXVUoiO88DJSs0tzhU+s?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9dd34a2-26c9-438e-c57e-08db884ff423
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 12:01:58.2366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l5td3NaFA8H5K1zCTsqhkBcqQNjOnQJirELG/I1FMV68n/ZBDt4nYE9HKJBa2yH+w4GqIjdz8k8kwK4qdLmAyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7115
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 09:25:10AM +0200, Andreas Hindborg wrote:
> From: Andreas Hindborg <a.hindborg@samsung.com>

Hello Andreas!

>=20
> Add zoned storage support to ublk: report_zones and operations:
>  - REQ_OP_ZONE_OPEN
>  - REQ_OP_ZONE_CLOSE
>  - REQ_OP_ZONE_FINISH
>  - REQ_OP_ZONE_RESET
>  - REQ_OP_ZONE_APPEND
>=20
> The zone append feature uses the `addr` field of `struct ublksrv_io_cmd` =
to
> communicate ALBA back to the kernel. Therefore ublk must be used with the
> user copy feature (UBLK_F_USER_COPY) for zoned storage support to be
> available. Without this feature, ublk will not allow zoned storage suppor=
t.
>=20
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> ---
>  drivers/block/ublk_drv.c      | 335 ++++++++++++++++++++++++++++++++--
>  include/uapi/linux/ublk_cmd.h |  36 +++-
>  2 files changed, 354 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 8d271901efac..5698f4575e05 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -56,16 +56,21 @@
>  		| UBLK_F_USER_RECOVERY_REISSUE \
>  		| UBLK_F_UNPRIVILEGED_DEV \
>  		| UBLK_F_CMD_IOCTL_ENCODE \
> -		| UBLK_F_USER_COPY)
> +		| UBLK_F_USER_COPY \
> +		| UBLK_F_ZONED)
> =20
>  /* All UBLK_PARAM_TYPE_* should be included here */
> -#define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | \
> -		UBLK_PARAM_TYPE_DISCARD | UBLK_PARAM_TYPE_DEVT)
> +#define UBLK_PARAM_TYPE_ALL                                \
> +	(UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
> +	 UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED)
> =20
>  struct ublk_rq_data {
>  	struct llist_node node;
> =20
>  	struct kref ref;
> +	__u64 sector;
> +	__u32 operation;
> +	__u32 nr_sectors;
>  };
> =20
>  struct ublk_uring_cmd_pdu {
> @@ -110,6 +115,11 @@ struct ublk_uring_cmd_pdu {
>   */
>  #define UBLK_IO_FLAG_NEED_GET_DATA 0x08
> =20
> +/*
> + * Set when IO is Zone Append
> + */
> +#define UBLK_IO_FLAG_ZONE_APPEND 0x10
> +
>  struct ublk_io {
>  	/* userspace buffer address from io cmd */
>  	__u64	addr;
> @@ -185,11 +195,264 @@ struct ublk_params_header {
>  	__u32	types;
>  };
> =20
> +static inline unsigned int ublk_req_build_flags(struct request *req);
> +static inline struct ublksrv_io_desc *ublk_get_iod(struct ublk_queue *ub=
q,
> +						   int tag);
> +
>  static inline bool ublk_dev_is_user_copy(const struct ublk_device *ub)
>  {
>  	return ub->dev_info.flags & UBLK_F_USER_COPY;
>  }
> =20
> +static inline bool ublk_dev_is_zoned(const struct ublk_device *ub)
> +{
> +	return ub->dev_info.flags & UBLK_F_ZONED;
> +}
> +
> +static inline bool ublk_queue_is_zoned(struct ublk_queue *ubq)
> +{
> +	return ubq->flags & UBLK_F_ZONED;
> +}
> +
> +#ifdef CONFIG_BLK_DEV_ZONED
> +
> +static int ublk_get_nr_zones(const struct ublk_device *ub)
> +{
> +	const struct ublk_param_basic *p =3D &ub->params.basic;
> +
> +	/* Zone size is a power of 2 */
> +	return p->dev_sectors >> ilog2(p->chunk_sectors);
> +}
> +
> +static int ublk_revalidate_disk_zones(struct ublk_device *ub)
> +{
> +	return blk_revalidate_disk_zones(ub->ub_disk, NULL);
> +}
> +
> +static int ublk_dev_param_zoned_validate(const struct ublk_device *ub)
> +{
> +	const struct ublk_param_zoned *p =3D &ub->params.zoned;
> +	int nr_zones;
> +
> +	if (!ublk_dev_is_zoned(ub))
> +		return -EINVAL;
> +
> +	if (!p->max_zone_append_sectors)
> +		return -EINVAL;
> +
> +	nr_zones =3D ublk_get_nr_zones(ub);
> +
> +	if (p->max_active_zones > nr_zones)
> +		return -EINVAL;
> +
> +	if (p->max_open_zones > nr_zones)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int ublk_dev_param_zoned_apply(struct ublk_device *ub)
> +{
> +	const struct ublk_param_zoned *p =3D &ub->params.zoned;
> +
> +	disk_set_zoned(ub->ub_disk, BLK_ZONED_HM);
> +	blk_queue_required_elevator_features(ub->ub_disk->queue,
> +					     ELEVATOR_F_ZBD_SEQ_WRITE);
> +	disk_set_max_active_zones(ub->ub_disk, p->max_active_zones);
> +	disk_set_max_open_zones(ub->ub_disk, p->max_open_zones);
> +	blk_queue_max_zone_append_sectors(ub->ub_disk->queue, p->max_zone_appen=
d_sectors);
> +
> +	ub->ub_disk->nr_zones =3D ublk_get_nr_zones(ub);
> +
> +	return 0;
> +}
> +
> +/* Based on virtblk_alloc_report_buffer */
> +static void *ublk_alloc_report_buffer(struct ublk_device *ublk,
> +				      unsigned int nr_zones, size_t *buflen)
> +{
> +	struct request_queue *q =3D ublk->ub_disk->queue;
> +	size_t bufsize;
> +	void *buf;
> +
> +	nr_zones =3D min_t(unsigned int, nr_zones,
> +			 ublk->ub_disk->nr_zones);
> +
> +	bufsize =3D nr_zones * sizeof(struct blk_zone);
> +	bufsize =3D
> +		min_t(size_t, bufsize, queue_max_hw_sectors(q) << SECTOR_SHIFT);
> +
> +	while (bufsize >=3D sizeof(struct blk_zone)) {
> +		buf =3D __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);
> +		if (buf) {
> +			*buflen =3D bufsize;
> +			return buf;
> +		}
> +		bufsize >>=3D 1;
> +	}
> +
> +	*buflen =3D 0;
> +	return NULL;
> +}
> +
> +static int ublk_report_zones(struct gendisk *disk, sector_t sector,
> +		      unsigned int nr_zones, report_zones_cb cb, void *data)
> +{
> +	struct ublk_device *ub =3D disk->private_data;
> +	unsigned int zone_size_sectors =3D disk->queue->limits.chunk_sectors;
> +	unsigned int first_zone =3D sector >> ilog2(zone_size_sectors);
> +	unsigned int done_zones =3D 0;
> +	unsigned int max_zones_per_request;
> +	int ret;
> +	struct blk_zone *buffer;
> +	size_t buffer_length;
> +
> +	nr_zones =3D min_t(unsigned int, ub->ub_disk->nr_zones - first_zone,
> +			 nr_zones);
> +
> +	buffer =3D ublk_alloc_report_buffer(ub, nr_zones, &buffer_length);
> +	if (!buffer)
> +		return -ENOMEM;
> +
> +	max_zones_per_request =3D buffer_length / sizeof(struct blk_zone);
> +
> +	while (done_zones < nr_zones) {
> +		unsigned int remaining_zones =3D nr_zones - done_zones;
> +		unsigned int zones_in_request =3D
> +			min_t(unsigned int, remaining_zones, max_zones_per_request);
> +		struct request *req;
> +		struct ublk_rq_data *pdu;
> +		blk_status_t status;
> +
> +		memset(buffer, 0, buffer_length);
> +
> +		req =3D blk_mq_alloc_request(disk->queue, REQ_OP_DRV_IN, 0);
> +		if (IS_ERR(req)) {
> +			ret =3D PTR_ERR(req);
> +			goto out;
> +		}
> +
> +		pdu =3D blk_mq_rq_to_pdu(req);
> +		pdu->operation =3D UBLK_IO_OP_REPORT_ZONES;
> +		pdu->sector =3D sector;
> +		pdu->nr_sectors =3D zones_in_request * zone_size_sectors;
> +
> +		ret =3D blk_rq_map_kern(disk->queue, req, buffer, buffer_length,
> +					GFP_KERNEL);
> +		if (ret) {
> +			blk_mq_free_request(req);
> +			goto out;
> +		}
> +
> +		status =3D blk_execute_rq(req, 0);
> +		ret =3D blk_status_to_errno(status);
> +		blk_mq_free_request(req);
> +		if (ret)
> +			goto out;
> +
> +		for (unsigned int i =3D 0; i < zones_in_request; i++) {
> +			struct blk_zone *zone =3D buffer + i;
> +
> +			/* A zero length zone means no more zones in this response */
> +			if (!zone->len)
> +				break;
> +
> +			ret =3D cb(zone, i, data);
> +			if (ret)
> +				goto out;
> +
> +			done_zones++;
> +			sector +=3D zone_size_sectors;
> +
> +		}
> +	}
> +
> +	ret =3D done_zones;
> +
> +out:
> +	kvfree(buffer);
> +	return ret;
> +}
> +
> +static blk_status_t ublk_setup_iod_zoned(struct ublk_queue *ubq,
> +					 struct request *req)
> +{
> +	struct ublksrv_io_desc *iod =3D ublk_get_iod(ubq, req->tag);
> +	struct ublk_io *io =3D &ubq->ios[req->tag];
> +	struct ublk_rq_data *pdu =3D blk_mq_rq_to_pdu(req);
> +	u32 ublk_op;
> +
> +	switch (req_op(req)) {
> +	case REQ_OP_ZONE_OPEN:
> +		ublk_op =3D UBLK_IO_OP_ZONE_OPEN;
> +		break;
> +	case REQ_OP_ZONE_CLOSE:
> +		ublk_op =3D UBLK_IO_OP_ZONE_CLOSE;
> +		break;
> +	case REQ_OP_ZONE_FINISH:
> +		ublk_op =3D UBLK_IO_OP_ZONE_FINISH;
> +		break;
> +	case REQ_OP_ZONE_RESET:
> +		ublk_op =3D UBLK_IO_OP_ZONE_RESET;
> +		break;
> +	case REQ_OP_ZONE_APPEND:
> +		ublk_op =3D UBLK_IO_OP_ZONE_APPEND;
> +		io->flags |=3D UBLK_IO_FLAG_ZONE_APPEND;
> +		break;
> +	case REQ_OP_DRV_IN:
> +		ublk_op =3D pdu->operation;
> +		switch (ublk_op) {
> +		case UBLK_IO_OP_REPORT_ZONES:
> +			iod->op_flags =3D ublk_op | ublk_req_build_flags(req);
> +			iod->nr_sectors =3D pdu->nr_sectors;
> +			iod->start_sector =3D pdu->sector;
> +			return BLK_STS_OK;
> +		default:
> +			return BLK_STS_IOERR;
> +		}
> +	case REQ_OP_ZONE_RESET_ALL:
> +	case REQ_OP_DRV_OUT:
> +		/* We do not support reset_all and drv_out */
> +		return BLK_STS_NOTSUPP;
> +	default:
> +		return BLK_STS_IOERR;
> +	}
> +
> +	iod->op_flags =3D ublk_op | ublk_req_build_flags(req);
> +	iod->nr_sectors =3D blk_rq_sectors(req);
> +	iod->start_sector =3D blk_rq_pos(req);
> +	iod->addr =3D io->addr;
> +
> +	return BLK_STS_OK;
> +}
> +
> +#else
> +
> +#define ublk_report_zones (NULL)
> +
> +static int ublk_dev_param_zoned_validate(const struct ublk_device *ub)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int ublk_dev_param_zoned_apply(struct ublk_device *ub)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int ublk_revalidate_disk_zones(struct ublk_device *ub)
> +{
> +	return 0;
> +}
> +
> +static blk_status_t ublk_setup_iod_zoned(struct ublk_queue *ubq,
> +					 struct request *req)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +#endif
> +
>  static inline void __ublk_complete_rq(struct request *req);
>  static void ublk_complete_rq(struct kref *ref);
> =20
> @@ -286,6 +549,9 @@ static int ublk_validate_params(const struct ublk_dev=
ice *ub)
> =20
>  		if (p->max_sectors > (ub->dev_info.max_io_buf_bytes >> 9))
>  			return -EINVAL;
> +
> +		if (ublk_dev_is_zoned(ub) && !p->chunk_sectors)
> +			return -EINVAL;
>  	} else
>  		return -EINVAL;
> =20
> @@ -304,6 +570,11 @@ static int ublk_validate_params(const struct ublk_de=
vice *ub)
>  	if (ub->params.types & UBLK_PARAM_TYPE_DEVT)
>  		return -EINVAL;
> =20
> +	if (ub->params.types & UBLK_PARAM_TYPE_ZONED)
> +		return ublk_dev_param_zoned_validate(ub);
> +	else if (ublk_dev_is_zoned(ub))
> +		return -EINVAL;
> +
>  	return 0;
>  }
> =20
> @@ -317,6 +588,9 @@ static int ublk_apply_params(struct ublk_device *ub)
>  	if (ub->params.types & UBLK_PARAM_TYPE_DISCARD)
>  		ublk_dev_param_discard_apply(ub);
> =20
> +	if (ub->params.types & UBLK_PARAM_TYPE_ZONED)
> +		return ublk_dev_param_zoned_apply(ub);
> +
>  	return 0;
>  }
> =20
> @@ -487,6 +761,7 @@ static const struct block_device_operations ub_fops =
=3D {
>  	.owner =3D	THIS_MODULE,
>  	.open =3D		ublk_open,
>  	.free_disk =3D	ublk_free_disk,
> +	.report_zones =3D	ublk_report_zones,
>  };
> =20
>  #define UBLK_MAX_PIN_PAGES	32
> @@ -601,7 +876,8 @@ static inline bool ublk_need_map_req(const struct req=
uest *req)
> =20
>  static inline bool ublk_need_unmap_req(const struct request *req)
>  {
> -	return ublk_rq_has_data(req) && req_op(req) =3D=3D REQ_OP_READ;
> +	return ublk_rq_has_data(req) &&
> +	       (req_op(req) =3D=3D REQ_OP_READ || req_op(req) =3D=3D REQ_OP_DRV=
_IN);
>  }
> =20
>  static int ublk_map_io(const struct ublk_queue *ubq, const struct reques=
t *req,
> @@ -685,8 +961,13 @@ static blk_status_t ublk_setup_iod(struct ublk_queue=
 *ubq, struct request *req)
>  {
>  	struct ublksrv_io_desc *iod =3D ublk_get_iod(ubq, req->tag);
>  	struct ublk_io *io =3D &ubq->ios[req->tag];
> +	enum req_op op =3D req_op(req);
>  	u32 ublk_op;
> =20
> +	if (!ublk_queue_is_zoned(ubq) &&
> +	    (op_is_zone_mgmt(op) || op =3D=3D REQ_OP_ZONE_APPEND))
> +		return -EIO;
> +
>  	switch (req_op(req)) {
>  	case REQ_OP_READ:
>  		ublk_op =3D UBLK_IO_OP_READ;
> @@ -704,6 +985,8 @@ static blk_status_t ublk_setup_iod(struct ublk_queue =
*ubq, struct request *req)
>  		ublk_op =3D UBLK_IO_OP_WRITE_ZEROES;
>  		break;
>  	default:
> +		if (ublk_queue_is_zoned(ubq))
> +			return ublk_setup_iod_zoned(ubq, req);
>  		return BLK_STS_IOERR;
>  	}
> =20
> @@ -756,7 +1039,8 @@ static inline void __ublk_complete_rq(struct request=
 *req)
>  	 *
>  	 * Both the two needn't unmap.
>  	 */
> -	if (req_op(req) !=3D REQ_OP_READ && req_op(req) !=3D REQ_OP_WRITE)
> +	if (req_op(req) !=3D REQ_OP_READ && req_op(req) !=3D REQ_OP_WRITE &&
> +	    req_op(req) !=3D REQ_OP_DRV_IN)
>  		goto exit;
> =20
>  	/* for READ request, writing data in iod->addr to rq buffers */
> @@ -1120,6 +1404,11 @@ static void ublk_commit_completion(struct ublk_dev=
ice *ub,
>  	/* find the io request and complete */
>  	req =3D blk_mq_tag_to_rq(ub->tag_set.tags[qid], tag);
> =20
> +	if (io->flags & UBLK_IO_FLAG_ZONE_APPEND) {

Do we really need to introduce a completely new flag just for this?

if (req_op(req) =3D=3D REQ_OP_ZONE_APPEND)

should work just as well, no?


Kind regards,
Niklas=
