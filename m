Return-Path: <linux-kernel+bounces-154878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 439078AE260
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE804283B8F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBADD5FEE6;
	Tue, 23 Apr 2024 10:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q82WsPe0"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F798481D1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 10:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713868641; cv=none; b=qGPYqcdP2oHINi0Pul7LrYNJnb1FhAOM6ypxm5Bjs0dodfC7Ol0yDoY8DHFVhvZc6teN1cBf0bXhJsyg9AYH362pF6JDAMJRQkNlcgryTz4qxyZ8iaQpz99nbTU6v4VxoODU0TYaIi/RfyNlxX6KTWJKbbNoLqfi7PkufTSYc4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713868641; c=relaxed/simple;
	bh=GwRtUr6gtqGKN2XBp8si19LOYfDcQhuRzWg2az31ZlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oocxppgBr+jBPyiXMNYsRM7yQcPARhGmMyFShea0Mpnz5DIlxrcKTQrkMhgwQER/1KN/z+s4IWJ10EepvQPWPiu5dTycXfzoR0XBXdQXCktXEyd8SjDHklZzibBy5/hkrRagHPznbDYu7VivLtlGkhyeVRzecxiMpDgaF0gVlN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q82WsPe0; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41aa15ae26dso7877495e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 03:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713868638; x=1714473438; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f1GtuAnGuJIGmi4Nj3I/YO3XIATvrNjSsCDRrmOKdN4=;
        b=q82WsPe01V5/Sl0RcDNMdzwE63weQp4khO33A0ROpQqMUBM8uS+SvQhl4wT6oprLF3
         m42okMIe46Tsj4+G1DSQ9wAZt7ClxlDToC9Q4tcmPblXLexaKRqmbkZkxWGgmyVNjKLw
         WTU7TvVOAuE+++raMn4KxwkVaN3SnH3cTKhIUccpLe38KJZbZzjIyQM/uWRkw3PsXMAn
         tylol34UF6aBDzQzroH0XQnqO3hyJv+ujhix1+Dr/8t6tvZyOGTdRP7duyN8MlPxgByZ
         UJW2ZRTsX9oCns1U7yqR1uKXkLck/BAjt6a9u0VEYUSiBuZMj/lewP/TDMlfUTnQLsK6
         mjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713868638; x=1714473438;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f1GtuAnGuJIGmi4Nj3I/YO3XIATvrNjSsCDRrmOKdN4=;
        b=BsrcYhlNUM+kppCw4d/2P7z3On/JqvNNZ9a7xdFLuQnwM17PyuPui+Y7WjgFd47e4V
         K8jpSrmKo3A5bNFNmvpSSsd94RDv2D9/Xr0WHiVgwKe2kQe/biyZcn938YeKHIkbDtaL
         CQlpnFpz5QqAUo2d5Mw1jKO4A04iLdrTDDWc7TNVW7XKz5pv25xadzIYit0tGQ7VxqjG
         7keik4G6qq35a++VoQX7YN+PUNLAqPk3I8I+qmXcB5Kke21HuQDMgengtYov1h6LwA5I
         H2CJbwJvZtAcHZ6jLz5vMY4jJZwdokvtRSB9H3Rag+yUnQeLLi79ycrohHuJdnuUz+wo
         yI8A==
X-Forwarded-Encrypted: i=1; AJvYcCWdgy4EjIKRu6+yn8SDFe9kq/kEcPMWqUdqwAwZ9Z5gl56xtr5/CbDslyPmtGljSAWPcLiTTAw3RUCCnKaNxLSPZuvL1GqoDUqsmzJz
X-Gm-Message-State: AOJu0Yz/FMPx0MRFzXLqqnpJiMJEyAxnvQaEJtY/MnVFK6Lm6SaOF6E0
	wye/YfMcf+ZKKLSTsa8um1gU7Aqb+V5sgDOmAILPNujOLo8PSKPWlUOuNjsQGIQ=
