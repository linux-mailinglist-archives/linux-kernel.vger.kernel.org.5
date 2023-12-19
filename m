Return-Path: <linux-kernel+bounces-5816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28678818FDA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D34C21F22F1C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B66D37D1A;
	Tue, 19 Dec 2023 18:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VCFFYINl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0E438FB6
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 18:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703010991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v47UTmHzAdl2Nt8HKA6jp1il3Lpc0GyKxIVnJREGniE=;
	b=VCFFYINlSC8B9VqE5Pvedsb4Z376BYQtkxncEGEiuMJU7RAOC7cCLhOCQgkwFFSE6SXuO2
	mxQuxdvRucg3viWk0jIwSL+3EqFdRYV3f/mSwhERGCWgbcRERpZ0yMRjSGxejCApNGBDeS
	dr7G3IN2nqAFfoJNGkVyJbk932oA4II=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-wwEir8tAPEaPDOaic6mdcg-1; Tue, 19 Dec 2023 13:36:29 -0500
X-MC-Unique: wwEir8tAPEaPDOaic6mdcg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33671e1efadso626978f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 10:36:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703010988; x=1703615788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v47UTmHzAdl2Nt8HKA6jp1il3Lpc0GyKxIVnJREGniE=;
        b=s5BYRYyxr3HmZ0GsL0kaIu3Phq8qIYvCyjhPXmP4l76reB/qWuvENnPJrhdpcHoleX
         tmCJNIAXSfjUZiMiPFrC76Ar6hemBU7tsuY2nNBhlc6rDCQJdDWKXHiIR/II1kCwrewX
         NsUXJ0UeQ+ZznloyauhKRgJbf5QzqsbHSYKtbblYs6Hcu4htk+J/qKeKIdeb6RlkQLcQ
         p3F2AzKgvyDOhxayW976//sxYzZe0OzzHbGjP7TOWOFppj+sPoaAl1ULgs8iIfRK7Nvc
         KgX13C2R/Bdflqc9xCB/dTPAUsTwbAYKeACcLyL+aEUXHu5HvfFaGwmbYAa/Mt2k9HXn
         Y8Qg==
X-Gm-Message-State: AOJu0YxZyzOV9TWHliJh7rJK0Q/Fbpji9B502XQ2DmCCBpmZx/WkAOUg
	HxCknBRWW849QP4WK4qEr5RErCtL6cRu71IhjR4YwPz8Ddk4aJ+yF3sXmD0ZCG7BMtWztypc4CE
	97O3pJQafikbdiHPjtR0f9SI+
X-Received: by 2002:adf:fc43:0:b0:336:73ea:b831 with SMTP id e3-20020adffc43000000b0033673eab831mr846388wrs.50.1703010988642;
        Tue, 19 Dec 2023 10:36:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7ZDUfdCp8TeJng+VjBTvRf6OjZ70v7Qzcn/FZ5sz+Lbr05EsgZlGNV4j59UjFadCCiaJivQ==
X-Received: by 2002:adf:fc43:0:b0:336:73ea:b831 with SMTP id e3-20020adffc43000000b0033673eab831mr846375wrs.50.1703010988261;
        Tue, 19 Dec 2023 10:36:28 -0800 (PST)
Received: from redhat.com ([2.52.148.230])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d48d0000000b0033616ea5a0fsm26973853wrs.45.2023.12.19.10.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 10:36:26 -0800 (PST)
Date: Tue, 19 Dec 2023 13:36:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH RFC 1/4] virtio-net: support transmit hash report
Message-ID: <20231219133545-mutt-send-email-mst@kernel.org>
References: <20231218-v6-7-topic-virtio-net-ptp-v1-0-cac92b2d8532@pengutronix.de>
 <20231218-v6-7-topic-virtio-net-ptp-v1-1-cac92b2d8532@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218-v6-7-topic-virtio-net-ptp-v1-1-cac92b2d8532@pengutronix.de>

On Mon, Dec 18, 2023 at 12:37:08PM +0100, Steffen Trumtrar wrote:
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index cc65ef0f3c3e2..698a11f8c6ab9 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -56,6 +56,7 @@
>  #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
>  					 * Steering */
>  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
> +#define VIRTIO_NET_F_TX_HASH	  51	/* Driver sends hash report */
>  #define VIRTIO_NET_F_VQ_NOTF_COAL 52	/* Device supports virtqueue notification coalescing */
>  #define VIRTIO_NET_F_NOTF_COAL	53	/* Device supports notifications coalescing */
>  #define VIRTIO_NET_F_GUEST_USO4	54	/* Guest can handle USOv4 in. */


Please make sure to register the feature bit with virtio tc
to avoid collisions.

-- 
MST


