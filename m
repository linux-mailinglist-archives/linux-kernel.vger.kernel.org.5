Return-Path: <linux-kernel+bounces-78704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D81861799
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE0D2B27633
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB1B85265;
	Fri, 23 Feb 2024 16:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="exvmedkQ"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9196185621;
	Fri, 23 Feb 2024 16:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708705137; cv=none; b=j6Rq2C6VR48/ZC10xQPDgXaVExkbe+qEPmK+QsefgIpQUEQp/5CoCWR+mIpQ9+RMUHLZ2lI/P6NvFGmaHhKrfVmfdPpris5HTXBZjVbzUwPHmXCJNiF/Hjx+HLsHQy360vQbhwQRvnko4DxHPw+VCYDY/WlQ9WX4YCV5R9YWCi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708705137; c=relaxed/simple;
	bh=++mXl8XRdlMiuP7x+ZwsIwgEa6yDT7Cbhew/+Mc8OWE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W+dLOLJ8/6UgYar3Ncm88FzDjy4Nsf+o2OPxc2b9pX8ko729kU6dYQ+bCnzSiAVTR4iHPazsfM96v2DvaEgjzrPfmQRX21nAbyq5ERe7EdsFpro2YMoXJlJXrJgXaYI7JnBAlkUno4pnXy0nMN7xRpE0lnwzHppO3lnVGhygEVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=exvmedkQ; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 41DCE1C0005;
	Fri, 23 Feb 2024 16:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708705131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/CZ2rpvcJY7E+5kqVg1LQhZq2CIMjXGm23IGlzlbGMg=;
	b=exvmedkQOBmRFdZC1f4rAaALAYWzbog/CnWuEfrwfl079eTE3r9zzKBZ2kKp/AX4QcnDIC
	7jNvIjq4RFFjvXRBiWUc5CB5xS5NTYXhEgUVdxKCxtrHhYFcT19JQH4njjhLiwwFux8la0
	WmwjSNUos1AzN7jomxhfhz9iVb18FWtP/8YCYkL6NgSGYHPyFR2rb0Zk3og74RO6jTlF4H
	2T2lvj1X1VJNd8dXW+gfW4QSwUwaG+y4dKJnAlrXXJPT3tFTTRQtcB9KfMDuuROiJhQPms
	uHl4iuf03pTikRnQsV88LFDIPmucW12cxcSB/OoXjSgbtOGupJoqN6u3/Te9BA==
Date: Fri, 23 Feb 2024 17:18:49 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Saravana Kannan <saravanak@google.com>
Cc: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Xu Yang
 <xu.yang_2@nxp.com>, kernel-team@android.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Herv=C3=A9?= Codina
 <herve.codina@bootlin.com>
Subject: Re: [PATCH v2 2/3] of: property: Improve finding the supplier of a
 remote-endpoint property
Message-ID: <20240223171849.10f9901d@booty>
In-Reply-To: <20240207011803.2637531-3-saravanak@google.com>
References: <20240207011803.2637531-1-saravanak@google.com>
	<20240207011803.2637531-3-saravanak@google.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Saravana,

[+cc Herv=C3=A9 Codina]

On Tue,  6 Feb 2024 17:18:01 -0800
Saravana Kannan <saravanak@google.com> wrote:

> After commit 4a032827daa8 ("of: property: Simplify of_link_to_phandle()"),
> remote-endpoint properties created a fwnode link from the consumer device
> to the supplier endpoint. This is a tiny bit inefficient (not buggy) when
> trying to create device links or detecting cycles. So, improve this the
> same way we improved finding the consumer of a remote-endpoint property.
>=20
> Fixes: 4a032827daa8 ("of: property: Simplify of_link_to_phandle()")
> Signed-off-by: Saravana Kannan <saravanak@google.com>

After rebasing my own branch on v6.8-rc5 from v6.8-rc1 I started
getting unexpected warnings during device tree overlay removal. After a
somewhat painful bisection I identified this patch as the one that
triggers it all.

