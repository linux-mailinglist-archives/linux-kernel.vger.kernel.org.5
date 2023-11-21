Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7B37F6027
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345454AbjKWNW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345271AbjKWNW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:22:57 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F3CD41
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:23:03 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c8880f14eeso10923481fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1700745782; x=1701350582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fmeSlyRRAZmkiADOOVUeH9QDd85AntrliLGP54hloZQ=;
        b=ADTOikpDonUTGJzYT3drdkqttCmqLQ03H+ys9gu/Ec1wVH0tKjd3w45LQos2oceeZG
         8PPFkrhWgFJJoUp9uBV3yo1tTXGDITUwAmIXHqemNBp4GVxHXo+I/o3HBYhj45BYNq1P
         FuSJPV+0GUuSCfYz750+xZQTFybs5VyNWvPhQOnD6FAXxSjV4lN03EC5Cymkhl32fx0K
         cFGYDkuC5R7xBlrwhQqg1z3DUu4CObHW/dLMI7D3QpdehYHcmlAYZD5iYgXyCSRqWK52
         omFbPEbZmiGLWL5Korm0WPFs1OAPNnOkPu99OaP+7m6VYuFb608uXyZzo/Q/M608ZiKl
         INcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700745782; x=1701350582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmeSlyRRAZmkiADOOVUeH9QDd85AntrliLGP54hloZQ=;
        b=DNG91HhLLZUoTYbm29BCSxDJ+boLoJIJhDP2v8Omd8AtXj2g452/xWqgFPirtuibSG
         UPdp1BR2HAHVE2fTi7EyRTJqB2Sgs1nPg40Dy2UP1ty4Wi4zZA1ZZYucNnHiWoogv+sP
         Brz8cj95uyg5AlfQ+Bss66vemk/6irt28DBnda6ZjPIY7WBCQ2jX6L76V2TfIUChvf3f
         7BKmCgF+4nkVMz03hN+cI2PggnAIRG9O0RtP3ihDCJ7SEaHFUt9FEUCDmuCF0BhGp4ed
         yA+1VhHvW8JcByX19/8TRd0wkusTMY6k9vo6+h4dtJMnse+3/hg3mzcVmoZB2IgUWK93
         fieQ==
X-Gm-Message-State: AOJu0YwaTT7fvJ35+g6aZXGESNsWs6nY25zPESU/Vr1x0GiZ5jNVzbYv
        KNa+ZkCGkWKeENET1CYliHKEuA==
X-Google-Smtp-Source: AGHT+IGFgp4TppLOoOOJ7pc4hl+TCahn+25qfWriVz63S8qOwrN2mC+tDrckfI9n2PiK0T1LH8PoBA==
X-Received: by 2002:a2e:920b:0:b0:2c5:23e3:ed11 with SMTP id k11-20020a2e920b000000b002c523e3ed11mr4198294ljg.30.1700745781933;
        Thu, 23 Nov 2023 05:23:01 -0800 (PST)
Received: from airbuntu (host109-151-228-202.range109-151.btcentralplus.com. [109.151.228.202])
        by smtp.gmail.com with ESMTPSA id j25-20020a05600c1c1900b004076f522058sm2738021wms.0.2023.11.23.05.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 05:23:01 -0800 (PST)
Date:   Tue, 21 Nov 2023 22:17:52 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        John Stultz <jstultz@google.com>, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Provide a boot time parameter to enable lazy RCU
Message-ID: <20231121221752.wphdk3xqgoii6eub@airbuntu>
References: <20231121205304.315146-1-qyousef@layalina.io>
 <ZV7xIjSq1l1q7gRI@gpd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZV7xIjSq1l1q7gRI@gpd>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/23 07:28, Andrea Righi wrote:
> On Tue, Nov 21, 2023 at 08:53:04PM +0000, Qais Yousef wrote:
> > To allow more flexible opt-in arrangements while still provide a single
> > kernel for distros, provide a boot time parameter to enable lazy RCU.
> > 
> > Specify:
> > 
> > 	rcutree.enable_rcu_lazy
> > 
> > Which also requires
> > 
> > 	rcu_nocbs=all
> > 
> > at boot time to enable lazy RCU assuming CONFIG_RCU_LAZY=y. The
> > parameter will be ignored if CONFIG_RCU_LAZY is not set.
> > 
> > With this change now lazy RCU is disabled by default if the boot
> > parameter is not set even when CONFIG_RCU_LAZY is enabled.
> 
> I'm wondering if we should make this enabled by default if
> CONFIG_RCU_LAZY=y, so we don't break the previous behavior, and those
> who want it disabled (despite having CONFIG_RCU_LAZY=y in their .config)
> can add rcutree.enable_rcu_lazy=0 to the boot options.
> 
> Thanks for working on this!

Sure, thanks for having a look!

Cheers

--
Qais Yousef
