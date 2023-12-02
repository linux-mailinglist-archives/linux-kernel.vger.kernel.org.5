Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433F5801FC9
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 00:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbjLBXiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 18:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLBXiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 18:38:11 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A491C8
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 15:38:16 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40b30308c67so33034485e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 15:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1701560295; x=1702165095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=78CTgtpobZ3nEtM8PQVEaWzZpOWHKrFZDrmFfudY4xw=;
        b=1R2kAnBCUo3YLVXFCjgCC77NHDZknXpYL2MZaKIv4ooAX3lya0HjtXzIyAZwwOHm0W
         0bvAjJXUq4+XqP5ylxG9wevLleWkAZl/zQy4jN9pp/1thXMXNFRKWUuUWiQX0FgAu6WM
         2hKAjFE3B2SN3LD9UjevIEJAw2BZs+VkMe5zyK2L0zwY3NZimCbo+kukZyunHMK0AeTc
         BqNN17cwmx/MDTmD2lgXk7ArC7oHBh0fxVeBz7/a7Nq+Pebh2n500pblyGisxyyy5O02
         yugP6YI/Zim5gFxWU+Ei5YdIYkHIntYK5C7BzRn+50cf4vHDQ2dL//zy9/jZCVZL/Xcq
         ZOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701560295; x=1702165095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78CTgtpobZ3nEtM8PQVEaWzZpOWHKrFZDrmFfudY4xw=;
        b=RvV+3d79iYPe0chi0n+kEXGxEM+Jig2KT1d4YcIVwqe1baZs/3uOH/vOlE9eRiLOQZ
         LjJ/4XmMCXkttOUuzehIaoirYTGCRQEgTED1SgammyHS3Hw8124BMVfI09GAgwzBz0e4
         T6KrOqSlMZjEXrYtFquXjSorybJyxfbcNohinbN2+9Oe8rrGk/TrGV6vz1c1hMHn3wol
         Tki7sDNwKtkiYvn04EZrJgkHfIpPM6mxeI8LaV3GExLGDlJEvoLCVHKiMwPWUtnYn4/i
         eCw5BzzjRlDXnlYZO5pR5yEg0MjkOkThoYzSuwWzda8lhrLxGNd9UmgDr0Qd4vCSBoC/
         MRfQ==
X-Gm-Message-State: AOJu0YxY2MCL7ByXzMiIrzocoId01J6+BZuYu4VkJl39fi6l2f6CIdTb
        SQgmTQ6V8MBeDAvVSKz0d2lkSQ==
X-Google-Smtp-Source: AGHT+IEx5t/BgNVRyaVaB3TRTF8+1Lk+D/pbCaZ8YVruDsW3d7NeoSmshnu5HAXAbgWdo4ONaaM06w==
X-Received: by 2002:a05:600c:5126:b0:3f6:9634:c8d6 with SMTP id o38-20020a05600c512600b003f69634c8d6mr1486941wms.18.1701560294174;
        Sat, 02 Dec 2023 15:38:14 -0800 (PST)
Received: from airbuntu (host109-153-232-45.range109-153.btcentralplus.com. [109.153.232.45])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c4eca00b0040596352951sm13712893wmq.5.2023.12.02.15.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 15:38:13 -0800 (PST)
Date:   Sat, 2 Dec 2023 23:38:12 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        corbet@lwn.net, alexs@kernel.org, siyanteng@loongson.cn,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        lukasz.luba@arm.com, hongyan.xia2@arm.com, yizhou.tang@shopee.com
Subject: Re: [PATCH v2 2/2] sched/fair: Simplify util_est
Message-ID: <20231202233812.cq2nodia3estdexy@airbuntu>
References: <20231201161652.1241695-1-vincent.guittot@linaro.org>
 <20231201161652.1241695-3-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231201161652.1241695-3-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/23 17:16, Vincent Guittot wrote:

>  /*
>   * The load/runnable/util_avg accumulates an infinite geometric series
>   * (see __update_load_avg_cfs_rq() in kernel/sched/pelt.c).
> @@ -505,9 +469,20 @@ struct sched_avg {
>  	unsigned long			load_avg;
>  	unsigned long			runnable_avg;
>  	unsigned long			util_avg;
> -	struct util_est			util_est;
> +	unsigned int			util_est;
>  } ____cacheline_aligned;

unsigned long would be better?
