Return-Path: <linux-kernel+bounces-125085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2957891FD9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85CD71F2FF81
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875D9148FE4;
	Fri, 29 Mar 2024 14:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mwjozn5p"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778FE69DF4;
	Fri, 29 Mar 2024 14:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711722398; cv=none; b=AlQCcBlZPuIhUOSRmKfUJQoqmYKBslx+WpK7GK1QgiTh7y7afqD9j6Lpcf4/sw8AqPRgfJ6+UeIhb6Nf7pdDvI0DyuxrHGvYOzfMfgr05rTBQF50tQhH/ZS+ypgG3SK2v13Ofv+BvKkDRNiHkUhA/4SUDwMvfN8rk6dC5fVCF8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711722398; c=relaxed/simple;
	bh=UFrvBTUqTAQ0nC/FyBljDk18vcMjjZLvtKE/7fdICFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fV1bVVR0aaqsLEAPzfhMeXjIhuDEf1fUCTmlhcPLaxW5NoLPVsy0/ahBIlssbUrg1CdElF7D4E+tatRXG/oJFY54IM35KTB1wmp3VFf1i8fGNqDzwYNVvgI8y/FwLq+QdzPIn6wr4Il4QVuy0qEB7LWAAAyZKcdKC9sDSplLtF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mwjozn5p; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-29fb12a22afso1544486a91.3;
        Fri, 29 Mar 2024 07:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711722397; x=1712327197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awx3iXILJ3etJ27hrz3eMY5jbcEJQVk2l5+2WFH7sG4=;
        b=Mwjozn5pUwOpmOlAx7ZSmRSmY+1tlrHedVq8VtWJtJry9a8RnUo09euwhskkk/Q+l9
         sdmfonB7ShzoNXHkbABqT45Sy5w3MDU0w7h7c7PEdxN0kTzW3qALAG1ulgi7PPQ7VnQ1
         kUVDhCGZVXZlODX9vs1r0glLpqRDcr5okc4uIun2cpjZjHQ3DcNt3W1hAcP/AI7wscgL
         PwrrI6sQFvN4YytDfZ/Mvwuozj2ZjLAcyOzOtPQxWtRTkQIaOTfLFDqwZVotSgCKo67F
         9xLJ6TX7I5N+SrWCJJMCcSRVRb+PiCh5nNLexkvY8FRdZWtiSp/0zCAGP+kjD0aJ6MOn
         dnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711722397; x=1712327197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awx3iXILJ3etJ27hrz3eMY5jbcEJQVk2l5+2WFH7sG4=;
        b=cj5Q9jRGyPXwgG6jY6XHTB7HrF7O2S+wPZYQY2rnzvqWNeEFsKVDj4AUNj2WODQQSv
         kSZJVytuf7bPouDQ6vTqH7lMsthvPXKsvWuQaOvayVjnFaPHzJTxnFgeSGG23hekDNyX
         0B6caZBsxYXH5QAofA6nNL21o1f1OuhuT+wBCnc4o4I27MZS6oB5ePeBhHIltV7zUI4E
         jfQbhljVdsNG3d/Dgd6AdzWRHGqHQ1Jmy4CyrwyYobAIZQeuDYmaZ8vUGeTjDvOstsUK
         +ZHpW/bsu1xTe+OqgirItAT7geKhYp0lSkHDavcDYy+RHMlVV29kTS3Qc71pmCqoa/lt
         M0Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUQyxbSXtacQA/5k20nyab21ViGaD4kUOgtZUMGNb4FuFpyaKyskewWaKFj3vamI0u1cpnaOWCNoIeLAAHNfW95ZrxypFLjfUMCDQqrgfMjBn/iyXpFqeFT921VA8J9jQt/ba1Tg8xlcP59yEY=
X-Gm-Message-State: AOJu0YyKVNN6j1sHhjemQs2OMQW+KZk29AWXYIkshdLG4ppkfcf5BxSy
	f93Mrj0kdpkEuzvidjbHGzYfPq9pRuIdJig8i217c8PxQiop/PX7l7nC85FXh3mzgDM3QiyqaNm
	LRHV4iyp7DmVbcZaQqWw2GEORH34=
X-Google-Smtp-Source: AGHT+IEAS9Cd0/AwNseDmaLsCeORItwmWKa57G0+mDoS5jtqWRJZrc/iltvm4Uybh0TCL3z+B9n9LyA3A2tnxTfkMiM=
X-Received: by 2002:a17:90b:1643:b0:29f:f876:18ac with SMTP id
 il3-20020a17090b164300b0029ff87618acmr2307022pjb.35.1711722396743; Fri, 29
 Mar 2024 07:26:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72mkHM3qfq66oDZyZMCuLK8Y1tJxEqFhSYpFWg7ihfcvEA@mail.gmail.com>
 <20240329140030.3989-1-kernel@valentinobst.de>
In-Reply-To: <20240329140030.3989-1-kernel@valentinobst.de>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 29 Mar 2024 15:26:02 +0100
Message-ID: <CANiq72nuRGUqi7JxdNpFPyTD2onNXvujZHk_5xuxwFSxqWh0xQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] In-place module initialisation
To: Valentin Obst <kernel@valentinobst.de>
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, aliceryhl@google.com, 
	benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, linux-kernel@vger.kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, walmeida@microsoft.com, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 3:00=E2=80=AFPM Valentin Obst <kernel@valentinobst.=
de> wrote:
>
> If I interpret the docs correctly, previous patches in the same series ar=
e
> only implicitly considered as prerequisites for the marked patch if they
> are marked themselves:
>
>     "[...] you do not have to list patch1 as prerequisite of patch2
>     if you have already marked patch1 for stable inclusion."

Right, "Cc: stable" would be needed in both 1/5 and 2/5 (but one could
remove the "# ..." comments in that case, i.e. it seems simpler).

Cheers,
Miguel

