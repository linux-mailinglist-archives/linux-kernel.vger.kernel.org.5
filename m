Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E47804C30
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344817AbjLEIWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjLEIWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:22:48 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A7E138;
        Tue,  5 Dec 2023 00:22:52 -0800 (PST)
Received: from [192.168.88.20] (91-158-149-209.elisa-laajakaista.fi [91.158.149.209])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5CEB34DB;
        Tue,  5 Dec 2023 09:22:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1701764531;
        bh=Lh9y/UDPcpcgejbtvdp2SqZpH1oMeRlPkdcPPMctZeQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fVcy5rebgdISrcgE3t8ShSmFOGgXvacSEi47L7DeLoE+z0cJleoHQ5vhDxix69Ezz
         7+tqeab9fm0gaPPPrci13uL7fWQbvOeC4/8iHYhop39zerrGT9M+Ns2wjeyH7xyF1m
         qkqnhxXNXZtSd7C4pSD+eUmzzdbwzZiGwbJQ7FpA=
Message-ID: <212f4a89-7135-41ca-9638-b36a474b1bfa@ideasonboard.com>
Date:   Tue, 5 Dec 2023 10:22:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] media: rkisp1: debug: Consolidate counter debugfs
 files
Content-Language: en-US
To:     Paul Elder <paul.elder@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc:     laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com,
        umang.jain@ideasonboard.com, Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20231201140433.2126011-1-paul.elder@ideasonboard.com>
 <20231201140433.2126011-5-paul.elder@ideasonboard.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <20231201140433.2126011-5-paul.elder@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2023 16:04, Paul Elder wrote:
