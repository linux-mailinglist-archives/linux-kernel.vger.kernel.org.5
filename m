Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CEE802342
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 12:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbjLCLll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 06:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCLlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 06:41:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE53FCB
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 03:41:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCE4C433C7;
        Sun,  3 Dec 2023 11:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701603705;
        bh=XccCxYSOFM8R5fg3IGTtouCQNjtf99QVUi/l5Jh6WSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d5lqdJZb4hhVJH0PsnHgitXGQdQJd18XdAvgVByoC9p5AJgHF+enWKjlVh7y2uU7v
         AZXqOa+wQmtIao804WE0taU2rYoHHTZTjja4tetQYA71XEmxqCb96pMVHI2w5YlsNE
         R9GPDbmcKEmBQ+MPI946qqEUgHLIQZATzAEHXSG25rsoC2oVbEMIQkJumvxFwGS/H9
         0N85iI1IRVLc/PbOjbgjKpxGOLOrNrUao4yBRFa8TS2bhDi3wIiWCTUjkvOGbo+6nv
         CxAPvFYqTwSawtGbs4sajQ4G8a3NpuQqAZm2y/8UARFhFumNyG28rHNPpGJc+TvxJH
         /5qSMmhNR+68Q==
Date:   Sun, 3 Dec 2023 11:41:39 +0000
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
Subject: Re: [PATCH v5 2/5] i40e: Introduce and use macros for iterating VSIs
 and VEBs
Message-ID: <20231203114139.GG50400@kernel.org>
References: <20231124150343.81520-1-ivecera@redhat.com>
 <20231124150343.81520-3-ivecera@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124150343.81520-3-ivecera@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 04:03:40PM +0100, Ivan Vecera wrote:
> Introduce i40e_for_each_vsi() and i40e_for_each_veb() helper
> macros and use them to iterate relevant arrays.
> 
> Replace pattern:
> for (i = 0; i < pf->num_alloc_vsi; i++)
> by:
> i40e_for_each_vsi(pf, i, vsi)
> 
> and pattern:
> for (i = 0; i < I40E_MAX_VEB; i++)
> by
> i40e_for_each_veb(pf, i, veb)
> 
> These macros also check if array item pf->vsi[i] or pf->veb[i]
> are not NULL and skip such items so we can remove redundant
> checks from loop bodies.
> 
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>

