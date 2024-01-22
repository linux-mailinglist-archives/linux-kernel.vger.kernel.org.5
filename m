Return-Path: <linux-kernel+bounces-33255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D10B8367FB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F24DB20979
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2548752F9F;
	Mon, 22 Jan 2024 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3MHB9th"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F1B524A4;
	Mon, 22 Jan 2024 14:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935505; cv=none; b=qLfB2PVTQYOtNxh+GLnC/SL+NgfS1dJcbo69aseHFikj30cfNk1rBP7OWVkc5Sx2AUSjw4EB180rzxwWim2HZZ83eZtmDdmg8nWYIPBgVY5dEvyD8p5yXN9NDwHAF/XgonctExOoc7O/6cSeMcF7ppdZK5cEvr5iiXQRXPra1gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935505; c=relaxed/simple;
	bh=zx5mRNzxyJlvHfbVnxkC/u6ZuwyKoUvIry+7Sb9Uyvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GX/eQCKnD0Us3NOqTdc3MBa2kwrHulZOdDgQaSMM9PiSaD+u+ftGjKcvHIHtopz/xRC2i1jfrAp+i35MbY9mi9LwQvwaGJKDqAlidi+4My6qajHG+a6aekwgaev3qzm70+OD5pZi87MUEfskt0Ds9PohqpcTp7XmFJ1WtO6Rs/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3MHB9th; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5ff7dc53ce0so21521607b3.1;
        Mon, 22 Jan 2024 06:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705935503; x=1706540303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zx5mRNzxyJlvHfbVnxkC/u6ZuwyKoUvIry+7Sb9Uyvw=;
        b=E3MHB9thrdSLYunhZFLAFjPBze3DHo15XKKo5pK2Zqe3lQn90x2HYk1Cpmd0l/R65S
         Cwy/CO7wqmSSaMlQ/5RiI696d3tX0BrLXLcMJEryPps36n8wPwn2f3ZkpXf/cR454VMi
         LWhboYhwsOpPUMBHFDhmX5ECXFNDS29I5Gl1OHwqF21TiwUiPgNZa5uzTo/wsOh5vIt6
         okXXuSpf4M7txjYR14tgNR/ZAb3a4rjKHRPHSgv7kg2HGmugrjRMD0TAr8Nr3eIGt7BL
         RuhbmXUa9WTQt4XMdYbJUyeoFAQKoEZDJ9GYldZryUOCYZ/59m1iftsnZbp3F4cnPPm2
         Zjtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705935503; x=1706540303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zx5mRNzxyJlvHfbVnxkC/u6ZuwyKoUvIry+7Sb9Uyvw=;
        b=ErZtzjcShkkVzn5ciHJfl60x7ELkQOOs0oWF93I2fP4f91kl4J06YosEim8SmwdWGS
         5WDHiuWgXk70cKr/YyaJr+RP31SvIpUBEyTiRwYLnR/wO+gJDgmzfgCVDis8iuuNoIEf
         fkQxx4RCiEXzCKFQoECYdU21gWb/tuOvBR0kBBkg68sJAyijleepmKG7ZBGWPS+nH0KD
         TFo7qSmaqy5iUSBQR3DkfI8rR//m/R3InREtPefUCNyXljdsEGukQJhFgOHe8i4rKozA
         5TZxcx/OOg2I687gQvN/vfOo9slX1Grn8xLsz7Q62JqD1bWrrzVESTDKFYvPKpmHiCdu
         GeoQ==
X-Gm-Message-State: AOJu0YxT7U0XidvruUJQX8FKqy9/hoxP8btPn6AFlVmsXp98SqNyrepC
	ebXQf4NrDlwzRpkcM3C2gOlhRllsOAelRVFtzVHlDiPfKbXdQwe+dOkh+Jmd0634xre4nOiH3yf
	v8TZT/nkCO1nS2gQBoUnTV+V9UgE=
X-Google-Smtp-Source: AGHT+IH4SpOaE3HwHRyQ6KFZQXsGaaFp8ZR7rCGfOdLhcTSQb+0HZE37tdRub1sxzupLDb2Yvbnn+Em9PV+2mDmvMP0=
X-Received: by 2002:a81:bf51:0:b0:5ff:7f45:3933 with SMTP id
 s17-20020a81bf51000000b005ff7f453933mr1974710ywk.80.1705935502922; Mon, 22
 Jan 2024 06:58:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105012930.1426214-1-charmitro@posteo.net>
In-Reply-To: <20240105012930.1426214-1-charmitro@posteo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 22 Jan 2024 15:58:11 +0100
Message-ID: <CANiq72kmQXt+wGfKD5ehrqA2V4vbzrtH9f1MJrhxSkR9nLJUHQ@mail.gmail.com>
Subject: Re: [PATCH] rust: sync: `CondVar` rename "wait_list" to "wait_queue_head"
To: Charalampos Mitrodimas <charmitro@posteo.net>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, aliceryhl@google.com, a.hindborg@samsung.com, 
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

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel

