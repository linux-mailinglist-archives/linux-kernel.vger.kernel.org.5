Return-Path: <linux-kernel+bounces-2412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B778815CC0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 01:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6195B224FA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 00:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CF3A47;
	Sun, 17 Dec 2023 00:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="e0f19Lk4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C028A28
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 00:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40c41b43e1eso23306965e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 16:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1702772224; x=1703377024; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bAFj5xbxM2mCS1XIYyK15ZI/pkl+AsbnPJZP3xO5CDc=;
        b=e0f19Lk4iZxB+wcQ/w2rx8W7kjfwburHMwZVawvskGMoI7gksGfjbwqmLwfQVmmeI/
         qlMDNR84zDx9wWWhdiPyT3bHNhGPOeLN+lMu1C1ipzYCboJOq/ZLByFEcWAIeIOjEd8N
         2f8TLx2Ds8PkpBX2qYnAp+wfGVUawV0ZHbgpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702772224; x=1703377024;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bAFj5xbxM2mCS1XIYyK15ZI/pkl+AsbnPJZP3xO5CDc=;
        b=OF67O3mUG/iOd/eo4aHDEDzQfsqTEKWIWiuTaot/apo5K1LxLHlCau7w3DRccoLkKd
         aaawd7m2kwbcvAb+HKzXqcq8AQpy5V9PazXt3Bxwh7KIwPa8zsF70CzW0DPGyE1xx1nO
         VK7ln0iMminu9PwgWjTHQnCuGHBgaYaPDZSpwtSnm5eTTLNXTDcRRfXlP7ZET5kidVt8
         0hUI86rIHyCF6VVJ8nLJBq6Oo1b5AL+qs7yMEIQwWpgUwrA2cea/2qzpgX1gv0jt/GBK
         rnwNCOXiJofzUYE4InY/RACTkPHmlsmPVMkZnKUbr1JZCuSaSEUKFeJnA1cTqb8J0HQj
         5jtw==
X-Gm-Message-State: AOJu0YyM1Uwww0X9FnRBx/kc5f9N58fzYuQKGkYt3CgbIDr1cZlcNlZu
	peGRuujGHUabI1bk1Dao9p2cqRKUjWIcWY/iSD8GgwmL
X-Google-Smtp-Source: AGHT+IGzUelHR0DBhAj3hKvt5bMJKp53n/4ZP/ZNSC3Xm8Ay+SedErc10E5xan4HJx1UhyJ3g1+AOA==
X-Received: by 2002:a05:600c:1d89:b0:40d:1447:daa3 with SMTP id p9-20020a05600c1d8900b0040d1447daa3mr164353wms.116.1702772224318;
        Sat, 16 Dec 2023 16:17:04 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id tz9-20020a170907c78900b00a19afc16d23sm12429600ejc.104.2023.12.16.16.17.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Dec 2023 16:17:03 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a233a60f8feso30981366b.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 16:17:02 -0800 (PST)
X-Received: by 2002:a17:906:dfd0:b0:a19:a19a:eabd with SMTP id
 jt16-20020a170906dfd000b00a19a19aeabdmr7023405ejc.118.1702772222569; Sat, 16
 Dec 2023 16:17:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215071604.946a433bbc05a6409faf5a33@linux-foundation.org>
 <CAHk-=wjWJgWzOf9MCuiE0oDsF6cCCn7KKDc_xDN6Q3kWNEHKLQ@mail.gmail.com>
 <20231215122251.bad09400b337dfb1965f6976@linux-foundation.org> <CAOUHufbcB9Lxeez=NcUY4uzxyX6x71dy2N0SMgj=ALooq+MetQ@mail.gmail.com>
In-Reply-To: <CAOUHufbcB9Lxeez=NcUY4uzxyX6x71dy2N0SMgj=ALooq+MetQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 16 Dec 2023 16:16:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgWwyvzcG9YiEAv2X7XivH-zqLLxeJ+A6EpMp+EA3o_iw@mail.gmail.com>
Message-ID: <CAHk-=wgWwyvzcG9YiEAv2X7XivH-zqLLxeJ+A6EpMp+EA3o_iw@mail.gmail.com>
Subject: Re: [GIT PULL] hotfixes for 6.7-rc6
To: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Jesse Barnes <jsbarnes@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Guru Anbalagane <gurua@google.com>, 
	David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Dec 2023 at 20:57, Yu Zhao <yuzhao@google.com> wrote:
>
> There has been a short-term plan, i.e., moving some of folio->flags to
> the lower bits of folio->lru so that we can drop the Kconfig
> constraint. I have discussed this with Willy but never acted on it. My
> priority has been to surface more of our ideas that can potentially
> save users money on memory to the community. I'm CC'ing our team
> leads. Please feel free to let us know your preference on the
> priority.

This is definitely a "eventually" thing on my wishlist, so I was more
just wanting to hear that there is a plan, and somebody working on
it..

Thanks,

            Linus

