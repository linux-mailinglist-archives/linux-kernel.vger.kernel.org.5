Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6117D7FFA67
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346776AbjK3Szg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjK3Sze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:55:34 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E000BB9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:55:39 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-db3fa47c2f7so1165278276.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701370539; x=1701975339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqiQ+l5GpsNJBn0NjDdpVv4owMOTVTjDklgky33CeT4=;
        b=CoBCAfegu1kaMuOggcAor5tWrbFxn3k7LpX4Mn/r3Q/WN2LWSDdPmdTd2k9XrNuAUD
         uMy2rNNOGGFCXv7fSsGm9Dg0hbzFzz47yrsKrs4+crzf7QTfTqLkTzM68q9xn12BN7Ng
         3d/g259x90ZsqT14oENTAIgRnNLT1nFrKNwRmVvk65E0KhO6x/LE2qJ8kBUsO5PIZocP
         DKdcsD5ibys1prs6A/BysSLF35rhJ2xtVf2hHTNqLXoH4kI9vGxh5Fl6SkJFZJMIyEwH
         YDxj0qIb/+dU0tUclFj637EAuzxbzuY5CqiRzj7pA8xJuaqaxaM6W+Ke+lYvavnPz5j7
         +Z7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701370539; x=1701975339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aqiQ+l5GpsNJBn0NjDdpVv4owMOTVTjDklgky33CeT4=;
        b=JxAzZNxI2kx94QBEOwLrToSrDlTCHIDltOvKsR+HAAsKGY8hxCzqOoNJPrWMMUdywn
         oBtoEr7ltE6s0yFCZEuqKV2cEVC/GPEHDA+YAlRhVjquAW/1IHlFtfXH/KzmHLVd8GS0
         iiK1bgzhikEqeyugdbNrJKj18RXsElkPba6qz/MRmsvMt/DQBLp8eDQmBQYQStkGFphH
         mIOjuJCmzztZc+Q6NT4Wir3tvg9sRaiss/15TN0pc8Gd7HLaNZsDqZ1fhbdMrrZ5NXbG
         2GOSoeYTotDBrpaPxg5q8BxkkMG71hOBc/PbaD7HubI34O/vwFgYvsIcjbPTWTAmVvuL
         3g2g==
X-Gm-Message-State: AOJu0Yzl2mKIvIlD9CDY8uJKDSjvR6RestdPSwiWndYEi8o9hN4zXeGV
        LCvMG+SkXP1Qf2hOZ/Jxtvt6Ch0WdqBSzlDFBCk=
X-Google-Smtp-Source: AGHT+IGp4jfCksWHhIxrXtk92hAfJRjMkzkCt1D9XW6BRXH7PMp24INwxdWYFCNnmcFg88+EirdiYRTh3Hh/fNuBrE0=
X-Received: by 2002:a25:2186:0:b0:db5:31ee:cb9 with SMTP id
 h128-20020a252186000000b00db531ee0cb9mr4320408ybh.0.1701370539088; Thu, 30
 Nov 2023 10:55:39 -0800 (PST)
MIME-Version: 1.0
References: <20231115210245.3744589-1-robh@kernel.org>
In-Reply-To: <20231115210245.3744589-1-robh@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 30 Nov 2023 19:55:27 +0100
Message-ID: <CANiq72=VGJDcK=tVkOFCnTumxDNE9YfiyAVocmD534mnAd_1CA@mail.gmail.com>
Subject: Re: [RESEND PATCH] auxdisplay: img-ascii-lcd: Use device_get_match_data()
To:     Rob Herring <robh@kernel.org>
Cc:     Paul Burton <paulburton@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 10:02=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:
>
> +       cfg =3D device_get_match_data(&pdev->dev);

This sounds good to me, but a couple notes:

  - This could be `dev` since we have it, no?

  - Orthogonally, should we just directly initialize `cfg` since now we can=
?

Cc'ing Geert as well since he was the last one touching the file (in
fact, he added the `dev` variable).

Cheers,
Miguel
