Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3B7780541
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 06:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357915AbjHRE7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 00:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357918AbjHRE7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 00:59:12 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DAE3A8B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 21:59:10 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so1111631a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 21:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1692334749; x=1692939549;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IbnlWB7AtC2a2bEKPJCs9bv9rfX3lG0Fd+mTh2luRKU=;
        b=d+3dqYCxWr+0knBcL1d5s6SCPHGNeDKB9ymKzXCHL3nRDWE3bsrY8wESK0+F9h9ew/
         LkWRvKryPHBr2rrujDKib19+V3NRaIsJHnmbkr2V3khgSB6UZGWSpflaKmYK2gz8Xy3D
         HHl4ufAoXJWVTXncFUkRkgip8cW5sjKANlda4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692334749; x=1692939549;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IbnlWB7AtC2a2bEKPJCs9bv9rfX3lG0Fd+mTh2luRKU=;
        b=NR77tyJv/Qy3U6FavtX6meP+qfsveTZLY7cHe+2ustWG3qYtDQMHjZXy2t7HKyFQSk
         odx1X096RA4+Uy1wRByUlQ8XqLXpNjdUxCotwnRVC82she0BW5O+ftcrrTaJXkuI14zZ
         cKnCTpbVfA4zY3OG42cni9rbGnaWG0N8BGAYHSr9cGnOqRP500VQpLAqRu1G7kzlOlye
         Pm+PPXpyv5jIsRGgA/7EyywTW05y/vRksMBn0fTOKyG65sHZKA9XG6y4xHxVCm/sgzQY
         kaEnEyAoGasKwms6qmwG5qsmvOQqlQnV9sdKyGCTGSRLSCsqTTM9C8ztxUEW3eCfDxz5
         ZNEg==
X-Gm-Message-State: AOJu0YzUuqmijZEqJZbOGbrtSVK3ifqresQCk0bnAnkmQe+JRPPXSTAI
        6pR6Ac005dakqw0ClItgaK678eRL/etmsDZAxg8U2bVv
X-Google-Smtp-Source: AGHT+IGPh+txaWavGgubgVIwSMGoJtSS9V4+YYjo5ilF6taYMubKCLU1vDaOV3R0qXIz2z2zNgnN/w==
X-Received: by 2002:a05:6402:26d4:b0:522:ab20:368a with SMTP id x20-20020a05640226d400b00522ab20368amr5658996edd.13.1692334749435;
        Thu, 17 Aug 2023 21:59:09 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id t26-20020aa7d4da000000b005233609e39dsm618738edr.30.2023.08.17.21.59.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 21:59:07 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so3398735a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 21:59:06 -0700 (PDT)
X-Received: by 2002:a17:907:7851:b0:993:d632:2c3 with SMTP id
 lb17-20020a170907785100b00993d63202c3mr1499942ejc.21.1692334746234; Thu, 17
 Aug 2023 21:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230817221129.1014945-1-kuba@kernel.org>
In-Reply-To: <20230817221129.1014945-1-kuba@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Aug 2023 06:58:49 +0200
X-Gmail-Original-Message-ID: <CAHk-=wi-DdiZu-zMfE3X5nx4i5farupHmJawz-My_Z2nk9Qkow@mail.gmail.com>
Message-ID: <CAHk-=wi-DdiZu-zMfE3X5nx4i5farupHmJawz-My_Z2nk9Qkow@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.5-rc7
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com
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

On Fri, 18 Aug 2023 at 00:11, Jakub Kicinski <kuba@kernel.org> wrote:
>
> The diffstat is a little massaged here, it's generated from the merge
> of x86/bugs, I merged x86/bugs on top of our previous merge point, and
> you already have those, so I _think_ this is exactly the diffstat
> you'll see when pulling..

Indeed.  Thanks.

> Fixes to fixes:

Heh. New header for an old problem ...

                Linus
