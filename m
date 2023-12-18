Return-Path: <linux-kernel+bounces-3924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F169F81752E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 456282858B2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AD03A1D5;
	Mon, 18 Dec 2023 15:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ZFM8yLHW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617393A1B6
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4b6c2480cccso919716e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702913102; x=1703517902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCsxDVfbkPMS/NMa2lYVcbOzQY9wpYT80t55EoX5NeE=;
        b=ZFM8yLHWvFJWREvSsOn4PmaST5wQDQpKwaqdDTsTDYc1Bm007ylw65L9ZZcqV3v1JS
         B4JMJ/P+oOOwTNYQ0QDSe7EqL06UWKi7PJKKICakKImjhFwPKCWOU90DLJr/8VZMvmOR
         hKmvLabPcakImU7bigCmS7qCG6ZAQpbvh20TmaubMO09q5CB//uMd43GS9S8AMC8RYqS
         8DlOrZU9IuWvCtqyXVABvKaO5JSLUfqEFxiJZHq9ME44y8L36l9BCHk5qdil7a9SB4t3
         lOWHEh5sf/vzN/WSBLLP4ku18jBb8QOMvODc4eXdZwyVbcYQrb/p4Y2kQganCQGL9eGT
         CHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913102; x=1703517902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cCsxDVfbkPMS/NMa2lYVcbOzQY9wpYT80t55EoX5NeE=;
        b=Kz5fQipoJnG1Xd+IX+G2qjfTF/rZW+3DyC+esDPhGE0lFBtfFQUS2wSRTo5xiOb+2b
         5usQnOdkZ7MH9YA/2sO58x3t0MzgQFtfVQ9LaPsIq+SEaoqfkusewAr9C8cFcTcNF3ba
         mNUKLxA/Ucy4So9jBCxTn3TovzvUi8yDEy/YreeZFNlhjpyNPYgQdlJw1G+Uow6nOQpA
         iM+JtVmduhwqtG9YAI1jd93ZglfMeLFCBdv7C4fBt01Y0my0LfFVnRa5MzJJhA069300
         3QYmgg31NxKil/vbfvLtB91WNC7kzhPpi1pFV7bodcO+kh6bPGXIMzN+YCt7k9aiWaPD
         boww==
X-Gm-Message-State: AOJu0YzllUFsDv+gnP/jU6CjgxrBHHLpP8rJqecUrtVrD3xkzE0auG+b
	Yaq59+V8L+waBQQLgy1OpfmuFUWcGRB9xX/iGWm/LA==
X-Google-Smtp-Source: AGHT+IGO2l6lmZVPnsi/ZR+YxC0Zep6Oj+duEmPDbZ2DeoMwFZAeAiQFG66nGwh4PwOejyRm6JC8FV0ylyAhD6YzfAI=
X-Received: by 2002:a05:6122:f05:b0:4b2:c573:ed5b with SMTP id
 bn5-20020a0561220f0500b004b2c573ed5bmr15236450vkb.13.1702913102093; Mon, 18
 Dec 2023 07:25:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231216001652.56276-1-warthog618@gmail.com> <20231216001652.56276-2-warthog618@gmail.com>
