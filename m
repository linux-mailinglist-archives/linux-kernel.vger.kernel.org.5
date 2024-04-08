Return-Path: <linux-kernel+bounces-135229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CB289BD69
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A3DFB20E3F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EFE5F879;
	Mon,  8 Apr 2024 10:40:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DE95BAF0;
	Mon,  8 Apr 2024 10:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572827; cv=none; b=SFqOwDx+26J9j8rAtDzXpHjkEzkbCyKPCztpz9AhwT0WlFNqvlNIOlUeVUCKyu7EtDHZ8/tkrkm5mrWlDrvyR/FtQS/N4BYOyAGVbKR3TPtDyErM3x97h+Zr8k76Cas5BmNHQKWuGcrwpR07DU2NwpRRlTutGRvNxNCqQTompSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572827; c=relaxed/simple;
	bh=jUvgRV3hkWQLCRFAJlQhdOuAKxJfmPSea0k2guoXG8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3F/aqaPAUZ/bGwaLWxIlxYR/U7FebKz80UDzyEfIX58cOYmQ19LXlORQlynJlBTfSzfk0UVMRZ8IoIGEmZ6OieXdirsmZXU0gCR5y81NkWVJiPLRDOM5XPgZs2ygud7N7HDkZdUcQAb2PklYu+LUCMzGtqy1y2V9BfpNBh4tEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 391AC339;
	Mon,  8 Apr 2024 03:40:55 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CAF13F766;
	Mon,  8 Apr 2024 03:40:23 -0700 (PDT)
Date: Mon, 8 Apr 2024 11:40:20 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, sudeep.holla@arm.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Subject: Re: [PATCH v3 2/2] mailbox: arm_mhuv3: Add driver
Message-ID: <ZhPJlHDMzejX_W4i@pluto>
References: <20240404062347.3219795-1-cristian.marussi@arm.com>
 <20240404062347.3219795-3-cristian.marussi@arm.com>
 <CABb+yY3yzj167ypLPPV7OvqDWfv9y9EFQeZ5pxPAx7xUyyvLVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABb+yY3yzj167ypLPPV7OvqDWfv9y9EFQeZ5pxPAx7xUyyvLVw@mail.gmail.com>

On Sun, Apr 07, 2024 at 08:14:23PM -0500, Jassi Brar wrote:
> On Thu, Apr 4, 2024 at 1:25 AM Cristian Marussi
> <cristian.marussi@arm.com> wrote:
> >
> > Add support for ARM MHUv3 mailbox controller.
> >
> > Support is limited to the MHUv3 Doorbell extension using only the PBX/MBX
> > combined interrupts.
> >

Hi Jassi,

thanks for having a look at this !

> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > v1 -> v2
> > - fixed checkpatch warnings about side-effects
> > - fixed sparse errors as reported
> >   | Reported-by: kernel test robot <lkp@intel.com>
> >   | Closes: https://lore.kernel.org/oe-kbuild-all/202403290015.tCLXudqC-lkp@intel.com/
> > ---
> >  MAINTAINERS                 |    9 +
> >  drivers/mailbox/Kconfig     |   11 +
> >  drivers/mailbox/Makefile    |    2 +
> >  drivers/mailbox/arm_mhuv3.c | 1063 +++++++++++++++++++++++++++++++++++
> >  4 files changed, 1085 insertions(+)
> >  create mode 100644 drivers/mailbox/arm_mhuv3.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index aa3b947fb080..e957b9d9e32a 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -12998,6 +12998,15 @@ F:     Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml
> >  F:     drivers/mailbox/arm_mhuv2.c
> >  F:     include/linux/mailbox/arm_mhuv2_message.h
> >
> > +MAILBOX ARM MHUv3
> > +M:     Sudeep Holla <sudeep.holla@arm.com>
> > +M:     Cristian Marussi <cristian.marussi@arm.com>
> > +L:     linux-kernel@vger.kernel.org
> > +L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > +S:     Maintained
> > +F:     Documentation/devicetree/bindings/mailbox/arm,mhuv3.yaml
> > +F:     drivers/mailbox/arm_mhuv3.c
> > +
> >  MAN-PAGES: MANUAL PAGES FOR LINUX -- Sections 2, 3, 4, 5, and 7
> >  M:     Alejandro Colomar <alx@kernel.org>
> >  L:     linux-man@vger.kernel.org
> > diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> > index 42940108a187..d20cdae65cfe 100644
> > --- a/drivers/mailbox/Kconfig
> > +++ b/drivers/mailbox/Kconfig
> > @@ -23,6 +23,17 @@ config ARM_MHU_V2
> >           Say Y here if you want to build the ARM MHUv2 controller driver,
> >           which provides unidirectional mailboxes between processing elements.
> >
> > +config ARM_MHU_V3
> > +       tristate "ARM MHUv3 Mailbox"
> > +       depends on ARM64 || COMPILE_TEST
> > +       help
> > +         Say Y here if you want to build the ARM MHUv3 controller driver,
> > +         which provides unidirectional mailboxes between processing elements.
> > +
> > +         ARM MHUv3 controllers can implement a varying number of extensions
> > +         that provides different means of transports: supported extensions
> > +         will be discovered and possibly managed at probe-time.
> > +
> >  config IMX_MBOX
> >         tristate "i.MX Mailbox"
> >         depends on ARCH_MXC || COMPILE_TEST
> > diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
> > index 18793e6caa2f..5cf2f54debaf 100644
> > --- a/drivers/mailbox/Makefile
> > +++ b/drivers/mailbox/Makefile
> > @@ -9,6 +9,8 @@ obj-$(CONFIG_ARM_MHU)   += arm_mhu.o arm_mhu_db.o
> >
> >  obj-$(CONFIG_ARM_MHU_V2)       += arm_mhuv2.o
> >
> > +obj-$(CONFIG_ARM_MHU_V3)       += arm_mhuv3.o
> > +
> >  obj-$(CONFIG_IMX_MBOX) += imx-mailbox.o
> >
> >  obj-$(CONFIG_ARMADA_37XX_RWTM_MBOX)    += armada-37xx-rwtm-mailbox.o
> > diff --git a/drivers/mailbox/arm_mhuv3.c b/drivers/mailbox/arm_mhuv3.c
> > new file mode 100644
> > index 000000000000..e4125568bec0
> > --- /dev/null
> > +++ b/drivers/mailbox/arm_mhuv3.c
> > @@ -0,0 +1,1063 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * ARM Message Handling Unit Version 3 (MHUv3) driver.
> > + *
> > + * Copyright (C) 2024 ARM Ltd.
> > + *
> > + * Based on ARM MHUv2 driver.
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/mailbox_controller.h>
> > +#include <linux/module.h>
> > +#include <linux/of_address.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/types.h>
> > +
> > +/* ====== MHUv3 Registers ====== */
> > +
> > +/* Maximum number of Doorbell channel windows */
> > +#define MHUV3_DBCW_MAX                 128
> > +/* Number of DBCH combined interrupt status registers */
> > +#define MHUV3_DBCH_CMB_INT_ST_REG_CNT  4
> > +#define MHUV3_INVALID_DOORBELL         0xFFFFFFFFUL
> > +
> > +/* Number of FFCH combined interrupt status registers */
> > +#define MHUV3_FFCH_CMB_INT_ST_REG_CNT  2
> > +
> > +#define MHUV3_STAT_BYTES               (sizeof(u32))
> >
> Simply 4 please.
>

Ok.
 
> > +#define MHUV3_STAT_BITS                        (MHUV3_STAT_BYTES * __CHAR_BIT__)
> >
> just 32.
>

Ok.
 
