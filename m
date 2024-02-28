Return-Path: <linux-kernel+bounces-85446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5B486B616
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 196211C24171
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F0D3FBB7;
	Wed, 28 Feb 2024 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0LEoSuM"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693953BBC5
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709141636; cv=none; b=O5u6JxPRoM6GsTgacYOwzXc9UlmLpOJ9UR8zUTYpN/NRvUuIJqLLLznpw0YszdI0AiyagW4Zv5GCtlLFJxdCCkfPhJ8uW7lC21jidQlxUUZRDLfZ2lw9vuunvojiYLNjq21Tvitsu5cXWcqI1rxwFf9pg7FIRZ7DYXs88yggWS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709141636; c=relaxed/simple;
	bh=Q2pL9GsHaVHsIjI9XnDgZXchhFpDtWwE5xJuwJSWxNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gBE4+K9fDxnrpE2UQpWDEd300NFFGKx8uJDc8gZbBVZ85GMtvDQE36jacav3FXUI4s6nVZ2/N4yXswgG7gHjQMpeCTMFmbMnEZglIbKt2QkwBd8WdzTRMMUN7S9FBEyK+yylF8EDcwts8y6L9Y4N2FD7lu759koFHlAig6DSCI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0LEoSuM; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7d5c2502ea2so3093372241.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709141633; x=1709746433; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VD4WJ7Dq6fHRKWtx/LCBxzWvZsBw52eMwWJcaWPnawk=;
        b=c0LEoSuMmL5fyJGjTutyKKxxgbfsocCOQ/T9CJYm2Q2mFzIDJUMzkG+y4SYUXqtiXL
         viYmBW7kLyWWYWH1X1xLQwX14xlP1OAXtBis2CHTlVxmm1ZyPdSHX6A8uOO6w90xFb1z
         LgBb5nFwGvwlQDI+aGVbASLUp/e4+pr4H/o1Kjq5GyiEIt2i8wyKd/qo4KoII7dFxKex
         /4SjKPx2LPn4lyPjh75MQGV8FfX8FiPKSe2YW4kBrrheJMkoXZRkhWDylJlIWoNBI5rv
         CfCiJxb5cqQ4J5gxLEmUhOHFgM4ubI+Ej87Ie66sSENox//wiqjmV8EUAqjlmmtkY2Up
         VlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709141633; x=1709746433;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VD4WJ7Dq6fHRKWtx/LCBxzWvZsBw52eMwWJcaWPnawk=;
        b=IE/bPrN/j4BluMcUvsaKDDcok9j1r7hw+sVZmNJxXP4ZpGU2y72mXNNNYAamuyAp/Z
         WH9oXcIYh9jAcueKVauEEJrfUU/diPSZvs3dEB8iN33DdYPqNTRWb9sqaJE5GZNxryIr
         sOKRDUiMcOfgs9fTKGuiIxQv5Y4DlhC9ojt13hIfsdWlxHjtc9P0AjO2VdExzRE7aNZX
         7A9zGWDcsiyiB8KaJ5hIz6+uL7Z/Rqc6MnuzZUuhGhqj0Lgkxgg6FKdXy1wdkkKMqxJL
         ALOxAbN/cHlYVij0oiWAv9Xwcvp2cCxsFiGqEgzy9W1gmRNG9vDpmaM/w7whMcnwleE0
         7HGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8PM3fPh0kQfP7IJgt+6sHuxmddSfDdcrnpUPb85Sfg8JuEqQDnCCgYGSTMaEyIJ6x/I97pE3/9xhpmTBTuNE00tTjPaJac4PG2BoT
X-Gm-Message-State: AOJu0YybkGieN6oKu18pynWLj+aDEPrDxUG2hpsZN4gBUJqvDzouX1iu
	yUtx/is8oD8fqFvMP2qto9aN0VBX5jwkgRh7A80GwBnb9K8HvfTfn1tfKW9ApiJyBQQUq+73mi2
	ufO7F5EkabVNOuF9wEPxugX1QXII=
X-Google-Smtp-Source: AGHT+IH3zISbZxvNa1MA8MxFbXD3SQ8elZxU+XxqFWrGJYn1fWLXeDG6dDVuWMREn/sPGyu5OhO7DraAo5tQ4QCYIYg=
X-Received: by 2002:a1f:62c2:0:b0:4d1:34a1:c892 with SMTP id
 w185-20020a1f62c2000000b004d134a1c892mr274781vkb.13.1709141633064; Wed, 28
 Feb 2024 09:33:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227172852.2386358-1-tj@kernel.org> <20240227172852.2386358-7-tj@kernel.org>
In-Reply-To: <20240227172852.2386358-7-tj@kernel.org>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 28 Feb 2024 09:33:40 -0800
Message-ID: <CAOMdWSLVDaN_XFD6Ov-=6VrH4wyBz-0wq_L3EzgdsJ5zJi47qQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] r8152: Convert from tasklet to BH workqueue
To: Tejun Heo <tj@kernel.org>
Cc: jiangshanlai@gmail.com, torvalds@linux-foundation.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, boqun.feng@gmail.com, 
	tglx@linutronix.de, peterz@infradead.org, romain.perier@gmail.com, 
	mingo@kernel.org
