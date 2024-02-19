Return-Path: <linux-kernel+bounces-71089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D01B985A083
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713371F2106E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6F925610;
	Mon, 19 Feb 2024 10:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="yMP09Cym"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DC025601
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 10:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708337180; cv=none; b=QddgaTTX8xlpYoq2/RAIJBP+AQxVKSxLsS48iehvj6Sred1rzgxgUZycsywYQnDRSkIAwpK5EJQSzmiA64WeHk19LVq0EzquEaHV+kSbscTLSQxI+2r5W1nucsKbnbxyXAeQwgz6xGGQyBmCgfPWzi20rn+kOLfGz1S8RU8yWmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708337180; c=relaxed/simple;
	bh=vYBRCWQn5pi6BftlC353rMYRDQYvAkyKACgB5eVnF3g=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=QwNdeVS0hKXUkI9RW/UORIKgXIxSPm6M3+vwgMzO3pg8OynZbBb+KOuMvDkqH2gO37MwygcdizfHVL6wExFUyw871ggyJtbsZA1kZeSugZ1IyED6sY1NnvrBfplq0YSiCN5kvNrutPcYkUJrew8Ng2XNhfFZ8lx5Y4QC9kIIjxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=yMP09Cym; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33d509c5706so390587f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 02:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1708337176; x=1708941976; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=vYBRCWQn5pi6BftlC353rMYRDQYvAkyKACgB5eVnF3g=;
        b=yMP09CymWl0tHkfF0ym2yJeh9fsDdUyUJzoAnfF5TApzCG3DoHuSHk/m8FbUm/RyiO
         q2NIHCLbBNhbPXi5GeR9xXOh0BtSgW5xkmCxhgDUS/pQCMLeWsx4tpa6zz3INN4h7tjz
         gkmpjOj07oMblg/WVzwvNzAPlk5mmE8ND6T24+u5sBViJZjGm/m1zi6ToYqJxF6h3/9c
         +7st40P2ZxKzxVkt2YSk3U9ROoGuJCkMsGBqMRLiLhdr5pxH47bxjmtAX2oyjTBz5bS8
         o0AAnooSgsj61et+IdQbScepfmO0Iu22b4xruFLKKpm2joVdOTHa858BUEvKEmKEIYML
         ms2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708337176; x=1708941976;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYBRCWQn5pi6BftlC353rMYRDQYvAkyKACgB5eVnF3g=;
        b=flpxwhFPwOwk/iFh6/UXGr4jFzpqGAAX9lZHY+NeOMm0++mOCS5/yKoN5cPmuxB+vQ
         dQY+s1MVf5vueAreYB3usvPWeYV6AezDABD7po63xEr8ctTLo8+OW6SpE9yTMBpGVBWq
         7t6pe6xVpGVr+kAFMZWVtU+PRlq6AzH2aurQf/bKTVfYoiWEFyP6gIqw0KqLbbdkxMf7
         p0Ga3rThzFgOtiWVPFkTcD0YApuNNi9PfYEdwGHQMzDzmwE1mG28FpjlzhBCRAYxzIam
         QHD4+GW9Ocp2DF0m29c0jCc1r2fnDlkyoWaV/qN644Pe6mLtmuUp0DwIdkJyc4A1R319
         t6Cg==
X-Forwarded-Encrypted: i=1; AJvYcCVpvdgy/u6JpXvu7zZPCyfLHIBCRHTt2vPxD1xPiNAFkcI9UlP5MMk6BHwVYPI/K7YndykXc/fTqOVX3hE/BJ7MpRYFLz/dhYFwR34M
X-Gm-Message-State: AOJu0YweditG3ZpY3uIjtRXHQFW8ba6/h4iACBwpLufSMDD+SdAxRtyw
	wHIfKE5O+yaqY2CaDGqLGXx3JyotCiLymvPR7snWQZisTrEYGJu4gxJI90wlT2k=
X-Google-Smtp-Source: AGHT+IHvaWFWKJICK4F7j0G/eSgGRsIOQzy0vgHZmI/yLOGmIzrOYxDsz1f7pKjzXKmoo5Qyz8h8rw==
X-Received: by 2002:a5d:648e:0:b0:33d:3bc2:7acc with SMTP id o14-20020a5d648e000000b0033d3bc27accmr3045129wri.11.1708337176264;
        Mon, 19 Feb 2024 02:06:16 -0800 (PST)
Received: from localhost ([147.161.155.108])
        by smtp.gmail.com with ESMTPSA id n15-20020a5d660f000000b0033b1b1da2adsm9842143wru.99.2024.02.19.02.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 02:06:15 -0800 (PST)
References: <20240217002717.57507-1-ojeda@kernel.org>
User-agent: mu4e 1.10.8; emacs 29.2
From: "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor
 <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno
 Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev
Subject: Re: [PATCH] rust: upgrade to Rust 1.77.0
Date: Mon, 19 Feb 2024 11:02:33 +0100
In-reply-to: <20240217002717.57507-1-ojeda@kernel.org>
Message-ID: <87ttm4g462.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Miguel Ojeda <ojeda@kernel.org> writes:

> This is the next upgrade to the Rust toolchain, from 1.76.0 to 1.77.0
> (i.e. the latest) [1].

I am a little confused about this patch, since 1.77.0 is not released
yet and the link [1] (currently) points to the release notes for 1.76.

Will there be a new version of this patch when 1.77 is released, or do
we just expect no changes to alloc when the compiler goes from beta to
release?

BR Andreas

