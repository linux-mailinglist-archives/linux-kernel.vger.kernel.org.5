Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8987D0B48
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376594AbjJTJRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376552AbjJTJRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:17:11 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A0BAB;
        Fri, 20 Oct 2023 02:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1697793425; bh=sPAwy1nmQ+bMmXVeWg91iZOlITJ2nlMgIJjpN+TvSZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A7qmhd6d5T9MZvmueUe4nFdFcfraAt8oZt3LXY3weEa1VC+xwb22qc7iXHlcq/nYr
         Kfd4VlQNouYsC8LDo4XTO8qPBKxrpx9ltnAsFlqkq/o/nsmTjWc+KABxh7PcqlUr2X
         0xfMrjTYLZ3grQMTTZl6aStMAfQR4gusQkGYLWkg=
Date:   Fri, 20 Oct 2023 11:17:05 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Ai Chao <aichao@kylinos.cn>
Cc:     hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
        markgross@kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5] platform/x86: inspur-platform-profile: Add platform
 profile support
Message-ID: <7c58ab73-abdd-461f-9d3e-31b02db2b7af@t-8ch.de>
References: <20231020024007.1677962-1-aichao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231020024007.1677962-1-aichao@kylinos.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-20 10:40:07+0800, Ai Chao wrote:
> Add support for Inspur platforms to used the platform profile feature.
> 
> This will allow users to determine and control the platform modes
> between low-power, balanced and performance modes.
> 
> Signed-off-by: Ai Chao <aichao@kylinos.cn>

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>

Thanks!

> ---
> 
> v5: Rename inspur-wmi to inspur_platform_profile
> v4: Add select ACPI_PLATFORM_PROFILE
> v3: Remove input device, using the platform profile interface
> v2: Remove Event GUID, remove inspur_wmi_notify and inspur_wmi_notify.
> 
>  drivers/platform/x86/Kconfig                  |  11 +
>  drivers/platform/x86/Makefile                 |   3 +
>  .../platform/x86/inspur_platform_profile.c    | 216 ++++++++++++++++++
>  3 files changed, 230 insertions(+)
>  create mode 100644 drivers/platform/x86/inspur_platform_profile.c

[..]
