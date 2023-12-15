Return-Path: <linux-kernel+bounces-1545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AF0814FE9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C111C243D7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890543FE40;
	Fri, 15 Dec 2023 18:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4YbdG9u3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D19E3E490
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 18:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40c25973988so10567815e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 10:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702666473; x=1703271273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0yhlLnli9k0VI7KUFKv0npC9sSJh/Clv7rMd6ohVtI=;
        b=4YbdG9u3epMfTOFMVMhwXMt0FoVjLUFa9bCv4+lm6wnldAGQiHQtDxmPZID9A8qmAd
         tQsSV6wpSJEnwg03riJLXi6MAANjvzdRjtrjIifZQKITJfqASbQs/5MCfZfm3lpn44K9
         uhS6fnkd0uHiKmd2ut6tLLFEjmYbZKbn7a1Cv9jpxyQp8cWBoJOdZvpRxnXAzXS6vxN1
         MB2OY5pRmFsPrtnPB5XkX5Owb8v0O7UtfZYc+FQ6vsDhTQNiaMWhaexfdqoubGpN8Z+b
         +Nvs3VD4xHexH+8pa52xNwywcRH2QsBrenqfddh7151JMcLIE2TeI/TK1L5Q7mC1m+2h
         EFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702666473; x=1703271273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w0yhlLnli9k0VI7KUFKv0npC9sSJh/Clv7rMd6ohVtI=;
        b=DcpE3fdbxLXxds/RWSXaNsmP+MF/Wu8GT6HohXVLPGV9IN8vYRQd22TvO1JjvZ0gzY
         0XA+/9ly9tL+gbdw/iOzh048qjR78qxVpUwzUxYmrZuVYxeHDHz6wz5a2aguBAa/pUDd
         qZOZ6sDzE0fL2XblhG4/5mTcLnmpCKQxy0Vfiew71rkFqNp0+Sd+3RtByqQ/vJTB9MVF
         qGYaJd37PvaF4HbypmAhq6LO7ZrrAWdWpKh4TOO/CWWCGxd3O1ONkl6VT+bszKRSggbs
         eXWt9FxWfRAlhW6I4/lQbEOmJxo6NHg8Lkts/1zgeeOVu9d8ix5M3tOr8RIzKTs/AgvL
         na6w==
X-Gm-Message-State: AOJu0YwIo1V59lXGyDilPXZ+XIKgGPY6aHpR4bz32m1BYdhbQRTflyjE
	v0WSmndvTSQ38VlAuRVcZkeWXFnPI+zCWwTeL0tODw==
X-Google-Smtp-Source: AGHT+IE34lQoNeNuvNXj90juk5IJps9k2aIPV/11nY+vSDykIRdGV6J/LHeJFvNMvCa4uco/LdEhELqecQbu4jjOX+U=
X-Received: by 2002:adf:ce06:0:b0:336:446d:7cc8 with SMTP id
 p6-20020adfce06000000b00336446d7cc8mr2132480wrn.132.1702666473386; Fri, 15
 Dec 2023 10:54:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214001753.779022-1-seanjc@google.com>
In-Reply-To: <20231214001753.779022-1-seanjc@google.com>
From: David Matlack <dmatlack@google.com>
Date: Fri, 15 Dec 2023 10:54:04 -0800
Message-ID: <CALzav=eFSoW4fWC4uKh3bm--ekzDriA4=jjq6kA5j+Mp=7n_wA@mail.gmail.com>
Subject: Re: [ANNOUNCE / RFC] PUCK Future Topics
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, James Houghton <jthoughton@google.com>, 
	Peter Xu <peterx@redhat.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Isaku Yamahata <isaku.yamahata@linux.intel.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Marc Zyngier <maz@kernel.org>, 
	Michael Roth <michael.roth@amd.com>, Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 4:18=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> 2024.01.03 - Post-copy for guest_memfd()
>     Needs: David M, Paolo, Peter Xu, James, Oliver, Aaron

This works for me. And in case we need to reschedule I can also do any
of the other Wednesdays in January.

Thanks Sean!

