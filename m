Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30D97F1D15
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 20:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjKTTHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 14:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjKTTHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 14:07:41 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564B2D9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 11:07:37 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5c186f027cfso2727551a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 11:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700507257; x=1701112057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gXcc2SNMf9zNJPM+0hZ75826DR37Dijp5Jy5P2sVv/o=;
        b=JqeLKNnw3TjAHlLQ+uzEo2Bw6JQjC5CyT6YJ9vJGSDBhNwh7sW0wP4Z+2obnyxtPuS
         0bK2/EwVJiMLgVrDeXOs6M18fVHYdeNgCFYurE4NBkOWRg1WRAvHKkJ48+Gb/BIh+je7
         PlfeEKdEExSeyZwWF2KiKaxtTMkwg7By1B1+KVvAFzzDheTOeslL1DhoW4XjbB6RABg5
         vKoli2MfyfqFMNnYeqUWOGmVTr3dgVJQwshZ5p3/jelpDBIwYtI9+7ypa8ToTn45DgST
         K2lewenD4TjahISVGmhMj1F6gV8NmSALCTotJMUyLUmIDtVlA3vkEZRIUJShuUVORTjG
         TMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700507257; x=1701112057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gXcc2SNMf9zNJPM+0hZ75826DR37Dijp5Jy5P2sVv/o=;
        b=cSZ1zN1aVKBYJX6YgjCl20PkRJHSq3dKhemaX5TBenHBu8mcoR/gYt/3jdrPssineM
         Ij8gBH0c4h6I/8LtsRqFTRHWvtoqCExDnrb799a5Su8rYqEtYuqEeUatTgCSj3QBggou
         eTo881zfEULosbaaxziM63MspHiH6yNzFXUz+4UbUCPYQOSX+hgxy3RLoCCsZYdXeBhU
         UGAf0JY5wl1Vh3oQLEtf5vfMbzF/tHFndjBTniRHV2wjs1LszbGJLJXXg00umAvuZewU
         RC80K37/MCHyd6T/Pv5EVCuV4Boh3AaeLaTq4gF4Ou4AF8TE7Q/fVsBUN96VY164BI0F
         F58g==
X-Gm-Message-State: AOJu0Yxe0J9TBwZ5y1p5a4V6s0gqxs6GzUVQ4M56bPfp6x0vP02x2jW6
        JiFskNxG2O8tKhcv6dTMNwU=
X-Google-Smtp-Source: AGHT+IH5YDwC4S96LNO7M8SQIItSJ8nzvH8b0wINbsNVBSou1CWcUQ4NtPSit4rWhoKelA95qNtDpA==
X-Received: by 2002:a17:90b:1c0a:b0:280:fc91:ad5d with SMTP id oc10-20020a17090b1c0a00b00280fc91ad5dmr6132513pjb.19.1700507256612;
        Mon, 20 Nov 2023 11:07:36 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id d7-20020a17090abf8700b0027768125e24sm7770052pjs.39.2023.11.20.11.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 11:07:36 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 20 Nov 2023 09:07:34 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yong He <zhuangel570@gmail.com>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: fix invalid cpu in kick_pool
Message-ID: <ZVuudtAtDqHqYJr8@slm.duckdns.org>
References: <20231120121623.119780-1-alexyonghe@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120121623.119780-1-alexyonghe@tencent.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Nov 20, 2023 at 08:16:23PM +0800, Yong He wrote:
> With incorrect unbound workqueue configurations, this may introduce kernel
> panic, because cpumask_any_distribute() will not always return a valid cpu,
> such as one set the 'isolcpus' and 'workqueue.unbound_cpus' into the same
> cpuset, and this will make the @pool->attrs->__pod_cpumask an empty set,
> then trigger panic like this:

This shouldn't have happened. Can you share the configuration and the full
dmesg? Let's fix the problem at the source.

Thanks.

-- 
tejun
