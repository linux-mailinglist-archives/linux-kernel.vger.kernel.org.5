Return-Path: <linux-kernel+bounces-131317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C323F898633
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8DE1F28CDB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4044C8565A;
	Thu,  4 Apr 2024 11:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BzpYfce4"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC9D71B47
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 11:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712230893; cv=none; b=lMQ9TnjGH5xTbbMvdH4OIp3NdfvaDLxTnDpo7IgqfTmQ7o2l/noeZSh86NOAQ+weEeNkbXexUFO9mm4otMbkr4Zjqjrj8pLbBXSPU/1snQHtd9WgwHH3GSbNZncQvVbV7Dh8s0wSevo+EF7UsGZBZlatrmLxZBQE4MRuRmVpYrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712230893; c=relaxed/simple;
	bh=xTu/IdCn/048THaVHddyM991QlKheudeHaOzDUEba/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CbnfdACCpKM7Uc4gFzSIuRFwmKigKjPc5Isqa3rKxlnO63rflNgyWp4oa0Igwxjgy2oh4JUrhAaah0aW3A+CPVh9rXkfOvXd7DPrtRkicJR4IW2sgEQ52w1orcJR64JjxayzrJEsSVFNY9/+GTeLqwau8Gxc92lTxEoXyw1GGzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BzpYfce4; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dcc80d6004bso1019450276.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 04:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712230889; x=1712835689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTu/IdCn/048THaVHddyM991QlKheudeHaOzDUEba/4=;
        b=BzpYfce4q/zv0gCorIvWLSXuzW4HjLtqKmXuLtELMIG7pv5Gw5rD2es8aCVqQFqD//
         8JggHBzNznjWgNLq2nD9WBWW0NsYaidmHqnL2ihAYJpv7o5gc1VJY6DJ0clWC7aekflL
         okxkVaJGNSO0qVH2yOxsFJLCq+7hYpnwhkr7HgXgiRTKZmRNaOv51pSZ+2EvNJ7l32Ax
         3rV1o60Rwqf7/3WoHSX+9OLMYTDALVEnxQwPAvQSTwkL+2+b5q+pMv+fOiTCP+zwNcc+
         ViJk4rxb2Vw07nE8VHUP+XT2krjKR9JIgTGsriDdaif1hRFImGjHsjVSH1La3PcFbNJH
         hkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712230889; x=1712835689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTu/IdCn/048THaVHddyM991QlKheudeHaOzDUEba/4=;
        b=HePJMfU68vxpJjHQGOLcX8a9nAWtvUv9uoMmtAzDFRUClchk+atouvEmtkc7EY5zB5
         qHzVLifctcITE6Vk6JmkuN3OpD6D6VgoGaBsb3rhHLQ+ziYcn7SfD/ZR0VQzRBq5ClHZ
         zG3LsI+9ZU5wt60H2eDt6RvZfDB12SceKSR1cxaf0oZUkD+sSFu0lNlxNpKiPu9xmqZG
         qe4HTY7v2XDduZNMmufHEiGyikdqeIgVzZxxy+PhtUuhvA4nHwtslTBHMlIQvPmsWs8Z
         0XzP8dWBQgqnHwzZSsR0XDFzx24h1HPxrt8bNqTeoZzYfmwITk4aiOmfeMnjLprXhabD
         BEFA==
X-Forwarded-Encrypted: i=1; AJvYcCXUkUlGXb7KIt1X3if2M7WdcGDuSJRJnE0/2mxoMVm42gH9H0fCze7QclImat9+Yl6Lnkn8LZqb5PB7sVTwNfet/Kp1WP4/S/jz7ZLh
X-Gm-Message-State: AOJu0Ywe++5gQ++DU7Om2cnjbLaXkfx0CaLnsr8FqYlz0yhlwQU648Rv
	T8NaOk3MNCoblTYzWogQ0OfCyUKhsNf8g2mXBfA2JLOnvAWV4PuerNOsdE35zG2Bd/hthPV4B9f
	7DjIVJXAebMVyqFVPFSrBQ91X62nBPpDdunxy5Q==
X-Google-Smtp-Source: AGHT+IEhL+O4bSIOCRsSy+Vdywn61xtrVBJ3li47sHwN1FOt8H7g9W+tj2/Or7rao9/9euGeRsXbtXq4vPMz7+GnZRc=
X-Received: by 2002:a25:ba86:0:b0:dd1:6fab:81e4 with SMTP id
 s6-20020a25ba86000000b00dd16fab81e4mr2034373ybg.37.1712230889318; Thu, 04 Apr
 2024 04:41:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240331-module-owner-virtio-v2-0-98f04bfaf46a@linaro.org> <20240331-module-owner-virtio-v2-12-98f04bfaf46a@linaro.org>
In-Reply-To: <20240331-module-owner-virtio-v2-12-98f04bfaf46a@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 4 Apr 2024 13:41:18 +0200
Message-ID: <CACRpkdYpVUq1SgxnPVfRdTiNg3o8dcBePxoxu9GRYy6LdzUE5A@mail.gmail.com>
Subject: Re: [PATCH v2 12/25] gpio: virtio: drop owner assignment
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jonathan Corbet <corbet@lwn.net>, 
	David Hildenbrand <david@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Paolo Bonzini <pbonzini@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gonglei <arei.gonglei@huawei.com>, 
	"David S. Miller" <davem@davemloft.net>, Sudeep Holla <sudeep.holla@arm.com>, 
	Cristian Marussi <cristian.marussi@arm.com>, Viresh Kumar <vireshk@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, David Airlie <airlied@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Daniel Vetter <daniel@ffwll.ch>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Alexander Graf <graf@amazon.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Kalle Valo <kvalo@kernel.org>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, "James E.J. Bottomley" <jejb@linux.ibm.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Anton Yakovlev <anton.yakovlev@opensynergy.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, virtualization@lists.linux.dev, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, 
	netdev@vger.kernel.org, v9fs@lists.linux.dev, kvm@vger.kernel.org, 
	linux-wireless@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-remoteproc@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, alsa-devel@alsa-project.org, 
	linux-sound@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 31, 2024 at 10:45=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> virtio core already sets the .owner, so driver does not need to.
>
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

