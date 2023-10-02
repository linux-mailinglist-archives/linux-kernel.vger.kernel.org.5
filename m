Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C717B5A8B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238841AbjJBSuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 14:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238791AbjJBSuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 14:50:08 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC45C9
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 11:50:04 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so44865a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 11:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696272603; x=1696877403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lci7aE9Nr12rnsuBj8lxjXGwqKY+F3Jq4/Wt3MfIP2I=;
        b=O38wsdmxtsyna4oOXPYL4H+Twdm/qOzAHz9KQdyr4mqdZm+XuEjlfGkoeVFVJcNc5K
         prA2f9hvBEW4j2GmaGH+mZkZEuZ7vT4tUN2PxFMO2zFWEE78UN/L9tZd8yFrHysdI8bT
         Sjc3V/qlMwZ1PRlCe0NqqX9v5qQTmI5EF7BTNqXre8YISVLhtQpO6aIJMkmfwql5Lm16
         NmqVf4qF0BgshIbmiVXajOgmlD8yV61dL7MA9kXd2at14bpFxY5a5eLR8VLZ09cUemol
         lNY/6flNkYKFezBSqltNp1tBut2dhfOiKHBPJyr93qOwO1KVDXkS3sua5eKiEcvtVpi6
         eqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696272603; x=1696877403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lci7aE9Nr12rnsuBj8lxjXGwqKY+F3Jq4/Wt3MfIP2I=;
        b=L3DdhL7KtECTijHGzDznB/usagnQz7z4Gwi5EdMpSpJeI7E+8JjvQZzbnwv1Mi56o6
         nAGgY3OkHmcGeb0F6W5Lu63z3cXh3hjlHVhgwGNaQHz8NVk7TrW2W88G4DqOr7TvV9Sx
         GdfEYODUdTUM8tzvgGzapPkjoKNg20gTKC7BhDJXjPQaBr032ic8U/9X/8UoTphXOaWk
         nJacKOJ5N9oBSKcjwWVI61y1fwC8WaG4p1xPqxTt+YtPoHYxELMLeTBlbwShzTyYApVU
         mzyVWdoFdBvBUKo/hBm/FPrnT/fTwYyp0s3/bcYIMGAvhZa07+g37HtLFEoOJXuuTeFX
         DrvA==
X-Gm-Message-State: AOJu0YyhP1txJ6zqQiwFdQjDkW/OBTpTRNHJuhBtTeu4eTe3sabtoXFQ
        L+M2njm4YdtqcGFQEIJzJsD68hTEFi1rIq2WuoE7qQ==
X-Google-Smtp-Source: AGHT+IGL+kcb6ZIi1pHexQ8Fkm4S3zA9EjTyFErM4ZJzlSAeQCJ0yHHY0K9LT47stqhw9jK05IhHUx7c6c+C9uoQT4Y=
X-Received: by 2002:a05:6402:1a28:b0:531:1241:3e98 with SMTP id
 be8-20020a0564021a2800b0053112413e98mr9957195edb.9.1696272602654; Mon, 02 Oct
 2023 11:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
 <20230929-ad2s1210-mainline-v3-26-fa4364281745@baylibre.com>
 <20230930170046.36637e9c@jic23-huawei> <CAMknhBH4+cUSX_j3-Y0xuTEiZHd3Ke4Zm8FdxLZJwn5gr_d-ug@mail.gmail.com>
In-Reply-To: <CAMknhBH4+cUSX_j3-Y0xuTEiZHd3Ke4Zm8FdxLZJwn5gr_d-ug@mail.gmail.com>
From:   David Lechner <dlechner@baylibre.com>
Date:   Mon, 2 Oct 2023 13:49:51 -0500
Message-ID: <CAMknhBGFpYx3oYqJgVgKZpoeANmVmXtUn+V3VnAW7woc7ytTow@mail.gmail.com>
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
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 2, 2023 at 11:58=E2=80=AFAM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> On Sat, Sep 30, 2023 at 11:00=E2=80=AFAM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> >
> > On Fri, 29 Sep 2023 12:23:31 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >
> > > From: David Lechner <david@lechnology.com>
> > >
> > > From: David Lechner <dlechner@baylibre.com>
> > >
> > > When reading the position and velocity on the AD2S1210, there is also=
 a
> > > 3rd byte following the two data bytes that contains the fault flag bi=
ts.
> > > This patch adds support for reading this byte and generating events w=
hen
> > > faults occur.
> > >
> > > The faults are mapped to various channels and event types in order to
> > > have a unique event for each fault.
> > >
> > > Signed-off-by: David Lechner <dlechner@baylibre.com>
> >
> > Use of x and y modifiers is a little odd.  What was your reasoning?
> > Was it just that there was a X_OR_Y modifier?  If so, don't use that!
> > It seemed like a good idea at the time, but it's not nice to deal with
> > and requires a channel with that modifier to hang the controls off
> > + make sure userspace expects that event code.
>
>
> Regarding the point about "requires a channel with that modifier to
> hang the controls off...". Although that comment was about modifiers,
> does it also apply in general.
>
> There are several fault events that don't have any configurable
> parameters, namely _sine/cosine inputs clipping_ and _velocity exceeds
> max tracking rate_. So there won't be any attributes that contain the
> event specification for those (e.g. no `events/in_angl0_*`
> attributes). It sounds like this would be a problem as well?
>
> Should we consider a IIO_EV_INFO_LABEL so that we can have some sort
> of attribute (namely `events/<dir>_<channel spec>_label`) so that
> userspace can enumerate expected events for non-configurable events?

Well, I didn't think that all the way through before I hit send.
IIO_EV_INFO_LABEL is clearly not the right way to implement a
`events/*_label` attribute, but however we consider going about it,
the point of adding such an attribute was the main idea.
