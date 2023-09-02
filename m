Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2FF79094C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 21:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjIBTIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 15:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjIBTIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 15:08:49 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A031B1
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 12:08:46 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52a5c0d949eso162925a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 12:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693681725; x=1694286525; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mMRyrKbAp4LZVuQSTEbdVAQvbekmFXrSYzVfEdiyF4s=;
        b=IRn5VhmJInfK728yHiVkaYfbMMHaNh8ZCkuBFeASlG+uZ3dV430Zr4vKn30O60dr+J
         K23HM7LnGpoZWVf2U4Fx5gSr2I5pgfC3TOqTn31UR3L6u1v7DD4Y9uGPf0pvpN5G7fiO
         NVddr/ZG5yScD7aHsBo5upq2ZOoEwGlb15j8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693681725; x=1694286525;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mMRyrKbAp4LZVuQSTEbdVAQvbekmFXrSYzVfEdiyF4s=;
        b=PCQCSDmG7eyjwS+Hun0UOO8XOzakmyx8VKKFvWYn8iMO4I1NIFRmOoUkYmiG3+sXZO
         Q8GmawdtkpizX7T/nhi499UeKPwr+k7VUvaBBTRyJwdq8JbG5h3TzSR2T4+9/fp+yx8p
         Jd9uOGZSKwvz22/WLheDjyZet9dzbw2Fg0IbDKqg08/5kv44ITrMMAFuTIshyAzhnlut
         cVSf4uK/9WFwzY0MPzyEIo76OgE2OEOtSNDhnCAcAlOI2kEcRyu4ebc7zK5CWu9FqFv2
         iXCRxm/w66h/E8/e4MIVzOuCl6kh4ZMiFcDF7t7KODQpiVNtH675OoQxwcYBAg1X154r
         GWUw==
X-Gm-Message-State: AOJu0YwtG11+D0gjGDjKWZjuoG7EnSUfhGnA19tHs30zYtMogbLY3qth
        krMztyyy5azNqL5m7rNj9NvShxQBXMEVr2BLThIx5l7k
X-Google-Smtp-Source: AGHT+IFYCVgW24jhoeNCZXpnX8OGAfCFie0P25iHqkLsD600KLk1kqoj1udleeb+hIq7TSwoim9soA==
X-Received: by 2002:a05:6402:17d7:b0:52c:84c4:a0bf with SMTP id s23-20020a05640217d700b0052c84c4a0bfmr1577966edy.30.1693681725068;
        Sat, 02 Sep 2023 12:08:45 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id x2-20020aa7dac2000000b005272523b162sm3642410eds.69.2023.09.02.12.08.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Sep 2023 12:08:44 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-31c6d17aec4so96602f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 12:08:44 -0700 (PDT)
X-Received: by 2002:a5d:6812:0:b0:317:df4f:4b97 with SMTP id
 w18-20020a5d6812000000b00317df4f4b97mr3843777wru.7.1693681724043; Sat, 02 Sep
 2023 12:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <6908480e8808a2d025926f2ff1f9a2468d1b6bb9.camel@HansenPartnership.com>
In-Reply-To: <6908480e8808a2d025926f2ff1f9a2468d1b6bb9.camel@HansenPartnership.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 2 Sep 2023 12:08:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgA6CBwnJ02H+vSgneKPcPRP0BWQ-Kx2Re1B56Y2hXkFQ@mail.gmail.com>
Message-ID: <CAHk-=wgA6CBwnJ02H+vSgneKPcPRP0BWQ-Kx2Re1B56Y2hXkFQ@mail.gmail.com>
Subject: Re: [GIT PULL] first round of SCSI updates for the 6.4+ merge window
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Sat, 2 Sept 2023 at 00:39, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> Updates to the usual drivers (ufs, lpfc, qla2xxx, mpi3mr, libsas) and
> the usual minor updates and bug fixes but no significant core changes.

Removing 3000+ lines for UFS HPB support wasn't even worth mentioning?

I am happy to see it gone, and maybe as a technology it was a failure
not worth it, but as a "we gave up on it as being worthless" might
still have been worth a word or two..

Sadly, I see from the commit message that apparently the next stage is
going to involve zoned storage. Now *there* is a technology that seems
to be a complete failure, brought to us by the same kind of failed
hardware people who tried to convince us that we should care about
64kB pages in SSD's.

Oh well. With enough thrust, even a pig will fly. I suspect that's the
motivating factor behind all those zoned storage things too.

                Linus
