Return-Path: <linux-kernel+bounces-95311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08323874C0F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B51CC283D21
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E342385274;
	Thu,  7 Mar 2024 10:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IiG00BKT"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98F484FAB
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 10:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709806395; cv=none; b=VMMHVqh+kv6yFaH2+mu1+TwK80zY3gaR9UaJtqSuyerSZ1OdKdKwQfmLwNrvnNNJVrJNGgBpCh6yGQjQOKS+fWOGPmZ/4N5rHX2VmXT2mvhBpeJ6tWW4cmql2BIKVfZJJ+aaUzzHq02w14n3M2ZvO2VloTkXpQZ77wmXt7cfbp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709806395; c=relaxed/simple;
	bh=8YdxXpNkuEwyV5gctfJURbHnkvOwyYECpGB8fspck6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EnsybNqstF7tZQNpPFMBu3uM94AZbumzyIxgTxXVuegjbjY3EYovxDokbGkO9bhBpBdidVHdNC4eqg4pXRSEqaulBDIfxP5Ay5ZXwqS9Fmk+6MZljqy3JUJBlAYtIGhRZVrMpU1s0VHuU30ybx+FxCVmu7j1H4OmQU6MsZIV/Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IiG00BKT; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6099703e530so6532817b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 02:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709806392; x=1710411192; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o7aOhcZHxTQGvbokl+x//A8IHaimRa07w+fuZLXjuzg=;
        b=IiG00BKTYqdKru/iPp/SEnlrGj3mAHvBtm+4xOpcTNacs0ZpT3J3djiAIOkZFWyETu
         DatCWojm13AuDqOmMhpN8KPnVHe73PYpsjrHfAXkHbdSgbp1Uv05r93VtZDIzc7kIHdZ
         BNJwkny43tMlNHxFz4Hl9Sqh7ni/1TjpVBS1Bs6VeNyVO0GGc7MPHmjnMmYCAXOFQ0Fj
         r9CfRzekTLXOg2yaz1KExr4Cz7j7tDDgMwPI4dH7k75BpZRBZUolLkyNl13U5lPYvQKo
         C1Cwhze+mqwI2BKwA6ViLbmlXIwCaGAx6/9S4p4Y1C4P0TF0WcHFIrYO6W17SE84ja7P
         7LCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709806392; x=1710411192;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7aOhcZHxTQGvbokl+x//A8IHaimRa07w+fuZLXjuzg=;
        b=e3U/GKvST6nyvf1D/zGu0KStjVGzelSp4T1yiS2hHCoG4mOJgxvul/diFrsRMMkT/A
         d9zKUUS5+POQwuGv8SG7klek27C+S/hy2pIYWonWw+EH3biIR1F7h9dWTaME6fWowciP
         2NXm3a1zOelxGu28yI9Pd4x6jUJ07dP7iw/oGKTl2g6Xjzba5TqBaKKPI7lCg3UWwya9
         OyotN4BYfoty2rqWHJkX8sgr6N4JeDe+WHNv51jgq2knV0CN+CMHeHGDZglp2ERy51pI
         McjTuHYVOFKMpfMFTWrwp/anr1akUoKUbkYjPw7DqD2u/xUUTLNRzDSz/AdCBDWHsZl3
         DKyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzYC+vlFXvzGjTTiX6h6a9zsGRCKHkLsIYXNzJbkrMD93iYiq2IH3FftV0lj1QEEUx71MtoAs72Bf3bpsDkJ8zwuG/1VIPnw2xR+L3
X-Gm-Message-State: AOJu0YxqJupD5+GyAEAoI/6+gGRZm164sZRbrGmwJad69PK4Q8KA4+oV
	u9KocmRp77219sRUaJsOZpZHksJGQZ4SkjUnm8SnPKT7y7EFwklnt/3NlBB7WArI6wQVY46nAbV
	v//Ik50+ubaOnG6sU3EO3xTRNr3Ii5SrLrXPNlOLFj9rg0a/X
X-Google-Smtp-Source: AGHT+IHl5CeapJNGYmG4jcbrf0/CGta/u9Vx0DjHeSECpyJ/76TzCk8HkHkekirsWc2ykxiPbxF/R8BtaCyvIzxPrNg=
X-Received: by 2002:a25:3009:0:b0:dc6:ff32:aae2 with SMTP id
 w9-20020a253009000000b00dc6ff32aae2mr12290559ybw.63.1709806392540; Thu, 07
 Mar 2024 02:13:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA8EJpp++=NLZVv7we3Cwz+G7vL9xFoXqHgsMyQZ8tgdNHKcyQ@mail.gmail.com>
 <20240307100221.709254-1-amadeus@jmu.edu.cn>
In-Reply-To: <20240307100221.709254-1-amadeus@jmu.edu.cn>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 7 Mar 2024 12:13:01 +0200
Message-ID: <CAA8EJprgWiOyAk5rpaobsXET+yE1g=snaRqcW33hXDuu7DPcoQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] arm64: dts: qcom: ipq6018: add 1.2GHz CPU Frequency
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: andersson@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 12:02, Chukun Pan <amadeus@jmu.edu.cn> wrote:
>
> Hi, Dmitry
> > So... Do you consider this SoC to be IPQ6018 or IPQ6000?
>
> According to the chip silk screen, this is ipq6000. In addition, I have
> never seen a board with the SoC chip silk screen printed as ipq6018.

Hmm, then what kind of chips do you consider to be ipq6018 if you
haven't seen it on a silkscreen?

>
> > And anyway, this should be explained in the commit message. Otherwise
> > anybody reading the commit will have the same questions as I do.
>
> Sorry, I will explain this in more detail.
>
> Thanks,
> Chukun
>
> --
> 2.25.1
>


-- 
With best wishes
Dmitry

