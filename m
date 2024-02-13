Return-Path: <linux-kernel+bounces-63478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF02185302D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46534B22374
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B05B39FF0;
	Tue, 13 Feb 2024 12:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Jwjrf5w7"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72A138FA9
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707825930; cv=none; b=VsMgTxvhKLGkZPSfLyI/waf5RhNO6cyntxuDZOum19xNx5CTgHk7uRBmhUDJ6zSXceE4Prn8jfMnKEWU/lM+WAzTtJylRwUkJ7eFpdgQhzyesAqH9G/BhdILAbmahVepcVj5t4kyNZYS4kAl3QZgFUnAFK9O8suJaxAKK0tjTKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707825930; c=relaxed/simple;
	bh=5v1WAw4N9I2O1AJTMU2SyjKe1FNgcuDPBUAnq4DSnpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Z0Ha8TUE+eOFKTpGCmldvDcQHc1W43bsxA+cK2wapfUYzuQnFgOM1OO+uCiFNacta/1hOvP3jm1e0N9RfXAan6dVgk6z0hQmK3zHbtczVHlwY/oJpIMt/yi7yfocYJWSuBI19tUHaEcDHi0RxAQEUh2fQ7oOJ5zxom/unvJaRmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Jwjrf5w7; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240213120519euoutp013d9ee5ebc5ea458df402b32f1d59971b~zaqAFTZYz1271812718euoutp01m
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 12:05:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240213120519euoutp013d9ee5ebc5ea458df402b32f1d59971b~zaqAFTZYz1271812718euoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707825919;
	bh=Qw01oiWIyOIq0Jif/GtsznhMJJDmHBMSpaam2oHZT9Q=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Jwjrf5w7oDb9vYeTeBjlBWHqpneaAKqKH7GSD6WeBAnMW6msmXBgPUQtsud3caUlV
	 WAvRpvYOXaWR/HqXsAbd6WdYjFlq0zmDn4m/jz3209HeQC03XFsosEmiFkrEvq4Ufy
	 O+MxpbztyQTJKW89RvAKYcW1Jbhdddxrtr15Kwac=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240213120518eucas1p2c2f5c5acd095c58cf0c882a219f7f68a~zap-qHhWk1269712697eucas1p2L;
	Tue, 13 Feb 2024 12:05:18 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 02.1C.09814.EFA5BC56; Tue, 13
	Feb 2024 12:05:18 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240213120518eucas1p2d514aac6e6d1e29bbae05f32db6724db~zap-KzXuk1268512685eucas1p2j;
	Tue, 13 Feb 2024 12:05:18 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240213120518eusmtrp2be6c0635eacf0a1c212a45570d62a807~zap-KEukn0447204472eusmtrp24;
	Tue, 13 Feb 2024 12:05:18 +0000 (GMT)
X-AuditID: cbfec7f4-727ff70000002656-47-65cb5afe6594
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id CE.D2.10702.EFA5BC56; Tue, 13
	Feb 2024 12:05:18 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240213120517eusmtip16bde613c4d66effc88b08c5781a22c99~zap_jCrOn1759417594eusmtip1H;
	Tue, 13 Feb 2024 12:05:17 +0000 (GMT)
