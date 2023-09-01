Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7453678F897
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 08:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346029AbjIAGci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 02:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjIAGcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 02:32:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DD09E;
        Thu, 31 Aug 2023 23:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693549953; x=1725085953;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/pxsW55MVBsOzk6oCbE/5pKPjqBXhRXgd1iOPD4l0p0=;
  b=XnqhoRt2YtfVmW8XewyCIr3wJfMGTpqbuColLDG9rR0RJT+/tTone6Ko
   1/wJ/ofZzQgjSAGGNe+265tA4UuT3erkEDpxJfmNLsSktn2HY3Dw19B35
   RvEILaYflE2uGSJ1qd9EDoI60jWGU2Gn/G4j9UUi5hK1TZqhX9joAK5Gg
   gRmFTnZxCbDj17/vNwscHRyMFO7FJmkdAmBweazno2xGtwbxAKbQW8BER
   PxcLYge5shgKQaoHGH8bVBaaL2o3715v5JOX4aSrNA9WY2tS4vgob3A3h
   DKxzUZyRWpvHmwhTkwYJCKX/mM/yfOJDiO3hAtoY4JO6OZKGbpP/zX/Fq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="440128573"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="440128573"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 23:32:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="689642590"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="689642590"
Received: from lkp-server01.sh.intel.com (HELO 5d8055a4f6aa) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 31 Aug 2023 23:32:28 -0700
Received: from kbuild by 5d8055a4f6aa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qbxhi-00010F-02;
        Fri, 01 Sep 2023 06:32:26 +0000
Date:   Fri, 1 Sep 2023 14:31:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Ekansh Gupta <quic_ekangupt@quicinc.com>,
        ekangupt@qti.qualcomm.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, fastrpc.upstream@qti.qualcomm.com
Subject: Re: [PATCH v1 5/5] misc: fastrpc: Add support to allocate shared
 context bank
Message-ID: <202309011446.SVM4HbHv-lkp@intel.com>
References: <1693499292-19083-6-git-send-email-quic_ekangupt@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1693499292-19083-6-git-send-email-quic_ekangupt@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ekansh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on char-misc/char-misc-next char-misc/char-misc-linus linus/master v6.5 next-20230831]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ekansh-Gupta/misc-fastrpc-Add-fastrpc-multimode-invoke-request-support/20230901-002929
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/1693499292-19083-6-git-send-email-quic_ekangupt%40quicinc.com
patch subject: [PATCH v1 5/5] misc: fastrpc: Add support to allocate shared context bank
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230901/202309011446.SVM4HbHv-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230901/202309011446.SVM4HbHv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309011446.SVM4HbHv-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/misc/fastrpc.c: In function 'fastrpc_context_alloc':
   drivers/misc/fastrpc.c:674:29: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     674 |                 ctx->args = (struct fastrpc_invoke_args *)invoke->inv.args;
         |                             ^
   drivers/misc/fastrpc.c: In function 'fastrpc_init_create_static_process':
   drivers/misc/fastrpc.c:1540:26: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1540 |         ioctl.inv.args = (__u64)args;
         |                          ^
   drivers/misc/fastrpc.c: In function 'fastrpc_init_create_process':
   drivers/misc/fastrpc.c:1677:26: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1677 |         ioctl.inv.args = (__u64)args;
         |                          ^
   drivers/misc/fastrpc.c: In function 'fastrpc_release_current_dsp_process':
   drivers/misc/fastrpc.c:1730:26: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1730 |         ioctl.inv.args = (__u64)args;
         |                          ^
   drivers/misc/fastrpc.c: In function 'fastrpc_device_release':
   drivers/misc/fastrpc.c:1739:42: warning: unused variable 'n' [-Wunused-variable]
    1739 |         struct fastrpc_invoke_ctx *ctx, *n;
         |                                          ^
   drivers/misc/fastrpc.c:1739:36: warning: unused variable 'ctx' [-Wunused-variable]
    1739 |         struct fastrpc_invoke_ctx *ctx, *n;
         |                                    ^~~
   drivers/misc/fastrpc.c: In function 'fastrpc_init_attach':
   drivers/misc/fastrpc.c:1871:26: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1871 |         ioctl.inv.args = (__u64)args;
         |                          ^
   drivers/misc/fastrpc.c: In function 'fastrpc_invoke':
   drivers/misc/fastrpc.c:1902:26: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1902 |         ioctl.inv.args = (__u64)args;
         |                          ^
   drivers/misc/fastrpc.c: In function 'fastrpc_internal_control':
   drivers/misc/fastrpc.c:1920:14: error: 'FASTRPC_CONTROL_SMMU' undeclared (first use in this function); did you mean 'FASTRPC_IOCTL_MMAP'?
    1920 |         case FASTRPC_CONTROL_SMMU:
         |              ^~~~~~~~~~~~~~~~~~~~
         |              FASTRPC_IOCTL_MMAP
   drivers/misc/fastrpc.c:1920:14: note: each undeclared identifier is reported only once for each function it appears in
   drivers/misc/fastrpc.c:1920:9: error: case label not within a switch statement
    1920 |         case FASTRPC_CONTROL_SMMU:
         |         ^~~~
   drivers/misc/fastrpc.c:1922:17: error: break statement not within loop or switch
    1922 |                 break;
         |                 ^~~~~
   drivers/misc/fastrpc.c:1923:9: error: 'default' label not within a switch statement
    1923 |         default:
         |         ^~~~~~~
   drivers/misc/fastrpc.c:1925:17: error: break statement not within loop or switch
    1925 |                 break;
         |                 ^~~~~
