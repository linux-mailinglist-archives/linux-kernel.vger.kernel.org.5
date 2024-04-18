Return-Path: <linux-kernel+bounces-149695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 299FE8A94B0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD058B226A8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44987D091;
	Thu, 18 Apr 2024 08:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YU2vQLJx"
Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F107E110
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 08:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713427949; cv=none; b=rttOKtO1t4hc791GU05KR0a7k2HFsvHYYT8XMapd/oR8yTu4Av/WqZanDKnGs5Nr0hPR9Q0pJDOCph2bYttuhk87nYF1FH7BCrgDB6z6HwqzJbHd7bYG8kS3lr1FtjBFwHvYMu9V/4QvvaqOAp2gtM5YilgsmYDbb1sIdlFy/Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713427949; c=relaxed/simple;
	bh=bY3ju86zcgJmVbLLguEE+K84ZW771J3V7iD06qo5EfU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gR/EuQUyuvySbU1d03QwcxCQKJtXKggBQO6Tji7xMrfE3rEClTJo7QfeM4h2t935rzI3nk+q0oMig2UDgCutT+CAKr055O31synEjOemi36dHaqUKUjw/ovf2fHl+YXOomzKALfU5iTx6rD7z9ercUDPOKqhJ/fadwxUYo6Fn9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YU2vQLJx; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-2d87ba1f5e0so5424221fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 01:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713427945; x=1714032745; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVL4jjrbBC+Bt7Hp+2Jpj3qHtwDFtxoS4Uo7rWQ9gqY=;
        b=YU2vQLJxkNlk8859LOTqv6RtHfukd5V6CA2P/6vVcHC8gyXLiHWns5qJ9AsP18dFjC
         J1JCFCWbrp6UwF46LNfVwdz1Om5cmTyoTdjmfmFBCLoKM6zFaXT8Iwh1JP6MGRvvjA2y
         agsXNAF3IbgSidGkiw04FUbUA/XTqwv8mmZGaOLOTpD09sejdhYF7xQRSPXbq+Ta/1tr
         Wjada401tWdzaF+U2WDyw7tLH6jc8+Xjo7b2yrDAF3dOPa3mCFJFuB2tMqx87/j+O0T/
         Lm10nlYINkAmdoNoBIiGx6fx0Lv2Vpyb8SjmIB7aREocjqFxbg9MWbJNWhCWcZP4gEmi
         iRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713427945; x=1714032745;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVL4jjrbBC+Bt7Hp+2Jpj3qHtwDFtxoS4Uo7rWQ9gqY=;
        b=Wwn/77d/3nY9weoa1+JvmaRtclvlkMxAZJOHowDXI4mbkHpECNx5lG/yQTR8KkL1V+
         vNdlQNXGV3HfN5BxgsAdPiOCI4McGBoqxGaUE7uapaLbUKhvzPDl5aO7wk2lyQCl0lhZ
         77VsqN3v5ic4XB6YO0J9XFm1aabX04ywvK6l5EQy96vm0sKp3RKXLIbQ3GkkqUWJ7E8N
         Mo3wQaFRk+Dwr/OmX9qwP9hACaBBrW8LXz+h+843ezpYe7U9TaxsOxSqWMrC8unxE0HU
         0hIUCkVhF2IaNfcnLcTcQZz5d7QawEKtIEy+Q0CHI2GnJgXLGi59aHdH87nPclTxO6PF
         ubpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNk5BKVkHXnLXU9TTdjxMYh3kxPAfd7XuyuB6ekzAomFH6iHQx2jvtOLbDXheN8iYAGwlVyr2z2RvPXaL/SDtUWMMoVJiTsAFAk09E
X-Gm-Message-State: AOJu0Ywn0oVv0QfI/1cFECq2Tssf0WV+nK78+tnP/FNpVc85FJ/BrIm9
	C9NotGezDDqg7mH6aECkLNaB2SGsSf2Tsb5zRUW1Y24kjf+nC69HZRBZfr0sJPR1ThuwIeRzzU2
	RJ63f31AV8X21QA==
X-Google-Smtp-Source: AGHT+IF/hmTW9nqgxlg/zyJ3kU0+wGR6ekMhCkaLc9VX4d7u1YMtJpMUGZ8cByZHS1Khb85Rg+27Y8FE0NRCirs=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:9a15:0:b0:2da:7932:4357 with SMTP id
 cy21-20020a2e9a15000000b002da79324357mr2153ljb.1.1713427945324; Thu, 18 Apr
 2024 01:12:25 -0700 (PDT)
Date: Thu, 18 Apr 2024 08:12:22 +0000
In-Reply-To: <20240417191418.1341988-3-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240417191418.1341988-3-cmllamas@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240418081222.3871629-1-aliceryhl@google.com>
Subject: Re: [PATCH 2/4] binder: migrate ioctl to new PF_SPAM_DETECTION
From: Alice Ryhl <aliceryhl@google.com>
To: cmllamas@google.com
Cc: aliceryhl@google.com, arve@android.com, brauner@kernel.org, 
	gregkh@linuxfoundation.org, joel@joelfernandes.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, maco@android.com, surenb@google.com, 
	tkjos@android.com
Content-Type: text/plain; charset="utf-8"

Carlos Llamas <cmllamas@google.com> writes:
> @@ -5553,7 +5553,8 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  			goto err;
>  		}
>  		binder_inner_proc_lock(proc);
> -		proc->oneway_spam_detection_enabled = (bool)enable;
> +		proc->flags &= ~PF_SPAM_DETECTION;
> +		proc->flags |= enable & PF_SPAM_DETECTION;

The bitwise and in `enable & PF_SPAM_DETECTION` only works because
PF_SPAM_DETECTION happens to be equal to 1. This seems pretty fragile to
me. Would you be willing to do this instead?

proc->flags &= ~PF_SPAM_DETECTION;
if (enable)
	proc->flags |= PF_SPAM_DETECTION;


Carlos Llamas <cmllamas@google.com> writes:
> -			if (proc->oneway_spam_detection_enabled &&
> -				   w->type == BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT)
> +			if (proc->flags & PF_SPAM_DETECTION &&
> +			    w->type == BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT)

Maybe I am just not sufficiently familiar with C, but I had to look up
the operator precedence rules for this one. Could we add parenthesises
around `proc->flags & PF_SPAM_DETECTION`? Or even define a macro for it?

Alice

