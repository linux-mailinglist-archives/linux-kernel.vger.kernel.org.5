Return-Path: <linux-kernel+bounces-142038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF5B8A269C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A14251C21C55
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9EE3B2AD;
	Fri, 12 Apr 2024 06:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Byzm0yPe"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7605B2C87C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 06:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712903336; cv=none; b=rH0b/pc82/ujW5Qqy+EhTC8aaLJRWxJsETSddyNkPbzRYDEiDSwUrSgzW1Thntvtri7luOQ6YW4Gjmrk1yqnaDpQ6jjedyvDd2sA8dQvopGai9pFoIocds7UKyCzpM+GPpg+So9lUcEFWWKuYmmeArgeevNfa/hpDZS3wP9gRVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712903336; c=relaxed/simple;
	bh=+RwbcFry8D89CJYvhce0MUVsj/oVUO7sMBwglPpCnGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SSncdS3VnPgYcBls2hVBmPY3sTMQ38/qkUXg4aw7bqHf+StGsQFQZ3fB1lA8tSgrW8J+C7Rh4yQbx3j3tPIrdq0cyqfkDNuTchLteNvAfFZpD0reEvKkEBLmsU3cYiwOxhyVkgnEnyCDjYi7R2oSVEWoHkEpe2/5wQFW75+sSQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Byzm0yPe; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E35083F17B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 06:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1712903325;
	bh=+RwbcFry8D89CJYvhce0MUVsj/oVUO7sMBwglPpCnGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=Byzm0yPe+uRrHVoGuXVRmJiuQEdwCUHhknpG4Q/b6fsYXHqOJ1tu+DRbW/TbWHlk2
	 MNwLvUmb4gTbYKpUKH0ySWwNbE/pZX4JW+jJg5uVJyKYmB2JLLxBsHzIHbP+G8/m/5
	 V7xuii9jJ9+P0KG4zfW2hfxQzLepWO8qXkiL+AgEmFCvD9Uj7khqxrwQetXG+zPsvr
	 cCPQubAzZs4YqaSd+9PutkNb+P8gu1d8i0flj+BenUi9Jv5C6iE1jMZQOVNzdp925P
	 GN+3z/Ud8dmiOCLyTutRpBJL2SNH6E7rkyY+PNv7kCbfhE/Yqo/Blqli95wiHNALcp
	 GeJt8/o6QgMcw==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2a517457163so536692a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 23:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712903324; x=1713508124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+RwbcFry8D89CJYvhce0MUVsj/oVUO7sMBwglPpCnGs=;
        b=hjoIgXNbX6HeTRLGCSVLN30v911+Bl+q7JG6h64Kw3cKfk5lLN77ppRqOBRWzxSYuR
         fqLxpGI+fqmJ9/80LnZjHn2lUTLT0HgzVMhdkk3h36AXOBvrQGNaCJz5GN3+WQ2sk7m2
         5iukW8O18UFZOFM7M6/6+t3Ca4LgkpfI94sSPXp9il87Ai5Ku6UiEdw1FnFUN72cxYgW
         MgFiH3HRRw8rRfTNFYdoNEjUYwqSJIStOubpJi6fnUxot0nwYzqhqP/oZ9sxH+QESVSY
         UQgRBOWMbJOQ+5AIG4DoIY5uaCaesH/x3jKknVpCoO+5Kl06UQN7fgdLmX+HXK1rDY3M
         DyUw==
X-Forwarded-Encrypted: i=1; AJvYcCW1aBZImjjuJIZ0fOfFAD/2kKHtBmsP0VCaHyUgiilj0fyeV8RreVQRZZ0txg82ovUaNRegrJpa12Du6vLTaRuRW23xr2kzhoL+jno/
X-Gm-Message-State: AOJu0Yx4BPjCeXgk+CxhuncEbtccNEruUm6BBWfYSSooPMqUPxV+LYmE
	RdLYf1kDn0h0QgWyvzYwwPDM+BtwHwha3LnQvMvvTBdQhpVJg1wEjjQiMNw7RJ3R1aLBKxuqZJi
	fuJCsxYNQV+iQeoaE43tMKxc7TooVVRrttnlRzYhuuXx3SwStcXf0fkjJo3T3NHchCGrFI8Vgo5
	nmIbsSsPytCrwYhzVJhJ8238RIXfAJNOVv5GbBUGqV1v6xcAT4x+P7
X-Received: by 2002:a17:90a:6f84:b0:2a3:ba0:d9f with SMTP id e4-20020a17090a6f8400b002a30ba00d9fmr1707268pjk.11.1712903324487;
        Thu, 11 Apr 2024 23:28:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3ziXTJu0QamXxvs6gYNvz/UNmyeoJRNxjKRKuN6UjDuQ4mIcj3plCiuEPcjfLbDFMjUnt4dCG4AFXjDUNO/s=
X-Received: by 2002:a17:90a:6f84:b0:2a3:ba0:d9f with SMTP id
 e4-20020a17090a6f8400b002a30ba00d9fmr1707254pjk.11.1712903324140; Thu, 11 Apr
 2024 23:28:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405102436.3479210-1-lma@chromium.org> <ZhOccGFkTFkUkRUI@hovoldconsulting.com>
 <CAE5UKNqufWZfKLAXLcpBYKQpJEVt6jPD4Xtr=Nesh34VkNOETg@mail.gmail.com>
 <ZhVix-HJrqQbiPrB@hovoldconsulting.com> <CAE5UKNp3uS9cqDbQjcP3SbfxVi3wPFG4LtP6z=WU_V+M9x6LtQ@mail.gmail.com>
In-Reply-To: <CAE5UKNp3uS9cqDbQjcP3SbfxVi3wPFG4LtP6z=WU_V+M9x6LtQ@mail.gmail.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Fri, 12 Apr 2024 14:28:32 +0800
Message-ID: <CAAd53p54HYPZEbK2aKQXjZt0V0-u-+F+6yqFjLzSVZx5BXG91w@mail.gmail.com>
Subject: Re: [PATCH v2] HID: i2c-hid: wait for i2c touchpad deep-sleep to
 power-up transition
To: =?UTF-8?Q?=C5=81ukasz_Majczak?= <lma@chromium.org>
Cc: Johan Hovold <johan@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Dmitry Torokhov <dtor@chromium.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
	Douglas Anderson <dianders@chromium.org>, Hans de Goede <hdegoede@redhat.com>, 
	Maxime Ripard <mripard@kernel.org>, Johan Hovold <johan+linaro@kernel.org>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Radoslaw Biernacki <rad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi =C5=81ukasz,

On Thu, Apr 11, 2024 at 10:23=E2=80=AFPM =C5=81ukasz Majczak <lma@chromium.=
org> wrote:
>
> > Sure, but what about other transactions that are initiated by the host
> > (e.g. SET_POWER)?
> >
> Somehow it is problematic only on reboot and works just fine on
> suspend/resume and
> set_power.
> I will dig more and try to find out what the difference is.

If cold boot doesn't have such issue, maybe I2C_HID_PWR_SLEEP
shouldn't be used by reboot?

Kai-Heng

>
> > Perhaps this hack at probe is enough for your use case, but is an
> > incomplete hack and at a minimum you'd need to add a comment explaining
> > why it is there.
> >
> You mean a comment in the code ?
>
> Lukasz

