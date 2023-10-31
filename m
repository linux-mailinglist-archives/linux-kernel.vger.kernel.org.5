Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B6D7DCEB9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbjJaOER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJaOEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:04:15 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62696C1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:04:13 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c595f5dc84so75102661fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dberlin.org; s=google; t=1698761051; x=1699365851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRTIlAh7OIzV3RODVT7AOAa8TASI1wwfrQcS91mwxTs=;
        b=Bj2A3ykPrV9OLqDdGVSoCYA+qV4/R2kQsFJSFTFdcST+vEQ69/MJNVHVp2M1a+Qyh1
         /d8xhPq1B1Zl2znV6h5tBD324+xw+3vA8SlKl+cWsuhWGR/qvvYlXrccnNwZCXpKHO7k
         QzpFmCqXNfLlkeYAAoxDRs+YBqCVkmaWNllAQxjv8UseR0RcyJPezOj4PkfQf+8SsYni
         7upFueOjn/g0G6ZdwzPnOpJQA0SyxAQ07aT+aUYA31/4tMoOGtpvxVgGJ2WHgZJGTJk+
         Llz2iuDKx5JqElEnwwoJZIfDKTiQV7fT30hNWc3XHMMM0oStlPg4H18737/Hyn7VpxOq
         dePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698761051; x=1699365851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRTIlAh7OIzV3RODVT7AOAa8TASI1wwfrQcS91mwxTs=;
        b=Hl4vktfZhhcpq89Lc3iOt1QgJmL/RUE5K9VKsMEVYiGQFRFYyVHXtOxGaV01YLd9FK
         jvmi18yTGkdN0JPa7GHvZkH57Mh6/HYPa7DjoT0bPDUxej+0q1ZcKYSi2tQiYoLMWPDC
         nkyibLDwMCbzk6m337RPb8N3fGzIcOaM75KpbFX89p32D7kj+iWlZene0N4Brav1LBMP
         vqLtuT4XIZUIWCmfhRmk6Y1xPvtMo2xYIDirqedtQtnv8jVtpyqvkVmd3CeAfBVuGx+y
         tAASxKwBvoLLaUZ6wCPl5D3pTIBVBKzUeNglYafTF20YoHtaVFTJeRNUI5k9E3V07qsO
         Sx5g==
X-Gm-Message-State: AOJu0Ywu3UTWHfTzuGU3yuJP7QJyNyTmWRRGhqR72kYMyZuVqdqO0Gy6
        WUFZOLMlkosRiaS+ffZQgA6DF8hQhYn+ah/TPSu60g==
X-Google-Smtp-Source: AGHT+IHnLFd7q2LXO8jzCsHIrlhdssA4af93Pg/BHH/2GIwTcD/7GGjoPOet1oGVMkRbOHKIDUEGce6uKh4n4cnpD9M=
X-Received: by 2002:a05:651c:b9f:b0:2c5:9be0:973e with SMTP id
 bg31-20020a05651c0b9f00b002c59be0973emr978572ljb.9.1698761051274; Tue, 31 Oct
 2023 07:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697650207.git.dberlin@dberlin.org> <079882bf4a7c026547ecf8ad50a2b7a49ade7130.1697650207.git.dberlin@dberlin.org>
 <b907f696-c966-54ef-3267-12833c6f5d91@broadcom.com> <CAF4BwTWzxbpSqeCbcFQjSf3a4sJio8PME-H7w-_juQ3RCmKGmg@mail.gmail.com>
In-Reply-To: <CAF4BwTWzxbpSqeCbcFQjSf3a4sJio8PME-H7w-_juQ3RCmKGmg@mail.gmail.com>
From:   Daniel Berlin <dberlin@dberlin.org>
Date:   Tue, 31 Oct 2023 10:04:00 -0400
Message-ID: <CAF4BwTUCtARMGwUfUiaJK+1DfYtnm8pTZ6sA2UCWEaw0XihbCw@mail.gmail.com>
Subject: Re: [PATCH 4/5] wifi: brcmfmac: Support bss_info up to v112
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
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

On Fri, Oct 20, 2023 at 1:31=E2=80=AFPM Daniel Berlin <dberlin@dberlin.org>=
 wrote:
>
> So, at least in the example code I have, all variants of the 109 and
> 112 structures both have bcnflags in that place - it was always
> missing here.
> For example, see
> https://android.googlesource.com/kernel/google-modules/wlan/bcmdhd/bcm439=
8/+/refs/heads/android-gs-shusky-5.15-u-qpr1-beta2/include/wlioctl.h
> and  compare v109 and v112 of bssinfo.
>
> As such, the 109 and 112 structures are compatible given these definition=
s.
>
> I don't know if what is there right now is wrong, or it is "yet
> another variant" of the 109 structure that we need to handle.
> Any idea what the ground truth is?

Circling back to this - i have checked other sources as well -
infineon also has u8 (though it's marked as padding) there, etc.

As far as i can tell, the structure should have that u8 there in all
versions i can find.

Nevertheless, I think I can make it not matter ;)

I'm going to post an RFC of some patches that handle this and other
structure versioning
things through function pointer structures that we set based on
interface versions available. So instead of setting feature flags, we
query the various iovars/firmware
info for the right interface versions, and set up the
structures/function pointers to handle the versions
we will get from the firmware.

This also makes the common code cleaner as they no longer have to deal
with the structure differences - for example,  brcmf_cfg80211_connect
now just calls
something like drvr->join_params_handler.get_struct_from_connect to
get an extended join params struct of the right version
and doesn't look inside the result anymore. It's an RFC so we can
argue about the approach and APIs, i just did what seemed
easy/obvious.

I have converted bss info, join params, scan params, and netinfo
versions to use this approach, and all now support all versions of the
structures available.

If we go that route, it wont matter if we overlay bss info structures or no=
t.

As an aside, while doing the function pointer work, i discovered some
other structure bugs (missing fields) that seem to be causing
failures/fallbacks on every chip i tested (no matter who the vendor
was).

So for example, some of the extended join parameter substructs are
missing fields, and every chip i tried (5 variants, representing 2
vendors and 3 join_param versions) all gave
BUFTOSHORT when trying to use the join iovar as a result, and all fell
back to using the SET_SSID method.
With the v0/v1 structure fixed, they all use the join iovar successfully an=
d
never fall back.

--Dan
