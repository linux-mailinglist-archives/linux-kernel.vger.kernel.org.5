Return-Path: <linux-kernel+bounces-43071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C04E840B44
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 093352885E5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23E8156965;
	Mon, 29 Jan 2024 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKAyNdTb"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65A9155A22;
	Mon, 29 Jan 2024 16:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545388; cv=none; b=oXyLu1uR8WXKBiuS2OD6buFUspPW8warOlr7sUYn4ARW3RkPWCBUu0FhDLxueSAghpc7KqShFwPbO/9+8xa/9/mc448tCq/IMHzzTajkrRpwD5eCntu4UdmaCHlx5yyCQKCCkupFjGoou7ocbxLSsx1C427ikkvNpOwRpt9/bUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545388; c=relaxed/simple;
	bh=OMqVP6ph42lDf1Ky7eApI1rvSIdCU1Rk3uR4ghXPe7s=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZv5OrEK1IyQwCPY6Pb0GmDFD4Ani7O87gV5phJQXKgEd+pDSIpvf27xqL33KJV6zHgMB+YmXqTVIj5fx2G+FLXCPdO8PPKxMtpEV3Z0UFkSKdzd2wQXWHIZjYfIejmxkeaVsK59QReZbmC1GEEwFmxhO/Ax0cM1dn/7f+J7dbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKAyNdTb; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-510322d5275so2844909e87.1;
        Mon, 29 Jan 2024 08:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706545385; x=1707150185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=boQI9oYiK4uW55M3uxYeL65Mv+jSVBAg7WNoRgTbhwA=;
        b=HKAyNdTbWgKsrVO1i5IwD/oEwiH5tvNi0SPGcQWdOGwZ0ZL91O25EcPLGms4faYZWQ
         VJKv28JWFcdeCqxFXO/iHTi5CXR+LuRefwGE1iELbhHQva5Agg6N6NNiJjvKXlTaIjmm
         ywxmAEGyxNqU789x+cYL7Y0wiTP96eFqgGOSJMJ+QiOFon5lsKEztU6QfszG627eIFWS
         jkKxtMY8LI5bpFGhQ/1W3GyJvCuw5hrwCLkpV4ud0zOTsCuA45BR5OScfcndNrGmx1Pp
         WaiTUnSQhabf7Wbnrih8IePaONNtvTiQ0/ZlGx0ol3y+hhJfx/lrM5uz08UCSmUfSO/2
         cihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706545385; x=1707150185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=boQI9oYiK4uW55M3uxYeL65Mv+jSVBAg7WNoRgTbhwA=;
        b=SKzPPGUHF6eQoIUEiJdq6pBV9bdCyR9NTeUjjlMvAX0UYjtfmxZYFsksN3P6W7ipmt
         ORTx3Ma1A6fz/i0RiphtiuH8QTpGVfrL8k9ja6g/FFhYzKugPA94+64K00o3snLM7JBc
         8KUvuNTjbr57sS7wDsbRuNfpV6YVYdZ8sMUTHVyYdAPbH7AN7rG1ymQlxaXfsqI/b13h
         JvoFPq5cjQkx1RYRsywn5T2C1VHRjJl6TMQMnmdtESQeF8j8jUr04XzlsCaO2aFDiJa+
         vQovs4wh8XtSyprrygKtQf5abdArVBFwJHQknq8kUWtFDrZ0gBROvvnsAKK5wP9LSx81
         JElw==
X-Gm-Message-State: AOJu0YxyXIXEuKKBnLjBJ1iUn3L4m3e15HUKP5wUnrRiGKHzMtsuSsyA
	tAWTdb435hB5LYgzpFTneYk4TJw175e41yOtYvtqpegqGVztIT3F
X-Google-Smtp-Source: AGHT+IHMb/abY1Egka+gDUQktv39XD/3oc+K/jwDOtSEICdJqJJJ+HlM+QesxWLQLb5dtoB1kU12rw==
X-Received: by 2002:a05:6512:3da8:b0:511:f33:4e4c with SMTP id k40-20020a0565123da800b005110f334e4cmr2859516lfv.40.1706545384364;
        Mon, 29 Jan 2024 08:23:04 -0800 (PST)
Received: from pc636 (host-90-233-198-33.mobileonline.telia.com. [90.233.198.33])
        by smtp.gmail.com with ESMTPSA id 9-20020ac25f09000000b0050eacc0c80bsm1141544lfq.131.2024.01.29.08.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 08:23:03 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 29 Jan 2024 17:23:01 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v4 0/4] Reduce synchronize_rcu() latency(v4)
Message-ID: <ZbfQ5cOkeReti7J0@pc636>
References: <20240104162510.72773-1-urezki@gmail.com>
 <620b475d-eef8-4396-9d3a-d3dcf1d70f9a@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <620b475d-eef8-4396-9d3a-d3dcf1d70f9a@paulmck-laptop>

On Fri, Jan 26, 2024 at 11:07:18PM -0800, Paul E. McKenney wrote:
> On Thu, Jan 04, 2024 at 05:25:06PM +0100, Uladzislau Rezki (Sony) wrote:
> > This is a v4 that tends to improve synchronize_rcu() call. To be more
> > specific it is about reducing a waiting time(especially worst cases)
> > of caller that blocks until a grace period is elapsed. 
> > 
> > In general, this series separates synchronize_rcu() callers from other
> > callbacks. We keep a dedicated an independent queue, thus the processing
> > of it starts as soon as grace period is over, so there is no need to wait
> > until other callbacks are processed one by one. Please note, a number of
> > callbacks can be 10K, 20K, 60K and so on. That is why this series maintain
> > a separate track for this call that blocks a context.
> 
> And before I forget (again), a possible follow-on to this work is to
> reduce cond_synchronize_rcu() and cond_synchronize_rcu_full() latency.
> Right now, these wait for a full additional grace period (and maybe
> more) when the required grace period has not elapsed.  In contrast,
> this work might enable waiting only for the needed portion of a grace
> period to elapse.
> 
Thanks. I see it. Probably we also need to move "sync" related
functionality out of tree.c file to the sync.c or something similar
to that name. IMO. 

Thanks!

--
Uladzislau Rezki

