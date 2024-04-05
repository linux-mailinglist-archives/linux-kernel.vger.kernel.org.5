Return-Path: <linux-kernel+bounces-133557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB05789A587
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DE2CB20D87
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6899717335A;
	Fri,  5 Apr 2024 20:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GtatqMjR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A21171E42
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 20:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712348047; cv=none; b=XT6+hvBhcYKs+0Muhq56hdG/SB+ZgvtR+outtBK+uFy+aF0+CRVbKQ0BqLJaM27+wsvb4uIOlbMRvT4UDF7tWNs/5BJZ9oHujMzc/3e8vOBarxRypnCYAjAmQx16R3WXQ4lDQt9w5IwnUNwOw8MpeCPkWK+s5m0Z4rUbf3u959Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712348047; c=relaxed/simple;
	bh=MauAJ22yHYagcZfjpHra3lN/mo7DYJopjdnrUhrDfgE=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=oM8P+EM1grvT/UdkFh0swcsYvZsM6D4bP/Wc1ZgW2rOiGyUJqA/P64tFonYAp094GgxIWI8cZsepjyaBh0NGeircOqEPK+j7rTk894BLbxPCJmlxdIaUWRwzf8h9scy/NV0pYMIzZnc00eo+RJ96uYJlxBK3IwRHBaVwVCbznmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GtatqMjR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9288FC433C7;
	Fri,  5 Apr 2024 20:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712348047;
	bh=MauAJ22yHYagcZfjpHra3lN/mo7DYJopjdnrUhrDfgE=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=GtatqMjRcQEjmaKQqHgse4nsmxyosMlOCd6nWUIUgH2hkjKtBMxT7qjIUSvrd3yFn
	 bzeGadxs8zkoDpE5ulfDpzuIthuXaxb2NLu3a6J12u6DjIRQVjd3N/LiVntX042LhY
	 7SietNtnz/LuwvGImp+busp34OP52MZqVc1J9zAVOIQATMTEaU5BDTJk/cS1Tu8Tz5
	 fTA8BV/j8RUsG53DGI4ZpHg60Wdx+X8Kpa/+MdsbDbCt513B2DGEvo7oPshopXWNqD
	 C44cigvG2NNz+a4L91zKIQfHJfdPzpKZO9PrkqAJWQeVnv9XMLSiS1jSfN81YiGqMn
	 lo4YitwnWbM+Q==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 962081200068;
	Fri,  5 Apr 2024 16:14:05 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 05 Apr 2024 16:14:05 -0400
X-ME-Sender: <xms:jFsQZqLwxgkPtLnQH9PVc4cqFtolkFLRDgpVlnhjwAxI02HdhSXScg>
    <xme:jFsQZiIdNH-EBxl5WagFj8kfyjXa4KTFhHJWCTBwLEca0hmG9h3Z2qSctFpbsYHS7
    uF1MZANqhyIlyK1vOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegtddgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvddttdffjeefgeeggfelfefggefhheeffefftefggfelgeduveev
    tefhfeejveeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedu
    jedtvdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnug
    gsrdguvg
X-ME-Proxy: <xmx:jFsQZqtLFUoXOlHogjlMx6x2TxwHYwbUo-nPHNpo1rEE3tTO8g3nRA>
    <xmx:jFsQZvZFlP2f7MWdYVzarCRTCF0CN3Ft6BB8HvK0q_EpGJqPfHEySg>
    <xmx:jFsQZhaSCD7aeRLlVgL1zEWKNcgrsIrU1HqOGwLSk1KNGJcMVjFNLw>
    <xmx:jFsQZrCTFF4fUHqWU9h_FENsrurErAmcwlXpAXTyPY1cif2dMW5gjw>
    <xmx:jVsQZlG_eXZBo_yzzUa2b85AFOdQ5KahgbEG5DBjxqw0Iy__tFLHWi0J>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id BCC0AB6008D; Fri,  5 Apr 2024 16:14:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6b308ab0-dda7-4052-98b3-cb03e17e3e12@app.fastmail.com>
In-Reply-To: <d9bdfa48-572a-caa1-229b-44565690d9e6@gmail.com>
References: <20240403122851.38808-1-schnelle@linux.ibm.com>
 <dd55afa6-8cb6-4e25-b720-d2df62dbb5e6@gmail.com>
 <bf276f98-2712-4fcf-a119-f984a1aedbf2@app.fastmail.com>
 <CAMuHMdX+M1VuhDVnC9n4hCBDjHywwsByNK1w8ibazc+-8_C53A@mail.gmail.com>
 <d9bdfa48-572a-caa1-229b-44565690d9e6@gmail.com>
