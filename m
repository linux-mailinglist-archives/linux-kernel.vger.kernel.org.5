Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A3C7FAFE7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 03:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbjK1CHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 21:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbjK1CHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 21:07:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D96A1B1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 18:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701137241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=26ylPeTUKwauoxaVi1z6xco5xaOkWba8wbcA5nPLGlY=;
        b=Xwi6xBmsWf+cGkiQYvW2D+8DGpctYsxNmf5kkFyfzbCxgmCx4RpqUvIg+uioDE0yJEe/t0
        E7vpGJUr3T+H+3Prm2mAwVJxpquX5caF2c0UkVMtAfEsUPyLOTcfF0uikcYOJAoulbAUjq
        3KdW9XD1+Nt8jLO/mwcmN59ofCRiSEM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-f-boATXjOW2vq0AyQxrXlQ-1; Mon, 27 Nov 2023 21:07:20 -0500
X-MC-Unique: f-boATXjOW2vq0AyQxrXlQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-67804869762so60035426d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 18:07:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701137239; x=1701742039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=26ylPeTUKwauoxaVi1z6xco5xaOkWba8wbcA5nPLGlY=;
        b=u2I/JhG8Q2z2z+3pl0o94Lfnq4bVvOVcVmn4l+LekaQmiddCnZy4OnnAWoTPETqmo3
         osKAIbCl+Y4MtJqd3i6bst5ihodwAf+3RZNVZlYUH/dOLEzm5bmIO7r7AvjCiDPQC6NW
         XxqZGK6/i7/NBu758ikDCWBGwUlYmFNCa8azeOkH2Cu32HY10yqQ202nyNMEeragp0PN
         doeyf9XtF9+A7ycbbEoBSY6PJTMMqqcyL5r7JECZMSD/dU/BszEtAGRX5nFD+rjiZVKR
         /3Zv5TnR9U+cXoYatjvjDO//vEGfBZwEclhBi+WmaCGaWQvLlBm1Ylw5PUkWrkDwFQRo
         bHJw==
X-Gm-Message-State: AOJu0YzoH20b6x1A2HlJ5SjzDcIKIm9oLuFwntMIKfRUazRwOgLpO+Zw
        plPY561O+rGtmiJ7vO5BuvR2u+CfODF0Gg0bhnzhPvLx1gYJxzuU1CgnvoScRvFswQP2oTtiN5m
        IgXNLEVmzDmz435FtjseRyxcMuS+iJh4nrjmmnZwk4eSVK2bwI8nhsQ==
X-Received: by 2002:ad4:4582:0:b0:67a:2c28:ce06 with SMTP id x2-20020ad44582000000b0067a2c28ce06mr8365654qvu.63.1701137239593;
        Mon, 27 Nov 2023 18:07:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTw8IiCvQDQz/rDMw7LbIWJb2p+jcHMtz7+40WBg/SDRsyIbNd4vmRPgJFXJrHQVJWKiRODIA+xEo2TuwpTVs=
X-Received: by 2002:ad4:4582:0:b0:67a:2c28:ce06 with SMTP id
 x2-20020ad44582000000b0067a2c28ce06mr8365639qvu.63.1701137239401; Mon, 27 Nov
 2023 18:07:19 -0800 (PST)
MIME-Version: 1.0
References: <ZWD_fAPqEWkFlEkM@dwarf.suse.cz> <CAO7dBbUVQn8xzPZQhhw1XqF+sQT0c6phk4sda+X=MrR6RmPE0A@mail.gmail.com>
 <ZWJllXCN0SDIELrX@dwarf.suse.cz>
In-Reply-To: <ZWJllXCN0SDIELrX@dwarf.suse.cz>
From:   Pingfan Liu <piliu@redhat.com>
Date:   Tue, 28 Nov 2023 10:07:08 +0800
Message-ID: <CAF+s44QDMzSq3ihzRtaP9ZwF-drfAiQq713d9bastsJFiReJ4w@mail.gmail.com>
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
To:     Jiri Bohac <jbohac@suse.cz>
Cc:     Tao Liu <ltao@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, mhocko@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2023 at 5:24=E2=80=AFAM Jiri Bohac <jbohac@suse.cz> wrote:
>
> Hi Tao,
>
> On Sat, Nov 25, 2023 at 09:51:54AM +0800, Tao Liu wrote:
> > Thanks for the idea of using CMA as part of memory for the 2nd kernel.
> > However I have a question:
> >
> > What if there is on-going DMA/RDMA access on the CMA range when 1st
> > kernel crash? There might be data corruption when 2nd kernel and
> > DMA/RDMA write to the same place, how to address such an issue?
>
> The crash kernel CMA area(s) registered via
> cma_declare_contiguous() are distinct from the
> dma_contiguous_default_area or device-specific CMA areas that
> dma_alloc_contiguous() would use to reserve memory for DMA.
>
> Kernel pages will not be allocated from the crash kernel CMA
> area(s), because they are not GFP_MOVABLE. The CMA area will only
> be used for user pages.
>
> User pages for RDMA, should be pinned with FOLL_LONGTERM and that
> would migrate them away from the CMA area.
>
> But you're right that DMA to user pages pinned without
> FOLL_LONGTERM would still be possible. Would this be a problem in
> practice? Do you see any way around it?
>

I have not a real case in mind. But this problem has kept us from
using the CMA area in kdump for years.  Most importantly, this method
will introduce an uneasy tracking bug.

For a way around, maybe you can introduce a specific zone, and for any
GUP, migrate the pages away. I have doubts about whether this approach
is worthwhile, considering the trade-off between benefits and
complexity.

Thanks,

Pingfan

