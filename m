Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB1D80A329
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 13:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbjLHM1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 07:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjLHM1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 07:27:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352D2AD
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 04:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702038432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MVkISSEH+FBdQzDw8GhWybc3B9G1vZlEpKHv0PrW/Q0=;
        b=VsOG9GQyyw+yGSlHE/4NZfMwFuvNA0FcYUCn7YOq5CQQBBfseLd+c0VxMJfm8bgm34DYHk
        IKFYIAyYlmarSRmLUP4BhR9PCtSS+LxWan2RGVEpmDtVykZ8EODawYICY2hbfz0oTHr6yU
        zzHvewegYlTFXYI6Q0o+lDIn7weeksY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-i9zHihNqOHG8nuHztZHeuQ-1; Fri, 08 Dec 2023 07:27:11 -0500
X-MC-Unique: i9zHihNqOHG8nuHztZHeuQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-547dd379955so1056697a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 04:27:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702038430; x=1702643230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVkISSEH+FBdQzDw8GhWybc3B9G1vZlEpKHv0PrW/Q0=;
        b=aTttUdUIKwXk1TfaRcLIOM/oMW+bd4hmp3+EcpWvteAjl1Bs1lkM29exZfyDH1hDdp
         dUMoK4otZ4Eyv8fAjKVnj2JxSZJXNiGN51vTpqCsb1uZXH3dY2KqFz2PHcUHK/T8CiHX
         qx5Fdqe0L4Xegsq9tj3fl+lXLt7PtmTKG9HwJjRazwioC3L9Ql/Iz64yLQQ/DUhrsBi9
         ohJHaA6mrIDRn2p5D/Nve+H8cCLLgsv/hd4sfmYHkHS4Tnz056u82JxPStX/aVsTLZzM
         WpQ/B0J2e5M2VI1/vLJTjgvtwYloB8xIsT87pvsqxx8TKBM7jaN5oACN4/Ue+O4riiGV
         Jjlg==
X-Gm-Message-State: AOJu0YzPskadjXnSPnVkaheqc77jDdlRYCAZ/G/jNZP7XFfNfleYqeOe
        BnESAYWv2Lio1ugohUoYy/7/5jE7YVENcSqBDgDeRFvDvBAMDOGU/jeq5NEcP8qCttM6Qvxn3QH
        ZUSksIFc4FG/5HvUCvlY7vaBK
X-Received: by 2002:a50:9fa9:0:b0:54d:8e9e:c835 with SMTP id c38-20020a509fa9000000b0054d8e9ec835mr12160edf.78.1702038430261;
        Fri, 08 Dec 2023 04:27:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMFEvK3hIa6NTwh4M4b1Lj05T78HNsQaqmShsFPjb+rBrGd/VH7pLicv91797yDItcZw6KJw==
X-Received: by 2002:a50:9fa9:0:b0:54d:8e9e:c835 with SMTP id c38-20020a509fa9000000b0054d8e9ec835mr12148edf.78.1702038429859;
        Fri, 08 Dec 2023 04:27:09 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f0:7466:b10d:58c8:869f:7e91])
        by smtp.gmail.com with ESMTPSA id n17-20020a509351000000b0054c5b5c0893sm792181eda.71.2023.12.08.04.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 04:27:09 -0800 (PST)
Date:   Fri, 8 Dec 2023 07:26:59 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Maxime Coquelin <maxime.coquelin@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        xieyongji@bytedance.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        david.marchand@redhat.com, lulu@redhat.com
Subject: Re: [PATCH v4 4/4] vduse: Add LSM hooks to check Virtio device type
Message-ID: <20231208072649-mutt-send-email-mst@kernel.org>
References: <20231020155819.24000-5-maxime.coquelin@redhat.com>
 <2b8269b7c58ebf9b260b4e2a0676bc22.paul@paul-moore.com>
 <8ec2ae21-603d-4ce1-944b-09e042751806@redhat.com>
 <20231208060249-mutt-send-email-mst@kernel.org>
 <a5faf263-d998-4845-952f-9c8dc1d4609f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5faf263-d998-4845-952f-9c8dc1d4609f@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 01:23:00PM +0100, Maxime Coquelin wrote:
> 
> 
> On 12/8/23 12:05, Michael S. Tsirkin wrote:
> > On Fri, Dec 08, 2023 at 12:01:15PM +0100, Maxime Coquelin wrote:
> > > Hello Paul,
> > > 
> > > On 11/8/23 03:31, Paul Moore wrote:
> > > > On Oct 20, 2023 "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > 
> > > > > This patch introduces LSM hooks for devices creation,
> > > > > destruction and opening operations, checking the
> > > > > application is allowed to perform these operations for
> > > > > the Virtio device type.
> > > > > 
> > > > > Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> > > > > ---
> > > > >    drivers/vdpa/vdpa_user/vduse_dev.c  | 12 +++++++
> > > > >    include/linux/lsm_hook_defs.h       |  4 +++
> > > > >    include/linux/security.h            | 15 ++++++++
> > > > >    security/security.c                 | 42 ++++++++++++++++++++++
> > > > >    security/selinux/hooks.c            | 55 +++++++++++++++++++++++++++++
> > > > >    security/selinux/include/classmap.h |  2 ++
> > > > >    6 files changed, 130 insertions(+)
> > > > 
> > > > My apologies for the late reply, I've been trying to work my way through
> > > > the review backlog but it has been taking longer than expected; comments
> > > > below ...
> > > 
> > > No worries, I have also been busy these days.
> > > 
> > > > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > > > index 2aa0e219d721..65d9262a37f7 100644
> > > > > --- a/security/selinux/hooks.c
> > > > > +++ b/security/selinux/hooks.c
> > > > > @@ -21,6 +21,7 @@
> > > > >     *  Copyright (C) 2016 Mellanox Technologies
> > > > >     */
> > > > > +#include "av_permissions.h"
> > > > >    #include <linux/init.h>
> > > > >    #include <linux/kd.h>
> > > > >    #include <linux/kernel.h>
> > > > > @@ -92,6 +93,7 @@
> > > > >    #include <linux/fsnotify.h>
> > > > >    #include <linux/fanotify.h>
> > > > >    #include <linux/io_uring.h>
> > > > > +#include <uapi/linux/virtio_ids.h>
> > > > >    #include "avc.h"
> > > > >    #include "objsec.h"
> > > > > @@ -6950,6 +6952,56 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
> > > > >    }
> > > > >    #endif /* CONFIG_IO_URING */
> > > > > +static int vduse_check_device_type(u32 sid, u32 device_id)
> > > > > +{
> > > > > +	u32 requested;
> > > > > +
> > > > > +	if (device_id == VIRTIO_ID_NET)
> > > > > +		requested = VDUSE__NET;
> > > > > +	else if (device_id == VIRTIO_ID_BLOCK)
> > > > > +		requested = VDUSE__BLOCK;
> > > > > +	else
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	return avc_has_perm(sid, sid, SECCLASS_VDUSE, requested, NULL);
> > > > > +}
> > > > > +
> > > > > +static int selinux_vduse_dev_create(u32 device_id)
> > > > > +{
> > > > > +	u32 sid = current_sid();
> > > > > +	int ret;
> > > > > +
> > > > > +	ret = avc_has_perm(sid, sid, SECCLASS_VDUSE, VDUSE__DEVCREATE, NULL);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	return vduse_check_device_type(sid, device_id);
> > > > > +}
> > > > 
> > > > I see there has been some discussion about the need for a dedicated
> > > > create hook as opposed to using the existing ioctl controls.  I think
> > > > one important point that has been missing from the discussion is the
> > > > idea of labeling the newly created device.  Unfortunately prior to a
> > > > few minutes ago I hadn't ever looked at VDUSE so please correct me if
> > > > I get some things wrong :)
> > > > 
> > > >   From what I can see userspace creates a new VDUSE device with
> > > > ioctl(VDUSE_CREATE_DEV), which trigger the creation of a new
> > > > /dev/vduse/XXX device which will be labeled according to the udev
> > > > and SELinux configuration, likely with a generic udev label.  My
> > > > question is if we want to be able to uniquely label each VDUSE
> > > > device based on the process that initiates the device creation
> > > > with the call to ioctl()?  If that is the case, we would need a
> > > > create hook not only to control the creation of the device, but to
> > > > record the triggering process' label in the new device; this label
> > > > would then be used in subsequent VDUSE open and destroy operations.
> > > > The normal device file I/O operations would still be subject to the
> > > > standard SELinux file I/O permissions using the device file label
> > > > assigned by systemd/udev when the device was created.
> > > 
> > > I don't think we need a unique label for VDUSE devices, but maybe
> > > Michael thinks otherwise?
> > 
> > I don't know.
> > All this is consumed by libvirt, you need to ask these guys.
> 
> I think it is not consumed by libvirt, at least not in the usecases I
> have in mind. For networking devices, it will be consumed by OVS.
> 
> Maxime

OK, ovs then :)

-- 
MST

