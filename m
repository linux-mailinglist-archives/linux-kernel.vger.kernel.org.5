Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BED17FAF37
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 01:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbjK1AqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 19:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjK1AqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 19:46:09 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59C61B5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 16:46:14 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b2f507c03cso2966813b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 16:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701132374; x=1701737174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LkjbCgNVUTUv8OQIqjJo1lUIRnLiNJ9ZX7ogrN71ZN4=;
        b=T75maftKOaY9rDnLYEZzqxw04tD85CHflDZZWsoOAHi+HLGi4MtP7L8ICYb0wMKr1H
         81xZRN+wOApW8aNs3B8Ai6m6Eirh/sidQFRaLGnEddS0PGotEyeOnqCGYWQjWdZH3E0R
         PKaE1XozdshPUzItDkro9o5oq20yucAHJTDycQ41us1BYXEPyWSH17HnYNmTTDpSUrgZ
         rNX/vR6680SHqH6BAeZhzhAY/MrWTQ7lGC9aZKE9VCiHiLGZ4gzW7d9YYzFdHCFfcXPG
         0/dUYijaZdrW7NaZI2C+kwC+J9ktz8Io/ikChxeq+OcDyfpZrU7IXuHtMkLzIYZZJdnJ
         vSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701132374; x=1701737174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LkjbCgNVUTUv8OQIqjJo1lUIRnLiNJ9ZX7ogrN71ZN4=;
        b=T2WtdinwQtVVyU2IZHOnif6hHghZ/7UZDt7h0TNyQyRDWiZ5T6pEq0Rqzv30EqYltA
         SY4kssVPOXncmfIRza2Je3JO9dqsGdtD2K3rjzxgGOeEeTEivu4Zdyhu7T3FA7DI10al
         /8DcsVXn3UrXsuoPxkQULMfoV4DEOa370AxP0TcCnYb+qxaVXKiFe0Z6TGUTKVf+Rhvp
         ZUryQnM21GbgxB3xcllcvw0NHaHBL5AOfk0Z4ScKON6tagJEFCvqoo4VPjmcinIHVenF
         Jo+JA9hCGQ//5WmtJALAEcGvAtsV2fnsePSr5y9bElBofEAK7YvSwq6eAIm7puvSEFXI
         IOIg==
X-Gm-Message-State: AOJu0YxwDAosjZVCXaRyFOoN+HHdi3lZV5tMTYMr63KZmzM3BCVpwqKy
        1QecQaYKDJm3Rl7rzH5O1i4OnQ==
X-Google-Smtp-Source: AGHT+IFITMTCLDp2mBJtXnfsiUwCzIWYMVKWSGPkiwj34B9WV/cARL/WF/ATd4SkJa1m4AsF35/Epg==
X-Received: by 2002:aca:d03:0:b0:3b7:673:8705 with SMTP id 3-20020aca0d03000000b003b706738705mr15340826oin.18.1701132374153;
        Mon, 27 Nov 2023 16:46:14 -0800 (PST)
Received: from ziepe.ca ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id bi21-20020a056808189500b003b85c5813fdsm1029867oib.21.2023.11.27.16.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 16:46:13 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r7mEu-004wOK-AS;
        Mon, 27 Nov 2023 20:46:12 -0400
Date:   Mon, 27 Nov 2023 20:46:12 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc:     Brett Creeley <brett.creeley@amd.com>,
        "yishaih@nvidia.com" <yishaih@nvidia.com>,
        liulongfang <liulongfang@huawei.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shannon.nelson@amd.com" <shannon.nelson@amd.com>
Subject: Re: [PATCH vfio 1/2] hisi_acc_vfio_pci: Change reset_lock to
 mutex_lock
Message-ID: <20231128004612.GE432016@ziepe.ca>
References: <20231122193634.27250-1-brett.creeley@amd.com>
 <20231122193634.27250-2-brett.creeley@amd.com>
 <eb2172d1e24044059e65d15b10391f65@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb2172d1e24044059e65d15b10391f65@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 08:46:58AM +0000, Shameerali Kolothum Thodi wrote:
> > diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> > b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> > index b2f9778c8366..2c049b8de4b4 100644
> > --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> > +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> > @@ -638,17 +638,17 @@ static void
> >  hisi_acc_vf_state_mutex_unlock(struct hisi_acc_vf_core_device
> > *hisi_acc_vdev)
> >  {
> >  again:
> > -	spin_lock(&hisi_acc_vdev->reset_lock);
> > +	mutex_lock(&hisi_acc_vdev->reset_mutex);
> >  	if (hisi_acc_vdev->deferred_reset) {
> >  		hisi_acc_vdev->deferred_reset = false;
> > -		spin_unlock(&hisi_acc_vdev->reset_lock);
> > +		mutex_unlock(&hisi_acc_vdev->reset_mutex);
> 
> Don't think we have that sleeping while atomic case for this here.
> Same for mlx5 as well. But if the idea is to have a common locking
> across vendor drivers, it is fine.

Yeah, I'm not sure about changing spinlocks to mutex's for no reason..
If we don't sleep and don't hold it for very long then the spinlock is
appropriate

Jason
