Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9576A769FEC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 20:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjGaSBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 14:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGaSBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 14:01:47 -0400
Received: from mgamail.intel.com (unknown [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E310E4E
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 11:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690826506; x=1722362506;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=G1m1f/yokP1/9TVZbcCBpbcPqifaN71mAD/RMOWQVpI=;
  b=EdmdESx6Pw+ha9scTMJKW7UJKbvKCdio7+Bn/xgCxHppOgHHs8ICz+1V
   +88hwScBT+M7mnjlmnmJHJxr4Y446gulujnV7xfkIHyFeU26dcMFE6p5A
   Eg/4GHPKJnZlIzjae+TjNQIaDW5tshdKEUimlVVdmFgTAcQoeGocWI7yT
   Ai2qhkZLzcAMYhY7Ruj44rnQ0zQLsptGVc8TJckuvfRasiorF7gLvIPM6
   wrkcagvL+nF5vx81o9FLh+QX0lRBASshzD6kc638Q4pgkMFOsZMgCfQu8
   HthJRNsY5L0HrMzP2mIip94O2W8dZlNdDBwDMGrYcdXVud7wJv7dsHrRl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="369097771"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="369097771"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 11:01:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="758003878"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="758003878"
Received: from ubik.fi.intel.com (HELO localhost) ([10.237.72.184])
  by orsmga008.jf.intel.com with ESMTP; 31 Jul 2023 11:01:43 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alison Schofield <alison.schofield@intel.com>,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v2 0/2] x86/sev: Generalize sev_setup_arch()
In-Reply-To: <20230609171214.31846-1-alexander.shishkin@linux.intel.com>
References: <20230609171214.31846-1-alexander.shishkin@linux.intel.com>
Date:   Mon, 31 Jul 2023 21:01:42 +0300
Message-ID: <87tttkx8mx.fsf@ubik.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Shishkin <alexander.shishkin@linux.intel.com> writes:

> Hi,
>
> Since previous version [0], I added 2/2, which is a minor cleanup.
>
> The main intention of this is to move sev_setup_arch() to mem_encrypt.c
> to reflect the fact that it's not SEV-specific, but covers TDX as well,
> although unintentionally.
>
> While looking at it, I also noticed that mem_encrypt_amd.c still
> includes virtio_config.h, which was needed for the code that since got
> moved to a different place (and even there doesn't require the include
> any more).

Gentle ping.

Regards,
--
Alex
