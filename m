Return-Path: <linux-kernel+bounces-160047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 779EF8B3848
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AB1E1C2129B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E69A1474AC;
	Fri, 26 Apr 2024 13:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oOwhrkb0"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F433146D5A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714137877; cv=none; b=ltrl/3mzCIXvT9kWAs787LrGg8etMMAjwDzI4gpAwEQ1J1Cbd+d/IpYLRBRSJbYtHcK851BAWipsuYDSPK7FEmpyhckkNKrWOVuM1qMKQuHfwcpuyYGPSJTYJ/Rb92OOU0tUBLDTvoRBICWmQO9O7sIe7QI6+DekPd1zSK/dGYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714137877; c=relaxed/simple;
	bh=jbcAHDiaTrHxMVyZRUpcW1QK1AMqtrKf4Idd/G1q1D8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s+UllYIt5N7fawa1mIDZXbGmWCs34o2oUFfAe9FjW/gU8Q3QmzP1zeI5YdtzTImkRD5vGqIbsibzXjzug6eYIvSCHOelcOst6fIaOOD4kk4NIgQhLU55ws4c9tBNVeYNBIYfQPni4pNnmhOEZIGiW0jDJNdU+nGXqzDTLBawFsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oOwhrkb0; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516d3a470d5so2608726e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 06:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714137874; x=1714742674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0Bi6gVXsIuX31dHLMHLC1PBbtKVJLJWgT+esEKInv0=;
        b=oOwhrkb0do8zR+EfU+BtoXpitJJDV3ugjbow3kQ02nJRP1Hj/f3H+YU7gh12dhIy3Y
         NJRVnmGHke4JU1f0Ev+Kdjs7rBjZDXxVVD2A95YwgNyTAIt8H0MYOgYuMkdEw5V6rOmi
         jrrd1oUr/QeYH+Q1EKXu+79FsxjBwgEWF9sCdhgwjHE7Lzx8CHOHBX5NGpclZMtQn7yd
         P0NkkBLFcpBTFq5wUykrgIH4bdlCuJvj49b8bVBHO+7Ab4ca43BR6xIIOOuz5hATX9sd
         +rlymuIzfwKJu/EuljSUgU78snIVzsiT0IRuhpAA5Pg0Kr80bZ3Wtf4n5f3jEX5IhWla
         ygTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714137874; x=1714742674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0Bi6gVXsIuX31dHLMHLC1PBbtKVJLJWgT+esEKInv0=;
        b=qt4iRwFhyMvpK4/bBqIcoQ+u+M87LWZbzc++M+fNsQONpDb89i6CL8QsHu+d0OfpFj
         qciaOhToUuxyQNEeuSbBLXLDzjRlbeDL75zMd22kArZs/Gp2ZecXIpuIfxoLgGA6xEAi
         2xEJi1phUvJkZyNoIvMCMYtN9flNMQr5hS1pI7p29SoIUDJJtzhjaYcDxYTNuN/qPEkw
         khSwvhU7iF47fa0u40+f0BDL+wkrQtwtIA5QZV3CoPdJxJ6ZuM0QIgzJ4b5BjwRy/WjV
         aA6tj6NI4xbrw5avN6REYVolirmTrb4obWfvPX7gdFB/ATxiBsSjI8e/5TnVwngIA0Xd
         Sm2g==
X-Gm-Message-State: AOJu0YwynEFBTlF8wEdxFjFwC5gOcoOjqMHHBtkDfGpOC7QGNcZozO7T
	6MIkLwq61vhh4X5aIjSzdEanQPBIF2BHPX2pdnzVWNa3qeJU9g4Gnzsk7G6RJv/lvcLk9zFfAfR
	PfRd7Tfsd3hWDL6hVU80Dd9F3KW4sLMlWn4UD4Q==
X-Google-Smtp-Source: AGHT+IHPfuxG9pOejD1ZKXKtqG/5pabtZoHlEQcSq1hk+hdHhJo+p7Q0A0wddj7FCls7ewydYqC9LME1vMp1yED8vpE=
X-Received: by 2002:a19:e015:0:b0:516:d259:245e with SMTP id
 x21-20020a19e015000000b00516d259245emr1727155lfg.9.1714137873732; Fri, 26 Apr
 2024 06:24:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422091936.3714381-1-jens.wiklander@linaro.org>
 <20240422091936.3714381-3-jens.wiklander@linaro.org> <ZioXkvnIw5V5MXBU@mecka.net>
