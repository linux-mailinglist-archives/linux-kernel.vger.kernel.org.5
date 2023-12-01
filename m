Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289F48013A1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 20:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjLATjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 14:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjLATjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 14:39:16 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Dec 2023 11:39:22 PST
Received: from esa.hc4959-67.iphmx.com (esa.hc4959-67.iphmx.com [139.138.35.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E30710E4;
        Fri,  1 Dec 2023 11:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
  t=1701459563; x=1732995563;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=h0jMU7WjZ/hlqRIW35kqLPEcBYhPPTfKUhdvWICUfUE=;
  b=c+bXXjwx7nWtI4OquaIxmOk558lo/SBEiVL75p8jV8zReQCzOc6bUXl3
   hm5iH20D+ktUQDFXWIXIp5LgtPnA4KlqG0DandM69ZiG57Gr8T0DgZeI/
   +c+emGUE8EMKyIc6qvGxmBK/9/5OplZXaVYaZ3N4AfOvhO+4qdb9SYxDq
   A=;
Received: from mail-dm6nam04lp2041.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.41])
  by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 11:38:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E17bcjcYm1em9dLZUxwir0Z9QNL87DBux416GSbeIh4cNk9VquQmtYzcdotyeP5eErtZ70c9Xk4K5YTNWVgaXMlHTG9K3eglXopysszIn21iMg1E9GKj+I7bBsMwgvKzyFPIl31N4YcZ7cyarxpgBxpXUjeEozFvzFAXwLW5/y1OOYKYfYvAf9hXMgD1vIsG/f43V2CIWAUdwe3K5Yb4iT83C4TmnndNMvmhU9sBXVK74eeLuJnzQWyD1h9iYbr9KvTlRYs9hE2EI0VQ7hcMoU/PTBYmHL94VWsUiW9qPw8Xd8pNBJC1l7s9Bo9wHGzNtH7fpnR82g2Yw2qx7U66+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOyI7d/QdG6K2JsOEZx1fB6Bqn1zXJxaUWZgJg8t6iM=;
 b=M2Gyxi5sj61a/naeC4f3CZw5s2ag2RA//apdUzn1gktmoVp3HHLyYLnk5sIfUAW+tHLBK/m0nIGo1Q/JKsboaXlaKcKrb0ZrRb6IomkR+ORpYmezgUJAhz0K7zUpbYZkKX2D+dwgKc91VmqyltkEy3Bp4b3K/DD27SpdrbsOmQ67lfECc7Pag1TMkS3KG8z6hdAJ9KfPY7Z0c5KtHI42WCZ/5U1nIJEq7S32ysy6jNJZpJzfWnQ+DsVzrqeHd9FHF4jtt+lvfJoMMX4Yvu2DYwARwKFWPb5KOvQIA34mzGCKDPlFKnTHbbXHAlHuwNJFlSdSVfkqJmO4K9pfwE9N0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seagate.com; dmarc=pass action=none header.from=seagate.com;
 dkim=pass header.d=seagate.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOyI7d/QdG6K2JsOEZx1fB6Bqn1zXJxaUWZgJg8t6iM=;
 b=anew9ORtzIlh5VMk12AhvEjliqYtGJ5CJVU9bPGcxb8m8KnZCi9Utiy8X60VLfxVfOgOOp0oExU8PvfsHIO3wXE6snIT3AOn55B8nNZv0WrxJaNoRT+lWNo6OiUCfnR7CaXjvDZNDWnIudN39ZaCX+RBUstRJ6PuLPiSQZMSmbs=
Received: from CH0PR20MB3818.namprd20.prod.outlook.com (2603:10b6:610:d9::9)
 by SA3PR20MB5888.namprd20.prod.outlook.com (2603:10b6:806:318::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Fri, 1 Dec
 2023 19:38:15 +0000
Received: from CH0PR20MB3818.namprd20.prod.outlook.com
 ([fe80::6ea8:3fb6:2432:e1fb]) by CH0PR20MB3818.namprd20.prod.outlook.com
 ([fe80::6ea8:3fb6:2432:e1fb%4]) with mapi id 15.20.7046.027; Fri, 1 Dec 2023
 19:38:15 +0000
From:   Nick Spooner <nicholas.spooner@seagate.com>
To:     "john.g.garry@oracle.com" <john.g.garry@oracle.com>,
        "yanaijie@huawei.com" <yanaijie@huawei.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] scsi: libsas: fix whitespace formatting
