Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB2177D5E2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 00:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239867AbjHOWXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 18:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239712AbjHOWXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 18:23:23 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B038C8E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 15:23:22 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-40ff82320a7so35944331cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 15:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1692138202; x=1692743002;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tyzHvqt/O1qXa0HQAGqgxNPglsQl/X9MXbsPGoB9vE8=;
        b=Q4KzTE7zaQXU/UXWdhs8xDFufSSHfiZ7ay9WXlAqA8digXod/dvvx6oGP6TtMPpqAQ
         PXOesJyk2OZt65gUeUecuXHZZE4RzNsPZGx9+Q/NxeDdoP8oM17aVxg7DA1A3NVj+fPy
         iGUoInu20QrCslCOPuy2TQyZSvN9cwXandZVL5CMRlYjBvrAcTGtUC9II/t0nLG+jhXF
         ZOF/Ntr7VKW4hWGH1Rd7pnRHQh4VYGjQU/glYVmOgV6bMNXQrNQ0McrAtcw2Yc+OM8zj
         rXG3t8lzTphJ2DZYePzXxN09gM5ratUG711FxkO6Is+NztqyvVfEInZKMJBq0jtu8I33
         18gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692138202; x=1692743002;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tyzHvqt/O1qXa0HQAGqgxNPglsQl/X9MXbsPGoB9vE8=;
        b=Oeo/Pqml2ukpObalackp97uq44u6k5wYfk4RtDHb2aZ8mKWE6jIYs25491aOgxoPpG
         +zuZ6RQ5Y5t8Ivc0bAO8796uugIbwilqS3lYPoes6YU2mByZClI/okzWswoRE6g07N02
         x1OmzBJzyoICiSIS9uiut4gCofNIvH0L3cbgGMdpklIbNXE/iyvDOezFImULQjBooiGr
         CnN9p1Q6pBYy1L1fNfy42rObWMgWZJvv2kDOmiZ87T8AxUWiOi8QxWMU+Qjx9W9ev15a
         +XNfrF6f+KUQ0onwIeOrcj/5erSaAw7yke77m7vX6KRjxRDix1kX2XFnOp8TF/fxknXj
         I54g==
X-Gm-Message-State: AOJu0YzTxJ4oIhp42W3rNFM9nvTuCAofmHUPaVE2zuMT76pyTlcrMoAp
        5C4X2y+iZWZedHgXAoMLKefi5tuEVS3237JSBhEt
X-Google-Smtp-Source: AGHT+IGak8gkevu1zmCY4EqpMWn/4mxG8srhxNngxPSkezkbgmp9NNMJg+aBUYuLoxEapxl19D+MzQ==
X-Received: by 2002:a0c:f345:0:b0:647:395c:8df9 with SMTP id e5-20020a0cf345000000b00647395c8df9mr85364qvm.46.1692138201834;
        Tue, 15 Aug 2023 15:23:21 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id t8-20020a05620a034800b007671cfe8a18sm4034501qkm.13.2023.08.15.15.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 15:23:21 -0700 (PDT)
Date:   Tue, 15 Aug 2023 18:23:21 -0400
Message-ID: <275c49e32b8a98dee1907c3a828cd079.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Andrew Kanner <andrew.kanner@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        selinux@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] selinux: netlabel: Prevent KMSAN warning in  selinux_inet_conn_request()
References: <20230815205917.1504837-2-andrew.kanner@gmail.com>
In-Reply-To: <20230815205917.1504837-2-andrew.kanner@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 15, 2023 Andrew Kanner <andrew.kanner@gmail.com> wrote:
> 
> KMSAN reports the following issue:
> [   81.822503] =====================================================
> [   81.823222] BUG: KMSAN: uninit-value in selinux_inet_conn_request+0x2c8/0x4b0
> [   81.823891]  selinux_inet_conn_request+0x2c8/0x4b0
> [   81.824385]  security_inet_conn_request+0xc0/0x160
> [   81.824886]  tcp_v4_route_req+0x30e/0x490
> [   81.825343]  tcp_conn_request+0xdc8/0x3400
> [   81.825813]  tcp_v4_conn_request+0x134/0x190
> [   81.826292]  tcp_rcv_state_process+0x1f4/0x3b40
> [   81.826797]  tcp_v4_do_rcv+0x9ca/0xc30
> [   81.827236]  tcp_v4_rcv+0x3bf5/0x4180
> [   81.827670]  ip_protocol_deliver_rcu+0x822/0x1230
> [   81.828174]  ip_local_deliver_finish+0x259/0x370
> [   81.828667]  ip_local_deliver+0x1c0/0x450
> [   81.829105]  ip_sublist_rcv+0xdc1/0xf50
> [   81.829534]  ip_list_rcv+0x72e/0x790
> [   81.829941]  __netif_receive_skb_list_core+0x10d5/0x1180
> [   81.830499]  netif_receive_skb_list_internal+0xc41/0x1190
> [   81.831064]  napi_complete_done+0x2c4/0x8b0
> [   81.831532]  e1000_clean+0x12bf/0x4d90
> [   81.831983]  __napi_poll+0xa6/0x760
> [   81.832391]  net_rx_action+0x84c/0x1550
> [   81.832831]  __do_softirq+0x272/0xa6c
> [   81.833239]  __irq_exit_rcu+0xb7/0x1a0
> [   81.833654]  irq_exit_rcu+0x17/0x40
> [   81.834044]  common_interrupt+0x8d/0xa0
> [   81.834494]  asm_common_interrupt+0x2b/0x40
> [   81.834949]  default_idle+0x17/0x20
> [   81.835356]  arch_cpu_idle+0xd/0x20
> [   81.835766]  default_idle_call+0x43/0x70
> [   81.836210]  do_idle+0x258/0x800
> [   81.836581]  cpu_startup_entry+0x26/0x30
> [   81.837002]  __pfx_ap_starting+0x0/0x10
> [   81.837444]  secondary_startup_64_no_verify+0x17a/0x17b
> [   81.837979]
> [   81.838166] Local variable nlbl_type.i created at:
> [   81.838596]  selinux_inet_conn_request+0xe3/0x4b0
> [   81.839078]  security_inet_conn_request+0xc0/0x160
> 
> KMSAN warning is reproducible with:
> * netlabel_mgmt_protocount is 0 (e.g. netlbl_enabled() returns 0)
> * CONFIG_SECURITY_NETWORK_XFRM may be set or not
> * CONFIG_KMSAN=y
> * `ssh USER@HOSTNAME /bin/date`
> 
> selinux_skb_peerlbl_sid() will call selinux_xfrm_skb_sid(), then fall
> to selinux_netlbl_skbuff_getsid() which will not initialize nlbl_type,
> but it will be passed to:
> 
>     err = security_net_peersid_resolve(nlbl_sid,
>                                        nlbl_type, xfrm_sid, sid);
> 
> and checked by KMSAN, although it will not be used inside
> security_net_peersid_resolve() (at least now), since this function
> will check either (xfrm_sid == SECSID_NULL) or (nlbl_sid ==
> SECSID_NULL) first and return before using uninitialized nlbl_type.
> 
> Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>
> Fixes: 220deb966ea5 ("SELinux: Better integration between peer labeling subsystems")
> ---
>  security/selinux/netlabel.c | 1 +
>  1 file changed, 1 insertion(+)

Thanks Andrew.  I'm going to drop the "Fixes" tag as the current code
isn't broken, as you mention in the commit description above, however,
I think this change is still worthwhile so I'm going to go ahead and
merge it into selinux/next.

--
paul-moore.com
