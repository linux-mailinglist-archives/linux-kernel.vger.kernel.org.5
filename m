Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940E47978CD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244794AbjIGQzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244892AbjIGQzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:55:25 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9E710CF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:54:58 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1c50438636fso799214fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 09:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1694105617; x=1694710417; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xETPG2OLwFNrEouFmEXlo345UOWEVFv+efIvPP2Gjrs=;
        b=IaYJ5NmiP72dhGwzelhOnje+8kho9EDFT0eppKqkSlNGKP3oeYSM/4BEvon8swFRnn
         u0/rotRZID/aTvGYqqACYE8wvnfO42CZRt2Fi1BKVRx/p/MXwAq3qqYOSururf9Zwy56
         XbRyEtelMxGT7CEarnRpofuNMRfDJIRi+6FzQmU1ecKCggWzhA8zulOEFtuvxG/jjXFb
         R9CWQC+BacUMplfemGzQilIMcJEpqWpnM/FxhvVeYpaptgAXiBaSHKQVREeJIDYl1h0K
         /SQUjghyaqzS2O4v9QYWKJJ+QtvFWRj1xfjFBPC1A1OIIovtWwjJl1bT+iB5OhSlQfWd
         OfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694105617; x=1694710417;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xETPG2OLwFNrEouFmEXlo345UOWEVFv+efIvPP2Gjrs=;
        b=UJcwd9E4xs35DJBB3EmQlQpBC4/09f02mUQzKkijNSdNX8UY4gjsLXkm6TNUQY5e7u
         Kg+IJsFi7PJ61R05r0qD6N5Tb9TjAFD+viPuN+IzJ9NEgqT26bRC98wFiSUkEPvDMAlV
         s6okKJp35kIyCWJnVKYefjtzq6Sob2kRpn4lSnivv3//vgB7ros8X6jEe5nXkb71o4qD
         TtpvfQE6HhUisclTNg2wXo0FznDZL3uz2ykRWD7WthbaFH/Tdc3nixF4my+jgGkIh2qI
         DRtnItbS8k6Cq7qQGvjAfVjwbyzvlIiMnomU8LW005WtAPItR0CW+Uo7fbF+Fikb4Ssq
         IXjw==
X-Gm-Message-State: AOJu0YwXIiutihzgtMGhaGml/eMRlr0vYfBpt4ZAbKYS4aqPljgWtr74
        p9Ouxqx31NjBHNcpfK99g9BJj64MI4tx5pBLG4Q=
X-Google-Smtp-Source: AGHT+IE4iJpYPS+1PG9GLANln9Pyz9DJZFOu5J69P7504oOvRN4SvG/ikZlC871o26AeGx016VTdfw==
X-Received: by 2002:a0c:ca06:0:b0:64f:51fe:859c with SMTP id c6-20020a0cca06000000b0064f51fe859cmr21170303qvk.43.1694103659597;
        Thu, 07 Sep 2023 09:20:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-134-41-202-196.dhcp-dynamic.fibreop.ns.bellaliant.net. [134.41.202.196])
        by smtp.gmail.com with ESMTPSA id d2-20020a0ce442000000b0063cf4d0d558sm6399607qvm.25.2023.09.07.09.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 09:20:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qeHkY-00179Y-Bs;
        Thu, 07 Sep 2023 13:20:58 -0300
Date:   Thu, 7 Sep 2023 13:20:58 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     oushixiong <oushixiong@kylinos.cn>
Cc:     Yishai Hadas <yishaih@nvidia.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Brett Creeley <brett.creeley@amd.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio/pds: Add missing PCI_IOV depends
Message-ID: <ZPn4agslpPV6STtN@ziepe.ca>
References: <20230906014942.1658769-1-oushixiong@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230906014942.1658769-1-oushixiong@kylinos.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 09:49:42AM +0800, oushixiong wrote:
> From: Shixiong Ou <oushixiong@kylinos.cn>
> 
> If PCI_ATS isn't set, then pdev->physfn is not defined.
> it causes a compilation issue:
> 
> ../drivers/vfio/pci/pds/vfio_dev.c:165:30: error: ‘struct pci_dev’ has no member named ‘physfn’; did you mean ‘is_physfn’?
>   165 |   __func__, pci_dev_id(pdev->physfn), pci_id, vf_id,
>       |                              ^~~~~~
> 
> So adding PCI_IOV depends to select PCI_ATS.
> 
> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
> ---
>  drivers/vfio/pci/pds/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