In-Reply-To: <ZioXkvnIw5V5MXBU@mecka.net>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Fri, 26 Apr 2024 15:24:21 +0200
Message-ID: <CAHUa44Fojanryuc+ciJrVZUopRLcTt2teS_pC4BBjt1Wmy240A@mail.gmail.com>
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

On Thu, Apr 25, 2024 at 10:43=E2=80=AFAM Manuel Traut <manut@mecka.net> wro=
te:
>
> On Mon, Apr 22, 2024 at 11:19:35AM +0200, Jens Wiklander wrote:
> > Register eMMC RPMB partition with the RPMB subsystem and provide
> > an implementation for the RPMB access operations abstracting
> > the actual multi step process.
> >
> > Add a callback to extract the needed device information at registration
> > to avoid accessing the struct mmc_card at a later stage as we're not
> > holding a reference counter for this struct.
> >
> > Taking the needed reference to md->disk in mmc_blk_alloc_rpmb_part()
> > instead of in mmc_rpmb_chrdev_open(). This is needed by the
> > route_frames() function pointer in struct rpmb_ops.
> >
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/mmc/core/block.c | 241 ++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 239 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > index 32d49100dff5..a7f126fbc605 100644
> > --- a/drivers/mmc/core/block.c
> > +++ b/drivers/mmc/core/block.c
> > @@ -33,6 +33,7 @@
> >  #include <linux/cdev.h>
> >  #include <linux/mutex.h>
> >  #include <linux/scatterlist.h>
> > +#include <linux/string.h>
> >  #include <linux/string_helpers.h>
> >  #include <linux/delay.h>
> >  #include <linux/capability.h>
> > @@ -40,6 +41,7 @@
> >  #include <linux/pm_runtime.h>
> >  #include <linux/idr.h>
> >  #include <linux/debugfs.h>
> > +#include <linux/rpmb.h>
> >
> >  #include <linux/mmc/ioctl.h>
> >  #include <linux/mmc/card.h>
> > @@ -76,6 +78,48 @@ MODULE_ALIAS("mmc:block");
> >  #define MMC_EXTRACT_INDEX_FROM_ARG(x) ((x & 0x00FF0000) >> 16)
> >  #define MMC_EXTRACT_VALUE_FROM_ARG(x) ((x & 0x0000FF00) >> 8)
> >
> > +/**
> > + * struct rpmb_frame - rpmb frame as defined by eMMC 5.1 (JESD84-B51)
> > + *
> > + * @stuff        : stuff bytes
> > + * @key_mac      : The authentication key or the message authenticatio=
n
> > + *                 code (MAC) depending on the request/response type.
> > + *                 The MAC will be delivered in the last (or the only)
> > + *                 block of data.
> > + * @data         : Data to be written or read by signed access.
> > + * @nonce        : Random number generated by the host for the request=
s
> > + *                 and copied to the response by the RPMB engine.
> > + * @write_counter: Counter value for the total amount of the successfu=
l
> > + *                 authenticated data write requests made by the host.
> > + * @addr         : Address of the data to be programmed to or read
> > + *                 from the RPMB. Address is the serial number of
> > + *                 the accessed block (half sector 256B).
> > + * @block_count  : Number of blocks (half sectors, 256B) requested to =
be
> > + *                 read/programmed.
> > + * @result       : Includes information about the status of the write =
counter
> > + *                 (valid, expired) and result of the access made to t=
he RPMB.
> > + * @req_resp     : Defines the type of request and response to/from th=
e memory.
> > + *
> > + * The stuff bytes and big-endian properties are modeled to fit to the=
 spec.
> > + */
> > +struct rpmb_frame {
> > +     u8     stuff[196];
> > +     u8     key_mac[32];
> > +     u8     data[256];
> > +     u8     nonce[16];
> > +     __be32 write_counter;
> > +     __be16 addr;
> > +     __be16 block_count;
> > +     __be16 result;
> > +     __be16 req_resp;
> > +} __packed;
> > +
> > +#define RPMB_PROGRAM_KEY       0x1    /* Program RPMB Authentication K=
ey */
> > +#define RPMB_GET_WRITE_COUNTER 0x2    /* Read RPMB write counter */
> > +#define RPMB_WRITE_DATA        0x3    /* Write data to RPMB partition =
*/
> > +#define RPMB_READ_DATA         0x4    /* Read data from RPMB partition=
 */
