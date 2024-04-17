Return-Path: <linux-kernel+bounces-148886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3219E8A8892
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB6641F257D2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF80014883C;
	Wed, 17 Apr 2024 16:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="iGAJwGsx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3361487ED;
	Wed, 17 Apr 2024 16:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713370284; cv=none; b=cE/YlJtlB7YfSpCOu/2J2ob+eZMbWOOYIBI3aAFlCsdtiYQCVqjMovswv68Hq6d9RXgCMpwDBImJFzj8AIYJv4rA9lLpN9d9ax1aqFtkqaS+QydoZXCE30GHhZ9oWx0Qxb69t0G3TYKPcU7JjQKj4rN3mTdBs5uzkIFr7qJko34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713370284; c=relaxed/simple;
	bh=Vd9MoZGmUJSmWJhjZuysNOPtSny1sF4YJqKBYM/g7G4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WqwIlTUD76zbrXl3Nca8YpxijMVHlNBgH4ZRlmH8NxUs6Fo6WOdVgjqKtkb8XhDzH2noqjkN2tp0LEMH3SCzT6169d1qZloQoFRiQTn2pq1rSSbPDQ64eEhth/U818haB79AMPh4EKsNgErYqvTF54/r3V1Hf+DpB+0huPmkF9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=iGAJwGsx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F8CC32783;
	Wed, 17 Apr 2024 16:11:23 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="iGAJwGsx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1713370279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vd9MoZGmUJSmWJhjZuysNOPtSny1sF4YJqKBYM/g7G4=;
	b=iGAJwGsxu04qMExnTCA3JQ+6qGD6hJ9R9PIoxkW7LDfeJjUHd8bl9Vb0t0YL2CX1esUNH6
	Q9s+L/xcwbGjeOklnxrEPJadgtbqAxD+ExlSY5ZuE8ItKhcSKjs8HSvo0xeoakglSB79AC
	iCHfpgGNpnXUVjPUYpqRfpXQuACBgCM=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 88535516 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Apr 2024 16:11:18 +0000 (UTC)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-de45e5c3c68so134981276.0;
        Wed, 17 Apr 2024 09:11:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWjjlyYGyGlcoALrqz1RIDwjEe8xnNSdACSULwJG8vQ2vYnstTYtc2mcC274SEYDyYc0F4RnpIDbhilvl0KDtRe9KYr77n5naFlXHoZt/DBEo1kZHaJqAIf5rxrTPCeNje2BT2hSxLOVczfwTimgwp6DabMqTk3CW5pN4H1l9gYL19ct6Am7w==
X-Gm-Message-State: AOJu0YwFPM94nRvziEFd7djeXTJg+FM2PvbzaDO8yvHUpk7r5JFtX7ch
	WXFqU60IpWBqe5C2rlsRr9CUjMPgUjguLgfHyu+4kqMBM+Vb4zSapGt1lV3U0CbC9lEv9LWZ9RD
	wYblurmtJ+RcIK2SwOSNcEZ95qo4=
X-Google-Smtp-Source: AGHT+IHnVFaaolAttobN05sEUDEOZ5q4IsHxKmNOdMXi38+CnOrD9A/ODY6svaDJFy1CiSQ4ILjWqKrNFfsRMS/5hTQ=
X-Received: by 2002:a25:ac1f:0:b0:de1:286c:23b1 with SMTP id
 w31-20020a25ac1f000000b00de1286c23b1mr16773107ybi.7.1713370277505; Wed, 17
 Apr 2024 09:11:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417104046.27253-1-bchalios@amazon.es> <20240417104046.27253-6-bchalios@amazon.es>
 <CAHmME9qHY_1JGDMyvEGB7XDu2DKaYQcPE3UfSfb4aVZkgC8Q=g@mail.gmail.com> <1fe62eb1-8ad5-4ced-9349-258cee9de663@kernel.org>
In-Reply-To: <1fe62eb1-8ad5-4ced-9349-258cee9de663@kernel.org>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Wed, 17 Apr 2024 18:11:05 +0200
X-Gmail-Original-Message-ID: <CAHmME9rtwMEBL-F5mQLuQREr=TqpuYChYn1rxpfGYqX11x-Efg@mail.gmail.com>
Message-ID: <CAHmME9rtwMEBL-F5mQLuQREr=TqpuYChYn1rxpfGYqX11x-Efg@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] virt: vmgenid: add support for devicetree bindings
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: sudanl@amazon.com, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, tytso@mit.edu, 
	olivia@selenic.com, herbert@gondor.apana.org.au, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-crypto@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, graf@amazon.de, 
	xmarcalx@amazon.co.uk, dwmw@amazon.co.uk, Alexander Graf <graf@amazon.com>, 
	Babis Chalios <bchalios@amazon.es>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Wed, Apr 17, 2024 at 6:02=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
> Usually we do not recommend hiding code behind !CONFIG_OF because this
> limits possible usage on ACPI systems via PRP0001. Not sure if it is
> applicable here, because there is already ACPI matching.
>
> I would suggest choose whatever makes code simpler... Or just mark some
> pieces with __maybe_unused if they are really not used? That would avoid
> ifdeffery.

Interesting about PRP0001. Alright. It looks like I can't quite do
without ifdefs because the code dereferences ->handle in a acpi_device
struct, but I can minimize it all to just a single ifdef.

Jason

