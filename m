Return-Path: <linux-kernel+bounces-144423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EF68A4640
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 02:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 075CB281EE0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 00:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FBC817;
	Mon, 15 Apr 2024 00:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="JaHZUYp9"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8209B632
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 00:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713139751; cv=none; b=R6JQUBm4p3PMpUja9oVMIDxe8wQiWuc5TvN34dWRvh3Xi49Qd0GG2IO8bWONDaUBjUVK8UM0+5CLli69Un3aeNS0PvhUqsXJ4eFikxMWsATlpSe0ATl7F1SOi5ayWUtelTWNwfz0bsT3OZqKMH2dCxgZAj6X/MkzjC2RQKQqSpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713139751; c=relaxed/simple;
	bh=lRG4QtdanZsYbOJPyCd1T0Kpc1bv2cDyoPPvluaR5YU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IERqTBmZvJzjL6xsDiPh4pVVl8sWtjfeAl5bvbJ9et9dLc/RMb6ulMF13oock8UPhqIqfTAyGrGmOmUEoVo+OEvh4+NA74uvtkmFVQ25FaxWQ2y69EPW3eh5x/Dk+kSX1e/uJPxleTtxRM4XBDfvJVCEe1h9U9cvzZ+QD7fn16M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=JaHZUYp9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e5aa82d1f6so12805295ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 17:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1713139750; x=1713744550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XD87meE/mKu5ky7rl4wzceYi2Ho+YrZL1ICbysnHKb0=;
        b=JaHZUYp9mgeF644MkBlt0WxmqR8+HFp/KtIFcQePbr9f09fuWSwTs5RZHOVntwEtJY
         /MccSgcUC+PMjFN/s93y+I2Fnt2JZxfZrb4rQY+fObtZ65iu013VBkwApARWyw60PsW1
         O509jobqJisG9pgFkd+i0mLHoDA351W9iPcgr/pUry+Yyvs5zhuCKEQofR7YAOCen6Tr
         AyyA3D1atjH72YHg1bLfbVsfxm8gKggkNjqN929q0bHt5XRuyLVHNmw75yMETrwpvi+y
         P12UDuvqsqSN09akZcdwzc1Bvrkhfp8wAleEjeXdWwpO/INLX776hoBYMedidvFByLBC
         inGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713139750; x=1713744550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XD87meE/mKu5ky7rl4wzceYi2Ho+YrZL1ICbysnHKb0=;
        b=P1Ea938EOOnEyPrZp8zy5FHviiOFklT8QJufhTvU3J7g2v12TVxjSgM++6tVR0Vv7Y
         9jLXKRDbe7GcaQPe5L3G19p6CKQel6/UtgKVwNcF9wWUf8k4kE+/K/tL7suhEq3FEy1W
         oDs4Ljkcvn+E4d9rD/4h+7PTHwsbVh//ZgrOBRZcnTB0wSz/9+CGZjF9vK9g/rlri8R9
         1CJOgmkAFzibrdGH2HhG7G/UYZQVNWuO6KwJFbVVGrv3JyOM7v13GrIVOg5DoHU5J9sE
         6I430R2h9RTDskVeYRv3sVmsX+M0yZRTp3tu03IPOSe+O82sMP0nkx1DY3o+w8zP33eG
         M3tw==
X-Forwarded-Encrypted: i=1; AJvYcCVUgcwo5AdopLDCsBcgv+8tMSZpDFP8fgglbKz4KDu6QZr9NbFJ2kSD0N+tDE2JOW2kVEvJz2wwIM84CO11F7rro0KWUOdHnk9V44Q6
X-Gm-Message-State: AOJu0Yx7NNlCWnTmaRMUBE34H0GA/F+wCOV+UoY36ALg0zLKIqbrLXkp
	22fKbfj1uclkWwRENLA+dOHSGJGixWS7oYCSS5ObXEcJVMnOrwW/wyhTNkMeB8Y=
X-Google-Smtp-Source: AGHT+IER50ZH3hDdMnKPJBATo42l+JvPADQjlqE49pRDUVeLB7sku1wzCjYhRD0RIsx9+C4cuSqWuA==
X-Received: by 2002:a17:902:ea04:b0:1e0:9964:76f4 with SMTP id s4-20020a170902ea0400b001e0996476f4mr13035552plg.14.1713139749574;
        Sun, 14 Apr 2024 17:09:09 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-56-237.pa.nsw.optusnet.com.au. [49.181.56.237])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902904300b001e2bbc0a672sm6595737plz.188.2024.04.14.17.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 17:09:09 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rw9uE-00FqsV-1n;
	Mon, 15 Apr 2024 10:09:06 +1000
Date: Mon, 15 Apr 2024 10:09:06 +1000
From: Dave Chinner <david@fromorbit.com>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
	Alex Shi <alexs@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Subject: Re: [PATCH 1/1] mm: protect xa split stuff under lruvec->lru_lock
 during migration
Message-ID: <ZhxwIh2M8jr6IZaF@dread.disaster.area>
References: <20240412064353.133497-1-zhaoyang.huang@unisoc.com>
 <20240412143457.5c6c0ae8f6df0f647d7cf0be@linux-foundation.org>
 <CAGWkznHRyZDuumF=70DncgPHFM0+pgxuONh98Bykz5b-=rCjCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznHRyZDuumF=70DncgPHFM0+pgxuONh98Bykz5b-=rCjCQ@mail.gmail.com>

On Sat, Apr 13, 2024 at 10:01:27AM +0800, Zhaoyang Huang wrote:
> loop Dave, since he has ever helped set up an reproducer in
> https://lore.kernel.org/linux-mm/20221101071721.GV2703033@dread.disaster.area/
> @Dave Chinner , I would like to ask for your kindly help on if you can
> verify this patch on your environment if convenient. Thanks a lot.

I don't have the test environment from 18 months ago available any
more. Also, I haven't seen this problem since that specific test
environment tripped over the issue. Hence I don't have any way of
confirming that the problem is fixed, either, because first I'd have
to reproduce it...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

