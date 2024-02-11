Return-Path: <linux-kernel+bounces-60856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A6D850A30
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 17:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 219CF1C21E18
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FEF5C5E6;
	Sun, 11 Feb 2024 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="kd86+i6P"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C090B2AE74;
	Sun, 11 Feb 2024 16:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707667321; cv=none; b=nYsiogJvSdZ46USkK6ZVMdc3BNWx/5ExRxIpIKOUV9TMW1pw9M1n65NgP97tBP8o+eUvT5MtpEL1hs1Mu6DVeHVSoIiypsuyAzmVkvDcRYKSYMFiBIB4UWtHV+eyyCkI8fYBysbhASp0rUci+j/XO7Yn84NuHx3rZLzrMlawT6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707667321; c=relaxed/simple;
	bh=iC+JbRILc1eLrWSfxvm521SmQ6znWeU6jUzyc+yCpCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmjNJlrn4TBY8LRWXe8kvQSrJJpWn79T5N8Vl6eg7AjbpmTZ5G7PJ5wjyzMZecIFI6k3vyayNV34gop1ryLIHSOBMOmTQUWNanpYOtgo7G61ijqFuOWp5o6PI03nh2cf5F6w3SJQeJZw7wo9qzZy6r/7o3dZo5Lb1uftnrKCWxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=kd86+i6P; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d91397bd22so18614095ad.0;
        Sun, 11 Feb 2024 08:01:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707667319; x=1708272119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=enTZ7yPBGcyh9V3V7UZj+oDbi/s8GRugq5pckUIXny8=;
        b=Lsi2n8fUYSycq35aGCiYgG3oetK2eBoKZQsWl5GCsggl+GvhTG5F95p6/uNnP0joLt
         +ch3u2qZKLjiF8eRImimey6q1GkJXcX9IjvFUD/8UKXkz+nJkT/max8Ef+s5BY/4EQgm
         JJK/QoPGs21vNpa9gGihJhpuL/PMh9CXMm1y0cJ4lGNjifdn+EdDJKFSmcbZgJlr1IOu
         tfNZ2e6n2sEBhuTfpISpSnwkB+aDq7H+f74rYn7TGubFNdgpOtJFyG8JsNrwTXr1B2cN
         Vm7hETHx+TQ7e1yuibQf/Fs/rIdyGcz5GNUuu+IFj2pQoJUf8KM9UaerooMj9XHHhY/R
         rPng==
X-Gm-Message-State: AOJu0YzQJM/biJEBb6Kwvq4/hACAKS/seZEQ2GP/tC1A5FzxB8+kbOh1
	8BEia+oFJNowbdx82k7qEsS3FCZwpb1EB2zTlUCj90nuDfYby5Rd5jhi2vlMUMIPVg==
X-Google-Smtp-Source: AGHT+IGV6aw/103BpNKJyhhVIc2nslgu+kV7vfCuKhF1hSUzTLM7MV8eSROCrqi5pl6aV7pDmBVKIw==
X-Received: by 2002:a17:902:b906:b0:1da:1e83:b961 with SMTP id bf6-20020a170902b90600b001da1e83b961mr3286505plb.63.1707667319031;
        Sun, 11 Feb 2024 08:01:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX5AlRHgfc4qix+2oX3sHxdq09tV/fuUxgBjPdxnMGHBzofdopUGDqP7OtWc1y072phEhcCpPSF3p/b0/sJ1eAJ0vbSxpJSdTDAqj0P9Yk7zE26V6Q+TOySsExAu8Z7k4XGmcTBUS5ye8SnXURL0mCVpE3HoZ2FBMGKf7bPRzXkN3dqBmWNNPwRFTwAjqr9aeNxODTVEBbF4f+SGqyLKx1zQd3XjkNxhViIfzAGgVqf3WdAvmt5w49FHstkkBz0hwILQ0/dDbrCseLKCxyc7re/iZ5WsuyC52UbUrS2xw==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id o3-20020a170902d4c300b001d987771271sm4418503plg.123.2024.02.11.08.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 08:01:58 -0800 (PST)
Date: Sun, 11 Feb 2024 13:02:34 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707667316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=enTZ7yPBGcyh9V3V7UZj+oDbi/s8GRugq5pckUIXny8=;
	b=kd86+i6P8fyNFqDFvEkSzF819/p9sP+e3B2DuIHzeK1gERxnVQkkmEfwsMKwQENXP9bsmq
	j5YJsZbTlxFZrVBqmkAzYee1wBM/1e6lQsaBT4RKIlnkgmjM8EmOzSd5WAIvumiHtgwJ7M
	ymILgOfYS7S58PCOiKlK31QvzFyTN0tv4CZ1lzX9J4AtaZ2ftR5DJMWFLsxeLOzxCLGJnC
	qVdVlOdynVLIr/eScILSwrajjmG9RzgLaUuUfALJRLZ0SJXXGtdSSkyDzi1JqzqtEcc2W9
	16JbLGaKcXwzf++nOepIEskVeCnKS2WjbQ5eRWhCAIgf17ImTLQJAReLlpiF4A==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Shresth Prasad <shresthprasad7@gmail.com>
Cc: gregkh@linuxfoundation.org, corbet@lwn.net, linux-doc@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	skhan@linuxfoundation.org
Subject: Re: [PATCH] Fix malformed table error in gadget-testing.rst
Message-ID: <qhnapkrcmqvpagzii46be362iyaelcbodo6vh7v3sem3ww5kpl@nw65w7gbyjij>
References: <2024021159-banner-dramatic-af88@gregkh>
 <74d67b62-6fa4-4218-b51f-f0d33f19c422@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74d67b62-6fa4-4218-b51f-f0d33f19c422@gmail.com>

Hi Shresth,

On 11 Feb 18:24, Shresth Prasad wrote:
> I see, sorry about that. I will try some other way to fix the error.
> 
> Also, as mentioned in this thread: https://lore.kernel.org/all/877cjqa5le.fsf@meer.lwn.net/ has the patch already been applied, fixing the issue?

Yes, that seems to be the case. In the future, make sure to split your
patches into individual "logical" changes. In this case you would have
one patch to fix the warnings and another to change tabs to space (even
though this should not be done, as you know now).

Refer to https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Best regards,
-	Ricardo.



> 
> Regards,
> Shresth
> 

