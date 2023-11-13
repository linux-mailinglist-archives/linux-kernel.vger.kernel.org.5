Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CFB7E9D2B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjKMNbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKMNbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:31:09 -0500
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3928B172C;
        Mon, 13 Nov 2023 05:31:06 -0800 (PST)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3ADCjrlR019493;
        Mon, 13 Nov 2023 13:31:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        PPS06212021; bh=QCOTHLDWYuvELDpneljhIHbwBvsrIJG27Sl/VOEJadY=; b=
        BEBfLX9WHdw3Bculs+YndX0hse/VpwWQbVK3+dnIoekVQwGwmLhA5UHXFXl8fjKq
        iygYj76dF6UNeBZ3q50pR27nIiJt/irSjITU5bXW/AXboPGryOZ5K/493m9wIw/B
        er41tP9oBsmrKKqDSQpkcehvVAMgCgltlAPpkXvGW3O+tjA2hOZl0V1cZOWg2kZS
        OVPakzWBsR/J7IjSRkU7YxISjmRC6wTNTK0GfF5W1C8+BFsDlIGlueWFJedkNj0g
        LhPu1qWKiPwvX2VRoAlF/RpgVKsmjw+d++L3uCjJYPiodgIzwc0Si3Jvlb7aNbR6
        M6Orq2gg9Q+XzfbgvDU8SQ==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3u9xtx9nb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Nov 2023 13:31:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aIz5ziIAFUKw7or3aDYAYYMu5MfLn39VoXFu5AcGUADNmbRwY45XlR8WYs0FZlDjAfyuPiY5T1DMlORlF8yn0/nYAqEIy5CLSlUmjzLKmPx0eIO8mbFx2zghk2goQPZMFk131XZC28EnMI6wT/mpYjmimGT0JdAm0H5O8dZiR8BixaapxafPv00M5d+YFrwzdUD3tTctgQCallxtqVtptQlGgGIDQ4OCMXw0djiM9M17YzWl4HvPXgkN2DRH6p1D9ZbicfqnrWGGTTdlQOg9ynZtXyfSbzZglrQqhfeYr1DI4te0QO16ajgfE3APEPiw8dCuQo6t4ZRd5LWfxS6keA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCOTHLDWYuvELDpneljhIHbwBvsrIJG27Sl/VOEJadY=;
 b=Hp1JcYjyEMNArKDYFiA+OEdBg5s3w57QeQddKHl61HhMKHsFlWG8OjvpQ6f65RbQlxmiyq+RzqKL3QJCEqxYQ4KNHj4k26ZogV+Q9pLwNmPgQCby4O8DjGSHy4znkFg9+8tHkheJihz+0aJuElOMbGbN96OniuGJqDxXt60cE/SbGAe7+Em+dyJOk3Gsfd+c36ynIVZ3tYzuPoHqqUjQRbaBPPg7SStYf2h2FEThfj3kF9h7j1Jss3bSeoSJfGOOrLwtJQrHFBQeGO3YIjpsFMFtwt+eG9nR4BZkt83Tv0mIG/aLRcQ3gmy/0bb91xuJ8i/wkczBIrt0lPN9XH7w6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by SJ2PR11MB8346.namprd11.prod.outlook.com (2603:10b6:a03:536::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 13:30:58 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::41c:9808:690:f88f]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::41c:9808:690:f88f%5]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 13:30:58 +0000
From:   "Li, Meng" <Meng.Li@windriver.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "Basavaraj.Natikar@amd.com" <Basavaraj.Natikar@amd.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: hcd-pci: replace usb_hcd_irq() with
 generic_handle_irq_safe() to avoid calltrace
Thread-Topic: [PATCH] usb: hcd-pci: replace usb_hcd_irq() with
 generic_handle_irq_safe() to avoid calltrace
