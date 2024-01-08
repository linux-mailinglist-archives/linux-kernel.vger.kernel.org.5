Return-Path: <linux-kernel+bounces-19595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1901E826F5C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2BB5283D32
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7D34174B;
	Mon,  8 Jan 2024 13:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ABRGqq0B"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF261427A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 13:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240108130316euoutp013001f1f949623954f9baab77de0ab6dd~oYOUygV531590115901euoutp01f
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 13:03:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240108130316euoutp013001f1f949623954f9baab77de0ab6dd~oYOUygV531590115901euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1704718996;
	bh=eXxygB5VtinReaPJyzoDX8KSOlubAkZdY8fkZSHh7G4=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=ABRGqq0Bln+9rRp5g8UyaYrm2sPPj+xhxisWYEvD0RYqCwW5pgmHF81Smhfw2BNOk
	 o+c6ljyS14jgqK0hsLh5p1sZ8c0MQOAsJ4psXU2j3UbKRqioopUVGF062a75tkPL3i
	 c1EgOgQFj4+h/qPZFddotWl7F1nWjHV0917LSreI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240108130316eucas1p1460f768b858e064c887d5849f456fa6a~oYOUsWbjp1863118631eucas1p1I;
	Mon,  8 Jan 2024 13:03:16 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 0D.BA.09814.492FB956; Mon,  8
	Jan 2024 13:03:16 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240108130315eucas1p1ecb6dbf60f9b796c3c678c889371a747~oYOUTAFo90118801188eucas1p1J;
	Mon,  8 Jan 2024 13:03:15 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240108130315eusmtrp23e475d76d87d117afdc27144d9c1c368~oYOUSd2x31328213282eusmtrp2g;
	Mon,  8 Jan 2024 13:03:15 +0000 (GMT)
X-AuditID: cbfec7f4-727ff70000002656-36-659bf29439a8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id BB.19.10702.392FB956; Mon,  8
	Jan 2024 13:03:15 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240108130315eusmtip291024e888628b6dea488a23f7a8202fe~oYOTqqipy0764607646eusmtip2Z;
	Mon,  8 Jan 2024 13:03:15 +0000 (GMT)
Message-ID: <32c76177-83c1-48c5-8198-b7347b83d5db@samsung.com>
Date: Mon, 8 Jan 2024 14:03:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] gpiolib: pin GPIO devices in place during
 descriptor lookup
