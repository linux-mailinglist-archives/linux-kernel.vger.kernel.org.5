Return-Path: <linux-kernel+bounces-133373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2398089A2F3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95EB91F22A00
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A5F171645;
	Fri,  5 Apr 2024 16:57:19 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53F9200CB;
	Fri,  5 Apr 2024 16:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712336239; cv=none; b=Lhv9UgMz3OXNnUU6DSYIScqyNm/LRs1JznILcbS2xGhSMllDEgk27or4OIcF4UgOqjggLqgBwFA1CbpfFvCRRL4qOZYwB++tp7Jon1pMK86vP/sPETH+fg0oz6zPBvwBpWbQwlcMomHtErYzuutWViOqVFMdPLtPtG9dCVNbzg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712336239; c=relaxed/simple;
	bh=OBK6g/UNcxbJXiiBy+9wcG+hPawXuj0fMmCpxvwxpYk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hd8PYVMqOive8YepoSy9o1BicanVejHRg8uXEA5FqimMql+9wCdK/tgLRB1ZSIFv054qyA4Zv8rG0yk7DwJdl24E0/pj5GZ5bgJx00BSHEd4ltz1PfT8CZ9IwJX4tntC8wSSIj4k5Z9ew5BKCnYu8lPhymu7/Lloa6HNC1RVQbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VB4PH4fD8z6J9ds;
	Sat,  6 Apr 2024 00:55:47 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 1C94A141251;
	Sat,  6 Apr 2024 00:57:13 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 5 Apr
 2024 17:57:12 +0100
Date: Fri, 5 Apr 2024 17:57:11 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
CC: Robert Richter <rrichter@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Xingtao Yao
 (Fujitsu)" <yaoxt.fnst@fujitsu.com>
Subject: Re: [Problem ?] cxl list show nothing after reboot Re: [PATCH v2]
 cxl/pci: Fix disabling memory if DVSEC CXL Range does not match a CFMWS
 window
Message-ID: <20240405175711.000032c4@Huawei.com>
In-Reply-To: <24b8b11d-a7ec-42ce-9fa6-8a24701cfe46@fujitsu.com>
References: <20240216160113.407141-1-rrichter@amd.com>
	<b0f5e2ce-d39e-4a8e-8f2f-ffa67b604e02@fujitsu.com>
	<24b8b11d-a7ec-42ce-9fa6-8a24701cfe46@fujitsu.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 26 Mar 2024 08:26:21 +0000
"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> wrote:

> All guys,
> 
> In order to make the CXL memdev work again, i have to modify the QEMU side
> where it resets the "DVSEC CXL Control" during reboot. A draft changes is as below:
> 
> Per 8.1.3.2 DVSEC CXL Control (Offset 0Ch), Default value of BIT(2) is 0. So is it reasonable
> to have a reset dvsecs in QEMU during reboot?
> 
> Any comments @Janathan

Hi,

Sorry it took me so long to get to this.

What are you attempting to do? Use an OS reboot on QEMU to check that the flows
meant for BIOS configuration work - i.e. the OS rebuilds the state
correctly by reading the current state of the devices?

Would be good to fix that case but I want to check that's the aim before looking
too closely at this.

Thanks,

Jonathan

