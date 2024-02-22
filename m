Return-Path: <linux-kernel+bounces-76751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A21985FBF1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CB811C2315D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4C414D444;
	Thu, 22 Feb 2024 15:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jtou4l0z"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6783514C5AA;
	Thu, 22 Feb 2024 15:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708614672; cv=none; b=Jf9ujP12791Di0PMb+f25B0ILZw0KSN4QqUlCQaOC5b7AfWMy3mV4DMMQdNOO+/JONTbVxh30rEwWtZ7827zJwxS2Qtw7BwG8mY9AMj6eR930IhGr5IaHXDRAkiFFeoJmSAwZwEALcDD92l2lyywPE/FTLJFO7i57ZNhAs2oezI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708614672; c=relaxed/simple;
	bh=QebyiapI7055CfCbggBHY8g8qVcrtvQF1PS/wph5iR0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=CPcxCeoofJtntaZI/h5x58O6N73JEwhzeIfRaaLjxxCglTHhtAHY7ti0vIkbrwUd1FXuhMK31HLNTxySjkCIImXkG2cLM2d6HHAQs3oqS/z+gWbPRWCtEZjKu/HvUWUG5FCUglse58kDaxxfXmBvzbpIb47fnvuhwqnjWwk+Yso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jtou4l0z; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6869e87c8d8so35819126d6.2;
        Thu, 22 Feb 2024 07:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708614669; x=1709219469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mahrs03r34MZtIZekwHDYOezoWm/Ls+aDygRBn5DYSw=;
        b=Jtou4l0zIgjEnlZVGF1hvW3gYgTep04qSntZk25vSkXxpUPFx9jYPjwMn1YCzNwsjg
         MerIMtZo5PWNl4NxJJcQubjg7WjZ9bUlpUWPspFzAE4V3kMR/EUm3lHl/S7QMIwkyIc8
         Ay8yszYGC15K+m7sRHvh4VLDioow3wCkekAgnqe/lVOKvPovFoamRoGdqYJ4qtJoaLzH
         B775tyNwc9HHSh99ryxbokPtEj0ZlNMoJp6Ln+kuL6XxQrxUf6LSXPQT+Cv+IBfH5AHW
         iGH12TbMiIESXOcN9iJkHyZCnzN+t0n7aFJxOzPJZnRfArlEohXIx60ifMjwc3v+dvWO
         25NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708614669; x=1709219469;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Mahrs03r34MZtIZekwHDYOezoWm/Ls+aDygRBn5DYSw=;
        b=df1ysK9xa5246C5UD9aFUVInenBuoTQpk2a9nhnSPk9BTqDCOHq5n/p7QMoWp7PFwF
         wIlvEGc/LfaBOCrlV1vdRsJCFHU1Pik8Ay0vq23mw+ZPik4MV/dLJ1YGD/n7zj9PcPDu
         gqfJ2hlgKG5N9z8VOEd0tXiEAEWSMeErK8zuq+Kw4JaVvFgvw4+0JOgeLbgeYXc4LDLb
         Be1yRntlIxAt3TyEhs4XzSeGN93VP3j4JzLO06BDSQ2ZSpO0G6GqHhT7Lim/r/VEuyla
         ybIEc9jMUEb1cjlN2aDpRvge4EpN5eszupdjE+1VhAmYSoOM/opzvWw1xq25lx+rJfoG
         kHDg==
X-Forwarded-Encrypted: i=1; AJvYcCWwdNIZa2D15dFPCg6KXrM1ON+vsJDRzXNRTJkgYr9xsMg+YGyt0vUyfydUIk14IsRhRldlslFc/DkcXPNeafMdZuEIofvVoIwKwptWA+gnW4m48XXXpigBPvOeqURBcdFzvGCI
X-Gm-Message-State: AOJu0YwyCRO7viKZgojkClKPtB5YNeOiIo3GxjqiMBuwzzyUudZ3FYCs
	OJZo+lr2642RHSUpXaO1BvwbaZXRNrZN0SxCzfj5H09FIf9vVmLmgynpmkCC
X-Google-Smtp-Source: AGHT+IHDHGJ99eHo0oF621Jw/La381yg3Qwa/iYlEx27njHAHXWvbgSPzzD7uoiEvecjuYMrcl0B/Q==
X-Received: by 2002:a0c:df0c:0:b0:68f:a58f:6582 with SMTP id g12-20020a0cdf0c000000b0068fa58f6582mr4996268qvl.12.1708614669254;
        Thu, 22 Feb 2024 07:11:09 -0800 (PST)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id dh17-20020ad458d1000000b0068f35e9e9a2sm6961304qvb.8.2024.02.22.07.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 07:11:08 -0800 (PST)
Date: Thu, 22 Feb 2024 10:11:08 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Marcelo Tosatti <mtosatti@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Valentin Schneider <vschneid@redhat.com>
Message-ID: <65d7640c7983b_2bd671294c3@willemb.c.googlers.com.notmuch>
In-Reply-To: <ZdSAWAwUxc5R46NH@tpad>
References: <ZdSAWAwUxc5R46NH@tpad>
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
> For systems that use CPU isolation (via nohz_full), creating or destroying
> a socket with  timestamping (SOF_TIMESTAMPING_OPT_TX_SWHW) might cause a
> static key to be enabled/disabled. This in turn causes undesired 
> IPIs to isolated CPUs.

This refers to SOF_TIMESTAMPING_RX_SOFTWARE, not SOF_TIMESTAMPING_OPT_TX_SWHW.
See also sock_set_timestamping.
> 
> So enable the static key unconditionally, if CPU isolation is enabled,
> thus avoiding the IPIs.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 0d548431f3fa..cc9a77b4aa4e 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -153,6 +153,7 @@
>  #include <linux/prandom.h>
>  #include <linux/once_lite.h>
>  #include <net/netdev_rx_queue.h>
> +#include <linux/sched/isolation.h>
>  
>  #include "dev.h"
>  #include "net-sysfs.h"
> @@ -11601,3 +11602,14 @@ static int __init net_dev_init(void)
>  }
>  
>  subsys_initcall(net_dev_init);
> +
> +static int __init net_dev_late_init(void)
> +{
> +	/* avoid static key IPIs to isolated CPUs */
> +	if (housekeeping_enabled(HK_TYPE_MISC))
> +		net_enable_timestamp();
> +
> +	return 0;
> +}
> +
> +late_initcall(net_dev_late_init);
> 



