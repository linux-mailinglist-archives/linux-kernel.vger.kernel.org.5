Return-Path: <linux-kernel+bounces-145141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F558A5012
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59B57287270
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4053C12C463;
	Mon, 15 Apr 2024 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="f5R7JLKQ"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9B412BF2A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185424; cv=none; b=Peod/EcGDOiJr+dlLVxWPAKqn7JXh0xSvfvb4EvcJ2tyvKKnCb5MsQpskvnchnfY0R1Okejug7JLRfhcKYHiJH/XvAlErRyu6dfRaajLo66WxxzGgjdNc6R+cYZXFGERqQVUqmI06dfhmRFLZjvrw+mkv5wr77AdNzW/oparmfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185424; c=relaxed/simple;
	bh=2RCvZSx4mDsYYthKS8e7h/HEfsOsFY3N/N8v78dg2zY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hlqzJzNGmBVQIJ15hmUM9H0zqiuHqGZq/KrLrhiQdzPRMOInKhf4z/M5e1X7yvgIAXWJ3Gw4bLqT8xMutWalVyL7IkYRYxKP1lKLRmV3A7H5fLVnNoVHgwzyrMHSOt8FMgiDIWabyyEG8hNgxWb2M+cT1imUz9KeQdzxsICuxaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=f5R7JLKQ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34665dd7610so1211424f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 05:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1713185420; x=1713790220; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vtkFtEeI8u9n0wGYtFb1Gs5PYCsfANTu3fNjyimbUfo=;
        b=f5R7JLKQoxyo9SFD1mfaQGExM55LH1G5VBfdLAOeAiNuRsuuasmm2PJe0ux+CiGRa1
         Zb+pX7boZ3SHZRKJUYSPBRB2tVppCJVYuDsimUtUbu735o843XS6NB1qxtMlkoPWJz1s
         7uYsbQQko841lftEKfeXpqyZOoXrQnpKg+XriYa5TsWoXfpukmU5AjyKCI3mPXU3ngmr
         bR3U0pFFNCJY7qFaBbZHoMzsRtRhRVzfMb01I11Yez5Px2CLpMBo5VGAKsleHW10Aekq
         m39uegR78eIr3hjjr1J+4vobAhTH20Mk4tK5NJRmCN+lt9OSVecGBuAiBX2/65mJsNcE
         XhGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713185420; x=1713790220;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vtkFtEeI8u9n0wGYtFb1Gs5PYCsfANTu3fNjyimbUfo=;
        b=SIyR1PfFudPIN0SZo2+6IausM3PrEA18mnjtF2A3eEYsardKl85Nquqa5NaaPm50Lq
         Fb/3vFGDo0jEzztP2dX+3y5uDC92u7fwdvZCxoL0lnbH6oAcO1Rz5JwQbGsulNolJ4HU
         bYvIisuVphU7HP0M+poGOwz3s5eYOKIeojKdTsmhCLA4RizKDZJJdX63puFJMhC0x52v
         m6iIdSHAMiIVbkWtNqHt3tI0mQG/kO8AQ9KCZMPZqedVtwfXrG1Ow9ZyMSIstQD806sm
         fhEYJy7CCAFKfpHPS2gELq+nMHdujCcWBaAXNCndfSVKZtPjYrl0TXLcn9PsZoSa6GUR
         P0iw==
X-Forwarded-Encrypted: i=1; AJvYcCWD7sM7m7vQxGcz93yQ4mCn+dUHxSG8fOTfJXrVXkRswwz+Owok7Tca6KB3pUxOk70uZEDWDhynHS7BQPkQLXM3kmdDoN53jFM7NcDr
X-Gm-Message-State: AOJu0YwDGG8aNJ9wPzPL1XYp68UQCOdaMKXugm8MQMmMtMxROUm2hwlF
	WoB88bL/8DRWf0ve8rOs5kCHtFzbchaz2iAzjFvJ1TCroEUZXYr/JQ4JMKl3WpI=
X-Google-Smtp-Source: AGHT+IGZl+ILMkIODDgIrM//G0ZKVMCt78xec3x9yWjOU+g4XwOCKrIzqWful5fTFk12zh8yATnoCQ==
X-Received: by 2002:a5d:6daa:0:b0:343:b5dd:f6a6 with SMTP id u10-20020a5d6daa000000b00343b5ddf6a6mr7347592wrs.4.1713185420244;
        Mon, 15 Apr 2024 05:50:20 -0700 (PDT)
Received: from [192.168.0.101] ([84.65.0.132])
        by smtp.gmail.com with ESMTPSA id b11-20020adfe30b000000b0034625392416sm12040391wrj.104.2024.04.15.05.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 05:50:19 -0700 (PDT)
Message-ID: <e6500d5b-0151-4c31-9032-3a23157b3126@ursulin.net>
Date: Mon, 15 Apr 2024 13:50:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sysfs: Add drm class-wide attribute to get active
 device clients
