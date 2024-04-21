Return-Path: <linux-kernel+bounces-152462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B1D8ABED3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 10:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBA1D1C208BC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 08:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD0F101C4;
	Sun, 21 Apr 2024 08:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kbokX4Dy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82B410A03;
	Sun, 21 Apr 2024 08:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713689390; cv=none; b=RTp/2zhTskN364EPpuYXv+7/f8XHv6oJ4/XtTptbhY2F36UDh7lmMitZLr/jtKWzW00z8QQIt4S7e4l21fp67H4KDnW7u6SHCzofXrMT0hleUNN6dmTrL2O9RAe9e0N+HBBiuoyh7JZsMCJz7otiBoSQdjgh3TrfH5F24eZ9vcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713689390; c=relaxed/simple;
	bh=xM9lXqlYZOpwamIi6wqW2Ib1u9BbnYJVFjHkfNNDcQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBilUCXAH2HSFlqfCVx9MXdWduis6DlowWP/qjIKMHeypWb5XOTHfC1HngT0W4Qk4mWO9iDWPHf4/LM4nwLtFEEYUVgYNbGLIFfiJt5/56+OqM5JuTct8odKw56ED+QfjZNw01XoqUY/rATPRek67UKMLwk4oW9fl/JwblTf/14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kbokX4Dy; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713689388; x=1745225388;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xM9lXqlYZOpwamIi6wqW2Ib1u9BbnYJVFjHkfNNDcQU=;
  b=kbokX4DyWEEBhoiepGr2aNZS4gpGQCmW9jjo8jYUw8I7R/A/+VZjkzcp
   7OQeVTkHdK7JQW+9c/JYHx0qr2FudjD0G8KxXSJ7ntQv1u1NCkQ+MIdKI
   Jqi5tb7k+SZgTTPTLC83lHC/W3eQgPVUklMCcRefYesdD2mUTdkvHwll/
   5mQ6/+/wPKatBxtGa6k8xRoAxVlhhqo6BIFBcRPSpYFmqeLOr/iM9ekSn
   zUuhAzc7janT1MWPQKLkwvwqvVBPBgzTpP8Dxtqy7huzMlAUF5c+UkZE3
   JMmbw7bZB353h5zyc4qW0YrugVQLvOzKPaL9KJURjPi/PB6X+aMhs9C8d
   w==;
X-CSE-ConnectionGUID: rbnzgxu8TbmarVs7RyRDXA==
X-CSE-MsgGUID: 93gYRwtgTVej/9oQ1yWWeA==
X-IronPort-AV: E=McAfee;i="6600,9927,11050"; a="9073131"
X-IronPort-AV: E=Sophos;i="6.07,218,1708416000"; 
   d="scan'208";a="9073131"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2024 01:49:47 -0700
X-CSE-ConnectionGUID: u2lN+IqUTRuMfKsVTFbUOA==
X-CSE-MsgGUID: 12Q7yg7+QIqL7BIOirSgNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,218,1708416000"; 
   d="scan'208";a="23780258"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 21 Apr 2024 01:49:42 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ryStI-000Bp8-1S;
	Sun, 21 Apr 2024 08:49:40 +0000
Date: Sun, 21 Apr 2024 16:49:28 +0800
From: kernel test robot <lkp@intel.com>
To: Sibi Sankar <quic_sibis@quicinc.com>, sudeep.holla@arm.com,
	cristian.marussi@arm.com, andersson@kernel.org,
	konrad.dybcio@linaro.org, jassisinghbrar@gmail.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	dmitry.baryshkov@linaro.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	quic_rgottimu@quicinc.com, quic_kshivnan@quicinc.com,
	quic_sibis@quicinc.com, conor+dt@kernel.org,
	quic_gkohli@quicinc.com, quic_nkela@quicinc.com,
	quic_psodagud@quicinc.com
Subject: Re: [PATCH V3 2/5] mailbox: Add support for QTI CPUCP mailbox
 controller
