Return-Path: <linux-kernel+bounces-85697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD1386B977
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61BD71C2739E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC928624B;
	Wed, 28 Feb 2024 20:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="r3VnOB93"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D9386243;
	Wed, 28 Feb 2024 20:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709153670; cv=none; b=hr47mUkUw+GYK5tP3+tIo3yDnpmJNbVtdBou+R6+GGugGQeGSMCUw2HfXwQ9M3QkN5lFiHilugkUkM5EOz/8MuiZ6yuDtYUiKnwlpwAha69G8DxcYCv5c4/DoHwvBThyctxsJDeYZFscwroT0kurA0d1GWYk/eZwBsuUbQ5kPfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709153670; c=relaxed/simple;
	bh=jo+BO2IhDfeini327Tb7mXmqp7L124EWZ+3futX5Zik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FF2u2AGN3dt3z2kilSfGTkfwLt7s+5Xgc2qs2dzhXTs/1WvAt019UYwUrspKQWkPxKdI/xdWUxR+6dQ+y42/AatQSzOsAHDzQkutubieXwlBSCLaxtPMLxPEghvX6IwPzJ8ljJUUEio9KQQ2iM/2SpIWGLTkjRYYsvFqgK4YhC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=r3VnOB93; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dcafff3c50so2209815ad.0;
        Wed, 28 Feb 2024 12:54:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709153666; x=1709758466;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from
         :dkim-signature:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvK3mnzW54NQd3+E2hM8ASmUMxZxl+Bc7s2h7Z79/zo=;
        b=VpxMakquLRz4IZDibFQA+1ijSphnoXyTo4lWE7gV7ZsUdTtf9OB35w+tOlAEJJnRFr
         5mWNWhysAc9rhXB9HGUov2ON1b3ZGdxHjRRERWta7xmo+OR0vksZJhGo5G0JmeklssWJ
         UuivizT4SzeWco314N9GdfY6SDXtv9qkBq9OfE8rU+no8pA1uZ4BwM+MyxeQaSg45GZf
         sVD49FjKZfAaWjSXVBsZR/HuWEeCa4jl1WNZJcwF3F1TZ3ksN0y+Zy1V46LtGUr62J2E
         yIn6Ua27HfXvnoXNKUCYTGc51trz8XIi+K2mf66mfH5+SPtIJ9ezL5hvGUiIZ6kj0xCD
         SRMg==
X-Forwarded-Encrypted: i=1; AJvYcCVHTjcAFF2JjmcNWU9KL0DKtqzwMx3Vhwyz0xcQ7ngI4I7yV0C738KV0TF9SsqRTXBgfENduG5aGxjbQZk91ddUEWuOr/wTKJmM6hjk
X-Gm-Message-State: AOJu0YxiCdaI7HLb/PhvrlZyNs6JfKCcWacAU3T9gr5c3iyURtETE39d
	/AV5ueYx3ljazNPRZumAydTegQuEJrXdu15kIXEzNp1KCWByirnU
X-Google-Smtp-Source: AGHT+IFdGG9I0XErDzLUzM1Lmh9Zwgl3QM7v2H9VQwU4EklvJj/8z/K26eU6Vb3atFniN6QdvsHJZw==
X-Received: by 2002:a17:903:2412:b0:1dc:bb56:9d14 with SMTP id e18-20020a170903241200b001dcbb569d14mr103281plo.41.1709153665960;
        Wed, 28 Feb 2024 12:54:25 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id je20-20020a170903265400b001db608107ecsm3709849plb.167.2024.02.28.12.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 12:54:25 -0800 (PST)
Date: Wed, 28 Feb 2024 17:54:16 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709153663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HvK3mnzW54NQd3+E2hM8ASmUMxZxl+Bc7s2h7Z79/zo=;
	b=r3VnOB93XCf6OVNVa/cMNGhLGlcc+1cPXayT5zvII+go/6gXw29n5G1XA7xzBeDB2t/441
	87hH0HSq44wDxx66EA7QAPOuHGsczUUwxHlgD51lmZMuiL6R0deJHVp2SB3l2duHa4WVB7
	uRfC5leZink2yV5N9lSD3WRnL7WB9flrhRBoicGfilwHhZYgbPBpe07e4rg7oQdKT0zj7p
	OROJ6VK/WB4HBdNF1S0dcZnTIb90v2WFvsJjPmVt/f3scS869cQrq9V2YZcoGT/tZqqqzh
	GwuqmRHEN4EIwi9HP0ThTAfgiZ/uGhzjja6afSNqYa9hK/wX/mGuhbJjypiS1w==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.7 000/334] 6.7.7-rc1 review
Message-ID: <v4hxsrh5ffheehaj3nk6hchb3rto54yvetjlbhuwb6wjpc6idx@acewq7clp2wc>
References: <20240227131630.636392135@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240227131630.636392135@linuxfoundation.org>

Hi Greg,

On 27 Feb 14:17, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.7 release.
> There are 334 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.

No noticeable regressions on my system.

Tested-by: Ricardo B. Marliere <ricardo@marliere.net>

Thanks,
-	Ricardo.


> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> -------------
> Pseudo-Shortlog of commits:
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Linux 6.7.7-rc1
> 
> Geliang Tang <geliang.tang@linux.dev>
>     selftests: mptcp: add mptcp_lib_get_counter
> 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>     selftests: mptcp: join: stop transfer when check is done (part 2)
> 
> Chengming Zhou <zhouchengming@bytedance.com>
>     mm/zswap: invalidate duplicate entry when !zswap_enabled
> 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>     selftests: mptcp: join: stop transfer when check is done (part 1)
> 
> Yosry Ahmed <yosryahmed@google.com>
>     mm: zswap: fix missing folio cleanup in writeback race path
> 
> Corey Minyard <minyard@acm.org>
>     i2c: imx: when being a target, mark the last read as processed
> 
> Melissa Wen <mwen@igalia.com>
>     drm/amd/display: fix null-pointer dereference on edid reading
> 
> Armin Wolf <W_Armin@gmx.de>
>     drm/amd/display: Fix memory leak in dm_sw_fini()
> 
> Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>     drm/amd/display: Fix potential null pointer dereference in dc_dmub_srv
> 
> Muhammad Usama Anjum <usama.anjum@collabora.com>
>     selftests/iommu: fix the config fragment
> 
> Erik Kurzinger <ekurzinger@nvidia.com>
>     drm/syncobj: handle NULL fence in syncobj_eventfd_entry_func
> 
> Jason Gunthorpe <jgg@ziepe.ca>
>     iommu/arm-smmu-v3: Do not use GFP_KERNEL under as spinlock
> 
> Tina Zhang <tina.zhang@intel.com>
>     iommu: Add mm_get_enqcmd_pasid() helper function
> 
> Erik Kurzinger <ekurzinger@nvidia.com>
>     drm/syncobj: call drm_syncobj_fence_add_wait when WAIT_AVAILABLE flag is set
> 
> Siddharth Vadapalli <s-vadapalli@ti.com>
>     net: phy: realtek: Fix rtl8211f_config_init() for RTL8211F(D)(I)-VD-CG PHY
> 
> Justin Iurman <justin.iurman@uliege.be>
>     Fix write to cloned skb in ipv6_hop_ioam()
> 
> Rémi Denis-Courmont <courmisch@gmail.com>
>     phonet/pep: fix racy skb_queue_empty() use
> 
> Rémi Denis-Courmont <courmisch@gmail.com>
>     phonet: take correct lock to peek at the RX queue
> 
> Horatiu Vultur <horatiu.vultur@microchip.com>
>     net: sparx5: Add spinlock for frame transmission from CPU
> 
> Jianbo Liu <jianbol@nvidia.com>
>     net/sched: flower: Add lock protection when remove filter handle
> 
> Jiri Pirko <jiri@resnulli.us>
>     devlink: fix port dump cmd type
> 
> Jakub Kicinski <kuba@kernel.org>
>     tools: ynl: don't leak mcast_groups on init error
> 
> Jakub Kicinski <kuba@kernel.org>
>     tools: ynl: make sure we always pass yarg to mnl_cb_run
> 
> Jeremy Kerr <jk@codeconstruct.com.au>
>     net: mctp: put sock on tag allocation failure
> 
> Florian Westphal <fw@strlen.de>
>     netfilter: nf_tables: use kzalloc for hook allocation
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nf_tables: register hooks last when adding new chain/flowtable
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nft_flow_offload: release dst in case direct xmit path is used
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nft_flow_offload: reset dst in route object after setting up flow
> 
> Florian Westphal <fw@strlen.de>
>     netfilter: nf_tables: set dormant flag on hook register failure
> 
> Sabrina Dubroca <sd@queasysnail.net>
>     tls: don't skip over different type records from the rx_list
> 
> Sabrina Dubroca <sd@queasysnail.net>
>     tls: stop recv() if initial process_rx_list gave us non-DATA
> 
> Sabrina Dubroca <sd@queasysnail.net>
>     tls: break out of main loop when PEEK gets a non-data record
> 
> Guenter Roeck <linux@roeck-us.net>
>     hwmon: (nct6775) Fix access to temperature configuration registers
> 
> Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>     cache: ax45mp_cache: Align end size to cache boundary in ax45mp_dma_cache_wback()
> 
> Shigeru Yoshida <syoshida@redhat.com>
>     bpf, sockmap: Fix NULL pointer dereference in sk_psock_verdict_data_ready()
> 
> Jason Gunthorpe <jgg@ziepe.ca>
>     s390: use the correct count for __iowrite64_copy()
> 
> Jason Gunthorpe <jgg@ziepe.ca>
>     iommufd: Reject non-zero data_type if no data_len is provided
> 
> Alex Elder <elder@linaro.org>
>     net: ipa: don't overrun IPA suspend interrupt registers
> 
> Eric Dumazet <edumazet@google.com>
>     net: implement lockless setsockopt(SO_PEEK_OFF)
> 
> Subbaraya Sundeep <sbhatta@marvell.com>
>     octeontx2-af: Consider the action set by PF
> 
> Yi Liu <yi.l.liu@intel.com>
>     iommu/vt-d: Set SSADE when attaching to a parent with dirty tracking
> 
> Yi Liu <yi.l.liu@intel.com>
>     iommu/vt-d: Add missing dirty tracking set for parent domain
> 
> Yi Liu <yi.l.liu@intel.com>
>     iommu/vt-d: Wrap the dirty tracking loop to be a helper
> 
> Yi Liu <yi.l.liu@intel.com>
>     iommu/vt-d: Remove domain parameter for intel_pasid_setup_dirty_tracking()
> 
> Yi Liu <yi.l.liu@intel.com>
>     iommu/vt-d: Track nested domains in parent
> 
> Yi Liu <yi.l.liu@intel.com>
>     iommu/vt-d: Update iotlb in nested domain attach
> 
> Maxime Ripard <mripard@kernel.org>
>     drm/i915/tv: Fix TV mode
> 
> Mario Limonciello <mario.limonciello@amd.com>
>     platform/x86: thinkpad_acpi: Only update profile if successfully converted
> 
> Mark Brown <broonie@kernel.org>
>     arm64/sme: Restore SMCR_EL1.EZT0 on exit from suspend
> 
> Mark Brown <broonie@kernel.org>
>     arm64/sme: Restore SME registers on exit from suspend
> 
> Emil Renner Berthing <emil.renner.berthing@canonical.com>
>     gpiolib: Handle no pin_ranges in gpiochip_generic_config()
> 
> Amit Machhiwal <amachhiw@linux.ibm.com>
>     KVM: PPC: Book3S HV: Fix L2 guest reboot failure due to empty 'arch_compat'
> 
> Kuniyuki Iwashima <kuniyu@amazon.com>
>     arp: Prevent overflow in arp_req_get().
> 
> Vasiliy Kovalev <kovalev@altlinux.org>
>     devlink: fix possible use-after-free and memory leaks in devlink_init()
> 
> Vasiliy Kovalev <kovalev@altlinux.org>
>     ipv6: sr: fix possible use-after-free and null-ptr-deref
> 
> Daniil Dulov <d.dulov@aladdin.ru>
>     afs: Increase buffer size in afs_update_volume_status()
> 
> Guenter Roeck <linux@roeck-us.net>
>     parisc: Fix stack unwinder
> 
> Mark Pearson <mpearson-lenovo@squebb.ca>
>     platform/x86: think-lmi: Fix password opcode ordering for workstations
> 
> Martin KaFai Lau <martin.lau@kernel.org>
>     bpf: Fix racing between bpf_timer_cancel_and_free and bpf_timer_cancel
> 
> Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>     ata: ahci_ceva: fix error handling for Xilinx GT PHY support
> 
> Hangbin Liu <liuhangbin@gmail.com>
>     selftests: bonding: set active slave to primary eth1 specifically
> 
> Gaurav Batra <gbatra@linux.ibm.com>
>     powerpc/pseries/iommu: DLPAR add doesn't completely initialize pci_controller
> 
> Justin Chen <justin.chen@broadcom.com>
>     net: bcmasp: Sanity check is off by one
> 
> Florian Fainelli <florian.fainelli@broadcom.com>
>     net: bcmasp: Indicate MAC is in charge of PHY PM
> 
> Eric Dumazet <edumazet@google.com>
>     ipv6: properly combine dev_base_seq and ipv6.dev_addr_genid
> 
> Eric Dumazet <edumazet@google.com>
>     ipv4: properly combine dev_base_seq and ipv4.dev_addr_genid
> 
> Pavel Sakharov <p.sakharov@ispras.ru>
>     net: stmmac: Fix incorrect dereference in interrupt handlers
> 
> Alison Schofield <alison.schofield@intel.com>
>     x86/numa: Fix the sort compare func used in numa_fill_memblks()
> 
> Alison Schofield <alison.schofield@intel.com>
>     x86/numa: Fix the address overlap check in numa_fill_memblks()
> 
> Dan Carpenter <dan.carpenter@linaro.org>
>     drm/nouveau/mmu/r535: uninitialized variable in r535_bar_new_()
> 
> Arnd Bergmann <arnd@arndb.de>
>     nouveau: fix function cast warnings
> 
> Jakub Kicinski <kuba@kernel.org>
>     net/sched: act_mirred: don't override retval if we already lost the skb
> 
> Jakub Kicinski <kuba@kernel.org>
>     net/sched: act_mirred: use the backlog for mirred ingress
> 
> Victor Nogueira <victor@mojatatu.com>
>     net/sched: act_mirred: Create function tcf_mirred_to_dev and improve readability
> 
> Randy Dunlap <rdunlap@infradead.org>
>     net: ethernet: adi: requires PHYLIB support
> 
> Kuniyuki Iwashima <kuniyu@amazon.com>
>     dccp/tcp: Unhash sk from ehash for tb2 alloc failure after check_estalblished().
> 
> Tobias Waldekranz <tobias@waldekranz.com>
>     net: bridge: switchdev: Ensure deferred event delivery on unoffload
> 
> Tobias Waldekranz <tobias@waldekranz.com>
>     net: bridge: switchdev: Skip MDB replays of deferred events on offload
> 
> Randy Dunlap <rdunlap@infradead.org>
>     scsi: jazz_esp: Only build if SCSI core is builtin
> 
> Don Brace <don.brace@microchip.com>
>     scsi: smartpqi: Fix disable_managed_interrupts
> 
> Dan Carpenter <dan.carpenter@linaro.org>
>     scsi: ufs: Uninitialized variable in ufshcd_devfreq_target()
> 
> Gianmarco Lusvardi <glusvardi@posteo.net>
>     bpf, scripts: Correct GPL license name
> 
> Arnd Bergmann <arnd@arndb.de>
>     RDMA/srpt: fix function pointer cast warnings
> 
> Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>     xsk: Add truesize to skb_add_rx_frag().
> 
> Chris Morgan <macromorgan@hotmail.com>
>     arm64: dts: rockchip: Correct Indiedroid Nova GPIO Names
> 
> Heiko Stuebner <heiko.stuebner@cherry.de>
>     arm64: dts: rockchip: set num-cs property for spi on px30
> 
> Kamal Heib <kheib@redhat.com>
>     RDMA/qedr: Fix qedr_create_user_qp error flow
> 
> Joao Martins <joao.m.martins@oracle.com>
>     iommufd/iova_bitmap: Consider page offset for the pages to be pinned
> 
> Joao Martins <joao.m.martins@oracle.com>
>     iommufd/iova_bitmap: Handle recording beyond the mapped pages
> 
> Joao Martins <joao.m.martins@oracle.com>
>     iommufd/iova_bitmap: Switch iova_bitmap::bitmap to an u8 array
> 
> Joao Martins <joao.m.martins@oracle.com>
>     iommufd/iova_bitmap: Bounds check mapped::pages access
> 
> Lucas Stach <l.stach@pengutronix.de>
>     bus: imx-weim: fix valid range check
> 
> Alexander Stein <alexander.stein@ew.tq-group.com>
>     arm64: dts: tqma8mpql: fix audio codec iov-supply
> 
> Bart Van Assche <bvanassche@acm.org>
>     RDMA/srpt: Support specifying the srpt_service_guid parameter
> 
> Mustafa Ismail <mustafa.ismail@intel.com>
>     RDMA/irdma: Add AE for too many RNRS
> 
> Mustafa Ismail <mustafa.ismail@intel.com>
>     RDMA/irdma: Set the CQ read threshold for GEN 1
> 
> Shiraz Saleem <shiraz.saleem@intel.com>
>     RDMA/irdma: Validate max_send_wr and max_recv_wr
> 
> Mike Marciniszyn <mike.marciniszyn@intel.com>
>     RDMA/irdma: Fix KASAN issue with tasklet
> 
> Marek Vasut <marex@denx.de>
>     arm64: dts: imx8mp: Disable UART4 by default on Data Modul i.MX8M Plus eDM SBC
> 
> Mark Zhang <markzhang@nvidia.com>
>     IB/mlx5: Don't expose debugfs entries for RRoCE general parameters if not supported
> 
> Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
>     RDMA/bnxt_re: Add a missing check in bnxt_qplib_query_srq
> 
> Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
>     RDMA/bnxt_re: Return error for SRQ resize
> 
> Zhipeng Lu <alexious@zju.edu.cn>
>     IB/hfi1: Fix a memleak in init_credit_return
> 
> Sohaib Nadeem <sohaib.nadeem@amd.com>
>     Revert "drm/amd/display: increased min_dcfclk_mhz and min_fclk_mhz"
> 
> Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>     drm/amd/display: Fix buffer overflow in 'get_host_router_total_dp_tunnel_bw()'
> 
> Nathan Chancellor <nathan@kernel.org>
>     drm/amd/display: Avoid enum conversion warning
> 
> Steve French <stfrench@microsoft.com>
>     smb3: add missing null server pointer check
> 
> Lennert Buytenhek <kernel@wantstofly.org>
>     ahci: Extend ASM1061 43-bit DMA address quirk to other ASM106x parts
> 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>     selftests: mptcp: diag: unique 'cestab' subtest names
> 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>     selftests: mptcp: diag: unique 'in use' subtest names
> 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>     selftests: mptcp: diag: fix bash warnings on older kernels
> 
> Geliang Tang <geliang.tang@linux.dev>
>     selftests: mptcp: diag: check CURRESTAB counters
> 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>     selftests: mptcp: pm nl: avoid error msg on older kernels
> 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>     selftests: mptcp: pm nl: also list skipped tests
> 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>     selftests: mptcp: simult flows: fix some subtest names
> 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>     selftests: mptcp: userspace_pm: unique subtest names
> 
> Paolo Abeni <pabeni@redhat.com>
>     mptcp: fix duplicate subflow creation
> 
> Paolo Abeni <pabeni@redhat.com>
>     mptcp: fix data races on remote_id
> 
> Paolo Abeni <pabeni@redhat.com>
>     mptcp: fix data races on local_id
> 
> Paolo Abeni <pabeni@redhat.com>
>     mptcp: fix lockless access in subflow ULP diag
> 
> Geliang Tang <tanggeliang@kylinos.cn>
>     mptcp: add needs_id for netlink appending addr
> 
> Geliang Tang <tanggeliang@kylinos.cn>
>     mptcp: add needs_id for userspace appending addr
> 
> Xu Yang <xu.yang_2@nxp.com>
>     usb: roles: don't get/set_role() when usb_role_switch is unregistered
> 
> Xu Yang <xu.yang_2@nxp.com>
>     usb: roles: fix NULL pointer issue when put module's reference
> 
> Aaro Koskinen <aaro.koskinen@iki.fi>
>     usb: gadget: omap_udc: fix USB gadget regression on Palm TE
> 
> Krishna Kurapati <quic_kriskura@quicinc.com>
>     usb: gadget: ncm: Avoid dropping datagrams of properly parsed NTBs
> 
> Frank Li <Frank.Li@nxp.com>
>     usb: cdns3: fix memory double free when handle zero packet
> 
> Frank Li <Frank.Li@nxp.com>
>     usb: cdns3: fixed memory use after free at cdns3_gadget_ep_disable()
> 
> Pawel Laszczak <pawell@cadence.com>
>     usb: cdnsp: fixed issue with incorrect detecting CDNSP family controllers
> 
> Pawel Laszczak <pawell@cadence.com>
>     usb: cdnsp: blocked some cdns3 specific code
> 
> Thinh Nguyen <Thinh.Nguyen@synopsys.com>
>     usb: dwc3: gadget: Don't disconnect if not started
> 
> Lino Sanfilippo <l.sanfilippo@kunbus.com>
>     serial: amba-pl011: Fix DMA transmission in RS485 mode
> 
> Lino Sanfilippo <l.sanfilippo@kunbus.com>
>     serial: stm32: do not always set SER_RS485_RX_DURING_TX if RS485 is enabled
> 
> Ondrej Jirman <megi@xff.cz>
>     Revert "usb: typec: tcpm: reset counter when enter into unattached state after try role"
> 
> Sandeep Dhavale <dhavale@google.com>
>     erofs: fix refcount on the metabuf used for inode lookup
> 
> Arnd Bergmann <arnd@arndb.de>
>     dm-integrity, dm-verity: reduce stack usage for recheck
> 
> Nikita Shubin <nikita.shubin@maquefel.me>
>     ARM: ep93xx: Add terminator to gpiod_lookup_table
> 
> Tom Parkin <tparkin@katalix.com>
>     l2tp: pass correct message length to ip6_append_data
> 
> Vidya Sagar <vidyas@nvidia.com>
>     PCI/MSI: Prevent MSI hardware interrupt number truncation
> 
> Nam Cao <namcao@linutronix.de>
>     irqchip/sifive-plic: Enable interrupt if needed before EOI
> 
> Oliver Upton <oliver.upton@linux.dev>
>     irqchip/gic-v3-its: Do not assume vPE tables are preallocated
> 
> Chen Jun <chenjun102@huawei.com>
>     irqchip/mbigen: Don't use bus_get_dev_root() to find the parent
> 
> zhenwei pi <pizhenwei@bytedance.com>
>     crypto: virtio/akcipher - Fix stack overflow on memcpy
> 
> Vasiliy Kovalev <kovalev@altlinux.org>
>     gtp: fix use-after-free and null-ptr-deref in gtp_genl_dump_pdp()
> 
> Andrzej Kacprowski <Andrzej.Kacprowski@intel.com>
>     accel/ivpu: Don't enable any tiles by default on VPU40xx
> 
> Oliver Upton <oliver.upton@linux.dev>
>     KVM: arm64: vgic-its: Test for valid IRQ in its_sync_lpi_pending_table()
> 
> Oliver Upton <oliver.upton@linux.dev>
>     KVM: arm64: vgic-its: Test for valid IRQ in MOVALL handler
> 
> Yu Kuai <yukuai3@huawei.com>
>     md: Fix missing release of 'active_io' for flush
> 
> Yu Kuai <yukuai3@huawei.com>
>     md: Don't suspend the array for interrupted reshape
> 
> Yu Kuai <yukuai3@huawei.com>
>     md: Don't register sync_thread for reshape directly
> 
> Yu Kuai <yukuai3@huawei.com>
>     md: Make sure md_do_sync() will set MD_RECOVERY_DONE
> 
> Yu Kuai <yukuai3@huawei.com>
>     md: Don't ignore read-only array in md_check_recovery()
> 
> Yu Kuai <yukuai3@huawei.com>
>     md: Don't ignore suspended array in md_check_recovery()
> 
> Javier Martinez Canillas <javierm@redhat.com>
>     sparc: Fix undefined reference to fb_is_primary_device
> 
> Baokun Li <libaokun1@huawei.com>
>     cachefiles: fix memory leak in cachefiles_add_cache()
> 
> Hans de Goede <hdegoede@redhat.com>
>     platform/x86: touchscreen_dmi: Allow partial (prefix) matches for ACPI names
> 
> Hans de Goede <hdegoede@redhat.com>
>     platform/x86: intel-vbtn: Stop calling "VBDL" from notify_handler
> 
> Hans de Goede <hdegoede@redhat.com>
>     platform/x86: x86-android-tablets: Fix keyboard touchscreen on Lenovo Yogabook1 X90
> 
> Anshuman Khandual <anshuman.khandual@arm.com>
>     mm/memblock: add MEMBLOCK_RSRV_NOINIT into flagname[] array
> 
> SeongJae Park <sj@kernel.org>
>     mm/damon/reclaim: fix quota stauts loss due to online tunings
> 
> SeongJae Park <sj@kernel.org>
>     mm/damon/core: check apply interval in damon_do_apply_schemes()
> 
> Johannes Weiner <hannes@cmpxchg.org>
>     mm: memcontrol: clarify swapaccount=0 deprecation warning
> 
> SeongJae Park <sj@kernel.org>
>     mm/damon/lru_sort: fix quota status loss due to online tunings
> 
> Kairui Song <kasong@tencent.com>
>     mm/swap: fix race when skipping swapcache
> 
> Terry Tritton <terry.tritton@linaro.org>
>     selftests/mm: uffd-unit-test check if huge page size is 0
> 
> Martin K. Petersen <martin.petersen@oracle.com>
>     scsi: core: Consult supported VPD page list prior to fetching page
> 
> Naohiro Aota <naohiro.aota@wdc.com>
>     scsi: target: pscsi: Fix bio_put() for error case
> 
> Martin K. Petersen <martin.petersen@oracle.com>
>     scsi: sd: usb_storage: uas: Access media prior to querying device properties
> 
> Robert Richter <rrichter@amd.com>
>     cxl/pci: Fix disabling memory if DVSEC CXL Range does not match a CFMWS window
> 
> Li Ming <ming4.li@intel.com>
>     cxl/pci: Skip to handle RAS errors if CXL.mem device is detached
> 
> Dan Williams <dan.j.williams@intel.com>
>     cxl/acpi: Fix load failures due to single window creation failure
> 
> Mikulas Patocka <mpatocka@redhat.com>
>     dm-verity: recheck the hash after a failure
> 
> Mikulas Patocka <mpatocka@redhat.com>
>     dm-crypt: don't modify the data when using authenticated encryption
> 
> Mikulas Patocka <mpatocka@redhat.com>
>     dm-integrity: recheck the integrity tag after a failure
> 
> Helge Deller <deller@gmx.de>
>     Revert "parisc: Only list existing CPUs in cpu_possible_mask"
> 
> Mikulas Patocka <mpatocka@redhat.com>
>     dm-crypt: recheck the integrity tag after a failure
> 
> Guenter Roeck <linux@roeck-us.net>
>     lib/Kconfig.debug: TEST_IOV_ITER depends on MMU
> 
> Bart Van Assche <bvanassche@acm.org>
>     fs/aio: Restrict kiocb_set_cancel_fn() to I/O submitted via libaio
> 
> Damien Le Moal <dlemoal@kernel.org>
>     ata: libata-core: Do not call ata_dev_power_set_standby() twice
> 
> Damien Le Moal <dlemoal@kernel.org>
>     ata: libata-core: Do not try to set sleeping devices to standby
> 
> Peter Oberparleiter <oberpar@linux.ibm.com>
>     s390/cio: fix invalid -EBUSY on ccw_device_start
> 
> Ma Jun <Jun.Ma2@amd.com>
>     drm/amdgpu: Fix the runtime resume failure issue
> 
> Wayne Lin <wayne.lin@amd.com>
>     drm/amd/display: adjust few initialization order in dm
> 
> Lewis Huang <lewis.huang@amd.com>
>     drm/amd/display: Only allow dig mapping to pwrseq in new asic
> 
> Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>     drm/buddy: Modify duplicate list_splice_tail call
> 
> Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>     drm/meson: Don't remove bridges which are created by other drivers
> 
> Thomas Hellström <thomas.hellstrom@linux.intel.com>
>     drm/ttm: Fix an invalid freeing on already freed page in error path
> 
> Qu Wenruo <wqu@suse.com>
>     btrfs: defrag: avoid unnecessary defrag caused by incorrect extent size
> 
> Huacai Chen <chenhuacai@kernel.org>
>     LoongArch: Update cpu_sibling_map when disabling nonboot CPUs
> 
> Huacai Chen <chenhuacai@kernel.org>
>     LoongArch: Disable IRQ before init_fn() for nonboot CPUs
> 
> Huacai Chen <chenhuacai@kernel.org>
>     LoongArch: Call early_init_fdt_scan_reserved_mem() earlier
> 
> Jonathan Corbet <corbet@lwn.net>
>     docs: Instruct LaTeX to cope with deeper nesting
> 
> Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
>     x86/bugs: Add asm helpers for executing VERW
> 
> David Gow <davidgow@google.com>
>     kunit: Add a macro to wrap a deferred action function
> 
> Daniel Vacek <neelx@redhat.com>
>     IB/hfi1: Fix sdma.h tx->num_descs off-by-one error
> 
> Sohaib Nadeem <sohaib.nadeem@amd.com>
>     drm/amd/display: fixed integer types and null check locations
> 
> Peichen Huang <peichen.huang@amd.com>
>     drm/amd/display: Request usb4 bw for mst streams
> 
> Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
>     drm/amd/display: Add dpia display mode validation logic
> 
> Paolo Abeni <pabeni@redhat.com>
>     mptcp: corner case locking for rx path fields initialization
> 
> Paolo Abeni <pabeni@redhat.com>
>     mptcp: fix more tx path fields initialization
> 
> Geliang Tang <geliang.tang@linux.dev>
>     mptcp: use mptcp_set_state
> 
> Geliang Tang <geliang.tang@linux.dev>
>     mptcp: add CurrEstab MIB counter support
> 
> Steve French <stfrench@microsoft.com>
>     smb3: clarify mount warning
> 
> Shyam Prasad N <sprasad@microsoft.com>
>     cifs: handle cases where multiple sessions share connection
> 
> Shyam Prasad N <sprasad@microsoft.com>
>     cifs: change tcon status when need_reconnect is set on it
> 
> Yi Sun <yi.sun@unisoc.com>
>     virtio-blk: Ensure no requests in virtqueues before deleting vqs.
> 
> Paulo Alcantara <pc@manguebit.com>
>     smb: client: set correct d_type for reparse points under DFS mounts
> 
> Lijo Lazar <lijo.lazar@amd.com>
>     drm/amdgpu: Fix HDP flush for VFs on nbio v7.9
> 
> Stanley.Yang <Stanley.Yang@amd.com>
>     drm/amdgpu: Fix shared buff copy to user
> 
> Prike Liang <Prike.Liang@amd.com>
>     drm/amdgpu: reset gpu for s3 suspend abort case
> 
> Prike Liang <Prike.Liang@amd.com>
>     drm/amdgpu: skip to program GFXDEC registers for suspend abort
> 
> Xiubo Li <xiubli@redhat.com>
>     ceph: always check dir caps asynchronously
> 
> Xiubo Li <xiubli@redhat.com>
>     libceph: fail sparse-read if the data length doesn't match
> 
> Takashi Sakamoto <o-takashi@sakamocchi.jp>
>     firewire: core: send bus reset promptly on gap count error
> 
> Krystian Pradzynski <krystian.pradzynski@intel.com>
>     accel/ivpu/40xx: Stop passing SKU boot parameters to FW
> 
> Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
>     accel/ivpu: Disable d3hot_delay on all NPU generations
> 
> Wachowski, Karol <karol.wachowski@intel.com>
>     accel/ivpu: Force snooping for MMU writes
> 
> Kees Cook <keescook@chromium.org>
>     LoongArch: vDSO: Disable UBSAN instrumentation
> 
> Huacai Chen <chenhuacai@kernel.org>
>     LoongArch: Change acpi_core_pic[NR_CPUS] to acpi_core_pic[MAX_CORE_PIC]
> 
> Masahiro Yamada <masahiroy@kernel.org>
>     LoongArch: Select HAVE_ARCH_SECCOMP to use the common SECCOMP menu
> 
> Masahiro Yamada <masahiroy@kernel.org>
>     LoongArch: Select ARCH_ENABLE_THP_MIGRATION instead of redefining it
> 
> SEO HOYOUNG <hy50.seo@samsung.com>
>     scsi: ufs: core: Remove the ufshcd_release() in ufshcd_err_handling_prepare()
> 
> Alice Chao <alice.chao@mediatek.com>
>     scsi: ufs: core: Fix shift issue in ufshcd_clear_cmd()
> 
> Hannes Reinecke <hare@suse.de>
>     scsi: lpfc: Use unsigned type for num_sge
> 
> Timur Tabi <ttabi@nvidia.com>
>     drm/nouveau: nvkm_gsp_radix3_sg() should use nvkm_gsp_mem_ctor()
> 
> Zhang Rui <rui.zhang@intel.com>
>     hwmon: (coretemp) Enlarge per package core count limit
> 
> Andrew Bresticker <abrestic@rivosinc.com>
>     efi: Don't add memblocks for soft-reserved memory
> 
> Andrew Bresticker <abrestic@rivosinc.com>
>     efi: runtime: Fix potential overflow of soft-reserved region size
> 
> Benjamin Berg <benjamin.berg@intel.com>
>     wifi: iwlwifi: do not announce EPCS support
> 
> Johannes Berg <johannes.berg@intel.com>
>     wifi: mac80211: accept broadcast probe responses on 6 GHz
> 
> Johannes Berg <johannes.berg@intel.com>
>     wifi: mac80211: adding missing drv_mgd_complete_tx() call
> 
> Johannes Berg <johannes.berg@intel.com>
>     wifi: mac80211: initialize SMPS mode correctly
> 
> Johannes Berg <johannes.berg@intel.com>
>     wifi: mac80211: fix driver debugfs for vif type change
> 
> Johannes Berg <johannes.berg@intel.com>
>     wifi: mac80211: set station RX-NSS on reconfig
> 
> Edward Adam Davis <eadavis@qq.com>
>     fs/ntfs3: Fix oob in ntfs_listxattr
> 
> Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
>     fs/ntfs3: Update inode->i_size after success write into compressed file
> 
> Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
>     fs/ntfs3: Fixed overflow check in mi_enum_attr()
> 
> Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
>     fs/ntfs3: Correct function is_rst_area_valid
> 
> Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
>     fs/ntfs3: Use i_size_read and i_size_write
> 
> Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
>     fs/ntfs3: Prevent generic message "attempt to access beyond end of device"
> 
> Ism Hong <ism.hong@gmail.com>
>     fs/ntfs3: use non-movable memory for ntfs3 MFT buffer cache
> 
> Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
>     fs/ntfs3: Use kvfree to free memory allocated by kvmalloc
> 
> Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
>     fs/ntfs3: Disable ATTR_LIST_ENTRY size check
> 
> Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
>     fs/ntfs3: Fix c/mtime typo
> 
> Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
>     fs/ntfs3: Add NULL ptr dereference checking at the end of attr_allocate_frame()
> 
> Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
>     fs/ntfs3: Add and fix comments
> 
> Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
>     fs/ntfs3: ntfs3_forced_shutdown use int instead of bool
> 
> Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
>     fs/ntfs3: Implement super_operations::shutdown
> 
> Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
>     fs/ntfs3: Drop suid and sgid bits as a part of fpunch
> 
> Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
>     fs/ntfs3: Add file_modified
> 
> Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
>     fs/ntfs3: Correct use bh_read
> 
> Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
>     fs/ntfs3: Fix detected field-spanning write (size 8) of single field "le->name"
> 
> Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
>     fs/ntfs3: Fix multithreaded stress test
> 
> Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
>     fs/ntfs3: Reduce stack usage
> 
> Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
>     fs/ntfs3: Print warning while fixing hard links count
> 
> Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
>     fs/ntfs3: Correct hard links updating when dealing with DOS names
> 
> Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
>     fs/ntfs3: Improve ntfs_dir_count
> 
> Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
>     fs/ntfs3: Modified fix directory element type detection
> 
> Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
>     fs/ntfs3: Improve alternative boot processing
> 
> Szilard Fabian <szfabian@bluemarch.art>
>     Input: i8042 - add Fujitsu Lifebook U728 to i8042 quirk table
> 
> Zhang Yi <yi.zhang@huawei.com>
>     ext4: correct the hole length returned by ext4_map_blocks()
> 
> Paulo Alcantara <pc@manguebit.com>
>     smb: client: increase number of PDUs allowed in a compound request
> 
> Shyam Prasad N <sprasad@microsoft.com>
>     cifs: do not search for channel if server is terminating
> 
> Daniel Wagner <dwagner@suse.de>
>     nvmet-fc: take ref count on tgtport before delete assoc
> 
> Daniel Wagner <dwagner@suse.de>
>     nvmet-fc: avoid deadlock on delete association path
> 
> Daniel Wagner <dwagner@suse.de>
>     nvmet-fc: abort command when there is no binding
> 
> Daniel Wagner <dwagner@suse.de>
>     nvmet-fc: hold reference on hostport match
> 
> Daniel Wagner <dwagner@suse.de>
>     nvmet-fc: free queue and assoc directly
> 
> Daniel Wagner <dwagner@suse.de>
>     nvmet-fc: defer cleanup using RCU properly
> 
> Daniel Wagner <dwagner@suse.de>
>     nvmet-fc: release reference on target port
> 
> Daniel Wagner <dwagner@suse.de>
>     nvmet-fcloop: swap the list_add_tail arguments
> 
> Daniel Wagner <dwagner@suse.de>
>     nvme-fc: do not wait in vain when unloading module
> 
> Alexander Tsoy <alexander@tsoy.me>
>     ALSA: usb-audio: Ignore clock selector errors for single connection
> 
> Richard Fitzgerald <rf@opensource.cirrus.com>
>     ASoC: wm_adsp: Don't overwrite fwf_name with the default
> 
> Shyam Prasad N <sprasad@microsoft.com>
>     cifs: make sure that channel scaling is done only once
> 
> Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
>     drm/amd/display: Fix DPSTREAM CLK on and off sequence
> 
> Charlene Liu <charlene.liu@amd.com>
>     drm/amd/display: fix USB-C flag update after enc10 feature init
> 
> Sohaib Nadeem <sohaib.nadeem@amd.com>
>     drm/amd/display: increased min_dcfclk_mhz and min_fclk_mhz
> 
> Mukul Joshi <mukul.joshi@amd.com>
>     drm/amdkfd: Use correct drm device for cgroup permission check
> 
> Xin Long <lucien.xin@gmail.com>
>     netfilter: conntrack: check SCTP_CID_SHUTDOWN_ACK for vtag setting in sctp_new
> 
> Will Deacon <will@kernel.org>
>     misc: open-dice: Fix spurious lockdep warning
> 
> Brenton Simpson <appsforartists@google.com>
>     Input: xpad - add Lenovo Legion Go controllers
> 
> Wolfram Sang <wsa+renesas@sang-engineering.com>
>     spi: sh-msiof: avoid integer overflow in constants
> 
> Patrick Rudolph <patrick.rudolph@9elements.com>
>     regulator (max5970): Fix IRQ handler
> 
> Chhayly Leang <clw.leang@gmail.com>
>     ALSA: hda: cs35l41: Support ASUS Zenbook UM3402YAR
> 
> Kenzo Gomez <kenzo.sgomez@gmail.com>
>     ALSA: hda: cs35l41: Support additional ASUS Zenbook UX3402VA
> 
> Chen-Yu Tsai <wens@csie.org>
>     ASoC: sunxi: sun4i-spdif: Add support for Allwinner H616
> 
> Alexander Tsoy <alexander@tsoy.me>
>     ALSA: usb-audio: Check presence of valid altsetting control
> 
> Christian A. Ehrhardt <lk@c--e.de>
>     usb: ucsi_acpi: Quirk to ack a connector change ack cmd
> 
> Guixin Liu <kanie@linux.alibaba.com>
>     nvmet-tcp: fix nvme tcp ida memory leak
> 
> Kunwu Chan <chentao@kylinos.cn>
>     HID: nvidia-shield: Add missing null pointer checks to LED initialization
> 
> Rui Salvaterra <rsalvaterra@gmail.com>
>     ALSA: hda: Increase default bdl_pos_adj for Apollo Lake
> 
> Rui Salvaterra <rsalvaterra@gmail.com>
>     ALSA: hda: Replace numeric device IDs with constant values
> 
> Jiri Kosina <jikos@kernel.org>
>     HID: logitech-hidpp: add support for Logitech G Pro X Superlight 2
> 
> Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>     regulator: pwm-regulator: Add validity checks in continuous .get_voltage
> 
> Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
>     ASoC: amd: acp: Add check for cpu dai link initialization
> 
> Kunwu Chan <chentao@kylinos.cn>
>     dmaengine: ti: edma: Add some null pointer checks to the edma_probe
> 
> Hans de Goede <hdegoede@redhat.com>
>     Input: goodix - accept ACPI resources with gpio_count == 3 && gpio_int_idx == 0
> 
> Baokun Li <libaokun1@huawei.com>
>     ext4: avoid allocating blocks from corrupted group in ext4_mb_find_by_goal()
> 
> Baokun Li <libaokun1@huawei.com>
>     ext4: avoid allocating blocks from corrupted group in ext4_mb_try_best_found()
> 
> Baokun Li <libaokun1@huawei.com>
>     ext4: avoid dividing by 0 in mb_update_avg_fragment_size() when block bitmap corrupt
> 
> Phoenix Chen <asbeltogf@gmail.com>
>     platform/x86: touchscreen_dmi: Add info for the TECLAST X16 Plus tablet
> 
> Huang Pei <huangpei@loongson.cn>
>     MIPS: reserve exception vector space ONLY ONCE
> 
> Roman Li <Roman.Li@amd.com>
>     drm/amd/display: Disable ips before dc interrupt setting
> 
> Lukas Wunner <lukas@wunner.de>
>     ARM: dts: Fix TPM schema violations
> 
> Lennert Buytenhek <kernel@wantstofly.org>
>     ahci: add 43-bit DMA address quirk for ASMedia ASM1061 controllers
> 
> Charles Keepax <ckeepax@opensource.cirrus.com>
>     spi: cs42l43: Handle error from devm_pm_runtime_enable
> 
> Maksim Kiselev <bigunclemax@gmail.com>
>     aoe: avoid potential deadlock at set_capacity
> 
> Conrad Kostecki <conikost@gentoo.org>
>     ahci: asm1166: correct count of reported ports
> 
> Shyam Prasad N <sprasad@microsoft.com>
>     cifs: helper function to check replayable error codes
> 
> Shyam Prasad N <sprasad@microsoft.com>
>     cifs: translate network errors on send to -ECONNABORTED
> 
> Shyam Prasad N <sprasad@microsoft.com>
>     cifs: cifs_pick_channel should try selecting active channels
> 
> Kees Cook <keescook@chromium.org>
>     smb: Work around Clang __bdos() type confusion
> 
> Christian A. Ehrhardt <lk@c--e.de>
>     block: Fix WARNING in _copy_from_iter
> 
> Devyn Liu <liudingyuan@huawei.com>
>     spi: hisi-sfc-v3xx: Return IRQ_NONE if no interrupts were detected
> 
> Mika Westerberg <mika.westerberg@linux.intel.com>
>     spi: intel-pci: Add support for Arrow Lake SPI serial flash
> 
> Liming Sun <limings@nvidia.com>
>     platform/mellanox: mlxbf-tmfifo: Drop Tx network packet when Tx TmFIFO is full
> 
> Fullway Wang <fullwaywang@outlook.com>
>     fbdev: sis: Error out if pixclock equals zero
> 
> Fullway Wang <fullwaywang@outlook.com>
>     fbdev: savage: Error out if pixclock equals zero
> 
> Felix Fietkau <nbd@nbd.name>
>     wifi: mac80211: fix race condition on enabling fast-xmit
> 
> Michal Kazior <michal@plume.com>
>     wifi: cfg80211: fix missing interfaces when dumping
> 
> Vinod Koul <vkoul@kernel.org>
>     dmaengine: dw-edma: increase size of 'name' in debugfs code
> 
> Vinod Koul <vkoul@kernel.org>
>     dmaengine: fsl-qdma: increase size of 'irq_name'
> 
> Vinod Koul <vkoul@kernel.org>
>     dmaengine: shdma: increase size of 'dev_id'
> 
> Shyam Prasad N <sprasad@microsoft.com>
>     cifs: open_cached_dir should not rely on primary channel
> 
> Dmitry Bogdanov <d.bogdanov@yadro.com>
>     scsi: target: core: Add TMF to tmr_list handling
> 
> Christoph Müllner <christoph.muellner@vrull.eu>
>     tools: selftests: riscv: Fix compile warnings in mm tests
> 
> Christoph Müllner <christoph.muellner@vrull.eu>
>     tools: selftests: riscv: Fix compile warnings in vector tests
> 
> Christoph Müllner <christoph.muellner@vrull.eu>
>     tools: selftests: riscv: Fix compile warnings in cbo
> 
> Christoph Müllner <christoph.muellner@vrull.eu>
>     tools: selftests: riscv: Fix compile warnings in hwprobe
> 
> Mahesh Rajashekhara <mahesh.rajashekhara@microchip.com>
>     scsi: smartpqi: Fix logical volume rescan race condition
> 
> David Strahan <david.strahan@microchip.com>
>     scsi: smartpqi: Add new controller PCI IDs
> 
> Hector Martin <marcan@marcan.st>
>     dmaengine: apple-admac: Keep upper bits of REG_BUS_WIDTH
> 
> Mario Limonciello <mario.limonciello@amd.com>
>     drm/amd: Stop evicting resources on APUs in suspend
> 
> 
> -------------
> 
> Diffstat:
> 
>  Documentation/conf.py                              |   6 +
>  Documentation/dev-tools/kunit/usage.rst            |  10 +-
>  Makefile                                           |   4 +-
>  .../dts/aspeed/aspeed-bmc-facebook-bletchley.dts   |   4 +-
>  .../dts/aspeed/aspeed-bmc-facebook-wedge400.dts    |   4 +-
>  arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts |   2 +-
>  .../dts/aspeed/ast2600-facebook-netbmc-common.dtsi |   4 +-
>  .../arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi |   2 +-
>  .../boot/dts/nxp/imx/imx7d-flex-concentrator.dts   |   2 +-
>  .../dts/ti/omap/am335x-moxa-uc-2100-common.dtsi    |   2 +-
>  arch/arm/mach-ep93xx/core.c                        |   1 +
>  .../dts/freescale/imx8mp-data-modul-edm-sbc.dts    |   2 +-
>  .../dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts    |   9 +-
>  arch/arm64/boot/dts/rockchip/px30.dtsi             |   2 +
>  .../boot/dts/rockchip/rk3588s-indiedroid-nova.dts  |  10 +-
>  arch/arm64/include/asm/fpsimd.h                    |   2 +
>  arch/arm64/kernel/fpsimd.c                         |  16 ++
>  arch/arm64/kernel/suspend.c                        |   3 +
>  arch/arm64/kvm/vgic/vgic-its.c                     |   5 +
>  arch/loongarch/Kconfig                             |  23 +--
>  arch/loongarch/include/asm/acpi.h                  |   4 +-
>  arch/loongarch/kernel/acpi.c                       |   4 +-
>  arch/loongarch/kernel/setup.c                      |   4 +-
>  arch/loongarch/kernel/smp.c                        | 122 ++++++-----
>  arch/loongarch/vdso/Makefile                       |   1 +
>  arch/mips/kernel/traps.c                           |   8 +-
>  arch/parisc/kernel/processor.c                     |   8 -
>  arch/parisc/kernel/unwind.c                        |  14 +-
>  arch/powerpc/include/asm/ppc-pci.h                 |  10 +
>  arch/powerpc/kernel/iommu.c                        |  23 ++-
>  arch/powerpc/kvm/book3s_hv.c                       |  26 ++-
>  arch/powerpc/kvm/book3s_hv_nestedv2.c              |  20 +-
>  arch/powerpc/platforms/pseries/pci_dlpar.c         |   4 +
>  arch/s390/pci/pci.c                                |   2 +-
>  arch/sparc/Makefile                                |   2 +-
>  arch/sparc/video/Makefile                          |   2 +-
>  arch/x86/entry/entry.S                             |  23 +++
>  arch/x86/include/asm/cpufeatures.h                 |   2 +-
>  arch/x86/include/asm/nospec-branch.h               |  13 ++
>  arch/x86/kernel/traps.c                            |   2 +-
>  arch/x86/mm/numa.c                                 |  21 +-
>  block/blk-map.c                                    |  13 +-
>  drivers/accel/ivpu/ivpu_drv.c                      |   5 +-
>  drivers/accel/ivpu/ivpu_hw_37xx.c                  |   2 +-
>  drivers/accel/ivpu/ivpu_hw_40xx.c                  |   9 +-
>  drivers/accel/ivpu/ivpu_mmu.c                      |   3 -
>  drivers/ata/ahci.c                                 |  44 +++-
>  drivers/ata/ahci.h                                 |   1 +
>  drivers/ata/ahci_ceva.c                            | 125 ++++++-----
>  drivers/ata/libata-core.c                          |  87 ++++----
>  drivers/block/aoe/aoeblk.c                         |   5 +-
>  drivers/block/virtio_blk.c                         |   7 +-
>  drivers/bus/imx-weim.c                             |   2 +-
>  drivers/cache/ax45mp_cache.c                       |   4 +
>  .../crypto/virtio/virtio_crypto_akcipher_algs.c    |   5 +-
>  drivers/cxl/acpi.c                                 |  46 +++--
>  drivers/cxl/core/pci.c                             |  49 +++--
>  drivers/dma/apple-admac.c                          |   5 +-
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.c           |   4 +-
>  drivers/dma/dw-edma/dw-hdma-v0-debugfs.c           |   4 +-
>  drivers/dma/fsl-qdma.c                             |   2 +-
>  drivers/dma/sh/shdma.h                             |   2 +-
>  drivers/dma/ti/edma.c                              |  10 +
>  drivers/firewire/core-card.c                       |  18 +-
>  drivers/firmware/efi/arm-runtime.c                 |   2 +-
>  drivers/firmware/efi/efi-init.c                    |  19 +-
>  drivers/firmware/efi/riscv-runtime.c               |   2 +-
>  drivers/gpio/gpiolib.c                             |   5 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   4 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c           |  18 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  11 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c         |   2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   8 +
>  drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c             |   6 +
>  drivers/gpu/drm/amd/amdgpu/soc15.c                 |  22 ++
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   9 +-
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  57 +++---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  |   5 +-
>  drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |  16 +-
>  .../gpu/drm/amd/display/dc/core/dc_link_exports.c  |   2 +-
>  drivers/gpu/drm/amd/display/dc/dc.h                |   4 +-
>  drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c       |   7 +-
>  drivers/gpu/drm/amd/display/dc/dc_dp_types.h       |   6 +
>  drivers/gpu/drm/amd/display/dc/dc_types.h          |  14 +-
>  .../gpu/drm/amd/display/dc/dce/dce_panel_cntl.c    |   1 +
>  .../drm/amd/display/dc/dcn301/dcn301_panel_cntl.c  |   1 +
>  .../drm/amd/display/dc/dcn31/dcn31_panel_cntl.c    |  18 +-
>  .../amd/display/dc/dcn32/dcn32_dio_link_encoder.c  |   4 +-
>  .../amd/display/dc/dcn35/dcn35_dio_link_encoder.c  |   4 +-
>  .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  |   2 +-
>  .../drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c    |  11 +-
>  drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h |   2 +-
>  drivers/gpu/drm/amd/display/dc/link/link_dpms.c    |  42 +++-
>  drivers/gpu/drm/amd/display/dc/link/link_factory.c |  26 +--
>  .../gpu/drm/amd/display/dc/link/link_validation.c  |  60 +++++-
>  .../display/dc/link/protocols/link_dp_dpia_bw.c    | 178 ++++++++++++----
>  .../display/dc/link/protocols/link_dp_dpia_bw.h    |   9 +
>  drivers/gpu/drm/drm_buddy.c                        |   4 +-
>  drivers/gpu/drm/drm_syncobj.c                      |  19 +-
>  drivers/gpu/drm/i915/display/intel_sdvo.c          |  10 +-
>  drivers/gpu/drm/i915/display/intel_tv.c            |  10 +-
>  drivers/gpu/drm/meson/meson_encoder_cvbs.c         |   1 -
>  drivers/gpu/drm/meson/meson_encoder_dsi.c          |   1 -
>  drivers/gpu/drm/meson/meson_encoder_hdmi.c         |   1 -
>  drivers/gpu/drm/nouveau/nvkm/subdev/bar/r535.c     |   5 +-
>  drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c  |   8 +-
>  drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c     |  18 +-
>  drivers/gpu/drm/ttm/ttm_pool.c                     |   2 +-
>  drivers/hid/hid-logitech-hidpp.c                   |   2 +
>  drivers/hid/hid-nvidia-shield.c                    |   4 +
>  drivers/hwmon/coretemp.c                           |   2 +-
>  drivers/hwmon/nct6775-core.c                       |  14 +-
>  drivers/i2c/busses/i2c-imx.c                       |   5 +
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c           |   5 +-
>  drivers/infiniband/hw/bnxt_re/qplib_fp.c           |   3 +-
>  drivers/infiniband/hw/hfi1/pio.c                   |   6 +-
>  drivers/infiniband/hw/hfi1/sdma.c                  |   2 +-
>  drivers/infiniband/hw/irdma/defs.h                 |   1 +
>  drivers/infiniband/hw/irdma/hw.c                   |   8 +
>  drivers/infiniband/hw/irdma/verbs.c                |   9 +-
>  drivers/infiniband/hw/mlx5/cong.c                  |   6 +
>  drivers/infiniband/hw/qedr/verbs.c                 |  11 +-
>  drivers/infiniband/ulp/srpt/ib_srpt.c              |  17 +-
>  drivers/input/joystick/xpad.c                      |   2 +
>  drivers/input/serio/i8042-acpipnpio.h              |   8 +
>  drivers/input/touchscreen/goodix.c                 |   3 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |  45 ++--
>  drivers/iommu/intel/iommu.c                        |  87 ++++++--
>  drivers/iommu/intel/iommu.h                        |   7 +
>  drivers/iommu/intel/nested.c                       |  14 +-
>  drivers/iommu/intel/pasid.c                        |   5 +-
>  drivers/iommu/intel/pasid.h                        |   1 -
>  drivers/iommu/iommu-sva.c                          |   2 +-
>  drivers/iommu/iommufd/hw_pagetable.c               |   3 +-
>  drivers/iommu/iommufd/iova_bitmap.c                |  68 +++++-
>  drivers/irqchip/irq-gic-v3-its.c                   |   2 +-
>  drivers/irqchip/irq-mbigen.c                       |   8 +-
>  drivers/irqchip/irq-sifive-plic.c                  |   8 +-
>  drivers/md/dm-crypt.c                              |  95 +++++++--
>  drivers/md/dm-integrity.c                          |  91 +++++++-
>  drivers/md/dm-verity-target.c                      |  86 +++++++-
>  drivers/md/dm-verity.h                             |   6 +
>  drivers/md/md.c                                    |  70 ++++---
>  drivers/md/raid10.c                                |  16 +-
>  drivers/md/raid5.c                                 |  29 +--
>  drivers/misc/open-dice.c                           |   2 +-
>  drivers/net/ethernet/adi/Kconfig                   |   1 +
>  drivers/net/ethernet/broadcom/asp2/bcmasp.c        |   6 +-
>  drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c   |   3 +
>  .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |   4 +
>  .../net/ethernet/microchip/sparx5/sparx5_main.c    |   1 +
>  .../net/ethernet/microchip/sparx5/sparx5_main.h    |   1 +
>  .../net/ethernet/microchip/sparx5/sparx5_packet.c  |   2 +
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  20 --
>  drivers/net/gtp.c                                  |  10 +-
>  drivers/net/ipa/ipa_interrupt.c                    |   2 +-
>  drivers/net/phy/realtek.c                          |   4 +-
>  drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |   5 +-
>  drivers/nvme/host/fc.c                             |  47 +----
>  drivers/nvme/target/fc.c                           | 137 +++++++------
>  drivers/nvme/target/fcloop.c                       |   6 +-
>  drivers/nvme/target/tcp.c                          |   1 +
>  drivers/pci/msi/irqdomain.c                        |   2 +-
>  drivers/platform/mellanox/mlxbf-tmfifo.c           |  67 ++++++
>  drivers/platform/x86/intel/vbtn.c                  |   3 -
>  drivers/platform/x86/think-lmi.c                   |  20 +-
>  drivers/platform/x86/thinkpad_acpi.c               |   5 +-
>  drivers/platform/x86/touchscreen_dmi.c             |  39 +++-
>  drivers/platform/x86/x86-android-tablets/core.c    |   3 +
>  drivers/platform/x86/x86-android-tablets/lenovo.c  |   1 +
>  .../x86/x86-android-tablets/x86-android-tablets.h  |   1 +
>  drivers/regulator/max5970-regulator.c              |   2 +-
>  drivers/regulator/pwm-regulator.c                  |   3 +
>  drivers/s390/cio/device_ops.c                      |   6 +-
>  drivers/scsi/Kconfig                               |   2 +-
>  drivers/scsi/lpfc/lpfc_scsi.c                      |  12 +-
>  drivers/scsi/scsi.c                                |  22 +-
>  drivers/scsi/sd.c                                  |  26 ++-
>  drivers/scsi/smartpqi/smartpqi.h                   |   1 -
>  drivers/scsi/smartpqi/smartpqi_init.c              |  88 +++++++-
>  drivers/spi/spi-cs42l43.c                          |   5 +-
>  drivers/spi/spi-hisi-sfc-v3xx.c                    |   5 +
>  drivers/spi/spi-intel-pci.c                        |   1 +
>  drivers/spi/spi-sh-msiof.c                         |  16 +-
>  drivers/target/target_core_device.c                |   5 -
>  drivers/target/target_core_pscsi.c                 |   9 +-
>  drivers/target/target_core_transport.c             |   4 +
>  drivers/tty/serial/amba-pl011.c                    |  60 +++---
>  drivers/tty/serial/stm32-usart.c                   |   4 +-
>  drivers/ufs/core/ufshcd.c                          |   7 +-
>  drivers/usb/cdns3/cdns3-gadget.c                   |   8 +-
>  drivers/usb/cdns3/core.c                           |   1 -
>  drivers/usb/cdns3/drd.c                            |  13 +-
>  drivers/usb/cdns3/drd.h                            |   6 +-
>  drivers/usb/cdns3/host.c                           |  16 +-
>  drivers/usb/dwc3/gadget.c                          |   5 +
>  drivers/usb/gadget/function/f_ncm.c                |  10 +-
>  drivers/usb/gadget/udc/omap_udc.c                  |   3 +-
>  drivers/usb/roles/class.c                          |  29 ++-
>  drivers/usb/storage/scsiglue.c                     |   7 +
>  drivers/usb/storage/uas.c                          |   7 +
>  drivers/usb/typec/tcpm/tcpm.c                      |   3 -
>  drivers/usb/typec/ucsi/ucsi_acpi.c                 |  71 ++++++-
>  drivers/video/fbdev/savage/savagefb_driver.c       |   3 +
>  drivers/video/fbdev/sis/sis_main.c                 |   2 +
>  fs/afs/volume.c                                    |   4 +-
>  fs/aio.c                                           |   9 +-
>  fs/btrfs/defrag.c                                  |   2 +-
>  fs/cachefiles/cache.c                              |   2 +
>  fs/cachefiles/daemon.c                             |   1 +
>  fs/ceph/caps.c                                     |   6 -
>  fs/ceph/mds_client.c                               |   9 +-
>  fs/ceph/mds_client.h                               |   2 +-
>  fs/ceph/super.h                                    |   2 -
>  fs/erofs/namei.c                                   |  28 +--
>  fs/ext4/extents.c                                  | 111 ++++++----
>  fs/ext4/mballoc.c                                  |  15 +-
>  fs/ntfs3/attrib.c                                  |  45 ++--
>  fs/ntfs3/attrlist.c                                |  12 +-
>  fs/ntfs3/bitmap.c                                  |   4 +-
>  fs/ntfs3/dir.c                                     |  44 ++--
>  fs/ntfs3/file.c                                    |  72 +++++--
>  fs/ntfs3/frecord.c                                 |  19 +-
>  fs/ntfs3/fslog.c                                   | 228 ++++++++++-----------
>  fs/ntfs3/fsntfs.c                                  |  29 ++-
>  fs/ntfs3/index.c                                   |   8 +-
>  fs/ntfs3/inode.c                                   |  32 ++-
>  fs/ntfs3/namei.c                                   |  12 ++
>  fs/ntfs3/ntfs.h                                    |   4 +-
>  fs/ntfs3/ntfs_fs.h                                 |  25 +--
>  fs/ntfs3/record.c                                  |  18 +-
>  fs/ntfs3/super.c                                   |  49 +++--
>  fs/ntfs3/xattr.c                                   |   6 +
>  fs/smb/client/cached_dir.c                         |   3 +-
>  fs/smb/client/cifsencrypt.c                        |   2 +-
>  fs/smb/client/cifsglob.h                           |  12 +-
>  fs/smb/client/connect.c                            |  11 +
>  fs/smb/client/dfs.c                                |   7 +-
>  fs/smb/client/file.c                               |   3 +
>  fs/smb/client/fs_context.c                         |   2 +-
>  fs/smb/client/readdir.c                            |  15 +-
>  fs/smb/client/sess.c                               |   5 +-
>  fs/smb/client/smb2pdu.c                            |  26 ++-
>  fs/smb/client/transport.c                          |  18 +-
>  include/kunit/resource.h                           |  21 ++
>  include/linux/ceph/osd_client.h                    |   3 +-
>  include/linux/fs.h                                 |   2 +
>  include/linux/iommu.h                              |  12 ++
>  include/linux/memblock.h                           |   2 +
>  include/linux/mlx5/mlx5_ifc.h                      |   2 +-
>  include/linux/swap.h                               |   5 +
>  include/net/netfilter/nf_flow_table.h              |   2 +-
>  include/net/switchdev.h                            |   3 +
>  include/net/tcp.h                                  |   2 +-
>  include/scsi/scsi_device.h                         |   5 +-
>  kernel/bpf/helpers.c                               |   5 +-
>  lib/Kconfig.debug                                  |   1 +
>  lib/kunit/kunit-test.c                             |   5 +-
>  lib/kunit/test.c                                   |   6 +-
>  mm/damon/core.c                                    |  15 +-
>  mm/damon/lru_sort.c                                |  43 +++-
>  mm/damon/reclaim.c                                 |  18 +-
>  mm/memblock.c                                      |   6 +-
>  mm/memcontrol.c                                    |  10 +-
>  mm/memory.c                                        |  20 ++
>  mm/swap.h                                          |   5 +
>  mm/swapfile.c                                      |  13 ++
>  mm/zswap.c                                         |   7 +-
>  net/bridge/br_switchdev.c                          |  86 +++++---
>  net/ceph/osd_client.c                              |  18 +-
>  net/core/skmsg.c                                   |   7 +-
>  net/core/sock.c                                    |  23 +--
>  net/devlink/core.c                                 |  12 +-
>  net/devlink/port.c                                 |   2 +-
>  net/ipv4/arp.c                                     |   3 +-
>  net/ipv4/devinet.c                                 |  21 +-
>  net/ipv4/inet_hashtables.c                         |  25 ++-
>  net/ipv4/udp.c                                     |   7 +-
>  net/ipv6/addrconf.c                                |  21 +-
>  net/ipv6/exthdrs.c                                 |  10 +
>  net/ipv6/seg6.c                                    |  20 +-
>  net/l2tp/l2tp_ip6.c                                |   2 +-
>  net/mac80211/cfg.c                                 |   2 +
>  net/mac80211/debugfs_netdev.c                      |   4 +-
>  net/mac80211/debugfs_netdev.h                      |   5 -
>  net/mac80211/iface.c                               |   2 +-
>  net/mac80211/mlme.c                                |   8 +-
>  net/mac80211/scan.c                                |  30 +--
>  net/mac80211/sta_info.c                            |   2 +
>  net/mac80211/tx.c                                  |   2 +-
>  net/mctp/route.c                                   |   2 +-
>  net/mptcp/diag.c                                   |   8 +-
>  net/mptcp/fastopen.c                               |   6 +-
>  net/mptcp/mib.c                                    |   1 +
>  net/mptcp/mib.h                                    |   8 +
>  net/mptcp/options.c                                |   9 +-
>  net/mptcp/pm_netlink.c                             |  74 ++++---
>  net/mptcp/pm_userspace.c                           |  15 +-
>  net/mptcp/protocol.c                               |  69 ++++---
>  net/mptcp/protocol.h                               |  25 ++-
>  net/mptcp/subflow.c                                |  86 +++++---
>  net/netfilter/nf_conntrack_proto_sctp.c            |   2 +-
>  net/netfilter/nf_flow_table_core.c                 |  17 +-
>  net/netfilter/nf_tables_api.c                      |  81 ++++----
>  net/phonet/datagram.c                              |   4 +-
>  net/phonet/pep.c                                   |  41 +++-
>  net/sched/act_mirred.c                             | 147 ++++++-------
>  net/sched/cls_flower.c                             |   5 +-
>  net/switchdev/switchdev.c                          |  73 +++++++
>  net/tls/tls_main.c                                 |   2 +-
>  net/tls/tls_sw.c                                   |  24 ++-
>  net/unix/af_unix.c                                 |  19 +-
>  net/wireless/nl80211.c                             |   1 +
>  net/xdp/xsk.c                                      |   3 +-
>  scripts/bpf_doc.py                                 |   2 +-
>  sound/pci/hda/cs35l41_hda_property.c               |   4 +
>  sound/pci/hda/hda_intel.c                          |   6 +-
>  sound/soc/amd/acp/acp-mach-common.c                |   9 +-
>  sound/soc/codecs/wm_adsp.c                         |  29 ++-
>  sound/soc/sunxi/sun4i-spdif.c                      |   5 +
>  sound/usb/clock.c                                  |  10 +-
>  sound/usb/format.c                                 |  20 ++
>  tools/net/ynl/lib/ynl.c                            |  19 +-
>  .../selftests/drivers/net/bonding/bond_options.sh  |   2 +
>  tools/testing/selftests/iommu/config               |   5 +-
>  tools/testing/selftests/mm/uffd-unit-tests.c       |   6 +
>  .../testing/selftests/net/forwarding/tc_actions.sh |   3 -
>  tools/testing/selftests/net/mptcp/diag.sh          |  46 ++++-
>  tools/testing/selftests/net/mptcp/mptcp_connect.sh |  41 ++--
>  tools/testing/selftests/net/mptcp/mptcp_join.sh    | 109 ++++------
>  tools/testing/selftests/net/mptcp/mptcp_lib.sh     |  16 ++
>  tools/testing/selftests/net/mptcp/pm_netlink.sh    |   8 +-
>  tools/testing/selftests/net/mptcp/simult_flows.sh  |   3 +-
>  tools/testing/selftests/net/mptcp/userspace_pm.sh  |  18 +-
>  tools/testing/selftests/riscv/hwprobe/cbo.c        |   6 +-
>  tools/testing/selftests/riscv/hwprobe/hwprobe.c    |   4 +-
>  tools/testing/selftests/riscv/mm/mmap_test.h       |   3 +
>  .../selftests/riscv/vector/v_initval_nolibc.c      |   2 +-
>  .../testing/selftests/riscv/vector/vstate_prctl.c  |   4 +-
>  340 files changed, 3847 insertions(+), 1826 deletions(-)
> 
> 
> 

