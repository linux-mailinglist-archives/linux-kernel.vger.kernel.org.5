Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5847DB786
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbjJ3KNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjJ3KNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:13:31 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE718A65;
        Mon, 30 Oct 2023 03:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1698660805; x=1698920005;
        bh=Ey+j0LkYX/UsuXLnIpNM5dQ9Vc1LXDjcfC0+Sal7iBY=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=WlcMGzHki0qsh6euirMQE3hJ8TX3kAWl0Ok2q6h7NdK7dHLP1XAlBPzjD3ctwsVx6
         uUsLHFPcY0xDb9jYY5e0c7qWQjLKPKcOsAIu2T8/+Fzl97UPBEM3dFTY4PGRgFAzpA
         OE/KaG4Jd7Aa5h1HinO0n2VW+EhZEizaxeYJo84of1HHk62NMy6g3xeQS3mpyA8Qho
         2hlqcXTyZb3nqGs+BOsHGdYedSUfZSpf4zArBC5OPywUE8zBhHIlVsC+sv05saBaql
         xljs0oaWY5O4fft4YrpKu+88e9jWuVrjR9bS1tFeZ/4BzZU/8miBXxaJNMJFooMxaU
         vNvALWYsY1VvQ==
Date:   Mon, 30 Oct 2023 10:13:13 +0000
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
From:   Simon Ser <contact@emersion.fr>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Janne Grunau <j@jannau.net>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        freedreno@lists.freedesktop.org
Subject: Re: [RFC PATCH v1 12/12] usb: typec: qcom: define the bridge's path
Message-ID: <B8P9onfq9cXaSM_GbX3N_PSdo19FY_donmDWeAwLGlrrRvclqNcOA2LCGBnVYuJtAlJJFanedJL6GygtJHDS6WP5twzb-L7VJYnmqyFXZtk=@emersion.fr>
In-Reply-To: <CAA8EJprgpfh_GOeV+557YHWUJC-9W1Tw7nzb0jy5mPAv35VuGA@mail.gmail.com>
References: <20230903214150.2877023-1-dmitry.baryshkov@linaro.org> <20230903214150.2877023-13-dmitry.baryshkov@linaro.org> <ZQRKq7K8jKlH/Y4X@kuha.fi.intel.com> <0F1BE090-92C4-4233-A77A-9B4C653DA1A7@linaro.org> <ZT9m/OoFUiZaWy9s@kuha.fi.intel.com> <CAA8EJprgpfh_GOeV+557YHWUJC-9W1Tw7nzb0jy5mPAv35VuGA@mail.gmail.com>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, October 30th, 2023 at 10:47, Dmitry Baryshkov <dmitry.baryshkov@=
linaro.org> wrote:

