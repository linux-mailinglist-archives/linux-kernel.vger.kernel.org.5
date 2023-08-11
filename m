Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A11779364
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236501AbjHKPmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236293AbjHKPmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:42:50 -0400
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.133.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF901FE9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
        t=1691768523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iXpDrr1odBbrqT0TQma78/3J1DOasfKLD2qjELvJYIE=;
        b=hQa+2p0YQYA97z5CSTb+mJbnAyEi8pJgV0fPhBD8shB4hpFsg0klObdz48KTD5MfdsGC/0
        QFmwKNbvD+Z28e8QEpfuwfcNOyOYX0BVCp4p4UIb4FndCZIqhKi8MQNWtZ/4tnG+vbDQBH
        OPcsfdiONpBivM5z1T7n+hupA5bg3Gs=
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-328-XctWRSpHPe6PYWJXebInEA-2; Fri, 11 Aug 2023 11:42:01 -0400
X-MC-Unique: XctWRSpHPe6PYWJXebInEA-2
Received: from PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:160::10)
 by MW5PR84MB1818.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 15:41:59 +0000
Received: from PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5e6b:1f96:bb19:ec40]) by PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5e6b:1f96:bb19:ec40%7]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 15:41:58 +0000
From:   "Lopez, Jorge A (Security)" <jorge.lopez2@hp.com>
To:     =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
CC:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: RE: [PATCH] platform/x86: hp-bioscfg: Remove useless else
Thread-Topic: [PATCH] platform/x86: hp-bioscfg: Remove useless else
Thread-Index: AQHZzB4Jrsa7FfVgg0iiCdS6YCkah6/kvJ2AgAB+O6A=
Date:   Fri, 11 Aug 2023 15:41:58 +0000
Message-ID: <PH0PR84MB1953B73F3FD78882065549C8A810A@PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM>
References: <20230811062957.82728-1-jiapeng.chong@linux.alibaba.com>
 <2ec499b-c37e-0a9-c163-2a1591b56029@linux.intel.com>
