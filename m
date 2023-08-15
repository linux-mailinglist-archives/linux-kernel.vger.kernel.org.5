Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F06277CC08
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236879AbjHOLuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236870AbjHOLtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:49:41 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6009A1986
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 04:49:30 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-410487ca3d6so12276861cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 04:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1692100169; x=1692704969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T+oV4OJqksoKrrOVqvE1dcZLounPv8Ok3JnUcRmYUME=;
        b=STewdZOUFdZkhOBFpHmxizNZ1c1uO8h9AahPqSM/bT5mtfAMxp/JPdVz2gwZqkGmYX
         CXUOy9IYCXGCzF3+rDerXnpoPRTSaME6gIV3+YX4He/3RwZ7YmZPtKP4okT4gQ5aVN20
         6cWEK8KTmk8A3mcW+j+gCNyyaMNei4bg0w0ZT+dDgr+wEOaUGbEe0JwkFSF22bDlAy4J
         esSPi0q4M3Ba0gD3p3CWj3sM/8FZucH6suDWsInP9IETZM/LcMw/APtN+NszrWsHvIIT
         i0v+RG6adtYNoRGQcTvaigBB2aFfCfvZNouda14VkK1JFzxsap17cqjYeHh8VzXo07yw
         dvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692100169; x=1692704969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+oV4OJqksoKrrOVqvE1dcZLounPv8Ok3JnUcRmYUME=;
        b=XMFqduAXVjm4anMwVgnP3/zrjpYkj6CqOke8kb01Ccus+hnTfh5KjnnjMPwbK6AZXf
         ejMK7A2dc8PWAXPT4pJy/YjkrmWB15FisX9IzzBGBf/Ui+W7tAMgn8L9jqP4F8+EXX5e
         lBQR7L7qnVYitesnViUuyRBD6TZLA08MN9IT/mF6/jQHxYeh59yYWdxu867kPQhAr05u
         Z8slej7rtNyt2C6xIIEQ77mjUEFq7M02dxVnngHuXCVTyR9XDdza8H3XLi7wPHNPlU9y
         bW5p/Ig+Dicwb/9mF21538JcfvLJ07PD8YRrDblbvJz92zCuOceidyGk2u9qTPQ4lFYY
         9jaQ==
X-Gm-Message-State: AOJu0YyuI88p/4uhcnbPo3k/hqrB7tZ1gxCbu23mxh5LyqV40TrM9Mdd
        8+mHFfkZa2Ooo1ofCDP/G4GpvQ==
X-Google-Smtp-Source: AGHT+IFYlxCaiz/GhuJRu3EPuGKafe/PtsfPGq6WvwzBhtCzK32OsxzfaAmFeIUznd0xlljtiCY5Gw==
X-Received: by 2002:ac8:5bcd:0:b0:3ff:23e4:40b4 with SMTP id b13-20020ac85bcd000000b003ff23e440b4mr16770979qtb.42.1692100169514;
        Tue, 15 Aug 2023 04:49:29 -0700 (PDT)
Received: from ziepe.ca ([24.114.95.117])
        by smtp.gmail.com with ESMTPSA id bq22-20020a05622a1c1600b00406b11a54b8sm3749564qtb.7.2023.08.15.04.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 04:49:28 -0700 (PDT)
Received: from jgg by NV-9X0Z6D3. with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qVsJg-0000AV-Hm;
        Tue, 15 Aug 2023 08:34:28 -0300
Date:   Tue, 15 Aug 2023 08:34:28 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the iommufd tree
Message-ID: <ZNtixPkYKHnWiVv1@ziepe.ca>
References: <20230815210437.12bd89b0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815210437.12bd89b0@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 09:04:37PM +1000, Stephen Rothwell wrote:
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 20c9a0501760..1e017e1bf5ea 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -332,7 +332,7 @@ int iommu_device_register_bus(struct iommu_device *iommu,
>  	spin_unlock(&iommu_device_lock);
>  
>  	bus->iommu_ops = ops;
> -	err = bus_iommu_probe(bus);
> +	err = bus_iommu_probe(bus, iommu);
>  	if (err) {
>  		iommu_device_unregister_bus(iommu, bus, nb);
>  		return err;

This is the right fix

Thanks,
Jason