> On Mon, 30 Oct 2023 at 10:19, Heikki Krogerus
> heikki.krogerus@linux.intel.com wrote:
>=20
> > On Mon, Oct 23, 2023 at 09:24:33PM +0300, Dmitry Baryshkov wrote:
> >=20
> > > On 15 September 2023 15:14:35 EEST, Heikki Krogerus heikki.krogerus@l=
inux.intel.com wrote:
> > >=20
> > > > Hi Dmitry,
> > > >=20
> > > > On Mon, Sep 04, 2023 at 12:41:50AM +0300, Dmitry Baryshkov wrote:
> > > >=20
> > > > > In order to notify the userspace about the DRM connector's USB-C =
port,
> > > > > export the corresponding port's name as the bridge's path field.
> > > > >=20
> > > > > Signed-off-by: Dmitry Baryshkov dmitry.baryshkov@linaro.org
> > > > > ---
> > > > > drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c | 11 +++++++----
> > > > > drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_drm.c | 4 +++-
> > > > > drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_drm.h | 6 ++++--
> > > > > 3 files changed, 14 insertions(+), 7 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c b/driv=
ers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> > > > > index b9d4856101c7..452dc6437861 100644
> > > > > --- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> > > > > +++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> > > > > @@ -156,6 +156,7 @@ static int qcom_pmic_typec_probe(struct platf=
orm_device *pdev)
> > > > > struct device_node *np =3D dev->of_node;
> > > > > const struct pmic_typec_resources *res;
> > > > > struct regmap *regmap;
> > > > > + char *tcpm_name;
> > > > > u32 base[2];
> > > > > int ret;
> > > > >=20
> > > > > @@ -211,10 +212,6 @@ static int qcom_pmic_typec_probe(struct plat=
form_device *pdev)
> > > > > mutex_init(&tcpm->lock);
> > > > > platform_set_drvdata(pdev, tcpm);
> > > > >=20
> > > > > - tcpm->pmic_typec_drm =3D qcom_pmic_typec_init_drm(dev);
> > > > > - if (IS_ERR(tcpm->pmic_typec_drm))
> > > > > - return PTR_ERR(tcpm->pmic_typec_drm);
> > > > > -
> > > > > tcpm->tcpc.fwnode =3D device_get_named_child_node(tcpm->dev, "con=
nector");
> > > > > if (!tcpm->tcpc.fwnode)
> > > > > return -EINVAL;
> > > > > @@ -225,6 +222,12 @@ static int qcom_pmic_typec_probe(struct plat=
form_device *pdev)
> > > > > goto fwnode_remove;
> > > > > }
> > > > >=20
> > > > > + tcpm_name =3D tcpm_port_get_name(tcpm->tcpm_port);
> > > > > + tcpm->pmic_typec_drm =3D qcom_pmic_typec_init_drm(dev, tcpm_nam=
e);
> > > >=20
> > > > So I got some questions and concerns off-list. This was one of the
> > > > concerns. That tcpm_name is now the actual port device name, so I'm
> > > > afraid this is not acceptable.
> > > >=20
> > > > You can't use device name as a reference, ever. There is no way to
> > > > guarantee that a device with a specific name is what you meant it t=
o
> > > > be by the time it's accessed.
> > >=20
> > > Hmm, could you please be more specific, why? I mean, class devices ar=
e not
> > > that easy to be renamed in sysfs, are they? Or are you concerned abou=
t the
> > > device being destroyed behind userspace's back? At least for MSM this=
 will be
> > > a huge problem already, with the bridge driver suddenly being removed=
.
> >=20
> > The race exists even in your case, but please do not look at this as a
> > solution for only your platform.
>=20
> Yes!
>=20
> > This is about showing the user space a link between two device
> > instances (struct device), and the way you do that is by creating a
> > symlink. That way the kernel can take care of reference counting and
> > guarantee that the link always points to the correct device. That way
> > the link will also be always visible in user space without requirement
> > for any specific ABI like it should.
>=20
> I'm fine with the symlink approach (and I'll follow that up after
> finishing the UCSI glue driver rework). However I feel several
> deficiencies there:
>=20
> 1) It creates asymmetry with the DP MST case. Do we want to have
> symlinks in each of the MST connectors? Or do we follow the PATH
> properties in the MST case until we find the root port, which has
> symlink? Please note, that fine X11 renames DP MST connectors
> internally, so in xrandr I see DP-2-1, which maps to
> /sys/class/drm/card0-DP-2. Kind of hard to follow.
>=20
> 2) For the multi-card cases, one has to remap the connector to the
> card index + connector path. And this needs to be done by all user
> space applications, which would like to present this kind of
> information for the user.
>=20
> 3) If we were to support non-USB-C connectors (e.g. MyDP / SlimPort
> and MHL used simple micro-USB connectors) there would be a completely
> new uABI. And any external port / wrapper will also require a
> completely new symlink kind.
>=20
> I understand your concerns regarding mentioning external device in the
> PATH property. However I think we should make it easier for the
> userspace app to determine the kind of the external connector. What
> would you think about extending the PATH property in the following
> way:
>=20
> For the USB-C connectors the PATH property has the value of
> `typec:cardN-DP-m` value. Userspace app can then look for the
> typec_connector symlink at the /sys/class/drm/cardN-DP-m subdir to
> find the information about the corresponding USB-C port.

This doesn't make sense to me. "cardN-DP-m" has nothing to do with the
physical path of the connector. All of the parts of this string are
exposed elsewhere in the KMS uAPI already.

> In future this will allow us to define e.g.:
>=20
> For the SlimPort / MyDP the PATH property has the value of
> `micro_usb:cardN-HDMI-m` or `micro_usb:cardN-DP-m`. The symlink is
> called /sys/class/drm/cardN-DP-m/micro_usb_connector.
>=20
> Or:
>=20
> For the SlimPort / MyDP the PATH property has the value of
> `mydp:cardN-HDMI-m` or `mydp:cardN-DP-m`. The symlink is called
> /sys/class/drm/cardN-DP-m/mydp_connector.
>=20
>=20
> --
> With best wishes
> Dmitry
