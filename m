Return-Path: <linux-kernel+bounces-91695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1C2871550
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 06:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4E621C216E9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EE4481A4;
	Tue,  5 Mar 2024 05:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iKCcnjxP"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3286BAD5E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 05:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709617025; cv=none; b=j8JZ95uLxEauLs03AWGLvIDLcF/4PIe9VyEsOPsrkFmtXdN5Y5arbeqmEmvnoKWbEmxb03kYY/rQ9ChygZjUl5DC+ZHRpMhKjARvrBpuHSkMLZZHra3y6Z0Ns1VPp9KF+8YBPpMIup4zMTlYuM6JYQLbwpodepTvHwa7GdIckBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709617025; c=relaxed/simple;
	bh=6ofdleIjmg4gSNbN7RMlFIqvhZj0cbxzZ1luEqJlDYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jOTHpgrkuIi6Q3lHe3vOSzb9IGZR2TGjUNoxEkqfpBv3UWWWKxCu/tyT+QGvjLNyHdhd2KXy9nD84yLn99swqBlryup7IAiLWpUizwBeHDil7DHMH5tc4vAnvYheEmRsSSXF9k3aIX40xy0fq4vKr8xUGIYtUU7A1YTBxWt2wCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iKCcnjxP; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7d5bbbe592dso2943904241.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 21:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709617023; x=1710221823; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9WJdN6jIWjInavb3iZMUJn2P9ZES7C5MXZcfimAwNBo=;
        b=iKCcnjxPOlrYdmXXUah/wtOb5E5Df2M1VDsdRjJ16U43ik7A3A3RrPSj7T/Bi9TCkv
         fmPiL+sFUqoXlMklcrnQpJ3ngZIFe9Q83b4U/thr6PU6BoP4r/1i+LLcLVg/XY10mVE9
         n/h3N/o5GTFMNmqIjTNcqmFOV+gmhYLf8KGXSBcJK8Ccx9hLm4F6Qexwg0V+ISlqcwDu
         LsNWQlqHwSg3ps5oT7JbF7kDQ2daDE6Wn+casN5CnxEcWrMIGIBCZ15cW6mUJwQzIDq2
         yMQ3W7ETaMms3gmeEYarx2AIINZn4QXWQysydZN2qxb3fi6MpbZhiNsTqyatXYsXmewN
         XPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709617023; x=1710221823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9WJdN6jIWjInavb3iZMUJn2P9ZES7C5MXZcfimAwNBo=;
        b=QUGDQ0u6D7Rc3AVEuyREoyebQSQfVMbb5d6NE8tblO2q3M4FQMm7G4TX89n3Gurqm/
         zzsVkpjg5XrF19SEI64WAmZ6IiuQuTnKR/rft/L1xV1il7AStIkkeewv5ZLs5kLOq7pm
         Vt12U54xyaBROTV4l9X7BMM8FGSP15bvW7LiJxKu3S52nA4HIGjh/JCjFC8ZH7Ys0nL8
         qXPW4w/LeLHc8KIZKtXwsco95LNo9sxQRDb9KnmC+cx4DlmS1H4E+pWQBdyicE2uybea
         vk4jMwJzJ91JOO04fYXF/MQhyDZWQvrv51ltthxUuxtyJd0HFqYiz3eTA3TvfiP3zTMO
         fLxw==
X-Forwarded-Encrypted: i=1; AJvYcCVnzBmaEKmXfY5xd81YDoqfBqqyNaxRrk+cSjoS64pEw3aMunutIlm6JKwZvA36WRy1VFqaKB0roedf7J0qqcj6yXqDg5Q3aT5GJwxE
X-Gm-Message-State: AOJu0YzNKF19IsTlYJR43XxOVfgOOwFKvtzYd8rB/zZI37AJ5lTKsuUS
	KsX1KUGufxFTcuVRuzeFW1YZGMXJy0VZMVklexRRXmUFfPu8Z/r1Qzhas45ECS0ju9B0qq/E48+
	S5O3U9y71eTsvn9Xqdj4mAnsfdDE11I75hBJ9yw==