X-Google-Smtp-Source: AGHT+IEH4u6S6D3wRTzN4LoL8l6ZdRFVF5WlLyRo5GBP3Ye47cGr849oyji7omkAYtv3mN9qFEIfTw==
X-Received: by 2002:a05:600c:3c95:b0:419:f126:a46d with SMTP id bg21-20020a05600c3c9500b00419f126a46dmr6803385wmb.30.1713868637635;
        Tue, 23 Apr 2024 03:37:17 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id bd6-20020a05600c1f0600b0041a7aa23dbfsm5003551wmb.48.2024.04.23.03.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 03:37:16 -0700 (PDT)
Date: Tue, 23 Apr 2024 11:37:14 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Jason Wessel <jason.wessel@windriver.com>,
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/7] kdb: Use format-strings rather than '\0'
 injection in kdb_read()
Message-ID: <20240423103714.GB1567803@aspen.lan>
References: <20240422-kgdb_read_refactor-v2-0-ed51f7d145fe@linaro.org>
 <20240422-kgdb_read_refactor-v2-2-ed51f7d145fe@linaro.org>
 <CAD=FV=VXFHqOatn3cvwvYCey53+zuzB7ie4gYdvDVbfGL=Qm1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=VXFHqOatn3cvwvYCey53+zuzB7ie4gYdvDVbfGL=Qm1Q@mail.gmail.com>

On Mon, Apr 22, 2024 at 04:52:04PM -0700, Doug Anderson wrote:
> Hi,
>
> On Mon, Apr 22, 2024 at 9:37 AM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > Currently when kdb_read() needs to reposition the cursor it uses copy and
> > paste code that works by injecting an '\0' at the cursor position before
> > delivering a carriage-return and reprinting the line (which stops at the
> > '\0').
> >
> > Tidy up the code by hoisting the copy and paste code into an appropriately
> > named function. Additionally let's replace the '\0' injection with a
> > proper field width parameter so that the string will be abridged during
> > formatting instead.
> >
> > Cc: stable@vger.kernel.org # Not a bug fix but it is needed for later bug fixes
> > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > ---
> >  kernel/debug/kdb/kdb_io.c | 34 ++++++++++++++--------------------
> >  1 file changed, 14 insertions(+), 20 deletions(-)
>
> Looks like a nice fix, but I think this'll create a compile warning on
> some compilers. The variable "tmp" is no longer used, I think.
>
> Once the "tmp" variable is deleted, feel free to add my Reviewed-by.

Good spot. I'll fix that.


> NOTE: patch #7 in your series re-adds a user of "tmp", but since this
> one is "Cc: stable" you will need to delete it here and then re-add it
> in patch #7.
>
>
> > diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> > index 06dfbccb10336..a42607e4d1aba 100644
> > --- a/kernel/debug/kdb/kdb_io.c
> > +++ b/kernel/debug/kdb/kdb_io.c
> > @@ -184,6 +184,13 @@ char kdb_getchar(void)
> >         unreachable();
> >  }
> >
> > +static void kdb_position_cursor(char *prompt, char *buffer, char *cp)
> > +{
> > +       kdb_printf("\r%s", kdb_prompt_str);
> > +       if (cp > buffer)
> > +               kdb_printf("%.*s", (int)(cp - buffer), buffer);
>
> nit: personally, I'd take the "if" statement out. I'm nearly certain
> that kdb_printf() can handle zero-length for the width argument and
> "buffer" can never be _after_ cp (so you can't get negative).

The kernel will correctly format zero-width fields... but kdb_printf()
will also inject the empty string into the log if running with
LOGGING=1. It is true the dmesg output with LOGGING=1 is pretty nasty
when doing line editing but I still didn't want to make it worse!

Oh... and we can't combine into one call to kdb_printf() since that
renders into a fixed length static buffer and we could get unwanted
truncation. I might just add a comment about that.


Daniel.

