Return-Path: <linux-kernel+bounces-149827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8A78A966C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 544871F22ECD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A804815B968;
	Thu, 18 Apr 2024 09:41:09 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C6715B109;
	Thu, 18 Apr 2024 09:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713433269; cv=none; b=Cu7mzS2CoN5cTlidR7aa6BNiEIEMipFIuYcmKxYteYaMLSyPgGkNlXRXw1kQIIbEUZfAaKdn7qXVb0bIJPWiOmcpQrBr+FJsUMVS/xSsCGr/HcaMoL8acylkCCJ4iRbW72e06y7/5W6n/OOVDPhdFzPIrMNRUmvFtnREmo2tm5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713433269; c=relaxed/simple;
	bh=X7mmMSW7WStS5uGM2nHr9Jyj4I7qxPWCtETwdZg8xmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pu4+REh1C+/6B94XAGypToVLun34asbth/z2vesmCkOaOd2c97m6E6DVRqQxRqQuZmZ1oZGo6TnswHrnn7dTYvYUGQoRN0saoXlfERlW7DBxKbBto2Pc6y3lruBJKMF1G3BaahCfrdnue3+S9okQVm5DJiliUFEQBE81SdqsF5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-61acfd3fd3fso6439747b3.1;
        Thu, 18 Apr 2024 02:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713433265; x=1714038065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkbR5FG9nHCaDQQ83/fhCPl692MGBzI0gOcU1PXseUQ=;
        b=nYXdEE43IhQ0T+43wzBAEjMNSxggzS7nmbjKVjEZ8k3uLBOM2epVN+oyVrvTxwBt1j
         B+VqflqEHyT0KOwQ4hAUiLtzHGCyIQn5mNOpN1MSkdBkiVWayQdVD+hDCFEMhhWRV/0t
         95GMfTXCQ3HiN1HfQCQb5R6ou8hF48glPwufu5IuH8lR0gwua51vC0psPCoas3aLAQPw
         oZnBuRgtoZYMcmTGqrZLuYEp5KAtfKQU3juJ60CeEp4qmDux5LhsdnugLtIwBVSDYGT4
         UWLjFtvyMsKPQkKm86r9hq4PB98YyYFG1aNYQMqWmd1+4GD9Srn1hQ9OM9lE2hGfGmdO
         UTnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVEAasNiKcb72O6m7MlG4OJj/TCkcsEAji4RtPrI6Bvvl44ycy7DgC6v2aiT6wiXn8wl+JBJzMPqPAYHuXBSlxbbWMHDVgdbzSol3TCJZOkTUB/+x/cnCmiSmhbFK75YNcw0tDBLXR8c1WcKpMiuKd2xsRra4u/QTxo7Sxc4KVAPq6RwBFS6i1NUpH6jAwdidnll9r0cVXSk9KKKL8KdUUqUxB
X-Gm-Message-State: AOJu0YxNeX/5VX/+rsBOuA/3H/csqzCQizu5hq94Pc/WwFshO+Ra4eHh
	sP03UFHxZcJPmDeU99cyujtyqst3Ij0OgggNxWTbnBQTACGzQkraT5DPXE1DtiI=
X-Google-Smtp-Source: AGHT+IEn54X5uiU3BE/DsxoFMqWcHS+NO5BYsT3yK2uQg5vWljAHSopORNAwPm2fiBzKzrL40NJJ4Q==
X-Received: by 2002:a05:690c:6082:b0:60a:6ad0:6c72 with SMTP id hg2-20020a05690c608200b0060a6ad06c72mr2230224ywb.36.1713433265624;
        Thu, 18 Apr 2024 02:41:05 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id g125-20020a0ddd83000000b0061b06ae1d09sm261308ywe.29.2024.04.18.02.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 02:41:04 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-de45385a1b4so749987276.3;
        Thu, 18 Apr 2024 02:41:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVwYCQt7oozfMLbG4YCH4/ioBH2L9rZZwTwfs7cZgBWfVcRKB36P6MjENpsPUP9aGxaudpftg/CX6Xrt/qARjs+nTwIun9sZZWlf4Pw3jnRD2gKOQZGWlL2eUU1QN1EbGpjGpGHtFyXd6SeHW/YpXPYqoOnXaHW+Ux1NzYyVCyXaIlhyOPdi3Mqn+IU8YXxdj8iIAT2HQSwoMLBhP2EmPvrBB0V
X-Received: by 2002:a25:4a46:0:b0:de0:de85:e388 with SMTP id
 x67-20020a254a46000000b00de0de85e388mr1985378yba.24.1713433264294; Thu, 18
 Apr 2024 02:41:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415-rzn1-gmac1-v3-0-ab12f2c4401d@bootlin.com> <20240415-rzn1-gmac1-v3-1-ab12f2c4401d@bootlin.com>
In-Reply-To: <20240415-rzn1-gmac1-v3-1-ab12f2c4401d@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Apr 2024 11:40:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUZJf=mL4bNik6ausMi9jOb9DegwX4ovLjdVLmnf7Sobg@mail.gmail.com>
Message-ID: <CAMuHMdUZJf=mL4bNik6ausMi9jOb9DegwX4ovLjdVLmnf7Sobg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/5] dt-bindings: net: renesas,rzn1-gmac:
 Document RZ/N1 GMAC support
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 11:18=E2=80=AFAM Romain Gantois
<romain.gantois@bootlin.com> wrote:
> From: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
>
> The RZ/N1 series of MPUs feature up to two Gigabit Ethernet controllers.
> These controllers are based on Synopsys IPs. They can be connected to
> RZ/N1 RGMII/RMII converters.
>
> Add a binding that describes these GMAC devices.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
> [rgantois: commit log]
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>

LGTM, so
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

