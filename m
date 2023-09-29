Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F3C7B3664
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbjI2PIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbjI2PIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:08:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C4ED6;
        Fri, 29 Sep 2023 08:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696000114; x=1727536114;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5RnBCSPEAzJPSAoQ/ZXC5vJGMkDh3xOlQXMwTkGu25w=;
  b=Z+MdlnaCdZfi6P0QtP1T5Ero7PRPV6AMNyMcxxuTjif9BealwVGt1aEt
   1S9wqfHCroWSDEHzzfq5n3nP4X0a0OeJ0LSwZhjU94hfierzDEm8o/LKb
   3vVrVFCulorNTftVQFh+Nz94rCiutfya5obx7ofSnUjSyxRF6ZkYz614d
   ZLEyDMZk3j4gNB/YRok1T7c3P4ZiLc7m6SS21ZyFcy1A7VWnFHMKatie5
   Lh7lJF8mtSAXQedDlsmTjMBleGUyWJSIFrFx9OxhXgBmc8ennwmUXiwTm
   lIggRetBni1k+xT845Jqg2VE9lS+qGTlvgEoECSm5TjvDzoCUglTjcgyi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="3887367"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="3887367"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 08:08:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="743464516"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="743464516"
Received: from smorozov-mobl1.ger.corp.intel.com ([10.252.52.167])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 08:08:14 -0700
Date:   Fri, 29 Sep 2023 18:08:11 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Babu Moger <babu.moger@amd.com>
cc:     corbet@lwn.net, Reinette Chatre <reinette.chatre@intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
Subject: Re: [PATCH v10 01/10] x86/resctrl: Add multiple tasks to the resctrl
 group at once
In-Reply-To: <20230915224227.1336967-2-babu.moger@amd.com>
Message-ID: <46e4b492-f79d-fdda-9434-56f16e9443@linux.intel.com>
References: <20230915224227.1336967-1-babu.moger@amd.com> <20230915224227.1336967-2-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1993037258-1696000102=:1989"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1993037258-1696000102=:1989
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 15 Sep 2023, Babu Moger wrote:

> The resctrl task assignment for monitor or control group needs to be
> done one at a time. For example:
> 
>   $mount -t resctrl resctrl /sys/fs/resctrl/
>   $mkdir /sys/fs/resctrl/ctrl_grp1
>   $echo 123 > /sys/fs/resctrl/ctrl_grp1/tasks
>   $echo 456 > /sys/fs/resctrl/ctrl_grp1/tasks
>   $echo 789 > /sys/fs/resctrl/ctrl_grp1/tasks
> 
> This is not user-friendly when dealing with hundreds of tasks.
> 
> Support multiple task assignment in one command with tasks ids separated
> by commas. For example:
>   $echo 123,456,789 > /sys/fs/resctrl/ctrl_grp1/tasks
> 
> Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  Documentation/arch/x86/resctrl.rst     |  9 ++++++++-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 25 ++++++++++++++++++++++---
>  2 files changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index cb05d90111b4..8154e9975d1e 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -299,7 +299,14 @@ All groups contain the following files:
>  "tasks":
>  	Reading this file shows the list of all tasks that belong to
>  	this group. Writing a task id to the file will add a task to the
> -	group. If the group is a CTRL_MON group the task is removed from
> +	group. Multiple tasks can be added by separating the task ids
> +	with commas. Tasks will be assigned sequentially. Multiple
> +	failures are not supported. A single failure encountered while
> +	attempting to assign a task will cause the operation to abort and
> +	already added tasks before the failure will remain in the group.
> +	Failures will be logged to /sys/fs/resctrl/info/last_cmd_status.
> +
> +	If the group is a CTRL_MON group the task is removed from
>  	whichever previous CTRL_MON group owned the task and also from
>  	any MON group that owned the task. If the group is a MON group,
>  	then the task must already belong to the CTRL_MON parent of this
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 725344048f85..f0d163950969 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -696,11 +696,10 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
>  				    char *buf, size_t nbytes, loff_t off)
>  {
>  	struct rdtgroup *rdtgrp;
> +	char *pid_str;
>  	int ret = 0;
>  	pid_t pid;
>  
> -	if (kstrtoint(strstrip(buf), 0, &pid) || pid < 0)
> -		return -EINVAL;
>  	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>  	if (!rdtgrp) {
>  		rdtgroup_kn_unlock(of->kn);
> @@ -715,7 +714,27 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
>  		goto unlock;
>  	}
>  
> -	ret = rdtgroup_move_task(pid, rdtgrp, of);
> +	while (buf && buf[0] != '\0' && buf[0] != '\n') {
> +		pid_str = strim(strsep(&buf, ","));
> +
> +		if (kstrtoint(pid_str, 0, &pid)) {
> +			rdt_last_cmd_printf("Task list parsing error pid %s\n", pid_str);
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		if (pid < 0) {
> +			rdt_last_cmd_printf("Invalid pid %d\n", pid);
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		ret = rdtgroup_move_task(pid, rdtgrp, of);
> +		if (ret) {
> +			rdt_last_cmd_printf("Error while processing task %d\n", pid);
> +			break;
> +		}
> +	}
>  
>  unlock:
>  	rdtgroup_kn_unlock(of->kn);
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1993037258-1696000102=:1989--