In-Reply-To: <2ec499b-c37e-0a9-c163-2a1591b56029@linux.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-bromium-msgid: 702b9232-4195-409a-8bee-c4fff11c20de
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR84MB1953:EE_|MW5PR84MB1818:EE_
x-ms-office365-filtering-correlation-id: 4ba4714a-c82c-425c-e1a1-08db9a817f73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: Mi/IW/1VNN9JSmGzm5u2E/PhzgFI9K64Vn+VxTmQtJjkCgdkypovQjx12lByNQ5oFdBFfqbH5OnEoqu/phPyACNC9I4yNiE5dX2ruwwlo6rgQDTQlTZyzEwRs9s/mGN3ynf5Z2EfzNArAEq8qVOc1Vp/M+hOgXkhBqbWx9S2p+slOKuSfJMHOtnKVZP90DyWRQBFlx66xRR4VrmCTXrGv472VDAiWGmQvKR9yO05mAmLDA/DToUXqT86dYyzJkLuPoSKczdYnIXqQmv9OpcPQVMvv7zNpDEAmYy/6TlV4dEaCKvTg3zTmIznjg1YeO8KYwbiptqKt/lZvvG8FzSfsd3pCi3r1PwTN2Ich7wD6oOWxE4z4s+Z+SPlH7cgaztYTYDlc4xo3T2XgyfaMnVr78781BsYe7MZ0kfAMeYMLRSaLtJgeLZaf8f+65nM14nE7O9nERdHLMCWcWAnxrNMim9TyHoF+LoYwkDUkRfQGybxttK9OBCFFP4bx7STfQsyZrUKaXSaJjguvkY8yRCFqO8VHS65MUX5l8b8xx+A1Jun8WF0JcJ+kPotURcxqAt0+kY6af6uTtWcJkq1IK+Vkb+eyvtMjH0lcFq2PzmYOqwHyiukG9EBhZJL+zkztkS7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(346002)(39860400002)(376002)(1800799006)(186006)(451199021)(9686003)(110136005)(71200400001)(54906003)(52536014)(4326008)(66446008)(66476007)(66556008)(76116006)(64756008)(66946007)(316002)(478600001)(7696005)(8936002)(8676002)(26005)(53546011)(5660300002)(6506007)(41300700001)(86362001)(38070700005)(82960400001)(55016003)(33656002)(38100700002)(122000001)(66574015)(83380400001)(2906002);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?P5mz/66pOV13bduvXyrluJBFrHobLkAVRPVvnnC3uCHwQjxMjM4vADgpJx?=
 =?iso-8859-1?Q?ihiBFFCbLWQs0LOYXEqVZu9Iuv1YR/KL0aeMuY5I0xYxr3jjnCyEGusNyU?=
 =?iso-8859-1?Q?ICY5kkYm/SkycLfmElGE2VvgFggBszSf8fMnHNESjLFMuaNIKlvPbzgQLK?=
 =?iso-8859-1?Q?x3t/bFCYAg8kQmwYocMcxxXDZUhnZff0MSac22g3mEobd48D+koz4gZ3GL?=
 =?iso-8859-1?Q?NCAoenyosxfzXmkIDiYHWURVKI6BnqEaRes/6YirRQYNwtn4RRO9ZgGzch?=
 =?iso-8859-1?Q?wac26HiSRMwiZFdyopSaX/C/eEUQde1nI4YtN6221JqiYo2S6lUP3xNjAF?=
 =?iso-8859-1?Q?mPXlN/H3gq1U6PLEgYvsUwPRBG2SuWE333goa0lsBWfVZodHz2gA47b1Dz?=
 =?iso-8859-1?Q?+SRK44qN3cjoZcbuT5KaDtCaQ84zH+Dk7cxP1sFroD3gLd8UoAuG5jVZAU?=
 =?iso-8859-1?Q?AEL9NWYu71mCj7FVVAr15gsn/KjfnXNvyX+PKKuhCBcVUnyn/s3KBHuCxJ?=
 =?iso-8859-1?Q?gMvH4ZFj/6tUFpSmGSxPnE4nJi+vtvxkzPUtilbQflbAR9KaegVKgSOxM/?=
 =?iso-8859-1?Q?mQRIMJaJdGnbMQ23qNdDdaj5IqYpK5024AKHUUJz/o69TpW9fs0L4k6/oc?=
 =?iso-8859-1?Q?Awg8KYK2/DhnISfnW54Hxm7+m6TrAnUlD/onZbR6zT7aBn6HXDfio1xF/N?=
 =?iso-8859-1?Q?hD7FRQo8J/DLBCGjZDCHEKSGadq6PeYEuNMK0fZjcmk12n/WSI+gGDQdHe?=
 =?iso-8859-1?Q?30wHXoHDrh5rr13YA1ZRONx9YIY+x4qjMoTEUtJkbgxO7Ymris42h/dlkH?=
 =?iso-8859-1?Q?Yc2Y1R+Pgqfs1zD8QqC5ZF/2QLO7MQGVQeA/xyOOyg/ds94qjQVXpTQvO8?=
 =?iso-8859-1?Q?5ueai87cweJvzXwTDps90XuIrZmPuTxtyT4FN0UMlNxBg1AZjlhpE3q++9?=
 =?iso-8859-1?Q?KRuk4Qz/u/qTqqXSruUEGmIi4lk5eSVk1vZ/8dUbjcif2dTofleCPvjIaA?=
 =?iso-8859-1?Q?96Rg26oi5lJFV2gGV5g5vgbrW1QWBhZFhgX1wvJ9apfLE0ipT5tKDrZCAf?=
 =?iso-8859-1?Q?Ot1tWfCUazBueypVHwGxlhhCvNPLowAY+IlzIlgqw50fOaQtSTuU/y1Sbf?=
 =?iso-8859-1?Q?1VrU42gjV2e5H2tITfGY6R/Eun/cZ7+I0607p0s6cesbkXpwGd1kg/nuLR?=
 =?iso-8859-1?Q?PcbcykKzZyppF5TgZPL0rRLkxchCTAYWaTTFL75ZD5Yg5SrHtBJrNnsiOi?=
 =?iso-8859-1?Q?tpAnNMJFNXRAkXSMgqwaGKPUBDvAcv58HPhhFxKEpIXjdPQqmZJGqSDOIs?=
 =?iso-8859-1?Q?PU4hDwbJLIB/S4+0SM+pAqPl5Vw+ZZXljBWhe7KSGKF2IDGQQjrv2g0lu/?=
 =?iso-8859-1?Q?wJOe1qqU23ch0Mj9xMH+C/T5k+WmEoCrfdQNl35/MZXKFcwfi5ReKMSWjx?=
 =?iso-8859-1?Q?lS7sP4R/KFU91zgkGBhQKW2Glj8JVJqQQwYtf6Yc0YKpP7MxlYz/F6c6jA?=
 =?iso-8859-1?Q?cXlCbmEJP+9Sdaj+sLPjXfTL3iJNmBNR/VopMaQ/hGmkiKkMZCA1G9ZOGa?=
 =?iso-8859-1?Q?fk4iSdHFnT9LfpXs7e24R417WWHS+nxWo4W2r64bmzlXAP/hu3Xqwuw5B9?=
 =?iso-8859-1?Q?XkMr+5cT6t6iv6pr/dixc+x4uLRL3o/eTc?=
