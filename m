Return-Path: <linux-kernel+bounces-142801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 459968A3049
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECC021F212E7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0888615F;
	Fri, 12 Apr 2024 14:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFNM6wCN"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081C7205E22;
	Fri, 12 Apr 2024 14:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712931391; cv=none; b=lWLiqO4lLKPXkCQmTONOskN91KLUUg0ElXIbAAtip6oOd4fd6rf4mo77TMnMoQkXXZGFIk+AUfq5GEiHQ5WiT1xxpwXhhe2nfrEn4LUsF1j4E3dBG9BhJNunrkKbT4/LpOmXLIkms/M+tZ4ZGU+qGG76rMP8IQxnlP/YwwAr3iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712931391; c=relaxed/simple;
	bh=SA0q6SsNFlcUSbmyksfGP3j4aVnwqM+5MoF1Muj/XLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GPbfcI1Z7i+qstQlB3lN1UbVbdQEnEzoTI+xE+bI3uZSQheUOR/op1MMDfExKF+NwA13bfRhqIHjTPgYG00lSteMbyFtKMDGtmQsegrMdz6sPSce7eDhsoguFpGc2I974gtNXEs3LUa5U5k7lrSLxC7LpLTf6o18j+VpRVT/f+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFNM6wCN; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d47a92cfefso11100981fa.1;
        Fri, 12 Apr 2024 07:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712931388; x=1713536188; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SA0q6SsNFlcUSbmyksfGP3j4aVnwqM+5MoF1Muj/XLA=;
        b=VFNM6wCNQrgh0By69e3PBn2Jmw8uc4aKhbrBZuMwpqzDrfIE+b+E0PKKAqZaE7J6NT
         3XNNSSd7cPRujvvXTLSbX+SnWEWxtUV8nuPEPNi4nACZCUVXDmSfXnob9NB6zVooryeQ
         UlIXtSkZRYlIdmvnKIMm4McUzc/RNMNVOAK9mRPxJgRNIN032BVxEn3HhIZAC1HDi924
         CWPWjfcqRrH+BWDWvP2ghTnveQ8HcKA8L1fUDHbfyauZGiSSDiTtmw3tVVtb6cSVNSb7
         EdorjixdTw+5+I8GQ2rRAtlgHtsw34Z3uqBqYXt4Kyjy1g/IC0Q6fvx19kal/4HBBO7q
         Jhdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712931388; x=1713536188;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SA0q6SsNFlcUSbmyksfGP3j4aVnwqM+5MoF1Muj/XLA=;
        b=ixZOeQBj3aYeK+rjPsPZHK7J7kzO6oI0M2lEu+JYQHGZqwvpjdvjq/TT+kxQ2aN83f
         N52V6lYzjGp9J10KRKae7rMi6PJcTHtR3ohOPpKG0AAMKsn5uG5qZlQkUrhfVVyIcbdG
         9WX9UppgULgadvPJwYvnpBxmx+S3OGDTTnXSLzsKNh+1+2JCCHXftjbVFyNE6kg5FmR5
         qxx0wLtleZShptcmwnbWYphUE5dpUz1A4q8D0TTiIwoh7asSuMpmGrVqdsVnkgqK8o+P
         wNk+R5AKDVd+liZVodbU8aLWIuZmQloXhbxwOpOrurYeySUXSzys/q6sMrXYUk1uZFYg
         gDZA==
X-Forwarded-Encrypted: i=1; AJvYcCUZvDAZwl6yxN5WN9T+2mAjq8nQOQMXJXeAiwtCDRlETOUe8UXSJfn5DMi5DRZeurbvLWrsDK07f8jWYjdJBDOhtpTsg0Vyhrs3ermHtMb1VHs32mb1bpsIpymPO9q73iEKMSuxU8pp/g==
X-Gm-Message-State: AOJu0Yyk5Fph+BIRuYH5j86aKcM8SgGBQ1tTw0uCO+jgLQ+//NeOawbM
	FZ+2smXmdYFvvjsAmHy4/DOffW8cvpCSsdvjjVVYONWfbrRAp7TTCWS0LYAcQ9Ux8P0NXekRO4/
	Jh1jL/fXbYhuJ/tJ4orKmbblfs08=
X-Google-Smtp-Source: AGHT+IHN1he0MRVv1bTgEsUkkS+mTqrtLXetL9ppYbRVjNCqz/IXwcP7pZldQHAqVu/k6BLU2IAiQWzC8tpvO83CdzA=
X-Received: by 2002:a2e:b5ae:0:b0:2d6:fb69:114e with SMTP id
 f14-20020a2eb5ae000000b002d6fb69114emr1557427ljn.21.1712931387856; Fri, 12
 Apr 2024 07:16:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404160649.967-1-bavishimithil@gmail.com> <78091796-fd0a-42dd-a4da-f7bed3025bf9@linaro.org>
 <CAGzNGRnuG_gLUrH1N57WvpKbpiNtFrcsG6nJcacQNJB_yMYNrA@mail.gmail.com>
 <ec7f77a7-2cf1-4ea6-b9c4-d4fe8a1673ab@linaro.org> <CAGzNGRktm5gMj=bhtX2RAzcn1v5ref+nV-HV3Fct56FzAzxjWA@mail.gmail.com>
 <c9084453-65f1-43b0-88df-5b73052ccb72@linaro.org> <CAGzNGR=2-us8GRB3RNi4_24QZ9rNBC7Lx0PFsWwbvxuRKk5ngw@mail.gmail.com>
 <352672fc-b6e1-458e-b4f9-840a8ba07c7e@linaro.org> <CAGzNGRnjCydMMJS6Cqht7zT1GvhbVtKAe1hu8oaf8YwRfA=hZg@mail.gmail.com>
In-Reply-To: <CAGzNGRnjCydMMJS6Cqht7zT1GvhbVtKAe1hu8oaf8YwRfA=hZg@mail.gmail.com>
From: Mithil <bavishimithil@gmail.com>
Date: Fri, 12 Apr 2024 19:46:16 +0530
Message-ID: <CAGzNGR=60czJWH4=1_1Hf1yH1KZQpmDqsv_zySLr-S_D0vqosg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: omap-mcpdm: Convert to DT schema
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	alsa-devel@alsa-project.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
Is the patch better now? I'd still like to learn from where i did the
mistakes (which seem very silly now)

Best Regards,
Mithil