Thread-Topic: [PATCH] scsi: libsas: fix whitespace formatting
Thread-Index: AQHaJIrzpBEYTx4M30uzGoeCOXRQvA==
Date:   Fri, 1 Dec 2023 19:38:14 +0000
Message-ID: <CH0PR20MB381839E1C7FCA1F477D7823D9C81A@CH0PR20MB3818.namprd20.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_Enabled=True;MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_SiteId=d466216a-c643-434a-9c2e-057448c17cbe;MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_SetDate=2023-12-01T19:38:14.629Z;MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_Name=Public;MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_ContentBits=0;MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_Method=Privileged;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seagate.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR20MB3818:EE_|SA3PR20MB5888:EE_
x-ms-office365-filtering-correlation-id: bc9e8d70-51e4-4548-a299-08dbf2a50fb8
stx-hosted-ironport-oubound: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /GU822lp9G9vNqiKOPeQzJ19mkQIsFbZ90HuJp6jGXLAgw2dSmoJ1kU64k/YkBaogFi/JUMoYizn3WatIr81Hb3ni3cPeRugvycmdAIap+oQvBA01S0du6AqfPZPubAYU6iFg9BgeifV9R50NYjeRcAgSvOvZk6XbOKTVqsH9aallfWgSWZ5aJ1JS+bkKAkUeXoDETxLROOM4ixnTDNupK1o++pL7C42WG+P9uQm3UZCErtIq3sQJleJDjEd5GgPgPKdXPCYqS8jdUkKjcfpQuZqiU4XfQaLbJPyeafuAYvC5Qp87OcU7nUHHFLRno+3BbFJBG4FPpEDkVn2bgptLnVmN93eW6reXrSBpke3f7RmVQn5yJr6YcPA1dpTX7DDo1KJ+9ES9VUm9hgp4XX0qd2nYxyqd98E3NngzQ5gEzRlGWnxKCo3ZvbvpPPGq398E/C2AcWSCkXoofazj+Wes3We0BWL0jryWpp+XeJi3yD7rMp/lQh25MRi7Kxd1/leISSDUF+iEqD05ExLBidKbktaHgyge82kD/W3VIxpwy8Yzc+N650keYkhqz4/8eP9xM7CIKx8jElJQw/1PSnK/uzWbWoaG1JigL2zwyEdTUSg+BLJund2dsjbGhuyguReX4elBRIdTjEZnBrspyWUAshUjvRtnXQs2UjD0Rnhonk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR20MB3818.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(396003)(136003)(230922051799003)(230273577357003)(230173577357003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(4326008)(2906002)(55016003)(52536014)(8936002)(8676002)(9686003)(86362001)(71200400001)(6506007)(7696005)(316002)(66476007)(66946007)(66556008)(38070700009)(5660300002)(66446008)(64756008)(54906003)(110136005)(33656002)(83380400001)(478600001)(76116006)(38100700002)(122000001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UQbCMdNrkKKEuwOv5lcdcEdaYSzRzymJLu7Hdaum+eXewAfNrgg2n5axdY?=
 =?iso-8859-1?Q?MiOOQS3F8aXewwgN0ARviYo17cSLg+HEU/Zvp2B9YHW7175zTimgQdatI9?=
 =?iso-8859-1?Q?7rf3frctGS+aF7d1H2H86cW2rydBamJaBIZfahqBNpcVW6Hdd/9f1t0Wcg?=
 =?iso-8859-1?Q?/0BWMc+Bjnvj8Cklc9RqXnVJF7xlVKwSE+ggWNDfSEHPYX/mm7GjICD7L3?=
 =?iso-8859-1?Q?9tTEfoG/pzMw2xlMnVdwyZBToVN10dD4jG5sk311ZBf74iS+45f2jLnIs4?=
 =?iso-8859-1?Q?hFwBw81rTaD2N9oB65SUMeQyjEf+dI1V/EnUpQYZt5izdziDhF3Bp4mFvs?=
 =?iso-8859-1?Q?YrsPf3bmJTp5cL0mnwcBwU4zy8c1+CfavLYHfQ7oarFwSHU5aw71pdy2X1?=
 =?iso-8859-1?Q?+uJy+1ZZooNS1ODIxbVZClL6GjtBV8VnKhK8+b5Lm2kkB1fDH+KxHlls6V?=
 =?iso-8859-1?Q?XSqR3Y/kDvkILNvejVfhm0dSvlalXXl611YB9LWZ6AKIO4yM0+kvx3Gy6E?=
 =?iso-8859-1?Q?DFWJ/VGlLsxAOBWQnfM3tfrmORTkWxPwahP2TBLqXNNB1uThlYamVgKEXR?=
 =?iso-8859-1?Q?cwPVZC3RgJGY2xw/LE4Lh95MQ9Po3Q4eKkQ3mys/ryITZu2qtVyLrqeWSH?=
 =?iso-8859-1?Q?BjZiwbpZDQQczTyLl6uEOnPn80X7hOEF8SgByVLrzEFrSfhDMwUX3d+f7T?=
 =?iso-8859-1?Q?t4MsOuw1n1vtPwhCudw0rblBfFZynAKJt5IyjIHsAYQ9dfeN4y1yjtL7x2?=
 =?iso-8859-1?Q?VppQ9TUPhaBknvBlpfzRoSJW3YxpoyW3YxFaStZ9iQGS3LMRClI8L+ftJj?=
 =?iso-8859-1?Q?GU5TqLUxKzwXvuz9AQLzuQT5QXWPvr0DJGnHUW+wOszg/azX7mUu/JRJ0y?=
 =?iso-8859-1?Q?lHI8U+E1dirmuZ+lEvrXo+iUxE2Z8g/27R/h0DRQgDhbLIJ8+XUUYrv3G2?=
 =?iso-8859-1?Q?PdI90csljbeMzO3S/rgtm9E+IVe/qOcflmS7PGba8GTYDyBb0P0IoCdAHL?=
 =?iso-8859-1?Q?la0dpsJaNodZF2rbLElmp4n8mOENK9mMSp2ibevzLsf41ISoXsN0FqFZuI?=
 =?iso-8859-1?Q?hRucSPYdJza28kaa50bMYwq0zAs2036HG9FM7dzWDasOR3X4rIGjTpmods?=
 =?iso-8859-1?Q?l9Y3Gi0nWwEfw6jzrgMAH70OxScIeA24YhU4apUmwfzTUzuDBcmhPIEhwh?=
 =?iso-8859-1?Q?uV4ih3A8jf+kuyUyDCWhCIUuFOahhiRjCBgKdFll1IkGtyq1jJMZvsAYOP?=
 =?iso-8859-1?Q?IeQDzDC6ju/3V4xwiAaASNvxp/rJQYsgpFhH8ehLsIgMuo6e3sORDwiPzb?=
 =?iso-8859-1?Q?CcVym6CaJahj2cSbVogaFJxZ/oo1XoIYzeXTzbrNx9ngTXnSS6G7iYDuO0?=
 =?iso-8859-1?Q?vOX5TCepMnAVI9X4JWrsYxmM1jn6wxj7SOIIdA0PEUF2seJm76ohdWXcBD?=
 =?iso-8859-1?Q?CNScJqMbOhBhSuGK1HoDdxPApl3H6A3xljQ1fhCR8Qhn7zSHDLnnw94yWy?=
 =?iso-8859-1?Q?WuHne4jxNHDAOKoCup6fSyPqWcJvggy5Zrfl/0CwT5VMJlpgHpdDUCiKRX?=
 =?iso-8859-1?Q?MIod61AhfGtqpc2vTZpG0YjsG+5lXtOqjrEWcpRQpeubjBVt22Zyz7t/xx?=
 =?iso-8859-1?Q?OdCdyjyo4rYH5T86jpagrouDtSNBVSoj0AY4rWltH8hn7+n4cjmCglMA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3Z5BixK28RwAQ1SV6QPEiY1PcN9A/r2CilHz04RmNnURXflaH6d9xlF1JSN0JXf94bmlO0j489VBi9EYoZaOpgU8kGo1B4gFEAP1ngP4bnfwuzmsufeLEKr2jujx2N1pouQHxtzLHI1SEJckOGZPBjH48FAh+pu2H18Lx4BLLzOHJIZNTJoF7cDJr1hLQ9ukMbrGt9r243NvqyTmT2VLOg4Leo7WslQHBXKHhlvq/RcwFYcvAdMEjGMNHVSfEV/1NT+/WxAw5n/R2IPWqt8Luqm/00QoFWwy5R8DBfSWpVMM8xxliNMfQll6MsTDyf9SOsmEPa2szV5DWVYju3AhuD9uEjGvGqHBwCsPGiNmbKQl09Pyzk6VX1gBvQlg0CwKSHTBR1VzfHY4MtGLj4GgY+sRJdIIan3D/9sE2Wzn/xZSjNC2YPxzYMATAzWZN4WkwSu6lHaOwP9P7LaY38AwKy/zIkAs7UbyLZ/iuk3dKkC5vXdujevLRCgNBtB+FP1US6K93565WMEO4GYa0zk4W9VMGWBbTCOwEQml7a5Mv6nKgISXIqoIu6ZD4TVP82ZxrizwJt/w0995vUwIMB0LFpGNg5vrlxqfztoPbNDziUCDVQJRYjMJMoL7zAjDLBnOqLM6Quxk5GfWQy2exl49QkWqcT1gkXAig45Hw/tZcM+ieuyRScQTSdjj0vvfzckzT9DkEPLJ+/aHPRqmKa/YTUIwAbwPGnE7VdRUD+g+Ox/c0pekC5wW6GDlSRoELoCBnCFIS7eoA9SVl1NKLv4r6zKljeckp30xs3Wjc6P5pRXxv+8+DqTW4H0kz5EmtpiEmnzz1bpUbP4FloCIi9+z/WvQb9hmGDUJH+iHqPnl1ENjOju0eCCKJbx6bGsV/EEVDuPr3PpG2LugF1gfgBNDL1rShUNHFJqvypZqRjpdDkE=
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR20MB3818.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc9e8d70-51e4-4548-a299-08dbf2a50fb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 19:38:14.9719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1VUe7sgRrcXOgkYM5sJj2x5O1ogdPW11fcfwemf5RXySEwx2Vef8QwRt3UKH2yhurEcWvBBaGz0KdNmMwSBi7tBLHiygDvXWHWZaVpuEiDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR20MB5888
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resolve whitespace issues reported by checkpatch.pl:=0A=
=0A=
WARNING: Missing a blank line after declarations=0A=
CHECK: Blank lines aren't necessary before a close brace '}'=0A=
CHECK: spaces preferred around that '|' (ctx:VxV)=0A=
=0A=
Signed-off-by: Nick Spooner <nicholas.spooner@seagate.com>=0A=
---=0A=
 drivers/scsi/libsas/sas_init.c | 5 +++--=0A=
 1 file changed, 3 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/drivers/scsi/libsas/sas_init.c b/drivers/scsi/libsas/sas_init.=
c=0A=
index 9c8cc723170d..91946f56b236 100644=0A=
--- a/drivers/scsi/libsas/sas_init.c=0A=
+++ b/drivers/scsi/libsas/sas_init.c=0A=
@@ -309,6 +309,7 @@ int sas_phy_reset(struct sas_phy *phy, int hard_reset)=
=0A=
        } else {=0A=
                struct sas_rphy *rphy =3D dev_to_rphy(phy->dev.parent);=0A=
                struct domain_device *ddev =3D sas_find_dev_by_rphy(rphy);=
=0A=
+=0A=
                ret =3D sas_smp_phy_control(ddev, phy->number, reset_type, =
NULL);=0A=
        }=0A=
        return ret;=0A=
@@ -346,9 +347,9 @@ static int sas_set_phy_speed(struct sas_phy *phy,=0A=
        } else {=0A=
                struct sas_rphy *rphy =3D dev_to_rphy(phy->dev.parent);=0A=
                struct domain_device *ddev =3D sas_find_dev_by_rphy(rphy);=
=0A=
+=0A=
                ret =3D sas_smp_phy_control(ddev, phy->number,=0A=
                                          PHY_FUNC_LINK_RESET, rates);=0A=
-=0A=
        }=0A=
 =0A=
        return ret;=0A=
@@ -612,7 +613,7 @@ static inline ssize_t phy_event_threshold_store(struct =
device *dev,=0A=
 }=0A=
 =0A=
 DEVICE_ATTR(phy_event_threshold,=0A=
-       S_IRUGO|S_IWUSR,=0A=
+       S_IRUGO | S_IWUSR,=0A=
        phy_event_threshold_show,=0A=
        phy_event_threshold_store);=0A=
 EXPORT_SYMBOL_GPL(dev_attr_phy_event_threshold);=0A=
-- =0A=
2.34.1=
