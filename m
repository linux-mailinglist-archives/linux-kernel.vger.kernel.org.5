Return-Path: <linux-kernel+bounces-157100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2FB8B0CD1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4214B22B69
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652E715ECD7;
	Wed, 24 Apr 2024 14:41:06 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D54E15E809;
	Wed, 24 Apr 2024 14:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969666; cv=none; b=LhnmfwzlfABArVOQq7zNgpTfhbCcoyRomlfE087DpuodGwpve9KXy6ggLIEbVmGpcUkiTClfYIppot9zrP10HfwgqZRLYzFMUCp+dghN2CkWQf6H1+FnNSiZM92pKnKVdpCA4xGW8fGq24gIOqJ/278nOAaDpWIDtEZ3AIeSJsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969666; c=relaxed/simple;
	bh=/P16XX5iWdneekJXphwtShIEaCyHH6GK3VIZXrRz/bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O453e99xcV+FRtp/DvEKqErPUpzsheylcot4BfNPiuZe0eIjftnIxIl9+2oIVts1bVKQSL2ZMqExVwgu88UQZSx+um/IFeKkV/OqxtSKDlS3CkW7neIXAw5EsPAvDnBfODfWe/VEOW92H+TqVm+e7RuKQ/HIB48XnLn0RFYMbE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-61b92a83216so2486517b3.2;
        Wed, 24 Apr 2024 07:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713969663; x=1714574463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1n3iR6ddwYoKM5lE0EM8akCCCwsZIPBSCjAQL1WN9kE=;
        b=PiJMof9AEntE/BE2VamDP/mB31Nj7dPAp0SFAzzx3FaL0LVcaEzah6q5Ws8zBHE8Sk
         Javi8fo8UHMRdsmQLWJZXjlWhAGyz1ZKdoGzHXf4vzDiLBy8pBkR8BTgvECjM0EqYY2E
         NG0/6H47qFEzFPG6GJGmcrIg+zZpc98DPos3kKRNZd/cibvuMoxCfa9QftbirBtg8OVh
         PmXvav7Yb0bQLtHUNnufjOuZFfeLfRmb+gCtekxn4j57OarH6BtVUebulm4oPMGjnp8i
         N96wLNExFdghmYCiKu2IC+0yjCZPf5iUsm14GMdJDtgAafl/y3hyGBzZ1F6iihNd19HR
         UyiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsOlDTM9Y8SmVXCejovA73GF8wczPzLOq+S0Y865GgeknAw17biToeerBuLv6Z/G3z3EpTbdOU0zpCHxbAzNRE9lbbmHxQTBr65+II5I8cWnYF+VAMDRV0CJs9ilukqLyaAglxYlt9YTCn9YQd1V0ZnRwypoNESUanarLzZio7Fl0O5ig0NLm738i/7tvcHrnLbuDPORYU5So0VRLZZBYTrMeZ4+wX
X-Gm-Message-State: AOJu0YzWXUFY/RHDOG3469w5o2T0oDZ2eB0gLuffiP2XtSvrrGYK80vu
	GwfqFB2PsZLAkA/bpr53jn/iDQ5WXRfNs6iC/8R/ehrixNZONosuJ/Da0SkzO7Y=
X-Google-Smtp-Source: AGHT+IF4wrh6OH+fA02E5Fz9P1NcO75QEO/T09uzv8zaysKD9yzGHDw7WbbmNRz7LlxMlIPwhGABgw==
X-Received: by 2002:a05:690c:67c6:b0:617:d365:dc17 with SMTP id ic6-20020a05690c67c600b00617d365dc17mr2859309ywb.26.1713969663283;
        Wed, 24 Apr 2024 07:41:03 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id c2-20020a0df302000000b006145e0aa9c5sm3023736ywf.60.2024.04.24.07.41.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 07:41:02 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-de54b28c41eso2387875276.0;
        Wed, 24 Apr 2024 07:41:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVkMfLT+gwnRAK1mEDqERn4489PjoS5rVH5Gq07sL95icMEoPwe+ioNukzISH4e7BDuRrhSGrY4ooBDyIzWyipMOQd0pKWCFMJ4cagGJ49aA3L7W4lQrOmO8xSs6K/yj957HkEVz2zbjJtDUpWowc/cg5iOqnX3adLiBH11gQjPwp9Dts32BOlsXt4blhvQqMlaoMMIGJCrJIEG6xnyKWZPSTfbPg7h
X-Received: by 2002:a25:db84:0:b0:de5:5a6f:a52a with SMTP id
 g126-20020a25db84000000b00de55a6fa52amr3101448ybf.26.1713969662762; Wed, 24
 Apr 2024 07:41:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422213006.505576-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240422213006.505576-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240422213006.505576-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Apr 2024 16:40:51 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWzV-NiPbkaK0ZNJwLtj9i9PEuTZNcjE+LmwCfmaLpy-A@mail.gmail.com>
Message-ID: <CAMuHMdWzV-NiPbkaK0ZNJwLtj9i9PEuTZNcjE+LmwCfmaLpy-A@mail.gmail.com>
Subject: Re: [PATCH 5/6] arm64: dts: renesas: rzg2l-family: Update fallback
 string for SDHI nodes
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 11:30=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.=
com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Use 'renesas,rzg2l-sdhi' as a fallback string for SDHI nodes, where
> hs400_disabled and fixed_addr_mode quirks are applied.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

