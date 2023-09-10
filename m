Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17B2799E87
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 15:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346680AbjIJNtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 09:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbjIJNtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 09:49:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED37CCA;
        Sun, 10 Sep 2023 06:49:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D0FC433C8;
        Sun, 10 Sep 2023 13:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694353782;
        bh=IAqYcnKPzNeIDqtgIjazLW2Yv7D0oebDNR4aro3tFR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CwVw6uy4xBOyPC7qVHVIFToy35ARWHf379d+0HzdxNvsXYwH1v+eY1MvBRhL7oYdo
         hW/oawjpRjhEPSSVEzxX3YisDq+Jj0P4bGzpnMNZZgm0ajODZLwEg5136pVjUfTgem
         5SWaweMjWsFxjta5iIwUvjQNib4Upzjz2Q7cj492mahxKd6VRfeqCvwDfDNCHYFYK7
         WsFGKucXwBEWljBB60m3P88mjdVLA1oV4HByBNPrTYUDayOwZ453Fo27VRUb921im3
         PZ/7ZTSMCnEIPmOHNggCCcjLLA7caGXZ+sefborg1PEnkXMa6ttMbzrDbZbnq9xZut
         eRCzJ3cu2fWtw==
Date:   Sun, 10 Sep 2023 15:49:37 +0200
From:   Simon Horman <horms@kernel.org>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Justin Chen <justin.chen@broadcom.com>,
        kernel-janitors@vger.kernel.org,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] net: bcmasp: add missing of_node_put
Message-ID: <20230910134937.GB775887@kernel.org>
References: <20230907095521.14053-1-Julia.Lawall@inria.fr>
 <20230907095521.14053-3-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907095521.14053-3-Julia.Lawall@inria.fr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 11:55:12AM +0200, Julia Lawall wrote:
> for_each_available_child_of_node performs an of_node_get
> on each iteration, so a break out of the loop requires an
> of_node_put.
> 
> This was done using the Coccinelle semantic patch
> iterators/for_each_child.cocci
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Reviewed-by: Simon Horman <horms@kernel.org>

