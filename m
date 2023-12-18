Return-Path: <linux-kernel+bounces-3500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0923D816D1A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1B21C2325F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36C91947A;
	Mon, 18 Dec 2023 11:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YcT1eM54"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDB61BDC6
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 11:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3b9d8bfe845so2485803b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 03:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702899971; x=1703504771; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V9/PLI7rzj7f6jyQoGUSY2YBGvyf/vqnFypMEK1t0Q8=;
        b=YcT1eM54FVR2bQ5I219Ah8GUnDxQZe2A9/ScdO3b3Veg3SS7WI6ldLj5zgKUWBq37W
         F9TKSpRo84o/nwM6oYYbfc01qRg3MBenoZC5pC6GI7jT6fu6J7kJ2V6cpY3cyn7sEpUx
         9yFvxLuIs/ZjZUPI9iqnTYO0crYKQJF/Q8qbVIKDo42Wf2TqbDD6TXiB+JyaGmZTPlQD
         2O88kv148Amd63ai5zptDt1uhO7QZI0ABZacCA+G481PWTOASKEYSa5ILXCVG3LFimQA
         vtruPb8HY+kpUG/ffhHkG+WjIB1uKWujxb9Co40eLmLEiakCyj80o22J6OePUIWYQLn9
         sOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702899971; x=1703504771;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V9/PLI7rzj7f6jyQoGUSY2YBGvyf/vqnFypMEK1t0Q8=;
        b=qDg3H6+EEeO0pQnV0Ncg4C4S8md1KPkaWq47QT14j7peHfCKBkRO3dZuW8caXL+wzu
         cAU5jMf1oX6CkWGnut022SzViU+KezUhTiSGxYba4eio5MiyLHj/1FZ5Kfmn/tB/0OLC
         VmG2edZHfA8yOLgIWa4jiyLZ3+OrVt3qAAI4FhdIR/5EcmWQWjV1ILcMqavwsv2M5s6F
         zj15Q882sRbWJyaRYR26VwQdlwcG4g5ZECKHdXSJe5kaTd/mjLq2Drf77Cj+Mtlh5dcA
         25uGagXGEK/P8yJzMXkjIi8JI9OJy+rfkxky/lYMVfBEkzeSBsx5apHUscbHh2fG8bYz
         MyfQ==
X-Gm-Message-State: AOJu0YxekSgru4WBFgcNZay0TRsxU8lNG9190zFiqGohgiisYUpsyPwo
	Z43X59zkBgAkRDiacrQ23HeOb13mOSzuYiXx4eXzaQ==
X-Google-Smtp-Source: AGHT+IEvOKcysKa0HBLT5IMkFy/4mujLlwcIKFwPYdHRrZQ1p7YoFmw0s4dV60lNXkTBGiokzPb67L1FD1n3eG2qPBI=
X-Received: by 2002:a05:6808:6548:b0:3ba:aa7:bd2f with SMTP id
 fn8-20020a056808654800b003ba0aa7bd2fmr21108554oib.92.1702899970823; Mon, 18
 Dec 2023 03:46:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214110639.2294687-1-glider@google.com> <20231214110639.2294687-5-glider@google.com>
 <ZXtircr4TllpqyeS@yury-ThinkPad> <CAG_fn=WcrNqV4burBRPZZwoBLwgia7kerZ8g2vV5spzWF=houQ@mail.gmail.com>
 <ZXyAXPxlmq11rp2Y@yury-ThinkPad>
In-Reply-To: <ZXyAXPxlmq11rp2Y@yury-ThinkPad>
From: Alexander Potapenko <glider@google.com>
Date: Mon, 18 Dec 2023 12:45:34 +0100
Message-ID: <CAG_fn=U5f-T95u+r5ok8ptA2sLdzqKPNxGia+NRo1hnGs15DoA@mail.gmail.com>
Subject: Re: [PATCH v10-mte 4/7] arm64: mte: implement CONFIG_ARM64_MTE_COMP
To: Yury Norov <yury.norov@gmail.com>
Cc: catalin.marinas@arm.com, will@kernel.org, pcc@google.com, 
	andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com, 
	aleksander.lobakin@intel.com, linux@rasmusvillemoes.dk, 
	alexandru.elisei@arm.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, eugenis@google.com, 
	syednwaris@gmail.com, william.gray@linaro.org
Content-Type: text/plain; charset="UTF-8"

> > > Nit: really no need to split the line - we're OK with 100-chars per
> > > line now.
> >
> > That's true, but I am relying on clang-format here (maybe we should
> > extend the limit in .clang-format?)
>
> If clang-format hurts readability, don't use it.
>
There's an old discussion on clang-format column limit being
inconsistent with what checkpatch mandates:
https://lore.kernel.org/lkml/20200610125147.2782142-1-christian.brauner@ubuntu.com/
I changed the name of the variable in this case to avoid hitting the
column limit.

