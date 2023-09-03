Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2F0790E19
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 23:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348319AbjICVJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 17:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjICVJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 17:09:21 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FB7103
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 14:09:18 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so178274866b.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 14:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693775356; x=1694380156; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ETEfE0KXcMXBvMZBy08UTNp3OVjDrmaEtqJyFQMw/WY=;
        b=WONMALfu2j9ZAyF28WSrAF4vpDizubOoLLGn6KO4uIXMNvTR0002pwwMFTIWz/jQaN
         fBFPpPK3+INaAEvIViFxgqBTSzMgok/Wt28tyQLU9nXtVRUiHBOtLzPDf85OHiR2HaQQ
         YjmhP1sFUxAPnRwaSKo2PbNWwPOjVIUfyHVP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693775356; x=1694380156;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ETEfE0KXcMXBvMZBy08UTNp3OVjDrmaEtqJyFQMw/WY=;
        b=cM0LOaw3etmu03fP4Ii1tFwZaKOwvT6F/iwa5oGRIxFUWI+aqKRQSlGAjqTAKQJ28Z
         O4eXKo9KipNJtK//0367CG3anxPvUFWvPiZbX7UCAmrzz7g8ySL88OdOY1J5yxtE/mEB
         EExDYjHp/lWGlgC1IMuveBcVSjPIRHw26YIzoHh3/QjwxlsRg/DqEgQNuoGxa3Io3BxW
         V42fYBkqiZxKYoKyi0FT2pDeYbiObDT9IfimfqjbvGWFJpNqY1DQSN7i5lGPCUPekJWd
         TuVDujpuIy72xktqmskQQhG/YnfAdA9vHV7RCXNDvYpF71ZAla5mQgGx3B6zjMqSFVre
         Q7uQ==
X-Gm-Message-State: AOJu0Yz25ZMpXnsHy3fJ2XAd0osIhL5Y6xqPXQwTSKWx4a9TtYOG4oD6
        BcGfCsfCI25B3QV3QisxK97xuARr84grVTRP1QoaL2va
X-Google-Smtp-Source: AGHT+IHtI/vRUpa+3CSvKOzPcD/XU9ZXO6MFt4i+CYkKpdzzkHH7a1VRkZ+Y74vz/kmyuLk09NpqRQ==
X-Received: by 2002:a17:907:7202:b0:9a2:25da:d71e with SMTP id dr2-20020a170907720200b009a225dad71emr12102042ejc.0.1693775356336;
        Sun, 03 Sep 2023 14:09:16 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id z17-20020a170906241100b0099cf91fe297sm5344262eja.13.2023.09.03.14.09.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 14:09:15 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-52bcd4db4c0so1783524a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 14:09:15 -0700 (PDT)
X-Received: by 2002:aa7:c690:0:b0:523:c36e:ec8b with SMTP id
 n16-20020aa7c690000000b00523c36eec8bmr9015339edq.9.1693775355421; Sun, 03 Sep
 2023 14:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230830140315.2666490-1-mjguzik@gmail.com> <CAHk-=wgADyL9i8r1=YkRTehKG8T89TzqAFMXDJV1Ag+_4_25Cw@mail.gmail.com>
 <CAGudoHH95OKVgf0jW5pz_Nt2ab0HTnt3H9hbmU=aSHozOS5B0Q@mail.gmail.com>
 <CAHk-=wh+=W2k1V_0Om=_=QpPAN_VgHzdZ4FLXSfcyTSK7xo0Eg@mail.gmail.com>
 <CAHk-=wg6bzTdQHSsswHPYFUbb1DfszyWTZ97hZv7bYxaNHVkHw@mail.gmail.com>
 <20230903204858.lv7i3kqvw6eamhgz@f> <CAHk-=whHZ1KJGVKTaBOSr7KwYAqvrjD9bcoz-SKrsW3DdS9Eug@mail.gmail.com>
 <CAGudoHH-KZcmTjPQihiZ3cAYQwyNhw4q2Yvdrxr-xKBp8nTwPw@mail.gmail.com>
In-Reply-To: <CAGudoHH-KZcmTjPQihiZ3cAYQwyNhw4q2Yvdrxr-xKBp8nTwPw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 3 Sep 2023 14:08:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiohUShtCtCxee5-SGvMetd6vgnWgboLNHq2m4cpyNUJQ@mail.gmail.com>
Message-ID: <CAHk-=wiohUShtCtCxee5-SGvMetd6vgnWgboLNHq2m4cpyNUJQ@mail.gmail.com>
Subject: Re: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Sept 2023 at 14:06, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> I don't think it is *that* bad. I did a quick sanity check on that
> front by rolling with bpftrace on cases which pass AT_EMPTY_PATH *and*
> provide a path.

I guess you are right - nobody sane would use AT_EMPTY_PATH except if
they don't have a path.

Of course, the only reason we're discussing this in the first place is
because people are doing insane things, which makes _that_ particular
argument very weak indeed...

                     Linus
