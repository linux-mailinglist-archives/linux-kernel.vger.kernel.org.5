Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE5F7DF3D0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 14:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376515AbjKBNbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 09:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjKBNbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 09:31:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC79196
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 06:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698931817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G4kaapn3liY1zTPGQnPDgzqDOBnuNLhFYbLOwMSHOTc=;
        b=BaYlqe7IXPgrfv5rbU8Qe3HxkWmqPFV4/2yl3qDstNdvySobMOfJjpzlwSk/23EBJ/Dv6N
        uwgXbEaocvU4F7w9W6hvTodQrql+cOKr5NJPO8TDxOwSmrgb5yNRzHXre8TzPs5vyubL2P
        ixzWczgcC5qql98ZZbMJlViM/kqUt1s=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-vmo8-sVLPd2zFG1vwrvImw-1; Thu, 02 Nov 2023 09:30:14 -0400
X-MC-Unique: vmo8-sVLPd2zFG1vwrvImw-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cc482cc026so8408835ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 06:30:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698931813; x=1699536613;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G4kaapn3liY1zTPGQnPDgzqDOBnuNLhFYbLOwMSHOTc=;
        b=MHA8crCdQ7DsWrknvFvc+6kkbvt0Ks/xkRywwIovUW+Pe0dU7QZbm4qKhnFYjmaZAP
         /UqxUE18pZtWgLbqUzJfW16q2WUz0SFmQvI2yX9PFx1DF60pPIezLYCLl7lKP5ZXlGRm
         uBKsB7dUSZ0mrE5HBCpBO+lgsdTO1YpWbC3JQycVqp2F2brjr6DlArxjuHxUYbT2h4BW
         Mc1IDrLB1Y0/OSV0l93TO2NOPgBFPqJ/fGSzoXTqyFHemPID8Mn2H1fwSwkBZXvhvdox
         EgH0bEwHlWQoDwbsjGXyrb5DJiBXiE96xKRAFGbJAaBv2ctxCKx+yzm3PCd7sU7GdGVe
         gKJg==
X-Gm-Message-State: AOJu0Yy+K7JfVLaXAqIGQhPTBgPlPiMbtGVJ8G4Z909H1TI3etnS0uB0
        ZNBHo/wu4OcA8o4N0jtLSOeyboZCfi86+UwGJ6pskH1su4X/wVkttbTJ1Hdx26KyH/YASvG+dLJ
        1FOQ0oUbAiM76M+qm22UVGOc3
X-Received: by 2002:a17:902:f943:b0:1cc:449b:689e with SMTP id kx3-20020a170902f94300b001cc449b689emr11958467plb.20.1698931813245;
        Thu, 02 Nov 2023 06:30:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpaf34EgGKqQhxqqvUP6ThPV7LvGkD3nyVPIKABjoFRGOKKdsCUmtWGPXXtO+YRCkk5SfLBA==
X-Received: by 2002:a17:902:f943:b0:1cc:449b:689e with SMTP id kx3-20020a170902f94300b001cc449b689emr11958445plb.20.1698931812829;
        Thu, 02 Nov 2023 06:30:12 -0700 (PDT)
Received: from localhost ([240d:1a:c0d:9f00:91ec:2f0b:ae2b:204a])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902ecc700b001c877f27d1fsm1940634plh.11.2023.11.02.06.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 06:30:12 -0700 (PDT)
Date:   Thu, 02 Nov 2023 22:30:08 +0900 (JST)
Message-Id: <20231102.223008.2284405204869772112.syoshida@redhat.com>
To:     kuba@kernel.org
Cc:     stefanha@redhat.com, sgarzare@redhat.com, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] virtio/vsock: Fix uninit-value in
 virtio_transport_recv_pkt()
From:   Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <20231101222045.5f7cca01@kernel.org>
References: <20231026150154.3536433-1-syoshida@redhat.com>
        <20231101222045.5f7cca01@kernel.org>
X-Mailer: Mew version 6.9 on Emacs 28.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2023 22:20:45 -0700, Jakub Kicinski wrote:
> On Fri, 27 Oct 2023 00:01:54 +0900 Shigeru Yoshida wrote:
>> This issue occurs because the `buf_alloc` and `fwd_cnt` fields of the
>> `struct virtio_vsock_hdr` are not initialized when a new skb is allocated
>> in `virtio_transport_alloc_skb()`. This patch resolves the issue by
>> initializing these fields during allocation.
> 
> We didn't manage to apply this before the merge window, and now the
> trees have converged. Patch no longer applies cleanly to net.
> Please rebase & repost.

I got it. I'll rebase the patch to the latest net tree and resend it.

Thanks,
Shigeru

