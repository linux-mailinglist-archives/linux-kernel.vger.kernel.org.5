Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634C476C481
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 07:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjHBFDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 01:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjHBFDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 01:03:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5579C1FCF;
        Tue,  1 Aug 2023 22:03:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E577861789;
        Wed,  2 Aug 2023 05:03:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9E6C433C8;
        Wed,  2 Aug 2023 05:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690952624;
        bh=Lh/8DXYnrVwSuT95CJrJrjg3AAwX2dmsR+R7uiAEAko=;
        h=Date:From:To:Cc:Subject:From;
        b=r8e2tnRr6NR/LJPVYeu/KXYVkqyD0lFLFN6wGOkUXSTnUvkHDwxIOHNPqVuq3fu18
         dW+IjDhbZTUUy5VqJL3lObzr1M3wg9vwgla000FujrcSx8KH3fxIaGKnFHXW8HruSy
         aoeKf9L4La43QQvz+pDwhEZOykqvRb2M6cNfJOMAfR50hmRGcM19Wtos27b39mV66G
         G6E3LxGY1Sp5kwbXVMy+Y+h2BFcyVip+M00JjLHhuP6t9Xb4B90mubprHGO93YA9yX
         GGLeuFgMQoA9czqR3P1/u6sJZX5FR1OPeiUhgC8R0atIvazIzrSgdU5TvvZ6ZyLDcN
         Vc6wXOtl+e9Mw==
Date:   Tue, 1 Aug 2023 23:04:48 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        fam1-i40e/0001-i40e-Replace-one-element-array-with-flex-array-membe.patch@work,
        fam1-i40e/0002-i40e-Replace-one-element-array-with-flex-array-membe.patch@work,
        fam1-i40e/0003-i40e-Replace-one-element-array-with-flex-array-membe.patch@work,
        fam1-i40e/0004-i40e-Replace-one-element-array-with-flex-array-membe.patch@work
Cc:     netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH 0/4][next] i40e: Replace one-element arrays with
 flexible-array members
Message-ID: <cover.1690938732.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace one-element arrays with flexible-array members in multiple
structures.

This results in no differences in binary output.

Gustavo A. R. Silva (4):
  i40e: Replace one-element array with flex-array member in struct
    i40e_package_header
  i40e: Replace one-element array with flex-array member in struct
    i40e_profile_segment
  i40e: Replace one-element array with flex-array member in struct
    i40e_section_table
  i40e: Replace one-element array with flex-array member in struct
    i40e_profile_aq_section

 drivers/net/ethernet/intel/i40e/i40e_ddp.c  | 4 ++--
 drivers/net/ethernet/intel/i40e/i40e_type.h | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.34.1

