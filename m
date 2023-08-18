Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D41780A43
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359014AbjHRKf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376481AbjHRKeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:34:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20804C21
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 03:32:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5549A6797A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 10:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A25C433C9;
        Fri, 18 Aug 2023 10:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692354775;
        bh=2TpNR24FXV8wdI1xhbKlLvv+i1pe7zzGnmmdOMKPlHQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=D5DpRaKdxnrBq9RtRGDerqJ9ZLF6aeHNJYe5Zkl/JE3/AE6kZ52RgD7UEv7lgQcwF
         y0L4iiXKIkzaMUhbUG+N0H7eWNS5XmBxcR0H2fzjaizgnDSXKgXdTvk8/0wuGWwsYT
         Yhba7GQrX3nS1EeECLivbu3Jj8VBHkACeA5oILw2AO/DLaLrMeKSKZGvIPU2hgDpMC
         ELddEsHjx0dJpFyppHKOJF+pszgky4fxsjcJx6yzbQczghXFnsH1HP1jgoiIONLSTr
         mKf2gEjKj/YciYEG526rvVH6QhiowFf1WtWMM90R14Az6sIezlqDV9ug0ifd1wg6/B
         obIoapnjgMm0A==
Message-ID: <f9c32a69-6399-0686-d47d-7464055e49bc@kernel.org>
Date:   Fri, 18 Aug 2023 12:32:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v5 02/17] dt-bindings: gpu: Add Imagination Technologies
 PowerVR GPU
To:     Sarah Walker <sarah.walker@imgtec.com>,
        dri-devel@lists.freedesktop.org
Cc:     matthew.brost@intel.com, luben.tuikov@amd.com, tzimmermann@suse.de,
        linux-kernel@vger.kernel.org, mripard@kernel.org, afd@ti.com,
        boris.brezillon@collabora.com, dakr@redhat.com,
        donald.robson@imgtec.com, hns@goldelico.com,
        christian.koenig@amd.com, faith.ekstrand@collabora.com
References: <20230816082531.164695-1-sarah.walker@imgtec.com>
 <20230816082531.164695-3-sarah.walker@imgtec.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230816082531.164695-3-sarah.walker@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2023 10:25, Sarah Walker wrote:
> Add the device tree binding documentation for the Series AXE GPU used in
> TI AM62 SoCs.
> 
> Co-developed-by: Frank Binns <frank.binns@imgtec.com>
> Signed-off-by: Frank Binns <frank.binns@imgtec.com>
> Signed-off-by: Sarah Walker <sarah.walker@imgtec.com>
> ---
> Changes since v4:
> - Add clocks constraint for ti,am62-gpu


Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC. It might happen, that command when run on an older
kernel, gives you outdated entries. Therefore please be sure you base
your patches on recent Linux kernel.

You missed at least DT list (maybe more), so this won't be tested by
automated tooling. Performing review on untested code might be a waste
of time, thus I will skip this patch entirely till you follow the
process allowing the patch to be tested.

Please kindly resend and include all necessary To/Cc entries.


You already got this comment. I think more than once. Fix your
processes, so finally this is resolved.

Best regards,
Krzysztof

