Return-Path: <linux-kernel+bounces-73270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 318E285C046
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B43AE2860BD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A31762E5;
	Tue, 20 Feb 2024 15:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpQKpKNg"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49F36A8AB;
	Tue, 20 Feb 2024 15:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443959; cv=none; b=uMQNpQfyvKQrmhsCMlBbSuC93jnTru00o+/yDSqlYhiFScrws3NbGc3UbUX6lN1ubwxZmEf3PmrXjUu6klaLgCrgpxUxGqjKwlJLk0PXsqcq5fVkzp9soyYp/5/2XtLSk4U0HR+WpXAWdE3fwaYrT8p/seXiCYwp+cvdRk+cwrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443959; c=relaxed/simple;
	bh=T9V5XtIpSuhz+qbEYmW8Gv+3u3YMnmX//PpS72rrwGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lksoEEotD+vMzjjD4tqaKsibzwb3P/cKbdJv3nBZT5Eayk/PTncA3F3n88yYmO1uM3e7JsejvR/xDnfKRrRPy09+claj7ZmhA/ACu8xJU51yHhTG56EWB8xpuRu8RzD/abexb6F09179SNuUnr6LWxD8/HFGEWeFDxvCjXCpZY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpQKpKNg; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-299e0271294so527747a91.3;
        Tue, 20 Feb 2024 07:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708443957; x=1709048757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9V5XtIpSuhz+qbEYmW8Gv+3u3YMnmX//PpS72rrwGM=;
        b=GpQKpKNg0GcULlY/QxM3dAho2Os0HlD4GVx9X2+Yv86hL/ztdPR/pcMaRKyKMOL/5H
         GSn+hI6JQaj80uIv6LYch3f+uw59DeYOrc8O1qD04MQHAk3G0OkQl2VJ1o8JbKg5gIaS
         prBBRJ1tJk3Dh8Rbuxz+rBA0qpOJmnX4D1pkbA2rPLr1X4d7lDjquMArXiQnWNPFfqB5
         QPEhG8k8YEkgPumfNvj0uHxD2NdVF0RcjOmhmWUs2K4q3oZKaEQctDiXXqi/s8offVpF
         9J+dlJclav2OKXfzgEEWyUTWJiRv5BwaCQj2IIyMb+0nF1CAb27a2PiidnZyKYt3Tc/w
         EGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708443957; x=1709048757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9V5XtIpSuhz+qbEYmW8Gv+3u3YMnmX//PpS72rrwGM=;
        b=B2BnwNKxNtkLL1ykiz+8rzcj2SWKB+VFuNEvGhKra7bjuLGYlEBdYsPn22nFK/JY75
         hxj5AzYpyjZ1BBhQIaVzGlXSOw1Ym6irnF9h9l6MIGKa6KWzhlIrTqNqJEOwGPz+rdTH
         i13g99G5+nhRSI0mztRqCTqBwcqpM7NGIe8nTcjV0/NawR9g56Txqp+Xsb0xatLii/PK
         zvJkMAj7S6vdN9PkkPVFlSbSdQ/fuTQmmA7IaWfhwm2KHixHLGQr9ynObMVmPs69oBVi
         1D9o0KhqOxq/IBnALx6HZmms4W2D9MbEOmkzO2GvrOWxXMM54mYcEzh8ub3+3y1vTUxK
         Crew==
X-Forwarded-Encrypted: i=1; AJvYcCXEk4i/Y9AJWfwb9B4jm+vP/ol3g1EzTrejr0Sj2ybgq4PmzgXddB+LqthhYEcoxFvUeqU/wq3dQ+pLcuvDjZW8/he/p5wK5LOQVPbZGyhTyk7z0xixlYIQisCEq/cv27/iJYyilppcO6IERwU=
X-Gm-Message-State: AOJu0Yz1krqS7MmDevwqpfvy4ImdmrKVDxH6cAe1M/A/qffzkSlw/sXY
	L8qZcinVCXYx4zRQIBrmJm2PzUHyL0/f23tatp3l7ZnmDqAp8VINknihilEdHCceeVS+mykQZtH
	jFC//lSlP9DoFg2sf3ectgSXJCIE=
X-Google-Smtp-Source: AGHT+IFQa8FwP5cuGMDzgfnt+NEbybiGyxs+UCGniB6Oz0QLmXsDYDI+phJjCypKWWKR0z0wh6HOhRNXXdIb2bPp6CQ=
X-Received: by 2002:a17:90a:3486:b0:299:398e:5cee with SMTP id
 p6-20020a17090a348600b00299398e5ceemr8445413pjb.13.1708443957074; Tue, 20 Feb
 2024 07:45:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219163915.2705-1-dakr@redhat.com> <20240220093541.280140-1-aliceryhl@google.com>
 <e543b270-dea7-477a-b83d-62129d4ac708@redhat.com> <CAH5fLggXiXGA_UWCxqqLhMpXe1kepDv2vMG+1jLGaDSzdRHvSw@mail.gmail.com>
 <19d0a4a9-85bb-4b9e-96b0-338adebc90e5@redhat.com>
In-Reply-To: <19d0a4a9-85bb-4b9e-96b0-338adebc90e5@redhat.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 20 Feb 2024 16:45:44 +0100
Message-ID: <CANiq72n06BCWuHoWbQBrODqgfH8ZGEc6rLhMu86UiYpKdjO3PA@mail.gmail.com>
Subject: Re: [PATCH v4] rust: str: add {make,to}_{upper,lower}case() to CString
To: Danilo Krummrich <dakr@redhat.com>
Cc: Alice Ryhl <aliceryhl@google.com>, a.hindborg@samsung.com, alex.gaynor@gmail.com, 
	benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, linux-kernel@vger.kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 3:53=E2=80=AFPM Danilo Krummrich <dakr@redhat.com> =
wrote:
>
> Just to clarify, I did not say anything else. As mentioned, I think those
> should not even be warnings.

Well, for things like the `return` one, I find it unlikely it will change.

And for other things that there are 2 ways of doing it, what we
typically want is to have one way of doing it, rather than allowing
both ways.

> I'm happy to do that. We should define the scope for that though. I think=
 this
> should be set globally, or at least not per crate. However, I don't reall=
y know
> what's the best way to do that. We could pass '-Aclippy::' to the compile=
r...

The scope is already defined -- it is global, precisely because we
want to keep all kernel code as consistent as possible.

> Is there any objective reason not to be allowed to be explicit here?

What is not objective about wanting to be consistent? How is your
argument objective if ours isn't?

> Well, I generally agree. However, I'm clearly against *blindly* following
> formatters and linters.
>
> Forcing guidelines we don't have objective reasons for will otherwise jus=
t annoy
> people and lead to less ideal code for the project. And I intentionally s=
ay "for
> the project", since this context is important.

Who is *blindly* following formatters and linters? We don't have
objective reasons?

I don't appreciate the way you are wording things here.

Does it actually lead to "less ideal code", or the opposite?

Cheers,
Miguel