Message-ID: <a8dddd27-f361-4e0d-be6f-7d6684007acd@samsung.com>
Date: Tue, 13 Feb 2024 13:05:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/24] gpio: rework locking and object life-time
 control
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij
	<linus.walleij@linaro.org>, Kent Gibson <warthog618@gmail.com>, Alex Elder
	<elder@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, "Paul E .
 McKenney" <paulmck@kernel.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz
	Golaszewski <bartosz.golaszewski@linaro.org>
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20240208095920.8035-1-brgl@bgdev.pl>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAKsWRmVeSWpSXmKPExsWy7djP87r/ok6nGkzfrm7R2zSdyWLFtzVM
	FrsebGOzONZwj9li7uxJjBZT/ixnstg8/w+jxeVdc9gsPi35xmKxsWUro8XKE7OYHbg9Fl+7
	zeox8ayux85Zd9k9Nq3qZPO4c20Pm8e8k4EeJ089YfH4vEkugCOKyyYlNSezLLVI3y6BK2PR
	JLaCj12MFRsOdbE1MDaWdTFyckgImEjsnbCMqYuRi0NIYAWjxKV775ghnC+MEjO2PYbKfGaU
	WHj2OVCGA6xlfoccRHw5o8S+xstsEM5HRol5HVuYQebyCthJHPrezQ5iswioStxtgbB5BQQl
	Ts58wgJiiwrIS9y/NQMsLiwQKHFv5iMmEJtZQFzi1pP5YJtFBE4zSZy/PI0ZIlEi8f3/NkYQ
	m03AUKLrbRcbiM0pYCRxd+dKRogaeYnmrbPBfpAQ6OeUuHZyISPEpy4S56YthrKFJV4d38IO
	YctI/N8JsU1CoJ1RYsHv+1DOBEaJhue3oDqsJe6c+8UGCgBmAU2J9bv0IcKOEpuWtbBCwoVP
	4sZbQYgj+CQmbZsODS5eiY42IYhqNYlZx9fBrT144RLzBEalWUjhMgvJ/7OQvDMLYe8CRpZV
	jOKppcW56anFRnmp5XrFibnFpXnpesn5uZsYgYns9L/jX3YwLn/1Ue8QIxMH4yFGCQ5mJRHe
	SzNOpArxpiRWVqUW5ccXleakFh9ilOZgURLnVU2RTxUSSE8sSc1OTS1ILYLJMnFwSjUwJSV5
	s+3c6vA95wzDgQUrGhJfzN7P9+vfdEWLnSmnHz6pv/vl4JmylnMZfJ8DJV0K//MuuuzCEvBz
	6vGj0ZO2O99Z1ZL42VW5Z9VtgZz/U9peBr0IvBNgb9vxZH/tx3ZrHefteiXBEsoxwpzf9olY
	PfKqXGTC2zXncWLwGf8CP6/Qnn1CFit/sR2+f/6bPfNl6bmMDI+eKjAsrp6oISB8ZFrXdfaj
	zz5sUJ/ydFqdUX5O8OlgPcmETQ9eudYIuoXfvbBmj/j2NZzeCzkWStjMeyQQOuG27B8t6/fn
	K3ue5jPPudrZM7WpRYy588cBp11tpf/CP5Vu+dXGPcFT9E/LqQXHL8Sm3Fi23Yvh9nFZbiWW
	4oxEQy3mouJEAJP/m3HTAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsVy+t/xu7r/ok6nGix7xmnR2zSdyWLFtzVM
	FrsebGOzONZwj9li7uxJjBZT/ixnstg8/w+jxeVdc9gsPi35xmKxsWUro8XKE7OYHbg9Fl+7
	zeox8ayux85Zd9k9Nq3qZPO4c20Pm8e8k4EeJ089YfH4vEkugCNKz6Yov7QkVSEjv7jEVina
	0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL2PRJLaCj12MFRsOdbE1MDaWdTFy
	cEgImEjM75DrYuTiEBJYyihx9NEXli5GTqC4jMTJaQ2sELawxJ9rXWwQRe8ZJS79XM4IkuAV
	sJM49L2bHcRmEVCVuNsCYfMKCEqcnPkEbJCogLzE/VszwOLCAoES92Y+YgKxmQXEJW49mc8E
	MlRE4DyTxL0L86ESJRKTHv5nA7GFBAwlju8+BnYFG5Dd9bYLLM4pYCRxd+dKRoh6M4murV1Q
	trxE89bZzBMYhWYhuWMWkn2zkLTMQtKygJFlFaNIamlxbnpusZFecWJucWleul5yfu4mRmDc
	bjv2c8sOxpWvPuodYmTiYDzEKMHBrCTCe2nGiVQh3pTEyqrUovz4otKc1OJDjKbAwJjILCWa
	nA9MHHkl8YZmBqaGJmaWBqaWZsZK4ryeBR2JQgLpiSWp2ampBalFMH1MHJxSDUwLGH757j/h
	8/JPkNyNmLLrgX+8WFkvuoVozalZ+P/21p3xcWbJd332xvxaMVv1X89d6/KQd+b7b0c5TpdR
	ZLy5Q+5jSdafArtrmZkMrc2JdyO2sp3+f7vO6b9H0Y0rB5ayu7+ZbHFWmiH/kMe1wq4uX4e+
	LZ0+E3/8X7kvesWq7cdX7Fx9JMlRSOSrYffBG/ncS7o5v6scYHT8rOAxOVf0oEjy1rebFqu8
	a/q1NMEx2W7t6t9HPB1mr1Je+uRCMGuhjVxDwfSvObWrfQNl526IU7ssZTmlqmX+3Qkytsk/
	Dymd0zJsFjjZ9uynMa+4e288yzrXZMGSw5zKbozWB4oLNr+/svRKr/EMI/3QnLlKLMUZiYZa
	zEXFiQC8wuwGZAMAAA==
