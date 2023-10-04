Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9877B83FF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243154AbjJDPqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbjJDPqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:46:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7A4C4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 08:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696434319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IxsazhYs2n/9MAXKA5npAthF91JV0rzqOS4I79VruDs=;
        b=iLYBplWljKc6T7vwfaR+mYnfVY2/asCCHii8FOnee2DklDagB+/C9w7jZQQYZaJXnFov6t
        VG7/A9jz3r7xkiZcFqa706FCgoJG/SpKzx5jnKiBA/noR6XcIckGpnA8ZHkPFe+sLTIQAZ
        LMZa92001qNF+Ry6EUYnoei0EO686Io=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-rX-ASqATNnie8_eE9DeCwA-1; Wed, 04 Oct 2023 11:45:12 -0400
X-MC-Unique: rX-ASqATNnie8_eE9DeCwA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-65afcf18d05so24386816d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 08:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696434312; x=1697039112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxsazhYs2n/9MAXKA5npAthF91JV0rzqOS4I79VruDs=;
        b=cwNWve5Q7nSalzgOuqQ0ROAbF3yKPh2sjSSXy1hVa9wuxTA38voCjlq9g7g8/46BE4
         DnTwiXBAztRxItkJurIsfXLUlQs9tqQgLxdtixpWVwRj8eCmIyNN9BYFCz+KxAlmzLVw
         UsR+SCH906iJJe51RhLdvWfOeNGoD9DH478aNcdYCgDuiThZQL06O3aD1tTItCNCB9FT
         yjXlZwZu+7k9I9HCq8g/sQx4RS6Zox0AnSI7cWf8EfOTIx/l77mJTgNaLuwvfoPfpSB3
         7nTmmgfZRSYgwsLDbbBtF3kyRqViJZp2EejdpZWK7cIKwrl+Cc+1K9f7f+an6CMpkteq
         0J4g==
X-Gm-Message-State: AOJu0YyvZ479JEFAGK6kNU9AH9o+8xkazA4MWW6j8SQpSuxspkBucBm6
        TdHraY+kuPs75fNExLlvC5wTqlgg467upe5XeBRa2PqEi34kfnXD0B9w6T6JQyFwxTPIYs8zjJU
        809qvfJTrXfb8pYSix//YV/wz
X-Received: by 2002:a0c:e20a:0:b0:65b:8a2:6b86 with SMTP id q10-20020a0ce20a000000b0065b08a26b86mr2448003qvl.59.1696434312459;
        Wed, 04 Oct 2023 08:45:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9JiqUasipY0BgL87SyW5GEOL9U/R/0xTXkbkmk6K2dh+lVGuHH2VfMxE94OR1d7VlhS5Teg==
X-Received: by 2002:a0c:e20a:0:b0:65b:8a2:6b86 with SMTP id q10-20020a0ce20a000000b0065b08a26b86mr2447984qvl.59.1696434312046;
        Wed, 04 Oct 2023 08:45:12 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-114.retail.telecomitalia.it. [82.57.51.114])
        by smtp.gmail.com with ESMTPSA id o3-20020a0ccb03000000b0064f4ac061b0sm1414263qvk.12.2023.10.04.08.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 08:45:11 -0700 (PDT)
Date:   Wed, 4 Oct 2023 17:45:06 +0200
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
        kernel@sberdevices.ru, oxffffaa@gmail.com
Subject: Re: [PATCH net-next v2 11/12] test/vsock: MSG_ZEROCOPY support for
 vsock_perf
Message-ID: <s5ofd3qomvc6dd7kyo675cyit6u4goehukoq5mkwa2hqsg3bzb@4v46dm7dpuye>
References: <20230930210308.2394919-1-avkrasnov@salutedevices.com>
 <20230930210308.2394919-12-avkrasnov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230930210308.2394919-12-avkrasnov@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 12:03:07AM +0300, Arseniy Krasnov wrote:
>To use this option pass '--zc' parameter:

--zerocopy would be better IMHO

