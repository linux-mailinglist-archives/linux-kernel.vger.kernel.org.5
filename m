Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF73F7D6141
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 07:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjJYFmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 01:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJYFmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 01:42:08 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C55F12F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 22:42:04 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-408002b5b9fso42740365e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 22:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698212523; x=1698817323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r0oszLO2SkH4mWCFEWC/xsf04Gi4tPhl+fKb/fjG29c=;
        b=xEOgJf/aL7Ftxx4sViWT7Ne6ACbFzsKhsHSFnEfcK3hiKMNCnRXCKQf4b+Bo/+dY06
         K8Y2xxfCB3+lJ+Q3hMvk+HCVJPTP7BR6bhkOZEK7VwGYdabtM0lBb6Dg6oA2FNaSORXc
         Cu2ZdOiNPpM/631S8SEEmYzsneKXddARIx7i+XJYVoi56GWOzEQlxxttwcvdGw/I7Rbc
         8mUFGtDfC/6THmbPoPNHjOTUJncy+djgFtd+gupRHbTLLgEIAUOMMhrzAbJ6E9PnLUxS
         4+edKm2cJ5eHLG3ilZSpucu8YLQR+H+NkDkyXFcecVzT1eQyADrqfOrf3qZsU0uE8/SB
         gx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698212523; x=1698817323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0oszLO2SkH4mWCFEWC/xsf04Gi4tPhl+fKb/fjG29c=;
        b=EUpAZiJMA+0St6hNwwTaToFW8G6CVKebQ6KUUOYdSHjbZOA3kpKju3EldXN0mQx9It
         ahtGEADykN+fNdWtHXDU2tne3rxm4uY5//tMZhQ24o68nKPYdjg6PaIDkHaltj+lkQAy
         m4xbOHXr60OTAvDfg/w+e9t/nlG0PqPgfCjDx4P1AJRYN4/UtGtXcMSpSZGVSeBj4K3r
         3zwFRRkLnWRrT+cHJcSuqwQp8AbFSPAqOjIihzZe3u3KjRSLQmJxxlA1EgSflZJzpF7H
         Y7dQc3sVoUjYOZR7pEhZGd3tuveN1+LVXc0Id+OcrFwo26JB1KGSDnK8YJ9U+/ropa87
         s43w==
X-Gm-Message-State: AOJu0YypSRJs/LeDpczZhG36N0nHQu2XcnIBI0tvxznWqpwmrwJa5IR+
        Ac1feWa/P6dW935URUuQHQg78g==
X-Google-Smtp-Source: AGHT+IFI13MX5jolODPfxGXYL4Be2Fh1zBCr2LmoMCFCEV9t7nwnPfzl3u1H1VeyliRmZojE9pxPpA==
X-Received: by 2002:a05:6000:79d:b0:32d:a688:8813 with SMTP id bu29-20020a056000079d00b0032da6888813mr14466338wrb.32.1698212522891;
        Tue, 24 Oct 2023 22:42:02 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id h2-20020a5d5042000000b0032d886039easm11262516wrt.14.2023.10.24.22.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 22:42:02 -0700 (PDT)
Date:   Wed, 25 Oct 2023 08:41:58 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/4] ACPI: sysfs: Fix a potential out-of-bound write in
 create_of_modalias()
Message-ID: <c2a6e660-fae0-4b50-917f-5cd59bce7d02@kadam.mountain>
References: <cover.1698081019.git.christophe.jaillet@wanadoo.fr>
 <004a9aa85dcc37d112443e133c9edfd7624cd47b.1698081019.git.christophe.jaillet@wanadoo.fr>
 <df33bc21-4792-4395-bbe0-4c8893818f6b@kadam.mountain>
 <ae1f9a0a-2058-4126-b716-44dc54449c4d@kadam.mountain>
 <6c38f870-8f89-4955-abd5-50439853e440@kadam.mountain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="/lr5YHKu0DFjT5yy"
Content-Disposition: inline
In-Reply-To: <6c38f870-8f89-4955-abd5-50439853e440@kadam.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/lr5YHKu0DFjT5yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 24, 2023 at 10:09:31AM +0300, Dan Carpenter wrote:
> On Tue, Oct 24, 2023 at 09:08:26AM +0300, Dan Carpenter wrote:
> > So I had a Smatch check for this kind of stuff but it was pretty junk.
> > It also only looked for "modalias + len" and here the code is doing
> > "&modalias[len]".
> > 
> > I can fix it up a bit today and look again at the warnings.  Here is the
> > the check and the warnings as-is.
> 
> Alright.  Here is the new version.  :)
> 

