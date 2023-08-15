Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CB577D568
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 23:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237754AbjHOVyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 17:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234192AbjHOVyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 17:54:10 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D1B1FDC;
        Tue, 15 Aug 2023 14:54:09 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9e6cc93c6so89754991fa.2;
        Tue, 15 Aug 2023 14:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692136447; x=1692741247;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LfhTFBFD+coZbbCiyqisT8pgDWgt0Ruf6FqqRbZrcks=;
        b=gO/KiGK9zpsAReN8KrJ81zZT/QsErQ765zOciLoHYqk3Z8GfIVNQSAkpogMwWM5P7L
         y8+LQnGsFtXuVgI2fy6ixRobRCxP/p3O+6ChAqCbAaurGcfAdzgvLtKucjnaV2J6fYrS
         XVB18wRfTXhuiZznMP9sS/f9hGHT8FhKzEwEtps4O/IhRl4pxhD0NWzkcBj5yJS/69pU
         X3Mb23BrhWlr4axCH9kLOe2n+ny5xg5TUY7DYwq9OtCaEHSLeswS3NKTsbq4lc99T+pR
         GxRDS1mOlA+bQ86wZh3E4KRaf0NGpSeW4sHeKri449DSI9cxOxZIVad9kMvERrIPHEIp
         DJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692136447; x=1692741247;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LfhTFBFD+coZbbCiyqisT8pgDWgt0Ruf6FqqRbZrcks=;
        b=OkvDbsNAY3VmnKUYICypQYpmZm8KiGwjdBxqqFmDzJmBm8wDqwW2EX96Vj9NMtU97J
         fxx5FMa3VVDQtM66dxbGmBF2vLTXPZI1dZkITpevmxX5oMpkIEoiaMyZNEswDLix4Kyc
         0Ldtptzme/VPhIWt2WlGKv88zt5r+ZdrV4Fxsx2X4zDBjQHT/M8pJ45V3ScZ56aMjEr3
         Af6VVBxwuqOuygA9Ig8rDYGsZ/Y2HJQKW6e6UfxQTvNCEDOqugl46zr+lUn76ddygtqf
         yyxXYL0u/c4BeFUAkQJ1dBGd9IqAFjkBmKE6T4l1xCyMSeCcU7Ic1jmmwMEuAD+Axn96
         Yq2g==
X-Gm-Message-State: AOJu0YzCpXhzqUwHVs69nTfH9dZjw8ORXSqGOk3OSRJ+GAelqGUY8ks3
        4jFScqdgL7pSnN90YynrytU=
X-Google-Smtp-Source: AGHT+IFXdRxuTQrU9/2j8YfnrYlovGjEJE3xNWQpZ15vhLKkfvRDqPvJIM8Kqd0/P2/vByH6kHH1mg==
X-Received: by 2002:a05:651c:1204:b0:2b9:e7d7:64bd with SMTP id i4-20020a05651c120400b002b9e7d764bdmr17109lja.47.1692136447275;
        Tue, 15 Aug 2023 14:54:07 -0700 (PDT)
Received: from akanner-r14. ([77.222.24.45])
        by smtp.gmail.com with ESMTPSA id b13-20020a2e988d000000b002b9ebbe09d5sm3172450ljj.33.2023.08.15.14.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 14:54:05 -0700 (PDT)
Message-ID: <64dbf3fd.2e0a0220.a52a7.7b80@mx.google.com>
X-Google-Original-Message-ID: <ZNvz78n5/KInEfVV@akanner-r14.>
Date:   Wed, 16 Aug 2023 00:53:51 +0300
From:   Andrew Kanner <andrew.kanner@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, selinux@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] selinux: netlabel: Prevent KMSAN warning in
 selinux_inet_conn_request()
References: <20230815205917.1504837-1-andrew.kanner@gmail.com>
 <20230815205917.1504837-2-andrew.kanner@gmail.com>
 <2023081532-laundry-pull-87ed@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023081532-laundry-pull-87ed@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 11:11:57PM +0200, Greg KH wrote:
> On Tue, Aug 15, 2023 at 10:59:17PM +0200, Andrew Kanner wrote:
> > KMSAN reports the following issue:
> > [   81.822503] =====================================================
> > [   81.823222] BUG: KMSAN: uninit-value in selinux_inet_conn_request+0x2c8/0x4b0
> > [   81.823891]  selinux_inet_conn_request+0x2c8/0x4b0
> > [   81.824385]  security_inet_conn_request+0xc0/0x160
> > [   81.824886]  tcp_v4_route_req+0x30e/0x490
> > [   81.825343]  tcp_conn_request+0xdc8/0x3400
> > [   81.825813]  tcp_v4_conn_request+0x134/0x190
> > [   81.826292]  tcp_rcv_state_process+0x1f4/0x3b40
> > [   81.826797]  tcp_v4_do_rcv+0x9ca/0xc30
> > [   81.827236]  tcp_v4_rcv+0x3bf5/0x4180
> > [   81.827670]  ip_protocol_deliver_rcu+0x822/0x1230
> > [   81.828174]  ip_local_deliver_finish+0x259/0x370
> > [   81.828667]  ip_local_deliver+0x1c0/0x450
> > [   81.829105]  ip_sublist_rcv+0xdc1/0xf50
> > [   81.829534]  ip_list_rcv+0x72e/0x790
> > [   81.829941]  __netif_receive_skb_list_core+0x10d5/0x1180
> > [   81.830499]  netif_receive_skb_list_internal+0xc41/0x1190
> > [   81.831064]  napi_complete_done+0x2c4/0x8b0
> > [   81.831532]  e1000_clean+0x12bf/0x4d90
> > [   81.831983]  __napi_poll+0xa6/0x760
> > [   81.832391]  net_rx_action+0x84c/0x1550
> > [   81.832831]  __do_softirq+0x272/0xa6c
> > [   81.833239]  __irq_exit_rcu+0xb7/0x1a0
> > [   81.833654]  irq_exit_rcu+0x17/0x40
> > [   81.834044]  common_interrupt+0x8d/0xa0
> > [   81.834494]  asm_common_interrupt+0x2b/0x40
> > [   81.834949]  default_idle+0x17/0x20
> > [   81.835356]  arch_cpu_idle+0xd/0x20
> > [   81.835766]  default_idle_call+0x43/0x70
> > [   81.836210]  do_idle+0x258/0x800
> > [   81.836581]  cpu_startup_entry+0x26/0x30
> > [   81.837002]  __pfx_ap_starting+0x0/0x10
> > [   81.837444]  secondary_startup_64_no_verify+0x17a/0x17b
> > [   81.837979]
> > [   81.838166] Local variable nlbl_type.i created at:
> > [   81.838596]  selinux_inet_conn_request+0xe3/0x4b0
> > [   81.839078]  security_inet_conn_request+0xc0/0x160
> > 
> > KMSAN warning is reproducible with:
> > * netlabel_mgmt_protocount is 0 (e.g. netlbl_enabled() returns 0)
> > * CONFIG_SECURITY_NETWORK_XFRM may be set or not
> > * CONFIG_KMSAN=y
> > * `ssh USER@HOSTNAME /bin/date`
> > 
> > selinux_skb_peerlbl_sid() will call selinux_xfrm_skb_sid(), then fall
> > to selinux_netlbl_skbuff_getsid() which will not initialize nlbl_type,
> > but it will be passed to:
> > 
> >     err = security_net_peersid_resolve(nlbl_sid,
> >                                        nlbl_type, xfrm_sid, sid);
> > 
> > and checked by KMSAN, although it will not be used inside
> > security_net_peersid_resolve() (at least now), since this function
> > will check either (xfrm_sid == SECSID_NULL) or (nlbl_sid ==
> > SECSID_NULL) first and return before using uninitialized nlbl_type.
> > 
> > Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>
> > ---
> >  security/selinux/netlabel.c | 1 +
> >  1 file changed, 1 insertion(+)
> 
> What git commit id does this fix?  Does it also need to go to older
> kernels?  If so, how far back?
> 
> thanks,
> 
> greg k-h

Thanks, Greg. I mentioned it in the cover letter only because I'm not
sure, it seems to be:

Fixes: 220deb966ea5 ("SELinux: Better integration between peer labeling subsystems")

which is ~v2.6.24, I believe. I wish I could use KMSAN there -)

But I checked - this uninit var will not be used on 220deb966ea5 and
the function will return earlier as well. As far as I see this is just
a KMSAN warning for the uninitialized function argument.

PS: maybe we should check if KMSAN is be able to check the possible
usage of such uninit arguments.

-- 
Andrew Kanner
