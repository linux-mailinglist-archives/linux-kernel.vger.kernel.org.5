Return-Path: <linux-kernel+bounces-30218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B97A9831BAC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCA801C22C24
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698E41DA2C;
	Thu, 18 Jan 2024 14:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZepYRH9l"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1571DDC3;
	Thu, 18 Jan 2024 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705589056; cv=none; b=WW4z4L5T4KM8X0JA0XuqxYXWQ49FUT3jt5kVpyiGnfpL/QHQDbRg4yoO5t5cmhSQGuPl9jgUOGE1v7YTkqwR6SV6uondW9CGGX6Ek5B3ZWAemkHvpSzr5WqRQ4zsCEZmL/Gy3wZzGZMNYJPQCfVeMgS9Jiq0vCgH7Ke1PnKPCyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705589056; c=relaxed/simple;
	bh=WCFGPbYkiQVLbhVotzaLYbYZTWEoJCeuU36QUwXEvMs=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Message-ID:In-Reply-To:References:Subject:Mime-Version:
	 Content-Type:Content-Transfer-Encoding; b=JZUtYwCXFZCvS52DG4J/mEy+GM69mz7SixftLvrtE/vSvIHGKJgnHukSO8p9H+niNZ6iZTnTSq4r9gp7vjExwk8BdJge8brPyG3Pz4GUuOLCmkVZYE54ENpgTIzwjOvkEr0GeE5lXU4sDzAs5+8Dd8Q16AtniBDIpumIC4iuL0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZepYRH9l; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-78339210979so767687485a.1;
        Thu, 18 Jan 2024 06:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705589054; x=1706193854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YoZ+SlkruvUdNkH7eZxjFcDuia7cqhFoQuvvT1OXvIY=;
        b=ZepYRH9lKAtqoFPXa/7Lka4xSlLEpq5qPJcAi0HrqSHVbNQomh2U+f7MO90Fb1Np8R
         I6OKEHYP63okJhz2fnL267g8Ku5NO7OgG9S/KrlJKWkdysebiBloY4aj+t5mX9lewifq
         tSST8eV4M+7JE//Nsws07ZLRL8tHkXzxmtJMBE2FAFYFw98etO2OcAXM2+Uxo5y31089
         mT2ESHZ3smREOOQ37PuS78UFR7lOfXmTtciQEip+9MdT7KJ+JcjUBD/QcbNK9515EplM
         aAjLuo5adjEyRWcPOsbTjem0f4w3zT1A6QY8VK3Q4NhTmYTaE8EkrikvvUECDdNbFmtv
         8N0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705589054; x=1706193854;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YoZ+SlkruvUdNkH7eZxjFcDuia7cqhFoQuvvT1OXvIY=;
        b=mm76E2fmc23jnRIJJAHTq7xlXnOA+7OhB5G2Zpfc89ZoH6NYdRwdpnIIcQOerXBKwP
         vjqafnbRFT25VazlXFR019GvMIP25OI2g/TWtFjxgs2U8QyGybMXfrc3qfRg12Cu26lx
         z1exJmTdiDfCaT5zXA2igg+jHMZkFQqSUJpFxqqkzlSs7k+K+KS9B+WFWrM8TR+xVJK9
         su9q4eS6DkDs6USQibJh9r+QFxZOESQVWY3c7TGSc2xfb9vYexPrAaTfzul5N2TO44hI
         oICOu2Y+p/2zvM3FY5L3hW4yjw9smC9QaoTZCal5c3Ob31+QBYxMIzW3lxll3gJ+iTZD
         3zng==
X-Gm-Message-State: AOJu0Ywon46VmidXaI9RUt3E4VdRh7SgKvUIjx6DkUnAC8jOPDnhoaqm
	bUo/MK9EMxerv3FzSGM+B1ohKoDJBkHsvFizSTDM/tH+mQ+VXAqazoMB3D0W
X-Google-Smtp-Source: AGHT+IEzw5yCRzR2VREpYP1zk6hUvPux7J9JLpCfOheCUlMPLJnyZiI+suikwj2sbgt4VUO4d0h4Kg==
X-Received: by 2002:a05:620a:134b:b0:783:148f:a691 with SMTP id c11-20020a05620a134b00b00783148fa691mr948410qkl.71.1705589053991;
        Thu, 18 Jan 2024 06:44:13 -0800 (PST)
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id q27-20020a05620a0c9b00b00781663f3161sm5350246qki.85.2024.01.18.06.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 06:44:13 -0800 (PST)
Date: Thu, 18 Jan 2024 09:44:13 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: wangyunjian <wangyunjian@huawei.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "jasowang@redhat.com" <jasowang@redhat.com>, 
 "kuba@kernel.org" <kuba@kernel.org>, 
 "davem@davemloft.net" <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 xudingke <xudingke@huawei.com>
Message-ID: <65a9393d75353_1c8cde294e2@willemb.c.googlers.com.notmuch>
In-Reply-To: <ed6fd9c514ae4a449580d11c9c6ba8e7@huawei.com>
References: <1705490503-28844-1-git-send-email-wangyunjian@huawei.com>
 <65a7f560a4643_6ba59294a7@willemb.c.googlers.com.notmuch>
 <ed6fd9c514ae4a449580d11c9c6ba8e7@huawei.com>
Subject: RE: [PATCH net v3] tun: add missing rx stats accounting in
 tun_xdp_act
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

