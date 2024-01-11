Return-Path: <linux-kernel+bounces-23283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0147382AA60
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2661D1C26032
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6AB10957;
	Thu, 11 Jan 2024 09:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MSu81bbF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A684FC0C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704963791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fiVGhyMQqpemmt2172xI1+ogtFZA6yGakCsHppFUzcE=;
	b=MSu81bbF9gxdFUXPYMXK3+PmiWS4BeWVM5oPtznbMiUj0E0ewzARDpnZ7bOvK5JzHxYNCg
	rTCGhkf0TVB1CgoN5W2VD0KQF+cDmQ0pxoMGR3mghJ4MjfVPJIZvTzWB1ythXnLO9sTei0
	Tt4M0p1meHp1hiRUMQLkJuDFdDDzWIc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-lFb5Mj52NRaohCCtVbRMpA-1; Thu, 11 Jan 2024 04:03:07 -0500
X-MC-Unique: lFb5Mj52NRaohCCtVbRMpA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a28f6a78b83so302622266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 01:03:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704963786; x=1705568586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fiVGhyMQqpemmt2172xI1+ogtFZA6yGakCsHppFUzcE=;
        b=mk4s6KqRGViB4ldmG6hlKetag8mYUS9YZA+HmiCF44lUlJxRK8/EcURFWFxnud0tkY
         Np/1NnSuywsN9XBzMswre5O3yi1siA8dLyra0IZglYNbnoWAxCS2XnASgpXPNXES4K7m
         qPM95Ee3E3aeYpubbYTVCKNyN1VtHxQdf6iPcqF/zaDMZOG4NXqHB9NbIM71jXLEjQ6Z
         B5dEk9AyJrY/g+oW5q2qVKhuYm9qknH2Hu1U7BB43oqQ2+OFgPr0ulSHM1WtL1wX/sOg
         OXOvum1p1BQ8fWWW3IYLQefoUB+088ri79aQBTm7wcjWOwNnuFyQ6xmPGYI1hDSWyYMa
         +LVA==
X-Gm-Message-State: AOJu0YxPaUHjiBgT5CidF2AnvW0lN7cErnxM15ol72AWZW2V3DRKsj6W
	5GTuauRUwsaraexEO2IPEy1Zs4foWKKcL8mj8cClDPXWal15KZUFVo892RvjoIRCWeu0GSdJXd2
	yrtmUNVwvIqp0uidBQroKD7eCJ3G03e6jFsuk4bBtiND5/npK
X-Received: by 2002:a17:906:3542:b0:a29:40fe:254d with SMTP id s2-20020a170906354200b00a2940fe254dmr364315eja.69.1704963786582;
        Thu, 11 Jan 2024 01:03:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHK7Ui4uGInFgVXo+NZqkjdPTK8VVW9Bqv6J5hojrs+GmhQPMTzNaI+7+HiAGH04fzV7CRFN3n0SvAxRkyMRTk=
X-Received: by 2002:a17:906:3542:b0:a29:40fe:254d with SMTP id
 s2-20020a170906354200b00a2940fe254dmr364310eja.69.1704963786312; Thu, 11 Jan
 2024 01:03:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103171641.1703146-1-lulu@redhat.com> <20240110172459-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240110172459-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 11 Jan 2024 17:02:27 +0800
Message-ID: <CACLfguVpiJY2h9MXEfJBEtaEeqaRnScp3X-SoAn7anPjqi9WiQ@mail.gmail.com>
Subject: Re: [RFC v1 0/8] vhost-vdpa: add support for iommufd
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 6:25=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Sat, Nov 04, 2023 at 01:16:33AM +0800, Cindy Lu wrote:
> >
> > Hi All
> > This code provides the iommufd support for vdpa device
> > This code fixes the bugs from the last version and also add the asid su=
pport. rebase on kernel
> > v6,6-rc3
> > Test passed in the physical device (vp_vdpa), but  there are still some=
 problems in the emulated device (vdpa_sim_net),
> > I will continue working on it
> >
> > The kernel code is
> > https://gitlab.com/lulu6/vhost/-/tree/iommufdRFC_v1
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
>
> Was this abandoned?
>
Thanks Micheal. I'm really sorry for the delay. I will continue working on =
this
Thanks
Cindy
> >
> > Cindy Lu (8):
> >   vhost/iommufd: Add the functions support iommufd
> >   Kconfig: Add the new file vhost/iommufd
> >   vhost: Add 3 new uapi to support iommufd
> >   vdpa: Add new vdpa_config_ops to support iommufd
> >   vdpa_sim :Add support for iommufd
> >   vdpa: change the map/unmap process to support iommufd
> >   vp_vdpa::Add support for iommufd
> >   iommu: expose the function iommu_device_use_default_domain
> >
> >  drivers/iommu/iommu.c             |   2 +
> >  drivers/vdpa/vdpa_sim/vdpa_sim.c  |   8 ++
> >  drivers/vdpa/virtio_pci/vp_vdpa.c |   4 +
> >  drivers/vhost/Kconfig             |   1 +
> >  drivers/vhost/Makefile            |   1 +
> >  drivers/vhost/iommufd.c           | 178 +++++++++++++++++++++++++
> >  drivers/vhost/vdpa.c              | 210 +++++++++++++++++++++++++++++-
> >  drivers/vhost/vhost.h             |  21 +++
> >  include/linux/vdpa.h              |  38 +++++-
> >  include/uapi/linux/vhost.h        |  66 ++++++++++
> >  10 files changed, 525 insertions(+), 4 deletions(-)
> >  create mode 100644 drivers/vhost/iommufd.c
> >
> > --
> > 2.34.3
>


