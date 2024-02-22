Return-Path: <linux-kernel+bounces-77134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7962F86018B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0179FB284A1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06B96E60C;
	Thu, 22 Feb 2024 18:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvYZbw3G"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6C56E61F;
	Thu, 22 Feb 2024 18:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708626315; cv=none; b=FU/rdLq8YfBl2Y+gdHnvddeBetsnjuK1jdxgLD6l3is4BmApXwe669ke94jU6vLzAOnII9r8H9LP4+N2/Ac2tMb6LgXW1p6gKTHqcFOjrj0d/GfZoA4c3YO8AhQllaJlM5ZzE/YiTKjpqON2vdUV5z5/YybCZAzDLNe5T/Ie4ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708626315; c=relaxed/simple;
	bh=tnXCp6dt5rGPIUld0fVfghgRSYczkMNdQV5eOnHT1dQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qk1TjdKfztk47uy5TdLfh62youErup2qbyO5tI9xzdLQN4rkLUpi5yHs9kPx89ceR9+9esOjZQasG0cWRyCn86Ky0pEd5U3gDIHvRMv7zaxIYfUdfXUthI3V6zTC0b14dE/4C+jyk6g/V+A3QKQ2ysydfgHlLjJvYFRQjmhYKgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RvYZbw3G; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d51ba18e1bso902415ad.0;
        Thu, 22 Feb 2024 10:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708626308; x=1709231108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bj3IcFn8mnJgzD3CoUY6c78LqZOUjuMORbYEATmxZBU=;
        b=RvYZbw3G35YJQwweCJRij2O1DvSIc40sRXDw3lKgNdfGtoosjfh32WB9pTRweTrRKG
         r1wZsA+PtHPoBlMVVXrq+7ke2iBGn5cSZFvkIVPRqXKbf9x4OQJHDcYnx0TaAaJVidkh
         nebW+49LaO4i+Lc9l6Sre86PmozTX+nSDwMb7gfExKiYSVDkpzeo5GeQFGAcWRygUN4t
         q2yi6QUbNDuMJtOXJgPCzfr6hWQPDgqVI9O0Oa675dJZ1VTIOHLFyfOBlimkRzcmX/8l
         G4TksyOX5VFTHZIX1UTc9b91hTHsdZwqVuYAiml+TmSRO8CZXyoBtjLEUSF0M+Jp+a+z
         kkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708626308; x=1709231108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bj3IcFn8mnJgzD3CoUY6c78LqZOUjuMORbYEATmxZBU=;
        b=jbKd09ZydECxSLRsFF+3ButsRErEwim7FPZWRVjPrWBqllFGg6yA6U8KGKxwlOXsL9
         EK1iMlHexv+wlHljdhYxMaKQw8SUysPFcJHNbg9+iRrz7UZZC2PVvHJpC3vRxid2HyxV
         VLcuaSaraiGq5WWplbWvEZ18edA0DB65KTHqDjnB5FLsMNAzoQ7+5yDx2wC50SZm712n
         yMAjxAzBOsTaCIUFKGt4OXbZ+WGugAyZO11YW0o1H3dG2ovEw8rFRWP4YoepXxAL1oLw
         B8C67kGryS2GAP/zxmlotPBwiEZlM133K0CO8N0V3s6ERkC2rQhQTng1sHYDxlTIfh5E
         Lijw==
X-Forwarded-Encrypted: i=1; AJvYcCXajfcHnJleyifzC4oQVBLTuo3l2yLzJSNs4jpHv0LyWjy0F3hhjbwv0mMYawW9/tfSWcgl8m2c0gAGUJvAT1U0qdPk6ppZhvx2p37TO5bdH6A6YE3tqvqOdEx9NANfgFoZZTzfNwyuW7M=
X-Gm-Message-State: AOJu0YymdV/6tVzEvp9UYqd1hyAXD2uYDZt8WOafpbo9D/iLznT5cWu5
	znsexzInStOqRfedHfJAlT7JCL4sceNGboA3fu+NSL3Fhcv1wq8n
