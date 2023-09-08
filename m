Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BEB7980B5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 04:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235560AbjIHCyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 22:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235504AbjIHCyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 22:54:07 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85C61BDB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 19:54:03 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bcfd3220d3so26448221fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 19:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694141642; x=1694746442; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=79oYKkiQaAA0k2s9Eo9LOCvdFF3ynWnYmCNUQgtZYfQ=;
        b=KyzmRl1yyZ9mb96p8FdPbRRz5KZyOO4FQNgQ4D871M0D+Qk9387zzuKKQjp4E1OVbU
         DjeDKwIUdY7RQcDfUWptP1MpkDXUUm4CEyHBKB4CfJMXCFSRXIFVUvZugpiIoiPIU5lS
         YJYsBjkDlA9v7Gg0WUCegeeOChTr4bcZoCIss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694141642; x=1694746442;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=79oYKkiQaAA0k2s9Eo9LOCvdFF3ynWnYmCNUQgtZYfQ=;
        b=daA22j+x5MzhGT7Xd59GCBb19BqEzRI9WTqqV1A4v4S30HBSDcQo7zykGqprM/rhGT
         s9lRJZu0jfj1CALNYOQBsVvZdVvvEGlRbKpn8daHrYV39+Pxs1JuFvLkruoyAHbgUR7V
         DrwllgAXhqhDvQlmbU5zl2bgp+mtXzGzia5YMHmeeG5uFh5+rta1KMxKCE4imJGRBsfw
         QGwni+5jZP926Cl22JEWSLT64YWLvV3c2d40QN24y70x8KLBwrU7Q8ZytLeEfgahPvte
         RYlEEyZ61VRKmAw7e9I4ML15o5JvD2Uj9aX5JUUUFa8DY3VTo4vVXaqfRXTqi1s2w8zs
         e1Iw==
X-Gm-Message-State: AOJu0YzW6Ye4Gac/WNoMNDktNZQwgk/Vm0ca9I81xlnRN5FW/OBiTj3O
        yqlI5Xxv1AUSMh+WRSZ0/oKjFPvBkMvuEtaXa+tx95MS
X-Google-Smtp-Source: AGHT+IG/CXxM9+xoGdikc3DD727u3fR8W2NMhFFW8SOzW9tZbjBqf8AqiByPrteAdhEV+eR8tr26Hw==
X-Received: by 2002:a2e:8718:0:b0:2bc:b9cd:8bc2 with SMTP id m24-20020a2e8718000000b002bcb9cd8bc2mr737441lji.4.1694141641683;
        Thu, 07 Sep 2023 19:54:01 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id u17-20020a170906069100b009a5f7fb51d5sm394797ejb.21.2023.09.07.19.54.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 19:54:00 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-52e64bc7c10so2162710a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 19:54:00 -0700 (PDT)
X-Received: by 2002:a50:ef14:0:b0:523:1f4d:4029 with SMTP id
 m20-20020a50ef14000000b005231f4d4029mr777471eds.21.1694141640514; Thu, 07 Sep
 2023 19:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tx-wOoVEc96nkOh=E5rDhsn-QM+QJF5oeYQK-yi2Cy8uQ@mail.gmail.com>
In-Reply-To: <CAPM=9tx-wOoVEc96nkOh=E5rDhsn-QM+QJF5oeYQK-yi2Cy8uQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Sep 2023 19:53:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjL=mmhfK9NQ3F8aKbSMxp31tPGcKit0=1TsjPDoo2L8w@mail.gmail.com>
Message-ID: <CAHk-=wjL=mmhfK9NQ3F8aKbSMxp31tPGcKit0=1TsjPDoo2L8w@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 6.6-rc1
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
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

On Thu, 7 Sept 2023 at 19:45, Dave Airlie <airlied@gmail.com> wrote:
>
> Just a poke about the outstanding drm CI support pull request since I
> haven't see any movement on that in the week, hopefully it's not as
> difficult a problem as bcachefs :-)

I was assuming that it wouldn't interfere with anything else... and
that I could just ignore it until I have all my "real" pulls done. I
didn't want to even look at it until I was "done".

Yes, it's past the mid-way point of the second week of the merge
window, and I mostly _should_ be "done".

But I still keep finding new pull requests in my inbox that aren't
just fixes and updates for previous main pull requests.

                Linus
