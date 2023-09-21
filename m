Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5257A9797
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjIURZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjIURZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:25:28 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62ACA46DF1;
        Thu, 21 Sep 2023 10:14:01 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50435a9f800so124477e87.2;
        Thu, 21 Sep 2023 10:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695316439; x=1695921239; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZOwo8hyrebGgO2V/Dzr5eBCz1cH8hJCbHTwIz3ASbYA=;
        b=WG79ZtiOEq5G7EL/My5+3TpG6xS39BVsVYYFb+vIPTyyd2nc/j5Pj2RmIeYnRGFfvL
         iQ9VNpGl+ePQJ1JLJxq4qwtDwd6VzmTBLfhtJIYP6SR+tvBigk01v9j9jhN0UFTndF0k
         RxVcduAbfEo9fcmDiGTGUGOM8dxHgf4Ml+oWZWrorR1bnK+WphVyq9ZJcU5gQN/LU4ub
         Jn+7Lw6nQjPBzCIiAhgTdR9XSxzY+ur1odFKORVsCXDRGCQN4xzxazYV8Ma4BRbHSdJT
         Ro+NFdn2rjOvVxeqDB+Ii7NbkK/EsL/VnWeC7wk/xcDmL+X0e2VhCvdCZiGf7AbxvOF0
         g1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316439; x=1695921239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOwo8hyrebGgO2V/Dzr5eBCz1cH8hJCbHTwIz3ASbYA=;
        b=ImyVc6xx/eOfPm6SA6U9PdMhxfkB4kheI7U7m0HMegGRUcHcPyjkN86L7tzgbI6XBm
         NbMcwxKiqG7G48H9oV29ji5PKvRm4YRjc+8SLZqL5lxv7jELSfANKBGkj4nl9EbBS1ud
         3bdPbj3K9+1nQZQ4PhWkJTvXV1aJC9ZVL2gvkq3Afbu2VkOXu9dY5lYWUVwT+r0Qps2A
         NS0WejEG98Rk7QL+KnZPJ8oicxAuKiTmiT4IQRaQzSKJ2n/ck5hVQZO0iJtkLWxYU4GO
         mQZiGfn7ZNCqheYpzX8nA1WxumUD7jAYyK4boF/+S5m08yUZOIc1vqCzKiHcgL4Z8BjR
         S+6A==
X-Gm-Message-State: AOJu0YyDbGOaJYvZHw+0tRBM34zBtVFxdnTxu2mvudzZVJNt1KpAECwl
        QFFHshHwxHB2O74UlZ0ttxx/tmMJO7k=
X-Google-Smtp-Source: AGHT+IHy75Zw/oHT0QdpQwOljvDOvgsSgRY8twuD810TBRpptwH+Vwig1RUsv4xZTTyAb+3v4IpDXg==
X-Received: by 2002:a05:600c:4708:b0:405:36d7:4577 with SMTP id v8-20020a05600c470800b0040536d74577mr380727wmo.26.1695283431095;
        Thu, 21 Sep 2023 01:03:51 -0700 (PDT)
Received: from gmail.com (1F2EF265.nat.pool.telekom.hu. [31.46.242.101])
        by smtp.gmail.com with ESMTPSA id m5-20020a05600c280500b003feeb082a9fsm1198206wmb.3.2023.09.21.01.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 01:03:47 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 21 Sep 2023 10:03:45 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Fangrui Song <maskray@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Subject: Re: [tip: objtool/core] x86/speculation, objtool: Use absolute
 relocations for annotations
Message-ID: <ZQv44cT8Fj7HAWa3@gmail.com>
References: <20230920001728.1439947-1-maskray@google.com>
 <169528034747.27769.14777306686927534953.tip-bot2@tip-bot2>
 <20230921072718.GB14803@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921072718.GB14803@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Sep 21, 2023 at 07:12:27AM -0000, tip-bot2 for Fangrui Song wrote:
> > The following commit has been merged into the objtool/core branch of tip:
> > 
> > Commit-ID:     0ca0043d89930cb162070598e7e4a9ed3fe57795
> > Gitweb:        https://git.kernel.org/tip/0ca0043d89930cb162070598e7e4a9ed3fe57795
> > Author:        Fangrui Song <maskray@google.com>
> > AuthorDate:    Tue, 19 Sep 2023 17:17:28 -07:00
> > Committer:     Ingo Molnar <mingo@kernel.org>
> > CommitterDate: Thu, 21 Sep 2023 08:42:38 +02:00
> 
> Ingo, can we please make this patch go away until further clarified?

Yeah, already gone.

Thanks,

	Ingo
