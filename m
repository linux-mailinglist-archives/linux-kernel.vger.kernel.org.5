Return-Path: <linux-kernel+bounces-22210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE42829AE6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B19F281572
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65A64879C;
	Wed, 10 Jan 2024 13:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mXWcgmJE"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB3348790
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 13:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50ea98440a7so4052940e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 05:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704891952; x=1705496752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3fYiUXc8cxYAbqnzO/jzfI53DkZ5gWWk2eUOw5iFG0=;
        b=mXWcgmJET9cdsw54wZbtBpfD523o75hayqx4fcRd0lMFNxElQwh3VBOcfMxo2g8o4x
         gvnPXiOV/o4TkEaWMzFwukbzFG7KFtt1gCDArWQiWJGlorEVLWVQSUSVJclmV953Sqay
         G07QWgYXdwD8cnL4RQf/d/CwsH5zuLQAG//sY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704891952; x=1705496752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3fYiUXc8cxYAbqnzO/jzfI53DkZ5gWWk2eUOw5iFG0=;
        b=kaPUgs8CU13d7q4LM7+Px1YB9xkfqtbQ8a/9gbjY0kKJEXhfJM5JRtnRBDKjHb7RMM
         VSh2TsjqiHmXP3IxZAL0G3gDbqUSGBY6NeT4ordGQREkiKVlFPOkwWLCfT2gJz5NSlyz
         tFkI1MuqISgzlSMHxmOlvc2IiEXoxiUJaEcdphCYzlVaTYrkFVW6ATq+VWysSDPgcPkE
         YksdDH++UGYkiUArbQEJ/oAOjALUAnTEHF+rDWe54uxGz5FKGaGTmjqIs5b5z2mn8bTb
         95/X3rWIwEdBALKsQxjwb2U0Ne+ekBEb/fxdCQomQeUmT78s9ZZJsuGMufbcNZ3yVWHM
         jqng==
X-Gm-Message-State: AOJu0YykxCUnKTeXSoOM+52qsii+ocjIbO75ocvsHWRrpGP3Pj9fvluS
	5CZtxtaLsWXwybiG90cg8qTphTatO483WGRMvanpqvqiLTIj
X-Google-Smtp-Source: AGHT+IFt9LtNMkMXZ6gNCxpiVlWpHHtlffylW5vVhnpe8vQkXxImIXJrH2WKUU6ZxRLJSX5+oOPbkg==
X-Received: by 2002:ac2:410a:0:b0:50e:80d3:55f4 with SMTP id b10-20020ac2410a000000b0050e80d355f4mr234568lfi.131.1704891951998;
        Wed, 10 Jan 2024 05:05:51 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id ch19-20020a170906c2d300b00a2b091e93aesm2048007ejb.115.2024.01.10.05.05.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 05:05:51 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3373a30af67so3829489f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 05:05:51 -0800 (PST)
X-Received: by 2002:adf:f604:0:b0:336:6422:708d with SMTP id
 t4-20020adff604000000b003366422708dmr349222wrp.116.1704891950857; Wed, 10 Jan
 2024 05:05:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228054630.3595093-1-tfiga@chromium.org> <CAK7LNATBipJtprjvvRVYg8JcYOFXQdpLEyEc+4+8j1PtBQ+PUg@mail.gmail.com>
In-Reply-To: <CAK7LNATBipJtprjvvRVYg8JcYOFXQdpLEyEc+4+8j1PtBQ+PUg@mail.gmail.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 10 Jan 2024 22:05:33 +0900
X-Gmail-Original-Message-ID: <CAAFQd5C3vAUJhKiQ1LPkZv3dJxNvK4QinRezV9Q8rz_Ov6FSUQ@mail.gmail.com>
Message-ID: <CAAFQd5C3vAUJhKiQ1LPkZv3dJxNvK4QinRezV9Q8rz_Ov6FSUQ@mail.gmail.com>
Subject: Re: [PATCH] kconfig: menuconfig: Make hidden options show as dim
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jesse Taube <Mr.Bossman075@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2023 at 1:10=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Thu, Dec 28, 2023 at 2:46=E2=80=AFPM Tomasz Figa <tfiga@chromium.org> =
wrote:
> >
> > When hidden options are toggled on (using 'z'), the number of options
> > on the screen can be overwhelming and may make it hard to distinguish
> > between available and hidden ones. Make them easier to distinguish by
> > displaying the hidden one as dim (using the A_DIM curses attribute).
> >
> > Signed-off-by: Tomasz Figa <tfiga@chromium.org>
>
>
>
> Do you think this is useful?
>
> This changes the color only when you select a hidden item.
>
>
> For unselected items, you cannot distinguish hidden ones,
> as A_DIM has no effect to black text.
>
>

Hmm, are you sure about that? For me it seems to dim the text. it
seems to be also used in the existing code for dlg.button_inactive.atr
of the mono theme:

https://elixir.bootlin.com/linux/latest/source/scripts/kconfig/lxdialog/uti=
l.c#L26

Best regards,
Tomasz

