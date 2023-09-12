Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2C279C4C1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 06:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbjILE2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 00:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbjILE2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 00:28:10 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A913E9A01A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 19:22:34 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-64c5f5d6f04so28554696d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 19:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694485353; x=1695090153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNz9pmUyvYE+1X1z1ltOs+pUz4Ht8e0o4P0Hq1idOMQ=;
        b=X/MqBaTwfAEO2sld8HqSJdI1jOYkR0ApltkH57SigUiuTTTmHK78ZLIUR244jD3W/H
         x+r9XTHNGJZhUHMcHpZsJxLy7TQJom3s4pcGbw0RM85SRd/oiTC3Plza73FGi/aW7hu9
         Zl6drywzUJsqQ0YLspXmCX7tOqcK3cVLHjugQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694485353; x=1695090153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YNz9pmUyvYE+1X1z1ltOs+pUz4Ht8e0o4P0Hq1idOMQ=;
        b=cAnlqOQTygyGL6y2JbasRiw13ot5tXEEvAOcuiBTVHhVIRJgiJEKBdpyUrNYqAQpVT
         8aFn9QHwR+p3A8h3D9khd8haM6cuPqIUR1OQgxorpoExnT2+8xGfD11YMeYesu/OpntS
         QAonF1BTYm5g34gJ07vjTLsL7e46DGczCCzT9Wjb+l1VN1gdqQZw2pILvICeQn3r18Xl
         hDZtpgL9DeLCKZFsRiBqn/W2oR4gUGmxFei2aiIXyspdrq7nvwTfMiqjq1yxhyRFAhr8
         3O0JJhNRQGs2Fb+G4AkmaI3SsA37Pr+sGlqDxhQ8qAok+Q1hnFbNeW7Uo2hcmQGzjquD
         62VA==
X-Gm-Message-State: AOJu0Yx1Y1gyyj8hA27o2PuZoA2noJmqVQ5ePzFhC3ANUPjgJKnjbcA5
        gj1FOC1qqIro0tjZ9u0O47ljvUZXIuP+fbyb1c5+dQ==
X-Google-Smtp-Source: AGHT+IHuzu2zbN2Q2ArJbPyoWcANlHqVN3aMwDHI8VD8CHkerlIX0cYi9RWBdewr/s6MeaYobfunUw==
X-Received: by 2002:a0c:9789:0:b0:64f:36c0:4331 with SMTP id l9-20020a0c9789000000b0064f36c04331mr10571096qvd.39.1694485353332;
        Mon, 11 Sep 2023 19:22:33 -0700 (PDT)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com. [209.85.219.47])
        by smtp.gmail.com with ESMTPSA id q3-20020a0cf5c3000000b0063cfe9adb2csm3346799qvm.108.2023.09.11.19.22.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 19:22:32 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-655cee6f752so18875696d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 19:22:32 -0700 (PDT)
X-Received: by 2002:a05:6214:3281:b0:64f:9421:6c7 with SMTP id
 mu1-20020a056214328100b0064f942106c7mr10033506qvb.21.1694485351756; Mon, 11
 Sep 2023 19:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230828075420.2009568-1-anle.pan@nxp.com> <DB9PR04MB9284AA58AA71655C9C0C7C9A87E6A@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5DYxwX+JdXQ_-ba5B9y+gyWPjvUpCBnKM1zz1W2EkO_vA@mail.gmail.com>
 <DB9PR04MB928460023FB3CCCBC3EACE1487E9A@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5BGJX7=Z1ukFRq_ktaQ0d7FbvV-ob5gs8hfGaNHUXPTww@mail.gmail.com>
 <DB9PR04MB9284A0CDB1FC7CAADE0A394F87EFA@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5AugUGh7Z=9Qh7SS4=-0ddGBmRAOOyCGDfPdT-=eurtUg@mail.gmail.com> <DB9PR04MB9284A45033B3E24F44C5AA3987F2A@DB9PR04MB9284.eurprd04.prod.outlook.com>
