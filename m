Return-Path: <linux-kernel+bounces-29905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C078314F5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E641C211EE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C19125A4;
	Thu, 18 Jan 2024 08:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvPB4S8V"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2721170E;
	Thu, 18 Jan 2024 08:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705567252; cv=none; b=G+sLVeRqLlKwwRi2oQZOPbCCWSbmvkE7Ok7w1vxweAhk6F8L+98zRloG5M4wuCgHRQ94n7ogmvrmX9atbSJ94Vj03Ggwp4feGJnNt7kQJBj1fi5pPE0ewo3Tq9XkBlb429buwPFMh2U4XsJKawK7LhXSFYhebkGlCWT5HDnk3ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705567252; c=relaxed/simple;
	bh=kTrKvY+ZpZRvmrl04Xmv+nqP95dJog5F0KPUXF/ZEhQ=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=UwHpW8Lc3ni4r5Kr/laGb81ceipHT+r0EyCRSUuUFTPB0kIhvazYl9o+c+pEfRyjLcsgZdt4jJ/lTBw3vV4SnIOanKPttDqw7GpElArdZ3ZwS/Sd9cufP7RBpSWUT9vmZOy70o7FxNwA/leE7IwYetmokLRxIYlh02/atjnV2r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvPB4S8V; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cd33336b32so158089831fa.0;
        Thu, 18 Jan 2024 00:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705567249; x=1706172049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uEQJFz2oWfMfQv57hY7KbsMu1MXvb5toYweGJv4ICU=;
        b=JvPB4S8VWLuJuFi1RKKgLIsLmk5AFNl54UCkJjNEtpw+pHkMjn386ZuQyBR1jhwdxS
         xYJL7QXFsr2KCbDKK10JnAGGDjquVyiTMRSZK7/12W3nPO/MX30A188y5yxm1w8+ZySO
         hwHjkdtp+fHuOiu1/IqydjkUSXl0gieDkP9Y90rzHfNnAypQRdN63yJxz5DC2YHNyKED
         6veRnw0cxpA0GxxZ+vj0JomQzrnrIZShsYdGN68nLoBvhSqRXYa9xxClOsVNY+DgbJGq
         42LglsV/H59CCMiKfmkFJmWSqdntoCQG+a20Rwmc4B3OnMidtDKGZVn3PyB3xSm+zcpm
         AL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705567249; x=1706172049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6uEQJFz2oWfMfQv57hY7KbsMu1MXvb5toYweGJv4ICU=;
        b=JsT5r18PIBUXd/LoHQgLj+7aijDdda5T/wljAYY+8LkL/HpinzTE2fYFEzI4wKTvlm
         bhrmsphydzQsTbXlGYQm8pB/wdT0LOzdrmh7yTzLpFBqD6gexoS+P0wsjs3KwufFuMLS
         VWpRz+3kuWk4HN/1eMu0LrMnTkKrgN41FjVDWDhW56dV3tZXF1x4KfhKCyljvH9KEtqX
         NeDvB6JppyRNKgasmucIWkWL3kpIA8nsstva3koQVsrO/7nqaEDfXYq/omsmHKeqrK3u
         G15QgtLc9pZIubDB4N8KiFkPaitBx0m3u88JxWXxsX7LUgNkHUCi33O2nyR9mFlvumbA
         hHnw==
X-Gm-Message-State: AOJu0Yyt510GAtemcpY1H86wIATPMJlBbAtJD+fc1irimuSe8rLieQwD
	SfAKJjBv2hSglpbQkvfYDF33sCAN4mzxBk43t3Gg8NjjDk8PU/t6CMiGAzuH9hl/tMzfTkojtYk
	+NbKqPxQfsG8Sotud3Y5WadwVimPLW+j1nLs=
X-Google-Smtp-Source: AGHT+IF6zMqIDK/PXaX7kXc/UK3PLNys16DVuVwxqvH10vIuoa7Cob7zZ9Eq4gItq0YfwysG0+OZi8ZAq4M/0aWAwTE=
X-Received: by 2002:a05:651c:220b:b0:2cc:74c2:3af2 with SMTP id
 y11-20020a05651c220b00b002cc74c23af2mr455782ljq.28.1705567248948; Thu, 18 Jan
 2024 00:40:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117092348.2873928-1-zhaoyang.huang@unisoc.com> <5ff36535-7cd3-4e8f-a477-9d2a98d18dd9@acm.org>
In-Reply-To: <5ff36535-7cd3-4e8f-a477-9d2a98d18dd9@acm.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Thu, 18 Jan 2024 16:40:37 +0800
Message-ID: <CAGWkznGc67yY9xCHJFLGvJZBu2oXOgOgHKZ_OvbBrv5mqRMywg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] block: introduce activity based ioprio
To: Bart Van Assche <bvanassche@acm.org>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 1:29=E2=80=AFAM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 1/17/24 01:23, zhaoyang.huang wrote:
> > +static enum dd_prio dd_req_ioprio(struct request *rq)
> > +{
> > +     enum dd_prio prio;
> > +     const u8 ioprio_class =3D dd_rq_ioclass(rq);
> > +#ifdef CONFIG_ACTIVITY_BASED_IOPRIO
> > +     struct bio *bio;
> > +     struct bio_vec bv;
> > +     struct bvec_iter iter;
> > +     struct page *page;
> > +     int gen =3D 0;
> > +     int cnt =3D 0;
> > +
> > +     if (req_op(rq) =3D=3D REQ_OP_READ) {
> > +             __rq_for_each_bio(bio, rq) {
> > +                     bio_for_each_bvec(bv, bio, iter) {
> > +                             page =3D bv.bv_page;
> > +                             gen +=3D PageWorkingset(page) ? 1 : 0;
> > +                             cnt++;
> > +                     }
> > +             }
> > +             prio =3D (gen >=3D cnt / 2) ? ioprio_class_to_prio[IOPRIO=
_CLASS_RT] :
> > +                     ioprio_class_to_prio[ioprio_class];
> > +     } else
> > +             prio =3D ioprio_class_to_prio[ioprio_class];
> > +#else
> > +     prio =3D ioprio_class_to_prio[ioprio_class];
> > +#endif
> > +     return prio;
> > +}
>
> I don't like it that code is introduced in the mq-deadline scheduler
> that accesses page cache information. Isn't that a layering violation?
ok. I will try to update a new version to implement these in block layer

> Additionally, this approach only works for buffered I/O and not for
> direct I/O. Shouldn't the I/O submitter set the I/O priority instead of
> deciding the I/O priority in the mq-deadline scheduler?
That's just the purpose of this commit, that is, introducing content
activity based ioprio OR the one that submitter decided
>
> Bart.