wangyunjian wrote:
> > -----Original Message-----
> > From: Willem de Bruijn [mailto:willemdebruijn.kernel@gmail.com]
> > Sent: Wednesday, January 17, 2024 11:42 PM
> > To: wangyunjian <wangyunjian@huawei.com>;
> > willemdebruijn.kernel@gmail.com; jasowang@redhat.com; kuba@kernel.org;
> > davem@davemloft.net
> > Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; xudingke
> > <xudingke@huawei.com>; wangyunjian <wangyunjian@huawei.com>
> > Subject: Re: [PATCH net v3] tun: add missing rx stats accounting in tun_xdp_act
> > 
> > Yunjian Wang wrote:
> > > The TUN can be used as vhost-net backend, and it is necessary to count
> > > the packets transmitted from TUN to vhost-net/virtio-net. However,
> > > there are some places in the receive path that were not taken into
> > > account when using XDP. The commit 8ae1aff0b331 ("tuntap: split out
> > > XDP logic") only includes dropped counter for XDP_DROP, XDP_ABORTED,
> > > and invalid XDP actions. It would be beneficial to also include new
> > > accounting for successfully received bytes using
> > > dev_sw_netstats_rx_add and introduce new dropped counter for XDP errors
> > on XDP_TX and XDP_REDIRECT.
> > 
> > From the description it is clear that these are two separate changes wrapped
> > into one patch. I should have flagged this previously.
> 
> Do I need to split these two modifications into 2 patches?
> 1. only fix dropped counter
> 2. add new accounting for successfully received bytes
> Or:
> Only fix dropped counter?

It's definitely good to fix both.

It might be a bit pedantic, but two separate patches is more correct.

The second fix, add missing byte counter, goes back to the original
introduction of XDP for tun, so has a different tag:

Fixes: 761876c857cb ("tap: XDP support")

> 
> > 
> > Ack on returning the error counter that was previously present and matches
> > the Fixes tag.
> > 
> > For the second change, I had to check a few other XDP capable drivers to verify
> > that it is indeed common to count such packets.
> > 
> > > Fixes: 8ae1aff0b331 ("tuntap: split out XDP logic")
> > > Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> > > ---
> > > v3: update commit log and code
> > > v2: add Fixes tag
> > > ---
> > >  drivers/net/tun.c | 14 +++++++++-----
> > >  1 file changed, 9 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/net/tun.c b/drivers/net/tun.c index
> > > afa5497f7c35..0704a17e74e1 100644
> > > --- a/drivers/net/tun.c
> > > +++ b/drivers/net/tun.c
> > > @@ -1625,18 +1625,15 @@ static struct sk_buff *__tun_build_skb(struct
> > > tun_file *tfile,  static int tun_xdp_act(struct tun_struct *tun, struct
> > bpf_prog *xdp_prog,
> > >  		       struct xdp_buff *xdp, u32 act)  {
> > > -	int err;
> > > +	unsigned int datasize = xdp->data_end - xdp->data;
> > > +	int err = 0;
> > >
> > >  	switch (act) {
> > >  	case XDP_REDIRECT:
> > >  		err = xdp_do_redirect(tun->dev, xdp, xdp_prog);
> > > -		if (err)
> > > -			return err;
> > >  		break;
> > >  	case XDP_TX:
> > >  		err = tun_xdp_tx(tun->dev, xdp);
> > > -		if (err < 0)
> > > -			return err;
> > >  		break;
> > >  	case XDP_PASS:
> > >  		break;
> > > @@ -1651,6 +1648,13 @@ static int tun_xdp_act(struct tun_struct *tun,
> > struct bpf_prog *xdp_prog,
> > >  		break;
> > >  	}
> > >
> > > +	if (err < 0) {
> > > +		act = err;
> > > +		dev_core_stats_rx_dropped_inc(tun->dev);
> > > +	} else if (act == XDP_REDIRECT || act == XDP_TX) {
> > > +		dev_sw_netstats_rx_add(tun->dev, datasize);
> > > +	}
> > > +
> > 
> > Let's avoid adding yet another branch and just do these operations in the case
> > statements, like XDP_DROP.
> 
> Fix it like this?

Perhaps avoid computing datasize is all paths, when it is not used
in common XDP_PASS, high performance XDP_DROP and a few others. Not
sure whether (all) compilers would optimze that.

        dev_core_stats_rx_dropped_inc(tun->dev, xdp,
                                      xdp->data_end - xdp->data);


> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1625,18 +1625,25 @@ static struct sk_buff *__tun_build_skb(struct tun_file *tfile,
>  static int tun_xdp_act(struct tun_struct *tun, struct bpf_prog *xdp_prog,
>                        struct xdp_buff *xdp, u32 act)
>  {
> +       unsigned int datasize = xdp->data_end - xdp->data;
>         int err;
>  
>         switch (act) {
>         case XDP_REDIRECT:
>                 err = xdp_do_redirect(tun->dev, xdp, xdp_prog);
> -               if (err)
> +               if (err) {
> +                       dev_core_stats_rx_dropped_inc(tun->dev);
>                         return err;
> +               }
> +               dev_sw_netstats_rx_add(tun->dev, datasize);
>                 break;
>         case XDP_TX:
>                 err = tun_xdp_tx(tun->dev, xdp);
> -               if (err < 0)
> +               if (err < 0) {
> +                       dev_core_stats_rx_dropped_inc(tun->dev);
>                         return err;
> +               }
> +               dev_sw_netstats_rx_add(tun->dev, datasize);
>                 break;
>         case XDP_PASS:
> 
> > 
> > >  	return act;
> > >  }
> > >
> > > --
> > > 2.41.0
> > >
> > 
> > 
> 



