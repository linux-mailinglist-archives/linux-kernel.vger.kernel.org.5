Return-Path: <linux-kernel+bounces-10980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE06D81DF98
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 10:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66F42281A4C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 09:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40AA1A71C;
	Mon, 25 Dec 2023 09:57:35 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out28-79.mail.aliyun.com (out28-79.mail.aliyun.com [115.124.28.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C04D179A2
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 09:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sjterm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sjterm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07447141|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.157524-0.0058014-0.836675;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047187;MF=fuyao@sjterm.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.VsS8aFT_1703497925;
Received: from localhost(mailfrom:fuyao@sjterm.com fp:SMTPD_---.VsS8aFT_1703497925)
          by smtp.aliyun-inc.com;
          Mon, 25 Dec 2023 17:52:06 +0800
Date: Mon, 25 Dec 2023 17:52:05 +0800
From: fuyao <fuyao@sjterm.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: fuyao <fuyao1697@cyg.com>, Lee Jones <lee@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
	maijianzhang <maijianzhang@allwinnertech.com>
Subject: Re: [PATCH RESEND] iio: adc: sun4i-gpadc-iio: adaptation interrupt
 number
Message-ID: <ZYlQxccd-_1kyHt5@debian.cyg>
Mail-Followup-To: Andre Przywara <andre.przywara@arm.com>,
	fuyao <fuyao1697@cyg.com>, Lee Jones <lee@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
	maijianzhang <maijianzhang@allwinnertech.com>
References: <YxmR5SPPY18O7LaG@google.com>
 <YwdhTlk+9h+9Mrwm@scg>
 <20231220115412.65bbc8c7@donnerap.manchester.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220115412.65bbc8c7@donnerap.manchester.arm.com>
Organization: work_work_work

On Wed, Dec 20, 2023 at 11:54:12AM +0000, Andre Przywara wrote:
> On Wed, 20 Dec 2023 15:23:17 +0800
> fuyao <fuyao1697@cyg.com> wrote:
> 
> Hi,
> 
> > __platform_get_irq_byname determinies whether the interrupt
> > number is 0 and returns EINVAL.
> 
> can you please say what this fixes, exactly? Is something not working at
> the moment? Can you please provide parts of the error message?
> 

With open MFD_SUN4I_GPADC and SUN4I_GPADC, It happens:

[    0.185068] ------------[ cut here ]------------
[    0.185093] WARNING: CPU: 3 PID: 1 at drivers/base/platform.c:451 __platform_get_irq_byname+0xb8/0xc4
[    0.185131] 0 is an invalid IRQ number
[    0.185140] Modules linked in:
[    0.185160] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 6.7.0-rc6 #9
[    0.185179] Hardware name: Allwinner sun8i Family
[    0.185203]  unwind_backtrace from show_stack+0x10/0x14
[    0.185234]  show_stack from dump_stack_lvl+0x48/0x54
[    0.185262]  dump_stack_lvl from __warn+0xcc/0x1ac
[    0.185285]  __warn from warn_slowpath_fmt+0xb4/0x168
[    0.185304]  warn_slowpath_fmt from __platform_get_irq_byname+0xb8/0xc4
[    0.185328]  __platform_get_irq_byname from platform_get_irq_byname+0x10/0x38
[    0.185354]  platform_get_irq_byname from sun4i_irq_init+0x40/0xdc
[    0.185382]  sun4i_irq_init from sun4i_gpadc_probe+0x1cc/0x310
[    0.185403]  sun4i_gpadc_probe from platform_probe+0x98/0xc0
[    0.185426]  platform_probe from really_probe+0x10c/0x374
[    0.185450]  really_probe from __driver_probe_device+0x90/0x188
[    0.185473]  __driver_probe_device from driver_probe_device+0x3c/0x198
[    0.185496]  driver_probe_device from __driver_attach+0x118/0x1b4
[    0.185518]  __driver_attach from bus_for_each_dev+0x104/0x148
[    0.185540]  bus_for_each_dev from bus_add_driver+0x164/0x25c
[    0.185560]  bus_add_driver from driver_register+0x70/0x118
[    0.185582]  driver_register from do_one_initcall+0xcc/0x29c
[    0.185605]  do_one_initcall from do_initcall_level+0x80/0x8c
[    0.185630]  do_initcall_level from do_initcalls+0x50/0x80
[    0.185653]  do_initcalls from kernel_init_freeable+0xb0/0xfc
[    0.185675]  kernel_init_freeable from kernel_init+0x14/0x1b4
[    0.185698]  kernel_init from ret_from_fork+0x14/0x28
[    0.185720] Exception stack(0xf0825fb0 to 0xf0825ff8)
[    0.185737] 5fa0:                                     00000000 00000000 00000000 00000000
[    0.185756] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    0.185775] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    0.185788] ---[ end trace 0000000000000000 ]---
[    0.185804] sun4i-gpadc-iio sun6i-a31-gpadc-iio.0: error -EINVAL: IRQ FIFO_DATA_PENDING not found
[    0.185828] sun4i-gpadc-iio: probe of sun6i-a31-gpadc-iio.0 failed with error -22

The gpadc-iio can not request irq.

> And maybe expand the explanation a bit more? For instance mention that the
> identifiers are used as IRQ resource numbers, where 0 is treated specially.
> 

thanks

> Cheers,
> Andre
> 
> > 
> > Signed-off-by: fuyao <fuyao1697@cyg.com>
> > Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > ---
> >  include/linux/mfd/sun4i-gpadc.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/mfd/sun4i-gpadc.h b/include/linux/mfd/sun4i-gpadc.h
> > index ea0ccf33a459..021f820f9d52 100644
> > --- a/include/linux/mfd/sun4i-gpadc.h
> > +++ b/include/linux/mfd/sun4i-gpadc.h
> > @@ -81,8 +81,8 @@
> >  #define SUN4I_GPADC_TEMP_DATA				0x20
> >  #define SUN4I_GPADC_DATA				0x24
> >  
> > -#define SUN4I_GPADC_IRQ_FIFO_DATA			0
> > -#define SUN4I_GPADC_IRQ_TEMP_DATA			1
> > +#define SUN4I_GPADC_IRQ_FIFO_DATA			1
> > +#define SUN4I_GPADC_IRQ_TEMP_DATA			2
> >  
> >  /* 10s delay before suspending the IP */
> >  #define SUN4I_GPADC_AUTOSUSPEND_DELAY			10000
> 

-- 
CYG Technology.

