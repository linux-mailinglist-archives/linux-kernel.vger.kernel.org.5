Return-Path: <linux-kernel+bounces-59852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D4D84FC89
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A4181F251F3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C1982872;
	Fri,  9 Feb 2024 19:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFzAJbMT"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2720550241;
	Fri,  9 Feb 2024 19:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707505317; cv=none; b=lMbwhWdGbh/jETU1SrStiHfuwtz3EZjmCnIUMVVUPesr/sMjodaON0Mz9EvurDjtD5tl0+Gxczjs5PYJj6T+G/IX8h/wEKSFk6IIvwOGtSP1kPAkcgpcSPePOF5Mmh0G+3JY6BrdBKpPoBzZErvMvAyJ0MaKShL6PuI1KCuu3xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707505317; c=relaxed/simple;
	bh=mXnpjUMjZYmglO49XI5gBG1hSNgTF3CJvQfAO/EeFJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0m/ngVmhAVobQo8SpC3YNrvgXXYK8CCmNq0j0s0Yd5PWAPAnBSKhA0kNlxOOHa1HvHLwPdLkwp1/LaPzY2wPcPEmRaVhNqlu3AxK8cX6r8RVb349WKz2xY64O5O8PemDYZTOWuZ5O00obLJ5JRGRnlwGB6pAlLcDBOUUpxX4yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFzAJbMT; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d73066880eso11302985ad.3;
        Fri, 09 Feb 2024 11:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707505315; x=1708110115; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dTLq5cLd6EW0V+pCXvV5cGkaUzSdBm3QWfelUNi0RmI=;
        b=jFzAJbMT7zEthpuJ4hK+R03ZiMjVEzqTwvdZqotcEj5IICqqYC4v4YVs+YTZHVph2l
         SddUIWbPi5xc8SpXY3PDsejQkeMGbY8/AS3CtP6OCGjFJ2EJZ9K1kL0yurV3k3rCp7o1
         3+OI0u/CyEman0C2MBQ3BKHm65BAPzdYTVwPU+2xiWkXY5uz0JqkI9BuelX0SoZ+L+9a
         1FQmYAq4lGzzjZOIcqo+IyB3DhAdG9ncObXJTUVj1y/dz5lqIq7MopLup1AP1OdIcsVU
         Vnpf8WBec9eUl90pkx2lTO3Qjk19xvbJNhWfQMkrjQrj9FiY5VqBvbGqYO07xXm08AKP
         akrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707505315; x=1708110115;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dTLq5cLd6EW0V+pCXvV5cGkaUzSdBm3QWfelUNi0RmI=;
        b=F0i7w6/1aNRCbiOrroQXCDlgNXieCKalBtKX28Fm5izlgV+SNjyOdcZ+dYB0bsH6Dm
         W6/cacJunRJBYutz4wcWrcsjsSXiUAg28Tpem9u7TmbdP123v/dUwGTZCI9YF2cfA/uN
         5ztWW2cuuUxGIl8/jizr8vOp7x/MuLGZCRy6oxs452K4dEzYXBXfXin0zKsTKar3mTLO
         Sx5GGpbPOmN5Z0KiFSGaQyFf9J2UVZbfOtSyl6HTbHfoC+wk+DQP11Fx99+AR91vWPg7
         xUrNhkgL+R1iesnH8Q+7al7r1RfEKNt8QcVhC1T5cf+MVJ39usbGc6S5zEp339lGFAiD
         Qr2A==
X-Gm-Message-State: AOJu0YxjMptfXkYqoABN0JevS00feQhKQMWG0+0tehOha9NRYL4caVNP
	IvwFQOuUiHEPVMjIhZEqbfS4jIFZZqcpjt/W68IZXvyLsa9No8kk
