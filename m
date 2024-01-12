Return-Path: <linux-kernel+bounces-24278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 150A682BA32
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 04:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99B21B22AB7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 03:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554AE1B285;
	Fri, 12 Jan 2024 03:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NFFdl0X1"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF9D1B27C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 03:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cd33336b32so79573641fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 19:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1705031606; x=1705636406; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c8TuUZrhjbDv+Rm2dZnvkGXea+jXRSU7uK9nGbNFVT0=;
        b=NFFdl0X1G3p8DhKmNxujey2OC5aml2O64i3JvPfuI9optu+vDKOTr5MhREt2hKUtDL
         Jzr6CoFNHGlgwVEmXIvQob+omIyNVkVNpgcK6YyYZ46dmC++oIEp1OyVGnA3OGta6qYZ
         bHY5nkx4Nngnz34KerCEZqlknyJ9hQYYRCyxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705031606; x=1705636406;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8TuUZrhjbDv+Rm2dZnvkGXea+jXRSU7uK9nGbNFVT0=;
        b=rordPa8XosPni0fm6/jE1rv2xW6TxeGoMGAe/i1rmpgsQWpymJgixNgkcg7SUMaYwI
         8URvdPRxjLNHFWn6W3gARwb8L6rv87UikgJXZi6sjP4GFrecxsg8OhsKuR0tE+1Yvt2p
         c+qpmDjOfP5g7dYplBgRaL1OYFDd6az2mZRVQoPT8dyQL4lU7Be6l/2vtS0XPDi7gfv4
         Xvwhf+Q9Ddj25rk2zhOLg4UdXC43hoiO0tsK68OQ2fPu1Ob4S/Fy9PjT1ViNvLTclAXb
         JzPm59jqzJ3vLELAQuYpRvgSN0pAiIsY3jIB1TzPpvIbhymjll8MrxYA+OaTA0MMsGDG
         ECjQ==
X-Gm-Message-State: AOJu0Yw+qExGDGaPCh+ct4ITPyXOOxmmvUcR1IK8ef2bGEupgX0Rzs43
	XyU5gYwwRh/MPChPIyhu3wy1xUkosvHyaroG/d00NJKGzYwECIz0
X-Google-Smtp-Source: AGHT+IG97+w9x8KwcaBvzPg/kgdoz05ZabfBKnhPT6tGxqg2rkirRDld50IW0t3nkaCDZTqux4v/2w==
X-Received: by 2002:a2e:850d:0:b0:2cd:7940:706b with SMTP id j13-20020a2e850d000000b002cd7940706bmr404939lji.0.1705031606338;
        Thu, 11 Jan 2024 19:53:26 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id y6-20020a2ebb86000000b002ccf056f63dsm335796lje.91.2024.01.11.19.53.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 19:53:25 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e5a9bcec9so7369509e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 19:53:25 -0800 (PST)
X-Received: by 2002:a05:6512:2386:b0:50e:8ccc:6df5 with SMTP id
 c6-20020a056512238600b0050e8ccc6df5mr477364lfv.27.1705031605206; Thu, 11 Jan
 2024 19:53:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87sf37vegj.fsf@meer.lwn.net>
In-Reply-To: <87sf37vegj.fsf@meer.lwn.net>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Thu, 11 Jan 2024 19:53:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=whtqOvx4_GL8MX+bGroS5hfueP+Arch_qVYwQDJVvFCKg@mail.gmail.com>
Message-ID: <CAHk-=whtqOvx4_GL8MX+bGroS5hfueP+Arch_qVYwQDJVvFCKg@mail.gmail.com>
Subject: Re: [GIT PULL] Documentation for 6.8
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jan 2024 at 10:59, Jonathan Corbet <corbet@lwn.net> wrote:
>
> - The minimum Sphinx requirement has been raised to 2.4.4, following a
>   warning that was added in 6.2.

Well, speaking of warnings, github now has this "dependabot" thing
that warns about bad minimum requirements due to tooling that has
security issues.

And it warns about our "jinja2 < 3.1" requirement, because apparently
that can cause issues:

  "The xmlattr filter in affected versions of Jinja accepts keys
containing spaces. XML/HTML attributes cannot contain spaces, as each
would then be interpreted as a separate attribute. If an application
accepts keys (as opposed to only values) as user input, and renders
these in pages that other users see as well, an attacker could use
this to inject other attributes and perform XSS. Note that accepting
keys as user input is not common or a particularly intended use case
of the xmlattr filter, and an application doing so should already be
verifying what keys are provided regardless of this fix"

with affected versions being marked as < 3.1.3 and fixed in Jinja2 3.1.3

I'm ignoring this github dependabit warning since the issue seems to
be rather irrelevant for our doc use, but I thought I'd mention it.

            Linus

