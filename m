Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B287AB97F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 20:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbjIVSoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 14:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjIVSoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:44:20 -0400
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90B6A9;
        Fri, 22 Sep 2023 11:44:10 -0700 (PDT)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-690fa0eea3cso2353275b3a.0;
        Fri, 22 Sep 2023 11:44:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695408250; x=1696013050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2aqVYOhUUnir1QTQiM0S+aPULzJZYtBBaxGwEOM8XUA=;
        b=j/9FIb0rT66vX6nUU4UehcEHur2bpYQDZE/I1EuQcVzf9hPyYs/VD3iADlZnu/UZK/
         M09gJ2NXoSVBDqOMHKBhBokQHbNmFdMjd7V2DaZdGu74veJgMkEJqaHTYA9QzPpJShmT
         ZH+cJ2OZaiFDm6foD/s0w70ihzG7bGbM1On/QeY4wZSGUpGB5iJ/J6MZl6NqbEBZgT9x
         1AqqwRgrXk/AII0TdNu8/DkIc70EwY+XR1BqHaGcPjJQxlvOmYQd30h0KoENH3lBp3TL
         kWfwUpJbidREPQ4ipTseXtR47K6xcf5k/g5BDlVyNAsU6S9NU6agf9NAzbk8VLcjaJ1j
         WmCQ==
X-Gm-Message-State: AOJu0YxTM7CZ1M/W+kX8fFrOqFtsaTA5zbcp2XhiFd79f7xIGfdM/AID
        Wx1MP2bxV/PEYmA8J59tcjU=
X-Google-Smtp-Source: AGHT+IHFWVfqxcx8M7H2NkTdmZ/h6CEuOxaJpfbdDeDzoU2LB58p+VwAxwoKTwgsc99gRYB+0fK2TQ==
X-Received: by 2002:a05:6a20:8f13:b0:10f:be0:4dce with SMTP id b19-20020a056a208f1300b0010f0be04dcemr532364pzk.8.1695408250118;
        Fri, 22 Sep 2023 11:44:10 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id g1-20020a62e301000000b0068bbd43a6e2sm3633497pfh.10.2023.09.22.11.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 11:44:09 -0700 (PDT)
Date:   Fri, 22 Sep 2023 18:43:26 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        vkuznets@redhat.com, ssengar@microsoft.com
Subject: Re: [PATCH] x86/hyperv: Add common print prefix "Hyper-V" in hv_init
Message-ID: <ZQ3gTjYESikJu9LL@liuwe-devbox-debian-v2>
References: <1695123361-8877-1-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1695123361-8877-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 04:36:01AM -0700, Saurabh Sengar wrote:
> Add "#define pr_fmt()" in hv_init.c to use "Hyper-V:" as common
> print prefix for all pr_*() statements in this file.
> 
> Remove the "Hyper-V:" already prefixed in couple of prints.
> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>

Applied to hyperv-fixes. Thanks.
