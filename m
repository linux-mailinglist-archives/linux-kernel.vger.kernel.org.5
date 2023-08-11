Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657A577936E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbjHKPo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236638AbjHKPot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:44:49 -0400
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.133.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0242123
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
        t=1691768647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i1HEFVbCS37beIjhX8uXTN0VOMio9hwvZJBP9Z356nc=;
        b=BQ+6ARBvnOTKCyrN/YNedKmz78bHA6QrWL9n1O97O68DnLghQ7dFMzx2Ovf5/n6Df1kMWK
        0N6Lhx8Oxn3lX3atmivHR9zRXeYitP5MyhsPtUWKsoY4UeKNU2Wm+1Zcz6CaKTN0Iyly4X
        D+t0GXHNkY+yeug4LQzhJjrCKPHYk+c=
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-fj5CmBQtPBufTjlBJRPWOQ-1; Fri, 11 Aug 2023 11:43:00 -0400
X-MC-Unique: fj5CmBQtPBufTjlBJRPWOQ-1
Received: from PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:160::10)
 by LV8PR84MB3655.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:408:1f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 15:42:57 +0000
Received: from PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5e6b:1f96:bb19:ec40]) by PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5e6b:1f96:bb19:ec40%7]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 15:42:57 +0000
From:   "Lopez, Jorge A (Security)" <jorge.lopez2@hp.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
CC:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: RE: [PATCH] platform/x86: hp-bioscfg: Remove useless else
Thread-Topic: [PATCH] platform/x86: hp-bioscfg: Remove useless else
Thread-Index: AQHZzB4Jrsa7FfVgg0iiCdS6YCkah6/lPExA
Date:   Fri, 11 Aug 2023 15:42:57 +0000
Message-ID: <PH0PR84MB1953FF2E688B5E250B0E37E3A810A@PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM>
References: <20230811062957.82728-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20230811062957.82728-1-jiapeng.chong@linux.alibaba.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-bromium-msgid: 1bce0796-c0c0-4fca-a834-ba9c23148860
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR84MB1953:EE_|LV8PR84MB3655:EE_
x-ms-office365-filtering-correlation-id: 787d9bed-c35d-4a83-8efa-08db9a81a2cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: /1+lWouk0EqoIwjWOD7YQQekdhM4uWvYiQzimwR5BKBxmw7sTG5e8giM2A5p3r6gmqqpRo3+xLFDriHVrfmmt9Og0N8AvijoOhIPbYZKukHRnGH/A6iVG6SJV5Xu/DdN9td8lwIaXO0T1kfznjK+a5L8wM5UdeyG1bngAJ0bZurgkyNuJ+fWx67QCo7KAwkali2Gu88UtXoicakbzwo4pkYrAdSQm2g8ptGXyMYPCBwbAjyIteEfQ4Yl3RRJgG2/IoI/BNauwYcHNtg64KyWCajHcz6APqID66URs7SibrgJBFV/y2hXvL0HAd0JLtniWdI28JvXmYcbYdYx9K1vvdMtd+UF1AfMmQcr0UGzTlEyzwxPp2DgI9mARRS6t9kmQks3CIgUI8fsy7DiPTOFzjw7SbU08oxPW7PnZao8yNh3tBWK/+k/3QgtuG9thF1mtQwcQxTI5zvSM87ybbeH3LroGGx/KAXYgY5asHc9c6V9nCaP3SsWwMesz/9qwdQGko+GANUiUvDTdhFHRhANNCBt/Gfsu8Q37zC1+izEnJ1x8AR9dLFQufXjhXSY9uTzz2n0Vp1yoV3LqnreAxNGKa1VRCkm4Rcnk6ZvtuVezowMDm67xbrvpo+Tv7ZTTVdY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199021)(1800799006)(186006)(6506007)(26005)(86362001)(53546011)(41300700001)(66476007)(6916009)(66556008)(64756008)(66446008)(8676002)(52536014)(83380400001)(5660300002)(33656002)(316002)(55016003)(76116006)(66946007)(8936002)(478600001)(38100700002)(2906002)(71200400001)(122000001)(38070700005)(7696005)(54906003)(82960400001)(9686003)(4326008);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jxUra9rewIqkWip5sYWo/Oa6H06EPQD5uium25DcqTw2UAc7dk6ahAwOk39g?=
 =?us-ascii?Q?bO6kxWimgUj/cBhHqYbeU1SelWcXo0wE85PfFwV5ue5JNoR6t722U37vHkf6?=
 =?us-ascii?Q?pUXhBqcbv0C74boWWYk+/scnohzkvWL4l/j90ndNP2hYdR4BgoZZasQdNYoO?=
 =?us-ascii?Q?qAxiagRalVtnPQ4zS64znGMdYm+yeAcnZrJ9871GR0tXYzbuNueRjHF/IZRc?=
 =?us-ascii?Q?/cJ7am1zHlNCSG9vdLCzMbWF4BT+iOv00Jtg1orjjdxqGN4RhAN1FCQ3v1Fn?=
 =?us-ascii?Q?HDIK8nSOjCk2jZVp9OR9G0XJK4UfwNNj/5dj3soHvS0RBtyIxlzJ+Y+8yFNh?=
 =?us-ascii?Q?ntu7WkA1vxBxNChaauAIgH1M0/A8R0WLTASOrf+6ITlgG1eAz8ThtQlAT/f4?=
 =?us-ascii?Q?m/ebfSstg8hSgmbhMHTF84cMEHcseX+f0H1nDJQU+3GiCQpAn9Q2OJdnHHag?=
 =?us-ascii?Q?KJqHWBdSaHkZI0sUSsieMXikdiEapoPMgpB0cjAGQXmQQ/Dd3vYHeTEWHPVU?=
 =?us-ascii?Q?lHZiNJy6cNRkTzlGIIH2Ylfly50PuT7eD9YXIqBrlrcWFfgA4mk9zV3kORR6?=
 =?us-ascii?Q?p/AL76RQO7y8ml5OPICdfMd+12Hz2R/yMUmSuqWYejhWECB993EPFo7BYsYP?=
 =?us-ascii?Q?ldkkgtN77iuKLVSplvyajIiLLggaAC3AsgeUEWptpPENv1u+hQv+sQB1YpIz?=
 =?us-ascii?Q?kYraFjHy2W3NSQnjRXh4u2p80NT2JQHUTGJdL9VK1WGdqbNHNzSzPpmyicix?=
 =?us-ascii?Q?VHtSOh90XLFYDFQtAaeiKxmgZvTd3TVIh2z8R5xLxi6e7Q6UbJRUV4IU/Ckc?=
 =?us-ascii?Q?B5/XrzMRd788goxPpOm/OCCQr7u3QBdJ8R3T1lT9EYD7zYs6pABJxcfFOzYE?=
 =?us-ascii?Q?KQXi1OSa6XBVLnq3dzl1pi2ei9JYYjVkHzXMFIFO60Q9fFVIPxsYDs99+H7E?=
 =?us-ascii?Q?pY5EqcKPZF4lhZSGqjwJxtU6WcQqP7V8GaHpMIFqGfdqz/iXoDh8FmDxmdn/?=
 =?us-ascii?Q?jRFfVvpzKiWTyJysZ7vryTOUNJPi62mF2P3UuAZnS2rN5NggCYSRv7yoohG/?=
 =?us-ascii?Q?0gXnxgRIFj5RhrkbUTWKFeIewlqM0iqCpGzHqG4X8onNPMUKGN41S2nUcrmf?=
 =?us-ascii?Q?2Xgkn3jxBy1BKnIo3w8pZP5vMZirqMqFQJQ7Y6hvzBtOPTkNAOkFxP4Wfhbh?=
 =?us-ascii?Q?KKKLJo0/wVNoXmOCRsSUqidvwDAMPjVOfBjSxPZnLLQ9xoLZOYa9Ol97qEhT?=
 =?us-ascii?Q?RdPDqiNkHJg1ejD6AfqhT4QMnYdlL+zfUuCITD/kMMDOBs6338m5BEaffc8O?=
 =?us-ascii?Q?aDtrZ8/W0G1oJ72w2Zl1nIhtQ4p6GZchLKP6Be/MbVp5KA8+zuIlMnZuiZEp?=
 =?us-ascii?Q?0E882xQKf42cGtNu/ydgyxeWSu53h8kq0HZSn68IjTPqxAjwyO61b+HcHfCk?=
 =?us-ascii?Q?icRUB6D3PDQilgYiz0M110CwRDnN9HMz9EhXNmdOcc9z6u2V4eVvsJSlZr3m?=
 =?us-ascii?Q?N+Xy4tq/KEos4emtAfvGcUWe2NuUXVGLTG59RQkps5JvCefijSwyYH8UpvWk?=
 =?us-ascii?Q?NqfC2lM0FZ0JBMQFpTYdu7rGYjheSlpVwBBFS8MH?=