X-CMS-MailID: 20240213120518eucas1p2d514aac6e6d1e29bbae05f32db6724db
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240213120518eucas1p2d514aac6e6d1e29bbae05f32db6724db
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240213120518eucas1p2d514aac6e6d1e29bbae05f32db6724db
References: <20240208095920.8035-1-brgl@bgdev.pl>
	<CGME20240213120518eucas1p2d514aac6e6d1e29bbae05f32db6724db@eucas1p2.samsung.com>

On 08.02.2024 10:58, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> This is a big rework of locking in GPIOLIB. The current serialization is
> pretty much useless. There is one big spinlock (gpio_lock) that "protects"
> both the GPIO device list, GPIO descriptor access and who knows what else.
>
> I'm putting "protects" in quotes as in several places the lock is
> taken, released whenever a sleeping function is called and re-taken
> without regards for the "protected" state that may have changed.
>
> First a little background on what we're dealing with in GPIOLIB. We have
> consumer API functions that can be called from any context explicitly
> (get/set value, set direction) as well as many others which will get
> called in atomic context implicitly (e.g. set config called in certain
> situations from gpiod_direction_output()).
>
> On the other side: we have GPIO provider drivers whose callbacks may or
> may not sleep depending on the underlying protocol.
>
> This makes any attempts at serialization quite complex. We typically
> cannot use sleeping locks - we may be called from atomic - but we also
> often cannot use spinlocks - provider callbacks may sleep. Moreover: we
> have close ties with the interrupt and pinctrl subsystems, often either
> calling into them or getting called from them. They use their own locking
> schemes which are at odds with ours (pinctrl uses mutexes, the interrupt
> subsystem can call GPIO helpers with spinlock taken).
>
> There is also another significant issue: the GPIO device object contains
> a pointer to gpio_chip which is the implementation of the GPIO provider.
> This object can be removed at any point - as GPIOLIB officially supports
> hotplugging with all the dynamic expanders that we provide drivers for -
> and leave the GPIO API callbacks with a suddenly NULL pointer. This is
> a problem that allowed user-space processes to easily crash the kernel
> until we patched it with a read-write semaphore in the user-space facing
> code (but the problem still exists for in-kernel users). This was
> recognized before as evidenced by the implementation of validate_desc()
> but without proper serialization, simple checking for a NULL pointer is
> pointless and we do need a generic solution for that issue as well.
>
> If we want to get it right - the more lockless we go, the better. This is
> why SRCU seems to be the right candidate for the mechanism to use. In fact
> it's the only mechanism we can use our read-only critical sections to be
> called from atomic and protecc contexts as well as call driver callbacks
> that may sleep (for the latter case).
>
> We're going to use it in three places: to protect the global list of GPIO
> devices, to ensure consistency when dereferencing the chip pointer in GPIO
> device struct and finally to ensure that users can access GPIO descriptors
> and always see a consistent state.
>
> We do NOT serialize all API callbacks. This means that provider callbacks
> may be called simultaneously and GPIO drivers need to provide their own
> locking if needed. This is on purpose. First: we only support exclusive
> GPIO usage* so there's no risk of two drivers getting in each other's way
> over the same GPIO. Second: with this series, we ensure enough consistency
> to limit the chance of drivers or user-space users crashing the kernel.
> With additional improvements in handling the flags field in GPIO
> descriptors there's very little to gain, while bitbanging drivers may care
> about the increased performance of going lockless.
>
> This series brings in one somewhat significant functional change for
> in-kernel users, namely: GPIO API calls, for which the underlying GPIO
> chip is gone, will no longer return 0 and emit a log message but instead
> will return -ENODEV.
>
> I know this is a lot of code to go through but the more eyes we get on it
> the better.

