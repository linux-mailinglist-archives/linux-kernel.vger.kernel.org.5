Return-Path: <linux-kernel+bounces-4034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4298176FD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2E431C22532
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9659E42042;
	Mon, 18 Dec 2023 16:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsqVrdQl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6963E3D56F;
	Mon, 18 Dec 2023 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-591487a1941so2476198eaf.3;
        Mon, 18 Dec 2023 08:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702915708; x=1703520508; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sVPPzIcxJTHHwl2PGodBQ7T+AVsNaRwSVhdAPKqSJh8=;
        b=HsqVrdQlNkvuqUXf8bZonB38t12k4Vm82uYzUKsWeJYouQ7ivb00KIpnZL9R3HEGmk
         KV12cKgBJUNaybWLUfiJpuagjxE9+PKXBJIQlzzGYzSC7hQuOwpLWhHgNibyGF+oYLO9
         Qvtaqnlw9WrHOG8+pF8IWW0uddSFrkF5RHSb/cADRVzL2/9i+2jRqFteo+1VlmTUKxed
         DuFJuTIOJVUCtkNkDH2oyA5iejOY5cOFLsA3V7ChNuVmMthv87uOgkU6qXuCQL5zCE3d
         5WFXBH7FqqlpPoRLagoCT3Nxi+vWpcbRHSoDYOYgAy10J/7vXekUN0fj+qk04b09INrJ
         4TZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702915708; x=1703520508;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sVPPzIcxJTHHwl2PGodBQ7T+AVsNaRwSVhdAPKqSJh8=;
        b=eDOvExA2zOaBHBtS0j/mwbrFE7OpjydeQqVu3lYmmf92Jrofjzgtv772AD0FyZhChn
         PEj6eGblc/HXL4DsufRSFDiTRnNV0Q4rH40vamTBUf2vuetxfI1kJMj3hyJUzA4oV+3Q
         HH583Aoj1BAc+3SfoWGuru64SRel0m9bseyEfYw0JelczdUQ2IpVBD/r8N3z0R8dhMdb
         1K5hJHyG+6FvPkHS/CuqMA4zhsvAi5KVP1iy5PgNZiXCXMxeISEc7g44bQx8HeS1iAzB
         35YzmrOrGiFejZt6p3zWRJlFPS5JNgcdZ4sCmJOCXyJCHDBWClfZiOy3rB4ht70Qc13V
         /l5g==
X-Gm-Message-State: AOJu0YyrdNFM2KcTJSXK3zbod6nBbLSd/b9jvAmC5cVE107ua5ZhPuyp
	U9cTlJgB6l/miNl8Ske77P0=
X-Google-Smtp-Source: AGHT+IH3hyB/OHezF8gVk8v+Ju9d9lXTX+94o1lL+vFj9yEr44sc4odT+aLOuG8bf4wdn2R0dbmHKg==
X-Received: by 2002:a05:6358:6f14:b0:170:68c8:1894 with SMTP id r20-20020a0563586f1400b0017068c81894mr16775514rwn.64.1702915708501;
        Mon, 18 Dec 2023 08:08:28 -0800 (PST)
Received: from rigel (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id w22-20020a63c116000000b005cd9bc22bdfsm2042605pgf.87.2023.12.18.08.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 08:08:28 -0800 (PST)
Date: Tue, 19 Dec 2023 00:08:23 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linus.walleij@linaro.org, andy@kernel.org
Subject: Re: [PATCH v4 1/5] gpiolib: cdev: relocate debounce_period_us from
 struct gpio_desc
Message-ID: <ZYBud4tobG3x9Zhh@rigel>
References: <20231216001652.56276-1-warthog618@gmail.com>
 <20231216001652.56276-2-warthog618@gmail.com>
 <CAMRc=McBVeQ=yRpGRsnPEULfPx15PBO3kiGscdS4s6-d0URc3w@mail.gmail.com>
 <ZYBoA25z76uutBBI@rigel>
 <CAMRc=MdKfs1ok2KgkO0C64cA9k8bOupxsjReBMQSdZbP+MQMCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdKfs1ok2KgkO0C64cA9k8bOupxsjReBMQSdZbP+MQMCQ@mail.gmail.com>

On Mon, Dec 18, 2023 at 05:01:32PM +0100, Bartosz Golaszewski wrote:
> On Mon, Dec 18, 2023 at 4:40 PM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > On Mon, Dec 18, 2023 at 04:24:50PM +0100, Bartosz Golaszewski wrote:
> > > On Sat, Dec 16, 2023 at 1:17 AM Kent Gibson <warthog618@gmail.com> wrote:
> > > >

> > > > +static void line_set_debounce_period(struct line *line,
> > > > +                                    unsigned int debounce_period_us)
> > > > +{
> > > > +       bool was_suppl = line_is_supplemental(line);
> > > > +
> > > > +       WRITE_ONCE(line->debounce_period_us, debounce_period_us);
> > > > +
> > > > +       if (line_is_supplemental(line) == was_suppl)
> > > > +               return;
> > > > +
> > > > +       if (was_suppl)
> > > > +               supinfo_erase(line);
> > > > +       else
> > > > +               supinfo_insert(line);
> > >
> > > Could you add a comment here saying it's called with the config mutex
> > > taken as at first glance it looks racy but actually isn't?
> > >
> >
> > Sure.  Though it is also covered by the gdev->sem you added, right?
> > So the config_mutex is now redundant?
> > Should I document it is covered by both?
> > Or drop the config_mutex entirely?
> >
>
> No! The semaphore is a read-write semaphore and we can have multiple
> readers at once. This semaphore only protects us from the chip being
> set to NULL during a system call. It will also go away once I get the
> descriptor access serialized (or not - I'm figuring out a lockless
> approach) and finally use SRCU to protect gdev->chip.
>

Ah, so it is.

> > And you wanted some comments to explain the logic?
> > I thought this is a common "has it changed" pattern, and so didn't
> > require additional explanation, but I guess not as common as I thought.
> >
>
> If line_set_debounce_period() could be called concurrently for the
> same line, this approach would be racy. It cannot but I want a comment
> here as I fear that if in the future we add some more attributes that
> constitute "supplemental info" and which may be changed outside of the
> config lock then this would in fact become racy.
>

If any line config is going to be changed from the userspace side then
it will be by the SET_CONFIG ioctl, and so be covered by the config_mutex,
but it can't hurt to explicitly document it here as well.

Cheers,
Kent.


