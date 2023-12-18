Return-Path: <linux-kernel+bounces-4079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B54B8177B4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4FB0B2129B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937561E4AF;
	Mon, 18 Dec 2023 16:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RDQtKieM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9576711706
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 16:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702917597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RzF2JbZXyIcepSdPLxopsW7MW0ToCu0TxILicJdkReA=;
	b=RDQtKieMmEzonyvGcZiFdioTpLlyUG5gBBuUmmrgjr5yDtVeUmBI/YnSNE0gHfDwkcaGJw
	XrxC0G8Cr1QqyJvP17XUIpa5q+6A75scIZJocFCLql29QWwOqRd4a0fQ62xc3AsM/IgIkZ
	9sc4GivJqNzAbJekiaUJ1g2M655BAj4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507--eNBK1L-OSOpzIkEXOxtFA-1; Mon, 18 Dec 2023 11:39:56 -0500
X-MC-Unique: -eNBK1L-OSOpzIkEXOxtFA-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-42577ba9d93so53758241cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:39:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702917596; x=1703522396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzF2JbZXyIcepSdPLxopsW7MW0ToCu0TxILicJdkReA=;
        b=ZICmRWLugn4UKT/sPzdfVyCLpE+GRDL06CN3IhkIXolrMXQGdgTREpHSOLjTvR1Yux
         JFmKUWKeixonZaH9qckAO0/WXNQ9MZ2anji6/Fse6EOGh7GID9WpRt2BBcLVfclmU34o
         dxA9XrCt5rOrgN+D9nlpnW60aec4Z/80zNF8qKJSMVkhJRC+jRpOHWJuOb00OB4xquSd
         bBdV9pxLatKOl8xROrcSWrq8pe6+i+BlGJ5JfPeG65ddUQYqTQs+BeZDfQNLRnSo/CxH
         n77eP3XkHnYmy58MH++F1psJSzmeP8eOxbO9RDKIu/EZJ8YGFmgcND3ykop4oHzCGJ6G
         DkRg==
X-Gm-Message-State: AOJu0YwaO/Wgv+5OhFm4KTL+FlHLXBSjXTtiXyDx4VeAxViIWpoWSp84
	jhOyShjo29/h1eca8VLS0JGJ71OaKgadTYsR08mUVKZm2Rwr8cvIW7xf9sNxOnMRIEIcSyv7dSb
	ZbsMguVJKZn31kllDHNuztpUv
X-Received: by 2002:a0c:d84d:0:b0:67e:f2a3:65b3 with SMTP id i13-20020a0cd84d000000b0067ef2a365b3mr10243365qvj.43.1702916069117;
        Mon, 18 Dec 2023 08:14:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6/x18YmncDwyp50UjFRfP/NiAFTZa/XpjJpoegbGivyb5S1NuE3buhOUOC8ymOCWqVGkP/Q==
X-Received: by 2002:a0c:d84d:0:b0:67e:f2a3:65b3 with SMTP id i13-20020a0cd84d000000b0067ef2a365b3mr10243358qvj.43.1702916068894;
        Mon, 18 Dec 2023 08:14:28 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id l10-20020a0ce84a000000b0067f38f0afd1sm1644254qvo.19.2023.12.18.08.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 08:14:28 -0800 (PST)
Date: Mon, 18 Dec 2023 10:14:25 -0600
From: Andrew Halaney <ahalaney@redhat.com>
To: Sneh Shah <quic_snehshah@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Bhupesh Sharma <bhupesh.sharma@linaro.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel@quicinc.com
Subject: Re: [PATCH net-next] net: stmmac: Fix ethool link settings ops for
 integrated PCS
Message-ID: <lcfvxawesjc3r2n66zjd2qu5gan7gvvpefgjqjzqwcxosh3n4l@kcggappvytkm>
References: <20231218135032.27209-1-quic_snehshah@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218135032.27209-1-quic_snehshah@quicinc.com>

Hi,

I think the subject should be [PATCH net] since this is a fix.

On Mon, Dec 18, 2023 at 07:20:32PM +0530, Sneh Shah wrote:
> Currently get/set_link_ksettings ethtool ops are dependent on PCS.
> When PCS is integrated in MAC, it will not have separate link config.
> Bypass cofiguring and checking PCS link config for integrated PCS.

s/cofiguring/configuring/

Please add:

    Fixes: ("aa571b6275fb net: stmmac: add new switch to struct plat_stmmacenet_data")

This fixes using the ethtool ops for me so also please feel free to add:

    Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8775p-ride

Thanks for the patch!

> 
> Signed-off-by: Sneh Shah <quic_snehshah@quicinc.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> index f628411ae4ae..e3ba4cd47b8d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> @@ -311,8 +311,9 @@ static int stmmac_ethtool_get_link_ksettings(struct net_device *dev,
>  {
>  	struct stmmac_priv *priv = netdev_priv(dev);
>  
> -	if (priv->hw->pcs & STMMAC_PCS_RGMII ||
> -	    priv->hw->pcs & STMMAC_PCS_SGMII) {
> +	if (!(priv->plat->flags & STMMAC_FLAG_HAS_INTEGRATED_PCS) &&
> +	    (priv->hw->pcs & STMMAC_PCS_RGMII ||
> +	     priv->hw->pcs & STMMAC_PCS_SGMII)) {
>  		struct rgmii_adv adv;
>  		u32 supported, advertising, lp_advertising;
>  
> @@ -397,8 +398,9 @@ stmmac_ethtool_set_link_ksettings(struct net_device *dev,
>  {
>  	struct stmmac_priv *priv = netdev_priv(dev);
>  
> -	if (priv->hw->pcs & STMMAC_PCS_RGMII ||
> -	    priv->hw->pcs & STMMAC_PCS_SGMII) {
> +	if (!(priv->plat->flags & STMMAC_FLAG_HAS_INTEGRATED_PCS) &&
> +	    (priv->hw->pcs & STMMAC_PCS_RGMII ||
> +	     priv->hw->pcs & STMMAC_PCS_SGMII)) {
>  		/* Only support ANE */
>  		if (cmd->base.autoneg != AUTONEG_ENABLE)
>  			return -EINVAL;
> -- 
> 2.17.1
> 


