Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB538124A8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 02:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbjLNBmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 20:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLNBmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 20:42:12 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F85D5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 17:42:19 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a22f2a28c16so256913266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 17:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1702518137; x=1703122937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05lmLmoBqLq27Cy6T0/P3Yy3HS1yBKgzOro5cdtp2xg=;
        b=BSX9bY3MNfBF1QmDA1zTI0RXufBMUZJ31/xwh9PGWv7ubLIdSBmZflsFtKR8X79Q+/
         53eTAxAni5AwMA//zVC4wq3b6tqfRPkizSCVHKgDGYKd6PeUtw/9lS366cn1mBZgp3Dl
         TETvudezp+jNrd3WYMdgQUwiLPo/dsc4ixrbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702518137; x=1703122937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05lmLmoBqLq27Cy6T0/P3Yy3HS1yBKgzOro5cdtp2xg=;
        b=na7YzrSwpvbcx4nyxTJPFMmZwf8ohPrSOm2PEl5qEJN6h2ftze7AAvpj9CVORweUOs
         wEHyU4u2O9Vmq1JJ/uuTdmLWRswtvpFnfxAkuD0tQEWXtIB4i8hPdUEtXO0xwSkpfElR
         pyw97zGLRwDv/mNlZSA1Ip0gLFBKWJykPaOrwwnRj/kBz3bYi2aCU/aQjd4eF9P8i9TT
         PHSpPaIeLFV1/ewRbsUBZqVIcLOCgiYTpeNdwd+6Ud8sCxgComxTX2Oh3Zz6cq+eQguQ
         fXzkevrAyD7x+h3Yok2lW7QY2hp2Oo7iBskms4SYBKH3ZlvRvJh5rJ8ie63gL6dQgU+J
         M2uw==
X-Gm-Message-State: AOJu0Yw4N9mPCE+EpmziEFUpl7uOOsebROKTrx5vo2kTyu2yDcATXKq5
        SUgiME0O8OygOHBYpRcJ2UfNfEpS3Um4UhfVbFzmyKBi
X-Google-Smtp-Source: AGHT+IGK1vDn8yXqPZVv1GdQ0cKs3WKPVDsfU/fNRb2oJhUI4Ok031e+K1pExjxmnW31ICap2WnuEQ==
X-Received: by 2002:a17:907:94d6:b0:a1c:5257:bfaa with SMTP id dn22-20020a17090794d600b00a1c5257bfaamr4219684ejc.50.1702518137508;
        Wed, 13 Dec 2023 17:42:17 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id sk13-20020a170906630d00b00a1e814b7155sm8624327ejc.62.2023.12.13.17.42.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 17:42:16 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-54c70c70952so10333816a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 17:42:16 -0800 (PST)
X-Received: by 2002:a50:8e12:0:b0:54c:5419:c16c with SMTP id
 18-20020a508e12000000b0054c5419c16cmr3661945edw.70.1702518135947; Wed, 13 Dec
 2023 17:42:15 -0800 (PST)
MIME-Version: 1.0
References: <20231014-get-maintainers-utf8-v1-1-3af8c7aeb239@bang-olufsen.dk>
 <5719647.DvuYhMxLoT@radijator> <fdb7c6312ea52086566e279918b5b873c687fecd.camel@perches.com>
 <dzn6uco4c45oaa3ia4u37uo5mlt33obecv7gghj2l756fr4hdh@mt3cprft3tmq> <b3th52nczdpeokggs2ogdnxq36m3jfhrw72ogjhlvnn53ocxy2@s6uhcbdgaowg>
In-Reply-To: <b3th52nczdpeokggs2ogdnxq36m3jfhrw72ogjhlvnn53ocxy2@s6uhcbdgaowg>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Dec 2023 17:41:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjZnfj2=yxokkCcpVdchY-NKwDO_Sh99Rtz7cWqb9OP3w@mail.gmail.com>
Message-ID: <CAHk-=wjZnfj2=yxokkCcpVdchY-NKwDO_Sh99Rtz7cWqb9OP3w@mail.gmail.com>
Subject: Re: [PATCH] get_maintainer: correctly parse UTF-8 encoded names in files
To:     =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Cc:     Joe Perches <joe@perches.com>,
        =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2023 at 17:06, Alvin =C5=A0ipraga <ALSI@bang-olufsen.dk> wro=
te:
>
> Sorry to be a nuisance, but could you please have another look below and
> reconsider this patch? Otherwise NAK is fine, but I wanted to follow up
> on this as it solves an actual, albeit minor, issue for people with
> unusual names when sending and receiving patches.

The patch seems bogus, because it shouldn't have any "Latin" encoding
issues at all.

Opening as utf8 makes sense, but the "Latin" part of the regular
expressions seem bogus.

IOW, isn't '\p{L}' the right pattern for a "letter"? Isn't that what
we actually care about here?

Replacing one locale bug with just another locale bug seems pointless.

           Linus
