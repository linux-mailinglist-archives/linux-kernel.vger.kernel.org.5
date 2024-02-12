Return-Path: <linux-kernel+bounces-61704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D479A85158C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 129551C20B65
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC1E3BB26;
	Mon, 12 Feb 2024 13:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDI2BUWF"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EAE3A1C9
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707744962; cv=none; b=A4MElUkYoLM2+O8/HSfTP70vhXA/9c7q9YDm31rOZgJJhFkH499VCb+PbYvxwxaXSyXxAS0G7jErIPcwmBIzQuRRW34s2pY7DJB6ORTzitpHJAZW+SC1TxhuqHXpDHxnLr4GlTLysYyfH3SGnZ1u18krEGVeMJNYpYtG/Rl0c1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707744962; c=relaxed/simple;
	bh=ID6fgbHIriXzsFWD9h1J/HknENOu7mtqM9iVqBiNICE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SN/k7HBX5pMm+iUlzAjHe2avZ1jRuQv/T7Qd7FvqBLTFRA6UGuxAVIr7+0GT9sed0hZu4MI/ga8JsWz93WIIE4CXMXjcDHY8m4ENeP91K3sOXVECbISdV3TVgpojHSKPC1y3Ep9eOv5pvKWT0PU6Ivz02gvJZ0bmKsX2AV0iHSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDI2BUWF; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-604b94c0556so22629477b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 05:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707744960; x=1708349760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ID6fgbHIriXzsFWD9h1J/HknENOu7mtqM9iVqBiNICE=;
        b=aDI2BUWFZanp2jAEexkB3EnVGlQgx0fBENqsF+zCCYqVnUPGTyHNlOtWtty8a4zKza
         QqIVj8bJ4mq6Ycj3p9JCHJYLb5+ZYBpJDfog5EUVmixsSZxh/m3ZChiNT4GXyN5jvWUu
         L9gIor58rhbT8Igs/TD7N+t0zAN0EFXJvHC0Jxwn0kvzHlUF0CVQZ2pHt5NsJMIUNz8f
         JrXwfQW+l5pzaamTTMQARagMbi68ZJwHMxdD84GnCrekWR2T9tlaekyqyuDtjFseeQOo
         RjGEQJ4dPTqzvyIHGRLcnFA97Mm3z7dqWuoOjXPuGFHgMKm/kxztMobi7foX+4OuGbn1
         Q6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707744960; x=1708349760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ID6fgbHIriXzsFWD9h1J/HknENOu7mtqM9iVqBiNICE=;
        b=ZZA+s09w1NonyIui+SQWOU9/Z0mjthrk40aZiNPt8TqSeVoYZg546Gs6f+2KN0qd/s
         chJXu/t2V7+hNog58bawzj+ZMx3nzNrUxOiKz5qzoxmU+DCnwcu7VLLihAZSt/TbmWYP
         ylVQct2V/Y6GbRzEI/epkgqn9QJwmyaOMHC59sFsbDIeJlVgJXjLEGdDG1zi8Ih65SR/
         FWkyJwbbHLCT1qWuU8EDnjKr9oNeO5a8B7bjq3h0kFqoPIgvrrQTsPzFsgAMcWsz53th
         Pa5TRw1/D1GqUoKlfewXPj6CFN7p/FtKLkjEZ+E4tNPo1fOppUw2YI0Dordz0ud21ejh
         vabQ==
X-Gm-Message-State: AOJu0Yw1LK6Y1q8Cx6O+Nsr/bPwEvhMD1BACF4epPpXvAqDmdlHi6u57
	YEQKmEIyJylyn8jN9p/6IYjy4PMwYqrc8NJ5WgkWHNd6if9JVT3H49rDRm0Gd5K2gPNH+fGNIKa
	O7ckoQfACSYD7zB3P0o8aRwNoKGE=
X-Google-Smtp-Source: AGHT+IHtikm1xzMnoru26iO5bcM8x244FUoaHl/+476ymlW/Kj6bX1YOXyrtrwWkRXQwSvXivQ4cZ0lzelcGO4L8xVY=
X-Received: by 2002:a25:b1a1:0:b0:dc3:71da:35b0 with SMTP id
 h33-20020a25b1a1000000b00dc371da35b0mr3460772ybj.16.1707744959791; Mon, 12
 Feb 2024 05:35:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212113653.2625776-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240212113653.2625776-1-andriy.shevchenko@linux.intel.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 12 Feb 2024 14:35:48 +0100
Message-ID: <CANiq72k-oqVqDGyxqR1pZzwUqpQcFvx=T68BrmLEGDFMY4L3Vw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] auxdisplay: Take over maintainership, but in Odd
 Fixes mode
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 12:37=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> I have no time for this, but since it looks like I'm the main
> contributor for the last few years to the subsystem, I'll take
> it for now. Let's see how it will go...

Thanks Andy, I appreciate it -- with Geert added as reviewer as
discussed privately:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

if you want to already take it yourself :)

Otherwise I can pick it up.

Cheers,
Miguel