X-Google-Smtp-Source: AGHT+IHcoigpFbKIQ5fbALcZQ6Rz++MRYgKPcOOAhRgDC8V+XygUKmSTJuBfrizzNDsVEvMULKcBiQ==
X-Received: by 2002:a17:902:e545:b0:1db:ed54:a726 with SMTP id n5-20020a170902e54500b001dbed54a726mr15517677plf.63.1708626308374;
        Thu, 22 Feb 2024 10:25:08 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id mi11-20020a170902fccb00b001da34166cd2sm10255199plb.180.2024.02.22.10.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 10:25:07 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 22 Feb 2024 10:25:06 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Marco Pagani <marpagan@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian Koenig <christian.koenig@amd.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v5] drm/test: add a test suite for GEM objects backed by
 shmem
Message-ID: <e38512f3-626f-42ae-bb3b-3f631dfaed9c@roeck-us.net>
References: <20231130171417.74162-1-marpagan@redhat.com>
 <a45b796d-5e04-4eac-b5ba-ea6bb3b6131b@roeck-us.net>
 <045bfb84-9833-442c-ac54-ed7a26451afa@redhat.com>
 <fb2ac929-6650-444e-8f24-c9b1562d2bb3@roeck-us.net>
 <ad03c582-28b9-40b2-9c7b-8372ed5a05c2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad03c582-28b9-40b2-9c7b-8372ed5a05c2@redhat.com>

On Thu, Feb 22, 2024 at 05:33:48PM +0100, Marco Pagani wrote:
> > 
> > In this context, the TTM unit tests fail as well in qemu, with worse result:
> > It seems there is some bad cleanup after a failed test case, causing list
> > corruptions in the drm core and ultimately a crash. I don't know if this
> > is also caused by the missing dma_mask initialization.
> > 
> 
> That's interesting. Which --arch argument are you using to run the
> tests with QEMU?

Example (I am not sure if any of those parameters matters; it is just one
of my tests):

qemu-system-x86_64 -kernel arch/x86/boot/bzImage -M q35 -cpu IvyBridge \
	-no-reboot -snapshot -smp 2 \
	-device e1000,netdev=net0 -netdev user,id=net0 -m 512 \
	-drive file=rootfs.ext2,format=raw,if=ide \
	--append "earlycon=uart8250,io,0x3f8,9600n8 root=/dev/sda1 console=ttyS0" \
	-d unimp,guest_errors -nographic -monitor none

This results in:

[ ... ]
[    5.989496]     KTAP version 1
[    5.989639]     # Subtest: ttm_device
[    5.989711]     # module: ttm_device_test
[    5.989760]     1..5
[    6.002044]     ok 1 ttm_device_init_basic
[    6.013557]     ok 2 ttm_device_init_multiple
ILLOPC: ffffffffb8ac9350: 0f 0b
[    6.022481]     ok 3 ttm_device_fini_basic
[    6.026172] ------------[ cut here ]------------
[    6.026315] WARNING: CPU: 1 PID: 1575 at drivers/gpu/drm/ttm/ttm_device.c:206 ttm_device_init+0x170/0x190
..
[    6.135016]         ok 3 Above the allocation limit
[    6.138759] ------------[ cut here ]------------
[    6.138925] WARNING: CPU: 1 PID: 1595 at kernel/dma/mapping.c:503 dma_alloc_attrs+0xf6/0x100
..
[    6.143850]     # ttm_pool_alloc_basic: ASSERTION FAILED at drivers/gpu/drm/ttm/tests/ttm_pool_test.c:162
[    6.143850]     Expected err == 0, but
[    6.143850]         err == -12 (0xfffffffffffffff4)
[    6.148824]         not ok 4 One page, with coherent DMA mappings enabled

From there things go downhill.

[    6.152821] list_add corruption. prev->next should be next (ffffffffbbd53950), but was 0000000000000000. (prev=ffff8af1c38f9e20).

and so on until the emulation crashes.

Guenter

