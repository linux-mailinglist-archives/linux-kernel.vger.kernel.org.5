Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA6C769B11
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjGaPr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjGaPrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:47:24 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE854E57;
        Mon, 31 Jul 2023 08:47:23 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe389d6f19so1553740e87.3;
        Mon, 31 Jul 2023 08:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690818442; x=1691423242;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ABZh1xz4n6wuJf1UZhlFRWHEBKIhLTjdbX5I0EQWrCs=;
        b=fSwFWkvhfCC6nHRRWXxDB0k59t7O9AYCvs+ae07YpC7D6PcxOp7BdFPLNtWeGb4Fdz
         wGHX0O86FGkl3r7hPwNaGSL8yPtLD0a995rOr64KRFzOodWqKD53z0pdEmXcS0ECkBHB
         tVxaJy2KHqLL31jRxlsQz15+yuZx4/wcK0DeDJHMIJiecc3RFcZEt8e/kXd2duxPH2GJ
         QJMFDXWWPuWw3+LPBncbkiax3Zs1LivJUK3j5uyssFaAgiNGgerQ6cNN1cWnS7o9dVr2
         4iignrmbEAntlYFXzebve04wmC65Xv1oq3nEhFEibh37R77U0vR9xbSH+ldd1Ln/6f5G
         D5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690818442; x=1691423242;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ABZh1xz4n6wuJf1UZhlFRWHEBKIhLTjdbX5I0EQWrCs=;
        b=f9y+iExwwdwYrJDSRXGJBIc82DSWEsv7UM02j+nYKjPlcay35MVTd0R9IsCdprv9Mq
         P+czQG1z5gA5EKJaSllcjVvjExrsqFmRa/Q4x/fTY7VKmc5SYcuS/T/27uxLOaeb4ZIx
         5xmVqr3D5GW41XgjjJkmZsXrUDXiO30N44nlASLFVPtrfTE6NIQK5cwfo7G+ZJAcpUo4
         7OmvZV8V6TxILpXMfkjm0zd47zqCAQwXxOpCdtJX3+tYWKyi2Z47H1WJ6MMJ/sZx1OIX
         2lt9Zve6oPrRXkZC8nrGGi9jAPnP4kA+WVks0WGDzUl95WpK22FMq+VTuebkNbrlP+Fa
         /Azw==
X-Gm-Message-State: ABy/qLYLU//2e/jWAjuU53oGv3W1KPCcm8m25t2xZ0EyNfkkce/J7Id/
        ziK/mSLS4/ExLLiR+VC5+XE=
X-Google-Smtp-Source: APBJJlHev/F2QvCssa3rzFT8WFT/xaYyjd6AmItAIopq/blmw1EN/cScn24nT8oET8fR0vJl1FcXDg==
X-Received: by 2002:a19:4f54:0:b0:4fb:89f2:278e with SMTP id a20-20020a194f54000000b004fb89f2278emr149583lfk.68.1690818441527;
        Mon, 31 Jul 2023 08:47:21 -0700 (PDT)
Received: from akanner-r14. ([77.222.27.66])
        by smtp.gmail.com with ESMTPSA id z21-20020a19f715000000b004fdc6f03c6dsm2119808lfe.37.2023.07.31.08.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 08:47:20 -0700 (PDT)
Message-ID: <64c7d788.190a0220.3c2cf.5d7f@mx.google.com>
X-Google-Original-Message-ID: <ZMfXhFYDHKnqn7cX@akanner-r14.>
Date:   Mon, 31 Jul 2023 18:47:16 +0300
From:   Andrew Kanner <andrew.kanner@gmail.com>
To:     David Ahern <dsahern@gmail.com>
Cc:     Jesper Dangaard Brouer <jbrouer@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jason Wang <jasowang@redhat.com>, brouer@redhat.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH v3] drivers: net: prevent tun_get_user() to exceed xdp
 size limits
References: <20230725155403.796-1-andrew.kanner@gmail.com>
 <CACGkMEt=Cd8J995+0k=6MT1Pj=Fk9E_r2eZREptLt2osj_H-hA@mail.gmail.com>
 <ab722ec1-ae45-af1f-b869-e7339402c852@redhat.com>
 <179979e6-eb8a-0300-5445-999b9366250a@gmail.com>
 <0c06b067-349c-9fe2-2cc3-36c149fd5277@gmail.com>
 <CACGkMEsYzd1FphP-Ym9T9YjA9ZNBw7Mnw5xQ75dytQMJxDK3cg@mail.gmail.com>
 <220fc36ba1086c1390ba087d08561b61762c965a.camel@redhat.com>
 <3659ea35-8d03-aae7-53c0-09181bb1b69d@redhat.com>
 <64c30249.2e0a0220.f779a.1c31@mx.google.com>
 <cf1ef905-fa48-df3a-2d3c-37d7a1e79b8e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf1ef905-fa48-df3a-2d3c-37d7a1e79b8e@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 06:11:57PM -0600, David Ahern wrote:
> On 7/27/23 5:48 PM, Andrew Kanner wrote:
> > 
> > Thanks, everyone.
> > 
> > If we summarize the discussion - there are 3 issues here:
> > 1. tun_can_build_skb() doesn't count XDP_PACKET_HEADROOM (minor and
> >    most trivial)
> > 2. WARN_ON_ONCE from net/core/filter.c, which may be too strict / not
> >    needed at all.
> > 3. strange behaviour with reallocationg SKB (65007 -> 131072)
> 
> I believe that happens because of the current skb size and the need to
> expand it to account for the XDP headroom makes the allocation go over
> 64kB. Since tun is given the packet via a write call there are no header
> markers to allocate separate space for headers and data (e.g. like TCP
> does with 32kB data segments).


Yes, this is exactly what you suspected. In pskb_expand_head() ->
kmalloc_reserve() I have these values initially:
(gdb) p *size
$13 = 65408
(gdb) p obj_size
$16 = 65728

and it will do:
    data = kmalloc_reserve(&size, gfp_mask, NUMA_NO_NODE, NULL);
...
	obj_size = SKB_HEAD_ALIGN(*size);
...
	*size = obj_size = kmalloc_size_roundup(obj_size);

(gdb) p *size
$22 = 131072

So this is kmalloc_size_roundup() doing this math with the following:
   /* Above the smaller buckets, size is a multiple of page size. */                                                                                                                           │
   if (size > KMALLOC_MAX_CACHE_SIZE)                                                                                                                                                          │
      return PAGE_SIZE << get_order(size);

> > 
> > I can check these issues. I have to dive a little deeper with 2-3,
> > most likely with kgdb and syzkaller repro. But seems this is not
> > somewhat urgent and lives quite a long time without being noticed.
> > 
> > BTW: Attached the ftrace logs using the original syzkaller repro
> > (starting with tun_get_user()). They answer Jesper's question about
> > contiguous physical memory allocation (kmem_cache_alloc_node() /
> > kmalloc_reserve()). But I'll check it one more time before submitting
> > a new PATCH V4 or another patch / patch series.
> > 
> 

I see no other bugs in math, so not sure wether it should be fixed. Is
it ok and expected to roundup the memory allocation?


-- 
Andrew Kanner
