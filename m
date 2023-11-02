Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B397DF20F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 13:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjKBMLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 08:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjKBMLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 08:11:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6318EE4
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 05:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698927031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S4d3LBwofHPDGIVxzOtEyFdF9IVCLxopngLk7uHzb1Y=;
        b=iLmFbG7n55SpnIa1Cl8bQR2s51UkbFM7HCa6dwrAdsPDtpptyQsqaLOR8kUBQYNULKrP0U
        juUE4G7lv9e5szFoWxvRm/3jNXlA58iXKDVgysXRmgO18GbYQ5zd5P2F+2+0t3r8nE/zpP
        1S6x2MxUHvFrYYc2fUJp88PMEnVUD3k=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-JHPk-41xOQWgpRoJsBok7Q-1; Thu, 02 Nov 2023 08:10:30 -0400
X-MC-Unique: JHPk-41xOQWgpRoJsBok7Q-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9d2606301eeso102236466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 05:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698927029; x=1699531829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S4d3LBwofHPDGIVxzOtEyFdF9IVCLxopngLk7uHzb1Y=;
        b=cjax5yCcegwWTWqtazBxbIObLOmKu3sY6xwRae1xHoA+So1wjYE6eRBoMFIYxHqGM6
         NXMLY44CJofcOHT0mBVpSssj+VL80jHibkckY8QWMABDr8oxj9+7CYOoBo00uoT7BXZb
         VP/1WleLoVm2hbIrxb7OCvfibuFiv+iZMyrCKto9Q8V8lS5cWJtJZqSSDnRh38GHWd0p
         sEEcMdbNKqRzD9szpOvbM7+7EIDDKgeT0/hjhiOQqEy1ZPLCloXmO+U4hpn2NBz+7RB9
         /defY1yinDqW2HsNUH+6bgpqYKA+gjGrLhoo/TSM6vPY8W1HJ82IUXCz8XK2fOISlFg1
         TuZw==
X-Gm-Message-State: AOJu0YxYKivUwGj2aXQpKSXbfAWHnupKg65l5UnT1EDwdZatwFKMNOzQ
        p/h4f7CuJk0Vrt3iz8cDJmjjfEMo3j96NMMypAZ3lpdRK+fOzeE4M269GPHTFu0K4pzRyeDEgZK
        lZtQI/RDVqvczKNUHjizeWLYcs4x+2acX7TI/kP4U
X-Received: by 2002:a17:907:88e:b0:9b2:b80d:da87 with SMTP id zt14-20020a170907088e00b009b2b80dda87mr4601103ejb.16.1698927029407;
        Thu, 02 Nov 2023 05:10:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEATtQiOlFzTOGhzy0swhCJpUIb/sUTEQBiEwaeEXPgC9LXCBs5EA6nfN6r2vIDmzVyu5JcVFzKjJ+d05SCuG4=
X-Received: by 2002:a17:907:88e:b0:9b2:b80d:da87 with SMTP id
 zt14-20020a170907088e00b009b2b80dda87mr4601085ejb.16.1698927029119; Thu, 02
 Nov 2023 05:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230923170540.1447301-1-lulu@redhat.com> <20231026024147-mutt-send-email-mst@kernel.org>
 <CACLfguXstNSC20x=acDx20CXU3UksURDY04Z89DM_sNbGeTELQ@mail.gmail.com> <20231102060151-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231102060151-mutt-send-email-mst@kernel.org>
From:   Cindy Lu <lulu@redhat.com>
Date:   Thu, 2 Nov 2023 20:09:50 +0800
Message-ID: <CACLfguVDx8B1t0K6vOZ8JchGwVrSUGJ1P-ZLzxG0KK5S63OuHg@mail.gmail.com>
Subject: Re: [RFC 0/7] vdpa: Add support for iommufd
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 6:02=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Thu, Oct 26, 2023 at 02:48:07PM +0800, Cindy Lu wrote:
> > On Thu, Oct 26, 2023 at 2:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Sun, Sep 24, 2023 at 01:05:33AM +0800, Cindy Lu wrote:
> > > > Hi All
> > > > Really apologize for the delay, this is the draft RFC for
> > > > iommufd support for vdpa, This code provides the basic function
> > > > for iommufd support
> > > >
> > > > The code was tested and passed in device vdpa_sim_net
> > > > The qemu code is
> > > > https://gitlab.com/lulu6/gitlabqemutmp/-/tree/iommufdRFC
> > > > The kernel code is
> > > > https://gitlab.com/lulu6/vhost/-/tree/iommufdRFC
> > > >
> > > > ToDo
> > > > 1. this code is out of date and needs to clean and rebase on the la=
test code
> > > > 2. this code has some workaround, I Skip the check for
> > > > iommu_group and CACHE_COHERENCY, also some misc issues like need to=
 add
> > > > mutex for iommfd operations
> > > > 3. only test in emulated device, other modes not tested yet
> > > >
> > > > After addressed these problems I will send out a new version for RF=
C. I will
> > > > provide the code in 3 weeks
> > >
> > > What's the status here?
> > >
> > Hi Michael
> > The code is finished, but I found some bug after adding the support for=
 ASID,
> > will post the new version after this bug is fixed, should be next week
> > Thanks
> > Cindy
>
> The week is almost gone, what's going on?
>
thanks, Micheal, I will send it out tomorrow
Thanks
Cindy
>
> > > --
> > > MST
> > >
>

