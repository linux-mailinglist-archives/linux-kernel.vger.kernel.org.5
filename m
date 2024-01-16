Return-Path: <linux-kernel+bounces-27258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A2F82ECD5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38DF4B22B01
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6761313AC8;
	Tue, 16 Jan 2024 10:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tbltmrl7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD5B134D9
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 10:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705401658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sZtjRks1jMUiOwoNBHIst311kojRryEzQSKGDYst7ZE=;
	b=Tbltmrl7o0fcymhxHreD5mcRQuxIun/f3Dc8OVla8VUh0t6A3bOa8Ssx4fRx4S3VXoGIIV
	97jA/iqQdqYBLWi65U5TB5Ysq5OljlKr/3CsY7iTOE2DwPzFky87IPoELBQ4qTRZ2bw5fN
	cYd1cpmG+BkUMFxnqV9acIgM7Qf8OSU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-K783gdHrOZC87NBJQHyuZA-1; Tue, 16 Jan 2024 05:40:57 -0500
X-MC-Unique: K783gdHrOZC87NBJQHyuZA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3368698f0caso6001244f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 02:40:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705401655; x=1706006455;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sZtjRks1jMUiOwoNBHIst311kojRryEzQSKGDYst7ZE=;
        b=mHgmoD7TysVFq+B/nML/gtaWId4MJ6YBbqf8gr8kriMjqbilckLJMHChwULcRnSegZ
         nsaY/stLOirZn1K9HS+G/qK86rOgF1+BZRUlRFvoMuIYimTR+t902ZXpp8ZctG/kp8Ds
         BAHUnwwXk+9z9DbqJlHEhNm/omtmnDCcNH8UywmBEHxOwRIDESA332pvYM8+D4Oewvsz
         R7R6gsFab8Sb/raK0JhIy26/wfyE7749u1vAqXygqglagW4HCJoqQeoekjwJm3N+/up0
         CXUOQwjVgekEzgGKlKJW03BIpm0+u8VNjKbuV7Cb3bHtnto6ADMtxxxRQop5JJlyDt2v
         s4cg==
X-Gm-Message-State: AOJu0YxRHumURD9NDOvNOBzFrp+0xoyqt7gK4SI+Rq5KaSZWITgKqXcY
	aZ+3LnSCbbPVakWZBslUkTO/fVc/6TMcmopaHQsJ4OydijVLFdvfYgaZeE5AJx+BpTw0ESPZa2C
	0LmmRbDWyh8P0ji+q7oqFOYW2/157YD4=
X-Received: by 2002:a5d:4a0a:0:b0:337:57da:4253 with SMTP id m10-20020a5d4a0a000000b0033757da4253mr2144313wrq.152.1705401655592;
        Tue, 16 Jan 2024 02:40:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/vNPo/ZR7dZ4Kn7fMyT1bR4Jj/yY2bFAMMD1Mhdzofs85Y7jrGM66bN02adUE/MbwfCB/Ow==
X-Received: by 2002:a5d:4a0a:0:b0:337:57da:4253 with SMTP id m10-20020a5d4a0a000000b0033757da4253mr2144309wrq.152.1705401655299;
        Tue, 16 Jan 2024 02:40:55 -0800 (PST)
Received: from [192.168.50.107] ([83.240.63.96])
        by smtp.gmail.com with ESMTPSA id m6-20020adffa06000000b00336c6b77584sm14253486wrr.91.2024.01.16.02.40.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 02:40:54 -0800 (PST)
Message-ID: <750d9e17-d8b8-44c0-ba47-74a686333a01@redhat.com>
Date: Tue, 16 Jan 2024 11:40:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] crash_dump: save the dm crypt key temporarily
Content-Language: en-US
To: Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org
Cc: Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Kairui Song <ryncsn@gmail.com>, dm-devel@redhat.com,
 Jan Pazdziora <jpazdziora@redhat.com>, Pingfan Liu <kernelfans@gmail.com>,
 Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>
References: <20240110071522.1308935-1-coxu@redhat.com>
 <20240110071522.1308935-3-coxu@redhat.com>
From: Ondrej Kozina <okozina@redhat.com>
Autocrypt: addr=okozina@redhat.com; keydata=
 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
