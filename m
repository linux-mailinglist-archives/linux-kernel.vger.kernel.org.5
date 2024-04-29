Return-Path: <linux-kernel+bounces-162018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2735D8B54BC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ACDA1C2185C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849932C19D;
	Mon, 29 Apr 2024 10:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j9p285Bt"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C6323778
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 10:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714385339; cv=none; b=Czqr74fN5+BApsdal50ux1bmNeel8DDhP18ipST5K0NqeozuS05UbW7BShhnkG5VDGzJQiHRMaa0+SFFRTLgwqXO3M76iJADMdPIcy6n8zk3SGZa5OIbthOPxgHUNqvkgdkbz8vrGB2k1Adq8GikOFhFjG1I0ysO2IVmDzGlGZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714385339; c=relaxed/simple;
	bh=0YwOBL9XEFWtJChj9O4DpfqC8u50r/IPY+o5Cnas8e4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UQf+Ubc+ntJtmWeGJKpj7Im4dCggz3IYE+hQAAJVOdMqNTeY5bA7r7Tm9doaxCQb9POt+vy3SccFhwNOE87YSGJUzYriwQtOa/PWSTXIysg9GyxqHNcuhNn9ydsf0af76Dveu41+3xs6R5uFTMbFmLSkf/Y3Fn/uSDLw6Cj5o1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j9p285Bt; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5aa2551d33dso3041055eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 03:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714385337; x=1714990137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gyittluF3hAMC8io2ukqkVu/PU9AQ4IktrhFU17l1s=;
        b=j9p285BtBxFe8rt0EUNKM3lnwY4f/wkS6fXa2uS8+WFlUHNQY2g8WwLxs2wlMv7iWE
         ECgych9vXqMqinZ5s+U7QB5OW+h/bafGon+5H34LYCxZSMtGGWtW2ZJAzwTNeVnLBuzq
         UJQzHCy1hMX+lUiVS1bNMfLaaiOHFouiM2MbcichTixk/9mUQ4Jk06AjxuitwATeNhAI
         zAWBLo5Xs5dFZVcIo/DH9kt8GQahSq929r8kfWe7AtVFWcejnB80qdKscjNUSfrq7Yrm
         8cNo2GCRMu/Ey4qmYmkL3tuqzBfSHvJny1+XhLVC4dzNopwTuyPP4ceOEU72rRYnG9bt
         aVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714385337; x=1714990137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9gyittluF3hAMC8io2ukqkVu/PU9AQ4IktrhFU17l1s=;
        b=bIgEwH+Sr0GojyJ/Mj5nly3g/KGwzBbEsNoSvA/oZwyjZRUuUB1NhWE8Pv8zdzsHha
         YH66NKFIFo9+32VpGDFxcbQvwjAeQHuZkRNmdih6FF08IHO7JEFPYmr86AR2IkuP8y4K
         +F5NutCFYG5G3yS+4C2iPg1j43q5xBGQUCTzjYrjtPpGRYgFqbJNDOZbfzAzvP1xH8fK
         Q1q9B5Oe4ZHkJWPxLBOTFg3e+b9DJYo1wBgWm+Jd5CbiFNouh+QpEu1pck4gvRqyYVSz
         0s7rxEXcnUP+dBoO99lAqGbEhcHgLk3rrbnvtPLN7zmPqJqI6LBENb++cd84BdLh905t
         m5dw==
X-Gm-Message-State: AOJu0Yxx7ZDV22gUuUyQUtW12Rlg/zdLQ1VtOSCyMAb7Br62WbZ+nmL3
	YzCQFtCfeTQIHoDv+mT/yRqyEW85TeCSioZjlMYqFVQPoi6CO+WOOG3xShTdGNHAtUuMmnNrMrF
	16X/GZ9/dKz4tVLJbW+UX0b1peQkEl3BlQRZpjg==
