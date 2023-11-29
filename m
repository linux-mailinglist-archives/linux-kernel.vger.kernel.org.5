Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BCA7FE0E0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 21:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjK2USf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 15:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjK2USe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 15:18:34 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95A5D67
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:18:40 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3b83ed78a91so106358b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701289120; x=1701893920; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Lp53QluNv4WhhdcXZkD4YoVlGdIpJB4VhJ1Lx/HjyA=;
        b=ZMkuqEdhdBnajAZ80cMj30hgdtfUvcBCH1ra697mDkBeNucu9ddv5IlVJXy+/mvSGL
         R/2fOzZ01p6R4hQYKOl0jIMO7zuqzTxfFpenYSfNQDCCdF1+IZ4x84KYuEqbFxXw98el
         5qLL3q9ay6XFigl3nUMbkYJ9yHJpHlyfuVP9lwKLJZVxaIoxqOTPG3K20fWKI5rPDuLm
         bu3klCuqm7OqRNCHi/Ye+qfq1euaklh5PhCezvbApRVsGZd3EvNw0vyxwpEIXPteiir9
         5VXcwScTMDMEso+kbUIuJT6n6bUZpjKkRr6nBqpLvN/AeNb46OX34Lt2mGDpE29kE504
         nvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701289120; x=1701893920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Lp53QluNv4WhhdcXZkD4YoVlGdIpJB4VhJ1Lx/HjyA=;
        b=NzM8Ph0/Hwcik/4JOysZnxMwVICnQQ6PXtO7IuAs3BDbbmokPZNnHQh+uxjkQ3mgWu
         oTwW8uP9V8InN779cq036iXh46sw3pHvL1YfCQpvbWjwLnLMHnAamy2mIvpNZGufIlSr
         zyn0khhIB15qiefDkJfyFmX490KjCN+5I5Awn7N7Wd5cn4hGdE2tmsNr+9hmw83XhxfS
         kwXHAa9E7hROdHHz0X6RjDiFOBccf6NJGBiCrYKCrY1uORPt0ogTrRUSC3YsOtqsRjYc
         EhjE5hW/jj9wCRIRTzYta90FoSQDJqQpaRsrI8f/Mw5PcRPT548DBsq5xd4mwTitNlFw
         CusA==
X-Gm-Message-State: AOJu0YykBi1oOGqB+Quo7az6f02qqEdtkduiTuQTpyry+0MU6b6BO1er
        5BvPV1ULcBoHdc70tILw3tk66g==
X-Google-Smtp-Source: AGHT+IERXfBnQQiRryRCqi6gVZlah11bhAemTbrIbuIkAC7r69cFrbq/dBpIPM2clwdqrYccLzDwHQ==
X-Received: by 2002:a05:6808:1645:b0:3b8:3e7c:f827 with SMTP id az5-20020a056808164500b003b83e7cf827mr22187927oib.14.1701289120221;
        Wed, 29 Nov 2023 12:18:40 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id m6-20020a0568080f0600b003b8459f2ec5sm2354758oiw.55.2023.11.29.12.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 12:18:39 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r8R14-005pWb-UE;
        Wed, 29 Nov 2023 16:18:38 -0400
Date:   Wed, 29 Nov 2023 16:18:38 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Brett Creeley <brett.creeley@amd.com>
Cc:     yishaih@nvidia.com, shameerali.kolothum.thodi@huawei.com,
        kevin.tian@intel.com, alex.williamson@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        shannon.nelson@amd.com
Subject: Re: [PATCH v2 vfio 0/6] vfio/pds: Clean-ups and multi-region support
Message-ID: <20231129201838.GM1312390@ziepe.ca>
References: <20231117001207.2793-1-brett.creeley@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117001207.2793-1-brett.creeley@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 04:12:01PM -0800, Brett Creeley wrote:
> This series contains various clean-ups, improvements, and support
> for multiple dirty tracking regions. The majority of clean-up and
> improvements are in preparation for the last patch in the series,
> which adds support for multiple dirty tracking regions.

I did not look closely at every line but this looked Ok to me

Thanks,
Jason
