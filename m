Return-Path: <linux-kernel+bounces-97132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB478765E9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF23E1F21E78
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B6A3FB97;
	Fri,  8 Mar 2024 14:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sWvlGvuu"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5A538387
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709906501; cv=none; b=Sr5qrSNSMDvkuf9X18SbrNLABhsudoaZbAzfsM5tCe7wBsRXWDENgswbLdys6quRMbHz5uQMq/j6vXQ0Um3/FiXQ8YWEXGK9p9q3MWJZwH3s2neIj3CyW/ImTCnTNvrpL5sdcoKDOf82daKuedn4rvuHJwacJWlGhePz4nZWY28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709906501; c=relaxed/simple;
	bh=TNeZqC8EHdoA4zceFSfyNIbNSdFaBZamwbYEzWpB0Kc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=bV4j7eleHF1zRO3hj4+VL2rlJtR5dUb2zn0mKmWVnfDA1ymBZuufQLQR4bwcCdI/VEOwJD7IQWBPx1YmB2CazcUii7pTK4VW8ZbRI/Jhq1alJGttExfMxyBUEjJnZXBRmaO6yOY6f8GHsCTo6F+J/mF1Blk1klD41lQ6tvXuHt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=sWvlGvuu; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240308140131euoutp0260447e9471496dd6337ead1a008481dc~6zuT3tRVF1930719307euoutp022
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 14:01:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240308140131euoutp0260447e9471496dd6337ead1a008481dc~6zuT3tRVF1930719307euoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1709906491;
	bh=yvoRig0S09QVE9AUSR2TjWuRGFhrpL5hFmGUmGlruEA=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=sWvlGvuu6pK8ckHd41Bwk0rVuCxCi2LBrM806b2th7jLHCmO2rWwm30w/xyRK0tb2
	 EEgi4UrcWacEJZfnRDEZB2KYmSY9WVGGxOdBiwOBCJkKny0E6ELaRDBlGty3mpAmo7
	 fud+eenYbN8CFSZ7nZaTtrTs7jh6PbB43g97ydCI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240308140130eucas1p29ed198df7ea0f3987a971d4db9c87191~6zuTcgUoH2092720927eucas1p2c;
	Fri,  8 Mar 2024 14:01:30 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id B9.D9.09552.A3A1BE56; Fri,  8
	Mar 2024 14:01:30 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240308140130eucas1p1259c805a0b6491ce2f69c6fca0264b1f~6zuS-PDwe2292522925eucas1p1x;
	Fri,  8 Mar 2024 14:01:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240308140130eusmtrp2f1a2e73eafe0413d9d29704d7bbb35f8~6zuS_XV7w0126801268eusmtrp2R;
	Fri,  8 Mar 2024 14:01:30 +0000 (GMT)
X-AuditID: cbfec7f5-83dff70000002550-42-65eb1a3a6805
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id F6.60.10702.A3A1BE56; Fri,  8
	Mar 2024 14:01:30 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240308140128eusmtip198a00a4ac169037c128c18da0e798558~6zuRksdd41842018420eusmtip10;
	Fri,  8 Mar 2024 14:01:28 +0000 (GMT)
Message-ID: <c1f2902d-cefc-4122-9b86-d1d32911f590@samsung.com>
Date: Fri, 8 Mar 2024 15:01:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ARM64: Dynamically allocate cpumasks and increase
 supported CPUs to 512
Content-Language: en-US
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>, Mark Rutland
	<mark.rutland@arm.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh
	Kumar <vireshk@kernel.org>