Date: Fri, 05 Apr 2024 22:13:43 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Michael Schmitz" <schmitzmic@gmail.com>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: "Niklas Schnelle" <schnelle@linux.ibm.com>,
 linux-m68k@lists.linux-m68k.org, "Heiko Carstens" <hca@linux.ibm.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] m68k: Handle HAS_IOPORT dependencies
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024, at 20:36, Michael Schmitz wrote:
> Am 05.04.2024 um 23:16 schrieb Geert Uytterhoeven:
>> On Wed, Apr 3, 2024 at 8:35=E2=80=AFPM Arnd Bergmann <arnd@kernel.org=
> wrote:
>>> On Wed, Apr 3, 2024, at 20:11, Michael Schmitz wrote:
>>>> how do you propose we handle legacy drivers that do depend on
>>>> inb()/outb() functions (_not_ actual ISA I/O) on architectures that=
 map
>>>> inb()/outb() to MMIO functions?
>>>>
>>>> (In my case, that's at least ne.c - Geert ought to have a better
>>>> overview what else does use inb()/outb() on m68k)
>>>
>>> If a machine provides an inb()/outb() set of operations that
>>> is actually used, it should set HAS_IOPORT.
>>>
>>> For the Q40, it may be better in the long run to change the
>>> drivers to just use MMIO directly though.
>>
>> Q40 uses ISA.
>>
>> Michael is worried about non-ISA drivers using inb() and friends.
>> At some point in time (i.e. eons ago), we were told it was better to
>> use in[bwl]()/read[bwl]() instead of directly dereferencing volatile
>> pointers...
>>
>> Anyway, I don't think we have many users of inb() and friends left, a=
nd
>> I assume the bots should have detected any/most remaining users in Ni=
klas'
>> branch...
>
> All the 8390 based ethernet drivers still use inb() and friends.
>
> That is the main reason for the terrible hacks in=20
> arch/m68k/include/asm/io_mm.h ...
>
> The last time I tried to add support for a different PCMCIA ethernet=20
> adapter to apne.c _without_ adding to the hacks in io_mm.h, I wasn't=20
> getting anywhere with the netdev crowd. That was ages ago, and I doubt=20
> their enthusiasm for a rewrite of the 8390 code base to avoid using=20
> inb() on MMIO architectures will be any better now.

From what I can see, there is already an abstraction layer in
these drivers that is used by all m68k drivers except apne:

$ git grep -w 'define\sei_inb'
drivers/net/ethernet/8390/8390.h:#define ei_inb(_p)     inb(_p)
drivers/net/ethernet/8390/8390p.c:#define ei_inb(_p)    inb(_p)
drivers/net/ethernet/8390/ax88796.c:#define ei_inb(_a) readb(ax_convert_=
addr(_a))
drivers/net/ethernet/8390/etherh.c:#define ei_inb(_p)    readb((void __i=
omem *)_p)
drivers/net/ethernet/8390/hydra.c:#define ei_inb(port)   in_8(port)
drivers/net/ethernet/8390/mac8390.c:#define ei_inb(port)        in_8(por=
t)
drivers/net/ethernet/8390/mcf8390.c:#define     ei_inb  ei_inb
drivers/net/ethernet/8390/xsurf100.c:#define ei_inb(_a) z_readb(ax_conve=
rt_addr(_a))
drivers/net/ethernet/8390/zorro8390.c:#define ei_inb(port)              =
in_8(port)

Can't apne.c just do the same here? The patch below didn't
take that long to come up with, but I may be missing something
here of course.

    Arnd

8<---
From 5dd43e612a52adf499b1ea3d33e3b2b45894d275 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 5 Apr 2024 21:47:51 +0200
Subject: [PATCH] net: apne: convert to lib8390

The apne driver still uses the ISA-style inb()/outb() wappers through the
8390.c helper module, which won't work in the future.

Change it to include lib8390.c like all the other m68k variants of this
driver do, so it can have custom MMIO abstractions.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/net/ethernet/8390/Makefile b/drivers/net/ethernet/8=
390/Makefile
index 85c83c566ec6..ec1b325da4e4 100644
--- a/drivers/net/ethernet/8390/Makefile
+++ b/drivers/net/ethernet/8390/Makefile
@@ -4,7 +4,7 @@
 #
=20
 obj-$(CONFIG_MAC8390) +=3D mac8390.o
-obj-$(CONFIG_APNE) +=3D apne.o 8390.o
+obj-$(CONFIG_APNE) +=3D apne.o
 obj-$(CONFIG_ARM_ETHERH) +=3D etherh.o
 obj-$(CONFIG_AX88796) +=3D ax88796.o
 obj-$(CONFIG_HYDRA) +=3D hydra.o
diff --git a/drivers/net/ethernet/8390/apne.c b/drivers/net/ethernet/839=
0/apne.c
index 828edca8d30c..ea3747723b3c 100644
--- a/drivers/net/ethernet/8390/apne.c
+++ b/drivers/net/ethernet/8390/apne.c
@@ -41,7 +41,15 @@
 #include <asm/amigayle.h>
 #include <asm/amipcmcia.h>
