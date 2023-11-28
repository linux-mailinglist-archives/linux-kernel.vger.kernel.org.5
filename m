Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64E67FC533
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 21:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345005AbjK1UWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK1UWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:22:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD37F83;
        Tue, 28 Nov 2023 12:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701202949; x=1732738949;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=5a9+cqvWMbcyuzJdN5sdcVcbsN9zqY5j2FPt3BXfm2g=;
  b=ncbc7Kqm3VCMyFtoy5HrLbz/Uz/jCx2q606hGeenVljx0PulAxq4iivG
   EmHnS7iZbA6q9bD2R19B0zV0rZ+DtAKZUQ3yPmlrL7MH08nkHQ454PQVh
   6IYt6x+sQa3eqjEGy/nKD2kd4Uz8BoJGjKxk+SwtSHcUi5vYs5uUzrulw
   +L2IURIQvDGNpAI2OpVcAaGMfb3SDrYrFNkoFPG64rPDrkWfCEEm6G4Es
   W7dwAAhxIq+BmhdAnFJBoLlvnJyowIuv5jhT7F0Q5lQLsR9/ZnKGyr3qz
   ArQkEUvjCzjgqPr4ONRc9sQyPY4w7tztTb2vcOAWnLW9WnluwwwWezwZq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="424166467"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="424166467"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 12:22:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="17036986"
Received: from ticela-or-268.amr.corp.intel.com (HELO vcostago-mobl3) ([10.212.190.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 12:22:28 -0800
From:   Vinicius Costa Gomes <vinicius.gomes@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 1/1] net/sched: cbs: Use units.h instead of
 the copy of a definition
In-Reply-To: <20231128174813.394462-1-andriy.shevchenko@linux.intel.com>
References: <20231128174813.394462-1-andriy.shevchenko@linux.intel.com>
Date:   Tue, 28 Nov 2023 12:22:27 -0800
Message-ID: <87h6l5sk58.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> BYTES_PER_KBIT is defined in units.h, use that definition.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


-- 
Vinicius
