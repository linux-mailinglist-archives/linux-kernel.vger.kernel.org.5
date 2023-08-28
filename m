Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51ED278B6F1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbjH1SBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbjH1SBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:01:41 -0400
Received: from out203-205-251-27.mail.qq.com (out203-205-251-27.mail.qq.com [203.205.251.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F34E19F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1693245691;
        bh=3nVTOKxn2v+c71PUzivCsIb3z1modIsrex9BbYGMMl4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=uCZmPxy+VgSxOnQCgFR7lp+r4gIVf5/wkD/jPTCbiGN3Mzl56e4E35Xv9Wrclv1OV
         PO5wQGGXF4PMQfkwMbXby9qcWOqsurOVruzM4cJXp0YhPwc7RaYUOHn6nBUyYw4fzB
         YjuGv+XEWsWc9Nc03lZ59BmM8nuicFoxia6p5Vfw=
Received: from localhost.localdomain ([122.14.229.192])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id 59B64FA; Tue, 29 Aug 2023 02:01:25 +0800
X-QQ-mid: xmsmtpt1693245685t2z0nsx4d
Message-ID: <tencent_2E893742B5115B5260081E410A34A89E1208@qq.com>
X-QQ-XMAILINFO: OXimaFo5SPf+AS8BFVa5JFDdiCIPCP6Hem7rxSpfyMGR6VE9/jmxPEJvgITgbC
         c1PPzMO7Z86dXcLh/SiWvqxnEZFTW4Me7vEpiW3aYfvhlidbEF7XTV+rfnyZyK2vVDgJvB4cT1Qt
         ZGmZlihtOgYomx7hhMMsFSuf+cVjxYZf0V9hSFVG4S1amigyVO1U93ANQBP1la8/UMApXxNEu42V
         W7+Nx8n36125VcXMQw8FMoy5s8gut7pmL7HfAw2z8d9Q6HRo28dGQcE3Skw7cKRAXrWjIcj3gJy7
         7C+YyN17h9HV4D+QyYo0vaFJuK/BE9sc0ulf6QWxJp+GL3zjOw8dWx5nUAgPaVvXlDNMJXGTVkXr
         bM3YLMHYXTJt/Ip0BReWOefprfI44VRLthwrjAwbJqqo/ZPl9Y4GkitrQjSe7uoTJtoges59Pbhk
         OA9sWNbg87ZKb+TfT7LHniuf8Ho9CA+KvcG+PQYYze3dZUY91As2GxTC24jIrOBW3cHz9n5JScCD
         8pCmQ+wzvEhEBG+4FTgrwThCXvlEfC7FHko1tVglY+OiWGeuhN/VBoDUE13+ZN5x6gIC371vTc7u
         Jps7kIqOQba8zL088HoGRf5eARHO0lVRqXjzJZ3wLgADGEeJSjJUtYyfY3Ng8xgQVMPxli61/NPU
         6xdFn5TJR3rrbDV9Fkk+je42ic8R7nG2rs4yCEctk9g4I5wPmNeC570YUgPFZXfjxe62sYR4ivXW
         mK29m3yIPDBpB7YGuhl65pzMQuZYh0CWhzGBxlyOquepwS0Vl6IN08EnbNqGEh5pcsw4kRm5XcJG
         s+tYpdl/Y/kX4yoiWlqgPLehGTYZF6yB8/O/DZZSHl5R+3xI5wZhcgWAI3eYFdgOFuIKl0UW0SYt
         ANbF+CTRYdguRksRCo3bMTxWlXKQbkiWYcEfZCUfHuCmcW+zMPSoP8kYVdWE3LJoK7E6fh0eKJeA
         zMioiQkavKk9+ZgNo1Ic7QtPhf8IivET4pDTD7wn2Yfo/i72pNlC/qIj/ShJl+ZSBQqY0XEvPyBJ
         hMnYOIKxbfxMvrIHTCYF1K0h+V0kpQ015XVdjT17uEuTdGAjfH
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     victor.liu@nxp.com, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, rfoss@kernel.org, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@gmail.com, daniel@ffwll.ch,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: imx: fix potential NULL pointer dereference in
 imx8qxp_ldb_parse_dt_companion()
Date:   Tue, 29 Aug 2023 02:01:25 +0800
X-OQ-MSGID: <8281992.T7Z3S40VBb@localhost.localdomain>
In-Reply-To: <20230828172822.GE14596@pendragon.ideasonboard.com>
References: <tencent_026E4B04ACDCE341411EF54862F8C6AB1605@qq.com>
 <20230828172822.GE14596@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2023=E5=B9=B48=E6=9C=8829=E6=97=A5=E6=98=9F=E6=9C=9F=E4=BA=8C CST=
 =E4=B8=8A=E5=8D=881:28:22=EF=BC=8CLaurent Pinchart =E5=86=99=E9=81=93=EF=
=BC=9A
> Hi Zhang,
>=20
> Thank you for the patch.
>=20
> On Tue, Aug 29, 2023 at 12:55:01AM +0800, Zhang Shurong wrote:
> > of_match_device() may fail and returns a NULL pointer.
>=20
> How can it return a NULL pointer here ?
>=20
> > Fix this by checking the return value of of_match_device().
> >=20
> > Fixes: 3818715f62b4 ("drm/bridge: imx: Add LDB support for i.MX8qxp")
> > Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
> > ---
> >=20
> >  drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c
> > b/drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c index
> > 7984da9c0a35..d272f35c8eac 100644
> > --- a/drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c
> > +++ b/drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c
> > @@ -488,6 +488,8 @@ static int imx8qxp_ldb_parse_dt_companion(struct
> > imx8qxp_ldb *imx8qxp_ldb)>=20
> >  	 * string.
> >  	 */
> >  =09
> >  	match =3D of_match_device(dev->driver->of_match_table, dev);
> >=20
> > +	if (!match)
> > +		return -ENODEV;
> >=20
> >  	if (!of_device_is_compatible(companion, match->compatible)) {
> >  =09
> >  		DRM_DEV_ERROR(dev, "companion LDB is incompatible\n");
> >  		ret =3D -ENXIO;
I think we can make it happen by designing the platform device in a way tha=
t=20
its name aligns with that of the driver. In such a scenario, when the drive=
r=20
is probed, the of_match_device function will return null. You can verify th=
is=20
functionality by reviewing the following function:

static int platform_match(struct device *dev, struct device_driver *drv)



