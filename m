Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442C07AE5A4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 08:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbjIZGQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 02:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbjIZGQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 02:16:54 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F8DE9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 23:16:47 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c147b96af8so91920581fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 23:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695709006; x=1696313806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLU06JRooA64WWeNfVb8WJXxu8rKh2vlVUkJa7RuASc=;
        b=h72q3Jx0CEOPL6G0HZtCcrljSmCdmoPmbxujjHoDTGZpJrn3kFjRGWowBwlNDtZVhL
         Ch98OfCw0RNX2AmqGTKVbhbgJKs0r04rDBM1EMZ0QlrAYvYRDtVBUUAqZJLS86ZiM3Ip
         WfWIBAxXazA/OL2hcswN3UZkbeClrTny5wn9vMxWi1hdAtsxC/8cifBQdj9rd+omYLW8
         HgebMxj3WEvHmJJxdfw25H3+WZQr2GSfJnGJvM29BdOwoY3xncFqUSEyexstsvXIz0kQ
         pv4c0lS0aHeIF1IcF8og2lb6vS+f/v5ExlUmsboWrOsaGcoMzBQOv/J6ABqq1AWaCO2/
         8XeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695709006; x=1696313806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLU06JRooA64WWeNfVb8WJXxu8rKh2vlVUkJa7RuASc=;
        b=tFz673AGngspFBXXJAluUMVdoTHaJQ/Q3CofZUfgbhZy69J7tSWGBSPTFDTx5NJSLl
         8Pjlw4Y8xpFFzRfD7BKPv7ltsc+UtszBvRSdNgGc87UtUmD7b5c8WX9d3UYeaswPWAD7
         qRtiaI2gJRZmq87DZwd7Wc8JasVFBOnwLcRYaGKuBVYqada3mqLDdg67wW8tUXTLu/Qn
         wEwWirHbyeMcl1ALXBHnaZSX1yzMIimHHuFeEw2w1HVSEKkdB2kOr1RKQ/1oxK0i/qCD
         6Cd2SVqTlAz5W/RzOGzhbSSPUILYeeFpzVb+xjLTtpQ8BiRCENW5MGCqhJVLZ2m3sSsr
         W3FA==
X-Gm-Message-State: AOJu0Yw1xG7J/9VFlmfiXxt808U0FvcB0ZeQBt/HpUdeGkC0OnAQPWlN
        cIyWVnjb56slTYeNBLRsNobJgmHWgYcrjYCULT8QGg==
X-Google-Smtp-Source: AGHT+IF9zraF5KjtnFHndDsMIsYfygddRtXXp3vkb8vbmpAMS62X7YunGbLtSZs0kLE916ljMyqfguOd+TCLQNmmLZk=
X-Received: by 2002:a2e:b1d1:0:b0:2c0:d44:6162 with SMTP id
 e17-20020a2eb1d1000000b002c00d446162mr6869677lja.12.1695709005713; Mon, 25
 Sep 2023 23:16:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230922062558.1739642-1-max.kellermann@ionos.com> <CAOi1vP80WvQhuXgzhvzupQP=4K2ckgu_WpUCtUSy5M+QdDycqw@mail.gmail.com>
In-Reply-To: <CAOi1vP80WvQhuXgzhvzupQP=4K2ckgu_WpUCtUSy5M+QdDycqw@mail.gmail.com>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Tue, 26 Sep 2023 08:16:34 +0200
Message-ID: <CAKPOu+-yUOuVh+3818iJ-GH968EHHQ0Pc3d8Rj4veO3k-xLk+g@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/ceph/debugfs: make all files world-readable
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Sep 25, 2023 at 12:42=E2=80=AFPM Ilya Dryomov <idryomov@gmail.com> =
wrote:
> A word of caution about building metrics collectors based on debugfs
> output: there are no stability guarantees.  While the format won't be
> changed just for the sake of change of course, expect zero effort to
> preserve backwards compatibility.

Agree, but there's nothing else. We have been using my patch for quite
some time, and it has been very useful.

Maybe we can discuss promoting these statistics to sysfs/proc? (the
raw numbers, not the existing aggregates which are useless for any
practical purpose)

> The latency metrics in particular are sent to the MDS in binary form
> and are intended to be consumed through commands like "ceph fs top".
> debugfs stuff is there just for an occasional sneak peek (apart from
> actual debugging).

I don't know the whole Ceph ecosystem so well, but "ceph" is a command
that is supposed to run on a Ceph server, and not on a machine that
mounts a cephfs, right? If that's right, then this command is useless
for me.

Max
