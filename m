Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C18C7BF2F8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 08:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442246AbjJJG1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 02:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442233AbjJJG1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 02:27:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064959E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 23:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696919178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZXgJjAltwNNXgE6CpFrMVez2TIFFxTWTGd+YncZ0BYc=;
        b=J9qa/Vx4AknqwwOM7fPSxC8QVkwL6hC7/vnJPBqUpqlKr1n9zewf2P3vTOb11mNOLXaFfx
        rBqm/3YRmjPgQ4or+UUTSH/1QgzrEzhK6nujZDvruIIcfKCTSbqoebG28lPYO6FtsING0Q
        kavDLq7gGzId4mj+VDWB+Km3BlTcN2E=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-v07QqIuZMHaAm2j2GAUK6Q-1; Tue, 10 Oct 2023 02:26:07 -0400
X-MC-Unique: v07QqIuZMHaAm2j2GAUK6Q-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-503317b8d26so4613410e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 23:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696919165; x=1697523965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZXgJjAltwNNXgE6CpFrMVez2TIFFxTWTGd+YncZ0BYc=;
        b=OGYcMIiFSqz2NIsn4G+TJXFVkAEPZgDKCNf0hjbS+lFCyyAKkW3fIIWDCgltFD5Xgp
         gooPMtSNW8u/ji2idEoH7LFHBzzgF/o89ScNxdwbB/o7x5Gd2i/nkObwNo8t39ZLWCwL
         Tc5jKtCDNapoc+gaqwAoeKwRN/DrVrHIuG+EQLCHw2fPanWz2AMeethbdAjBcwCHq5Fc
         LA5GuShr89/Om0zvr6iw0bXq2HuUZFjON1ZsxD6bBmlH5/opOCwTHsByMqPZdF8rL4Sm
         bNMfczZweJzaUDHqjr0BVOmNdXfXpQ5L31QMRggwtAzpQlnUGla0/O9cNwclbw//juZJ
         I2xw==
X-Gm-Message-State: AOJu0YyDxvl3+ky3iu36ThGq5TcjwxD9vo21ypZYseO1hredmmb6j1WU
        yh+zfYYlMzVXOm6Dmpmaq9rsQAnbrYQyl2D6PVDpw9rXcYR1QV3UnAMcyXZxsT9+X7QTqDfM1Bx
        mg9+kmrHcZbmmS9tbTV5sPBFageyjIjv/zFUqTTju
X-Received: by 2002:ac2:5e2c:0:b0:500:9524:f733 with SMTP id o12-20020ac25e2c000000b005009524f733mr11638590lfg.20.1696919165639;
        Mon, 09 Oct 2023 23:26:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTRfSc/Dwktp9YhC8aXUxGnki2o7zlWGkxqIyChOD0GhfDblxBz/lw7GvevY0oxSJY788QjGmeYKUsCUmt5sc=
X-Received: by 2002:ac2:5e2c:0:b0:500:9524:f733 with SMTP id
 o12-20020ac25e2c000000b005009524f733mr11638574lfg.20.1696919165315; Mon, 09
 Oct 2023 23:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <20231009112401.1060447-1-dtatulea@nvidia.com> <20231009112401.1060447-12-dtatulea@nvidia.com>
In-Reply-To: <20231009112401.1060447-12-dtatulea@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 10 Oct 2023 14:25:54 +0800
Message-ID: <CACGkMEt6gQCBJNZzc-tia6YkY7z7-zF4Qc2njixVaCZMfohvpw@mail.gmail.com>
Subject: Re: [PATCH vhost v3 11/16] vdpa/mlx5: Move mr mutex out of mr struct
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
> The mutex is named like it is supposed to protect only the mkey but in
> reality it is a global lock for all mr resources.
>
> Shift the mutex to it's rightful location (struct mlx5_vdpa_dev) and
> give it a more appropriate name.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