Cc: catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
	Jonathan.Cameron@huawei.com, Matteo.Carlini@arm.com,
	Valentin.Schneider@arm.com, akpm@linux-foundation.org,
	anshuman.khandual@arm.com, Eric Mackay <eric.mackay@oracle.com>,
	dave.kleikamp@oracle.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux@armlinux.org.uk,
	robin.murphy@arm.com, vanshikonda@os.amperecomputing.com,
	yang@os.amperecomputing.com, Nishanth Menon <nm@ti.com>, Stephen Boyd
	<sboyd@kernel.org>
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <37099a57-b655-3b3a-56d0-5f7fbd49d7db@gentwo.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf0xTVxjlvvf6WjrrnhXtHbhhGjGOsPoL4t1Y2MaMPJdNMFkysmxxjX0U
	BIppAYEYJdjBhpYVAhELSlV+gy0Wga04txakIOoouEqaijDAzQpORCcMVkZ5uPHfOec733e+
	7+bycGEB6c9LUKQySoU0SUzyidau2V/eesf/EbPNnrsNlRsbSXSt+yD6s/oUQDXlZzH084N+
	HI17qrmo/ryDRKZRBwcNmMtJNNS4wEHTmk6ArCU/AlR1146hueoXGJqYuYWhs89KcGR5MsZB
	HsdlArVVzOLoodNFoObhLhKpXWFIU9nDfV9EN55rBPSAw47TP3UoaXXnJIc21X9L0qanRVy6
	u3SOoJsrj9NT406CPjkwyKVtg20YPW16I2bV5/x3ZUxSQjqj3BrxFT/+wbnAw7OhGZe0tzjZ
	oCEkH/jyIBUKrxeNEvmAzxNStQBaXSOAJc8AnC7TYSyZBrC7o4n7ssXy/MmyqwbAx53NXJZM
	AWgZ1wGvS0BFwCsVJzleTFCbYPNdK8Hqa2DPmbElvI4KhPedpUtT11JS6G7T416MUyLoHKtY
	ivajhgAcMVzmsoViAma7RF5MUtth/mQ+6cW+i2HmouuA9QTCEy1luLcZUjl86Fr4mmT33g0v
	ms8TLF4L3bYry/dsgAs/sGmQygNQP3d/mWgBzP7dCVhXOHTd/ntxEm8x4k1oNG9l5Q+gu8DI
	9cqQWg0HJ9ewS6yGRa2ncVYWwG9yhax7M9TZDP/FWvr6cS0Q61a8i27F/boV5+j+z9UDoh6I
	mDRVspxR7VQwRyQqabIqTSGXHExJNoHFL9vrsT3/HtS6pyRWgPGAFUAeLvYTEOghIxTIpJlZ
	jDLlgDItiVFZQQCPEIsEQbJARkjJpalMIsMcZpQvqxjP1z8bO1b1HpWMHXrl3p7h28GO8A2J
	xpxVE7KEm54u+4efRl4M1r8WVIitf6qJqKV20jcSHjV5Mn7zGb0karL1fXZhvHq+t2Yw4A+f
	nMjwnthj0i2qEtHMUMf6uDu6+AjPiH4+tuWUI27HkfADj2P2af/afDSu+OiuX31Cuo8b6m6q
	7Wdmogqy8l/PSjnU+1FZXkmYaCIuL3GXav5GRjrkSGpaqvYOl9b5t/e3ujMNV6OjYzkyzX5J
	ut8nUZFRpfcsvhuLQ98u1O7J3bflRbxiR8zujZkNr17NuiYPIDTclMq9IV8U/rNO2O6WGDo0
	0bXygTt+QV+GfWw+4Upt71LXGRu+i72gnuoTE6p46fZgXKmS/gsEGWeEIQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsVy+t/xu7pWUq9TDU5f4beYs34Nm8W+E8kW
	75f1MFosnzOXyeLAs0vMFk//LWO3WLXwGpvFpsfXWC0u75rDZnFvzX9Wi8+9RxgtDk3dy2ix
	9PpFJovfy74zWbz5cZbJYu6XqcwWBz88YbX4d20ji8X2+T+ZLV7eusNisfnBMTaLljumFr1L
	TrI7iHusmbeG0ePytYvMHvsPF3m0HHnL6rFpVSebx6ZPk9g9Tsz4zeKxeUm9x8ent1g8ui/f
	YPc4fmM7k8fnTXIBPFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2Nimp
	OZllqUX6dgl6Gc/myRf8NKlYO+EsawPjap0uRk4OCQETiYNfPzB2MXJxCAksZZT4ffIoG0RC
	RuLktAZWCFtY4s+1LjaIoveMEg2vD7KAJHgF7CS2zO8GK2IRUJHYfP0QVFxQ4uTMJ2C2qIC8
	xP1bM9hBbGGBRIlX2xcwg9jMAuISt57MZwIZKiJwj1HiyKqzLCAOs8AUFolPu7cB3cQBtM5W
	YsPXbJAGNgFDia63XWDXcQIt3jXpKCPEIDOJrq1dULa8RPPW2cwTGIVmIbljFpJ9s5C0zELS
	soCRZRWjSGppcW56brGRXnFibnFpXrpecn7uJkZgStl27OeWHYwrX33UO8TIxMF4iFGCg1lJ
	hJfF4mWqEG9KYmVValF+fFFpTmrxIUZTYGBMZJYSTc4HJrW8knhDMwNTQxMzSwNTSzNjJXFe
	z4KORCGB9MSS1OzU1ILUIpg+Jg5OqQYmIbVLxhOUuPZeNBG69Oie1rqjgWdYtvBmMCwXbGX2
	rHu/4M/3D5Wr5zZ29xl/Co5+v1ThTaGiha7YxPAKg49Xjm1+/7zT/OurSpubH8wOX9W5Fqef
	ms7zsSMt4obtJ6Vk3tdaydyul39v2BOw9G5deXfvgdtKWZxRHybPykqMUuJjOxz2KSpVjfvO
	lW75tAvyApfPPKlcunjzYemPkzeuXbfcfcNZzfaNG+WP8gf/jzgidTP2kIjuh2039Lq2lFcy
	Nc596hb+Yf3UhjMcImySPf0+K9sV+IpFKvtmVQT/ahFz02Le83VKXZSo7TWDaT+P5d2rNTr+
	5OAUxgN6z9QVfvHc3j7FPr976skLwnumKbEUZyQaajEXFScCAI1Ije2yAwAA
