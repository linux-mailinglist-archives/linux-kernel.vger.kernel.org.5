Return-Path: <linux-kernel+bounces-162001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6259E8B5464
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85A5A1C20F96
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AA124B34;
	Mon, 29 Apr 2024 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mecka.net header.i=@mecka.net header.b="j/+AENdG"
Received: from mecka.net (mecka.net [159.69.159.214])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4735171C9;
	Mon, 29 Apr 2024 09:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.159.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714383677; cv=none; b=a5Ee6MnHM4msHMIJNSB9an83QJOjPUPQXcywW0la7YMRQks3Kx3UCCz7Nn/fEKJ6WvFP9G8z2b+4w3rBC7wgxHg14LnBI8JNBOA7pCEBPhWnb+9zQrvEMfi+8mCmryUGaDZx5OctXPvejlJ9p+mDoEMR96+ckCh9yfWBTDjkyHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714383677; c=relaxed/simple;
	bh=lOtwTB1hQGTZTb9sPzIaDFMAGjapJfjC6odRs5U7n1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cr0h5EWGSH9+yQuD/oL4doxmVkDyKl8Uz2Z9TUJ5vpHeMhwy2MqscuyBRmjdYVwcQHQgtjygSjyWE1s4dEsbGzajScrB1Q3Ddtj2DFloduzT32q7WeIwGTcRP9/vgKrUVR4GPi84xPMwhwEf6mjoBhw/GY52eOmdlse9ReI/LkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mecka.net; spf=pass smtp.mailfrom=mecka.net; dkim=fail (0-bit key) header.d=mecka.net header.i=@mecka.net header.b=j/+AENdG reason="key not found in DNS"; arc=none smtp.client-ip=159.69.159.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mecka.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mecka.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mecka.net; s=2016.11;
	t=1714383666; bh=lOtwTB1hQGTZTb9sPzIaDFMAGjapJfjC6odRs5U7n1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j/+AENdGEJgLUzRuxmAVjBTu1Dv7L3DB6tnXIZ3HyfHC7UrUrIh4UQVnGzelkpl64
	 wcBXG5etvmD5mw+PRGuUlvV324jyhFDyBddwaEipT/1KFeHzTPH6pFkQRJSft1Nq14
	 R/kpWApQ845bATayE4z0UunU1RL5zfTgQiUY5PUEm78yBXX9V8U3E65vy1QuXDO+tO
	 G6JC637ROQOHIqbLByCbzNG3hp/mqqzTNlbnlEO2v/qxZjZNHzxts/8hbt9v8rEs/e
	 +dIbTG4P6ajgKN1qRXi+//d5+hjhrxROHbgsDGnjsW+JYmS3ckCIQVyWU3KAoDyuhe
	 sDW3z+9n3gGVA==
Received: from mecka.net (unknown [185.147.11.134])
	by mecka.net (Postfix) with ESMTPSA id 5191747C02B;
	Mon, 29 Apr 2024 11:41:05 +0200 (CEST)
Date: Mon, 29 Apr 2024 11:40:59 +0200
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
Message-ID: <Zi9rKzz8u8z7cIy0@mecka.net>
References: <20240422091936.3714381-1-jens.wiklander@linaro.org>
 <20240422091936.3714381-3-jens.wiklander@linaro.org>
 <ZioXkvnIw5V5MXBU@mecka.net>
 <CAHUa44Fojanryuc+ciJrVZUopRLcTt2teS_pC4BBjt1Wmy240A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHUa44Fojanryuc+ciJrVZUopRLcTt2teS_pC4BBjt1Wmy240A@mail.gmail.com>

