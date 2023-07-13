Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051077517CF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 07:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbjGMFDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 01:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbjGMFC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 01:02:59 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C331734
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 22:02:58 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6686a05bc66so192500b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 22:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689224577; x=1691816577;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zmNRJ1DhhnpsNLZvHCU4oBTJzYSiuqq67vhMQEJqAGk=;
        b=FSat0dWd9nFI3BYX7PS5L4Ae6ndXJo5ilm08eo0j6QiVl6suiLWt9O2WpWJrmoUM+4
         6+RhUp6KBx067jkhzLhojOcCzT3oXo7W4softROP7hjZmm5S5u72/LFxKqYMxSow8HLM
         V4SJY4xf2bfEnVyKAWriEwvENDvWRNLYnWEnSG+7wziv1yy/E5PT8LUsS3fuR1kU6/gL
         kxunvNEDEf1mZSLO4Fst/gX87/8hheD/xk9GCC7kF3qxTdiXooEEueK+t7Fa2tLbFjCJ
         o2qSXJaAx48ZKbCv9cdA1Y3FKf9bnjTFxd1swjCjV9bUurGTW0o9WVdkzlEm85qFvWn2
         sCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689224578; x=1691816578;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zmNRJ1DhhnpsNLZvHCU4oBTJzYSiuqq67vhMQEJqAGk=;
        b=JE8gpMd3ujHnutkCer+jtqioEd/O/gkRHuyGM4rwGQ8LRgZKFhbOgk0Whk8bd6HOCB
         FJVCQTOluMJsdlui+NmQSgFcv1IDBy35AIO+Q5iqB66jSN76wvaNIB5WRHlSPFJasQAU
         3HBTO/i6XfJ1Q5ERNACd8Ncly8DoVxOGGy8stkE6Tb0FIshw9OvOCTGxmu9MG3S2E6VG
         CcI1gOmFefsLqKZzlNWJcKV9XjeLBUcjaQdRS0m1bmIrWbPkgdOulTbvZvSTeJ3OQBVE
         SAMSDfViHwzLmfy5XCSF5hMXNiC9AOTd5ahBkhCuMuLCfQEyvpJ0OYpbvmmNJrTdKuFl
         eC5Q==
X-Gm-Message-State: ABy/qLa0LTgu4LB4U+43BbelqEZAkjOdR5FcWKoXf4WilYpk6VmW3lyo
        rAEYFqRPAF8emvn1gF0KGTPe
X-Google-Smtp-Source: APBJJlE/YSQ1fGKxgw5Djc2nrADRvVNea6O9A00b/3toWdXISb2e7TQXf9rlBmJeV5tD7ldIg6d5nw==
X-Received: by 2002:a05:6a20:394f:b0:12f:952:11ee with SMTP id r15-20020a056a20394f00b0012f095211eemr173448pzg.43.1689224577534;
        Wed, 12 Jul 2023 22:02:57 -0700 (PDT)
Received: from thinkpad ([117.207.27.112])
        by smtp.gmail.com with ESMTPSA id c23-20020a170902cb1700b001b9bebbc621sm4847537ply.136.2023.07.12.22.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 22:02:56 -0700 (PDT)
Date:   Thu, 13 Jul 2023 10:32:48 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the mhi tree
Message-ID: <20230713050248.GA3047@thinkpad>
References: <20230713081411.43792927@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230713081411.43792927@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 08:14:11AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   8623c0a70ef6 ("bus: mhi: host: use vmalloc_array and vcalloc")
> 
> is missing a Signed-off-by from its committer.
> 

Doh! Fixed it now.

- Mani

> -- 
> Cheers,
> Stephen Rothwell



-- 
மணிவண்ணன் சதாசிவம்
