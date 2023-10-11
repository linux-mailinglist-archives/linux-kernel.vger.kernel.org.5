Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184217C5861
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 17:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346724AbjJKPol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 11:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235062AbjJKPoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 11:44:39 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7775A4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 08:44:37 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d852b28ec3bso7529526276.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 08:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1697039077; x=1697643877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WoB38qVrfy0Z5NrFm6D5FEtkeSsKsFCNUumBknFNT7k=;
        b=VYmvKHEIACqtMdWPZoZbxP2j9r6yoNPWRjeO1ll2uIUsKRTRTtf+vedcZElvrB2c2m
         aJjFeNpvNSyZN8++zGb0PXZLkns6wOKu6A5Vtbr/t7Gj9bOeThvr8bC5gNWY9qtB2WtY
         H97iMIsCWKh3Ap4rUz4O3nOb8DOdIOScJ4AfYqWp73zjrPYJUBqZug4TBOPrnkMFecUk
         hdWYeiJYbMWZphwkEzvFRI73ml2oNCexSLOoem6dyBogermr0pArl2ZQimg3P+Vy27Lk
         xazFgy4qfUhfTSBOM6qKGWxrz61FWTMh42g757Jk360+sy5p7SZt0l30YYqHDF2YNXMX
         7oEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697039077; x=1697643877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WoB38qVrfy0Z5NrFm6D5FEtkeSsKsFCNUumBknFNT7k=;
        b=vCQ4Go2/LWjG6osKa6Dm5w5ZFKUMALOk6l0y4x1/Tucme2wK1wyATZHBYABToJ+ffV
         jzJgXSbNqTWReHvu+eN4PZ6ouT4hB7KBEftriDAAhrB+CTpB8t0KzkjueBMgCDZ5oTJf
         anbxRmNnh4r1HhMzE9qJJqusGvTmp8mr9O1pv3tnhyWgzkgBMe9pzW2xo+bXp6OS3bV4
         OPpuG6Tivx0KlgJrjE21V5PEL+SpqmuBkZquB/MilgQ/q9bLMGQdeX0xiXFDO5hfTMmO
         Tpezj21kTFKmm2u/sE+wJFwtENWzH43Znt9+7vzZF8JTCGttiadj8fkGSdsUdW88OyoC
         z7tA==
X-Gm-Message-State: AOJu0Yzr9vWzOGhhDRfH1oyyijH2k965ILzh1VRWV5MnKhprKWCoA65z
        f8xWG2cuQfdI0IuKF/HXvqiEPg==
X-Google-Smtp-Source: AGHT+IGPRIevfR60iyGshI42VdKzgNUrCL0njQ43RhfaylkSDbzn1Q4Db90GZVIb3bqd0dkp+tUWcQ==
X-Received: by 2002:a05:6902:202:b0:d91:fdb:afd4 with SMTP id j2-20020a056902020200b00d910fdbafd4mr18990169ybs.16.1697039077048;
        Wed, 11 Oct 2023 08:44:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id x8-20020a0ce0c8000000b00658266be23fsm5775096qvk.41.2023.10.11.08.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 08:44:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qqbNz-000hH9-N4;
        Wed, 11 Oct 2023 12:44:35 -0300
Date:   Wed, 11 Oct 2023 12:44:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tina Zhang <tina.zhang@intel.com>
Cc:     Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [v6 PATCH 2/5] iommu: Add mm_get_enqcmd_pasid() helper function
Message-ID: <20231011154435.GE55194@ziepe.ca>
References: <20231011065132.102676-1-tina.zhang@intel.com>
 <20231011065132.102676-3-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011065132.102676-3-tina.zhang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 02:51:29PM +0800, Tina Zhang wrote:
> mm_get_enqcmd_pasid() is for getting enqcmd pasid value.
> 
> The motivation is to replace mm->pasid with an iommu private data
> structure that is introduced in a later patch.

When you do v7 how about:

===

mm_get_enqcmd_pasid() should be used by architecture code and closely
related to learn the PASID value that the x86 ENQCMD operation should
use for the mm.

For the moment SMMUv3 uses this without any connection to ENQCMD, it
will be cleaned up similar to how the prior patch made VT-d use the
PASID argument of set_dev_pasid().

The motivation is to replace mm->pasid with an iommu private data
structure that is introduced in a later patch.

===

Jason