X-Google-Smtp-Source: AGHT+IESFvQgS5ubIMjDNjOpc4bhc/ZUx9oUV8/Yr0GtwTiypLvFvF/n21fz53JaY+ahnuE42RrwjMzpwmTK99NPweY=
X-Received: by 2002:a05:6871:4007:b0:233:5893:912d with SMTP id
 kx7-20020a056871400700b002335893912dmr10593829oab.44.1714385336712; Mon, 29
 Apr 2024 03:08:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422091936.3714381-1-jens.wiklander@linaro.org>
 <20240422091936.3714381-3-jens.wiklander@linaro.org> <ZioXkvnIw5V5MXBU@mecka.net>
 <CAHUa44Fojanryuc+ciJrVZUopRLcTt2teS_pC4BBjt1Wmy240A@mail.gmail.com> <Zi9rKzz8u8z7cIy0@mecka.net>
In-Reply-To: <Zi9rKzz8u8z7cIy0@mecka.net>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 29 Apr 2024 12:08:45 +0200
Message-ID: <CAHUa44HHtcaYXhcWg5zL5EQ8pEP7aEDKS+yjpaMJH8vTtF3xFw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] mmc: block: register RPMB partition with the RPMB subsystem
To: Manuel Traut <manut@mecka.net>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Jerome Forissier <jerome.forissier@linaro.org>, 
	Sumit Garg <sumit.garg@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Bart Van Assche <bvanassche@acm.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomas Winkler <tomas.winkler@intel.com>, 
	Alexander Usyskin <alexander.usyskin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 11:41=E2=80=AFAM Manuel Traut <manut@mecka.net> wro=
te:
>
> On Fri, Apr 26, 2024 at 03:24:21PM +0200, Jens Wiklander wrote:
> > On Thu, Apr 25, 2024 at 10:43=E2=80=AFAM Manuel Traut <manut@mecka.net>=
 wrote:
