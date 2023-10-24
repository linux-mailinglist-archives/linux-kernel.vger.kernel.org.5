Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D277D4732
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 08:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbjJXGIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 02:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjJXGIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 02:08:36 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFE0C0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 23:08:32 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so2993711f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 23:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698127710; x=1698732510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TqNCl8l+KnQqm1rHah7h5hq+q0hn/gFoy9mSnGDjiFI=;
        b=B5/mt5PiqavyI7wpp6rQRuQOqXQg7jGGFPgl6lL6MSBq2ArbnP7tKJfxbntf8YjnQ0
         YOPd0Asqi/+Ocz2HgN0Npg5BVxEXRxFLJKvUJLWmqWxXMMCbAhkvcXI4VmNehU0DiAKw
         tMCeOBoR8bS0STlgedOLkMp8Lkc9RlwKUpYBZ4/MO58+ukQ66kryfpdKDX60DjCIhrRK
         6fvK4OZDVVTV/19Ldt0/g1oE/W6flHrYYxHuoLDDzpjURqPIDRAOrpFPxCGIJP9lhecS
         KcRhyOh3FpkbpIPokpWNUfGH9M0RH/hWX99OplGC+aoP8yiupTAIAGj4mJj1IZNEioHD
         tEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698127710; x=1698732510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqNCl8l+KnQqm1rHah7h5hq+q0hn/gFoy9mSnGDjiFI=;
        b=iRorBmscmziBx/yEe6w0V39jjKLRTPzxUsW/wzfgWjFZkZR3TBM9g7Fji5N83P98Gc
         1LXnYtP5Zm1UR2TkvUqWkWPvaE94+68i49oXYZEJJuO7vt2E8gM9WNZiyPH+OXXfVmQ1
         RHE1f4ilDKV6E7KjbyazB4ad4HMs9g6IuppUsE6eAtd1yRLIWXkNie+i6kkd0yS/+rdH
         tr00qIbwc1Q40BT412mW/4BUA+K7XTkjPYplotzx5zzETLK+TPlh4mL691k+fSMGxJZl
         NLORpO1N/oYZqd8zmjsZbx0+6cx6Uo4VOdCU/MKYDf9eQE/6OXA4gviEzeG4ArXavs6P
         Upxw==
X-Gm-Message-State: AOJu0Ywf9ILuynBUNGqsI6sLwrQp5RC5q3iSoeOAllL3/ecxcoz871eo
        PjggBK+Sb1+Y8WQh6/HfyXcH5Q==
X-Google-Smtp-Source: AGHT+IE8pQjyPk0MmN1uOsGxmhiiTVjbFu+htr0cIvDHXFuoc2dgLg0tpeLOzrT2sKb4wWrJmZLy9A==
X-Received: by 2002:a05:6000:bc3:b0:32d:a466:c470 with SMTP id dm3-20020a0560000bc300b0032da466c470mr7473958wrb.21.1698127710513;
        Mon, 23 Oct 2023 23:08:30 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q5-20020adfea05000000b0032d9548240fsm9138398wrm.82.2023.10.23.23.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 23:08:30 -0700 (PDT)
Date:   Tue, 24 Oct 2023 09:08:26 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/4] ACPI: sysfs: Fix a potential out-of-bound write in
 create_of_modalias()
Message-ID: <ae1f9a0a-2058-4126-b716-44dc54449c4d@kadam.mountain>
References: <cover.1698081019.git.christophe.jaillet@wanadoo.fr>
 <004a9aa85dcc37d112443e133c9edfd7624cd47b.1698081019.git.christophe.jaillet@wanadoo.fr>
 <df33bc21-4792-4395-bbe0-4c8893818f6b@kadam.mountain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bqF84jalhcFd/GyC"
