Return-Path: <linux-kernel+bounces-167439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB458BA99E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5730281C12
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8E614F129;
	Fri,  3 May 2024 09:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mecka.net header.i=@mecka.net header.b="kt9QHgKq"
Received: from mecka.net (mecka.net [159.69.159.214])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DD8139CE5;
	Fri,  3 May 2024 09:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.159.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714727819; cv=none; b=rVYVsOp0Suu3DBLEFiJbg4h6zgzbdTS/Uf0LTH53XmGOeichFxYctyOOnxoA1GKaVX2FsPdUl/9oO6B23CdZZwELdp8ajhX4Yiov4gZzb+LVgS5nfZM3NYFmhrMd3Q7+AjoprcxxexXm7i+Fbi2FFlpDurAeNkhnhJogF9lG/yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714727819; c=relaxed/simple;
	bh=7Bo2cSz7OHrxMRYOFOuGmSNObiTSXZOJDjl3T6Pcx5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNBKhtceavNVkdAI1My32NQalmxRisINXWBVQLEsUbdImJOB23NrvnvoyBK9gNyPhft976iRHdGqom3Xkwo1cjWi7i4nwuRXLxv5XjE3Xo/x5odT+fj7+CNRreRoO5Byf/1shbpC9K3PQJW/H85xl+T96ZII8lnGxnCpDETitKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mecka.net; spf=pass smtp.mailfrom=mecka.net; dkim=fail (0-bit key) header.d=mecka.net header.i=@mecka.net header.b=kt9QHgKq reason="key not found in DNS"; arc=none smtp.client-ip=159.69.159.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mecka.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mecka.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mecka.net; s=2016.11;
	t=1714727807; bh=7Bo2cSz7OHrxMRYOFOuGmSNObiTSXZOJDjl3T6Pcx5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kt9QHgKq2Oy9+F6Y/kCyafgWWOl7OhQF2AacYfpimVvXsutIXooTvnuCn5V7p+Ogv
	 kiDndJne3hv7/wmyYUDgekZ2pDPm+CsqrBKCBjBI2JCj4x79OJce/Au9hfQKR3tN2a
	 Gwna/ulTF48e9Xp0OxFxn/q2Lg/lRVCknV5W1fonAcX9nzaB//b4ASImVIEYRpJF3s
	 sst/CoId7q0Aco8l6CtBllTa1RgQlvrz4NZfAFGVTOG1qYL8NOvhWxurquOs3URIAJ
	 vn9DxaEN7UnvzQ9dYLu6GtL0ntDuNCLtQGMNaD2eJWbS7C0vP+GcHUZZGCnS+YFCJ6
	 NMhJ8wxTOPvkA==
Received: from mecka.net (unknown [185.147.11.134])
	by mecka.net (Postfix) with ESMTPSA id 3B5494945CF;
	Fri,  3 May 2024 11:16:47 +0200 (CEST)
Date: Fri, 3 May 2024 11:16:42 +0200
From: Manuel Traut <manut@mecka.net>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	op-tee@lists.trustedfirmware.org,
	Shyam Saini <shyamsaini@linux.microsoft.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jerome Forissier <jerome.forissier@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>
Subject: Re: [PATCH v5 2/3] mmc: block: register RPMB partition with the RPMB
 subsystem
Message-ID: <ZjSrelq-R7x9Mjc0@mecka.net>
References: <20240422091936.3714381-3-jens.wiklander@linaro.org>
 <ZioXkvnIw5V5MXBU@mecka.net>
 <CAHUa44Fojanryuc+ciJrVZUopRLcTt2teS_pC4BBjt1Wmy240A@mail.gmail.com>
 <Zi9rKzz8u8z7cIy0@mecka.net>
 <CAHUa44HHtcaYXhcWg5zL5EQ8pEP7aEDKS+yjpaMJH8vTtF3xFw@mail.gmail.com>
 <Zi93_0aCq9mQ_6cD@mecka.net>
 <CAHUa44FG3ge3nyQVStKjfpeJvpjuQjNiZsxHjyRz+CUjHwkS=g@mail.gmail.com>
 <CAHUa44EecehfyzE97z49e=-qA513um21JyJz_CNKweuctp=HoQ@mail.gmail.com>
 <Zi-c6QXySx78JoJ_@mecka.net>
 <CAHUa44F1GrHpg4tatm_3+c9sg=CBWMjpdU5YE9BmQKRa+5vvaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHUa44F1GrHpg4tatm_3+c9sg=CBWMjpdU5YE9BmQKRa+5vvaQ@mail.gmail.com>

