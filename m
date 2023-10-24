Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8657D4616
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 05:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjJXDoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 23:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjJXDoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 23:44:07 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6D1A6;
        Mon, 23 Oct 2023 20:44:04 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39O3VCQq019993;
        Tue, 24 Oct 2023 03:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        PPS06212021; bh=iOZ991P+CPWVfxTnlBRl68jfYu5yE3y66sxn0dEfWXk=; b=
        rrE82hxAdDn+s+92tSu6frQ6y9x3/liDdL8A9BhqvtLEmUGf3wcaEPJ8Sg86ZLEx
        mUKh8wRRePCIlUrz2MgsZ9FzAmlP4sM38z9F0UdHZVGxeo5k1ld/c55BquuUUdoQ
        w+FYgjXx5a76z+89EABQvOKK8IH7f085Ib1x/QqLdnT2ozNK195kWZQPLgVR0H95
        JNsPJTGUzU8EgG5PKfRJJ70tgJfzdobaodP+PF7YQkqxb61V0+RN+1BO27SF3Bwx
        fQ8R5LY+xIPpKt2Wrar9WLRMKCB/cr740JCpfl1aPU40dDAJvcpF65xP/7K6utFA
        t/cXfIYgLrdcKhAika20WQ==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3tv3ux2tt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 03:44:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HsET2JMtY5Wr0HhZxSVGeF3KvKF6EobqJ877fsIz+Dwup/hF/AwH7MBEHT3GvpYLqGRRKPIVvMVyGulIfLFNgkTsQxCGWqY5hNb/gN/q0rjO6QZ0kMAVH0ZSkIufL1c8rHInozcOChDh579V6iYCF33LQ0Hq8pytPB6kAX8vols/RNcb3ccFfnZR2tuSR90qWqr9hXWJFXl5rbFVKwRfGsQlcx6MukFJ4Kc12/eV5gYy49TMTS3I5fnF1zQ9QWyfxRGtfVWIGOIuAcSsX5IJaRjfTY1xxGmd1bf5xyT2GnPPjNN3UJt5+Ad7wqI3xNE+j6uO9hqp9rEfQkaeQse23A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOZ991P+CPWVfxTnlBRl68jfYu5yE3y66sxn0dEfWXk=;
 b=DyDDL6IXxNFYN5ZmZZAOd6mqBzzgw8L++SFBsOla1yY8TxE7FYUzVwnA7huvEVMvlSMd8MzFr3ZrwGaq+EihIy1VIBSWymrsxgYcMD/Uo4C8Jm4oCutDQklu8yO5emFg0WQdn4rdBhQPXjMWxVdOOe7PwSdYgtOpNa3UI5CFbi2/9VpIwOTG9ITafLQrcECM7CHUOWYdEH/C2QzRe3wRion+SVvI7bGlL/JZ50v+D7w0ct15EBDhe7ektOVuCqb1oMaLa8vEBD7k4afQHtDfSXtIj9grD3kPwbozALKWQpMWQOU6ReFH4f9dZSwE+zEGJ6z3gWB/yROQDIKFPcoZkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by BN9PR11MB5260.namprd11.prod.outlook.com (2603:10b6:408:135::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 03:43:57 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::6eff:bf87:e13f:40df]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::6eff:bf87:e13f:40df%7]) with mapi id 15.20.6907.025; Tue, 24 Oct 2023
 03:43:57 +0000
From:   "Li, Meng" <Meng.Li@windriver.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "usb-storage@lists.one-eyed-alien.net" 
        <usb-storage@lists.one-eyed-alien.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: storage: add shutdown function for usb storage
 driver
Thread-Topic: [PATCH] usb: storage: add shutdown function for usb storage
 driver
Thread-Index: AQHaBXOS0TY0dBbnMkyFvU8OyrUaFrBXvqSAgAB6/iA=
Date:   Tue, 24 Oct 2023 03:43:56 +0000
Message-ID: <PH0PR11MB51918DD50651DB6BE937BEA3F1DFA@PH0PR11MB5191.namprd11.prod.outlook.com>
References: <20231023054111.2744872-1-Meng.Li@windriver.com>
 <33bd0779-bfe7-4c87-8fe6-ea8455df3b6b@rowland.harvard.edu>
