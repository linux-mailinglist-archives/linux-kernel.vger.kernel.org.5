Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0464A803516
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235551AbjLDNiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbjLDNiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:38:08 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18704271C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 05:27:35 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-77efe9be09fso27508185a.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 05:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701696454; x=1702301254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D9LwUnJIABIYXynmRpnw8pFA/pix8HVAwnnjKzJe6go=;
        b=IFfed4nRNRW34bnfJg0K5t+m7Qs/6Ibys9PBnRhbntxFz1p70fTUj9Sdz7E2p89/GH
         5ZnUmfpVDqcjJc8TVh29Zo8hnUMidkibRGpcbqM05hHTYkFMXk8BNhvVG9LW4wTYz1rU
         FNcILSfSOzss+x55aKQykriC9tM3LEs37qV5Xom4E409/PyCK0mXt8ZltCslONcG9CXw
         hYRq7Qwb8mqslU1Ss9XDxU6PZESOmTAyH1LDpkqIaWrWDXxHQU3E92EJo3AIU2rQQsBP
         JmGmIQOWbVNmywxyHBZU1jo2mcMyLWkdhYvxRB5NMegtb1IpSaEZafkLIPy+vMFMqge0
         QjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701696454; x=1702301254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9LwUnJIABIYXynmRpnw8pFA/pix8HVAwnnjKzJe6go=;
        b=q8Sahux2G7eCkk+ynI0NWDxVdSbn4Rq3yOkY6ac1E13FDH0/fO6HRCf6wwd/NfH0fL
         R+lJkj+F9ASL6NFRjMFJOVzBfrlQSeFXgaPF7J3KbkbL3IIyYHSsC//AmygHp85BRrUO
         a2lRCp2E0WKcwQjN8qULTH2xvqOHZD1ZARVMGitlGuQPHS7kH67ZkORwjcL0OmcVj4rk
         9Oyd4NFDeKn0qafWpXwIH90WIyLC30qqbk9XS8Q2Ji18jKXxfx8bbchlHmFDxs0Ec2LE
         b/udEI5PnpiSrqjz2zNcuz/qy+o5Ibf8u6VWsvCQZTA6wZ47fdZXkw0Xo6iZTO87IofE
         82Aw==
X-Gm-Message-State: AOJu0Yx8okrJroJaEzRC5ixrI84eMcVjCZuJ9l1aSO8w+M5b1UPaNngx
        SwGMH+03gyE2EconjFPfErS0jSAfpC3qYA0ACMQ=
X-Google-Smtp-Source: AGHT+IFwJd+mm5yr9E/Hib/UfERIuq8yXaFwHF06npvbzKqM7QtB126feDLE1ZVHpqSCvPB5b1ED4w==
X-Received: by 2002:a05:620a:1913:b0:77e:fba3:a787 with SMTP id bj19-20020a05620a191300b0077efba3a787mr2055508qkb.101.1701696454008;
        Mon, 04 Dec 2023 05:27:34 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id l15-20020ae9f00f000000b0077da8c0936asm4239213qkg.107.2023.12.04.05.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 05:27:33 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1rA8yz-00AsTP-01;
        Mon, 04 Dec 2023 09:27:33 -0400
Date:   Mon, 4 Dec 2023 09:27:32 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>, iommu@lists.linux.dev,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 12/12] iommu: Improve iopf_queue_flush_dev()
Message-ID: <20231204132732.GM1489931@ziepe.ca>
References: <20231115030226.16700-1-baolu.lu@linux.intel.com>
 <20231115030226.16700-13-baolu.lu@linux.intel.com>
 <20231201203536.GG1489931@ziepe.ca>
 <93a57e63-352c-407c-ac3f-4b91c11d925d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93a57e63-352c-407c-ac3f-4b91c11d925d@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 11:46:30AM +0800, Baolu Lu wrote:
> On 12/2/23 4:35 AM, Jason Gunthorpe wrote:

> I am wondering whether we can take patch 1/12 ~ 10/12 of this series as
> a first step, a refactoring effort to support delivering iopf to
> userspace? I will follow up with one or multiple series to add the
> optimizations.

I think that is reasonable, though I would change the earlier patch to
use RCU to obtain the fault data.

Jason
