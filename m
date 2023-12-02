Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D57801A55
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 04:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjLBD6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 22:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLBD6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 22:58:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D0711C
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 19:58:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AAA4C433C8;
        Sat,  2 Dec 2023 03:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701489525;
        bh=4Dssh/2XYrY7MFpdTli/FZh9LF92fl3xHUY9aZxS/Pg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UNJVtCelRf/0UiHca/sA+nNHW5KpAxlyJE35EDaH124YQSHW3SHpu9ad6DDFTZza9
         tY1dMIlGCa1nTsMoXd9PqD8ATfDdK0iX9RtGOnZtqPGzDhNkCwjcJteNSt+3jgSepZ
         3LsPt1bhjrlSsI+TJGsX4ojwn6qTd5UqWLRsHToQqZKV6ZmkihZIvKtmfdRtwpK55s
         xdrgiLUTmrw5lMb2zS6c4pfsJJlOkRaXNBp8XX7zIhtz0KbSn2AsLDlcouhp6SB2vj
         qq6iBx4XseHTqWvzLIDUxePGxThJb7kb3QaZ/6NYnMxR1lMIYa5QncS0Pe+Ogt5Epd
         xtOWtgPZOBS9w==
Date:   Fri, 1 Dec 2023 19:58:43 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Shinas Rasheed <srasheed@marvell.com>
Cc:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <davem@davemloft.net>, <wizhao@redhat.com>, <konguyen@redhat.com>,
        "Veerasenareddy Burru" <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v1] octeon_ep: control net API framework to
 support offloads
Message-ID: <20231201195843.118fdcfe@kernel.org>
In-Reply-To: <20231201131815.2566189-1-srasheed@marvell.com>
References: <20231201131815.2566189-1-srasheed@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2023 05:18:14 -0800 Shinas Rasheed wrote:
> +static netdev_features_t octep_fix_features(struct net_device *dev,
> +					    netdev_features_t features)
> +{
> +	return (dev->hw_features & features);
> +}

Why is this needed? The core kernel should already make sure
unsupported features aren't requested.
