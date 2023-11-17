Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5123B7EF66B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 17:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346084AbjKQQof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 11:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjKQQoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 11:44:34 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048E0194
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 08:44:31 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-540c54944c4so4203852a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 08:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700239469; x=1700844269; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bs2wsPjA2JAN6w4n7okuC94+1cRA6FNJdtHsM2rFQKI=;
        b=VLLkxb6gCzwesX2dwgCAyPIsLGEpidUx9/aeMzKCBK0aN/+B2qqZcX/OvmNNfMv4jV
         Duln9iHewxfqZlyAMhvRuSoMaogV7l9kuLeNmtbxqZS0nB39tLGsWRgxCIfkUckwvgKI
         QZLaEtFL3DsehUkuUt0yMUcBAvl/KkbYzJUec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700239469; x=1700844269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bs2wsPjA2JAN6w4n7okuC94+1cRA6FNJdtHsM2rFQKI=;
        b=G40T3jINI7zticX5v2+K0XiBxRHeiL8SQsWoJ68vygqpRDh9BjcC2FU6pd7l7BNzUA
         gHerrojSn20HJqPuxEbxxEudcCN3mndFHXgqS8GBDPlVgOoL1P2oQ9L5Ej3e2EXOygyv
         GBUqVCwHV8Zms+oK6SV/BJkBPVMTD/BT61Q8RqNR1GN7XuoSBqZPQ+2r5RaIO9oLQRPQ
         YwZqQGmyf5mYV/JVw/3P5wCU5dPuIMY95uYnKBudODlt0cJ/kx/9bdMDsPIA85qSPkHC
         8ZVJk4cN7Se0cLuN3bN4nE5CsQOdaWx8FaKL1L5QlshG2AHd/18tgwY4Izywg9U7htAA
         DugQ==
X-Gm-Message-State: AOJu0Yypry50oyVUTcSgF85Eim90DwCTNNBJ9yhj1iZ0qZoMypICsg8k
        WCK2Sm2c7PlqMRYO9Pot/0IlN1yVOI9oPLznD08RQNDo
X-Google-Smtp-Source: AGHT+IGzW7VCOSYZD6TMaXYCGBeXggP7g/NSDfvKboTWHYjyz7yQR4j95Vh7CxNtLEQDpXVxmlJ0wQ==
X-Received: by 2002:a05:6402:5153:b0:540:911b:72b1 with SMTP id n19-20020a056402515300b00540911b72b1mr4795041edd.7.1700239469314;
        Fri, 17 Nov 2023 08:44:29 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id g9-20020aa7c589000000b005470cacc4bfsm889552edq.84.2023.11.17.08.44.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 08:44:28 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-9becde9ea7bso663664166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 08:44:28 -0800 (PST)
X-Received: by 2002:a17:906:24d0:b0:9f1:a725:54a6 with SMTP id
 f16-20020a17090624d000b009f1a72554a6mr5387650ejb.1.1700239468401; Fri, 17 Nov
 2023 08:44:28 -0800 (PST)
MIME-Version: 1.0
References: <20231116154406.GDZVY4xmFvRQt0wGGE@fat_crate.local>
 <202311061616.cd495695-oliver.sang@intel.com> <3865842.1700061614@warthog.procyon.org.uk>
 <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com>
 <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com>
 <CAHk-=wjhs6uuedgz-7HbcPtirEq+vvjJBY-M2zyteJwBhOMZhg@mail.gmail.com>
 <20231115190938.GGZVUXcuUjI3i1JRAB@fat_crate.local> <CAHk-=wh0TcXyGmKHfs+Xe=5Sd5bNn=NNV9CEtOy_tbyHAAmk9g@mail.gmail.com>
 <232440.1700153046@warthog.procyon.org.uk> <864270.1700230337@warthog.procyon.org.uk>
 <20231117160940.GGZVeQRLgLjJZXBLE1@fat_crate.local> <CAHk-=wj33FoGBQ7HkqjLbyOBQogWpYAG7WUTXatcfBF5duijjQ@mail.gmail.com>
In-Reply-To: <CAHk-=wj33FoGBQ7HkqjLbyOBQogWpYAG7WUTXatcfBF5duijjQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Nov 2023 11:44:10 -0500
X-Gmail-Original-Message-ID: <CAHk-=whLbJ7vvB1ACVC6t44zjihX8w7GMY2y584+Fm83rsmaKg@mail.gmail.com>
Message-ID: <CAHk-=whLbJ7vvB1ACVC6t44zjihX8w7GMY2y584+Fm83rsmaKg@mail.gmail.com>
Subject: Re: [linus:master] [iov_iter] c9eec08bac: vm-scalability.throughput
 -16.9% regression
To:     Borislav Petkov <bp@alien8.de>
Cc:     David Howells <dhowells@redhat.com>,
        kernel test robot <oliver.sang@intel.com>,
        oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        David Laight <David.Laight@aculab.com>, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2023 at 11:32, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The test case seems to be (from the profile) just a simple

Just to clarify: that's the test robot test case. David's test-case is
just the simple KUnit test.

> do_iter_readv_writev ->
>   shmem_file_write_iter ->
>     generic_perform_write ->
>       copy_page_from_iter_atomic ->
>         memcpy_from_iter_mc

.. and more details: this is *not* the actual normal "write()" path,
which would copy memory from user space, and that uses our
"copy_user()" function etc.

No, the path leading up to this seems to be

  worker_thread ->
    process_one_work ->
      loop_process_work ->
        lo_write_simple ->
         do_iter_write

which is why it uses a regular memcpy (ie it's a kernel buffer due to
loop block device).

So the test robot load is kind of odd.

Not that I think that David's KUnit test is necessarily much of a real
load either. so...

                  Linus
