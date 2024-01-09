Return-Path: <linux-kernel+bounces-20217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB19827C12
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 01:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4770BB2240D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 00:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F992912;
	Tue,  9 Jan 2024 00:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RolAEsfj"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ACB28EC
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 00:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e7d6565b5so2532417e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 16:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704760254; x=1705365054; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zO50hugsTP49JzCek/Fz2sz/IjqHzazxTuZOtrr33Cc=;
        b=RolAEsfjHrLajGtxSX+oHtXRIviav4kRImNKeHTQfaZu7MTwJoY96YzsI3mj54pBiq
         eV/sEnlMH3KScPvBAtYnx3inNcS0g/RR78C/ykD2ADTEgnHflcepGC+ZbsOTKg9HxSVB
         KhmL5GtyBBvFXh6EW1tG5FrL+wykRjHU4MXt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704760254; x=1705365054;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zO50hugsTP49JzCek/Fz2sz/IjqHzazxTuZOtrr33Cc=;
        b=B3+fvLjWnO99WnviXSXkiFw6ZQ029Gz1kJE4omJjiU8nJRmbkdSGDg5bwN8qffZ41z
         SGt6lzAKSeCJCQcFemKltdatHGMGpmjBUTZh38nTi3PHTD5X/s3FOTMFuuKzlMody1xb
         hKz565IxvhsLGN/kl+CVaEDLe/VNCrow2nt+nSLXXlEoLqm1baxw8EKtyLvgaw5nIKgX
         NFfTEnstxZfpLkaTX6qGSTEPh5hDTzQmXzJH0iZXrXRaXt/lDvLeGJd+dXuAFvUhqE2V
         jPVYEioZlhLVD+ZK9nfRSKQKblTpLSylYYj1T6RXt3RfO62W4FN17E5gAc9sKbT/G9a1
         CWcw==
X-Gm-Message-State: AOJu0YxmpDNwkMw1gj8uozqs/819IXaDF0NKyHCC12I6PRKD796dTZ8C
	1Ihc+lU8LB4RcQ6ba2sbBRB100BSw/N+meaLHmjEs5/iX1tT564r
X-Google-Smtp-Source: AGHT+IFxyE5+FxRvqyjIFgJvwYrifNm0opXNzukcex33pjKzhZfJC5OU2ycS4ZpGgJA14zAeAzx1Xw==
X-Received: by 2002:a05:6512:68c:b0:50e:8ec5:3025 with SMTP id t12-20020a056512068c00b0050e8ec53025mr2366939lfe.95.1704760254740;
        Mon, 08 Jan 2024 16:30:54 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id m5-20020a056512114500b0050e84be8127sm123302lfg.101.2024.01.08.16.30.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 16:30:53 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50e7d6565b5so2532394e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 16:30:53 -0800 (PST)
X-Received: by 2002:a19:6719:0:b0:50e:cd02:b537 with SMTP id
 b25-20020a196719000000b0050ecd02b537mr85182lfc.11.1704760253453; Mon, 08 Jan
 2024 16:30:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401081028.0E908F9E0A@keescook> <CAHk-=wgznerM-xs+x+krDfE7eVBiy_HOam35rbsFMMOwvYuEKQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgznerM-xs+x+krDfE7eVBiy_HOam35rbsFMMOwvYuEKQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 8 Jan 2024 16:30:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=whF-ur-8B5_8xgm0h9_=yX_Rz0Owjo4ghRwYVnKr-3z5Q@mail.gmail.com>
Message-ID: <CAHk-=whF-ur-8B5_8xgm0h9_=yX_Rz0Owjo4ghRwYVnKr-3z5Q@mail.gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.8-rc1
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>, 
	Josh Triplett <josh@joshtriplett.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jan 2024 at 16:19, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Anyway, I want to repeat: this patch is UNTESTED. It compiles for me.

Actually, I take that back. I did a clang build, and clang noted that
my "remove the retval initialization as unnecessary" was wrong,
because the

                if (!bprm->fdpath)
                        goto out_free;

code path in alloc_bprm() still wanted that initial -ENOMEM initialization.

So you need to fix the

        int retval;

in alloc_bprm() to be back to the original

        int retval = -ENOMEM;

but then it might all work.

Again - note the "might". Somebody needs to actually test it.  I may
try to do that in between pulls.

            Linus

