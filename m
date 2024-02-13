Return-Path: <linux-kernel+bounces-63454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1CC852FC2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5846A28AD2A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD9F37710;
	Tue, 13 Feb 2024 11:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MvhAkUC9"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FD3364C1
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 11:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707824614; cv=none; b=jPe5GSt0TXiDaqBPxGVexAW9Io2y8+TXBDamOyiFgrotIdcJqcB+begOIQmQ3EsxQXMmb1GQE66ofj8NyzLotmjbUksObJTEDgGXOdJtPbI5h8iQwIHpOkfMRtIGjW/0sM9RXdB+ByOKAJbkTge5B7QeYth2fdex4KpBguj4qbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707824614; c=relaxed/simple;
	bh=j0EcmW86LVwxDZD8jjvR3IIBsMo9Vd5fN53o5Q4wNco=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=ZqVRiGLElzwS1o7TPcXHSJGEfw4TA/9oDAy5T5gRSB/hYWSz5d0NRsuDzwd1x1QTkWkquS8Yg2BTqSB9Nh9d64bsVOQG2phVhY4Ojaogq+3TNZ7pcYTxREzAXsDnvXa5sMPP2eotLRs3gY3k2bDD7SEEj39/cjWompGEShAekLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MvhAkUC9; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33b2960ff60so3002900f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 03:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707824610; x=1708429410; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=E9Sow8wf4cLhsoNjPkxy+Vy7mK54b8EsDuIPycqqMjY=;
        b=MvhAkUC9tng24+xCuIdEMwNnVoqKqTUqsjzOwfRCIUcBsenLYgP3AnbEHrYA+o85u4
         tqFGfknQAezY3HaXNJL+W2xiWpXr1vsT814jBr5jVxCZnDBubbJJhsiXGGciPAxM2A1b
         BL131n7PmYd4ypfP0BZKhryTh/1j5RizR9BS1lRllGOwBaDum1LOJE1VLiVMD20edl2H
         URiNK1t9b3nNGfBpvu1hIqH1O1O6BjzkUeiBHvcsOahvX+mpgRtYL8XowyIPB+4Yy4gR
         muptTIiHU3464FcEeY3OxWuTCdFV4IccwREG/StJ2tVKMJUxqtk3PZ+rRchb1Ntua7XJ
         Wc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707824610; x=1708429410;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9Sow8wf4cLhsoNjPkxy+Vy7mK54b8EsDuIPycqqMjY=;
        b=qdLU95zfRwyEGYmrGi26iKouguF8uJ60HB+QC3apdojiscuIPNliZ5e/PTok0YVilg
         MLJkacTe9veKEKFHX3u6OmStYouW2aT9H6mZ36rFVOpyXpiGiqSa8KB+8FALCBjVtxMV
         g2F62pEAZF16dsf+g4DYHl0YHjk59ywBjF4JTjaSqfhdraQbhJveRHDStjmKbUtM41OH
         xt7IwjVrOjbZSZY7SZ/s3huTyi/hHKvPFR1QlfVXgYSIDWW5H/4eIDrqJLxXUeE5rydo
         rniUoHKSw2cwLy65KllMZDQ8XWN5vte18cl9qkOGcRfhQHc2DkxeKBbvvPQ059I5EXjl
         2ZfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxde7d/XYlweHBT/m2x48PQbNgyZWQxyvYl0izm//hyQqgI7gwn8ytG1RSLSginCM+njvKZOOQu5OvQ8pzlfiEaag9qB9Xg3DoFH3h
X-Gm-Message-State: AOJu0Yzn7PtT1w65hGj7i9AXnkCkkWfsObvvbXY1zR2s/h6DrfNBZtew
	dTmDNHcCO3IFUFMkZn5ECMu7GECRylhoBU9XFeL+4QQDZHNFoXRvZsoFYcLHoag=
