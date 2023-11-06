Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7CB7E2EAE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 22:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbjKFVJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 16:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjKFVIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 16:08:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F2B198B;
        Mon,  6 Nov 2023 13:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=WcTGKRC8aIgIPpHyxt4LGmD5l1aKIH7ouZAiNt82fgg=; b=sKhhISRqy1vGsTBa4cQkabNGwK
        Y80kTBPUORC6EOmzuclu5twI3w3XcUEWwHMohljLxE2+7JhgtQ8o9m2vAYgUCGK6NHR5niwvmST52
        nSj634WUPTTp89u40iIyu3dIUDdKwFHmQJiBeut3uhCoiYEczGA51DKix2AFnRmMRIJsAbwDQwn0Z
        Aq9VxikIu0Gbef2njHB/Fjc0In45vDqJYFzTy5dQQkyvRvkaImhOsLod4iM0wWGjxGIqSLfhhkDtO
        hJ3LoY07io4PiRJcq9lQMo1HRc4BG6/2P0EqRn9gW9eN2liJNTwR3ylCzASH6Cm5MECpygt0eqVy8
        EcAohGXg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r06pj-00HZGK-1n;
        Mon, 06 Nov 2023 21:08:31 +0000
Message-ID: <aa6b416d-08a4-4f8e-8ab6-f8bf489876d0@infradead.org>
Date:   Mon, 6 Nov 2023 13:08:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm: amd: Resolve Sphinx unexpected indentation
 warning
Content-Language: en-US
To:     Hunter Chasens <hunter.chasens18@ncf.edu>,
        linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
References: <20231106201739.29507-1-hunter.chasens18@ncf.edu>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231106201739.29507-1-hunter.chasens18@ncf.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/6/23 12:17, Hunter Chasens wrote:
> Resolves Sphinx unexpected indentation warning when compiling
> documentation (e.g. `make htmldocs`). Replaces tabs with spaces and adds
> a literal block to keep vertical formatting of the
> example power state list.
> 
> Signed-off-by: Hunter Chasens <hunter.chasens18@ncf.edu>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 517b9fb4624c..81b8ceb26890 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -989,12 +989,13 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
>   * Reading back the files will show you the available power levels within
>   * the power state and the clock information for those levels. If deep sleep is
>   * applied to a clock, the level will be denoted by a special level 'S:'
> - * E.g.,
> - *	S: 19Mhz *
> - *	0: 615Mhz
> - *	1: 800Mhz
> - *	2: 888Mhz
> - *	3: 1000Mhz
> + * E.g.::
> + *
> + *  S: 19Mhz *
> + *  0: 615Mhz
> + *  1: 800Mhz
> + *  2: 888Mhz
> + *  3: 1000Mhz
>   *
>   *
>   * To manually adjust these states, first select manual using

-- 
~Randy
