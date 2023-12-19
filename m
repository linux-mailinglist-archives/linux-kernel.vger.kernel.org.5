Return-Path: <linux-kernel+bounces-5696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFE2818E3A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B7C286EBF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E451D37D01;
	Tue, 19 Dec 2023 17:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hKb4CYJp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30FA37D04
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55322dbac2fso3674865a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 09:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1703007235; x=1703612035; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OnZBfJxvlMXqfGxAlHGk4/tTYiysjQa2BcKYP1IJZmE=;
        b=hKb4CYJpXMwWhIJ5zb5x7HjWVIsezVmU9AEp7HGEukbq3bWz3G5q3k/+WdF0gtux7H
         U1ch+QN0wydKG5Xi0/Anhr3TN3eR4iByckYy7InVMjbX2Z4480wDNLEJpDCLZxE8dmmu
         LrK4KTWIGE+61knhtylKJlCQ8h3+C/bM54n5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703007235; x=1703612035;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OnZBfJxvlMXqfGxAlHGk4/tTYiysjQa2BcKYP1IJZmE=;
        b=ORyhnFICM2Npxiqx7eNnDurmdAbegDADWUhzLg22Vhv8wynwMkOu+kKHgIHZq3jog/
         kfXzQuPk8zymWRbVRvMmzfp9JQpybuc5+W7qmiXN+OuqdNxqMXD4ge32E4jXy037eN17
         QQYNP+dc6eY56djLcBMki5Ew1tST9aIX24EOGduE6JOcvQ7PYNKRoDFx7p1xr56M5ds4
         1HyfuWNF0NmikYSkU+L4TIATRfd8ixD8/i3h2bqnL9ozqEknIzheFp+Pq0TkzgDbTPsv
         aoORoAHjh/WGsM4/sAloPl7rCX/62cYKvGayXwWl4iL8g4Oqz6rwVmTeXvYnuvXw4/pZ
         1WYA==
X-Gm-Message-State: AOJu0Yz9Rdy6mnvYLd0UAXC1vY2COcTyVoUZhjG+owoiN/8nwplJj4HE
	fjo48k+RMxN8lLK+9tNaVULjD/c7QJGwxanSBexTTcR3
X-Google-Smtp-Source: AGHT+IGQiZE2Tjqn8sQDKMZ+9ouh/zqEDEwH0Ugl6uuXkx0URQDUau9hst8mGIgR3SB7f3tTdqoixg==
X-Received: by 2002:a17:907:944d:b0:a10:172b:4cfe with SMTP id dl13-20020a170907944d00b00a10172b4cfemr10503199ejc.11.1703007235484;
        Tue, 19 Dec 2023 09:33:55 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id v11-20020a17090651cb00b00a2549d2352dsm839484ejk.44.2023.12.19.09.33.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 09:33:54 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a22f59c6aeaso567444366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 09:33:54 -0800 (PST)
X-Received: by 2002:a17:906:4893:b0:a23:762c:7f61 with SMTP id
 v19-20020a170906489300b00a23762c7f61mr712235ejq.38.1703007234561; Tue, 19 Dec
 2023 09:33:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219151200.2878271-1-vegard.nossum@oracle.com>
In-Reply-To: <20231219151200.2878271-1-vegard.nossum@oracle.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Tue, 19 Dec 2023 09:33:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgSjQvgXbYkqJuOhL337cESfb-z65889D+-Rc6o5euYwQ@mail.gmail.com>
Message-ID: <CAHk-=wgSjQvgXbYkqJuOhL337cESfb-z65889D+-Rc6o5euYwQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] replace magic numbers in GDT descriptors
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, 
	Brian Gerst <brgerst@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Dec 2023 at 07:12, Vegard Nossum <vegard.nossum@oracle.com> wrote:
>
> Vegard Nossum (5):
>   x86: provide new infrastructure for GDT descriptors
>   x86: replace magic numbers in GDT descriptors, part 1
>   x86: replace magic numbers in GDT descriptors, part 2
>   x86: always set A (accessed) flag in GDT descriptors
>   x86: add DB flag to 32-bit percpu GDT entry

All these patches look fine to me, but I will again leave it to the
x86 maintainers whether they want to apply them. But feel free to add
my Ack if y ou do.

The end result does look a *lot* more legible, with something like

   DESC_DATA64 | DESC_USER

instead of just a raw number like 0xc0f3.

So while this is unlikely to be a maintenance burden (since we look at
these things so seldom, and they never really change), I think it's a
nice readability improvement.

The fact that Vegard found two oddities while doing this series just
reinforces that readability issue. Neither of them were bugs, but they
were odd inconsistencies.

               Linus

