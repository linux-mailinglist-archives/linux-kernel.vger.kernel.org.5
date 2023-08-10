Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2074E777DED
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbjHJQPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjHJQPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:15:23 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8265EE69;
        Thu, 10 Aug 2023 09:15:23 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bba54f7eefso15769345ad.1;
        Thu, 10 Aug 2023 09:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691684123; x=1692288923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZVqbHV+QG5GsPVQyZyu89m2UgvCEHBysqsbECKUvsgM=;
        b=VwzCKhaPMwglG5KggDpTUmyhicW2VNofcGN0/8+GUvXD8mnw2q8UG219D52DCMxIZb
         9sscV2l8e1CL429IVvICiz9LQfhRfjIQgV4cxPkz89gw1kcR7lL+YdcPUGHnS0uX3H/u
         8lXDHXLey+VJNEERD5qbDg65u78bHoq/cHP4ed2IAljq2JWAhXCY0qXmxEvUX0CRFgz/
         3KzqD48KU99lSbwL5nCqWslPv6VDP3vo4hqgtpIOIFUkS48n5/eoy1F2R/+r+TyV0uPy
         h7gYiYggyONGtlUEVOQCVkvzsNeb1/20NNPZjx88TseY/1G52GldN+LPferx0Ia17ujM
         E7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691684123; x=1692288923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVqbHV+QG5GsPVQyZyu89m2UgvCEHBysqsbECKUvsgM=;
        b=ZpuC6mzQM+NUcuqn7DCJ1FqWBTk6Ms0zVJoS8TzX9NbM1MGQYw5jzlUPqpB6AvSBJ5
         w+zYeR2haDiDsiDAfSnxDx3Bb6amlWg+Ea/+ZZ0DuYI3nBRvhep89T8A5Y4MlUTw4O6+
         MM+X8IXVd6z+XeSp9OakPKPFsBMgyRlM7CBVb0Ufko2q6Ptth6lXhmawQzLxMVIa3Cgz
         UjQo1gX4KSyU7A97ank9vyFIooovH7Xtn67AAqjaNmNaZmk0qLUw8EMG6Vb2LyHMMQgG
         /8OAReJD0KfoynsOLsMglW9iOW6xyJU/2K9e+QMXUltraL3XeYKpG2L84gXBm31Dxm9Q
         UOHw==
X-Gm-Message-State: AOJu0YzRl/FIn74OQnXqMRHcFXZbeC3ujEdHyPCvmFDxVxR1Duzt26EZ
        kK19uDHDVwJ24O8L8VabB1Y=
X-Google-Smtp-Source: AGHT+IHX/AxNqI+XLXc2Gd770eCbj0++Kc5KbY5XG3Wg/eCIjosP5SBsbkuvKoQ00716dbJaa2oq7A==
X-Received: by 2002:a17:902:ce8f:b0:1bc:7312:78e2 with SMTP id f15-20020a170902ce8f00b001bc731278e2mr3226286plg.5.1691684122928;
        Thu, 10 Aug 2023 09:15:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c1-20020a170902b68100b001b53be3d942sm1957928pls.232.2023.08.10.09.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 09:15:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 10 Aug 2023 09:15:21 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.4 000/165] 6.4.10-rc1 review
Message-ID: <f110a9c9-5be2-447a-b8b8-be79a078426e@roeck-us.net>
References: <20230809103642.720851262@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 12:38:51PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.10 release.
> There are 165 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 522 pass: 522 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
