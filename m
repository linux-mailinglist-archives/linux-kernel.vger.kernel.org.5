Return-Path: <linux-kernel+bounces-7070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF46F81A13C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BFB8286E0A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A89F3D973;
	Wed, 20 Dec 2023 14:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OHQPpxYe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E72C3D98F
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3366827ca79so3172047f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 06:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703083147; x=1703687947; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f2oUpPP2PLyXV8nPq8H1pk05VlePtZv14Y6rjtd2zCg=;
        b=OHQPpxYeWLJGbaLz8p4BpvQ7NyjQlaTkaTUXBQAJmGat/HsrBblxEiurb1sc8sakWX
         e3lNb0YVh3gmpab9htQuUvGKOeA6SJN6cKWFvn32zxzbh8c+WHYLhSQQVeOImlBf2vds
         8WA/IlsZzb5KMh2e6A+jmmhwSz0J9bZOQSAehYkyBMkR/LgMpB5TLhwqnpjTzsPVkwrC
         bfcXv7VWM/UEURiVSYwtiYkFJM7rQ6BhWcTMt+GYL6J69Xe6sRQNkNy+COYyqxckmB6o
         8Ec5pE5aTqNXMNg4dj4Lo/w5H2Uyu8snvlJ9demvEMwQCDiL4w+x0mXPxYlYagZGuRTt
         BPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703083147; x=1703687947;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f2oUpPP2PLyXV8nPq8H1pk05VlePtZv14Y6rjtd2zCg=;
        b=tiquBWdym9ZfyX6EYWzZha95GJOVeZkSVqwh2mts7+znR2qqqYybXqaVch4nvUvIKH
         CE8ZDzud9ZQJ4vQFI0cRMofPU2rN9tPmWeGvbkthN2F+A0y0TCXI2bDZx/CSU7rnhqBf
         GF8dIgQ3Dz+ETR9K7ZiCEb/yHcefw8/5mUic26yCSwgN2SdGgTmE10XbaLAyvPLyIQwm
         ALN8By0p8K7Me7tnsNw1LQ+RWCrFZSjrUbayYn60VzPRTWL5d+rrGC8YAr/g2srEH354
         RNNCL6WHtL/Icly5p4gJGXE90YJuNWCvDlpB59Le+RxpdTc3Xy6uusw+Wc4i3/CuGhmv
         Py9Q==
X-Gm-Message-State: AOJu0YwB5lVC/z+FpA3dRnzOEBcXFvgJdHohwi0eFxXGqCZaBPQLh9fE
	V1Ah02YHjRcPDrB376sm+6SJ8Z2y61Y8VKMLyKLYWQ==
X-Google-Smtp-Source: AGHT+IF8K6EUmmfn1dSorG+bifQbkbItpBNPjm2gICGt2CYz8CKW5ogpaRIJFGwGAo1cEwXzCcejyo4bDjcnYdjSwOs=
X-Received: by 2002:a5d:47c5:0:b0:336:5b5d:245f with SMTP id
 o5-20020a5d47c5000000b003365b5d245fmr5663984wrc.140.1703083147437; Wed, 20
 Dec 2023 06:39:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230906102557.3432236-1-alpic@google.com> <20231219090909.2827497-1-alpic@google.com>
 <CALcwBGC9LzzdJeq3SWy9F3g5A32s5uSvJZae4j+rwNQqqLHCKg@mail.gmail.com>
In-Reply-To: <CALcwBGC9LzzdJeq3SWy9F3g5A32s5uSvJZae4j+rwNQqqLHCKg@mail.gmail.com>
From: Alfred Piccioni <alpic@google.com>
Date: Wed, 20 Dec 2023 15:38:31 +0100
Message-ID: <CALcwBGD1hW4RJEpm6ABgEA--0RKkn1U9O5mBPL1g3B4Hw+0gWA@mail.gmail.com>
Subject: Re: [PATCH] security: new security_file_ioctl_compat() hook
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Eric Paris <eparis@parisplace.org>
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>> By the way, for extra credit, you could augment the ioctl tests in the
>> selinux-testsuite to also exercise this new hook and confirm that it
>> works correctly. See
>> https://github.com/SELinuxProject/selinux-testsuite particularly
>> tests/ioctl and policy/test_ioctl.te. Feel free to ask for help on
>> that.

> I do like extra credit. I'll take a look and see if it's something I
> can tackle. I'm primarily doing ad hoc checks on Android devices, so
> I'm unsure how easy it will be for me to run the suite. I'll get back
> to you shortly on that.

In response to myself, I unfortunately won't have time to do the
testing updates this year. If someone else wants to help, that'd be
great! Otherwise, I'll take a look next year after vacation and see if
I can take a crack at it. Thanks!

