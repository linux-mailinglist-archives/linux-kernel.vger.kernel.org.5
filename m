Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F01975860E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 22:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjGRU2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 16:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjGRU2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 16:28:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4250EE2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 13:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689712060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UFzQVLD8HSP1RQHiTiX0erd1kVWah51g3weAFxDkVck=;
        b=KXoxZa1wvh6uJ1R9hnvVbn2hju6/1ONC4zjc+FGKcUEoqZ1A4WLc4zSLkvFP1Zm69KZYq1
        kNUBdeK13J2hqLWtGyu5NTl0/Peq5RiHVDD091Rom4LElPasKovh+7j5+WnnR0qKI6XOcK
        22kd38IUychA/d10pgrinDALOFZKROU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-lyB1uVNZN4-lahdNSS5IHA-1; Tue, 18 Jul 2023 16:27:39 -0400
X-MC-Unique: lyB1uVNZN4-lahdNSS5IHA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3143b277985so3853751f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 13:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689712058; x=1692304058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFzQVLD8HSP1RQHiTiX0erd1kVWah51g3weAFxDkVck=;
        b=kn7kBVq0zQdyg/juoigSu9mTSf+E6hNrqjA5Ly39QI5au7uV2si4MNAw5g1BKiHtId
         b4Zn+b5G6ePtDipwmV0LnhXI1rAFqDmwepnt6snko98LzHcUPHXHdkDAvWBpRGFcgBFq
         ZtyAdSVLb7jw1Hu28b0YkqCWguKWjIceiHy9/a26mKijtSsl3xApFCQj2iuQCXhF6Zq9
         15cQ2gphBePXZmf54dKEZs2gGwdFDyM3k9CKx8gsThryT+evsPf0TKjE5LteRsu+XBNc
         5frQkEFEPHFTpdL2agYlL8q+mqJPrMlsrUSaeqBqFGj/RitaMqwOwKUf44pLnBvxBvdk
         REXg==
X-Gm-Message-State: ABy/qLY7DuP+hmttX+9NVoBtYEP5mdPUbWl2w6igG6kZ3WsyhNuP51tt
        RGIN7fQsMmpcSrpRh8rhQHhXLgAOk9L2EZpPZvuwqGfBvjEN+09dXX/zrMdk1Rbs6QJvOHt86Mf
        iwhcPaDcHKWtnQLGvQUvR5F0J
X-Received: by 2002:adf:f045:0:b0:313:e591:94ec with SMTP id t5-20020adff045000000b00313e59194ecmr13934279wro.67.1689712058008;
        Tue, 18 Jul 2023 13:27:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHUSL09uGLyJ1DR1WqntoobKzn63+jF7HDSK0e6I01IxLEjjbrBzLog+jIdJvOcqhUNu9bHBQ==
X-Received: by 2002:adf:f045:0:b0:313:e591:94ec with SMTP id t5-20020adff045000000b00313e59194ecmr13934256wro.67.1689712057598;
        Tue, 18 Jul 2023 13:27:37 -0700 (PDT)
Received: from redhat.com ([2.52.16.41])
        by smtp.gmail.com with ESMTPSA id n13-20020adff08d000000b0031433443265sm3305560wro.53.2023.07.18.13.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 13:27:36 -0700 (PDT)
Date:   Tue, 18 Jul 2023 16:27:32 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, oxffffaa@gmail.com
Subject: Re: [PATCH net-next v2 2/4] vsock/virtio: support to send non-linear
 skb
Message-ID: <20230718162202-mutt-send-email-mst@kernel.org>
References: <20230718180237.3248179-1-AVKrasnov@sberdevices.ru>
 <20230718180237.3248179-3-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718180237.3248179-3-AVKrasnov@sberdevices.ru>
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

On Tue, Jul 18, 2023 at 09:02:35PM +0300, Arseniy Krasnov wrote:
> For non-linear skb use its pages from fragment array as buffers in
> virtio tx queue. These pages are already pinned by 'get_user_pages()'
> during such skb creation.
> 
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport.c | 40 +++++++++++++++++++++++++++-----
>  1 file changed, 34 insertions(+), 6 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index e95df847176b..6cbb45bb12d2 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -100,7 +100,9 @@ virtio_transport_send_pkt_work(struct work_struct *work)
>  	vq = vsock->vqs[VSOCK_VQ_TX];
>  
>  	for (;;) {
> -		struct scatterlist hdr, buf, *sgs[2];
> +		/* +1 is for packet header. */
> +		struct scatterlist *sgs[MAX_SKB_FRAGS + 1];
> +		struct scatterlist bufs[MAX_SKB_FRAGS + 1];
>  		int ret, in_sg = 0, out_sg = 0;
>  		struct sk_buff *skb;
>  		bool reply;
> @@ -111,12 +113,38 @@ virtio_transport_send_pkt_work(struct work_struct *work)
>  
>  		virtio_transport_deliver_tap_pkt(skb);
>  		reply = virtio_vsock_skb_reply(skb);
> +		sg_init_one(&bufs[out_sg], virtio_vsock_hdr(skb),
> +			    sizeof(*virtio_vsock_hdr(skb)));
> +		sgs[out_sg] = &bufs[out_sg];
> +		out_sg++;
> +
> +		if (!skb_is_nonlinear(skb)) {
> +			if (skb->len > 0) {
> +				sg_init_one(&bufs[out_sg], skb->data, skb->len);
> +				sgs[out_sg] = &bufs[out_sg];
> +				out_sg++;
> +			}
> +		} else {
> +			struct skb_shared_info *si;
> +			int i;
> +
> +			si = skb_shinfo(skb);
> +
> +			for (i = 0; i < si->nr_frags; i++) {
> +				skb_frag_t *skb_frag = &si->frags[i];
> +				void *va = page_to_virt(skb_frag->bv_page);
>  
> -		sg_init_one(&hdr, virtio_vsock_hdr(skb), sizeof(*virtio_vsock_hdr(skb)));
> -		sgs[out_sg++] = &hdr;
> -		if (skb->len > 0) {
> -			sg_init_one(&buf, skb->data, skb->len);
> -			sgs[out_sg++] = &buf;
> +				/* We will use 'page_to_virt()' for userspace page here,

don't put comments after code they refer to, please?

> +				 * because virtio layer will call 'virt_to_phys()' later

it will but not always. sometimes it's the dma mapping layer.


> +				 * to fill buffer descriptor. We don't touch memory at
> +				 * "virtual" address of this page.


you need to stick "the" in a bunch of places above.

> +				 */
> +				sg_init_one(&bufs[out_sg],
> +					    va + skb_frag->bv_offset,
> +					    skb_frag->bv_len);
> +				sgs[out_sg] = &bufs[out_sg];
> +				out_sg++;
> +			}
>  		}
>  
>  		ret = virtqueue_add_sgs(vq, sgs, out_sg, in_sg, skb, GFP_KERNEL);


There's a problem here: if there vq is small this will fail.
So you really should check free vq s/gs and switch to non-zcopy
if too small.

> -- 
> 2.25.1