I've noticed that this patchset landed in today's linux-next. It causes 
a lots of warning during boot on my test boards when LOCKDEP is enabled 
in kernel configs. Do you want me to report all of them? Some can be 
easily reproduced even with QEMU's virt ARM and ARM64 machines.

Here are some examples captured on ARM 32bit Exynos4412-based OdroidU3 
board:

=============================
WARNING: suspicious RCU usage
6.8.0-rc4-next-20240213 #8017 Not tainted
-----------------------------
drivers/gpio/gpiolib-cdev.c:2799 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
2 locks held by swapper/0/1:
  #0: c1f9608c (&dev->mutex){....}-{3:3}, at: __device_attach+0x2c/0x1fc
  #1: c1f973c0 (&gdev->srcu){.+.+}-{0:0}, at: 
gpiolib_cdev_register+0x5c/0x1c4

stack backtrace:
CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc4-next-20240213 #8017
Hardware name: Samsung Exynos (Flattened Device Tree)
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x68/0x88
  dump_stack_lvl from lockdep_rcu_suspicious+0x150/0x1c0
  lockdep_rcu_suspicious from gpiolib_cdev_register+0x180/0x1c4
  gpiolib_cdev_register from gpiochip_setup_dev+0x44/0xb0
  gpiochip_setup_dev from gpiochip_add_data_with_key+0x9b4/0xab8
  gpiochip_add_data_with_key from devm_gpiochip_add_data_with_key+0x20/0x5c
  devm_gpiochip_add_data_with_key from samsung_pinctrl_probe+0x938/0xb18
  samsung_pinctrl_probe from platform_probe+0x5c/0xb8
  platform_probe from really_probe+0xe0/0x400
  really_probe from __driver_probe_device+0x9c/0x1f4
  __driver_probe_device from driver_probe_device+0x30/0xc0
  driver_probe_device from __device_attach_driver+0xa8/0x120
  __device_attach_driver from bus_for_each_drv+0x80/0xcc
  bus_for_each_drv from __device_attach+0xac/0x1fc
  __device_attach from bus_probe_device+0x8c/0x90
  bus_probe_device from device_add+0x5d4/0x7fc
  device_add from of_platform_device_create_pdata+0x94/0xc4
  of_platform_device_create_pdata from of_platform_bus_create+0x1f8/0x4c0
  of_platform_bus_create from of_platform_bus_create+0x268/0x4c0
  of_platform_bus_create from of_platform_populate+0x80/0x110
  of_platform_populate from of_platform_default_populate_init+0xd4/0xec
  of_platform_default_populate_init from do_one_initcall+0x64/0x2fc
  do_one_initcall from kernel_init_freeable+0x1c4/0x228
  kernel_init_freeable from kernel_init+0x1c/0x12c
  kernel_init from ret_from_fork+0x14/0x28
Exception stack(0xf0845fb0 to 0xf0845ff8)
..

=============================
WARNING: suspicious RCU usage
iommu: Default domain type: Translated
6.8.0-rc4-next-20240213 #8017 Not tainted
iommu: DMA domain TLB invalidation policy: strict mode
-----------------------------
drivers/gpio/gpiolib.c:1193 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
6 locks held by kworker/u16:1/36:
  #0: c1ced8b4 ((wq_completion)async){+.+.}-{0:0}, at: 
