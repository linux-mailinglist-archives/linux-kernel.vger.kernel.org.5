Return-Path: <linux-kernel+bounces-7925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE5381AF43
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FD0AB2322C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB5611719;
	Thu, 21 Dec 2023 07:17:05 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out28-81.mail.aliyun.com (out28-81.mail.aliyun.com [115.124.28.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C412BE6B;
	Thu, 21 Dec 2023 07:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sjterm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sjterm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1523255|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0672332-0.00579752-0.926969;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=fuyao@sjterm.com;NM=1;PH=DS;RN=19;RT=16;SR=0;TI=SMTPD_---.Vpa1iLw_1703143015;
Received: from localhost(mailfrom:fuyao@sjterm.com fp:SMTPD_---.Vpa1iLw_1703143015)
          by smtp.aliyun-inc.com;
          Thu, 21 Dec 2023 15:16:56 +0800
Date: Thu, 21 Dec 2023 15:16:54 +0800
From: fuyao <fuyao@sjterm.com>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org,
	=?utf-8?B?6bqm5YGl5bu6?= <maijianzhang@allwinnertech.com>
Subject: Re: [PATCH] gmac: sun8i: r40: add gmac tx_delay support
Message-ID: <ZYPmZj8l01eQsDS5@debian.cyg>
Mail-Followup-To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org,
	=?utf-8?B?6bqm5YGl5bu6?= <maijianzhang@allwinnertech.com>
References: <ZYKvCQBD-SY9uVLF@debian.cyg>
 <2370947.NG923GbCHz@jernej-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2370947.NG923GbCHz@jernej-laptop>
Organization: work_work_work

On Wed, Dec 20, 2023 at 06:04:28PM +0100, Jernej Škrabec wrote:
> Dne sreda, 20. december 2023 ob 10:08:25 CET je fuyao napisal(a):
> > r40 can support tx_delay, so we add it.
> 
> I don't see how. User manual, 3.3.4.64. GMAC Clock Register talks only
> about RX delay.
> 

I don't see it in the user manual also.

it works fine in 100M, but it doesn't work good in 1G without tx_delay
in my board.

Read the sdk from allwinner I found in:

https://sourcegraph.com/github.com/tinalinux/linux-3.10/-/blob/arch/arm/boot/dts/sun8iw11p1.dtsi?L1826
https://sourcegraph.com/github.com/tinalinux/linux-3.10@r40-v1.y/-/blob/drivers/net/ethernet/allwinner/sunxi-gmac.c?L877

And I add it to my board, it works fine.

So, I think it may be exist register but not documented.

Best regards,
fuyao

> Best regards,
> Jernej
> 
> > 
> > Signed-off-by: fuyao <fuyao1697@cyg.com>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> > index 137741b94122..fd07573afc9b 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> > @@ -127,6 +127,7 @@ static const struct emac_variant emac_variant_r40 = {
> >  	.support_mii = true,
> >  	.support_rgmii = true,
> >  	.rx_delay_max = 7,
> > +	.tx_delay_max = 7,
> >  };
> >  
> >  static const struct emac_variant emac_variant_a64 = {
> > 
> 
> 
> 
> 


