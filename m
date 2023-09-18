Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12AE7A5337
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 21:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjIRTpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 15:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjIRTpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 15:45:35 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30440B6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 12:45:29 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b962c226ceso80342631fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 12:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695066327; x=1695671127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zW90+4LnhcXuYh4PgbZ4Zl6heO2MhvqvxAqb1aqy9sA=;
        b=KCR/+8gZYD6+QDchae8pwZvJni38Hbn1IT+ROSaQtdjgJ8L+elvODQ9fPv+1Z//Byv
         gStV5BMuMxwhv8bepohgoxGmuqH7X8RGxVXwLtxb2aqmIlkYhqgHPxO2SWf6qhAJYtBc
         wxk1ndck4R/upcAe5XkByj7y1htLnTPWuDKt1R+564SHG5jhoOQlB5H6bNvXjDcUQx9g
         4JCZt2sHyIe2AANQ3/7357FA104vZuowS/PqIcsyT03UJ48BEHIyx4HixZgsfy2Qi5c8
         cYU4OCYOhj7f3NEY0WBIi4diTfQzhIbiA4rAit6ocPbQ7KAEKxXx45xeO9F3qhy5G/+j
         uvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695066327; x=1695671127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zW90+4LnhcXuYh4PgbZ4Zl6heO2MhvqvxAqb1aqy9sA=;
        b=lNspgcvHf7SIXrbZGRDkLVJgDpkG0BaZD4pS8Uvzxg7NtENwheFWYSH/MjWK2NzEfy
         gQ4bTFIVIr5mdpxuQKCWSQKSB6AWFtNz9fWKBfRm6QJuttozjNzacb+Wb0DYg/PLCv2M
         dlqu8gQOsY/YdBWMWvTj7AQjPc1dVw3ttP+nuXYemg/wa8Rqrzhd3ebnTP5r1gB3nlon
         OZywaeH8d4qaGDUp+iy5yaKyKimmubHWVWdn9MOrgL4VcRLc36xtZ89izUMZHqS15ySU
         LBE/zUdVDyp4FWO3CFJDTDgA85LxpQbG2AqvJpCKzNdqMW4Q0bs2y9AoDGnL92zKLHOa
         NVwg==
X-Gm-Message-State: AOJu0YzCQopJyZe1c1LG6CuyI4g8PYscnutCHpZ9cGBx9HHjPYOtCbPX
        0BGmyYeXNXf1GyUGmS+dkxjDiHL4RGsIeE7owD0+7A==
X-Google-Smtp-Source: AGHT+IEL7ZbuHmHMhfSt7oo20tbProZdj8HUKQ/ND2lyRw+9QyGxP5DFrXFBvAttMLQBi94pczJfRMAdGXrMRRT/fgM=
X-Received: by 2002:a2e:9607:0:b0:2bc:f252:6cc4 with SMTP id
 v7-20020a2e9607000000b002bcf2526cc4mr8663483ljh.10.1695066327372; Mon, 18 Sep
 2023 12:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230918123217.932179-1-max.kellermann@ionos.com>
 <20230918123217.932179-3-max.kellermann@ionos.com> <20230918124050.hzbgpci42illkcec@quack3>
In-Reply-To: <20230918124050.hzbgpci42illkcec@quack3>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Mon, 18 Sep 2023 21:45:16 +0200
Message-ID: <CAKPOu+9yAKCtrRZsZPFDtM6RP6Ev_-2x84WYCLf_SPHJcr3Faw@mail.gmail.com>
Subject: Re: [PATCH 3/4] inotify_user: add system call inotify_add_watch_at()
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        amir73il@gmail.com
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

On Mon, Sep 18, 2023 at 2:40=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> Is there any problem with using fanotify for you?

Turns out fanotify is unusable for me, unfortunately.
I have been using inotify to get notifications of cgroup events, but
the cgroup filesystem appears to be unsupported by fanotify: all
attempts to use fanotify_mark() on cgroup event files fail with
ENODEV. I think that comes from fanotify_test_fsid(). Filesystems
without a fsid work just fine with inotify, but fail with fanotify.

Since fanotify lacks important features, is it really a good idea to
feature-freeze inotify?

(By the way, what was not documented is that fanotify_init() can only
be used by unprivileged processes if the FAN_REPORT_FID flag was
specified. I had to read the kernel sources to figure that out - I
have no idea why this limitation exists - the code comment in the
kernel source doesn't explain it.)
