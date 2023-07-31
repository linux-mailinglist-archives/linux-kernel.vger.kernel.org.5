Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D083768BEB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 08:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjGaGY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 02:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGaGYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 02:24:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4FEE57
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 23:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690784650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dFujNs0s393AKJL9Pn5KqZK/kd8R31aOCdV5SggcTOg=;
        b=hlMZvrHUZ0ceVW2AbwDnradUhsukm3myNM4W8cJ2dqvBxYyfGKbCQa3yhAN3UJuvWex7x5
        ashdEW5y8YslYnKywRSjBvUlsCbaFfYvQb+f8raeoTbxxrNugE+Avof1EuqprOHgW9tr0K
        OStdBJfUYAGGut6Gj9BzzLFkwbP4s1s=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-w_1BH6QbNN-PifihR7a7ig-1; Mon, 31 Jul 2023 02:24:08 -0400
X-MC-Unique: w_1BH6QbNN-PifihR7a7ig-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1bb83eb84e5so45322235ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 23:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690784647; x=1691389447;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dFujNs0s393AKJL9Pn5KqZK/kd8R31aOCdV5SggcTOg=;
        b=WXcuYWQarKEtfluqD9ykdTO8uxz2we1uS8mpmpbLnuwADmOJG6g3BaK+/GHOASx1Ve
         NNGVxyXsWTrjTpjrmm7py28wjoJCwF0T66wduCRVJq3NZJ2f2I5IICkIIkZUGzleh0SV
         MDtyEIH+IUiRrr/6Cr7IPmTTq6DdeuK054jKvCkCEgyLTDwXVtCwVvhN9dg576KUTYfO
         mDTuLJobvv0tL9PuocoAiuCAaFqjiL4awofzpdd4EWS00H7S/M0tobchGxVl5OUwFmtf
         K0rIaOVZ9QbuHOCa+M0kKFBlcCGlyGRDtIPwtbZdTRhTGiB3BE2jdSrR8xbuc+hDQKWU
         uw9g==
X-Gm-Message-State: ABy/qLYtoejr2mOVEKmJ7Pa++8ip8X5GDc8/3s/nv4hZo8sREMJtwqqR
        8WhJ1Dhn58W9WQ+w5lrI7VJLbAwXDRomgNC5XQ3mPb+Z6qoqEwCA/gQC0mVrX97ZTJ+nH6aeaBe
        xC4qdunLNhBFxDZr4O9chhtGa
X-Received: by 2002:a17:902:6b88:b0:1b8:16c7:a786 with SMTP id p8-20020a1709026b8800b001b816c7a786mr7837690plk.4.1690784647320;
        Sun, 30 Jul 2023 23:24:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH7mH2Qi6DFfl6DwSxvSKUPeZPkzsuIKf9buf/HUaThSCbGhjgk9r38CsiEE+rud7IO8Nb3ow==
X-Received: by 2002:a17:902:6b88:b0:1b8:16c7:a786 with SMTP id p8-20020a1709026b8800b001b816c7a786mr7837667plk.4.1690784647016;
        Sun, 30 Jul 2023 23:24:07 -0700 (PDT)
Received: from [10.72.112.185] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id v5-20020a170902b7c500b001b5247cac3dsm7590352plz.110.2023.07.30.23.24.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 23:24:06 -0700 (PDT)
Message-ID: <66cd33fd-5d92-915e-e7ac-9eb564936eab@redhat.com>
Date:   Mon, 31 Jul 2023 14:24:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH net-next V4 2/3] virtio_net: support per queue interrupt
 coalesce command
To:     Gavin Li <gavinl@nvidia.com>, mst@redhat.com,
        xuanzhuo@linux.alibaba.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, jiri@nvidia.com, dtatulea@nvidia.com
Cc:     gavi@nvidia.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Heng Qi <hengqi@linux.alibaba.com>
References: <20230725130709.58207-1-gavinl@nvidia.com>
 <20230725130709.58207-3-gavinl@nvidia.com>
Content-Language: en-US
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230725130709.58207-3-gavinl@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/7/25 21:07, Gavin Li 写道:
> Add interrupt_coalesce config in send_queue and receive_queue to cache user
> config.
>
> Send per virtqueue interrupt moderation config to underlying device in
> order to have more efficient interrupt moderation and cpu utilization of
> guest VM.
>
> Additionally, address all the VQs when updating the global configuration,
> as now the individual VQs configuration can diverge from the global
> configuration.
>
> Signed-off-by: Gavin Li <gavinl@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>


Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

