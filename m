Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE33C7CB88A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 04:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjJQCpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 22:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjJQCpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 22:45:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37532E6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 19:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697510655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SJt7HsiJ8G1L7Niuvw9G7dLf2vRLVXowVAVUuCZgzH0=;
        b=Hpo5xppOK9bCjkUSKfsam9KAlvn7sPabL2Ks8QeZDqS9hXKbswaLYExHDRxbIy2lJv8Nfk
        xfXhbKYIQzU3ht+5abruLbNgU0ZVfPZl1QfLMBxys1hshUo1V9tXUFHq9VtaXmViOUzDD5
        DBawqPfDoRJCzp1o+lvwGzPPrG5590g=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-G0nhi7UiNACcYgQu731YDg-1; Mon, 16 Oct 2023 22:44:13 -0400
X-MC-Unique: G0nhi7UiNACcYgQu731YDg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-507968e3953so3558394e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 19:44:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697510652; x=1698115452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJt7HsiJ8G1L7Niuvw9G7dLf2vRLVXowVAVUuCZgzH0=;
        b=ZOgiKIP0DisxvL0HslzoxoZXK3wSBKF9WrkwSjAEINUjVCoj9LUrM4rAJjXTzqnKzo
         O5moI2aJcWiQRx1pXU8sJ3rkV2PLgkbgg6l+kueQ3M8LJWrwQErOchKHRuRU9+d7Ye+6
         x/4x5YbHjX03ed+QK7XoQH5yl0gi0yk5tqBUxFhVF0bxjB+LJ1dIXapQxhlB5kJQ5IpD
         dGxVsi58/zjSXquAnip8s1hpH0ZF5QVfWHhTT7I2YZsE7EqT94PNTCXmcKTDRani8Zzb
         E0Fj9IxsB64B23aSoM79DX/t3drZbWuSIOlW4PWRDpEJEKJJ0inF2W8v7sJNg1EBkL+i
         KsSQ==
X-Gm-Message-State: AOJu0YwV9YMMejGfWgKzeT8zYkrbW4foAsQv4d3XNLjYl+QSPDwjn7DR
        1T+T3owJi0FN5HdWVu2T/3racfecmKtR+xCilWbuKDOAXRTsL2ywRAVxU7iUNKwetYCOnBOf3pd
        9rGKcIOeJjii5pdQEpbD8EvCMwuGQ8aJAYmHh0iFc
X-Received: by 2002:ac2:5977:0:b0:502:e235:20c7 with SMTP id h23-20020ac25977000000b00502e23520c7mr292526lfp.20.1697510652193;
        Mon, 16 Oct 2023 19:44:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUpIIzqymJ6/Kkubja9kCFor2YU9Jql4E6m+ZEdJTSeLLmt43uzzUgSR7bXfPbUTCBDSsk9TlFU9QnMS2Q+gk=
X-Received: by 2002:ac2:5977:0:b0:502:e235:20c7 with SMTP id
 h23-20020ac25977000000b00502e23520c7mr292515lfp.20.1697510651908; Mon, 16 Oct
 2023 19:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231011064208.2143245-1-lulu@redhat.com>
In-Reply-To: <20231011064208.2143245-1-lulu@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 17 Oct 2023 10:44:00 +0800
Message-ID: <CACGkMEvJpcsNTLp7e2vuKAyGFRdF4RC34+t=EHUbvFAg8LdfDw@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] vduse: Reconnection support in vduse
To:     Cindy Lu <lulu@redhat.com>
Cc:     mst@redhat.com, xieyongji@bytedance.com,
        linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 2:42=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Here is the reconnect support in vduse,
>
> The kernel will allocate pages for reconnection
> userspace needs to use ioctl VDUSE_GET_RECONNECT_INFO to
> get the mmap related infomation and then map these pages
> to userspace.
> The kernel and userspace will use these pages to sync
> the reconnect information
>
> Tested in vduse + dpdk test-pmd

I would like to see the DPDK part as a reference. Would you mind
giving me a pointer?

Thanks

>
> Cindy Lu (4):
>   vduse: Add function to get/free the pages for reconnection
>   vduse: Add file operation for mmap
>   vduse: Add new ioctl VDUSE_GET_RECONNECT_INFO
>   vduse: update the vq_info in ioctl
>
>  drivers/vdpa/vdpa_user/vduse_dev.c | 175 +++++++++++++++++++++++++++++
>  include/uapi/linux/vduse.h         |  43 +++++++
>  2 files changed, 218 insertions(+)
>
> --
> 2.34.3
>