process_one_work+0x14c/0x690
  #1: f0905f20 ((work_completion)(&entry->work)){+.+.}-{0:0}, at: 
process_one_work+0x14c/0x690
  #2: c24e488c (&dev->mutex){....}-{3:3}, at: 
__driver_attach_async_helper+0x38/0xec
  #3: c13f4c5c (gpio_devices_srcu){.+.+}-{0:0}, at: 
gpiod_find_and_request+0x0/0x578
  #4: c13f4c5c (gpio_devices_srcu){.+.+}-{0:0}, at: 
gpio_device_find+0x0/0x2d8
  #5: c1f973c0 (&gdev->srcu){.+.+}-{0:0}, at: gpio_device_find+0xf0/0x2d8

stack backtrace:
CPU: 0 PID: 36 Comm: kworker/u16:1 Not tainted 6.8.0-rc4-next-20240213 #8017
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: async async_run_entry_fn
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x68/0x88
  dump_stack_lvl from lockdep_rcu_suspicious+0x150/0x1c0
  lockdep_rcu_suspicious from gpio_device_find+0x190/0x2d8
  gpio_device_find from of_get_named_gpiod_flags+0xa4/0x318
  of_get_named_gpiod_flags from of_find_gpio+0x80/0x168
  of_find_gpio from gpiod_find_and_request+0x15c/0x578
  gpiod_find_and_request from gpiod_get_optional+0x54/0x90
  gpiod_get_optional from reg_fixed_voltage_probe+0x200/0x400
  reg_fixed_voltage_probe from platform_probe+0x5c/0xb8
  platform_probe from really_probe+0xe0/0x400
  really_probe from __driver_probe_device+0x9c/0x1f4
  __driver_probe_device from driver_probe_device+0x30/0xc0
  driver_probe_device from __driver_attach_async_helper+0x54/0xec
  __driver_attach_async_helper from async_run_entry_fn+0x40/0x154
  async_run_entry_fn from process_one_work+0x224/0x690
  process_one_work from worker_thread+0x1a0/0x3f4
  worker_thread from kthread+0x104/0x138
  kthread from ret_from_fork+0x14/0x28
Exception stack(0xf0905fb0 to 0xf0905ff8)
..

=============================
WARNING: suspicious RCU usage
6.8.0-rc4-next-20240213 #8017 Not tainted
-----------------------------
drivers/gpio/gpiolib.c:112 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
2 locks held by swapper/0/1:
  #0: c24e548c (&dev->mutex){....}-{3:3}, at: __driver_attach+0x118/0x1d4
  #1: c1db1118 (&desc->srcu){.+.+}-{0:0}, at: 
gpiod_configure_flags+0x188/0x460

stack backtrace:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc4-next-20240213 #8017
Hardware name: Samsung Exynos (Flattened Device Tree)
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x68/0x88
  dump_stack_lvl from lockdep_rcu_suspicious+0x150/0x1c0
  lockdep_rcu_suspicious from gpiod_get_label+0xc4/0xcc
  gpiod_get_label from gpiod_configure_flags+0x214/0x460
  gpiod_configure_flags from gpiod_find_and_request+0x214/0x578
  gpiod_find_and_request from fwnode_gpiod_get_index+0x34/0x3c
  fwnode_gpiod_get_index from devm_fwnode_gpiod_get_index+0x60/0x9c
  devm_fwnode_gpiod_get_index from gpio_led_probe+0x300/0x3c0
  gpio_led_probe from platform_probe+0x5c/0xb8
  platform_probe from really_probe+0xe0/0x400
  really_probe from __driver_probe_device+0x9c/0x1f4
  __driver_probe_device from driver_probe_device+0x30/0xc0
  driver_probe_device from __driver_attach+0x124/0x1d4
  __driver_attach from bus_for_each_dev+0x6c/0xb4
  bus_for_each_dev from bus_add_driver+0xe0/0x200
  bus_add_driver from driver_register+0x7c/0x118
  driver_register from do_one_initcall+0x64/0x2fc
  do_one_initcall from kernel_init_freeable+0x1c4/0x228
  kernel_init_freeable from kernel_init+0x1c/0x12c
  kernel_init from ret_from_fork+0x14/0x28
