Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F382180CB51
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343673AbjLKNqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234625AbjLKNqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:46:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99758AD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702302397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=IFsLeKW3DW6BmxUhVRH0V3zQ/xj1O1MUYot7lQD78gA=;
        b=P7+enMsUDv30Ht7W/sWNEfF3bBPRMeTlsQ+ZBNVbXlSvp1yzJJ7TNNauF/xuHHA9MwTieq
        Fwzhii7L92lcLgUCWbzLdrnRAnBskm1moHh7CgJrVuOdJ4wmR0joclhWt30eok8DFRKUMS
        GvY1D9QY9L1tLpIsEHa/66ngr/tLR+M=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-4F7FSfA6OCuMiBi7pQTbZg-1; Mon, 11 Dec 2023 08:46:36 -0500
X-MC-Unique: 4F7FSfA6OCuMiBi7pQTbZg-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5c6bd30ee89so3982102a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:46:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702302395; x=1702907195;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IFsLeKW3DW6BmxUhVRH0V3zQ/xj1O1MUYot7lQD78gA=;
        b=q4J4v/I0YX6v5NY0TV+AkCxOdgofZzUQGfQ71Q1eba2E2MYSAQG9u9XldixAj7Frc+
         cHVdwsfIO5Gss1U0mOyB9gZxbSRiTpVNo+ci4di2AI1CKzQ8yq4THmLM1A83XgAAstml
         bVY+byYjRGb3GHPw/ryT4gUqwrR/ww4GeGWHgE5fpNis/s9vwaqJGsqDFAxhfDdGKmpr
         CnOxTeszsQqKqhC2EoJLzFSW8gfVA78A74MIOQKn/qLtaXXWLyANL3DblVpEQ8tZkCH2
         e4LSgNqp5b1UayXwPVJduyyRp0XYRLsYoQ2aJ+Yor59z49fhWIy08vIs4PiM1h1Bn+rx
         V7hQ==
X-Gm-Message-State: AOJu0Yz0sxz6beUMLTuOv/x4TdJwy0jtN534YT08ZYpW9o8jKzMZJyhA
        l0yYGdKBPpSH12t9ogoFovsRCPQXmeuD47SOO/bbSweZA9V+mbXGfZH79/9MA9KeLSTOON9aXDM
        plI8SQz+LkPJKqMyVeMDs0XQEIeQWMrMdk1hxr35QO/9+vRniHmbQMw==
X-Received: by 2002:a05:6a20:1604:b0:190:3b35:5999 with SMTP id l4-20020a056a20160400b001903b355999mr6160563pzj.9.1702302395292;
        Mon, 11 Dec 2023 05:46:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHz/VpW74q862C/8B1Zq9q8sq1pAy3bkDkccmDflRYHJXOso3iqCrr4R+jnoGZVXq44EchwL0IzwxnZXOgg+J8=
X-Received: by 2002:a05:6a20:1604:b0:190:3b35:5999 with SMTP id
 l4-20020a056a20160400b001903b355999mr6160548pzj.9.1702302394991; Mon, 11 Dec
 2023 05:46:34 -0800 (PST)
MIME-Version: 1.0
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Mon, 11 Dec 2023 13:45:58 +0000
Message-ID: <CAOgh=Fwb+JCTQ-iqzjq8st9qbvauxc4gqqafjWG2Xc08MeBabQ@mail.gmail.com>
Subject: [RFC KERNEL] initoverlayfs - a scalable initial filesystem
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-unionfs@vger.kernel.org, linux-erofs@lists.ozlabs.org
Cc:     Daan De Meyer <daan.j.demeyer@gmail.com>,
        Stephen Smoogen <ssmoogen@redhat.com>,
        Yariv Rachmani <yrachman@redhat.com>,
        Daniel Walsh <dwalsh@redhat.com>,
        Douglas Landgraf <dlandgra@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Colin Walters <walters@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        Eric Chanudet <echanude@redhat.com>,
        Pavol Brilla <pbrilla@redhat.com>,
        Lokesh Mandvekar <lmandvek@redhat.com>,
        =?UTF-8?B?UGV0ciDFoGFiYXRh?= <psabata@redhat.com>,
        Lennart Poettering <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>, Neal Gompa <neal@gompa.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

We have recently been working on something called initoverlayfs, which
we sent an RFC email to the systemd and dracut mailing lists to gather
feedback. This is an exploratory email as we are unsure if a solution
like this fits in userspace or kernelspace and we would like to gather
feedback from the community.

To describe this briefly, the idea is to use erofs+overlayfs as an
initial filesystem rather than an initramfs. The benefits are, we can
start userspace significantly faster as we do not have to unpack,
decompress and populate a tmpfs upfront, instead we can rely on
transparent decompression like lz4hc instead. What we believe is the
greater benefit, is that we can have less fear of initial filesystem
bloat, as when you are using transparent decompression you only pay
for decompressing the bytes you actually use.

We implemented the first version of this, by creating a small
initramfs that only contains storage drivers, udev and a couple of 100
lines of C code, just enough userspace to mount an erofs with
transient overlay. Then we build a second initramfs which has all the
contents of a normal everyday initramfs with all the bells and
whistles and convert this into an erofs.

Then at boot time you basically transition to this erofs+overlayfs in
userspace and everything works as normal as it would in a traditional
initramfs.

The current implementation looks like this:

```
From the filesystem perspective (roughly):

fw -> bootloader -> kernel -> mini-initramfs -> initoverlayfs -> rootfs

From the process perspective (roughly):

fw -> bootloader -> kernel -> storage-init   -> init ----------------->
```

But we have been asking the question whether we should be implementing
this in kernelspace so it looks more like:

```
From the filesystem perspective (roughly):

fw -> bootloader -> kernel -> initoverlayfs -> rootfs

From the process perspective (roughly):

fw -> bootloader -> kernel -> init ----------------->
```

The kind of questions we are asking are: Would it be possible to
implement this in kernelspace so we could just mount the initial
filesystem data as an erofs+overlayfs filesystem without unpacking,
decompressing, copying the data to a tmpfs, etc.? Could we memmap the
initramfs buffer and mount it like an erofs? What other considerations
should be taken into account?

Echo'ing Lennart we must also "keep in mind from the beginning how
authentication of every component of your process shall work" as
that's essential to a couple of different Linux distributions today.

We kept this email short because we want people to read it and avoid
duplicating information from elsewhere. The effort is described from
different perspectives in the systemd/dracut RFC email and github
README.md if you'd like to learn more, it's worth reading the
discussion in the systemd mailing list:

https://marc.info/?l=systemd-devel&m=170214639006704&w=2

https://github.com/containers/initoverlayfs/blob/main/README.md

We also received feedback informally in the community that it would be
nice if we could optionally use btrfs as an alternative.

Is mise le meas/Regards,

Eric Curtin

