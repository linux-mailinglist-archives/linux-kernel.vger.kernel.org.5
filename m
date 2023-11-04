Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0717E0F76
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 13:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjKDMqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 08:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKDMqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 08:46:23 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77245194
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 05:46:20 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507a5edc2ebso1254e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 05:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699101979; x=1699706779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7d3FLwKpFYOTr5gbCWXtm9OztyAg68Ag2ZB+uAGlNg=;
        b=EzuzmZFKo5Z4V3a3r8MfW9fO2I+Jxn1EVYlEq4kvA7vqLBDxTMoi64FesWFc9iTMGr
         zO2KoZqPTqpy2QvcfqCRfi7sZabTWAazWhbigxo5VfIQKfLZtpktK6B5d+TQpfOeg0FR
         u1g4R2XyK3Dxw9wy3fKC8kLSH1fycNFZ8A3fakDH/AR+9hTyqoFlKQvuDFHUzDn4wym/
         mgICGy/TYO0aH7HEDutMuP08z1bgBtbPQB5tzuREF9YrWgnwsjmveY49j9Ka2gvTUowl
         kefnJSyFIg97CkXa9OWzJxSTsmu0FTipIYnpq33DdDtBbFh1OYSKcKVW21uQX/Md995n
         RWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699101979; x=1699706779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I7d3FLwKpFYOTr5gbCWXtm9OztyAg68Ag2ZB+uAGlNg=;
        b=YYistp43kWAKP8S91ksVnBNsrtGzNiYOmgGJ7Ug69s9U+IikYJYKan1mq4l0USQv2X
         F7trA7J9grtwoYdHzQFXZ7RUF3cfwKckL/DvAkD2CvKC623piaP6NdYhChVyHv3ySA+X
         VhjuqCY07CbKCSC2wovisN2JsOhz6fDvnRkQrWMiqg8ABFBNoTmgIvrHYbZY4s+xNhe1
         D3FTG1FjBK//lnC7WebNUELNNLO9x8iPOTgj6/B7/cHwudORXaYWP+SslUyOn9Nb9YaH
         tW/GPXzlVOwUWEk+Nf/mweiBC7CvI9+HUH42I4eAa/zwLOGW1B97XCuvj7L30SJr0QFu
         NQYA==
X-Gm-Message-State: AOJu0Yx4cMyqtt8j+AoB9vR+E4w0MSBoTQI+Ozx8GIOdOVJoT8SzQuRj
        myUTJALjhIyF5+81lcz5ubD7zdyWddFOmVg9K1+4tA==
X-Google-Smtp-Source: AGHT+IGQuFm1gFc9sc9e2VNUxROPUiFQH+ug/+OodDkH/1zwAt+kxlBXU45zcvzvQbGwvs/2T45lbamU0hN70iQXcBU=
X-Received: by 2002:ac2:4c86:0:b0:507:8c80:f1d1 with SMTP id
 d6-20020ac24c86000000b005078c80f1d1mr46272lfl.2.1699101978565; Sat, 04 Nov
 2023 05:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231104000239.367005-1-seanjc@google.com> <20231104000239.367005-6-seanjc@google.com>
In-Reply-To: <20231104000239.367005-6-seanjc@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Sat, 4 Nov 2023 05:46:06 -0700
Message-ID: <CALMp9eQ8F6U4PgP7Bcwd_-m=p8OtSgUW+zTEyDJBrxnq=qBB=Q@mail.gmail.com>
Subject: Re: [PATCH v6 05/20] KVM: x86/pmu: Allow programming events that
 match unsupported arch events
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Like Xu <likexu@tencent.com>,
        Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 3, 2023 at 5:02=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> Remove KVM's bogus restriction that the guest can't program an event whos=
e
> encoding matches an unsupported architectural event.  The enumeration of
> an architectural event only says that if a CPU supports an architectural
> event, then the event can be programmed using the architectural encoding.
> The enumeration does NOT say anything about the encoding when the CPU
> doesn't report support the architectural event.
>
> Preventing the guest from counting events whose encoding happens to match
> an architectural event breaks existing functionality whenever Intel adds
> an architectural encoding that was *ever* used for a CPU that doesn't
> enumerate support for the architectural event, even if the encoding is fo=
r
> the exact same event!
>
> E.g. the architectural encoding for Top-Down Slots is 0x01a4.  Broadwell
> CPUs, which do not support the Top-Down Slots architectural event, 0x10a4
> is a valid, model-specific event.  Denying guest usage of 0x01a4 if/when
> KVM adds support for Top-Down slots would break any Broadwell-based guest=
.
>
> Reported-by: Kan Liang <kan.liang@linux.intel.com>
> Closes: https://lore.kernel.org/all/2004baa6-b494-462c-a11f-8104ea152c6a@=
linux.intel.com
> Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Fixes: a21864486f7e ("KVM: x86/pmu: Fix available_event_types check for R=
EF_CPU_CYCLES event")
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Yes! Finally!

Reviewed-by: Jim Mattson <jmattson@google.com>
