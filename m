Return-Path: <linux-kernel+bounces-5539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A686818BEB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C848B1C24362
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0411D546;
	Tue, 19 Dec 2023 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fswlRv4f"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36031D521;
	Tue, 19 Dec 2023 16:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cc7087c6c4so30785571fa.2;
        Tue, 19 Dec 2023 08:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703002439; x=1703607239; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nhC+jwAGmxb7UhLBDy8MfACwzSGilMtSLYNhHLjh8O4=;
        b=fswlRv4f/sVvELlV7atREu9r2bFx0FMCYSymIn++Uj2OP7YmMDurKZDbZqGX4vB9FG
         UfOO9NvN+ZrkZo9paP8JANTESWlgNRBOM/yYkaUOI/Yzg0V553+P4RKbm9PRCDP5SBiU
         680uH3c5kHo83E1Kb84BOBjbwrAYozMazG7rbrR1PfM5MtQ4wpsW3KEf08nYhkJR6Bje
         /Y3z/Gfpse/aUd39PZmUE5W62ziIbktf2jYhln0cfiUjdolJGnw3tFSGbLLoiRUmsFgR
         /mwcFs+SA7xnf75SrX+1oBq9QQScxOnAJBoX/VSIqMsXbHzORqFzqiSga//fdtxbFN9R
         AwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703002439; x=1703607239;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nhC+jwAGmxb7UhLBDy8MfACwzSGilMtSLYNhHLjh8O4=;
        b=BvUMSoOuSEsKDRpLZMzFFJu2xlWL8ObBk3GB/0uR1Ucu3uh5B7kMZUlKmLcyePT89S
         VPccJxHJGGGUmobHZNIbWgJfYVlrIsmh0v46m+y0P4HBxB0x9gvgpGrmaTt2tv6F05wX
         SfTc20mc6Ts0fxH3RpWNiOo4Z8MGEw/t/z/8H9wzl+b8s4TkM7PLeY7cYwqnAduKbAb/
         vBYTOfOyWVuBUEjDmnm2EyGGgrk82fZEHEz7xKmQZGMMjswL1B4fLv5Sog8HVjKO+Mai
         /3XP+h/TzBXu1ugPpYT79gXl5QyD6ISC/R5JibdP+oc9gCnsNHfNbat+V4vQap23NNpQ
         ALXA==
X-Gm-Message-State: AOJu0Yxdpye0/7bky5XXn2T/PgL2bpafdYaeks7V2SRRHgmHbkf2N7Vi
	aLq1BgAYGexslfhpKztpIMU=
X-Google-Smtp-Source: AGHT+IGOOjAK3kB+cHNakSASi4koC1XDnNRRN4wt5V9CO95YFMEVFKof7hmcPy+wwgY7aRxLwgELVw==
X-Received: by 2002:a2e:be84:0:b0:2cb:f3f2:76a2 with SMTP id a4-20020a2ebe84000000b002cbf3f276a2mr7833558ljr.27.1703002439373;
        Tue, 19 Dec 2023 08:13:59 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id h10-20020a05651c114a00b002cc779741c6sm607469ljo.65.2023.12.19.08.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 08:13:58 -0800 (PST)
Date: Tue, 19 Dec 2023 19:13:55 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Jiangfeng Ma <Jiangfeng.Ma@synopsys.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <Jose.Abreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Simon Horman <horms@kernel.org>, 
	Andrew Halaney <ahalaney@redhat.com>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Johannes Zink <j.zink@pengutronix.de>, 
	"Russell King (Oracle" <rmk+kernel@armlinux.org.uk>, Jochen Henneberg <jh@henneberg-systemdesign.com>, 
	"open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>, 
	"moderated  list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>, 
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, 
	James Li <James.Li1@synopsys.com>, Martin McKenny <Martin.McKenny@synopsys.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0g=?= =?utf-8?Q?=5D?=
 net:stmmac:stmmac_platform:Add snps,xpcs devicetree parsing
