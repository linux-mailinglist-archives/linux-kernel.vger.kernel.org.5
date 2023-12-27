Return-Path: <linux-kernel+bounces-11945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C3B81EE08
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B56FB21FD2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 10:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FCC2CCD1;
	Wed, 27 Dec 2023 10:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQuiJLhV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0962C688
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 10:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703671580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vpvi0QuylzJT57z4Iry1XFcRTO36VgwNkYMSy6kylAQ=;
	b=jQuiJLhVeDlz2xfDFyT9fIcVGOhJ1/uX0Ejmm76mK/LIyFDiTUqWnVN7OWD570CWhHmaKC
	1fBpAY06BMcjOVzdyws5CY2Hy3MWM/6BZ1uIZ1caQvZ+pwfnn0h5MM3Xp0Xd1lTSiPQrZ9
	aS4z6yYqtZx/tR3WtDjAc2izAImx2+I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-pOKEYRKoNBK3hFObzlurnw-1; Wed, 27 Dec 2023 05:06:18 -0500
X-MC-Unique: pOKEYRKoNBK3hFObzlurnw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40d5ae4cdadso10889505e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 02:06:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703671577; x=1704276377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vpvi0QuylzJT57z4Iry1XFcRTO36VgwNkYMSy6kylAQ=;
        b=IrW67HBi4s/DZ2bfKYjbLpeLrZgeyHS9OYDw51mJzZHlw2I+DpSca53GNk7WzL/7ly
         1aWUQ2WzsQOfb7O/OjuQqrb69MVtmsrkLjNdUyCmrJKqMGtlyFGVxIZTHLnshjIBPJ+D
         bnL4cTuuOInO02mv714cseqUJk9IrJFs5bdVMzugmQWYDHpZr26/h7oVtCB2uiCHEeBM
         VjFDr/byec8vFpgDlumtx9ofDoIKXi9PfjYo75Ettxf5bVR+bRa4Mo087mnYadI9tLA5
         rAR2BwQGz0JEQIprrXNsp7O1VnjIcRjD1UewhBCvPCI94dO7bQwihkMfo2Tqa6oFlfMo
         PbdQ==
X-Gm-Message-State: AOJu0YwJyOIof0LnRY9oD9ITfpmnkdywfF3l0d+SsM0Raly5J8eaSajG
	tWxZOOJuoCgp7D495vDUMLK687hzBzXkbl7RzO1JTPNLcycMre9NUQiWxpTVOaVEY4j1Q4HzTG3
	b7st3dX1TrSW601eeNgLdBr2/T/2aXRnZ
X-Received: by 2002:a05:600c:3f94:b0:40d:5e3e:33af with SMTP id fs20-20020a05600c3f9400b0040d5e3e33afmr217829wmb.51.1703671577593;
        Wed, 27 Dec 2023 02:06:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5FpgrgHxxLBaIeXm7LTM0yLsMuN+g4thXte0aFhycFE23DDxpgalZv2U5QOQ/j0TgZHDoNg==
X-Received: by 2002:a05:600c:3f94:b0:40d:5e3e:33af with SMTP id fs20-20020a05600c3f9400b0040d5e3e33afmr217822wmb.51.1703671577203;
        Wed, 27 Dec 2023 02:06:17 -0800 (PST)
Received: from redhat.com ([2.55.177.189])
        by smtp.gmail.com with ESMTPSA id r19-20020a05600c459300b0040d128e9c62sm31122809wmo.18.2023.12.27.02.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 02:06:16 -0800 (PST)
Date: Wed, 27 Dec 2023 05:06:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li Feng <fengli@smartx.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Jason Wang <jasowang@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"open list:VIRTIO BLOCK AND SCSI DRIVERS" <virtualization@lists.linux.dev>
Subject: Re: [PATCH] virtio_blk: set the default scheduler to none
Message-ID: <20231227050544-mutt-send-email-mst@kernel.org>
References: <20231207043118.118158-1-fengli@smartx.com>
 <20231225092010-mutt-send-email-mst@kernel.org>
 <AB23804D-FF38-47B8-ADC6-C0A19B7083CC@smartx.com>
 <20231226103743-mutt-send-email-mst@kernel.org>
 <2E148FC5-F9A9-4A86-99F1-8D0B93412181@smartx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2E148FC5-F9A9-4A86-99F1-8D0B93412181@smartx.com>

On Wed, Dec 27, 2023 at 03:26:30PM +0800, Li Feng wrote:
> 
> 
> > On Dec 26, 2023, at 23:38, Michael S. Tsirkin <mst@redhat.com> wrote:
> > 
> > On Tue, Dec 26, 2023 at 05:01:40PM +0800, Li Feng wrote:
> >> I don't have ideas right now to answer Christoph/Paolo's question.
> > 
> > Paolo did some testing on this thread and posted some concerns.
> > Do you disagree with his analysis?
> 
> Paolo gave a very detailed data analysis. Indeed, in some low queue depth
> scenarios, the data dropped somewhat. However, I suspect that it may be 
> caused by other problems (such as test fluctuations) rather than the benefits 
> brought by deadline. 

Maybe. I think it would be up to you to prove this then.


> BTW, I think 128 queue depth test is a very important and common performance
> test item for storage devices.
> 
> Thanks,
> Li
> 
> > 
> > -- 
> > MST
> > 


