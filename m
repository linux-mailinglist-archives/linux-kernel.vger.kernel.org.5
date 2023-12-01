Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A855D800FAD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 17:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjLAPuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjLAPuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:50:08 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D731711
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 07:50:14 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5cfc3a48ab2so24763167b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 07:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701445814; x=1702050614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjy4k2jP/Byy5bf8/WFYn4LmFLJD1039JGTAsB+jeJU=;
        b=NHuEBCIEmm30FkAmtDwUNLk+W09dAP4c6jAMygGUGp0LGmyhBGZLqUpaYExf7Ron9a
         l4ebaQBfkQb387C74R3xaFO6MJo3NnnnPnAoSPZpeViRzP6TxDM9Be2n8aUsePyBD8/2
         KatgTm9BA2aIh9DXvrZeDNSWrfxftFyITCWcJ/K9GH61uZFGchmXHVk7z5Lz5CIoZkot
         Fbx3b5fCxFG+/vVFC1Z49gZ8QAiaZNlfMNBYU3Psq7DoBsS2al4iUsfZsmnbH7v60J4b
         8fP0KoyrXY8YeghFMlWGWcD9Ucpw7Venay9FwxiFl72tveQTZFTqV/ZVPVBwl20GJbXk
         esdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701445814; x=1702050614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjy4k2jP/Byy5bf8/WFYn4LmFLJD1039JGTAsB+jeJU=;
        b=C3xJvGulDKbvpeqCEOCN2sNmtJB5ThgdjKLhZBNIx/Q70QlpKYM8UZ+aqMwaVgAh6u
         XdMSe1m9TocQM5KUi4aQMzSAaBGYogSLGqAuAM9CFo1/4VeTlC6Gnz5USne/U47neO2J
         jBclGX11CDi3kspozdXWQFFq9Jw2DeeOG9zLnHh8zEvrhxTES27jtmCrE4UB3YH/q6CO
         pRm71Kl6f/HAukNchcK572pcDGuNVJIpuXx4hVkP457GN92HYRZ3dV9TWsQ8EtlMLVcO
         W3dRiXTlSoRZK68ibdJ421QyPL2QX1MCmlL7th0UhkKRyX8jpzO+NjajKpRZhiKMEWcM
         +OTA==
X-Gm-Message-State: AOJu0Yz30QWF/pxLIjwy7AWv+vgwBX3ffy4F7hRwKZfh348SA7fqQb4Z
        rrFkvXGy99Y36VP9YHFTBjbrOhXPY+0UmMRg25k=
X-Google-Smtp-Source: AGHT+IGBOTrrcYuF29JFAsyKhZ26iGdGlKvm2h2vFYI7FbJ41YNXli1q9dKl08mq+EYWp//J0jjSmpV3MCkO2ao4cYI=
X-Received: by 2002:a81:4524:0:b0:5d3:c52a:1972 with SMTP id
 s36-20020a814524000000b005d3c52a1972mr3680768ywa.7.1701445813720; Fri, 01 Dec
 2023 07:50:13 -0800 (PST)
MIME-Version: 1.0
References: <20231115210245.3744589-1-robh@kernel.org> <CANiq72=VGJDcK=tVkOFCnTumxDNE9YfiyAVocmD534mnAd_1CA@mail.gmail.com>
 <CAL_JsqLcqpGa=sc9niVK=-4LtVyr3jtUBcQJ2pNsafc3PQpj_g@mail.gmail.com>
 <CANiq72=_VtkEYLYZxz9uyAgFuL4-ZemUAmfWYZR3bcWaDSB=TQ@mail.gmail.com> <CAL_JsqKUVC7ORMRmpPLYqVYhEAb8eiPWWJkesy6K3OiHcL8Kdw@mail.gmail.com>
In-Reply-To: <CAL_JsqKUVC7ORMRmpPLYqVYhEAb8eiPWWJkesy6K3OiHcL8Kdw@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 1 Dec 2023 16:50:02 +0100
Message-ID: <CANiq72mraaAuw8fLNS-8+nc=b=EkGau=Aa56tpp-Vrh+N87-sw@mail.gmail.com>
Subject: Re: [RESEND PATCH] auxdisplay: img-ascii-lcd: Use device_get_match_data()
To:     Paul Burton <paulburton@kernel.org>, Rob Herring <robh@kernel.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 1, 2023 at 3:20=E2=80=AFPM Rob Herring <robh@kernel.org> wrote:
>
> Please take it. There's other dependencies already, so I'll be sending
> the final patch to Linus at the end of the merge window or after rc1.

Applied, thanks!

Paul: please double-check/test it (I just compile-tested it) and shout
if you do not agree with the change. Otherwise, I will send it to
Linus for the next merge window.

    https://github.com/ojeda/linux/commit/c52391fafcefe4c562bdac62088a2735c=
185b942

Cheers,
Miguel
