Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A96E7914B0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 11:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352644AbjIDJZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 05:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbjIDJZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 05:25:12 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DAB18D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 02:25:08 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5650ef42f6dso417693a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 02:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693819508; x=1694424308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ues6LUWpFGpYu+/cfSbGGj3jXqDVy5KCS5rD+HIDMCs=;
        b=UUSul7wPNYeGw5YWumOh+OR3rhuxQlSUphv9R4TJCZB76ii8wL9n79ZsQyqmpdvrmK
         W4qVTUbkpEglL5IU3sjh0h1IGpqy2qe3yEJKWxgLo/wHke7qcJ0UcLOjY1VSck9rPWSP
         ZFj5SzQmrH7qpcSKcfs9WXv+DOUciIsgJ+FbpKqbSprL/bNUgVYS12sFlwl2a8uWSx7i
         a1OQGq9AwCGq58ZYfKQRCpeN1ch+DOPW+U0f2VuOl9LzZJ5oB41AfVBugsOYbmzEOIJm
         e9/+EIOH+otopMH/4RbJb0+5mQmsZdv94s6bLmT6TB+OWdz4bR67mO1FGIRaSPWNPYPo
         SIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693819508; x=1694424308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ues6LUWpFGpYu+/cfSbGGj3jXqDVy5KCS5rD+HIDMCs=;
        b=QJNC1nKp+Zt/JQE/ulVGiBJc7N0UrKUhWOITcKbD0hRPevjJvJfH8mY1TqHW0HaRW8
         WbtmPQS8Yk7b3E7uFQb2s4uQZaMqBSZGnTrm2WmHMf5O/2o41YTfDW+OSUXiIvuIYw98
         Ucg6DGBBAOqatvnUgRRUv76ckwOKU6KWbFPoXfS4dr7+Bp+mfyAIFcmFCPZunCJz28LD
         9iz9Ph9FGmeziK6aPfEvTbGvBSTE5Mbiycg7k7slGbZj9qoPRQYgPpWk2RoUrSaaYHBz
         Hqou+LGZQwCTz9AGfKzsU+MrJ2nWF7IA4v4U3VURojNMUAUw4foATXFi1uKSSpE+vt1y
         nz2g==
X-Gm-Message-State: AOJu0YywIlRkZc93xOD/toKcwhZdZ3ImRbh+iGGZGm909Y3OwTFGgVfV
        fqYkPM09kmaBA8wd2mOvoHc8Ug==
X-Google-Smtp-Source: AGHT+IH1BfUzOyLUHipTNv5d/4cfbsYQWRWIORpIpPKSE97wMQmC/h9DYCK3cAyjm242/7rPEo1kFA==
X-Received: by 2002:a05:6a21:4881:b0:137:fa5:8519 with SMTP id av1-20020a056a21488100b001370fa58519mr6436764pzc.31.1693819507870;
        Mon, 04 Sep 2023 02:25:07 -0700 (PDT)
Received: from leoy-huanghe.lan ([98.98.49.29])
        by smtp.gmail.com with ESMTPSA id j2-20020a170902da8200b001b53c8659fesm7169522plx.30.2023.09.04.02.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 02:25:07 -0700 (PDT)
Date:   Mon, 4 Sep 2023 17:25:03 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Remove myself as a Arm CoreSight reviewer
Message-ID: <20230904092503.GA388456@leoy-huanghe.lan>
References: <20230518095345.1755105-1-leo.yan@linaro.org>
 <977b845a-eb99-ec53-3aa9-a395744b68a2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <977b845a-eb99-ec53-3aa9-a395744b68a2@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 09:05:52AM +0100, Suzuki Kuruppassery Poulose wrote:
> Hi Leo
> 
> On 18/05/2023 10:53, Leo Yan wrote:
> > I haven't done any meaningful work for a long while on Arm CoreSight and
> > it's unlikely I'll be able to do related work in the future.
> > 
> > Remove myself from the Arm CoreSight "Reviewers" list.
> 
> Apologies for missing this one. Trust me, it was not intentional ;-)
> This however conflicts with what we have in next. Are you able to
> resend this at -rc1 ?

No worries, Suzuki!  Have rebased the patch and sent it out.

Thanks,
Leo
