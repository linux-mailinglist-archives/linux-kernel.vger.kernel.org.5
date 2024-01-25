Return-Path: <linux-kernel+bounces-38707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C2B83C465
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D4FE1F23E95
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A2163405;
	Thu, 25 Jan 2024 14:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4KhpNVP"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4EF2D627;
	Thu, 25 Jan 2024 14:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706191886; cv=none; b=p9XRtmyKI4zK/SArI7BGdWApktB0DmFtEu8bef5rv+paCJGpI+0o01e28Qxq30FR5TmWrMxXHkAjUzHuyaa+jUZnua2cFieFMcy2kN1hVkln9nmMkbJ4esDELNxJqYPHjhIdknpqUdRVrVMAuW6He9YW2u4KpcenO3gQtLxp7Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706191886; c=relaxed/simple;
	bh=0iQRw21OAU34dIrmX0/ZgzKF1HOn7qpSiAngu8dBphc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=tyaBMJ86UzcnXazijHzq3J7fU7Hbcb3LSm6VxHmLj19fuGZgPgjNa2uiGk23M3qsVRdz3JZte5Zck4MqyXmq1UNzmbRaBRUAyubcYpjkfUtd5qLqH9o8TEh2/JVL0EeMKPP1q4/chvcFJ5mSw0s0NE1ZYL+dHjEXB6a7vDrFtVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4KhpNVP; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-783137d8049so562842285a.2;
        Thu, 25 Jan 2024 06:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706191884; x=1706796684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsREW+LG4sNq5C/r9JnpxuzCqtoBvg3yhlJSA/oDkwk=;
        b=b4KhpNVPg48Vx/dlKvvd5I7Hnf4NbxntgJCoFZPf69jQGk3IuGWlflQdwbt+G4MFV3
         SLh4CHgFm72SfDNT/xxF6FtEXu138wIo+gKuBxkPISKvWCXfO4RbGSRlyqc2J+zAPtqj
         eT/VpSsN/7aOTipIpnoA+bcXEIEzOo1PLGEq8tb0JSibcUuXPCYYBQptLQIXWSi7Qnol
         6IqvaDaJYqeZAljeQBUbcTFiZZ7/rTbLNRoF4sy7zdy4gdnMSkPoar1Y+WzbmPxrOfdc
         mo+AOZrKRqMqK1Nhr5F8fahJ6D3MfpUmfJQdcr/eDLNYA2L2xz2fdAaa0U/7ajZIdqBW
         +wCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706191884; x=1706796684;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IsREW+LG4sNq5C/r9JnpxuzCqtoBvg3yhlJSA/oDkwk=;
        b=SFKAfmaKJT1PxJS4v9717qA9xmyjH5N+Xs85kR9fximCWq87hlUF+DfDOB6r0OGbOX
         ucIeO+OHGKwQPHI6ay6l4qo9Uioxwd1PuwwMzQjP2yCjr+TRqfetQk+rkBW8FUxDNKlW
         z74Jv02WaUqyAtUzA09OOP1Sphr0xcMp3B9hhFdyshbLrZ8pKdsSSZGNnttsR7MEPhR5
         ZtInELq+sz4DcJ0Hxekuavir3E2GAIdALcO0D9mSkIUY2Psv7m+lvlouRyfwhl4hzist
         k7nR18fU5C3RALHzcrbuxIw8dHf0SW2e/oJW8g8BL4DpgMxFhSqpZJ7nQrI33biMa4pS
         9qYw==
X-Gm-Message-State: AOJu0YxzkATFAmT12oW8FcrumsGIcb4rqHkPecVwsTzU+1wv8tr1pPzN
	p9HLLuIixHYnD/T3xNNVB9JcQ6Ec3+cIErYVUDlfs5T2/gloXHPE
