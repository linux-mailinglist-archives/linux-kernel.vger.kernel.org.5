Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2567F9F60
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbjK0MQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbjK0MP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:15:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12FB193
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:16:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3A6C433C9;
        Mon, 27 Nov 2023 12:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701087362;
        bh=s9rET20v/rSXQlRujYuxlhNNOKLKtQvmV96idnskVkA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rU/txeKTYQCMDfJtJqGVSHHioO6RTS2LrchPi7WT3rvPBWAHUuDJf3DKcW4VIHhYN
         dmddKcScUVE1ysBY6T4/EegoY6QVaUd4getqOkOFqptv7xQB3Y9FWGq7bmAYHZK2P0
         QwcnsQJyJTNBYiDuT9UMXJvgz7au7lknobJ+36PsOSEdFQkSeIWvD1OfM7PLUwsJAZ
         jVhHvo3HpCvUA394KLioh4+I7eFaw5b1QfpEcz7jm9xEDrZXQ5f27wAhpfpJTNhSND
         BUPBNGaeS9pJej9O0uXq7tgKGRksK4vDZWP1Q/2ftgo3aSfbyU8igVRDXN7vyvpNAu
         RpQzyUXmmgiMQ==
Date:   Mon, 27 Nov 2023 12:15:57 +0000
From:   Simon Horman <horms@kernel.org>
To:     Petr Oros <poros@redhat.com>
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-kernel@vger.kernel.org,
        wojciech.drewek@intel.com
Subject: Re: [Intel-wired-lan] [PATCH v2 iwl-next] iavf: use
 iavf_schedule_aq_request() helper
Message-ID: <20231127121557.GE84723@kernel.org>
References: <20231114223522.2110214-1-poros@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114223522.2110214-1-poros@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 11:35:22PM +0100, Petr Oros wrote:
> Use the iavf_schedule_aq_request() helper when we need to
> schedule a watchdog task immediately. No functional change.
> 
> Signed-off-by: Petr Oros <poros@redhat.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> ---
> v2: rebased on net-next

Reviewed-by: Simon Horman <horms@kernel.org>
