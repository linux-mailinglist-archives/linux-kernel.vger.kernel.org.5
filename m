Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C077761F0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbjHIOBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbjHIOBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:01:35 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809EA212B;
        Wed,  9 Aug 2023 07:01:29 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-40ddc558306so51160541cf.2;
        Wed, 09 Aug 2023 07:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691589688; x=1692194488;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLYgZQH2Ij3K3LoTdjXRfe+TJ6luenVkp0WNkFXycto=;
        b=FEQ5IzQKBnixKZFMgNTz3T6J5SZSi+dgJ9hmE2UxqM+/bX12aVctBv9Y+gKGjjtsmP
         7qsgv7xmPWhvveYZtadCCi1f4IanwffNIk1CKMIa+7kMkZH4Z5Jpn7YviFOvia0tRqhj
         ly4gDughof+XQeRLB4K5olmTN0h+H9rfrfBJL3/TXoIE+N1bfVxPUZRxOMHVLJhV6MYf
         rg1sZ8YR0IYRSb1NOSSLKJjSCUSu/ybtbE5ROA3t8cZAjpl8Ztkd65dZN4f9kmM+Lnd0
         C/GJ/5jL3l9Ty2pXwPHMPWPUHOo7qdbvVQcTVo/3+RLMR6F3wVJi/WfbRvP/MDxQxIjz
         zewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691589688; x=1692194488;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LLYgZQH2Ij3K3LoTdjXRfe+TJ6luenVkp0WNkFXycto=;
        b=GyNKk5emUPI45SgBaKyTR1QrZlXxyEsppI2D+vLBVnsEQPU6zCkxJBv0MdArfYb/G/
         G5rxj21pwwviDwaW0Mluj62EsqmIf0O+D5E1qabx9NPXpfyNHDudBIXI1tdpQzipPKFv
         LqKvhwlwj9lrHaRZ6E8i+GSZvhiQt3efsQFwj2P5k/YwrkTZcjvmKnikV4L0zJdZEQ+s
         PIy06WfCfFAvXBW6dMeVfZ2SwBW6KCThVBoXLUjxe6z/cLXs1ipyKi3LK5iCIFWbnkFU
         ICaAFuKqj0wLbPG8zKO/Rr4kwgZ0s5uGyRSO0xPUVlQu4Tw64LFP8TkoeF2yif4c1Hjk
         Gw8g==
X-Gm-Message-State: AOJu0YzoYVadzlkQGbYLFaTafQ7fvNsJgsggzdQ74EZJ4v+lzFbjrrY0
        uOZA5y/p3arEF3jZB/HXXpA=
X-Google-Smtp-Source: AGHT+IFZo3I3XbMYg31QcvWH7Nq/rpn7umB+aovvba/yvvD70tFDc6X5txm0oye9CiI4S94wFJt7YA==
X-Received: by 2002:a05:622a:552:b0:40e:2e60:e3e1 with SMTP id m18-20020a05622a055200b0040e2e60e3e1mr3601664qtx.33.1691589688281;
        Wed, 09 Aug 2023 07:01:28 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id h17-20020ac87451000000b00405d7c1a4b0sm4084889qtr.15.2023.08.09.07.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 07:01:27 -0700 (PDT)
Date:   Wed, 09 Aug 2023 10:01:24 -0400
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     "Erdogan, Tahsin" <trdgn@amazon.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <64d39c34bbd92_26add629414@willemb.c.googlers.com.notmuch>
In-Reply-To: <fc219fe5f8c8dec66a6fdff08f40acf714b8328b.camel@amazon.com>
References: <20230808230920.1944738-1-trdgn@amazon.com>
 <64d3921ed1f1a_267bde294f2@willemb.c.googlers.com.notmuch>
 <fc219fe5f8c8dec66a6fdff08f40acf714b8328b.camel@amazon.com>
Subject: Re: [PATCH v3] tun: avoid high-order page allocation for packet
 header
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Erdogan, Tahsin wrote:
> On Wed, 2023-08-09 at 09:18 -0400, Willem de Bruijn wrote:
> > Tun sendmsg is a special case, only used by vhost-net from inside the
> > kernel. Arguably consistency with packet_snd/packet_alloc_skb would
> > be
> > more important. That said, this makes sense to me. I assume your
> > configuring a device with very large MTU?
> 
> That's right. I am setting MTU to 9100 in my test.

Makes sense. That's not even that large.

Please address the commit message points about virtio_net_hdr.hdr_len
and write() vs writev().

A writev() specific solution could even take the first iov length as
hint. Note that I'm not suggesting that. IFF_NAPI_FRAGS already does
exactly that, plus the geometry of subsequent frags.