In-Reply-To: <33bd0779-bfe7-4c87-8fe6-ea8455df3b6b@rowland.harvard.edu>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5191:EE_|BN9PR11MB5260:EE_
x-ms-office365-filtering-correlation-id: a4f6bdf7-f752-4dcd-e7e7-08dbd443738c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oCzrps29zAgV7EZl5H/XTt1845flQ1dF2B8wZKaCfhpOCvvBIw9MsmEadxx4qlIhesEUFXV0GmFV6C+jE51LBuLDtN0+vmSq6CghcYe9NnYvorzifpdMepnBNUmiYdDTU+RG1pVj0bf8FDyZPjGCvK0CqRy8EABX/WswER1IZpX4wyw7EJ/9dnk+IKLHMgv2iiTUPVzL5eQsuldxFwx30FyHlVE9Run1K/JmffeEaeQu534RAszC0c+ULitBBa0I050Wz6t/BnHchiyBWetlnKM98f/qbsKb1+37Jtk+Isf00dZhEkDPsrwXraAJwUck78E3GJ2+AO0JigvAESNTpGJudQG5/VmGRmMf3ISPkINdgLavkZstgFGIHUcrD+LbEJLYhO2c1mLboJ6rB2lBq7uSFcmGCYjw5L/D27HQVTXwYPaDAk/Ejb+Ol6ch3bAAR3/lpu5cjv5uQsEj75k46jMgiNmuXj0Dp+NBYiptmnQfceXA6NpIFzo4QQuy5jU7XXUx9rHr8+TDxQjoCcfO9Jc/Q7X4yF3lmsWXawR5ITV3s94jaiH6LiFBvAgUMDcHe1K1RgXe7twnuITiyXDE47vIy+4/KKhSY2K+hP/9F7C87b0axi/uQ4UN+kD1SbwH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(39850400004)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(76116006)(18074004)(38100700002)(316002)(55016003)(66556008)(66446008)(9686003)(64756008)(66946007)(6916009)(54906003)(66476007)(2906002)(86362001)(33656002)(478600001)(71200400001)(53546011)(122000001)(6506007)(7696005)(52536014)(4326008)(83380400001)(8936002)(5660300002)(38070700009)(41300700001)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GSTqgLZLfzr8Lu5qY+Ikir1RL3/66kW5p0tKxWHrVvJZbB2GfgujCfk4T4ur?=
 =?us-ascii?Q?HoxeqWNSr9Jj934/xG2BfeunCHoRObWLP7EVDqjPF48GJgagdDXtrs4AkLlb?=
 =?us-ascii?Q?WeiXF7Woh869bnOI4mm+HDCvRoCSrjZRJIZyIs9pCIsjTuv3BJ4huNeqVd+G?=
 =?us-ascii?Q?o7Sb1i9CSLpS3Hp0sF/WGUCh316ZXCUy0BqvYhO1kKl3p1/Qq8PvqS1EevjD?=
 =?us-ascii?Q?Xepk51aO6rfGGvIhnoTPqoMCDB/cUy93iMCqvk3H91Qq0q3I8bx7Z6+oFH1Y?=
 =?us-ascii?Q?4YPPzlVisOBf9/1xWjTP+AkUH6mNfaWANqaLzoWhACs2aPhcfW7j6K1iDR5g?=
 =?us-ascii?Q?1ZtTWxq9x6kjWN07bV5/JXIygEAhV3loxwdKRvvX6UcBys/1ewDYs+CMRrnn?=
 =?us-ascii?Q?YwWQFCExcWyqh76QO7ZiAlAe0pxkGTGdi99rhaXn6Wp2M3kPzp+zayNGVFLq?=
 =?us-ascii?Q?IJZFBmxzjpKWzJnvsQC3L8MCcGGNRyL/2062/o0+dDHks/psjr++PGGx+pQM?=
 =?us-ascii?Q?qWHE0B8zpetF7xdTUOppGAWA2x6jrPyiu4Dypi3Lk9qYtqYarGRzU0N0X2n1?=
 =?us-ascii?Q?zWYv0sEkX+s2tol+Tze/h6mBBmoXb6acQE+x6FGv3C0XJyw6NGNKwEq+s5BD?=
 =?us-ascii?Q?Q2FR5wfEQaTm5LE4teDBUXdkaJxmZA1I/cjRiCrVpq6beczjFfHJpjaJbKes?=
 =?us-ascii?Q?bhwnEV7I/0Y/OudNaIBlRebD/mFFcEslzIwETUgimwlqLLIc6pGjtRHvXEkB?=
 =?us-ascii?Q?NxdJJoKji6/JeDKrrQp8WwxSD+/yMS8cyAZARVsetgXc8eXNIefnaOwZ3qjx?=
 =?us-ascii?Q?3H7ROXVcF8jiyHXVZN2BzY1QTuXkoZvkT2lszE5WInVxA/RdNwi2iOkXiOZh?=
 =?us-ascii?Q?MWSBMf2K7s/UdY8ZWI/q+lVRKk9cArvh9JQqa+o0Md1VF7ri1FkSpqNy3oB1?=
 =?us-ascii?Q?kzo+oUpxSCypgyZgOUKegs+Uqme2miSZSubHqwakgNc3UZs108t7wPPlGHEf?=
 =?us-ascii?Q?2T1Tn4U22b4mRnFjHmLK/uU0P6ejZd6By41fHNLin6dHymbJRfRo09q91O8t?=
 =?us-ascii?Q?xStT4UfBUXNK/f4gaoKFcx9A6SpedaiccsUNyVMdlCBK9ZWJuufJVccWFtfa?=
 =?us-ascii?Q?pw8Uz9ZIRyMkRAzsc4bGh8MrOkG2cgv0S5IL517tXprmOWWAmUChTbZCj9m2?=
 =?us-ascii?Q?gXeaQNvrxbgRjHzs5ajDivWwLtTqwjgBL7lMhAZhWMpgZVgSM23ogf3ymdhk?=
 =?us-ascii?Q?sR4TdNeUbPSmvqTWnwT5GromXnqsqL0hCd8VFlaFv775LdCrObpRGiELCBwW?=
 =?us-ascii?Q?WRWrgk6zG1rfcqz7lpUxzRVOHscthRZP/QRgUvgzZgQP2tbqi9U7K/OHBTUW?=
 =?us-ascii?Q?pLdhH2iKxOLGCbWiXr91krLeh5KhLbMj2wixQywv2a6gk0iY7nOfss0JR2IP?=
 =?us-ascii?Q?CG3Mv3+CexGktE3Ts+ubmX8G6BxLTIrnl/VTXvwtJ7Mlt49iERoPkBR2tYk/?=
 =?us-ascii?Q?fCjyEbUTrmcrm6J6mK0GTDsfyh6H0PiI4x31M9ZHO4FPVFgzexQuGj0rLQ?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f6bdf7-f752-4dcd-e7e7-08dbd443738c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 03:43:56.9158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: umy4ZU3CPx1SDCWOnCgo+ILGbCttjA3d/KXqXwJ2QhB4xxLffsgwepRboc2Czx2bpcX8NuacWLWYYKFCtkBsxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5260
