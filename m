Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA9B7B8DE4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 22:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbjJDUMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 16:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbjJDUMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 16:12:39 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F69BAD
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 13:12:36 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-533cbbd0153so327425a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 13:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696450351; x=1697055151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lmwpd1CMBj/zW0Pr+iJ9G2UH6hQACRNF8JDThDi5kTM=;
        b=JQ6OejVVMLR3XZmTp8Y5z1me/wSNEfARN+RnNYxVW7Ibb6Onjv1vDUtQ7UTRuX3PDq
         3ZSPgSjAY7A5nMTktYnaxDD8i5JRA6zpl5sW5lxFsWwMeaIi2l0vIo2XGx+96UZY1pM2
         TxuGHuJ2vozhUtnEBiQaeS4dheph2HGHDYZFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696450351; x=1697055151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lmwpd1CMBj/zW0Pr+iJ9G2UH6hQACRNF8JDThDi5kTM=;
        b=P/7E6GWDA3M6za8tZOa/U3m3MCIPGci337Xs7Y8x1wDiI83fNhYrkjodxcf2zxUfDe
         DWiEwyJaLzAODvMapJfbfP39faRE50DRBVq/XE/jC4d0nOnzQ+jsiFM7rYaNtFlzJVPF
         BPX2O2w8xrL1BaI1kOpUzXm52xES5GXzCdLg/IC4+fBEph4JRUdq6ZY9bDs3hP93FNg1
         RT2x+heotPf1L8ccoLjBmhcUuPlOqBrECdrp811zaQCrR4xcGiYJWA4KZt1eOJpsVKf9
         Pklq+N4J7Z0F3sJdfPH6goOHIOIwwxs/3LjGD6HdpL5c9nGroKa8k9XVRWR+cj6w/MVw
         GLEg==
X-Gm-Message-State: AOJu0YzfFf90BVxhAJCUTyYXqoXwpzL5sdZ9xkMaO75H8kMVUGjeeakL
        y4Z55MzFxIk/bmQDsHrJyRCBmy8vxxwD2dbdO0DvLyeJ
X-Google-Smtp-Source: AGHT+IG7KjmNs4S86344zlg2D6qdS8zlL1wVPc3AwjrhSpbdc3lt6O5BP0vRSI3NvITCN/CBapc1UQ==
X-Received: by 2002:aa7:d912:0:b0:533:4cee:e52b with SMTP id a18-20020aa7d912000000b005334ceee52bmr2688385edr.25.1696450351628;
        Wed, 04 Oct 2023 13:12:31 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id bm15-20020a0564020b0f00b00538538f1fcesm345768edb.47.2023.10.04.13.12.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 13:12:31 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-534694a9f26so301a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 13:12:30 -0700 (PDT)
X-Received: by 2002:a50:d64b:0:b0:538:1d3a:d704 with SMTP id
 c11-20020a50d64b000000b005381d3ad704mr423edj.1.1696450350049; Wed, 04 Oct
 2023 13:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231004192622.1093964-1-dianders@chromium.org> <20231004122435.v2.5.Ib2affdbfdc2527aaeef9b46d4f23f7c04147faeb@changeid>
In-Reply-To: <20231004122435.v2.5.Ib2affdbfdc2527aaeef9b46d4f23f7c04147faeb@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 4 Oct 2023 13:12:17 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UKe33R0z-Qu32F2q4eHdwox88oTprgvDf_bMJZcBM+hQ@mail.gmail.com>
Message-ID: <CAD=FV=UKe33R0z-Qu32F2q4eHdwox88oTprgvDf_bMJZcBM+hQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] r8152: Block future register access if register
 access fails
To:     Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Grant Grundler <grundler@chromium.org>,
        Edward Hill <ecgh@chromium.org>,
        =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 4, 2023 at 12:27=E2=80=AFPM Douglas Anderson <dianders@chromium=
.org> wrote:
>
> Even though the functions to read/write registers can fail, most of
> the places in the r8152 driver that read/write register values don't
> check error codes. The lack of error code checking is problematic in
> at least two ways.
>
> The first problem is that the r8152 driver often uses code patterns
> similar to this:
>   x =3D read_register()
>   x =3D x | SOME_BIT;
>   write_register(x);
>
> ...with the above pattern, if the read_register() fails and returns
> garbage then we'll end up trying to write modified garbage back to the
> Realtek adapter. If the write_register() succeeds that's bad. Note
> that as of commit f53a7ad18959 ("r8152: Set memory to all 0xFFs on
> failed reg reads") the "garbage" returned by read_register() will at
> least be consistent garbage, but it is still garbage.
>
> It turns out that this problem is very serious. Writing garbage to
> some of the hardware registers on the Ethernet adapter can put the
> adapter in such a bad state that it needs to be power cycled (fully
> unplugged and plugged in again) before it can enumerate again.
>
> The second problem is that the r8152 driver generally has functions
> that are long sequences of register writes. Assuming everything will
> be OK if a random register write fails in the middle isn't a great
> assumption.
>
> One might wonder if the above two problems are real. You could ask if
> we would really have a successful write after a failed read. It turns
> out that the answer appears to be "yes, this can happen". In fact,
> we've seen at least two distinct failure modes where this happens.
>
> On a sc7180-trogdor Chromebook if you drop into kdb for a while and
> then resume, you can see:
> 1. We get a "Tx timeout"
> 2. The "Tx timeout" queues up a USB reset.
> 3. In rtl8152_pre_reset() we try to reinit the hardware.
> 4. The first several (2-9) register accesses fail with a timeout, then
>    things recover.
>
> The above test case was actually fixed by the patch ("r8152: Increase
> USB control msg timeout to 5000ms as per spec") but at least shows
> that we really can see successful calls after failed ones.
>
> On a different (AMD) based Chromebook with a particular adapter, we
> found that during reboot tests we'd also sometimes get a transitory
> failure. In this case we saw -EPIPE being returned sometimes. Retrying
> worked, but retrying is not always safe for all register accesses
> since reading/writing some registers might have side effects (like
> registers that clear on read).
>
> Let's fully lock out all register access if a register access fails.
> When we do this, we'll try to queue up a USB reset and try to unlock
> register access after the reset. This is slightly tricker than it
> sounds since the r8152 driver has an optimized reset sequence that
> only works reliably after probe happens. In order to handle this, we
> avoid the optimized reset if probe didn't finish.
>
> When locking out access, we'll use the existing infrastructure that
> the driver was using when it detected we were unplugged. This keeps us
> from getting stuck in delay loops in some parts of the driver.
>
> - Reset patch no longer based on retry patch, since that was dropped.
> - Reset patch should be robust even if failures happen in probe.
> - Switched booleans to bits in the "flags" variable.
> - Check for -ENODEV instead of "udev->state =3D=3D USB_STATE_NOTATTACHED"

Argh, the above 4 bullet points were supposed to get moved "after the
cut" and describe the differences between v1 and v2. Sorry! :(

To avoid spamming people, I won't send another version and will wait
for feedback. I'm happy to fix and send a new version at any time,
though.
