Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5707FC15B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346259AbjK1RwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjK1RwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:52:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDC493
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:52:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7B4C433C8;
        Tue, 28 Nov 2023 17:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701193931;
        bh=fIENyWx1p7BpJfaucZBxmc/ZLBKGsHeNB6XalPqHagY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GVaHFP0HS1UBadW+JZbhURBZ5MrshziTIOE0oBHVmBWSE53RugvD6SJ8Kh8GN/Xpz
         sjJqJK2IH9aL9OFqb2lsjNcphaldkHChg+ew9lIOODULEF/7x34Nc/Z3KLTFkv9C/h
         eqHrb49ns0Zo47owKsM0izffmMukUCXXVJfQ0R1l819GKQuvd/CbzLVen1u5Qa8Cwb
         1yKbKv5nAuADzMJslKWjfbNskMPlxOGch4uCQ1i2L4Pg3XcmL/9jhkMxV8MVQKlI4c
         cudLg94i2PKhjYsQn2+aM3751WpEF7q4/jDVKQpNj/stqjMofNf+zd7s/9kgqgFY06
         ZHlQdamnIgXYA==
Date:   Tue, 28 Nov 2023 18:52:07 +0100
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Peter Rosin <peda@axentia.se>, robh@kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v5 2/2] i2c: muxes: pca954x: Enable features on
 MAX7357
Message-ID: <20231128175207.jzeiaxc2kxusl2fd@zenone.zhora.eu>
References: <20231128100009.3727407-2-naresh.solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128100009.3727407-2-naresh.solanki@9elements.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naresh,

On Tue, Nov 28, 2023 at 10:00:08AM +0000, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Enable additional features based on DT settings and unconditionally
> release the shared interrupt pin after 1.6 seconds and allow to use
> it as reset.
> 
> These features aren't enabled by default and it's up to board designer
> to validate for proper functioning and detection of devices in secondary
> bus as sometimes it can cause secondary bus being disabled.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
