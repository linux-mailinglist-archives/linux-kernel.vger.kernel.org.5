Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF697F4163
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbjKVJQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjKVJQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:16:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3752A10C4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700644584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FvqBK0UZREQjTEFtoe+8dwMEyfkRZhPHhHrOq6zH23k=;
        b=QxdhiCdX+e0UpV1YnY6TtkSow4lX4tk6dqXpuVpQEwF4jiY0B7v8eLSl4uhEIHcCJoHYRJ
        +k04dECEeNXJorWvZDjBhJ4zIBT/ha8l+s8SEJ5D8TMvKi4r2eOMTMr2Giz3zja8kkALPq
        JLDwCzkOhUtgeH+fKnwOjwQLmcz6aWA=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-H1jdkQM2PqeixPn-yxWUzA-1; Wed, 22 Nov 2023 04:16:22 -0500
X-MC-Unique: H1jdkQM2PqeixPn-yxWUzA-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-5c59fa94f72so96286097b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:16:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700644582; x=1701249382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvqBK0UZREQjTEFtoe+8dwMEyfkRZhPHhHrOq6zH23k=;
        b=gBkNsK/CVIjwybtJdq2UdlbRLCE2HHsYlLrTktEQv4cjJon+ijNAzjBDfJT9fA2RvG
         /VadXQH7uOdQ7qUxr7hMuGJesNqw47VJR1qWuaqwGv633UMMkccH9Y9Ji4P2RpvZ/AVP
         fyF5+f6Q/myS5OKd37dGwo1g9AoJ8DrQhRgKca9Hb9c9634rMrkMOaIRVuPZjpmDdYHK
         29yzNNW2+J/RBw9cMyxJJaO6FI0PAnXhCqG4sBPAkJvG0g77FSEs1USezdi/hZWbJNTP
         uHJ72dkMZhUZb/u8+mzMIx4lKEbMZxAX4L/Xz6rEF6+GzbV66yOfbGPB2V8ah5RFdQNT
         RbeQ==
X-Gm-Message-State: AOJu0YwXfxbF2rsaoO3bm95p1x5IrfyP6o1SOnZjMuPv1/M4gaA04zoE
        gdZIi6+iINNxJKkb3ujBXUg/i9n4q74S8gUF1sZL9m7YELYtt/6BV5//xIbByUlxfp7nrT8C5vi
        rxK3Htrg5blzPl/oIb60hs1Z4
X-Received: by 2002:a25:e812:0:b0:daf:81e5:d2fa with SMTP id k18-20020a25e812000000b00daf81e5d2famr1645687ybd.33.1700644582105;
        Wed, 22 Nov 2023 01:16:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgjChf8tYk5WRQhvlQx17JS9JtaEmIgWhz74vAPdVRs7d7DxN/bnfe4x0/ngk4fEhGpNP7Bw==
X-Received: by 2002:a25:e812:0:b0:daf:81e5:d2fa with SMTP id k18-20020a25e812000000b00daf81e5d2famr1645672ybd.33.1700644581817;
        Wed, 22 Nov 2023 01:16:21 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-199.retail.telecomitalia.it. [79.46.200.199])
        by smtp.gmail.com with ESMTPSA id qd24-20020ad44818000000b0065b21b232bfsm4711765qvb.138.2023.11.22.01.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 01:16:21 -0800 (PST)
Date:   Wed, 22 Nov 2023 10:16:14 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, oxffffaa@gmail.com,
        Bogdan Marcynkov <bmarcynk@redhat.com>
Subject: Re: [PATCH net v1] vsock/test: fix SEQPACKET message bounds test
Message-ID: <zoq32fkokk2ygtiabxgf74xu6vkfdynrlfzdqguh67qlogzd7j@qfd57sgudzpw>
References: <20231121211642.163474-1-avkrasnov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231121211642.163474-1-avkrasnov@salutedevices.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 12:16:42AM +0300, Arseniy Krasnov wrote:
>Tune message length calculation to make this test work on machines
>where 'getpagesize()' returns >32KB. Now maximum message length is not
>hardcoded (on machines above it was smaller than 'getpagesize()' return
>value, thus we get negative value and test fails), but calculated at
>runtime and always bigger than 'getpagesize()' result. Reproduced on
>aarch64 with 64KB page size.

It was reported to me by Bogdan, so we can add:

Reported-by: Bogdan Marcynkov <bmarcynk@redhat.com>

>
>Fixes: 5c338112e48a ("test/vsock: rework message bounds test")
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> tools/testing/vsock/vsock_test.c | 19 +++++++++++++------
> 1 file changed, 13 insertions(+), 6 deletions(-)

The fix LGTM and it worked on aarch64 machine.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks for the fast fix!
Stefano

>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index f5623b8d76b7..691e44c746bf 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -353,11 +353,12 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
> }
>
> #define SOCK_BUF_SIZE (2 * 1024 * 1024)
>-#define MAX_MSG_SIZE (32 * 1024)
>+#define MAX_MSG_PAGES 4
>
> static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
> {
> 	unsigned long curr_hash;
>+	size_t max_msg_size;
> 	int page_size;
> 	int msg_count;
> 	int fd;
>@@ -373,7 +374,8 @@ static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
>
> 	curr_hash = 0;
> 	page_size = getpagesize();
>-	msg_count = SOCK_BUF_SIZE / MAX_MSG_SIZE;
>+	max_msg_size = MAX_MSG_PAGES * page_size;
>+	msg_count = SOCK_BUF_SIZE / max_msg_size;
>
> 	for (int i = 0; i < msg_count; i++) {
> 		size_t buf_size;
>@@ -383,7 +385,7 @@ static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
> 		/* Use "small" buffers and "big" buffers. */
> 		if (i & 1)
> 			buf_size = page_size +
>-					(rand() % (MAX_MSG_SIZE - page_size));
>+					(rand() % (max_msg_size - page_size));
> 		else
> 			buf_size = 1 + (rand() % page_size);
>
>@@ -429,7 +431,6 @@ static void test_seqpacket_msg_bounds_server(const struct test_opts *opts)
> 	unsigned long remote_hash;
> 	unsigned long curr_hash;
> 	int fd;
>-	char buf[MAX_MSG_SIZE];
> 	struct msghdr msg = {0};
> 	struct iovec iov = {0};
>
>@@ -457,8 +458,13 @@ static void test_seqpacket_msg_bounds_server(const struct test_opts *opts)
> 	control_writeln("SRVREADY");
> 	/* Wait, until peer sends whole data. */
> 	control_expectln("SENDDONE");
>-	iov.iov_base = buf;
>-	iov.iov_len = sizeof(buf);
>+	iov.iov_len = MAX_MSG_PAGES * getpagesize();
>+	iov.iov_base = malloc(iov.iov_len);
>+	if (!iov.iov_base) {
>+		perror("malloc");
>+		exit(EXIT_FAILURE);
>+	}
>+
> 	msg.msg_iov = &iov;
> 	msg.msg_iovlen = 1;
>
>@@ -483,6 +489,7 @@ static void test_seqpacket_msg_bounds_server(const struct test_opts *opts)
> 		curr_hash += hash_djb2(msg.msg_iov[0].iov_base, recv_size);
> 	}
>
>+	free(iov.iov_base);
> 	close(fd);
> 	remote_hash = control_readulong();
>
>-- 
>2.25.1
>

