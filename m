Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4442A7F1C21
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 19:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjKTSSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 13:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjKTSSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 13:18:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8D692
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 10:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700504280; x=1732040280;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Uy/JOOl2F0hOLE08z0LK0OspugTXHtlXgW1jln1Dmjo=;
  b=Es05mAv90xZ7mf0saE4ofAPehI7/PtExlnARMuM+MIaBiMZS1Bx9YnUN
   PmkhK1q8LQwzW8eLJTlWmqbE8qCR8qIMZyE+4wLYYabOZZBPI1AajK4Zm
   h0rnD6eqgbs0b9ag3B7en32SIlzQhFd4zlXMvBUBVhW2JD5s0/ZTL4w0X
   YZGMXo84e4TMDF5mSiaQNfe0FzNFen8j4xwljdUsU6Tm0hiRoUTZn/CPI
   VolOE0BFTbJtE0IYTw19PyZgPhSjzBkny4NNfqWcUsQCoZzKq5rdURrd2
   iphgmc5qfHyZj0V/AKB3ACPf7+P/J777IUooYP3J1CheXNEC2Idh3CtCs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="382060519"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="382060519"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 10:17:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="832360878"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="832360878"
Received: from jhahn1-mobl1.amr.corp.intel.com (HELO [10.209.22.30]) ([10.209.22.30])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 10:17:39 -0800
Message-ID: <929eb682-8deb-4054-a7c1-b7b60831d7df@linux.intel.com>
Date:   Mon, 20 Nov 2023 12:17:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soundwire: stream: constify sdw_port_config when adding
 devices
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20231120174720.239610-1-krzysztof.kozlowski@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20231120174720.239610-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/20/23 11:47, Krzysztof Kozlowski wrote:
> sdw_stream_add_master() and sdw_stream_add_slave() do not modify
> contents of passed sdw_port_config, so it can be made const for code
> safety and as documentation of expected usage.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

