Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B93808077
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 07:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377313AbjLGGCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 01:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377345AbjLGGCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 01:02:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2785D6D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 22:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701928969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u/XqCkGwetPERlH8LTIVNcKw64vcUuQSwWmVxlaN7SM=;
        b=QChhmL5E4hLNRBQ9PtB2SCfVoBbX5YA6aatn0WooLhHfdp39mnu3H64/KdfwCGWPvwPdSO
        GhExH3dMlqey3qX3ZkkoE79jswNv6eqhKehcyUQ6obLfEeD5z6bq1k3mfJrzY5/6zV2Btl
        EVoXIdvpuLiQ0UfS4vNxEyxA0iuDaOM=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140--LjteiK1OL6K09m2xxw_BA-1; Thu, 07 Dec 2023 01:02:48 -0500
X-MC-Unique: -LjteiK1OL6K09m2xxw_BA-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1d068f02fc7so7016385ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 22:02:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701928967; x=1702533767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/XqCkGwetPERlH8LTIVNcKw64vcUuQSwWmVxlaN7SM=;
        b=cWv018N0oHSeNAZiJUmHO2QKiImG8Z6BZ2Fe1iJPadTYH0DbaAgWeJGAQUQz0jgF5a
         bWIJQAdwmoD4BLJiy0MB/XbA14hlZmNkyOEZghSVR/huecpxRquTe/Mkz/kQ+KHgPuio
         IvdX91Or/P1AFzfOp7y/QTEJrO/yBSIDaWRY5/kUVBKW4Q3S2m9wJLQcW3ehjPkw4DAO
         PYMWiPPunxDnIdWGTMmB+R6Y69O1Sr7P/gMRVUh6nyrRXgVV1wNNTlPi7m/uyASI4PaE
         tRzSE6bfvvCOhC9CXld9L1uTFvOU+4x1xE2zXWk1AySZ5V0dxYkCJiRjMUuVc4qG05Ej
         D+Mw==
X-Gm-Message-State: AOJu0YwxnhEJTfBV+7AsCCO9Sn5rLsXYJU5WQd907DFE94YEUidFCqPY
        FDakNTkN6WyCBLwn+Lj1g1dN/M4EjbAlcKobfSqvKAp5djAkf45QvzGjlRsJX/IAZNJ6MznAbqn
        R1tehlzNxKwzprjsefAUMKeKO18JC+X6aS5uCFjpu
X-Received: by 2002:a17:903:228e:b0:1d0:9c53:9cca with SMTP id b14-20020a170903228e00b001d09c539ccamr1954629plh.96.1701928967270;
        Wed, 06 Dec 2023 22:02:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGownq1ugLEOsfZ1cOJOiCkaYo93T8MWTSEJJFK0j1YeFaEDArhl552qEMO2cfTnbzOgcp/3YMGRbZyZbgPil0=
X-Received: by 2002:a17:903:228e:b0:1d0:9c53:9cca with SMTP id
 b14-20020a170903228e00b001d09c539ccamr1954622plh.96.1701928967048; Wed, 06
 Dec 2023 22:02:47 -0800 (PST)
MIME-Version: 1.0
References: <20231207043118.118158-1-fengli@smartx.com>
In-Reply-To: <20231207043118.118158-1-fengli@smartx.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 7 Dec 2023 14:02:36 +0800
Message-ID: <CACGkMEt4_T5-aArkS4LOQsndwrMkjm_K-uPjdFnNRvwknQPaPg@mail.gmail.com>
Subject: Re: [PATCH] virtio_blk: set the default scheduler to none
To:     Li Feng <fengli@smartx.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO BLOCK AND SCSI DRIVERS" 
        <virtualization@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 12:33=E2=80=AFPM Li Feng <fengli@smartx.com> wrote:
>
> virtio-blk is generally used in cloud computing scenarios, where the
> performance of virtual disks is very important. The mq-deadline scheduler
> has a big performance drop compared to none with single queue.

At least you can choose the scheduler based on if mq is supported or not?

Thanks

