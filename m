Return-Path: <linux-kernel+bounces-74581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3184185D653
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D4231C224BB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A491B3FE4E;
	Wed, 21 Feb 2024 11:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8NRqo7a"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850953C493;
	Wed, 21 Feb 2024 11:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513269; cv=none; b=CwQt5+7ATeyg/3t1VrjcSW5HiXZZiEQ6LbxfNHcKIV1Ta3s3QIuL3ZrLh69smBNh1p26jwjldXQMFv9zH2ODPfIWFIBlA2VmdgR6mse5lLlMeWG3iMlx53a6DamEuU+jv2LQn4Yb2xAONxLuO4tiyHGYidEEVNSyGz9fCKiL0d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513269; c=relaxed/simple;
	bh=70eNBbKZzuAyuf1o2HIAmK0GV9wiKjhwAv48HbLlU4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jCIFlJYBQp7QgzkNxhB5kc1yjDWc4HIKPelaQn0S8A9kLt9AMQeiRi8yym4LtdiSaQWWMcN8r+HCNY8XTzl2Mhn5WYwgllfoBBe55+S0O8W7oKDfXAHeKXFg7Ack5N9pDsenGVS5BWZ9LDUyGDjQc3iOBigITFLxBpzM0/Gwavo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8NRqo7a; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-21ef7be6772so1940576fac.0;
        Wed, 21 Feb 2024 03:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708513266; x=1709118066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvM+TkXnvpsJe5GdmErUOSzKyCiaHvr4XSjgcC20Fug=;
        b=W8NRqo7aRv4KgVVp8mg2sZwrRZzTcPeVUqXZOnBbPU1zFKE5dkoMaPvv4WNXzawN30
         slwwYYwbagrtp6arPk+rcSMqQdN3hW9Oqh4zFdELaAZsHHV+ACDItEIoh2Theq7xzLky
         gNLE9/bSqcXdI/SPhsi4/By0bUppYdth0xt0kFS+qWbp8NrQKxfMm3daLCVqDjQHSDRc
         cAOgDAJaEbAuioTpsxoUBoU947XqKo+2L/ww1XpuJH0J6YKwFn/kT2cpk6w247gwpkor
         NyC1mQ7nAHnTzKN8jcH3rUMbOraV+muw5z2N0FRM8hSyGepp4u4X3S8xd/A9sNNUuAml
         5wzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708513266; x=1709118066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PvM+TkXnvpsJe5GdmErUOSzKyCiaHvr4XSjgcC20Fug=;
        b=oQ6b9O8Hnd1GKLmB54Gv1lLlnXQDVQJVBI6NlU/fnRl3U8UPb7fVFf3raoH0UYrgli
         R6PaxYHF4tnD33fykp+yFigo8QEFbGTGiIYYpyKeHQn9aHYWSKdu/HarkelyAwKy/+4W
         e+0LIEq9kAU1P+uIH8SScMt15u2TthUm9BJpT19LrBKgGcZNCph9HDHSob570n+VNguz
         rwZglPu7/iN+fKfRAiXiPXP5P9zpJMR8ilvHaZ79n/ZFIMXvO9P4EevhKajitXY+ULej
         jp0QQEP5rlzAOLYWdmH7miYsE5ZZcD9qCfGdDHCGBeiEcK2bfMGTRWDvQuhM6FiFJGRi
         /CRA==
X-Forwarded-Encrypted: i=1; AJvYcCU28EmBnNNJeYU8rOfGGk96zVLDBVSi3hflC8d73b4x4KqIXc182B5zrrXsvJaV4xnvVM3Lp6eLXZxtyVzBJzq7GDNgQb5yUuIzyN/0PpdarU77E5nVuPjtUeZo59ifPk79DwpfkY3H
X-Gm-Message-State: AOJu0YwsorKtmd31OYcPns/QG2W/1HfGK8y98gt2JKiOJaKgr0HdDm3Z
	LTbmCFMu3bcWysOiHOTiZz2AjH/GC4a2FsduonOGRmFHcNoAASxyuKMIXSpm8xkVz+btBDH5Uxq
	Sdg3YyL4NtU5PvHrvEnEI2v9gwiE=
X-Google-Smtp-Source: AGHT+IFjoEqIit3Y3gxSZt8bqndJp8MzYFZJomjlfSgVtaDiIw03tv411W8WKFYgRd+q5Xrd9k9XKz5JWK23cGvgPj4=
X-Received: by 2002:a05:6871:3a2a:b0:21e:e0d3:41b8 with SMTP id
 pu42-20020a0568713a2a00b0021ee0d341b8mr7803289oac.51.1708513266514; Wed, 21
 Feb 2024 03:01:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219074634.2039-1-xuewen.yan@unisoc.com> <ZdTXWrB8dascOIM_@slm.duckdns.org>
 <CAB8ipk9R3hRSTTEEBn8nvOcTZGBtaDQfomXiQwji+DTKgLghwQ@mail.gmail.com> <ZdWNvolkfPCyMNj9@slm.duckdns.org>
In-Reply-To: <ZdWNvolkfPCyMNj9@slm.duckdns.org>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Wed, 21 Feb 2024 19:00:55 +0800
Message-ID: <CAB8ipk9FtgYh5Ho-nFQCwUO8zOPEk73VS0KHFDuRS9yxDRpe4A@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Control the frequency of intensive warning
 through cmdline
To: Tejun Heo <tj@kernel.org>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, jiangshanlai@gmail.com, corbet@lwn.net, 
	paulmck@kernel.org, rdunlap@infradead.org, peterz@infradead.org, 
	yanjiewtw@gmail.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tejun

On Wed, Feb 21, 2024 at 1:44=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Wed, Feb 21, 2024 at 10:01:17AM +0800, Xuewen Yan wrote:
> >                 cnt =3D atomic64_inc_return_relaxed(&ent->cnt);
> > -               if (cnt >=3D 4 && is_power_of_2(cnt))
> > +               if (cnt =3D=3D wq_cpu_intensive_warning_nth ||
> > +                   (cnt > wq_cpu_intensive_warning_nth && is_power_of_=
2(cnt)))
>
> If we do this the nth name doesn't really make sense. Maybe something lik=
e
> wq_cpu_intensive_warning_thresh is better? Also, something like the
> following might be more predictable. Let's say
> wq_cpu_intensive_warning_thresh of 0 disables the warnings and it's
> initialized to 4 by default.
>
>         if (cnt >=3D wq_cpu_intensive_warning_thresh &&
>             is_power_of_2(cnt + 1 - wq_cpu_intensive_warning_thresh))
>

This way looks simpler, but it could not disable the warnings, but I
think this is okay, because even if the threshold is set to 0, the
warning will only be printed when 1, 3, 7, 15....

I will send patch-v2 later as you suggested:)

Thanks.
BR

--
xuewen

