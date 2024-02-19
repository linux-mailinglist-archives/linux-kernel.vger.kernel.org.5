Return-Path: <linux-kernel+bounces-70767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCB1859BF8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2370A1F21B03
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97FD200D6;
	Mon, 19 Feb 2024 06:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3Dvm1kJ"
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6102F200AD
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708323829; cv=none; b=I/ZHP+AYyb5kZ7I+SjPX3dLXqH2gK5S60JRCRnCLmX175vQ1/uTEJ0JDFK6uc+llYSvBOV4i3Fwp0/vUNuSPXNX36fqLptlj+2W5N7VtGkF46GLCuZIHkPNicL7JiAnxyhly4Qc3S+shNG3VMXRPRCQNbDp2zf98JHyjANKxIks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708323829; c=relaxed/simple;
	bh=PCV7/GjnToskxFQVDLdtLSGzj6jLmCk9DhRk9GUzB+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQsseinpFMi3Q4Y3hXhBsj3etDZum/8BDaMHtptXQnih9nI/FVNrrM+vSv9MpWgOoWoxEwu9tvWcCq7edyzNOQMB99nzrXXa0EXU9NIUkqbXbL1pWYkzw9jXXdXkXVOq0VOmRE4Ux0UXUqadBkCONPc5SsPx4hlcybafY5eSiEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3Dvm1kJ; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-512b36bb97eso444609e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 22:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708323825; x=1708928625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCV7/GjnToskxFQVDLdtLSGzj6jLmCk9DhRk9GUzB+M=;
        b=T3Dvm1kJgyV3XNybjDtWRrLBNetMdFE/dbzPYZarcJ4B1l2Xv4xu+dhnoWILy7u4iE
         ImcR2d3SbDpN9ggMRpJEgLFvdD0IxrO+c7THXZD9NHcWsAuApcgEvIVuF6FEAXpdrJqQ
         VaWT48NCC4hCV/Cl/96K7r0FBOpzzp+UPPVDjHN7RKvLInQ+Lx8+KNJVWw2UyKalbAfk
         SNUhe9yiFQq00Pb35KProgwqwMnpmTCW60dsQn57eCvP6WOnSHLPxtod6RPnfQKbUYTG
         /d9/N6YLhjc3I3E3qdzyLd5G8LGLxqxvS4gNQL12+bvh/DoSdWIej5XMXWMAbGYXTJ6b
         4aig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708323825; x=1708928625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCV7/GjnToskxFQVDLdtLSGzj6jLmCk9DhRk9GUzB+M=;
        b=SBAui4Clk9K9OCOJN9wQf3m0LBfNgyRSSyXs4pgCB0ljlPl12jrMC+cnVxEQIJtiLz
         9VFmkR0NJnkKnHn8pM9w+y0EHy2kk0yYSbdp14/VniW2gBmsfgsC+NK3j3TJLuNkEsDK
         LX8PfuwEqy/eKT6h9Q5PaXLj9rItsl/0sAQabu6ZMnyukPqwXcsl048CRSH2HGh42Q3/
         VlyEe+/rfKIW9pcnYZIbb/hQavpgu3gq14MyPRysdHR7UVcXJqq6rs/u+KcnvNmjd10E
         84zjQaUXvmqCgSzvax43lRv0EOeyzo6sHZB1XEDWvq7/Nh09KtX9LHz0o7h0GEsHsBNQ
         xziw==
X-Forwarded-Encrypted: i=1; AJvYcCXQinZATqXMgl47TYloWgHSNwZXof9LdibrU7HjP/XlFvVzb5S+k9O/e8jyaq1Eo2iehJcS4DTrK0IfK7JgqAODNvs/xF5cGYupPWeX
X-Gm-Message-State: AOJu0YxGJp0okq2wjuXtGOg6Zc6sylm0xj4o8VstaY6Zw5hh6vF9u2sc
	GRf4hgoQRfnHO6fu4hdktYrYJXrqCTD8pcRb7k4YL9NXr9QzZ7xEIPTpc9QJtBEhPDva8sAhX+z
	UaTeZAnVZrqc4x7i6qD2G71xZAQ==
X-Google-Smtp-Source: AGHT+IG+SSK9Ev0R/5Ce+rCVvL0NunDHmQi8xVVicpYEM6Fyp6WoACLu/HZz5RMrZ4SC6s3rnqPCfVoflgeWORV0GtY=
X-Received: by 2002:a05:6512:945:b0:511:6031:3f1c with SMTP id
 u5-20020a056512094500b0051160313f1cmr6753250lft.28.1708323825255; Sun, 18 Feb
 2024 22:23:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219031911.10372-1-fangzheng.zhang@unisoc.com>
 <20240219031911.10372-3-fangzheng.zhang@unisoc.com> <ZdLX51r1mOEZKUje@casper.infradead.org>
In-Reply-To: <ZdLX51r1mOEZKUje@casper.infradead.org>
From: zhang fangzheng <fangzheng.zhang1003@gmail.com>
Date: Mon, 19 Feb 2024 14:23:33 +0800
Message-ID: <CA+kNDJ+C2b520afauSWbfNK=S1XiNHR_zF32_K-3Rf7R6m3n5Q@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] Documentation: filesystems: introduce
 proc/slabinfo to users
To: Matthew Wilcox <willy@infradead.org>
Cc: Fangzheng Zhang <fangzheng.zhang@unisoc.com>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, tkjos@google.com, 
	Yuming Han <yuming.han@unisoc.com>, Chunyan Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 12:24=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Mon, Feb 19, 2024 at 11:19:11AM +0800, Fangzheng Zhang wrote:
> > +Note, <slabreclaim> comes from the collected results in the file
> > +/sys/kernel/slab/$cache/reclaim_account. Next, we will mark /proc/slab=
info
> > +as deprecated and recommend the use of either sysfs directly or
> > +use of the "slabinfo" tool that we have been providing in linux/tools/=
mm.
>
> Wait, so you're going to all of the trouble of changing the format of
> slabinfo (with the associated costs of updating every tool that currently
> parses it), only to recommend that we stop using it and start using
> tools/mm/slabinfo instead?
>

The initial purpose was to obtain the type of each slab through
a simple command 'cat proc/slabinfo'. So here, my intention is not to
update all slabinfo-related tools for the time being, but to modify
the version number of proc/slabinfo and further display the results
of using the command.

> How about we simply do nothing?

The note here means what changes will occur after
we modify the version number of proc/slabinfo to 2.2.
As for the replacement of tools/mm/slabinfo (that inspired
by Christoph=E2=80=99s suggestions), it will be implemented in the next ver=
sion
or even the later version.

Thanks!

