Return-Path: <linux-kernel+bounces-30518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44924831FC6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 778DB1C246B3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321A62E41C;
	Thu, 18 Jan 2024 19:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jm8CwJkn"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551ED2E624
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 19:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705606334; cv=none; b=M0UO4mHZ78pkAhWC/56XqOPxX3NhObq3BuG2uJKxn4PpqQgR3UGxR+UxcNpDKDi27ZV+vt8hfVQswcu5xi+egZnKZRiNRc25wF55KXUEzYs2x7yOGSWqNh3uUjTF9JpW39v72iKHzQhD6RCjfbjsBmgiDG2rfu4guodgdxwu89w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705606334; c=relaxed/simple;
	bh=Y8FfsU4oAFfA0PGeoRTocA7rdzQlh4ZD1o7RLLkaJ9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3uxBsRq+Uh4WNOZEF7LEbYFEEGxK2JxZ+TX1jcmp7lVpO7j7LwIf+nHylO9E8k06LJ0PXRF8ZsgJtstcM8gdOwb3JObwDXtSIbs3VkVflKWriX8OxBgCBoRT9gCz2w4neUYJd5lVl2jbCDy1eEkiMEC+FsP8vs+F080BYXqF1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jm8CwJkn; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-290483f8c7bso31396a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705606332; x=1706211132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IlUOG4jxCYw/W/5RZ3kz4OPHzrvcyjQxPYbulIdLMKE=;
        b=jm8CwJknje55t5+uQesqm3VO51Zy7C6oIHbkSOVgIs99FIovYX2mCDcwaTdWSrfyeS
         xC2foMeNRST2RASuSxOZzIefvfiLM/IzCzHRNon2rlup2YrGONzQKCoH3/qU0zibTswT
         Os+152OerDN7HGqhf2v3fYCzAtzqqDoUAgYqgZweQJSvPnWu+yG6RmIjcSPI7eWN3wIC
         8mq8J/Z2xulyi28ep/Z2+0tQ0sAZiC7ZsTAI3Npnz+8jRWtbaEMCOZf8AJdfIAETldGy
         7MmXqHsNxLia89i5ov6VDwo8eO0kPKqGrs7QAV9oJWir6eQtS3xWIvRtKgVgp2Qb1YLk
         9xzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705606332; x=1706211132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlUOG4jxCYw/W/5RZ3kz4OPHzrvcyjQxPYbulIdLMKE=;
        b=wcobu904tCfOsCoGFeZf/VV/klyIwO6mRooaXpQdfa1fQTNuMmnPkAyIBwTBITTfos
         FRYc9IYM7GJvUHf1kFgvgPv/9MmgsdKJtdZtz/7zeGrjSOl1toqhuUTsEcz8dcBJGL5Z
         tQxnutnIs1MDskqgFz0HoR63AHWQ5nA/UZ3Zz3RfFDK6t6/U4UP3pdh06X9T4YyEU/6p
         Bi44yDG2CFlwLlhUA5NP49zbApJDdNqjYQ2NPqfgryW7Tm899B+zcM+FkpDXsm0PDlrc
         XiOu+O/ovhZ3picYv4O8BTNAvxI03Y5Typ0b8WblOJT/nx1PzrU6qajnMyQ8YEHO8eTc
         KNpw==
X-Gm-Message-State: AOJu0Yw5nWOqPiSRpqH9lJQ70TorsbGtxvy+Z7bYnlIJO3aTth/mhvy+
	LUGb86rZVHNhzyo+V+Zc9W2pyCpkgUpS9/XIDavWnfzGarn16sHDwxC0LNgQRw==
X-Google-Smtp-Source: AGHT+IEfUAGXijOXMlnPK9epyhH/u9FL7c8Jh7wca9Jcvw+EUiy3zWGywAluCHcjkjznUWSH4XteaA==
X-Received: by 2002:a17:90b:2285:b0:28d:4fad:21c8 with SMTP id kx5-20020a17090b228500b0028d4fad21c8mr1238664pjb.35.1705606331641;
        Thu, 18 Jan 2024 11:32:11 -0800 (PST)
Received: from google.com (77.62.105.34.bc.googleusercontent.com. [34.105.62.77])
        by smtp.gmail.com with ESMTPSA id gw7-20020a17090b0a4700b0029011eb89a8sm2218691pjb.28.2024.01.18.11.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 11:32:11 -0800 (PST)
Date: Thu, 18 Jan 2024 19:32:08 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Sherry Yang <sherryy@android.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 04/28] binder: fix async space check for 0-sized
 buffers
Message-ID: <Zal8uGqP2lLZz_oz@google.com>
References: <20231201172212.1813387-1-cmllamas@google.com>
 <20231201172212.1813387-5-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201172212.1813387-5-cmllamas@google.com>

On Fri, Dec 01, 2023 at 05:21:33PM +0000, Carlos Llamas wrote:
> Move the padding of 0-sized buffers to an earlier stage to account for
> this round up during the alloc->free_async_space check.
> 
> Fixes: 74310e06be4d ("android: binder: Move buffer out of area shared with user space")
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---

Sorry, I forgot to Cc: stable@vger.kernel.org.

--
Carlos Llamas

