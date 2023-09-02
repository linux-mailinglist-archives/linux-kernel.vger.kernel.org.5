Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1585790897
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 17:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbjIBPvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 11:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbjIBPvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 11:51:00 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE7BE5C
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 08:50:50 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5922b96c5fcso402667b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 08:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693669850; x=1694274650; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pRMCIrxRKvjA3fHuNLxm+TCxQxtaqWRK8gpzuCewrLY=;
        b=EAmf9c9J1vrcGJkPO9w1PWNd9nb+IiW/grrYGWDVbYJVeOBEmVcMSWXveZQXna2E1w
         bmcqKnt/vMsoFonjCnqajYjIC59E1elDaxBpgotRz23448+hjvI8anbuqsqA6LA4lD2M
         dMMqgmtAXnTZoA6aVjoHUCozuBbzmahDsHSDL9i75oBTmKza/4Od/6t70YROUUtXUKcq
         gI4JqMMouT26NWDG5RXaefQb/9oUWvtVbZEa4IiGjnmK+Dqs/aOePpnomjGXvOa4N3pJ
         8nuJ6vB6BxXs7YVy1WOhHRRxkayQ2ugdPEg2yMJvS3sJSIqVBeQKbbpJdOAss+L4p5dx
         j24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693669850; x=1694274650;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pRMCIrxRKvjA3fHuNLxm+TCxQxtaqWRK8gpzuCewrLY=;
        b=B2DmhDfqBcRynBD6hTSPeezTFV4OgZfnlFj2ZSNj73pcY8VQhDCJaxBi7aRP2ZYrfP
         mHHTP0WlkySKzvJATSqPQjIReQQtrNODyiFGrsB9jP5wb88brT1DupN1TwhqbipHSeQY
         xhwbDliorgBUlZRu9VLSe8/SCHmZKkjqh85X386yLSsX3OGRlAmtrZL0JheZ60FPxYGU
         F8J7k9F97Ho4xLQ520Eg0p8UMAppNtOJYeVCfCFEu08pfPkKG14vFgNdzJrlfH+QIOik
         yg4TEHJfFmLbNfpybIl8mj63Fud2aivIhNIWOwZazp0hRHfGkXqqBNntba7bu9O6Q3nL
         Kl3Q==
X-Gm-Message-State: AOJu0Yxjk/8EUahKko9dOiC0OiO6oHzP4dh/ILrmXJIH+XDp0wWAHCyl
        7X8HlJOh41Hd0wl6o0jDX4d20w==
X-Google-Smtp-Source: AGHT+IEkAsyisZiz8vks79pWVNznhUxJYhALx926CW/w3O1pO2fXrC4tJqmdJCpcgyPEMjj+gItlXg==
X-Received: by 2002:a81:84c8:0:b0:576:93f1:d118 with SMTP id u191-20020a8184c8000000b0057693f1d118mr6982475ywf.2.1693669850085;
        Sat, 02 Sep 2023 08:50:50 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id l188-20020a0de2c5000000b00597e101dbd5sm1683494ywe.13.2023.09.02.08.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 08:50:49 -0700 (PDT)
Date:   Sat, 2 Sep 2023 08:50:41 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        regressions@lists.linux.dev
Subject: Re: 6.6/regression/bisected - after commit a349d72fd9efc87c8fd1d16d3164752d84a7275b
 system stopped booting
In-Reply-To: <CABXGCsOM0j7ME4iUDbf5fpLMxZicXHwT9aBGWXCNWUVSPUO0Sw@mail.gmail.com>
Message-ID: <ffb3fb7e-69f-d5b5-84a2-e51595a4a99e@google.com>
References: <CABXGCsNi8Tiv5zUPNXr6UJw6qV1VdaBEfGqEAMkkXE3QPvZuAQ@mail.gmail.com> <3548ca67-ce58-3bc6-fef5-348b98d7678b@google.com> <CABXGCsOyamBvQ=Y-M9HQBTfEDfaRwGqzXqayBm7L259Q+t+gJQ@mail.gmail.com> <98eb1ba4-5bd3-ee7-1a88-47b054dc938@google.com>
 <CABXGCsOPcu8R9rpdihNR5r822FAHBZ42wBa5XUa5RDVierD_tg@mail.gmail.com> <5e4d50d4-978-ce54-e1ae-40f7117dbf3d@google.com> <CABXGCsOM0j7ME4iUDbf5fpLMxZicXHwT9aBGWXCNWUVSPUO0Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Sep 2023, Mikhail Gavrilov wrote:
> 
> Great, this is the right patch.
> Both build a349d72fd9ef and latest in Rawhide (now it is 99d99825fc07)
> works fine after applying this patch.
> So thank you a lot.
> Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

Great, thanks so much Mike: and Linus already took it into his tree:
ee40d543e97d mm/pagewalk: fix bootstopping regression from extra pte_unmap()

Hugh
