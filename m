Return-Path: <linux-kernel+bounces-22209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B093829AE4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9434F281072
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B1E48799;
	Wed, 10 Jan 2024 13:05:47 +0000 (UTC)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15E647F6F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 13:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4299d95547eso12318911cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 05:05:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704891944; x=1705496744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h0CYESXWRwPl8oqvteNiSuteSyQk0Ky/r564akScXfg=;
        b=q6GKmPRI3UinucRWzsgygtv+4Hw2YL8eRdYsJGfuGgl/YQMdLCY/y9HhfT0G/eIxdt
         fB73bE8SYQ+/sSvQxWPhodLBxsyN10gbEOaWY+POxm5efRR7HfpB5qb75ZcYNAOQkPq7
         C2/dCUSkwq7pAjWKD3Taq4Vk/iIdRhCmFY+EHBs8lHRxNoVvVSFuo1QS/drBOA5hNu4B
         mHn3cLrC4hpTwp5fSTKNLx70U15n3hmRz80ZTO2jX5GWVHO+eP/6xM4sZlFftHRltw7Q
         VzTZlH1gKHd4B6pPq8+cJN5/7LVUKIE6eJQdD/9WxrDeASwgcZokfh7eY34xJJM+yPCQ
         YOkA==
X-Gm-Message-State: AOJu0YwYTUBCQw5dsnFfAQv8aGLNJB8XBnNiAMItAvpRwH/pbzUp3V7J
	X1z2RKuhxa3m7UdaccCO6Cg=
X-Google-Smtp-Source: AGHT+IHe1RvNMYGKzjKIDeQa10bovKXWOKkurYaCsJ4WPcjbUKsAuCGpiIgF0NtedlK05DRgEHQERA==
X-Received: by 2002:ac8:5d89:0:b0:429:85d9:d5f1 with SMTP id d9-20020ac85d89000000b0042985d9d5f1mr909495qtx.93.1704891944386;
        Wed, 10 Jan 2024 05:05:44 -0800 (PST)
Received: from Belldandy-Slimbook.tail03774.ts.net ([32.221.209.96])
        by smtp.gmail.com with ESMTPSA id i3-20020a05622a08c300b00427e2ec0bd0sm1774371qte.73.2024.01.10.05.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 05:05:43 -0800 (PST)
From: Neal Gompa <neal@gompa.dev>
To: jirislaby@kernel.org
Cc: dhowells@redhat.com,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	pinskia@gmail.com,
	kent.overstreet@linux.dev,
	Neal Gompa <neal@gompa.dev>
Subject: Re: [PATCH 00/45] C++: Convert the kernel to C++
Date: Wed, 10 Jan 2024 08:04:53 -0500
Message-ID: <20240110130456.142763-1-neal@gompa.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <938ebce3-74c5-4fcf-9de3-849271d3581d@kernel.org>
References: <938ebce3-74c5-4fcf-9de3-849271d3581d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hey all,

I would like to speak in support of this too. It is not uncommon
to see operating systems code written in C++ (notable examples are
Haiku OS, Serenity OS, and Zircon/Fuschia) and I do feel that there
are benefits to C++ for Linux code. Modern C++ (such as C++14 and
newer), offers a lot of nice base language features that can make
some of the kind of stuff that Linux does easier (as H. Peter Anvin
has detailed in his post[1]).

While I personally have some experience in a variety of programming
languages, C++ and Python are my preferred tools, and I would
personally be much more interested in contributing in C++ than in C.
I imagine there are a lot of other folks out there who feel the same,
but just don't feel like they can say it. I'll stick my neck out for
those who won't. ;)

Even though this started out as a "joke"[2], I really would like to
see C++ code permitted in Linux.

Thanks in advance and best regards,
Neal

[1]: https://lore.kernel.org/lkml/3465e0c6-f5b2-4c42-95eb-29361481f805@zytor.com/
[2]: https://lore.kernel.org/lkml/152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk/


-- 
真実はいつも一つ！/ Always, there's only one truth!

