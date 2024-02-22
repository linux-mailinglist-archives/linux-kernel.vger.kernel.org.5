Return-Path: <linux-kernel+bounces-77192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6458601EA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E118A1C24B89
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2524143C75;
	Thu, 22 Feb 2024 18:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVvoMzfD"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7477C14B802;
	Thu, 22 Feb 2024 18:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627339; cv=none; b=TwotOEz0Q3xjV2UgyW4WIWNF1oMf1+J+rLk8/e1b1fnh6FA4/G4C1VIBJF9V/AWc9SZCRTo6sVUT34qPrRxoWMeJ+rJ1LU2Av0Gi8Na77AyKMz0qH5akq4X39f+dlG1oXLbyz3xKPcop4E0vWSQ9H36yubN/tAjiTA2ybcHMGxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627339; c=relaxed/simple;
	bh=X5DPbtUuo167CmhEQH4ZaCaXl2qW67O4l0eto/HRpMM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=pa/8Dd5k+qS+H01vaK7R1txlCUiMxiSEaYqFdRdERbINr992dB4FgAHdjAUfNHh8T4vzEaXvSEGLI/LmPNftLm8oLBydwtZUugaykJW9NaaS4HPlZx1oOPFBCcr3Ozd8oXdrD0ZtFwYpxkWH6Cdjrh9I4wy8dZvnyVix8/Pjr90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVvoMzfD; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-787990149edso62710885a.3;
        Thu, 22 Feb 2024 10:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708627337; x=1709232137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JY57+eYxgeopbrNEfdOzDb+UHFYaRCQjxBHdb2jOZM=;
        b=eVvoMzfD+7LYbL8H4o5jqWdYjHkAvtfxVTRCyg8rSdaixPYkxjkYIi5RyFvQ5NVUqB
         WeHNzteCL9gPAXUDU8DHnXr6Z4uLRPY9Hgxxm6euEA8BBl6K9SW+jmjWIrTs2KSWAHeq
         YSYWdAH/BaSKPGxq48Nx+G0la9ObPdrvGzGIVLUQtOP6ZHewOKFrNt0WgX4pJXiQkb+I
         fDrZNJ7aRbSvbmup8HV0401V7WuEovgNmYrsw+xKOj8a6QIGdV7S80XWAAzzKJSwdKFj
         1R6rKJK6atCK7+OHh0pQW2N3C3CXAFmdi+AgXYBBFJm7ctrZrP0bIPGYMFPt4D1sesmR
         5EBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708627337; x=1709232137;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5JY57+eYxgeopbrNEfdOzDb+UHFYaRCQjxBHdb2jOZM=;
        b=FfOs330LNQRUw3jj53TGORW6DAQbf0rR/NZ35Fa6VrFBu568/n17eKq6W0pf7hQIHR
         Y4iKt2Q5haZbz0vUiQHE6B3hMUjeP//Q4SWzNLQfTSKE5E3cjyZFYktiPskOE7kme9aF
         DKuo8/PFAY8fNsHCcatkJ63yn6nLxhLf+MkLkavEKvMPsgmYyf4fdO7moSQ5oUGxWjl9
         8ezX6XnF57ImmJfh+SZZSBpH8NbojtgBYCq2cV8jPt6Gc4bTqnLmgtCUEaVLGLRKsOa7
         WaDkg098GZeWRoA8g6cJnBB2Ccc+KmZsjO9JXf293XqLs8/0QAw7aec20ilenqIpilBX
         I1Yw==
X-Forwarded-Encrypted: i=1; AJvYcCXBBUDLOxE5IaMUJpf64UHMuFAYMHHfgoiIXhZRYtLi4fCeJzswTFtD7E6GiFDx3depjHAwGT5SPXCkNCfZ+JJmaWDWeBzEjpl5XFou
X-Gm-Message-State: AOJu0YxPnajE1NY96zZ6wEZ+DHpJCDcBLHpvk+Bcyh5Uezf1Qo46s+H/
	ccpfWb6NEIcGymV7eDrpmLGk4iHJ9N9/RHeyYQPs+T3Ey34XeEEOQR/QO3Nq
X-Google-Smtp-Source: AGHT+IEei0q7Q4XqoOQZJBSxgNbHlzC2WpFyHXkKvYFhxKhCrg0y7NTK2ahXSWsHltPeKbWXsFrgAg==
X-Received: by 2002:a05:620a:20d8:b0:787:34f6:a706 with SMTP id f24-20020a05620a20d800b0078734f6a706mr22687920qka.28.1708627337199;
        Thu, 22 Feb 2024 10:42:17 -0800 (PST)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id vv14-20020a05620a562e00b00787acc6a3c7sm126403qkn.65.2024.02.22.10.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 10:42:16 -0800 (PST)
Date: Thu, 22 Feb 2024 13:42:16 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Marcelo Tosatti <mtosatti@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Valentin Schneider <vschneid@redhat.com>
Message-ID: <65d795888e904_2c3076294d2@willemb.c.googlers.com.notmuch>
In-Reply-To: <ZdeJyxiTSKtkpHMO@tpad>
References: <ZdSAWAwUxc5R46NH@tpad>
 <65d7640c7983b_2bd671294c3@willemb.c.googlers.com.notmuch>
 <ZdeJyxiTSKtkpHMO@tpad>
Subject: Re: [PATCH] net/core/dev.c: enable timestamp static key if CPU
 isolation is configured
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Marcelo Tosatti wrote:
> On Thu, Feb 22, 2024 at 10:11:08AM -0500, Willem de Bruijn wrote:
> > Marcelo Tosatti wrote:
> > > For systems that use CPU isolation (via nohz_full), creating or destroying
> > > a socket with  timestamping (SOF_TIMESTAMPING_OPT_TX_SWHW) might cause a
> > > static key to be enabled/disabled. This in turn causes undesired 
> > > IPIs to isolated CPUs.
> > 
> > This refers to SOF_TIMESTAMPING_RX_SOFTWARE, not SOF_TIMESTAMPING_OPT_TX_SWHW.
> > See also sock_set_timestamping.
> 
> Willem,
> 
> This test program does trigger the static key change:
> 
> int main (void)
> {
>         int option = SOF_TIMESTAMPING_OPT_TX_SWHW;
>         int sock_fd;
>         int ret;
>         int pid_fd;
>         pid_t pid;
>         char buf[50];
> 
> ...
> 
>         /* set the timestamping option
>          * this is to trigger the IPIs that notify all cpus of the change
>          */
>         if (setsockopt(sock_fd, SOL_SOCKET, SO_TIMESTAMP, &option, sizeof (option)) < 0) {
>                 printf("Could not enable timestamping option %x", (unsigned int)option);
>                 close(sock_fd);
>                 return 0;
>         }
> ...
> 

That is because you call SO_TIMESTAMP, which interprets option as a
boolean. The SOF_ flags apply to setsockopt SO_TIMESTAMPING.


