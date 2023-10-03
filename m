Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699F57B65E8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239812AbjJCJv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239778AbjJCJvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:51:55 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C00B7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 02:51:52 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9adca291f99so118338466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 02:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696326710; x=1696931510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ExSvwMAkpOvCS+jThDBzs2R/QjDRrK01zUKhilKpRF4=;
        b=XEw3HhNHigbD3keIjjMPS8opmu7n2BeZ3N4q9+FIi5qrcSrwmORbn519xBAbrvRmnE
         9CAfj7bbkcPZijB+j+BJMwATaBcqnHUiD2V8cd+YE4XB3sa8buOp9O6mSz1LiGNLCcc5
         EKXG8VFX0LVFT+vFjMIHRrUuQwb/SJHngI8oP4ZNsncWXjSyrd4XRXIw14Chw1C560GM
         QLuk1+E2zcYpCioII0/xt+AvUI/lJM7cw5C9iy4+OB5ba5es3BdxsnIA314NNGmbBzaI
         djqrev9UL5px+dnqUl9Xq8cf7ZFMi8Wmm9lm/GcQ4F3N19THtdSxnoOuMH9Z6yqxuMdA
         iDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696326710; x=1696931510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExSvwMAkpOvCS+jThDBzs2R/QjDRrK01zUKhilKpRF4=;
        b=ExWaGpGDS56avDjvCJeivki0SdzYYapbk4qZL0881+V3yKtb7uPJflvxASEO955TMI
         FNnDLjtKR8F4cFrxu3k/JUAcxpnoJJLXNE9s6jGFs14S3C5nPM+vz6shjxnDWkkFpGP2
         GugJYFaYgwnkuOYH1OfY67qOr0K3XkqPTcUJyC3kaCK4mwBZghrEjNYUIl82A1wEkOpS
         nygsCmfUpI7ZKeB4wp0Ec83Jb90/8yq7HFFdy+uBANhPyKTFAWuWyS7TxzIuSsH+VRZz
         0SSVokUbzy/vIbx55GvBOONtLIDmGQhsHNmdAdOTA/kVuSeecjWn+ZiiM3db+iMtpTOU
         TMkQ==
X-Gm-Message-State: AOJu0YyQXm+1oeb+Q5uBRgF/svxqB2QM84gitTIjmRSpW55h71Zdt0NO
        qW20Yl9+oJnzNEhZ3wtJX/0=
X-Google-Smtp-Source: AGHT+IGviB5WZFpDrLrzHq50Ge3Yf7yqPB7z8RWNRKpq8DzFLFcEjRwI9CHTSlchBaF+09tqFOguQg==
X-Received: by 2002:a17:907:7787:b0:9b6:aac1:6fa5 with SMTP id ky7-20020a170907778700b009b6aac16fa5mr783641ejc.55.1696326710375;
        Tue, 03 Oct 2023 02:51:50 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id rn4-20020a170906d92400b009934b1eb577sm784393ejb.77.2023.10.03.02.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 02:51:49 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 3 Oct 2023 11:51:47 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v4] sched/rt: move back to RT_GROUP_SCHED and rename it
 child
Message-ID: <ZRvkM1lxsTrHb2Ox@gmail.com>
References: <20230803050317.2240948-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803050317.2240948-1-yajun.deng@linux.dev>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Yajun Deng <yajun.deng@linux.dev> wrote:

> The member back in struct sched_rt_entity only related to RT_GROUP_SCHED,
> it should not place out of RT_GROUP_SCHED, move back to RT_GROUP_SCHED
> and rename it child.
> 
> Init child when parent isn't NULL in init_tg_rt_entry().
> 
> Introduce for_each_sched_rt_entity_reverse() to iterate rt_se from
> top to down.
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202308031034.4369b15b-oliver.sang@intel.com

Yeah, so I agree with these changes, but could you please split up this 
patch into 3 separate patches:

   sched/rt: Move sched_rt_entity::back to under the CONFIG_RT_GROUP_SCHED block
   sched/rt: Rename sched_rt_entity::back to sched_rt_entity::child
   sched/rt: Introduce for_each_sched_rt_entity_reverse() & use it

Thanks,

	Ingo
