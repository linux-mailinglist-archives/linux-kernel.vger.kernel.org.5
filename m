Return-Path: <linux-kernel+bounces-9041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DB881BF82
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FC1628624F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B550D745C9;
	Thu, 21 Dec 2023 20:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uo4abMHv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02FE745C7
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 20:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-28bf27be6c4so531751a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 12:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703189987; x=1703794787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gssvy5smjz8a5SJrD6j08da6bZEPTZEaRbn1KUt4UuQ=;
        b=Uo4abMHvR3kusy1Om58iJETpugQnHrdiRthE4D6+I7asAdiT5IczdxT+dGgvja+2qt
         QPIWWEfNdvLNL8APH3+GV702z9EUrCfmZMjYEOP9SYbPky9Y4K5rORCYCwzCKhtBlp8l
         PC+3BoFP0E3Gk06lNXtb/AsyMru76obWA0wIazunwRuafSwnjUKO5iPJy66hn/kiTPQ2
         xcv+zzt1DB4z8cbAqnmtWLJU+97OgL79idJlEhmebK/UQyWusLTn6xjov6BaRHNyVfg6
         s0VC0xfrOAc79zCHws6bkVJUMl7UGZtiMd+agTNZHrm3uNLwoOGmzcBkVlI70LvqaWYf
         6zmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703189987; x=1703794787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gssvy5smjz8a5SJrD6j08da6bZEPTZEaRbn1KUt4UuQ=;
        b=khmpdKG/1rG2uNyQxKTERizVjCsqRD/9voTKyJR2MF6vOKyz6Ga5BynUImbzh31m9v
         Jbm2gTIDnCnP7Dm4kV/3L9TGIdFAJ500rxHnSRaSiYnwSakooq8damYaZFnr01TAZrPr
         ad7OdlU+6TwzMbRFMjvfT5ZNoJaR1bvLwnlb8F+8oyadYaBR4mdQ4MvibwOaGQkitbWY
         cX6xqPF4n9kei4bsRAK+3YG9l4qX3GROr6pOU0uQKsdd+NcNmZ3wHuP16EsgYh4V4ljP
         C9lg4HqJxjf9HhVF3LhuS6NoddeNT0f6uQiHxNi3NFZj9/BPyODvaPZvfKj7SDPz49r3
         2+rw==
X-Gm-Message-State: AOJu0YzQtA3wq+Iyw/SbEu2aerOALRXi9vVRYl8XTd+JY6Wu9moay1jn
	823LfJ1lgboixCssNldBiGd2j4/QKFvCaRDvZlg=
X-Google-Smtp-Source: AGHT+IHS5EXZjgpp2fJkrvuuqF8/IpGeWCj1CjncaEw1dze4kKh4Kr6ER64TVAJIZej89ke+4GkFOFbLK40jeIcuYpU=
X-Received: by 2002:a17:90a:ad92:b0:28c:194:8de1 with SMTP id
 s18-20020a17090aad9200b0028c01948de1mr317153pjq.63.1703189987119; Thu, 21 Dec
 2023 12:19:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221183540.168428-1-andrey.konovalov@linux.dev>
 <20231221183540.168428-2-andrey.konovalov@linux.dev> <CANpmjNPGBMD6XsPpdL-ix8VTuWAwV-jmBjLpC66Z5y543j0DuA@mail.gmail.com>
In-Reply-To: <CANpmjNPGBMD6XsPpdL-ix8VTuWAwV-jmBjLpC66Z5y543j0DuA@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 21 Dec 2023 21:19:36 +0100
Message-ID: <CA+fCnZcMRT2p07PLqXnm3p=YFOq9SDR_74fbnA+x1BtFuotCjA@mail.gmail.com>
Subject: Re: [PATCH mm 2/4] kasan: reuse kasan_track in kasan_stack_ring_entry
To: Marco Elver <elver@google.com>
Cc: andrey.konovalov@linux.dev, Andrew Morton <akpm@linux-foundation.org>, 
	Juntong Deng <juntong.deng@outlook.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 9:11=E2=80=AFPM Marco Elver <elver@google.com> wrot=
e:
>
> On Thu, 21 Dec 2023 at 19:35, <andrey.konovalov@linux.dev> wrote:
> >
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Avoid duplicating fields of kasan_track in kasan_stack_ring_entry:
> > reuse the structure.
>
> No functional change?

Yes, no functional changes in this and the following patches in the series.

> > Fixes: 5d4c6ac94694 ("kasan: record and report more information")
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> Reviewed-by: Marco Elver <elver@google.com>

Thank you!

