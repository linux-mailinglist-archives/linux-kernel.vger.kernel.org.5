Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76D7770E77
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 09:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjHEHea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 03:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHEHe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 03:34:28 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FE84ECA
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 00:34:24 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-76cd8dab98fso215304185a.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 00:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20221208.gappssmtp.com; s=20221208; t=1691220863; x=1691825663;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w9uyawjZHnUZYQY4bK5UiV75xekF3m7LclUMpvxGdxc=;
        b=IbJDK+jO92ODgVuLtNd5BBX5bHS0jhghWsv4QkoqAzLulspcFU8J8yP5oK/BKCNU5A
         TImYgK80BkmW2VgCAHSNC1BDqZAXspVbZqkioNomL687pSAlRxTa4r05UdShc7p8lNHi
         C7D9tHV2ZJ2JwPthfG7VlYJhyKxhnpivk4/OdMpf08pr6L83MKupPBa10hBkLEaq1HVK
         Xzv8LTPaBfkLBggHQlTmWmU4Fb+5wIppzN/iuFeUlynHviv5lq2coOcmHdjzAKfprwUy
         mrERV9Ciy4ScmEU9XmK3ArrstMjEqBph4wRxHI1O9AYBkOXm3R3gfUI83zbDkyveYui9
         1oRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691220863; x=1691825663;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w9uyawjZHnUZYQY4bK5UiV75xekF3m7LclUMpvxGdxc=;
        b=aGHe1TXoC3Dp3tnguF5CpByxvb5TvA5YAw8ouyWtqT7beel+of+LNR5Tln/WsmXylQ
         Nf8uKuJIpGutnWHXupoX7z8ZfCbKcCpsl7SP4eBXbos99yICgVkzm5A+lT/+IasrmOfZ
         zs763bXu3t3Ajtnyisxyn2r1KjUya5EqdRWR/TeKN2WOV4BqbaJbqaGk7FsjCO3IB5B/
         8CuOSXcvDzb2C0V50avEUKj65rk4yV7Cc5QVGsZEBf8s/M4fTpRQwTAhM48EEBUI5Em/
         fyLt6iSesRdmUff6YfqDLcZ3qPOZHyjBItmVEf9g7YGTRmIYpzaPmW/ABaZNI/1jkSzG
         Shgw==
X-Gm-Message-State: AOJu0YyMxYY16OwtXLL/IAyFdrqhj8yHrzcFl0ZBXksUP7ePpU7Sqvpk
        of42QHeWzZeDjdP5GfYPsaP16AEMWIV55CzJIwER4s5RlHk7nUCCIg4=
X-Google-Smtp-Source: AGHT+IFdYcostVh57kE1L1S3kadAFjg+9iFXDHE2FAEn7ZWsTWYXPzw41CWvawMnXI34J9XRxsLPlCDQgPGLl/MPP7c=
X-Received: by 2002:a05:620a:c47:b0:76c:97fd:c106 with SMTP id
 u7-20020a05620a0c4700b0076c97fdc106mr5134931qki.70.1691220863327; Sat, 05 Aug
 2023 00:34:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:6209:0:b0:794:1113:bb24 with HTTP; Sat, 5 Aug 2023
 00:34:22 -0700 (PDT)
X-Originating-IP: [24.53.241.2]
In-Reply-To: <c38e208b-4ffa-4310-ae00-412447fc4269@lunn.ch>
References: <CADyTPEzqf8oQAPSFRWJLxAhd-WE4fX2zdoe9Vu6V9hZMn1Yc8g@mail.gmail.com>
 <CAL_JsqLrErF__GGHfanRFCpfbOh6fvz4-aJv32h8OfDjUeZPSg@mail.gmail.com>
 <CADyTPEwgG0=R_b5DNBP0J0auDXu2BNTOwkSUFg-s7pLJUPC+Tg@mail.gmail.com>
 <CADyTPExgjcaUeKiR108geQhr0KwFC0A8qa_n_ST2RxhbSczomQ@mail.gmail.com>
 <CAL_Jsq+N2W0hVN7fUC1rxGL-Hw9B8eQvLgSwyQ3n41kqwDbxyg@mail.gmail.com>
 <CADyTPEyT4NJPrChtvtY=_GePZNeSDRAr9j3KRAk1hkjD=5+i8A@mail.gmail.com>
 <CAL_JsqKGAFtwB+TWc1yKAe_0M4BziEpFnApuWuR3h+Go_=djFg@mail.gmail.com>
 <CADyTPEwY4ydUKGtGNayf+iQSqRVBQncLiv0TpO9QivBVrmOc4g@mail.gmail.com>
 <173b1b67-7f5a-4e74-a2e7-5c70e57ecae5@lunn.ch> <CADyTPExypWjMW2PF0EfSFc+vvdzRtNEi_H0p3S-mw1BNWyq6VQ@mail.gmail.com>
 <c38e208b-4ffa-4310-ae00-412447fc4269@lunn.ch>
From:   Nick Bowler <nbowler@draconx.ca>
Date:   Sat, 5 Aug 2023 03:34:22 -0400
Message-ID: <CADyTPEyQcHd5-A2TLf_-U5KdtA5WKZ_mNYKvx3DSMjkNi99E0g@mail.gmail.com>
Subject: Re: PROBLEM: Broken or delayed ethernet on Xilinx ZCU104 since 5.18 (regression)
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-05, Andrew Lunn <andrew@lunn.ch> wrote:
>> > It was also commented out before that change. It could be that gpio
>> > controller is missing. Do you have the driver for the tca6416 in
>> > your kernel configuration?
>>
>> I have CONFIG_GPIO_PCA953X=y which I think is the correct driver?
>
> It does appear to be the correct driver. But check if it has
> loaded. It is an i2c device, so maybe you are missing the I2C bus
> master device?

That's it!  I needed to set

  CONFIG_I2C_CADENCE=y

and now things are working again!

Thanks,
  Nick
