Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C3E78DE34
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbjH3S7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242738AbjH3J2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 05:28:43 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F991A1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 02:28:41 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-48d0db157efso1873117e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 02:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693387720; x=1693992520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jroHJ+MkLQqBRfk0Nu3WgrYu34mEmWyrSwHJuotBG9g=;
        b=iZ7VN1lftNho+Ey5VsBXzyLYxKPlBDxEwyLDGCpM8+iwEmbnQdhGMeD/DSFzEQOe4L
         8wfBu17RDoSB9AfPMMh+6EqNC+rbRjXYLh9El06mGhQSjpFRnp8Bev5lEKBlDKZNBd5g
         DmMYH6fW0QKgRhDhZnz7FhVX2pXiYbWviGu3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693387720; x=1693992520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jroHJ+MkLQqBRfk0Nu3WgrYu34mEmWyrSwHJuotBG9g=;
        b=IMvalAxzciFKMLqokxIDEGE5t2A4pxItI5/JLywirO0fOFTGPniSaucAE7Gp+/brbS
         Y0xi+dg5qiJU4fJN95hTP66ETkIk8Z2QHaNDKH7TtR7ghBR1ZbCYqx5DUvnaNuo6w2US
         FEEmZR0TI+oYlNGqJwvCVHW48PfxrisdwtptKj+8R8aM0GC7HtCdyPLf8d0EVT+sAKPv
         AOH4ic/7aOC+AGHWrwZMGy71X78sTtsS9nWpzZBJxIGra+NRRRioThEXXm9pXyWmMKYb
         9qoYDDmUIGyiJ2f+pWgp88+Np6hGUi2vkvAklTOQrvvRQR1hGR5J2rC8OwGx8CkJnf+K
         PLTQ==
X-Gm-Message-State: AOJu0Yz9O9XvV5XdAOVSBgeqDSVvJp+ZKNipLvijOU7TkaZE/79a2GJQ
        B3llPKTUw3i9ZTR+ifXKikdspfWA2Yyyg05bHK8pXw==
X-Google-Smtp-Source: AGHT+IEjXcJF7ibqsggGA2Uhc6ryDLkcsFAs9u9mGdUheQsatXUuV0xIX941BqTaUKwu00r6Vq5qZQ==
X-Received: by 2002:a67:f787:0:b0:44e:a396:36e4 with SMTP id j7-20020a67f787000000b0044ea39636e4mr1723479vso.10.1693387720055;
        Wed, 30 Aug 2023 02:28:40 -0700 (PDT)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id f30-20020ab0101e000000b0073f5b4610e4sm1856631uab.39.2023.08.30.02.28.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 02:28:39 -0700 (PDT)
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-48d2e2e05e7so1866826e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 02:28:38 -0700 (PDT)
X-Received: by 2002:a67:fbc9:0:b0:44e:8773:8c72 with SMTP id
 o9-20020a67fbc9000000b0044e87738c72mr1688981vsr.0.1693387718481; Wed, 30 Aug
 2023 02:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230828075420.2009568-1-anle.pan@nxp.com> <DB9PR04MB9284AA58AA71655C9C0C7C9A87E6A@DB9PR04MB9284.eurprd04.prod.outlook.com>
In-Reply-To: <DB9PR04MB9284AA58AA71655C9C0C7C9A87E6A@DB9PR04MB9284.eurprd04.prod.outlook.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 30 Aug 2023 18:28:21 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DYxwX+JdXQ_-ba5B9y+gyWPjvUpCBnKM1zz1W2EkO_vA@mail.gmail.com>
Message-ID: <CAAFQd5DYxwX+JdXQ_-ba5B9y+gyWPjvUpCBnKM1zz1W2EkO_vA@mail.gmail.com>
Subject: Re: [PATCH] media: videobuf2-dma-sg: limit the sg segment size
To:     Hui Fang <hui.fang@nxp.com>
Cc:     Anle Pan <anle.pan@nxp.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jindong Yue <jindong.yue@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 5:50=E2=80=AFPM Hui Fang <hui.fang@nxp.com> wrote:
>
> On Mon, Aug 28, 2023 at 8:57=E2=80=AFAM Anle Pan <anle.pan@nxp.com> wrote=
:
> >
> > When allocating from pages, the size of the sg segment is unlimited and=
 the
> > default is UINT_MAX. This will cause the DMA stream mapping failed late=
r
> > with a "swiotlb buffer full" error. The default maximum mapping size is=
 128
> > slots x 2K =3D 256K, determined by "IO_TLB_SEGSIZE".
> > To fix the issue, limit the sg segment size according to
> > "dma_max_mapping_size" to match the mapping limit.
>
> I wonder if only NXP met the "swiotlb buffer full" issue. In theory,
> when format is YUYV, those resolutions no greater than 320x240 (153600 by=
tes,
> which less than the max mapping size 256K ) can't meet the issue.
> But resolutions no less than 640x480 (307200 bytes), may have chances to
> trigger the issue.

I think a combination of a device that can support scatter-gather, but
requires swiotlb is kind of rare. Most drivers would require a single
contiguous DMA address (and thus use videobuf2-dma-contig) and
physical discontinuity would be handled by an IOMMU (transparently to
vb2).

I guess one thing to ask you about your specific setup is whether it's
expected that the swiotlb ends up being used at all?

Best regards,
Tomasz