Exception stack(0xf0845fb0 to 0xf0845ff8)
..

=============================
WARNING: suspicious RCU usage
6.8.0-rc4-next-20240213 #8017 Not tainted
-----------------------------
drivers/gpio/gpiolib.c:3596 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
4 locks held by kworker/u16:1/36:
  #0: c1ced8b4 ((wq_completion)async){+.+.}-{0:0}, at: 
process_one_work+0x14c/0x690
  #1: f0905f20 ((work_completion)(&entry->work)){+.+.}-{0:0}, at: 
process_one_work+0x14c/0x690
  #2: c1d2708c (&dev->mutex){....}-{3:3}, at: 
__driver_attach_async_helper+0x38/0xec
  #3: c1fc9fc0 (&gdev->srcu){.+.?}-{0:0}, at: gpiod_to_irq+0x18/0x194

stack backtrace:
CPU: 1 PID: 36 Comm: kworker/u16:1 Not tainted 6.8.0-rc4-next-20240213 #8017
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: async async_run_entry_fn
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x68/0x88
  dump_stack_lvl from lockdep_rcu_suspicious+0x150/0x1c0
  lockdep_rcu_suspicious from gpiod_to_irq+0x144/0x194
  gpiod_to_irq from mmc_gpiod_request_cd_irq+0xb4/0xd0
  mmc_gpiod_request_cd_irq from mmc_start_host+0x48/0x9c
  mmc_start_host from mmc_add_host+0x7c/0xb0
  mmc_add_host from __sdhci_add_host+0x1b4/0x304
  __sdhci_add_host from sdhci_add_host+0x24/0x38
  sdhci_add_host from sdhci_s3c_probe+0x484/0x554
  sdhci_s3c_probe from platform_probe+0x5c/0xb8
  platform_probe from really_probe+0xe0/0x400
  really_probe from __driver_probe_device+0x9c/0x1f4
  __driver_probe_device from driver_probe_device+0x30/0xc0
  driver_probe_device from __driver_attach_async_helper+0x54/0xec
  __driver_attach_async_helper from async_run_entry_fn+0x40/0x154
  async_run_entry_fn from process_one_work+0x224/0x690
  process_one_work from worker_thread+0x1a0/0x3f4
  worker_thread from kthread+0x104/0x138
  kthread from ret_from_fork+0x14/0x28
Exception stack(0xf0905fb0 to 0xf0905ff8)
..

=============================
WARNING: suspicious RCU usage
6.8.0-rc4-next-20240213 #8017 Not tainted
-----------------------------
drivers/gpio/gpiolib.c:2981 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
3 locks held by kworker/1:0/22:
  #0: c1c06cb4 ((wq_completion)events_freezable){+.+.}-{0:0}, at: 
process_one_work+0x14c/0x690
  #1: f08cdf20 ((work_completion)(&(&host->detect)->work)){+.+.}-{0:0}, 
at: process_one_work+0x14c/0x690
  #2: c1fc9fc0 (&gdev->srcu){.+.?}-{0:0}, at: 
gpiod_get_raw_value_commit+0x0/0x1b4

stack backtrace:
CPU: 1 PID: 22 Comm: kworker/1:0 Not tainted 6.8.0-rc4-next-20240213 #8017
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: events_freezable mmc_rescan
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x68/0x88
  dump_stack_lvl from lockdep_rcu_suspicious+0x150/0x1c0
  lockdep_rcu_suspicious from gpiod_get_raw_value_commit+0x164/0x1b4
  gpiod_get_raw_value_commit from gpiod_get_value+0x2c/0x94
  gpiod_get_value from sdhci_get_cd+0xc/0x68
  sdhci_get_cd from mmc_rescan+0x124/0x3a8
  mmc_rescan from process_one_work+0x224/0x690
  process_one_work from worker_thread+0x1a0/0x3f4
  worker_thread from kthread+0x104/0x138
  kthread from ret_from_fork+0x14/0x28
