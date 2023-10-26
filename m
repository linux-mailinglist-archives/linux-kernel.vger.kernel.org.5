Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33137D8517
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345180AbjJZOsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjJZOsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:48:11 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4321AA;
        Thu, 26 Oct 2023 07:48:09 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-5079f9675c6so1496212e87.2;
        Thu, 26 Oct 2023 07:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698331687; x=1698936487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lA4hE3uZlgvLgsP3vdnLkkBKbPdZxuW4amK7/iwUep4=;
        b=CNYG/ipj5tefaEs0/ZguViqsV3hjpPmwxAEO9ehLWyZ0jx6yaXaqT90JRWt2qdVdVM
         nA3zSmUbRKIs5iErfR11jolcfZzvgFSIYUiRTEVanZPwWchxVbcj0J9ufxmuClsruDR8
         bNRq/e/hsLdD1EFymOYdO7E8Brm27X+Nh8V+j5JVafF21j2iolMwkr+MrcO93HFhb/1Y
         vJlM7IQ/IpSOBu/L27gKvlXMS2CTlsTNO2r9tkfWTUOgf8LWal/JmsoUO6c+Cq8fchgG
         fqEAMwfiZw81EMbpjIbZRLoEg0kdxUGpnGPdIDSvJPOaIRHMsHb9+M9ATorNSpRXGkSB
         GzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698331687; x=1698936487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lA4hE3uZlgvLgsP3vdnLkkBKbPdZxuW4amK7/iwUep4=;
        b=lQOAO7WLUZBf63BBgi4hjwjUXo3noI818a4dNguoDkgMin1Cmz+BfQvhLQirAwP4og
         pyOBg+qoqtpG1L/WrSNdNXLqHQHurgAe75ZBmRWVhTCRyWWICBf34ZJ3acLGs3M183fr
         PbPn/JUoQy5d2AGtBczyG8xzmuj1zVX+6lUcDi6YrFF2od1ZcfhDHU+50xCY0NWoBIRT
         gABN2PulmlROgf1RhncqAnV2oD9zpEAabRLCiCmXia1ZzP54V+hhp1ltZr4u/4j2CFAH
         59B0iFWTfSzQ97HBzz+zoYD6GbWaOEQ100oqZj6Ko5D8874HDnzxbGxS1K1gUkw7rfiv
         XlPg==
X-Gm-Message-State: AOJu0Ywi/9cCqfpEmyhSmbaj/3YIpAPxnhNdwfkb88QIm0TShtX/5zEx
        125TryOQcxc8LCE4uyRcJ+k=
X-Google-Smtp-Source: AGHT+IFz8j4YY/HHghX2GGt1lrlrylUL7fvAkkIZOGh/AZiM8BbdOzSm4JE7cSrL9dgBRDOqGYbdBA==
X-Received: by 2002:ac2:5bd0:0:b0:507:9a0b:3fd7 with SMTP id u16-20020ac25bd0000000b005079a0b3fd7mr13491806lfn.13.1698331687167;
        Thu, 26 Oct 2023 07:48:07 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id h2-20020ac25962000000b005079a00a456sm3019308lfp.107.2023.10.26.07.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 07:48:06 -0700 (PDT)
Date:   Thu, 26 Oct 2023 17:48:04 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, andrew@lunn.ch,
        Jose.Abreu@synopsys.com, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next V2] net: pcs: xpcs: Add 2500BASE-X case in get
 state for XPCS drivers
Message-ID: <pgr3jnzao7jeoz6sutt2nk6wrtzvjl42lxmorncyddzeouuzvu@jpznq4ycta6f>
References: <20231026101642.3913-1-Raju.Lakkaraju@microchip.com>
 <ZTpHi5YYmiQKpy1e@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTpHi5YYmiQKpy1e@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 12:03:39PM +0100, Russell King (Oracle) wrote:
> On Thu, Oct 26, 2023 at 03:46:42PM +0530, Raju Lakkaraju wrote:
> > Add DW_2500BASEX case in xpcs_get_state( ) to update speed, duplex and pause
> > 
> > Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> 
> Sorry for not doing a fuller review with the earlier iteration today.
> 
> Also, please note that on netdev, it's customary not to post more than
> one version of a patch per day. Please see the netdev FAQ for guidance.
> 
> > +static int xpcs_get_state_2500basex(struct dw_xpcs *xpcs,
> > +				    struct phylink_link_state *state)
> > +{

> > +	int sts;
> > +
> > +	sts = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_MMD_STS);
> 
> 	if (sts < 0) {
> 		state->link = 0;
> 		return sts;

My 5cents to this note. Please use "ret" variable name as it's implied
by the local naming convention.

-Serge(y)

> 	}
> 
> especially as a negative errno value could result in state->link being
> true.
> 
> Thanks.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