On Fri, Apr 26, 2024 at 03:24:21PM +0200, Jens Wiklander wrote:
> On Thu, Apr 25, 2024 at 10:43 AM Manuel Traut <manut@mecka.net> wrote:
> >
> > On Mon, Apr 22, 2024 at 11:19:35AM +0200, Jens Wiklander wrote:
> > > Register eMMC RPMB partition with the RPMB subsystem and provide
> > > an implementation for the RPMB access operations abstracting
> > > the actual multi step process.
> > >
> > > Add a callback to extract the needed device information at registration
> > > to avoid accessing the struct mmc_card at a later stage as we're not
> > > holding a reference counter for this struct.
> > >
> > > Taking the needed reference to md->disk in mmc_blk_alloc_rpmb_part()
> > > instead of in mmc_rpmb_chrdev_open(). This is needed by the
> > > route_frames() function pointer in struct rpmb_ops.
> > >
> > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > ---
> > >  drivers/mmc/core/block.c | 241 ++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 239 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > > index 32d49100dff5..a7f126fbc605 100644
> > > --- a/drivers/mmc/core/block.c
> > > +++ b/drivers/mmc/core/block.c
> > > @@ -33,6 +33,7 @@
> > >  #include <linux/cdev.h>
> > >  #include <linux/mutex.h>
> > >  #include <linux/scatterlist.h>
> > > +#include <linux/string.h>
> > >  #include <linux/string_helpers.h>
> > >  #include <linux/delay.h>
> > >  #include <linux/capability.h>
> > > @@ -40,6 +41,7 @@
> > >  #include <linux/pm_runtime.h>
> > >  #include <linux/idr.h>
> > >  #include <linux/debugfs.h>
> > > +#include <linux/rpmb.h>
> > >
> > >  #include <linux/mmc/ioctl.h>
> > >  #include <linux/mmc/card.h>
> > > @@ -76,6 +78,48 @@ MODULE_ALIAS("mmc:block");
> > >  #define MMC_EXTRACT_INDEX_FROM_ARG(x) ((x & 0x00FF0000) >> 16)
> > >  #define MMC_EXTRACT_VALUE_FROM_ARG(x) ((x & 0x0000FF00) >> 8)
> > >
> > > +/**
> > > + * struct rpmb_frame - rpmb frame as defined by eMMC 5.1 (JESD84-B51)
> > > + *
> > > + * @stuff        : stuff bytes
> > > + * @key_mac      : The authentication key or the message authentication
> > > + *                 code (MAC) depending on the request/response type.
> > > + *                 The MAC will be delivered in the last (or the only)
> > > + *                 block of data.
> > > + * @data         : Data to be written or read by signed access.
> > > + * @nonce        : Random number generated by the host for the requests
> > > + *                 and copied to the response by the RPMB engine.
> > > + * @write_counter: Counter value for the total amount of the successful
> > > + *                 authenticated data write requests made by the host.
> > > + * @addr         : Address of the data to be programmed to or read
> > > + *                 from the RPMB. Address is the serial number of
> > > + *                 the accessed block (half sector 256B).
> > > + * @block_count  : Number of blocks (half sectors, 256B) requested to be
> > > + *                 read/programmed.
> > > + * @result       : Includes information about the status of the write counter
> > > + *                 (valid, expired) and result of the access made to the RPMB.
> > > + * @req_resp     : Defines the type of request and response to/from the memory.
> > > + *
> > > + * The stuff bytes and big-endian properties are modeled to fit to the spec.
> > > + */
> > > +struct rpmb_frame {
> > > +     u8     stuff[196];
> > > +     u8     key_mac[32];
> > > +     u8     data[256];
> > > +     u8     nonce[16];
> > > +     __be32 write_counter;
> > > +     __be16 addr;
> > > +     __be16 block_count;
> > > +     __be16 result;
> > > +     __be16 req_resp;
> > > +} __packed;
> > > +
> > > +#define RPMB_PROGRAM_KEY       0x1    /* Program RPMB Authentication Key */
> > > +#define RPMB_GET_WRITE_COUNTER 0x2    /* Read RPMB write counter */
> > > +#define RPMB_WRITE_DATA        0x3    /* Write data to RPMB partition */
> > > +#define RPMB_READ_DATA         0x4    /* Read data from RPMB partition */
> > > +#define RPMB_RESULT_READ       0x5    /* Read result request  (Internal) */
> > > +
> > >  static DEFINE_MUTEX(block_mutex);
> > >
> > >  /*
> > > @@ -163,6 +207,7 @@ struct mmc_rpmb_data {
> > >       int id;
> > >       unsigned int part_index;
> > >       struct mmc_blk_data *md;
> > > +     struct rpmb_dev *rdev;
> > >       struct list_head node;
> > >  };
> > >
> > > @@ -2672,7 +2717,6 @@ static int mmc_rpmb_chrdev_open(struct inode *inode, struct file *filp)
> > >
> > >       get_device(&rpmb->dev);
> > >       filp->private_data = rpmb;
> > > -     mmc_blk_get(rpmb->md->disk);
> > >
> > >       return nonseekable_open(inode, filp);
> > >  }
> > > @@ -2682,7 +2726,6 @@ static int mmc_rpmb_chrdev_release(struct inode *inode, struct file *filp)
> > >       struct mmc_rpmb_data *rpmb = container_of(inode->i_cdev,
> > >                                                 struct mmc_rpmb_data, chrdev);
> > >
> > > -     mmc_blk_put(rpmb->md);
> > >       put_device(&rpmb->dev);
> > >
> > >       return 0;
> > > @@ -2703,10 +2746,165 @@ static void mmc_blk_rpmb_device_release(struct device *dev)
> > >  {
> > >       struct mmc_rpmb_data *rpmb = dev_get_drvdata(dev);
> > >
> > > +     rpmb_dev_unregister(rpmb->rdev);
> > > +     mmc_blk_put(rpmb->md);
> > >       ida_simple_remove(&mmc_rpmb_ida, rpmb->id);
> > >       kfree(rpmb);
> > >  }
> > >
> > > +static void free_idata(struct mmc_blk_ioc_data **idata, unsigned int cmd_count)
> > > +{
> > > +     unsigned int n;
> > > +
> > > +     for (n = 0; n < cmd_count; n++)
> > > +             kfree(idata[n]);
> > > +     kfree(idata);
> > > +}
> > > +
> > > +static struct mmc_blk_ioc_data **alloc_idata(struct mmc_rpmb_data *rpmb,
> > > +                                          unsigned int cmd_count)
> > > +{
> > > +     struct mmc_blk_ioc_data **idata;
> > > +     unsigned int n;
> > > +
> > > +     idata = kcalloc(cmd_count, sizeof(*idata), GFP_KERNEL);
> > > +     if (!idata)
> > > +             return NULL;
> > > +     for (n = 0; n < cmd_count; n++) {
> > > +             idata[n] = kcalloc(1, sizeof(**idata), GFP_KERNEL);
> > > +             if (!idata[n]) {
> > > +                     free_idata(idata, n);
> > > +                     return NULL;
> > > +             }
> > > +             idata[n]->rpmb = rpmb;
> > > +     }
> > > +
> > > +     return idata;
> > > +}
> > > +
> > > +static void set_idata(struct mmc_blk_ioc_data *idata, u32 opcode,
> > > +                   int write_flag, u8 *buf, unsigned int buf_bytes)
> > > +{
> > > +     /*
> > > +      * The size of an RPMB frame must match what's expected by the
> > > +      * hardware.
> > > +      */
> > > +     BUILD_BUG_ON(sizeof(struct rpmb_frame) != 512);
> > > +
> > > +     idata->ic.opcode = opcode;
> > > +     idata->ic.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
> > > +     idata->ic.write_flag = write_flag;
> > > +     idata->ic.blksz = sizeof(struct rpmb_frame);
> > > +     idata->ic.blocks = buf_bytes /  idata->ic.blksz;
> > > +     idata->buf = buf;
> >
> > I tested the series on a i.MX8MM with a eMMC connected via the imx-sdhci
> > controller. Reading from RPMB does not work. It ends in timeouts due to
> > no response from the SDHCI controller.
> >
> > If idata->buf is allocated here with kmalloc(buf_bytes, GFP_KERNEL) and
> > the content of buf is copied to the new allocated area, transfers succeed.
> >
> > Is it possible that idata->buf is not DMA capable? Any other ideas?
> 
> Thanks for testing. I don't know, the idata->buf is allocated using
> alloc_pages_exact(nr_pages * PAGE_SIZE, GFP_KERNEL | __GFP_ZERO); in
> optee_pool_op_alloc_helper().

Is this really true for idata->buf or isnt the complete RPMB frame memory
allocated like this and therefore idata->buf not page aligned?

For RPMB via tee-supplicant the idata->buf is allocated within memdup_user
and therefore page aligned.

> Alternatively, it's from the memory
> range mapped using memremap() in optee_config_shm_memremap(), but
> that's only if you don't have "dynamic shared memory is enabled" in
> the boot log.

"dynamic shared memory is enabled" is in the bootlog, ..

Thanks for your comments,
Manuel

