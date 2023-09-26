Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A274F7AE4BB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 06:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbjIZEvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 00:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjIZEvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 00:51:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C683FD9;
        Mon, 25 Sep 2023 21:51:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C384AC433C7;
        Tue, 26 Sep 2023 04:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695703860;
        bh=2XWKvAekto0AapUYqHrtSRxr7WShNEyij7c26YghRAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YlMYktapS25d7hZe/l5I6O7kcLKgNhHBFArEte2dwHWHKXWOD+0f/ZTSAV3im7Vz3
         2ctnQvtA6Ecsqhsn0BAMHio9nMUxOayGBJ3Yy11vErSAX/JxVtl1AKwp8j0VUeBMl+
         xXhRzMvHqoUG7bY16Mq0UbmQxBKdxaljMZME+W9o=
Date:   Tue, 26 Sep 2023 06:50:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Wireless <linux-wireless@vger.kernel.org>,
        Aloka Dixit <quic_alokad@quicinc.com>,
        Franziska Naepelt <franziska.naepelt@googlemail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the wireless-next tree with Linus'
 tree
Message-ID: <2023092650-nastily-cube-30de@gregkh>
References: <20230926115452.68a71261@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926115452.68a71261@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 11:54:52AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the wireless-next tree got a conflict in:
> 
>   drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> 
> between commit:
> 
>   1d85bb7fd66a ("staging: rtl8723bs: Fix alignment open parenthesis")
> 
> from Linus' tree and commit:
> 
>   66f85d57b710 ("wifi: cfg80211: modify prototype for change_beacon")
>   bb55441c57cc ("wifi: cfg80211: split struct cfg80211_ap_settings")
> 
> from the wireless-next tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> index af155fca39b8,1e683212027c..000000000000
> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> @@@ -2317,9 -2318,8 +2317,9 @@@ static int cfg80211_rtw_start_ap(struc
>   	return ret;
>   }
>   
>  -static int cfg80211_rtw_change_beacon(struct wiphy *wiphy, struct net_device *ndev,
>  -		struct cfg80211_ap_update *info)
>  +static int cfg80211_rtw_change_beacon(struct wiphy *wiphy,
>  +				      struct net_device *ndev,
> - 				      struct cfg80211_beacon_data *info)
> ++				      struct cfg80211_ap_update *info)
>   {
>   	struct adapter *adapter = rtw_netdev_priv(ndev);
>   


Looks good to me, thanks!

greg k-h
