Return-Path: <linux-kernel+bounces-135250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7599789BDC4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5C7A1F21D68
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8CF64CD1;
	Mon,  8 Apr 2024 11:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Ht5rXnBv"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFE96025E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 11:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712574481; cv=none; b=HN/eTKMNDfyigDDxbLks00Zfp42/SrW0KOMzu7QgXaGZiHy4klYzzh8ftwBXVcHzxG/G+Jqm/XAqpmExdnv6mAy9Cfw19cJxyK7c65YlC3yAcjtGXdYDVyNyj3tg9RH1lgs6V6SAHPz/iBUwj8Bea9JLrDM9EUapZ8Lp5xuJyMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712574481; c=relaxed/simple;
	bh=YhxUQBg3n3cTnufK2zPe131A0C62pT4wrNfA/Coth50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OgBsELtpBfQSA4JL9IOhrjE4/60j1KyTVp9sIAvVveY6mFSPW1zcp7ILwHnCvRU2sxEBLEiFQ8x3YzbWMqF1gRZENf2xUL8C2MXNFJhO6lZNuvrvpAajfpC6u49m1psZZuucfEC6n2Hgh+C81b/3WryVg/KlWcy6EEX1MNaB+GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Ht5rXnBv; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=G8yNq+5/1rE8/5Dwk4z6wsHTs+C7YBQ68IPG6F+ovZ4=; b=Ht5rXnBvynUwwe/qU0kYhHgQC1
	6P0cPSJATQGx0nHe6NQoKbIkAmZjdBsLxkIa1HDIwNH57McaHgs8iZZGafYVY0CT1k2YSrv/JXoLC
	lU1xexwN53IQORZdi08jz9lI3P23ebeejTcI9ju67bd92HMrJG6sVU9RnXVQjZEIO2hBdWmA5RqTX
	pBNcS2stYbU5lGoEQ4GroAZCjXMySrSkpm1bq4gjyJb+OnCKAqvznji/nRJ1uftpEzUR2ShDvjPi5
	B5zT8m+MiBJ1mdoGZmysdTkN19nHGFtE4ta1ShF1jAyLYX0NjM3LdyGj/JyF7xzLeYv5x2E3ePXRg
	Ovd53EVQ==;