Message-ID: <iot4xazx5w5ckx77emdz2pcqds573wvnnegtw2rznk6ezrix2m@quhutbzqmtav>
References: <SA0PR12MB44138E48A245378CF54D2F9ED98AA@SA0PR12MB4413.namprd12.prod.outlook.com>
 <20231208091408.071680db@device.home>
 <uzss3af2cklc5bx5apszoegafeaaiv7o7iwgrgrml4grkyev6p@6tme4hdb4mkn>
 <SA0PR12MB4413305305D47CAAAFEAD528D98EA@SA0PR12MB4413.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SA0PR12MB4413305305D47CAAAFEAD528D98EA@SA0PR12MB4413.namprd12.prod.outlook.com>

On Tue, Dec 12, 2023 at 10:50:53AM +0000, Jiangfeng Ma wrote:
> 
> 
> > -----邮件原件-----
> > 发件人: Serge Semin <fancer.lancer@gmail.com>
> > 发送时间: Friday, December 8, 2023 10:28 PM
> > 收件人: Maxime Chevallier <maxime.chevallier@bootlin.com>; Jiangfeng Ma <jiama@synopsys.com>
> > 抄送: Jiangfeng Ma <jiama@synopsys.com>; Alexandre Torgue <alexandre.torgue@foss.st.com>; Jose
> > Abreu <joabreu@synopsys.com>; David S. Miller <davem@davemloft.net>; Eric Dumazet
> > <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> > Maxime Coquelin <mcoquelin.stm32@gmail.com>; Simon Horman <horms@kernel.org>; Andrew
> > Halaney <ahalaney@redhat.com>; Bartosz Golaszewski <bartosz.golaszewski@linaro.org>; Shenwei
> > Wang <shenwei.wang@nxp.com>; Johannes Zink <j.zink@pengutronix.de>; Russell King (Oracle
> > <rmk+kernel@armlinux.org.uk>; Jochen Henneberg <jh@henneberg-systemdesign.com>; open
> > list:STMMAC ETHERNET DRIVER <netdev@vger.kernel.org>; moderated list:ARM/STM32
> > ARCHITECTURE <linux-stm32@st-md-mailman.stormreply.com>; moderated list:ARM/STM32
> > ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; open list <linux-kernel@vger.kernel.org>; James
> > Li <lijames@synopsys.com>; Martin McKenny <mmckenny@synopsys.com>
> > 主题: Re: [PATCH] net:stmmac:stmmac_platform:Add snps,xpcs devicetree parsing
> > 
> Hi Maxime, Serge
> Thanks for your review!
> 
> > Hi Maxime, Jiangfeng
> > 
> > On Fri, Dec 08, 2023 at 09:14:08AM +0100, Maxime Chevallier wrote:
> > > Hello,
> > >
> > > On Fri, 8 Dec 2023 07:02:19 +0000
> > > Jiangfeng Ma <Jiangfeng.Ma@synopsys.com> wrote:
> > >
> > > > In order to setup xpcs, has_xpcs must be set to a non-zero value.
> > > > Add new optional devicetree properties representing this.
> > > >
> > > > If has_xpcs is set to true, then xpcs_an_inband should preferably be
> > > > consistent with it, Otherwise, some errors may occur when starting
> > > > the network, For example, the phy interface that xpcs already supports,
> > > > but link up fails.
> > >
> > > Can you elaborate on why you need this, and on which platform
> > > especially ? Usually drivers for the various stmmac variants know if
> > > they have XPCS or not, or can guess it based on some info such as the
> > > configured PHY mode (dwmac-intel).
> 
> There is no specific platform here. I utilize the dwmcac-generic platform,
> and xpcs is utilized as the MDIO device or it can be seen as a C45 PHY.
> While it's sometimes possible to deduce the presence of xpcs based on information
> such as the phy mode (dwmac-intel), this is not always a definitive indicator.
> For instance, the support of SGMII by XPCS doesn't imply
> that all SGMII-supporting PHYs include XPCS. But as Serge mentioned, using pcs-handle,
> or pcs-handle-name might be a more effective approach.
> > >
> > > Besides that, there are a few issues with your submission. If DT is the
> > > way to go (and I don't say it is), you would also need to update the
> > > bindings to document that property.
> > >
> > > > The types of has_xpcs and xpcs_an_inband are unsigned int,
> > > > and generally used as flags. So it may be more reasonable to set them to
> > > > bool type. This can also be confirmed from the type of @ovr_an_inband.
> > >
> > > And this part would go into a separate patch.
> Sorry for this issue, I will create the patch separately later.
> > 
> > In addition to what Maxime already said having DT-bindings adjusted to
> > fit to the pattern implemented in the software part is a wrong way to
> > go. The best choice in this case is to add the DW XPCS DT-node to the
> > DW MAC MDIO/MI bus and then use the "pcs-handle" to inform the MAC
> > (mainly it's driver) of what PCS-device is actually attached to it.
> > The series I submitted on this week is exactly about that:
> > https://urldefense.com/v3/__https://lore.kernel.org/netdev/20231205103559.9605-1-fancer.lancer@g
> > mail.com/__;!!A4F2R9G_pg!Y6R3WZWHeBdrkZklbqrAQARbHnQ-g_Tbb6r5IqcsSHMQ_l4rOzLLgZvLPl6YP
> > BYferbjrbjZA6_XvSSSvkV35eo2jWPz$
> > I guess I'll need about a month or so to settle all the comments, but
> > the solution implemented there will be better than this one really.
> >

> Yes, I agree that binding the xpcs via the "pcs-handle" DT firmware node 
> is a better way. but the current method of binding xpcs through scanning 
> addresses still relies on mdio_bus_data->has_xpcs.

It doesn't matter on what the code relies. What matters is to
correctly describe the hardware. Adding the 'snps,xpcs' property would
just be a workround so to make things working because the driver was
designed that way.

> The 16th patch in your patchset also mentions the difficulty of 
> obtaining has_xpcs. Therefore, can we add parsing of pcs-handle-names 
> in the platform to determine if the xpcs exists, like this:
> 
> if (plat->mdio_bus_data) {
> 	rc = of_property_match_string(np, "pcs-handle-names", "dw-xpcs");
> 	if (rc >= 0) {
> 		plat->mdio_bus_data->has_xpcs = true;
> 		plat->mdio_bus_data->xpcs_an_inband = true;
> 	}
> }

It won't make sense. 'pcs-handle' would already point out to the
MDIO-device. Since it's doubtfully there is DW XGMAC connected to more
than one PCS device, then there is no need in the named handle
property. Moreover your way of bindings violates bindings rule that
the 'pcs-handle-names' array should always be specified together with
the phandles array:
Documentation/devicetree/bindings/net/ethernet-controller.yaml

Please be patient. After my patchset is merged in, the only thing what
you would need is to do something like this:

xgmac: ethernet@1f054000 {
	compatible = "snps,dwxgmac";
	reg = <0 0x1f054000 0 0x4000>;

	...

	pcs-handle = <&xgmac_pcs>;

	xgmac_mdio: mdio {
		compatible = "snps,dwmac-mdio";
		#address-cells = <1>;
		#size-cells = <0>;

		xgmac_pcs: ethernet-pcs@0 {
			compatible = "snps,dw-xpcs";
			reg = <0>;
		};
	};
};

If no XPCS available, just omit the 'pcs-handle' property and the
respective MDIO-bus sub-node.

-Serge(y)

> 
> Thanks,
> Jiangfeng
> 
> > -Serge(y)
> > 
> > >
> > > Thanks,
> > >
> > > Maxime
> > >