> > +#define RPMB_RESULT_READ       0x5    /* Read result request  (Interna=
l) */
> > +
> >  static DEFINE_MUTEX(block_mutex);
> >
> >  /*
> > @@ -163,6 +207,7 @@ struct mmc_rpmb_data {
> >       int id;
> >       unsigned int part_index;
> >       struct mmc_blk_data *md;
> > +     struct rpmb_dev *rdev;
> >       struct list_head node;
> >  };
> >
> > @@ -2672,7 +2717,6 @@ static int mmc_rpmb_chrdev_open(struct inode *ino=
de, struct file *filp)
> >
> >       get_device(&rpmb->dev);
> >       filp->private_data =3D rpmb;
> > -     mmc_blk_get(rpmb->md->disk);
> >
> >       return nonseekable_open(inode, filp);
> >  }
> > @@ -2682,7 +2726,6 @@ static int mmc_rpmb_chrdev_release(struct inode *=
inode, struct file *filp)
> >       struct mmc_rpmb_data *rpmb =3D container_of(inode->i_cdev,
> >                                                 struct mmc_rpmb_data, c=
hrdev);
> >
> > -     mmc_blk_put(rpmb->md);
> >       put_device(&rpmb->dev);
> >
> >       return 0;
> > @@ -2703,10 +2746,165 @@ static void mmc_blk_rpmb_device_release(struct=
 device *dev)
> >  {
> >       struct mmc_rpmb_data *rpmb =3D dev_get_drvdata(dev);
> >
> > +     rpmb_dev_unregister(rpmb->rdev);
> > +     mmc_blk_put(rpmb->md);
> >       ida_simple_remove(&mmc_rpmb_ida, rpmb->id);
> >       kfree(rpmb);
> >  }
> >
> > +static void free_idata(struct mmc_blk_ioc_data **idata, unsigned int c=
md_count)
> > +{
> > +     unsigned int n;
> > +
> > +     for (n =3D 0; n < cmd_count; n++)
> > +             kfree(idata[n]);
> > +     kfree(idata);
> > +}
> > +
> > +static struct mmc_blk_ioc_data **alloc_idata(struct mmc_rpmb_data *rpm=
b,
> > +                                          unsigned int cmd_count)
> > +{
> > +     struct mmc_blk_ioc_data **idata;
> > +     unsigned int n;
> > +
> > +     idata =3D kcalloc(cmd_count, sizeof(*idata), GFP_KERNEL);
> > +     if (!idata)
> > +             return NULL;
> > +
> > +     for (n =3D 0; n < cmd_count; n++) {
> > +             idata[n] =3D kcalloc(1, sizeof(**idata), GFP_KERNEL);
> > +             if (!idata[n]) {
> > +                     free_idata(idata, n);
> > +                     return NULL;
> > +             }
> > +             idata[n]->rpmb =3D rpmb;
> > +     }
> > +
> > +     return idata;
> > +}
> > +
> > +static void set_idata(struct mmc_blk_ioc_data *idata, u32 opcode,
> > +                   int write_flag, u8 *buf, unsigned int buf_bytes)
> > +{
> > +     /*
> > +      * The size of an RPMB frame must match what's expected by the
> > +      * hardware.
> > +      */
> > +     BUILD_BUG_ON(sizeof(struct rpmb_frame) !=3D 512);
> > +
> > +     idata->ic.opcode =3D opcode;
> > +     idata->ic.flags =3D MMC_RSP_R1 | MMC_CMD_ADTC;
> > +     idata->ic.write_flag =3D write_flag;
> > +     idata->ic.blksz =3D sizeof(struct rpmb_frame);
> > +     idata->ic.blocks =3D buf_bytes /  idata->ic.blksz;
> > +     idata->buf =3D buf;
>
> I tested the series on a i.MX8MM with a eMMC connected via the imx-sdhci
> controller. Reading from RPMB does not work. It ends in timeouts due to
> no response from the SDHCI controller.
>
> If idata->buf is allocated here with kmalloc(buf_bytes, GFP_KERNEL) and
> the content of buf is copied to the new allocated area, transfers succeed=
.
>
> Is it possible that idata->buf is not DMA capable? Any other ideas?

Thanks for testing. I don't know, the idata->buf is allocated using
alloc_pages_exact(nr_pages * PAGE_SIZE, GFP_KERNEL | __GFP_ZERO); in
optee_pool_op_alloc_helper(). Alternatively, it's from the memory
range mapped using memremap() in optee_config_shm_memremap(), but
that's only if you don't have "dynamic shared memory is enabled" in
the boot log.

Thanks,
Jens

