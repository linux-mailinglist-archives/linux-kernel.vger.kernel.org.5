Return-Path: <linux-kernel+bounces-21410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 325C5828EC5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58BDE1C23F3A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BDF3DB8A;
	Tue,  9 Jan 2024 21:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g2/dylWK"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF9D3DB80
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 21:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5cdbc7bebecso1315489a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 13:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704834754; x=1705439554; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eqQUHChJf0/arFpvV2IRHuuXQmt67RRG08Y2Ov7HDGI=;
        b=g2/dylWKjTyE1oGAMQ3UWpurCwkJLx/vs8whAdPJgl+gYOMqgYnyB60fkZIZNMtiBi
         p9NmRW8q0egQJlZfx+z3lg2sIFDYElVnyvb/8xiGnITxrDaD4N1Eb7Ejw6wQ3Y4A89j7
         J/P2NQvkQMW2Qm8UulN+vAkZVNBmDpv50hKZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704834754; x=1705439554;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eqQUHChJf0/arFpvV2IRHuuXQmt67RRG08Y2Ov7HDGI=;
        b=q4QmP2bJOoV/TSs9A1OalBVwZBh1JET9PtrEyKyjs3PXPy5cxdU4ft6c5tMXYMM49x
         4d03M72LiaQvawuUYMTWxCLuAHZLl+rBNaK44j8fhHCw1UC0MvJ8mnP9bsF9anEQde+e
         c4Nsb7W6qLD1BVoz03lj7XjL/TKQbHrm9l4KgKmzhNnJ0EaciAsyopprEF0SYv5OizSm
         JEAb9AlQg7/5Qio86qizjagKjG/eY2vL/+GHcTVzr2spbKEd1abx0TljQK1Y0s7Bz4fM
         t8fuwLvq1eEXRqMma1+zqPhIuikYPCtqVuLWkvmJv2M3YBXemMhXXkNIYhdw+AEqxZXT
         pE8g==
X-Gm-Message-State: AOJu0YwwowT2/UBNT5EFQtgxgVA23OFbLUGeLhy7VS8VU7beuBQyDgvf
	ikSxs0u6emWf0wKKA9SO1rO0/J1NJNGc
X-Google-Smtp-Source: AGHT+IF9Df8jD6jo0r8n/3rNIJtxx3CS7IAQquzGY9SJyX43vHRj6T0RnfaCNO4tgaoUC6aOgdhndQ==
X-Received: by 2002:a05:6a21:a58a:b0:199:83e3:dd67 with SMTP id gd10-20020a056a21a58a00b0019983e3dd67mr3000031pzc.40.1704834754458;
        Tue, 09 Jan 2024 13:12:34 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id su6-20020a17090b534600b0028d136ba928sm8245175pjb.28.2024.01.09.13.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 13:12:33 -0800 (PST)
Date: Tue, 9 Jan 2024 13:12:33 -0800
From: Kees Cook <keescook@chromium.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	"Gustavo A . R . Silva" <gustavo@embeddedor.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] Compiler Attributes: counted_by: bump compiler versions
Message-ID: <202401091311.08D6FF677@keescook>
References: <20240109133633.1103876-1-senozhatsky@chromium.org>
 <20240109153249.GA205400@dev-arch.thelio-3990X>
 <CANiq72kjHCh-inyv1aU=eNca1-+E0_85MGU-8qbZZtzbC_VwOQ@mail.gmail.com>
 <20240109195652.GA1253215@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240109195652.GA1253215@dev-arch.thelio-3990X>

On Tue, Jan 09, 2024 at 12:56:52PM -0700, Nathan Chancellor wrote:
> On Tue, Jan 09, 2024 at 08:42:24PM +0100, Miguel Ojeda wrote:
> > On Tue, Jan 9, 2024 at 4:32 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > >
> > > It is still possible in theory for this feature to make clang-18, as the
> > > release/18.x branch is not scheduled to be cut until the fourth Tuesday
> > > in January, which is two weeks from now. I don't have a good feeling for
> > > how close that pull request is to being mergeable though, so this is
> > > fine for now. I assume this won't go to Linus immediately so we would
> > > have time to change it if necessary.
> > 
> > Yeah, I was wondering about the deadline too. If LLVM's `-rc1` is the
> > latest time possible to merge it, we can wait the couple weeks (which
> > are conveniently the merge window) and I apply it afterwards with the
> > result :)
> 
> If I understand the doucmentation at [1] correctly, the first round of
> testing starts with -rc1 and ends with -rc2, so if the feature is not
> merged by -rc2, it won't make that release cycle. I think counted_by
> might be a hard sell even after -rc1 because the feature is not exactly
> small but it is also not expansive (it is relatively self contained
> from what I can tell). So I think your plan is reasonable.
> 
> Another alternative would be to split this patch in to three distinct
> patches, not sure if that would be overkill for this though.
> 
> 1. Update the clang review link from reviews.llvm.org to github.com
> 2. Update the GCC version from 14 to 15.
> 3. Update the Clang version from 18 to 19.
> 
> The first two patches could be picked up immediately and the third one
> could be sat on to see how the review and acceptance process works out
> over the next couple of weeks. Up to you/Sergey. Thanks for taking a
> look!

Yeah, I think either the above split or just wait until the Clang 18
cut, since we've got a while before the next kernel merge window.

-- 
Kees Cook

