Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5337C5097
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 12:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346285AbjJKKwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 06:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234868AbjJKKv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 06:51:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5249ADD;
        Wed, 11 Oct 2023 03:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697021507; x=1728557507;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HzKy/wD6fRWSSHN2E6lVNwkcLE+uuPmcqXe5CRZ4jno=;
  b=n3xJiIMKq6QtoXM5ZR6myB395QkmRlSuTRdQz2Be8wkjns6ueY7uv6eZ
   HS+iKEIwgkN5YnlymACvw4zk1a+UtOje827WAoEo8vrMn/Lo1S+uRB8fv
   tFjqXLRMuL69d2EClkrAdNmAEWIHYDDK6a5cUFDNoOx/52A9nWteMupsT
   8NnsvkHPxGvZWcViqWS3f+S0UQE30RV5Xrg8U4+ntM+7bprQotPTwYRCI
   mwSNHFp7ds5pG/8ImtUQihc+wx08PdrHejrLOjUJgVynPw3sacqW7d+M1
   juBTrtqKxNkR0rsmLdj2n4/0Ib/bKA39/wNBfRGbRttshVzwcYATi9mw1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="387477531"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="387477531"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:51:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="703687816"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="703687816"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 11 Oct 2023 03:51:43 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qqWoX-00027z-0I;
        Wed, 11 Oct 2023 10:51:41 +0000
Date:   Wed, 11 Oct 2023 18:50:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hardik Gajjar <hgajjar@de.adit-jv.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, stern@rowland.harvard.edu
Cc:     oe-kbuild-all@lists.linux.dev, yangyingliang@huawei.com,
        jinpu.wang@ionos.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, erosca@de.adit-jv.com,
        hgajjar@de.adit-jv.com
Subject: Re: [PATCH v3] usb: core: hub: Add quirks for reducing device
 address timeout
Message-ID: <202310111851.fB7Flvj5-lkp@intel.com>
References: <20231011085011.89198-1-hgajjar@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011085011.89198-1-hgajjar@de.adit-jv.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hardik,

kernel test robot noticed the following build warnings:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on usb/usb-next usb/usb-linus linus/master v6.6-rc5 next-20231011]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hardik-Gajjar/usb-core-hub-Add-quirks-for-reducing-device-address-timeout/20231011-165246
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20231011085011.89198-1-hgajjar%40de.adit-jv.com
patch subject: [PATCH v3] usb: core: hub: Add quirks for reducing device address timeout
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231011/202310111851.fB7Flvj5-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231011/202310111851.fB7Flvj5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310111851.fB7Flvj5-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/usb/host/xhci.c:1318: warning: Function parameter or member 'desc' not described in 'xhci_get_endpoint_index'
>> drivers/usb/host/xhci.c:4001: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * This function issues an Address Device command to assign a unique USB bus


