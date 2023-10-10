Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF6D7BF2EF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 08:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442222AbjJJGZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 02:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442180AbjJJGZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 02:25:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4D99D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 23:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696919083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1AqkLrzrIXxwvm4PGZ1aUIreaVgNNNZ9t0/4h1i7AZY=;
        b=gM0oGBEMp6KHPvdPCJXzv5D+MxnLVg2GK8J0TKPMjLg+CskOYpO5LEt+GY8WtiXyPTnZws
        Qp/Xg16TxzwVHmjeBrHa5sL8jWGf0YJ9s7/QcFp7NtFGN36ZuNOiY/I3j9RmGzKb5lKWN9
        x18baZrkt4yTrlWM7JXpNPqUFYfADGQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333--0bK5OfrOEOBnwcwygkVUA-1; Tue, 10 Oct 2023 02:24:41 -0400
X-MC-Unique: -0bK5OfrOEOBnwcwygkVUA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-50433324cf3so4670977e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 23:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696919080; x=1697523880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1AqkLrzrIXxwvm4PGZ1aUIreaVgNNNZ9t0/4h1i7AZY=;
        b=LbPXa+8C6y4cT44sy/Y60lTz9SIgNovrTRGdzftKnKbcmA5m6wa/z3oELSmvrd4Wx1
         ShC/aLDnWiq/IEqigybyBErq4SnIvsIAPj/JjkGpCaj9VFzAfWqQgs1HFQxNadmgA9nG
         VWcBXAv7dh2lz3Sn2iCa2yOrDJHo9Dgb5gZdKrYNQ7neTpZWsMuC4LDI1vZ/ooXYWUcZ
         4xjt99DhEFLaOwrsbs8PO8pSgDcNYnSFHny2Bq+EixKLcmyG+6Es3F9N+gWygEs+ue+u
         7XSipTHBqZHASlkJ02zkGehBZW0Pst77ZMg7RN2WE5YI2m//1znpcrTWYb3kbn2UIHK2
         YrGQ==
X-Gm-Message-State: AOJu0YymCgQ6YwpzBT3P6A7YGDPalQSJN3UXlarDS6t8N9g7kea6vVok
        lW3qqaBXaH+mZfge9zX37qB5XI7xFmI1D5ez/OpMqgt8MKaZAfi4zHytVqAkj8HTBnrExXlIpYK
        QGskq074YalpiK/oO7e3LMAtNDjBxm0j2VQE01UKiBoDR8muIHA0=
X-Received: by 2002:a19:f015:0:b0:500:d970:6541 with SMTP id p21-20020a19f015000000b00500d9706541mr13782369lfc.39.1696919079960;
        Mon, 09 Oct 2023 23:24:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7xUE6pgdBc/7IGhtXyNcrZjmsd0aJhTSJHQ75/95fWLdH7kgG7RJO/mGmbpq6jQLfRM7uFrYPEqqarKGGcNc=
X-Received: by 2002:a19:f015:0:b0:500:d970:6541 with SMTP id
 p21-20020a19f015000000b00500d9706541mr13782360lfc.39.1696919079631; Mon, 09
 Oct 2023 23:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231009112401.1060447-1-dtatulea@nvidia.com> <20231009112401.1060447-11-dtatulea@nvidia.com>
In-Reply-To: <20231009112401.1060447-11-dtatulea@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 10 Oct 2023 14:24:28 +0800
Message-ID: <CACGkMEuMnx0s6t-8FhT67Bd3-RYnZkFWUE+SfY2VByy0GbynAA@mail.gmail.com>
Subject: Re: [PATCH vhost v3 10/16] vdpa/mlx5: Allow creation/deletion of any
 given mr struct
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Parav Pandit <parav@nvidia.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 7:25=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
> This patch adapts the mr creation/deletion code to be able to work with
> any given mr struct pointer. All the APIs are adapted to take an extra
> parameter for the mr.
>
> mlx5_vdpa_create/delete_mr doesn't need a ASID parameter anymore. The
> check is done in the caller instead (mlx5_set_map).
>
> This change is needed for a followup patch which will introduce an
> additional mr for the vq descriptor data.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

