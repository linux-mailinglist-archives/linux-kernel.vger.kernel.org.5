Return-Path: <linux-kernel+bounces-23068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A75F982A72B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 06:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA93A1C23363
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 05:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D3E1FB0;
	Thu, 11 Jan 2024 05:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bcs58dBG"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E1C17F1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 05:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2a17f3217aso547366166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 21:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704949754; x=1705554554; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9MKrB6z6h6FCL7Pjwb6W+0zbLJ1lLA75vK6XbRw6+sM=;
        b=Bcs58dBGPuyHFbj/C8CGutI/YZmAVibVBC+ftbwMeum42qy1n76rQUZg/j+1dLhQlV
         JQe4JXKVCR+zqAOvWDH6m5d9kYVlsSoqBVk9HzfMVYC1Px49VUpmIyhJHAzaKA+8TYPL
         Vx5YkegOrxbFqJuYdvO6FlUmlLCR3GuwHq5HWNWXV2Akm3GcHyoAyN2F5DYLFAXLwo3r
         hBKpvwC5IatNpem40XeTSR1NNNiEqVO81E7ZKERD0VjvwTWJMOIA4OIKP4bl9a7jIK9D
         EGoZ9n9q31KoopED/tFlc+PObGn3QIcflAZvoF5oQDwjUKVeVBhe7X+ITNN/1wmxgszs
         iDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704949754; x=1705554554;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9MKrB6z6h6FCL7Pjwb6W+0zbLJ1lLA75vK6XbRw6+sM=;
        b=W/fIx19dExkBA8gDOORaayaLfaT4hdLU5uZe5AczZS4kjy0SrRiiTG5QUhjX55trfZ
         NkB/5g6sowh6/94pXOUunuZ2z9AmDFjVbeOa9aSmxkKduOFDsHxCtoP6PYREktrRLrGc
         5RAZr/ijVkvyE4K5sawCrDm8YEsU0EpBxANDCTSKnUg4GTmc4FVWZCypwGhpLr5BMORY
         36opfUcf+ECgn/Uva6W7+d0H9Av2eBSBnb++uXFoZG2ciK/0/ysPu5INSVjVaa37onOF
         9QknUZdKecwvH6J0WBhmpHYs09cFDvp4z6C/vpuk02QZPm+RL8oQXAmzWsiDSwV7CnzA
         JBUQ==
X-Gm-Message-State: AOJu0YzZOvcbjwDZ6Nj/3wkkFIUCiuo9MNk+mQsNeqSXkruqQ9UH2YOH
	+plCsd8RSxfp2Koyq2qRrwDV1DhI7zp+xDpq4Fo=
X-Google-Smtp-Source: AGHT+IG2NI/guH0/C72gEVL6DAU5yYa/NpqFiWeVvNPFaDK8jbBVLGZKhkeaKmTGpqjEkryfBjUQTCU0kA85arH3b6k=
X-Received: by 2002:a17:906:241b:b0:a22:e690:f09f with SMTP id
 z27-20020a170906241b00b00a22e690f09fmr280341eja.143.1704949754221; Wed, 10
 Jan 2024 21:09:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
 <3465e0c6-f5b2-4c42-95eb-29361481f805@zytor.com> <de221edb-6d12-4bef-97a7-4ab4c2381bfc@nvidia.com>
In-Reply-To: <de221edb-6d12-4bef-97a7-4ab4c2381bfc@nvidia.com>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 11 Jan 2024 15:09:02 +1000
Message-ID: <CAPM=9tzNEbJxVtusYLQqvzo14-CW_Nbo65L7Jfb4dF_JM1PBTQ@mail.gmail.com>
Subject: Re: [PATCH 00/45] C++: Convert the kernel to C++
To: John Hubbard <jhubbard@nvidia.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org, 
	pinskia@gmail.com
Content-Type: text/plain; charset="UTF-8"

> There was an effort to address this, and I remember we even tried to use
> it: Embedded C++ [2]. This is very simplistic and completely out of date
> compared to what is being considered here, but it does show that many
> others have had the same reaction: the language is so large that it
> wants to be constrained. We actually wrote to Bjarne Stroustrup around
> that time and asked about both embedded C++ and coding standards, and
> his reaction was, "don't limit the language, just use education instead".
>
> However, in my experience since then, that fails, and you need at least
> coding standards. Because people will use *everything* they have available,
> unless they can't. :)

You don't just need coding standards, you need a compiler that refuses
to compile that stuff.

If you want C++ to do what Rust could do, then you need the compiler
to stop the stupid before you can even write it, otherwise people will
still write the bad stuff and code review won't catch it all.

Can we get memory safety with C++ now? and also stop people coding C++
like it's 1994?

Kernel C has kinda become a thing without enforcing it, but C wasn't
really stopping anything bad, so having C that isn't quite kernel C
get into corners isn't that bad, but introducing C++ without any
history of kernel C++ is just asking for everyone to do their own
special things and defend their usage of every corner of the language
because they wanted to learn it.

Dave.

