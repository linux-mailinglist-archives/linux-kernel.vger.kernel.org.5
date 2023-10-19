Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B127CF863
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbjJSMJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345841AbjJSMJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:09:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE04385D
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697717231; x=1729253231;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rbsBJpmkS47G9tV6+xTsrI+g7quKxqgTbZfC3LaxFAw=;
  b=KPBhMqdrJ3E2t2pak4T0w0c9uTFqXyPCTFG/vbcHxFKAHpUBz3dzDtdA
   HFO/IqFX0iOK/fC5he0lPLCbnZqUyJt3d3SEiD+P+aj0dQ237Ge4Fk431
   J3RpcZ5l9rGa8O8VNsflxsTRCrZO+Wzkmo+VAFN0XTOD4Tw0LgrPLAISo
   Y5l7buBLX3K20zSaHUJ6JB4KIbpe/k92lsHUU0VBnQkUM8P44dTCHZG2S
   zL3ObaQu4sX3VPS2mUOcmONRQCEMK7mhOQ2hjVPN83vjJ+wElhDy8fylj
   SBOZmUtK6NqB89EK/S4LEWdT9NQxtC7QcW2h1D/36yswTyElREk/sGF2J
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="366473293"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="366473293"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 05:07:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="1088342758"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="1088342758"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 19 Oct 2023 05:07:09 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtRnv-00025W-0K;
        Thu, 19 Oct 2023 12:07:07 +0000
Date:   Thu, 19 Oct 2023 20:06:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, virtualization@lists.linux-foundation.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 5/5] x86/paravirt: remove no longer needed paravirt
 patching code
Message-ID: <202310191909.USSRXzXc-lkp@intel.com>
References: <20231019091520.14540-6-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019091520.14540-6-jgross@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juergen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kvm/queue]
[cannot apply to tip/x86/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Juergen-Gross/x86-paravirt-move-some-functions-and-defines-to-alternative/20231019-171709
base:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git queue
patch link:    https://lore.kernel.org/r/20231019091520.14540-6-jgross%40suse.com
patch subject: [PATCH v3 5/5] x86/paravirt: remove no longer needed paravirt patching code
reproduce: (https://download.01.org/0day-ci/archive/20231019/202310191909.USSRXzXc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310191909.USSRXzXc-lkp@intel.com/

# many are suggestions rather than must-fix

WARNING:SPLIT_STRING: quoted string split across lines
#327: FILE: arch/x86/tools/relocs.c:69:
 	"__x86_cpu_dev_(start|end)|"
+	"__alt_instructions(_end)?|"

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
