Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BA7802344
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 12:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbjLCLmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 06:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbjLCLmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 06:42:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A59E114
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 03:42:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2ED5C433C9;
        Sun,  3 Dec 2023 11:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701603727;
        bh=yyB6miuV3QDfgKnJCr8YxHHVQ4FeW1IM6trz2iKW220=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qjYMVFOPP3usK2DsxR2PhtHpHYZ4WGTs6XUpZV3XMQXpqDA+9QKDyqaTkSbXkxBJ+
         WxygQf25Gdc2nlfqNmH26ZaPLuXlyfEA+jast5XjwuUaV2P/xGRMeMBJUPTSwsJnni
         YdFTs03N9MelOH7/scZz96jkvHYSCEqTXMcMFTHHM27y5O7Y52E3weMUVkiC0APDdn
         CO5oDRYWl0yzhVG2qSdgMuE1UQGGX0J7nkNYG+hxjJ54vq5TW7L7e26nJqLBWOdZue
         RBZfxMPrTVaQna3U3XoG8FQ1LBUG0OoEQC4o3sQ0fn9hnpvu476fRIFWhEJcOqkVb9
         iOkAWwSvm5LnQ==
Date:   Sun, 3 Dec 2023 11:41:59 +0000
From:   Simon Horman <horms@kernel.org>
To:     Ivan Vecera <ivecera@redhat.com>
Cc:     intel-wired-lan@lists.osuosl.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>,
        mschmidt@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH v5 3/5] i40e: Add helpers to find VSI and VEB by SEID and
 use them
Message-ID: <20231203114159.GH50400@kernel.org>
References: <20231124150343.81520-1-ivecera@redhat.com>
 <20231124150343.81520-4-ivecera@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124150343.81520-4-ivecera@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 04:03:41PM +0100, Ivan Vecera wrote:
> Add two helpers i40e_(veb|vsi)_get_by_seid() to find corresponding
> VEB or VSI by their SEID value and use these helpers to replace
> existing open-coded loops.
> 
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>