X-CMS-MailID: 20240308140130eucas1p1259c805a0b6491ce2f69c6fca0264b1f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240308140130eucas1p1259c805a0b6491ce2f69c6fca0264b1f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240308140130eucas1p1259c805a0b6491ce2f69c6fca0264b1f
References: <37099a57-b655-3b3a-56d0-5f7fbd49d7db@gentwo.org>
	<CGME20240308140130eucas1p1259c805a0b6491ce2f69c6fca0264b1f@eucas1p1.samsung.com>

Dear All,

On 07.03.2024 02:45, Christoph Lameter (Ampere) wrote:
> Currently defconfig selects NR_CPUS=256, but some vendors (e.g. Ampere
> Computing) are planning to ship systems with 512 CPUs. So that all 
> CPUs on
> these systems can be used with defconfig, we'd like to bump NR_CPUS to 
> 512.
> Therefore this patch increases the default NR_CPUS from 256 to 512.
>
> As increasing NR_CPUS will increase the size of cpumasks, there's a 
> fear that
> this might have a significant impact on stack usage due to code which 
> places
> cpumasks on the stack. To mitigate that concern, we can select
> CPUMASK_OFFSTACK. As that doesn't seem to be a problem today with
> NR_CPUS=256, we only select this when NR_CPUS > 256.
>
> CPUMASK_OFFSTACK configures the cpumasks in the kernel to be
> dynamically allocated. This was used in the X86 architecture in the
> past to enable support for larger CPU configurations up to 8k cpus.
>
> With that is becomes possible to dynamically size the allocation of
> the cpu bitmaps depending on the quantity of processors detected on
> bootup. Memory used for cpumasks will increase if the kernel is
> run on a machine with more cores.
>
> Further increases may be needed if ARM processor vendors start
> supporting more processors. Given the current inflationary trends
> in core counts from multiple processor manufacturers this may occur.
>
> There are minor regressions for hackbench. The kernel data size
> for 512 cpus is smaller with offstack than with onstack.
>
> Benchmark results using hackbench average over 10 runs of
>
>     hackbench -s 512 -l 2000 -g 15 -f 25 -P
>
> on Altra 80 Core
>
> Support for 256 CPUs on stack. Baseline
>
>     7.8564 sec
>
> Support for 512 CUs on stack.
>
>     7.8713 sec + 0.18%
>
> 512 CPUS offstack
>
>     7.8916 sec + 0.44%
>
> Kernel size comparison:
>
>    text           data        filename                Difference to 
> onstack256 baseline
> 25755648    9589248        vmlinuz-6.8.0-rc4-onstack256
> 25755648    9607680        vmlinuz-6.8.0-rc4-onstack512    +0.19%
> 25755648    9603584        vmlinuz-6.8.0-rc4-offstack512    +0.14%
>
> Tested-by: Eric Mackay <eric.mackay@oracle.com>
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Christoph Lameter (Ampere) <cl@linux.com>


This patch landed in today's linux-next as commit 0499a78369ad ("ARM64: 
Dynamically allocate cpumasks and increase supported CPUs to 512"). 
Unfortunately it triggers the following warning during boot on most of 
my ARM64-based test boards. Here is an example from Odroid-N2 board:

  ------------[ cut here ]------------
  WARNING: CPU: 4 PID: 63 at drivers/opp/core.c:2554 
dev_pm_opp_set_config+0x390/0x710
  Modules linked in: dw_hdmi_i2s_audio meson_gxl smsc onboard_usb_hub(+) 