Content-Type: text/plain; charset="UTF-8"

> tasklet is being replaced by BH workqueue. No noticeable behavior or
> performance changes are expected. The following is how the two APIs map:
>
> - tasklet_setup/init()          -> INIT_WORK()
> - tasklet_schedule()            -> queue_work(system_bh_wq, ...)
> - tasklet_hi_schedule()         -> queue_work(system_bh_highpri_wq, ...)
> - tasklet_disable_nosync()      -> disable_work()
> - tasklet_disable[_in_atomic]() -> disable_work_sync()
> - tasklet_enable()              -> enable_work() + queue_work()
> - tasklet_kill()                -> cancel_work_sync()
>
> Note that unlike tasklet_enable(), enable_work() doesn't queue the work item
> automatically according to whether the work item was queued while disabled.
> While the caller can track this separately, unconditionally scheduling the
> work item after enable_work() returns %true should work for most users.
>
> r8152 conversion has been tested by repeatedly forcing the device to go
> through resets using usbreset under iperf3 generated traffic.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  drivers/net/usb/r8152.c | 44 ++++++++++++++++++++++-------------------
>  1 file changed, 24 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 9bf2140fd0a1..24e284b9eb38 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -882,7 +882,7 @@ struct r8152 {
>  #ifdef CONFIG_PM_SLEEP
>         struct notifier_block pm_notifier;
>  #endif
> -       struct tasklet_struct tx_tl;
> +       struct work_struct tx_work;
>
>         struct rtl_ops {
>                 void (*init)(struct r8152 *tp);
> @@ -1948,7 +1948,7 @@ static void write_bulk_callback(struct urb *urb)
>                 return;
>
>         if (!skb_queue_empty(&tp->tx_queue))
> -               tasklet_schedule(&tp->tx_tl);
> +               queue_work(system_bh_wq, &tp->tx_work);
>  }
>
>  static void intr_callback(struct urb *urb)
> @@ -2746,9 +2746,9 @@ static void tx_bottom(struct r8152 *tp)
>         } while (res == 0);
>  }
>
> -static void bottom_half(struct tasklet_struct *t)
> +static void bottom_half(struct work_struct *work)
>  {
> -       struct r8152 *tp = from_tasklet(tp, t, tx_tl);
> +       struct r8152 *tp = container_of(work, struct r8152, tx_work);
>
>         if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>                 return;
> @@ -2942,7 +2942,7 @@ static netdev_tx_t rtl8152_start_xmit(struct sk_buff *skb,
>                         schedule_delayed_work(&tp->schedule, 0);
>                 } else {
>                         usb_mark_last_busy(tp->udev);
> -                       tasklet_schedule(&tp->tx_tl);
> +                       queue_work(system_bh_wq, &tp->tx_work);
>                 }
>         } else if (skb_queue_len(&tp->tx_queue) > tp->tx_qlen) {
>                 netif_stop_queue(netdev);
> @@ -6824,11 +6824,12 @@ static void set_carrier(struct r8152 *tp)
>         } else {
>                 if (netif_carrier_ok(netdev)) {
>                         netif_carrier_off(netdev);
> -                       tasklet_disable(&tp->tx_tl);
> +                       disable_work_sync(&tp->tx_work);
>                         napi_disable(napi);
>                         tp->rtl_ops.disable(tp);
>                         napi_enable(napi);
> -                       tasklet_enable(&tp->tx_tl);
> +                       enable_work(&tp->tx_work);
> +                       queue_work(system_bh_wq, &tp->tx_work);
>                         netif_info(tp, link, netdev, "carrier off\n");
>                 }
>         }
> @@ -6864,7 +6865,7 @@ static void rtl_work_func_t(struct work_struct *work)
>         /* don't schedule tasket before linking */
>         if (test_and_clear_bit(SCHEDULE_TASKLET, &tp->flags) &&
>             netif_carrier_ok(tp->netdev))
> -               tasklet_schedule(&tp->tx_tl);
> +               queue_work(system_bh_wq, &tp->tx_work);
>
>         if (test_and_clear_bit(RX_EPROTO, &tp->flags) &&
>             !list_empty(&tp->rx_done))
> @@ -6971,7 +6972,7 @@ static int rtl8152_open(struct net_device *netdev)
>                 goto out_unlock;
>         }
>         napi_enable(&tp->napi);
> -       tasklet_enable(&tp->tx_tl);
> +       enable_work(&tp->tx_work);

  I think we are missing queue_work() above, right?

   To avoid such situations, could we combine enable_work() + queue_work(),
into a single API?
Perhaps, something like:

static inline bool enable_and_queue_work(struct workqueue_struct *wq,
struct work_struct *work)
{
       if (enable_work(work))
       {
             queue_work(wq, work);
             return true;
       }
       return false;
}


Thanks,
Allen


>         mutex_unlock(&tp->control);
>
> @@ -6999,7 +7000,7 @@ static int rtl8152_close(struct net_device *netdev)
>  #ifdef CONFIG_PM_SLEEP
>         unregister_pm_notifier(&tp->pm_notifier);
>  #endif
> -       tasklet_disable(&tp->tx_tl);
> +       disable_work_sync(&tp->tx_work);
>         clear_bit(WORK_ENABLE, &tp->flags);
>         usb_kill_urb(tp->intr_urb);
>         cancel_delayed_work_sync(&tp->schedule);
> @@ -8421,7 +8422,7 @@ static int rtl8152_pre_reset(struct usb_interface *intf)
>                 return 0;
>
>         netif_stop_queue(netdev);
> -       tasklet_disable(&tp->tx_tl);
> +       disable_work_sync(&tp->tx_work);
>         clear_bit(WORK_ENABLE, &tp->flags);
>         usb_kill_urb(tp->intr_urb);
>         cancel_delayed_work_sync(&tp->schedule);
> @@ -8466,7 +8467,8 @@ static int rtl8152_post_reset(struct usb_interface *intf)
>         }
>
>         napi_enable(&tp->napi);
> -       tasklet_enable(&tp->tx_tl);
> +       enable_work(&tp->tx_work);
> +       queue_work(system_bh_wq, &tp->tx_work);
>         netif_wake_queue(netdev);
>         usb_submit_urb(tp->intr_urb, GFP_KERNEL);
>
> @@ -8625,12 +8627,13 @@ static int rtl8152_system_suspend(struct r8152 *tp)
>
>                 clear_bit(WORK_ENABLE, &tp->flags);
>                 usb_kill_urb(tp->intr_urb);
> -               tasklet_disable(&tp->tx_tl);
> +               disable_work_sync(&tp->tx_work);
>                 napi_disable(napi);
>                 cancel_delayed_work_sync(&tp->schedule);
>                 tp->rtl_ops.down(tp);
>                 napi_enable(napi);
> -               tasklet_enable(&tp->tx_tl);
> +               enable_work(&tp->tx_work);
> +               queue_work(system_bh_wq, &tp->tx_work);
>         }
>
>         return 0;
> @@ -9387,11 +9390,12 @@ static int rtl8152_change_mtu(struct net_device *dev, int new_mtu)
>                 if (netif_carrier_ok(dev)) {
>                         netif_stop_queue(dev);
>                         napi_disable(&tp->napi);
> -                       tasklet_disable(&tp->tx_tl);
> +                       disable_work_sync(&tp->tx_work);
>                         tp->rtl_ops.disable(tp);
>                         tp->rtl_ops.enable(tp);
>                         rtl_start_rx(tp);
> -                       tasklet_enable(&tp->tx_tl);
> +                       enable_work(&tp->tx_work);
> +                       queue_work(system_bh_wq, &tp->tx_work);
>                         napi_enable(&tp->napi);
>                         rtl8152_set_rx_mode(dev);
>                         netif_wake_queue(dev);
> @@ -9819,8 +9823,8 @@ static int rtl8152_probe_once(struct usb_interface *intf,
>         mutex_init(&tp->control);
>         INIT_DELAYED_WORK(&tp->schedule, rtl_work_func_t);
>         INIT_DELAYED_WORK(&tp->hw_phy_work, rtl_hw_phy_work_func_t);
> -       tasklet_setup(&tp->tx_tl, bottom_half);
> -       tasklet_disable(&tp->tx_tl);
> +       INIT_WORK(&tp->tx_work, bottom_half);
> +       disable_work(&tp->tx_work);
>
>         netdev->netdev_ops = &rtl8152_netdev_ops;
>         netdev->watchdog_timeo = RTL8152_TX_TIMEOUT;
> @@ -9954,7 +9958,7 @@ static int rtl8152_probe_once(struct usb_interface *intf,
>         unregister_netdev(netdev);
>
>  out1:
> -       tasklet_kill(&tp->tx_tl);
> +       cancel_work_sync(&tp->tx_work);
>         cancel_delayed_work_sync(&tp->hw_phy_work);
>         if (tp->rtl_ops.unload)
>                 tp->rtl_ops.unload(tp);
> @@ -10010,7 +10014,7 @@ static void rtl8152_disconnect(struct usb_interface *intf)
>                 rtl_set_unplug(tp);
>
>                 unregister_netdev(tp->netdev);
> -               tasklet_kill(&tp->tx_tl);
> +               cancel_work_sync(&tp->tx_work);
>                 cancel_delayed_work_sync(&tp->hw_phy_work);
>                 if (tp->rtl_ops.unload)
>                         tp->rtl_ops.unload(tp);
> --
> 2.43.2
>


-- 
       - Allen