Here are the results.  The only new real bugs I found were:

drivers/edac/i5400_edac.c:1036 calculate_dimm_size() warn: expected subtract in snprintf limit 'space'
drivers/accel/habanalabs/gaudi/gaudi.c:8930 gaudi_fill_sobs_from_mon() warn: expected subtract in snprintf limit 'max_write'

These ones are not bugs, but they're pretty messed up...  (It's debugfs
code so no one cares).
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:217 dp_link_settings_read() warn: expected subtract in snprintf limit 'str_len'
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:224 dp_link_settings_read() warn: expected subtract in snprintf limit 'str_len'
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:231 dp_link_settings_read() warn: expected subtract in snprintf limit 'str_len'

regards,
dan carpenter


--/lr5YHKu0DFjT5yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=err-list

kernel/locking/lockdep_proc.c:497 seq_stats() warn: expected subtract in snprintf limit '3'
kernel/locking/lockdep_proc.c:501 seq_stats() warn: expected subtract in snprintf limit '3'
kernel/trace/trace_probe.c:1642 __set_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_probe.c:1645 __set_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_probe.c:1646 __set_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_probe.c:1649 __set_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_probe.c:1652 __set_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_probe.c:1663 __set_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_probe.c:1670 __set_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_events_synth.c:619 __set_synth_event_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_events_synth.c:623 __set_synth_event_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_events_synth.c:628 __set_synth_event_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_events_synth.c:631 __set_synth_event_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_events_synth.c:634 __set_synth_event_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_syscalls.c:220 __set_enter_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_syscalls.c:224 __set_enter_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_syscalls.c:227 __set_enter_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_events_user.c:1332 user_dyn_field_set_string() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_events_user.c:1354 user_field_set_string() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_events_user.c:1355 user_field_set_string() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_events_user.c:1358 user_field_set_string() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_events_user.c:1361 user_field_set_string() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_events_user.c:1377 user_event_set_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_events_user.c:1379 user_event_set_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_events_user.c:1385 user_event_set_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_events_user.c:1390 user_event_set_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_events_user.c:1393 user_event_set_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
arch/x86/kernel/apic/io_apic.c:2669 ioapic_setup_resources() warn: expected subtract in snprintf limit '11'
arch/x86/kernel/acpi/boot.c:1006 acpi_parse_hpet() warn: expected subtract in snprintf limit '9'
lib/dynamic_debug.c:836 __dynamic_emit_prefix() warn: expected subtract in snprintf limit 'remaining(pos)'
lib/dynamic_debug.c:839 __dynamic_emit_prefix() warn: expected subtract in snprintf limit 'remaining(pos)'
lib/dynamic_debug.c:841 __dynamic_emit_prefix() warn: expected subtract in snprintf limit 'remaining(pos)'
lib/dynamic_debug.c:845 __dynamic_emit_prefix() warn: expected subtract in snprintf limit 'remaining(pos)'
lib/dynamic_debug.c:847 __dynamic_emit_prefix() warn: expected subtract in snprintf limit 'remaining(pos)'
drivers/hid/hid-lg4ff.c:1417 lg4ff_init() warn: expected subtract in snprintf limit 'name_sz'
drivers/hid/hid-sony.c:1438 sony_leds_init() warn: expected subtract in snprintf limit 'name_sz'
drivers/hid/hid-sony.c:1441 sony_leds_init() warn: expected subtract in snprintf limit 'name_sz'
drivers/hid/hid-picolcd_leds.c:120 picolcd_init_leds() warn: expected subtract in snprintf limit 'name_sz'
drivers/hid/hid-wiimote-modules.c:353 wiimod_led_probe() warn: expected subtract in snprintf limit 'namesz'
drivers/hid/hid-steelseries.c:296 steelseries_srws1_probe() warn: expected subtract in snprintf limit 'name_sz'
drivers/hid/hid-steelseries.c:317 steelseries_srws1_probe() warn: expected subtract in snprintf limit 'name_sz'
drivers/hid/hid-bigbenff.c:435 bigben_probe() warn: expected subtract in snprintf limit 'name_sz'
drivers/net/ethernet/engleder/tsnep_ethtool.c:147 tsnep_ethtool_get_strings() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/engleder/tsnep_ethtool.c:155 tsnep_ethtool_get_strings() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c:3204 bnx2x_get_strings() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/chelsio/cxgb4/sge.c:2721 cxgb4_selftest_lb_pkt() warn: expected subtract in snprintf limit '17'
drivers/net/ethernet/sfc/siena/ethtool_common.c:229 efx_fill_test() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/sfc/falcon/ethtool.c:229 ef4_fill_test() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/sfc/ethtool_common.c:278 efx_fill_test() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/mellanox/mlx5/core/main.c:243 mlx5_set_driver_version() warn: expected subtract in snprintf limit 'remaining_size'
drivers/net/ethernet/mellanox/mlx4/eq.c:1505 mlx4_assign_eq() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats.c:53 hclge_comm_tqps_get_strings() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c:2602 hns_dsaf_get_node_stats_strings() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c:2604 hns_dsaf_get_node_stats_strings() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c:2606 hns_dsaf_get_node_stats_strings() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c:2608 hns_dsaf_get_node_stats_strings() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c:2610 hns_dsaf_get_node_stats_strings() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c:2612 hns_dsaf_get_node_stats_strings() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c:2614 hns_dsaf_get_node_stats_strings() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c:2616 hns_dsaf_get_node_stats_strings() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c:2618 hns_dsaf_get_node_stats_strings() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c:2620 hns_dsaf_get_node_stats_strings() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c:2622 hns_dsaf_get_node_stats_strings() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c:2624 hns_dsaf_get_node_stats_strings() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c:2633 hns_dsaf_get_node_stats_strings() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c:2638 hns_dsaf_get_node_stats_strings() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/hisilicon/hns/hns_ethtool.c:436 __lb_other_process() warn: expected subtract in snprintf limit '3'
drivers/net/ethernet/cavium/liquidio/lio_core.c:1101 octeon_setup_interrupt() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/cavium/liquidio/lio_core.c:1122 octeon_setup_interrupt() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/cavium/liquidio/lio_core.c:1127 octeon_setup_interrupt() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/freescale/enetc/enetc_ethtool.c:262 enetc_get_strings() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/freescale/enetc/enetc_ethtool.c:269 enetc_get_strings() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/google/gve/gve_ethtool.c:106 gve_get_strings() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/google/gve/gve_ethtool.c:114 gve_get_strings() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c:281 aq_ethtool_get_strings() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c:288 aq_ethtool_get_strings() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c:316 aq_ethtool_get_strings() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c:341 aq_ethtool_get_strings() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c:353 aq_ethtool_get_strings() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/marvell/octeon_ep/octep_main.c:358 octep_request_irqs() warn: expected subtract in snprintf limit '16 + 32'
drivers/net/ethernet/marvell/octeon_ep/octep_ethtool.c:97 octep_get_strings() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/marvell/octeon_ep/octep_ethtool.c:105 octep_get_strings() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c:1971 mvpp2_ethtool_get_strings() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c:1980 mvpp2_ethtool_get_strings() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:207 otx2_register_flr_me_intr() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:228 otx2_register_flr_me_intr() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:238 otx2_register_flr_me_intr() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:707 otx2_register_pfvf_mbox_intr() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:710 otx2_register_pfvf_mbox_intr() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:723 otx2_register_pfvf_mbox_intr() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:726 otx2_register_pfvf_mbox_intr() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:1004 otx2_register_mbox_intr() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:1790 otx2_open() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:1810 otx2_open() warn: expected subtract in snprintf limit '32'
drivers/net/can/can327.c:629 can327_handle_prompt() warn: expected subtract in snprintf limit '18'
drivers/net/can/can327.c:634 can327_handle_prompt() warn: expected subtract in snprintf limit '18'
drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:385 brcmf_fw_add_macaddr() warn: expected subtract in snprintf limit '(7 + 6 * 3) + 1'
drivers/edac/i5400_edac.c:1036 calculate_dimm_size() warn: expected subtract in snprintf limit 'space'
drivers/usb/atm/cxacru.c:490 adsl_config_store() warn: expected subtract in snprintf limit '13'
drivers/media/test-drivers/vivid/vivid-core.c:1283 vivid_init_dv_timings() warn: expected subtract in snprintf limit '32'
drivers/iommu/omap-iommu-debug.c:49 omap2_iommu_dump_ctx() warn: expected subtract in snprintf limit 'maxcol'
drivers/iommu/omap-iommu-debug.c:50 omap2_iommu_dump_ctx() warn: expected subtract in snprintf limit 'maxcol'
drivers/iommu/omap-iommu-debug.c:51 omap2_iommu_dump_ctx() warn: expected subtract in snprintf limit 'maxcol'
drivers/iommu/omap-iommu-debug.c:52 omap2_iommu_dump_ctx() warn: expected subtract in snprintf limit 'maxcol'
drivers/iommu/omap-iommu-debug.c:53 omap2_iommu_dump_ctx() warn: expected subtract in snprintf limit 'maxcol'
drivers/iommu/omap-iommu-debug.c:54 omap2_iommu_dump_ctx() warn: expected subtract in snprintf limit 'maxcol'
drivers/iommu/omap-iommu-debug.c:55 omap2_iommu_dump_ctx() warn: expected subtract in snprintf limit 'maxcol'
drivers/iommu/omap-iommu-debug.c:56 omap2_iommu_dump_ctx() warn: expected subtract in snprintf limit 'maxcol'
drivers/iommu/omap-iommu-debug.c:57 omap2_iommu_dump_ctx() warn: expected subtract in snprintf limit 'maxcol'
drivers/iommu/omap-iommu-debug.c:58 omap2_iommu_dump_ctx() warn: expected subtract in snprintf limit 'maxcol'
drivers/iommu/omap-iommu-debug.c:59 omap2_iommu_dump_ctx() warn: expected subtract in snprintf limit 'maxcol'
drivers/iommu/omap-iommu-debug.c:60 omap2_iommu_dump_ctx() warn: expected subtract in snprintf limit 'maxcol'
drivers/iommu/omap-iommu-debug.c:61 omap2_iommu_dump_ctx() warn: expected subtract in snprintf limit 'maxcol'
drivers/iommu/omap-iommu-debug.c:62 omap2_iommu_dump_ctx() warn: expected subtract in snprintf limit 'maxcol'
drivers/iommu/omap-iommu-debug.c:63 omap2_iommu_dump_ctx() warn: expected subtract in snprintf limit 'maxcol'
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:217 dp_link_settings_read() warn: expected subtract in snprintf limit 'str_len'
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:224 dp_link_settings_read() warn: expected subtract in snprintf limit 'str_len'
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:231 dp_link_settings_read() warn: expected subtract in snprintf limit 'str_len'
drivers/gpu/drm/drm_print.c:144 __drm_printfn_coredump() warn: expected subtract in snprintf limit 'iterator->remain'
drivers/md/dm-ima.c:337 dm_ima_measure_on_table_load() warn: expected subtract in snprintf limit '3'
drivers/scsi/fcoe/fcoe_transport.c:608 fcoe_transport_show() warn: expected subtract in snprintf limit '16'
drivers/scsi/fcoe/fcoe_transport.c:612 fcoe_transport_show() warn: expected subtract in snprintf limit '16'
drivers/acpi/device_sysfs.c:228 create_of_modalias() warn: expected subtract in snprintf limit 'size'
drivers/input/misc/keyspan_remote.c:132 keyspan_print() warn: expected subtract in snprintf limit '4'
drivers/accel/habanalabs/gaudi/gaudi.c:8927 gaudi_fill_sobs_from_mon() warn: expected subtract in snprintf limit 'max_write'
drivers/accel/habanalabs/gaudi/gaudi.c:8930 gaudi_fill_sobs_from_mon() warn: expected subtract in snprintf limit 'max_write'
drivers/hwmon/pmbus/ibm-cffps.c:169 ibm_cffps_debugfs_read() warn: expected subtract in snprintf limit '3'
drivers/hwmon/pmbus/ibm-cffps.c:180 ibm_cffps_debugfs_read() warn: expected subtract in snprintf limit '5'
fs/proc/bootconfig.c:53 copy_xbc_key_value_list() warn: expected subtract in snprintf limit '(end > dst) ?end - dst:0'
fs/proc/bootconfig.c:60 copy_xbc_key_value_list() warn: expected subtract in snprintf limit '(end > dst) ?end - dst:0'
fs/proc/bootconfig.c:67 copy_xbc_key_value_list() warn: expected subtract in snprintf limit '(end > dst) ?end - dst:0'
fs/ecryptfs/crypto.c:127 ecryptfs_derive_iv() warn: expected subtract in snprintf limit '16'
sound/soc/intel/avs/topology.c:191 avs_parse_string_token() warn: expected subtract in snprintf limit '44'

--/lr5YHKu0DFjT5yy--