> > +
> > +/* Not a typo ... */
> > +#define MHUV3_MAJOR_VERSION            2
> > +
> > +enum {
> > +       MHUV3_MBOX_CELL_TYPE,
> > +       MHUV3_MBOX_CELL_CHWN,
> > +       MHUV3_MBOX_CELL_PARAM,
> > +       MHUV3_MBOX_CELLS
> > +};
> > +
> > +/* CTRL_Page */
> > +
> > +struct blk_id {
> > +       u32 blk_id : 4;
> 
> Please avoid name clashes.
> 

I'll fix.

> > +       u32 pad : 28;
> > +} __packed;
> > +
> > +struct feat_spt0 {
> > +       u32 dbe_spt : 4;
> > +       u32 fe_spt : 4;
> > +       u32 fce_spt : 4;
> > +       u32 tze_spt : 4;
> > +       u32 rme_spt : 4;
> > +       u32 rase_spt : 4;
> > +       u32 pad: 8;
> > +} __packed;
> > +
> > +struct feat_spt1 {
> > +       u32 auto_op_spt : 4;
> > +       u32 pad: 28;
> > +} __packed;
> > +
> > +struct dbch_cfg0 {
> > +       u32 num_dbch : 8;
> > +       u32 pad: 24;
> > +} __packed;
> > +
> > +struct ffch_cfg0 {
> > +       u32 num_ffch : 8;
> > +       u32 x8ba_spt : 1;
> > +       u32 x16ba_spt : 1;
> > +       u32 x32ba_spt : 1;
> > +       u32 x64ba_spt : 1;
> > +       u32 pad : 4;
> > +       u32 ffch_depth : 10;
> > +       u32 pad2 : 6;
> > +} __packed;
> > +
> > +struct fch_cfg0 {
> > +       u32 num_fch : 10;
> > +       /* MBX only registers */
> > +       u32 fcgi_spt : 1;
> > +       /* ------------------ */
> > +       u32 num_fcg : 5;
> > +       u32 num_fch_per_grp : 5;
> > +       u32 fch_ws : 8;
> > +       u32 pad : 3;
> > +} __packed;
> > +
> > +struct ctrl {
> > +       u32 op_req : 1;
> > +       u32 ch_op_mask : 1;
> > +       u32 pad : 30;
> > +} __packed;
> > +
> > +struct fch_ctrl {
> > +       u32 pad : 2;
> > +       u32 int_en : 1;
> > +       u32 pad2 : 29;
> > +} __packed;
> > +
> > +struct iidr {
> > +       u32 implementer : 12;
> > +       u32 revision : 4;
> > +       u32 variant : 4;
> > +       u32 product_id : 12;
> > +} __packed;
> > +
> > +struct aidr {
> > +       u32 arch_minor_rev : 4;
> > +       u32 arch_major_rev : 4;
> > +       u32 pad : 24;
> > +} __packed;
> > +
> I am not sure about using bitfields on register values. I know v2
> driver also uses bitfields but this still is not very portable and is
> dependent on compiler behaviour. We may actually save some loc by not
> having unused fields if we use shifts and masks. Though I don't
> strongly feel either way.
> 

Yes, indeed seemed a bit odd way of handling regs when I saw it in mhuv2,
BUT it seemed it had its advantages in terms of clarity of usage....did
not know about possible drawbacks, though. I'll re-think about the pros
and cons of this approach.