Received: from [177.34.169.255] (helo=[192.168.0.139])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1rtmqY-002Tcn-Hz; Mon, 08 Apr 2024 13:07:30 +0200
Message-ID: <eb52c5b7-074e-4f63-a5c4-c693190b5805@igalia.com>
Date: Mon, 8 Apr 2024 08:07:20 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panfrost: Show overall GPU usage stats through sysfs
 knob
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 kernel@collabora.com, Christopher Healy <healych@amazon.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240404140014.1022816-1-adrian.larumbe@collabora.com>
 <364bd804-2be6-4a0a-a3d2-e6fa136a73ab@igalia.com>
 <6aoklcyuvvxgqecjzatn2xopevbsrejhkvzmcqosbu2wkngtui@36gynkk5fay6>
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
In-Reply-To: <6aoklcyuvvxgqecjzatn2xopevbsrejhkvzmcqosbu2wkngtui@36gynkk5fay6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/4/24 18:30, Adrián Larumbe wrote:
> On 04.04.2024 11:31, Maíra Canal wrote:
>> On 4/4/24 11:00, Adrián Larumbe wrote:
>>> This changeset is heavily inspired by commit 509433d8146c ("drm/v3d: Expose
>>> the total GPU usage stats on sysfs"). The point is making broader GPU
>>> occupancy numbers available through the sysfs interface, so that for every
>>> job slot, its number of processed jobs and total processing time are
>>> displayed.
>>
>> Shouldn't we make this sysfs interface a generic DRM interface?
>> Something that would be standard for all drivers and that we could
>> integrate into gputop in the future.
> 
> I think the best way to generalise this sysfs knob would be to create a DRM
> class attribute somewhere in drivers/gpu/drm/drm_sysfs.c and then adding a new
> function to 'struct drm_driver' that would return a structure with the relevant
> information (execution units and their names, number of processed jobs, etc).

These is exactly what I was thinking about.

> 
> What that information would exactly be is up to debate, I guess, since different
> drivers might be interested in showing different bits of information.

I believe we can start with the requirements of V3D and Panfrost and 
them, expand from it.

> 
> Laying that down is important because the sysfs file would become part of the
> device class API.

My PoV: it is important, but not completly tragic if we don't get it
perfect. Just like fdinfo, which is evolving.

> 
> I might come up with a new RFC patch series that does precisely that, at least
> for v3d and Panfrost, and maybe other people could pitch in with the sort of
> things they'd like to see for other drivers?

Yeah, this would be a great idea. Please, CC me on this series.

Best Regards,
- Maíra

> 
> Cheers,
> Adrian
> 
>> Best Regards,
>> - Maíra
>>
>>>
>>> Cc: Boris Brezillon <boris.brezillon@collabora.com>
>>> Cc: Christopher Healy <healych@amazon.com>
>>> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
>>> ---
>>>    drivers/gpu/drm/panfrost/panfrost_device.h |  5 +++
>>>    drivers/gpu/drm/panfrost/panfrost_drv.c    | 49 ++++++++++++++++++++--
>>>    drivers/gpu/drm/panfrost/panfrost_job.c    | 17 +++++++-
>>>    drivers/gpu/drm/panfrost/panfrost_job.h    |  3 ++
>>>    4 files changed, 68 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
>>> index cffcb0ac7c11..1d343351c634 100644
>>> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
>>> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
>>> @@ -169,6 +169,11 @@ struct panfrost_engine_usage {
>>>    	unsigned long long cycles[NUM_JOB_SLOTS];
>>>    };
>>> +struct panfrost_slot_usage {
>>> +	u64 enabled_ns;
>>> +	u64 jobs_sent;
>>> +};
>>> +
>>>    struct panfrost_file_priv {
>>>    	struct panfrost_device *pfdev;
>>> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
>>> index ef9f6c0716d5..6afcde66270f 100644
>>> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
>>> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
>>> @@ -8,6 +8,7 @@
>>>    #include <linux/pagemap.h>
>>>    #include <linux/platform_device.h>
>>>    #include <linux/pm_runtime.h>
>>> +#include <linux/sched/clock.h>
>>>    #include <drm/panfrost_drm.h>
>>>    #include <drm/drm_drv.h>
>>>    #include <drm/drm_ioctl.h>
>>> @@ -524,6 +525,10 @@ static const struct drm_ioctl_desc panfrost_drm_driver_ioctls[] = {
>>>    	PANFROST_IOCTL(MADVISE,		madvise,	DRM_RENDER_ALLOW),
>>>    };
>>> +static const char * const engine_names[] = {
>>> +	"fragment", "vertex-tiler", "compute-only"
>>> +};
>>> +
>>>    static void panfrost_gpu_show_fdinfo(struct panfrost_device *pfdev,
>>>    				     struct panfrost_file_priv *panfrost_priv,
>>>    				     struct drm_printer *p)
>>> @@ -543,10 +548,6 @@ static void panfrost_gpu_show_fdinfo(struct panfrost_device *pfdev,
>>>    	 *   job spent on the GPU.
>>>    	 */
>>> -	static const char * const engine_names[] = {
>>> -		"fragment", "vertex-tiler", "compute-only"
>>> -	};
>>> -
>>>    	BUILD_BUG_ON(ARRAY_SIZE(engine_names) != NUM_JOB_SLOTS);
>>>    	for (i = 0; i < NUM_JOB_SLOTS - 1; i++) {
>>> @@ -716,8 +717,48 @@ static ssize_t profiling_store(struct device *dev,
>>>    static DEVICE_ATTR_RW(profiling);
>>> +static ssize_t
>>> +gpu_stats_show(struct device *dev, struct device_attribute *attr, char *buf)
>>> +{
>>> +	struct panfrost_device *pfdev = dev_get_drvdata(dev);
>>> +	struct panfrost_slot_usage stats;
>>> +	u64 timestamp = local_clock();
>>> +	ssize_t len = 0;
>>> +	unsigned int i;
>>> +
>>> +	BUILD_BUG_ON(ARRAY_SIZE(engine_names) != NUM_JOB_SLOTS);
>>> +
>>> +	len += sysfs_emit(buf, "queue        timestamp        jobs        runtime\n");
>>> +	len += sysfs_emit_at(buf, len, "-------------------------------------------------\n");
>>> +
>>> +	for (i = 0; i < NUM_JOB_SLOTS - 1; i++) {
>>> +
>>> +		stats = get_slot_stats(pfdev, i);
>>> +
>>> +		/*
>>> +		 * Each line will display the slot name, timestamp, the number
>>> +		 * of jobs handled by that engine and runtime, as shown below:
>>> +		 *
>>> +		 * queue        timestamp        jobs        runtime
>>> +		 * -------------------------------------------------
>>> +		 * fragment     12252943467507   638         1184747640
>>> +		 * vertex-tiler 12252943467507   636         121663838
>>> +		 *
>>> +		 */
>>> +		len += sysfs_emit_at(buf, len, "%-13s%-17llu%-12llu%llu\n",
>>> +				     engine_names[i],
>>> +				     timestamp,
>>> +				     stats.jobs_sent,
>>> +				     stats.enabled_ns);
>>> +	}
>>> +
>>> +	return len;
>>> +}
>>> +static DEVICE_ATTR_RO(gpu_stats);
>>> +
>>>    static struct attribute *panfrost_attrs[] = {
>>>    	&dev_attr_profiling.attr,
>>> +	&dev_attr_gpu_stats.attr,
>>>    	NULL,
>>>    };
>>> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
>>> index a61ef0af9a4e..4c779e6f4cb0 100644
>>> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
>>> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
>>> @@ -31,6 +31,8 @@ struct panfrost_queue_state {
>>>    	struct drm_gpu_scheduler sched;
>>>    	u64 fence_context;
>>>    	u64 emit_seqno;
>>> +
>>> +	struct panfrost_slot_usage stats;
>>>    };
>>>    struct panfrost_job_slot {
>>> @@ -160,15 +162,20 @@ panfrost_dequeue_job(struct panfrost_device *pfdev, int slot)
>>>    	WARN_ON(!job);
>>>    	if (job->is_profiled) {
>>> +		u64 job_time = ktime_to_ns(ktime_sub(ktime_get(), job->start_time));
>>> +
>>>    		if (job->engine_usage) {
>>> -			job->engine_usage->elapsed_ns[slot] +=
>>> -				ktime_to_ns(ktime_sub(ktime_get(), job->start_time));
>>> +			job->engine_usage->elapsed_ns[slot] += job_time;
>>>    			job->engine_usage->cycles[slot] +=
>>>    				panfrost_cycle_counter_read(pfdev) - job->start_cycles;
>>>    		}
>>> +
>>>    		panfrost_cycle_counter_put(job->pfdev);
>>> +		pfdev->js->queue[slot].stats.enabled_ns += job_time;
>>>    	}
>>> +	pfdev->js->queue[slot].stats.jobs_sent++;
>>> +
>>>    	pfdev->jobs[slot][0] = pfdev->jobs[slot][1];
>>>    	pfdev->jobs[slot][1] = NULL;
>>> @@ -987,3 +994,9 @@ int panfrost_job_is_idle(struct panfrost_device *pfdev)
>>>    	return true;
>>>    }
>>> +
>>> +struct panfrost_slot_usage
>>> +get_slot_stats(struct panfrost_device *pfdev, unsigned int slot)
>>> +{
>>> +	return pfdev->js->queue[slot].stats;
>>> +}
>>> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.h b/drivers/gpu/drm/panfrost/panfrost_job.h
>>> index ec581b97852b..e9e2c9db0526 100644
>>> --- a/drivers/gpu/drm/panfrost/panfrost_job.h
>>> +++ b/drivers/gpu/drm/panfrost/panfrost_job.h
>>> @@ -50,4 +50,7 @@ void panfrost_job_enable_interrupts(struct panfrost_device *pfdev);
>>>    void panfrost_job_suspend_irq(struct panfrost_device *pfdev);
>>>    int panfrost_job_is_idle(struct panfrost_device *pfdev);
>>> +struct panfrost_slot_usage
>>> +get_slot_stats(struct panfrost_device *pfdev, unsigned int slot);
>>> +
>>>    #endif
>>>
>>> base-commit: 45c734fdd43db14444025910b4c59dd2b8be714a
>>> prerequisite-patch-id: 06ac397dd381984bfbff2a7661320c4f05470635

