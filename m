Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7767CD480
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 08:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344429AbjJRGcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 02:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjJRGcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 02:32:06 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9DC93
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 23:32:04 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c5071165d5so2061921fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 23:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1697610722; x=1698215522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tjC/IFqkvBBhR48NAuD9T/1qJBmUPzNnAkBCizquaQ=;
        b=HWkOzOZ04I28w+pkVcaw3CLNZuoZashd3rQ7eL/gZFERiOwbKYOmwZ5qpBoSJpZ3w2
         Ur3LyWZhp45hBJakbBI/hwZUclX5kdh/McBBtne6+yIWUU0rmUpsZO51yZOqs+LHOiC0
         wRzYvMpIaqy4IvDNLi6LbXPnY3H2eOSvz8MG9Msoj4OWyovX1lNgPyAt1eJFsGHJlWnS
         PhUSjP5dKzvQEIQmSsJ2AB/vGPMWRDUlxERs6l0CQK+7moI0TNvTf834Y9PRg866Rcc2
         0TLbKTGcSR17a6FAPOr5iMw5+H39qaHYe6ZBJnS+yRCoYhiC5/QS0C59DTzFeY0rUTfL
         RsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697610722; x=1698215522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9tjC/IFqkvBBhR48NAuD9T/1qJBmUPzNnAkBCizquaQ=;
        b=eYyBe2ubjJ6JVEOEsoO5fz//9WEybiDTz7x2DPeNwTx3AR9XotjPnUtBHTilFHI5Fx
         NXYpg4a7tc1iTtlcPlvAypEGHhFf1w5vUIg3tCwzXe/Dqvc43JJ/Sw3ysoZxy7eX6v7Z
         dqqq7r3nUm9JGGFbEdRck8KcuM8s3XU2Z0GzBic9RhZ6KlhQ/CN/NjhLuRhldtu2DM6+
         p9ZiEnIyUfQ84apHG8/ag9C87sHQGKA6htgpS2TmHFYxW54kp+MSqflsPAy11axOB/ls
         rZs9FufcNsAoG6IodLX1iQLzO89qoewYh7Jr3n8y2LaWU0Bc5NOwqTd140bHa2Vd0MUD
         VZLg==
X-Gm-Message-State: AOJu0YzJ6VZt/1fCAgNh4wJzcZOgMg9nAUOpzxdeW5LYjDhLAghj+UiU
        8B9XFqph6EQSt6zhzSfVtlIyIZcFhpTPw2/bpkvj9Q==
X-Google-Smtp-Source: AGHT+IEgPSai5R65B+hsjAZpWjxARBJ9cktgQMzW0R1rlNY1QAnKJwqHR7gz0g3zbBtP0X1OV/UTCcCEGVkLfrIlDGo=
X-Received: by 2002:a2e:9b07:0:b0:2c5:12ae:adb3 with SMTP id
 u7-20020a2e9b07000000b002c512aeadb3mr2829172lji.44.1697610722467; Tue, 17 Oct
 2023 23:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <202310172247.b9959bd4-oliver.sang@intel.com> <2023101759-front-ember-6354@gregkh>
In-Reply-To: <2023101759-front-ember-6354@gregkh>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Wed, 18 Oct 2023 08:31:51 +0200
Message-ID: <CAKPOu+_tQj361LAGNyw+wLnrw=Y709zcA5kjX_95c_4HOv6wxg@mail.gmail.com>
Subject: Re: [linux-next:master] [drivers/char/mem] 1b057bd800:
 stress-ng.splice.ops_per_sec -99.8% regression
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
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

On Tue, Oct 17, 2023 at 6:57=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> So everything now goes faster, right?  -99.8% regression means 99.8%
> faster?

That's what I thought, too, and sounds reasonable considering this
test is described as "stress copying of /dev/zero to /dev/null",
but... it's not what that test actually does. Contrary to the
description, it doesn't use /dev/zero at all, neither does it use
/dev/full. So it shouldn't be affected by my patch at all.

strace of that test's setup:

 pipe2([4, 5], 0)                =3D 0
 openat(AT_FDCWD, "/dev/null", O_WRONLY) =3D 6

Then it loops:

 vmsplice(5, [{iov_base=3D"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
\0\0\0\0\0\0\0\0"...,
iov_len=3D65536}], 1, 0) =3D 65536
 splice(4, NULL, 6, NULL, 65536, SPLICE_F_MOVE) =3D 65536
 write(5, "\334\360U\300~\361\20jV\367\263,\221\3724\332>7\31H2|\20\254\314=
\212y\275\334I\304\207"...,
4096) =3D 4096
 vmsplice(4, [{iov_base=3D"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
\0\0\0\0\0\0\0\0"...,
iov_len=3D4096}], 1, 0) =3D 4096

I don't get it.