MIME-Version: 1.0
X-OriginatorOrg: hp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba4714a-c82c-425c-e1a1-08db9a817f73
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 15:41:58.2815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ca7981a2-785a-463d-b82a-3db87dfc3ce6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zY1gfi2r7cPGMuJH7DIDDF6HpZAmTZOoH2iPLIealM9CXSmp3TyD5opFHWoAjkYQNWh6FmQCM86+o9hnQQvSbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1818
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hp.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The redundant code is a remnant code from test phase.
I concur with your changes which were approved in a separate email.


Regards,

Jorge Lopez
HP Inc

"Once you stop learning, you start dying"
Albert Einstein

> -----Original Message-----
> From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Sent: Friday, August 11, 2023 3:04 AM
> To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> Cc: Lopez, Jorge A (Security) <jorge.lopez2@hp.com>;
> hdegoede@redhat.com; markgross@kernel.org; platform-driver-
> x86@vger.kernel.org; LKML <linux-kernel@vger.kernel.org>; Abaci Robot
> <abaci@linux.alibaba.com>
> Subject: Re: [PATCH] platform/x86: hp-bioscfg: Remove useless else
>=20
> CAUTION: External Email
>=20
> On Fri, 11 Aug 2023, Jiapeng Chong wrote:
>=20
> > The assignment of the else and if branches is the same, so the else
> > here is redundant, so we remove it.
> >
> > ./drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c:545:3-5:
> WARNING: possible condition with no effect (if =3D=3D else).
> >
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> > ---
> >  .../platform/x86/hp/hp-bioscfg/passwdobj-attributes.c  | 10
> > ++--------
> >  1 file changed, 2 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
> > b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
> > index 03d0188804ba..771e554182dc 100644
> > --- a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
> > +++ b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
> > @@ -541,14 +541,8 @@ void hp_exit_password_attributes(void)
> >               struct kobject *attr_name_kobj =3D
> >
> > bioscfg_drv.password_data[instance_id].attr_name_kobj;
> >
> > -             if (attr_name_kobj) {
> > -                     if (!strcmp(attr_name_kobj->name, SETUP_PASSWD))
> > -                             sysfs_remove_group(attr_name_kobj,
> > -                                                &password_attr_group);
> > -                     else
> > -                             sysfs_remove_group(attr_name_kobj,
> > -                                                &password_attr_group);
> > -             }
> > +             if (attr_name_kobj)
> > +                     sysfs_remove_group(attr_name_kobj,
> > + &password_attr_group);
> >       }
> >       bioscfg_drv.password_instances_count =3D 0;
> >       kfree(bioscfg_drv.password_data);
>=20
> While this is a valid observation, I wonder why you didn't change the cre=
ate
> side too?
>=20
> I hope it's not because you never took a look to understand the
> SETUP_PASSWD related code, it'd be pretty impossible to not notice it.
> This could have just as well have been a bug with inconsitent pairing aga=
inst
> create side, which is why reports from automated tools must not be
> implemented blindly but the related code must be understood first.
>=20
> --
>  i.