> > +struct ctrl_page {
> > +       struct blk_id blk_id;
> > +       u8 pad[0x10 - 0x4];
> > +       struct feat_spt0 feat_spt0;
> > +       struct feat_spt1 feat_spt1;
> > +       u8 pad1[0x20 - 0x18];
> > +       struct dbch_cfg0 dbch_cfg0;
> > +       u8 pad2[0x30 - 0x24];
> > +       struct ffch_cfg0 ffch_cfg0;
> > +       u8 pad3[0x40 - 0x34];
> > +       struct fch_cfg0 fch_cfg0;
> > +       u8 pad4[0x100 - 0x44];
> > +       struct ctrl ctrl;
> > +       /* MBX only registers */
> > +       u8 pad5[0x140 - 0x104];
> > +       struct fch_ctrl fch_ctrl;
> > +       u32 fcg_int_en;
> > +       u8 pad6[0x400 - 0x148];
> > +       /* ------------------ */
> Why the decoration ? Maybe comment on what different starts from here.
> 

PBX and MBX Ctrl page are exactly the same, BUT for some registers banks
that does not exist in the PBX: this decoration is indeed the end, not
the start, of the MBX only regs that starts 5 lines above with the related
comment...was trying to avoid to use 2 different types for the basically
the same data...of course it works just because the PBX code refrains
from accessing the areas where only regs known to MBX lives.

> > +       u32 dbch_int_st[MHUV3_DBCH_CMB_INT_ST_REG_CNT];
> > +       u32 ffch_int_st[MHUV3_FFCH_CMB_INT_ST_REG_CNT];
> > +       /* MBX only registers */
> > +       u8 pad7[0x470 - 0x418];
> > +       u32 fcg_int_st;
> > +       u8 pad8[0x480 - 0x474];
> > +       u32 fcg_grp_int_st[32];
> > +       u8 pad9[0xFC8 - 0x500];
> > +       /* ------------------ */

Same here.

> > +       struct iidr iidr;
> > +       struct aidr aidr;
> > +       u32 imp_def_id[12];
> > +} __packed;
> > +
> > +/* DBCW_Page */
> > +
> > +struct xbcw_ctrl {
> > +       u32 comb_en : 1;
> > +       u32 pad : 31;
> > +} __packed;
> > +
> > +struct pdbcw_int {
> > +       u32 tfr_ack : 1;
> > +       u32 pad : 31;
> > +} __packed;
> > +
> > +struct pdbcw_page {
> > +       u32 st;
> > +       u8 pad[0xC - 0x4];
> > +       u32 set;
> > +       struct pdbcw_int int_st;
> > +       struct pdbcw_int int_clr;
> > +       struct pdbcw_int int_en;
> > +       struct xbcw_ctrl ctrl;
> > +} __packed;
> > +
> > +struct mdbcw_page {
> > +       u32 st;
> > +       u32 st_msk;
> > +       u32 clr;
> > +       u8 pad[0x10 - 0xC];
> > +       u32 msk_st;
> > +       u32 msk_set;
> > +       u32 msk_clr;
> > +       struct xbcw_ctrl ctrl;
> > +} __packed;
> > +
> > +struct dummy_page {
> > +       u8 pad[0x1000];
> > +} __packed;
> > +
> > +struct mhu3_pbx_frame_reg {
> > +       struct ctrl_page ctrl;
> > +       struct pdbcw_page dbcw[MHUV3_DBCW_MAX];
> > +       struct dummy_page ffcw;
> > +       struct dummy_page fcw;
> > +       u8 pad[0xF000 - 0x4000];
> > +       struct dummy_page impdef;
> > +} __packed;
> > +
> > +struct mhu3_mbx_frame_reg {
> > +       struct ctrl_page ctrl;
> > +       struct mdbcw_page dbcw[MHUV3_DBCW_MAX];
> > +       struct dummy_page ffcw;
> > +       struct dummy_page fcw;
> > +       u8 pad[0xF000 - 0x4000];
> > +       struct dummy_page impdef;
> > +} __packed;
> > +
> > +/* Macro for reading a bitfield within a physically mapped packed struct */
> > +#define readl_relaxed_bitfield(_regptr, _field)                                \
> > +       ({                                                              \
> > +               u32 _rval;                                              \
> > +               typeof(_regptr) _rptr = _regptr;                        \
> > +               _rval = readl_relaxed(_rptr);                           \
> > +               ((typeof(*_rptr) __force *)(&_rval))->_field;           \
> > +       })
> > +
> > +/* Macro for writing a bitfield within a physically mapped packed struct */
> > +#define writel_relaxed_bitfield(_value, _regptr, _field)               \
> > +       ({                                                              \
> > +               u32 _rval;                                              \
> > +               typeof(_regptr) _rptr = _regptr;                        \
> > +               _rval = readl_relaxed(_rptr);                           \
> > +               ((typeof(*_rptr) __force *)(&_rval))->_field = _value;  \
> > +               writel_relaxed(_rval, _rptr);                           \
> > +       })
> > +
> > +/* ====== MHUv3 data structures ====== */
> > +
> > +enum mhuv3_frame {
> > +       PBX_FRAME,
> > +       MBX_FRAME
> > +};
> > +
> > +static char *mhuv3_str[] = {
> > +       "PBX",
> > +       "MBX"
> > +};
> > +
> > +enum mhuv3_extension_type {
> > +       FIRST_EXT = 0,
> > +       DBE_EXT = FIRST_EXT,
> > +       FCE_EXT,
> > +       FE_EXT,
> > +       MAX_EXT
> > +};
> > +
> > +struct mhuv3;
> > +
> > +/**
> > + * struct mhuv3_protocol_ops - MHUv3 operations
> > + *
> > + * @rx_startup: Receiver startup callback.
> > + * @rx_shutdown: Receiver shutdown callback.
> > + * @read_data: Read available Sender in-band LE data (if any).
> > + * @rx_complete: Acknowledge data reception to the Sender. Any out-of-band data
> > + *              has to have been already retrieved before calling this.
> > + * @tx_startup: Sender startup callback.
> > + * @tx_shutdown: Sender shutdown callback.
> > + * @last_tx_done: Report back to the Sender if the last transfer has completed.
> > + * @send_data: Send data to the receiver.
> > + *
> > + * Each supported transport protocol provides its own implementation of
> > + * these operations.
> > + */
> > +struct mhuv3_protocol_ops {
> > +       int (*rx_startup)(struct mhuv3 *mhu, struct mbox_chan *chan);
> > +       void (*rx_shutdown)(struct mhuv3 *mhu, struct mbox_chan *chan);
> > +       void *(*read_data)(struct mhuv3 *mhu, struct mbox_chan *chan);
> > +       void (*rx_complete)(struct mhuv3 *mhu, struct mbox_chan *chan);
> > +       void (*tx_startup)(struct mhuv3 *mhu, struct mbox_chan *chan);
> > +       void (*tx_shutdown)(struct mhuv3 *mhu, struct mbox_chan *chan);
> > +       int (*last_tx_done)(struct mhuv3 *mhu, struct mbox_chan *chan);
> > +       int (*send_data)(struct mhuv3 *mhu, struct mbox_chan *chan, void *arg);
> > +};
> > +
> > +/**
> > + * struct mhuv3_mbox_chan_priv - MHUv3 channel private information
> > + *
> > + * @ch_idx: Channel window index associated to this mailbox channel.
> > + * @doorbell: Doorbell bit number within the @ch_idx window.
> > + *           Only relevant to Doorbell transport.
> > + * @ops: Transport protocol specific operations for this channel.
> > + *
> > + * Transport specific data attached to mmailbox channel priv data.
> > + */
> > +struct mhuv3_mbox_chan_priv {
> > +       u32 ch_idx;
> > +       u32 doorbell;
> > +       const struct mhuv3_protocol_ops *ops;
> > +};
> > +
> > +/**
> > + * struct mhuv3_extension - MHUv3 extension descriptor
> > + *
> > + * @type: Type of extension
> > + * @max_chans: Max number of channels found for this extension.
> > + * @base_ch_idx: First channel number assigned to this extension, picked from
> > + *              the set of all mailbox channels descriptors created.
> > + * @mbox_of_xlate: Extension specific helper to parse DT and lookup associated
> > + *                channel from the related 'mboxes' property.
> > + * @combined_irq_setup: Extension specific helper to setup the combined irq.
> > + * @channels_init: Extension specific helper to initialize channels.
> > + * @chan_from_comb_irq_get: Extension specific helper to lookup which channel
> > + *                         triggered the combined irq.
> > + * @pending_db: Array of per-channel pending doorbells.
> > + * @pending_lock: Protect access to pending_db.
> > + */
> > +struct mhuv3_extension {
> > +       enum mhuv3_extension_type type;
> > +       unsigned int max_chans;
> > +       unsigned int base_ch_idx;
> > +       struct mbox_chan *(*mbox_of_xlate)(struct mhuv3 *mhu,
> > +                                          unsigned int channel,
> > +                                          unsigned int param);
> > +       void (*combined_irq_setup)(struct mhuv3 *mhu);
> > +       int (*channels_init)(struct mhuv3 *mhu);
> > +       struct mbox_chan *(*chan_from_comb_irq_get)(struct mhuv3 *mhu);
> > +       u32 pending_db[MHUV3_DBCW_MAX];
> > +       /* Protect access to pending_db */
> > +       spinlock_t pending_lock;
> > +};
> > +
> > +/**
> > + * struct mhuv3 - MHUv3 mailbox controller data
> > + *
> > + * @frame:     Frame type: MBX_FRAME or PBX_FRAME.
> > + * @auto_op_full: Flag to indicate if the MHU supports AutoOp full mode.
> > + * @major: MHUv3 controller architectural major version.
> > + * @minor: MHUv3 controller architectural minor version.
> > + * @tot_chans: The total number of channnels discovered across all extensions.
> > + * @cmb_irq: Combined IRQ number if any found defined.
> > + * @ctrl: A reference to the MHUv3 control page for this block.
> > + * @pbx: Base address of the PBX register mapping region.
> > + * @mbx: Base address of the MBX register mapping region.
> > + * @ext: Array holding descriptors for any found implemented extension.
> > + * @mbox: Mailbox controller belonging to the MHU frame.
> > + */
> > +struct mhuv3 {
> > +       enum mhuv3_frame frame;
> > +       bool auto_op_full;
> > +       unsigned int major;
> > +       unsigned int minor;
> > +       unsigned int tot_chans;
> >
> may be num_chans or chan_count ?
> 

Ok.

> 
> > +       int cmb_irq;
> > +       struct ctrl_page __iomem *ctrl;
> > +       union {
> > +               struct mhu3_pbx_frame_reg __iomem *pbx;
> > +               struct mhu3_mbx_frame_reg __iomem *mbx;
> > +       };
> > +       struct mhuv3_extension *ext[MAX_EXT];
> > +       struct mbox_controller mbox;
> > +};
> > +
> > +#define mhu_from_mbox(_mbox) container_of(_mbox, struct mhuv3, mbox)
> > +
> > +typedef int (*mhuv3_extension_initializer)(struct mhuv3 *mhu);
> > +
> > +/* =================== Doorbell transport protocol operations =============== */
> > +
> > +static void mhuv3_doorbell_tx_startup(struct mhuv3 *mhu, struct mbox_chan *chan)
> > +{
> > +       struct mhuv3_mbox_chan_priv *priv = chan->con_priv;
> > +
> > +       /* Enable Transfer Acknowledgment events */
> > +       writel_relaxed_bitfield(0x1, &mhu->pbx->dbcw[priv->ch_idx].int_en, tfr_ack);
> > +}
> > +
> > +static void mhuv3_doorbell_tx_shutdown(struct mhuv3 *mhu, struct mbox_chan *chan)
> > +{
> > +       unsigned long flags;
> > +       struct mhuv3_extension *e = mhu->ext[DBE_EXT];
> > +       struct mhuv3_mbox_chan_priv *priv = chan->con_priv;
> > +
> In order of decreasing line-lengths please everywhere.
>

Sure.
 
> > +       /* Disable Channel Transfer Ack events */
> > +       writel_relaxed_bitfield(0x0, &mhu->pbx->dbcw[priv->ch_idx].int_en, tfr_ack);
> > +
> > +       /* Clear Channel Transfer Ack and pending doorbells */
> > +       writel_relaxed_bitfield(0x1, &mhu->pbx->dbcw[priv->ch_idx].int_clr, tfr_ack);
> > +       spin_lock_irqsave(&e->pending_lock, flags);
> > +       e->pending_db[priv->ch_idx] = 0;
> > +       spin_unlock_irqrestore(&e->pending_lock, flags);
> > +}

