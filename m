Return-Path: <linux-kernel+bounces-12327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E2981F370
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55BBD282B7A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 00:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EF4468F;
	Thu, 28 Dec 2023 00:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="b6Lq5WwA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC82F4401
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 00:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e7c76897dso2312086e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 16:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1703723794; x=1704328594; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuhB8VHwVQmrv2O2PykI3H6Y0tt0rKki08G/rfRh77c=;
        b=b6Lq5WwA+t7+gTf2ZEADvQomVCMQo6RYH1ySmv8oFEWqjNzswmkL+TaXW8WPiNRR9x
         cLoMuw14xRAV3Q8f8Ygb42G4Gp3ZCxhoKTqRzV4/wbaKMK+p24TPDx/tAPfaSEU1NI+S
         bEue72O/7hWlO+TYwP5HpSpnFx+NXvVssdBp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703723794; x=1704328594;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZuhB8VHwVQmrv2O2PykI3H6Y0tt0rKki08G/rfRh77c=;
        b=EUi7202+d4bWwHkeg734L5ZX2eV2joZm3kXrAUOM7Ack4JYiI/o4ZpX4PAWYVLkL7M
         mi1+6aoPO3JLve5e9+FfP47v8YgcegbsT0JfK302MpgfAEUTD0ql5Yy3tVOo1/GH6Yph
         lY1piqFwLFBKwLlLHYEbWOn2b06luy0PPVK0Cztguvg2/FlDQiME22nsoT/BB75DFlPS
         wZ7lS5fLwHj48mwPcHxtrCrlNGJ6HJyc7ljTOCmg5AAKwh3UV4b7+nKj3ZRZfGlFOQKc
         Ir+SAioDjTV/UR7fAGUtCJzlPA0I5U1Xbdc2l3iNepSAhMp8/vH4cdu5h5nqN1FQz60d
         19mA==
X-Gm-Message-State: AOJu0YxdupZYg8d8mcAl84Q3rDFAgCWfZJLCtoxE6TQmULkx60PPMWRq
	GP7JVt9Ywv9014nXq6agdqbZohJp35bv6oysv8zsaIHJDxCFGA==
X-Google-Smtp-Source: AGHT+IHPPQFRmPs68ad0WkiT2T0ErutL1NSRFhRG/0z+ZQ4Jn4lU6JRz6s2zrQtEwtR4QIVAQJTx+w==
X-Received: by 2002:a05:6512:419:b0:50e:2e88:1157 with SMTP id u25-20020a056512041900b0050e2e881157mr1653176lfk.107.1703723794568;
        Wed, 27 Dec 2023 16:36:34 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id w14-20020aa7d28e000000b0055306f10c28sm9124387edq.28.2023.12.27.16.36.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Dec 2023 16:36:33 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a26db4e9676so393788966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 16:36:33 -0800 (PST)
X-Received: by 2002:a17:906:254e:b0:a27:2f11:2928 with SMTP id
 j14-20020a170906254e00b00a272f112928mr781979ejb.271.1703723793333; Wed, 27
 Dec 2023 16:36:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231227150354.9437b5c792000b8eb22758e9@linux-foundation.org>
In-Reply-To: <20231227150354.9437b5c792000b8eb22758e9@linux-foundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 27 Dec 2023 16:36:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wifOnmeJq+sn+2s-P46zw0SFEbw9BSCGgp2c5fYPtRPGw@mail.gmail.com>
Message-ID: <CAHk-=wifOnmeJq+sn+2s-P46zw0SFEbw9BSCGgp2c5fYPtRPGw@mail.gmail.com>
Subject: Re: [GIT PULL] hotfixes for 6.7
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mm-commits@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Dec 2023 at 15:03, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> Baokun Li (1):
>       mm/filemap: avoid buffered read/write race to read inconsistent data

Hmm. I wonder if we should have made the i_size_read/write helpers be
smp_load_acquire/store_release()?

The existing smp_wmb() are almost accidental, and aren't primarily
about the inode size, but about the page/folio uptodate bit. I guess
they work, but it's all a bit messy.

Which might *also* be better off with acquire/release, but we don't
have those bitops, I guess. Oh well.

             Linus

