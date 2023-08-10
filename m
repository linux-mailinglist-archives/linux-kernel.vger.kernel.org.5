Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA2A777AAC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbjHJOZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235760AbjHJOZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:25:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC8330FF;
        Thu, 10 Aug 2023 07:25:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C7AF65DEE;
        Thu, 10 Aug 2023 14:25:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1FAC433C7;
        Thu, 10 Aug 2023 14:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691677511;
        bh=6cGOvNoykusDaf6Of5RjamYUXKMze3La+qVxd6f/ihM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oeUjikqDD0vlkCHVBso+yDHIalbbekvyd8GI/r6gRirQ3QYapq/cRvZSfjYunSP84
         VjIA7W42EALTh1Ci0C8s5nWdycAlhbeFuDwQSLyKIcp1PhDMsztNC2V0VptWBBa95b
         l2dzl53uwt7WAMyxdjCh3u2V2sPWqzSZhk5vqY4AyDKTe+/IWv5+p57jIW74JELOMt
         yU6EEnYHMx75I39kf9nAmmRNuAPUasSJu0HzZSAqgljR3ItvaJM2lxuW6jPjVn+Y+8
         VU/8I/YP0yr0Aumy2uy3xg1PpntjX25L/7WjEveLNRfjNtVZI0uYbCw2WpFGOo+kLu
         6SeQBisAhnBeQ==
Date:   Thu, 10 Aug 2023 16:25:07 +0200
From:   Simon Horman <horms@kernel.org>
To:     Lin Ma <linma@zju.edu.cn>
Cc:     johannes@sipsolutions.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        avraham.stern@intel.com, luciano.coelho@intel.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] nl80211/cfg80211: add forgetten nla_policy for
 BSS color attribute
Message-ID: <ZNTzQ3QgKdWWpVop@vergenet.net>
References: <20230809033151.768910-1-linma@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809033151.768910-1-linma@zju.edu.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 11:31:51AM +0800, Lin Ma wrote:
> The previous commit dd3e4fc75b4a ("nl80211/cfg80211: add BSS color to
> NDP ranging parameters") adds a parameter for NDP ranging by introducing
> a new attribute type named NL80211_PMSR_FTM_REQ_ATTR_BSS_COLOR.
> 
> However, the author forgot to also describe the nla_policy at
> nl80211_pmsr_ftm_req_attr_policy (net/wireless/nl80211.c). Just
> complement it to avoid malformed attribute that causes out-of-attribute
> access.
> 
> Fixes: dd3e4fc75b4a ("nl80211/cfg80211: add BSS color to NDP ranging parameters")
> Signed-off-by: Lin Ma <linma@zju.edu.cn>

Reviewed-by: Simon Horman <horms@kernel.org>