In-Reply-To: <20240110071522.1308935-3-coxu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/01/2024 08:15, Coiby Xu wrote:
> User space is supposed to write the key description to
> /sys/kernel/crash_dm_crypt_key so the kernel will read the key and save
> a temporary copy for later user. User space has 2 minutes at maximum to
> load the kdump initrd before the key gets wiped. And after kdump
> retrieves the key, the key will be wiped immediately.
> 
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>   include/linux/crash_core.h   |   7 +-
>   include/linux/kexec.h        |   4 ++
>   kernel/Makefile              |   2 +-
>   kernel/crash_dump_dm_crypt.c | 121 +++++++++++++++++++++++++++++++++++
>   kernel/ksysfs.c              |  23 ++++++-
>   5 files changed, 153 insertions(+), 4 deletions(-)
>   create mode 100644 kernel/crash_dump_dm_crypt.c
> 
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index 5126a4fecb44..7078eda6418d 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -125,6 +125,12 @@ static inline void __init reserve_crashkernel_generic(char *cmdline,
>   {}
>   #endif
>   
> +struct kimage;
> +
> +int crash_sysfs_dm_crypt_key_write(const char *key_des, size_t count);
> +int crash_pass_temp_dm_crypt_key(void **addr, unsigned long *sz);
> +int crash_load_dm_crypt_key(struct kimage *image);
> +
>   /* Alignment required for elf header segment */
>   #define ELF_CORE_HEADER_ALIGN   4096
>   
> @@ -140,7 +146,6 @@ extern int crash_exclude_mem_range(struct crash_mem *mem,
>   extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
>   				       void **addr, unsigned long *sz);
>   
> -struct kimage;
>   struct kexec_segment;
>   
>   #define KEXEC_CRASH_HP_NONE			0
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 6f4626490ebf..bf7ab1e927ef 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -366,6 +366,10 @@ struct kimage {
>   	void *elf_headers;
>   	unsigned long elf_headers_sz;
>   	unsigned long elf_load_addr;
> +
> +	/* dm crypt key buffer */
> +	unsigned long dm_crypt_key_addr;
> +	unsigned long dm_crypt_key_sz;
>   };
>   
>   /* kexec interface functions */
> diff --git a/kernel/Makefile b/kernel/Makefile
> index 3947122d618b..48859bf63db5 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -119,7 +119,7 @@ obj-$(CONFIG_PERF_EVENTS) += events/
>   
>   obj-$(CONFIG_USER_RETURN_NOTIFIER) += user-return-notifier.o
>   obj-$(CONFIG_PADATA) += padata.o
> -obj-$(CONFIG_CRASH_DUMP) += crash_dump.o
> +obj-$(CONFIG_CRASH_DUMP) += crash_dump.o crash_dump_dm_crypt.o
>   obj-$(CONFIG_JUMP_LABEL) += jump_label.o
>   obj-$(CONFIG_CONTEXT_TRACKING) += context_tracking.o
>   obj-$(CONFIG_TORTURE_TEST) += torture.o
> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> new file mode 100644
> index 000000000000..3a0b0b773598
> --- /dev/null
> +++ b/kernel/crash_dump_dm_crypt.c
> @@ -0,0 +1,121 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <keys/user-type.h>
> +#include <linux/crash_dump.h>
> +
> +static u8 *dm_crypt_key;
> +static unsigned int dm_crypt_key_size;
> +
> +void wipe_dm_crypt_key(void)
> +{
> +	if (dm_crypt_key) {
> +		memset(dm_crypt_key, 0, dm_crypt_key_size * sizeof(u8));
> +		kfree(dm_crypt_key);
> +		dm_crypt_key = NULL;
> +	}
> +}
> +
> +static void _wipe_dm_crypt_key(struct work_struct *dummy)
> +{
> +	wipe_dm_crypt_key();
> +}
> +
> +static DECLARE_DELAYED_WORK(wipe_dm_crypt_key_work, _wipe_dm_crypt_key);
> +
> +static unsigned __read_mostly wipe_key_delay = 120; /* 2 mins */
> +
> +static int crash_save_temp_dm_crypt_key(const char *key_desc, size_t count)
> +{
> +	const struct user_key_payload *ukp;
> +	struct key *key;
> +
> +	if (dm_crypt_key) {
> +		memset(dm_crypt_key, 0, dm_crypt_key_size * sizeof(u8));
> +		kfree(dm_crypt_key);
> +	}
> +
> +	pr_debug("Requesting key %s", key_desc);
> +	key = request_key(&key_type_user, key_desc, NULL);

If we don't read the key copy form userspace (my reply to top level 
message) you could use key_type_logon here.

> +
> +	if (IS_ERR(key)) {
> +		pr_debug("No such key %s", key_desc);
> +		return PTR_ERR(key);
> +	}
> +
> +	ukp = user_key_payload_locked(key);
> +	if (!ukp)
> +		return -EKEYREVOKED;
> +
> +	dm_crypt_key = kmalloc(ukp->datalen, GFP_KERNEL);
> +	if (!dm_crypt_key)
> +		return -ENOMEM;
> +	memcpy(dm_crypt_key, ukp->data, ukp->datalen);
> +	dm_crypt_key_size = ukp->datalen;
> +	pr_debug("dm crypt key (size=%u): %8ph\n", dm_crypt_key_size, dm_crypt_key);
> +	schedule_delayed_work(&wipe_dm_crypt_key_work,
> +			      round_jiffies_relative(wipe_key_delay * HZ));
> +	return 0;
> +}
> +
> +int crash_sysfs_dm_crypt_key_write(const char *key_desc, size_t count)
> +{
> +	if (!is_kdump_kernel())
> +		return crash_save_temp_dm_crypt_key(key_desc, count);
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL(crash_sysfs_dm_crypt_key_write);
> +
> +int crash_pass_temp_dm_crypt_key(void **addr, unsigned long *sz)
> +{
> +	unsigned long dm_crypt_key_sz;
> +	unsigned char *buf;
> +	unsigned int *size_ptr;
> +
> +	if (!dm_crypt_key)
> +		return -EINVAL;
> +
> +	dm_crypt_key_sz = sizeof(unsigned int) + dm_crypt_key_size * sizeof(u8);
> +
> +	buf = vzalloc(dm_crypt_key_sz);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	size_ptr = (unsigned int *)buf;
> +	memcpy(size_ptr, &dm_crypt_key_size, sizeof(unsigned int));
> +	memcpy(size_ptr + 1, dm_crypt_key, dm_crypt_key_size * sizeof(u8));
> +	*addr = buf;
> +	*sz = dm_crypt_key_sz;
> +	wipe_dm_crypt_key();
> +	return 0;
> +}
> +
> +int crash_load_dm_crypt_key(struct kimage *image)
> +{
> +	int ret;
> +	struct kexec_buf kbuf = {
> +		.image = image,
> +		.buf_min = 0,
> +		.buf_max = ULONG_MAX,
> +		.top_down = false,
> +		.random = true,
> +	};
> +
> +	image->dm_crypt_key_addr = 0;
> +	ret = crash_pass_temp_dm_crypt_key(&kbuf.buffer, &kbuf.bufsz);
> +	if (ret)
> +		return ret;
> +
> +	kbuf.memsz = kbuf.bufsz;
> +	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
> +	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
> +	ret = kexec_add_buffer(&kbuf);
> +	if (ret) {
> +		vfree((void *)kbuf.buffer);
> +		return ret;
> +	}
> +	image->dm_crypt_key_addr = kbuf.mem;
> +	image->dm_crypt_key_sz = kbuf.bufsz;
> +	pr_debug("Loaded dm crypt key at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
> +		 image->dm_crypt_key_addr, kbuf.bufsz, kbuf.bufsz);
> +
> +	return ret;
> +}
> diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
> index 1d4bc493b2f4..f3bb6bc6a604 100644
> --- a/kernel/ksysfs.c
> +++ b/kernel/ksysfs.c
> @@ -165,16 +165,34 @@ static ssize_t vmcoreinfo_show(struct kobject *kobj,
>   }
>   KERNEL_ATTR_RO(vmcoreinfo);
>   
> +static ssize_t crash_dm_crypt_key_show(struct kobject *kobj,
> +					  struct kobj_attribute *attr,
> +					  char *buf)
> +{
> +	return 0;
> +}
> +
> +static ssize_t crash_dm_crypt_key_store(struct kobject *kobj,
> +					struct kobj_attribute *attr,
> +					   const char *buf, size_t count)
> +{
> +	int ret;
> +
> +	ret = crash_sysfs_dm_crypt_key_write(buf, count);
> +	return ret < 0 ? ret : count;
> +}
> +KERNEL_ATTR_RW(crash_dm_crypt_key);
> +
>   #ifdef CONFIG_CRASH_HOTPLUG
>   static ssize_t crash_elfcorehdr_size_show(struct kobject *kobj,
> -			       struct kobj_attribute *attr, char *buf)
> +					  struct kobj_attribute *attr,
> +					  char *buf)
>   {
>   	unsigned int sz = crash_get_elfcorehdr_size();
>   
>   	return sysfs_emit(buf, "%u\n", sz);
>   }
>   KERNEL_ATTR_RO(crash_elfcorehdr_size);
> -
>   #endif
>   
>   #endif /* CONFIG_CRASH_CORE */
> @@ -267,6 +285,7 @@ static struct attribute * kernel_attrs[] = {
>   #endif
>   #ifdef CONFIG_CRASH_CORE
>   	&vmcoreinfo_attr.attr,
> +	&crash_dm_crypt_key_attr.attr,
>   #ifdef CONFIG_CRASH_HOTPLUG
>   	&crash_elfcorehdr_size_attr.attr,
>   #endif


