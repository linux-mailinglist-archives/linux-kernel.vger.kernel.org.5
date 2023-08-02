Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E36D76D067
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbjHBOpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbjHBOpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:45:18 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1021FC6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 07:45:17 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CA048380;
        Wed,  2 Aug 2023 14:45:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CA048380
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1690987516; bh=gjlHNSiPJH2mSvqtWTZhAzkJgjQu1TEBb+RZEZs8VC8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=GDXKA1gx0lsSxBw05FF03T0dOuntbILT+c/h97Tdew0kSKeYeJ+2vN82Py2YHx5P7
         klcB4yyhpsD7KElDrdxfPIlFCuEV0+NEaYoCAGsmYmsGJy3C3JHz/MIxzlm06h3vJB
         8rqbFBcz2oW0ewXlDV49rg3nGFnfBw8qAngycoLwh/upSTevQv4p6G+y4gyChHelwi
         CQ0+RtM5LH8GXxMbHRpj+VPCTUikdeRsFVdKejKHs8NsfJT39RdddBbmDAnUX6CzVT
         o/NAOlbgSZbUVCMyIEzVT7CjijP6+sNyTeKjo/AWIK3vKVWWBIdv7hkRoSL1b5IOio
         wi8N/osGJSSjg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lee Jones <lee@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH 02/37] drm/xlnx/zynqmp_disp: Use correct kerneldoc
 formatting in zynqmp_disp
In-Reply-To: <20230320231551.GQ20234@pendragon.ideasonboard.com>
References: <20230317081718.2650744-1-lee@kernel.org>
 <20230317081718.2650744-3-lee@kernel.org>
 <20230319142432.GM10144@pendragon.ideasonboard.com>
 <20230320081700.GH9667@google.com>
 <20230320231551.GQ20234@pendragon.ideasonboard.com>
Date:   Wed, 02 Aug 2023 08:45:15 -0600
Message-ID: <87o7jpa4g4.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Pinchart <laurent.pinchart@ideasonboard.com> writes:

> I haven't seen anything either. I tried moving the documentation inline,
> and the scripts/kernel-doc script ignores the comment blocks for the
> inner fields.
>
> Mauro, Jon, is this a known issue ? If so, are there plans to fix it ?
> What's the recommended way to proceed here ?

As far as I can recall, nobody has ever complained about problems with
nested structure definitions like that; kernel-doc certainly isn't set
up to handle such a thing.  It could certainly be added, but it would
require somebody diving into that delightful code to do that work.  I
can't promise to be able to do that in the near future.

Sorry,

jon
