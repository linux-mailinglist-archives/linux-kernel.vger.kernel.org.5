Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199427F8575
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 22:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjKXV2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 16:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjKXV2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 16:28:41 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14E519B3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 13:28:42 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c993da0b9eso3131581fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 13:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700861321; x=1701466121; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UE+udvWHynzozj92dDUIlgeAGu8LTQ+iWilnuivlMqc=;
        b=gBho6sCNs9cgETHAPp8Io4gkWNqWBYUNcmKlU6uO3eK/KmC973ImyHddQrTxdLpvfX
         smpGYEEFqX54bAv5Bny+KHjGqLJKlUnL24u0TlD4ck6AGVGT016FTzIzlEZAUmFmh7OT
         VOQwsYBrPcvkyACgG6YSzch0pXIjIFoNp7snI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700861321; x=1701466121;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UE+udvWHynzozj92dDUIlgeAGu8LTQ+iWilnuivlMqc=;
        b=DjAMEZuc9Yl8bCkbLChOcIrPZ4P3o6ieM184tyU0+hUmD63tPFsIwJxB2ZqNLtf7Qj
         fwjdzOozybfEwfHXbdfY31d1mYtX+08iy7+npULYKESHFk88DmSjG1c3MOqFR5YRAbf8
         3VmoVo9AmT5Z2m6kZxDvuPDfFpVMMtjp8fTppMnD4PrBWNgxuCNbSLCc6lxFr9mhlYk5
         Ap3fZgQri87pVmCJH11HBy7oof5oUrwl9G2CtnggyHhrDL9pLpfwxDFRWCLFnT3b1PgT
         MtmrCMCNAp8LLW6sUK9ZA5MhbsUUPmnKQnedtPy3RMaVHL0JrxXyU1pYRdwhNB/F2ooN
         95aQ==
X-Gm-Message-State: AOJu0Yw/0L6kTYaRlwH+e9yRlyA9Oamlzz/HiqWf5viTuLFmfhMMehYK
        oiHZa77lyunp/A3vu1V16tOFkpYprgrOqPMb3V7i/DAt
X-Google-Smtp-Source: AGHT+IH4NrDiRQh1TLDQx0ileBYT/bNkDXcoWxbapXemB5KZXmAnVXPhSVSdRlQMfWOW1+DYrLsuMQ==
X-Received: by 2002:a2e:9cc5:0:b0:2c5:b3c4:7b17 with SMTP id g5-20020a2e9cc5000000b002c5b3c47b17mr3402294ljj.38.1700861320876;
        Fri, 24 Nov 2023 13:28:40 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 16-20020a2e1450000000b002c8872c9d53sm651617lju.8.2023.11.24.13.28.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 13:28:40 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50aabfa1b75so3207614e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 13:28:40 -0800 (PST)
X-Received: by 2002:a05:6512:3b0a:b0:509:4b78:69b5 with SMTP id
 f10-20020a0565123b0a00b005094b7869b5mr3916662lfv.36.1700861320031; Fri, 24
 Nov 2023 13:28:40 -0800 (PST)
MIME-Version: 1.0
References: <20231124060200.GR38156@ZenIV>
In-Reply-To: <20231124060200.GR38156@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Nov 2023 13:28:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjsmOgYVFEQqikxtpH6w6kJ3YePTHhGVDhZSMLYvXpP8A@mail.gmail.com>
Message-ID: <CAHk-=wjsmOgYVFEQqikxtpH6w6kJ3YePTHhGVDhZSMLYvXpP8A@mail.gmail.com>
Subject: Re: [RFC][PATCHSET v3] simplifying fast_dput(), dentry_kill() et.al.
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2023 at 22:02, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         The series below is the fallout of trying to document the dentry
> refcounting and life cycle - basically, getting rid of the bits that
> had been too subtle and ugly to write them up.

Apart from my RCU note, this looks like "Al knows what he's doing" to me.

Although I'm inclined to agree with Amir on the "no need to call out
kabi" on patch#3. It's also not like we've ever cared: as long as you
convert all users, kabi is simply not relevant.

            Linus
