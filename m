Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37CB79A0DA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 02:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjIKAte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 20:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjIKAtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 20:49:32 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B3C132;
        Sun, 10 Sep 2023 17:49:28 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-573f8afe1d9so2920415a12.0;
        Sun, 10 Sep 2023 17:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694393368; x=1694998168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qKKiIggEL8Q6+GVAzogX6XIuLeLwn4Ms0HBNJv6B+LA=;
        b=sZmyncvi3rJxM/DsylF1KwKSM95YJdKF2B+2yqyJpEtizc0XdOXpACkjP90MaOJQ/e
         C745aZq+AX/4FmpybzKXDQSu47uhkY3YE7sd+qyN2QF4qCx2a7VnlXMZf9/yJzTYhdxB
         yCSgt6exbRhnAtsb33YYbuwOP3kiOI5k1hNtyG518bFqYFsMd5nN4L7ESsKCO5IdgJcU
         zZM4CNucOttOdX8Eojljm/PZCBmsRKJ8LYf288duIhxOlIZZa6YvhJqbNI+BbzZ7tHG9
         1xgaJTDl34y/vGMbmmbBsvhxqxifVo63XKpnKOlAxYHFlxRx9yJCspHgiaPjc5L+0JE/
         drXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694393368; x=1694998168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKKiIggEL8Q6+GVAzogX6XIuLeLwn4Ms0HBNJv6B+LA=;
        b=PQCUkPbE8VHz5r8drSZ9z9fn+QHrUg23eZTnFMY1eD+EEEzmDTn/oulPwGXMPiKHE9
         4i0a3s4mmnSLkzi4ohOYU7GN+n+ssrKkZNuugOhMzxA8pA9ggUCVz0ZbECN9I08fwa6G
         0OVpnDJIyCvvyir6bp8QvnfR2mLJDu28JrVO29kjh+JH+D0BaU773DdA3HguhOjnIHMh
         QvtsDYpwNierru+RRzdHtvUnQE86bs7G352XUjCS8sfBUh7+pePS/Bnpue32XcZmhbfL
         2qDAZmPL+AU8+Mep8OYzR2eA5whzYPzBRIryzcLjAHmayT+H/lJesD7m3LQJWS4kJbrz
         hR/w==
X-Gm-Message-State: AOJu0Yx0rAjKwEKxOk4dA8Ck35DWdEV+NPCVjVcOTISM1YuTbflxFlCi
        cTrKdvsTbAovTdN3ywaiZII=
X-Google-Smtp-Source: AGHT+IH2NqIFPwQ/hARIh7aeatdMOBzagObDu2Ee8qbVZ3dVqZZy4tpYyAS23vSL9AeDA6QX7+BahA==
X-Received: by 2002:a17:90a:588c:b0:262:f06d:c0fc with SMTP id j12-20020a17090a588c00b00262f06dc0fcmr7718383pji.7.1694393367855;
        Sun, 10 Sep 2023 17:49:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id mp15-20020a17090b190f00b0025bfda134ccsm4557777pjb.16.2023.09.10.17.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 17:49:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 10 Sep 2023 17:49:26 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     hdegoede@redhat.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] hwmon: (sch5627) Disallow write access if virtual
 registers are locked
Message-ID: <f9291b90-c9c0-4114-8f1c-28a44af6c49c@roeck-us.net>
References: <20230907052639.16491-1-W_Armin@gmx.de>
 <20230907052639.16491-3-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907052639.16491-3-W_Armin@gmx.de>
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

On Thu, Sep 07, 2023 at 07:26:36AM +0200, Armin Wolf wrote:
> When the lock bit inside SCH5627_REG_CTRL is set, then the virtual
> registers become read-only until the next power cycle.
> Disallow write access to those registers in such a case.
> 
> Tested on a Fujitsu Esprimo P720.
> 
> Fixes: aa9f833dfc12 ("hwmon: (sch5627) Add pwmX_auto_channels_temp support")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Applied.

Thanks,
Guenter