>
>./vsock_perf --zc --sender <cid> --port <port> --bytes <bytes to send>
>
>With this option MSG_ZEROCOPY flag will be passed to the 'send()' call.
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> tools/testing/vsock/vsock_perf.c | 143 +++++++++++++++++++++++++++++--
> 1 file changed, 134 insertions(+), 9 deletions(-)
>
>diff --git a/tools/testing/vsock/vsock_perf.c b/tools/testing/vsock/vsock_perf.c
>index a72520338f84..f0f183f3f9e8 100644
>--- a/tools/testing/vsock/vsock_perf.c
>+++ b/tools/testing/vsock/vsock_perf.c
>@@ -18,6 +18,8 @@
> #include <poll.h>
> #include <sys/socket.h>
> #include <linux/vm_sockets.h>
>+#include <sys/mman.h>
>+#include <linux/errqueue.h>
>
> #define DEFAULT_BUF_SIZE_BYTES	(128 * 1024)
> #define DEFAULT_TO_SEND_BYTES	(64 * 1024)
>@@ -28,9 +30,18 @@
> #define BYTES_PER_GB		(1024 * 1024 * 1024ULL)
> #define NSEC_PER_SEC		(1000000000ULL)
>
>+#ifndef SOL_VSOCK
>+#define SOL_VSOCK	287
>+#endif
>+
>+#ifndef VSOCK_RECVERR
>+#define VSOCK_RECVERR	1
>+#endif
>+
> static unsigned int port = DEFAULT_PORT;
> static unsigned long buf_size_bytes = DEFAULT_BUF_SIZE_BYTES;
> static unsigned long vsock_buf_bytes = DEFAULT_VSOCK_BUF_BYTES;
>+static bool zerocopy;
>
> static void error(const char *s)
> {
>@@ -247,15 +258,76 @@ static void run_receiver(unsigned long rcvlowat_bytes)
> 	close(fd);
> }
>
>+static void recv_completion(int fd)
>+{
>+	struct sock_extended_err *serr;
>+	char cmsg_data[128];
>+	struct cmsghdr *cm;
>+	struct msghdr msg = { 0 };
>+	ssize_t ret;
>+
>+	msg.msg_control = cmsg_data;
>+	msg.msg_controllen = sizeof(cmsg_data);
>+
>+	ret = recvmsg(fd, &msg, MSG_ERRQUEUE);
>+	if (ret) {
>+		fprintf(stderr, "recvmsg: failed to read err: %zi\n", ret);
>+		return;
>+	}
>+
>+	cm = CMSG_FIRSTHDR(&msg);
>+	if (!cm) {
>+		fprintf(stderr, "cmsg: no cmsg\n");
>+		return;
>+	}
>+
>+	if (cm->cmsg_level != SOL_VSOCK) {
>+		fprintf(stderr, "cmsg: unexpected 'cmsg_level'\n");
>+		return;
>+	}
>+
>+	if (cm->cmsg_type != VSOCK_RECVERR) {
>+		fprintf(stderr, "cmsg: unexpected 'cmsg_type'\n");
>+		return;
>+	}
>+
>+	serr = (void *)CMSG_DATA(cm);
>+	if (serr->ee_origin != SO_EE_ORIGIN_ZEROCOPY) {
>+		fprintf(stderr, "serr: wrong origin\n");
>+		return;
>+	}
>+
>+	if (serr->ee_errno) {
>+		fprintf(stderr, "serr: wrong error code\n");
>+		return;
>+	}
>+
>+	if (zerocopy && (serr->ee_code & SO_EE_CODE_ZEROCOPY_COPIED))
>+		fprintf(stderr, "warning: copy instead of zerocopy\n");
>+}
>+
>+static void enable_so_zerocopy(int fd)
>+{
>+	int val = 1;
>+
>+	if (setsockopt(fd, SOL_SOCKET, SO_ZEROCOPY, &val, sizeof(val)))
>+		error("setsockopt(SO_ZEROCOPY)");
>+}

We use enable_so_zerocopy() in a single place, maybe we can put this
code there.

Anyway it seems we are copy & paste some codes from util, etc.

Would make sense create a new header to use on both tests and perf?


