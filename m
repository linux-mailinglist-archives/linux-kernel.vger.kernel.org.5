Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3BA7CF3BA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345016AbjJSJP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbjJSJPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:15:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A91E136
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 02:15:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1780C433C9;
        Thu, 19 Oct 2023 09:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697706921;
        bh=2akR1+SpClZT3e4hW3GUBKo4hbbNfLPH+FJFcgjS+bQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NDw9mOxaxTwpIG2OLQXoJ0CTEuTsLDqvqLHgBr9mmasIrMuTajY6NHR2Lyp8kgko6
         d4U8sANg22+MMNy2oqQ2OSdIgdmMJamlgzMkYRMyp1LiPWEsQFCCXrYG+KB9s9ROA6
         xrGm9sIN/VYicmTIOc2PRrZHF0zprsL+JeaHthvLwlsKzaB7CqNBLgHapoVQ0xfmNS
         fEpb0MVH2Rxi8hOXbP4pIFEwrbKXxQorzEod3798LFEhxycRFVGFPYJO2X/E3npYjx
         /veSJeNpceDqBEWxRwbj3qneTmQEmzUOwpDBaggyRdFFT7LeLAZjB0uzOvwZ8xtJ3D
         LHb3jjr7cIK7g==
Date:   Thu, 19 Oct 2023 11:15:17 +0200
From:   Simon Horman <horms@kernel.org>
To:     Ivan Vecera <ivecera@redhat.com>
Cc:     netdev@vger.kernel.org,
        Mateusz Palczewski <mateusz.palczewski@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "moderated list:INTEL ETHERNET DRIVERS" 
        <intel-wired-lan@lists.osuosl.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] i40e: Fix I40E_FLAG_VF_VLAN_PRUNING value
Message-ID: <20231019091408.GA2100445@kernel.org>
References: <20231018112621.463893-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018112621.463893-1-ivecera@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 01:26:20PM +0200, Ivan Vecera wrote:
> Commit c87c938f62d8f1 ("i40e: Add VF VLAN pruning") added new
> PF flag I40E_FLAG_VF_VLAN_PRUNING but its value collides with
> existing I40E_FLAG_TOTAL_PORT_SHUTDOWN_ENABLED flag.
> 
> Move the affected flag at the end of the flags and fix its value.
> 
> Cc: Mateusz Palczewski <mateusz.palczewski@intel.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Hi Ivan,

I agree with the correctness of this patch and that it was
introduced by the cited commit.

However, I do wonder if, as a fix for 'net':

1) The patch description could include some discussion of
   what problem is resolved, and, ideally, how I user might
   get into such a situation.

2) The following fixes tag is appropriate.

Fixes: c87c938f62d8 ("i40e: Add VF VLAN pruning")

...
