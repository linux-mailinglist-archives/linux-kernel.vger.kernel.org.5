Return-Path: <linux-kernel+bounces-37897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E23683B754
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 03:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D081E282240
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 02:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A766FB6;
	Thu, 25 Jan 2024 02:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXHjdc3F"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B95A566A;
	Thu, 25 Jan 2024 02:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706150787; cv=none; b=GhPYKGhP1H60r8J/OTrae/3XgyPckvZu4dAIP7rVYST6wtOw7yj8jaCcTJTCE4R8T4A/gP4vSkYAcu22xQ45CSGaeG4fPHHfvsQ14MyjZLVOKJyqT9IGv/35FgpUe20FZAZgfE5eEZXHDALTxJZbskwdR86N1AXdQGadiUUDgGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706150787; c=relaxed/simple;
	bh=EIzoKUrWgYKQUkaf8D0oAhqrDucJuvoIW9UPgeX/fGU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=J9O+S06sC8OTdidLtCdd5en2aRBfSXYJEAidw7/9Sg4XL+0FiAtc95RgZiDgcauFVbIGfQ5sLLU6hQ9WYldigYx419SQ7tOkgKrMENwiuS6VoRXMKCHVkQUUE+MY1/cAlPQS9HNejFvde/SNQm0TeIygw6YZ6GbUcHjkYtTtrUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXHjdc3F; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-783b7ec94d4so71314385a.1;
        Wed, 24 Jan 2024 18:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706150784; x=1706755584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mclETPRpYIW12ULS4u08qVFtz8ioPIiE9lpjrb3XQZQ=;
        b=FXHjdc3Fa4HfYsxzC95t7Wv1ujxhHqoX7WvEVzYHDDVrP+uC+UT82yD1KPVhYN8DPL
         YrHOFixe7uwOiafRO6ycyGbHPN23CoO8hgIfN2/Ymbj/9YSn5vmZDoblJTRZ8tP4Vw8S
         1Oqu185xTYk5rQk/83/B74jew8VZvj3NmyCjYAoDvrWfUG5ztBB4h28ERwV2FdLn640L
         m3IOBkEn56lDl5FW6b0xosVp8VMb0k5o9VVNqniOgEASDTZrKvcpvgA3axOY/eyrCwc1
         9Ql/MXC+hvrQEBLJkQYNAqq44k3lj7NZ6BElsKNwFuoxwU6G4CNvlRRYdeWZkNQ8O7p2
         9pWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706150784; x=1706755584;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mclETPRpYIW12ULS4u08qVFtz8ioPIiE9lpjrb3XQZQ=;
        b=RJlp049V2qHj3Syf2vzB0i/aCxGumUfdpEZfOKi+cKAtGOiGETMz4KwHg1s3msM979
         GrnaJseVLzvLdrJilI04tendyfgdrcFeB4Culu4lCQwkOZTYGOPd9zETTEkJgX8hfcEB
         wqSVw4vtczKAk/a7p1BpiAPloQOkE1UM1PdSKfdyWq4BLlnz/EejYUR8cGJ5NYQNBGQn
         Qkox4bWfaQATAIzgTXkwbOxn1GZfA85C/69kcbKOBzDhyew5kbePMhyUSVldHUVFNX0T
         scrD1so1fIlh4Jz1t5b81Hk/Nyt2W4GR/UPyADJYFM3yKyCMm9lLq0hyOCHqou7ZOzhU
         mU3A==
X-Gm-Message-State: AOJu0YxpqOsKa41rQh/fW2I+J4+PCmCa9cdGUQxlR5QrEq1YaUrDb/is
	Zyr0wf63/DzHkY4VCYM2RGcbM3eXFrf4Py9+7wqfISD2mA66q/83
X-Google-Smtp-Source: AGHT+IGodqpXMuBS2duJzFY8gsyfaK8nc5e7N19ugkz8byxjhCgqMXOvLVShxH5GPJ9IKkwIPiZC9A==
X-Received: by 2002:ac8:5bd0:0:b0:42a:3b61:2cb2 with SMTP id b16-20020ac85bd0000000b0042a3b612cb2mr335697qtb.92.1706150783994;
        Wed, 24 Jan 2024 18:46:23 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUaYwuANash8EJ5tBSIC9R+pkqFfK+NtnyTeDrsfvzGojl/CgmpN7xQhIMlUFN4pAy51qLpMs4SAhww9SWTUe8oklUTiyeQQPoZPkv928Qw1iWXbmDQSSza/mB8tzY5Ve7eiaB2AEdCkUkYx5i1tAXk49ilD0yxquB//zdoLgupHkgNWYag7Du69HxdY/ylPq8GWleGKVfjgZDkoBoK2vqxJxsbwrn6DtQBbzdOxt6dfRW7ng2r+2LN2hHYUgSFn0msM65FjZlkeLUlUYVSMXQjSaGYcUiChXL8LuM/5oFO/vxSCLUy541q112kE5rT3rLjNdCVQ7mmVPhVml/64Y/0QDYkxEm5ngWT0sBtqh17E+3AeHckZP13ebFhYESP1MmZrVjOZxj/YFB8MGVO
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id cf12-20020a05622a400c00b00427f375c329sm4932508qtb.26.2024.01.24.18.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 18:46:23 -0800 (PST)
Date: Wed, 24 Jan 2024 21:46:23 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Joe Damato <jdamato@fastly.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: chuck.lever@oracle.com, 
 jlayton@kernel.org, 
 linux-api@vger.kernel.org, 
 brauner@kernel.org, 
 edumazet@google.com, 
 davem@davemloft.net, 
 alexander.duyck@gmail.com, 
 sridhar.samudrala@intel.com, 
 kuba@kernel.org, 
 weiwan@google.com, 
 Joe Damato <jdamato@fastly.com>
