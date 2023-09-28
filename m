Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2067B1703
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjI1JTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbjI1JTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:19:00 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C1DB7;
        Thu, 28 Sep 2023 02:18:59 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9936b3d0286so1634513766b.0;
        Thu, 28 Sep 2023 02:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695892738; x=1696497538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f0I8AEvxud0N3U/mCzEd6vO0RsTxP2xVStL4mYXmgZI=;
        b=PerTNBvJ+Dt5fW+T9e7a+cedIe8KEkvcY/sC6zeSvIkP8x6sFvQxfWmEi1JOWMOHwh
         PHZzlb1P1q/7/hJioIlhUlJSd8EIEjT4qvk6CusGQNZ7SM7zgbkgwF8GT2eNsBY5jMHL
         pTCM5fQGDvZ2yLCncSsKdh4gFCAnW8erhwpdXAfKhB0SDUPnJB0eOqER+TO9c4XDTivc
         eeoVBZ5LNDYbVM3C4FyaDx3Ib6YFPv3mIL2uYdxDX+Nf9iP9qtUY3Q4NGpCosES8OYk+
         wjL4rYyitsse4L2mC2IWdHncFsFKs7dYM7RNhb6Wq0cKbwXxxtxytYOFJH9ylXMUmwXa
         fMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695892738; x=1696497538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0I8AEvxud0N3U/mCzEd6vO0RsTxP2xVStL4mYXmgZI=;
        b=YB6DwUOVDh783Yb0uwoaR+m85fLsPVgKT4FCr5KcAxh07W4EBj+f7t2JcLmTxMnebt
         ojoob8LyeUfgW68rwIB8hObj9WHVdW6sxdmWPqcsCzwhKiADB821Rs6Tx2GWQqi0izPE
         JMRX/IHOc9fJy5Qu4Lahq04tpKGEwDl1RQFsfHPdbOPDrk0WUTlnfufdrAud1dsvsIPP
         pMn6GkJTb2ymvAlDFFbAv0xQhWjEKhmEYJqOVAPXecaTDVOugkJI/gvONHWhNF5/6+2S
         szv24WKP+HK5+MZAckXl+tz6jgciZFnS0W/B9J2wGpmMotJtd3v9O1TS+WpaLbIG4JsJ
         4ISg==
X-Gm-Message-State: AOJu0YwkLl1i87gbErS0N7gSlkDe9fSdOoTBE3sJzFmiDePUG8fr2pjj
        CeLoWqMkOFLqKPPVN7TV0sE=
X-Google-Smtp-Source: AGHT+IFPh/r1TyxtRbkXEAXTdqs7ZV2buYWXt7RQCyLLk6tgfYiPozTfQSuBwY7Gjj099Namzn85Ng==
X-Received: by 2002:a17:906:73ca:b0:9af:159a:5113 with SMTP id n10-20020a17090673ca00b009af159a5113mr768221ejl.52.1695892737505;
        Thu, 28 Sep 2023 02:18:57 -0700 (PDT)
Received: from gmail.com (1F2EF49C.nat.pool.telekom.hu. [31.46.244.156])
        by smtp.gmail.com with ESMTPSA id r1-20020a1709067fc100b0099d804da2e9sm10600973ejs.225.2023.09.28.02.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 02:18:56 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 28 Sep 2023 11:18:54 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, ltp@lists.linux.it
Subject: Re: [PATCH v2 2/2] docs: scheduler-rt: Clarify & fix sched_rt_*
 sysctl docs
Message-ID: <ZRVE/nQlVi1woRPf@gmail.com>
References: <20230927103012.9587-1-chrubis@suse.cz>
 <20230927103012.9587-3-chrubis@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927103012.9587-3-chrubis@suse.cz>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Cyril Hrubis <chrubis@suse.cz> wrote:

> - Describe explicitly that sched_rt_runtime_us is allocated from
>   sched_rt_period_us and hence always less or equal to that value.

Just some spelling nits:

> - The limit for sched_rt_runtime_us is not INT_MAX - 1 but rather it's
>   limited by the value of sched_rt_period_us. If sched_rt_period_us is
>   INT_MAX then sched_rt_runtime_us can be set to INT_MAX as well.

s/is not INT_MAX - 1 but rather it's
 /is not INT_MAX-1, but rather it's

>  /proc/sys/kernel/sched_rt_runtime_us:
> -  A global limit on how much time realtime scheduling may use.  Even without
> -  CONFIG_RT_GROUP_SCHED enabled, this will limit time reserved to realtime
> -  processes. With CONFIG_RT_GROUP_SCHED it signifies the total bandwidth
> -  available to all realtime groups.
> +  A global limit on how much time realtime scheduling may use. This is always

s/realtime
 /real-time

> +  less or equal than the period_us as it denotes the time allocated from the

s/than the period_us as it denotes
 /than the period_us, as it denotes

> +  period_us for the realtime tasks. Even without CONFIG_RT_GROUP_SCHED enabled,
> +  this will limit time reserved to realtime processes. With

s/realtime
 /real-time

> +  CONFIG_RT_GROUP_SCHED it signifies the total bandwidth available to all

s/CONFIG_RT_GROUP_SCHED
 /CONFIG_RT_GROUP_SCHED=y

> +  realtime groups.

s/realtime
 /real-time

Thanks,

	Ingo
