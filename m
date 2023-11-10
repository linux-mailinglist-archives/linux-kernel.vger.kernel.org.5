Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DC77E8305
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344875AbjKJTdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjKJTc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:32:59 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE6B31E69
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 10:01:13 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507adc3381cso2990077e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 10:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1699639247; x=1700244047; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YE6wSSy+yGYDG+b6Y+tJNP7bCqAo8fMg9L3es6MuY0k=;
        b=QOQytouZObwQerNbimQb0bW3bYTMgVbJX5Ymfix8L17+uIr7S5dk0v/5nAh1ThlDDx
         Cy0e4o6JF1ZWPukQLGynytrNB5YgrD9/TpvqJbI5w3LjYbNcuDr32t+l7OvW8WQ/MXuw
         9X3uOZLJgh5IPg3zEnjRIAcBpiWdI/14Fzabw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699639247; x=1700244047;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YE6wSSy+yGYDG+b6Y+tJNP7bCqAo8fMg9L3es6MuY0k=;
        b=ENMwOOdCMPSxLQV0s7mmJ9MAgJX4UdOLO0tHM4ktsfe7BzXjtphPL0MRDFvPkcnETf
         QRwjahxApAlSj+Rwp5lMTExeBxvfa1JVDFO27kR5nDMXwP8GrtszHTjXwt6O8B1daq0Y
         neFoH9mjmfAsi0bikev3nBcVVqhpzvSYn29khgVfHjCYMZCQjrhN7BxQOjvPSSVCDN8i
         17DxOZoaFImeEH3RU53PmAuF/fF5rXJG9qh7787PqNiqx3qEWgwr1AD5TRdL0zN/wiVf
         K2lsMI27BPVaocd2RzQ3DZcvtmyyLZjLdgkxMGzY18OduAVyWAGyUQSG88fsgGu5NF/B
         QCDQ==
X-Gm-Message-State: AOJu0Yywt4R/h+qotmNpLUym23XCFcZ7y0vNeRlTl/bxI7WY4nwHlQOe
        vuX3Uodw58aluEK7G8rjoTTvu134PmZSsR92a2afW4cI
X-Google-Smtp-Source: AGHT+IEvFoGGpaLKXcG/E0rN/tgs92uKJu7KapATJ0h5tDs5WqPCr/g9Cd0WintxFxLs7GJ46D252Q==
X-Received: by 2002:a05:6512:374c:b0:507:ad92:18d1 with SMTP id a12-20020a056512374c00b00507ad9218d1mr3970049lfs.68.1699639247429;
        Fri, 10 Nov 2023 10:00:47 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id a7-20020a194f47000000b005079ec79bfesm3103lfk.93.2023.11.10.10.00.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 10:00:47 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-507bd19eac8so3016720e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 10:00:46 -0800 (PST)
X-Received: by 2002:a05:6512:3592:b0:500:d4d9:25b5 with SMTP id
 m18-20020a056512359200b00500d4d925b5mr4178037lfr.56.1699639246516; Fri, 10
 Nov 2023 10:00:46 -0800 (PST)
MIME-Version: 1.0
References: <20231109174044.269054-1-idryomov@gmail.com>
In-Reply-To: <20231109174044.269054-1-idryomov@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Nov 2023 10:00:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgZmHfx1UFOkYpwBZk7gf7hGQKeFgevYzOH269Qw0d5Ew@mail.gmail.com>
Message-ID: <CAHk-=wgZmHfx1UFOkYpwBZk7gf7hGQKeFgevYzOH269Qw0d5Ew@mail.gmail.com>
Subject: Re: [GIT PULL] Ceph updates for 6.7-rc1
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2023 at 09:41, Ilya Dryomov <idryomov@gmail.com> wrote:
>
> There are a few conflicts in fs/ceph/inode.c caused by a clash between
> the conversion to new timestamp accessors in VFS and logging changes in
> CephFS.  I have the resolution in for-linus-merged, it's the same as in
> linux-next.

My resolution ended up different, because I just couldn't deal with
the incorrect printouts of times, and changed the bogus occurrences of
"%lld.%ld" to "%lld.%09ld" while doing the other conflict resolutions.

Other than that I think it's just whitespace differences.

               Linus
