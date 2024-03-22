Return-Path: <linux-kernel+bounces-111834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9D1887177
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 518121F24C47
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773D25FBBF;
	Fri, 22 Mar 2024 17:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q68AdQAZ"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7515D720
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 17:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711126849; cv=none; b=bgjtW3wjNzTkJxIlbnMI6uZoRdSvyI8QAjH1MelCdWfct5t6I+V5OjgbKkxtDWlsdIVeMB3bnv3RI2nI5268KDIeasybg5J5Gmvr8AipKfKvQXz8zZJ4123G0UUbAzS+4gFU//D0CT9LYYTzad7wsndl3nzXd3gXi+hS62YPhR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711126849; c=relaxed/simple;
	bh=j6DbhQluzvzsx41undBNUIjdpXcP/a5BTdC29L1/dMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TrS6W2J0HE5UizcnTgSBNrNoz3C3I3YvTJuVZV0cFn/GDt5gDuCG315HWcOegkVD3L4T3Xbr0J4XnvL+uB0Nz8qzfJBnLBzh4TIVcD4kSXwX1MFitYr0mYjvZfqEPn7Op8utCuoo1CcPNxVNbO6nP39r7oJmhgqW+OFuNzAA7yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q68AdQAZ; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-60a0579a968so24530477b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 10:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711126847; x=1711731647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yF6hR7gLucpj0wDgjmAS4/Lo4A9wMQBgK+CIYwQ+D+E=;
        b=Q68AdQAZVq/W6vAQIBQP6RIBJVq1s8RNm7n7ck9XjWngYSBtUVM7UTGGdYlRoWExTq
         msvZsE4GFPhtT6qsmSFXVcBMbi0qUNxAqX8mPpS7hJj7/la+6zKmQvtOij/ha9p72aMd
         emmvKbTXdm/DpXOrQy61Ot490q6g49CVpPHJdsGxXlSNr41xKCT5LqzEMlaHPFd9dDLr
         Uf7a3puw36jbiOUrfmwLrZvLmVZuwWyzc5KTHJd+CPWngQakroljOThA/JyjL0BcKP9c
         2vMrbEzU96nKRWl9/fG7A+xpSpl5Bwvug8X+ajqkSfJ2dIVoLYwV8KzwHb2aDqm87giS
         uMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711126847; x=1711731647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yF6hR7gLucpj0wDgjmAS4/Lo4A9wMQBgK+CIYwQ+D+E=;
        b=F+zuLdgSoqlvTiAMDQs8BX/5A1HSP4ggmaMEie13qUne0OP0zcp4tUEw86goYx2PJP
         EsBf7l5mNSYcsa3aOQZI6GusqSwn4g3lZ5opqv0wceMPOZKAgkmCeat08Bwf+JyXIIbA
         K3jH2hB+efhSokeRAhNJXBMicMJQm3j8Pfb6h71PgvX4wi5wTpOJyqQ+jB8AATUeLkP9
         q+A7wdrZrtgjsVd7VSgva3RwY0/Mz/jlR8FGcXxYQNBgYN57IvIjLP4oJ7eVl84ZBaj9
         FADE7YWHFFwAv7VVPcbjOi4Tvke52uyO6f89qETSAkZvsLnpxu4qjUTEr7MY3dAPFb4A
         AnfA==
X-Gm-Message-State: AOJu0YxShcceIev4v8nmfniTdV3epftEvgv5ospTMBZVdGDww/Fd3Q+l
	g3mnBV91gHq8ntZUlsWF2o4PyNvvnnuMek9UPtZd5iDuIKJs3RIlyR68aOR0D3OQ6zavE+zbbTC
	iz943qOuLr+X9EOzdA0r7tPFpr2w=
X-Google-Smtp-Source: AGHT+IEZZpPp29NFVZfmD5E3ICda2do9UjqtVvd49EwDJSJV3zudli2rq71jj6JS/CdI/AzFxUn85JmoA8JoRkAI+Mg=
X-Received: by 2002:a81:a503:0:b0:609:f2d9:2473 with SMTP id
 u3-20020a81a503000000b00609f2d92473mr205816ywg.28.1711126845877; Fri, 22 Mar
 2024 10:00:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315140433.1966543-1-hjl.tools@gmail.com> <264400cc-ccb6-46c5-b054-403f6b82860a@intel.com>
 <CAMe9rOrZ8XDoeDru+zm1ad7NsLHgkD1cm=CL==uhWY4OqqQGJg@mail.gmail.com> <ece5cc63-960d-4323-9128-5023b6d94dc0@intel.com>
In-Reply-To: <ece5cc63-960d-4323-9128-5023b6d94dc0@intel.com>
From: "H.J. Lu" <hjl.tools@gmail.com>
Date: Fri, 22 Mar 2024 10:00:09 -0700
Message-ID: <CAMe9rOoEQ3jUUXy+Kai9Hg83b+79azmGfu8DBR=A3HSL05kj0A@mail.gmail.com>
Subject: Re: [PATCH] x86/shstk: Enable shadow stack for x32
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 9:56=E2=80=AFAM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 3/22/24 09:52, H.J. Lu wrote:
> > On Fri, Mar 22, 2024 at 9:49=E2=80=AFAM Dave Hansen <dave.hansen@intel.=
com> wrote:
> >> On 3/15/24 07:04, H.J. Lu wrote:
> >>> 1. Add shadow stack support to x32 signal.
> >>> 2. Use the 64-bit map_shadow_stack syscall for x32.
> >>> 3. Set up shadow stack for x32.
> >>>
> >>> Tested with shadow stack enabled x32 glibc on Intel Tiger Lake.
> >> I don't think we should wire up code that's never going to get used in
> >> practice.  I think I'd want to be sure of the existence of some
> >> specific, real-world, long-term users of this before we add a new ABI
> >> that we need to support forever.
> >>
> >> Are there real users?
> > Were you talking about x32 users or x32 users with shadow stack?
>
> x32 users who both want and will use shadow stacks.

Someone can do a survey among x32 users.

> It's been a long time since I've seen an x32 bug report.

Because it just works?

--=20
H.J.

