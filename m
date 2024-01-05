Return-Path: <linux-kernel+bounces-18386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 422B9825C50
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 23:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD7AD285B81
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 22:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA0A224FB;
	Fri,  5 Jan 2024 22:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aKHfox9C"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFB022EEA
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 22:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-336dcebcdb9so42984f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 14:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704492187; x=1705096987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fl326ppApdtYpQa2z7hCEBAekt98FBC4Zvp+AcKVEdg=;
        b=aKHfox9CUxXFe80IoiEtQliTTzLex2k+5y2XD/hRFdM3gbdXLu4SqdZsh2+DU1rmjb
         ZvOiHUer7v5MyqubweDxWytgH3iGi0bJ1LAr5jSSJhF3PC/ScL1nOgWpGYShDSU9V6OE
         V7IXUMGpvoTAt8Rirq+hxRHFItZWcs92BGvqa3zUKqZNXfzU+hBuqH/5whqWzp29eY2y
         MjL8KS4E1usUCOI4/Tc6nK38n11GPjJVflErze6PNKIYHZZ+Al88ntChvZzZQ33rVNYq
         gZsELD6tS6mbqmFYlQcvN4jpz/XhbfFtgrhUOhR1ki1AJBauip/TAKLR269T5Q05NtS/
         Awtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704492187; x=1705096987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fl326ppApdtYpQa2z7hCEBAekt98FBC4Zvp+AcKVEdg=;
        b=HfLrMGPmD5fl+cjgYqYDRdhub8y1zZNEaC3ZvnYTvBNhIfp+4D8BhrTfzcXKXGhu36
         KW9OcP/Rj108Z+Vn8pvmYUiiOgc9Ory1maoiQ8ftrz4UffbqZyjl2kWviQnTOaPJZ+Hs
         JM8cZSgoMmr9AVT292fm+pCtkecJ92NwBZuv4gT6AJa1rfDg/I5UrnYD1nXpqv+QvcPm
         ou/ZhGF393GB2CrTIcNeptsQXVj2eF1pLRT4I3n/SGsTtzVPKtdqxq87hkha9zO0BqYo
         OpYObCAEhBnNf4LVPYlK9B9X1NGBzrisPHzX6jWZSaEwAuc/8D6eEdpTpJBaHYm9FJaq
         xKFA==
X-Gm-Message-State: AOJu0Yxp9Gy5PiUu9/mqZMIBGJlAUVJq9oOl+nZh0Xj5MSRD4/KFI7m3
	TzQZbQfvqnAxeVmNNThnuM3chl7x1gprdQvLv/FyTIPWMQPp
X-Google-Smtp-Source: AGHT+IGHIFilgAST+tnw594t9jW9/9A9DfU8mcF++MGui+youXLTsYZZhoiqtZBbHwS3Jo40asWBzTeBdQCtOKf39lU=
X-Received: by 2002:a05:6000:1287:b0:336:79c1:571a with SMTP id
 f7-20020a056000128700b0033679c1571amr24552wrx.139.1704492187436; Fri, 05 Jan
 2024 14:03:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105-newemail-v2-1-a7fdeaa0abdc@google.com>
In-Reply-To: <20240105-newemail-v2-1-a7fdeaa0abdc@google.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 5 Jan 2024 14:02:56 -0800
Message-ID: <CAKwvOdkKDQtdaBKJTE4uAv52Qu-cFgKL=gT-KCs_pFjy9KcYDA@mail.gmail.com>
Subject: Re: [PATCH v2] mailmap: Switch email for Tanzir Hasan
To: Tanzir Hasan <tanzirh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Tanzir Hasan <tanzhasanwork@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 1:57=E2=80=AFPM Tanzir Hasan <tanzirh@google.com> wr=
ote:
>
> From: Tanzir Hasan <tanzhasanwork@gmail.com>
>
> Access to the tanzirh@google.com email will be revoked upon the end of
> the internship.
>
> Reviewed-by: Nick Desaulniers <nnn@google.com>

Sorry to be pedantic, but please keep the RB tag as it was provided
privately (i.e. using ndesaulniers@google.com) (in general for kernel
development, not just this patch). While I have the alias nnn@, I
don't use it for kernel dev and would prefer to that not to
proliferate.

> Signed-off-by: Tanzir Hasan <tanzirh@google.com>
> ---
> Changes in v2:
> - Fixed alphabetical ordering
> - Link to v1: https://lore.kernel.org/r/20240105-newemail-v1-1-c4e0ba2c7c=
11@google.com
> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.mailmap b/.mailmap
> index 9a9069235f0d..36d5bd3fdc8e 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -578,6 +578,7 @@ Surabhi Vishnoi <quic_svishnoi@quicinc.com> <svishnoi=
@codeaurora.org>
>  Takashi YOSHII <takashi.yoshii.zj@renesas.com>
>  Tamizh Chelvam Raja <quic_tamizhr@quicinc.com> <tamizhr@codeaurora.org>
>  Taniya Das <quic_tdas@quicinc.com> <tdas@codeaurora.org>
> +Tanzir Hasan <tanzhasanwork@gmail.com> <tanzirh@google.com>
>  Tejun Heo <htejun@gmail.com>
>  Tomeu Vizoso <tomeu@tomeuvizoso.net> <tomeu.vizoso@collabora.com>
>  Thomas Graf <tgraf@suug.ch>
>
> ---
> base-commit: ac865f00af293d081356bec56eea90815094a60e
> change-id: 20240105-newemail-ccd4a5db700d
>
> Best regards,
> --
> Tanzir Hasan <tanzirh@google.com>
>


--=20
Thanks,
~Nick Desaulniers