rtc_pcf8563 panfrost snd_soc_meson_axg_sound_card drm_shmem_helper 
crct10dif_ce dwmac_generic snd_soc_meson_card_utils gpu_sched 
snd_soc_meson_g12a_toacodec snd_soc_meson_g12a_tohdmitx rc_odroid 
snd_soc_meson_codec_glue pwm_meson ao_cec_g12a meson_gxbb_wdt meson_ir 
snd_soc_meson_axg_frddr snd_soc_meson_axg_toddr snd_soc_meson_axg_tdmin 
meson_vdec(C) v4l2_mem2mem videobuf2_dma_contig snd_soc_meson_axg_tdmout 
videobuf2_memops axg_audio videobuf2_v4l2 sclk_div videodev 
reset_meson_audio_arb snd_soc_meson_axg_fifo clk_phase dwmac_meson8b 
stmmac_platform videobuf2_common mdio_mux_meson_g12a meson_drm 
meson_dw_hdmi rtc_meson_vrtc stmmac meson_ddr_pmu_g12 mc dw_hdmi 
drm_display_helper pcs_xpcs snd_soc_meson_t9015 meson_canvas gpio_fan 
display_connector snd_soc_meson_axg_tdm_interface 
snd_soc_simple_amplifier snd_soc_meson_axg_tdm_formatter nvmem_meson_efuse
  hub 1-1:1.0: USB hub found
  CPU: 4 PID: 63 Comm: kworker/u12:5 Tainted: G         C 6.8.0-rc3+ #14677
  Hardware name: Hardkernel ODROID-N2 (DT)
  Workqueue: events_unbound deferred_probe_work_func
  pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : dev_pm_opp_set_config+0x390/0x710
  lr : dev_pm_opp_set_config+0x5c/0x710
  ...
  Call trace:
   dev_pm_opp_set_config+0x390/0x710
   dt_cpufreq_probe+0x268/0x480
   platform_probe+0x68/0xd8
   really_probe+0x148/0x2b4
   __driver_probe_device+0x78/0x12c
   driver_probe_device+0xdc/0x164
   __device_attach_driver+0xb8/0x138
   bus_for_each_drv+0x84/0xe0
   __device_attach+0xa8/0x1b0
   device_initial_probe+0x14/0x20
   bus_probe_device+0xb0/0xb4
   deferred_probe_work_func+0x8c/0xc8
   process_one_work+0x1ec/0x53c
   worker_thread+0x298/0x408
   kthread+0x124/0x128
   ret_from_fork+0x10/0x20
  irq event stamp: 317178
  hardirqs last  enabled at (317177): [<ffff8000801788d4>] 
ktime_get_coarse_real_ts64+0x10c/0x110
  hardirqs last disabled at (317178): [<ffff800081222030>] el1_dbg+0x24/0x8c
  softirqs last  enabled at (315802): [<ffff800080010a60>] 
__do_softirq+0x4a0/0x4e8
  softirqs last disabled at (315793): [<ffff8000800169b0>] 
____do_softirq+0x10/0x1c
  ---[ end trace 0000000000000000 ]---
  cpu cpu2: error -EBUSY: failed to set regulators
  cpufreq-dt: probe of cpufreq-dt failed with error -16

It looks that cpufreq-dt and/or opp drivers needs some adjustments 
related with this change.


> ---
>
>
> Original post: https://www.spinics.net/lists/linux-mm/msg369701.html
> V2: https://lkml.org/lkml/2024/2/7/505
>
>
> V1->V2
>
> - Keep quotation marks
> - Remove whiltespace damage
> - Add tested by
>
> V2->V3:
> - Add test results
> - Rework descriptions
>
>
>  arch/arm64/Kconfig | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index aa7c1d435139..4e767dede47d 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1427,7 +1427,21 @@ config SCHED_SMT
>  config NR_CPUS
>      int "Maximum number of CPUs (2-4096)"
>      range 2 4096
> -    default "256"
> +    default "512"
> +
> +#
> +# Determines the placement of cpumasks.
> +#
> +# With CPUMASK_OFFSTACK the cpumasks are dynamically allocated.
> +# Useful for machines with lots of core because it avoids increasing
> +# the size of many of the data structures in the kernel.
> +#
> +# If this is off then the cpumasks have a static sizes and are
> +# embedded within data structures.
> +#
> +    config CPUMASK_OFFSTACK
> +    def_bool y
> +    depends on NR_CPUS > 256
>
>  config HOTPLUG_CPU
>      bool "Support for hot-pluggable CPUs"

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


