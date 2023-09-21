Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58C57A9E20
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjIUT4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjIUT4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:56:17 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9255DA9F0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:46:54 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-502e7d66c1eso2325104e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695325612; x=1695930412; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PBK/gazFsyzXOKB+rBrmhryzG1knngQqKvlNh1yC244=;
        b=EsADxX/l8bpSbBR0dOwOGRhFA/s32coC4juMuGu8Ot+SRhWVPckVxv5JqDr9TDrCPd
         nXd+sCZGp9thaoONzvgcToC98HSNv1oBvfAUH+NUpHKDtYu6+TXZWE5aNsqoeWVKI6pB
         POx0yugFS+EPmoHsXcwLnTmNZYGNgY5WU6nzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695325612; x=1695930412;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PBK/gazFsyzXOKB+rBrmhryzG1knngQqKvlNh1yC244=;
        b=EKbAYUBiBMD9xi3oZn/SXB23hAdd9o3d31ipMljrtNvemkVKoPApCw3ygw8lqISWxg
         3uPvK9+gZwDqhD9VvblfLI3mnb0Cpcp93SLIQDCtJ3lJ19I/+xxzMxOde2Ibxumkta+U
         P7BiDNt1cjcySz6tMltHPi3Z3uRCO6peIwEWhcUTMo8IBrDTXCHmm+n4IGAyqfcFJjyn
         0wbfST2pZ2dzLGF5aZlCG7I1+TWWWJWotV3PUKTfm4dAYGmnzbx0lCqTNu/vfacGdoxd
         8Lx0fwBQ8qOXRxgWoy3DsIHG85jB7Ote4qi5km+AdrwEi/o2B89jH1q3nNqvugkgkfSt
         tz6Q==
X-Gm-Message-State: AOJu0YzVI4VJa3KqjIweyvpSc4utO1dQYVlL0rMoneIQD7pXQd3/wRqR
        aBZJJvbgPPqG0OaFyE7064bBeU9aBUGYyOBo0rnXgM/G
X-Google-Smtp-Source: AGHT+IGIH9zxgy8LyXazn08gadTnFG+VwZsdchNPX0qmq7Mt7/PjA7JfEbqbCGln/hxFXFzF6E2MtQ==
X-Received: by 2002:a19:3813:0:b0:4ff:7046:984a with SMTP id f19-20020a193813000000b004ff7046984amr5140997lfa.7.1695325612500;
        Thu, 21 Sep 2023 12:46:52 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id j16-20020ac24550000000b0050300e013f3sm410038lfm.254.2023.09.21.12.46.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 12:46:51 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-503f39d3236so2346163e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:46:51 -0700 (PDT)
X-Received: by 2002:a05:6512:2013:b0:502:ffdf:b098 with SMTP id
 a19-20020a056512201300b00502ffdfb098mr4997773lfb.6.1695325611372; Thu, 21 Sep
 2023 12:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230921-umgekehrt-buden-a8718451ef7c@brauner>
 <CAHk-=wgoNW9QmEzhJR7C1_vKWKr=8JoD4b7idQDNHOa10P_i4g@mail.gmail.com>
 <0d006954b698cb1cea3a93c1662b5913a0ded3b1.camel@kernel.org> <CAHk-=whAwTJduUZTrsLFnj1creZMfO7eCNERHXZQmzX+qLqZMA@mail.gmail.com>
In-Reply-To: <CAHk-=whAwTJduUZTrsLFnj1creZMfO7eCNERHXZQmzX+qLqZMA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Sep 2023 12:46:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjDAqOs5TFuxxEOSST-5-LJJkAS5cEMrDu-pgiYsrjyNw@mail.gmail.com>
Message-ID: <CAHk-=wjDAqOs5TFuxxEOSST-5-LJJkAS5cEMrDu-pgiYsrjyNw@mail.gmail.com>
Subject: Re: [GIT PULL v2] timestamp fixes
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
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

On Thu, 21 Sept 2023 at 12:28, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And that's ok when we're talking about times that are kernel running
> times and we haev a couple of centuries to say "ok, we'll need to make
> it be a bigger type",

Note that the "couple of centuries" here is mostly the machine uptime,
not necessarily "we'll need to change the time in the year 2292".

Although we do also have "ktime_get_real()" which is encoding the
whole "nanoseconds since 1970". That *will* break in 2292.

Anyway, regardless, I am *not* suggesting that ktime_t would be useful
for filesystems, because of this issue.

I *do* suspect that we might consider a "tenth of a microsecond", though.

Resolution-wise, it's pretty much in the "system call time" order of
magnitude, and if we have Linux filesystems around in the year-31k,
I'll happily consider it to be a SEP thing at that point ("somebody
else's problem").

                  Linus
