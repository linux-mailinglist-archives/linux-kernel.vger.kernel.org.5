Return-Path: <linux-kernel+bounces-150639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D55078AA22A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AEC81F21E7A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253C5179956;
	Thu, 18 Apr 2024 18:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHBtJt6T"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A5B168B17;
	Thu, 18 Apr 2024 18:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713465648; cv=none; b=RGN4UZrk7fx6TQDmGMza3Jy1EhsqHfbulw9qZT4uzlp4qAJxiofaaAgPgGu+WZdkfYRhnPEozfEZKF5FDygfZ+8ld5dtmmUNS8mc2bWXn4Z/WzT/w1FWxONsBoI12Rb1twfPv4c7rrCO7bdCi9IqwKq8ZhYeMg0ih9fbhCT+5DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713465648; c=relaxed/simple;
	bh=5ToLcy52BaJXBcXlWLeMKoufyQXVQDmyMU8jmDUTvTc=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Qv4Voi46D1tJzEucrXVwJwJyzKxCiWIlEehRvHnIzRmXQEAWL/5zf8qbbBE1YfTVnogNgAxFOKTNDJl43lFirTrclwJ5zrWuKXJ0XcvMeO0tFIx98uOzeHNx2msU5QE2aBBmJh8yL+BMFIjTG3BXB9696+MKEIOpmEy/xvbTk/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHBtJt6T; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-437610adf96so7217681cf.3;
        Thu, 18 Apr 2024 11:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713465646; x=1714070446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5k53Uq71quKacJUGkPnt8MT5A7eFfqS0PbDvP0l0t4=;
        b=ZHBtJt6Ti8k84GpQPb0yREZOp5HYtDMlF62jPCX//CA+nTjEZnpVSp47OLRjn0izrW
         wjv02EG/IUbLv+OisuzAXlXndyjh7KQF6YOhVE+Tis6vP6DpmB00C8oMPhpdfk1X0LxS
         ZOtFScgckpARSqDmwL0CORdRg4X2C+ZeNWPClJomb4rusLHl+115wRsLpuFZPBRSznGg
         rxw38O/X9POutPKol5Tte+WkBz7pgZ7Fjvz3yJZ1zlqxiBme5pPcjDxjVp/P31VD/UEs
         QuH/MZRQ40ID9GYoXmRogaF8W6ldO+eHoJfBDxS+KI+qyWr7e5hcocZT/oL5GpJne05S
         /tqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713465646; x=1714070446;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q5k53Uq71quKacJUGkPnt8MT5A7eFfqS0PbDvP0l0t4=;
        b=GjDFtepf11tuppbbAbFtiR/rG6GcgaWPkGrdQlP3aWRewxi/J1bAa2KeXNVFsMLSqg
         edOHRFLDX/i1mu3poqO8Pwu0CAy626Mat67T9GZ4t5My5llIdzg0wsRad59QV6jSam5T
         vDQFOnPe+BDDpPszPZT8zCecoQnRNTaVcWdI0+9uiPWzzTjpcq//kfLh1Fu9QBAh9RvX
         pedBdvrk+4+y/pLvHxYClHVrz1tHeJHw76caa0TMW1veOi7OZc2nZoqBhl+e43/E3wtw
         OYbxCMihSCvigrBlQ/sgCyaU7aqoX1qr6C+C5ae7mvwW9v24J7pjH2M0kbm4ZNRLphZU
         Iz0g==
X-Forwarded-Encrypted: i=1; AJvYcCXM3eN2ETjLerSSKEkvoAbY3IMgrWJkjKJf9+/Gc5OMD9KtVQyGUBWrKfDQPjOJHry6uaIlCX6rHq2pbgXKlX6i4ogkS8qVzQP/5f4wkPEklf39JGPgJzUn8oWOia0W+yIJPU9H
X-Gm-Message-State: AOJu0Ywr15QVbxWJV//PR8V/qPiLs9bb4YA5JK9JPL0Pab8H1pZ/UcR6
	pfGv1Ka1A2pr2RGZFccVL3tzNIL9nuqJwPtsbbouFPNo1bv4UdJl
X-Google-Smtp-Source: AGHT+IHGI5FYP9s4REKOtxgzgAXt+90cjs7t/3iZMDFQ2gWEbnYYp/pYUMYgY1IjAMjRcY33x/zm8Q==
X-Received: by 2002:a05:622a:48b:b0:434:4011:3cdb with SMTP id p11-20020a05622a048b00b0043440113cdbmr4406368qtx.54.1713465645506;
        Thu, 18 Apr 2024 11:40:45 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id c16-20020a05620a201000b0078ede411c92sm874415qka.27.2024.04.18.11.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 11:40:44 -0700 (PDT)
Date: Thu, 18 Apr 2024 14:40:44 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 aleksander.lobakin@intel.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <6621692cbedd1_f648a29469@willemb.c.googlers.com.notmuch>
In-Reply-To: <6736050b-1410-453e-8afa-55e4c8f34033@gmail.com>
References: <20240412152120.115067-1-richardbgobert@gmail.com>
 <20240412152120.115067-3-richardbgobert@gmail.com>
 <661ad2e8a7e95_3be9a7294a5@willemb.c.googlers.com.notmuch>
 <97a01bf9-99d2-4368-9ebd-1e1194c1d7fd@gmail.com>
 <662025813539e_c86472944@willemb.c.googlers.com.notmuch>
 <6736050b-1410-453e-8afa-55e4c8f34033@gmail.com>
Subject: Re: [PATCH net v1 2/2] net: gro: add p_off param in *_gro_complete
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> Willem de Bruijn wrote:> Since this INDIRECT_CALL_INET needs to know about the definitions of
> > udp4_lib_lookup_skb and udp6_lib_lookup_skb anyway, we can just get
> > rid of the whole udp_lookup_t type and function pointer passing?
> > 
> > Or move the entire lookup to udp4_gro_complete/udp6_gro_complete and
> > pass the sk to udp_gro_complete.
> 
> This sounds like a really good idea, I like it. Although I think it may be
> more relevant to net-next instead of this bug fix. I can post a
> complementing patch to net-next later if that's OK with you

That's fine.

This patch as is is already very intrusive for a net patch. For a fix,
could we do something smaller? Like add the network offset into
NAPI_GRO_CB in inet_gro_callback and use that in udp4_lib_lookup_skb? 
(and same for IPv6 of course).


