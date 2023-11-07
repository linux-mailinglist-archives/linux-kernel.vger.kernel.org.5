Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6377E472E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 18:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbjKGRiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 12:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjKGRiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 12:38:06 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C04BC0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 09:38:04 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-544455a4b56so5945194a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 09:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699378681; x=1699983481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqd7PZ/B96UGfoG3Q8m8TyivOw1/h/kSnp+uMatk3Wc=;
        b=bgvDpzIbEjl5PeBmA+L7QJ/J5AjDighUuFbADxI92Sko7v8aLR5fTEIzzCBVvSaWib
         YnjbNEN0Unr94kKTlxzw7zno0LLLN0SvHzP0Q1km1iumLp6jMikRU1Xbn6yrzNHLKLY+
         A6PMdSQm+/FUcI62mkn8i/wDHF/hWvTCSCMY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699378681; x=1699983481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqd7PZ/B96UGfoG3Q8m8TyivOw1/h/kSnp+uMatk3Wc=;
        b=iqAA3JhHWR40oSTjwhzxqSBcJJtx8VCGiRrM7xK8LML7LA63eXfx7na8sf9Vb9BPpY
         EnnMo8RlJCZVrtqY0Txmk4y7j2Y+wPbRUrZTQCUo6ojJ7nvhFAp+ZFkoyZjqCcIct8Ed
         iu3YCERqjxLZrYmWkIhTysMAZnzbbDe+ObscHpl4VodzNEsusoCKxEWMFzBNfDlKUC8G
         /qDI7ySFqsAg3dmsVDDuVzMAE1fFMdT8HkNRKc4Two3OfeX3A0qANmbU/xp0v6Ab/tcK
         Xp9v9aRMJmAHvQ87oxczzH4E00XP7/W2SE+wMsZvGETYAAn0Wo55vVWAIS1KZ8zWyMHF
         dOvw==
X-Gm-Message-State: AOJu0Yxgu4oSSMXLdVG8fFFsvaHT8aDVdcaAxp8WmpuZN1uMJ3Isfisn
        gOX0724AoctrCy416VKr2IeypqFK9v+j/Hm4VgAM5SFz
X-Google-Smtp-Source: AGHT+IFTOtT71t5V+YuHuxrFZrnGgKuXG8/muG0ci0svzb+2vReiwBYlMBWSHYK6XsJvnTYPpwrrlQ==
X-Received: by 2002:a17:907:9446:b0:9bd:a65e:b594 with SMTP id dl6-20020a170907944600b009bda65eb594mr16999648ejc.3.1699378680935;
        Tue, 07 Nov 2023 09:38:00 -0800 (PST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id cb9-20020a170906a44900b0099d804da2e9sm1269607ejb.225.2023.11.07.09.37.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 09:37:59 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40837124e1cso2095e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 09:37:59 -0800 (PST)
X-Received: by 2002:a7b:c8c1:0:b0:408:3725:b96a with SMTP id
 f1-20020a7bc8c1000000b004083725b96amr142833wml.0.1699378679435; Tue, 07 Nov
 2023 09:37:59 -0800 (PST)
MIME-Version: 1.0
References: <20231107072651.v2.1.Ide945748593cffd8ff0feb9ae22b795935b944d6@changeid>
 <9b2e37a0-32ee-4aa4-99e8-d37103674847@collabora.com>
In-Reply-To: <9b2e37a0-32ee-4aa4-99e8-d37103674847@collabora.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 7 Nov 2023 09:37:43 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xv7XKvePTZ6LKT97EViG81d8hqk+T68B5eXamKTU407A@mail.gmail.com>
Message-ID: <CAD=FV=Xv7XKvePTZ6LKT97EViG81d8hqk+T68B5eXamKTU407A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: Move Mediatek GIC quirk handling from
 irqchip to core
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        James Morse <james.morse@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 7, 2023 at 8:30=E2=80=AFAM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> > +static __init void detect_system_supports_pseudo_nmi(void)
> > +{
> > +     struct device_node *np;
> > +
> > +     if (!enable_pseudo_nmi)
> > +             return;
> > +
> > +     /*
> > +      * Detect broken Mediatek firmware that doesn't properly save and
>
> s/Mediatek/MediaTek/g
>
> Apart from that,
>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
>
> On MT8195, MT8192, MT8186:
> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabor=
a.com>

Thanks! Unless someone wants me to spin it more quickly, I'll plan to
send a V3 with the Mediatek=3D>MediaTek change tomorrow.

-Doug
