Return-Path: <linux-kernel+bounces-6792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69370819DA2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 241842829EA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970A3210E5;
	Wed, 20 Dec 2023 11:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZLsOLMp6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5597210EF
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 11:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-42581f9c0e7so45806291cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 03:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703070308; x=1703675108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRuOb3thPKxS5ftTwWuPZVBwpG9dfs4GXpoJ1hD7vC0=;
        b=ZLsOLMp6hN5xMThNv+as6Ms91ht4Hg8idXzILP4u9tIFPo+5rHRXxllusclBYIXajE
         Taub7AAXqVnoQI3f+fLXz1Gp0AxFveNNF0bNkr8eTL/zMqrVufk8w5ZNjCo+t1tZ8qv8
         t8z5nthKMJW+gMkBUyv+fkxw3IDtvvaXbfvz6qO0TtjPZ/NLkiMZzcomXP3VmwV5CiRQ
         UTKG35J2uNwTtYgyXGpycBAz1Ubbiix2cIl1KNmNuETV61LRgb3U//dbRzVATravzLY2
         7cwjvRQh5zkoshl6AuNy4Yj/qGDO3V1Z+x9I8CvRuIbJouB2zBFCjxFaSRojVcxHE5UK
         ufRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703070308; x=1703675108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aRuOb3thPKxS5ftTwWuPZVBwpG9dfs4GXpoJ1hD7vC0=;
        b=W8X4/ktYdIGxx3IoHE0mNrI5kIcCalOXib7e9OeWAV/duYP88uE/FLyhREmPUeDWsz
         VGLHDqgDywbo+aTTB8+BGXSGF3A8nXOiiGSdTR/zEM7o7vu3tVg5VMqARecERFYgzDsE
         t/jrDntjtfs3pLMoBvH8tS+8WQ9AlfJB0QzBv5j8bPbHUWHHN5NWHQi0bDNqHhHSa6XR
         5U3fvTR0R1aSyIybpDrpsxrrciEAK2d9mrNfSuDuSGQi/ZiP6ohjqokcW8ypbwtrULTy
         RAfaC1K+Tf8bi+qTzWSf+dZEku2K7BY5lNWK7mV5AtQ3cMQHSKsv1wbmeEmcDE62Te34
         vFjQ==
X-Gm-Message-State: AOJu0Yxyi0Wv++kH6c28jV7/in+g/NC3mQsV/8ZIzS47Wqm5UjJS/i7u
	fewXRQnKf+mxJu3/3IfInAZQvI+rhyD+QCW6leSpwg==
X-Google-Smtp-Source: AGHT+IGM1DvhNsHIpLRzl7TLlRhf+sSCR6McpSC15tKPCcbFJwj7U8mFeDmNKOAesBXFyLQOLaIWCh6aAZXNFJ7pswI=
X-Received: by 2002:ad4:5dca:0:b0:67f:143d:b8ca with SMTP id
 m10-20020ad45dca000000b0067f143db8camr12635720qvh.44.1703070308403; Wed, 20
 Dec 2023 03:05:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213233605.661251-1-iii@linux.ibm.com> <20231213233605.661251-25-iii@linux.ibm.com>
In-Reply-To: <20231213233605.661251-25-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 20 Dec 2023 12:04:28 +0100
Message-ID: <CAG_fn=X_MejbvJRG7qYih+qrL6D0hrJW7czfAJbOdY5ES4JyiA@mail.gmail.com>
Subject: Re: [PATCH v3 24/34] s390/cpumf: Unpoison STCCTM output buffer
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Pekka Enberg <penberg@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Vasily Gorbik <gor@linux.ibm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 12:37=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.co=
m> wrote:
>
> stcctm() uses the "Q" constraint for dest, therefore KMSAN does not
> understand that it fills multiple doublewords pointed to by dest, not
> just one. This results in false positives.
>
> Unpoison the whole dest manually with kmsan_unpoison_memory().
>
> Reported-by: Alexander Gordeev <agordeev@linux.ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

