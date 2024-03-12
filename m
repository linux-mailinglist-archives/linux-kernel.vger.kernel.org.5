Return-Path: <linux-kernel+bounces-100322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E018795B2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B2221F21E3E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390DB7A73F;
	Tue, 12 Mar 2024 14:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0JOed2Y"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E287A726
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710252589; cv=none; b=h0Weu2wO7Q4jiBrnNx4AAlfzr2Q1eZnQ4Gb6QkxDVdhtE0GfnsnxhhDEK3bhZvRIK4CVRwMcGZpCzw2tW19XH+UVFGEzW1yDp7tCmUFmJNCZnCwk/3uREYXfxxR4zdXvYlT9r5FRLY/wvBacAmO3NgrbJHBDNkzkTYJDPpfIXRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710252589; c=relaxed/simple;
	bh=zu+uZ/8084vv+m/AogKImKAueKFkXxPoXHpto1b+ruQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AuMRxpH0WJEap0CKWmwxeZaELnYWT/kngRViCcIoPghI79j2laCihBcSK0bHcQpQe/51FD3KRuEKZn9UP+wJDVOa0bn3+D34DuIXEeWKI0vVtKRIKyfRCijJawezAoCNLac0v4CIf1pTImLUyEfid9EwcQgWppYtE34pfgyLpfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0JOed2Y; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e0f43074edso3780099a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 07:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710252587; x=1710857387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zu+uZ/8084vv+m/AogKImKAueKFkXxPoXHpto1b+ruQ=;
        b=N0JOed2Yh+PwnmLX0NDNMDPn09Bz9b01NNf+hu6I/rEu/sSM1AJc9xwYd0+z99U2xt
         97+PaVtlPsHU/x86ymrKgYQEUkyyxpm2kXpoNtRVvrhx2iYccnZpSEgxWdMYJTYIxTzb
         /9qF9OFv0y2/neGiZ2hrlRNYpRgFfcOA67ZObqMG3AkJbqPYAY2A5cqgZDeGSdGh/Uhg
         6yIkzFmXeh8c5N51FHY7Pw1Rufu62W2dBpZmkl6huNJutk3faFMgAy3I7oDY3HEo36VF
         J50lAFMHGMYffWhT82DYIA3TeHO3sp29VVZf8VZMqb/yHOiT3euvKAZZMltQNZgv9IzE
         X3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710252587; x=1710857387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zu+uZ/8084vv+m/AogKImKAueKFkXxPoXHpto1b+ruQ=;
        b=nd+RWgP8m/oOyzhiYY6P/G8Xd7Ax0Oo9c6JpKF1ICugDcnrG60qEGKnKm8cBfMCFkI
         KsfY4D8src7RsX9dXeGOGGmkAB0GvdK75Joh1oxiPQJVizs9qoubSEQr1Zj+/+P1rz1F
         23v4A1qUYA6ZEy8Y7K14xhtVvgUeUdif76QMQsmxHG2h/bXevouAMlCvdWt/6IHhXkM7
         iiwwtnM0OVSiTOAIMa01Qr+7xnXuQqoIVFunFD6sempV4KW5mDDm+mdzKRKjTqgYFc7Q
         G9zz/5kpugonWTXl/IFF6PqxFZ81sYOJwWQlHlSw6DX+uY1pOr6b1J8W598o3STnf+Na
         r9Tw==
X-Forwarded-Encrypted: i=1; AJvYcCUxlGFA5BNXf45hVoj3dL1aDGYx58B6tBKCxWsDmHdLgbbevg2/F7jn9DgaEmo+otihq1ZXI/D2CUekQz98Bnv3pez1KBXkuzCVedY5
X-Gm-Message-State: AOJu0Yybiwxv6W0fvtikaF5TabE2uL2C70VawKRB3URZ/FYgGnB8vDAL
	JiUHkJCAubGsFz4iNANCCHEzxIKY+YMygSf184hCUkXWQPhMQEY2JO60X1YXnOg40NE8IPqdyBq
	vQsJhljgX7gw439gyS+relHdNsPM=
X-Google-Smtp-Source: AGHT+IE+c+ZdOXmBGc3GWGBArNuHaUYW7pUu2NOq0nVv7TTeFNzcJ/MRGEdssQkYOkouITD9YMFOcPhJlm4xc+GpLn8=
X-Received: by 2002:a05:6870:7e14:b0:221:c8a9:563d with SMTP id
 wx20-20020a0568707e1400b00221c8a9563dmr7791776oab.3.1710252587056; Tue, 12
 Mar 2024 07:09:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Ze9Ie67PCSvBU+og@MOLeToid> <Ze+JxSpqc/eHfCKn@aschofie-mobl2>
In-Reply-To: <Ze+JxSpqc/eHfCKn@aschofie-mobl2>
From: Felix Kimbu <felixkimbu1@gmail.com>
Date: Tue, 12 Mar 2024 15:09:35 +0100
Message-ID: <CAK=vLxKtR_rgU3A=w7AEddM4fbtTtmAQ85aCVHYbqyEXcjP=SA@mail.gmail.com>
Subject: Re: [PATCH] staging: p80211conv: Rename local foo to decrypt_check
To: Alison Schofield <alison.schofield@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 11:46=E2=80=AFPM Alison Schofield
<alison.schofield@intel.com> wrote:
> 'rc' is typically used for cases like this. If the name of the function
> being called is reasonably intuitive, then 'rc' suffices for the return
> value.

Greetings Alison,
Thank you for the feedback, well noted.

> 'Also' signals that this patch is trying to do more than one thing.
> One type of 'thing' per patch please.

Dan has already address this, perhaps, I did not write the message correctl=
y,
suggesting that the patch does more than one thing.

> The commit message prefixes are off. Please see First Patch Tutorial
> Section: "Following the Driver commit style"
>
> Patch fails checkpatch. Please see First Patch Tutorial Sections:
> "Git post-commit hooks" and "Understand patch best practices"

I will definitely fix these, thanks again immensely.
--

