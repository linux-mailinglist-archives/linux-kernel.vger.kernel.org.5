Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678147E1EF0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjKFKwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKFKwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:52:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF84692
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 02:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699267880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sGKHksPd501hQHA9eLNxN+ry44710hoCv07MExLKHVs=;
        b=BiyZPznzXg0GrUBHq16b2wQh0ydbz9SoaKtgS8EHDBGK0S8L08LdyZofNkybf1hGgKLO5T
        RBkNoSwv2aUrlvejKgmRQVRBcCbh/pKMSr8vH03SyI5FqmWYA6X4Z6HSLx14jCUlN3yhma
        p3JQzlYCOJC2DS3uApGd3mjTgaQzOcs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-wt-yXXJmOUq5BZ134STsCw-1; Mon, 06 Nov 2023 05:50:52 -0500
X-MC-Unique: wt-yXXJmOUq5BZ134STsCw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7789f06778aso796189485a.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 02:50:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699267852; x=1699872652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGKHksPd501hQHA9eLNxN+ry44710hoCv07MExLKHVs=;
        b=ppKKoVUM5KC87n789WFizdQnIZHO+oBWyyotRaItvv1YWONFu26InA5gmqF/SqUMsc
         jk9oGzowccwXWIyizioIGgq1qtfAK3m+tZ9fIJ+XucbR8ulUEJallXtLxnzmljm9VsZ2
         u9NaM1a9J70b/qYZx6XR5TmaAMQNMTncQ9E9BwxXmQHy/M7yAJOti2VqXs3yZ0N8T245
         r7sMmZzWBHZ+HKl9MkhkIE8t/CzPpo5asvyXf3zzMNDV7SV9wSqco+1esMaXbGcVwgJz
         4w24o6hwmOTbKZG0jukp7nVZODHEmbrL9GBrEc36q4JC6bzMYmBJZ/525b1HLAheoNPo
         L8kg==
X-Gm-Message-State: AOJu0YyhN3GcVCnQNS+PfSwUfjMHTVQbb7tNiIYJigDnqVX9fPBhl9gg
        0AORepLVynGvabetujSGRL8FHAHh4/xtyYOy14b+4Zvs6yQ3etcPHUyjxqrRXLMCdhaB3sUL7Ay
        vImHNUVo9FRSWhFDRBoqY0jmo
X-Received: by 2002:a05:620a:4891:b0:774:21d8:b0bb with SMTP id ea17-20020a05620a489100b0077421d8b0bbmr12492217qkb.24.1699267852269;
        Mon, 06 Nov 2023 02:50:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJ0WMQS53FSstaaqoM5HU6Y+QSQp08ZUPiU8X5BKecLqp2Qc+R6PUnmsWzejkhzBiVviTEyQ==
X-Received: by 2002:a05:620a:4891:b0:774:21d8:b0bb with SMTP id ea17-20020a05620a489100b0077421d8b0bbmr12492204qkb.24.1699267852003;
        Mon, 06 Nov 2023 02:50:52 -0800 (PST)
Received: from sgarzare-redhat ([5.179.191.143])
        by smtp.gmail.com with ESMTPSA id a26-20020a05620a125a00b0077892023fc5sm3168522qkl.120.2023.11.06.02.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 02:50:51 -0800 (PST)
Date:   Mon, 6 Nov 2023 11:50:43 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     f.storniolo95@gmail.com
Cc:     luigi.leonardi@outlook.com, kvm@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, mst@redhat.com,
        imbrenda@linux.vnet.ibm.com, kuba@kernel.org, asias@redhat.com,
        stefanha@redhat.com, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH net 0/4] vsock: fix server prevents clients from
 reconnecting
Message-ID: <arbypnxtolin6jhz5wqguh4mnqlejtorgx5gvicwbuqdivjpds@lvitwxxfgy2g>
References: <20231103175551.41025-1-f.storniolo95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231103175551.41025-1-f.storniolo95@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 06:55:47PM +0100, f.storniolo95@gmail.com wrote:
>From: Filippo Storniolo <f.storniolo95@gmail.com>
>
>This patch series introduce fix and tests for the following vsock bug:
>If the same remote peer, using the same port, tries to connect
>to a server on a listening port more than once, the server will
>reject the connection, causing a "connection reset by peer"
>error on the remote peer. This is due to the presence of a
>dangling socket from a previous connection in both the connected
>and bound socket lists.
>The inconsistency of the above lists only occurs when the remote
>peer disconnects and the server remains active.
>This bug does not occur when the server socket is closed.
>
>More details on the first patch changelog.
>The remaining patches are refactoring and test.

Thanks for the fix and the test!

I only left a small comment in patch 2 which I don't think justifies a
v2 by itself though. If for some other reason you have to send a v2,
then maybe I would fix it.

I reviewed the series and ran the tests. Everything seems to be fine.

Thanks,
Stefano

