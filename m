Return-Path: <linux-kernel+bounces-153704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 157758AD1DF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFE6A28149C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC2D153824;
	Mon, 22 Apr 2024 16:24:42 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF783153582;
	Mon, 22 Apr 2024 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713803081; cv=none; b=N/9gs/We4RPQpctka2EUXsMMDVkUKhbTSj3BAZG/luiBNpY/6d9Dg3A5eeGRyEy5XtJXHEQcEs13x0pW8lfX3+VK4QF32akINNmi12GwwQH8hUPvtGebn2hJhrrgA193377tcmBlLQE3oGpLQnJSXBvwyhPY8RWrwCzlYYSr1Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713803081; c=relaxed/simple;
	bh=HaD9uj6RJr8FOK2IkqY5S9vAt19PWx2ZyaWNJGKWrQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXFYVXykcQJ/oknOXAzkb2prp6mgIkzBhGl84EGYgcSM1NmOQH9RUh6CJgukTaEvIYOjHAq6ufSUAG5Y3wb7hS7DTpsDb/v2xD2TdlkTxboC/MlbGSNd9Qph0TzyqnU71SUUHu4zUJH6I0WppQeZlmdQaTdOXKPEm6I23LTSmVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1rywSZ-000000003hF-3pRt;
	Mon, 22 Apr 2024 16:24:04 +0000
Date: Mon, 22 Apr 2024 17:23:57 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexander Couzens <lynxis@fe80.eu>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org
Subject: Re: [RFC PATCH net-next v3 3/8] net: pcs: pcs-mtk-lynxi: add
 platform driver for MT7988
Message-ID: <ZiaPHWXU-82QMrMt@makrotopia.org>
References: <cover.1702352117.git.daniel@makrotopia.org>
 <8aa905080bdb6760875d62cb3b2b41258837f80e.1702352117.git.daniel@makrotopia.org>
 <ZXnV/Pk1PYxAm/jS@shell.armlinux.org.uk>
 <ZcLc7vJ4fPmRyuxn@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcLc7vJ4fPmRyuxn@makrotopia.org>

Hi Russell,
Hi netdev crew,

I haven't received any reply for this email and am still waiting for
clarification regarding how inter-driver dependencies should be modelled
in that case of mtk_eth_soc. My search for good examples for that in the
kernel code was quite frustrating and all I've found are supposedly bugs
of that exact cathegory.

Please see my questions mentioned in the previous email I've sent and
also a summary of suggested solutions inline below:

