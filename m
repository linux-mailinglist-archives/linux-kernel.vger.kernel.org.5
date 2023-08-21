Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35748782C6C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbjHUOrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 10:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjHUOrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:47:01 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E59CE9;
        Mon, 21 Aug 2023 07:46:59 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-64f3ad95ec0so9950676d6.1;
        Mon, 21 Aug 2023 07:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692629218; x=1693234018;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WuA3TdNjVttC4ENEMTU7iIB13TPKbbPgEw4DfONfOIg=;
        b=nzOfc/+3vPkk+2xcoHixT2qig/KVfSfruaE8oC/BHOhj4Vj8zK9wQl/YBsovUfjuyE
         zzdUfx0F+1nY+xEONrt5yI8FWOp1QrAohZ3IkYZyY94D8Nb0lF63snqV0onxX8UJbdRS
         W1OENcVQ/wPS91JuWs6rzqCuSYu2pCwXc2MvCLhv1xAQf/GW34/3Xok29hzwDsUcEWri
         K6RBfHFWHDQw3zBVPMEemIuhjd5J2WirIGF8kiJIV2fCCwk1JLsGdgid8sas/T3c1R7D
         ClfsowvOP6bADW4XnuMdfydqJvFH70N4COIOkZ7NSD8UaocdbL6/2rMcwVI7BOjmq2gJ
         pIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692629218; x=1693234018;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WuA3TdNjVttC4ENEMTU7iIB13TPKbbPgEw4DfONfOIg=;
        b=Dtgl+cU6IarnX6x0DtTSzWlPce41S1QtxadCguUNKQ6c3EjkkEJJofC+ZTZOZHWZ2B
         DwsOtGuYAzHyvXp/XVj3abuOOB2WF868+hcWwiyVCg68FJ6eFCnpG30voMe1p2F0FeqZ
         v/OgtXrj0NpBpNh8HaoNnuO9Bxu2F0ovmHDZOYy89OJCj+9dI2cdrwlv+6Pwlq2uVkJX
         m9b0J+OvkjTnx7F2KeWZKxkYcmjkkDgsTLR9uyeYQ+C3wGI00Rk/3dpmI7HWAWe2efgz
         +d4xBgjX1cd1+usXDwuCf0DBijr1+dtIkPmCQHg+w8AeZkJZhcnbEclTmxGbs1XB1hvq
         KBNQ==
X-Gm-Message-State: AOJu0YwX9fing7Csb0owXjQIv2f0xumUT+bk70KC7D1d7IJLRZS00/3E
        1dF13cqOMvfbOM/DQy5CQMQ=
X-Google-Smtp-Source: AGHT+IG/I4x/uX5zBHwBZnZQvnI1/jXeEL+zKtLEb5rhbvBKzlFssu9Ud/GZZNrEpLvz+FrLSwB56A==
X-Received: by 2002:a0c:e084:0:b0:64f:3e27:1e4a with SMTP id l4-20020a0ce084000000b0064f3e271e4amr3752794qvk.19.1692629218377;
        Mon, 21 Aug 2023 07:46:58 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id t3-20020a0ce2c3000000b0064729e5b2d9sm2950385qvl.14.2023.08.21.07.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 07:46:58 -0700 (PDT)
Date:   Mon, 21 Aug 2023 10:46:57 -0400
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     Feng Liu <feliu@nvidia.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Simon Horman <horms@kernel.org>,
        Bodong Wang <bodong@nvidia.com>, Feng Liu <feliu@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>
Message-ID: <64e378e1c7fed_1b7a7294fd@willemb.c.googlers.com.notmuch>
In-Reply-To: <20230821142713.5062-1-feliu@nvidia.com>
References: <20230821142713.5062-1-feliu@nvidia.com>
Subject: Re: [PATCH net-next v3] virtio_net: Introduce skb_vnet_common_hdr to
 avoid typecasting
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Feng Liu wrote:
> The virtio_net driver currently deals with different versions and types
> of virtio net headers, such as virtio_net_hdr_mrg_rxbuf,
> virtio_net_hdr_v1_hash, etc. Due to these variations, the code relies
> on multiple type casts to convert memory between different structures,
> potentially leading to bugs when there are changes in these structures.
> 
> Introduces the "struct skb_vnet_common_hdr" as a unifying header
> structure using a union. With this approach, various virtio net header
> structures can be converted by accessing different members of this
> structure, thus eliminating the need for type casting and reducing the
> risk of potential bugs.
> 
> For example following code:
> static struct sk_buff *page_to_skb(struct virtnet_info *vi,
> 		struct receive_queue *rq,
> 		struct page *page, unsigned int offset,
> 		unsigned int len, unsigned int truesize,
> 		unsigned int headroom)
> {
> [...]
> 	struct virtio_net_hdr_mrg_rxbuf *hdr;
> [...]
> 	hdr_len = vi->hdr_len;
> [...]
> ok:
> 	hdr = skb_vnet_hdr(skb);
> 	memcpy(hdr, hdr_p, hdr_len);
> [...]
> }
> 
> When VIRTIO_NET_F_HASH_REPORT feature is enabled, hdr_len = 20
> But the sizeof(*hdr) is 12,
> memcpy(hdr, hdr_p, hdr_len); will copy 20 bytes to the hdr,
> which make a potential risk of bug. And this risk can be avoided by
> introducing struct skb_vnet_common_hdr.
> 
> Change log
> v1->v2
> feedback from Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> feedback from Simon Horman <horms@kernel.org>
> 1. change to use net-next tree.
> 2. move skb_vnet_common_hdr inside kernel file instead of the UAPI header.
> 
> v2->v3
> feedback from Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> 1. fix typo in commit message.
> 2. add original struct virtio_net_hdr into union
> 3. remove virtio_net_hdr_mrg_rxbuf variable in receive_buf;
> 
> Signed-off-by: Feng Liu <feliu@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

A similar solution as tpacket_uhdr.