[snip]

> > +static struct mbox_chan *mhuv3_dbe_chan_from_comb_irq_get(struct mhuv3 *mhu)
> > +{
> > +       int i;
> > +       struct mhuv3_extension *e = mhu->ext[DBE_EXT];
> > +       struct device *dev = mhu->mbox.dev;
> > +
> > +       for (i = 0; i < MHUV3_DBCH_CMB_INT_ST_REG_CNT; i++) {
> > +               unsigned int channel, db = MHUV3_INVALID_DOORBELL;
> > +               u32 cmb_st, st;
> > +
> > +               cmb_st = readl_relaxed(&mhu->ctrl->dbch_int_st[i]);
> > +               if (!cmb_st)
> > +                       continue;
> > +
> > +               channel = i * MHUV3_STAT_BITS + __builtin_ctz(cmb_st);
> 
> __ffs instead of __builtin_ctz please.
>

ok.
 
> > +               if (channel >= e->max_chans) {
> > +                       dev_err(dev, "Invalid %s channel:%d\n",
> > +                               mhuv3_str[mhu->frame], channel);
> > +                       break;
> > +               }
> > +

[snip]

> > +static irqreturn_t mhuv3_pbx_comb_interrupt(int irq, void *arg)
> > +{
> > +       int ret = IRQ_NONE;
> > +       unsigned int i, found = 0;
> > +       struct mhuv3 *mhu = arg;
> > +       struct device *dev = mhu->mbox.dev;
> > +       struct mbox_chan *chan;
> > +
> > +       for (i = FIRST_EXT; i < MAX_EXT; i++) {
> > +               /* FCE does not participate to the PBX combined */
> > +               if (i == FCE_EXT || !mhu->ext[i])
> > +                       continue;
> > +
> > +               chan = mhu->ext[i]->chan_from_comb_irq_get(mhu);
> > +               if (!IS_ERR(chan)) {
> >
>   'continue' for error instead, to have fewer indented lines.
>

ok.
 
> > +                       struct mhuv3_mbox_chan_priv *priv = chan->con_priv;
> > +
> > +                       found++;
> > +                       if (chan->cl) {
> > +                               mbox_chan_txdone(chan, 0);
> > +                               ret = IRQ_HANDLED;
> > +                       } else {
> > +                               dev_warn(dev,
> > +                                        "TX Ack on UNBOUND channel (%u)\n",
> > +                                        priv->ch_idx);
> > +                       }
> > +               }
> > +       }
> > +
> > +       if (!found)
> > +               dev_warn_once(dev, "Failed to find channel for the TX interrupt\n");
> > +
> > +       return ret;
> > +}
> > +
> > +static irqreturn_t mhuv3_mbx_comb_interrupt(int irq, void *arg)
> > +{
> > +       int ret = IRQ_NONE;
> > +       unsigned int i, found = 0;
> > +       struct mhuv3 *mhu = arg;
> > +       struct device *dev = mhu->mbox.dev;
> > +       struct mbox_chan *chan;
> > +
> > +       for (i = FIRST_EXT; i < MAX_EXT; i++) {
> > +               if (!mhu->ext[i])
> > +                       continue;
> > +
> > +               /* Process any extension which could be source of the IRQ */
> > +               chan = mhu->ext[i]->chan_from_comb_irq_get(mhu);
> > +               if (!IS_ERR(chan)) {
>   'continue' for error instead, to have fewer indented lines.
>

ok.

Thanks,
Cristian

