Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F82877823D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 22:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbjHJUji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 16:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjHJUjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 16:39:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B22190
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 13:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691699976; x=1723235976;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JTD3Owe/y8oFr/7EH3CBnZlvpyMo3oQFkQYXfLhTLZE=;
  b=hv2XG4cw/AE5bhfibIuP4LIxDfOlKfJCGfvjI8mPA+ulnh4CdDzcEZwS
   R2vGpwxIcT5SxKf79skWKFuyMpSl79avTZTlyXtewM0VT7HOzk6urs1j7
   U7qFNcPOx0xec2n+ANuqWRYFo+HGIjCGDfbD9xUCCGokg13LTfBaJLY8D
   Kf3KH/e3w707AESFtkCfnkVycsaIzeO5ll7Vs/ILN+bZcE/h/M+MJANMx
   ucllMUyFBo4L6eSqyi5PlwOuNwUxeI8EPdKVPcMCzZf3FhOI1zBl8PJsC
   rHopNHvPFsGeq4hbgR7sAIzo+xCWHh/TDcUd/YGUV3sxMmgkeCg5FfaA2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="368992386"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="368992386"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 13:39:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="725976546"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="725976546"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 10 Aug 2023 13:39:19 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qUCRC-0007Ef-1y;
        Thu, 10 Aug 2023 20:39:18 +0000
Date:   Fri, 11 Aug 2023 04:38:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     zhanghao1 <zhanghao1@kylinos.cn>,
        virtualization@lists.linux-foundation.org
Cc:     oe-kbuild-all@lists.linux.dev, mst@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org,
        zhanghao1 <zhanghao1@kylinos.cn>
Subject: Re: [PATCH] A new virtio pci driver is added for listening to vcpus
 inside guest. Each vcpu creates a corresponding thread to periodically send
 data to qemu's back-end watchdog device.
Message-ID: <202308110442.0tXLNEKs-lkp@intel.com>
References: <20230731012405.234611-1-zhanghao1@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731012405.234611-1-zhanghao1@kylinos.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi zhanghao1,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.5-rc5 next-20230809]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/zhanghao1/A-new-virtio-pci-driver-is-added-for-listening-to-vcpus-inside-guest-Each-vcpu-creates-a-corresponding-thread-to-periodi/20230731-092546
base:   linus/master
patch link:    https://lore.kernel.org/r/20230731012405.234611-1-zhanghao1%40kylinos.cn
patch subject: [PATCH] A new virtio pci driver is added for listening to vcpus inside guest. Each vcpu creates a corresponding thread to periodically send data to qemu's back-end watchdog device.
config: sparc64-randconfig-r071-20230811 (https://download.01.org/0day-ci/archive/20230811/202308110442.0tXLNEKs-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230811/202308110442.0tXLNEKs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308110442.0tXLNEKs-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/virtio/virtio_vcpu_stall_detector.c:76:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct vcpu_stall_priv * @@
   drivers/virtio/virtio_vcpu_stall_detector.c:76:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/virtio/virtio_vcpu_stall_detector.c:76:17: sparse:     got struct vcpu_stall_priv *
>> drivers/virtio/virtio_vcpu_stall_detector.c:89:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] ticks @@     got restricted __virtio32 @@
   drivers/virtio/virtio_vcpu_stall_detector.c:89:37: sparse:     expected unsigned int [usertype] ticks
   drivers/virtio/virtio_vcpu_stall_detector.c:89:37: sparse:     got restricted __virtio32
   drivers/virtio/virtio_vcpu_stall_detector.c:117:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct vcpu_stall_priv * @@
   drivers/virtio/virtio_vcpu_stall_detector.c:117:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/virtio/virtio_vcpu_stall_detector.c:117:17: sparse:     got struct vcpu_stall_priv *
   drivers/virtio/virtio_vcpu_stall_detector.c:129:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] ticks @@     got restricted __virtio32 @@
   drivers/virtio/virtio_vcpu_stall_detector.c:129:37: sparse:     expected unsigned int [usertype] ticks
   drivers/virtio/virtio_vcpu_stall_detector.c:129:37: sparse:     got restricted __virtio32
>> drivers/virtio/virtio_vcpu_stall_detector.c:193:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct vcpu_stall_priv *priv @@     got struct vcpu_stall_priv [noderef] __percpu * @@
   drivers/virtio/virtio_vcpu_stall_detector.c:193:26: sparse:     expected struct vcpu_stall_priv *priv
   drivers/virtio/virtio_vcpu_stall_detector.c:193:26: sparse:     got struct vcpu_stall_priv [noderef] __percpu *
   drivers/virtio/virtio_vcpu_stall_detector.c:203:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct vcpu_stall_priv * @@
   drivers/virtio/virtio_vcpu_stall_detector.c:203:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/virtio/virtio_vcpu_stall_detector.c:203:24: sparse:     got struct vcpu_stall_priv *
