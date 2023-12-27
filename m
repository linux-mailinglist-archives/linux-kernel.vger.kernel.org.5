Return-Path: <linux-kernel+bounces-12194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6F981F127
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 19:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BD871C219F2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 18:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513854655E;
	Wed, 27 Dec 2023 18:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YoW928nG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DFA47766
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 18:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5d05ff42db0so45857967b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 10:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703701285; x=1704306085; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QUb3T9LCTor3OtZr4aU2okT2EQhxWP10qbYK/muZCTM=;
        b=YoW928nGexnkinoiQNjZQQ7BLQdDgSH1qnUnslTiSjUc8RyZk0/iblcS0Bb+WBIQG6
         2WUHPA6fKdl6hUUwt+1O0/lqXU9ZJTWmrWE1OxTsz6NyojPupLCfN2DuH38xQzQh63Im
         BJ/WDeCHZpVxMRIwpDXjiUzZnZBdKqK7cy09o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703701285; x=1704306085;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QUb3T9LCTor3OtZr4aU2okT2EQhxWP10qbYK/muZCTM=;
        b=YjoIvsyf0jV/qxdfSZcIVw3Jf0O9nOZ7CHYU8wztA98t/J571t05tEdJ41L9oIChoy
         Msl59H5LiTyhI58/uCbaXe46Auy78BmMl2nWi+O8r3LCaKuasfZSDp8EK2lBSSSh3MsJ
         CwjPKEkJP1pggcfR1F7HpCs5BHOTKWTbFdtEqfJIqrAgVPOUVHY7qyAdaHqEcYcRcktz
         oZNEusWnh2S1e+O/nJO1oyIC482hVczz7PwhEgG5uJ6KErAyj0387g7sRM9J1MnK79ON
         KcjNJsEnKowxmySdClsCqDJkVXPAetocYfVuSXjXmTntvD3VRQ/bihAMLNPsi+IiHrl+
         flCA==
X-Gm-Message-State: AOJu0YzDDHXKpQ4dfYaebO0zQ2/zc00zW5sntsD/VOz4yxDnQcGFIq8e
	Y3s3lNZQ4PDUpp3WSO+y7MbtOnTVXIfZNHN/sx2OQaiAwLPHZqpQ3HyZyWabeQ==
X-Google-Smtp-Source: AGHT+IG/QBYCKbbNKz4z1Pk4mO+bOm+M4u117qwAKbKOjd/deSesO3ksE77YRBwrfFhwqZumGERveuiVY5yBVM3xM4s=
X-Received: by 2002:a81:5385:0:b0:5e8:cff8:6f2e with SMTP id
 h127-20020a815385000000b005e8cff86f2emr5485099ywb.81.1703701285363; Wed, 27
 Dec 2023 10:21:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226192149.1830592-1-markhas@chromium.org>
 <20231226122113.v3.18.I29b26a7f3b80fac0a618707446a10b6cc974fdaf@changeid> <ZYxcvSLL8yWW-URu@smile.fi.intel.com>
In-Reply-To: <ZYxcvSLL8yWW-URu@smile.fi.intel.com>
From: Mark Hasemeyer <markhas@chromium.org>
Date: Wed, 27 Dec 2023 11:21:14 -0700
Message-ID: <CANg-bXCrR2FKSi6ik7LZBqTQz9=HDW=0cy7GZN0yaB0PsKKjkQ@mail.gmail.com>
Subject: Re: [PATCH v3 18/24] of: irq: add wake capable bit to of_irq_resource()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring <robh@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, 
	Raul Rangel <rrangel@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> > +             u32 irq_flags;
> >               const char *name = NULL;
>
> Don't know if OF style requires reversed xmas tree order. If so, this should be
>
>                 const char *name = NULL;
>                 u32 irq_flags;
>

I see both methods used. For example, of_irq_init() uses normal xmas
tree order. I'll leave it unless Rob says otherwise.
It is Christmas time, so I do want to honor the Christmas trees appropriately!

