Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFF77B583A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjJBQnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjJBQnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:43:35 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AFDC4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 09:43:31 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53808d5b774so4062280a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 09:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696265010; x=1696869810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x93iIN0fNUqVoRi/c/6JJ+kFUaB/mOrDLlTEcgIl4+M=;
        b=yi328mmjajwyHxqAYIb7cxvfQlP5nsVnr6S7Ekg88z9MMu5fXTEAnoIo3/W1fia/BQ
         2M1i+Hcn9NH11dg061mxWxjZjHjE9F3KxmnmQaault8yt/wuH/VBgDb6ma3vUjR078pC
         J/A1VeSS6qUnJaB5MmTtdckhQUCKTPEey/j6Kgc5zfZDfbXvI1l+GViYL03IjA1RfT5V
         hjTxq2bvZp5xyDlcqgYYGELzZUm9AVVG/6sxqbd8qsM2TM2HXpoKUvvw0jmjnw9GrSyb
         7hJHkEcUK0/89v4RSDo0S0Ca433uzBwyJfp+4sD9ONFRoG8/1Io13MphalwFSMQ3Y6Tf
         A55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696265010; x=1696869810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x93iIN0fNUqVoRi/c/6JJ+kFUaB/mOrDLlTEcgIl4+M=;
        b=IbaLG9o2boX0ElJmqLfv/BZqVihSuQ/4uxapRvLWK/M8b6c2jdQlXK3RwIdldkwZQa
         qZHOGifOoTMxhYULrSE1yQemW7JcR+bCvINkOZ2PBhKL4D0MT0oPPpaGbkNieCws63Rp
         3AgD8ioMSl9bDWzgDgr/JslVflnV+0YXt00PuyHpUNp93NdpjzfGlszT/UAWcNRTLGvf
         xz7eGmhVgzMjMunfYZMU2lvKoud+pLGKjEkBFdKf3CebfvzgjC1RUY59OJuaANggutyG
         gI8Hs0otj27Tw/gg11TlSUBJkwMEWguQQ8GTfcjMEaJ4twHLM0++L5ZRyFy31lTPmynI
         KYWg==
X-Gm-Message-State: AOJu0Yx+zWwSJAIWsmisTSdWiFzTz8FDhz0ggCkC30cUr/GtEH1tbP3r
        7VtCPLREs+LrLGt83Uwn/PWWlmKfh/3z3jk0UQKwJA==
X-Google-Smtp-Source: AGHT+IHDDMMxoHK1rMkkwfVFldZ+KWxjIjoU9+PtnwHrVewlRhb5UP5vNxEhatM3whdpv4O1/RWIUBsxnkMjfmKqjDE=
X-Received: by 2002:aa7:c157:0:b0:533:4c67:c911 with SMTP id
 r23-20020aa7c157000000b005334c67c911mr11352514edp.19.1696265010143; Mon, 02
 Oct 2023 09:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
 <20230929-ad2s1210-mainline-v3-26-fa4364281745@baylibre.com> <20230930170046.36637e9c@jic23-huawei>
In-Reply-To: <20230930170046.36637e9c@jic23-huawei>
From:   David Lechner <dlechner@baylibre.com>
Date:   Mon, 2 Oct 2023 11:43:19 -0500
Message-ID: <CAMknhBE0CfASN9Vb0aZWt4Cebik2cF8QVBaXCvyJy9dNF-PjdA@mail.gmail.com>
Subject: Re: [PATCH v3 26/27] staging: iio: resolver: ad2s1210: implement
 fault events
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev,
        David Lechner <david@lechnology.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2023 at 11:00=E2=80=AFAM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Fri, 29 Sep 2023 12:23:31 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>
> > From: David Lechner <david@lechnology.com>
> >
> > From: David Lechner <dlechner@baylibre.com>
> >
> > When reading the position and velocity on the AD2S1210, there is also a
> > 3rd byte following the two data bytes that contains the fault flag bits=
.
> > This patch adds support for reading this byte and generating events whe=
n
> > faults occur.
> >
> > The faults are mapped to various channels and event types in order to
> > have a unique event for each fault.
> >
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
>
> Use of x and y modifiers is a little odd.  What was your reasoning?
> Was it just that there was a X_OR_Y modifier?  If so, don't use that!
> It seemed like a good idea at the time, but it's not nice to deal with
> and requires a channel with that modifier to hang the controls off
> + make sure userspace expects that event code.
>

Yes, I was perhaps getting a bit too creative here (the two inputs
come from transformers mounted 90 degrees apart so measure X and Y
component of an angle). The only reason I did this was to take
advantage of the possibility of an "OR" event to avoid double events
for a single fault bit. We can just go with the double event on the
two different input channels as discussed in "[PATCH v3 22/27]
staging: iio: resolver: ad2s1210: convert LOS threshold to event
attr".
