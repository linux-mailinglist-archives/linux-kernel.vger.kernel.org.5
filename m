Return-Path: <linux-kernel+bounces-9207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D44C81C253
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 01:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D1F7B24B0E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D32EB8;
	Fri, 22 Dec 2023 00:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XWnT7kIc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FAAA41
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 00:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4279c2ada00so68221cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 16:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703205009; x=1703809809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sN/XrY+o4OaYu2S+U3ZxKmsQLdlYuluu9gEjN0UAhMc=;
        b=XWnT7kIcaNxln7Bqvns/1kDaQnUozjnLLCNo8Tj3Cf3N+FwsPUchCJNBw9xNnoOB6p
         ngkbSOOQmQouzPfn3cVq1TjG55wUiqmfwK2uGupkSGiIABOtKAX/FfzXt42hY4Xic/8x
         j83yzKZyZFtB0VEmfOFnCmu7ujW0AN7tf86qsjJPSyWJgCwMW+h01E5RtP+9vARtdlJb
         1AzEZ8WHsLt7jEq4V/u9752E8s2Z+ZnNPHZVqY5ZvloYM7u7XdXJUtPalVpu8Lwoy4O0
         Z4KILJz1gvLPlCGPoI4lsMpgCKRnTOQsH7IlvCk1vZTSdyWLWI1Rkg0cz/pBmHCFgfTh
         eCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703205009; x=1703809809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sN/XrY+o4OaYu2S+U3ZxKmsQLdlYuluu9gEjN0UAhMc=;
        b=RTrnbeIjQ4hT7h83s3Q+UV4zV2GEEZ4eptbkY15weEo92/T1fSo50yqFoJtK8jaIBO
         F2PDw/r5p4MbJRAQLcsVKL3Fb3/UL9JWO0f+GCTT0hvjrernOMJsGoH3Qth6MS/AjRrh
         ij1oylnMMptc+P972AwZoVyaKX5qyuWSYoGezgyoCrGk0Chpq9O9Ig2m6xK6FxwQASwv
         UJyBph3XIVNKAEzLN66g4p/dOjKQsnYZIAwUemyRrWi0KKJg2t7BajX3mSjx9eH0fxtW
         I5/hl3DBYRxGBkmd70ONygxHNGoi3CXhqkpnhiSiveDw/K3+pbhfRzCR0KqN66v41R9C
         3zRQ==
X-Gm-Message-State: AOJu0Yw4xwz1mG3nkrdyf05jvVS6YraP9sjlJmf05YGIlohx70e2V/F6
	bRwvfo2Sj2uFKzE9QGQLPyibizPhXMpFqVxAWMwXkLj02FDq
X-Google-Smtp-Source: AGHT+IEGIBokYFm6kfYazkwZAM6fp7OJRMeithDuk3+nUs89ReyI0Rp0uC/AaWNo6Mkymf6M3nx7zYg+xwN9Jj+trSE=
X-Received: by 2002:a05:622a:1899:b0:423:e912:52c5 with SMTP id
 v25-20020a05622a189900b00423e91252c5mr37268qtc.25.1703205008706; Thu, 21 Dec
 2023 16:30:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221-asmgenericvaddr-v1-1-742b170c914e@google.com> <20231221234947.59458-1-sj@kernel.org>
In-Reply-To: <20231221234947.59458-1-sj@kernel.org>
From: Tanzir Hasan <tanzirh@google.com>
Date: Thu, 21 Dec 2023 16:29:57 -0800
Message-ID: <CAE-cH4o85OkMAZ5sH0SiakQi_FqauNYcQ+KhniEd2g5e8kSF1Q@mail.gmail.com>
Subject: Re: [PATCH] mm/damon/vaddr: changed asm-generic/mman-common.h to linux/mman.h
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Nick Desaulniers <nnn@google.com>, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi SeongJae,

On Thu, Dec 21, 2023 at 3:49=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:
>
> Maybe we could add below Fixes: line?  I guess stable@ is intentionally n=
ot
> added and that makes sense, but please let me know if you think different=
ly.
>
> Fixes: 6dea8add4d28 ("mm/damon/vaddr: support DAMON-based Operation Schem=
es")

Yes, that makes sense. Just confirming that I understand, would you like it
to look like this:

Fixes: 6dea8add4d28 ("mm/damon/vaddr: support DAMON-based Operation Schemes=
")
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Tanzir Hasan <tanzirh@google.com>

Best,
Tanzir