On Thu, May 02, 2024 at 11:53:40AM +0200, Jens Wiklander wrote:
> On Mon, Apr 29, 2024 at 3:13 PM Manuel Traut <manut@mecka.net> wrote:
> >
> > On Mon, Apr 29, 2024 at 01:13:58PM +0200, Jens Wiklander wrote:
> > > On Mon, Apr 29, 2024 at 12:45 PM Jens Wiklander
> > > <jens.wiklander@linaro.org> wrote:
> > > >
> > > > On Mon, Apr 29, 2024 at 12:35 PM Manuel Traut <manut@mecka.net> wrote:
> > > > >
> > > > > On Mon, Apr 29, 2024 at 12:08:45PM +0200, Jens Wiklander wrote:
> > > > > > On Mon, Apr 29, 2024 at 11:41 AM Manuel Traut <manut@mecka.net> wrote:
> > > > > > >
> > > > > > > On Fri, Apr 26, 2024 at 03:24:21PM +0200, Jens Wiklander wrote:
> > > > > > > > On Thu, Apr 25, 2024 at 10:43 AM Manuel Traut <manut@mecka.net> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, Apr 22, 2024 at 11:19:35AM +0200, Jens Wiklander wrote:
> > > > > > > > > > Register eMMC RPMB partition with the RPMB subsystem and provide
> > > > > > > > > > an implementation for the RPMB access operations abstracting
> > > > > > > > > > the actual multi step process.
> > > > > > > > > >
> > > > > > > > > > Add a callback to extract the needed device information at registration
> > > > > > > > > > to avoid accessing the struct mmc_card at a later stage as we're not
> > > > > > > > > > holding a reference counter for this struct.
> > > > > > > > > >
> > > > > > > > > > Taking the needed reference to md->disk in mmc_blk_alloc_rpmb_part()
> > > > > > > > > > instead of in mmc_rpmb_chrdev_open(). This is needed by the
> > > > > > > > > > route_frames() function pointer in struct rpmb_ops.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > > > > > > > > > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> > > > > > > > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > > > > > > ---
> > > > > > > > > >  drivers/mmc/core/block.c | 241 ++++++++++++++++++++++++++++++++++++++-
> > > > > > > > > >  1 file changed, 239 insertions(+), 2 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > > > > > > > > > index 32d49100dff5..a7f126fbc605 100644
> > > > > > > > > > --- a/drivers/mmc/core/block.c
> > > > > > > > > > +++ b/drivers/mmc/core/block.c
> > > > > > > > > > @@ -33,6 +33,7 @@
> > > > > > > > > >  #include <linux/cdev.h>
> > > > > > > > > >  #include <linux/mutex.h>
> > > > > > > > > >  #include <linux/scatterlist.h>
> > > > > > > > > > +#include <linux/string.h>
> > > > > > > > > >  #include <linux/string_helpers.h>
> > > > > > > > > >  #include <linux/delay.h>
> > > > > > > > > >  #include <linux/capability.h>
> > > > > > > > > > @@ -40,6 +41,7 @@
> > > > > > > > > >  #include <linux/pm_runtime.h>
> > > > > > > > > >  #include <linux/idr.h>
> > > > > > > > > >  #include <linux/debugfs.h>
> > > > > > > > > > +#include <linux/rpmb.h>
> > > > > > > > > >
> > > > > > > > > >  #include <linux/mmc/ioctl.h>
> > > > > > > > > >  #include <linux/mmc/card.h>
> > > > > > > > > > @@ -76,6 +78,48 @@ MODULE_ALIAS("mmc:block");
> > > > > > > > > >  #define MMC_EXTRACT_INDEX_FROM_ARG(x) ((x & 0x00FF0000) >> 16)
> > > > > > > > > >  #define MMC_EXTRACT_VALUE_FROM_ARG(x) ((x & 0x0000FF00) >> 8)
> > > > > > > > > >
> > > > > > > > > > +/**
> > > > > > > > > > + * struct rpmb_frame - rpmb frame as defined by eMMC 5.1 (JESD84-B51)
> > > > > > > > > > + *
> > > > > > > > > > + * @stuff        : stuff bytes
> > > > > > > > > > + * @key_mac      : The authentication key or the message authentication
> > > > > > > > > > + *                 code (MAC) depending on the request/response type.
> > > > > > > > > > + *                 The MAC will be delivered in the last (or the only)
> > > > > > > > > > + *                 block of data.
> > > > > > > > > > + * @data         : Data to be written or read by signed access.
> > > > > > > > > > + * @nonce        : Random number generated by the host for the requests
> > > > > > > > > > + *                 and copied to the response by the RPMB engine.
> > > > > > > > > > + * @write_counter: Counter value for the total amount of the successful
> > > > > > > > > > + *                 authenticated data write requests made by the host.
> > > > > > > > > > + * @addr         : Address of the data to be programmed to or read
> > > > > > > > > > + *                 from the RPMB. Address is the serial number of
> > > > > > > > > > + *                 the accessed block (half sector 256B).
> > > > > > > > > > + * @block_count  : Number of blocks (half sectors, 256B) requested to be
> > > > > > > > > > + *                 read/programmed.
> > > > > > > > > > + * @result       : Includes information about the status of the write counter
> > > > > > > > > > + *                 (valid, expired) and result of the access made to the RPMB.
> > > > > > > > > > + * @req_resp     : Defines the type of request and response to/from the memory.
> > > > > > > > > > + *
> > > > > > > > > > + * The stuff bytes and big-endian properties are modeled to fit to the spec.
> > > > > > > > > > + */
> > > > > > > > > > +struct rpmb_frame {
> > > > > > > > > > +     u8     stuff[196];
> > > > > > > > > > +     u8     key_mac[32];
> > > > > > > > > > +     u8     data[256];
> > > > > > > > > > +     u8     nonce[16];
> > > > > > > > > > +     __be32 write_counter;
> > > > > > > > > > +     __be16 addr;
> > > > > > > > > > +     __be16 block_count;
> > > > > > > > > > +     __be16 result;
> > > > > > > > > > +     __be16 req_resp;
> > > > > > > > > > +} __packed;
> > > > > > > > > > +
> > > > > > > > > > +#define RPMB_PROGRAM_KEY       0x1    /* Program RPMB Authentication Key */
> > > > > > > > > > +#define RPMB_GET_WRITE_COUNTER 0x2    /* Read RPMB write counter */
> > > > > > > > > > +#define RPMB_WRITE_DATA        0x3    /* Write data to RPMB partition */
> > > > > > > > > > +#define RPMB_READ_DATA         0x4    /* Read data from RPMB partition */
> > > > > > > > > > +#define RPMB_RESULT_READ       0x5    /* Read result request  (Internal) */
> > > > > > > > > > +
> > > > > > > > > >  static DEFINE_MUTEX(block_mutex);
> > > > > > > > > >
> > > > > > > > > >  /*
> > > > > > > > > > @@ -163,6 +207,7 @@ struct mmc_rpmb_data {
> > > > > > > > > >       int id;
> > > > > > > > > >       unsigned int part_index;
> > > > > > > > > >       struct mmc_blk_data *md;
> > > > > > > > > > +     struct rpmb_dev *rdev;
> > > > > > > > > >       struct list_head node;
> > > > > > > > > >  };
> > > > > > > > > >
> > > > > > > > > > @@ -2672,7 +2717,6 @@ static int mmc_rpmb_chrdev_open(struct inode *inode, struct file *filp)
> > > > > > > > > >
> > > > > > > > > >       get_device(&rpmb->dev);
> > > > > > > > > >       filp->private_data = rpmb;
> > > > > > > > > > -     mmc_blk_get(rpmb->md->disk);
> > > > > > > > > >
> > > > > > > > > >       return nonseekable_open(inode, filp);
> > > > > > > > > >  }
> > > > > > > > > > @@ -2682,7 +2726,6 @@ static int mmc_rpmb_chrdev_release(struct inode *inode, struct file *filp)
> > > > > > > > > >       struct mmc_rpmb_data *rpmb = container_of(inode->i_cdev,
> > > > > > > > > >                                                 struct mmc_rpmb_data, chrdev);
> > > > > > > > > >
> > > > > > > > > > -     mmc_blk_put(rpmb->md);
> > > > > > > > > >       put_device(&rpmb->dev);
> > > > > > > > > >
> > > > > > > > > >       return 0;
> > > > > > > > > > @@ -2703,10 +2746,165 @@ static void mmc_blk_rpmb_device_release(struct device *dev)
> > > > > > > > > >  {
> > > > > > > > > >       struct mmc_rpmb_data *rpmb = dev_get_drvdata(dev);
> > > > > > > > > >
> > > > > > > > > > +     rpmb_dev_unregister(rpmb->rdev);
> > > > > > > > > > +     mmc_blk_put(rpmb->md);
> > > > > > > > > >       ida_simple_remove(&mmc_rpmb_ida, rpmb->id);
> > > > > > > > > >       kfree(rpmb);
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > > +static void free_idata(struct mmc_blk_ioc_data **idata, unsigned int cmd_count)
> > > > > > > > > > +{
> > > > > > > > > > +     unsigned int n;
> > > > > > > > > > +
> > > > > > > > > > +     for (n = 0; n < cmd_count; n++)
> > > > > > > > > > +             kfree(idata[n]);
> > > > > > > > > > +     kfree(idata);
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +static struct mmc_blk_ioc_data **alloc_idata(struct mmc_rpmb_data *rpmb,
> > > > > > > > > > +                                          unsigned int cmd_count)
> > > > > > > > > > +{
> > > > > > > > > > +     struct mmc_blk_ioc_data **idata;
> > > > > > > > > > +     unsigned int n;
> > > > > > > > > > +
> > > > > > > > > > +     idata = kcalloc(cmd_count, sizeof(*idata), GFP_KERNEL);
> > > > > > > > > > +     if (!idata)
> > > > > > > > > > +             return NULL;
> > > > > > > > > > +     for (n = 0; n < cmd_count; n++) {
> > > > > > > > > > +             idata[n] = kcalloc(1, sizeof(**idata), GFP_KERNEL);
> > > > > > > > > > +             if (!idata[n]) {
> > > > > > > > > > +                     free_idata(idata, n);
> > > > > > > > > > +                     return NULL;
> > > > > > > > > > +             }
> > > > > > > > > > +             idata[n]->rpmb = rpmb;
> > > > > > > > > > +     }
> > > > > > > > > > +
> > > > > > > > > > +     return idata;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +static void set_idata(struct mmc_blk_ioc_data *idata, u32 opcode,
> > > > > > > > > > +                   int write_flag, u8 *buf, unsigned int buf_bytes)
> > > > > > > > > > +{
> > > > > > > > > > +     /*
> > > > > > > > > > +      * The size of an RPMB frame must match what's expected by the
> > > > > > > > > > +      * hardware.
> > > > > > > > > > +      */
> > > > > > > > > > +     BUILD_BUG_ON(sizeof(struct rpmb_frame) != 512);
> > > > > > > > > > +
> > > > > > > > > > +     idata->ic.opcode = opcode;
> > > > > > > > > > +     idata->ic.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
> > > > > > > > > > +     idata->ic.write_flag = write_flag;
> > > > > > > > > > +     idata->ic.blksz = sizeof(struct rpmb_frame);
> > > > > > > > > > +     idata->ic.blocks = buf_bytes /  idata->ic.blksz;
> > > > > > > > > > +     idata->buf = buf;
> > > > > > > > >
> > > > > > > > > I tested the series on a i.MX8MM with a eMMC connected via the imx-sdhci
> > > > > > > > > controller. Reading from RPMB does not work. It ends in timeouts due to
> > > > > > > > > no response from the SDHCI controller.
> > > > > > > > >
> > > > > > > > > If idata->buf is allocated here with kmalloc(buf_bytes, GFP_KERNEL) and
> > > > > > > > > the content of buf is copied to the new allocated area, transfers succeed.
> > > > > > > > >
> > > > > > > > > Is it possible that idata->buf is not DMA capable? Any other ideas?
> > > > > > > >
> > > > > > > > Thanks for testing. I don't know, the idata->buf is allocated using
> > > > > > > > alloc_pages_exact(nr_pages * PAGE_SIZE, GFP_KERNEL | __GFP_ZERO); in
> > > > > > > > optee_pool_op_alloc_helper().
> > > > > > >
> > > > > > > Is this really true for idata->buf or isnt the complete RPMB frame memory
> > > > > > > allocated like this and therefore idata->buf not page aligned?
> > > > > >
> > > > > > You're right.
> > > > > >
> > > > > > >
> > > > > > > For RPMB via tee-supplicant the idata->buf is allocated within memdup_user
> > > > > > > and therefore page aligned.
> > > > > >
> > > > > > Yes, that's a difference. Have you tested with page-aligned buffers to
> > > > > > see if it helps?
> > > > >
> > > > > Yes, this helps. I tested with the following patch, but probably it can also
> > > > > be solved during frame allocation in optee?
> > > >
> > > > Great, thanks for confirming. Yes, we should fix that in the secure world.
> > >
> > > I've pushed an update to
> > > https://github.com/jenswi-linaro/optee_os/tree/rpmb_probe
> >
> > Thanks for taking care. I applied the additional patch
> >
> > https://github.com/OP-TEE/optee_os/commit/cdbe8d149f1eed62bc8ef9137d208858bb7691d8.patch
> >
> > to optee_os and removed the kmalloc dynalloc hack mentioned before from the
> > kernel.
> >
> > The issue persists, please see below.
> 
> So it's not the alignment that is the problem. We need to understand
> this problem better before adding workarounds. If I'm not mistaken,
> alloc_pages_exact () and kmalloc() are supposed to provide DMAable
> memory. Could this be a symptom of some other error in your system?