>> drivers/virtio/virtio_vcpu_stall_detector.c:207:15: sparse: sparse: no generic selection for 'unsigned int virtio_cread_v'
>> drivers/virtio/virtio_vcpu_stall_detector.c:207:15: sparse: sparse: incompatible types in comparison expression (different base types):
>> drivers/virtio/virtio_vcpu_stall_detector.c:207:15: sparse:    bad type *
>> drivers/virtio/virtio_vcpu_stall_detector.c:207:15: sparse:    unsigned int *
>> drivers/virtio/virtio_vcpu_stall_detector.c:207:15: sparse: sparse: no generic selection for 'unsigned int [addressable] virtio_cread_v'
   drivers/virtio/virtio_vcpu_stall_detector.c:217:15: sparse: sparse: no generic selection for 'unsigned int virtio_cread_v'
   drivers/virtio/virtio_vcpu_stall_detector.c:217:15: sparse: sparse: incompatible types in comparison expression (different base types):
   drivers/virtio/virtio_vcpu_stall_detector.c:217:15: sparse:    bad type *
   drivers/virtio/virtio_vcpu_stall_detector.c:217:15: sparse:    unsigned int *
   drivers/virtio/virtio_vcpu_stall_detector.c:217:15: sparse: sparse: no generic selection for 'unsigned int [addressable] virtio_cread_v'