In-Reply-To: <20231216001652.56276-2-warthog618@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 18 Dec 2023 16:24:50 +0100
Message-ID: <CAMRc=McBVeQ=yRpGRsnPEULfPx15PBO3kiGscdS4s6-d0URc3w@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] gpiolib: cdev: relocate debounce_period_us from
 struct gpio_desc
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linus.walleij@linaro.org, andy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2023 at 1:17=E2=80=AFAM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> Store the debounce period for a requested line locally, rather than in
> the debounce_period_us field in the gpiolib struct gpio_desc.
>
> Add a global tree of lines containing supplemental line information
> to make the debounce period available to be reported by the
> GPIO_V2_GET_LINEINFO_IOCTL and the line change notifier.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> ---
>  drivers/gpio/gpiolib-cdev.c | 154 ++++++++++++++++++++++++++++++------
>  1 file changed, 132 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index 02ffda6c1e51..47197f6339c4 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -5,6 +5,7 @@
>  #include <linux/bitmap.h>
>  #include <linux/build_bug.h>
>  #include <linux/cdev.h>
> +#include <linux/cleanup.h>
>  #include <linux/compat.h>
>  #include <linux/compiler.h>
>  #include <linux/device.h>
> @@ -21,6 +22,7 @@
>  #include <linux/mutex.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/poll.h>
> +#include <linux/rbtree.h>
>  #include <linux/seq_file.h>
>  #include <linux/spinlock.h>
>  #include <linux/timekeeping.h>
> @@ -461,6 +463,7 @@ static int linehandle_create(struct gpio_device *gdev=
, void __user *ip)
>
>  /**
>   * struct line - contains the state of a requested line
> + * @node: to store the object in supinfo_tree if supplemental
>   * @desc: the GPIO descriptor for this line.
>   * @req: the corresponding line request
>   * @irq: the interrupt triggered in response to events on this GPIO
> @@ -473,6 +476,7 @@ static int linehandle_create(struct gpio_device *gdev=
, void __user *ip)
>   * @line_seqno: the seqno for the current edge event in the sequence of
>   * events for this line.
>   * @work: the worker that implements software debouncing
> + * @debounce_period_us: the debounce period in microseconds
>   * @sw_debounced: flag indicating if the software debouncer is active
>   * @level: the current debounced physical level of the line
>   * @hdesc: the Hardware Timestamp Engine (HTE) descriptor
> @@ -481,6 +485,7 @@ static int linehandle_create(struct gpio_device *gdev=
, void __user *ip)
>   * @last_seqno: the last sequence number before debounce period expires
>   */
>  struct line {
> +       struct rb_node node;
>         struct gpio_desc *desc;
>         /*
>          * -- edge detector specific fields --
> @@ -514,6 +519,15 @@ struct line {
>          * -- debouncer specific fields --
>          */
>         struct delayed_work work;
> +       /*
> +        * debounce_period_us is accessed by debounce_irq_handler() and
> +        * process_hw_ts() which are disabled when modified by
> +        * debounce_setup(), edge_detector_setup() or edge_detector_stop(=
)
> +        * or can live with a stale version when updated by
> +        * edge_detector_update().
> +        * The modifying functions are themselves mutually exclusive.
> +        */
> +       unsigned int debounce_period_us;
>         /*
>          * sw_debounce is accessed by linereq_set_config(), which is the
>          * only setter, and linereq_get_values(), which can live with a
> @@ -546,6 +560,17 @@ struct line {
>  #endif /* CONFIG_HTE */
>  };
>
> +/*
> + * a rbtree of the struct lines containing supplemental info.
> + * Used to populate gpio_v2_line_info with cdev specific fields not cont=
ained
> + * in the struct gpio_desc.
> + * A line is determined to contain supplemental information by
> + * line_is_supplemental().
> + */
> +static struct rb_root supinfo_tree =3D RB_ROOT;
> +/* covers supinfo_tree */
> +static DEFINE_SPINLOCK(supinfo_lock);
> +
>  /**
>   * struct linereq - contains the state of a userspace line request
>   * @gdev: the GPIO device the line request pertains to
> @@ -575,6 +600,95 @@ struct linereq {
>         struct line lines[] __counted_by(num_lines);
>  };
>
> +static void supinfo_insert(struct line *line)
> +{
> +       struct rb_node **new =3D &(supinfo_tree.rb_node), *parent =3D NUL=
L;
> +       struct line *entry;
> +
> +       guard(spinlock)(&supinfo_lock);
> +
> +       while (*new) {
> +               entry =3D container_of(*new, struct line, node);
> +
> +               parent =3D *new;
> +               if (line->desc < entry->desc) {
> +                       new =3D &((*new)->rb_left);
> +               } else if (line->desc > entry->desc) {
> +                       new =3D &((*new)->rb_right);
> +               } else {
> +                       /* this should never happen */
> +                       WARN(1, "duplicate line inserted");
> +                       return;
> +               }
> +       }
> +
> +       rb_link_node(&line->node, parent, new);
> +       rb_insert_color(&line->node, &supinfo_tree);
> +}
> +
> +static void supinfo_erase(struct line *line)
> +{
> +       guard(spinlock)(&supinfo_lock);
> +
> +       rb_erase(&line->node, &supinfo_tree);
> +}
> +
> +static struct line *supinfo_find(struct gpio_desc *desc)
> +{
> +       struct rb_node *node =3D supinfo_tree.rb_node;
> +       struct line *line;
> +
> +       while (node) {
> +               line =3D container_of(node, struct line, node);
> +               if (desc < line->desc)
> +                       node =3D node->rb_left;
> +               else if (desc > line->desc)
> +                       node =3D node->rb_right;
> +               else
> +                       return line;
> +       }
> +       return NULL;
> +}
> +
> +static void supinfo_to_lineinfo(struct gpio_desc *desc,
> +                               struct gpio_v2_line_info *info)
> +{
> +       struct gpio_v2_line_attribute *attr;
> +       struct line *line;
> +
> +       guard(spinlock)(&supinfo_lock);
> +
> +       line =3D supinfo_find(desc);
> +       if (!line)
> +               return;
> +
> +       attr =3D &info->attrs[info->num_attrs];
> +       attr->id =3D GPIO_V2_LINE_ATTR_ID_DEBOUNCE;
> +       attr->debounce_period_us =3D READ_ONCE(line->debounce_period_us);
> +       info->num_attrs++;
> +}
> +
> +static inline bool line_is_supplemental(struct line *line)