On Wed, Feb 07, 2024 at 01:29:18AM +0000, Daniel Golle wrote:
> Hi Russell,
> 
> sorry for the extended time it took me to get back to this patch and
> the comments you made for it. Understanding the complete scope of the
> problem took a while (plus there were holidays and other fun things),
> and also brought up further questions which I hope you can help me
> find good answers for, see below:
> 
> On Wed, Dec 13, 2023 at 04:04:12PM +0000, Russell King (Oracle) wrote:
> > On Tue, Dec 12, 2023 at 03:47:18AM +0000, Daniel Golle wrote:
> > > Introduce a proper platform MFD driver for the LynxI (H)SGMII PCS which
> > > is going to initially be used for the MT7988 SoC.
> > > 
> > > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > 
> > I made some specific suggestions about what I wanted to see for
> > "getting" PCS in the previous review, and I'm disappointed that this
> > patch set is still inventing its own solution.
> > 
> > > +struct phylink_pcs *mtk_pcs_lynxi_get(struct device *dev, struct device_node *np)
> > > +{
> > > +	struct platform_device *pdev;
> > > +	struct mtk_pcs_lynxi *mpcs;
> > > +
> > > +	if (!np)
> > > +		return NULL;
> > > +
> > > +	if (!of_device_is_available(np))
> > > +		return ERR_PTR(-ENODEV);
> > > +
> > > +	if (!of_match_node(mtk_pcs_lynxi_of_match, np))
> > > +		return ERR_PTR(-EINVAL);
> > > +
> > > +	pdev = of_find_device_by_node(np);
> > > +	if (!pdev || !platform_get_drvdata(pdev)) {
> > 
> > This is racy - as I thought I described before, userspace can unbind
> > the device in one thread, while another thread is calling this
> > function. With just the right timing, this check succeeds, but...
> > 
> > > +		if (pdev)
> > > +			put_device(&pdev->dev);
> > > +		return ERR_PTR(-EPROBE_DEFER);
> > > +	}
> > > +
> > > +	mpcs = platform_get_drvdata(pdev);
> > 
> > mpcs ends up being read as NULL here. Even if you did manage to get a
> > valid pointer, "mpcs" being devm-alloced could be freed from under
> > you at this point...
> > 
> > > +	device_link_add(dev, mpcs->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
> > 
> > resulting in this accessing memory which has been freed.
> > 
> > The solution would be either to suppress the bind/unbind attributes
> > (provided the underlying struct device can't go away, which probably
> > also means ensuring the same of the MDIO bus. Aternatively, adding
> > a lock around the remove path and around the checking of
> > platform_get_drvdata() down to adding the device link would probably
> > solve it.
> > 
> > However, I come back to my general point - this kind of stuff is
> > hairy. Do we want N different implementations of it in various drivers
> > with subtle bugs, or do we want _one_ implemenatation.
> > 
> > If we go with the one implemenation approach, then we need to think
> > about whether we should be using device links or not. The problem
> > could be for network interfaces where one struct device is
> > associated with multiple network interfaces. Using device links has
> > the unfortunate side effect that if the PCS for one of those network
> > interfaces is removed, _all_ network interfaces disappear.
> 
> I agree, esp. on this MT7988 removal of a PCS which may then not
> even be in use also impairs connectivity on the built-in gigE DSA
> switch. It would be nice to try to avoid this.
> 
> > 
> > My original suggestion was to hook into phylink to cause that to
> > take the link down when an in-use PCS gets removed.
> 
> I took a deep dive into how this could be done correctly and how
> similar things are done for other drivers. Apart from the PCS there
> often also is a muxing-PHY involved, eg. MediaTek's XFI T-PHY in this
> case (previously often called "pextp" for no apparent reason) or
> Marvell's comphy (mvebu-comphy).
> 
> So let's try something simple on an already well-supported platform,
> I thought and grabbed Marvell Armada CN9131-DB running vanilla Linux,
> and it didn't even take some something racy, but plain:
> 
> ip link set eth6 up
> cd /sys/bus/platform/drivers/mvebu-comphy
> echo f2120000.phy > unbind
> echo f4120000.phy > unbind
> echo f6120000.phy > unbind
> ip link set eth6 down
> 
> 
> That was enough. The result is a kernel crash, and the same should
> apply on popular platforms like the SolidRun MACCHIATOBin and other
> similar boards.
> 
> So this gets me to think that there is a wider problem around
> non-phylink-managed resources which may disappear while in use by
> network drivers, and I guess that the same applies in many other
> places. I don't have a SATA drive connected to that Marvell board, but
> I can imagine what happens when suddenly removing the comphy instance
> in charge of the SATA link and then a subsequent SATA hotplug event
> happens or stuff like that...
> 
> Anyway, back to network subsystem and phylink:
> 
> Do you agree that we need a way to register (and unregister) PCS
> providers with phylink, so we don't need *_get_by_of_node implementations
> in each driver? If so, can you sketch out what the basic requirements
> for an acceptable solution would be?
> 
> Also, do you agree that lack of handling of disappearing resources,
> such as PHYs (*not* network PHYs, but PHYs as in drivers/phy/*) or
> syscons, is already a problem right now which should be addressed?
> 
> If you imagine phylink to take care of the life-cycle of all link-
> resources, what is vision about those things other than classic MDIO-
> connected PHYs?
> 
> And well, of course, the easy fix for the example above would be:
> diff --git a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
> index b0dd133665986..9517c96319595 100644
> --- a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
> +++ b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
> @@ -1099,6 +1099,7 @@ static const struct of_device_id mvebu_comphy_of_match_table[] = {
>  MODULE_DEVICE_TABLE(of, mvebu_comphy_of_match_table);
>  
>  static struct platform_driver mvebu_comphy_driver = {
> +	.suppress_bind_attrs = true,
>  	.probe	= mvebu_comphy_probe,
>  	.driver	= {
>  		.name = "mvebu-comphy",
> 
> But that should then apply to every single driver in drivers/phy/...
> 

My remaining questions are:
 - Is it ok to just use .suppress_bind_attrs = true for PCS and PHY
   drivers to avoid having to care out hot-removal?
   Those components are anyway built-into the SoC so removing them
   is physically not possible.

 - In case of driver removal (rmmod -f) imho using a device-link would
   be sufficient to prevent the worst. However, we would have to live
   with the all-or-nothing nature of that approach, ie. once e.g. the
   USXGMII driver is being removed, *all* Ethernet interfaces would
   disappear with it (even those not actually using USXGMII).

If the solutions mentioned above do not sound agreeable, please suggest
how a good solution would look like, ideally also share an example of
any driver in the kernel where this is done in the way you would like
to have things done.

> 
> > 
> > > +
> > > +	return &mpcs->pcs;
> > > +}
> > > +EXPORT_SYMBOL(mtk_pcs_lynxi_get);
> > > +
> > > +void mtk_pcs_lynxi_put(struct phylink_pcs *pcs)
> > > +{
> > > +	struct mtk_pcs_lynxi *cur, *mpcs = NULL;
> > > +
> > > +	if (!pcs)
> > > +		return;
> > > +
> > > +	mutex_lock(&instance_mutex);
> > > +	list_for_each_entry(cur, &mtk_pcs_lynxi_instances, node)
> > > +		if (pcs == &cur->pcs) {
> > > +			mpcs = cur;
> > > +			break;
> > > +		}
> > > +	mutex_unlock(&instance_mutex);
> > 
> > I don't see what this loop gains us, other than checking that the "pcs"
> > is still on the list and hasn't already been removed. If that is all
> > that this is about, then I would suggest:
> > 
> > 	bool found = false;
> > 
> > 	if (!pcs)
> > 		return;
> > 
> > 	mpcs = pcs_to_mtk_pcs_lynxi(pcs);
> > 	mutex_lock(&instance_mutex);
> > 	list_for_each_entry(cur, &mtk_pcs_lynxi_instances, node)
> > 		if (cur == mpcs) {
> > 			found = true;
> > 			break;
> > 		}
> > 	mutex_unlock(&instance_mutex);
> > 
> > 	if (WARN_ON(!found))
> > 		return;
> > 
> > which makes it more obvious why this exists.
> 
> The idea was not only to make sure it hasn't been removed, but also
> to be sure that what ever the private data pointer points to has
> actually been created by that very driver.
> 
> But yes, doing it in the way you suggest will work in the same way,
> just when having my idea in mind it looks more fishy to use
> pcs_to_mtk_pcs_lynxi() before we are 100% sure that what we dealing
> with has previously been created by this driver.
> 
> 
> Cheers
> 
> 
> Daniel
> 

