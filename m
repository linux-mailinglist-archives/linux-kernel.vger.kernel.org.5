Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1EC7E6170
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 01:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjKIAdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 19:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjKIAdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 19:33:09 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545EF2694
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 16:33:07 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1eb7a8e9dd0so143266fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 16:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1699489986; x=1700094786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XpvSVpOIuoICwr0eisYk7Xi99IWTfuOr8GvS2fUSAq4=;
        b=LkKOz0dwjQBJdrBh/iSrAEha7KCXzAzUuHWyCGZ90WfdcvuIYlBdnwO9RW4TVV1bLY
         Y4rb60gcN4AVmRpgDUFt1pORH4Fg8jHVbIkOmJyJwKpcsuRgI49JNQSLt8alLZ15BFnG
         ust3wRzobIBhUCpyKJaAI2iak6fJPoXS6WR7SZ0Yuk2OKkvMxlkKXw8pNuFFMzR1uu7i
         QjHYCtKGB52Xa9T68w0xylQ/ZVkZNtmtnollQQjgPl4ryMK/nTzLunSSx3eqoyThc6E1
         HL7DqLS4Hj2U45Yf5ssUac5M9pIEhEUFyPW1HcUO2Q9ov0KgTQE9gxrASDC+vlPnNH+D
         wBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699489986; x=1700094786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XpvSVpOIuoICwr0eisYk7Xi99IWTfuOr8GvS2fUSAq4=;
        b=NP8IMcjwEQt28J9jeh4kdKyGZ/XP/mjx1Dl0Q72WGL2oZru5O4TSYUBOqC+VMYPGeh
         w//7EQwl8brK37aageNmnWTpAa823yWTFsMbbHmpJHG16ARr4MEHJLwaDYj343umjbGI
         A4MKxyCp/QRsxwi9arF6vaUL1KJHDwvMPPRhOinW9oAum5EyzHEfiaqkSbJOSsc2m2qq
         C9HkqRI/gp94J2oD4P5+ENGSECIEsZct3bPZBy0hhCpfdbn1L/G/zfVtzCVvxudmTrGT
         Ovng/wfI9t/NEh4s/GXmI6zD3wPETWUyy73YQT5ei12II9gvV9459+fl9gCySidj8K4Z
         W43g==
X-Gm-Message-State: AOJu0YxCvoxYYeToLaNHi0V1fV2zmEmsto9Aj4hiNncsHt6WiAH05W8/
        0JaeYHmwwtYMUqAIXbGnlZiOJw==
X-Google-Smtp-Source: AGHT+IF96nOKOaNh89TNNrC8DvAIA42Xn4IPrYpq+5CGXZoyWBXuWbQokFnyps+CZE1BYCDOJhxJVg==
X-Received: by 2002:a05:6870:1290:b0:1f0:36b6:ef26 with SMTP id 16-20020a056870129000b001f036b6ef26mr3049223oal.46.1699489986633;
        Wed, 08 Nov 2023 16:33:06 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id ki14-20020a056871bcce00b001eb7196de06sm508956oac.54.2023.11.08.16.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 16:33:05 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r0sym-001jjD-8L;
        Wed, 08 Nov 2023 20:33:04 -0400
Date:   Wed, 8 Nov 2023 20:33:04 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Zhang, Tina" <tina.zhang@intel.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/5] iommu/vt-d: Add generic IO page table support
Message-ID: <20231109003304.GG4634@ziepe.ca>
References: <20231106071226.9656-1-tina.zhang@intel.com>
 <20231106071226.9656-3-tina.zhang@intel.com>
 <20231106193228.GU4634@ziepe.ca>
 <MW5PR11MB5881FC3D9DBF14D6BD07025489AFA@MW5PR11MB5881.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR11MB5881FC3D9DBF14D6BD07025489AFA@MW5PR11MB5881.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 12:10:59AM +0000, Zhang, Tina wrote:

> > If this is going to happen can we also convert vt-d to actually use the io page
> > table stuff directly and shuffle the code around so it is structured like the rest of
> > the io page table implementations?

> Converting VT-d driver to use io page table involves much code
> change. I made a local version of it, and it didn't prove much
> benefit.

Well, it structures the code in a similar way to all the other
drivers, though I admit to having not looked closely at the io page
table stuff.
 
> VT-d only supports one 1st-stage IO pgtable format and one 2nd-stage
> IO pgtable format. So, the current IO pgtable handling operations
> seems more efficient comparing to adding another layer callbacks in
> them.

I would like to de-virtualize those callbacks, is is completely
pointless when we have per-format iommu_domain ops now.

Jason