X-Proofpoint-ORIG-GUID: qATaCanPE3p1jhGkn8VoOaGSXFBrL4nM
X-Proofpoint-GUID: qATaCanPE3p1jhGkn8VoOaGSXFBrL4nM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_01,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 impostorscore=0 clxscore=1015 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2310170000 definitions=main-2310240031
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Alan Stern <stern@rowland.harvard.edu>
> Sent: Tuesday, October 24, 2023 3:12 AM
> To: Li, Meng <Meng.Li@windriver.com>
> Cc: gregkh@linuxfoundation.org; linux-usb@vger.kernel.org; usb-
> storage@lists.one-eyed-alien.net; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] usb: storage: add shutdown function for usb storage
> driver
>=20
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender an=
d
> know the content is safe.
>=20
> On Mon, Oct 23, 2023 at 01:41:11PM +0800, Meng Li wrote:
> > On ls1043/ls1046 rdb platform, if a PCIe-USB host controller is
> > installed, and an USB disk is also installed on the PCIe card, when
> > executing "reboot -f" to reset the board, there will be below error rep=
orted:
> > usb 2-2: device not accepting address 2, error -108
>=20
> Do you mean that this error occurs after the system has rebooted?  Or do =
you
> mean that the error is reported while the reboot is taking place?
>=20

Understand why you ask me to clarify the time of reporting error.
Only when the reboot action is taking place, there is error reported, and t=
hen system reset normally, and there is no error in the boot log of the nex=
t time.
So, I am not sure whether it is meaningful and worth to fix this issue or n=
ot.


> That "device not accepting address" error message is generated by the USB
> core, not by the usb-storage driver.  How will changing usb-storage help =
fix the
> problem?
>=20

I add an WARN_ON() in USB core code
Call trace as below:
 hub_port_init+0xae0/0xcf0
 usb_reset_and_verify_device+0xe8/0x3e4
 usb_reset_device+0x118/0x24c
 usb_stor_port_reset+0x70/0x80
 usb_stor_invoke_transport+0x234/0x530
 usb_stor_transparent_scsi_command+0x18/0x24
 usb_stor_control_thread+0x158/0x25c
 kthread+0x120/0x124
 ret_from_fork+0x10/0x20