> ---
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1232,7 +1232,6 @@ DEFINE_SIMPLE_PROP(pinctrl5, "pinctrl-5", NULL)
>  DEFINE_SIMPLE_PROP(pinctrl6, "pinctrl-6", NULL)
>  DEFINE_SIMPLE_PROP(pinctrl7, "pinctrl-7", NULL)
>  DEFINE_SIMPLE_PROP(pinctrl8, "pinctrl-8", NULL)
> -DEFINE_SIMPLE_PROP(remote_endpoint, "remote-endpoint", NULL)
>  DEFINE_SIMPLE_PROP(pwms, "pwms", "#pwm-cells")
>  DEFINE_SIMPLE_PROP(resets, "resets", "#reset-cells")
>  DEFINE_SIMPLE_PROP(leds, "leds", NULL)
> @@ -1298,6 +1297,17 @@ static struct device_node *parse_interrupts(struct=
 device_node *np,
>  	return of_irq_parse_one(np, index, &sup_args) ? NULL : sup_args.np;
>  }
> =20
> +static struct device_node *parse_remote_endpoint(struct device_node *np,
> +						 const char *prop_name,
> +						 int index)
> +{
> +	/* Return NULL for index > 0 to signify end of remote-endpoints. */
> +	if (!index || strcmp(prop_name, "remote-endpoint"))

There seem to be a bug here: "!index" should be "index > 0", as the
comment suggests. Otherwise NULL is always returned.

I am going to send a quick patch for that, but haven't done so yet
because it still won't solve the problem, so I wanted to open the topic
here without further delay.

Even with the 'index > 0' fix I'm still getting pretty much the same:

[   34.836781] ------------[ cut here ]------------
[   34.841401] WARNING: CPU: 2 PID: 204 at drivers/base/devres.c:1064 devm_=
kfree+0x8c/0xfc
..
[   35.024751] Call trace:
[   35.027199]  devm_kfree+0x8c/0xfc
[   35.030520]  devm_drm_panel_bridge_release+0x54/0x64 [drm_kms_helper]
[   35.036990]  devres_release_group+0xe0/0x164
[   35.041264]  i2c_device_remove+0x38/0x9c
[   35.045196]  device_remove+0x4c/0x80
[   35.048774]  device_release_driver_internal+0x1d4/0x230
[   35.054003]  device_release_driver+0x18/0x24
[   35.058279]  bus_remove_device+0xcc/0x10c
[   35.062292]  device_del+0x15c/0x41c
[   35.065786]  device_unregister+0x18/0x34
[   35.069714]  i2c_unregister_device+0x54/0x88
[   35.073988]  of_i2c_notify+0x98/0x224
[   35.077656]  blocking_notifier_call_chain+0x6c/0xa0
[   35.082543]  __of_changeset_entry_notify+0x100/0x16c
[   35.087515]  __of_changeset_revert_notify+0x44/0x78
[   35.092398]  of_overlay_remove+0x114/0x1c4
..

By comparing the two versions I found that before removing the overlay:

 * in the "working" case (with this patch reverted) I have:

   # ls /sys/class/devlink/ | grep 002c
   platform:hpbr--i2c:13-002c
   platform:panel-dsi-lvds--i2c:13-002c
   platform:regulator-sys-1v8--i2c:13-002c
   regulator:regulator.31--i2c:13-002c
   #

 * in the "broken" case (v6.8-rc5 + s/!index/index > 0/ as mentioned):

   # ls /sys/class/devlink/ | grep 002c
   platform:hpbr--i2c:13-002c
   platform:regulator-sys-1v8--i2c:13-002c
   regulator:regulator.30--i2c:13-002c
   #=20

So in the latter case the panel-dsi-lvds--i2c:13-002c link is missing.
I think it gets created but later on removed. Here's a snippet of the
kernel log when that happens:

[    9.578279] ----- cycle: start -----
[    9.578283] /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvds-br=
idge@2c: cycle: depends on /panel-dsi-lvds
[    9.578308] /panel-dsi-lvds: cycle: depends on /soc@0/bus@30800000/i2c@3=
0ad0000/i2cmux@70/i2c@3/dsi-lvds-bridge@2c
[    9.578329] ----- cycle: end -----
[    9.578334] platform panel-dsi-lvds: Fixed dependency cycle(s) with /soc=
@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvds-bridge@2c
..
[    9.590620] /panel-dsi-lvds Dropping the fwnode link to /soc@0/bus@30800=
000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvds-bridge@2c
..
[    9.597280] ----- cycle: start -----
[    9.597283] /panel-dsi-lvds: cycle: depends on /soc@0/bus@30800000/i2c@3=
0ad0000/i2cmux@70/i2c@3/dsi-lvds-bridge@2c
[    9.602781] /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvds-br=
idge@2c: cycle: depends on /panel-dsi-lvds
[    9.607581] ----- cycle: end -----
[    9.607585] i2c 13-002c: Fixed dependency cycle(s) with /panel-dsi-lvds
[    9.614217] device: 'platform:panel-dsi-lvds--i2c:13-002c': device_add
..
[    9.614277] /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvds-br=
idge@2c Dropping the fwnode link to /panel-dsi-lvds
[    9.614369] /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvds-br=
idge@2c Dropping the fwnode link to /regulator-dock-sys-1v8
..
[    9.739840] panel-simple panel-dsi-lvds: Dropping the link to 13-002c
[    9.739846] device: 'i2c:13-002c--platform:panel-dsi-lvds': device_unreg=
ister
[   10.247037] sn65dsi83 13-002c: Dropping the link to panel-dsi-lvds
[   10.247049] device: 'platform:panel-dsi-lvds--i2c:13-002c': device_unreg=
ister

And here's the relevant portion of my device tree overlay:

--------------------8<--------------------

/dts-v1/;
/plugin/;

&{/}
{
        panel_dsi_lvds: panel-dsi-lvds {
                compatible =3D "auo,g133han01.1";

                ports {
                        #address-cells =3D <1>;
                        #size-cells =3D <0>;
                        port@0{
                                reg =3D <0>;
                                dual-lvds-odd-pixels;
                                panel_dsi_lvds_in0: endpoint {
                                        remote-endpoint =3D <&sn65dsi84_out=
0>;
                                };
                        };

                        port@1{
                                reg =3D <1>;
                                dual-lvds-even-pixels;
                                panel_dsi_lvds_in1: endpoint {
                                        remote-endpoint =3D <&sn65dsi84_out=
1>;
                                };
                        };
                };
        };
};

&i2c5_ch3 {
        dsi-lvds-bridge@2c {
                compatible =3D "ti,sn65dsi84";
                reg =3D <0x2c>;
                vcc-supply =3D <&reg_sys_1v8>;

                ports {
                        #address-cells =3D <1>;
                        #size-cells =3D <0>;

                        port@0 {
                                reg =3D <0>;

                                sn65dsi84_from_bridge: endpoint {
                                        remote-endpoint =3D <&hpbr_source>;
                                        data-lanes =3D <1 2 3 4>;
                                };
                        };
                        port@2 {
                                reg =3D <2>;

                                sn65dsi84_out0: endpoint {
                                        remote-endpoint =3D <&panel_dsi_lvd=
s_in0>;
                                };
                        };
                        port@3 {
                                reg =3D <3>;

                                sn65dsi84_out1: endpoint {
                                        remote-endpoint =3D <&panel_dsi_lvd=
s_in1>;
                                };
                        };
                };
        };
};

--------------------8<--------------------

That's all I could get at this point. Any clues for further
investigation?

Best regards,
Luca

--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

