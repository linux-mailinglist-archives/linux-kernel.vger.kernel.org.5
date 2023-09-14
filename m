Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98497A0C1A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240675AbjINSAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240156AbjINSAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:00:04 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4571FF6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 11:00:00 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38EHjnGG029708;
        Thu, 14 Sep 2023 17:59:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=E6jhJ46q+vC7UYQGeKlkJY+GhlfFIxeZk1p+Q/+gNrU=;
 b=hc6XjzyRlibMzpa2L3eCIALI+Z2GTTITEnixA2AY2xvtZ5/Cflwcf4tm6g7mAkcmqWWH
 Xe0dQkUmcyZXxHIPjjYRhLlQiVWxsNYTra8HJYMROpt+y4TeZGCovw+PatRKUQFOYD0I
 OmAqUQq9ixCxnLkzGlLbztuXAQt9li3onDTzN+elhjWOkfomBKNbTwN3NzCvE6bDlY4G
 JvSZb51Ggf/nxtdtjSx3lrYIeDDPLJ6NYSNchv3yoT3o8V26kRwkPC55qVrZDHq3Obg9
 f2R2wGIZhaXxihB3mwCG/ZY6qmKEB7z3pxEtJh/1LY0sbfZ86O0s0kt4B8W76YzTgyoO FQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t46uwgaej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 17:59:41 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38EHntc4009494;
        Thu, 14 Sep 2023 17:59:41 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t46uwgae9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 17:59:41 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38EH8G7X011980;
        Thu, 14 Sep 2023 17:59:40 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t15r2c95s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 17:59:40 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38EHxdem59834646
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 17:59:39 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C9C258059;
        Thu, 14 Sep 2023 17:59:39 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19D2B58058;
        Thu, 14 Sep 2023 17:59:33 +0000 (GMT)
Received: from [9.171.8.153] (unknown [9.171.8.153])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 14 Sep 2023 17:59:32 +0000 (GMT)
Message-ID: <46ef47cf-4aea-65ed-09e1-ad8562b4e693@linux.vnet.ibm.com>
Date:   Thu, 14 Sep 2023 23:29:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3] sched/topology: remove sysctl_sched_energy_aware
 depending on the architecture
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, dietmar.eggemann@arm.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com, quentin.perret@arm.com,
        srikar@linux.vnet.ibm.com, mgorman@techsingularity.net,
        mingo@kernel.org, pierre.gondois@arm.com, yu.c.chen@intel.com,
        tim.c.chen@linux.intel.com, mingo@redhat.com,
        vincent.guittot@linaro.org
References: <20230913114807.665094-1-sshegde@linux.vnet.ibm.com>
 <202309140704.YiAtZ0yy-lkp@intel.com>
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <202309140704.YiAtZ0yy-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6V250cDZOlXXqWgBpF__an2MJQRrABCz
X-Proofpoint-ORIG-GUID: C0iHTg7QUWL7vWFXQjz4T-e77ej6V-o6
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_09,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140152
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/14/23 5:31 AM, kernel test robot wrote:
> Hi Shrikanth,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on tip/sched/core]
> [also build test WARNING on linus/master v6.6-rc1 next-20230913]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Shrikanth-Hegde/sched-topology-remove-sysctl_sched_energy_aware-depending-on-the-architecture/20230913-195055
> base:   tip/sched/core
> patch link:    https://lore.kernel.org/r/20230913114807.665094-1-sshegde%40linux.vnet.ibm.com
> patch subject: [PATCH v3] sched/topology: remove sysctl_sched_energy_aware depending on the architecture
> config: x86_64-buildonly-randconfig-003-20230914 (https://download.01.org/0day-ci/archive/20230914/202309140704.YiAtZ0yy-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230914/202309140704.YiAtZ0yy-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202309140704.YiAtZ0yy-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from kernel/sched/build_utility.c:89:
>>> kernel/sched/topology.c:212:33: warning: 'sysctl_eas_header' defined but not used [-Wunused-variable]
>      212 | static struct ctl_table_header *sysctl_eas_header;
>          |                                 ^~~~~~~~~~~~~~~~~
> 

Hi. 

Thanks for pointing it out. This could be done by setting CONFIG_PROC_SYSCTL=n
have refactored the code and it likely make it simpler. will send out v4. 


> 
> vim +/sysctl_eas_header +212 kernel/sched/topology.c
> 
>    208	
>    209	#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
>    210	DEFINE_STATIC_KEY_FALSE(sched_energy_present);
>    211	static unsigned int sysctl_sched_energy_aware;
>  > 212	static struct ctl_table_header *sysctl_eas_header;
>    213	static DEFINE_MUTEX(sched_energy_mutex);
>    214	static bool sched_energy_update;
>    215	static bool is_sysctl_eas_changing;
>    216	
> 
