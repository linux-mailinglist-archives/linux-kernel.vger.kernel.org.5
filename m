Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EBD7CE90F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjJRUe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjJRUe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:34:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A407A4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697661266; x=1729197266;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iNmeuMkJESq2ZVW7vNQdz+bxp+eQ9oYwrESWIg9tEAU=;
  b=CavmMet46YXefN2ZOok/5CW+D7Ge5llH8liBV8/rSdqpr9qtEAZh/Hxp
   RUeunH765zFCn00TRvRytH+Q62w0A2fv8+uQdYU9oTSKojCDRB/phUScH
   WocDfxdRwWOBczGy9GwbxnXQkRj2h7LjDDbuvkIuAIFehBTm3gsirppHF
   xoD6HIR74h7B8bt4N/MSZcGUCYrZFrRJqoNhpkzdrlI1dGK6gf4qsPctw
   ubq0AKQ0ksKTEz2BHOLOLVM8VRRz3kmpA3cdMSUMu1VV7fKWtlcdEk4Js
   uc/0Ta08yD3HI6n8vkVvJO+l+T21D2mWonsle9EFNFBbR75Dav5HL1vld
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="450324833"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="450324833"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 13:34:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="756724138"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="756724138"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 18 Oct 2023 13:34:23 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtDFE-0000zs-2U;
        Wed, 18 Oct 2023 20:34:20 +0000
Date:   Thu, 19 Oct 2023 04:33:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: kernel/trace/trace_kprobe.c:952: warning: Excess function parameter
 'args' description in '__kprobe_event_gen_cmd_start'
Message-ID: <202310190437.paI6LYJF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dd72f9c7e512da377074d47d990564959b772643
commit: 2a588dd1d5d649a183a2ff6fa1b80e870cf821d8 tracing: Add kprobe event command generation functions
date:   3 years, 9 months ago
config: x86_64-randconfig-x012-20230629 (https://download.01.org/0day-ci/archive/20231019/202310190437.paI6LYJF-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231019/202310190437.paI6LYJF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310190437.paI6LYJF-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/trace/trace_kprobe.c:952: warning: Excess function parameter 'args' description in '__kprobe_event_gen_cmd_start'
>> kernel/trace/trace_kprobe.c:1017: warning: Excess function parameter 'args' description in '__kprobe_event_add_fields'


vim +952 kernel/trace/trace_kprobe.c

   929	
   930	/**
   931	 * __kprobe_event_gen_cmd_start - Generate a kprobe event command from arg list
   932	 * @cmd: A pointer to the dynevent_cmd struct representing the new event
   933	 * @name: The name of the kprobe event
   934	 * @loc: The location of the kprobe event
   935	 * @kretprobe: Is this a return probe?
   936	 * @args: Variable number of arg (pairs), one pair for each field
   937	 *
   938	 * NOTE: Users normally won't want to call this function directly, but
   939	 * rather use the kprobe_event_gen_cmd_start() wrapper, which automatically
   940	 * adds a NULL to the end of the arg list.  If this function is used
   941	 * directly, make sure the last arg in the variable arg list is NULL.
   942	 *
   943	 * Generate a kprobe event command to be executed by
   944	 * kprobe_event_gen_cmd_end().  This function can be used to generate the
   945	 * complete command or only the first part of it; in the latter case,
   946	 * kprobe_event_add_fields() can be used to add more fields following this.
   947	 *
   948	 * Return: 0 if successful, error otherwise.
   949	 */
   950	int __kprobe_event_gen_cmd_start(struct dynevent_cmd *cmd, bool kretprobe,
   951					 const char *name, const char *loc, ...)
 > 952	{
   953		char buf[MAX_EVENT_NAME_LEN];
   954		struct dynevent_arg arg;
   955		va_list args;
   956		int ret;
   957	
   958		if (cmd->type != DYNEVENT_TYPE_KPROBE)
   959			return -EINVAL;
   960	
   961		if (kretprobe)
   962			snprintf(buf, MAX_EVENT_NAME_LEN, "r:kprobes/%s", name);
   963		else
   964			snprintf(buf, MAX_EVENT_NAME_LEN, "p:kprobes/%s", name);
   965	
   966		ret = dynevent_str_add(cmd, buf);
   967		if (ret)
   968			return ret;
   969	
   970		dynevent_arg_init(&arg, NULL, 0);
   971		arg.str = loc;
   972		ret = dynevent_arg_add(cmd, &arg);
   973		if (ret)
   974			return ret;
   975	
   976		va_start(args, loc);
   977		for (;;) {
   978			const char *field;
   979	
   980			field = va_arg(args, const char *);
   981			if (!field)
   982				break;
   983	
   984			if (++cmd->n_fields > MAX_TRACE_ARGS) {
   985				ret = -EINVAL;
   986				break;
   987			}
   988	
   989			arg.str = field;
   990			ret = dynevent_arg_add(cmd, &arg);
   991			if (ret)
   992				break;
   993		}
   994		va_end(args);
   995	
   996		return ret;
   997	}
   998	EXPORT_SYMBOL_GPL(__kprobe_event_gen_cmd_start);
   999	
  1000	/**
  1001	 * __kprobe_event_add_fields - Add probe fields to a kprobe command from arg list
  1002	 * @cmd: A pointer to the dynevent_cmd struct representing the new event
  1003	 * @args: Variable number of arg (pairs), one pair for each field
  1004	 *
  1005	 * NOTE: Users normally won't want to call this function directly, but
  1006	 * rather use the kprobe_event_add_fields() wrapper, which
  1007	 * automatically adds a NULL to the end of the arg list.  If this
  1008	 * function is used directly, make sure the last arg in the variable
  1009	 * arg list is NULL.
  1010	 *
  1011	 * Add probe fields to an existing kprobe command using a variable
  1012	 * list of args.  Fields are added in the same order they're listed.
  1013	 *
  1014	 * Return: 0 if successful, error otherwise.
  1015	 */
  1016	int __kprobe_event_add_fields(struct dynevent_cmd *cmd, ...)
> 1017	{
  1018		struct dynevent_arg arg;
  1019		va_list args;
  1020		int ret;
  1021	
  1022		if (cmd->type != DYNEVENT_TYPE_KPROBE)
  1023			return -EINVAL;
  1024	
  1025		dynevent_arg_init(&arg, NULL, 0);
  1026	
  1027		va_start(args, cmd);
  1028		for (;;) {
  1029			const char *field;
  1030	
  1031			field = va_arg(args, const char *);
  1032			if (!field)
  1033				break;
  1034	
  1035			if (++cmd->n_fields > MAX_TRACE_ARGS) {
  1036				ret = -EINVAL;
  1037				break;
  1038			}
  1039	
  1040			arg.str = field;
  1041			ret = dynevent_arg_add(cmd, &arg);
  1042			if (ret)
  1043				break;
  1044		}
  1045		va_end(args);
  1046	
  1047		return ret;
  1048	}
  1049	EXPORT_SYMBOL_GPL(__kprobe_event_add_fields);
  1050	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