Exception stack(0xf08cdfb0 to 0xf08cdff8)
..


> Thanks,
> Bartosz
>
> * - This is not technically true. We do provide the
> GPIOD_FLAGS_BIT_NONEXCLUSIVE flag. However this is just another piece of
> technical debt. This is a hack provided for a single use-case in the
> regulator framework which got out of control and is now used in many
> places that should have never touched it. It's utterly broken and doesn't
> even provide any contract as to what a "shared GPIO" is. I would argue
> that it's the next thing we should address by providing "reference counted
> GPIO enable", not just a flag allowing to request the same GPIO twice
> and then allow two drivers to fight over who toggles it as is the case
> now. For now, let's just treat users of GPIOD_FLAGS_BIT_NONEXCLUSIVE like
> they're consciously and deliberately choosing to risk undefined behavior.
>
> v2 -> v3:
> - fix SRCU cleanup in error path
> - add a comment explaining the use of gpio_device_find() in sysfs code
> - don't needlessly dereference gdev->chip in sysfs code
> - don't return 1 (INPUT) for NULL descriptors from gpiod_get_direction(),
>    rather: return -EINVAL
> - fix debugfs code: take the SRCU read lock in .start() and release it in
>    .stop() callbacks for seq file instead of taking it locally which
>    doesn't protect the entire seq printout
> - move the removal of the GPIO device from the list before setting the
>    chip pointer to NULL
>
> v1 -> v2:
> - fix jumping over variable initialization in sysfs code
> - fix RCU-related sparse warnings
> - fix a smatch complaint about uninitialized variables (even though it's
>    a false positive coming from the fact that scoped_guard() is implemented
>    as a for loop
> - fix a potential NULL-pointer dereference in debugfs callbacks
> - improve commit messages
>
> Bartosz Golaszewski (24):
>    gpio: protect the list of GPIO devices with SRCU
>    gpio: of: assign and read the hog pointer atomically
>    gpio: remove unused logging helpers
>    gpio: provide and use gpiod_get_label()
>    gpio: don't set label from irq helpers
>    gpio: add SRCU infrastructure to struct gpio_desc
>    gpio: protect the descriptor label with SRCU
>    gpio: sysfs: use gpio_device_find() to iterate over existing devices
>    gpio: remove gpio_lock
>    gpio: reinforce desc->flags handling
>    gpio: remove unneeded code from gpio_device_get_desc()
>    gpio: sysfs: extend the critical section for unregistering sysfs
>      devices
>    gpio: sysfs: pass the GPIO device - not chip - to sysfs callbacks
>    gpio: cdev: replace gpiochip_get_desc() with gpio_device_get_desc()
>    gpio: cdev: don't access gdev->chip if it's not needed
>    gpio: sysfs: don't access gdev->chip if it's not needed
>    gpio: don't dereference gdev->chip in gpiochip_setup_dev()
>    gpio: reduce the functionality of validate_desc()
>    gpio: remove unnecessary checks from gpiod_to_chip()
>    gpio: add the can_sleep flag to struct gpio_device
>    gpio: add SRCU infrastructure to struct gpio_device
>    gpio: protect the pointer to gpio_chip in gpio_device with SRCU
>    gpio: remove the RW semaphore from the GPIO device
>    gpio: mark unsafe gpio_chip manipulators as deprecated
>
>   drivers/gpio/gpiolib-cdev.c  |  92 ++--
>   drivers/gpio/gpiolib-of.c    |   4 +-
>   drivers/gpio/gpiolib-sysfs.c | 151 ++++---
>   drivers/gpio/gpiolib.c       | 791 +++++++++++++++++++----------------
>   drivers/gpio/gpiolib.h       |  86 ++--
>   5 files changed, 635 insertions(+), 489 deletions(-)
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


