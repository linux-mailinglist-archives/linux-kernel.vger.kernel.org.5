Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35CD7D6D62
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 15:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbjJYNeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 09:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344564AbjJYNek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:34:40 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9484F182
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 06:34:38 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3b2e4107f47so4029788b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 06:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1698240878; x=1698845678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yWRrV8TrzcGhn3y1mwcKlcTnHxjvKLZ2v/fGWRYHR+Y=;
        b=DpG18zMcKs3ColGZAapMl1CKV1cFvDZaGTWUERIMODAkYeqzLUES7pVAxuspIFkhvc
         JeJ3hhaXWzyGa55J8V4yvjfe3JBsVcJaUi2hd95fXNuTY3BVfeq7NH8jjbFr7LdqrX4K
         JNYhYMD2+13IS9+jO3CjAb0ZwjVzAbnzDaMJBIwrDMUjVzySJUvGWnglRmbfjf7q3Qwd
         4X+9eBDEjDy69CupQaNrrcjHh+U7Zj9HlL8OM4Vl+wC5sDFdXrY7S1xmB4xFkFp+QfV2
         VS87FnYwB+/8te+5a9EbCbBivofXUjl6CXBaUrpyiUfX2noTw0rFtVvpwBbiGXXHDxlk
         /1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698240878; x=1698845678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWRrV8TrzcGhn3y1mwcKlcTnHxjvKLZ2v/fGWRYHR+Y=;
        b=STsNtwU8VubdeIU37JeQCsFUlDVaSQs4p8SJOYt2CrrBEds6sXCwAkCStK8Ztssz0e
         Jrw98SXPnEvbKnLQvUU08WuBfXeKzE880NlUirSndMuJaUD5sJ072h8dz3+VV7L6cG2g
         Zga7FWU5EyVFCESEmc6pS8hUM6vU2pg4BtPMh7DR1flOBepVMpwZpOqHbpTlEYndsRi4
         5cUTwiB3iFbU6samz2MDWO5z6MllMuZlmzB8gGsVgBb50xenEJO6Zk5k6XJQyxTuryQm
         3kYaV6qfDtXZWYOZ0VY02MO67Y3jY9Ok/mf+tiX8SsKD4XtnyA+7dQkx52kjvI2rFluq
         iA2Q==
X-Gm-Message-State: AOJu0YzRxs3abyADlELPLHDk091V6PbKyhApdUHgZ4mwA/sduhoYNPtV
        qYx+HsPahOND4OyOdg6HaQK56B28ufVTVRQytJ4=
X-Google-Smtp-Source: AGHT+IF2TgXBS3eDpm+PeKpS/zyKzW+Q8bERmNhr7qjghP/HnyXpWPs8Xo07ycy873fwfyVKg1IAww==
X-Received: by 2002:a05:6808:b29:b0:3b2:f576:3f97 with SMTP id t9-20020a0568080b2900b003b2f5763f97mr15973522oij.12.1698240877826;
        Wed, 25 Oct 2023 06:34:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id a26-20020a05680802da00b003ae0e57874fsm2370339oid.21.2023.10.25.06.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 06:34:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qve1s-004gmc-4f;
        Wed, 25 Oct 2023 10:34:36 -0300
Date:   Wed, 25 Oct 2023 10:34:36 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Revert "iommu/vt-d: Remove unused function"
Message-ID: <20231025133436.GP691768@ziepe.ca>
References: <20231025131854.375388-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025131854.375388-1-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 09:18:54PM +0800, Lu Baolu wrote:
> This reverts commit c61c255e114c52682546447ed44d3470b5708134.
> 
> The pasid_set_wpe() helper, which was removed by the reverted commit,
> is still used by the nesting translation support in the iommufd tree.
> To avoid a merge conflict, revert the commit.
> 
> Link: https://lore.kernel.org/linux-kernel/20231025153455.283c5b12@canb.auug.org.au/
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/pasid.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Needed to avoid ugly conflicts with iommufd, Joerg please take it

Jason