It seems to be still the alignment problem. With a debug print
to print the address in the linux kernel alloc_helper:

+++ b/drivers/tee/optee/core.c
@@ -42,6 +42,7 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
                return -ENOMEM;

        shm->paddr = virt_to_phys(shm->kaddr);
+       printk(KERN_ERR "%s: phys: %p virt: %p", __func__, shm->paddr, shm->kaddr);
        shm->size = nr_pages * PAGE_SIZE;

in optee_os:

--- a/core/tee/tee_rpmb_fs.c
+++ b/core/tee/tee_rpmb_fs.c
@@ -438,6 +438,7 @@ static TEE_Result tee_rpmb_alloc(size_t req_size, size_t resp_size,

        *req = mobj_get_va(mem->mobj, 0, req_s);
        *resp = mobj_get_va(mem->mobj, req_s, resp_s);
+       EMSG("RPMB req: %p resp: %p", *req, *resp);


and in the kernel if PAGE_ALIGNED is not true in mmc frame routing:


@@ -2801,9 +2803,24 @@ static void set_idata(struct mmc_blk_ioc_data *idata, u32 opcode,
        idata->ic.blksz = sizeof(struct rpmb_frame);
        idata->ic.blocks = buf_bytes /  idata->ic.blksz;
        idata->buf = buf;
+       if (!PAGE_ALIGNED(idata->buf)) {
+           printk(KERN_ERR "RPMB FRAME IS NOT PAGE ALIGNED: %p", idata->buf);
+       }


it looks strange to me:

[   20.976798] optee_pool_op_alloc_helper: phys: 000000006e87bb2a virt: 00000000c90be80d
E/TC:? 0 tee_rpmb_alloc:441 RPMB req: 0xbbe01000 resp: 0xbbe02000
[   20.983028] RPMB FRAME IS NOT PAGE ALIGNED: 000000000160f4bd

I will try to understand what is going on..

Thanks,
Manuel

> > E/TC:? 0
> > E/TC:? 0 TA panicked with code 0xffff0006
> > [   18.661761] mmc0: Timeout waiting for hardware interrupt.
> > [   18.661776] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> > E/LD:  Status of TA bc50d971-d4c9-42c4-82cb-343fb7f37896
> > E/LD:   arch: arm
> > E/LD:  region  0: va 0x40005000 pa 0xbe81b000 size 0x002000 flags rw-s (ldelf)
> > E/LD:  region  1: va 0x40007000 pa 0xbe81d000 size 0x008000 flags r-xs (ldelf)
> > E/LD:  region  2: va 0x4000f000 pa 0xbe825000 size 0x001000 flags rw-s (ldelf)
> > E/LD:  region  3: va 0x40010000 pa 0xbe826000 size 0x004000 flags rw-s (ldelf)
> > E/LD:  region  4: va 0x40014000 pa 0xbe82a000 size 0x001000 flags r--s
> > E/LD:  region  5: va 0x40015000 pa 0xbe88b000 size 0x011000 flags rw-s (stack)
> > E/LD:  region  6: va 0x40026000 pa 0x534f8000 size 0x002000 flags rw-- (param)
> > E/LD:  region  7: va 0x40035000 pa 0x00001000 size 0x042000 flags r-xs [0]
> > E/LD:  region  8: va 0x40077000 pa 0x00043000 size 0x01e000 flags rw-s [0]
> > E/LD:   [0] bc50d971-d4c9-42c4-82cb-343fb7f37896 @ 0x40035000
> > E/LD:  Call stack:
> > E/LD:   0x40064d48
> > E/LD:   0x40060c17
> > E/LD:   0x40037d81
> > E/LD:   0x40038223
> > E/LD:   0x4004d343
> > E/LD:   0x4005d52d
> > E/LD:   0x4003885f
> > E/LD:   0x40064cd9
> > E/LD:   0x4006a8a3
> > E/LD:   0x4005d68c
> > [   18.661782] mmc0: sdhci: Sys addr:  0x00000008 | Version:  0x00000002
> > [   18.661790] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000006
> > [   18.661796] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x0000003b
> > [   18.661802] mmc0: sdhci: Present:   0x01088a8e | Host ctl: 0x00000031
> > [   18.661808] mmc0: sdhci: Power:     0x00000002 | Blk gap:  0x00000080
> > [   18.661814] mmc0: sdhci: Wake-up:   0x00000008 | Clock:    0x0000000f
> > [   18.661820] mmc0: sdhci: Timeout:   0x0000008f | Int stat: 0x00000000
> > [   18.661825] mmc0: sdhci: Int enab:  0x117f100b | Sig enab: 0x117f100b
> > [   18.661831] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000502
> > [   18.661837] mmc0: sdhci: Caps:      0x07eb0000 | Caps_1:   0x0000b407
> > [   18.661842] mmc0: sdhci: Cmd:       0x0000123a | Max curr: 0x00ffffff
> > [   18.661848] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffff
> > [   18.661856] mmc0: sdhci: Resp[2]:   0x328f5903 | Resp[3]:  0x00000900
> > [   18.661862] mmc0: sdhci: Host ctl2: 0x00000008
> > [   18.661868] mmc0: sdhci: ADMA Err:  0x00000007 | ADMA Ptr: 0x412c0200
> > [   18.661874] mmc0: sdhci-esdhc-imx: ========= ESDHC IMX DEBUG STATUS DUMP =========
> > [   18.661879] mmc0: sdhci-esdhc-imx: cmd debug status:  0x2120
> > [   18.661885] mmc0: sdhci-esdhc-imx: data debug status:  0x22d0
> > [   18.661893] mmc0: sdhci-esdhc-imx: trans debug status:  0x23c0
> > [   18.661900] mmc0: sdhci-esdhc-imx: dma debug status:  0x2400
> > [   18.661907] mmc0: sdhci-esdhc-imx: adma debug status:  0x25b4
> > [   18.661915] mmc0: sdhci-esdhc-imx: fifo debug status:  0x2650
> > [   18.661922] mmc0: sdhci-esdhc-imx: async fifo debug status:  0x2760
> > [   18.661929] mmc0: sdhci: ============================================
> > [   18.662615] sdhci-esdhc-imx 30b40000.mmc: __mmc_blk_ioctl_cmd: data error -110
> > [   18.772374] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke error: 0xffff3024
> > [   18.772393] tpm tpm0: tpm_try_transmit: send(): error -53212
> > [   18.772447] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke error: 0xffff3024
> > [   18.772455] tpm tpm0: tpm_try_transmit: send(): error -53212
> > [   18.772465] ftpm-tee tpm: ftpm_tee_probe: tpm_chip_register failed with rc=-53212
> > [   18.772545] ftpm-tee: probe of tpm failed with error -53212
> > [   19.430011] caam_jr 30902000.jr: 20000254: CCB: desc idx 2: RNG: Not instantiated
> > [   28.901794] mmc0: Timeout waiting for hardware interrupt.
> > [  *** ] (1 of 2) Job dev-tpmrm0.device/start running (37s / 1min 30s)
> > [ ***  ] (2 of 2) Job dev-tpm0.device/start running (47s / 1min 30s)
> > [ ***  ] (2 of 2) Job dev-tpm0.device/start
> >
> 