Message-ID: <65b1cb7f73a6a_250560294bd@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240125003014.43103-4-jdamato@fastly.com>
References: <20240125003014.43103-1-jdamato@fastly.com>
 <20240125003014.43103-4-jdamato@fastly.com>
Subject: Re: [net-next v2 3/4] eventpoll: Add epoll ioctl for epoll_params
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Joe Damato wrote:
> Add an ioctl for getting and setting epoll_params. User programs can use
> this ioctl to get and set the busy poll usec time or packet budget
> params for a specific epoll context.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>

Please be sure to include the lists and people suggested by
`get_maintainer.pl -f fs/eventpoll.c`.

Adding ioctls is generally discouraged.

As this affects the behavior of epoll_wait, should this just be a
flag to (a new variant of) epoll_wait?

Speaking from some experience with adding epoll_pwait2. I initially
there added a stateful change that would affect wait behavior. The
sensible feedback as the time was to just change the behavior of the
syscall it affected. Even if that requires a syscall (which is not
that different from an ioctl, if better defined).

The discussion in that thread may be informative to decide on API:
https://lwn.net/ml/linux-kernel/20201116161001.1606608-1-willemdebruijn.kernel@gmail.com/

Agreed on the overall principle that it is preferable to be able to
enable busypolling selectively. We already do for SO_BUSY_POLL and
sysctl busy_read.

> ---
>  .../userspace-api/ioctl/ioctl-number.rst      |  1 +
>  fs/eventpoll.c                                | 47 +++++++++++++++++++
>  include/uapi/linux/eventpoll.h                | 12 +++++
>  3 files changed, 60 insertions(+)
> 
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index 457e16f06e04..b33918232f78 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -309,6 +309,7 @@ Code  Seq#    Include File                                           Comments
>  0x89  0B-DF  linux/sockios.h
>  0x89  E0-EF  linux/sockios.h                                         SIOCPROTOPRIVATE range
>  0x89  F0-FF  linux/sockios.h                                         SIOCDEVPRIVATE range
> +0x8A  00-1F  linux/eventpoll.h
>  0x8B  all    linux/wireless.h
>  0x8C  00-3F                                                          WiNRADiO driver
>                                                                       <http://www.winradio.com.au/>
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 40bd97477b91..c1ee0fe01da1 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -6,6 +6,8 @@
>   *  Davide Libenzi <davidel@xmailserver.org>
>   */
>  
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/sched/signal.h>
> @@ -869,6 +871,49 @@ static void ep_clear_and_put(struct eventpoll *ep)
>  		ep_free(ep);
>  }
>  
> +static long ep_eventpoll_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +	int ret;
> +	struct eventpoll *ep;
> +	struct epoll_params epoll_params;
> +	void __user *uarg = (void __user *) arg;
> +
> +	if (!is_file_epoll(file))
> +		return -EINVAL;
> +
> +	ep = file->private_data;
> +
> +	switch (cmd) {
> +#ifdef CONFIG_NET_RX_BUSY_POLL
> +	case EPIOCSPARAMS:
> +		if (copy_from_user(&epoll_params, uarg, sizeof(epoll_params)))
> +			return -EFAULT;
> +
> +		if (epoll_params.busy_poll_budget > NAPI_POLL_WEIGHT)
> +			pr_err("busy poll budget %u exceeds suggested maximum %u\n",
> +					epoll_params.busy_poll_budget, NAPI_POLL_WEIGHT);
> +
> +		ep->busy_poll_usecs = epoll_params.busy_poll_usecs;
> +		ep->busy_poll_budget = epoll_params.busy_poll_budget;
> +		return 0;
> +
> +	case EPIOCGPARAMS:
> +		memset(&epoll_params, 0, sizeof(epoll_params));
> +		epoll_params.busy_poll_usecs = ep->busy_poll_usecs;
> +		epoll_params.busy_poll_budget = ep->busy_poll_budget;
> +		if (copy_to_user(uarg, &epoll_params, sizeof(epoll_params)))
> +			return -EFAULT;
> +
> +		return 0;
> +#endif
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
>  static int ep_eventpoll_release(struct inode *inode, struct file *file)
>  {
>  	struct eventpoll *ep = file->private_data;
> @@ -975,6 +1020,8 @@ static const struct file_operations eventpoll_fops = {
>  	.release	= ep_eventpoll_release,
>  	.poll		= ep_eventpoll_poll,
>  	.llseek		= noop_llseek,
> +	.unlocked_ioctl	= ep_eventpoll_ioctl,
> +	.compat_ioctl   = compat_ptr_ioctl,
>  };
>  
>  /*
> diff --git a/include/uapi/linux/eventpoll.h b/include/uapi/linux/eventpoll.h
> index cfbcc4cc49ac..8eb0fdbce995 100644
> --- a/include/uapi/linux/eventpoll.h
> +++ b/include/uapi/linux/eventpoll.h
> @@ -85,4 +85,16 @@ struct epoll_event {
>  	__u64 data;
>  } EPOLL_PACKED;
>  
> +struct epoll_params {
> +	u64 busy_poll_usecs;
> +	u16 busy_poll_budget;
> +
> +	/* for future fields */
> +	u8 data[118];
> +} EPOLL_PACKED;
> +
> +#define EPOLL_IOC_TYPE 0x8A
> +#define EPIOCSPARAMS _IOW(EPOLL_IOC_TYPE, 0x01, struct epoll_params)
> +#define EPIOCGPARAMS _IOR(EPOLL_IOC_TYPE, 0x02, struct epoll_params)
> +
>  #endif /* _UAPI_LINUX_EVENTPOLL_H */
> -- 
> 2.25.1
> 



