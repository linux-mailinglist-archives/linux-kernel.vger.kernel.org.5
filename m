Return-Path: <linux-kernel+bounces-49108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8BF8465EA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 03:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B4CC1F2350E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA1BEAEA;
	Fri,  2 Feb 2024 02:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ck5Q2M/k"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95625E56B;
	Fri,  2 Feb 2024 02:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706841071; cv=none; b=Yhd2FsLjbl067W8R5JuoVKDDUF/35UxzIeSXvoxn3IZNgCqLygf9f4Vp2n+yKC0nnUtZzcIBIOeykiacgeWdwjbTCtBNKBH0QRKnpjNOIop8ySTJL7l2K0m4fO6IcKKkKLdZsjwPVh8Q2EY3QRNUz/bwJbkmzCQpARWOYTYkR/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706841071; c=relaxed/simple;
	bh=+yWBFgqsLJb+DfB4+lohr/565RIudwuQoPMSMCPgiEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KTvFX9R7VmIslUbYdDModzoBzAV0zzlmkLemq6HP28Xz/Xxy/Ix8rEy7ZBBY+RC/7H/Ugug8xGcb3zZNbdLyXCdJJA9QT6bK+WivSVt9ntRQYVLaffsdWEwz7xJNcumITgnyivEI8CtFRzh1L04H4NNNK44/z+k8BaF/H8fGH94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ck5Q2M/k; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5113191f3c3so410672e87.0;
        Thu, 01 Feb 2024 18:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706841067; x=1707445867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l99B5IUgp/QyIWazijcr0QOYcEJaWP5wOJ89lKkwdd8=;
        b=ck5Q2M/kU9x0oU1sWLTmJ9Rehhuct+k+yhcoqxZ890e1KVgwoZldycD7TCSoN2oQGv
         Bckbf6od2MsLcF9crr6nqFZ4UA30KoqMIYk2cWPWxv/Lun8tSuK5yqLPEDvHlSwS2E0n
         7aAdxc/Dp/Kl7ovnpK5eZ3ZeGtiPu1KiiKxK0S3aUNNC+zlI0rTZF3K7OFylzWb1tZKl
         fGrFLmxM3bxxMvxuhdQWUp88sIaxv2RcgwXb1+qoOhCrV/3lfs52zzInIvieIRZN3omD
         mXDX6vhFsU/QydmylEVLJqBNJPp/6NvK+KnduiaFZvgcOFiAenuf5U/uWHGagMy8SPkS
         c8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706841067; x=1707445867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l99B5IUgp/QyIWazijcr0QOYcEJaWP5wOJ89lKkwdd8=;
        b=f7gpagqfQNWPH+DQVorVJV4IuSZEZTuRn84bmGG8zXwhBiVasgCotSe5MXGgrrL5eP
         6QHKP8Vfiz3V7hq3qXpHmLmOWu/ySI7xpt2+UM+nxAOyEAYUFWQL21GPBZPwueUKylaX
         zeLxNl8XyJQ8sVAWJZ3HB89h2QI128M+hC0ccmoXXoz90reFkpoEM4lIFANu0aYGch2O
         cG00JHS7Cgx9vilNx/mzP8vY1t2LnZxxCV5nigjleCpC8j65dASV4jeYaQE3WGwu+KEE
         3M0yzsNC+XRadc4l+ea4q6aOhJSzYEPOqkPOgZwSh7gVhPS65FUHawNJ9ql1yO82k5GO
         Or2g==
X-Forwarded-Encrypted: i=0; AJvYcCUpOQexrkII5UqD3Ys9tH7bTdClZOsipxxXylOXkZW4SSWfRraT18t6vmCHIzacBLbhf3dG/xVYfbqq5oKw0lsegIJnU/O3WqdkslWyGfAaWUBbN+I19+vnD7SlhA4W5i4oahVAedjupls=
X-Gm-Message-State: AOJu0YyWfTKLcN5vOCJkIxcG/BPJkC8Zt3TgI0FDZFnQ5E4oJ8IXSGrs
	PqLvSSxXsb8PZpv4M85ZQvYDu+A1StQnVyR8b2UNuFy2C3xbmKTLAy6+3aPsrm0limKBAv7GPAt
	uFZlztZcAIRY9X5GKScKEVP56f3+Zxf6YUaP9rA==
X-Google-Smtp-Source: AGHT+IH/WCkGkOlIZ5RVRugk5Caf3wHPCOQZPMfFpuCqEQlRXSSVK1vGqUq2hkqY2MElIL55i6YENWOpqCdWfS79Wmo=
X-Received: by 2002:a2e:7d10:0:b0:2d0:727e:79a6 with SMTP id
 y16-20020a2e7d10000000b002d0727e79a6mr2707828ljc.1.1706841067128; Thu, 01 Feb
 2024 18:31:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201115320.684-1-jirislaby@kernel.org> <20240201115320.684-3-jirislaby@kernel.org>
In-Reply-To: <20240201115320.684-3-jirislaby@kernel.org>
From: Ping Cheng <pinglinux@gmail.com>
Date: Thu, 1 Feb 2024 18:30:54 -0800
Message-ID: <CAF8JNhK+LSxg+wj3Ms46HhmETj3ymtEThnDBNHaWHbAZiGqsqA@mail.gmail.com>
Subject: Re: [PATCH 2/7] HID: wacom: remove unused hid_data::pressure
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: jikos@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <jason.gerecke@wacom.com>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 3:53=E2=80=AFAM Jiri Slaby (SUSE) <jirislaby@kernel.=
org> wrote:
>
> The pressure member in struct hid_data is unused. It was
> added in commit 5ae6e89f7409 (HID: wacom: implement the finger part of
> the HID generic handling), but never used.
>
> As this is not a struct to communicate with the HW, remove that member.
>
> Found by https://github.com/jirislaby/clang-struct.
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Wacom current touch devices do not support pressure. We could add pressure
back when it is necessary in the future. Thank you Jiri.

Acked-by: Ping Cheng <ping.cheng@wacom.com>

Cheers,
Ping

> Cc: Ping Cheng <ping.cheng@wacom.com>
> Cc: Jason Gerecke <jason.gerecke@wacom.com>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  drivers/hid/wacom_wac.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
> index e63b1e806e34..6ec499841f70 100644
> --- a/drivers/hid/wacom_wac.h
> +++ b/drivers/hid/wacom_wac.h
> @@ -309,7 +309,6 @@ struct hid_data {
>         bool confidence;
>         int x;
>         int y;
> -       int pressure;
>         int width;
>         int height;
>         int id;
> --
> 2.43.0
>
>

