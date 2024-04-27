Return-Path: <linux-kernel+bounces-161053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9389B8B4677
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 15:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F97E286060
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 13:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6674F208;
	Sat, 27 Apr 2024 13:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="E8SC4q7c"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040A151C3E;
	Sat, 27 Apr 2024 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714224717; cv=none; b=qNGN3IcTPHYJJ3NaV8VYnRgboeMkW9wWpE/mHhcMziM42zDdbEAb9ZDagMbd/g2zU1Wh9ln+6goLa+96OHO/2wsn7W66S2UdtpMJ5O0JhIs9WjwmfBB65t4n8qE77LlHWHS/nVxgySSRD0+zk716FxqURSwT+G8ssPEYM2OFvfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714224717; c=relaxed/simple;
	bh=RKP4Wmy3tUWyN3fPHYMmPu0SgDcWMjuRKXN0JXL0BN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKrJekJWf4UfXuxY/cuzEtIQuzVZnMXQHZsp7ZAfPr++vLOulgI9wYJ6vNL2jmCAboxL433N8hVSZVkvYMJNzR9NI5ErrRIGdBLp4+OxVZqT3m6geLZYTl3cr1mfj3UUYGy6GdJqlBBSqWaY5on50o6aD/cJFiU1khbVnpzMGz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=E8SC4q7c; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=uLjmIxWBZXYFaJoEDrFA76LxUvZ8/QKRwm9su8En8/U=; b=E8
	SC4q7cnxZuKZPZHU2E87r6vMH+XWnFfdlKPoMLVhloayciK5L8OphMvdgMQkONjPXJFapa2sdqeMj
	Yod6kuuzZs4XDpfSqd4rh66ERJmW9TeHL6tH6OIZVBNjs6kTjD9U/1J2/QG26Z/vh2+zF5GzC4mJe
	S5Z3EE/oAp/LrnI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s0i9S-00E90w-N3; Sat, 27 Apr 2024 15:31:38 +0200
Date: Sat, 27 Apr 2024 15:31:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: arinc.unal@arinc9.com
Cc: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next] net: dsa: mt7530: do not set MT7530_P5_DIS when
 PHY muxing is being used
Message-ID: <7c476e63-5747-4128-af97-13edc252a263@lunn.ch>
References: <20240427-for-netnext-mt7530-do-not-disable-port5-when-phy-muxing-v1-1-793cdf9d7707@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240427-for-netnext-mt7530-do-not-disable-port5-when-phy-muxing-v1-1-793cdf9d7707@arinc9.com>

On Sat, Apr 27, 2024 at 02:24:42PM +0300, Arınç ÜNAL via B4 Relay wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> When the PHY muxing feature is in use, port 5 won't be defined in the
> device tree. Because of this, the type member of the dsa_port structure for
> this port will be assigned DSA_PORT_TYPE_UNUSED. The dsa_port_setup()
> function calls ds->ops->port_disable() when the port type is
> DSA_PORT_TYPE_UNUSED.
> 
> The MT7530_P5_DIS bit is unset when PHY muxing is being used.
> mt7530_port_disable() which is assigned to ds->ops->port_disable() is
> called afterwards. Currently, mt7530_port_disable() sets MT7530_P5_DIS
> which breaks network connectivity when PHY muxing is being used.
> 
> Therefore, do not set MT7530_P5_DIS when PHY muxing is being used.
> 
> Fixes: 377174c5760c ("net: dsa: mt7530: move MT753X_MTRAP operations for MT7530")
> Reported-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
> Hello.
> 
> I've sent this to net-next as the patch it fixes is on the current
> development cycle.
> ---
>  drivers/net/dsa/mt7530.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index 2b9f904a98f0..07b6da3ae97c 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -1220,7 +1220,7 @@ mt7530_port_disable(struct dsa_switch *ds, int port)
>  	if (priv->id != ID_MT7530 && priv->id != ID_MT7621)
>  		return;
>  
> -	if (port == 5)
> +	if (port == 5 && priv->p5_mode == GMAC5)
>  		mt7530_set(priv, MT753X_MTRAP, MT7530_P5_DIS);


It might be worth a comment. It is not obvious that
priv->p5_mode == GMAC5 means the PHY MUX is being used.
mt7530_setup_port5() thinks it is sufficiently obscure that
it comments each case.

	Andrew