To: Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij
	<linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz
	Golaszewski <bartosz.golaszewski@linaro.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20240102155949.73434-4-brgl@bgdev.pl>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42LZduzned0pn2anGjRPErRY8W0Nk8WuB9vY
	LKb8Wc5ksXn+H0aLy7vmsDmweiy+dpvV4861PWwenzfJBTBHcdmkpOZklqUW6dslcGXcvHmN
	teCydsWSly9YGhh7VLoYOTkkBEwkTjSuZuxi5OIQEljBKHF03kMWCOcLo8TtidOZIJzPjBK/
	Lrxhhmk52/Ifqmo5o8TGI19YIZyPjBL9DYvYQap4BewkDu3oZQKxWQRUJHbcvcUGEReUODnz
	CQuILSogL3H/1gywemGBSImOg0vA6kUEgiW+PL0BVs8sUCLx/f82RghbXOLWk/lgNWwChhJd
	b7vAajgFjCXm9B5gh6iRl2jeOpsZ5CAJgQMcEkeOfWGBONtFYvvNbewQtrDEq+NboGwZif87
	5zNBNLQzSiz4fR/KmcAo0fD8FiNElbXEnXO/gNZxAK3QlFi/Sx8i7ChxZ/JLFpCwhACfxI23
	ghBH8ElM2jadGSLMK9HRJgRRrSYx6/g6uLUHL1xinsCoNAspWGYheXMWkndmIexdwMiyilE8
	tbQ4Nz212CgvtVyvODG3uDQvXS85P3cTIzC9nP53/MsOxuWvPuodYmTiYDzEKMHBrCTCKzlj
	dqoQb0piZVVqUX58UWlOavEhRmkOFiVxXtUU+VQhgfTEktTs1NSC1CKYLBMHp1QD08rHDS2y
	+3s41u1fIcCjqTvbM7LHUuKJ7xcte+GQJdyzOht7E/5JttVGfPG7KfA13KaS13V+1Vt1vb7i
	iyfXvlpszVK1a5Ihw19TBX/GzxVHHrC8WPr0Hu+HmXU1J1e2zPp+9ZXt36L4uABvxUeb417r
	v5sqtrxX1ecm97S8c2VJHzsreYq4LR+z/zjj/0m//o7es41xN9yLX7EtfThb+ebmH7473nBv
	2ccrdXPZNkVFp/XXpzj8ma8WnPFHvY73yYXoL6zlgRJbZkms6d5vllLeU5yQqNF2cLlZ+30V
	/5/Bu/elMP9LWM38ObMojzHjZ/3KtGgnlhvmN54GKxXbvJSsTVvS+KWQ4UfW1ElTlFiKMxIN
	tZiLihMBmVUNgJ4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsVy+t/xe7qTP81ONZjQbWCx4tsaJotdD7ax
	WUz5s5zJYvP8P4wWl3fNYXNg9Vh87Tarx51re9g8Pm+SC2CO0rMpyi8tSVXIyC8usVWKNrQw
	0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mu4efMaa8Fl7YolL1+wNDD2qHQxcnJI
	CJhInG35z9LFyMUhJLCUUaKl+RgbREJG4uS0BlYIW1jiz7UuNoii94wSfTv2MIIkeAXsJA7t
	6GUCsVkEVCR23L3FBhEXlDg58wkLiC0qIC9x/9YMdhBbWCBSouPgErB6EYFgiUV3O8HmMAuU
	SEx6+B+sV0ggWqJ/2UZ2iLi4xK0n88Hq2QQMJbredoHVcAoYS8zpPQBVYybRtbULao68RPPW
	2cwTGIVmITljFpJRs5C0zELSsoCRZRWjSGppcW56brGRXnFibnFpXrpecn7uJkZgNG079nPL
	DsaVrz7qHWJk4mA8xCjBwawkwis5Y3aqEG9KYmVValF+fFFpTmrxIUZTYFhMZJYSTc4HxnNe
	SbyhmYGpoYmZpYGppZmxkjivZ0FHopBAemJJanZqakFqEUwfEwenVAOTdhx7ndAN38hgU2dZ
	0bM/Eg+9XVuQOUOHke99zNug1RyPNZ8ZurddEL9ZmfL559Ov5xbNdMhfkOkc9OvPo7WsStWz
	5/MJvXUUnhY6y1Jk8oI7y6eee/X2gGdUlv8Z/kmXLgVNLr4deP/g+oPlp4/8vvuwYMtN+dmb
	zul+upVf8FXh9Yftm1K6cpR+7dq455mVZZJLg8zqZRE3NGqnb7ls5XP9manWLcvTW/l/fmx4
	Pm/dl/uCbOvu6lUYWRpPNf2z//SzwoXHucUK9gr7Sq/earLvuuk6cwFG7jVffi6pb9sV4DZ5
	WtKU3LxPeV9z1/TKpXFvU4+UYSo7GLMu9sGTk491V2ilWX1PdU87GZdbPleJpTgj0VCLuag4
	EQDWnmO4LwMAAA==
X-CMS-MailID: 20240108130315eucas1p1ecb6dbf60f9b796c3c678c889371a747
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240108130315eucas1p1ecb6dbf60f9b796c3c678c889371a747
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240108130315eucas1p1ecb6dbf60f9b796c3c678c889371a747
References: <20240102155949.73434-1-brgl@bgdev.pl>
	<20240102155949.73434-4-brgl@bgdev.pl>
	<CGME20240108130315eucas1p1ecb6dbf60f9b796c3c678c889371a747@eucas1p1.samsung.com>