Content-Disposition: inline
In-Reply-To: <df33bc21-4792-4395-bbe0-4c8893818f6b@kadam.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bqF84jalhcFd/GyC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 24, 2023 at 08:55:25AM +0300, Dan Carpenter wrote:
> On Mon, Oct 23, 2023 at 09:33:16PM +0200, Christophe JAILLET wrote:
> > The remaining size of the buffer used by snprintf() is not updated after
> > the first write, so subsequent write in the 'for' loop a few lines below
> > can write some data past the end of the 'modalias' buffer.
> > 
> > Correctly update the remaining size.
> > 
> > Note that this pattern is already correctly written in
> > create_pnp_modalias().
> > 
> > Fixes: 8765c5ba1949 ("ACPI / scan: Rework modalias creation when "compatible" is present")
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> >  drivers/acpi/device_sysfs.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> > index 4deb36dccb73..7ec3142f3eda 100644
> > --- a/drivers/acpi/device_sysfs.c
> > +++ b/drivers/acpi/device_sysfs.c
> > @@ -215,6 +215,8 @@ static int create_of_modalias(const struct acpi_device *acpi_dev, char *modalias
> >  	if (len >= size)
> >  		return -ENOMEM;
> >  
> > +	size -= len;
> > +
> 
> Yeah.  This is a good bugfix but it also shows why the canonical format
> is better.  In the canonical format the "size - len" happens as part of
> snprintf() instead of on a separate line where it can be forgotten.
> 
> 	len += snprintf(buf + len, size - len, "string");
> 
> Also the user space version of snprintf() can fail but the
> kernel space version can't.  This code is more complicated and introduces
> a memory corruption bug because it is pretending that we need to check
> for negatives.  People (someone) sometimes (once ten years ago) tell me
> that checking for negatives is important for security but actually it's
> the reverse.

So I had a Smatch check for this kind of stuff but it was pretty junk.
It also only looked for "modalias + len" and here the code is doing
"&modalias[len]".

I can fix it up a bit today and look again at the warnings.  Here is the
the check and the warnings as-is.

regards,
dan carpenter


--bqF84jalhcFd/GyC
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="check_snprintf_no_minus.c"

/*
 * Copyright (C) 2021 Oracle.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, see http://www.gnu.org/copyleft/gpl.txt
 */

#include "smatch.h"
#include "smatch_slist.h"
#include "smatch_extra.h"

static int my_id;

static bool is_plus(struct expression *expr)
{
	if (expr->type == EXPR_BINOP && expr->op == '+')
		return true;
	/* fixme: what about dst += snprintf() */
	return false;
}

static void match_snprintf(const char *fn, struct expression *expr, void *unused)
{
	struct expression *dest, *limit;
	char *name;

	dest = get_argument_from_call_expr(expr->args, 0);
	limit = get_argument_from_call_expr(expr->args, 1);
	dest = strip_expr(dest);
	limit = strip_expr(limit);
	if (!dest || !limit)
		return;

	if (!is_plus(dest))
		return;

	if (limit->type == EXPR_BINOP && limit->op == '-')
		return;

	name = expr_to_str(limit);
	sm_warning("expected subtract in snprintf limit '%s'", name);
	free_string(name);
}

void check_snprintf_no_minus(int id)
{
	my_id = id;
	add_function_hook("snprintf", &match_snprintf, NULL);
	add_function_hook("scnprintf", &match_snprintf, NULL);
}


--bqF84jalhcFd/GyC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=err-list

kernel/locking/lockdep_proc.c:497 seq_stats() warn: expected subtract in snprintf limit '3'
kernel/locking/lockdep_proc.c:501 seq_stats() warn: expected subtract in snprintf limit '3'
kernel/time/clocksource.c:1429 available_clocksource_show() warn: expected subtract in snprintf limit '(null)'
kernel/time/clocksource.c:1434 available_clocksource_show() warn: expected subtract in snprintf limit '(null)'
kernel/trace/trace_probe.c:1635 __set_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_probe.c:1639 __set_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_probe.c:1642 __set_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_probe.c:1645 __set_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_probe.c:1646 __set_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_probe.c:1649 __set_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_probe.c:1652 __set_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_probe.c:1663 __set_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_probe.c:1670 __set_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_events_synth.c:616 __set_synth_event_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_events_synth.c:619 __set_synth_event_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_events_synth.c:623 __set_synth_event_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_events_synth.c:628 __set_synth_event_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_events_synth.c:631 __set_synth_event_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_events_synth.c:634 __set_synth_event_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_syscalls.c:218 __set_enter_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_syscalls.c:220 __set_enter_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_syscalls.c:224 __set_enter_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_syscalls.c:227 __set_enter_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_events_user.c:1330 user_dyn_field_set_string() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_events_user.c:1332 user_dyn_field_set_string() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_events_user.c:1353 user_field_set_string() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_events_user.c:1354 user_field_set_string() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_events_user.c:1355 user_field_set_string() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_events_user.c:1358 user_field_set_string() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_events_user.c:1361 user_field_set_string() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_events_user.c:1373 user_event_set_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_events_user.c:1377 user_event_set_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_events_user.c:1379 user_event_set_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_events_user.c:1385 user_event_set_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_events_user.c:1390 user_event_set_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
kernel/trace/trace_events_user.c:1393 user_event_set_print_fmt() warn: expected subtract in snprintf limit '(len) ?len - pos:0'
lib/ref_tracker.c:99 __ref_tracker_dir_pr_ostream() warn: expected subtract in snprintf limit 'len'
lib/ref_tracker.c:110 __ref_tracker_dir_pr_ostream() warn: expected subtract in snprintf limit 'len'
lib/ref_tracker.c:116 __ref_tracker_dir_pr_ostream() warn: expected subtract in snprintf limit 'len'
lib/dynamic_debug.c:828 __dynamic_emit_prefix() warn: expected subtract in snprintf limit 'remaining(pos)'
lib/dynamic_debug.c:830 __dynamic_emit_prefix() warn: expected subtract in snprintf limit 'remaining(pos)'
lib/dynamic_debug.c:836 __dynamic_emit_prefix() warn: expected subtract in snprintf limit 'remaining(pos)'
lib/dynamic_debug.c:839 __dynamic_emit_prefix() warn: expected subtract in snprintf limit 'remaining(pos)'
lib/dynamic_debug.c:841 __dynamic_emit_prefix() warn: expected subtract in snprintf limit 'remaining(pos)'
lib/dynamic_debug.c:845 __dynamic_emit_prefix() warn: expected subtract in snprintf limit 'remaining(pos)'
lib/dynamic_debug.c:847 __dynamic_emit_prefix() warn: expected subtract in snprintf limit 'remaining(pos)'
drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c:3204 bnx2x_get_strings() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/sfc/siena/ethtool_common.c:229 efx_fill_test() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/sfc/falcon/ethtool.c:229 ef4_fill_test() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/sfc/ethtool_common.c:278 efx_fill_test() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/mellanox/mlx5/core/main.c:243 mlx5_set_driver_version() warn: expected subtract in snprintf limit 'remaining_size'
drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c:198 mlx5_lag_print_mapping() warn: expected subtract in snprintf limit '4'
drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c:209 mlx5_lag_print_mapping() warn: expected subtract in snprintf limit '10'
drivers/net/ethernet/mellanox/mlx4/eq.c:1264 mlx4_init_eq_table() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/mellanox/mlx4/eq.c:1505 mlx4_assign_eq() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c:2630 hns_dsaf_get_node_stats_strings() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c:2633 hns_dsaf_get_node_stats_strings() warn: expected subtract in snprintf limit '32'
drivers/net/ethernet/hisilicon/hns/hns_ethtool.c:436 __lb_other_process() warn: expected subtract in snprintf limit '3'
drivers/net/ethernet/qlogic/qede/qede_main.c:1205 qede_log_probe() warn: expected subtract in snprintf limit 'left_size'
drivers/ata/libata-transport.c:578 show_ata_dev_id() warn: expected subtract in snprintf limit '20'
drivers/ata/libata-transport.c:597 show_ata_dev_gscr() warn: expected subtract in snprintf limit '20'
drivers/usb/atm/cxacru.c:490 adsl_config_store() warn: expected subtract in snprintf limit '13'
drivers/gpu/drm/i915/display/intel_sdvo.c:423 intel_sdvo_debug_write() warn: expected subtract in snprintf limit '(null)'
drivers/gpu/drm/i915/display/intel_sdvo.c:426 intel_sdvo_debug_write() warn: expected subtract in snprintf limit '(null)'
drivers/gpu/drm/i915/display/intel_sdvo.c:431 intel_sdvo_debug_write() warn: expected subtract in snprintf limit '(null)'
drivers/gpu/drm/i915/display/intel_sdvo.c:433 intel_sdvo_debug_write() warn: expected subtract in snprintf limit '(null)'
drivers/gpu/drm/i915/display/intel_sdvo.c:586 intel_sdvo_read_response() warn: expected subtract in snprintf limit '(null)'
drivers/gpu/drm/i915/display/intel_sdvo.c:588 intel_sdvo_read_response() warn: expected subtract in snprintf limit '(null)'
drivers/gpu/drm/i915/display/intel_sdvo.c:599 intel_sdvo_read_response() warn: expected subtract in snprintf limit '(null)'
drivers/gpu/drm/gma500/psb_intel_sdvo.c:416 psb_intel_sdvo_debug_write() warn: expected subtract in snprintf limit '(null)'
drivers/gpu/drm/gma500/psb_intel_sdvo.c:420 psb_intel_sdvo_debug_write() warn: expected subtract in snprintf limit '(null)'
drivers/gpu/drm/gma500/psb_intel_sdvo.c:425 psb_intel_sdvo_debug_write() warn: expected subtract in snprintf limit '(null)'
drivers/gpu/drm/gma500/psb_intel_sdvo.c:431 psb_intel_sdvo_debug_write() warn: expected subtract in snprintf limit '(null)'
drivers/gpu/drm/gma500/psb_intel_sdvo.c:541 psb_intel_sdvo_read_response() warn: expected subtract in snprintf limit '(null)'
drivers/gpu/drm/gma500/psb_intel_sdvo.c:543 psb_intel_sdvo_read_response() warn: expected subtract in snprintf limit '(null)'
drivers/gpu/drm/gma500/psb_intel_sdvo.c:554 psb_intel_sdvo_read_response() warn: expected subtract in snprintf limit '(null)'
drivers/gpu/drm/drm_print.c:144 __drm_printfn_coredump() warn: expected subtract in snprintf limit 'iterator->remain'
drivers/md/dm-ima.c:337 dm_ima_measure_on_table_load() warn: expected subtract in snprintf limit '3'
drivers/input/input.c:1087 input_bits_to_string() warn: expected subtract in snprintf limit '(null)'
drivers/input/input.c:1386 input_print_modalias_bits() warn: expected subtract in snprintf limit '(null)'
drivers/input/input.c:1420 input_print_modalias() warn: expected subtract in snprintf limit '(null)'
drivers/input/input.c:1543 input_print_bitmap() warn: expected subtract in snprintf limit '(null)'
drivers/input/input.c:1554 input_print_bitmap() warn: expected subtract in snprintf limit '(null)'
drivers/input/misc/keyspan_remote.c:132 keyspan_print() warn: expected subtract in snprintf limit '4'
drivers/block/zram/zram_drv.c:878 read_block_state() warn: expected subtract in snprintf limit 'count'
drivers/infiniband/hw/cxgb4/device.c:267 dump_qp() warn: expected subtract in snprintf limit 'space'
drivers/infiniband/hw/cxgb4/device.c:288 dump_qp() warn: expected subtract in snprintf limit 'space'
drivers/infiniband/hw/cxgb4/device.c:304 dump_qp() warn: expected subtract in snprintf limit 'space'
drivers/infiniband/hw/cxgb4/device.c:390 dump_stag() warn: expected subtract in snprintf limit 'space'
drivers/infiniband/hw/cxgb4/device.c:574 dump_ep() warn: expected subtract in snprintf limit 'space'
drivers/infiniband/hw/cxgb4/device.c:595 dump_ep() warn: expected subtract in snprintf limit 'space'
drivers/infiniband/hw/cxgb4/device.c:631 dump_listen_ep() warn: expected subtract in snprintf limit 'space'
drivers/infiniband/hw/cxgb4/device.c:644 dump_listen_ep() warn: expected subtract in snprintf limit 'space'
drivers/accel/habanalabs/gaudi/gaudi.c:8927 gaudi_fill_sobs_from_mon() warn: expected subtract in snprintf limit 'max_write'
drivers/accel/habanalabs/gaudi/gaudi.c:8930 gaudi_fill_sobs_from_mon() warn: expected subtract in snprintf limit 'max_write'
fs/ocfs2/filecheck.c:327 ocfs2_filecheck_attr_show() warn: expected subtract in snprintf limit 'remain'
fs/ecryptfs/crypto.c:127 ecryptfs_derive_iv() warn: expected subtract in snprintf limit '16'
sound/soc/sof/sof-client-probes.c:226 sof_probes_dfs_points_read() warn: expected subtract in snprintf limit 'remaining'
sound/soc/sof/ipc4-mtrace.c:320 sof_ipc4_priority_mask_dfs_read() warn: expected subtract in snprintf limit 'remaining'

--bqF84jalhcFd/GyC--
