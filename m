Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5157FBAA6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 14:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344838AbjK1NAT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Nov 2023 08:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344711AbjK1NAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:00:15 -0500
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5A4D72
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 05:00:22 -0800 (PST)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1fa1e17a0b1so597893fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 05:00:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701176421; x=1701781221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=izpuOZu6B1FXpmXyClCOOq7hLe9BRki4gCMUdF0sfoE=;
        b=Cks74GNme6qxO+8P1T8pwmH8Cc3E/fxD3l49gwZL9Q/11W5BKjEffl2Vc4BBPrb745
         mT/hgUxa/qLdCe366n/nInN65dClmSeBl1XFo1ceoy8P9862DRC4AcJRINuUOO1b4Yy8
         p+wlOBmgfL5GNRzUB74CXJWMVxKs/aoMxvBh3kXD5m2qsVjM5Di1dAS+RSmlo8yI83Lc
         c5VHa24wd/gP8r+yGt0/ZHupaTmiKkQUcRouejObBzT5fjWG0rzCL0zZSSzrh5+dR1wj
         22Lq81TAgSsuEGjlKALxjVLCUgWONfPjlc/zovI/nDnI2YsE9xYEvqSk33eJ3bfJwhch
         J5Aw==
X-Gm-Message-State: AOJu0YxqD0nH/djnGTMUqCqZeVbzXJPWnaX9WpCRASMVGFXWkZJwvQvD
        hO1BtZsmG7N1l3vbH/lkfCxt+XbMSud1SacNaKs=
X-Google-Smtp-Source: AGHT+IH3xR6DOsCkD1of/eXssJ1e/6sSIiopYReTW26r7dLvwzjn2ck3KdQA/zJ/sEzTXs4F9DTlnuSwrVIOzIMnplg=
X-Received: by 2002:a05:6870:168d:b0:1fa:132a:ad11 with SMTP id
 j13-20020a056870168d00b001fa132aad11mr16243385oae.2.1701176421293; Tue, 28
 Nov 2023 05:00:21 -0800 (PST)
MIME-Version: 1.0
References: <2023112815-faculty-thud-add8@gregkh>
In-Reply-To: <2023112815-faculty-thud-add8@gregkh>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 28 Nov 2023 14:00:10 +0100
Message-ID: <CAJZ5v0j-+AbutYRbvoU_8Du6VNevvRW_HOD5BZAzgOSoy2ZiuQ@mail.gmail.com>
Subject: Re: [PATCH] driver core: make device_is_dependent() static
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 11:28 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> The function device_is_dependent() is only called by the driver core
> internally and should not, at this time, be called by anyone else
> outside of it, so mark it as static so as not to give driver authors the
> wrong idea.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: "Rafael J. Wysocki" <rafael@kernel.org>

> ---
>  drivers/base/core.c    | 2 +-
>  include/linux/device.h | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index dafdb9970901..6dcc26eec096 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -298,7 +298,7 @@ static inline bool device_link_flag_is_sync_state_only(u32 flags)
>   * Check if @target depends on @dev or any device dependent on it (its child or
>   * its consumer etc).  Return 1 if that is the case or 0 otherwise.
>   */
> -int device_is_dependent(struct device *dev, void *target)
> +static int device_is_dependent(struct device *dev, void *target)
>  {
>         struct device_link *link;
>         int ret;
> diff --git a/include/linux/device.h b/include/linux/device.h
> index c11d60cabaab..6a4ee40af3df 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1071,7 +1071,6 @@ int device_rename(struct device *dev, const char *new_name);
>  int device_move(struct device *dev, struct device *new_parent,
>                 enum dpm_order dpm_order);
>  int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid);
> -int device_is_dependent(struct device *dev, void *target);
>
>  static inline bool device_supports_offline(struct device *dev)
>  {
> --
> 2.43.0
>
