Return-Path: <linux-kernel+bounces-131620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2F9898A2B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B061B269C5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21E914F90;
	Thu,  4 Apr 2024 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Q4zF0luQ"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866D7125B9
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712241150; cv=none; b=pTQtQVKuM9EidRaSTALDLF2R+8poj69a1vs/QpsVWN5Fj7yn70AWBPSkF7kXXWTjbTG3+x1sD2o+xGUqdalmo3EvmJENTSYvb7M1FRBWVqAjPAWMTwXiLYqZVqZIZ6nsxrkhERv7/BnVBXlJUsO1hpqgNijX19npr+eYKdnuw3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712241150; c=relaxed/simple;
	bh=/F837dXSiAvKy1fdu02fbfPcV5zZqVsZ4ilneosPBS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iNHVeyOVtHqPJu9UpDnj71jKj7/GlL30Wq9GLzCYnq3ab3CUB6BApofJXe5HbOA9e/osDSm9wSNkHCZ+KBzt2r2AJUPomlf/CYyz6bWlHs97vuCD/0anD1sjdT/3SBomQ0rWTEgWWuHQRzfgViWhHcGWvjvdgu2wBMQK2neMW0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Q4zF0luQ; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6KR9TtFl2kGJ0T4pKvcEGbT/7l77y9rqQ/1NhStIGDM=; b=Q4zF0luQl0NHWT1go39d8Z/ToY
	tDwDM4nhRMxXcGZ7zV2N+aGCfK1hKpnwoGNTWEACi5mkpuK//JC4vctz9MYZBIP03MfdVQ+dSdNns
	XiY5Hy6rftS7vI2DJx3SP8NyUKI36vheGUbL+fD1hImchek/0V59F7vfl4os4Y6cov/XY62UaF0pL
	JjetrK6TMbYdBvx9LX66sddopJSlNTMXSzkjbDzRPkWiNA6xzhaUU4o+oAaQCTUS3LbnKsUVLPqPM
	9+uGmfGLdNQaiZSEwgtQdCW3JAN94QwyzuSQUiIvw+kQWIwkZcPXTosHYDrTnFqgmUGupkbp+xCkm
	TqiVJs9A==;
Received: from [177.34.169.255] (helo=[192.168.0.139])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1rsO8J-001IWX-RQ; Thu, 04 Apr 2024 16:32:04 +0200
Message-ID: <364bd804-2be6-4a0a-a3d2-e6fa136a73ab@igalia.com>
Date: Thu, 4 Apr 2024 11:31:54 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panfrost: Show overall GPU usage stats through sysfs
 knob
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: kernel@collabora.com, Christopher Healy <healych@amazon.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240404140014.1022816-1-adrian.larumbe@collabora.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Autocrypt: addr=mcanal@igalia.com; keydata=
 xjMEZIsaeRYJKwYBBAHaRw8BAQdAGU6aY8oojw61KS5rGGMrlcilFqR6p6ID45IZ6ovX0h3N
 H01haXJhIENhbmFsIDxtY2FuYWxAaWdhbGlhLmNvbT7CjwQTFggANxYhBDMCqFtIvFKVRJZQ
 hDSPnHLaGFVuBQJkixp5BQkFo5qAAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQNI+cctoYVW5u
 GAEAwpaC5rI3wD8zqETKwGVoXd6+AbmGfZuVD40xepy7z/8BAM5w95/oyPsHUqOsg/xUTlNp
 rlbhA+WWoaOXA3XgR+wCzjgEZIsaeRIKKwYBBAGXVQEFAQEHQGoOK0jgh0IorMAacx6WUUWb
 s3RLiJYWUU6iNrk5wWUbAwEIB8J+BBgWCAAmFiEEMwKoW0i8UpVEllCENI+cctoYVW4FAmSL
 GnkFCQWjmoACGwwACgkQNI+cctoYVW6cqwD/Q9R98msvkhgRvi18fzUPFDwwogn+F+gQJJ6o
 pwpgFkAA/R2zOfla3IT6G3SBoV5ucdpdCpnIXFpQLbmfHK7dXsAC