> 
> 
> [root@iaas-rpma qemu]# git diff
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index b0a7e9f11b64..31755a9f9aab 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -899,6 +899,26 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
>       return address_space_write(as, dpa_offset, attrs, &data, size);
>   }
>   
> +static void dvsecs_ctrl_reset(CXLType3Dev *ct3d)
> +{
> +
> +     if (ct3d->sn != UI64_NULL) {
> +        pcie_dev_ser_num_init(ct3d->cxl_cstate.pdev, 0x100, ct3d->sn);
> +        ct3d->cxl_cstate.dvsec_offset = 0x100 + 0x0c;
> +    } else {
> +        ct3d->cxl_cstate.dvsec_offset = 0x100;
> +    }
> +
> +    // FIXME?: only reset ctrl instead of rebuilding the whole dvsecs
> +#if 0
> +    memcpy(pdev->config + offset + sizeof(DVSECHeader),
> +           body + sizeof(DVSECHeader),
> +           length - sizeof(DVSECHeader));
> +#else
> +    build_dvsecs(ct3d);
> +#endif
> +}
> +
>   static void ct3d_reset(DeviceState *dev)
>   {
>       CXLType3Dev *ct3d = CXL_TYPE3(dev);
> @@ -907,6 +927,7 @@ static void ct3d_reset(DeviceState *dev)
>   
>       cxl_component_register_init_common(reg_state, write_msk, CXL2_TYPE3_DEVICE);
>       cxl_device_register_init_t3(ct3d);
> +    dvsecs_ctrl_reset(ct3d);
>   
>       /*
>        * Bring up an endpoint to target with MCTP over VDM.
> 
> 
> 
> 
> 
> On 22/03/2024 11:15, Zhijian Li (Fujitsu) wrote:
> > Robert, Dan
> > 
> > It's noticed that 'cxl list' show nothing after a reboot in v6.8.(A fresh boot works)
> > The git bisection pointed to this commit.
> > 
> > Haven't investigated it deeply, I'm wondering if it's a QEMU problem or
> > something wrong with this patch.
> > 
> > 
> > Reproduce step:
> > 
> > 1. Start a cxl QEMU VM
> > 2. cxl list works
> > cxl list
> > [
> >     {
> >       "memdev":"mem0",
> >       "ram_size":2147483648,
> >       "serial":0,
> >       "host":"0000:54:00.0"
> >     },
> >     {
> >       "memdev":"mem1",
> >       "pmem_size":2147483648,
> >       "serial":0,
> >       "host":"0000:36:00.0"
> >     }
> > ]
> > 
> > 3. reboot VM
> > 4. cxl list show nothing and has following dmesg
> > 
> > cxl list
> > [
> > ]
> >     Warning: no matching devices found
> > 
> > ...
> > 
> > [    6.249188]  pci0000:53: host supports CXL
> > [    6.258168]  pci0000:35: host supports CXL
> > [    6.490568] cxl_pci 0000:54:00.0: Range register decodes outside platform defined CXL ranges.
> > [    6.494298] cxl_mem mem0: endpoint3 failed probe
> > [    6.506072] cxl_pci 0000:36:00.0: Range register decodes outside platform defined CXL ranges.
> > [    6.515092] cxl_mem mem1: endpoint3 failed probe
> > [   12.181188] kauditd_printk_skb: 18 callbacks suppressed
> > 
> > 
> > Thanks
> > Zhijian
> > 
> > 
> > On 17/02/2024 00:01, Robert Richter wrote:  
> >> The Linux CXL subsystem is built on the assumption that HPA == SPA.
> >> That is, the host physical address (HPA) the HDM decoder registers are
> >> programmed with are system physical addresses (SPA).
> >>
> >> During HDM decoder setup, the DVSEC CXL range registers (cxl-3.1,
> >> 8.1.3.8) are checked if the memory is enabled and the CXL range is in
> >> a HPA window that is described in a CFMWS structure of the CXL host
> >> bridge (cxl-3.1, 9.18.1.3).
> >>
> >> Now, if the HPA is not an SPA, the CXL range does not match a CFMWS
> >> window and the CXL memory range will be disabled then. The HDM decoder
> >> stops working which causes system memory being disabled and further a
> >> system hang during HDM decoder initialization, typically when a CXL
> >> enabled kernel boots.
> >>
> >> Prevent a system hang and do not disable the HDM decoder if the
> >> decoder's CXL range is not found in a CFMWS window.
> >>
> >> Note the change only fixes a hardware hang, but does not implement
> >> HPA/SPA translation. Support for this can be added in a follow on
> >> patch series.
> >>
> >> Signed-off-by: Robert Richter <rrichter@amd.com>
> >> ---
> >>    drivers/cxl/core/pci.c | 4 ++--
> >>    1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> >> index a0e7ed5ae25f..18616ca873e5 100644
> >> --- a/drivers/cxl/core/pci.c
> >> +++ b/drivers/cxl/core/pci.c
> >> @@ -478,8 +478,8 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
> >>    	}
> >>    
> >>    	if (!allowed) {
> >> -		cxl_set_mem_enable(cxlds, 0);
> >> -		info->mem_enabled = 0;
> >> +		dev_err(dev, "Range register decodes outside platform defined CXL ranges.\n");
> >> +		return -ENXIO;
> >>    	}
> >>    
> >>    	/  