X-Google-Smtp-Source: AGHT+IESc/WCsWIwF12rCYDTPHDd/JRoJdCLpLJMm862gzu7IcvSlacaxx9b5yR5n8LgFX/JwaZnhg==
X-Received: by 2002:ae9:ee11:0:b0:783:1683:548 with SMTP id i17-20020ae9ee11000000b0078316830548mr1273386qkg.64.1706191884150;
        Thu, 25 Jan 2024 06:11:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVANvkD/EXIPA6BqWO8Km7lx3jodwp9n6IoGzDEOlL4S1wSlngJIwHXe481sKsPDcHmaJDOEV5/whHYngeAWnhMbvH40oPKS/wXtzy3X7flR64RoG39d8DtwSVZt65UuXT7jCfY08uEJ9WdnnclfN952W2MOywpQ+gVXLWy2KRWzt9PXv9VIfZOSXtK50iY482y4erUniVA0PEIRnZCZet9ATuj11aiKxZxfagdzF+vcW6CQbOXqlXE0/i02fY9dXc29bC+WFPqehnTIpiA5fgOpb4qwxNqLXlQ4VXV+DqqrKrTyobL6FeLSSlXw6YXViaIZglGpR8rdXeWnpdMq28DSdAiVEGJVLV/3rgbUhC3JEJ586EP97hapha3vEyOfpPLdXiovxYYi96jggrO2k0b3/vvhDlcnumWr9MnYZ9kXfFJdtnFEIAqca/VOdy0
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id h22-20020a05620a10b600b00783949e7817sm4783779qkk.92.2024.01.25.06.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:11:23 -0800 (PST)
Date: Thu, 25 Jan 2024 09:11:22 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Joe Damato <jdamato@fastly.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 chuck.lever@oracle.com, 
 jlayton@kernel.org, 
 linux-api@vger.kernel.org, 
 brauner@kernel.org, 
 edumazet@google.com, 
 davem@davemloft.net, 
 alexander.duyck@gmail.com, 
 sridhar.samudrala@intel.com, 
 kuba@kernel.org, 
 weiwan@google.com
Message-ID: <65b26c0ada0c6_2b890a294ef@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240125042746.GA1294@fastly.com>
References: <20240125003014.43103-1-jdamato@fastly.com>
 <20240125003014.43103-4-jdamato@fastly.com>
 <65b1cb7f73a6a_250560294bd@willemb.c.googlers.com.notmuch>
 <20240125042746.GA1294@fastly.com>
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
> On Wed, Jan 24, 2024 at 09:46:23PM -0500, Willem de Bruijn wrote:
> > Joe Damato wrote:
> > > Add an ioctl for getting and setting epoll_params. User programs can use
> > > this ioctl to get and set the busy poll usec time or packet budget
> > > params for a specific epoll context.
> > > 
> > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > 
> > Please be sure to include the lists and people suggested by
> > `get_maintainer.pl -f fs/eventpoll.c`.
> 
> Thanks - I must have done something wrong when trying to get the maintainer
> list.
> 
> Should I resend this v2? Not sure what the appropriate thing to do is in
> this case. My apologies.

If you don't get additional feedback in a few days and still prefer
this option that might be an approach.

After reading the below thread, compare the different possible APIs
and either revise the code or perhaps add a small paragraph why you
think this is the preferred path.
 