In-Reply-To: <DB9PR04MB9284A45033B3E24F44C5AA3987F2A@DB9PR04MB9284.eurprd04.prod.outlook.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 12 Sep 2023 11:22:12 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Bk0DUq5jgFDHV2wGYEcfQzNVQ2KYJ2ZYLubwFLgqW4kQ@mail.gmail.com>
Message-ID: <CAAFQd5Bk0DUq5jgFDHV2wGYEcfQzNVQ2KYJ2ZYLubwFLgqW4kQ@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH] media: videobuf2-dma-sg: limit the sg segment size
To:     Hui Fang <hui.fang@nxp.com>
Cc:     Anle Pan <anle.pan@nxp.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jindong Yue <jindong.yue@nxp.com>,
        Xuegang Liu <xuegang.liu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 3:13=E2=80=AFPM Hui Fang <hui.fang@nxp.com> wrote:
>
> On Wed, Sep 6, 2023 at 18:28=E2=80=AFPM Tomasz Figa <tfiga@chromium.org> =
wrote:
> > That all makes sense, but it still doesn't answer the real question on =
why
> > swiotlb ends up being used. I think you may want to trace what happens =
in
> > the DMA mapping ops implementation on your system causing it to use
> > swiotlb.
>
> Add log and feed invalid data to low buffer on purpose,
> it's confirmed that swiotlb is actually used.
>

Yes, that we already know. But why?

> Got log as
> "[  846.570271][  T138] software IO TLB: =3D=3D=3D=3D swiotlb_bounce: DMA=
_TO_DEVICE,
>  dst 000000004589fa38, src 00000000c6d7e8d8, srcPhy 5504139264, size 4096=
".
>
> " srcPhy 5504139264" is larger than 4G (8mp has DRAM over 5G).
> And "CONFIG_ZONE_DMA32=3Dy" in kernel config, so swiotlb static is used.
> Also, the host (win10) side can't get valid image.
>
> Code as below.
> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/=
media/common/videobuf2/videobuf2-dma-sg.c
> index 7f83a86e6810..de03704ce695 100644
> --- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> +++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> @@ -98,6 +98,7 @@ static int vb2_dma_sg_alloc_compacted(struct vb2_dma_sg=
_buf *buf,
>         return 0;
>  }
>
> +bool g_v4l2 =3D false;
>  static void *vb2_dma_sg_alloc(struct vb2_buffer *vb, struct device *dev,
>                               unsigned long size)
>  {
> @@ -144,6 +145,7 @@ static void *vb2_dma_sg_alloc(struct vb2_buffer *vb, =
struct device *dev,
>         if (ret)
>                 goto fail_table_alloc;
>
> +       g_v4l2 =3D true;
>         pr_info("=3D=3D=3D=3D vb2_dma_sg_alloc, call sg_alloc_table_from_=
pages_segment,
>                         size %d, max_segment %d\n", (int)size, (int)max_s=
egment);
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index dac01ace03a0..a2cda646a02f 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -523,6 +523,7 @@ static unsigned int swiotlb_align_offset(struct devic=
e *dev, u64 addr)
>         return addr & dma_get_min_align_mask(dev) & (IO_TLB_SIZE - 1);
>  }
>
> +extern bool g_v4l2;
>  /*
>   * Bounce: copy the swiotlb buffer from or back to the original dma loca=
tion
>   */
> @@ -591,8 +592,19 @@ static void swiotlb_bounce(struct device *dev, phys_=
addr_t tlb_addr, size_t size
>                 }
>         } else if (dir =3D=3D DMA_TO_DEVICE) {
>                 memcpy(vaddr, phys_to_virt(orig_addr), size);
> +               if (g_v4l2) {
> +                       static unsigned char val;
> +                       val++;
> +                       memset(vaddr, val, size);
> +
> +                       pr_info("=3D=3D=3D=3Dxx %s: DMA_TO_DEVICE, dst %p=
, src %p, srcPhy %llu, size %zu\n",
> +                               __func__, vaddr, phys_to_virt(orig_addr),=
 orig_addr, size);
> +               }
>         } else {
>                 memcpy(phys_to_virt(orig_addr), vaddr, size);
>         }
>  }
>
>
> BRs,
> Fang Hui
>
