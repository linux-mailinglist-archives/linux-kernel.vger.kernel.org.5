Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94C578FB66
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbjIAJtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347086AbjIAJt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:49:26 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFFE10E0;
        Fri,  1 Sep 2023 02:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1693561763; x=1725097763;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3eEKLsHUkGclLOGoXaTYeqFyN3TNYQ1gsRbN2VKWsm4=;
  b=EizZGvurpIJvlIvkrD30/b7fxc9Yi6i1fXDwLwsqVR8z450ozegWGhTn
   qfGRjqO7YdKJqFA3BLpX3AVmEPqXS0U0r01dnnKKwxeRltx97Cw0RFgHG
   K51AEiTz9waEZGWes3vmzK+Eo0AAb8aYY38RegoTLFANBF505Dzlq5n88
   rXrJvHk038ifCVGk/dMhlsiCoiIY0rJxNlNblCjDu4MVyUZa9mNY/3Vd2
   uk6e0hH2a7Rsl2DVe/Y28vy+vMD2lx3pw51TGy/KYIxDg+CiKvn2i6v3J
   z8CuxpoFg1VMBA14CFspx5TBvTs9q/5LK2pDoPS4SO2PR1NppcdlOavdg
   w==;
X-IronPort-AV: E=Sophos;i="6.02,219,1688400000"; 
   d="scan'208";a="354735459"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2023 17:49:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcFbeGlNHs/yj++vx6zT+fRu0Dmzz8RU14BpGbBD9uBjSF6n/Q77HFKmYs2tOf1YiwqR35BaAjkasxQQo+lzXc5jOL4rhMgfA45s5a9pr7v0kCtUWtbdng9ynCAxWMcU/Ta6KKBv/Y5DJtP65W2AubYqw4n6sRzD2GKG0308xgB27M9SxijDX66/+t/rKh2M6/DWfKqXGx3ABMOa9eoe4gmX/Cltz2yX7l2N6M+u+XrGNVaPYfiFmQJWDs3pDt4l7dVMrlF9ih/DLrUYnrpMMgHclQOHf7URoLLwgc2MQrQA86P3hCldHxTPCzl2AnFZ30OjLaFfePDh94v8BFxQrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0oMv933GqYNCeh6sd90QVVgjYQHuL7cfVWTIxb15z4=;
 b=UFeQ0ZPVfVmeMlNmCnOqflsvlBUXwQce32cVva4ig0fRRTJmMK5PRuSDqHVpqpibMlfPDcq+wOCLNQJxVn/VrZ5H/2Ps8o3BHQJQ6DPzxIl//laF93jrLp/Syv+B6RyLkW+QsDf8CIOkULCz5unePP7kP/e41FYp8zXGiWbiin56wrTKjzKkP8AGA1mplCYGHsAs6InR6vQQsRVPc2QkKxVsl4RULn+TtEuUGxj48Cpgtvg7CrfSLaug1FDMvgcC3ydBRWvMfZyTg2LkdmZFjfSwNVXGGlcVVfTeK2ovbb7Q//hayV1A307Ygh9bEwhAvhmm0v8fan0QM6mUTxXp1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0oMv933GqYNCeh6sd90QVVgjYQHuL7cfVWTIxb15z4=;
 b=r3WQ0I7fKLNXzOp5DqcChtTWJg+efew4TEA+hmIcefymnHH+L90dE8dg5jesKSBClOgjIqUUmqhLHPAiG6skcw0C3enBw9xcblLZ3cStC5TfOoduM+epHJ4PGWLN/Hg18IGDq8KRNRcSY/UvFmBtHnyzeVbweiF25uEpUZ3f56k=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by DM6PR04MB7018.namprd04.prod.outlook.com (2603:10b6:5:24d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.12; Fri, 1 Sep
 2023 09:49:20 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5%2]) with mapi id 15.20.6768.014; Fri, 1 Sep 2023
 09:49:20 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Pawel Zmarzly <pzmarzly@meta.com>
