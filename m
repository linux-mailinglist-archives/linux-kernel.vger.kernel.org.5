Return-Path: <linux-kernel+bounces-30044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC3C83183E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77CEC1F22F40
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5605E24213;
	Thu, 18 Jan 2024 11:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKLlCnT8"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270C523772
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705576471; cv=none; b=We6WRxuxwhWDsmVfUFlg+hfaN4P8R9GCFjtP4/ygKAXrA/smQQaCDFxJbwvq1xkDxXcyszE9JV3N5U+EKNrt5bsgp2OUkC0gjNpNm5OOtXh3qdnyEIyu/EJBitz3hUkwzc1W0LWH90umeIqn14ayvVBLbC0xHwAbQQs/M/l/mC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705576471; c=relaxed/simple;
	bh=9VE+k6l54CWKcwOP4zGe/Sl1ruOg42q4FivpaiWmeH4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=H3R7cZFwIUNym2aSE6Ai0rEMQ7Uv7rhtbMWHGhNoB56imFN0aXXEMomSLsCTUj6hhW4RxWKwue5KAq0iPPAoVGjc2LEPBhoLwpg2U40G7oP8rPkgKLWXJfGPuZkjAC4hwxMFepUtiIaTxkmZjpPI81e4FADS65NZ3U4/wlhJ/8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKLlCnT8; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cd853c159eso92753321fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 03:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705576468; x=1706181268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VE+k6l54CWKcwOP4zGe/Sl1ruOg42q4FivpaiWmeH4=;
        b=TKLlCnT8EXQRuPLxpitYcLPEQ1Xnzwk03+GlkHA9hJZDfM6g+k0kjt1AlPUBYO6QfW
         v6mH+GjaZJiVxPuoPuA9XGLg57rbfKIJ1ngxQY6aOSpeOAFCbYNhSK7soD8gAlEQWaNt
         imM1RQ6kF4jaPBCNSuJh6En8pfmI4AqqZeAk4tsDVZMR2bE4gC1yxuAXVe41jq1lrLuu
         2V41asCScaHGmqlLm6yDKzoXsahQcsHEE7GKCXQbGMH2mmvTozRQ5MqtNNZMxUpxHgp4
         LsEOKAclp3UH7v0AGYGKOzgIoTPssVpIdiNVp1dq08hMIJyfjF70PJQTozfuKCAy21Ww
         enPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705576468; x=1706181268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VE+k6l54CWKcwOP4zGe/Sl1ruOg42q4FivpaiWmeH4=;
        b=FTHYka+Z9CebJ3chKtigtMWQ1K/CrZ1kQrNQdx8sEIV5Zsu1nJu20ECDn3T68aEw0p
         khEa1PHWew8g/9Sv7Dao9r7adie7Y1HjksA9INJfJPBaY+XkjX+WwUS+0SILsyey53G+
         MGMZ5SUsfDWSmn2n339i/n8xvChWhlPbyR5aOt/FTXqGqZXelR+qX4jGLEcR0x6OAatc
         DMzwPE00f1Veb30bMsKyw11JVhYvuVzZjloWLQgVzrHY9yf6kUweo+lfHT/mY6K0E1T5
         7d8L9JOHsACkhUb+duvcHunFeKmXG8Org8K80zKzpkl24Qpbutff5+CYIX8Q9OLqTQY5
         jkFQ==
X-Gm-Message-State: AOJu0YyJPht3B9f9PDEPWYkEdyHQK7Z1QePiPSt/Rurixvt2zdopMDKN
	mkPe4dIqAV0/z1YdD/Y9FLHUpYv+auXuXkAROnH8KgW3k/aoSSM6oe1tyPzjirjXds4biflPBxZ
	8+T5xSZp1x18XjceZnWNGIWILzkw=
X-Google-Smtp-Source: AGHT+IGOekbppaoWwtk6ccGkeyMaF+QoO4HCmiuvByTKTlT9lg50wbR2VnXSzaFKEIzE7zcwlzczulK9pp0kkERFa9s=
X-Received: by 2002:a05:6512:2813:b0:50e:d3dc:2645 with SMTP id
 cf19-20020a056512281300b0050ed3dc2645mr499069lfb.87.1705576467890; Thu, 18
 Jan 2024 03:14:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117031212.1104034-1-nunes.erico@gmail.com>
 <20240117031212.1104034-2-nunes.erico@gmail.com> <CAKGbVbsydzXyKuhN8VyW9zYwuOMWzvz192WKKReHVX1XCnuXGQ@mail.gmail.com>
In-Reply-To: <CAKGbVbsydzXyKuhN8VyW9zYwuOMWzvz192WKKReHVX1XCnuXGQ@mail.gmail.com>
From: Erico Nunes <nunes.erico@gmail.com>
Date: Thu, 18 Jan 2024 12:14:15 +0100
Message-ID: <CAK4VdL2PnWTZ+M2eQqF22+VuF-YGKb_WjG=168BcuBDqD8+9kA@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] drm/lima: fix devfreq refcount imbalance for job timeouts
To: Qiang Yu <yuq825@gmail.com>
Cc: dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org, 
	anarsoul@gmail.com, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, christian.koenig@amd.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 2:36=E2=80=AFAM Qiang Yu <yuq825@gmail.com> wrote:
>
> So this is caused by same job trigger both done and timeout handling?
> I think a better way to solve this is to make sure only one handler
> (done or timeout) process the job instead of just making lima_pm_idle()
> unique.

It's not very clear to me how to best ensure that, with the drm_sched
software timeout and the irq happening potentially at the same time.
I think patch 4 in this series describes and covers the most common
case that this would be hit. So maybe now this patch could be dropped
in favour of just that one.
But since this was a bit hard to reproduce and I'm not sure the issue
is entirely covered by that, I just decided to keep this small change
as it prevented all the stack trace reproducers I was able to come up
with.

Erico

