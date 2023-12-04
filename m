Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40596802F6A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjLDJ5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjLDJ5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:57:20 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD9FB6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 01:57:26 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5cbcfdeaff3so49950507b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 01:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701683845; x=1702288645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyeYb+ql0SyNyhyMLosDv4p5iiN7RVdysjk96TvPY/U=;
        b=VNrznMQZQXMwLXSN68X9g5/OdxpIohRK+oNslgHvKEP/xEBwGB7Y8aA4ftrOWHhzLv
         CBj+C1vCGSO+LuYnvysjMY5SPehZXTq+RKMg3ieGrZPxonIy26dbh5OTdrfas3x/l3y0
         tXk0fBMMJcQihEQNoyFpf4141mLrbx2CJu0LfyEpHl0oKnaOI8qJ9rFPzpu/CJRSvDdI
         ZBS8678B9S8ezq4LzEE/ro3yEaiGssVVF4KHMSISDCq+Sjw9jmxJmmBU8CkQSl3dr9XF
         R6orJ4atECtlChdpljU8XVcgpBKm7SZKBTUXPpnA3OdVcMa+e90bqvGhyUgwQOGgUvfi
         2oaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701683845; x=1702288645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyeYb+ql0SyNyhyMLosDv4p5iiN7RVdysjk96TvPY/U=;
        b=hCok4w2VAsO/cOwYFBqAy7NPtLb6oYOuKglsd/CVX6SUhF/ZuuFwkzY2QZzIf6vCea
         IRRtfP7vxHVM9AQhpUeusAW+nsLAZyd8y1IR6JqNQSsQWWuXsbo+2UdmiHmIPqjqabJo
         hVpdSbATtjZyt4IBgrxQGDTK+Nz2qiwIyh1xti9R6J3/zWZlT5o4wESZm6p5lhH3nQh9
         vvdFz8wBAXhgx4NjgL78Cn61tcAGDhEAy3Vhsfc4neyY+mkpEPAyQZcshH3y+vgFtMqw
         Xsfks3xkiKEtLU8zFkpvCFP9mbUMvmonEvbiJm6FTlrvwJsJtTocC9Ab5jrgp2MqlOlo
         fWPw==
X-Gm-Message-State: AOJu0YynkwQoK8J4x49A5AmgHXAzx1oyLYk9e3INQhJdS29htlMTdWJ6
        SIqHmqp2Uq9jvGXVj4hm0BJXREmY4c5DtGE03CRs2w==
X-Google-Smtp-Source: AGHT+IFPNuK+9cOIpKHmoinczKV8MminI3NreBuRG+6sy+RGo1WH4QD56pTWpN4kexe3XakI3kZkEOgDB4+bi46jBIc=
X-Received: by 2002:a81:b626:0:b0:5d7:1940:f3db with SMTP id
 u38-20020a81b626000000b005d71940f3dbmr3037866ywh.67.1701683845464; Mon, 04
 Dec 2023 01:57:25 -0800 (PST)
MIME-Version: 1.0
References: <20231130024046.25938-1-quic_tengfan@quicinc.com>
 <20231130024046.25938-5-quic_tengfan@quicinc.com> <dx62durg3wmqviqdpecdqprd5wwkg4i7n5tgcab55axzssdeel@ftt35c6td2sh>
In-Reply-To: <dx62durg3wmqviqdpecdqprd5wwkg4i7n5tgcab55axzssdeel@ftt35c6td2sh>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Dec 2023 10:57:14 +0100
Message-ID: <CACRpkdZRNvUY0rEY__v9wPy4bjuDSgFhEkXFHxixdfyKSw56Bg@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] pinctrl: qcom: sm4450: correct incorrect address offset
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Tengfei Fan <quic_tengfan@quicinc.com>, agross@kernel.org,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 1, 2023 at 10:33=E2=80=AFPM Bjorn Andersson <andersson@kernel.o=
rg> wrote:
> On Thu, Nov 30, 2023 at 10:40:46AM +0800, Tengfei Fan wrote:
> > The address offset of 0x100000 is already provided in SM4450 DTSI, so
> > subtract 0x100000 from the offset which used by ufs and sdc.
> >
>
> As Konrad points out, please fix the broken patch, don't add a separate
> fix in the same series.
>
> > Suggested-by: Can Guo <quic_cang@quicinc.com>
>
> We unfortunately don't have a way to give credit to those providing
> review feedback, so omit this when fixing patch #2.

Just write in the commit message that Can Guo helped out in reviewing
the driver (just some free text).

Yours,
Linus Walleij
