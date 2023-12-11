Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC13780D001
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344388AbjLKPrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344390AbjLKPrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:47:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E575E5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702309641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IZlJdJgXVbL3FV2sl0lv/ikQI4rT8wZ5WPDilRcK534=;
        b=LkpPJJibT57XZGLdJBzh/GeCy4g8XMaOUWWS+6pGbWbsX0YglDfV89Q2atPjWUJ6WjEP+G
        zCh2fIOPs/QqG08A63codUl0W8zfeQibD/PspU09OWpkb3IdNF6oApGLhgen+TuIegS/Po
        os3lYRkUEnmyDN3awPMcdO9CTC5ivxQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-xwMPJFlVOfysSur7VKMPFA-1; Mon, 11 Dec 2023 10:47:19 -0500
X-MC-Unique: xwMPJFlVOfysSur7VKMPFA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40c49cb08fcso5686255e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:47:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702309637; x=1702914437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZlJdJgXVbL3FV2sl0lv/ikQI4rT8wZ5WPDilRcK534=;
        b=X5aSeIBZqfaVRFE35Wuk8mgcrz7WRJpgFmEqu2xR5kSrtJrtDNliDa2H0EchUA5/+n
         pxRXdw/54y2IXqUXyxaoKb3WMDN9ThzuOoshcE5cRp7gBOyM3Q7zkpzW7SQMFrckyRYt
         /M6eKbDbMgVLmWv1heC6RDP3zm/C/WrAP0uCcTkAwVYCE3U4hTU5/TeBbMy+0Wcttpnl
         RVA/Fo0gRpJF+f89LB/wdQWznS9XzZGQHo+fDhqjN6X0oTtFyLH5RoSr14RX0carAQb3
         tY+PbEsRNaQO2zIRFeM0FajqWqQWvusX8bjaJuPCbfZO20vp/BlnEQLczRH0/ZN8gEPU
         Hy4Q==
X-Gm-Message-State: AOJu0YzB+Mi5Ou2LQs3a/cVNtwxLceZaOAkoH2zfCh3Wpc/lXTOVN7HM
        WBurJ/qu6Yl7s3kZRHpRQQyfVacmcHw4sin6zji4Eg1MjUd5+6Tb8Cazzj+sOz78CvQi86KQmNa
        Pe/L7GfSfYas1J0q08otvg/NR+vOm4nqz
X-Received: by 2002:a05:600c:1f08:b0:40c:3e98:5309 with SMTP id bd8-20020a05600c1f0800b0040c3e985309mr2116100wmb.98.1702309637338;
        Mon, 11 Dec 2023 07:47:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpH0te5s/Q1Xr8W7VeRGbO99gtL3UMDIEk2Fm7MvD8T4ecMB/fJcg5Sa0456ul8XolChfdVA==
X-Received: by 2002:a05:600c:1f08:b0:40c:3e98:5309 with SMTP id bd8-20020a05600c1f0800b0040c3e985309mr2116092wmb.98.1702309636881;
        Mon, 11 Dec 2023 07:47:16 -0800 (PST)
Received: from sgarzare-redhat ([78.209.43.40])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c450d00b00405c7591b09sm13401013wmo.35.2023.12.11.07.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 07:47:16 -0800 (PST)
Date:   Mon, 11 Dec 2023 16:45:09 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Nikolay Kuratov <kniv@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtualization@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH] vsock/virtio: Fix unsigned integer wrap around in
 virtio_transport_has_space()
Message-ID: <t6mnn7lyusvwt4knlxkgaajphhs6es5xr6hr7iixtwrfcljw67@foceocwkayk2>
References: <20231211142505.4076725-1-kniv@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231211142505.4076725-1-kniv@yandex-team.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 05:25:05PM +0300, Nikolay Kuratov wrote:
>We need to do signed arithmetic if we expect condition
>`if (bytes < 0)` to be possible
>
>Found by Linux Verification Center (linuxtesting.org) with SVACE
>

We should add:

Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")

>Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
>---
> net/vmw_vsock/virtio_transport_common.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index c8e162c9d1df..6df246b53260 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -843,7 +843,7 @@ static s64 virtio_transport_has_space(struct vsock_sock *vsk)
> 	struct virtio_vsock_sock *vvs = vsk->trans;
> 	s64 bytes;
>
>-	bytes = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
>+	bytes = (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);

If we respect the credit, this should not happen. It can happen, though,
that the receiver changes its buffer size while we're communicating,
and if it reduces it, this could happen. So yes, we need to fix it!

Thanks!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

> 	if (bytes < 0)
> 		bytes = 0;
>
>-- 
>2.34.1
>

