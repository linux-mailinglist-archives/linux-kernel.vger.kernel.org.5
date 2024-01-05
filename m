Return-Path: <linux-kernel+bounces-17672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B720B825104
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40BE62869E8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF26C25101;
	Fri,  5 Jan 2024 09:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VkcJyBS9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA610250E9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 09:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7cc94f8756aso432964241.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 01:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704447775; x=1705052575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWcapK+4gPTCU4AKgsJIg/JwPTZZJk2BZElnDDx7WIE=;
        b=VkcJyBS9Bg/bFdxHSo7oO7aGO5cPsNXAsKCW6449H0ayrkS5OrIn9DKIf57B79mdRB
         rX755gYJX9mWNGq4TiyQaW2tqc3C2h/NpLlhg5EW5mnbNQQn4W2k1XpfAA3saMT7U7Xk
         7CfK3yCpYtJiOkiku1OXZaKa1WQajLJg1r6IWiI22OkDGKdkNiWhy8Gt4WFosmJpIbXo
         G5y5umVzG3uExvrCBZ0Be4e0VxyIBwfzGKb0zEV2bmeIBv0aE3BgqDR6F2sTyazWG/hZ
         GPdN/luMubMGU00nicaFzPXo8KiqThy/U6O2yecOmmnx0KPD8AEKE0LTAzgivlOEOs4s
         eH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704447775; x=1705052575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWcapK+4gPTCU4AKgsJIg/JwPTZZJk2BZElnDDx7WIE=;
        b=lu9nIcWAX6rZxlwWAyXDDv9QCx4BYndmhn+bEHDhAFJrPlzLKGKak238kwy3EsDMQr
         nn1APaeJPkbQ/TEVY8OOj7YORuL7xQFm/RcFg5tgyD0/juAyVX4pK7NSZF/lGXrV36IW
         T6EjvOTnkCcvrkqKXNjpW0f+SUcPLAeKKAQK8nLZ0+qiU7ecnV1+iX3C4Ek0tNYt0/gk
         eJDbJu+4eD3tvPFJPS4wUAKMrRXBWR3QySnefU64RdNDf1KMFM4qPRtkx8Ce4QsipHEW
         lENDu0cY4qGeKQ/BOwg9vvjdISkdhLWtuqzj0qLDCXFcHWD3wASST70OFUgqPSiK677h
         HK8Q==
X-Gm-Message-State: AOJu0YzWDIL7LS59ADVsgTij/N5zSCgELUZZsgf1BIB6vWPnrHTjKMRG
	V/Jb5iBlZTvScCLuB6kmV30xuK2pLL5EfO9odtaE7WzfoEyV
X-Google-Smtp-Source: AGHT+IESCC49EOa17Ki/LCzGy4Axu3cNswj9K4To7Z0Yqe9h8ZZJtWriSSU5Gia3aH253IZZC/M7sZdYmLWS2PnbYAk=
X-Received: by 2002:a05:6102:570f:b0:466:f130:9d0d with SMTP id
 dg15-20020a056102570f00b00466f1309d0dmr1308113vsb.32.1704447775543; Fri, 05
 Jan 2024 01:42:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105012930.1426214-1-charmitro@posteo.net>
In-Reply-To: <20240105012930.1426214-1-charmitro@posteo.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 5 Jan 2024 10:42:44 +0100
Message-ID: <CAH5fLggLUBJQYAKb9Vx66QD9CR2XZLpgqj1UQivV0-qvf+qDPw@mail.gmail.com>
Subject: Re: [PATCH] rust: sync: `CondVar` rename "wait_list" to "wait_queue_head"
To: Charalampos Mitrodimas <charmitro@posteo.net>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 2:29=E2=80=AFAM Charalampos Mitrodimas
<charmitro@posteo.net> wrote:
>
> Fields named "wait_list" usually are of type "struct list_head". To
> avoid confusion and because it is of type
> "Opaque<bindings::wait_queue_head>" we are renaming "wait_list" to
> "wait_queue_head".
>
> Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>

This has merge conflicts with a bunch of other patchsets, but the
change itself looks good.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

