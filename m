Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B747BAA0D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 21:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjJETZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 15:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjJETZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:25:23 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83540D4D
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 12:25:15 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9b1ebc80d0aso244608266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 12:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696533913; x=1697138713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAIuNzRqeVKL4UBHwUYQTQv/MFOTl6dEpbXD6CCqo5M=;
        b=CP+wsGlVZz+ZBWwKajzI5e//MDd4smfNBVfr7IWfyq0+QnepCbUxNgZEccvXVHMBZp
         SJOje4LpCysyu932xIZpREMKVnEPC8KH5viEu01HeG4u8jsPdQ/V0xPRzXXtWZu9X7R+
         mK28RFL3xFRUho+P+s8qJGLqt19rUgKSsdOF9OCmW5zlLMUVtZyLbZ8od7QeTvK2lMLI
         mO4ZnejzbzuBvRFR+MtxVO+roPVXOWjHrJPZRn/04VWl3m9L06kCwzgInRmynmB2xZvr
         4Yn9H5BrMo8A5LjmeFTLJJbIxKwq8TQ3Iz9dvtTFy5HTbrOj+FHfa3fXbQk0qmVIj1bI
         fnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696533913; x=1697138713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAIuNzRqeVKL4UBHwUYQTQv/MFOTl6dEpbXD6CCqo5M=;
        b=gGwlx7ueel18lGMJTHLBr9klapN3F2GDqNt70hALstxNKabckgD4lKMauwXSKuGFXF
         pnX+U4tr4cE5+Mpe8M7qBLnw/BExRNd+n9PtcnY+pvkEoVNZc9wmXn33lm35fAi6cDfY
         hapJ2EPrVNttRtEKXzDKjbksJWDQzkEdnXrxmVHjOLALPM7gn6s9YlfeCh3TPn5YPgXK
         IZJY1BqCLEIuQnvNHM0cw/aWgaPx1uW4mi9ikEreen04FenEwcAp0Q0njxeCafYvHHeo
         Rj2t/37w54mL2w+SgDdtymw73oXQige93rCoSZ9+QY+q/n43exZFg/2uuRfMq99mKwbz
         rYvA==
X-Gm-Message-State: AOJu0Yx+ki/gKAFVlvZy7G1OP06+2WRYcli1KodKdv7b7AevXW3yBwpe
        QAZ0JtbDa7cMVAZS40lrvcy/oP46Epil9f1/NNi63Q==
X-Google-Smtp-Source: AGHT+IE/lNkGrp8J2WkjY7FP16+AvJpLMZkj9ptYmYvBvpsK946+tDKXzby/+pwCKElpnR04kI+486BfdcMim4oAt3U=
X-Received: by 2002:a17:906:3048:b0:9ae:37d9:803e with SMTP id
 d8-20020a170906304800b009ae37d9803emr5549553ejd.8.1696533913393; Thu, 05 Oct
 2023 12:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
 <20230929-ad2s1210-mainline-v3-22-fa4364281745@baylibre.com>
 <20230930164251.5c07723c@jic23-huawei> <CAMknhBFKSqXvgOeRjGAOfURzndmxmCffdU6MUirEmfzKqwM_Kg@mail.gmail.com>
 <20231005153736.2603dbbf@jic23-huawei>