Under v2 I suggested naming this line_has_suppinfo(). Any reason not
to do it? I think it's more logical than saying "line is
supplemental". The latter makes it seem as if certain line objects
would "supplement" some third party with something. What this really
checks is: does this line contain additional information.

> +{
> +       return READ_ONCE(line->debounce_period_us);
> +}
> +
> +static void line_set_debounce_period(struct line *line,
> +                                    unsigned int debounce_period_us)
> +{
> +       bool was_suppl =3D line_is_supplemental(line);
> +
> +       WRITE_ONCE(line->debounce_period_us, debounce_period_us);
> +
> +       if (line_is_supplemental(line) =3D=3D was_suppl)
> +               return;
> +
> +       if (was_suppl)
> +               supinfo_erase(line);
> +       else
> +               supinfo_insert(line);

Could you add a comment here saying it's called with the config mutex
taken as at first glance it looks racy but actually isn't?

Bart

> +}
> +
>  #define GPIO_V2_LINE_BIAS_FLAGS \
>         (GPIO_V2_LINE_FLAG_BIAS_PULL_UP | \
>          GPIO_V2_LINE_FLAG_BIAS_PULL_DOWN | \
> @@ -723,7 +837,7 @@ static enum hte_return process_hw_ts(struct hte_ts_da=
ta *ts, void *p)
>                 line->total_discard_seq++;
>                 line->last_seqno =3D ts->seq;
>                 mod_delayed_work(system_wq, &line->work,
> -                 usecs_to_jiffies(READ_ONCE(line->desc->debounce_period_=
us)));
> +                 usecs_to_jiffies(READ_ONCE(line->debounce_period_us)));
>         } else {
>                 if (unlikely(ts->seq < line->line_seqno))
>                         return HTE_CB_HANDLED;
> @@ -864,7 +978,7 @@ static irqreturn_t debounce_irq_handler(int irq, void=
 *p)
>         struct line *line =3D p;
>
>         mod_delayed_work(system_wq, &line->work,
> -               usecs_to_jiffies(READ_ONCE(line->desc->debounce_period_us=
)));
> +               usecs_to_jiffies(READ_ONCE(line->debounce_period_us)));
>
>         return IRQ_HANDLED;
>  }
> @@ -946,7 +1060,7 @@ static int debounce_setup(struct line *line, unsigne=
d int debounce_period_us)
>         /* try hardware */
>         ret =3D gpiod_set_debounce(line->desc, debounce_period_us);
>         if (!ret) {
> -               WRITE_ONCE(line->desc->debounce_period_us, debounce_perio=
d_us);
> +               line_set_debounce_period(line, debounce_period_us);
>                 return ret;
>         }
>         if (ret !=3D -ENOTSUPP)
> @@ -1025,8 +1139,7 @@ static void edge_detector_stop(struct line *line)
>         cancel_delayed_work_sync(&line->work);
>         WRITE_ONCE(line->sw_debounced, 0);
>         WRITE_ONCE(line->edflags, 0);
> -       if (line->desc)
> -               WRITE_ONCE(line->desc->debounce_period_us, 0);
> +       line_set_debounce_period(line, 0);
>         /* do not change line->level - see comment in debounced_value() *=
/
>  }
>
> @@ -1051,7 +1164,7 @@ static int edge_detector_setup(struct line *line,
>                 ret =3D debounce_setup(line, debounce_period_us);
>                 if (ret)
>                         return ret;
> -               WRITE_ONCE(line->desc->debounce_period_us, debounce_perio=
d_us);
> +               line_set_debounce_period(line, debounce_period_us);
>         }
>
>         /* detection disabled or sw debouncer will provide edge detection=
 */
