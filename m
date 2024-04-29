Return-Path: <linux-kernel+bounces-162083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADA18B55AB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0333C1F22E8A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E213987C;
	Mon, 29 Apr 2024 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="prevbHe9"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7C22209F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 10:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714387557; cv=none; b=ijpInqGMEgxjq2qN7z038aKwLHwTnbVWsvR/5NMdU30hoPs7Ulhb2MCaTYmG6+3CutpKTQkc+e/euEhcWs1XemzKbKruULM6HMK+/I858Je6t6S0uJlvhR69a5eeT4BKjTwCiXAcsHauv9EPeH+bHSGZS1MqvoIqZsxGpJA9nTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714387557; c=relaxed/simple;
	bh=Pt7YfRb3o5jsUNUKh4288/nUtPfxSnu/p8dilxPmuPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PnjJI1GbUbatEAJl1EiKU3Wg2A6zL7QOUxtH3h59aT55Xm41kwkxABeKG0C+xDg65KVi+PoIVj7iYzTPB7x4dzMSJmTb28cEfl8MV0Cp8pOO+pOLNAJiMiATUYtqoSW1ihNSpJgYbjueVNc+rlMqQpFlSEdjzAEYKhOPjAWVN2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=prevbHe9; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5ad2da2196bso2430269eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 03:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714387555; x=1714992355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2449yjkOAheYReN3/P+mmeUztaBhibYeEhDta2WgLMc=;
        b=prevbHe9rv70zpHRjit3SKnHLBvCakHfrRbm3xt/71a6I5ZU+3zFLedxRSpv7Fw7/v
         1HD/5/3ISwzns33SLDsUgaaR6dA1+JpHH68G/3/+fRCLJo9XIU9joOw/Y6Aox2ohDQRv
         FmNYBzYrzWlP4tafAPoXOfbZcUTtKgCEpGAhQF4XkIi2O38oJwEwcvLswRQNmSrX+iKN
         55Fhm8MtFwkiHu6Dyk2KKUuVeu5yr4gAEvgId9MMJ4RdNrnxI8/77bVnl+7zzrVHPkr3
         JfQvTK3zT/YaB2Zt9pnhecD888UuCjInjUM0YDPHKLPHz29Hd95Io8Q1l5nBhdRwPqpg
         E6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714387555; x=1714992355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2449yjkOAheYReN3/P+mmeUztaBhibYeEhDta2WgLMc=;
        b=Ww+7zACXt9dTFJbbBfjDcn4DH3YxvDZS90qyO10XknxaqEWdtPh3xyG+vyazeItrYr
         otsyOt+pPob0FmwczoqwTrt0hkBYq83xHrT/++zqsVcPAVR7Zz2F9/OwdRjjPcy26HK0
         h5KHd3Z9tlsbERLlMa7Ijw4aIUUVm9zhc8Ss3o9Vijxwv+Q5FN28CkLzB8HciA+xoawx
         6wgl0udcDAZZnm5nLKfkySzTVtWlbPQgHqQM3kVpH67HHvoQjEJtaDkuDYyRvR6tkhL1
         0YqaIdpEtd6WTtAHspT3PkNhayutMwktGUScc1b/RMH8DGq36X7P4G2ByUT5Nw4chUw/
         WgpA==
X-Gm-Message-State: AOJu0Yxd75xwhEh08PP0PubnEYxZltFBFbEx98tJmJqxAjulbU4TwZsG
	lTMO4jVl9OwKPcHCou5bxq1zNYAogJSB6PkEgUBiL61kowx14cbmwrOX1y/nAUQA/ZWSTRzVMVm
	/22xVHU7rMRzHUD3F60YksW5dGL6a0ebVMTFG6g==
