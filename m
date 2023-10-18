Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B887CEB91
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjJRXG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJRXG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:06:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9872113
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 16:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697670372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=emwLO1oEgFxoohwR39m91tAAqusjqAjflYtV60nLTMw=;
        b=dZ1eYnR0V973yD3Rvq1RLynNi2e6K9OjpMf0I2wuIVOmtSi9IhGdxitdpFuVVTXeauqH3k
        taJu1h5bNq0pFNu3cuulf/p2dquLJhOApW8F/CxA0kfBx8CdPwQkYLSpJvcahVLswbpvsh
        q+WSzN/mf9pTKPVI/Z7ynEdfdYJpJsM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-0BL1qRPWPqqD5gvhLU5pxg-1; Wed, 18 Oct 2023 19:05:56 -0400
X-MC-Unique: 0BL1qRPWPqqD5gvhLU5pxg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7788f0f099fso219051285a.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 16:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697670356; x=1698275156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emwLO1oEgFxoohwR39m91tAAqusjqAjflYtV60nLTMw=;
        b=LViWb5W4kr6V2w/KKkyi81JC+UT6LMAfm4GtPlu4Kzpa2qXL1/7fXbgCCkcWFwAzfg
         8MoUfkshMLWi1sQvQrszbT/lmVlyS8ygkFPIk/A1m9s9rMkZebAyA7BhPOuO8sb++tqQ
         XazNyS8iDs9KJqvnPrNy4JrOWoZuHEV3uydYtySoJWfkb7Ko9I0WFsxFi4lmd/sowU/3
         QzoPA2DcUqXcwefCrbpPFfMnkzXcQyymEbeeq1a3b4n+0hmPWcZfXjjINWNfs5WBRYWB
         y+zhfH+cBmA+Ecjq/0G2zlVEzNqLkmo+kPHTC8cB8deRi7h8cqRFk6Wotd5YWV88fpjV
         g3pQ==
X-Gm-Message-State: AOJu0YzZ/bQWcMv83bH8sr+x/Zib0OfuplnsjErKWTV42jN2gfCI5oVG
        7iaSu8VKrA/7HY6bVQrtICIMedon2dtkJ42n3p0kytvumFbDPxB/gOVWTdGXp2df2PwPc26GhUT
        yDd15h+MCXbAowWK5VWrnjIWF
X-Received: by 2002:a05:620a:3d96:b0:773:eeb1:ed1 with SMTP id ts22-20020a05620a3d9600b00773eeb10ed1mr568311qkn.51.1697670356140;
        Wed, 18 Oct 2023 16:05:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGrsMiHhEWrXRi/9hyvAu7EMDkO8fLMcZWguNzwo9WCS48RlQAIEWo7JYyQZD6lhLG3E/brA==
X-Received: by 2002:a05:620a:3d96:b0:773:eeb1:ed1 with SMTP id ts22-20020a05620a3d9600b00773eeb10ed1mr568299qkn.51.1697670355940;
        Wed, 18 Oct 2023 16:05:55 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id e25-20020a05620a209900b007742ad3047asm307347qka.54.2023.10.18.16.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 16:05:55 -0700 (PDT)
Date:   Wed, 18 Oct 2023 16:05:54 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        jgg@nvidia.com, baolu.lu@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/7] iommu: Decouple iommu_present() from bus ops
Message-ID: <hczdhgxyhpdjvwl4k5e77g2id33gjmduwcdfye65qxpdu2n5fn@g2byzbj47kff>
References: <cover.1697047261.git.robin.murphy@arm.com>
 <6711338e24dd1edfd02187f25cf40d8622cefdb2.1697047261.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6711338e24dd1edfd02187f25cf40d8622cefdb2.1697047261.git.robin.murphy@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 07:14:49PM +0100, Robin Murphy wrote:
> Much as I'd like to remove iommu_present(), the final remaining users
> are proving stubbornly difficult to clean up, so kick that can down the
> road and just rework it to preserve the current behaviour without
> depending on bus ops. Since commit 57365a04c921 ("iommu: Move bus setup
> to IOMMU device registration"), any registered IOMMU instance is already
> considered "present" for every entry in iommu_buses, so it's simply a
> case of validating the bus and checking we have at least once IOMMU.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> ---
> 
> v3: Tweak to use the ops-based check rather than group-based, to
>     properly match the existing behaviour
> v4: Just look for IOMMU instances instead of managed devices
> ---

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

