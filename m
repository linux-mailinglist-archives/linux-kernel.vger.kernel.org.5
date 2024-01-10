Return-Path: <linux-kernel+bounces-22540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CFD829F43
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0C381C22AA6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426144D105;
	Wed, 10 Jan 2024 17:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZxlPX0uB"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C354CDEA
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 17:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a2a225e9449so472113466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 09:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704908086; x=1705512886; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/49oXKnbPjZF5ZGzYE7U5F6wOvnnpExXGG3oQotPgWM=;
        b=ZxlPX0uBFLqfUVhPHvPB16d9tub5EwmOi8SEPACcteE6p1eu1yMgdwQxPAWtxuQa12
         HRsBRDpt28Y2rfx+c6jzjJiNqxVy4zjoz1sHhnk9gtR1VSPwntsdzuOMysWfBbiKkilq
         h/B3+bzPnZOIBx7i/eBCH7O++fbu72kiKkFBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704908086; x=1705512886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/49oXKnbPjZF5ZGzYE7U5F6wOvnnpExXGG3oQotPgWM=;
        b=oJgZ7atQ+NnUHh2TTKPeLlJ+zZRFJt3UZ0pl8hMOF7zQJH9dkBJr3wspgHkWNXbW/q
         m3XEhHWGbtVeezXiwfCRtRdndpFIz2KF1CSGogcvEvcwBK2C6QYl7aNeyNJ1ecX8y/vw
         0T+Q/KK9KsqPpKzmrBd+V6PaMp8QzlnGPcPnl6pUyfvUgqG1LG6bX5/iRu+L9G6qp/X2
         ZahmGme6ujqITXwjyYPAkbDWvjnI5DT7GsQJ+skM2AdsC8U1guPJNUsL/k53W6BoypxD
         Yja5UrmZyeKkTdUy3eTPwsbMaEJ33h83E3fp9JuD+STA5tvHZ5rUMjjfl0Uwak9dcBsN
         K3Rg==
X-Gm-Message-State: AOJu0YxYpeqwUxUGbjXzAJF9Jp/4+9+M2IAGNEjkEYba4mZSs7xVkV3k
	WwbfyCv6FRH3MssDHbOl4uj0KsJI/a+bJITNJ9M1mX44fELs3Q==
X-Google-Smtp-Source: AGHT+IFPVvMqgm2u9yydn3l6Xzw19capN8oFp791bgcs1eG1PQi84RgsvfTxCIy5YIqPm+3qD1Qtcw==
X-Received: by 2002:a17:906:110d:b0:a28:6bca:9f8b with SMTP id h13-20020a170906110d00b00a286bca9f8bmr869911eja.126.1704908086566;
        Wed, 10 Jan 2024 09:34:46 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id qk9-20020a170906d9c900b00a28da51438asm2269826ejb.157.2024.01.10.09.34.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 09:34:45 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a298accc440so526919566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 09:34:45 -0800 (PST)
X-Received: by 2002:a17:907:31ce:b0:a26:98a1:9e89 with SMTP id
 xf14-20020a17090731ce00b00a2698a19e89mr1099695ejb.41.1704908085231; Wed, 10
 Jan 2024 09:34:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1704481157.git.dsterba@suse.com>
In-Reply-To: <cover.1704481157.git.dsterba@suse.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 10 Jan 2024 09:34:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjju0S87C+pdF=0i0hVky+HeMj1xVFwUdV867YoLheL5Q@mail.gmail.com>
Message-ID: <CAHk-=wjju0S87C+pdF=0i0hVky+HeMj1xVFwUdV867YoLheL5Q@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs updates for 6.8
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jan 2024 at 11:04, David Sterba <dsterba@suse.com> wrote:
>
> There are possible minor merge conflicts reported by linux-next.

Bah. The block open mode changes were ugly. I did my best to make the
end result legible.

You may want to note the btrfs_open_mode() helper I added and possibly
do it differently.

                    Linus

