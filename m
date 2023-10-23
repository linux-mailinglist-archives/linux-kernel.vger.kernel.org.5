Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F137D2931
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 05:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjJWDw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 23:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJWDw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 23:52:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD43188
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 20:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698033099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+V7BmlRiz3EwuPt7UOzQq7qzRqObgsoG0aaVO3Q641Q=;
        b=IoUpiP8d80kDQpkXzK5vK6Zyo9ctiSrpjIoDPOzB25V4w/ufnQ717XeTYjQrCLZmdVTjmT
        3UTSYRGtrwCORhvaGtqrSQ5qTsobe+8vyNfATLp3vjUmSsVu+d3ux2vxEMgsaUtNSue2+n
        kdcafocQBlnP5k1cAmUxau9x68SdcO8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529--OAKnr4LOA-hT-F-qfynHw-1; Sun, 22 Oct 2023 23:51:32 -0400
X-MC-Unique: -OAKnr4LOA-hT-F-qfynHw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5079fe7cc7cso2855184e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 20:51:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698033090; x=1698637890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+V7BmlRiz3EwuPt7UOzQq7qzRqObgsoG0aaVO3Q641Q=;
        b=rSF3WjZ23gmDcrMfuaeAed5h078nUDm/DePcCDvfniSr2t/MgJJuXSoOl/tiLZD39W
         az4KjCbV/aOtQbqHNelIPeYPcq89Tjz/wV3DLErZdLuEULdFxQ0XzEu8HXhRFdXcGKEg
         nl4VIcMIqlN6Ra/+ZUQBtHNJapN2oHY+hY5JLlLKavLjCdQxlPKj2FmrVanlHAC/hODy
         x8ney0KIH2km2UA5DCK15/zAnHmCl/PtrhcJiapBotAvD5jHJReZ9HGGvgfjTlIzeMXg
         RyFDJEtA2yQ4sKm9N1B2u41EVgxLq4yK2AryVx0GCmYC9ASAdIGXh7WQvSUoN4K41NsJ
         9fHQ==
X-Gm-Message-State: AOJu0YyZ27fX9OqUD/a983pEeR51c3CPZSJ07q7Ub1nZ4G31MGIz2bRb
        QefX0mKEUzgfVEcwusLJHyilc5kbpItCBcx5urlnYnzoG5UnlTPJNXneG3kRUUChJirU27tBHZK
        CreCblBPb8HY/z3UjeGZfjQWzerZPFpUp2whfYqgGdM3vFhCCIKU=
X-Received: by 2002:ac2:4911:0:b0:500:7a21:3e78 with SMTP id n17-20020ac24911000000b005007a213e78mr5226118lfi.55.1698033090739;
        Sun, 22 Oct 2023 20:51:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBVz9KGtLqK/A0i1i8bVdzKIT/WKsiTXMWhplm2cV356QzdFFyLaRynHU7puQJ3xGZVp2LihGQnjFJ4J3CXRM=
X-Received: by 2002:ac2:4911:0:b0:500:7a21:3e78 with SMTP id
 n17-20020ac24911000000b005007a213e78mr5226109lfi.55.1698033090354; Sun, 22
 Oct 2023 20:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <1697880319-4937-1-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1697880319-4937-1-git-send-email-si-wei.liu@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 23 Oct 2023 11:51:19 +0800
Message-ID: <CACGkMEvkSFcHXC0HFw-NoDtDNnaucJbpfPO0Yho2r1QP8F6zSw@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] vdpa: decouple reset of iotlb mapping from device reset
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     mst@redhat.com, eperezma@redhat.com, sgarzare@redhat.com,
        dtatulea@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Si-Wei:

On Sat, Oct 21, 2023 at 5:28=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
> In order to reduce needlessly high setup and teardown cost
> of iotlb mapping during live migration, it's crucial to
> decouple the vhost-vdpa iotlb abstraction from the virtio
> device life cycle, i.e. iotlb mappings should be left
> intact across virtio device reset [1]. For it to work, the
> on-chip IOMMU parent device could implement a separate
> .reset_map() operation callback to restore 1:1 DMA mapping
> without having to resort to the .reset() callback, the
> latter of which is mainly used to reset virtio device state.
> This new .reset_map() callback will be invoked only before
> the vhost-vdpa driver is to be removed and detached from
> the vdpa bus, such that other vdpa bus drivers, e.g.
> virtio-vdpa, can start with 1:1 DMA mapping when they
> are attached. For the context, those on-chip IOMMU parent
> devices, create the 1:1 DMA mapping at vdpa device creation,
> and they would implicitly destroy the 1:1 mapping when
> the first .set_map or .dma_map callback is invoked.
>
> This patchset is rebased on top of the latest vhost tree.
>
> [1] Reducing vdpa migration downtime because of memory pin / maps
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg953755.html
>
> ---
> v4:
> - Rework compatibility using new .compat_reset driver op

I still think having a set_backend_feature() or reset_map(clean=3Dtrue)
might be better. As it tries hard to not introduce new stuff on the
bus.

But we can listen to others for sure.

Thanks