Thread-Index: AQHaFd2rDxm2vbGN10msMgs59igVF7B4P23w
Date:   Mon, 13 Nov 2023 13:30:58 +0000
Message-ID: <PH0PR11MB51913F2805FFB72B4454F5C0F1B3A@PH0PR11MB5191.namprd11.prod.outlook.com>
References: <20231113030041.3655742-1-Meng.Li@windriver.com>
In-Reply-To: <20231113030041.3655742-1-Meng.Li@windriver.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5191:EE_|SJ2PR11MB8346:EE_
x-ms-office365-filtering-correlation-id: da552980-e0bf-483b-d389-08dbe44cc5a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p8XsWxwj6LELNSEHChUMXj+w2ZpHW3FXCR8KcjaVrVpxB/aKTyhQa56HKZHP7fPoWKg+PLZ6wEne5htmNdyrgccx4McVqDuFBENg8T20rabHA1bHKLIERHymLtxARN7H6GaU7cEqhNrUr8VAyNga8fQLnOZEHMqD04+s2Yd67FRTSlWEoZtBv2xRN98dWAnUb/IyqP+uHE8ZSqw/F7lJ2CaTTCU8U6ev1oqEQfLv1Y6k20Gmj18zSHuh4nEaa3oOOdo+dFr0bRSXckJUc3oeFPuQ5qgh+Xqt0Zb+NvWvtTEiQ7JRa5ExCgo79ZzAsuCw+WTcbFvF7do8xoqVhI3W5vaJd4Z5LACgN1BJLapJWCdohEY9rc+CWLNJQWpdGRuars6fl2BeYZn4s5v6oCl6okPRaGqKzl3ywaYs0tCOmYiCLgEMeYkUIKmp2q551WOc38eLKGYnvPbVNMzNAy3ZirytvipmPsjgbOQ3VLMn6FJ96pK5tLv7HlG6Vj3cG6GqB8idv4t/014Inxlsb7DC3KJaZ+mnn9uqFM4GJmvENgAyD3cL/eURTsuky1UQCvRY/e3M7QyhyRBlHipngN4U0c5C9VoacOSmv/Z6MqzAjsjh2cQCGADGjYtiqbbkXoA23ko9+RbHZNHVZKykMl5O8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39850400004)(366004)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(8676002)(8936002)(52536014)(71200400001)(38070700009)(26005)(2906002)(5660300002)(86362001)(7696005)(6506007)(53546011)(55016003)(33656002)(122000001)(478600001)(41300700001)(38100700002)(83380400001)(316002)(9686003)(66946007)(66556008)(76116006)(66446008)(64756008)(66476007)(110136005)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vl8bRHWgiGrWOsaVdSoVTvb21FTiO2OTZ/VU/noQ5bWKToWvuB/Jm8bGeH2+?=
 =?us-ascii?Q?O7pEmSlFihRTZCENJD9xhz3myv0bvIvEUkBZ6Mov47AA4Z9ISICSN1JUC0IL?=
 =?us-ascii?Q?fC/wen46cZwvJfPgN/E+yfyb5Qnk2G+6Q036pcEfEv4L+1sCEWipJhAVJfnR?=
 =?us-ascii?Q?XV+mUtQMBSqEIoqxGF9jCB+lxEIyEaAnXYvPoGp0gNdwZvpTcHYxmwS740PJ?=
 =?us-ascii?Q?ifZ912CNE06fAky+n/di6bLdOduQ3w6R6ZgMUjQn4K/POmOdzGS7gJUPTAre?=
 =?us-ascii?Q?Fxwju+itZl3vPSeTuAkkMTHoClkoY3FhW1O3lX6mDbt/hCmprpCWn7MIdSSI?=
 =?us-ascii?Q?f89js2gNZzpn22K1csmW1SBvpEqoLC4DYbtIlMkwU+LwPc581uflIlQbMkVu?=
 =?us-ascii?Q?768Zs3C9kd9ZOIa9s648U4vOdGTWNddJgVW5Lrbrn+tvFTeqUmXlYWZX+wsw?=
 =?us-ascii?Q?6iCD4dU5sMS/pAF2PPlodJmNr8MpysF1xQjMfyky/EKiT1Etxx8SwZmF+7Ue?=
 =?us-ascii?Q?mfJJxrDFn0RPPmN7FVgFwLke4rU7PZWlsPj1P7vROs0by9EuyW+aT6CFSlZM?=
 =?us-ascii?Q?7SAaIb7e30P4FuLVn1sSgRGFEaQKa4IJP7Dz5s7P8zGHWPUfu285XA+qCDYT?=
 =?us-ascii?Q?30g0yM5iLRX9i4c5i4bDju+rPasuNpVYB2MwNk8h8v0NaZjT9JjzGWEeS8tA?=
 =?us-ascii?Q?CKyfHKBQQrxP9mtfzqbtU+0A6ib6zfUBybVEbvP1W30kk2nYv2AWto4tsguW?=
 =?us-ascii?Q?sYlh2kxwJOsDG7BOAi5wvIPKiA9T5JTscG3W2h0/FhF3T3tNo0ZNlScbGFrz?=
 =?us-ascii?Q?7yRQnjIXc3N1tz/I9B3AllFEqErJsiT+ifMxlsRdKvixB4PQ8Nk/OEIe5r72?=
 =?us-ascii?Q?hPyGqtWVb+LtonP5dUzRfCKNKBgMd4jW2vtmHbgVL57MMkiZZU1EsY7kNKFD?=
 =?us-ascii?Q?05Gs6IM2/FSHubI4kfoDbdN1loDYVLxCv8jJMP7mmu/y6yI4+Zx14xDM+xJ6?=
 =?us-ascii?Q?sS73PE9qAwUI/rSocTlD+EV1STgBddDYcEDALmPafEPnAW5EwqRviWX60cp8?=
 =?us-ascii?Q?6e6DK3KhxhNRCZPDbGEHQSorK8edypq2NMVeB6pR/RYssxBKPxNCAvntMJdV?=
 =?us-ascii?Q?qPbNugAph9XZ2jdckcawIuALh5ln0Qhg59BepIpnFoMQWak9Enqj8bF+Bn5/?=
 =?us-ascii?Q?+hEGLwbdyhA8K2+3axHMVeiNclIw16phNLS7Ne2+VylSQzvvIkeDd3wamJ3k?=
 =?us-ascii?Q?TNDYMWw1QFoQDWrdPatcyRIBzQGQF1L0d4zVSJZLvXg4hgk7GLfXxaA3Pg8U?=
 =?us-ascii?Q?8j69qf3YhY0V7p5w3JlXf+A4RGukw7rbwZjN5GNFF5NgPWD6JeUNihNz8bZ2?=
 =?us-ascii?Q?mYDtgPWeRQhkMyALqbnU6289i1BJTn2Tx3p94PvZ/20tTcT3ZSx0gNo6IxFh?=
 =?us-ascii?Q?poiLA6eXfnA5Ndzwj/OhyCZ+xmkv/8dmkdNHFJn2oASg15lPqMpBLusMCCUD?=
 =?us-ascii?Q?rv9p5d0FD5Nl52m5/qu2KqNGZoJevmkom0xYaBRRX0M7H5w2c3k9ERIZ9Ab6?=
 =?us-ascii?Q?qHv/pAfjHyRsd7W2rqLs5m/y0g5VIknD4MPt83eg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da552980-e0bf-483b-d389-08dbe44cc5a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2023 13:30:58.7553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z4FlzpnAGdc7PkQYduxwPfhxxkUGD2fktEtVX4tCV4bcn0rnrog9bpjSpMZ4ZH8yvSW9Li63zbOCZXHW+KPs3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8346
