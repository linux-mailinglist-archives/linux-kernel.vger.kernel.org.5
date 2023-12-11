Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D28D80DD73
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 22:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345310AbjLKViJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 16:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345220AbjLKViI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 16:38:08 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Dec 2023 13:38:14 PST
Received: from esa.hc4959-67.iphmx.com (esa.hc4959-67.iphmx.com [139.138.35.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BD891
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 13:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
  t=1702330694; x=1733866694;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=6I2WJTqG73N5vhtuXp7D6b8KzAbLRh6EzVU/TOFLaFE=;
  b=HTn5X75eQb/zLoGROH5MlUsuJc4dC2QlK7zPyTA7DiKK2Nv5EpvvjrvG
   T+fmjsyZbcjhOLTg0GSSqPuk4TmtOax29N1qzUfAcGriet3asPI1HH2aT
   CFMgEFX6ISFrOr+c+NW9sRJEvq4F+9bWQFKUA/6cmJTgjflN8VsZMgO8Q
   Y=;
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 13:37:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0Gj8XAENkF6Irh/OGejey9Hkv1NuJ0UJ9BqvF0sZfAx8Phlm+OSHuwxQomPV8MErRd3s/BzIQ3j0QbyX8OLOgXGRG7rW9dptYQMWmDWKbvB11rj0kwNXme4uMiS3MVSKxLjqncUMetzMjOQWoNZaEQz1d7hi8SNf/eKnjCH5SuukRihyXUZlxBHk/0E98Qw1CZo5Io0+813Ipvms3tymWZsGZveHVN6a+A4HVX/COhMr+F81cEC3UKRkB5nT+6kAVz3xJT9pcqbkaB9oLWFIyTrl2OMggdqV24ak6hth7y8rg1P3xnqGh40Hg46FWzh6BVfqnB+9xsnh0uVijvJaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGn9o6+YgNBxamTKQtVevNA0K7m4wweh5DHsG488RG0=;
 b=J++gTzB/drb4Xva035+8XgNW21BGT0P3Kd7b6NRCPrMode9QijQAMZiEm9m8GX0PstGyUs8PtWSrs/ohULtkr+cP+ZM2cnGnEVIQlzP0cI7peqnuNzHh4GlmIAVcJVT/RAglK+FZLYbto38VeY6fXfIIHIYKwXtG2bRX2yFbMyaBOxZvVns4NPjx/F5RuEvOc1khu72zpPSPLoF9ITTUttf/ihFvCtWbX08x5f+OM0X649k75r+RkKgCX0kfXagl87Pcd6GSOCwngfhSCSYnXHeVFiYVsfp9bJrtzr57KMJKqgZRfNvggUyI3lXHDyr0vSgXEGy/BWVlfOwnwE5ZdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seagate.com; dmarc=pass action=none header.from=seagate.com;
 dkim=pass header.d=seagate.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGn9o6+YgNBxamTKQtVevNA0K7m4wweh5DHsG488RG0=;
 b=C55o2Y6vMqFkZSra2U+sl2+x3ZHxNQcWviVHMDUWBNaXAsAjVUSx3JEVX6v68GaN2ZktEAM2W/CDbHMkIrdOm06VyZ3oqwLpiHana4zpvZDLrZ5wkY6A1MMFdpi3SF+cmMPPhJ1lZ9V7DRJWFxedidCcXBbSaczM0Si6SjYt47k=
Received: from SN7PR20MB6609.namprd20.prod.outlook.com (2603:10b6:806:32a::21)
 by SJ2PR20MB6190.namprd20.prod.outlook.com (2603:10b6:a03:4fd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 21:37:07 +0000
Received: from SN7PR20MB6609.namprd20.prod.outlook.com
 ([fe80::91e0:13ad:1b6:8db6]) by SN7PR20MB6609.namprd20.prod.outlook.com
 ([fe80::91e0:13ad:1b6:8db6%3]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 21:37:07 +0000
From:   Evan Burgess <evan.burgess@seagate.com>
To:     Christoph Hellwig <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [RFC] nvmet: configfs: use ctrl->instance to track passthru
 subsystems
Thread-Topic: [RFC] nvmet: configfs: use ctrl->instance to track passthru
 subsystems
Thread-Index: AdoseU+Og/M/p3IBQFO+mNbnV5Ig1g==
Date:   Mon, 11 Dec 2023 21:37:07 +0000
Message-ID: <SN7PR20MB6609903F74075383EC400BFC808FA@SN7PR20MB6609.namprd20.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_ActionId=20e1bb13-7b03-4f5d-9dd2-c8d54f4b4c74;MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_ContentBits=0;MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_Enabled=true;MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_Method=Privileged;MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_Name=Public;MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_SetDate=2023-12-11T20:54:31Z;MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_SiteId=d466216a-c643-434a-9c2e-057448c17cbe;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seagate.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR20MB6609:EE_|SJ2PR20MB6190:EE_
x-ms-office365-filtering-correlation-id: 98611529-d3ee-49c8-5e8e-08dbfa915355
stx-hosted-ironport-oubound: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ncpz4EtAfaA4duLN13hHTCWkQv124+0W95lXl8Lk/+dvvsx+3OjTmHUHq+sY/FfiZgNUtx3ej4b0gMakbzI8R4wWr3/VH82j1PIbSd3VIk/+2Ze+rTLsCVzwXrNaop421L0iCvT9D1EGIKLkK+hZzqQZjf7jFbkh8yP/U9+Lh9BjgWXtrGt6o8AgBx2qPh2FUKnHxp5uhhe1ktfGJDJz5JDfFauTo++RfanTh09NMRDgWpm7qTg1xSfn0oo6dhbU9ht2C0qtXg5YH7AkrUt2ntUzHuRUjTbJZ/1aMQCD9uHS/ojgQbjnTG8G9XNssKl0/mdnn7RSnsqw8dYzmSso6htBB6Ej9fY0J1QHK79YIzyNw04ADdg0kaZYCEMehxT61/4ftufIGbsvEqKo1zDLH4GrSedClZ9BwNERdfiOSalcw0rUsHwyFwcMNmhifmFlGyOHy1wAqrqktcSBfOLXJlpKA5p2YUzzjZi1qXAwORdtUfx2p00uvr6FFEE6qPSPlKDgeJEe1U0WzVKbJofXvdcR2DjZU1uhIgN82V5Zhbj8BBtWEw5ntQD0qCJflQnN/sBzI5h+NU10HYK4KusRskCzjjC++3Yx4AnQq3SqhrwuE4PK99rjhYq9e8bhBIDA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR20MB6609.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(136003)(346002)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(71200400001)(9686003)(6506007)(83380400001)(5660300002)(44832011)(4326008)(478600001)(2906002)(7696005)(41300700001)(8676002)(76116006)(8936002)(52536014)(66946007)(110136005)(316002)(66476007)(64756008)(54906003)(66556008)(122000001)(33656002)(86362001)(38070700009)(38100700002)(66446008)(55016003)(66899024);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xqjkzrv4lvIJKHn220GofnyNjQh/C08rHs3FSbahFQqdxJDO1ic7Yfj/bsJ1?=
 =?us-ascii?Q?J8YXX+vr9wXHJsPj2ARcwWCCRUyy9l7MD7IXCR+hrKXIxJMXKLhHn0V4zLpq?=
 =?us-ascii?Q?lmcASg2xHXkJTAm8/qpj8umwHyFQ1Q022ZbofdeTaRnAH2fjse78T/bFJATg?=
 =?us-ascii?Q?qfpF5yLr3twabwr20Oycnq+HC7aVwTYVbDXFcKvwZ3XugdmeE4cjpGGVUHxo?=
 =?us-ascii?Q?up/IEEcfJLm8jyqHn50oxJznA3TFyHyYJ+8bYHcGanSUhZm//pH3OvSym8Ai?=
 =?us-ascii?Q?nhlHCTjEtl3UgOs8oe31JDzFZXveDrNtc2+YOzr0GNQGENEQeRR7un1EDJD9?=
 =?us-ascii?Q?Kh1K7xuYLMXyEi4SF7fxmkbBuxdOHMUhw4IseoRKdLOcrI1KCfJoPgP0AdVt?=
 =?us-ascii?Q?G4MjXi5YnXmaXpLzkg04Ty81rvHojEK6ykW24A67DctvwsbVYI/LQocES0ND?=
 =?us-ascii?Q?KU387sg4P/m50cn9GxRi/9hENwJ4TR1HpXnfbeZ2wXCvtqkm13Mk2kELboCk?=
 =?us-ascii?Q?CpJXwk3Xf0dF1VKoW023L0AGMBNuBDWJmNJSTp8H6qCwtHbtEUQLKpDc1KHk?=
 =?us-ascii?Q?/bHJVW8YVfk/QcEEnDCR/cvWRUUtptUa7qrZennwmt6I6sNb9PizqLLy3qha?=
 =?us-ascii?Q?OddrQA1KG2iMANSAxW8VNHYytGRg/sMp/6JrgG5CeRVxVqiqlGplJc5rDhZw?=
 =?us-ascii?Q?SZaRM8tJg1sALO1OWX/0jz9UaZNinNhW7dAgmMB5vUa59cW5uPgZkuEssPXz?=
 =?us-ascii?Q?xwfIP7SCXNP5MouLN8Gk6uZSeHDhlxors3Bb3zLhwolpmXG2vpcS5eRe4/FY?=
 =?us-ascii?Q?voHa5UCG1AcL//ZcgWkwoWbkJ2qOKZwC+aYqQMRDO7cRTsSSxHZTFvEHf/Zh?=
 =?us-ascii?Q?dtaq6FG/WZ3ffidw567+lSuUzoQdS/shmkqBIJfSle13lNBvp+avRxIpzgPX?=
 =?us-ascii?Q?bm1Cd7KM0kCwIa92oy+wWTeTpttcWGwXhUZ08mQQlN7w+zD1hplIVFxLvDU4?=
 =?us-ascii?Q?NyYtDcKMrCMeWt9J+Kak3o4JCekGj4NGP4OwFFKcAT/IS0FIpXrSz8B2d6Xx?=
 =?us-ascii?Q?NgGy2Dl57ZNt96zdFXhWubowGKLwU3DW0R2QtgdH4zFylQHBAi5WVPZvgYoq?=
 =?us-ascii?Q?6MTmXSDr4STNO8g8zYDi2xN3EZ5tsy1maWyv5HuLxxymnCGHpObVGgT1dnu2?=
 =?us-ascii?Q?HcF5Jm+IYMBQ7+4DdfCIOZIXG3FU4G6JoIYBHnq1AaNu/siac81/3n6+fJZf?=
 =?us-ascii?Q?Bc5M444z/1WvPxeAbT2QqvUkUm78O495GEXUep5FNAKI5jY77mQYK8F92vuf?=
 =?us-ascii?Q?0Rd5xzsrr3Vx1p+POS2Gs/w/wilR0ULuKbnlhVM1yv70wFOPUapIrVk9Ql7Q?=
 =?us-ascii?Q?yIsF3szyQaO07Sq+Nm08/aVH/jW1ON9MeLnVNdd9U+wS4Wa/Icp33/KaELi2?=
 =?us-ascii?Q?WZrJoGAvwnBZIrfN2fMHdCNmpoEOGlfWpU/+OHwF9FPHauCIEO/bzhW2z9eV?=
 =?us-ascii?Q?QAj1dgkAmd8OF9gBre1G+gCAF9GfsNCZMD9eLW1reGURZKUundVQv+VSLqo9?=
 =?us-ascii?Q?P6Qrqdu4s9hcga+cupqJfIjAMlZy/+9lTEJ4FzBh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZD5FLx9SVDI+16xF5f1s//vruIhb1kMYGtFLvj0IQF3ZBW4UzAkTL5VYmgY80+BmBmnMK/yrOYE7zZJLAzvYxfw2NSrvfQl3PAPftlScGuMtyXFxt3aCfJ3W2ZnNYyHsP2EfzE5ocVli++W+OwPbRiYRDHI8K9sNVOYCU9yA3lRPbVLMBD2oMRE9y3sEhUBT5mqqMoO+8jz8swAxWNIewycXP+rrLpAPXNkJBLfE4Otn/1mRmtVGqmJnvVifZl2wO06CStJoi+17tTuw4NkNiFYNPuwYckWIzN/hLrp3FtkbOPg+3g3SidGt1V+IYf1lqBg+M6QRo5NqmjsUOaBaYfbhbRBMmqYMrp7L6YiwGl2VWF32sG4RfqkoNFgI8cOSDiSim1UN7ENccxxSGjbB6l3bqwt4U11vd+Mjblwo0e490h+H3Yh8LBwDuJeHluzyvdYKtV1/IMMd+C5PskQ5BefX7rXGqiCgxJVmNzC/Wems0efFIUGXVJExfNSOOfwMlEdF2P8pwej1ZJE4Od0geK4HK3J1XYtWQBWoybYDOVOA6kJ5c6bH73814f6gO14M7G72kDWzlskG2y2t1ptBQSpiFX0IMTpYzkAEAVgYx4uuAC+FDPXW65Lfg582gGzmxM61qgsDQ9+PmUXwyBVsAXFFsk95KxwGudFkUtzRS189Qolmg/MtZTyxBa3b0z9oGv/8Ei3Yde/5CJhojZTNQYDCtjOd8j1p9RJHM9xW1Mz+5z5hUWhMi3Zpsb38GqmUr9qdKXrWZ/8XyXNpJTukPleNFvBLPH37r/cFGBCZNjDY1a60ZEU7IAOTD2ff6LEh1R+TgIc7kPXKVxAEe7okh4Y/VOxbgfGsTn4bh64GzjFI49CE7txF9nawhwyLS6a6YSAGImBFSbb5v/EDDU+j0Q==
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR20MB6609.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98611529-d3ee-49c8-5e8e-08dbfa915355
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2023 21:37:07.8338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ZWEy3hGVZ4G45fzUxYLBGqNBVtCeM0uFT87JSJFJZABTRAX+wxvRBQNm8v2D4DN4QFiayhA8P+XJaY1wm2BASGnlY8e29lQjfI9Js8T1MM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR20MB6190
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prevent enabling more than one passthrough subsystem per NVMe
controller, passthru.c maintains an xarray indexed by cntlid values.
An nvmet subsystem cannot enable passthrough via configfs if its
passthru_ctrl->cntlid value is already accounted for by the xarray.=20

However, according to the NVMe base spec (rev 2.0c, p.145), "The
Controller ID (CNTLID) value returned in the Identify Controller data
structure may be used to uniquely identify a controller within an NVM=20
subsystem," meaning that cntlid values are not guaranteed to be
globally unique across multiple subsystems. Instead, the cntlid only=20
uniquely identifies multiple controllers _within_ a subsystem.

As a result, multiple unique & valid NVMe targets can be blocked from
enabling passthrough at the same time if their controllers share cntlid
values, a behavior (seemingly) allowed by the spec. This could be
remedied by indexing the xarray with passthru_ctrl->instance values,=20
which are allocated per controller by IDA and thus should act as truly
unique controller identifiers.

I have seen this issue in practice, but have found a suspicious lack of=20
corroboration across this ML and elsewhere (so far). So, I am not=20
discounting a possible misunderstanding of the spec and/or code here.

Signed-off-by: Evan Burgess <evan.burgess@seagate.com>
---
 drivers/nvme/target/passthru.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.=
c
index 9fe07d7efa96..f2d963e1fe94 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -602,7 +602,7 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *sub=
sys)
 		goto out_put_file;
 	}
=20
-	old =3D xa_cmpxchg(&passthru_subsystems, ctrl->cntlid, NULL,
+	old =3D xa_cmpxchg(&passthru_subsystems, ctrl->instance, NULL,
 			 subsys, GFP_KERNEL);
 	if (xa_is_err(old)) {
 		ret =3D xa_err(old);
@@ -635,7 +635,7 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *sub=
sys)
 static void __nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys)
 {
 	if (subsys->passthru_ctrl) {
-		xa_erase(&passthru_subsystems, subsys->passthru_ctrl->cntlid);
+		xa_erase(&passthru_subsystems, subsys->passthru_ctrl->instance);
 		module_put(subsys->passthru_ctrl->ops->module);
 		nvme_put_ctrl(subsys->passthru_ctrl);
 	}
--=20
2.34.1