X-Google-Smtp-Source: AGHT+IEwvQoB5TC1uIWbgDJB8SmCS7VztF3Xw9J74aun9ddu3TR8T3KHWNAiZQ0Np/1lMB9WBf2VjQ==
X-Received: by 2002:a17:902:e80e:b0:1da:1780:8b49 with SMTP id u14-20020a170902e80e00b001da17808b49mr228638plg.0.1707505315264;
        Fri, 09 Feb 2024 11:01:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUjoEMxNjLxC6GOol6lB7OSTSlHJOlWls8J/e10SG76ACkgM/Ro7WDvQcB3b0Ii/kS8FulfhCnUy/LlCYjFkTg1hKNmWG/kyRXpNdOmF467WzD+b554gPULeBDUZDzDzD/93ygbbvsVtsLMvbAZamLgf03EYUr+FK//4nJE/0iMz1BA2HpChpdlar6/Hvx+Zo9OjtCJyaQMqs4g3bqkIiE51Wb25xc3e9lthg==
Received: from google.com ([2620:15c:9d:2:9ec:8b78:c8c:fc9])
        by smtp.gmail.com with ESMTPSA id ks7-20020a170903084700b001d9033b9d8csm1833761plb.59.2024.02.09.11.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 11:01:54 -0800 (PST)
Date: Fri, 9 Feb 2024 11:01:52 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jonathan Denose <jdenose@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, jefferymiller@google.com,
	Jonathan Denose <jdenose@google.com>,
	Raul Rangel <rrangel@chromium.org>, linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: psmouse - add resync_on_resume dmi check
Message-ID: <ZcZ2oG1Rls-oR593@google.com>
References: <20231102075243.1.Idb37ff8043a29f607beab6440c32b9ae52525825@changeid>
 <ZcKs589qYxviC1J4@google.com>
 <CALNJtpV0KsOusPQeGv8bQ3jKy2sUj+k=mPHc172f+vMaTDYPfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALNJtpV0KsOusPQeGv8bQ3jKy2sUj+k=mPHc172f+vMaTDYPfg@mail.gmail.com>

On Wed, Feb 07, 2024 at 10:39:03AM -0600, Jonathan Denose wrote:
> Hi Dmitry,
> 
> Thanks for your reply.
> 
> On Tue, Feb 6, 2024 at 4:04 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > Hi Jonathan,
> >
> > On Thu, Nov 02, 2023 at 07:52:47AM -0500, Jonathan Denose wrote:
> > > Some elantech touchpads consistently fail after resuming from
> > > suspend at sanity_check in elantech_packet_check_v4. This means
> > > the touchpad is completely unusable after suspend resume.
> > >
> > > With different permutations of i8042 nomux, nopnp, reset, and noloop
> > > kernel options enabled, and with crc_enabled the touchpad fails in
> > > the same way.
> > >
> > > Resyncing the touchpad after receiving the
> > > PACKET_UNKNOWN/PSMOUSE_BAD_DATA return code allows the touchpad to
> > > function correctly on resume. The touchpad fails to reconnect with
> > > the serio reconnect no matter how many times it retries, so this
> > > change skips over that retry sequence and goes directly to resync.
> >
> > Why can't we do this in elantech_reconnect()? I am sure we can make it
> > simpler and more robust than what the generic handler is trying to do
> > with polling and everything.
> >
> > Thanks.
> >
> > --
> > Dmitry
> 
> I am fine with anything that would be simpler and more robust, though
> I'm not sure how to implement what you are describing.
> 
> Are you suggesting that in this PSMOUSE_BAD_DATA case, instead of
> using psmouse_set_state and psmouse_queue_work to call
> psmouse->reconnect (which calls elantech_reconnect)?

No. From the description it sounds like the device sends wrong/extra
data right after resume. I think you can handle it in
elantech_reconnect() method by draining the buffer or issuing poll
request or something similar.

Can you post the i8042 data stream that happens on suspend/resume?
Toggling i8042.debug option will cause the driver to dump the data to
dmesg.

Thanks.

-- 
Dmitry

