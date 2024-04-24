Return-Path: <linux-kernel+bounces-156943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 351F18B0AAB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FE6AB22A66
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E7615B977;
	Wed, 24 Apr 2024 13:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XHCuy3KY"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BA815B561
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713964751; cv=none; b=OH3tMRFpmCoIpHC2B3SRMjsI3UY0ojYcDXn/8EilMTcElISbm6eSAUWZ84rB2cxU0t2jYPPR6N1fT3Yg6joHmfSR2t7Ngn1C6YS898zOT4ld93AU//1dsQBwG6VnENGWBwD1AI7rT92O8lAmG31sqgXCdYFFw5FLF1EW4ReOkX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713964751; c=relaxed/simple;
	bh=ZtIbeYyi0OmMU+AkQPw6JSmB4tNWWwldPoSlN6WAmOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h4QJSuWBkIu6zs/7lmSj6P2zOOauxTalfiEMrKuK56Rp8E35FMyD2X03BupKt/M70ffDX7sWVtq9MHykDTWyYQMdbcOsOFLlhl7VZpiqX+RLAHW9bR0Hr0rzjn6f7VH5ZU9OkC7+TeP7m2NAPWmMvn8iJNLlpkd3mBioo761oPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XHCuy3KY; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dcc71031680so6409709276.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713964748; x=1714569548; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZtIbeYyi0OmMU+AkQPw6JSmB4tNWWwldPoSlN6WAmOI=;
        b=XHCuy3KYvxu87WoMrzjYcjkhc74rAORwdFQ6ZMD2J+wm+lhNvxvKSD1GCTXx39WryT
         oWiizPcNysL2hr3XkRYYSokmDRdI0U2mfBpmZYeeDXWJtNNslk2Lmgn/4Cva8073OC7R
         /FY4qDAokN8JqacrdXxigZdv1r9t8XVEHO3sYkDo3eQiKBTrrSRSAZZ1UTlx9IeSUIeX
         ZUXsnAhN2akzT5LF3ouJb3Rq4KK9sK+MZ4Bn9SRg+LYjlTUgHZcvoDxzTiyfJ5WyDyY1
         a87Ki0lieBiSwqWtijKTQiLQMpXyqpqLXL29fh+TYEIVQP4686TO9QhGC9hqlQV8dQhx
         4a1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713964748; x=1714569548;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZtIbeYyi0OmMU+AkQPw6JSmB4tNWWwldPoSlN6WAmOI=;
        b=jrDSwS0T8ErC5hFTydfHcMjSSw6vBwo8eClsxuZ/X0ashxznkiRScoZ9SgOAuHVjj9
         0E5CSF+tANXr62yHfANa8OeOhJvgqEC8OqSBX73w20ovQlZLSyJN5MFPQBi6RJjUhXeJ
         d5HUxT/Lcnjws1FV+SemykylMvQhEJ0JKTbEZShozL2ePWO8y6iBUNtwjdW/dG1qn10a
         5wN8jPbjpYc2McPz1339r4juoBQAbgg3TgM8Ti7rCruMKodhBS3/5xhIuvT2uZz6F2Wm
         I6xTFtfIQJgyhiBU8BXw3E54BfQJW078z3WeIy69HHEAi3zsgByp7OEpucMPwYQcj1qZ
         6j4A==
X-Forwarded-Encrypted: i=1; AJvYcCUgarvhg+LTsPZPHqw4aV4NdNcmKShRw6bRqXYBHKV6jeaRCq1Ojln99y4la/kEi9JeupON0IjtWPqYwnzulBs/B75RnIgs29sPcLpP
X-Gm-Message-State: AOJu0YyGS8Im7KnNPusCp7buwGDi5vSdkWz8XBspjqU1jjr4iIQ4YLuy
	mTNSJP750cT1DCWe/OeHSPvI8lxKHrlhep9yrLyio6oR5TZ/m3quxeo0EzwP/W7uANTmE6fJ+DS
	MEMl0poAr6jdvqe1iP9B6ji0h+7Sdi87W9yR1fw==
X-Google-Smtp-Source: AGHT+IGWxg7YpP/AXugHPkwzaw5BeM12hpdBMcNOlY6L4gYSvrWbhTAMlLpFe4wfQwN3T31LeiVie/izT+xuY+/yXQU=
X-Received: by 2002:a25:d354:0:b0:de4:27f:e335 with SMTP id
 e81-20020a25d354000000b00de4027fe335mr2481953ybf.64.1713964748546; Wed, 24
 Apr 2024 06:19:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424122932.79120-1-brgl@bgdev.pl> <ba9b0e6e-3601-4460-ab5c-a02eb7708a4f@penguintechs.org>
In-Reply-To: <ba9b0e6e-3601-4460-ab5c-a02eb7708a4f@penguintechs.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Wed, 24 Apr 2024 15:18:57 +0200
Message-ID: <CACMJSesZqCG=fdWe5C31a0iOFJ-ZpPRr70T_1TNLn7xqChZ4Sg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: qca: set power_ctrl_enabled on NULL
 returned by gpiod_get_optional()
To: Wren Turkal <wt@penguintechs.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zijun Hu <quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Apr 2024 at 15:10, Wren Turkal <wt@penguintechs.org> wrote:
>
> On 4/24/24 5:29 AM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski<bartosz.golaszewski@linaro.org>
> >
> > Any return value from gpiod_get_optional() other than a pointer to a
> > GPIO descriptor or a NULL-pointer is an error and the driver should
> > abort probing. That being said: commit 56d074d26c58 ("Bluetooth: hci_qca:
> > don't use IS_ERR_OR_NULL() with gpiod_get_optional()") no longer sets
> > power_ctrl_enabled on NULL-pointer returned by
> > devm_gpiod_get_optional(). Restore this behavior but bail-out on errors.
> > While at it: also bail-out on error returned when trying to get the
> > "swctrl" GPIO.
> >
> > Reported-by: Wren Turkal<wt@penguintechs.org>
> > Reported-by: Zijun Hu<quic_zijuhu@quicinc.com>
> > Closes:https://lore.kernel.org/linux-bluetooth/1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com/
> > Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
> > Reviewed-by: Krzysztof Kozlowski<krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Bartosz Golaszewski<bartosz.golaszewski@linaro.org>
>
> Tested-by: "Wren Turkal" <wt@penguintechs.org>
>
>
> Like this?

Yes, awesome, thanks.

This is how reviewing works too in the kernel, look at what Krzysztof
did under v1, he just wrote:

Reviewed-by: Krzysztof Kozlowski<krzysztof.kozlowski@linaro.org>

And mailing list tools will pick it up.

Bartosz

