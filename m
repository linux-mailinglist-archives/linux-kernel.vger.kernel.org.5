Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F81276B5F6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbjHANfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbjHANfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:35:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3C21BDB
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 06:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690896855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m3EuGMRXqXwIjso57QFZOBRIJwj3UoGAkDVIx/t2tOw=;
        b=D59mTV0YKEZ4PpLT1uEJiMaDHuurSvw9p3DFqCYFwWteZgfmP11jnLPYr9NBEHtwIIWTfb
        g7uNHS8CrtgU4SL8iGJL59lKUDoEE4jhaMaD/7DF+YweH1L9yEPCrLZ5s5/fRIjge8zl3N
        2I9Zj2hZzOn9vc1wzEUJjKBXGt84n+I=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-DyZmtEynNgGN69zmrovrHA-1; Tue, 01 Aug 2023 09:34:11 -0400
X-MC-Unique: DyZmtEynNgGN69zmrovrHA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-76cb9958d60so35646785a.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 06:34:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690896851; x=1691501651;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m3EuGMRXqXwIjso57QFZOBRIJwj3UoGAkDVIx/t2tOw=;
        b=YLiQB39CYAJC5zViXqaXAccXwC/ANgH3K+gSzLyWdm+wZC0WJv6P0ba/FBrRs03gsd
         F5kowjxB7V+fpXHEsPwoz+Bj0+6ply66BedYtp/RpFwtLSSdBC3nncqRDe4yhu8c9JAp
         nf5UQAGttr3aD+7AgoetqwHVC1DAvJWS5e7035r8vbbEEXEiIfxS+NVPAkDyiLFs5ah/
         ehpilo8NMjhKL+mYCMmIOjJMHZuOdTbmTYU1m6Ge+7qDq0yoUBpV2iqY9PqpYH0tm+Zi
         zN05ItqLAYcddN4ZFRkMC4+AsQ4IOpsebHdc4HIFAoJ8qJ0YTO+CKZP+HnkOW9WAaCTs
         Ky5g==
X-Gm-Message-State: ABy/qLbLxp/WU1DKY7q+uVdlBkg8fxYwT+rjiJeCNGpCvk9S0aFMVYbr
        zH+NkU8ce4EX4YQloVUVdpJOXCebfRBAtayIjUOWQNFsskYbLHftCZyqd45/4yKCMnw1V9Axo1C
        c/j30lsjTBfoXSqollnIptslL
X-Received: by 2002:a05:620a:430a:b0:767:346c:4b37 with SMTP id u10-20020a05620a430a00b00767346c4b37mr11487672qko.7.1690896851429;
        Tue, 01 Aug 2023 06:34:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF2f6rViFVq6s9ZoHhoK5v+BjyA/rYc7oOn3EuiWdiJ1W4rbVP76VwVvUC5Ka+gXuoKt2VQqA==
X-Received: by 2002:a05:620a:430a:b0:767:346c:4b37 with SMTP id u10-20020a05620a430a00b00767346c4b37mr11487637qko.7.1690896851093;
        Tue, 01 Aug 2023 06:34:11 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-251.dyn.eolo.it. [146.241.225.251])
        by smtp.gmail.com with ESMTPSA id op51-20020a05620a537300b00767dc4c539bsm4136811qkn.44.2023.08.01.06.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 06:34:10 -0700 (PDT)
Message-ID: <8a7772a50a16fbbcb82fc0c5e09f9e31f3427e3d.camel@redhat.com>
Subject: Re: [PATCH net-next v5 4/4] vsock/virtio: MSG_ZEROCOPY flag support
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
Date:   Tue, 01 Aug 2023 15:34:07 +0200
In-Reply-To: <20230730085905.3420811-5-AVKrasnov@sberdevices.ru>
References: <20230730085905.3420811-1-AVKrasnov@sberdevices.ru>
         <20230730085905.3420811-5-AVKrasnov@sberdevices.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
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

On Sun, 2023-07-30 at 11:59 +0300, Arseniy Krasnov wrote:
> +static int virtio_transport_fill_skb(struct sk_buff *skb,
> +				     struct virtio_vsock_pkt_info *info,
> +				     size_t len,
> +				     bool zcopy)
> +{
> +	if (zcopy) {
> +		return __zerocopy_sg_from_iter(info->msg, NULL, skb,
> +					      &info->msg->msg_iter,
> +					      len);
> +	} else {


No need for an else statement after 'return'

> +		void *payload;
> +		int err;
> +
> +		payload =3D skb_put(skb, len);
> +		err =3D memcpy_from_msg(payload, info->msg, len);
> +		if (err)
> +			return -1;
> +
> +		if (msg_data_left(info->msg))
> +			return 0;
> +

This path does not update truesize, evem if it increases the skb len...

> +		return 0;
> +	}
> +}

[...]

> @@ -214,6 +251,70 @@ static u16 virtio_transport_get_type(struct sock *sk=
)
>  		return VIRTIO_VSOCK_TYPE_SEQPACKET;
>  }
> =20
> +static struct sk_buff *virtio_transport_alloc_skb(struct vsock_sock *vsk=
,
> +						  struct virtio_vsock_pkt_info *info,
> +						  size_t payload_len,
> +						  bool zcopy,
> +						  u32 src_cid,
> +						  u32 src_port,
> +						  u32 dst_cid,
> +						  u32 dst_port)
> +{
> +	struct sk_buff *skb;
> +	size_t skb_len;
> +
> +	skb_len =3D VIRTIO_VSOCK_SKB_HEADROOM;
> +
> +	if (!zcopy)
> +		skb_len +=3D payload_len;
> +
> +	skb =3D virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
> +	if (!skb)
> +		return NULL;
> +
> +	virtio_transport_init_hdr(skb, info, src_cid, src_port,
> +				  dst_cid, dst_port,
> +				  payload_len);
> +
> +	/* Set owner here, because '__zerocopy_sg_from_iter()' uses
> +	 * owner of skb without check to update 'sk_wmem_alloc'.
> +	 */
> +	if (vsk)
> +		skb_set_owner_w(skb, sk_vsock(vsk));

... which can lead to bad things(TM) if the skb goes trough some later
non trivial processing, due to the above skb_set_owner_w().

Additionally can be the following condition be true:

	vsk =3D=3D NULL && (info->msg && payload_len > 0) && zcopy

???

If so it looks like skb can go through __zerocopy_sg_from_iter() even
without a prior skb_set_owner_w()...


Cheers,

Paolo

