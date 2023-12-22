Return-Path: <linux-kernel+bounces-9504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422D881C6A1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3AF6281D3C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46EED530;
	Fri, 22 Dec 2023 08:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b4nlJEgg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09ECC8CB
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 08:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703233749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+1/Sz19OR6XWaD99Hs0XiYIWs6pPYgQ5leaKhAq6DJY=;
	b=b4nlJEggy78sDx6v1o9eyjy8xlaWS3GpPlvTg0nEjetA01XPv53lY2aQLc+KemGseARCeQ
	Ten+JzlHR7XyR8WP3+MU5ov8MFPXbzOdKvHd8o4sO+zp2WsLoRzlh3VHMv9qj4Wa7iHeyQ
	5h0hiRf89qFS83zAk2rvWn/G9You0aY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-AcKK_gY1PhWCIoghtOPgNw-1; Fri, 22 Dec 2023 03:29:08 -0500
X-MC-Unique: AcKK_gY1PhWCIoghtOPgNw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3368698f0caso992874f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 00:29:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703233746; x=1703838546;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+1/Sz19OR6XWaD99Hs0XiYIWs6pPYgQ5leaKhAq6DJY=;
        b=LSMxVVM8Rp9u9hRy2oYmNQg6QXfJ7P2lM0S77Z8Lx9sqjyJYmEtxLcw9/UICd3+KOa
         9p6KjZIq2HJ5jexm5lyG1lowa6x8a7Kld58VNPSR+STiDxycsT5YwPmC+TMADl6XKtgi
         8Uc8276La7Els9ZZCF6WAvjq2e4xbEwvPEJHbmvRH1MLhyU8EVgi6PZ5s99VTnCYnQMA
         pgcA4+XDfpQOlBvoOLqIZhxLX5v+RTlg6yqL56EPG/AtzqJZVDtZD6P8Uyv1Rk6jkH43
         zxGEZG9WYCyR9+oN7RnHAf2C6v6fOX1k9z68j9SKMw78hVOSBMjddGteeCxnaDf1WbJ+
         zjxw==
X-Gm-Message-State: AOJu0YyQJCejLM8ZILnhPlVafOxEA74xec7vKIIVqObuVU/lDZsHIIAA
	joiuzCGT3QNayuj85h2lGhuRyc91h3IAbqkLuNiuYoF2Ax+CXOxi6ReT3n0RjiKF5J9lAWAO3qt
	DQtId95b90qjt761AGcTpr7XdO3NrORG8euA+U50E
X-Received: by 2002:a05:600c:5248:b0:40d:494a:cb9 with SMTP id fc8-20020a05600c524800b0040d494a0cb9mr60320wmb.62.1703233746653;
        Fri, 22 Dec 2023 00:29:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQLIJ3jovK0TTr+qKYudLCC16A8aoY3e2L7y+gdkeb2YLR6dNadO38fME4r6D9zWksyIN5kQ==
X-Received: by 2002:a05:600c:5248:b0:40d:494a:cb9 with SMTP id fc8-20020a05600c524800b0040d494a0cb9mr60308wmb.62.1703233746369;
        Fri, 22 Dec 2023 00:29:06 -0800 (PST)
Received: from redhat.com ([2.55.177.189])
        by smtp.gmail.com with ESMTPSA id m17-20020adffe51000000b003364a0e6983sm3731542wrs.62.2023.12.22.00.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 00:29:05 -0800 (PST)
Date: Fri, 22 Dec 2023 03:29:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "eperezma@redhat.com" <eperezma@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	Parav Pandit <parav@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"si-wei.liu@oracle.com" <si-wei.liu@oracle.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"leon@kernel.org" <leon@kernel.org>
Subject: Re: [PATCH vhost v4 02/15] vdpa: Add
 VHOST_BACKEND_F_CHANGEABLE_VQ_ADDR_IN_SUSPEND flag
Message-ID: <20231222032713-mutt-send-email-mst@kernel.org>
References: <CACGkMEv7xQkZYJAgAUK6C3oUrZ9vuUJdTKRzihXcNPb-iWdpJw@mail.gmail.com>
 <CACGkMEsaaDGi63__YrvsTC1HqgTaEWHvGokK1bJS5+m1XYM-6w@mail.gmail.com>
 <CAJaqyWdoaj8a7q1KrGqWmkYvAw_R_p0utcWvDvkyVm1nUOAxrA@mail.gmail.com>
 <CACGkMEuM7bXxsxHUs_SodiDQ2+akrLqqzWZBJSZEcnMASUkb+g@mail.gmail.com>
 <CAJaqyWeBVVcTZEzZK=63Ymk85wnRFd+_wK56UfEHNXBH-qy1Zg@mail.gmail.com>
 <70adc734331c1289dceb3bcdc991f3da7e4db2f0.camel@nvidia.com>
 <CAJaqyWeUHiZXMFkNBpinCsJAXojtPkGz+SjzUNDPx5W=qqON1w@mail.gmail.com>
 <c03eb2bb3ad76e28be2bb9b9e4dee4c3bc062ea7.camel@nvidia.com>
 <CAJaqyWevZX5TKpaLiJwu2nD7PHFsHg+TEZ=iPdWvrH4jyPV+cA@mail.gmail.com>
 <17abeefd02c843cddf64efbeadde49ad15c365a1.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17abeefd02c843cddf64efbeadde49ad15c365a1.camel@nvidia.com>

On Thu, Dec 21, 2023 at 03:07:22PM +0000, Dragos Tatulea wrote:
> > > > In that case you're right, we don't need feature flags. But I think it
> > > > would be great to also move the error return in case userspace tries
> > > > to modify vq parameters out of suspend state.
> > > > 
> > > On the driver side or on the core side?
> > > 
> > 
> > Core side.
> > 
> Checking my understanding: instead of the feature flags there would be a check
> (for .set_vq_addr and .set_vq_state) to return an error if they are called under
> DRIVER_OK and not suspended state?

Yea this looks much saner, if we start adding feature flags for
each OPERATION_X_LEGAL_IN_STATE_Y then we will end up with N^2
feature bits which is not reasonable.

-- 
MST


