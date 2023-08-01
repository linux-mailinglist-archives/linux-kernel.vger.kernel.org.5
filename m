Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2B676B593
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbjHANMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbjHANMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:12:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB31910E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 06:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690895505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LZPGMYFD95A8uiN976D445h5APBCC9ED+naAIlPhoHg=;
        b=hQ43lxZM6cRkz5ax2FAraNWDTLtHI/uSXqINPLLxNri/hmr9PIDattAmS7Ciucsks6I+OU
        RBONoOf+O6Jxiru3HnhuylpbaGS0zMmHfa1od4v8mxbBEgjhhOB/cMz/ydqtH39GoTCvPy
        tV/dB3ixJOfCe4M+01zguZawhcZeaCo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-AwFN4NFNPSG_p-vslpNHeA-1; Tue, 01 Aug 2023 09:11:43 -0400
X-MC-Unique: AwFN4NFNPSG_p-vslpNHeA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-76c8e07cbe9so98328185a.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 06:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690895503; x=1691500303;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LZPGMYFD95A8uiN976D445h5APBCC9ED+naAIlPhoHg=;
        b=iAFtHvEo/lmWXARp8/e9v1dz+Hoe7aRXve2l1HHd9Oyx/kqHUgx02+Doz5gJRBj/rF
         hryrN6c9WqxQGzWrqpnRTqkxM9rf1GnW9LmCq3xOUmHG58tM936AaGy/rAFk23r9xa3z
         akqjbKKRhXhq1JiH5A0XkV29drk8ITAZZ4pbNvyIbTpNX+ZA4mH9EdjFjzr9TWxS+Fk7
         1gebt6RTDAk19XS65SQOojsucxy+0LLI636TU3yiaCDj+w9XV/x5v6ssKpHOA9NDdibr
         D05hsfhqiV7mtranq5b/WnGMXi5i0sl+qE3lqsFD4cf9UHxKFMoZyljqPjs+k+NBjwhj
         7JpA==
X-Gm-Message-State: ABy/qLZdXPs4LckciZg2xkpT6ZUAliPCNWL96zSV7mcoHutCnl3MCC65
        Ohj2ajuc5EQtGlgVLxdKK6kymiGdWYjqZrL95dA76fLdijQE2OOducUZllUyEyRgFtZY9QyMctC
        /Ci2ct5fk89NHOY+M9uBgxjYk
X-Received: by 2002:a05:620a:1a11:b0:767:a7c1:e776 with SMTP id bk17-20020a05620a1a1100b00767a7c1e776mr11186397qkb.2.1690895503109;
        Tue, 01 Aug 2023 06:11:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF4WPKBYnm5c1SYuFP+zCzJTJpn6DkKmUmEfzMFnNuT7F0grWUkB9zMAi1HQjUppRuuFnBO+g==
X-Received: by 2002:a05:620a:1a11:b0:767:a7c1:e776 with SMTP id bk17-20020a05620a1a1100b00767a7c1e776mr11186374qkb.2.1690895502779;
        Tue, 01 Aug 2023 06:11:42 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-251.dyn.eolo.it. [146.241.225.251])
        by smtp.gmail.com with ESMTPSA id j27-20020a05620a001b00b00767d05117fesm4127068qki.36.2023.08.01.06.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 06:11:42 -0700 (PDT)
Message-ID: <8972ac7df2298d47e1b2f53b7f1b5d5941999580.camel@redhat.com>
Subject: Re: [PATCH net-next v5 1/4] vsock/virtio/vhost: read data from
 non-linear skb
From:   Paolo Abeni <pabeni@redhat.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, oxffffaa@gmail.com
Date:   Tue, 01 Aug 2023 15:11:38 +0200
In-Reply-To: <20230730085905.3420811-2-AVKrasnov@sberdevices.ru>
References: <20230730085905.3420811-1-AVKrasnov@sberdevices.ru>
         <20230730085905.3420811-2-AVKrasnov@sberdevices.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-07-30 at 11:59 +0300, Arseniy Krasnov wrote:
> This is preparation patch for MSG_ZEROCOPY support. It adds handling of
> non-linear skbs by replacing direct calls of 'memcpy_to_msg()' with
> 'skb_copy_datagram_iter()'. Main advantage of the second one is that it
> can handle paged part of the skb by using 'kmap()' on each page, but if
> there are no pages in the skb, it behaves like simple copying to iov
> iterator. This patch also adds new field to the control block of skb -
> this value shows current offset in the skb to read next portion of data
> (it doesn't matter linear it or not). Idea behind this field is that
> 'skb_copy_datagram_iter()' handles both types of skb internally - it
> just needs an offset from which to copy data from the given skb. This
> offset is incremented on each read from skb. This approach allows to
> avoid special handling of non-linear skbs:
> 1) We can't call 'skb_pull()' on it, because it updates 'data' pointer.
> 2) We need to update 'data_len' also on each read from this skb.

It looks like the above sentence is a left-over from previous version
as, as this patch does not touch data_len. And I think it contradicts
the previous one, so it's a bit confusing.

> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> ---
>  Changelog:
>  v5(big patchset) -> v1:
>   * Merge 'virtio_transport_common.c' and 'vhost/vsock.c' patches into
>     this single patch.
>   * Commit message update: grammar fix and remark that this patch is
>     MSG_ZEROCOPY preparation.
>   * Use 'min_t()' instead of comparison using '<>' operators.
>  v1 -> v2:
>   * R-b tag added.
>  v3 -> v4:
>   * R-b tag removed due to rebase:
>     * Part for 'virtio_transport_stream_do_peek()' is changed.
>     * Part for 'virtio_transport_seqpacket_do_peek()' is added.
>   * Comments about sleep in 'memcpy_to_msg()' now describe sleep in
>     'skb_copy_datagram_iter()'.
>=20
>  drivers/vhost/vsock.c                   | 14 +++++++----
>  include/linux/virtio_vsock.h            |  1 +
>  net/vmw_vsock/virtio_transport_common.c | 32 +++++++++++++++----------
>  3 files changed, 29 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 817d377a3f36..8c917be32b5d 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -114,6 +114,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock=
,
>  		struct sk_buff *skb;
>  		unsigned out, in;
>  		size_t nbytes;
> +		u32 frag_off;

IMHO 'offset' would be a better name for both the variable and the CB
field, as it can points both inside the skb frags, linear part or frag
list.

Otherwise LGTM, thanks!

Paolo

