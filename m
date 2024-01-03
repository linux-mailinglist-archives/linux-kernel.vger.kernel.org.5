Return-Path: <linux-kernel+bounces-15904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0946A823567
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EDA62860F2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2531B1CAAA;
	Wed,  3 Jan 2024 19:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EqAcBFq9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4BD1CA98
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 19:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-555e07761acso4449095a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 11:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704309317; x=1704914117; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VqpWt6ocefEfDXK+KnHNKXoEM0IL+DB/QDp9HBirG1E=;
        b=EqAcBFq97pFwtmYe13BC1tWt0GnonY1LTo4njL+s/snL8yXFgvwnYkRUvAtt0zQ9y6
         1mAGHvuhP4DgrfVmN58DjUqF4MjT9AUfQ9v+xAn91VKSdCaUBG/PJsNgglyc+tUo5uIJ
         agJzYaT5uMGGPb5c8DZYQb6Ljve9/cQuK6XK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704309317; x=1704914117;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VqpWt6ocefEfDXK+KnHNKXoEM0IL+DB/QDp9HBirG1E=;
        b=WqHa3GcRbR52vBl7yeWiKj7/vUOiudg9PI5z2xFYSBF6pSTWpsB2alpU/HrzxDkEtU
         S3rlhaHvKHNXI3EdoUxNpp5HnXiDez+kLqHLLwrT3F9t6+kKtqCMWfNKC/F0AP4le+DX
         Xj6rfnwddv/ZnJJau0vVjxuc7hfz44nbAzASvSRua020f8QqwZ6CjGcMA6p8/xAbViAm
         H5nwaHd4ddw2a+sSdY1/h9u45OgRylfOgURH26O4yovOHCO7IfQ5MFYlZ5zgZ5TdNBoW
         Jd0qhCRcOE2zf2ATxAORFPP2zMQ6oU5E9mh4HGXX8bgDfcC3uSA9Gwc/eWNgDatf5Vvb
         ig+A==
X-Gm-Message-State: AOJu0Yxrt6YMz3LCBXB1GXEJT9vufAjqZmsgG+KFWmhGddK/nHi1OHIc
	xEjB+jjPUss/BBV3nRSmOaCVGmqGRURJbBqzJdwzC+tczuRJVKYY
X-Google-Smtp-Source: AGHT+IE42SDtjTO3X6yzx73C+GZauAM2YNH3OQwpy9ILFXrsS5IF61RiP0LN/N5mQingGCzj2aLfRg==
X-Received: by 2002:a50:c055:0:b0:553:79ad:4aca with SMTP id u21-20020a50c055000000b0055379ad4acamr8022836edd.87.1704309317034;
        Wed, 03 Jan 2024 11:15:17 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id j20-20020aa7c0d4000000b005527de2aecfsm17750330edp.42.2024.01.03.11.15.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 11:15:16 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-556c3f0d6c5so1256982a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 11:15:15 -0800 (PST)
X-Received: by 2002:a17:906:ef0c:b0:a27:6fbc:ce3 with SMTP id
 f12-20020a170906ef0c00b00a276fbc0ce3mr3854440ejs.42.1704309315585; Wed, 03
 Jan 2024 11:15:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
 <4dec932dcd027aa5836d70a6d6bedd55914c84c2.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
 <6c3fc5e9-f8cf-4b42-9317-8ce9669160c2@kernel.org>
In-Reply-To: <6c3fc5e9-f8cf-4b42-9317-8ce9669160c2@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jan 2024 11:14:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgLZXULo7pg=nwUMFLsKNUe+1_X=Fk7+f-J0735Oir97w@mail.gmail.com>
Message-ID: <CAHk-=wgLZXULo7pg=nwUMFLsKNUe+1_X=Fk7+f-J0735Oir97w@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] tty: splice_read: disable
To: Jiri Slaby <jirislaby@kernel.org>, Oliver Giles <ohw.giles@gmail.com>
Cc: =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>, 
	Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 03:36, Jiri Slaby <jirislaby@kernel.org> wrote:
>
> What are those "things" doing that "splice to tty", I don't recall and
> the commit message above ^^^ does not spell that out. Linus?

It's some annoying SSL VPN thing that splices to pppd:

   https://lore.kernel.org/all/C8KER7U60WXE.25UFD8RE6QZQK@oguc/

and I'd be happy to try to limit splice to tty's to maybe just the one
case that pppd uses.

So I don't think we should remove splice_write for tty's entirely, but
maybe we can limit it to only the case that the VPN thing used.

I never saw the original issue personally, and I think only Oliver
reported it, so cc'ing Oliver.

Maybe that VPN thing already has the pty in non-blocking mode, for
example, and we could make the tty splicing fail for any blocking op?

                Linus