vim +76 drivers/virtio/virtio_vcpu_stall_detector.c

    67	
    68	static enum hrtimer_restart
    69	vcpu_stall_detect_timer_fn(struct hrtimer *hrtimer)
    70	{
    71		u32 ticks, ping_timeout_ms;
    72		struct scatterlist sg;
    73		int unused, err = 0;
    74	
    75		struct vcpu_stall_priv *vcpu_stall_detector =
  > 76			this_cpu_ptr(vcpu_stall->priv);
    77	
    78		/* Reload the stall detector counter register every
    79		 * `ping_timeout_ms` to prevent the virtual device
    80		 * from decrementing it to 0. The virtual device decrements this
    81		 * register at 'clock_freq_hz' frequency.
    82		 */
    83		ticks = vcpu_stall_config.clock_freq_hz *
    84					vcpu_stall_config.stall_timeout_sec;
    85	
    86		spin_lock(&vcpu_stall->lock);
    87		while (virtqueue_get_buf(vcpu_stall->vq, &unused))
    88			;
  > 89		vcpu_stall->pet_event.ticks = cpu_to_virtio32(vcpu_stall_detector->vdev, ticks);
    90		vcpu_stall->pet_event.is_initialized = true;
    91		vcpu_stall->pet_event.cpu_id = vcpu_stall_detector->cpu_id;
    92	
    93		sg_init_one(&sg, &vcpu_stall->pet_event, sizeof(vcpu_stall->pet_event));
    94		err = virtqueue_add_outbuf(vcpu_stall->vq, &sg, 1, vcpu_stall, GFP_ATOMIC);
    95		if (!err)
    96			virtqueue_kick(vcpu_stall->vq);
    97		else
    98			pr_err("cpu:%d failed to add outbuf, err:%d\n", vcpu_stall_detector->cpu_id, err);
    99	
   100		spin_unlock(&vcpu_stall->lock);
   101	
   102		ping_timeout_ms = vcpu_stall_config.stall_timeout_sec *
   103				  MSEC_PER_SEC / 2;
   104		hrtimer_forward_now(hrtimer,
   105				    ms_to_ktime(ping_timeout_ms));
   106		return HRTIMER_RESTART;
   107	}
   108	
   109	static int start_stall_detector_cpu(unsigned int cpu)
   110	{
   111		u32 ticks, ping_timeout_ms;
   112		struct scatterlist sg;
   113		struct hrtimer *vcpu_hrtimer;
   114		int err = 0;
   115	
   116		struct vcpu_stall_priv *vcpu_stall_detector =
   117			this_cpu_ptr(vcpu_stall->priv);
   118	
   119		vcpu_stall_detector->cpu_id = cpu;
   120	
   121		vcpu_hrtimer = &vcpu_stall_detector->vcpu_hrtimer;
   122	
   123		/* Compute the number of ticks required for the stall detector
   124		 * counter register based on the internal clock frequency and the
   125		 * timeout value given from the device tree.
   126		 */
   127		ticks = vcpu_stall_config.clock_freq_hz *
   128			vcpu_stall_config.stall_timeout_sec;
   129		vcpu_stall->pet_event.ticks = cpu_to_virtio32(vcpu_stall_detector->vdev, ticks);
   130	
   131		/* Pet the stall detector at half of its expiration timeout
   132		 * to prevent spurious resets.
   133		 */
   134		ping_timeout_ms = vcpu_stall_config.stall_timeout_sec *
   135				  MSEC_PER_SEC / 2;
   136	
   137		hrtimer_init(vcpu_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
   138		vcpu_hrtimer->function = vcpu_stall_detect_timer_fn;
   139	
   140		vcpu_stall->pet_event.is_initialized = true;
   141	
   142		spin_lock(&vcpu_stall->lock);
   143		vcpu_stall->pet_event.cpu_id = cpu;
   144		sg_init_one(&sg, &vcpu_stall->pet_event, sizeof(vcpu_stall->pet_event));
   145		err = virtqueue_add_outbuf(vcpu_stall->vq, &sg, 1, vcpu_stall, GFP_ATOMIC);
   146		if (!err)
   147			virtqueue_kick(vcpu_stall->vq);
   148	
   149		spin_unlock(&vcpu_stall->lock);
   150	
   151		hrtimer_start(vcpu_hrtimer, ms_to_ktime(ping_timeout_ms),
   152			      HRTIMER_MODE_REL_PINNED);
   153		return err;
   154	}
   155	
   156	static int stop_stall_detector_cpu(unsigned int cpu)
   157	{
   158		int err = 0;
   159		struct scatterlist sg;
   160	
   161		struct vcpu_stall_priv *vcpu_stall_detector =
   162			per_cpu_ptr(vcpu_stall_detectors, cpu);
   163	
   164		/* Disable the stall detector for the current CPU */
   165		hrtimer_cancel(&vcpu_stall_detector->vcpu_hrtimer);
   166		vcpu_stall->pet_event.is_initialized = false;
   167		vcpu_stall->pet_event.cpu_id = cpu;
   168	
   169		spin_lock(&vcpu_stall->lock);
   170		sg_init_one(&sg, &vcpu_stall->pet_event, sizeof(vcpu_stall->pet_event));
   171		err = virtqueue_add_outbuf(vcpu_stall->vq, &sg, 1, vcpu_stall, GFP_ATOMIC);
   172		if (!err)
   173			virtqueue_kick(vcpu_stall->vq);
   174	
   175		spin_unlock(&vcpu_stall->lock);
   176	
   177		return err;
   178	}
   179	
   180	static int vcpu_stall_detect_probe(struct virtio_device *vdev)
   181	{
   182		int ret, cpu;
   183		u32 clock_freq_hz = VCPU_STALL_DEFAULT_CLOCK_HZ;
   184		u32 stall_timeout_sec = VCPU_STALL_DEFAULT_TIMEOUT_SEC;
   185	
   186		vcpu_stall = kzalloc(sizeof(struct vcpu_stall), GFP_KERNEL);
   187		if (!vcpu_stall) {
   188			ret = -ENOMEM;
   189			goto err;
   190		}
   191		vdev->priv = vcpu_stall;
   192	
 > 193		vcpu_stall->priv = devm_alloc_percpu(&vdev->dev,
   194						typeof(struct vcpu_stall_priv));
   195		if (!vcpu_stall->priv) {
   196			ret = -ENOMEM;
   197			goto failed_priv;
   198		}
   199	
   200		for_each_possible_cpu(cpu) {
   201			struct vcpu_stall_priv *priv;
   202	
   203			priv = per_cpu_ptr(vcpu_stall->priv, cpu);
   204			priv->vdev = vdev;
   205		}
   206	
 > 207		ret = virtio_cread_feature(vdev, VCPU_STALL_REG_CLOCK_FREQ_HZ,
   208							struct vcpu_stall_detect_config, clock_freq_hz,
   209							&clock_freq_hz);
   210		if (ret || !clock_freq_hz) {
   211			if (!(clock_freq_hz > 0 &&
   212			      clock_freq_hz < VCPU_STALL_MAX_CLOCK_HZ)) {
   213				dev_warn(&vdev->dev, "clk out of range\n");
   214				clock_freq_hz = VCPU_STALL_DEFAULT_CLOCK_HZ;
   215			}
   216		}
   217		ret = virtio_cread_feature(vdev, VCPU_STALL_REG_TIMEOUT_SEC,
   218							struct vcpu_stall_detect_config, stall_timeout_sec,
   219							&stall_timeout_sec);
   220		if (ret || !stall_timeout_sec) {
   221			if (!(stall_timeout_sec > 0 &&
   222			      stall_timeout_sec < VCPU_STALL_MAX_TIMEOUT_SEC)) {
   223				dev_warn(&vdev->dev, "stall timeout out of range\n");
   224				stall_timeout_sec = VCPU_STALL_DEFAULT_TIMEOUT_SEC;
   225			}
   226		}
   227	
   228		vcpu_stall_config = (struct vcpu_stall_detect_config) {
   229			.clock_freq_hz		= clock_freq_hz,
   230			.stall_timeout_sec	= stall_timeout_sec
   231		};
   232	
   233		/* find virtqueue for guest to send pet event to host */
   234		vcpu_stall->vq = virtio_find_single_vq(vdev, NULL, "pet-event");
   235		if (IS_ERR(vcpu_stall->vq)) {
   236			dev_err(&vdev->dev, "failed to find vq\n");
   237			goto failed_priv;
   238		}
   239	
   240		spin_lock_init(&vcpu_stall->lock);
   241	
   242		ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
   243					"virt/vcpu_stall_detector:online",
   244					start_stall_detector_cpu,
   245					stop_stall_detector_cpu);
   246		if (ret < 0) {
   247			dev_err(&vdev->dev, "failed to install cpu hotplug\n");
   248			goto failed_priv;
   249		}
   250	
   251		vcpu_stall_config.hp_online = ret;
   252		return 0;
   253	
   254	
   255	failed_priv:
   256		kfree(vcpu_stall);
   257	err:
   258		return ret;
   259	}
   260	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
