Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A981E802345
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 12:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbjLCLlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 06:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCLlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 06:41:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354B3C0
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 03:41:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61E1C433CA;
        Sun,  3 Dec 2023 11:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701603672;
        bh=OtdrrUcI446zB3hxjmwSCcBAkj90yqeSrqfZyF8qy48=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CFFBrH4SEi0MldZ/NirkRDs9gdP61dFBFMSHJrl24HO7MpEZ5hYwfNYSYgxvDUYJv
         lfEPwAWMzLKrWQ9NmiPy6zbjhcclRi8X5r9Wf3Ezu6f+eLazpk7xuHqwNFTkHRJVhw
         ZtdwoW4BzUA4rAk8USaAeg+g8EPxdrVcK2NACkmioYme+KUp1GpepZkFNYjfExe3iF
         o0AM/RIEpu1yUcGsDOAcPSUDC2bpSseQRSU3GBd/Sjp1YR+WzeDRo5IMhfLO52gbVE
         Jlew+uy0TaY6QVe/leeqOB2wuqpFvxO0K4C9NxTjRzTF8SsA/+QvbaKZuFQ+TZMG2j
         amGSUhiRftWRA==
Date:   Sun, 3 Dec 2023 11:41:06 +0000
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
Subject: Re: [PATCH v5 1/5] i40e: Use existing helper to find flow director
 VSI
Message-ID: <20231203114106.GF50400@kernel.org>
References: <20231124150343.81520-1-ivecera@redhat.com>
 <20231124150343.81520-2-ivecera@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124150343.81520-2-ivecera@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 04:03:39PM +0100, Ivan Vecera wrote:
> Use existing i40e_find_vsi_by_type() to find a VSI
> associated with flow director.
> 
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>