X-Google-Smtp-Source: AGHT+IF2+dHvZ9K+iJprNEPrc03Rr4KK+qM2I6DYFDaVQ0XLjKRKzoZoBKHLSXSlfbhBbzXBsWwchUTAqPuunFOq7xU=
X-Received: by 2002:a4a:347:0:b0:5ac:9f40:16a with SMTP id 68-20020a4a0347000000b005ac9f40016amr11143009ooi.5.1714387554985;
 Mon, 29 Apr 2024 03:45:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422091936.3714381-1-jens.wiklander@linaro.org>
 <20240422091936.3714381-3-jens.wiklander@linaro.org> <ZioXkvnIw5V5MXBU@mecka.net>
 <CAHUa44Fojanryuc+ciJrVZUopRLcTt2teS_pC4BBjt1Wmy240A@mail.gmail.com>
 <Zi9rKzz8u8z7cIy0@mecka.net> <CAHUa44HHtcaYXhcWg5zL5EQ8pEP7aEDKS+yjpaMJH8vTtF3xFw@mail.gmail.com>
 <Zi93_0aCq9mQ_6cD@mecka.net>
In-Reply-To: <Zi93_0aCq9mQ_6cD@mecka.net>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 29 Apr 2024 12:45:43 +0200
Message-ID: <CAHUa44FG3ge3nyQVStKjfpeJvpjuQjNiZsxHjyRz+CUjHwkS=g@mail.gmail.com>
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

On Mon, Apr 29, 2024 at 12:35=E2=80=AFPM Manuel Traut <manut@mecka.net> wro=
te:
>
> On Mon, Apr 29, 2024 at 12:08:45PM +0200, Jens Wiklander wrote:
> > On Mon, Apr 29, 2024 at 11:41=E2=80=AFAM Manuel Traut <manut@mecka.net>=
 wrote:
> > >
> > > On Fri, Apr 26, 2024 at 03:24:21PM +0200, Jens Wiklander wrote:
> > > > On Thu, Apr 25, 2024 at 10:43=E2=80=AFAM Manuel Traut <manut@mecka.=
net> wrote:
> > > > >
> > > > > On Mon, Apr 22, 2024 at 11:19:35AM +0200, Jens Wiklander wrote:
> > > > > > Register eMMC RPMB partition with the RPMB subsystem and provid=
e
> > > > > > an implementation for the RPMB access operations abstracting
> > > > > > the actual multi step process.
> > > > > >
> > > > > > Add a callback to extract the needed device information at regi=
stration
> > > > > > to avoid accessing the struct mmc_card at a later stage as we'r=
e not
> > > > > > holding a reference counter for this struct.
> > > > > >
> > > > > > Taking the needed reference to md->disk in mmc_blk_alloc_rpmb_p=
art()
> > > > > > instead of in mmc_rpmb_chrdev_open(). This is needed by the
> > > > > > route_frames() function pointer in struct rpmb_ops.
> > > > > >
> > > > > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > > > > > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> > > > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > > ---
> > > > > >  drivers/mmc/core/block.c | 241 +++++++++++++++++++++++++++++++=
+++++++-
> > > > > >  1 file changed, 239 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.=
c
> > > > > > index 32d49100dff5..a7f126fbc605 100644
> > > > > > --- a/drivers/mmc/core/block.c
> > > > > > +++ b/drivers/mmc/core/block.c
> > > > > > @@ -33,6 +33,7 @@
> > > > > >  #include <linux/cdev.h>
> > > > > >  #include <linux/mutex.h>
> > > > > >  #include <linux/scatterlist.h>
> > > > > > +#include <linux/string.h>
> > > > > >  #include <linux/string_helpers.h>
> > > > > >  #include <linux/delay.h>
> > > > > >  #include <linux/capability.h>
> > > > > > @@ -40,6 +41,7 @@
> > > > > >  #include <linux/pm_runtime.h>
> > > > > >  #include <linux/idr.h>
> > > > > >  #include <linux/debugfs.h>
> > > > > > +#include <linux/rpmb.h>
> > > > > >
> > > > > >  #include <linux/mmc/ioctl.h>
> > > > > >  #include <linux/mmc/card.h>
> > > > > > @@ -76,6 +78,48 @@ MODULE_ALIAS("mmc:block");
> > > > > >  #define MMC_EXTRACT_INDEX_FROM_ARG(x) ((x & 0x00FF0000) >> 16)
> > > > > >  #define MMC_EXTRACT_VALUE_FROM_ARG(x) ((x & 0x0000FF00) >> 8)
> > > > > >
> > > > > > +/**
> > > > > > + * struct rpmb_frame - rpmb frame as defined by eMMC 5.1 (JESD=
84-B51)
> > > > > > + *
> > > > > > + * @stuff        : stuff bytes
> > > > > > + * @key_mac      : The authentication key or the message authe=
ntication
> > > > > > + *                 code (MAC) depending on the request/respons=
e type.
> > > > > > + *                 The MAC will be delivered in the last (or t=
he only)
> > > > > > + *                 block of data.
> > > > > > + * @data         : Data to be written or read by signed access=
.
> > > > > > + * @nonce        : Random number generated by the host for the=
 requests
> > > > > > + *                 and copied to the response by the RPMB engi=
ne.
> > > > > > + * @write_counter: Counter value for the total amount of the s=
uccessful
> > > > > > + *                 authenticated data write requests made by t=
he host.
> > > > > > + * @addr         : Address of the data to be programmed to or =
read
> > > > > > + *                 from the RPMB. Address is the serial number=
 of
> > > > > > + *                 the accessed block (half sector 256B).
> > > > > > + * @block_count  : Number of blocks (half sectors, 256B) reque=
sted to be
> > > > > > + *                 read/programmed.
> > > > > > + * @result       : Includes information about the status of th=
e write counter
> > > > > > + *                 (valid, expired) and result of the access m=
ade to the RPMB.
> > > > > > + * @req_resp     : Defines the type of request and response to=
/from the memory.
> > > > > > + *
> > > > > > + * The stuff bytes and big-endian properties are modeled to fi=
t to the spec.
> > > > > > + */
> > > > > > +struct rpmb_frame {
> > > > > > +     u8     stuff[196];
> > > > > > +     u8     key_mac[32];
> > > > > > +     u8     data[256];
> > > > > > +     u8     nonce[16];
> > > > > > +     __be32 write_counter;
> > > > > > +     __be16 addr;
> > > > > > +     __be16 block_count;
> > > > > > +     __be16 result;
> > > > > > +     __be16 req_resp;
> > > > > > +} __packed;
> > > > > > +
> > > > > > +#define RPMB_PROGRAM_KEY       0x1    /* Program RPMB Authenti=
cation Key */
> > > > > > +#define RPMB_GET_WRITE_COUNTER 0x2    /* Read RPMB write count=
er */
> > > > > > +#define RPMB_WRITE_DATA        0x3    /* Write data to RPMB pa=
rtition */
> > > > > > +#define RPMB_READ_DATA         0x4    /* Read data from RPMB p=
artition */
> > > > > > +#define RPMB_RESULT_READ       0x5    /* Read result request  =
(Internal) */
> > > > > > +
> > > > > >  static DEFINE_MUTEX(block_mutex);
> > > > > >
> > > > > >  /*
> > > > > > @@ -163,6 +207,7 @@ struct mmc_rpmb_data {
> > > > > >       int id;
> > > > > >       unsigned int part_index;
> > > > > >       struct mmc_blk_data *md;
> > > > > > +     struct rpmb_dev *rdev;
> > > > > >       struct list_head node;
> > > > > >  };
> > > > > >
> > > > > > @@ -2672,7 +2717,6 @@ static int mmc_rpmb_chrdev_open(struct in=
ode *inode, struct file *filp)
> > > > > >
> > > > > >       get_device(&rpmb->dev);
> > > > > >       filp->private_data =3D rpmb;
> > > > > > -     mmc_blk_get(rpmb->md->disk);
> > > > > >
> > > > > >       return nonseekable_open(inode, filp);
> > > > > >  }
> > > > > > @@ -2682,7 +2726,6 @@ static int mmc_rpmb_chrdev_release(struct=
 inode *inode, struct file *filp)
> > > > > >       struct mmc_rpmb_data *rpmb =3D container_of(inode->i_cdev=
,
> > > > > >                                                 struct mmc_rpmb=
_data, chrdev);
> > > > > >
> > > > > > -     mmc_blk_put(rpmb->md);
> > > > > >       put_device(&rpmb->dev);
> > > > > >
> > > > > >       return 0;
> > > > > > @@ -2703,10 +2746,165 @@ static void mmc_blk_rpmb_device_releas=
e(struct device *dev)
> > > > > >  {
> > > > > >       struct mmc_rpmb_data *rpmb =3D dev_get_drvdata(dev);
> > > > > >
> > > > > > +     rpmb_dev_unregister(rpmb->rdev);
> > > > > > +     mmc_blk_put(rpmb->md);
> > > > > >       ida_simple_remove(&mmc_rpmb_ida, rpmb->id);
> > > > > >       kfree(rpmb);
> > > > > >  }
> > > > > >
> > > > > > +static void free_idata(struct mmc_blk_ioc_data **idata, unsign=
ed int cmd_count)
> > > > > > +{
> > > > > > +     unsigned int n;
> > > > > > +
> > > > > > +     for (n =3D 0; n < cmd_count; n++)
> > > > > > +             kfree(idata[n]);
> > > > > > +     kfree(idata);
> > > > > > +}
> > > > > > +
> > > > > > +static struct mmc_blk_ioc_data **alloc_idata(struct mmc_rpmb_d=
ata *rpmb,
> > > > > > +                                          unsigned int cmd_cou=
nt)
> > > > > > +{
> > > > > > +     struct mmc_blk_ioc_data **idata;
> > > > > > +     unsigned int n;
> > > > > > +
> > > > > > +     idata =3D kcalloc(cmd_count, sizeof(*idata), GFP_KERNEL);
> > > > > > +     if (!idata)
> > > > > > +             return NULL;
> > > > > > +     for (n =3D 0; n < cmd_count; n++) {
> > > > > > +             idata[n] =3D kcalloc(1, sizeof(**idata), GFP_KERN=
EL);
> > > > > > +             if (!idata[n]) {
> > > > > > +                     free_idata(idata, n);
> > > > > > +                     return NULL;
> > > > > > +             }
> > > > > > +             idata[n]->rpmb =3D rpmb;
> > > > > > +     }
> > > > > > +
> > > > > > +     return idata;
> > > > > > +}
> > > > > > +
> > > > > > +static void set_idata(struct mmc_blk_ioc_data *idata, u32 opco=
de,
> > > > > > +                   int write_flag, u8 *buf, unsigned int buf_b=
ytes)
> > > > > > +{
> > > > > > +     /*
> > > > > > +      * The size of an RPMB frame must match what's expected b=
y the
> > > > > > +      * hardware.
> > > > > > +      */
> > > > > > +     BUILD_BUG_ON(sizeof(struct rpmb_frame) !=3D 512);
> > > > > > +
> > > > > > +     idata->ic.opcode =3D opcode;
> > > > > > +     idata->ic.flags =3D MMC_RSP_R1 | MMC_CMD_ADTC;
> > > > > > +     idata->ic.write_flag =3D write_flag;
> > > > > > +     idata->ic.blksz =3D sizeof(struct rpmb_frame);
> > > > > > +     idata->ic.blocks =3D buf_bytes /  idata->ic.blksz;
> > > > > > +     idata->buf =3D buf;
> > > > >
> > > > > I tested the series on a i.MX8MM with a eMMC connected via the im=
x-sdhci
> > > > > controller. Reading from RPMB does not work. It ends in timeouts =
due to
> > > > > no response from the SDHCI controller.
> > > > >
> > > > > If idata->buf is allocated here with kmalloc(buf_bytes, GFP_KERNE=
L) and
> > > > > the content of buf is copied to the new allocated area, transfers=
 succeed.