Content-Language: en-GB
To: Rob Clark <robdclark@gmail.com>,
 =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Hans de Goede <hdegoede@redhat.com>, kernel@collabora.com,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Christopher Healy <healych@amazon.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240403182951.724488-1-adrian.larumbe@collabora.com>
 <CAF6AEGsWtJs2xcZx59P9_maxn1RqCO6-4GwEp2fL31bZtTyuoA@mail.gmail.com>
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <CAF6AEGsWtJs2xcZx59P9_maxn1RqCO6-4GwEp2fL31bZtTyuoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 05/04/2024 18:59, Rob Clark wrote:
> On Wed, Apr 3, 2024 at 11:37 AM Adrián Larumbe
> <adrian.larumbe@collabora.com> wrote:
>>
>> Up to this day, all fdinfo-based GPU profilers must traverse the entire
>> /proc directory structure to find open DRM clients with fdinfo file
>> descriptors. This is inefficient and time-consuming.
>>
>> This patch adds a new device class attribute that will install a sysfs file
>> per DRM device, which can be queried by profilers to get a list of PIDs for
>> their open clients. This file isn't human-readable, and it's meant to be
>> queried only by GPU profilers like gputop and nvtop.
>>
>> Cc: Boris Brezillon <boris.brezillon@collabora.com>
>> Cc: Tvrtko Ursulin <tursulin@ursulin.net>
>> Cc: Christopher Healy <healych@amazon.com>
>> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> 
> It does seem like a good idea.. idk if there is some precedent to
> prefer binary vs ascii in sysfs, but having a way to avoid walking
> _all_ processes is a good idea.

I naturally second that it is a needed feature, but I do not think 
binary format is justified. AFAIR it should be used for things like 
hw/fw standardised tables or firmware images, not when exporting a 
simple list of PIDs. It also precludes easy shell/script access and the 
benefit of avoiding parsing a short list is I suspect completely dwarfed 
by needing to parse all the related fdinfo etc.

