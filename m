Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93AC77706BD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 19:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjHDRIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 13:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjHDRIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:08:50 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA9849E0;
        Fri,  4 Aug 2023 10:08:43 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3747kBWW006143;
        Fri, 4 Aug 2023 10:08:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id : mime-version;
 s=s2048-2021-q4; bh=R2NgxswRRhXTPyb/rMw00QviSFwR6/8uvSgG8KKWsIw=;
 b=mxEzqp/pEdgO5V4eehfPOIQS/oo0LbKV+XmUTXy+1wVDbKaMj2L84Z9mantrhoatLZUY
 ZqTKN+P1w1i2EjSGGOM2h1it4pFQjnntkEzuVjxfnnM5h8g0u1IdARLBpJiV1sjdm1fy
 DXf8rF+aDooYcrr9NDfgXz3qRuJ6WZBEjBDBtid9J250Uxbg/2AEtQPkkc9AShZnbBhy
 Rgt1+XLzEXkt3m/T+d3l4w+enM+rXFpq065+O6Q7igbXGEA4ceOASPXiAdqxB/BjFKtP
 zAvSMrm7XMTzxIoTsi1HZgdduTiuIkgkPE/eOIffaB5OOQRRjVQKURdHdWBbUYv42rnL sw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3s8w7quut4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 10:08:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nun00HVCDdjxoRn0KJjUZeEHFWTfmeM8oN7EOuIeH/RG5pnwnebO/6IFZlwX1GzbGj8q9QQTKuuKVGiRdlnPQy0rSfFCVjN9CCJjucGPESFkN41rF8zUplJ2QeWlT4Sp5MVyOtAKlJcNojpWcOWZAXmcYxi0p9lk2NH9paD9e87VmzLJQsv2gtcse5l5A//+OKc5qahgc05Eg5QiCD0rtmG2BhENiAhztfa0TiFY9AQYZj0rXmGXVuuWjNi25249S7OQNUVaZOZPqxTs4gJVMBXbewYFBPtZ7MClsJTDmkDplOwWeylxcvI/ilVcR0xA72kPg7djldqVojph3togMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2NgxswRRhXTPyb/rMw00QviSFwR6/8uvSgG8KKWsIw=;
 b=S7447ufpn1ZV3Ky+kBjvHirsOh8F8aoEo+3/By/U3WSlBm+bPmeoSSYXHOrpuYBiy3qJPWjNTsMcjZS3rmYpk4D5j3b0/q6kNI4s1X6PSAivRMOdfMwONW9WyfhWMfsRJksETaEXbspDuGK6cZbcnByqJgSMOEc/wD6mUGZFz9kmA7Pb5XMmK3qpbVV6sxTN9mceU5YzyjT++5J3G09E/5HgAIPiU47esWam6srPShAgTJkiCdaraEHJ0aMNqcQbZIMja0KCupaRpsHhfas1jpozkyKLeFl1HNRVBJkZJdpkizAIsuxpqPxxkzSOsd8otJt8W2PHCgNdhFdCHZyS4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA0PR15MB3997.namprd15.prod.outlook.com (2603:10b6:806:84::21)
 by DS0PR15MB5921.namprd15.prod.outlook.com (2603:10b6:8:f8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 17:08:40 +0000
Received: from SA0PR15MB3997.namprd15.prod.outlook.com
 ([fe80::fdb:2c72:511d:1b3]) by SA0PR15MB3997.namprd15.prod.outlook.com
 ([fe80::fdb:2c72:511d:1b3%3]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 17:08:40 +0000
From:   Jonathan McDowell <noodles@meta.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] tpm/tpm_tis: Disable interrupts for Lenovo P620 devices
Thread-Topic: [PATCH] tpm/tpm_tis: Disable interrupts for Lenovo P620 devices
Thread-Index: AQHZxvZQDWmzbkuMkkCLZJDAg+uwug==
Date:   Fri, 4 Aug 2023 17:08:40 +0000
Message-ID: <20230804170638.GA3705864@noodles-fedora.dhcp.thefacebook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR15MB3997:EE_|DS0PR15MB5921:EE_
x-ms-office365-filtering-correlation-id: 62a54e8b-2293-4c69-ada1-08db950d736f
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zPOs0+17iO2t9GrdoP503WZMrWlQpON98H5JfY9Ht2m2iKAntZlTX6mQNVXH01FRKQUJNnrPoXkGP2tq/ZkgSd8iVdyRtinfnvdgw0Iu42SVnapVwo2EYf1cvH1Lkj/r9IsERM66KfyC9YMOAwxM+x099/PBq6fdMirOPVszBxAuXc5tM+fJNxVgnNI0ccd9ORdFAGQJnJOJB0oMG34NiPYtHKnn2lhb/QSwW2KGmFED3mMTaZdJVUJpOI09oddFyLHRLBcA4aBhxjKZdxs4JQjkUlj4tXRhntcad+i2p9bJoijvaNVLEtUADlLufHaErNQbvlHBdgwoYzalemV5kYRLGL20OW+6XkmGcj7FdWyrZBy+ow8APfuIlhUAjemh2NYJL+zITmojAblUgly9D05iick0prWoyko6O5/MeUdhp6cEj/7AwkNmgjvGsWKw+gfektK5vRGDnHZAPhmzdbu92GAvzRMXH1oCYLim7I5Jcu5SqdP822+RgKLlPv5lwQPjGckRnSVFE0ETm1zzC3IXz7vZGccRRQdAWlJOe4+bD2ohY8mC2UrbDC3kzO/fdWxijuuT9wwMZ56wf4dQadhZLtJ+bTF5GcsAMB7IuSk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3997.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(186006)(451199021)(1800799003)(66476007)(66946007)(66446008)(66556008)(64756008)(4326008)(76116006)(91956017)(2906002)(38100700002)(122000001)(38070700005)(1076003)(6506007)(54906003)(110136005)(86362001)(9686003)(6512007)(26005)(478600001)(6486002)(71200400001)(33656002)(8936002)(8676002)(5660300002)(41300700001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dfs8oarASIFAle9kgy0qYovW/YbcKXkHNZm3vi95wRmTiLa+QHu0rwyes6ZQ?=
 =?us-ascii?Q?p7A39ZmJ923GR1ZDi98vGl03icqcz5TeRAz8eYNk9QUNwA5msLqKF7Fj7eTq?=
 =?us-ascii?Q?jHYw+uygD7/evoJCGYlemFXKH7WhLMeK/+ISMrpCsTadcMPsxWtpAnGb62uW?=
 =?us-ascii?Q?lbnCp1aUSNV9Flo0/gExT9Hlj6+iRjtNmyKJQePY3UEt+mprK2k/EwFEUoNl?=
 =?us-ascii?Q?TrTz0kt+ZmoKM26aI3HNKlrlAzWW+8EluHo5aWKWKblFW8Oltz76IYEwgEBe?=
 =?us-ascii?Q?PbxdgTpmnYB4K9IsE7m9dftPG7+Aj3bdH+TMVwvzsSK/6Rpkz+fRdhFhRgVp?=
 =?us-ascii?Q?Em2rWBifem+Y03f1pof5608RpmvhlC1cD6vuVKcjn/iwAd7UC591wy1eh/ih?=
 =?us-ascii?Q?9+gIbNXG9SHonQxQHxZCkX4Zydk0hJ+jLSl24pf4+YMs3T5SmlEAZKRHpBpB?=
 =?us-ascii?Q?2H39cwdfiIdIXNCDsM40OoJ/Cw4WgGRgetEpKQq5WKJYJi2Et33Fc23UAIj5?=
 =?us-ascii?Q?ZOyr2JSO7+aSN9tsZWYE+/CdN0xevl4ZsXLP5Y23sbrBldn+HjIZ38rdvZbA?=
 =?us-ascii?Q?0x8GidtpG0DCXyfCl5zo82D+RkMUGQ5qpCqabzWyMTJ0S1BR62FATvP+aFdi?=
 =?us-ascii?Q?95s7oiH5FR+q4vztY6RK+VOZZ+2Fcp2pOoY7auRELO3bQPg4Bqf/eJ/Iz1a7?=
 =?us-ascii?Q?X8MtcmhrSsxn+RS2KAxCVf5LXfqTzjU6GZpUw4SIw/fbIJ4Mp/IXDgn7VqnD?=
 =?us-ascii?Q?dpBETm24QrQprlS/uPZ1tN3C3bMPI6m5xlaLvG+nWj7sjwRs+Xz04cemfXsU?=
 =?us-ascii?Q?jIWsVQNgBwKbefmw1oTqBYv9TLjnXm9CGTKcq349BPctPHF8pOnhjw1zJE5t?=
 =?us-ascii?Q?280gwB1V3xoswZlRjdkIBqs1zjb6VJOO1jew1asF5wN07fPCNuAh33Q13+9Y?=
 =?us-ascii?Q?jIWb7QT4ZZWKKOEM8mfdKeXkr6Fjz3JOXLke+Wbt+G9arxR3aSx8LJZ0/exQ?=
 =?us-ascii?Q?K/Sv/PgeWtgzQ6WOCelnmEb+ApVPKmBU6tGd0foOaLwt0X9jbMVuZfJrXVel?=
 =?us-ascii?Q?R3ZWXPzqmxvuIq4Dsyoqtua5hEzU+j4f8l9DwVmuhZG3HYaoSO3mMF825pL8?=
 =?us-ascii?Q?2H12XmTc6UU4KGPLB6mVbKahwl9w36z9Oq9FTsJrKddot6cggT4ye6EbEMWv?=
 =?us-ascii?Q?2ukovqIwyaLPuwzwzrafgtWt+6oOg3aJ9JO5g8ivNc78qlwYBpA/oIgnZmS6?=
 =?us-ascii?Q?H+3vxnZdCijAknkMpFeBizDzKmvrPugaXJdsIauIa2EbHDxAoKHyy2qE6ErT?=
 =?us-ascii?Q?5CcJjArl+igTcYiVzt2yex+kg74KNfvyA4bDgoX2W/e/O+2WAGy5t9vk9q7q?=
 =?us-ascii?Q?adSV3r9HzIjWskG9+CpDfsseW/GTXM2kyvQmh6ViGdkB8Tp1qgvb6hoLAB71?=
 =?us-ascii?Q?eOZInpJlLRYwPEp2Vr7vHfrUlv71KmXPFTxw7KThDTgbFu28YsAaTFU3sSj/?=
 =?us-ascii?Q?oE++RSM2NIU4B2nhTSk5HSJ3S5eBlzAAl2Q4bK1PCpjkWtpoB6kpKWfteFtv?=
 =?us-ascii?Q?QDKBHp2sC9DV/VQ7aZHRcknM/YOCgGvwftsIoXNR?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <89CEE9854EB96945B0D5CAC0E63770DA@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3997.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a54e8b-2293-4c69-ada1-08db950d736f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 17:08:40.6506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gYCB9gpA54RSiKU4woUPzU87/cWqHP7xjD+hMLxuqlrX+6I27ZJg8zmhFLe7Mn5NjXAT0ifCa9UDc2no9MJgug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB5921
X-Proofpoint-GUID: fVyoulJ0HF2uv9OosfbrWQeWby3N0xZy
X-Proofpoint-ORIG-GUID: fVyoulJ0HF2uv9OosfbrWQeWby3N0xZy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_17,2023-08-03_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Lenovo ThinkStation P620 suffers from an irq storm issue like
various other Lenovo machines, so add an entry for it to
tpm_tis_dmi_table and force polling.

It is worth noting that 481c2d14627de8ecbb54dd125466e4b4a5069b47
(tpm,tpm_tis: Disable interrupts after 1000 unhandled IRQs) does not
seem to fix the problem on this machine, but setting
tpm_tis.interrupts=0 on the kernel command line does.

Cc: stable@vger.kernel.org # v6.4+
Fixes: e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
Signed-off-by: Jonathan McDowell <noodles@meta.com>
---
 drivers/char/tpm/tpm_tis.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index cc42cf3de960..0cbd745374dc 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -162,6 +162,14 @@ static const struct dmi_system_id tpm_tis_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L590"),
 		},
 	},
+	{
+		.callback = tpm_tis_disable_irq,
+		.ident = "ThinkStation P620",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkStation P620"),
+		},
+	},
 	{
 		.callback = tpm_tis_disable_irq,
 		.ident = "UPX-TGL",
-- 
2.41.0
