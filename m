Return-Path: <linux-kernel+bounces-103838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B202D87C52F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C944282F6B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 22:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B74749A;
	Thu, 14 Mar 2024 22:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eX0FkPV2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF780DDAD;
	Thu, 14 Mar 2024 22:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710455812; cv=none; b=ORPyVkB578nU+uxcvNI+9rYq9cRLxL2a4CJsPR4YL+vUwSgmYVo5eYpGAKZFXmkqVnP3OQIrvSTQP44lT1ploqtB1onqEkTQTOMLQn/Whe0f5uF93XEVaMxCt6P0hF6VuNnE7mQNd2fkQFvs6KWocFE30cQQlPkRR/9a8bDfMQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710455812; c=relaxed/simple;
	bh=fbNb5wcqEZU5SnCBUM6reim3vrCnqaK/WfSKJQJ0njg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fIw0ZuuiaR1tUk1fZTX2RJHN7EFb8ZRBpXgVVWf5ze6J1SjHsA41r5OPONlDWQ7wdXubQ+RshDutlBgISL252JNGVH0q4wCIFWNsqKvKkMZlIR1WkOTAUYjswiPyXRN89TkiLRmsLpnuFyEFi/CqhjSl6p8eSrU00EEyEKLswI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eX0FkPV2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8296BC43399;
	Thu, 14 Mar 2024 22:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710455811;
	bh=fbNb5wcqEZU5SnCBUM6reim3vrCnqaK/WfSKJQJ0njg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eX0FkPV29BtRH+YQ2XMihobim0z38t5NXP5yWvokl1Ow+kh5NDpOuNHMh8NIqtO4E
	 MlbvzYFjojFJqVU4bCAjf0oc44Pdg2OMgade2Dfjuvi5IMm20v1Z3z5EpzVF2dWEkP
	 VkzASyUbYjj+5TpfpNeG8KXFXZCMmS88XFOuPQB37hKXhVjjjD71fnlez/rlPdy6lF
	 l0YkbIQOveYU6f2L8QW9sFolAhX0qqfJg0M3r9ts1PwyRpD2MHEc4FE1wjwqxgGIrT
	 zHqPdaJvbdPGLSwJmBcDnVYMYTrGepyL3katyh7vL+COLjv3MYNzn14scUBcrly/SN
	 qxtA2OvlgsR5g==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d27184197cso18029701fa.1;
        Thu, 14 Mar 2024 15:36:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV3t2zuuH/HRqxUHFU0PL4U0Dg5HR8S7ZcQegl0/Z5o7ScsIS6FZzBvjxz854xrPGLAGT/45GJ3tzrgFLOAjpG/0iSp4ujmNKU/4P2JPm97dTPOyiksDjObBmaPGvUydHpwuhzCndV+VeQOqPn4zcUzOqeguQwkmYwzcws1ztDFiA==
X-Gm-Message-State: AOJu0YzQqUN3r5iGAQWWGma/2vmt7LwdMvctzYWSkOazo40Uj6JYvKA0
	HksqPNwSp4PG2yUVFqxrMVv3IjFHn0S/9cN84t17HZpLPeGQHCxL1AzifVeccr7aAQ5qTxNaSIc
	Cx7nBMInB7viJRXpzVVPp/pNfT88=
X-Google-Smtp-Source: AGHT+IFiM0ytae454y9Doy0DuUAI+DWqxfqDNq0jd8LMDy7eU4aCLH+y9/AkZYl+Sa+21uX20P6wffVPOv9NMK7csE8=
X-Received: by 2002:a2e:bba5:0:b0:2d4:72c1:d2dd with SMTP id
 y37-20020a2ebba5000000b002d472c1d2ddmr2106863lje.8.1710455809914; Thu, 14 Mar
 2024 15:36:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123005700.9302-1-dan@danm.net> <20240220230658.11069-1-dan@danm.net>
 <7efac6e0-32df-457e-9d21-4945c69328f8@leemhuis.info> <CAPhsuW5QYTjBvjAjf8SdcKmPGO20e5-p57n6af5FaXudSiOCmg@mail.gmail.com>
 <739634c3-3e21-44dd-abb1-356cf54e54fd@oracle.com> <d3cdebfe-17c0-4f61-9ad9-71d9de2339b2@oracle.com>
 <ecfce4d7-bcf7-c09a-7f01-5c7de88df107@huaweicloud.com> <ba26ac4f-160a-451e-a08b-27f577d8d2ba@oracle.com>
 <fa4beda8-986c-1112-f3f2-159f20674d47@huaweicloud.com> <e58155bf-71c1-48c4-94c7-b0d9ecbbef99@oracle.com>
In-Reply-To: <e58155bf-71c1-48c4-94c7-b0d9ecbbef99@oracle.com>
From: Song Liu <song@kernel.org>
Date: Thu, 14 Mar 2024 15:36:38 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7V_n96PDp0wBe5pFNrrkZsbiTQZgZkY+FN7fpJYUmmaw@mail.gmail.com>
Message-ID: <CAPhsuW7V_n96PDp0wBe5pFNrrkZsbiTQZgZkY+FN7fpJYUmmaw@mail.gmail.com>
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system;
 successfully bisected
To: junxiao.bi@oracle.com
Cc: Yu Kuai <yukuai1@huaweicloud.com>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, 
	stable@vger.kernel.org, Dan Moulding <dan@danm.net>, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 11:20=E2=80=AFAM <junxiao.bi@oracle.com> wrote:
>
[...]
> >>
> >> This patch eliminated the benefit of blk_plug, i think it will not be
> >> good for IO performance perspective?
> >
> > There is only one daemon thread, so IO should not be handled here as
> > much as possible. The IO should be handled by the thread that is
> > submitting the IO, and let daemon to hanldle the case that IO failed or
> > can't be submitted at that time.

raid5 can have multiple threads calling handle_stripe(). See raid5_do_work(=
).
Only chunk_aligned_read() can be handled in raid5_make_request.

>
> I am not sure how much it will impact regarding drop the blk_plug.
>
> Song, what's your take on this?

I think we need to evaluate the impact of (removing) blk_plug. We had
some performance regressions related to blk_plug a couple years ago.

Thanks,
Song

