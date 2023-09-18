Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BFF7A4B92
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjIRPSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbjIRPSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:18:50 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6951706
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:17:32 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-5733bcf6eb6so2414598eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695050252; x=1695655052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lj5dxmdz31KH6AK++Iu1oSHNEdMOKTOEa8EzHyb8OO4=;
        b=DzqQ4xV/tSCjuAwgM2E5R/vQvNCxPt0tZ1n4yvCcv85Gfp/I9CiMMjHi29I8pas3ea
         Bt/o1RAOUyjuJt+0CnLAZCSkQuohrMQa631imXzcldFOjfWzPIcjtWBuEzdgoSRoeb/M
         G4cu9xI5rRIefzAK0ApQ0QAkh7/pgh8Ne/K44cUcUrB3jyIngJ/Mr8DTBSCYWPLuJE+V
         ZEPPIYh5TyKSFjHzldLykvjS7ZUupOSn1FOIo8rMoRs+xcvYjgY8BG+7K9ZOE2ZR9EX6
         i5zoEjKl2FmA7TJCXFdI8e3qwznTKOMQHTkE1h9oIM8bHvllR+DwyTg6O0xr2qSBOqqa
         fOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695050252; x=1695655052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lj5dxmdz31KH6AK++Iu1oSHNEdMOKTOEa8EzHyb8OO4=;
        b=LDzYSNy4203tDdk9VffX72iINvfWMqwb+xDptaNsaZ1DI3tLlzfwW0GrJrGKLp5ROR
         8t87tBTkHxnh1joEL7wnjRT4WaHIX+25h3WtlOndz8Umy7fhWLODVjSRed9/Xqu/ksuy
         YHdMYXxDbZYrj+1kfTdFM+Mst4JdOc02P+DJ1T625GbsPXYsGBcULnFdCDVaGHy0MbPe
         BVJ+R+Zo5NP7c90MruhNOt6xKpo0awnuqn9APOo0CTXs4CXISmWhyxOvkBHmUSzjH4fX
         o1/z5i8NzZs+MP+wr+yTnqYkw/Hmva2q04AKZtayo6afMp8EoI31A1CriQewF2C7nTZU
         JjMw==
X-Gm-Message-State: AOJu0YyLmpZIKBJD8nNXKINUpidEC1wpJ4CLbEsgHP5o4jYqGxJPY35R
        L8gSgewHEZMzfBFm2Qk1TkK82ueVzs4LNCliO2g=
X-Google-Smtp-Source: AGHT+IFNhLbse4fMScsyVGa4C7/zZePvwAGFSXOes1CURAA9QoCkvaC8bU10ioWe6oH7Sby42aFfXg==
X-Received: by 2002:ad4:4110:0:b0:64f:91de:3aab with SMTP id i16-20020ad44110000000b0064f91de3aabmr9453857qvp.29.1695046626845;
        Mon, 18 Sep 2023 07:17:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id w26-20020a0ca81a000000b00655e2005350sm3491584qva.9.2023.09.18.07.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 07:17:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qiF3h-00054J-Oj;
        Mon, 18 Sep 2023 11:17:05 -0300
Date:   Mon, 18 Sep 2023 11:17:05 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Shannon Nelson <shannon.nelson@amd.com>
Cc:     alex.williamson@redhat.com, kevin.tian@intel.com,
        reinette.chatre@intel.com, tglx@linutronix.de, kvm@vger.kernel.org,
        brett.creeley@amd.com, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH vfio] vfio/pci: remove msi domain on msi disable
Message-ID: <20230918141705.GE13795@ziepe.ca>
References: <20230914191406.54656-1-shannon.nelson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914191406.54656-1-shannon.nelson@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 12:14:06PM -0700, Shannon Nelson wrote:
> The new MSI dynamic allocation machinery is great for making the irq
> management more flexible.  It includes caching information about the
> MSI domain which gets reused on each new open of a VFIO fd.  However,
> this causes an issue when the underlying hardware has flexible MSI-x
> configurations, as a changed configuration doesn't get seen between
> new opens, and is only refreshed between PCI unbind/bind cycles.
> 
> In our device we can change the per-VF MSI-x resource allocation
> without the need for rebooting or function reset.  For example,
> 
>   1. Initial power up and kernel boot:
> 	# lspci -s 2e:00.1 -vv | grep MSI-X
> 	        Capabilities: [a0] MSI-X: Enable+ Count=8 Masked-
> 
>   2. Device VF configuration change happens with no reset

Is this an out of tree driver problem?

The intree way to alter the MSI configuration is via
sriov_set_msix_vec_count, and there is only one in-tree driver that
uses it right now.

If something is going wrong here it should be fixed in the
sriov_set_msix_vec_count() machinery, possibly in the pci core to
synchronize the msi_domain view of the world.

Jason
