Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDCA776EF5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 06:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjHJENX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 00:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjHJENU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 00:13:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA96810C0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 21:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691640759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MpZ1xdG2a7UripeaaXQi64sXQC9E4hMZ1zP5gcfMmYk=;
        b=IrCgd9lZPS/1rpHjHkGJd4tDB8aKSDWOy24RMaLK5RD5zeYP3cQBAKQJgIlB5GERIdev4K
        Gi/fnjQidFTvITAqcGrGUG5xRHAniCWyDwXU3K7a1AKskjbQZLfzz9TKJnHpeVCYic1Gkn
        7Y234tnEvLoZf888oPLi3KyvVsbugDQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-nXg5fEd7OGy_kTKqwZ7e9Q-1; Thu, 10 Aug 2023 00:12:37 -0400
X-MC-Unique: nXg5fEd7OGy_kTKqwZ7e9Q-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b9e8abe56bso4721371fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 21:12:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691640756; x=1692245556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MpZ1xdG2a7UripeaaXQi64sXQC9E4hMZ1zP5gcfMmYk=;
        b=LEPRX6W0Mm2H+AjSbsyHDHZuxjIoDTgK9ZujqOXZSG948VTyvyjz/bVqUZwwCcd1KA
         wp/8ZOA76L6EbjywXbNmnFIZdjnDjozDqS+fcgKBxjRt1b0iy6M9jsR6rD2uNBlkCfzz
         J2raTFPI5cYfg7rKeVBbqGkRfOon2RsGHHhC1mkGCkO+Q4lpAC3N/frXTxrlSFbK61yw
         Ol3YyrU/g3T3TICCGECEcXyo4AJOncv9G2QfdqjEPu+eurq+GXTD34anQrRa5DtLeLWk
         5pewDlGiIHnqnmM8hbNsD1iO0e1X2nl29GJEC/PUAJKBf3VeDFhmM7e6Di93Ti9LEwu3
         bOaQ==
X-Gm-Message-State: AOJu0YyQo8DGb4EpyyqVNKyfeux4ViD7zp2b1Gm1jR6PcOpuXaw1eBnh
        y+/nFKhfJZAkWK66fqtCgMLRsm2xfnVpLWqH8i2a4JBjPxclMSAO8bx3GjkwEtOD+0qXcfOFfzH
        8ReYO9AdJl6mmetrApJkyvpSbTY6OxLQ3wa9g940t
X-Received: by 2002:a2e:884a:0:b0:2b9:ec57:c331 with SMTP id z10-20020a2e884a000000b002b9ec57c331mr940292ljj.6.1691640756073;
        Wed, 09 Aug 2023 21:12:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaAekTnhnaCJl4cn+CYttu+Q7kBOi1OQnauownq+9tUz7svhr/pDPkmAYG6E44ev8Mnzua0MchL6zCrzalZvI=
X-Received: by 2002:a2e:884a:0:b0:2b9:ec57:c331 with SMTP id
 z10-20020a2e884a000000b002b9ec57c331mr940280ljj.6.1691640755792; Wed, 09 Aug
 2023 21:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230810031557.135557-1-yin31149@gmail.com>
In-Reply-To: <20230810031557.135557-1-yin31149@gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 10 Aug 2023 12:12:24 +0800
Message-ID: <CACGkMEu_vzfcD=BzkL=HAkfi+RVq1F2vpDDQBGg54O_PL1fWGQ@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: Zero max_tx_vq field for VIRTIO_NET_CTRL_MQ_HASH_CONFIG
 case
To:     Hawkins Jiawei <yin31149@gmail.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, eperezma@redhat.com,
        18801353760@163.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 11:16=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.com=
> wrote:
>
> Kernel uses `struct virtio_net_ctrl_rss` to save command-specific-data
> for both the VIRTIO_NET_CTRL_MQ_HASH_CONFIG and
> VIRTIO_NET_CTRL_MQ_RSS_CONFIG commands.

This is tricky.

>
> According to the VirtIO standard, "Field reserved MUST contain zeroes.
> It is defined to make the structure to match the layout of
> virtio_net_rss_config structure, defined in 5.1.6.5.7.".
>
> Yet for the VIRTIO_NET_CTRL_MQ_HASH_CONFIG command case, the `max_tx_vq`
> field in struct virtio_net_ctrl_rss, which corresponds to the
> `reserved` field in struct virtio_net_hash_config, is not zeroed,
> thereby violating the VirtIO standard.
>
> This patch solves this problem by zeroing this field in
> virtnet_init_default_rss().
>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