X-Google-Smtp-Source: AGHT+IEJ4bxJhwqVbCZyNHpW+xFJRh6xSEc8u4JgkeVWVlK9/pxTzpopfDpigyMOipaSqiBAvvOW0i5LN2Rxow5sVAI=
X-Received: by 2002:a67:f1d4:0:b0:470:397e:5329 with SMTP id
 v20-20020a67f1d4000000b00470397e5329mr806565vsm.10.1709617023225; Mon, 04 Mar
 2024 21:37:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223095133.109046-1-balint.dobszay@arm.com>
 <20240223095133.109046-2-balint.dobszay@arm.com> <CAFA6WYNW9-7gCZQSEaV=Gcr+GLdu25rQ8MpTg9yNpX7OwyZ0Tg@mail.gmail.com>
 <4E68610D-8F2B-4E27-AE5C-45CB59D7FEC0@arm.com> <CAFA6WYNz57v_S9CBQHUjvPdzcP9FWuDN0ciPNvgUZY_-m3JKRg@mail.gmail.com>
 <1A75CF74-D486-4A3B-9004-250F870D7330@arm.com>
In-Reply-To: <1A75CF74-D486-4A3B-9004-250F870D7330@arm.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 5 Mar 2024 11:06:52 +0530
Message-ID: <CAFA6WYMocdcQXaqk8hS8dwnfwJLNWKWSEfMLO4wXyCQM=TQ8vQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] tee: optee: Move pool_op helper functions
To: Balint Dobszay <balint.dobszay@arm.com>
Cc: op-tee@lists.trustedfirmware.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	jens.wiklander@linaro.org, corbet@lwn.net, sudeep.holla@arm.com, 
	rdunlap@infradead.org, krzk@kernel.org, gyorgy.szing@arm.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Mar 2024 at 19:57, Balint Dobszay <balint.dobszay@arm.com> wrote:
>
> On 4 Mar 2024, at 10:17, Sumit Garg wrote:
>
> > Hi Balint,
> >
> > On Mon, 4 Mar 2024 at 14:33, Balint Dobszay <balint.dobszay@arm.com> wrote:
> >>
> >> Hi Sumit,
> >>
> >
> > [snip]
> >
> >>>> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> >>>> index 911ddf92dcee..4cf402424e71 100644
> >>>> --- a/include/linux/tee_drv.h
> >>>> +++ b/include/linux/tee_drv.h
> >>>> @@ -275,6 +275,17 @@ void *tee_get_drvdata(struct tee_device *teedev);
> >>>>  struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t size);
> >>>>  struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t size);
> >>>>
> >>>> +int tee_shm_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
> >>>> +                                size_t size, size_t align,
> >>>> +                                int (*shm_register)(struct tee_context *ctx,
> >>>> +                                                    struct tee_shm *shm,
> >>>> +                                                    struct page **pages,
> >>>> +                                                    size_t num_pages,
> >>>> +                                                    unsigned long start));
> >>>> +void tee_shm_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
> >>>> +                                int (*shm_unregister)(struct tee_context *ctx,
> >>>> +                                                      struct tee_shm *shm));
> >>>> +
> >>>
> >>> These rather belong to drivers/tee/tee_private.h as we shouldn't
> >>> expose them to other kernel client drivers.
> >>
> >> As per the discussion in the other thread I'll ignore this.
> >>
> >
> > Then it will have conflicts with this [1] patch. If you are fine to
> > incorporate [1] in your series then the right place for these function
> > declarations should be include/linux/tee_core.h.
> >
> > [1] https://www.spinics.net/lists/kernel/msg5122983.html
>
> You're right, I'll rebase my patches on this.
>
> By incorporating your patch in my series, do you mean that I should just
> add it as the first patch in the series for the next version?

If you are happy to carry it then I would be in favour of this to take
care of dependency.

-Sumit

> Or keep my
> series as is (do the rebase of course) and just mention that it's using
> your patch as base?
>
> Regards,
> Balint
>
> >>
> >>>>  struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
> >>>>                                             void *addr, size_t length);
> >>>>
> >>>> --
> >>>> 2.34.1
> >>>>