Message-ID: <202404211602.d8vcGEH0-lkp@intel.com>
References: <20240417132856.1106250-3-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417132856.1106250-3-quic_sibis@quicinc.com>

Hi Sibi,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.9-rc4 next-20240419]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sibi-Sankar/dt-bindings-mailbox-qcom-Add-CPUCP-mailbox-controller-bindings/20240417-213339
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240417132856.1106250-3-quic_sibis%40quicinc.com
patch subject: [PATCH V3 2/5] mailbox: Add support for QTI CPUCP mailbox controller
config: hexagon-randconfig-r121-20240421 (https://download.01.org/0day-ci/archive/20240421/202404211602.d8vcGEH0-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20240421/202404211602.d8vcGEH0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404211602.d8vcGEH0-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/mailbox/qcom-cpucp-mbox.c:6:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/mailbox/qcom-cpucp-mbox.c:6:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/mailbox/qcom-cpucp-mbox.c:6:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
>> drivers/mailbox/qcom-cpucp-mbox.c:61:11: error: call to undeclared function 'readq'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
           status = readq(cpucp->rx_base + APSS_CPUCP_RX_MBOX_STAT);
                    ^
>> drivers/mailbox/qcom-cpucp-mbox.c:71:4: error: call to undeclared function 'writeq'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
                           writeq(BIT(i), cpucp->rx_base + APSS_CPUCP_RX_MBOX_CLEAR);
                           ^
   drivers/mailbox/qcom-cpucp-mbox.c:85:8: error: call to undeclared function 'readq'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
           val = readq(cpucp->rx_base + APSS_CPUCP_RX_MBOX_EN);
                 ^
   drivers/mailbox/qcom-cpucp-mbox.c:87:2: error: call to undeclared function 'writeq'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
           writeq(val, cpucp->rx_base + APSS_CPUCP_RX_MBOX_EN);
           ^
   drivers/mailbox/qcom-cpucp-mbox.c:98:8: error: call to undeclared function 'readq'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
           val = readq(cpucp->rx_base + APSS_CPUCP_RX_MBOX_EN);
                 ^
   drivers/mailbox/qcom-cpucp-mbox.c:100:2: error: call to undeclared function 'writeq'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
           writeq(val, cpucp->rx_base + APSS_CPUCP_RX_MBOX_EN);
           ^
   drivers/mailbox/qcom-cpucp-mbox.c:140:2: error: call to undeclared function 'writeq'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
           writeq(0, cpucp->rx_base + APSS_CPUCP_RX_MBOX_EN);
           ^
   6 warnings and 7 errors generated.


vim +/readq +61 drivers/mailbox/qcom-cpucp-mbox.c

    51	
    52	static irqreturn_t qcom_cpucp_mbox_irq_fn(int irq, void *data)
    53	{
    54		struct qcom_cpucp_mbox *cpucp = data;
    55		struct mbox_chan *chan;
    56		unsigned long flags;
    57		u64 status;
    58		u32 val;
    59		int i;
    60	
  > 61		status = readq(cpucp->rx_base + APSS_CPUCP_RX_MBOX_STAT);
    62	
    63		for (i = 0; i < APSS_CPUCP_IPC_CHAN_SUPPORTED; i++) {
    64			val = 0;
    65			if (status & BIT(i)) {
    66				val = readl(cpucp->rx_base + APSS_CPUCP_RX_MBOX_CMD(i) + APSS_CPUCP_MBOX_CMD_OFF);
    67				chan = &cpucp->chans[i];
    68				spin_lock_irqsave(&chan->lock, flags);
    69				if (chan->cl)
    70					mbox_chan_received_data(chan, &val);
  > 71				writeq(BIT(i), cpucp->rx_base + APSS_CPUCP_RX_MBOX_CLEAR);
    72				spin_unlock_irqrestore(&chan->lock, flags);
    73			}
    74		}
    75	
    76		return IRQ_HANDLED;
    77	}
    78	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

