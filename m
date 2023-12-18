Return-Path: <linux-kernel+bounces-3553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9B5816DBD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0993A282175
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E0149F66;
	Mon, 18 Dec 2023 12:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7tw5wnd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B64B4F8B1
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 12:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3365e85a4easo1496487f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 04:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702901625; x=1703506425; darn=vger.kernel.org;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MQkXJYJc/Sg6AJczIV0BB5z+pNvPL2oyiY2izXL+Fek=;
        b=W7tw5wndDZqCAS6M1DJx3MIa1ufYiEoFUJivUQthY5LgZ7IbzJSe4TPqnFDFCIjCAj
         5dIRquBXp2MfQJo0HOEeg/i4LulukxvM7qhanFrKlfpn7O6pyQs/xnflD7P/G/+hDdd+
         WvwvgZfP66Y6aAOxPYbyRgXWVX3gaB9cUZ7mluF1KZgVEKV+DrI82nPTU8ui9G8z4PZh
         g4brLTAcWlbTsNNQb/vC45ASf+jjyXprT5OZxzFtN6Ulh4/ePPEbqPlTIFQWxZzTvLoX
         oTMuC3SGxy3aiGyNsUA6gXQf3RMgXamNYiObn1n3+5y/PquPeYyjRXCliygjty0f7/wu
         r3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702901625; x=1703506425;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MQkXJYJc/Sg6AJczIV0BB5z+pNvPL2oyiY2izXL+Fek=;
        b=N+DJOleDJZfJpqFSwsDZY775WajSbG5iTujaES0aTBYG715926nhYK0AiEacq6bIdV
         gcYM4FTx8MQMlYtnYhObHyNIIqFx62J9q732B1DiFeL3QmqOWu4pBGLsniAdFaImz0Rq
         nWSUYSN7PrCufYbORlsOcRvijRQDYDS3SnrnFNG/UHDXe4WKA6F5FFfn60v5Dme89nP8
         JibBLSoaxlw5jDDdwitCd+jMgEQjN0Ij1PYjI2fajpTA8lZ3qYPG6Tzs/SQ9vWpxXlI6
         Q2wmsy1ElNX9fuAkI1mGpFT2t6f0BSsAU/0YJkPdzSSf72RIXSrQsma/s/T4pY6qEuZm
         dG5w==
X-Gm-Message-State: AOJu0Yx0oZRUdHd3hQPwZDJu97/6VnAwQFIN9stxzDq0lDylyWrGfVJU
	bRzIkygMLO7uzkFR9r+47qEfbi8Zljc4pW5Mxg==
X-Received: by 2002:a5d:678c:0:b0:336:6426:4e1f with SMTP id
 v12-20020a5d678c000000b0033664264e1fmt1089425wru.34.1702901625226; Mon, 18
 Dec 2023 04:13:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218114222.283705-1-tomas.mudrunka@gmail.com> <c22997c9-6d99-4e1f-9015-b7f80be2a720@kernel.org>
In-Reply-To: <c22997c9-6d99-4e1f-9015-b7f80be2a720@kernel.org>
From: =?UTF-8?B?VG9tw6HFoSBNdWRydcWIa2E=?= <tomas.mudrunka@gmail.com>
Date: Mon, 18 Dec 2023 13:13:34 +0100
Message-ID: <CAH2-hcJe40e7LhrmQb5XjGpRfrUEp3RukqWUqn1p8UQSNkpisg@mail.gmail.com>
Subject: Re: [PATCH] /proc/sysrq-trigger can now pause processing for one second
Cc: Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Bah, what's wrong with:
>   echo e > /proc/sysrq-trigger
>   sleep 2
>   echo i > /proc/sysrq-trigger
> ?

Your bash, or even ssh session being killed during the first line, not
getting to the two subsequent lines.

Tomas

