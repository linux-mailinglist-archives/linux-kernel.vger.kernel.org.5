Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E22179EA75
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241214AbjIMOIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjIMOIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:08:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329B419B1;
        Wed, 13 Sep 2023 07:08:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9F0C433C7;
        Wed, 13 Sep 2023 14:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694614114;
        bh=U0uF/Hy56VJL0mJg5gDqOTRdoiUMba1sRM09O5WC0A0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZXRh2XAwWjglZRrf4C8kmeEaaKwcdq7iyQv3rdUqUL/lHXxjECxSWAETJVrhjv0KA
         l+1ZnZBjmsxRvWBL9bVGkQLlncKiR9g7ZSS/eM79YODZxZ5Kbke7TddQ6bpLDJdJl8
         IjKcMHFA1k2RRdOYkB+FmCvpafbv+Aqr+24EAZGEo9Fwoj2YjhYyJogKFKVguMniaf
         yJnaH3WxJmQxi0pZitFm1EUevL4DqkIa1xTnitflY8xl0Hy1gq1wYAlOdgcPo/kspU
         mP4VmRpD1CzsOId08Rj/aHwQ4LHRGC26z+BKG/CyUUyELafG57JDa1+8GjHex7Zjdf
         no+tTZ2JGzO8w==
Date:   Wed, 13 Sep 2023 16:08:28 +0200
From:   Simon Horman <horms@kernel.org>
To:     Jinjian Song <songjinjian@hotmail.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, corbet@lwn.net, loic.poulain@linaro.org,
        ryazanov.s.a@gmail.com, jiri@resnulli.us,
        johannes@sipsolutions.net, chandrashekar.devegowda@intel.com,
        linuxwwan@intel.com, chiranjeevi.rapolu@linux.intel.com,
        haijun.liu@mediatek.com, m.chetan.kumar@linux.intel.com,
        ricardo.martinez@linux.intel.com, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        nmarupaka@google.com, vsankar@lenovo.com, danielwinkler@google.com,
        Jinjian Song <jinjian.song@fibocom.com>
Subject: Re: [net-next v4 5/5] net: wwan: t7xx: Devlink documentation
Message-ID: <20230913140828.GU401982@kernel.org>
References: <20230912094845.11233-1-songjinjian@hotmail.com>
 <ME3P282MB27037E574DB3685216A0DF56BBF1A@ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ME3P282MB27037E574DB3685216A0DF56BBF1A@ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 05:48:45PM +0800, Jinjian Song wrote:
> From: Jinjian Song <jinjian.song@fibocom.com>
> 
> Document the t7xx devlink commands usage for firmware flashing &
> coredump collection.
> 
> Base on the v5 patch version of follow series:
> 'net: wwan: t7xx: fw flashing & coredump support'
> (https://patchwork.kernel.org/project/netdevbpf/patch/f902d4a0cb807a205687f7e693079fba72ca7341.1674307425.git.m.chetan.kumar@linux.intel.com/)
> 
> Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
> ---
> v4:
>  * no change
> v3:
>  * supplementary separator '~'
> v2:
>  * no change
> ---
>  Documentation/networking/devlink/index.rst |   1 +
>  Documentation/networking/devlink/t7xx.rst  | 232 +++++++++++++++++++++
>  2 files changed, 233 insertions(+)
>  create mode 100644 Documentation/networking/devlink/t7xx.rst
> 
> diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
> index b49749e2b9a6..f101781105ca 100644
> --- a/Documentation/networking/devlink/index.rst
> +++ b/Documentation/networking/devlink/index.rst
> @@ -67,3 +67,4 @@ parameters, info versions, and other features it supports.
>     iosm
>     octeontx2
>     sfc
> +   mtk_t7xx

Hi Jinjian Song,

I think that this should be t7xx rather than mtk_t7xx,
to match the filename of the new file created by the following hunk

> diff --git a/Documentation/networking/devlink/t7xx.rst b/Documentation/networking/devlink/t7xx.rst

...