> @@ -1093,12 +1206,12 @@ static int edge_detector_update(struct line *line=
,
>                         gpio_v2_line_config_debounce_period(lc, line_idx)=
;
>
>         if ((active_edflags =3D=3D edflags) &&
> -           (READ_ONCE(line->desc->debounce_period_us) =3D=3D debounce_pe=
riod_us))
> +           (READ_ONCE(line->debounce_period_us) =3D=3D debounce_period_u=
s))
>                 return 0;
>
>         /* sw debounced and still will be...*/
>         if (debounce_period_us && READ_ONCE(line->sw_debounced)) {
> -               WRITE_ONCE(line->desc->debounce_period_us, debounce_perio=
d_us);
> +               line_set_debounce_period(line, debounce_period_us);
>                 return 0;
>         }
>
> @@ -1573,6 +1686,7 @@ static ssize_t linereq_read(struct file *file, char=
 __user *buf,
>
>  static void linereq_free(struct linereq *lr)
>  {
> +       struct line *line;
>         unsigned int i;
>
>         if (lr->device_unregistered_nb.notifier_call)
> @@ -1580,10 +1694,14 @@ static void linereq_free(struct linereq *lr)
>                                                    &lr->device_unregister=
ed_nb);
>
>         for (i =3D 0; i < lr->num_lines; i++) {
> -               if (lr->lines[i].desc) {
> -                       edge_detector_stop(&lr->lines[i]);
> -                       gpiod_free(lr->lines[i].desc);
> -               }
> +               line =3D &lr->lines[i];
> +               if (!line->desc)
> +                       continue;
> +
> +               edge_detector_stop(line);
> +               if (line_is_supplemental(line))
> +                       supinfo_erase(line);
> +               gpiod_free(line->desc);
>         }
>         kfifo_free(&lr->events);
>         kfree(lr->label);
> @@ -2274,8 +2392,6 @@ static void gpio_desc_to_lineinfo(struct gpio_desc =
*desc,
>         struct gpio_chip *gc =3D desc->gdev->chip;
>         bool ok_for_pinctrl;
>         unsigned long flags;
> -       u32 debounce_period_us;
> -       unsigned int num_attrs =3D 0;
>
>         memset(info, 0, sizeof(*info));
>         info->offset =3D gpio_chip_hwgpio(desc);
> @@ -2341,14 +2457,6 @@ static void gpio_desc_to_lineinfo(struct gpio_desc=
 *desc,
>         else if (test_bit(FLAG_EVENT_CLOCK_HTE, &desc->flags))
>                 info->flags |=3D GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE;
>
> -       debounce_period_us =3D READ_ONCE(desc->debounce_period_us);
> -       if (debounce_period_us) {
> -               info->attrs[num_attrs].id =3D GPIO_V2_LINE_ATTR_ID_DEBOUN=
CE;
> -               info->attrs[num_attrs].debounce_period_us =3D debounce_pe=
riod_us;
> -               num_attrs++;
> -       }
> -       info->num_attrs =3D num_attrs;
> -
>         spin_unlock_irqrestore(&gpio_lock, flags);
>  }
>
> @@ -2455,6 +2563,7 @@ static int lineinfo_get(struct gpio_chardev_data *c=
dev, void __user *ip,
>                         return -EBUSY;
>         }
>         gpio_desc_to_lineinfo(desc, &lineinfo);
> +       supinfo_to_lineinfo(desc, &lineinfo);
>
>         if (copy_to_user(ip, &lineinfo, sizeof(lineinfo))) {
>                 if (watch)
> @@ -2545,6 +2654,7 @@ static int lineinfo_changed_notify(struct notifier_=
block *nb,
>         chg.event_type =3D action;
>         chg.timestamp_ns =3D ktime_get_ns();
>         gpio_desc_to_lineinfo(desc, &chg.info);
> +       supinfo_to_lineinfo(desc, &chg.info);
>
>         ret =3D kfifo_in_spinlocked(&cdev->events, &chg, 1, &cdev->wait.l=
ock);
>         if (ret)
> --
> 2.39.2
>