In-Reply-To: <20231005153736.2603dbbf@jic23-huawei>
From:   David Lechner <dlechner@baylibre.com>
Date:   Thu, 5 Oct 2023 14:25:02 -0500
Message-ID: <CAMknhBEuX9sA_eHM2xqjGkDDtq-hDMtmmYyqYbER3B42TqWRmw@mail.gmail.com>
Subject: Re: [PATCH v3 22/27] staging: iio: resolver: ad2s1210: convert LOS
 threshold to event attr
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
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 5, 2023 at 9:37=E2=80=AFAM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Mon, 2 Oct 2023 11:09:11 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>
> > On Sat, Sep 30, 2023 at 10:42=E2=80=AFAM Jonathan Cameron <jic23@kernel=
.org> wrote:
> > >
> > > On Fri, 29 Sep 2023 12:23:27 -0500
> > > David Lechner <dlechner@baylibre.com> wrote:
> > >
> > > > From: David Lechner <david@lechnology.com>
> > > >
> > > > From: David Lechner <dlechner@baylibre.com>
> > > >
> > > > The AD2S1210 has a programmable threshold for the loss of signal (L=
OS)
> > > > fault. This fault is triggered when either the sine or cosine input
> > > > falls below the threshold voltage.
> > > >
> > > > This patch converts the custom device LOS threshold attribute to an
> > > > event falling edge threshold attribute on a new monitor signal chan=
nel.
> > > > The monitor signal is an internal signal that combines the amplitud=
es
> > > > of the sine and cosine inputs as well as the current angle and posi=
tion
> > > > output. This signal is used to detect faults in the input signals.
> > >
> > > Hmm. Looking forwards, I'm less sure that we should be shoving all th=
ese
> > > error conditions onto one channel. Fundamentally we have
> > > sine and cosine inputs. I think we should treat those as separate cha=
nnels
> > > and include a third differential channel between them.
> >
> > At first, I did consider a differential channel as you suggested in
> > v2. However, the datasheet is quite clear that the LOS and DOS faults
> > (and only those faults) come from a signal it calls the "monitor
> > signal". This signal is defined as:
> >
> >     Monitor =3D A1 * sin(theta)  * sin(phi) + A2 * cos(theta) * cos(phi=
)
> >
> > where A1 * sin(theta) is the the sine input, A2 * cos(theta) is the
> > cosine input and phi is the position output. So mathematically
> > speaking, there is no signal that is the difference between the two
> > inputs. (See "Theory of Operation" section in the datasheet.)
>
> Hmm. That's certainly a bit more complex than I expected.
> Relying on the brief description led me astray.
>
> It's related to the differences in the measured and  as if
> theta =3D=3D phi and A1 =3D=3D A2 (ideal) then it will be A1.
>
> I can see it's relevant to DOS, but not LOS.  The description of LOS
> seems to overlap a number of different things unfortunately.
>

One thing to watch out for in the datasheet is the difference between
the fault output pins and the fault bits read over the bus. The LOS
output pin does indicate one or more of multiple faults, but we are
not currently using that. We are only looking at the fault bits which
are more granular.

>
>
> >
> > But if we want to hide these internal details and don't care about a
> > strict definition of "differential", then what is suggested below
> > seems fine.
>
> Probably best to introduce that monitor signal though we'll have
> to be a bit vague about what it is which has the side effect that
> anyone trying to understand what on earth these faults are is going
> to be confused (having read the datasheet section a couple of times
> I'm not 100% sure...)
>
> >
> > >
> > > So this one becomes a double event (you need to signal it on both
> > > cosine and sine channels).  The DOS overange is similar.
> > > The DOS mismatch is a threshold on the differential channel giving
> > >
> > > events/in_altvoltage0_thresh_falling_value
> > > events/in_altvoltage1_thresh_falling_value (these match)
> > > events/in_altvoltage0_thresh_rising_value
> > > events/in_altvoltage1_thresh_rising_value (matches previous which is =
fine)
> > > events/in_altvoltage1-altvoltage0_mag_rising_value
> > >
> > > Does that work here?  Avoids smashing different types of signals toge=
ther.
> > > We could even do the LOT as differential between two angle channels
> > > (tracking one and measured one) but meh that's getting complex.>
> > > Note this will rely on channel labels to make the above make any sens=
e at all.
> >
> > I think this could be OK - I think what matters most is having some
> > documentation that maps the faults and registers on the chip to the
> > iio names. Where would the sine/cosine clipping fault fit in though? I
> > got a bit too creative and used X_OR_Y to differentiate it (see
> > discussion in "staging: iio: resolver: ad2s1210: implement fault
> > events"). Strictly speaking, it should probably be a type: threshold,
> > direction: either event on both the sine and cosine input channels
> > (another double event) since it occurs if either of the signal exceeds
> > the power or ground rail voltage. But we already have threshold rising
> > and threshold falling on these channels with a different meaning. I
> > guess it could call it magnitude instead of a threshold?
>
> Tricky indeed.  Though I guess we only hit the clipping case after
> LOS or DOS fires or if their thresholds are set too wide (is that
> even possible?).

I suppose it _could_ be possible on the high side if the AVDD voltage
supply was selected to be less than the 4.4V max of the threshold
voltage registers.

> So it is useful to report it as we are already in
> error? Or can we combine the cases by treating it as a cap on the
> threshold controls for LOS and DOS?

I found the clipping error useful while developing this driver since
it help identify that we had a gain setting wrong on the excitation
output (on the circuit board) which in turn caused the inputs to be
overdriven. But, yes when this happened, it also always triggered at
least one or more of the LOS and DOS faults as well.

>
> Even when they aren't just there for error reporting, designers
> seem to always come up with new create signals to use for event
> detection and sometimes it's a real struggle to map them to
> something general.
>
> Jonathan
>
>
