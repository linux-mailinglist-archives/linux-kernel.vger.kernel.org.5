Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9B9791F8D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 00:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241475AbjIDWh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 18:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235084AbjIDWhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 18:37:55 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E89CDB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 15:37:51 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9a5dff9d2d9so276715566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 15:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693867070; x=1694471870; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8qca5uXQ/xF+tdAyo92FlBltmSbX5l/XJqzvbOU7OH0=;
        b=f1lSYIFW23sFdesDoqVyYdff2pko5C0ql+kWIC9K/Wt7uMWAlmdHJxB7I8OQXXWKXU
         IgFjM2FD7agDRMJmo3isBlWIs3zmrPuFpz5cySzpmKRT7s6lwF5LAn5791iZzgKlCNWl
         H62vjHpF1JX3hzsJ8NgGjyDET4P+Jda5lHjdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693867070; x=1694471870;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qca5uXQ/xF+tdAyo92FlBltmSbX5l/XJqzvbOU7OH0=;
        b=DObRiC8fmvvIOAgYUf6oo/eiAj/9pFT1yah2VAbxcVhtsIxXKkCpkraacf3CIVSx7d
         zskCBi1hDTe3b1wHESJ/ZFpK/Q11sQsbmBRPFYEnmeCxSuMBNosiMWvyhpXpl7ZMOobB
         5XKSyebJ27TZputgvg0S7dMsYx5gKLxyYBC+3fvhuL2hiUhR+939cx0jbiv4aI8zol1x
         9iWu54RJmy4R6PZzdDV+YhBYnKDYDulcn47xcwKCQK31kGKwBOnAq4tw4y1Bs7cBlJuI
         2Xhl3S087YCk4T/UXEjVgLaj0zZmoY/MzEORmSXtJaz8h8ycpGgSqAOkysRkSwkTrVJG
         PEVw==
X-Gm-Message-State: AOJu0YwIKsgEBtsmo646pgVxA/yiR9LvzRyWiA3cvsxr4S+yrddl/Fpp
        aJXrCG+qoEdaoH2ZvlZ6xH7xZxn9nVHsDWgAPji+U0Rt
X-Google-Smtp-Source: AGHT+IFuetOHWpc3kcM6IKrJyAeKFD3Zzy6stvrMgYhxOtY6I1iikz31zBV7IFnC/w8KWK7EJXVUBg==
X-Received: by 2002:a17:906:212:b0:9a6:3d19:df7 with SMTP id 18-20020a170906021200b009a63d190df7mr4516605ejd.17.1693867069852;
        Mon, 04 Sep 2023 15:37:49 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id l13-20020a170906a40d00b0099bc0daf3d7sm6790278ejz.182.2023.09.04.15.37.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 15:37:49 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-31f4a286ae1so918234f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 15:37:48 -0700 (PDT)
X-Received: by 2002:a5d:538b:0:b0:31a:d8be:d6f4 with SMTP id
 d11-20020a5d538b000000b0031ad8bed6f4mr7686624wrv.10.1693867068514; Mon, 04
 Sep 2023 15:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <ZPYuGlUw9K2PcShj@antec>
In-Reply-To: <ZPYuGlUw9K2PcShj@antec>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 4 Sep 2023 15:37:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgbKyC6DTA7OyrtbtuDELaxyJSatkKF75FGWJQGKqXWZA@mail.gmail.com>
Message-ID: <CAHk-=wgbKyC6DTA7OyrtbtuDELaxyJSatkKF75FGWJQGKqXWZA@mail.gmail.com>
Subject: Re: [GIT PULL] OpenRISC updates for 6.6
To:     Stafford Horne <shorne@gmail.com>
Cc:     Linux OpenRISC <linux-openrisc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Mon, 4 Sept 2023 at 12:21, Stafford Horne <shorne@gmail.com> wrote:
>
>   https://github.com/openrisc/linux.git tags/for-linus

Nothing new there. Forgot to push?

                Linus