X-Proofpoint-ORIG-GUID: 0K8kRkSdf66Q4vyankNi2m9wupQ428IQ
X-Proofpoint-GUID: 0K8kRkSdf66Q4vyankNi2m9wupQ428IQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-13_03,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=412 bulkscore=0 mlxscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311060001
 definitions=main-2311130110
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please discard this patch, I need to do further research.

Thanks,
LImeng


> -----Original Message-----
> From: Li, Meng <Meng.Li@windriver.com>
> Sent: Monday, November 13, 2023 11:01 AM
> To: gregkh@linuxfoundation.org; mathias.nyman@linux.intel.com;
> stern@rowland.harvard.edu; Basavaraj.Natikar@amd.com; linux-
> usb@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Li, Meng <Meng.Li@windriver.com>
> Subject: [PATCH] usb: hcd-pci: replace usb_hcd_irq() with
> generic_handle_irq_safe() to avoid calltrace
>=20
> When running below to command to remove a PCIe-USB device, there is
> below caltrace reported in RT kernel.
> Call trace:
>  ......
>  __might_resched+0x160/0x1c0
>  rt_spin_lock+0x38/0xb0
>  xhci_irq+0x44/0x16d0
>  usb_hcd_irq+0x38/0x5c
>  usb_hcd_pci_remove+0x84/0x14c
>  xhci_pci_remove+0x78/0xc0
>  pci_device_remove+0x44/0xcc
>  device_remove+0x54/0x8c
>  device_release_driver_internal+0x1ec/0x260
>  device_release_driver+0x20/0x30
>  pci_stop_bus_device+0x8c/0xcc
>  pci_stop_and_remove_bus_device_locked+0x28/0x44
>  ......
>  el0t_64_sync_handler+0xf4/0x120
>  el0t_64_sync+0x18c/0x190
> This issue is introduced by commit c548795abe0d("USB: add check to detect
> host controller hardware removal"). Because in RT-kernel, spinlock that m=
ay
> cause sleep is invoked under irq disabled status. Therefore, replace
> usb_hcd_irq() function with
> generic_handle_irq_safe() to avoid calltrace
>=20
> Fixes: c548795abe0d ("USB: add check to detect host controller hardware
> removal")
> Cc: stable@vger.kernel.org
> Signed-off-by: Meng Li <Meng.Li@windriver.com>
> ---
>  drivers/usb/core/hcd-pci.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c inde=
x
> ee3156f49533..3b5f7dccbe6a 100644
> --- a/drivers/usb/core/hcd-pci.c
> +++ b/drivers/usb/core/hcd-pci.c
> @@ -325,9 +325,7 @@ void usb_hcd_pci_remove(struct pci_dev *dev)
>  	 * to test whether the controller hardware has been removed (e.g.,
>  	 * cardbus physical eject).
>  	 */
> -	local_irq_disable();
> -	usb_hcd_irq(0, hcd);
> -	local_irq_enable();
> +	generic_handle_irq_safe(dev->irq);
>=20
>  	/* Note: dev_set_drvdata must be called while holding the rwsem */
>  	if (dev->class =3D=3D CL_EHCI) {
> --
> 2.34.1