> > This issue is introduced by linux-yocto commit 837547b64a34("driver: ne=
t:
> > dpaa: release resource when executing kexec") that cause to spend more
> > time on shutdown operation. So, the 2 platforms with DPAA are not
> > reset immediately after executing force reboot command. Moreover, the
> > usb-storage thread is still in active status, there is still control
> > data transferred between USB disk and PCIe host controller. But now
> > the shutdown callback of usb pci driver had been invoked to stop the
> > PCIe host controller completely. In this situation, the data transferri=
ng failed
> and report error.
>=20
> That's _supposed_ to happen.  By design, the "reboot -f" command is meant
> to carry out an immediate reboot, without using the init system, unmounti=
ng
> filesystems, or doing other cleanup operations.
>=20

As my above said, I understand what you mean. I also thought over what you =
said.
I am not sure, but I still sent patch to upstream community, and want to ge=
t some suggest from more authoritative maintainer.

> If you want a clean reboot with no errors, don't use the "-f" option.
>=20

There is also error report even if I use command "reboot"

> >  Therefore, add shutdown function
> > used to disconnect the usb mass storage device to avoid data
> > transferring under the stopped status of PCIe device.
>=20
> I don't see how this will fix the problems associated with a forced reboo=
t.  How
> is preventing data from being transferred any better than getting an erro=
r
> when you do try to transfer it?
>=20

After adding the mass storage shutdown function usb_stor_shutdown(), it wil=
l release resource with bellow call logic.
usb_stor_shutdown()->usb_stor_disconnect->usb_stor_release_resources()
in the usb_stor_release_resources(), usb_stor_control_thread thread() is st=
opped, and there will no control data transferring.

> > Signed-off-by: Meng Li <Meng.Li@windriver.com>
> > ---
> >  drivers/usb/storage/usb.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/usb/storage/usb.c b/drivers/usb/storage/usb.c
> > index ed7c6ad96a74..e076d7e3784f 100644
> > --- a/drivers/usb/storage/usb.c
> > +++ b/drivers/usb/storage/usb.c
> > @@ -1142,6 +1142,15 @@ static int storage_probe(struct usb_interface
> *intf,
> >       return result;
> >  }
> >
> > +static void usb_stor_shutdown(struct device *dev) {
> > +     struct usb_driver *driver =3D to_usb_driver(dev->driver);
> > +     struct usb_interface *intf =3D to_usb_interface(dev);
> > +
> > +     if (driver->disconnect)
> > +             driver->disconnect(intf); }
> > +
> >  static struct usb_driver usb_storage_driver =3D {
> >       .name =3D         DRV_NAME,
> >       .probe =3D        storage_probe,
> > @@ -1151,6 +1160,7 @@ static struct usb_driver usb_storage_driver =3D {
> >       .reset_resume =3D usb_stor_reset_resume,
> >       .pre_reset =3D    usb_stor_pre_reset,
> >       .post_reset =3D   usb_stor_post_reset,
> > +     .drvwrap.driver.shutdown =3D usb_stor_shutdown,
>=20
> This definitely looks like a layering violation.  If devices are to be di=
sconnected
> during a system shutdown, the USB core should take care of it.  Not the
> individual device drivers.
>=20
It looks like a little uncomfortably indeed.

> What will happen if you make this change to usb-storage?  In a little whi=
le
> you'll want to do the same thing to the uas driver.  And then the usbhid =
driver.
> And the usb serial drivers.  And so on...
>=20

I add the shutdown callback refer to uas driver that has the similar shutdo=
wn function.
About the usb serial driver, there has been serial_port_shutdown() function=
 at a more reasonable location.
I am able to test all the cases with PCIe to USB card, so I am not sure whe=
ther there is also the same issue with other drivers.

> This does not seem like the best solution to whatever problem you want to
> solve.

Maybe. But this issue is caused by usb_stor_control_thread() thread that is=
 in the use mass storage driver.
So, I would like to fixed it only in use mass storage driver.
Based on my current understanding of usb code, I don't know whether there i=
s a unified usb core interface that can fix this issue of all the usb drive=
r.
I don't have ability to touch use core code that has so widespread influenc=
e.

Thanks,
LImeng

>=20
> >       .id_table =3D     usb_storage_usb_ids,
> >       .supports_autosuspend =3D 1,
> >       .soft_unbind =3D  1,
>=20
> Alan Stern