> Consolidate all the debugfs files that were each a single counter into a
> single "counters" file.
> 
> While at it, reset the counters at stream on time to make it easier for
> to interpret the values in userspace.
> 
> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> 
> ---
> New in v2
> 
>   .../platform/rockchip/rkisp1/rkisp1-capture.c |  2 +
>   .../platform/rockchip/rkisp1/rkisp1-common.h  |  4 ++
>   .../platform/rockchip/rkisp1/rkisp1-debug.c   | 69 ++++++++++++-------
>   3 files changed, 50 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> index c6d7e01c8949..67b2e94dfd67 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> @@ -1030,6 +1030,8 @@ rkisp1_vb2_start_streaming(struct vb2_queue *queue, unsigned int count)
>   	struct media_entity *entity = &cap->vnode.vdev.entity;
>   	int ret;
>   
> +	rkisp1_debug_reset_counters(cap->rkisp1);
> +
>   	mutex_lock(&cap->rkisp1->stream_lock);
>   
>   	ret = video_device_pipeline_start(&cap->vnode.vdev, &cap->rkisp1->pipe);
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> index be69173958a4..789259fb304a 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> @@ -599,9 +599,13 @@ int rkisp1_params_register(struct rkisp1_device *rkisp1);
>   void rkisp1_params_unregister(struct rkisp1_device *rkisp1);
>   
>   #if IS_ENABLED(CONFIG_DEBUG_FS)
> +void rkisp1_debug_reset_counters(struct rkisp1_device *rkisp1);
>   void rkisp1_debug_init(struct rkisp1_device *rkisp1);
>   void rkisp1_debug_cleanup(struct rkisp1_device *rkisp1);
>   #else
> +static inline void rkisp1_debug_reset_counters(struct rkisp1_device *rkisp1)
> +{
> +}
>   static inline void rkisp1_debug_init(struct rkisp1_device *rkisp1)
>   {
>   }
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c
> index 79cda589d935..4358ed1367ed 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c
> @@ -25,6 +25,11 @@ struct rkisp1_debug_register {
>   	const char * const name;
>   };
>   
> +struct rkisp1_debug_counter {
> +	const char * const name;
> +	unsigned long *value;
> +};
> +
>   #define RKISP1_DEBUG_REG(name)		{ RKISP1_CIF_##name, 0, #name }
>   #define RKISP1_DEBUG_SHD_REG(name) { \
>   	RKISP1_CIF_##name, RKISP1_CIF_##name##_SHD, #name \
> @@ -191,6 +196,43 @@ static int rkisp1_debug_input_status_show(struct seq_file *m, void *p)
>   }
>   DEFINE_SHOW_ATTRIBUTE(rkisp1_debug_input_status);
>   
> +static int rkisp1_debug_counters_show(struct seq_file *m, void *p)
> +{
> +	struct rkisp1_device *rkisp1 = m->private;
> +	struct rkisp1_debug *debug = &rkisp1->debug;
> +
> +	const struct rkisp1_debug_counter counters[] = {
> +		{ "data_loss", &debug->data_loss },
> +		{ "outform_size_err", &debug->outform_size_error },
> +		{ "img_stabilization_size_error", &debug->img_stabilization_size_error },
> +		{ "inform_size_error", &debug->inform_size_error },
> +		{ "irq_delay", &debug->irq_delay },
> +		{ "mipi_error", &debug->mipi_error },
> +		{ "stats_error", &debug->stats_error },
> +		{ "mp_stop_timeout", &debug->stop_timeout[RKISP1_MAINPATH] },
> +		{ "sp_stop_timeout", &debug->stop_timeout[RKISP1_SELFPATH] },
> +		{ "mp_frame_drop", &debug->frame_drop[RKISP1_MAINPATH] },
> +		{ "sp_frame_drop", &debug->frame_drop[RKISP1_SELFPATH] },
> +		{ "complete_frames", &debug->complete_frames },
> +		{ /* Sentinel */ },
> +	};
> +
> +	const struct rkisp1_debug_counter *counter = counters;
> +
> +	for (; counter->name; ++counter)
> +		seq_printf(m, "%s: %lu\n", counter->name, *counter->value);
> +

You could also do:

	const struct {
		const char *name;
		unsigned long value;
	} counters[] = {
		{ "data_loss", debug->data_loss },
		{ "outform_size_err", debug->outform_size_error },
		{ "img_stabilization_size_error", debug->img_stabilization_size_error },
		{ "inform_size_error", debug->inform_size_error },
		{ "irq_delay", debug->irq_delay },
		{ "mipi_error", debug->mipi_error },
		{ "stats_error", debug->stats_error },
		{ "mp_stop_timeout", debug->stop_timeout[RKISP1_MAINPATH] },
		{ "sp_stop_timeout", debug->stop_timeout[RKISP1_SELFPATH] },
		{ "mp_frame_drop", debug->frame_drop[RKISP1_MAINPATH] },
		{ "sp_frame_drop", debug->frame_drop[RKISP1_SELFPATH] },
		{ "complete_frames", debug->complete_frames },
	};

	for (unsigned int i = 0; i < ARRAY_SIZE(counters); ++i)
		seq_printf(m, "%s: %lu\n", counters[i].name, counters[i].value);

Not a big difference, but this doesn't "leak" the struct used only inside the
function, doesn't need the sentinel, and I don't see a reason to store pointers
to values, instead of just storing the values.

  Tomi

> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(rkisp1_debug_counters);
> +
> +void rkisp1_debug_reset_counters(struct rkisp1_device *rkisp1)
> +{
> +	struct dentry *debugfs_dir = rkisp1->debug.debugfs_dir;
> +	memset(&rkisp1->debug, 0, sizeof(rkisp1->debug));
> +	rkisp1->debug.debugfs_dir = debugfs_dir;
> +}
> +
>   void rkisp1_debug_init(struct rkisp1_device *rkisp1)
>   {
>   	struct rkisp1_debug *debug = &rkisp1->debug;
> @@ -198,31 +240,8 @@ void rkisp1_debug_init(struct rkisp1_device *rkisp1)
>   
>   	debug->debugfs_dir = debugfs_create_dir(dev_name(rkisp1->dev), NULL);
>   
> -	debugfs_create_ulong("data_loss", 0444, debug->debugfs_dir,
> -			     &debug->data_loss);
> -	debugfs_create_ulong("outform_size_err", 0444,  debug->debugfs_dir,
> -			     &debug->outform_size_error);
> -	debugfs_create_ulong("img_stabilization_size_error", 0444,
> -			     debug->debugfs_dir,
> -			     &debug->img_stabilization_size_error);
> -	debugfs_create_ulong("inform_size_error", 0444,  debug->debugfs_dir,
> -			     &debug->inform_size_error);
> -	debugfs_create_ulong("irq_delay", 0444,  debug->debugfs_dir,
> -			     &debug->irq_delay);
> -	debugfs_create_ulong("mipi_error", 0444, debug->debugfs_dir,
> -			     &debug->mipi_error);
> -	debugfs_create_ulong("stats_error", 0444, debug->debugfs_dir,
> -			     &debug->stats_error);
> -	debugfs_create_ulong("mp_stop_timeout", 0444, debug->debugfs_dir,
> -			     &debug->stop_timeout[RKISP1_MAINPATH]);
> -	debugfs_create_ulong("sp_stop_timeout", 0444, debug->debugfs_dir,
> -			     &debug->stop_timeout[RKISP1_SELFPATH]);
> -	debugfs_create_ulong("mp_frame_drop", 0444, debug->debugfs_dir,
> -			     &debug->frame_drop[RKISP1_MAINPATH]);
> -	debugfs_create_ulong("sp_frame_drop", 0444, debug->debugfs_dir,
> -			     &debug->frame_drop[RKISP1_SELFPATH]);
> -	debugfs_create_ulong("complete_frames", 0444, debug->debugfs_dir,
> -			     &debug->complete_frames);
> +	debugfs_create_file("counters", 0444, debug->debugfs_dir, rkisp1,
> +			    &rkisp1_debug_counters_fops);
>   	debugfs_create_file("input_status", 0444, debug->debugfs_dir, rkisp1,
>   			    &rkisp1_debug_input_status_fops);
>   

