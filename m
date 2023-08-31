Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCF878F379
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 21:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345017AbjHaTlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 15:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjHaTlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 15:41:07 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AF41BF
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 12:41:02 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-5007abb15e9so2319304e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 12:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693510860; x=1694115660; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9lFziVFqioUGyeOGzUW1l/wvWLY3b5anS2Z+ZANPwmM=;
        b=XbUiZEWqtxrNK4ZHUDbHPQxP+FBfqZuYkPbDiM9snYmCrK6+5oM8F6ZtWua7nWNVwd
         +ih4d/qrn+PYVbEenn1lrrsxqmV3ltXHJKHl04CtyhpVuRpQuIm64Ng1QEZIHh+1gyaC
         YbkolXOiQCOfbx7eUR1LBGTvkH5K7+YnsEXUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693510860; x=1694115660;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9lFziVFqioUGyeOGzUW1l/wvWLY3b5anS2Z+ZANPwmM=;
        b=H1Pm+UhrlalLqecC6DzBHimbzRc2cwnJDqaBQBIBHiv9npRwkl8Y2ppQw9FFJ1Q6Cm
         kFgLGtOnrZoAWWXf2Vb7mLQxlh3GeKrD74ALrJyZgjTkBp3EcPlto5j/eyjS1GkFhiha
         v3wm3r51N1N1BbOP29+EUScKQfgKUOfDqPew7aarjuRnM1dZi2xar2+Fff7zXwmO70Ad
         CesOsdtV1AjMEzvUEtbAoUCkXcE7CX1Zgb85hkSOF4BGBnMZaxLWQ0r2kp2t68EdYoJm
         H3QJGgCo8enPMmWKRG462H8KF3P3imMUwZU/FVOiHLgBJHB5YmdoFj2wqr28k1jQPu5p
         tJWw==
X-Gm-Message-State: AOJu0YxO25wnnadN3FNZuLmXrnUpkPLG0yaNEDIxY5ZCU9u0IeJvnItJ
        XIWEuLlfJf3xZAQpw9PxNYjhp5XZJebRkNqt0selfkLY
X-Google-Smtp-Source: AGHT+IHc3bMDRpeYmCFP12xrNrDK0xlA91qO4DXfZbo9XmDqbqKZkrSjkghnqd7ZGbcvfRFyf95mIw==
X-Received: by 2002:a05:6512:481d:b0:4fb:8de9:ac0e with SMTP id eo29-20020a056512481d00b004fb8de9ac0emr146113lfb.1.1693510860566;
        Thu, 31 Aug 2023 12:41:00 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id q26-20020ac24a7a000000b00500832b083esm384092lfp.298.2023.08.31.12.40.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 12:41:00 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2bcc14ea414so22086261fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 12:40:59 -0700 (PDT)
X-Received: by 2002:a05:6512:32d5:b0:500:c180:59c6 with SMTP id
 f21-20020a05651232d500b00500c18059c6mr147282lfg.33.1693510859634; Thu, 31 Aug
 2023 12:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230830234752.19858-1-dave.hansen@linux.intel.com>
In-Reply-To: <20230830234752.19858-1-dave.hansen@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 31 Aug 2023 12:40:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wipDVFEfSJxbnUSDqENs5i8RzSsgJOFdb69pH=b7BOFiQ@mail.gmail.com>
Message-ID: <CAHk-=wipDVFEfSJxbnUSDqENs5i8RzSsgJOFdb69pH=b7BOFiQ@mail.gmail.com>
Subject: Re: [GIT PULL] x86/shstk for 6.6-rc1
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2023 at 16:48, Dave Hansen <dave.hansen@linux.intel.com> wrote:
>
> Add x86 shadow stack support

I assume you are aware of the system call renumbering from linux-next,
but I thought I'd mention it anyway. 452 was taken by fchmodat2, so
your new map_shadow_stack() system call is merged as 453.

I do also note that it looks like the merge resolution of the
_COMMON_PAGE_CHG_MASK bits in linux-next is wrong, and lost the
_PAGE_DIRTY_BITS part in Ingo's -tip merge 783560d95e0e ("Merge branch
'x86/mm' into x86/merge, to ease integration testing").

Anyway, please do double-check my merge for correctness, and test it
on some machine that hopefully supports this and has the
infrastructure set up for it.

             Linus