=20
-#include "8390.h"
+#define ei_inb(port)            in_8(port)
+#define ei_outb(val, port)      out_8(port, val)
+#define ei_inb_p(port)          in_8(port)
+#define ei_outb_p(val, port)    out_8(port, val)
+
+static const char version[] =3D
+    "apne.c:v1.1 7/10/98 Alain Malek (Alain.Malek@cryogen.ch)\n";
+
+#include "lib8390.c"
=20
 /* ---- No user-serviceable parts below ---- */
=20
@@ -105,14 +113,21 @@ static int init_pcmcia(void);
 #define MANUAL_HWADDR5 0x9a
 */
=20
-static const char version[] =3D
-    "apne.c:v1.1 7/10/98 Alain Malek (Alain.Malek@cryogen.ch)\n";
-
 static int apne_owned;	/* signal if card already owned */
=20
-static u32 apne_msg_enable;
-module_param_named(msg_enable, apne_msg_enable, uint, 0444);
-MODULE_PARM_DESC(msg_enable, "Debug message level (see linux/netdevice.=
h for bitmap)");
+static const struct net_device_ops apne_netdev_ops =3D {
+	.ndo_open		=3D __ei_open,
+	.ndo_stop		=3D __ei_close,
+	.ndo_start_xmit		=3D __ei_start_xmit,
+	.ndo_tx_timeout		=3D __ei_tx_timeout,
+	.ndo_get_stats		=3D __ei_get_stats,
+	.ndo_set_rx_mode	=3D __ei_set_multicast_list,
+	.ndo_validate_addr	=3D eth_validate_addr,
+	.ndo_set_mac_address	=3D eth_mac_addr,
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	.ndo_poll_controller	=3D __ei_poll,
+#endif
+};
=20
 static struct net_device * __init apne_probe(void)
 {
@@ -141,11 +156,11 @@ static struct net_device * __init apne_probe(void)
 		return ERR_PTR(-ENODEV);
 	}
=20
-	dev =3D alloc_ei_netdev();
+	dev =3D ____alloc_ei_netdev(0);
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
 	ei_local =3D netdev_priv(dev);
-	ei_local->msg_enable =3D apne_msg_enable;
+	ei_local->msg_enable =3D msg_enable;
=20
 	/* disable pcmcia irq for readtuple */
 	pcmcia_disable_irq();
@@ -203,7 +218,7 @@ static int __init apne_probe1(struct net_device *dev=
, int ioaddr)
 #endif
     static unsigned version_printed;
=20
-    if ((apne_msg_enable & NETIF_MSG_DRV) && (version_printed++ =3D=3D =
0))
+    if ((msg_enable & NETIF_MSG_DRV) && (version_printed++ =3D=3D 0))
 		netdev_info(dev, version);
=20
     netdev_info(dev, "PCMCIA NE*000 ethercard probe");
@@ -309,7 +324,7 @@ static int __init apne_probe1(struct net_device *dev=
, int ioaddr)
=20
     dev->base_addr =3D ioaddr;
     dev->irq =3D IRQ_AMIGA_PORTS;
-    dev->netdev_ops =3D &ei_netdev_ops;
+    dev->netdev_ops =3D &apne_netdev_ops;
=20
     /* Install the Interrupt handler */
     i =3D request_irq(dev->irq, apne_interrupt, IRQF_SHARED, DRV_NAME, =
dev);
@@ -333,7 +348,7 @@ static int __init apne_probe1(struct net_device *dev=
, int ioaddr)
     ei_status.block_output =3D &apne_block_output;
     ei_status.get_8390_hdr =3D &apne_get_8390_hdr;
=20
-    NS8390_init(dev, 0);
+    __NS8390_init(dev, 0);
=20
     pcmcia_ack_int(pcmcia_get_intreq());		/* ack PCMCIA int req */
     pcmcia_enable_irq();
@@ -513,7 +528,7 @@ apne_block_output(struct net_device *dev, int count,
 	if (time_after(jiffies, dma_start + 2*HZ/100)) {	/* 20ms */
 		netdev_warn(dev, "timeout waiting for Tx RDC.\n");
 		apne_reset_8390(dev);
-		NS8390_init(dev,1);
+		__NS8390_init(dev,1);
 		break;
 	}
=20
@@ -534,10 +549,10 @@ static irqreturn_t apne_interrupt(int irq, void *d=
ev_id)
         pcmcia_ack_int(pcmcia_intreq);
         return IRQ_NONE;
     }
-    if (apne_msg_enable & NETIF_MSG_INTR)
+    if (msg_enable & NETIF_MSG_INTR)
 	pr_debug("pcmcia intreq =3D %x\n", pcmcia_intreq);
     pcmcia_disable_irq();			/* to get rid of the sti() within ei_interr=
upt */
-    ei_interrupt(irq, dev_id);
+    __ei_interrupt(irq, dev_id);
     pcmcia_ack_int(pcmcia_get_intreq());
     pcmcia_enable_irq();
     return IRQ_HANDLED;

