Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75127941A4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 18:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238787AbjIFQog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 12:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjIFQoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:44:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08511738
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 09:44:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EE7C433C8;
        Wed,  6 Sep 2023 16:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694018671;
        bh=EI+fvmvCWqkc2KvJRNNxL/0XTQiGCQyC+Wq7BVvHLbw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GJphocDoYaCEC2q0FlyhwS2052waXIDzJHzIdPzpiWlS4y3p2SAOqx6BQ4eW0Gnb5
         xTrcawY491TpXvsTGriQLa+fxiX7nyheq/JKMcgosSjwVcEXVIzxOCiuU83ckmdA+M
         wZpcgQb+FJH78SF7AMyBQ3X15P6qV/3iCsMf8+dNc8JMjzeGzbXBEIhsLZzsjZMGJX
         xmeoWKGPUKSMa5FjSA2+A3nTJ8TMicZRBt+PdowRHmvOHxLg5s5c4RytvrZnJ0+qQe
         uw0o/K694wTBRD8YTenWL8xQ1PUfXTUYoWVdZvBZHZuEQHV6ZFWGNt9dWr3i7S1pRo
         ouGcdjKJGgkAg==
Date:   Wed, 6 Sep 2023 18:44:27 +0200
From:   Simon Horman <horms@kernel.org>
To:     Ahmed Zaki <ahmed.zaki@intel.com>
Cc:     Petr Oros <poros@redhat.com>, netdev@vger.kernel.org,
        ivecera@redhat.com, intel-wired-lan@lists.osuosl.org,
        jesse.brandeburg@intel.com, linux-kernel@vger.kernel.org,
        edumazet@google.com, anthony.l.nguyen@intel.com, kuba@kernel.org,
        pabeni@redhat.com, davem@davemloft.net
Subject: Re: [Intel-wired-lan] [PATCH net 1/2] iavf: add
 iavf_schedule_aq_request() helper
Message-ID: <20230906164427.GC270386@kernel.org>
References: <20230906141411.121142-1-poros@redhat.com>
 <bbb51ddd-ceb1-63a8-a06a-f365da5ac4b7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbb51ddd-ceb1-63a8-a06a-f365da5ac4b7@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 09:32:59AM -0600, Ahmed Zaki wrote:
> 
> On 2023-09-06 08:14, Petr Oros wrote:
> > Add helper for set iavf aq request AVF_FLAG_AQ_* and imediately

nit: immediately
