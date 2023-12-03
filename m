Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514238025E5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 18:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbjLCRMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 12:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCRMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 12:12:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4919FD
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 09:12:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCF0C433C7;
        Sun,  3 Dec 2023 17:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701623543;
        bh=C594qh/OKVwQZc6TZ7itti5dOI6pBQTMwVSTjIeQZRY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GZyUG1bjxANaV8iareFw/0h8QtxuYqbMtKZzlPazgvK/OwNe3l0cwj2p6kMUeAh9f
         hEpioqTsAoinrK4UMCI/MVpTSRy+V9gvJFOUtXAxxBSvgEQEHJ0R4U690LJEZKQye4
         QfuP2pO56XdsbrdcS5jrMA8t3+YKDIADu3d5IyfFpmTDl3grJSC6/JSuwnRRNyOjqs
         8eIVoLXAPvEetSUaBJoMzePlstBCm39DBwfiQVSErDPnm2JN1ra04wz5GdViLk8qpP
         VXqYMJK4i7eXMVhuyc3z6414hrrcyegL5zW03vyDDEv+CTJU+7JzBFSLU2F1/nysuo
         6coUL5yXDhscg==
Date:   Sun, 3 Dec 2023 17:12:18 +0000
From:   Simon Horman <horms@kernel.org>
To:     Geetha sowjanya <gakula@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
        edumazet@google.com, sgoutham@marvell.com, lcherian@marvell.com,
        jerinj@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net v3 PATCH 4/5] octeontx2-af: Add missing mcs flr handler call
Message-ID: <20231203171218.GN50400@kernel.org>
References: <20231130075818.18401-1-gakula@marvell.com>
 <20231130075818.18401-5-gakula@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130075818.18401-5-gakula@marvell.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 01:28:17PM +0530, Geetha sowjanya wrote:
> If mcs resources are attached to PF/VF. These resources need
> to be freed on FLR. This patch add missing mcs flr call on PF FLR.
> 
> Fixes: bd69476e86fc ("octeontx2-af: cn10k: mcs: Install a default TCAM for normal traffic")
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