>+
> static void run_sender(int peer_cid, unsigned long to_send_bytes)
> {
> 	time_t tx_begin_ns;
> 	time_t tx_total_ns;
> 	size_t total_send;
>+	time_t time_in_send;
> 	void *data;
> 	int fd;
>
>-	printf("Run as sender\n");
>+	if (zerocopy)
>+		printf("Run as sender MSG_ZEROCOPY\n");
>+	else
>+		printf("Run as sender\n");
>+
> 	printf("Connect to %i:%u\n", peer_cid, port);
> 	printf("Send %lu bytes\n", to_send_bytes);
> 	printf("TX buffer %lu bytes\n", buf_size_bytes);
>@@ -265,38 +337,82 @@ static void run_sender(int peer_cid, unsigned long to_send_bytes)
> 	if (fd < 0)
> 		exit(EXIT_FAILURE);
>
>-	data = malloc(buf_size_bytes);
>+	if (zerocopy) {
>+		enable_so_zerocopy(fd);
>
>-	if (!data) {
>-		fprintf(stderr, "'malloc()' failed\n");
>-		exit(EXIT_FAILURE);
>+		data = mmap(NULL, buf_size_bytes, PROT_READ | PROT_WRITE,
>+			    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>+		if (data == MAP_FAILED) {
>+			perror("mmap");
>+			exit(EXIT_FAILURE);
>+		}
>+	} else {
>+		data = malloc(buf_size_bytes);
>+
>+		if (!data) {
>+			fprintf(stderr, "'malloc()' failed\n");
>+			exit(EXIT_FAILURE);
>+		}
> 	}
>
> 	memset(data, 0, buf_size_bytes);
> 	total_send = 0;
>+	time_in_send = 0;
> 	tx_begin_ns = current_nsec();
>
> 	while (total_send < to_send_bytes) {
> 		ssize_t sent;
>+		size_t rest_bytes;
>+		time_t before;
>
>-		sent = write(fd, data, buf_size_bytes);
>+		rest_bytes = to_send_bytes - total_send;
>+
>+		before = current_nsec();
>+		sent = send(fd, data, (rest_bytes > buf_size_bytes) ?
>+			    buf_size_bytes : rest_bytes,
>+			    zerocopy ? MSG_ZEROCOPY : 0);
>+		time_in_send += (current_nsec() - before);
>
> 		if (sent <= 0)
> 			error("write");
>
> 		total_send += sent;
>+
>+		if (zerocopy) {
>+			struct pollfd fds = { 0 };
>+
>+			fds.fd = fd;
>+
>+			if (poll(&fds, 1, -1) < 0) {
>+				perror("poll");
>+				exit(EXIT_FAILURE);
>+			}
>+
>+			if (!(fds.revents & POLLERR)) {
>+				fprintf(stderr, "POLLERR expected\n");
>+				exit(EXIT_FAILURE);
>+			}
>+
>+			recv_completion(fd);
>+		}
> 	}
>
> 	tx_total_ns = current_nsec() - tx_begin_ns;
>
> 	printf("total bytes sent: %zu\n", total_send);
> 	printf("tx performance: %f Gbits/s\n",
>-	       get_gbps(total_send * 8, tx_total_ns));
>-	printf("total time in 'write()': %f sec\n",
>+	       get_gbps(total_send * 8, time_in_send));
>+	printf("total time in tx loop: %f sec\n",
> 	       (float)tx_total_ns / NSEC_PER_SEC);
>+	printf("time in 'send()': %f sec\n",
>+	       (float)time_in_send / NSEC_PER_SEC);
>
> 	close(fd);
>-	free(data);
>+
>+	if (zerocopy)
>+		munmap(data, buf_size_bytes);
>+	else
>+		free(data);
> }
>
> static const char optstring[] = "";
>@@ -336,6 +452,11 @@ static const struct option longopts[] = {
> 		.has_arg = required_argument,
> 		.val = 'R',
> 	},
>+	{
>+		.name = "zc",
>+		.has_arg = no_argument,
>+		.val = 'Z',
>+	},
> 	{},
> };
>
>@@ -351,6 +472,7 @@ static void usage(void)
> 	       "  --help			This message\n"
> 	       "  --sender   <cid>		Sender mode (receiver default)\n"
> 	       "                                <cid> of the receiver to connect to\n"
>+	       "  --zc				Enable zerocopy\n"

Should we specify that this is used only in the sender?

> 	       "  --port     <port>		Port (default %d)\n"
> 	       "  --bytes    <bytes>KMG		Bytes to send (default %d)\n"
> 	       "  --buf-size <bytes>KMG		Data buffer size (default %d). In sender mode\n"
>@@ -413,6 +535,9 @@ int main(int argc, char **argv)
> 		case 'H': /* Help. */
> 			usage();
> 			break;
>+		case 'Z': /* Zerocopy. */
>+			zerocopy = true;
>+			break;
> 		default:
> 			usage();
> 		}
>-- 
>2.25.1
>

