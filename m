Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136AD7AA553
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbjIUW4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjIUWzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:55:45 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B551FFE
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:56:53 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-79f8e4108c3so26697639f.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695322613; x=1695927413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nNT2/tTxlFmIxWwqgo/0XCM90wCyMD1PzlNkeutky8A=;
        b=OUHULxWh2Rsisvlc484pzdxDO3XnRsvLP9hIpA1rH553W5M9dhvlj7k9R1ghaKivcB
         ZTe7XEGQ0OR46OPi4uLjIrFPRR3BD/VB1XEELeiGxG9CWC3tq1LifIToHkV3YPtdd4fN
         8h9i0zMutTvAFmdOzfFNiNH/H4gJRdR7y5e+wjyTcFEv9CSDPd2ri+tYPIwtsvYjjiyF
         XiLdKLE0a9x+WyXDKWshpNfwLeLN/4SLQTB1JPPNiZ8tVoSDP8Xs5t9aZF3n+eWmAJJZ
         1zPvK21HbZmWIOgJOrDyPa9RD4qKaUoZFiWvFTPt1LZK1s7db1PLmi0idzT7VIiRMLbg
         ZhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695322613; x=1695927413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNT2/tTxlFmIxWwqgo/0XCM90wCyMD1PzlNkeutky8A=;
        b=K02lkYT95tzmO+572WnBZKefHG1TqXDqxKpiP5uMg+YmgCmGVm6JXgZ1uhqrmwBT9F
         oq7B20+Mhew59BQZhFWpYHMgeqCqj1jZs6200E1ZKJ1zsyPNJpaOTziWlyv45XeK3Eo/
         CiEtYKINVD/SBvZEVHMFvFzInNq99mAKUH3DtZOYIXmEfrYT59SVrv3QwexiZwUjJVR9
         K5E7d3Zlad2mN8pyeNwv2atLI8BMK1DZ/7V1xgSyx3FmwLZ8h3LJMf1jXAJ61Iq61212
         Liykfu90hqvKeF4fcQ2gs12xU15kYYJaK1Lc3zQ4UrbOZx4cafkUCNL9BRdBZvXwi6fO
         Vjrw==
X-Gm-Message-State: AOJu0YwP4bbHnXgiwu0KvPS/lTurqDiZD0on6HjvCWanf5l2cX7q6hJn
        EUDj4ope2KQ8jgKlsSVb/sttcQ==
X-Google-Smtp-Source: AGHT+IEpXdSCS2/x8+X3w0VeAWP4DHLj6wedh+rIY6iO2wK8du2iUVOGQatU5YmHQ+hAKcF5W2XBpQ==
X-Received: by 2002:a05:6e02:1302:b0:34f:c9b4:5f9c with SMTP id g2-20020a056e02130200b0034fc9b45f9cmr6008080ilr.31.1695322611693;
        Thu, 21 Sep 2023 11:56:51 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id y10-20020a63b50a000000b0057412d84d25sm1649420pge.4.2023.09.21.11.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 11:56:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qjOr2-000TTV-F8;
        Thu, 21 Sep 2023 15:56:48 -0300
Date:   Thu, 21 Sep 2023 15:56:48 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tina Zhang <tina.zhang@intel.com>
Cc:     Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/6] iommu/vt-d: Remove mm->pasid in
 intel_sva_bind_mm()
Message-ID: <20230921185648.GY13795@ziepe.ca>
References: <20230912125936.722348-1-tina.zhang@intel.com>
 <20230912125936.722348-3-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912125936.722348-3-tina.zhang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 08:59:32PM +0800, Tina Zhang wrote:
> The pasid is passed in as a parameter through .set_dev_pasid() callback.
> Thus, intel_sva_bind_mm() can directly use it instead of retrieving the
> pasid value from mm->pasid.
> 
> Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
>  drivers/iommu/intel/svm.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

I would order this patch first in the series

Jason
