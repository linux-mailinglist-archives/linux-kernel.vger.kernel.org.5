Return-Path: <linux-kernel+bounces-117614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E4588AD3F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAD361C219B6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C193A133420;
	Mon, 25 Mar 2024 17:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ehuk.net header.i=@ehuk.net header.b="qiN0qqHF"
Received: from james.steelbluetech.co.uk (james.steelbluetech.co.uk [78.40.151.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E59132C0D;
	Mon, 25 Mar 2024 17:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.151.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388418; cv=none; b=XPcbQtBvushym7TjgUM5rw4dNF9v0kLbOQmFxjzz7hPpCZQhELPQHnvWUg8aLO0YPfcQqJ0UNJBEmNBlWB1sVIUOp5zhGUp8EAhwsw1E/1nhnDxslLKmJ5RAu2MNuS9A+YQBiRYMkaMv+d3gkJbff+KZVQA7tPtjBCm8UilJsHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388418; c=relaxed/simple;
	bh=smFYDSH9B5YUSASHKg2uLIGlrU36nGJWynip0XRYKPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dqBgecYTgyyPKNr60UnV7Tw0+sYksYTrIBEiaxVH22yJiRAHPx9E3IYoVSGesqGx6r9eEvs0vJElE2wH/AgYpG0buj3n5iupXrSr9X+3nuDfTotMdwMrD02gheH/rLySI923jH0QdcGtsoQFraaNi8m9ML7ty95yUvUiEbBblZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ehuk.net; spf=pass smtp.mailfrom=ehuk.net; dkim=pass (2048-bit key) header.d=ehuk.net header.i=@ehuk.net header.b=qiN0qqHF; arc=none smtp.client-ip=78.40.151.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ehuk.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ehuk.net
Received: from [10.0.5.25] (tv.ehuk.net [10.0.5.25])
	by james.steelbluetech.co.uk (Postfix) with ESMTP id BB093BFC18;
	Mon, 25 Mar 2024 17:32:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.10.3 james.steelbluetech.co.uk BB093BFC18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ehuk.net; s=default;
	t=1711387962; bh=jEA45GxcfxPwikJuID7WzQ1xMUTGgZSJQcil0hACI9k=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qiN0qqHFeISwY8Sr7Bw5ZDZ1UzFARHSWUL9hgVxRlFXNynwWIfNaD7QCctSJPn4YA
	 D0OlxS85ufFXs9iY3qkWzDmLJDZSUg6iRqSIjGe6y+Lf507qyIQrFSbV9qv2U2Ogm/
	 WXy17rBbnyluHMPqm80ZmnaVcuhAepO8E+NqUDtkWgaso2wJrL0uW4etdpzyTaMDGo
	 1LZN7QYfa3h7gxcKxvcO1ogZQajUW1ljLi6QBbS4LmyHeJGyygsMDauMTv7yqSbh5e
	 DeLSLmXSVlAR6heJXAOfkF7w1+QUp3wkT3/OqUGPiNx30iCZJw0BW4anlaNPsIpfKd
	 6KW1OfKSZF+pg==
Message-ID: <30b3729c-d8ab-4254-8cc4-b5ca3bbe1a59@ehuk.net>
Date: Mon, 25 Mar 2024 17:32:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eddie@ehuk.net
Subject: Re: [PATCH 6.1 000/451] 6.1.83-rc1 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com, pavel@denx.de
References: <20240324231207.1351418-1-sashal@kernel.org>
Content-Language: en-GB
From: Eddie Chapman <eddie@ehuk.net>
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang

On 24/03/2024 23:04, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.1.83 release.
> There are 451 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue Mar 26 11:11:59 PM UTC 2024.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.1.y&id2=v6.1.82
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha

Greg & Sasha, thanks for all your hard work.

Just to report I upgraded eight x86-64 machines from a 5.15.x kernel to 
6.1.82 plus all patches in the stable queue as of Saturday 23rd March 
11pm GMT. That's the vast majority of this series as Greg & Sasha have 
dropped a dozen or so and added 68 new since I built my kernel. Ha ha 
what fun living on the edge :-)

All are running fine 24+ hrs later, no noticeable issues, nothing 
untoward in dmesg.

They are:
6 x custom AMD Ryzen servers
1 x Intel IvyBridge era server
1 x Intel Skylake era laptop

All running various workloads and with a mixture of addon 
network/sas/sata/graphics cards from a variety of manufacturers. Some 
uefi booted, some bios booted.

Also zero warnings in the build output using gcc 13.2.1.

Just to be clear, the 68 patches listed below, which are in this series, 
were NOT in the kernel I tested.

Eddie

arm64-dts-broadcom-bcmbca-bcm4908-drop-invalid-switc.patch
asoc-rockchip-i2s-tdm-fix-inaccurate-sampling-rates.patch
bpf-report-rcu-qs-in-cpumap-kthread.patch
comedi-comedi_test-prevent-timers-rescheduling-during-deletion.patch
dm-address-indent-space-issues.patch
dm-integrity-align-the-outgoing-bio-in-integrity_rec.patch
dm-integrity-fix-a-memory-leak-when-rechecking-the-d.patch
dm-io-support-io-priority.patch
drm-fix-drm_fixp2int_round-making-it-add-0.5.patch
hsr-fix-uninit-value-access-in-hsr_get_node.patch
hsr-handle-failures-in-module-init.patch
hwtracing-hisi_ptt-move-type-check-to-the-beginning-.patch
ipv4-raw-fix-sending-packets-from-raw-sockets-via-ip.patch
kconfig-fix-infinite-loop-when-expanding-a-macro-at-.patch
net-bnx2x-prevent-access-to-a-freed-page-in-page_poo.patch
net-dsa-mt7530-fix-handling-of-all-link-local-frames.patch
net-dsa-mt7530-fix-link-local-frames-that-ingress-vl.patch
net-dsa-mt7530-prevent-possible-incorrect-xtal-frequ.patch
net-ethernet-mtk_eth_soc-fix-ppe-hanging-issue.patch
net-mediatek-mtk_eth_soc-clear-mac_mcr_force_link-on.patch
net-octeontx2-use-alloc_ordered_workqueue-to-create-.patch
net-phy-fix-phy_read_poll_timeout-argument-type-in-g.patch
net-report-rcu-qs-on-threaded-napi-repolling.patch
net-sched-taprio-proper-tca_taprio_tc_entry_index-ch.patch
net-veth-do-not-manipulate-gro-when-using-xdp.patch
netfilter-nf_tables-do-not-compare-internal-table-fl.patch
netfilter-nft_set_pipapo-release-elements-in-clone-o.patch
nouveau-reset-the-bo-resource-bus-info-after-an-evic.patch
nvme-add-the-apple-shared-tag-workaround-to-nvme_all.patch
nvme-fix-reconnection-fail-due-to-reserved-tag-alloc.patch
nvme-only-set-reserved_tags-in-nvme_alloc_io_tag_set.patch
octeontx2-af-add-mbox-for-cpt-lf-reset.patch
octeontx2-af-add-mbox-to-return-cpt_af_flt_int-info.patch
octeontx2-af-optimize-cpt-pf-identification.patch
octeontx2-af-recover-cpt-engine-when-it-gets-fault.patch
octeontx2-af-use-matching-wake_up-api-variant-in-cgx.patch
octeontx2-af-use-separate-handlers-for-interrupts.patch
octeontx2-detect-the-mbox-up-or-down-message-via-reg.patch
octeontx2-pf-send-up-messages-to-vf-only-when-vf-is-.patch
octeontx2-pf-use-default-max_active-works-instead-of.patch
packet-annotate-data-races-around-ignore_outgoing.patch
rcu-add-a-helper-to-report-consolidated-flavor-qs.patch
rds-introduce-acquire-release-ordering-in-acquire-re.patch
rds-tcp-fix-use-after-free-of-net-in-reqsk_timer_han.patch
remoteproc-stm32-fix-incorrect-optional-pointers.patch
remoteproc-stm32-fix-incorrect-type-assignment-retur.patch
remoteproc-stm32-fix-incorrect-type-in-assignment-fo.patch
remoteproc-stm32-use-correct-format-strings-on-64-bi.patch
rtc-mt6397-select-irq_domain-instead-of-depending-on.patch
s390-vtime-fix-average-steal-time-calculation.patch
sched-fair-take-the-scheduling-domain-into-account-i.patch
selftests-forwarding-fix-ping-failure-due-to-short-t.patch
serial-8250_exar-don-t-remove-gpio-device-on-suspend.patch
serial-max310x-fix-syntax-error-in-irq-error-message.patch
soc-fsl-dpio-fix-kcalloc-argument-order.patch
spi-spi-mt65xx-fix-null-pointer-access-in-interrupt-.patch
staging-greybus-fix-get_channel_from_mode-failure-pa.patch
tcp-fix-new_syn_recv-handling-in-inet_twsk_purge.patch
tcp-fix-refcnt-handling-in-__inet_hash_connect.patch
tty-serial-samsung-fix-tx_empty-to-return-tiocser_te.patch
tty-vt-fix-20-vs-0x20-typo-in-escsiignore.patch
usb-gadget-net2272-use-irqflags-in-the-call-to-net22.patch
usb-phy-generic-get-the-vbus-supply.patch
vdpa-mlx5-allow-cvq-size-changes.patch
vdpa_sim-reset-must-not-run.patch
wireguard-receive-annotate-data-race-around-receivin.patch
x86-efistub-clear-decompressor-bss-in-native-efi-ent.patch
x86-efistub-don-t-clear-bss-twice-in-mixed-mode.patch