MIME-Version: 1.0
X-OriginatorOrg: hp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 787d9bed-c35d-4a83-8efa-08db9a81a2cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 15:42:57.5291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ca7981a2-785a-463d-b82a-3db87dfc3ce6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GThoSiah8Lc7X888oONo+fUavMwhRSIHZK1IE7pDV/oPTPxM0T20uEVB08SBzdWXvl7BGecxUn0p3gZAHqPghw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR84MB3655
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hp.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Jorge Lopez <jorge.lopez2@hp.com>


Regards,

Jorge Lopez
HP Inc

"Once you stop learning, you start dying"
Albert Einstein

> -----Original Message-----
> From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> Sent: Friday, August 11, 2023 1:30 AM
> To: Lopez, Jorge A (Security) <jorge.lopez2@hp.com>
> Cc: hdegoede@redhat.com; markgross@kernel.org; platform-driver-
> x86@vger.kernel.org; linux-kernel@vger.kernel.org; Jiapeng Chong
> <jiapeng.chong@linux.alibaba.com>; Abaci Robot
> <abaci@linux.alibaba.com>
> Subject: [PATCH] platform/x86: hp-bioscfg: Remove useless else
>=20
> CAUTION: External Email
>=20
> The assignment of the else and if branches is the same, so the else here =
is
> redundant, so we remove it.
>=20
> ./drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c:545:3-5:
> WARNING: possible condition with no effect (if =3D=3D else).
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  .../platform/x86/hp/hp-bioscfg/passwdobj-attributes.c  | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
> b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
> index 03d0188804ba..771e554182dc 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
> @@ -541,14 +541,8 @@ void hp_exit_password_attributes(void)
>                 struct kobject *attr_name_kobj =3D
>                         bioscfg_drv.password_data[instance_id].attr_name_=
kobj;
>=20
> -               if (attr_name_kobj) {
> -                       if (!strcmp(attr_name_kobj->name, SETUP_PASSWD))
> -                               sysfs_remove_group(attr_name_kobj,
> -                                                  &password_attr_group);
> -                       else
> -                               sysfs_remove_group(attr_name_kobj,
> -                                                  &password_attr_group);
> -               }
> +               if (attr_name_kobj)
> +                       sysfs_remove_group(attr_name_kobj,
> + &password_attr_group);
>         }
>         bioscfg_drv.password_instances_count =3D 0;
>         kfree(bioscfg_drv.password_data);
> --
> 2.20.1.7.g153144c