X-Google-Smtp-Source: AGHT+IG5/46zhd1eOGmh0ra4YTAm6cqkOsrOZ3nHpxyZmRoQkb4L9iG9KRCKL7XD6RvIzjKFdLIpsQ==
X-Received: by 2002:adf:e501:0:b0:33c:ddf1:4e70 with SMTP id j1-20020adfe501000000b0033cddf14e70mr954874wrm.32.1707824610355;
        Tue, 13 Feb 2024 03:43:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV7XrcP98bixIaJaWBm55q3RGYgSAE7tBhAYxKCoTsFS3k+4Ze4N9ov5S7jgh/2kJS+irBO7hxgVQEv5sDqQLLxPDbHWC/Gs9TNJlYjDEdufmt8KqWgoLUap5P3RpuWSetm000MWsh8TG+RUnCiXYaeMS5P0KNR3vebzw4AK/Q7JSo2GChThL92QnUXlhhiqm3T+6Rm3bvBKFEBzRlNWsZ+oOtKvz4oZ5nrlk648f3KJ2YpB/AX8hYJ587hDFDHo7r1dZijD51CXUPKlm5Vvhyal5Vcu8pdKF6uRZUApCiCyWoYNna6+r1jeyiDnM+GrXyNfiI2jbQ39aZMPjTPS8Zd3pV6gPE6Q7iU5e+r5dq5ve8rVNhCu75nGRzfJSoMnFhhSRik6L03/9iH7StxCOiMjhlgvJXp0QLxcfnI7mQfyKBVWxmvK2n71BqvpzozyhkCuO8AO5J3tR81TAvxXYjA7ctciW/JxNy+0RD/Pu/DIgB3TrohH6Ieb4EtEjvFx//s0BbxRWmV5YdUNG0mEtgvFkabj7dgVuJmSkIyba37uRJ9Nj4vceMwV61cZXHq4Bloh/1m9MdaDSFr4L6+ysW0lgb2UhEH255fGSjDzoKUuGFhCI24w+H3rJL0zLOVpS/KYYbMSbqL1GxJsA+mmbtlzt0e6TZAQ/d1Iwa3
Received: from localhost ([2a01:e0a:3c5:5fb1:509b:4241:48a3:e3e0])
        by smtp.gmail.com with ESMTPSA id m18-20020a5d56d2000000b0033b60bad2fcsm9261852wrw.113.2024.02.13.03.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 03:43:29 -0800 (PST)
References: <20240213101220.459641-1-arnd@kernel.org>
 <1jbk8kk5pk.fsf@starbuckisacylon.baylibre.com>
 <c61d7daf-1b13-4ff8-aeae-7dcd8dd02131@app.fastmail.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Jerome Brunet <jbrunet@baylibre.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Arnd Bergmann <arnd@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Mark Brown <broonie@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi
 Iwai <tiwai@suse.com>, Neil Armstrong <neil.armstrong@linaro.org>, Kevin
 Hilman <khilman@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill
 Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] ASoC: meson: add helpers for clk_disable_unprepare
Date: Tue, 13 Feb 2024 12:09:52 +0100
In-reply-to: <c61d7daf-1b13-4ff8-aeae-7dcd8dd02131@app.fastmail.com>
Message-ID: <1j7cj8k2se.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On Tue 13 Feb 2024 at 11:52, "Arnd Bergmann" <arnd@arndb.de> wrote:

> On Tue, Feb 13, 2024, at 11:36, Jerome Brunet wrote:
>> On Tue 13 Feb 2024 at 11:11, Arnd Bergmann <arnd@kernel.org> wrote:
>
>> This probably pre-dates the introduction of devm_clk_get_enabled()
>> It would probably be better to use that instead of duplicating helper
>> functions which do the same thing.
>
> Ah, I had not thought of that interface either, so you are probably
> right that this is the best way to do it.
> Can you send a replacement patch then and add my Reported-by?

Sure.

How may I reproduce the problem ?
Just tried with 'Debian clang version 16.0.6 (19)', no warning.

I suppose I need to add something ?

>
> I also sent the same patch for drivers/nvmem/meson-efuse.c, which
> I guess will also need the same treatment. I also checked and saw
> that all three files already had this code in linux-6.0 when
> devm_clk_get_enabled() got added.
>
>> If for any reason it is not possible, a common helper in clk.h would
>> preferable I think.
>
> I can't think of anything that prevents us from using
> devm_clk_get_enabled() here.
>
>     Arnd


-- 
Jerome