CC:     Damien Le Moal <dlemoal@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ata: Disable NCQ_TRIM on Micron 1100 drives
Thread-Topic: [PATCH] ata: Disable NCQ_TRIM on Micron 1100 drives
Thread-Index: AQHZ3LmTO8yqhY6jokarzNFz0xNBcg==
Date:   Fri, 1 Sep 2023 09:49:19 +0000
Message-ID: <ZPGznkRMxemW2N9E@x1-carbon>
References: <20230831000222.576254-1-pzmarzly@meta.com>
In-Reply-To: <20230831000222.576254-1-pzmarzly@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|DM6PR04MB7018:EE_
x-ms-office365-filtering-correlation-id: d389b0cc-d9d3-4ee9-bd21-08dbaad0b6ac
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: szH+YdztBYBF+VGLxzam7nKlSNzlV9fQQPrTn33RMJlSfurse/u4kxaZa0GLIp4CNKcLuIdYh4UFZtTE2ilkLTENmTTedkjfcL+7Rju8mXGbrRlttL+cu6NfDKDcFiaKvYQ4Z8eABerAhtnYr4OnxXAHWqCnByqddkt7Mdd5R7/Z8osuq2ZEckPJN4cqj1J0tsK5RrtEyUhBgy2nfITAKgF8dJQxdaxQfMXp5HD7tR1iY51FFOViUvBwf9sNhDQ/eCF1mfMe0Lllr53uah/GqRDWHRKR+bdfJWHyRgrR8oecjV8/hK3Hj2LUy3hlxI6q+3kWCr4EkAtn+TEgEMbTgA1s6SekkFJoSTqmZgt3Yv/9tQtCEVPTMeIFT1ybesDnh1fDvqwoBZQ/AOjGHj95IP0atMlx7piMnYIkx7QOKuaNH1m/TF9ZONx1n/5oPbkuyR6ZDrFUlYXAtIDLFXqq2AzTzbNFoAzvcuEGnEr0I0uWo8hv7bCVFaB0m04B9mhRIqENkPqZTHrFJSJvvU7J1YYN/Jb4fKH/b06Be6wbdJKfjtUlR7b+ZZ7TFNh9QUGc/4f1RpEM43kDuBiAM6R+FLYVCpUZLneQhPWP6uQ1SDHKz2i6BytQOEtIUVSDPzzo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199024)(186009)(1800799009)(71200400001)(6506007)(9686003)(6512007)(6486002)(82960400001)(86362001)(122000001)(38070700005)(38100700002)(2906002)(26005)(83380400001)(478600001)(91956017)(76116006)(66946007)(8676002)(8936002)(4326008)(5660300002)(6916009)(41300700001)(316002)(66476007)(66446008)(54906003)(66556008)(64756008)(33716001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3LjYmReIL24/MfdrfaVH7VkjmRCSwhaGF5nBOzEBgPPnMRn8ezS/OlILZbmo?=
 =?us-ascii?Q?Lj7TQx3zJidPTyaPitfh+BZqAVbI+crO+1vV7p9SpgfrN1f7E1YxGB9fKKJi?=
 =?us-ascii?Q?FLcW1v0e+LYkpaOulTbvrR8tJKR2wyB/47fGYRF0q9g03CRPX2+r2CsFBM8H?=
 =?us-ascii?Q?Fe9phFeUq+58X74oX89ILDBfZRPZWmRqzKrcfb09FCUjB49DhpiksnKmXqCF?=
 =?us-ascii?Q?WhE19C0lTWDE/e8Psz3rX17D3lhDQ2XaJuRhEd6EohYDAok1EhKxFMqdI5Xx?=
 =?us-ascii?Q?TZTHJV3gE17laY7i6AD/HsQFVSFKMOl7kD5CmVTXAZ+48MAchJc67j0EzAua?=
 =?us-ascii?Q?eanI12BI3yQOhGZPQueRN7XMBf+KnpgXuPd6Lh9mZroT3ngU2t9/oGCoIhfd?=
 =?us-ascii?Q?iOk7oUkOJv9gtpZf5Z4yqcryqeRhN2HtYLSLr7cOtzozn87wqvuvJ1ILOhjw?=
 =?us-ascii?Q?y7KtXWOfnmf2fQ8g3WFfz4shquIG5smh+d19eBKf7GiIIKQga6dHD6RPVkuq?=
 =?us-ascii?Q?VaAc36EjMbTpInsnvUndg6CLeP/jp8aqmO1j05htXJDNnfXEjJvTCwf12Pt5?=
 =?us-ascii?Q?ZeUI05vCM9+y+V42bbte2gWylC0UL5+3XyLDgesHVJyxyjD9PQeAkWUbkh9b?=
 =?us-ascii?Q?R3mEZ1rwDPUdcTJW7JL4F0a6SlsX/ICHm3v/7NXBGvpuVxHAxAwx37agUhtM?=
 =?us-ascii?Q?HjZOTVHq+PVqpmng7TAwo7wjyegX2yKGbI5oLYahUZrKCmRDeBJQ9Oe4FA9r?=
 =?us-ascii?Q?91JkafKQhbvia18j1Lo9Pjh3OvRe6ZUp6cBR0p3m0ApUvynlC6Q66Kw2Z8nM?=
 =?us-ascii?Q?mprnChcaxaXys4zd76mUkfAEIv3KJruhsrAYml0dQxH+6psF8T8Q4klMzVJ1?=
 =?us-ascii?Q?Z02cNnhAkbHuBwEe+Rr4FcLM63Pha6Vgl50WX3/sk4TxWSecjxjEs4Vaj0x9?=
 =?us-ascii?Q?FyyZQKOBMB9UL0WUjHBCc2MG8+zGS/Mw7iXmwrEalqRKkRCADZVy/jGgLuuV?=
 =?us-ascii?Q?f77BjqVIyMSE25gYmhIw0w01HMABdNBhbtCaglZrlPzwIT3Wclv2GMb6gVZa?=
 =?us-ascii?Q?1ZzIPvYQNfPqMWh285mL+zm7NkkR8YRkEHV0s8SULKYb2iAvkYLQdNEBmEvg?=
 =?us-ascii?Q?Zn6llaD/WRo9SI4iTTAe7zYufa/O6y0Fvj/AmA4MojNyUrM8uMvwXMwNKINf?=
 =?us-ascii?Q?pF5VR4rCyNt03XG0VdNL6YkP7cghNhGb4FDUC1xKAU8d6rejHAOwOhmg56CX?=
 =?us-ascii?Q?KaxX4ewR93rpFL7PGZ+wbLP72o39bRiBz+W8JSFBsT+aF8lYLUh2s9CxPiUa?=
 =?us-ascii?Q?FhukNmEmtqxzQU5urWKJAZ85OarwpFyBExQKB/u6MM1/Y0w68FZSDk/+VgyT?=
 =?us-ascii?Q?KOjheVsp+7Z2Fp5/YGtOYSshbJInxcGcDCEL1hRlcFzdvueRDZcu4ZU3AS1f?=
 =?us-ascii?Q?1y/oCLMm8eysBpS16s40JrX1bdiHjMO+iZFgLa2KnHWOGBEvCU+YxDDA4obE?=
 =?us-ascii?Q?1G4ouU+EHM21UWk6BWVWOg1uXRdskF/IzZ3mnKUCxR2QBNPaySS4Hl6jCoVS?=
 =?us-ascii?Q?wDRdmcnPYBmFdryaaIjLj0NC/897yKRFRDyk4NC1NODcz67pb5SAyCOOefn8?=
 =?us-ascii?Q?sA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D5D3D28B1DD43442B847FA9D9129D417@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TsUks23D7ft4sUVi9wd8RiFOy+W05QPL5Ko5a2pfjyzuHZJYgy0uladAEJyAH7yBVs2K7kAXgSAeGJ+1tIVk6ItTYIUHg9T0RA/3FybK3cXpNwiDC1MbaDemxzcPs3OvsQoToXdx39M6PhGb0BXxeWlm47UIzihQSDn4AlbDwcHo1wj2tz+ucZHNR2+/Gexcm9NrtaBR0kNKZy7TzVUbVF8HfwWNc2zNhNYwCz3MsTQfTPFBGvvF3RRRIDEAp04irVbRhyzhiwet6IGk2IyonvXAROm5iau3xwyoB7W8fvePLTV2ki0w/2RDxufH4oUeRKHwQs4KWzZFca7tLOrK9a6MaSvwMY46T7v+QelVwesh7b/VuP6m+84fIrs4bb+IO+HSI1QYrq+G22ZqbBIU3Lvu/FVBbZQxeSh9U8bVSvDxEWB3a1EZ4XxxAs0GE7cb8ZHvp5m7eMGdz+ANNOZzFzRk6wWBJXysk8+8k0SQDDwBL3nDsmst2A05RTKUMFmqRJVqAgvZfAq1OaHDnpaVbzZYX2kkvANQYcZhD9+kDQwKE+HQtOC58KNmFKDAUih02LguQF7tgPmuhfCOkeGtQfvMovZn/hu6NjEQdmrHG8ARE5No4GBpmeIlP2SVoEKySJSMukKXDcpSsel+wqIylc08XWWx3j7EjS3crFL2myGnJoY024N6yZA/s34ICrWb4D4y6Y1L6OFo7aT9nTy/mO4lqXu/UnpDnNJxEbxm//O9XUAqAripDjsI17sjx9EKIhsSRL7UGRZn6iQvvlHUuXCNNaD0lqxst9db7PEyVDoetdYSEtc7eX8oAFgzAqne3WCaTYq5co9NPdrF3nrBBw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d389b0cc-d9d3-4ee9-bd21-08dbaad0b6ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2023 09:49:19.7270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DVpDVGJAk5CbTLOWD/2Wrgc2lXJAVflFpJArhYvpj3ok/rHo7VCrLTD6OY79q9cs53HJWZeSzXM+RhANOCa7aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7018
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 05:02:22PM -0700, Pawel Zmarzly wrote:

Hello Pawel,

> Micron 1100 drives lock up when encountering queued TRIM command.
> It is a quite old hardware series, for past years we have been
> running our machines with these drives using
> libata.force=3Dnoncqtrim.
>=20
> Signed-off-by: Pawel Zmarzly <pzmarzly@meta.com>
> ---
>  drivers/ata/libata-core.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 175b2a9dc000..d2466f2c5fea 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4564,6 +4564,8 @@ static const struct ata_blacklist_entry ata_device_=
blacklist [] =3D {
>  						ATA_HORKAGE_ZERO_AFTER_TRIM, },
>  	{ "FCCT*M500*",			NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
>  						ATA_HORKAGE_ZERO_AFTER_TRIM, },
> +	{ "Micron_1100_*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
> +					ATA_HORKAGE_ZERO_AFTER_TRIM, },

Please align ATA_HORKAGE_ZERO_AFTER_TRIM to ATA_HORKAGE_NO_NCQ_TRIM,
instead of aligning it to NULL. (That way it matches the existing entries.)


Kind regards,
Niklas=
