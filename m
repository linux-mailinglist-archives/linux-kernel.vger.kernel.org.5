Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2D0784FB7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 06:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjHWEqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 00:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjHWEq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 00:46:28 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B95E57
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 21:46:26 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-76dbe263c68so12308585a.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 21:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692765985; x=1693370785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbuj0UaWEA761fCPdddWt+wikwDEFpkNLnzTAhHNiDs=;
        b=D/1uhAMBMMYSvv227R9QNsh9n0F41mPXzvZeQQctwcKB8Lkiwnuj6gAhnssR72xkha
         AyzyPJ4cLH0iU2vV/ZVZujGM2DWIr1L7+0LfPaMHMjomDakkBXtJVTjPwk6ZOPHGRf89
         QcGi8vkKxE1bmOAvTVOKADMlGbOw0rgfwOHD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692765985; x=1693370785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbuj0UaWEA761fCPdddWt+wikwDEFpkNLnzTAhHNiDs=;
        b=i9VbWSj4J8iEuz4sIgNTnLAtAVkl1cWYTC8Uca629LPQ/xtlZOkYPe4sjPgX8mh8o/
         IFonffyWqyG9p3tIB8Tq0JZqOOWQZyueVs+bS8EQwS3+3HOFoz+UMasq1qbhZHOrQ9HJ
         wcJAafembA0hoSHKskA4CabyGZMnMgTXyzrSmhP/1yCDqmLKBb9QCQWP37o9kvJUDDGM
         TUMIYovT+cU/9kvIWC2dS3MzUyAFD5/y/Inso+mOXy1eu9zl2+wmtxhhZG0qmXm7sfYc
         8yeE+KFCRYdbLhNBBDOOls1vnFW+q+HlBw4f5s8IMNr/mTnDV7yzOlcC7/cEGzYIOSLM
         VhUw==
X-Gm-Message-State: AOJu0Yz/0xam4a9WED/uFvuQWOaw9jY9lpzFVCppI27jKgBdzk+jaD0B
        inTdwm3ZKRHGS5enTpE+nTYFOQeHhY5cmatTk4Sz2Q==
X-Google-Smtp-Source: AGHT+IHRqcJn0GYvSt+cIHzyp1aJfzFYXV3XpcRKoJbrvFaYhb0dNsOh3tXCYL//DxyVOFKOcQr9yQ==
X-Received: by 2002:a05:620a:2ae2:b0:76c:baeb:7ed7 with SMTP id bn34-20020a05620a2ae200b0076cbaeb7ed7mr11816875qkb.0.1692765985116;
        Tue, 22 Aug 2023 21:46:25 -0700 (PDT)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com. [209.85.222.182])
        by smtp.gmail.com with ESMTPSA id c8-20020a05620a134800b0076dae4753efsm1361139qkl.14.2023.08.22.21.46.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 21:46:24 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-76da819edc7so117832385a.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 21:46:24 -0700 (PDT)
X-Received: by 2002:a05:6214:5493:b0:62d:f04b:b51 with SMTP id
 lg19-20020a056214549300b0062df04b0b51mr14567439qvb.29.1692765983989; Tue, 22
 Aug 2023 21:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <029b982f-da62-4fa8-66c4-ab11a515574a@synaptics.com>
In-Reply-To: <029b982f-da62-4fa8-66c4-ab11a515574a@synaptics.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 23 Aug 2023 13:46:07 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CqAvr7ZUdDSYPEOWSgvbttTBjHa0YWDomxJJSaiZxGog@mail.gmail.com>
Message-ID: <CAAFQd5CqAvr7ZUdDSYPEOWSgvbttTBjHa0YWDomxJJSaiZxGog@mail.gmail.com>
Subject: Re: [RFC]: shmem fd for non-DMA buffer sharing cross drivers
To:     Hsia-Jun Li <Randy.Li@synaptics.com>
Cc:     linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        hughd@google.com, akpm@linux-foundation.org,
        Simon Ser <contact@emersion.fr>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>, daniels@collabora.com,
        ayaka <ayaka@soulik.info>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsia-Jun,

On Tue, Aug 22, 2023 at 8:14=E2=80=AFPM Hsia-Jun Li <Randy.Li@synaptics.com=
> wrote:
>
> Hello
>
> I would like to introduce a usage of SHMEM slimier to DMA-buf, the major
> purpose of that is sharing metadata or just a pure container for cross
> drivers.
>
> We need to exchange some sort of metadata between drivers, likes dynamic
> HDR data between video4linux2 and DRM.

If the metadata isn't too big, would it be enough to just have the
kernel copy_from_user() to a kernel buffer in the ioctl code?

> Or the graphics frame buffer is
> too complex to be described with plain plane's DMA-buf fd.
> An issue between DRM and V4L2 is that DRM could only support 4 planes
> while it is 8 for V4L2. It would be pretty hard for DRM to expend its
> interface to support that 4 more planes which would lead to revision of
> many standard likes Vulkan, EGL.

Could you explain how a shmem buffer could be used to support frame
buffers with more than 4 planes?

>
> Also, there is no reason to consume a device's memory for the content
> that device can't read it, or wasting an entry of IOMMU for such data.

That's right, but DMA-buf doesn't really imply any of those. DMA-buf
is just a kernel object with some backing memory. It's up to the
allocator to decide how the backing memory is allocated and up to the
importer on whether it would be mapped into an IOMMU.

> Usually, such a metadata would be the value should be written to a
> hardware's registers, a 4KiB page would be 1024 items of 32 bits register=
s.
>
> Still, I have some problems with SHMEM:
> 1. I don't want thhe userspace modify the context of the SHMEM allocated
> by the kernel, is there a way to do so?

This is generally impossible without doing any of the two:
1) copying the contents to an internal buffer not accessible to the
userspace, OR
2) modifying any of the buffer mappings to read-only

2) can actually be more costly than 1) (depending on the architecture,
data size, etc.), so we shouldn't just discard the option of a simple
copy_from_user() in the ioctl.

> 2. Should I create a helper function for installing the SHMEM file as a f=
d?

We already have the udmabuf device [1] to turn a memfd into a DMA-buf,
so maybe that would be enough?

[1] https://elixir.bootlin.com/linux/v6.5-rc7/source/drivers/dma-buf/udmabu=
f.c

Best,
Tomasz

>
> --
> Hsia-Jun(Randy) Li