> > Adding ioctls is generally discouraged.
> > 
> > As this affects the behavior of epoll_wait, should this just be a
> > flag to (a new variant of) epoll_wait?
> 
> I have no strong preference either way. It seems to me that adding a new
> system call is a fairly significant change vs adding an ioctl, but I am
> open to whatever is preferred by the maintainers.
> 
> I have no idea who would need to weigh-in to make this decision.
> 
> > Speaking from some experience with adding epoll_pwait2. I initially
> > there added a stateful change that would affect wait behavior. The
> > sensible feedback as the time was to just change the behavior of the
> > syscall it affected. Even if that requires a syscall (which is not
> > that different from an ioctl, if better defined).
> > 
> > The discussion in that thread may be informative to decide on API:
> > https://lwn.net/ml/linux-kernel/20201116161001.1606608-1-willemdebruijn.kernel@gmail.com/
> 
> Interesting thread, thanks for sending.
> 
> > Agreed on the overall principle that it is preferable to be able to
> > enable busypolling selectively. We already do for SO_BUSY_POLL and
> > sysctl busy_read.
> 
> Thanks for taking a look and providing feedback.
> 
> >
> > > ---
> > >  .../userspace-api/ioctl/ioctl-number.rst      |  1 +
> > >  fs/eventpoll.c                                | 47 +++++++++++++++++++
> > >  include/uapi/linux/eventpoll.h                | 12 +++++
> > >  3 files changed, 60 insertions(+)
> > > 
> > > diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > > index 457e16f06e04..b33918232f78 100644
> > > --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> > > +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > > @@ -309,6 +309,7 @@ Code  Seq#    Include File                                           Comments
> > >  0x89  0B-DF  linux/sockios.h
> > >  0x89  E0-EF  linux/sockios.h                                         SIOCPROTOPRIVATE range
> > >  0x89  F0-FF  linux/sockios.h                                         SIOCDEVPRIVATE range
> > > +0x8A  00-1F  linux/eventpoll.h
> > >  0x8B  all    linux/wireless.h
> > >  0x8C  00-3F                                                          WiNRADiO driver
> > >                                                                       <http://www.winradio.com.au/>
> > > diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> > > index 40bd97477b91..c1ee0fe01da1 100644
> > > --- a/fs/eventpoll.c
> > > +++ b/fs/eventpoll.c
> > > @@ -6,6 +6,8 @@
> > >   *  Davide Libenzi <davidel@xmailserver.org>
> > >   */
> > >  
> > > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > > +
> > >  #include <linux/init.h>
> > >  #include <linux/kernel.h>
> > >  #include <linux/sched/signal.h>
> > > @@ -869,6 +871,49 @@ static void ep_clear_and_put(struct eventpoll *ep)
> > >  		ep_free(ep);
> > >  }
> > >  
> > > +static long ep_eventpoll_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> > > +{
> > > +	int ret;
> > > +	struct eventpoll *ep;
> > > +	struct epoll_params epoll_params;
> > > +	void __user *uarg = (void __user *) arg;
> > > +
> > > +	if (!is_file_epoll(file))
> > > +		return -EINVAL;
> > > +
> > > +	ep = file->private_data;
> > > +
> > > +	switch (cmd) {
> > > +#ifdef CONFIG_NET_RX_BUSY_POLL
> > > +	case EPIOCSPARAMS:
> > > +		if (copy_from_user(&epoll_params, uarg, sizeof(epoll_params)))
> > > +			return -EFAULT;
> > > +
> > > +		if (epoll_params.busy_poll_budget > NAPI_POLL_WEIGHT)
> > > +			pr_err("busy poll budget %u exceeds suggested maximum %u\n",
> > > +					epoll_params.busy_poll_budget, NAPI_POLL_WEIGHT);
> > > +
> > > +		ep->busy_poll_usecs = epoll_params.busy_poll_usecs;
> > > +		ep->busy_poll_budget = epoll_params.busy_poll_budget;
> > > +		return 0;
> > > +
> > > +	case EPIOCGPARAMS:
> > > +		memset(&epoll_params, 0, sizeof(epoll_params));
> > > +		epoll_params.busy_poll_usecs = ep->busy_poll_usecs;
> > > +		epoll_params.busy_poll_budget = ep->busy_poll_budget;
> > > +		if (copy_to_user(uarg, &epoll_params, sizeof(epoll_params)))
> > > +			return -EFAULT;
> > > +
> > > +		return 0;
> > > +#endif
> > > +	default:
> > > +		ret = -EINVAL;
> > > +		break;
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > > +
> > >  static int ep_eventpoll_release(struct inode *inode, struct file *file)
> > >  {
> > >  	struct eventpoll *ep = file->private_data;
> > > @@ -975,6 +1020,8 @@ static const struct file_operations eventpoll_fops = {
> > >  	.release	= ep_eventpoll_release,
> > >  	.poll		= ep_eventpoll_poll,
> > >  	.llseek		= noop_llseek,
> > > +	.unlocked_ioctl	= ep_eventpoll_ioctl,
> > > +	.compat_ioctl   = compat_ptr_ioctl,
> > >  };
> > >  
> > >  /*
> > > diff --git a/include/uapi/linux/eventpoll.h b/include/uapi/linux/eventpoll.h
> > > index cfbcc4cc49ac..8eb0fdbce995 100644
> > > --- a/include/uapi/linux/eventpoll.h
> > > +++ b/include/uapi/linux/eventpoll.h
> > > @@ -85,4 +85,16 @@ struct epoll_event {
> > >  	__u64 data;
> > >  } EPOLL_PACKED;
> > >  
> > > +struct epoll_params {
> > > +	u64 busy_poll_usecs;
> > > +	u16 busy_poll_budget;
> > > +
> > > +	/* for future fields */
> > > +	u8 data[118];
> > > +} EPOLL_PACKED;
> > > +
> > > +#define EPOLL_IOC_TYPE 0x8A
> > > +#define EPIOCSPARAMS _IOW(EPOLL_IOC_TYPE, 0x01, struct epoll_params)
> > > +#define EPIOCGPARAMS _IOR(EPOLL_IOC_TYPE, 0x02, struct epoll_params)
> > > +
> > >  #endif /* _UAPI_LINUX_EVENTPOLL_H */
> > > -- 
> > > 2.25.1
> > > 
> > 
> > 



