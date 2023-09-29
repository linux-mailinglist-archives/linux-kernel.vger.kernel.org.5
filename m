Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76D77B36DD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbjI2Pd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbjI2Pd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:33:57 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE87B4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:33:55 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so18336622a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696001634; x=1696606434; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dk6zMaY1JI1EwfQXLCF2rqxZErCOZLkm102MXN7pBqY=;
        b=J2ZE1J/EgQtVJERfnnXr8xf28MsEgCRujuvpvvytX4ilUnbQLZkDRGFlrBFJTWA/D0
         8sJmQ8EJmG0X9ntFgW1ZoiLS9YFH/4I1UbaJkdy2ATvdXGI3Z28NkmysYsH0fXJOH+LF
         XGAprIj/LS4VtSZimctY/PPjDxHwHicliXERt1lxBXpyReP9giCsyZsUEfY5y72MqrVB
         hC7j53JMSPfrfrX+sEs3LHV39Z3+tNSIAWJS/nA8mvSzInsg5DXa3hO8BReBiJTXo6/T
         yenUMnSTzuIpyl3GlWiTUPVfGM7Evj+NtAGCRhAAAWyKp3xOtzp8E0I2S+ysDoFhhbip
         Rsmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696001634; x=1696606434;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dk6zMaY1JI1EwfQXLCF2rqxZErCOZLkm102MXN7pBqY=;
        b=HlQJsjeMI3HQ+dU1sZ/I7Hhx6yMC5vBC0LKdlNktC+0JzbqNUVq8bjM+markkBXvj6
         s5Dden35TuF9ixCwmjgIU8p8nAMSXvXWCKsA1upI+bAp7RUFSzpuUDHjwJSHaNUo3YaX
         VCpIkK6sVGfcmqSYMFgeJWw/jlCr5Gltom+gBgmaiMukSvNGs7GDqqBLFhF3STWcdV/r
         FTumz/MOP87eqSRotf73CQ9JtNcEEL53ipTclPLkRBfVse1HjuNwmNy5j3x0zjYaNVlq
         Shf+FreDiDZ56AR+J+E/6zAoC7jdOgKumJoIW9lZHZewGbq0uMMg3+HoNQxDrQEvuNla
         6kHg==
X-Gm-Message-State: AOJu0YwvU+09QY9At+3dEeR0Abb0x0T1gKvOukEBRz9DP3LxuNJ49XzN
        An+Kr9+uasKVlsVmklb4hJRbkmJw8myo76QYiCP/4a0QwRE=
X-Google-Smtp-Source: AGHT+IF2SnE9WoTsJGge/GfnYOAeYBbtrMuu+aFgwP4KNlmreEJCX/DMSy5jz2txnPdkqtHX5oRRXYwg8KVjfs7Rn4I=
X-Received: by 2002:aa7:d481:0:b0:52f:a42a:85a3 with SMTP id
 b1-20020aa7d481000000b0052fa42a85a3mr4092902edr.0.1696001633814; Fri, 29 Sep
 2023 08:33:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:7f03:0:b0:235:af9d:fd1e with HTTP; Fri, 29 Sep 2023
 08:33:53 -0700 (PDT)
Reply-To: maryrosekomo2@gmail.com
From:   Mary Rose <ddiarassouba31@gmail.com>
Date:   Fri, 29 Sep 2023 17:33:53 +0200
Message-ID: <CAFuvAEMY_8c_v7BTn6wi-ikk5nB5yis8rhXQThsen=P27r1z2w@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gott sch=C3=BCtze dich.

Mein Name ist Frau Maryrose. Komo, ich war mit dem verstorbenen Herrn
Kingsley verheiratet, der am 7. Januar 2019 von einem seiner Freunde
in London vergiftet wurde.

Mein verstorbener Mann und ich waren jahrelang ohne Kinder
verheiratet. Und nach seinem Tod beschloss ich, nicht wieder zu
heiraten. Bei mir wurde Herzversagen diagnostiziert, was von den
=C3=84rzten best=C3=A4tigt wurde. Der Arzt sagte mir, dass ich aufgrund die=
ser
gegenw=C3=A4rtigen Krankheit nicht mehr lange leben werde. Mein
verstorbener Mann hat eine riesige Geldsumme bei einer Bank
eingezahlt.

Gesamtguthaben auf der Bank: 4.500.000,00 $. W=C3=A4hrend ich Ihnen
schreibe, ist das Geld auf der Bank. Aufgrund meines aktuellen
Gesundheitszustands habe ich beschlossen, das Geld an das weniger
privilegierte und mutterlose Babyheim zu spenden

Nachdem ich Ihr Profil im Internet =C3=BCberpr=C3=BCft hatte, beschloss ich=
,
Kontakt zu Ihnen aufzunehmen und Sie um Freundschaft und Hilfe bei der
Spende meines Erbes zu bitten. Bitte mein lieber Freund, ich bin zu
dir gekommen, um mir zu helfen, diesen letzten Wunsch auf Erden zu
erf=C3=BCllen, denn ich bin zu schwach, um mich zu bewegen, und aufgrund
meines Gesundheitszustands bin ich an einen Rollstuhl gebunden.

Es ist wahr, ich kenne dich nicht, aber Gott hat mir befohlen, dies zu
tun. Wenn Sie mir helfen m=C3=B6chten, schreiben Sie mir zur=C3=BCck, damit=
 ich
Ihnen sagen kann, wie Sie die Bank kontaktieren k=C3=B6nnen, um das Geld an
Sie zu =C3=BCberweisen. Bitte teilen Sie mir Ihren Namen, Ihre Adresse,
Ihren Beruf, Ihr Alter, Ihr Geschlecht, Ihren Familienstand und Ihre
Kontaktdaten mit, damit ich den Betrag zur Freigabe an die Bank
weiterleiten kann. Ich bin schwach und habe weniger Privilegien zu
schreiben oder zu sprechen.

Ich erwarte Ihre dringende Antwort.

Vielen Dank f=C3=BCr Ihre Freundlichkeit und Gottes Segen,

Dein
Frau Maryrose Komo
