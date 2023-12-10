Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BEB80BD5A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 22:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjLJVYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 16:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLJVYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 16:24:09 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3441BDA
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 13:24:15 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-33349b3f99aso3614770f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 13:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702243453; x=1702848253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mqEf7WmuKDGX9nvRdQA8LWh5OGSEy6Iu2m6IfkFvvR8=;
        b=FZoPsK9LRG4psqsGmAMfhEbonWl7qM1oYWXL2NkrKTyc9ijDckexMNcyVe0/btkP1f
         UcS2NqlgT3AG3Vr07JafFUJtu0BVuU6tBAODrsJ90kSdjHqqNWlz+sSzcEtEnuWD3YuT
         GMWfd0n4+ztuM41n72SEsefxXsSb0etAFR6QuBI+11uFZzAUjL2imszV2/Ubxi7TgfFV
         bqcp1F4IXPp7sbkrlUh1wh1SAZYpUWCnFVoA+k36JnaC1NubAIXG/SpMSRkCuJErzvtu
         T8svHvASWAYtNkcetvDc5YrDHIi5WgN3UPEe5kL+C70niG+TMGddQYYwOvFjkkMbtNkB
         badQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702243453; x=1702848253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqEf7WmuKDGX9nvRdQA8LWh5OGSEy6Iu2m6IfkFvvR8=;
        b=Asmc57w2tQEZQTllBBeLaT2fD20dfICQmor84RMe6VgK9+NRgd8LYvd61YQK36urpD
         71pDk4hHWQ+SCWRVVW7LSOeSur1xf8hKJmcXcoNGdilg2BjlhZJ2nNCm9uCaqJDr49XY
         msp0M90L2wouWKs9fwGJiX5zN5p8/dJQN+Xbv1XutNIaEqZRgjxG5N/iK0nfThwGLq4j
         dxfB54F/lKy2uBIeRJNFY/+YrHHUa/D8ci3Zf3Y6bJXxnLhxtx3yPGWgGTq4rJorXJNO
         ZQTSNAtelfdmwKa+HiVTaWevk1HB6TIgMv0cYrCkfTzp4QrtUIwlIIdtcu2ovGceLlW2
         9+MA==
X-Gm-Message-State: AOJu0Yz8VGlke9FbYS+2D+y+7/A21lRJbOKv2+w2hf6tnoJrgoG+PNUh
        nRDQpb38+E5yHkUqUtw8G4sZiA==
X-Google-Smtp-Source: AGHT+IHk94izCilF/BewfwW/CZqmak7w/eouFIC+6NzSJblcQxRBUIeAZX7fQCm4BQU00/CeXDVuJw==
X-Received: by 2002:a05:6000:4c4:b0:333:28f6:d9e3 with SMTP id h4-20020a05600004c400b0033328f6d9e3mr1730755wri.33.1702243453583;
        Sun, 10 Dec 2023 13:24:13 -0800 (PST)
Received: from airbuntu (host109-153-232-45.range109-153.btcentralplus.com. [109.153.232.45])
        by smtp.gmail.com with ESMTPSA id h4-20020a05600004c400b0033621fe3a29sm706874wri.26.2023.12.10.13.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 13:24:13 -0800 (PST)
Date:   Sun, 10 Dec 2023 20:51:56 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-pm@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Chung-Kai Mei <chungkai@google.com>,
        Hongyan Xia <hongyan.xia2@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/4] sched/fair: Be less aggressive in calling
 cpufreq_update_util()
Message-ID: <20231210205156.kausxdcwsydggwie@airbuntu>
References: <20231208015242.385103-1-qyousef@layalina.io>
 <20231208015242.385103-2-qyousef@layalina.io>
 <bc525124-da79-45af-a99b-ec4616b3fa6b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bc525124-da79-45af-a99b-ec4616b3fa6b@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/23 10:05, Lukasz Luba wrote:
> Hi Qais,
> 
> On 12/8/23 01:52, Qais Yousef wrote:
> 
> [snip]
> 
> > @@ -6704,14 +6677,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >   	 */
> >   	util_est_enqueue(&rq->cfs, p);
> > -	/*
> > -	 * If in_iowait is set, the code below may not trigger any cpufreq
> > -	 * utilization updates, so do it here explicitly with the IOWAIT flag
> > -	 * passed.
> > -	 */
> > -	if (p->in_iowait)
> > -		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
> > -
> 
> Why this io wait boost is considered as the $subject says 'aggressive'
> calling?

This will trigger a frequency update along with the iowait boost. Did I miss
something?


Cheers

--
Qais Yousef
