Return-Path: <linux-kernel+bounces-25977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AAA82D934
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1610D1C21819
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 12:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5902919;
	Mon, 15 Jan 2024 12:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1kxOL9p"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB789168CC
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 12:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705323300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OdOY5TfnFDP96uyidwJURkq+KNPlInJLGTZ9BVgWgNg=;
	b=S1kxOL9phfPMqkKNPWiasezZiIYkTJuL1l6n4Dd92FU+gCDCVQrdAZnl7c2Vi4KxYxSOfW
	Bq/cY1eP+mc+kGVkIEMskzK4hQOJ5qBVsmJ46lD3UV2I4DKzXpEcb526D0kW7HNKzBzTfk
	QGjDy8A1j9zNeJzkrnZBM5UzjYhrixI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-3Pu5cVGYNZmvZPw-3QFTRQ-1; Mon, 15 Jan 2024 07:54:59 -0500
X-MC-Unique: 3Pu5cVGYNZmvZPw-3QFTRQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-336c79d75aaso5349393f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 04:54:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705323298; x=1705928098;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OdOY5TfnFDP96uyidwJURkq+KNPlInJLGTZ9BVgWgNg=;
        b=mFyPLirgP1LS36u4skoC5MwXotRNW7o4IxNBrlty6GwkwPEkWccSgdIz9mpUNQFkP1
         b682X2ZKFitzQ3r7DbXGxbbFZJnxGGnyeFSjbTMreuy2lxcyO6QkHkKsMgkGAGm1w5Pn
         XIc2evB8JW5/If73g7foFEFIAdHBR7jJUaB/PQOnoPeiACLMaNjHVlqiuwU9LZ/gcpD1
         Z0BQnfYTOgKxKI4rutlzr3Fs4nl/1vgv/q+VWalCvD3TWoiQ76sN7kVcqVYEDcM3iCOY
         voLH+Pkj+h/3+8wr6SHFLBbbHp1HCmqwEpja/+Bt1tHiqfx2hBb7loKX8r6Z1YpMopgO
         /ogA==
X-Gm-Message-State: AOJu0YyvZPe7U2qcExU0hQo5tTLQu/ZQeUQNsKSWQbRUtnO4jq3RwFFs
	KQaj+67LC4JljsJZ//jy/fjtgbEYqW0zSTZo8CdAb/anG/bBo7dmPx1rmiPSPX6aqtu1g8f1oJs
	yiFAa7UHPUbYpKGY2q2xEyLMJR/69fmnl
X-Received: by 2002:a05:600c:211a:b0:40e:6ba4:e052 with SMTP id u26-20020a05600c211a00b0040e6ba4e052mr1896488wml.25.1705323298089;
        Mon, 15 Jan 2024 04:54:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzg0bntWWAcXtuHZuGROwZXvYdlmFhuKVULfmHMeQ1PrfepcSckBb2THm+UeIHVJ5SngMEHg==
X-Received: by 2002:a05:600c:211a:b0:40e:6ba4:e052 with SMTP id u26-20020a05600c211a00b0040e6ba4e052mr1896482wml.25.1705323297800;
        Mon, 15 Jan 2024 04:54:57 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g6-20020a05600c4ec600b0040e6b0a1bc1sm9160488wmq.12.2024.01.15.04.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 04:54:57 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, corbet@lwn.net
Cc: Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation/gpu: Reference articles on Linux graphics
 stack
In-Reply-To: <20240115113908.25897-1-tzimmermann@suse.de>
References: <20240115113908.25897-1-tzimmermann@suse.de>
Date: Mon, 15 Jan 2024 13:54:56 +0100
Message-ID: <87zfx6oixr.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Add two articles on LWN about the Linux graphics stack to DRM's
> list of external references. The articles document the graphics
> output as a whole, including the kernel side.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