>> drivers/misc/fastrpc.c:1913:13: warning: variable 'err' set but not used [-Wunused-but-set-variable]
    1913 |         int err = 0;
         |             ^~~
   drivers/misc/fastrpc.c: At top level:
   drivers/misc/fastrpc.c:1927:9: error: expected identifier or '(' before 'return'
    1927 |         return err;
         |         ^~~~~~
   drivers/misc/fastrpc.c:1928:1: error: expected identifier or '(' before '}' token
    1928 | }
         | ^
   drivers/misc/fastrpc.c: In function 'fastrpc_multimode_invoke':
   drivers/misc/fastrpc.c:1964:33: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1964 |                 einv.inv.args = (__u64)args;
         |                                 ^
   drivers/misc/fastrpc.c: In function 'fastrpc_get_info_from_dsp':
   drivers/misc/fastrpc.c:2000:26: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    2000 |         ioctl.inv.args = (__u64)args;
         |                          ^
   drivers/misc/fastrpc.c: In function 'fastrpc_req_munmap_impl':
   drivers/misc/fastrpc.c:2103:26: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    2103 |         ioctl.inv.args = (__u64)args;
         |                          ^
   drivers/misc/fastrpc.c: In function 'fastrpc_req_mmap':
   drivers/misc/fastrpc.c:2201:26: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    2201 |         ioctl.inv.args = (__u64)args;
         |                          ^
   drivers/misc/fastrpc.c: In function 'fastrpc_req_mem_unmap_impl':
   drivers/misc/fastrpc.c:2282:26: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    2282 |         ioctl.inv.args = (__u64)args;
         |                          ^
   drivers/misc/fastrpc.c: In function 'fastrpc_req_mem_map':
   drivers/misc/fastrpc.c:2351:26: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    2351 |         ioctl.inv.args = (__u64)args;
         |                          ^
   drivers/misc/fastrpc.c: In function 'fastrpc_internal_control':
   drivers/misc/fastrpc.c:1926:9: error: control reaches end of non-void function [-Werror=return-type]
    1926 |         }
         |         ^
   cc1: some warnings being treated as errors


vim +/err +1913 drivers/misc/fastrpc.c

  1909	
  1910	static int fastrpc_internal_control(struct fastrpc_user *fl,
  1911						struct fastrpc_internal_control *cp)
  1912	{
> 1913		int err = 0;
  1914	
  1915		if (!fl)
  1916			return -EBADF;
  1917		if (!cp)
  1918			return -EINVAL;
  1919	
  1920		case FASTRPC_CONTROL_SMMU:
  1921			fl->sharedcb = cp->smmu.sharedcb;
> 1922			break;
  1923		default:
  1924			err = -EBADRQC;
  1925			break;
  1926		}
  1927		return err;
  1928	}
  1929	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