> > > > >
> > > > > Is it possible that idata->buf is not DMA capable? Any other idea=
s?
> > > >
> > > > Thanks for testing. I don't know, the idata->buf is allocated using
> > > > alloc_pages_exact(nr_pages * PAGE_SIZE, GFP_KERNEL | __GFP_ZERO); i=
n
> > > > optee_pool_op_alloc_helper().
> > >
> > > Is this really true for idata->buf or isnt the complete RPMB frame me=
mory
> > > allocated like this and therefore idata->buf not page aligned?
> >
> > You're right.
> >
> > >
> > > For RPMB via tee-supplicant the idata->buf is allocated within memdup=
_user
> > > and therefore page aligned.
> >
> > Yes, that's a difference. Have you tested with page-aligned buffers to
> > see if it helps?
>
> Yes, this helps. I tested with the following patch, but probably it can a=
lso
> be solved during frame allocation in optee?

Great, thanks for confirming. Yes, we should fix that in the secure world.

Cheers,
Jens

>
>
> commit b84a56c15abdcd07f4dacf0b7f482802f8ce752b
> Author: Manuel Traut <manut@mecka.net>
> Date:   Tue Apr 23 13:22:27 2024 +0200
>
>     mmc: core: block: rpmb: Allocate page aligned memory
>
>     "Random" position in optee shared memory cannot be used for blk
>     IO on an eMMC with the i.MX8 SDHCI.
>
>     This is for sure not the best possible solution, but works
>     for the moment.
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 30da8fd03..f123a6c96 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2786,6 +2786,8 @@ static struct mmc_blk_ioc_data **alloc_idata(struct=
 mmc_rpmb_data *rpmb,
>         return idata;
>  }
>
> +#define DYNALLOC 1
> +
>  static void set_idata(struct mmc_blk_ioc_data *idata, u32 opcode,
>                       int write_flag, u8 *buf, unsigned int buf_bytes)
>  {
> @@ -2800,10 +2802,23 @@ static void set_idata(struct mmc_blk_ioc_data *id=
ata, u32 opcode,
>         idata->ic.write_flag =3D write_flag;
>         idata->ic.blksz =3D sizeof(struct rpmb_frame);
>         idata->ic.blocks =3D buf_bytes /  idata->ic.blksz;
> +#ifdef DYNALLOC
> +       idata->buf =3D kmalloc(buf_bytes, GFP_KERNEL);
> +       memcpy(idata->buf, buf, buf_bytes);
> +#else
>         idata->buf =3D buf;
> +#endif
>         idata->buf_bytes =3D buf_bytes;
>  }
>
> +#ifdef DYNALLOC
> +static void free_idata_buf(struct mmc_blk_ioc_data *idata, u8 *buf, unsi=
gned int buf_bytes)
> +{
> +    memcpy(buf, idata->buf, buf_bytes);
> +    kfree(idata->buf);
> +}
> +#endif
> +
>  static int mmc_route_rpmb_frames(struct device *dev, u8 *req,
>                                  unsigned int req_len, u8 *resp,
>                                  unsigned int resp_len)
> @@ -2901,6 +2916,13 @@ static int mmc_route_rpmb_frames(struct device *de=
v, u8 *req,
>         blk_execute_rq(rq, false);
>         ret =3D req_to_mmc_queue_req(rq)->drv_op_result;
>
> +#ifdef DYNALLOC
> +       free_idata_buf(idata[0], req, req_len);
> +       free_idata_buf(idata[1], resp, resp_len);
> +       if (write)
> +               free_idata_buf(idata[2], resp, resp_len);
> +#endif
> +
>         blk_mq_free_request(rq);
>
>  out:
>
> > > > Alternatively, it's from the memory
> > > > range mapped using memremap() in optee_config_shm_memremap(), but
> > > > that's only if you don't have "dynamic shared memory is enabled" in
> > > > the boot log.
> > >
> > > "dynamic shared memory is enabled" is in the bootlog, ..
> >
> > Great.
>
> Thanks
> Manuel

