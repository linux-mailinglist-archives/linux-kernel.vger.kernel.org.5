Return-Path: <linux-kernel+bounces-135669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E62A89C985
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FCDA1F2371B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C2B14264D;
	Mon,  8 Apr 2024 16:25:45 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AD6142640;
	Mon,  8 Apr 2024 16:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712593545; cv=none; b=eVxNdA/uv51U4fxs6A/gIm9kFackyaAjntHg4i1QIzTOB6oIfBhMVUsdBSzR3hG38vI6RwovNq0SGIKEe5pWFviIaewHVtvGGkZYzO0Rk4fT7TKPgV2d2ZVDU2C8CvjiaSYCxP3kybpN+MRROd1pyyBc8Vxyt6MdLWNw9mDLDik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712593545; c=relaxed/simple;
	bh=yLhAozbKSgSEEVWL2zZSEiQilYIPhxqpASbxKKAFji8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXRE1ZqbT+pz05dMGl6GLB0dKuWMVlC7HMto8IklIwJqMv4sPqTqEdMHqeoJpdg2sPAftoiImmBHeRJ0LsPYB43LFWJldA4hDk1Qw5XBaoYaCL60OQ0WqF9mCIdHJqICihxip1A7ftKprHsFcbDT61Llc/dawk6a3bNx56Nu7yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56c404da0ebso7029475a12.0;
        Mon, 08 Apr 2024 09:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712593542; x=1713198342;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P2EhArtYiqyvGPV+LTB9gPEv+phrRjdmzBmn4ktvhm8=;
        b=HNT6CCIGMI0VAxImhBdnCPLrn+wWGbdFZ9Tk2kUJUa1DzW+ZCRalckmthEOb6d8KGi
         ruH5fuG3FxRBCmg2L7qm7konRPjV0OA1+GreH8NohhkuoglUWPc20+qCN9b+hX0uovzF
         aGcAkCgdWPV4IKZbpZYZbS4e7tEXaJQz8+YuRWWEgJYdvUtO/ZTAhA2JWeBHaImbLTCr
         QbUQPKccssfyhJeEQBZnE8HMCXBp9iSVWJ/Gk6YJTk6AdhHf9ot9Ff70TPI9jtkmoxa+
         C+CLnhMBhmjXiXNFufb5RXaV+ruv6/pJjgODzIQTRY49S8msz9ip2ABu5O3JQ1DsBf/Z
         OQ7w==
X-Forwarded-Encrypted: i=1; AJvYcCWyJhImAE0oNtt10su9C6+5rYCpz3dXpCQOD08LwxLMEjFjyc8ecdaax7Qf0CGFGLkKKvXrkWPg12fOS5OKnkmXWabRo7b0Yy+xf8TxuCE9W8ey1cHtqAwlP0C5SrXFIO/2LLvm
X-Gm-Message-State: AOJu0YztmbqKl/qMiP4gLFm9dToKZycMjU4bE65+hunLTICVtbWzLKiN
	m5qnfDG2jwzXAzvHmSMy7SC7V/DxeYhLjlvpIKVHfAexPlwtc6/U
X-Google-Smtp-Source: AGHT+IExb0impRE50hhROeVv7gmRycil43jnqIkFUdoPPCEvMlNxNAnPKayXT5hEjmK3SvenyFFi8w==
X-Received: by 2002:a50:8ad1:0:b0:56d:c937:7558 with SMTP id k17-20020a508ad1000000b0056dc9377558mr7784316edk.9.1712593541482;
        Mon, 08 Apr 2024 09:25:41 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-117.fbsv.net. [2a03:2880:30ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id eh15-20020a0564020f8f00b0056e67f9f4c3sm766731edb.72.2024.04.08.09.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 09:25:41 -0700 (PDT)
Date: Mon, 8 Apr 2024 09:25:39 -0700
From: Breno Leitao <leitao@debian.org>
To: Eric Dumazet <edumazet@google.com>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] net: dql: Optimize stall information
 population
Message-ID: <ZhQagwjRHBNsQbIw@gmail.com>
References: <20240404145939.3601097-1-leitao@debian.org>
 <20240404145939.3601097-4-leitao@debian.org>
 <CANn89iLhi365XA2-5vQwf+ELRYEep=NFSHxVAE=v0cXjpANh4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLhi365XA2-5vQwf+ELRYEep=NFSHxVAE=v0cXjpANh4w@mail.gmail.com>

On Thu, Apr 04, 2024 at 06:36:00PM +0200, Eric Dumazet wrote:
> On Thu, Apr 4, 2024 at 5:00 PM Breno Leitao <leitao@debian.org> wrote:
> >
> > When Dynamic Queue Limit (DQL) is set, it always populate stall
> > information through dql_queue_stall().  However, this information is
> > only necessary if a stall threshold is set, stored in struct
> > dql->stall_thrs.
> >
> > dql_queue_stall() is cheap, but not free, since it does have memory
> > barriers and so forth.
> >
> > Do not call dql_queue_stall() if there is no stall threshold set, and
> > save some CPU cycles.
> >
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  include/linux/dynamic_queue_limits.h | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/dynamic_queue_limits.h b/include/linux/dynamic_queue_limits.h
> > index 9980df0b7247..869afb800ea1 100644
> > --- a/include/linux/dynamic_queue_limits.h
> > +++ b/include/linux/dynamic_queue_limits.h
> > @@ -137,7 +137,9 @@ static inline void dql_queued(struct dql *dql, unsigned int count)
> >
> >         dql->num_queued += count;
> >
> > -       dql_queue_stall(dql);
> > +       /* Only populate stall information if the threshold is set */
> > +       if (READ_ONCE(dql->stall_thrs))
> > +               dql_queue_stall(dql);
> 
> Note that this field is not in the first cache line of 'struct dql',
> we will have some false sharing.
> 
> Perhaps we could copy it in a hole of the first cache line (used by producers).

That is a good point. Let me move stall_thrs to the first hole.

Thanks

