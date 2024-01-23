Return-Path: <linux-kernel+bounces-34642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9794838597
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 473E028523B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93415524CB;
	Tue, 23 Jan 2024 02:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXiSnJNl"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EED524B5
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 02:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705977173; cv=none; b=ph7BQt4p8Ym1tFqUkHOF//dNy8My3EKD1Zjg7LNUTpwrzBT39iwxwAT1fCTyGPPDcty9/CyZIsh3dd6jCCpwgcz9kawDMezTyM7sQ0NhiCHqIN/yN4GweQ78a+CPGGWJOYkP304JtiUTlXZpkuOE6roZ62XtTVa+Yd2lrqwQago=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705977173; c=relaxed/simple;
	bh=PuoXL9IdPvfHwmMmwXtVQe0uMpiNrIBtvpFvqCKinUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HI6nlsbsTMmhbSYHXwquhn2UoVAvkLbTOFMrkfqWxbrnZNfs6Vj2xeiDow92USiZBMvbwHRFVLDBEwmsyztC6Ba6Ts/iIxnR/F3hT3/gxmpvuvhKuN3xINWICDVgFtnfa+Y39+212/5NyNpT7EZ7EC1zio6k2YNNpO8YeUeUQMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXiSnJNl; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3082d450adso141651566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705977170; x=1706581970; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bTu7e+R2osSeEN8Xk/RtMHC9XeUYH+SQtEvbC2VNoMo=;
        b=jXiSnJNlWIDGRwj/fM3ivjZGnS2sOIK18VISXE9ozgPRqo97hJLGVPQoI9IxdxSA0n
         DwNyYNYSkElUrfD76jjN7m5IiJjRS6r9WqM8NxG3qwpbQU1o/5I8LALxbnoI4XUej+eK
         XQVfqmy+RG7k4vA8BtxRgEnEQjNhnHc/3Us7f9PwT36hP/Vo5L/U4w5GTIxGVNhLbQ6b
         qdqQjQVC1NF1fetS7FcGyb6oV2nyWSrknXxgaZmkA0RIsRb3JGQ8pyk1cP1gB1xN259c
         EjJPZyy29SrnZH83Mq+UsBIeczJIFe2p9gtOVQ+lYhMbU9ScY6b5PlzsCzL8y5s0jrKz
         nTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705977170; x=1706581970;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bTu7e+R2osSeEN8Xk/RtMHC9XeUYH+SQtEvbC2VNoMo=;
        b=hMhoKtp+koXD/chZImEqMsYySN21T3401/3V5P/j6hXl+YdBS/kd65UXUV53ps5NH/
         PPnCNQagXwCO4YEA4mM0niubbarug4UxhR4U8P2at7NKC6nX4nJd+lyjuQ1yBW2EjDqA
         FaA4gTzM1hLoyoFj6uO7fU+ZVArrjnal8FpT/IiWzNZg+wWTv0hKDCq0RLyYjWHamuEl
         /QsreTChRhKu9sk5y02faF+4GDNm6cCi2Wx3jiYYiiQuWnLnUHd5tHC0Ld84cNDApqhE
         PrBk+2t621J9n8ESMaKSATYvYSzAuJMINiq2hg2wZ5FvYEjfdWG4W15zsmFjt4JB3/0i
         G53Q==
X-Gm-Message-State: AOJu0YyZBYwaYuKkc4fSvNNW7+5CeBPqaCAX9CwdX8SdnmNI9FujJjwP
	6WKnlYxsNVAFwlwqPsoBz9bKlzGF6zcot8E5x3yUPmIGDKPSTivxyB/oNaCN42cseyCk+xyVCM1
	m7Qt86Ao1egIaBWpAhnDC4foZu8s0JClS
X-Google-Smtp-Source: AGHT+IE7VdcQSqNrPhkD9owPZ1XUsP0f4OqLr/OJRdAs4mUyZIPiwMT97B31EG2v+CaXbSobt+7BPfP+Ubee7g1kU80=
X-Received: by 2002:a17:906:c43:b0:a28:fd0e:6051 with SMTP id
 t3-20020a1709060c4300b00a28fd0e6051mr2306716ejf.33.1705977170369; Mon, 22 Jan
 2024 18:32:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122180605.28daf23a@gandalf.local.home> <20240122181547.16b029d6@gandalf.local.home>
 <20240122181901.05a3b9ab@gandalf.local.home> <CAHk-=whry+-JUDiiCkDkDn2TDg7SA5OvZpPbcQ_jkM_J5=ySdA@mail.gmail.com>
 <27c3d1e9-5933-47a9-9c33-ff8ec13f40d3@amd.com> <20240122203552.529eeb20@gandalf.local.home>
 <CAPM=9tyQ22nw4_u366EX=PnROYcWPD7ONRFpPEKxRvTZo0B4zQ@mail.gmail.com>
In-Reply-To: <CAPM=9tyQ22nw4_u366EX=PnROYcWPD7ONRFpPEKxRvTZo0B4zQ@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 23 Jan 2024 12:32:39 +1000
Message-ID: <CAPM=9tyCN1ZhvCTjoKn-Yg5BhnrMae4E5Ci4_u7BZ2vv5gDnKw@mail.gmail.com>
Subject: Re: [BUG] BUG: kernel NULL pointer dereference at ttm_device_init+0xb4
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	dri-devel@lists.freedesktop.org, Fedor Pchelkin <pchelkin@ispras.ru>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jan 2024 at 12:21, Dave Airlie <airlied@gmail.com> wrote:
>
> On Tue, 23 Jan 2024 at 12:15, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Mon, 22 Jan 2024 19:56:08 -0500
> > "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com> wrote:
> >
> > >
> > > On 1/22/2024 7:43 PM, Linus Torvalds wrote:
> > > > On Mon, 22 Jan 2024 at 15:17, Steven Rostedt<rostedt@goodmis.org>  wrote:
> > > >> Perhaps this is the real fix?
> > > > If you send a signed-off version, I'll apply it asap.
> > >
> > >
> > > I think a fix might already be in flight. Please see Linux-Kernel
> > > Archive: Re: [PATCH] drm/ttm: fix ttm pool initialization for
> > > no-dma-device drivers (iu.edu)
> > > <https://lkml.iu.edu/hypermail/linux/kernel/2401.1/06778.html>
> >
> > Please use lore links. They are much easier to follow and use.
>
> https://lore.kernel.org/dri-devel/20240123022015.1288588-1-airlied@gmail.com/T/#u
>
> should also fix it, Linus please apply it directly if Steven has a
> chance to give it a run.

I see Linus applied the other one, that's fine too.

Dave.

