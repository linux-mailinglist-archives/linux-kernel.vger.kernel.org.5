Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E1D7E10BC
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 20:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjKDTXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 15:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjKDTXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 15:23:37 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35BF1BC
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 12:23:34 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9c5b313b3ffso469664766b.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 12:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1699125813; x=1699730613; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JxepWvacGDqpCJSE7j7k1s9SrOuSbIYvnugxYe8U1sM=;
        b=IE3qoE2+mtpNRE4IH9ywT6o1BHa8HFtUzaa09szPAADNjfcXYlF4beMxuCrjbfDlQ2
         kIIBcOanzvOgPhGpNV5M3/wm2XJ2h4tIdcCfUCkhL+4ufb3q+FPDfEtBHNL93N0FUOAn
         FcfMYVlyinWBoiCgvhuRc8yE2JzN8GxYPI6B8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699125813; x=1699730613;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JxepWvacGDqpCJSE7j7k1s9SrOuSbIYvnugxYe8U1sM=;
        b=Ntcz/pxcpCJpBXs0MMNG9NNh+HbRGRWW9LNV74u9sLMxctieqIYt3ilInMgwK/ROwu
         /9GDlMNSktj91NIKfxUAxeKTv0X2fGO77S+WPO+AD1yzwEuOgPeFMEXWrxfoIiudsKmI
         LXTCmECpRzkwEJ5hgfdxbTApveMjZ23PbIOQ9a0wB/baEJkavF+8CYzXwwEIS/Vd+3ME
         zpU71EsF8jPNddoLOm6ff73E3WuH2oXrcRAfIYy5ys5v/WLwUbyvVOn7L7KIa/BNYj3l
         JGQqOIPYj7EruXg2Qj8LpOK52BYMW3vPXGI8rg0N08K0qrTdW08H559aoeLxqQjHoHG3
         aoxw==
X-Gm-Message-State: AOJu0Yywt4PFOjJA5LKvFDP+M1SiRNSLsSKq68/3CyurCMlS9b+W+w3w
        Rg+nhQEPZxFT3e1Sqarcx9B4IMoaD8aaz0r6Hdso/A==
X-Google-Smtp-Source: AGHT+IGUf+6yZ5EYdg/wnHTTO1XfQraEXsRcchzKif3XjqDDa7pCzpKHMsdc9Cpu6aJtXR5+eoe9JQ==
X-Received: by 2002:a17:907:971d:b0:9be:ab38:a361 with SMTP id jg29-20020a170907971d00b009beab38a361mr10385671ejc.8.1699125812963;
        Sat, 04 Nov 2023 12:23:32 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id d26-20020a170906041a00b009b2f2451381sm2226035eja.182.2023.11.04.12.23.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Nov 2023 12:23:31 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-9c5b313b3ffso469662866b.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 12:23:31 -0700 (PDT)
X-Received: by 2002:a17:907:1c1a:b0:9ba:33ef:fe4c with SMTP id
 nc26-20020a1709071c1a00b009ba33effe4cmr10254548ejc.64.1699125811553; Sat, 04
 Nov 2023 12:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <ZUW82S8bGg2BAeNU@codewreck.org>
In-Reply-To: <ZUW82S8bGg2BAeNU@codewreck.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Nov 2023 09:23:14 -1000
X-Gmail-Original-Message-ID: <CAHk-=whcrbGbc5RJ40iCF55q45Hwgb0qw-MfuJqC8SrK62wgKQ@mail.gmail.com>
Message-ID: <CAHk-=whcrbGbc5RJ40iCF55q45Hwgb0qw-MfuJqC8SrK62wgKQ@mail.gmail.com>
Subject: Re: [GIT PULL] 9p fixes for 6.7-rc1
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
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

On Fri, 3 Nov 2023 at 17:39, Dominique Martinet <asmadeus@codewreck.org> wrote:
>
>       9p/fs: add MODULE_DESCIPTION
> (^ I've just noticed DESCIPTION -> DESCRIPTION typo, but I guess it's
> understandable enough and I'd rather not rebase the branch just before
> sending the pull request (that last memory leak patch came in late
> enough) -- please say if you'd rather I fix it up and I'll resend this)

No, no, a typo in the commit message is very much not a reason for
rebasing etc. So sending it to me as-is was th weight thing to do.

I did fix it in the resulting merge message shortlog since you pointed
it out, but hey, if we fixed every typo we had in our commits, we'd be
doing nothing but rebasing.

Kernel people aren't necessarily great at spelling, and that's true
even for those of us where English is our first language.

            Linus
