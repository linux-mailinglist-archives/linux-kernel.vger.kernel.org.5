Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD143774AD4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbjHHUgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbjHHUfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:35:46 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B700E5EA3A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:05:42 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fe7e1ef45dso645887e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 10:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691514339; x=1692119139;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1uNjCc9Bzcn7Dor1sdhjCXOwNWmVk+6MaO4ncMW1tgM=;
        b=gifu3hI3Y2Y1Hqj/X0HI3y5JgWHgfs81ZFYzlTJgFMo66Ka4YBt+qKw1/kWUd7NaT5
         3892R2r454SKdtdIaycq6gbtSmTvMl5F6NOC83SNvQglwYfBBPyXYF0GBCgmmXJyVSpl
         qEg0gZuD3KItQIaj5YpOiVxRj65+qkuXsDpsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691514339; x=1692119139;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1uNjCc9Bzcn7Dor1sdhjCXOwNWmVk+6MaO4ncMW1tgM=;
        b=DaVIRUryNbR5U3eE8oL6s1nATm3A9DpGCqemIipAwEnTQkwcQvE+pUmer3MBdB2/7O
         wT7R3W5soKdKT0cU0U95b8edosLWUVyojT5aEEmaqVYJ7miwyU8HXlBnvhi28DZM6Gcd
         GYSKEBa3/vOz8BFQMYY9dMmeR/TgJk67qgK2M84yXT2GM8qvgRguSOdtK3BCsvARe5DU
         ihet5fOnlS+ykWFIcDXmK/lXqk1UBXzz/Ej2rfs0FYHpuP9FHnMpqPXJjHGSVubebNvR
         ebEKd6uE+C5WIi3tjN4JBQIZlywGlsTSfH1wiZPIpLNEeWM8bhx6sHfAK0WXxiRnSgBd
         563g==
X-Gm-Message-State: AOJu0YzXZdXkv9qczJglPZO+Ed18dCDELoM6+Y74GTEsNRt5RUUuTPcO
        qm8ZVhQ4bCY3s56nDGFVyL0edu4ejCWsjVDuh3TdGxxy
X-Google-Smtp-Source: AGHT+IHZAUJkbjLmLXRi2aTVpXgJx2LB7c356ZEWWF2VCDNxRDVAMTnie8T+YVhNxtsUV+Kig9Q6GA==
X-Received: by 2002:a05:6512:4002:b0:4fe:2f8a:457e with SMTP id br2-20020a056512400200b004fe2f8a457emr79772lfb.43.1691514338876;
        Tue, 08 Aug 2023 10:05:38 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id p20-20020ac246d4000000b004fbf37b73ccsm1954906lfo.284.2023.08.08.10.05.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 10:05:38 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4fe21e7f3d1so9724697e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 10:05:38 -0700 (PDT)
X-Received: by 2002:ac2:54ba:0:b0:4fe:f24:cbf3 with SMTP id
 w26-20020ac254ba000000b004fe0f24cbf3mr47081lfk.63.1691514337785; Tue, 08 Aug
 2023 10:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230806230627.1394689-1-mjguzik@gmail.com> <87o7jidqlg.fsf@email.froward.int.ebiederm.org>
 <20230808-eingaben-lumpen-e3d227386e23@brauner> <CAGudoHF=cEvXy3v96dN_ruXHnPv33BA6fA+dCWCm-9L3xgMPNQ@mail.gmail.com>
 <20230808-unsensibel-scham-c61a71622ae7@brauner> <CAGudoHEQ6Tq=88VKqurypjHqOzfU2eBmPts4+H8C7iNu96MRKQ@mail.gmail.com>
 <CAGudoHGqRr_WNz86pmgK9Kmnwsox+_XXqqbp+rLW53e5t8higg@mail.gmail.com> <20230808-lebst-vorgibt-75c3010b4e54@brauner>
In-Reply-To: <20230808-lebst-vorgibt-75c3010b4e54@brauner>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Aug 2023 10:05:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiyeMKrvU5GdjekSF65KS=i3hKzfJ1qe2Xja42K+qOd2w@mail.gmail.com>
Message-ID: <CAHk-=wiyeMKrvU5GdjekSF65KS=i3hKzfJ1qe2Xja42K+qOd2w@mail.gmail.com>
Subject: Re: [PATCH v2 (kindof)] fs: use __fput_sync in close(2)
To:     Christian Brauner <brauner@kernel.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Aug 2023 at 09:30, Christian Brauner <brauner@kernel.org> wrote:
>
> At least make this really dumb and obvious and keep the ugliness to
> internal.h and open.c

See the patch I just sent out.

I hate yours too, for that nasty "bool may_delay".

I hate those "bool flag" things that change behavior of a function. It
may be obvious when you look at the function itself, and know the
code, but then it causes things like this:

        return __filp_close(filp, id, true);

and there is zero clue about what the heck 'true' means.

At least then the "behavior flags" are named bitmasks, things make
*sense*. But we have too many of these boolean arguments.

And yes, I realize that we have tons of extant ones, and this would be
only one more in a sea of others. That doesn't make it ok. So please
keep it to when it *has* to be done to avoid major problems.

             Linus
