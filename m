Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37417834A6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjHUVIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 17:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjHUVI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 17:08:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91D4D1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 14:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692652063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oQbG/Zrrtm4dTd/ljOBC/1/aflCxfw0pZXVgVdEOSI0=;
        b=GWLFm9ungF6pQDfunBCyb8tRO9NeBvr5L3XRZG7o5ZEAcXI5xjwKrPHxhPzERwsm4ZU++9
        r0TV6yxqTaKu3W8VZmeLkxytMiCs7uZArZC1hKqQJR0VZQ3hcfCaeoiKmWSAq6hvOvQt3U
        Ue9K+ZEe/LxNwLYPTc0idq82z60HUI8=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-SWvl5sieOnmHgjXw8QIpfw-1; Mon, 21 Aug 2023 17:07:42 -0400
X-MC-Unique: SWvl5sieOnmHgjXw8QIpfw-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6b9efedaeebso4340851a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 14:07:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692652061; x=1693256861;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oQbG/Zrrtm4dTd/ljOBC/1/aflCxfw0pZXVgVdEOSI0=;
        b=QZPGFnHt87YZOa1kXj6KpYMHegIkfvyhqlmdRL0gORlEtJ9Fkk8YPzwXknGF8rkzfs
         l/7UbR08hmEDh59xvj7x2n56UK/34k41/8no2yowfrNXS+EGEg7f+kW4Fal8CoI+Xxm5
         SAMfQBgjF1bRLCqAZT6oOd0RY+KSQBqLz0Cy8mBNYsrMr3w5v9GMC+rNPhqsmdLziyak
         L9TKnZmGqBZlzua8cL67D1GnQzyD/lSqZ/YsvUhqBBAUgzu9xwiXKta1PGjvunj5i0VU
         J78TOBEJc1kl0OC2visSoO03hVLCM5rQUtiMnSHW5qOU+kryEMdM5wPQQ16PmvKcE63H
         Uciw==
X-Gm-Message-State: AOJu0YzKMd7istvCgUPUduUl7Qk5nURAdGEnKF7lpsSEEubpPwCPHEUd
        aQMBOzEXK4LdKToFyOsMQeaTmDkW4T8nMJz19RQOp3j7PXljCMeGSyFA3u5ah+HHTTwhLtGzAvq
        mT7CqXs3H0EySzGSSEnG2MdX/
X-Received: by 2002:a05:6871:8a0:b0:1b7:2edd:df6d with SMTP id r32-20020a05687108a000b001b72edddf6dmr10382268oaq.10.1692652061580;
        Mon, 21 Aug 2023 14:07:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHg53yS4+yqxYQU4Fqo7FjOoh3Pd04o9nYoiVuJ/o7Z0mFf9rf+RR12Qm6IWfmcknClaStmNA==
X-Received: by 2002:a05:6871:8a0:b0:1b7:2edd:df6d with SMTP id r32-20020a05687108a000b001b72edddf6dmr10382253oaq.10.1692652061290;
        Mon, 21 Aug 2023 14:07:41 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id r134-20020a4a378c000000b0056e45a34dcfsm4268234oor.1.2023.08.21.14.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 14:07:40 -0700 (PDT)
Date:   Mon, 21 Aug 2023 15:07:38 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Gupta, Nipun" <nipun.gupta@amd.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        git@amd.com, pieter.jansen-van-vuuren@amd.com,
        nikhil.agarwal@amd.com, michal.simek@amd.com,
        abhijit.gangurde@amd.com, Shubham Rohila <shubham.rohila@amd.com>
Subject: Re: [PATCH v6 3/3] vfio-cdx: add bus mastering device feature
 support
Message-ID: <20230821150738.63ff73b9.alex.williamson@redhat.com>
In-Reply-To: <4f1dc1c5-ce18-5595-6667-3e6ce1d0e36c@amd.com>
References: <20230810084409.4922-1-nipun.gupta@amd.com>
        <20230810084409.4922-3-nipun.gupta@amd.com>
        <20230816114610.79c9eccc.alex.williamson@redhat.com>
        <2d94cffa-7ebf-a8ab-4f43-fc9ab1be41bb@amd.com>
        <20230818083737.7ad97c2a.alex.williamson@redhat.com>
        <4f1dc1c5-ce18-5595-6667-3e6ce1d0e36c@amd.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2023 16:27:40 +0530
"Gupta, Nipun" <nipun.gupta@amd.com> wrote:

> On 8/18/2023 8:07 PM, Alex Williamson wrote:
> > On Fri, 18 Aug 2023 14:02:32 +0530
> > "Gupta, Nipun" <nipun.gupta@amd.com> wrote:
> >   
> >> On 8/16/2023 11:16 PM, Alex Williamson wrote:  
> >>> On Thu, 10 Aug 2023 14:14:09 +0530
> >>> Nipun Gupta <nipun.gupta@amd.com> wrote:
> >>>      
> >>>> Support Bus master enable and disable on VFIO-CDX devices using
> >>>> VFIO_DEVICE_FEATURE_BUS_MASTER flag over VFIO_DEVICE_FEATURE IOCTL.
> >>>>
> >>>> Co-developed-by: Shubham Rohila <shubham.rohila@amd.com>
> >>>> Signed-off-by: Shubham Rohila <shubham.rohila@amd.com>
> >>>> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> >>>> ---
> >>>>
> >>>> Changes v5->v6:
> >>>> - Called CDX device reset at cdx_open_device()
> >>>>
> >>>> Changes v4->v5:
> >>>> - Use device feature IOCTL instead of adding a new VFIO IOCTL
> >>>>     for bus master feature.
> >>>>
> >>>> Changes in v4:
> >>>> - This patch is newly added which uses cdx_set_master() and
> >>>>     cdx_clear_master() APIs.
> >>>>
> >>>>    drivers/vfio/cdx/main.c | 46 +++++++++++++++++++++++++++++++++++++++--
> >>>>    1 file changed, 44 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/vfio/cdx/main.c b/drivers/vfio/cdx/main.c
> >>>> index c376a69d2db2..bf0e1f56e0f9 100644
> >>>> --- a/drivers/vfio/cdx/main.c
> >>>> +++ b/drivers/vfio/cdx/main.c
> >>>> @@ -14,7 +14,7 @@ static int vfio_cdx_open_device(struct vfio_device *core_vdev)
> >>>>    		container_of(core_vdev, struct vfio_cdx_device, vdev);
> >>>>    	struct cdx_device *cdx_dev = to_cdx_device(core_vdev->dev);
> >>>>    	int count = cdx_dev->res_count;
> >>>> -	int i;
> >>>> +	int i, ret;
> >>>>    
> >>>>    	vdev->regions = kcalloc(count, sizeof(struct vfio_cdx_region),
> >>>>    				GFP_KERNEL_ACCOUNT);
> >>>> @@ -39,8 +39,11 @@ static int vfio_cdx_open_device(struct vfio_device *core_vdev)
> >>>>    		if (!(cdx_dev->res[i].flags & IORESOURCE_READONLY))
> >>>>    			vdev->regions[i].flags |= VFIO_REGION_INFO_FLAG_WRITE;
> >>>>    	}
> >>>> +	ret = cdx_dev_reset(core_vdev->dev);
> >>>> +	if (ret)
> >>>> +		kfree(vdev->regions);  
> >>>
> >>> AIUI, this reset clears bus master, but per the first patch in the
> >>> series the ability to set or clear bus master depends on whether the
> >>> underlying cdx_ops supports dev_configure.  Apparently all currently
> >>> do, but will that always be true?
> >>>
> >>> It seems like this could make a gratuitous call to cdx_clear_master()
> >>> to validate the return value and only conditionally support this device
> >>> feature based on that result (or fail the device open if it's meant to
> >>> be required).  
> >>
> >> CDX bus driver does not explicitly call cdx_clear_master during reset.
> >> It is triggered by device implicitly and hence device_reset would never
> >> fail due to lack of bus mastering capability.
> >>
> >> Do you mean if cdx_dev_reset() fails we should not set the
> >> VFIO_DEVICE_FLAGS_RESET in vfio_device_info? something like:
> >>
> >> 	ret = cdx_dev_reset(core_vdev->dev);
> >> 	if (ret == -EOPNOTSUPP)
> >>    		/* make sure VFIO_DEVICE_FLAGS_RESET is not returned in
> >> 		 * flags for device get info */
> >> 	else if (ret)
> >> 		kfree(vdev->regions);
> >>
> >>   From new device feature added for BUS mastering if cdx_clear_master()
> >> fails due to no support, the bus driver will return -EOPNOTSUPP, so same
> >> would be communicated to the user-space, so it seems fine from this end.  
> > 
> > It's inconsistent to the user to allow the bus master device feature
> > probe to indicate the feature is available if it's going to fail on
> > every call.  My suggestion was specifically relative to that, a
> > gratuitous call to clear bus master, determine if the call works, then
> > the feature probe could succeed or fail based on that result.
> > 
> > However, now that I look at cdx_dev_reset() I notice the inconsistency
> > with dev_configure.  The reset path unconditionally calls
> > dev_configure, but the bus master paths tests dev_configure.  Is
> > dev_configure a required op or not?  Are reset and bus master control
> > required features of CDX?  If the core CDX code requires these then the
> > vfio support gets easier, we don't need to make all these conditional.  
> 
> Hi Alex,
> 
> dev_configure is a required op for CDX bus controller. The check in 
> cdx_set_master()/cdx_clear_master() is just precautionary and can be 
> removed.
> 
> On the other part where you mention making device feature optional, I 
> was not able to locate any API/flags to export capabilities to the VFIO 
> user regarding the features supported by the device. Though it is not 
> required as all CDX devices would support the BUS mastering.

The flags for the feature itself is how the user determines whether the
feature is available.  For example here we're expecting the user to
call with flags (VFIO_DEVICE_FEATURE_PROBE | VFIO_DEVICE_FEATURE_SET)
to determine the VFIO_DEVICE_FEATURE_BUS_MASTER is available.  This is
handled automatically by the boilerplate usage of vfio_check_feature().

In this series we introduce the possibility that there might be no
dev_configure callback for a device, which would create a scenario were
the vfio device feature probing indicates support for a feature that
maybe isn't actually present.  Then, even if dev_configure is
supported and required, it's just multiplexing the specific op via a
switch statement, so we need to make a leap of faith whether every
future dev_configure implementation will support these ops.

I wonder if dev_configure is really necessary or it wouldn't be better
to to have .reset and .bus_master callbacks on struct cdx_ops.  Then
the cdx subsystem could properly enforce required callbacks.  Thanks,

Alex

