Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DECF67CD620
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbjJRIMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjJRIMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:12:36 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF0DF7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:12:34 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c50fbc218bso61216871fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1697616752; x=1698221552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8OSgkc4e1dMirZuYakBJ4TV+Pc4xjV8sddnOYMm7jI=;
        b=SmX2qkgq3qUTduZ2J7nRkRlT4IIMMicqvgMcn0SYLPKJpewcqWKhly+U3hfdtOBNn9
         PgIW+TYRaysn4vHNMV+u4iAwawPKi8rlq6LL8vkz3IfUw8PlYb5qrwqUUacwEE+s3/2W
         X/vgfEp5Rua5Ps0gtFg2Yr7TI/I3ZsD1ZJkVInZK9U7XaTgLSGxmQ+EpT9LoY++qPiW2
         W3lyrBXefJbu+37jSZjAarbESJSSDIfS6E6pw1g50ZD+F2v46n1PGJcf1ZJWk3UxsKKn
         PrRbyRBBHCewWlcuHXJ5WYy6k48jGp2fRzJeLqzDopVYcKsF7sdyEvfOIK4BwzuiJJIZ
         5xIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697616752; x=1698221552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8OSgkc4e1dMirZuYakBJ4TV+Pc4xjV8sddnOYMm7jI=;
        b=weT5MNjACdEa1QZWgMTtGOCx4L4yMA7p9U7UuX3JnHEOLr6Nvp2TqVjTsIJ51nrLl7
         POWX5wGrDy3tbuRLxGmbOIFaUezuoBE7m8Kn3yVnVKUhe0D9IjJSY9KecseQFPSdD5bN
         s4veyR3v9E6NMVzlNqbXxHCBMxnLQFjrKGedEy3C3eII9b1WvzWPZkMqjfuzZgSBScYB
         S75CZQMa3Ybc/xWVuQ5b3S15jO9Rwx1w2UVM+SODrmehm1vM9nvlle94PAtGg4VPrjN4
         LEofBPs5IRu2s6Pdc5XI60t7etN+Em0StKQD4EOGwKh/5sLI8qg4zKQ/vNSnCQpO87V4
         Fb8Q==
X-Gm-Message-State: AOJu0Yz/eHiFJZDFyE4YvjSzLYhL4762pmCFb3I0lsrhzpu1HXwWf5B3
        3Ikb/NVy8Gcps7BgI0Rg8TaKNuhRjmTKndJPA7a3SQ==
X-Google-Smtp-Source: AGHT+IE1yL45y3giHvGlWwiGV+n0AcnmEXxcJzbz2rJTiP59KR/TOfhDFA2cpbwe0KAkULT4qqNUQ+xiX331N5X+lz0=
X-Received: by 2002:a05:651c:1989:b0:2bc:dab2:c7dc with SMTP id
 bx9-20020a05651c198900b002bcdab2c7dcmr4120154ljb.47.1697616752372; Wed, 18
 Oct 2023 01:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <202310172247.b9959bd4-oliver.sang@intel.com> <2023101759-front-ember-6354@gregkh>
 <ZS+EKPJA+BMhM0yO@xsang-OptiPlex-9020> <2023101836-backtalk-mystified-d197@gregkh>
In-Reply-To: <2023101836-backtalk-mystified-d197@gregkh>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Wed, 18 Oct 2023 10:12:21 +0200
Message-ID: <CAKPOu+9bZtu80NncqLET_ycZcWynZFHuWGRC4HU2Od9NrsjnCw@mail.gmail.com>
Subject: Re: [linux-next:master] [drivers/char/mem] 1b057bd800:
 stress-ng.splice.ops_per_sec -99.8% regression
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 9:57=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> That's odd given that as was pointed out, this test does not even touch
> the code paths that this patch changed.

I think I mixed up the "vmsplice" and the "splice" tests, and my
conclusion was wrong, sorry.
This performance regression is about the "splice" test which indeed
uses /dev/zero. I'll have a closer look and get back to you.
