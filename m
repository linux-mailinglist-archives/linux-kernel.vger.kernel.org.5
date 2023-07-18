Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7627570E1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 02:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjGRA2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 20:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjGRA2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 20:28:24 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90251700
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 17:28:18 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fb9ae4cef6so8230285e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 17:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1689640096; x=1692232096;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2L0VdloPCyOSLQrJ9OqnJtdMt4JTIWx7VRtXY1KHvow=;
        b=Iv9CqQHIz/YPk5n8hgWaBwblFrxB0Sm41Ht8+waloy/wSAO08vwWho/NnQRTyQtomj
         /gf0oo8RGaFvndFcZvttGAV0cfGW93LvlakB/KHLEo0ADXwAHmS8ApKrqESOXhHpFVJN
         8vcQhKjWY1qyVWGNV4J0pL4awVOKZM3Dh5tKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689640096; x=1692232096;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2L0VdloPCyOSLQrJ9OqnJtdMt4JTIWx7VRtXY1KHvow=;
        b=eWbxwlQCF9tdpa069iGOeqUPm2PemceOhQLe6ApK0vb6iesHlhFCpJSjsLuVFBXazx
         jGqKjCW1j53bXpHbmLdQW8YVIsk/bg5RffJSmz4MCJwsX98P1iNRor5OL2GaN2ViksFF
         GozmyxvrY53iTQSuXbKFPTTzbeC2A4Iqpx79t6H8UJDeAg5ybmZhog+SW1x72yL1jBwH
         hJ3G7td+wy7/2KpQzklmaQ2/1DiUuFG41Rs7o26ZcAtQMbD3+Is0VDePIEau+xwWQyAp
         NQZkd2Jytzlz2sRoOfSFMlI7cZ7cdbgnSYEK1ajDu4N9RQRhuz+vD4CSvsuaOUvv+rEU
         /PvA==
X-Gm-Message-State: ABy/qLavy9WL/zKauVk/wmLtWy/iGS2V+dHJuE4HcZG0Bhtjxb7b30N3
        +Bwnc+FyzVZXKHUqg0eAe6fTSypHn+DlHaaf6Ic12g==
X-Google-Smtp-Source: APBJJlHrQLTybY0NgJl9MQ9kxeXj/syDXtzDTLdKKAQk7JqS2zsnLbHdtSRxBU1CgDffYQwXurAXoQ==
X-Received: by 2002:a05:6512:3a82:b0:4f8:5472:7307 with SMTP id q2-20020a0565123a8200b004f854727307mr10267046lfu.31.1689640096434;
        Mon, 17 Jul 2023 17:28:16 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id q11-20020ac25a0b000000b004fb93225036sm155564lfn.166.2023.07.17.17.28.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 17:28:15 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4fbc0314a7bso8220118e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 17:28:14 -0700 (PDT)
X-Received: by 2002:ac2:538e:0:b0:4fb:820a:f87f with SMTP id
 g14-20020ac2538e000000b004fb820af87fmr8740043lfh.10.1689640094015; Mon, 17
 Jul 2023 17:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230717223049.327865981@linutronix.de>
In-Reply-To: <20230717223049.327865981@linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Jul 2023 17:27:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=whGm0gQhUUK0o+=rwVTNsFDkjz+6=y+NvmcYe=SCW-2JA@mail.gmail.com>
Message-ID: <CAHk-=whGm0gQhUUK0o+=rwVTNsFDkjz+6=y+NvmcYe=SCW-2JA@mail.gmail.com>
Subject: Re: [patch 00/58] x86/apic: Decrapification and static calls
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
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

On Mon, 17 Jul 2023 at 16:14, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> But what I really want to do is to make x86 SMP only.

I don't hate the notion, but it would make our UP coverage much worse
for other targets.

We already have weak coverage of UP builds anyway, since no sane
developer uses UP. But if we make UP not even be an option on x86,
then that coverage goes from bad to abysmal.

That said, I already floated dropping i486 support a couple of years
ago. If what you *really* want is "unconditional APIC support", then
that would be it, no?

So I don't like "force SMP" from a coverage standpoint. But if the
pain point is "we support machines that don't even have an APIC at
all", *that* I think we could just decide to do.

Hmm?

Anyway, the series looks good to me. I did have one reaction, but that
is probably due to my own confusion.

              Linus
