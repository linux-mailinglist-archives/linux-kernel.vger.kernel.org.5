Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED57E7E1ED6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjKFKsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjKFKsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:48:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21A6DB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 02:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699267671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+lT38C9wjUtWACQaL07OufNUHAmzWCa7yzF7D6wde9Q=;
        b=Z79M21mbVpP6IPNYC/PpwN0spmJXRMk4MG+J/AFQpgt95FYNhVpIXlrXnUVBDavp+zbH+y
        aulo0WiaRyrWG0HV7FADmdg03vNjXSBhIEaI8QrL9tVoONhfivPYLWm6WVIH7zwu8Jdfes
        85VMkLVbbELDDAFsAgP+iQvCRmRz2Gs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-R62aBdLfNG2K59UfhIpFwA-1; Mon, 06 Nov 2023 05:47:43 -0500
X-MC-Unique: R62aBdLfNG2K59UfhIpFwA-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-41cdc542b56so51079791cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 02:47:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699267663; x=1699872463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lT38C9wjUtWACQaL07OufNUHAmzWCa7yzF7D6wde9Q=;
        b=tvN+uDLxyEzXZrYFN5ntYZch2jwdhyHPhErigmwyZoUnJugw5fLCgUgZ/EYbYJOA+o
         cswDZbLKC8TZtZkLdEddi9GkvCDeYi73SHBLvUBurAS1cbPkgG0EDpVCo1DK+K1+EKDl
         pmJvBg/js7S9CcgdIUeAr/F063nj0J+E0YvMd1a5ZUcLd9zjMvIEFrkkt4OTFggXyfCk
         16IvavW+LIZhesVfMwRO0EgHigYdz/KRP7SeWyVjyHf1DAmA7TTqoVNVuGPgqWx0skSw
         PsMLFKW2nSn3uvzccczbWse/PFEKU10Pqk7frmESnlr4TZWiCaKPC9oXbht5pGOQU9BS
         /2YQ==
X-Gm-Message-State: AOJu0YyWSov5X1feNm9X3+mvmrMEL3c+I3/NJO5/uG5biVehIZw3yYaX
        9m7UrStLmxQCmK5DbUbFCxPFB+C3dxfZyBiJbw51mzJGhYoYwpiTliVy6JkqBtkpVo6vnDm+jqb
        Bh7M5jL2J3VQhv5MHIHC600P8
X-Received: by 2002:ac8:58c9:0:b0:3fd:dab5:9430 with SMTP id u9-20020ac858c9000000b003fddab59430mr34239772qta.16.1699267663087;
        Mon, 06 Nov 2023 02:47:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjH5tsrv9EosQgCdf+Wk5X4APcmLon+ih9JbEw8zpkDnU51uS7si0Atvpc7KZve/mxRma74g==
X-Received: by 2002:ac8:58c9:0:b0:3fd:dab5:9430 with SMTP id u9-20020ac858c9000000b003fddab59430mr34239760qta.16.1699267662799;
        Mon, 06 Nov 2023 02:47:42 -0800 (PST)
Received: from sgarzare-redhat ([5.179.191.143])
        by smtp.gmail.com with ESMTPSA id b10-20020ac8678a000000b00410a9dd3d88sm3253917qtp.68.2023.11.06.02.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 02:47:42 -0800 (PST)
Date:   Mon, 6 Nov 2023 11:47:34 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     f.storniolo95@gmail.com
Cc:     luigi.leonardi@outlook.com, kvm@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, mst@redhat.com,
        imbrenda@linux.vnet.ibm.com, kuba@kernel.org, asias@redhat.com,
        stefanha@redhat.com, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH net 3/4] test/vsock: refactor vsock_accept
Message-ID: <l2ng7ukyxj5ykzznogyescuufalhfvx2cvrykpht6gqyjrfoy3@ib6dag5o2qik>
References: <20231103175551.41025-1-f.storniolo95@gmail.com>
 <20231103175551.41025-4-f.storniolo95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231103175551.41025-4-f.storniolo95@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 06:55:50PM +0100, f.storniolo95@gmail.com wrote:
>From: Filippo Storniolo <f.storniolo95@gmail.com>
>
>This is a preliminary patch to introduce SOCK_STREAM bind connect test.
>vsock_accept() is split into vsock_listen() and vsock_accept().
>
>Co-developed-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>Signed-off-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>Signed-off-by: Filippo Storniolo <f.storniolo95@gmail.com>
>---
> tools/testing/vsock/util.c | 32 ++++++++++++++++++++------------
> 1 file changed, 20 insertions(+), 12 deletions(-)

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 698b0b44a2ee..2fc96f29bdf2 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -136,11 +136,8 @@ int vsock_seqpacket_connect(unsigned int cid, unsigned int port)
> 	return vsock_connect(cid, port, SOCK_SEQPACKET);
> }
>
>-/* Listen on <cid, port> and return the first incoming connection.  The remote
>- * address is stored to clientaddrp.  clientaddrp may be NULL.
>- */
>-static int vsock_accept(unsigned int cid, unsigned int port,
>-			struct sockaddr_vm *clientaddrp, int type)
>+/* Listen on <cid, port> and return the file descriptor. */
>+static int vsock_listen(unsigned int cid, unsigned int port, int type)
> {
> 	union {
> 		struct sockaddr sa;
>@@ -152,14 +149,7 @@ static int vsock_accept(unsigned int cid, unsigned int port,
> 			.svm_cid = cid,
> 		},
> 	};
>-	union {
>-		struct sockaddr sa;
>-		struct sockaddr_vm svm;
>-	} clientaddr;
>-	socklen_t clientaddr_len = sizeof(clientaddr.svm);
> 	int fd;
>-	int client_fd;
>-	int old_errno;
>
> 	fd = socket(AF_VSOCK, type, 0);
> 	if (fd < 0) {
>@@ -177,6 +167,24 @@ static int vsock_accept(unsigned int cid, unsigned int port,
> 		exit(EXIT_FAILURE);
> 	}
>
>+	return fd;
>+}
>+
>+/* Listen on <cid, port> and return the first incoming connection.  The remote
>+ * address is stored to clientaddrp.  clientaddrp may be NULL.
>+ */
>+static int vsock_accept(unsigned int cid, unsigned int port,
>+			struct sockaddr_vm *clientaddrp, int type)
>+{
>+	union {
>+		struct sockaddr sa;
>+		struct sockaddr_vm svm;
>+	} clientaddr;
>+	socklen_t clientaddr_len = sizeof(clientaddr.svm);
>+	int fd, client_fd, old_errno;
>+
>+	fd = vsock_listen(cid, port, type);
>+
> 	control_writeln("LISTENING");
>
> 	timeout_begin(TIMEOUT);
>-- 
>2.41.0
>