> > >
> > > On Mon, Apr 22, 2024 at 11:19:35AM +0200, Jens Wiklander wrote:
> > > > Register eMMC RPMB partition with the RPMB subsystem and provide
> > > > an implementation for the RPMB access operations abstracting
> > > > the actual multi step process.
> > > >
> > > > Add a callback to extract the needed device information at registra=
tion
> > > > to avoid accessing the struct mmc_card at a later stage as we're no=
t
> > > > holding a reference counter for this struct.
> > > >
> > > > Taking the needed reference to md->disk in mmc_blk_alloc_rpmb_part(=
)
> > > > instead of in mmc_rpmb_chrdev_open(). This is needed by the
> > > > route_frames() function pointer in struct rpmb_ops.
> > > >
> > > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > > > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > ---
> > > >  drivers/mmc/core/block.c | 241 +++++++++++++++++++++++++++++++++++=
+++-
> > > >  1 file changed, 239 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > > > index 32d49100dff5..a7f126fbc605 100644
> > > > --- a/drivers/mmc/core/block.c
> > > > +++ b/drivers/mmc/core/block.c
> > > > @@ -33,6 +33,7 @@
> > > >  #include <linux/cdev.h>
> > > >  #include <linux/mutex.h>
> > > >  #include <linux/scatterlist.h>
> > > > +#include <linux/string.h>
> > > >  #include <linux/string_helpers.h>
> > > >  #include <linux/delay.h>
> > > >  #include <linux/capability.h>
> > > > @@ -40,6 +41,7 @@
> > > >  #include <linux/pm_runtime.h>
> > > >  #include <linux/idr.h>
> > > >  #include <linux/debugfs.h>
> > > > +#include <linux/rpmb.h>
> > > >
> > > >  #include <linux/mmc/ioctl.h>
> > > >  #include <linux/mmc/card.h>
> > > > @@ -76,6 +78,48 @@ MODULE_ALIAS("mmc:block");
> > > >  #define MMC_EXTRACT_INDEX_FROM_ARG(x) ((x & 0x00FF0000) >> 16)
> > > >  #define MMC_EXTRACT_VALUE_FROM_ARG(x) ((x & 0x0000FF00) >> 8)
> > > >
> > > > +/**
> > > > + * struct rpmb_frame - rpmb frame as defined by eMMC 5.1 (JESD84-B=
51)
> > > > + *
> > > > + * @stuff        : stuff bytes
> > > > + * @key_mac      : The authentication key or the message authentic=
ation
> > > > + *                 code (MAC) depending on the request/response ty=
pe.
> > > > + *                 The MAC will be delivered in the last (or the o=
nly)
> > > > + *                 block of data.
> > > > + * @data         : Data to be written or read by signed access.
> > > > + * @nonce        : Random number generated by the host for the req=
uests
> > > > + *                 and copied to the response by the RPMB engine.
> > > > + * @write_counter: Counter value for the total amount of the succe=
ssful
> > > > + *                 authenticated data write requests made by the h=
ost.
> > > > + * @addr         : Address of the data to be programmed to or read
> > > > + *                 from the RPMB. Address is the serial number of
> > > > + *                 the accessed block (half sector 256B).
> > > > + * @block_count  : Number of blocks (half sectors, 256B) requested=
 to be
> > > > + *                 read/programmed.
> > > > + * @result       : Includes information about the status of the wr=
ite counter
> > > > + *                 (valid, expired) and result of the access made =
to the RPMB.
> > > > + * @req_resp     : Defines the type of request and response to/fro=
m the memory.
> > > > + *
> > > > + * The stuff bytes and big-endian properties are modeled to fit to=
 the spec.
> > > > + */
> > > > +struct rpmb_frame {
> > > > +     u8     stuff[196];
> > > > +     u8     key_mac[32];
> > > > +     u8     data[256];
> > > > +     u8     nonce[16];
> > > > +     __be32 write_counter;
> > > > +     __be16 addr;
> > > > +     __be16 block_count;
> > > > +     __be16 result;
> > > > +     __be16 req_resp;
> > > > +} __packed;
> > > > +
> > > > +#define RPMB_PROGRAM_KEY       0x1    /* Program RPMB Authenticati=
on Key */
> > > > +#define RPMB_GET_WRITE_COUNTER 0x2    /* Read RPMB write counter *=
/
> > > > +#define RPMB_WRITE_DATA        0x3    /* Write data to RPMB partit=
ion */
> > > > +#define RPMB_READ_DATA         0x4    /* Read data from RPMB parti=
tion */
> > > > +#define RPMB_RESULT_READ       0x5    /* Read result request  (Int=
ernal) */
> > > > +
> > > >  static DEFINE_MUTEX(block_mutex);
> > > >
> > > >  /*
> > > > @@ -163,6 +207,7 @@ struct mmc_rpmb_data {
> > > >       int id;
> > > >       unsigned int part_index;
> > > >       struct mmc_blk_data *md;
> > > > +     struct rpmb_dev *rdev;
> > > >       struct list_head node;
> > > >  };
> > > >
> > > > @@ -2672,7 +2717,6 @@ static int mmc_rpmb_chrdev_open(struct inode =
*inode, struct file *filp)
> > > >
> > > >       get_device(&rpmb->dev);
> > > >       filp->private_data =3D rpmb;
> > > > -     mmc_blk_get(rpmb->md->disk);
> > > >
> > > >       return nonseekable_open(inode, filp);
> > > >  }
> > > > @@ -2682,7 +2726,6 @@ static int mmc_rpmb_chrdev_release(struct ino=
de *inode, struct file *filp)
> > > >       struct mmc_rpmb_data *rpmb =3D container_of(inode->i_cdev,
> > > >                                                 struct mmc_rpmb_dat=
a, chrdev);
> > > >
> > > > -     mmc_blk_put(rpmb->md);
> > > >       put_device(&rpmb->dev);
> > > >
> > > >       return 0;
> > > > @@ -2703,10 +2746,165 @@ static void mmc_blk_rpmb_device_release(st=
ruct device *dev)
> > > >  {
> > > >       struct mmc_rpmb_data *rpmb =3D dev_get_drvdata(dev);
> > > >
> > > > +     rpmb_dev_unregister(rpmb->rdev);
> > > > +     mmc_blk_put(rpmb->md);
> > > >       ida_simple_remove(&mmc_rpmb_ida, rpmb->id);
> > > >       kfree(rpmb);
> > > >  }
> > > >
> > > > +static void free_idata(struct mmc_blk_ioc_data **idata, unsigned i=
nt cmd_count)
> > > > +{
> > > > +     unsigned int n;
> > > > +
> > > > +     for (n =3D 0; n < cmd_count; n++)
> > > > +             kfree(idata[n]);
> > > > +     kfree(idata);
> > > > +}
> > > > +
> > > > +static struct mmc_blk_ioc_data **alloc_idata(struct mmc_rpmb_data =
*rpmb,
> > > > +                                          unsigned int cmd_count)
> > > > +{
> > > > +     struct mmc_blk_ioc_data **idata;
> > > > +     unsigned int n;
> > > > +
> > > > +     idata =3D kcalloc(cmd_count, sizeof(*idata), GFP_KERNEL);
> > > > +     if (!idata)
> > > > +             return NULL;
> > > > +     for (n =3D 0; n < cmd_count; n++) {
> > > > +             idata[n] =3D kcalloc(1, sizeof(**idata), GFP_KERNEL);
> > > > +             if (!idata[n]) {
> > > > +                     free_idata(idata, n);
> > > > +                     return NULL;
> > > > +             }
> > > > +             idata[n]->rpmb =3D rpmb;
> > > > +     }
> > > > +
> > > > +     return idata;
> > > > +}
> > > > +
> > > > +static void set_idata(struct mmc_blk_ioc_data *idata, u32 opcode,
> > > > +                   int write_flag, u8 *buf, unsigned int buf_bytes=
)
> > > > +{
> > > > +     /*
> > > > +      * The size of an RPMB frame must match what's expected by th=
e
> > > > +      * hardware.
> > > > +      */
> > > > +     BUILD_BUG_ON(sizeof(struct rpmb_frame) !=3D 512);
> > > > +
> > > > +     idata->ic.opcode =3D opcode;
> > > > +     idata->ic.flags =3D MMC_RSP_R1 | MMC_CMD_ADTC;
> > > > +     idata->ic.write_flag =3D write_flag;
> > > > +     idata->ic.blksz =3D sizeof(struct rpmb_frame);
> > > > +     idata->ic.blocks =3D buf_bytes /  idata->ic.blksz;
> > > > +     idata->buf =3D buf;
> > >
> > > I tested the series on a i.MX8MM with a eMMC connected via the imx-sd=
hci
> > > controller. Reading from RPMB does not work. It ends in timeouts due =
to
> > > no response from the SDHCI controller.
> > >
> > > If idata->buf is allocated here with kmalloc(buf_bytes, GFP_KERNEL) a=
nd
> > > the content of buf is copied to the new allocated area, transfers suc=
ceed.
> > >
> > > Is it possible that idata->buf is not DMA capable? Any other ideas?
> >
> > Thanks for testing. I don't know, the idata->buf is allocated using
> > alloc_pages_exact(nr_pages * PAGE_SIZE, GFP_KERNEL | __GFP_ZERO); in
> > optee_pool_op_alloc_helper().
>
> Is this really true for idata->buf or isnt the complete RPMB frame memory
> allocated like this and therefore idata->buf not page aligned?

You're right.

>
> For RPMB via tee-supplicant the idata->buf is allocated within memdup_use=
r
> and therefore page aligned.

Yes, that's a difference. Have you tested with page-aligned buffers to
see if it helps?

>
> > Alternatively, it's from the memory
> > range mapped using memremap() in optee_config_shm_memremap(), but
> > that's only if you don't have "dynamic shared memory is enabled" in
> > the boot log.
>
> "dynamic shared memory is enabled" is in the bootlog, ..

Great.

Thanks,
Jens