>> ---
>>   drivers/gpu/drm/drm_internal.h       |  2 +-
>>   drivers/gpu/drm/drm_privacy_screen.c |  2 +-
>>   drivers/gpu/drm/drm_sysfs.c          | 89 ++++++++++++++++++++++------
>>   3 files changed, 74 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
>> index 2215baef9a3e..9a399b03d11c 100644
>> --- a/drivers/gpu/drm/drm_internal.h
>> +++ b/drivers/gpu/drm/drm_internal.h
>> @@ -145,7 +145,7 @@ bool drm_master_internal_acquire(struct drm_device *dev);
>>   void drm_master_internal_release(struct drm_device *dev);
>>
>>   /* drm_sysfs.c */
>> -extern struct class *drm_class;
>> +extern struct class drm_class;
>>
>>   int drm_sysfs_init(void);
>>   void drm_sysfs_destroy(void);
>> diff --git a/drivers/gpu/drm/drm_privacy_screen.c b/drivers/gpu/drm/drm_privacy_screen.c
>> index 6cc39e30781f..2fbd24ba5818 100644
>> --- a/drivers/gpu/drm/drm_privacy_screen.c
>> +++ b/drivers/gpu/drm/drm_privacy_screen.c
>> @@ -401,7 +401,7 @@ struct drm_privacy_screen *drm_privacy_screen_register(
>>          mutex_init(&priv->lock);
>>          BLOCKING_INIT_NOTIFIER_HEAD(&priv->notifier_head);
>>
>> -       priv->dev.class = drm_class;
>> +       priv->dev.class = &drm_class;
>>          priv->dev.type = &drm_privacy_screen_type;
>>          priv->dev.parent = parent;
>>          priv->dev.release = drm_privacy_screen_device_release;
>> diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
>> index a953f69a34b6..56ca9e22c720 100644
>> --- a/drivers/gpu/drm/drm_sysfs.c
>> +++ b/drivers/gpu/drm/drm_sysfs.c
>> @@ -58,8 +58,6 @@ static struct device_type drm_sysfs_device_connector = {
>>          .name = "drm_connector",
>>   };
>>
>> -struct class *drm_class;
>> -
>>   #ifdef CONFIG_ACPI
>>   static bool drm_connector_acpi_bus_match(struct device *dev)
>>   {
>> @@ -128,6 +126,62 @@ static const struct component_ops typec_connector_ops = {
>>
>>   static CLASS_ATTR_STRING(version, S_IRUGO, "drm 1.1.0 20060810");
>>
>> +static ssize_t clients_show(struct device *cd, struct device_attribute *attr, char *buf)
>> +{
>> +       struct drm_minor *minor = cd->driver_data;
>> +       struct drm_device *ddev = minor->dev;
>> +       struct drm_file *priv;
>> +       ssize_t offset = 0;
>> +       void *pid_buf;
>> +
>> +       if (minor->type != DRM_MINOR_RENDER)
>> +               return 0;

Why this?

>> +
>> +       pid_buf = kvmalloc(PAGE_SIZE, GFP_KERNEL);

I don't quite get the kvmalloc for just one page (or why even a temporay 
buffer and not write into buf directly?).

>> +       if (!pid_buf)
>> +               return 0;
>> +
>> +       mutex_lock(&ddev->filelist_mutex);
>> +       list_for_each_entry_reverse(priv, &ddev->filelist, lhead) {
>> +               struct pid *pid;
>> +
>> +               if (drm_WARN_ON(ddev, (PAGE_SIZE - offset) < sizeof(pid_t)))
>> +                       break;

Feels bad.. I would suggest exploring implementing a read callback 
(instead of show) and handling arbitrary size output.

>> +
>> +               rcu_read_lock();
>> +               pid = rcu_dereference(priv->pid);
>> +               (*(pid_t *)(pid_buf + offset)) = pid_vnr(pid);
>> +               rcu_read_unlock();
>> +
>> +               offset += sizeof(pid_t);
>> +       }
>> +       mutex_unlock(&ddev->filelist_mutex);
>> +
>> +       if (offset < PAGE_SIZE)
>> +               (*(pid_t *)(pid_buf + offset)) = 0;

Either NULL terminated or PAGE_SIZE/sizeof(pid) entries and not NULL 
terminated feels weird. If I got that right.

For me everything points towards going for text output.

>> +
>> +       memcpy(buf, pid_buf, offset);
>> +
>> +       kvfree(pid_buf);
>> +
>> +       return offset;
>> +
>> +}
>> +static DEVICE_ATTR_RO(clients);

Shouldn't BIN_ATTR_RO be used for binary files in sysfs?

Regards,

Tvrtko

P.S. Or maybe it is time for drmfs? Where each client gets a directory 
and drivers can populate files. Such as per client logging streams and 
whatnot.

>> +
>> +static struct attribute *drm_device_attrs[] = {
>> +       &dev_attr_clients.attr,
>> +       NULL,
>> +};
>> +ATTRIBUTE_GROUPS(drm_device);
>> +
>> +struct class drm_class = {
>> +       .name           = "drm",
>> +       .dev_groups     = drm_device_groups,
>> +};
>> +
>> +static bool drm_class_initialised;
>> +
>>   /**
>>    * drm_sysfs_init - initialize sysfs helpers
>>    *
>> @@ -142,18 +196,19 @@ int drm_sysfs_init(void)
>>   {
>>          int err;
>>
>> -       drm_class = class_create("drm");
>> -       if (IS_ERR(drm_class))
>> -               return PTR_ERR(drm_class);
>> +       err = class_register(&drm_class);
>> +       if (err)
>> +               return err;
>>
>> -       err = class_create_file(drm_class, &class_attr_version.attr);
>> +       err = class_create_file(&drm_class, &class_attr_version.attr);
>>          if (err) {
>> -               class_destroy(drm_class);
>> -               drm_class = NULL;
>> +               class_destroy(&drm_class);
>>                  return err;
>>          }
>>
>> -       drm_class->devnode = drm_devnode;
>> +       drm_class.devnode = drm_devnode;
>> +
>> +       drm_class_initialised = true;
>>
>>          drm_sysfs_acpi_register();
>>          return 0;
>> @@ -166,12 +221,12 @@ int drm_sysfs_init(void)
>>    */
>>   void drm_sysfs_destroy(void)
>>   {
>> -       if (IS_ERR_OR_NULL(drm_class))
>> +       if (!drm_class_initialised)
>>                  return;
>>          drm_sysfs_acpi_unregister();
>> -       class_remove_file(drm_class, &class_attr_version.attr);
>> -       class_destroy(drm_class);
>> -       drm_class = NULL;
>> +       class_remove_file(&drm_class, &class_attr_version.attr);
>> +       class_destroy(&drm_class);
>> +       drm_class_initialised = false;
>>   }
>>
>>   static void drm_sysfs_release(struct device *dev)
>> @@ -372,7 +427,7 @@ int drm_sysfs_connector_add(struct drm_connector *connector)
>>                  return -ENOMEM;
>>
>>          device_initialize(kdev);
>> -       kdev->class = drm_class;
>> +       kdev->class = &drm_class;
>>          kdev->type = &drm_sysfs_device_connector;
>>          kdev->parent = dev->primary->kdev;
>>          kdev->groups = connector_dev_groups;
>> @@ -550,7 +605,7 @@ struct device *drm_sysfs_minor_alloc(struct drm_minor *minor)
>>                          minor_str = "card%d";
>>
>>                  kdev->devt = MKDEV(DRM_MAJOR, minor->index);
>> -               kdev->class = drm_class;
>> +               kdev->class = &drm_class;
>>                  kdev->type = &drm_sysfs_device_minor;
>>          }
>>
>> @@ -579,10 +634,10 @@ struct device *drm_sysfs_minor_alloc(struct drm_minor *minor)
>>    */
>>   int drm_class_device_register(struct device *dev)
>>   {
>> -       if (!drm_class || IS_ERR(drm_class))
>> +       if (!drm_class_initialised)
>>                  return -ENOENT;
>>
>> -       dev->class = drm_class;
>> +       dev->class = &drm_class;
>>          return device_register(dev);
>>   }
>>   EXPORT_SYMBOL_GPL(drm_class_device_register);
>>
>> base-commit: 45c734fdd43db14444025910b4c59dd2b8be714a
>> --
>> 2.44.0
>>

