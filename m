Return-Path: <linux-kernel+bounces-14770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF588221FA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 20:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81079B2255A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD5D15E90;
	Tue,  2 Jan 2024 19:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BwbWxHwa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297E915AF2
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 19:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704223706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bJ/i/xMtI4WK7rc02jogXWNeclW4uq/A8ibcd1aMymI=;
	b=BwbWxHwaIY/p2fmFTxma9j34KOrg30XJx+M3YuDBmaVPi8yUUk/DEpiC0f7LWc9M0mMlEk
	NAnv2OJ7XoIXX+TIXasJ/qxeKF4q6QWL3VqkEnsoerQzvMR9z+Jsh5hklO2I0FjIIzf/4+
	WJ6BQpQ15pMMJMZ7bWTkZgkN80Vmo3Q=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-Tf3dczY7OWu4my5EwH4ixA-1; Tue, 02 Jan 2024 14:28:25 -0500
X-MC-Unique: Tf3dczY7OWu4my5EwH4ixA-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7bbad6e08b0so212551539f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 11:28:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704223704; x=1704828504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJ/i/xMtI4WK7rc02jogXWNeclW4uq/A8ibcd1aMymI=;
        b=V8uvr13JIFq21lJzQqbWyXJu1CBrL0wNXi4FOOFJDyKPcLEnKKDX1j5tL6110tSaC6
         3jq9uklWKze1ZDoEu2X98TZ/wrkEd1i+ncNiXUuMWDIcwz3ToG5KrVrn+1cPnwPWQXM/
         EzJe91RWilZRxAevlK00CmE5MwCr2Nd7zH7QsP/efrP3C5MFdSi0jbfrTY0Z2bQEsmmW
         bf6bbirV+KDqpkl99tuaPYKAOPpzIjy5JZk+QPslP8H6dUDPCOjj5x9NTDFeplrXgYDz
         wBtbCWtJeQdaeocNkANCGyhXjAkyCWcMVyRusMIHJHIQia8lRWF0cB0iwP8SB/fZmGvd
         CbqQ==
X-Gm-Message-State: AOJu0Yz10zkLGeMgWiJLEBPZSZDSq2gZkyTS/4/L/2dBQy9xtbMTtfuU
	3144RyK0yalAkhfpQq4ed1cI0Z2El72KQ5Hc/5hLuz/Mdp08ACal+AR57tBjfNmNTMeI4toHGeN
	F4CBf4WcNK6WFuTng20KDR7VSnqPeCPplIW3uEcHR
X-Received: by 2002:a05:6602:1512:b0:7ba:7fd1:a638 with SMTP id g18-20020a056602151200b007ba7fd1a638mr28289285iow.16.1704223704675;
        Tue, 02 Jan 2024 11:28:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQt0k9BpNBf3awzoQ+iFyFl7hdWVxVsXotr+x2FmspxI5w39AFpAC/MeGYdPjdqaflGn15gw==
X-Received: by 2002:a05:6602:1512:b0:7ba:7fd1:a638 with SMTP id g18-20020a056602151200b007ba7fd1a638mr28289276iow.16.1704223704472;
        Tue, 02 Jan 2024 11:28:24 -0800 (PST)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id s14-20020a02cf2e000000b004647af59c3dsm6948475jar.16.2024.01.02.11.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 11:28:24 -0800 (PST)
Date: Tue, 2 Jan 2024 12:28:22 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 wutu.xq2@linux.alibaba.com
Subject: Re: [Question] Is it must for vfio-mdev parent driver to implement
 a pci-compliant configuration r/w interface
Message-ID: <20240102122822.768f979c.alex.williamson@redhat.com>
In-Reply-To: <ZYo6rITis9siz2Av@wuzongyong-alibaba>
References: <ZYo6rITis9siz2Av@wuzongyong-alibaba>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Dec 2023 10:30:04 +0800
Wu Zongyong <wuzongyong@linux.alibaba.com> wrote:

> Hi,
> 
> For vfio, I know there are two method to get region size:
>   1. VFIO_DEVICE_GET_REGION_INFO ioctl
>   2. write a value of all 1's to the bar register of vfio-device fd
>     and then read the value back which is described in pci spec
> 
> Now I am curious about is it a must for a vfio-mdev parent driver to
> implement the method 2? Or it is just a optional interface.

If there's not a working, compliant config space, the device shouldn't
claim to implement a vfio-pci interface.  There's vfio-platform
available for non-PCI devices.  While the BAR size may be found via
either REGION_INFO or config space itself, the BAR address space is
only found via config space, ie. memory or IO, 32 or 64-bit,
prefetchable or not.  Thanks,

Alex