vim +4001 drivers/usb/host/xhci.c

  3999	
  4000	/**
> 4001	 * This function issues an Address Device command to assign a unique USB bus
  4002	 * address. Optionally, it sends a SetAddress request.
  4003	 *
  4004	 * @param hcd        USB host controller data structure.
  4005	 * @param udev       USB device structure representing the connected device.
  4006	 * @param setup      Enum specifying setup mode: address only or with context.
  4007	 * @param timeout_ms Max wait time (ms) for the command operation to complete.
  4008	 *
  4009	 * @return           Integer status code: 0 on success, negative on error.
  4010	 *
  4011	 */
  4012	static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
  4013				     enum xhci_setup_dev setup, unsigned int timeout_ms)
  4014	{
  4015		const char *act = setup == SETUP_CONTEXT_ONLY ? "context" : "address";
  4016		unsigned long flags;
  4017		struct xhci_virt_device *virt_dev;
  4018		int ret = 0;
  4019		struct xhci_hcd *xhci = hcd_to_xhci(hcd);
  4020		struct xhci_slot_ctx *slot_ctx;
  4021		struct xhci_input_control_ctx *ctrl_ctx;
  4022		u64 temp_64;
  4023		struct xhci_command *command = NULL;
  4024	
  4025		mutex_lock(&xhci->mutex);
  4026	
  4027		if (xhci->xhc_state) {	/* dying, removing or halted */
  4028			ret = -ESHUTDOWN;
  4029			goto out;
  4030		}
  4031	
  4032		if (!udev->slot_id) {
  4033			xhci_dbg_trace(xhci, trace_xhci_dbg_address,
  4034					"Bad Slot ID %d", udev->slot_id);
  4035			ret = -EINVAL;
  4036			goto out;
  4037		}
  4038	
  4039		virt_dev = xhci->devs[udev->slot_id];
  4040	
  4041		if (WARN_ON(!virt_dev)) {
  4042			/*
  4043			 * In plug/unplug torture test with an NEC controller,
  4044			 * a zero-dereference was observed once due to virt_dev = 0.
  4045			 * Print useful debug rather than crash if it is observed again!
  4046			 */
  4047			xhci_warn(xhci, "Virt dev invalid for slot_id 0x%x!\n",
  4048				udev->slot_id);
  4049			ret = -EINVAL;
  4050			goto out;
  4051		}
  4052		slot_ctx = xhci_get_slot_ctx(xhci, virt_dev->out_ctx);
  4053		trace_xhci_setup_device_slot(slot_ctx);
  4054	
  4055		if (setup == SETUP_CONTEXT_ONLY) {
  4056			if (GET_SLOT_STATE(le32_to_cpu(slot_ctx->dev_state)) ==
  4057			    SLOT_STATE_DEFAULT) {
  4058				xhci_dbg(xhci, "Slot already in default state\n");
  4059				goto out;
  4060			}
  4061		}
  4062	
  4063		command = xhci_alloc_command(xhci, true, GFP_KERNEL);
  4064		if (!command) {
  4065			ret = -ENOMEM;
  4066			goto out;
  4067		}
  4068	
  4069		command->in_ctx = virt_dev->in_ctx;
  4070		command->timeout_ms = timeout_ms;
  4071	
  4072		slot_ctx = xhci_get_slot_ctx(xhci, virt_dev->in_ctx);
  4073		ctrl_ctx = xhci_get_input_control_ctx(virt_dev->in_ctx);
  4074		if (!ctrl_ctx) {
  4075			xhci_warn(xhci, "%s: Could not get input context, bad type.\n",
  4076					__func__);
  4077			ret = -EINVAL;
  4078			goto out;
  4079		}
  4080		/*
  4081		 * If this is the first Set Address since device plug-in or
  4082		 * virt_device realloaction after a resume with an xHCI power loss,
  4083		 * then set up the slot context.
  4084		 */
  4085		if (!slot_ctx->dev_info)
  4086			xhci_setup_addressable_virt_dev(xhci, udev);
  4087		/* Otherwise, update the control endpoint ring enqueue pointer. */
  4088		else
  4089			xhci_copy_ep0_dequeue_into_input_ctx(xhci, udev);
  4090		ctrl_ctx->add_flags = cpu_to_le32(SLOT_FLAG | EP0_FLAG);
  4091		ctrl_ctx->drop_flags = 0;
  4092	
  4093		trace_xhci_address_ctx(xhci, virt_dev->in_ctx,
  4094					le32_to_cpu(slot_ctx->dev_info) >> 27);
  4095	
  4096		trace_xhci_address_ctrl_ctx(ctrl_ctx);
  4097		spin_lock_irqsave(&xhci->lock, flags);
  4098		trace_xhci_setup_device(virt_dev);
  4099		ret = xhci_queue_address_device(xhci, command, virt_dev->in_ctx->dma,
  4100						udev->slot_id, setup);
  4101		if (ret) {
  4102			spin_unlock_irqrestore(&xhci->lock, flags);
  4103			xhci_dbg_trace(xhci, trace_xhci_dbg_address,
  4104					"FIXME: allocate a command ring segment");
  4105			goto out;
  4106		}
  4107		xhci_ring_cmd_db(xhci);
  4108		spin_unlock_irqrestore(&xhci->lock, flags);
  4109	
  4110		/* ctrl tx can take up to 5 sec; XXX: need more time for xHC? */
  4111		wait_for_completion(command->completion);
  4112	
  4113		/* FIXME: From section 4.3.4: "Software shall be responsible for timing
  4114		 * the SetAddress() "recovery interval" required by USB and aborting the
  4115		 * command on a timeout.
  4116		 */
  4117		switch (command->status) {
  4118		case COMP_COMMAND_ABORTED:
  4119		case COMP_COMMAND_RING_STOPPED:
  4120			xhci_warn(xhci, "Timeout while waiting for setup device command\n");
  4121			ret = -ETIME;
  4122			break;
  4123		case COMP_CONTEXT_STATE_ERROR:
  4124		case COMP_SLOT_NOT_ENABLED_ERROR:
  4125			xhci_err(xhci, "Setup ERROR: setup %s command for slot %d.\n",
  4126				 act, udev->slot_id);
  4127			ret = -EINVAL;
  4128			break;
  4129		case COMP_USB_TRANSACTION_ERROR:
  4130			dev_warn(&udev->dev, "Device not responding to setup %s.\n", act);
  4131	
  4132			mutex_unlock(&xhci->mutex);
  4133			ret = xhci_disable_slot(xhci, udev->slot_id);
  4134			xhci_free_virt_device(xhci, udev->slot_id);
  4135			if (!ret)
  4136				xhci_alloc_dev(hcd, udev);
  4137			kfree(command->completion);
  4138			kfree(command);
  4139			return -EPROTO;
  4140		case COMP_INCOMPATIBLE_DEVICE_ERROR:
  4141			dev_warn(&udev->dev,
  4142				 "ERROR: Incompatible device for setup %s command\n", act);
  4143			ret = -ENODEV;
  4144			break;
  4145		case COMP_SUCCESS:
  4146			xhci_dbg_trace(xhci, trace_xhci_dbg_address,
  4147				       "Successful setup %s command", act);
  4148			break;
  4149		default:
  4150			xhci_err(xhci,
  4151				 "ERROR: unexpected setup %s command completion code 0x%x.\n",
  4152				 act, command->status);
  4153			trace_xhci_address_ctx(xhci, virt_dev->out_ctx, 1);
  4154			ret = -EINVAL;
  4155			break;
  4156		}
  4157		if (ret)
  4158			goto out;
  4159		temp_64 = xhci_read_64(xhci, &xhci->op_regs->dcbaa_ptr);
  4160		xhci_dbg_trace(xhci, trace_xhci_dbg_address,
  4161				"Op regs DCBAA ptr = %#016llx", temp_64);
  4162		xhci_dbg_trace(xhci, trace_xhci_dbg_address,
  4163			"Slot ID %d dcbaa entry @%p = %#016llx",
  4164			udev->slot_id,
  4165			&xhci->dcbaa->dev_context_ptrs[udev->slot_id],
  4166			(unsigned long long)
  4167			le64_to_cpu(xhci->dcbaa->dev_context_ptrs[udev->slot_id]));
  4168		xhci_dbg_trace(xhci, trace_xhci_dbg_address,
  4169				"Output Context DMA address = %#08llx",
  4170				(unsigned long long)virt_dev->out_ctx->dma);
  4171		trace_xhci_address_ctx(xhci, virt_dev->in_ctx,
  4172					le32_to_cpu(slot_ctx->dev_info) >> 27);
  4173		/*
  4174		 * USB core uses address 1 for the roothubs, so we add one to the
  4175		 * address given back to us by the HC.
  4176		 */
  4177		trace_xhci_address_ctx(xhci, virt_dev->out_ctx,
  4178					le32_to_cpu(slot_ctx->dev_info) >> 27);
  4179		/* Zero the input context control for later use */
  4180		ctrl_ctx->add_flags = 0;
  4181		ctrl_ctx->drop_flags = 0;
  4182		slot_ctx = xhci_get_slot_ctx(xhci, virt_dev->out_ctx);
  4183		udev->devaddr = (u8)(le32_to_cpu(slot_ctx->dev_state) & DEV_ADDR_MASK);
  4184	
  4185		xhci_dbg_trace(xhci, trace_xhci_dbg_address,
  4186			       "Internal device address = %d",
  4187			       le32_to_cpu(slot_ctx->dev_state) & DEV_ADDR_MASK);
  4188	out:
  4189		mutex_unlock(&xhci->mutex);
  4190		if (command) {
  4191			kfree(command->completion);
  4192			kfree(command);
  4193		}
  4194		return ret;
  4195	}
  4196	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
