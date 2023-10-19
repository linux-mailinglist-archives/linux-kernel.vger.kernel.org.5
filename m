Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6E97D0349
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 22:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346561AbjJSUpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 16:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346397AbjJSUpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 16:45:15 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EF8124
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 13:45:13 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so4284a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 13:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697748311; x=1698353111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVuCB44VLEjsZzvUgM1w7n2lvEI4MsHtEyH+2GVq2dY=;
        b=EulO5Oy4vXgxAA88b1og3ur2Akh0sYSkPVfIpxvdGm4MMF93ZCwC1lj2M+zZLqG6eQ
         A2Pyy0EJ4bXkkrdo7FlBfFVZtAmXDPTVpWgs4MiadRD84rCsdV957TmoxHIs8fAh5OJR
         LWH+O7bqv3+BZ1CoAaTo7px+dZp2vRpOeiIoL5aSkVby89PJtAhnMCGpk9XMaHLfBIms
         vaynbKJref+ZTPRmPnc+Wwjun2M1X65PfBJ5TVBm2ZAJOmc1H34QGZIw5Zo2QtFK0zqL
         CK5pv1cXTUAZOIMeusY13UWvRnqzJaIS6rYMBqCJ7baIWJZlslahMbQxMbWwG3hfByDB
         F+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697748311; x=1698353111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVuCB44VLEjsZzvUgM1w7n2lvEI4MsHtEyH+2GVq2dY=;
        b=V6XlJhOfgLZi6uDHFtUP7hPECkSA5si08lWqonfwg9qn0kX5RHquGq3LEteejvGISk
         IeVfpa5x4kgK1bXNsWkM9xDlWa1yu1XH8P/mKK88iFVyV6Fg28odg+BZUg8GV/5YOzYM
         t5NfxPLHyKayKGdPqxr3T+Wr7cjdoqUVAKuc5eVJ4omz209PPPK8S0ezc31MdI3Y0NHZ
         q7+JSztfQLp4Gav/kIHk/wtdPi7KHFxRmeKcEXkjOIA+w4l+FhxR/kjCeg2xX8wIWWXX
         4/taaGglfwj3YKP8G8I480tACLO3YaB4mMiJkEzeKXisvY8aYGGXq7wkVCJoK6m/kivT
         m38w==
X-Gm-Message-State: AOJu0Yx8zEBwEt3BD/Sus/pGPQcpTTRiqGXs4lk/QivEm+ldwGRXssBX
        e4v+T8E9mPNhzWvnEKtcHRHKC6MQVLadWzCTdNZyoQ==
X-Google-Smtp-Source: AGHT+IHFC9ybSiyivStLgYN8fa6C0ml9tRY1/5sGB2bF7uJu4CHMtn3ZiatZMgc3HYBkARDtPGQ6AHj9IsKbPrz5vok=
X-Received: by 2002:a50:9f41:0:b0:53f:91cb:6904 with SMTP id
 b59-20020a509f41000000b0053f91cb6904mr27602edf.4.1697748310674; Thu, 19 Oct
 2023 13:45:10 -0700 (PDT)
MIME-Version: 1.0
References: <20231016232816.3355132-2-rdbabiera@google.com> <ZTDkIGLmjmL9HwJP@kuha.fi.intel.com>
In-Reply-To: <ZTDkIGLmjmL9HwJP@kuha.fi.intel.com>
From:   RD Babiera <rdbabiera@google.com>
Date:   Thu, 19 Oct 2023 13:44:59 -0700
Message-ID: <CALzBnUF-EZjFEHCc4XRLdFr5yP8dCq7De4SaNif32LcL5=tMYA@mail.gmail.com>
Subject: Re: [PATCH v1] usb: typec: tcpm: only discover modes the port
 supports svids for
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     gregkh@linuxfoundation.org, linux@roeck-us.net,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        badhri@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

On Thu, Oct 19, 2023 at 1:09=E2=80=AFAM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
> I'm confused here. Is the device here the port or partner (or both)?

The port, I'll make sure to be more precise when describing.

> Why are you skipping the first SVID?

Skipping to the first SVID supported by the port when preparing
the first Discover Modes message.

> Please note that the Type-C specification puts priority on TBT over DP.
> Is this in conflict with that?

Not in this case. Assuming the port supports both TBT and DP, a Discover
Modes message will be sent to both regardless of what order they return
in the Discover SVIDs ACK message.

> > Fixes: f0690a25a140 ("staging: typec: USB Type-C Port Manager (tcpm)")
>
> I think that's wrong commit (perhaps you want 8afe9a3548f9d instead?).

8afe9a3548f9d looks to be more concerned with the consumption and
processing of the received payload, I had put f0690a25a140 because it
contained the logic to determine if the Discover Mode message was being
sent at all as well as preparing the response. 5e1d4c49fbc86 does touch
the response formation but only the svdm_version and not the SVID.

> Right now I'm not convinced that this should be considered as a fix at
> all. I don't know anything about the test you are talking about, but
> if this patch is just about making it pass, then there is something
> seriously wrong.

I use the VESA DisplayPort Alt Mode on USB Type-C CTS as a reference.
In regards to this being a fix, if this ends up being more optional (discus=
sed
below), then I'll remove the fix tag.

> If you need the modes to be discovered in some specific order, then we
> need the framework to allow you to do that. So perhaps the tcpci
> drivers should be able to supply the preferred order to the tcpm?
>
> But as such, unless I'm mistaken, this patch will change the logic so
> that only the partner alt modes that the port supports get registered,
> and that way are exposed to the user. You can't do that - right now
> it's the only way we can inform the user about them. All partner
> alternate modes (at least the SVIDs) must be exposed to the user one
> way or the other, regardless does the port support them or not.

The test this patch tries to fix could just be written without consideratio=
n
of this. My guess is that the test was designed such that the SVIDs before
the DisplayPort SVID are unknown to the port under test so the mentality
could have been "why should a port care about SVIDs it doesn't know
about?"

A defense I could make for it is that the USB PD CTS doesn't test
to see if a port under test sends Discover Modes for every SVID returned
in a Discover SVIDs ACK, so the interpretation isn't invalid. I've seen oth=
er
tcpm implementations handle Discover Modes this way as well.

Regardless, you're definitely right that the user should know about all
Alt Modes/SVIDs - the port would lose SVID information without
registering a partner altmode for it. Currently I think the approaches to p=
ass
this test look like:
    1. Your suggestion - let the tcpci decide if there should be a
discovery order.
Alternatively, let the tcpci decide if it wants to opt into this
patch's behavior of
only discovering modes for known SVIDs - a strict discovery flag.
    2. Send a Discover Mode message to known SVIDs first in the order
they come in, and then to unknown SVIDs. The test passes and no information
is lost, but it's unnecessary refactoring just to pass one test for
one Alt Mode.
    3. Don't send a Discover Mode message to unknown SVIDs, but do register
an Alt Mode with blank info for that SVID. It passes the test without havin=
g to
do any reordering compared to the first option and it preserves supported
SVIDs. But, the port would lose information such as each SVID's Alt Modes
VDO plus each SVID can support more than one Alt Mode.

Let me know if any of these approaches sound worth pursuing; I do think
Option 1 does make more sense than the others.

---
Thanks for the feedback,
RD