In-Reply-To: <20240404140014.1022816-1-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/4/24 11:00, Adrián Larumbe wrote:
> This changeset is heavily inspired by commit 509433d8146c ("drm/v3d: Expose
> the total GPU usage stats on sysfs"). The point is making broader GPU
> occupancy numbers available through the sysfs interface, so that for every
> job slot, its number of processed jobs and total processing time are
> displayed.

Shouldn't we make this sysfs interface a generic DRM interface?
Something that would be standard for all drivers and that we could
integrate into gputop in the future.

Best Regards,
- Maíra

> 
> Cc: Boris Brezillon <boris.brezillon@collabora.com>
> Cc: Christopher Healy <healych@amazon.com>
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> ---
>   drivers/gpu/drm/panfrost/panfrost_device.h |  5 +++
>   drivers/gpu/drm/panfrost/panfrost_drv.c    | 49 ++++++++++++++++++++--
>   drivers/gpu/drm/panfrost/panfrost_job.c    | 17 +++++++-
>   drivers/gpu/drm/panfrost/panfrost_job.h    |  3 ++
>   4 files changed, 68 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
> index cffcb0ac7c11..1d343351c634 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> @@ -169,6 +169,11 @@ struct panfrost_engine_usage {
>   	unsigned long long cycles[NUM_JOB_SLOTS];
>   };
>   
> +struct panfrost_slot_usage {
> +	u64 enabled_ns;
> +	u64 jobs_sent;
> +};
> +
>   struct panfrost_file_priv {
>   	struct panfrost_device *pfdev;
>   
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index ef9f6c0716d5..6afcde66270f 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -8,6 +8,7 @@
>   #include <linux/pagemap.h>
>   #include <linux/platform_device.h>
>   #include <linux/pm_runtime.h>
> +#include <linux/sched/clock.h>
>   #include <drm/panfrost_drm.h>
>   #include <drm/drm_drv.h>
>   #include <drm/drm_ioctl.h>
> @@ -524,6 +525,10 @@ static const struct drm_ioctl_desc panfrost_drm_driver_ioctls[] = {
>   	PANFROST_IOCTL(MADVISE,		madvise,	DRM_RENDER_ALLOW),
>   };
>   
> +static const char * const engine_names[] = {
> +	"fragment", "vertex-tiler", "compute-only"
> +};
> +
>   static void panfrost_gpu_show_fdinfo(struct panfrost_device *pfdev,
>   				     struct panfrost_file_priv *panfrost_priv,
>   				     struct drm_printer *p)
> @@ -543,10 +548,6 @@ static void panfrost_gpu_show_fdinfo(struct panfrost_device *pfdev,
>   	 *   job spent on the GPU.
>   	 */
>   
> -	static const char * const engine_names[] = {
> -		"fragment", "vertex-tiler", "compute-only"
> -	};
> -
>   	BUILD_BUG_ON(ARRAY_SIZE(engine_names) != NUM_JOB_SLOTS);
>   
>   	for (i = 0; i < NUM_JOB_SLOTS - 1; i++) {
> @@ -716,8 +717,48 @@ static ssize_t profiling_store(struct device *dev,
>   
>   static DEVICE_ATTR_RW(profiling);
>   
> +static ssize_t
> +gpu_stats_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct panfrost_device *pfdev = dev_get_drvdata(dev);
> +	struct panfrost_slot_usage stats;
> +	u64 timestamp = local_clock();
> +	ssize_t len = 0;
> +	unsigned int i;
> +
> +	BUILD_BUG_ON(ARRAY_SIZE(engine_names) != NUM_JOB_SLOTS);
> +
> +	len += sysfs_emit(buf, "queue        timestamp        jobs        runtime\n");
> +	len += sysfs_emit_at(buf, len, "-------------------------------------------------\n");
> +
> +	for (i = 0; i < NUM_JOB_SLOTS - 1; i++) {
> +
> +		stats = get_slot_stats(pfdev, i);
> +
> +		/*
> +		 * Each line will display the slot name, timestamp, the number
> +		 * of jobs handled by that engine and runtime, as shown below:
> +		 *
> +		 * queue        timestamp        jobs        runtime
> +		 * -------------------------------------------------
> +		 * fragment     12252943467507   638         1184747640
> +		 * vertex-tiler 12252943467507   636         121663838
> +		 *
> +		 */
> +		len += sysfs_emit_at(buf, len, "%-13s%-17llu%-12llu%llu\n",
> +				     engine_names[i],
> +				     timestamp,
> +				     stats.jobs_sent,
> +				     stats.enabled_ns);
> +	}
> +
> +	return len;
> +}
> +static DEVICE_ATTR_RO(gpu_stats);
> +
>   static struct attribute *panfrost_attrs[] = {
>   	&dev_attr_profiling.attr,
> +	&dev_attr_gpu_stats.attr,
>   	NULL,
>   };
>   
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
> index a61ef0af9a4e..4c779e6f4cb0 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -31,6 +31,8 @@ struct panfrost_queue_state {
>   	struct drm_gpu_scheduler sched;
>   	u64 fence_context;
>   	u64 emit_seqno;
> +
> +	struct panfrost_slot_usage stats;
>   };
>   
>   struct panfrost_job_slot {
> @@ -160,15 +162,20 @@ panfrost_dequeue_job(struct panfrost_device *pfdev, int slot)
>   
>   	WARN_ON(!job);
>   	if (job->is_profiled) {
> +		u64 job_time = ktime_to_ns(ktime_sub(ktime_get(), job->start_time));
> +
>   		if (job->engine_usage) {
> -			job->engine_usage->elapsed_ns[slot] +=
> -				ktime_to_ns(ktime_sub(ktime_get(), job->start_time));
> +			job->engine_usage->elapsed_ns[slot] += job_time;
>   			job->engine_usage->cycles[slot] +=
>   				panfrost_cycle_counter_read(pfdev) - job->start_cycles;
>   		}
> +
>   		panfrost_cycle_counter_put(job->pfdev);
> +		pfdev->js->queue[slot].stats.enabled_ns += job_time;
>   	}
>   
> +	pfdev->js->queue[slot].stats.jobs_sent++;
> +
>   	pfdev->jobs[slot][0] = pfdev->jobs[slot][1];
>   	pfdev->jobs[slot][1] = NULL;
>   
> @@ -987,3 +994,9 @@ int panfrost_job_is_idle(struct panfrost_device *pfdev)
>   
>   	return true;
>   }
> +
> +struct panfrost_slot_usage
> +get_slot_stats(struct panfrost_device *pfdev, unsigned int slot)
> +{
> +	return pfdev->js->queue[slot].stats;
> +}
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.h b/drivers/gpu/drm/panfrost/panfrost_job.h
> index ec581b97852b..e9e2c9db0526 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.h
> @@ -50,4 +50,7 @@ void panfrost_job_enable_interrupts(struct panfrost_device *pfdev);
>   void panfrost_job_suspend_irq(struct panfrost_device *pfdev);
>   int panfrost_job_is_idle(struct panfrost_device *pfdev);
>   
> +struct panfrost_slot_usage
> +get_slot_stats(struct panfrost_device *pfdev, unsigned int slot);
> +
>   #endif
> 
> base-commit: 45c734fdd43db14444025910b4c59dd2b8be714a
> prerequisite-patch-id: 06ac397dd381984bfbff2a7661320c4f05470635

