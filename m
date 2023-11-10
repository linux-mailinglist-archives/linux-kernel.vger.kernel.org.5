Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5147E768E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 02:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbjKJB25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 20:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjKJB2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 20:28:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5367B133
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 17:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699579687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zC+u4Re2AoTUGpqWOoMx+tYjldUA5tL8xtOql2ozAF4=;
        b=ikm9oFhPOb19kPDF/ogY5eyRNaXuCjl/99wVKoXm27tKhbLLoOqsMxz37O4X/P/pPh+IIu
        mabszhLa1gSa+QtOvzYfUMpxmLB7w/Kz5P3/hScEXrBhoI2o6KlNXcXhIjvn8DwsFkLnbl
        OtgAQlzihsRn+UzIepOT6dn9PQQ0PfE=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-5lrvpXCGOE-yJoDAMY7t-w-1; Thu, 09 Nov 2023 20:28:06 -0500
X-MC-Unique: 5lrvpXCGOE-yJoDAMY7t-w-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1d5f4d5d848so1392751fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 17:28:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699579685; x=1700184485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zC+u4Re2AoTUGpqWOoMx+tYjldUA5tL8xtOql2ozAF4=;
        b=R6DeqjIyy9hGxySl9z99JsNvdpAUtylhEykOpmwqcVp4kPx+iZpByL4G3JmahCNNyY
         /rK4Z4ej8jQ7htRlAxiYnYXm8PH0IMhDA4dFIxHk0XzuwvFCKzjikECC0GDwL2Nv0VUj
         e/FbBmImLL7/mJvdr2+wgnS2vZ7hnoOXaZHexq0/j0rnYU4MU067aekikVIVNJB2yO7J
         NyRRu5QVhVBAhZKflvyjU4L4WI7pvgLlbcS5/+XFXaaPQHcpt7fUFlEQ3zynGYq+uG1N
         0nW7b4Z/iRIPGpYzQ0ES0NLJ/xY1mKhk2QJFAAa1fRi0ATKNSMdy0JqjGk7vfy5iMlIn
         NRKQ==
X-Gm-Message-State: AOJu0YwRIuem+3AvT/iyJPQWIlPGwZVnf6gkVO3jQZskZeIavljAKlE2
        UZjU+dmhqI/FeCAXy6Rbd3bXG3B082tgwJ6s++OMqpeduIF5SUPoRo1Fi4A6PNdjzqKQAE6dG/y
        RLrD+ieiD3nj26xacHvtPUdhYdMcs1fGTXb8dQU6Tatp5jVXrJDE=
X-Received: by 2002:a05:6870:1314:b0:1ea:d76b:1457 with SMTP id 20-20020a056870131400b001ead76b1457mr6624726oab.7.1699579685234;
        Thu, 09 Nov 2023 17:28:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGY6J8ZouDEA5qQMJiaMxmBZIrQRVPu28NAIQ+CGdUvmcYPLrHluYLqjgbiUv9YwzmkiYQWWU0SJT6gXHqvqxY=
X-Received: by 2002:a05:6870:1314:b0:1ea:d76b:1457 with SMTP id
 20-20020a056870131400b001ead76b1457mr6624714oab.7.1699579684985; Thu, 09 Nov
 2023 17:28:04 -0800 (PST)
MIME-Version: 1.0
References: <20231110010139.3901150-1-sarthakkukreti@chromium.org> <20231110010139.3901150-5-sarthakkukreti@chromium.org>
In-Reply-To: <20231110010139.3901150-5-sarthakkukreti@chromium.org>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Fri, 10 Nov 2023 09:27:48 +0800
Message-ID: <CAHj4cs9pS0hgWBpz9bzoJBGwh1iK+0Nuzc5RmJNyZOR5s-7oLw@mail.gmail.com>
Subject: Re: [PATCH] loop/010: Add test for mode 0 fallocate() on loop devices
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Mike Snitzer <snitzer@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 9:02=E2=80=AFAM Sarthak Kukreti
<sarthakkukreti@chromium.org> wrote:
>
> A recent patch series[1] adds support for calling fallocate() in mode 0

The patch link is missing in this patch.

> on block devices. This test adds a basic sanity test for loopback devices
> setup on a sparse file and validates that writes to the loopback device
> succeed, even when the underlying filesystem runs out of space.
>
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> ---
>  tests/loop/010     | 60 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/loop/010.out |  2 ++
>  2 files changed, 62 insertions(+)
>  create mode 100644 tests/loop/010
>  create mode 100644 tests/loop/010.out
>
> diff --git a/tests/loop/010 b/tests/loop/010
> new file mode 100644
> index 0000000..091be5e
> --- /dev/null
> +++ b/tests/loop/010
> @@ -0,0 +1,60 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2023 Google LLC.
> +# Author: sarthakkukret@google.com (Sarthak Kukreti)
> +#
> +# Test if fallocate() on a loopback device provisions space on the under=
lying
> +# filesystem and writes on the loop device succeed, even if the lower
> +# filesystem is filled up.
> +
> +. tests/loop/rc
> +
> +DESCRIPTION=3D"Loop device fallocate() space provisioning"
> +QUICK=3D1
> +
> +requires() {
> +       _have_program mkfs.ext4
> +}
> +
> +test() {
> +       echo "Running ${TEST_NAME}"
> +
> +       local mount_dir=3D"$TMPDIR/mnt"
> +       mkdir -p ${mount_dir}
> +
> +       local image_file=3D"$TMPDIR/img"
> +       truncate -s 1G "${image_file}"
> +
> +       local loop_device
> +       loop_device=3D"$(losetup -P -f --show "${image_file}")"
> +
> +       mkfs.ext4 ${loop_device} &> /dev/null
> +       mount -t ext4 ${loop_device} ${mount_dir}
> +
> +       local provisioned_file=3D"${mount_dir}/provisioned"
> +       truncate -s 200M "${provisioned_file}"
> +
> +       local provisioned_loop_device
> +       provisioned_loop_device=3D"$(losetup -P -f --show "${provisioned_=
file}")"
> +
> +       # Provision space for the file: without provisioning support, thi=
s fails
> +       # with EOPNOTSUPP.
> +       fallocate -l 200M "${provisioned_loop_device}"
> +
> +       # Fill the filesystem, this command will error out with ENOSPC.
> +       local fs_fill_file=3D"${mount_dir}/fill"
> +       dd if=3D/dev/zero of=3D"${fs_fill_file}" bs=3D1M count=3D1024 sta=
tus=3Dnone &>/dev/null
> +       sync
> +
> +       # Write to provisioned loop device, ensure that it does not run i=
nto ENOSPC.
> +       dd if=3D/dev/zero of=3D"${provisioned_loop_device}" bs=3D1M count=
=3D200 status=3Dnone
> +       sync
> +
> +       # Cleanup.
> +       losetup --detach "${provisioned_loop_device}"
> +       umount "${mount_dir}"
> +       losetup --detach "${loop_device}"
> +       rm "${image_file}"
> +
> +       echo "Test complete"
> +}
> \ No newline at end of file
> diff --git a/tests/loop/010.out b/tests/loop/010.out
> new file mode 100644
> index 0000000..068c489
> --- /dev/null
> +++ b/tests/loop/010.out
> @@ -0,0 +1,2 @@
> +Running loop/009
> +Test complete
> --
> 2.42.0.758.gaed0368e0e-goog
>
>


--=20
Best Regards,
  Yi Zhang

