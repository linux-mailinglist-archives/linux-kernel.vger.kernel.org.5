Return-Path: <linux-kernel+bounces-13811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B9A8212C7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 02:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FA761F21769
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 01:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E044E7FD;
	Mon,  1 Jan 2024 01:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T45J0Oj3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0869217C6;
	Mon,  1 Jan 2024 01:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7bb06f56fe9so54958739f.0;
        Sun, 31 Dec 2023 17:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704071774; x=1704676574; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=igLpTaTtuBNjhMxOT0ObscwM7f/uo9GkEsq0L4+MN+0=;
        b=T45J0Oj3WsdLzb8hi/7YMexWz/a5lmPL35fPxQdWGW++t9pi1LxMJnpeDPuB61QTRO
         df1O6HoijngewBABl4mMQHyYnsE9Y+qx4WbF33YcZ4w++E4qZpHon2LGbqWvbiuOYWUL
         yjTOyMdeq9A9RfZWPw+L6SrufYKgATkrP/hgthukWxwav2Y4fN28n8z1xb+T0TXJJ3wM
         KnYGNs519OdxOkhPOQ84qIMu1HfV7A061H8YXLKfuv9nOzqikMN5P+8Fss33FGnPxHyo
         dhvHiKOMrW5/viGdDnpNlq9m6cEqMgTGVIGUMIjDlcClV8G3LV6nTzE+uCHA7TKvtaM7
         0Jyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704071774; x=1704676574;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=igLpTaTtuBNjhMxOT0ObscwM7f/uo9GkEsq0L4+MN+0=;
        b=gbEJjoZtjdKBJVEtXU/fasfk2ZViREOmXh5dM2JQX+5CoFqgK7uw+9pBFzDBafJbsV
         8DYsxpWm1eG8tvxSxQlp6QojSAXo1QT0Lb2aDZFMmx7yttgA+dxEEDtoS0x3Npa9m0xd
         Gsb240LMSjUUy2VAy6k9VODnIWsJevBN899GSz0dDTN6lWj3pgrmQP3n9fdal8gWd0B2
         Cvlm29kKJRZkD02Z4Amt8VPU04TDF3AsdFW33OcBhBWDBqhZkaLxoowNx5McWoNwbI4I
         oBSsK5TMcXR8DrfTzlwI/NkiKvaWzgI+/D9JklKiAQsIDr0/2RzmcmaFWu7XSZqJxLPr
         lv+Q==
X-Gm-Message-State: AOJu0YwSLwZc/41K+n0DXzuEmdhMuUQFVCayoiMBDxmIW/8clwxzy+30
	C8bMuPIDCSx4ah/OoDhqU1hjcGnzNbvZ3xR/NT0=
X-Google-Smtp-Source: AGHT+IH9jf8WYpQtAcBecswGMkYwiqNiBGh4FJ/2sQJ4BKcCxUErEQhbdXQ4ezkL4J6/BeyqlYR1BGMwx5WAEhCdREI=
X-Received: by 2002:a05:6e02:1d13:b0:35f:da7a:3797 with SMTP id
 i19-20020a056e021d1300b0035fda7a3797mr27411494ila.1.1704071774062; Sun, 31
 Dec 2023 17:16:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPnZJGDcNwPLbzC99qNQ+bRMwxPU-Z0xe=TD6DWQU=0MNyeftA@mail.gmail.com>
 <d4b227de-d609-aef2-888b-203dbcf06707@landley.net> <CAPnZJGBeV-E_AN8GnTfkaJvRtBmCeMYYCt+O0XMsc3kDULRuKg@mail.gmail.com>
 <fb776d99-1956-4e1b-9afc-84f27ca40f46@linux.ibm.com> <0879141d-462c-7e94-7c87-7a5b5422b8ed@landley.net>
 <e32077de-b159-4a7b-89a3-e1925239142f@linux.ibm.com> <fcb45898-0699-878f-0656-f570607fbed4@landley.net>
 <8b85253d-dd75-42e4-9a05-dafb3618269c@linux.ibm.com>
In-Reply-To: <8b85253d-dd75-42e4-9a05-dafb3618269c@linux.ibm.com>
From: Askar Safin <safinaskar@gmail.com>
Date: Mon, 1 Jan 2024 04:15:33 +0300
Message-ID: <CAPnZJGCcsSoJVs_ct_9ngTrPpH0dxAakJCVGnYaYCDPbw2EyLQ@mail.gmail.com>
Subject: Re: [PATCH v3] rootfs: Fix support for rootfstype= when root= is given
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Rob Landley <rob@landley.net>, gregkh@linuxfoundation.org, initramfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hi, Stefan. Hi, Rob.

> My intention is to be able to pass rootfstype= to the kernel and have it
> interpreted correctly in the presence of root=, which currently does not
> work
Stefan, let me repeat: your patch, which does exactly this, got to
linux-next: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=21528c69a0d8483f7c6345b1a0bc8d8975e9a172

I think there is some misunderstanding here. First, there is Stefan's
patch (based on Rob's patch), which makes the kernel parse rootfstype=
even if root= is present. As well as I understand, we all agree that
this patch is needed, and it was applied to linux-next, so all is
good!

Second, there was my suggestion to introduce rdrootfstype= option. You
both reacted sceptically, so I withdraw this suggestion

-- 
Askar Safin

