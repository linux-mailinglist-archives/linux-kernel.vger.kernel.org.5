Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669007A2C50
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 02:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238987AbjIPAdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 20:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238748AbjIPAcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 20:32:41 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C13D1FCC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 17:32:03 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bceb02fd2bso42929101fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 17:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694824321; x=1695429121; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hXxPKtz5nN+DfsuKg6sOZlo1Msf7kjZ/mu4lVCkpHMY=;
        b=Q2etY6S6wKtXFJHa27AXeqkuzXd23OkFpret8P3qK3hBJ+UYxb86DQbkQCeEYGmvVw
         mV7QHEP6/lihowvpG7hqAqg8BoW9FC7QAid1ZWcnn7Snmu/RqEOXkrsLrmTMcBzsztaw
         lQSxiJLcHRvrdHaiGNZerJZ1MAUfruogawF2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694824321; x=1695429121;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hXxPKtz5nN+DfsuKg6sOZlo1Msf7kjZ/mu4lVCkpHMY=;
        b=ewNnU2E/xjxkNBgRi5PgMDJvRTOq8v82fcdRbAchcdweKt23G2T8D8yjo6zwAFbV2Y
         GO9sOsHmsaf8uiMl7QDnLK0nq2xDb3ioezZ9DJC9N8SmxSfkb9X+oWjMa/I1kWSSzxHB
         OKVjwyWOuNbmszmhlK31YTyAhYJNdzzQ986mw/NAIK5tzO29Cc4DDIbvW2Q/XbTLmUyg
         rLUoohSUfSnW5ClaLqnywgZhvW6eYqlSK8CjTTrrmQz42ihaUarTg9zUKCP/JJ2XbDwk
         OfulxGr0bwIqanuW3r94sBFQMUrXr/7dRavusLOU4Vavt+j0hmYPl28370401t4OlmdM
         DymQ==
X-Gm-Message-State: AOJu0YyOOtHCcjsBfC3ZVt0s0Ne7mq3fjO/wZ3xDkXhzrcJg3GjOKVTa
        C0usxtaP7pqbLh0h2G3D3IaFE9+2x+xEDwBMkYZ93dC/
X-Google-Smtp-Source: AGHT+IGAn9NQNOzY6/zDsHbalaBsdx1iyvkcVSPTgQio7rNB/RBtILD18MECeHqbBYTubf0HMXfaKA==
X-Received: by 2002:a2e:9084:0:b0:2bb:b626:5044 with SMTP id l4-20020a2e9084000000b002bbb6265044mr3003277ljg.6.1694824321232;
        Fri, 15 Sep 2023 17:32:01 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id b23-20020a2e8497000000b002ba130e9a29sm910393ljh.76.2023.09.15.17.32.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 17:32:00 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2bceb02fd2bso42928971fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 17:32:00 -0700 (PDT)
X-Received: by 2002:a2e:9084:0:b0:2bb:b626:5044 with SMTP id
 l4-20020a2e9084000000b002bbb6265044mr3003230ljg.6.1694824319872; Fri, 15 Sep
 2023 17:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230915183707.2707298-1-willy@infradead.org>
In-Reply-To: <20230915183707.2707298-1-willy@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Sep 2023 17:31:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjU44TsEkoae6HuJi8JcTHMr01JSi_ZhiVTVSwpKvBtXA@mail.gmail.com>
Message-ID: <CAHk-=wjU44TsEkoae6HuJi8JcTHMr01JSi_ZhiVTVSwpKvBtXA@mail.gmail.com>
Subject: Re: [PATCH 00/17] Add folio_end_read
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sept 2023 at 11:37, Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> I don't have any performance numbers; I'm hoping Nick might provide some
> since PPC seems particularly unhappy with write-after-write hazards.

I suspect you can't see the extra atomic in the IO paths.

The existing trick with bit #7 is because we do a lot of
page_lock/unlock pairs even when there is no actual IO. So it's worth
it because page_unlock() really traditionally shows up quite a bit.
But once you actually do IO, I think the effect is not measurable.

That said, the series doesn't look *wrong*, although I did note a few
things that just made me go "that looks very strange to me" in there.

                      Linus
