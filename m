Return-Path: <linux-kernel+bounces-109893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C73885770
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66C32838B1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5EB56763;
	Thu, 21 Mar 2024 10:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J8mTdNpT"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A153F273FE
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 10:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711016927; cv=none; b=LjxdKxgaDYk3XXv+xhjR4bpyXER3M2PHDGWCSxEdBBtl9woYnih5WiBcYeUdNb1rIIUF7r1AyYJmZsMCrWiTZ8KtJdfra+D6XZ5ZO64uEVjC1U18zcBPq/T90N6mYKAsIDv8c+peAtfqwFMpOhw6kUfr7c3ioDxg8EdT9Kcv7Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711016927; c=relaxed/simple;
	bh=sBumMZut2B1H9SXaoSyAfz8Dv0/kDq0UpwwUBEyPe0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ek+0hyVvqWwBWoaautg+x6ZLF7n8nKbgfQmVMGx0q5KIOFH0MXeZuoYs9fta+fGowPNLMdFebHPickRwCEBbq9vC/g5usjEw1WPaRse4j//pbRtwSIUaTeOp7Rb2PdzGgzYz1lK9l2YO+AycWOtNeSERW15YZINPPild+icF7Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J8mTdNpT; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcc7cdb3a98so725263276.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 03:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711016924; x=1711621724; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AKR4ns3MqNzj8KEDAsBBcau/lp94Er5oC4NBIHHopRs=;
        b=J8mTdNpTmNmgmLAbJhotmM/l9hg2Vxglq65OpP7TMZUM9Y7n3jVDwANjpqI+tcbN60
         XwCtEOb6aB4YACKbQe3J7FO5aCKkNpn3AAUNfCDXJuMXQ2D6ATRRW8k0YudUFZ2qtyDK
         rpwP+AAn80+AD6JxVCKSE9gee8YMH8G/kUJa6OduvuO9LkdYW2U/HFa+ThgSX/2+mh95
         vExkj+yu2DV6kAYlAUKjSQNhlzLiwr6W2qDqwIbKSPFDfGWIHYIYu4xWZiPkkQzkHtuX
         7AMrVKIs6+TH3KLd79nv79mDZV4ekVKrCn0Q5uVuaG3u68zE5dZaN2pUJOW8UoW4HZYk
         ga4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711016924; x=1711621724;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AKR4ns3MqNzj8KEDAsBBcau/lp94Er5oC4NBIHHopRs=;
        b=ujvIY8NxJgNwkjmzDZaYVy6ios0nUUbeCXaA+ndOGLZp3wsWlE+qnpEmp/jiKtYMYT
         Gom0LddOI28hqczgtm8JDZNb9ccRB8SrpAH7CubfaMPzHw5t9dOlzlYAlGfFUn7RVzdw
         RcT9wl+kMGLCBUHxxbaw4sk+Uw6wuWuGP5m7CFiBun0SXB1QLykDhdr7jbT+PcjD6vac
         uTiH2nxpSUehHvH9lP4pHh/ltLyickNH9c7NL1ynelLz1Mp/tLdtx55lrzwRio420Fw7
         aVDW1vSvu9qCkFA3EZF4wiRQ/g7jXXpjk3VEmkBDbY3p/SIjNdgzLYUIiw04h6IRD9xS
         X6Wg==
X-Forwarded-Encrypted: i=1; AJvYcCXXuAnmwQUVYqpzaVyzLoUqP0n9BUWsXHlEC7RSRX9LY883mCz9xaWzSVpMnHqsMVYhgksNXYLmU75hFFYnlbCJXF3paS6tdVcFgRxV
X-Gm-Message-State: AOJu0YyvZO7dl+bFIANVIDUnQTMEfU7rr4tSnR8D0SIOiVBsu/WCvbKq
	mUVahXRFv+0fv/tHf+zDa6nRbgxZ98WLYBl08kKFc3oFP9rWmYmDF+PbxMJfwkjDW5oi8/X2CFV
	Y8GiuJZor5E4GSTekvqnQagn8kbuPkCNZnHESDg==
X-Google-Smtp-Source: AGHT+IETG/rfT4UCPwIL6SU4sfhZXcsh/0wacPA3Q09Ay/MZih0yDzYnOhnGRPnhcgYWqmzQjimC/j+kn1f7J6rQhK4=
X-Received: by 2002:a25:7483:0:b0:dc2:48af:bf17 with SMTP id
 p125-20020a257483000000b00dc248afbf17mr19150907ybc.62.1711016924700; Thu, 21
 Mar 2024 03:28:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321-alpha-pll-kerneldoc-v1-1-0d76926b72c3@gmail.com>
In-Reply-To: <20240321-alpha-pll-kerneldoc-v1-1-0d76926b72c3@gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 21 Mar 2024 12:28:33 +0200
Message-ID: <CAA8EJpojZonVnOLdmrVU2NQzJ4G0KOjVvJ2f4yCQ5Zhs1yu4UQ@mail.gmail.com>
Subject: Re: [PATCH] clk: qcom: clk-alpha-pll: fix kerneldoc of struct clk_alpha_pll
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Mar 2024 at 10:59, Gabor Juhos <j4g8y7@gmail.com> wrote:
>
> Add missing descriptions of the 'num_vco' and 'flags' members to
> clk_alpha_pll structure's documentation. Also reorder the member
> description entries to match the order of the declarations.
>
> Eliminates the following warnings:
>   drivers/clk/qcom/clk-alpha-pll.h:72: info: Scanning doc for struct clk_alpha_pll
>   drivers/clk/qcom/clk-alpha-pll.h:91: warning: Function parameter or struct member 'num_vco' not described in 'clk_alpha_pll'
>   drivers/clk/qcom/clk-alpha-pll.h:91: warning: Function parameter or struct member 'flags' not described in 'clk_alpha_pll'
>
> No functional changes.
>
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
> Based on v6.8.
> ---
>  drivers/clk/qcom/clk-alpha-pll.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

