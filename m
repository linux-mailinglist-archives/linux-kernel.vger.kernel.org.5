Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6C575BF18
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 08:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjGUGtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 02:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjGUGtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 02:49:01 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B8A10CB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 23:49:00 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-4036bd4fff1so234301cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 23:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689922139; x=1690526939;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hQfAD+gRLI1T8q/mSuX9jGerjy3VlrCpnWiJnxkvDK4=;
        b=PBzSzI5mVQ/5a0fwR+VlN0WqFzdvb24sVzYk0n0+bTqCQzQa9csh0dy4gS5kXQHp67
         MKkKSATVkGuzPY8qn5m2u/mvcGKjB4Zb9JlMp5FnzaHu4U4cZWIzwxZE3KBC5rwVRw1h
         NFTU4/E23Ju1Ci29D+suAsxxBZ4CJjUwd8JeyIvkj2ygeqjLKbZItldXD4pimtOnoixo
         y/FQhaHi6M2Hx0EG8StuDOSL+U/do7x+li8NJL5T/gTt8cy4HrxEbuw1cgMQAQxB9Fmr
         Az8pr28i8zXNh3NpIkNyfTJyunXmH8cvN/hRRSE+b0NiDvK19xOaxRzqZQnC7gCIlE9m
         nAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689922139; x=1690526939;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hQfAD+gRLI1T8q/mSuX9jGerjy3VlrCpnWiJnxkvDK4=;
        b=ijNj6WmV3jGe+aDUW31dvjovtixpt6dNW2QLe1j3kF7srxXhYOZzrrHFgRbmN41T1P
         Mjk+42Iedl8U0Aifaw8qMQ1EuRnmP7pMoQXaVMcx7MT6cPfrS4U1KtFB0YHneM2iJINv
         QY5/IsnSak0NbhbMpS9ialoYvAzN36Ds7cv0YYCOp0He1b1vFSIUZttDSZdlCL1ihQhL
         bfvTgaXnvO0kcezitCuYMwakDJGFQ79JpFH/Jdq53PajnVw8K4aDj2In/DS3Srvo5hZ7
         RLPts607/wlUM3oqm/HtbWDmxH6u6IwONH/mENHGxGLUx2SHfRT/JD9mNwwzk84YsjA4
         nrmQ==
X-Gm-Message-State: ABy/qLYkn/eOwfUZ+7qZKjA8AA1BHFd28tRa1+IUD5/8xiOUHPHFu6g+
        yrVam5JIS3VVaZozvlshFmeQ+LRb4qg+850aorUTqg==
X-Google-Smtp-Source: APBJJlEld3XqjQTnMeJZ2GV04gPcS+P8zcQ/fL27WUjm6UoEiTkHArYFvXo8lTGeifb9JjvEN7kHAFibO6MUi3PDPZI=
X-Received: by 2002:ac8:5716:0:b0:3ef:302c:319e with SMTP id
 22-20020ac85716000000b003ef302c319emr186241qtw.8.1689922139427; Thu, 20 Jul
 2023 23:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com> <20230621063825.268890-8-mshavit@google.com>
 <ZK9cyDaFkAKc1SvJ@Asurada-Nvidia>
In-Reply-To: <ZK9cyDaFkAKc1SvJ@Asurada-Nvidia>
From:   Michael Shavit <mshavit@google.com>
Date:   Fri, 21 Jul 2023 14:48:23 +0800
Message-ID: <CAKHBV27FbpJHoPC5_8mCYHmhEbCaCE7st_-qzPv0uQYSH3RC9g@mail.gmail.com>
Subject: Re: [PATCH v4 07/13] iommu/arm-smmu-v3: Keep track of attached ssids
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        jgg@nvidia.com, baolu.lu@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> And since we have a group of subdomains that are simply indexed
> by ssids, perhaps we can add an xarray to store a subdomain ptr
> along with an ssid, replacing the list?

Hmmmm, I think the only place where we search through the list for a
specific SSID is during remove_dev_pasid. We mostly use the list to
iterate over  all the masters/ssids that this domain is attached to.
I'm not sure if moving to an xarray to optimize the remove_dev_pasid
call is worth it (at the cost of iterations which IIUC would become N
log(N))