On 02.01.2024 16:59, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> There's time between when we locate the relevant descriptor during
> lookup and when we actually take the reference to its parent GPIO
> device where - if the GPIO device in question is removed - we'll end up
> with a dangling pointer to freed memory. Make sure devices cannot be
> removed until we hold a new reference to the device.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This patch landed in linux-next as commit db660b9a9f86 ("gpiolib: pin 
GPIO devices in place during descriptor lookup"). Unfortunately it 
introduces a following lock-dep warning:

============================================
WARNING: possible recursive locking detected
6.7.0-rc7-00062-gdb660b9a9f86 #7819 Not tainted
--------------------------------------------
kworker/u4:2/27 is trying to acquire lock:
c13f4e1c (gpio_devices_sem){++++}-{3:3}, at: gpio_device_find+0x30/0x94

but task is already holding lock:
c13f4e1c (gpio_devices_sem){++++}-{3:3}, at: 
gpiod_find_and_request+0x44/0x594

other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(gpio_devices_sem);
   lock(gpio_devices_sem);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

4 locks held by kworker/u4:2/27:
  #0: c1c06ca8 ((wq_completion)events_unbound){+.+.}-{0:0}, at: 
process_one_work+0x148/0x608
  #1: e093df20 ((work_completion)(&entry->work)){+.+.}-{0:0}, at: 
process_one_work+0x148/0x608
  #2: c1f3048c (&dev->mutex){....}-{3:3}, at: 
__driver_attach_async_helper+0x38/0xec
  #3: c13f4e1c (gpio_devices_sem){++++}-{3:3}, at: 
gpiod_find_and_request+0x44/0x594

stack backtrace:
CPU: 0 PID: 27 Comm: kworker/u4:2 Not tainted 
6.7.0-rc7-00062-gdb660b9a9f86 #7819
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: events_unbound async_run_entry_fn
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x58/0x70
  dump_stack_lvl from __lock_acquire+0x1300/0x2984
  __lock_acquire from lock_acquire+0x130/0x37c
  lock_acquire from down_read+0x44/0x224
  down_read from gpio_device_find+0x30/0x94
  gpio_device_find from of_get_named_gpiod_flags+0xa4/0x3a8
  of_get_named_gpiod_flags from of_find_gpio+0x80/0x168
  of_find_gpio from gpiod_find_and_request+0x120/0x594
  gpiod_find_and_request from gpiod_get_optional+0x54/0x90
  gpiod_get_optional from reg_fixed_voltage_probe+0x200/0x400
  reg_fixed_voltage_probe from platform_probe+0x5c/0xb8
  platform_probe from really_probe+0xe0/0x400
  really_probe from __driver_probe_device+0x9c/0x1f0
  __driver_probe_device from driver_probe_device+0x30/0xc0
  driver_probe_device from __driver_attach_async_helper+0x54/0xec
  __driver_attach_async_helper from async_run_entry_fn+0x40/0x154
  async_run_entry_fn from process_one_work+0x204/0x608
  process_one_work from worker_thread+0x1e0/0x498
  worker_thread from kthread+0x104/0x138
  kthread from ret_from_fork+0x14/0x28
Exception stack(0xe093dfb0 to 0xe093dff8)
...


Taking gpio_devices_sem more than once for reading is safe, but it looks 
that it needs some lock-dep annotations to to make it happy and avoid 
the above warning.


> ---
>   drivers/gpio/gpiolib.c | 40 +++++++++++++++++++++++-----------------
>   1 file changed, 23 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 4c93cf73a826..be57f8d6aeae 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -4134,27 +4134,33 @@ static struct gpio_desc *gpiod_find_and_request(struct device *consumer,
>   	struct gpio_desc *desc;
>   	int ret;
>   
> -	desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx, &flags, &lookupflags);
> -	if (gpiod_not_found(desc) && platform_lookup_allowed) {
> +	scoped_guard(rwsem_read, &gpio_devices_sem) {
> +		desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx,
> +					    &flags, &lookupflags);
> +		if (gpiod_not_found(desc) && platform_lookup_allowed) {
> +			/*
> +			 * Either we are not using DT or ACPI, or their lookup
> +			 * did not return a result. In that case, use platform
> +			 * lookup as a fallback.
> +			 */
> +			dev_dbg(consumer,
> +				"using lookup tables for GPIO lookup\n");
> +			desc = gpiod_find(consumer, con_id, idx, &lookupflags);
> +		}
> +
> +		if (IS_ERR(desc)) {
> +			dev_dbg(consumer, "No GPIO consumer %s found\n",
> +				con_id);
> +			return desc;
> +		}
> +
>   		/*
> -		 * Either we are not using DT or ACPI, or their lookup did not
> -		 * return a result. In that case, use platform lookup as a
> -		 * fallback.
> +		 * If a connection label was passed use that, else attempt to
> +		 * use the device name as label
>   		 */
> -		dev_dbg(consumer, "using lookup tables for GPIO lookup\n");
> -		desc = gpiod_find(consumer, con_id, idx, &lookupflags);
> +		ret = gpiod_request(desc, label);
>   	}
>   
> -	if (IS_ERR(desc)) {
> -		dev_dbg(consumer, "No GPIO consumer %s found\n", con_id);
> -		return desc;
> -	}
> -
> -	/*
> -	 * If a connection label was passed use that, else attempt to use
> -	 * the device name as label
> -	 */
> -	ret = gpiod_request(desc, label);
>   	if (ret) {
>   		if (!(ret == -EBUSY && flags & GPIOD_FLAGS_BIT_NONEXCLUSIVE))
>   			return ERR_PTR(ret);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


