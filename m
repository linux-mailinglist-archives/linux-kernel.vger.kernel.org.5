Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D1376F410
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 22:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjHCUex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 16:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjHCUev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 16:34:51 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350542101
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 13:34:50 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68783b2e40bso979656b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 13:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691094889; x=1691699689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yne8dE5qa+AZFO6MYiXyBrJgKLy2ndMfi+/6/yomMRw=;
        b=nNHqC61YsJnA/Qg8yL5CCfR2UgoxUchqC6/FBJyKpbR44nIStf56NQANenPVpTn2WA
         7lBydqd6CWhjTMSW9f5t95KPxgT1SZ/GYsqd32U1iPaLogNJiQiouOSmGlXwEtqi0Qxo
         fmI+DK65+mnpXh2UtxNuEuPa1RPfD33QV0xJgGuvsSeNKCJsWvzQGBKeH0wNpLJsPGCB
         ypNe3i0bfaFX0btAvDNk1mJW2Xq2HrqdNHH9Hd8MzaooZ9W5zctb43rSXS4nq5g4AV1Z
         9eO72epIT0Vm6eBlR8BN7JuAkNML/p5PcoOJvttsU0I97rKPaE79Q+bJAxo0S9dbwjgy
         eFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691094889; x=1691699689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yne8dE5qa+AZFO6MYiXyBrJgKLy2ndMfi+/6/yomMRw=;
        b=Rd8mRjIiBG0TshWmsOGkkQy4bL1eTRDcWb3AbQEggU64s6/DCeMAIe+X+7oQaaZgtq
         TNbb0w2+qlX8OF9pXneVWa3sTRly+yCG3dsDi6nqSlPIvshOLlzl6WlxQzc8bP1Fmcpf
         jAb6IROvuSEsu4rjbALU7xiG6lGt8A9DtEfPyYdtWj6Y0vROJU8sJILITESzpZ457zJB
         XMFFieZOeODSJXCHxwrZbBzDoBVpJI7QFxImoh05N04t2L6VjnaJr3hHt+fkEZ5z/5DO
         LltmbVfLYFYDs7MRSpcIxq0H25/nLwRMsD8eMqKT3EGEJHlpRTS1m7oI3SfUtcRsn31/
         pt3Q==
X-Gm-Message-State: ABy/qLbp0Kv8GYF2NMnPzy++3zEDdgM58Hni10lEgtSAOFaMg3wJWych
        /PBuLqZakvx8r8fCtRVbw6pB6Z7Oj2w=
X-Google-Smtp-Source: APBJJlE6RBAndHVVfrGkvW8smOAW6PSHoSiCAx+NgjoXOayulJGCQkKlJQ2UCarLdtUyWmSHiF5p0A==
X-Received: by 2002:a05:6a21:3284:b0:129:c38e:cdd7 with SMTP id yt4-20020a056a21328400b00129c38ecdd7mr22577763pzb.38.1691094889376;
        Thu, 03 Aug 2023 13:34:49 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:9d5d])
        by smtp.gmail.com with ESMTPSA id r20-20020a6560d4000000b005646868da17sm198181pgv.72.2023.08.03.13.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 13:34:48 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 3 Aug 2023 10:34:47 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Aaron Tomlin <atomlin@atomlin.com>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org
Subject: Re: [RFC PATCH 0/2] workqueue: Introduce PF_WQ_RESCUE_WORKER
Message-ID: <ZMwPZ7jRUrq6MjLn@slm.duckdns.org>
References: <ZMqcGUderg8v5SEz@slm.duckdns.org>
 <20230803201914.1802437-1-atomlin@atomlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803201914.1802437-1-atomlin@atomlin.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 09:19:14PM +0100, Aaron Tomlin wrote:
> > But why do you need to identify rescue workers? What are you trying to
> > achieve?
> 
> Hi Tejun,
> 
> I had a conversation with a colleague of mine. It can be useful to identify
> and account for all kernel threads. From the perspective of user-mode, the
> name given currently to the rescuer kworker is ambiguous. For instance,
> "kworker/u16:9-kcryptd/253:0" is clearly identifiable as an unbound kworker
> for the specified workqueue which can have their CPU affinity adjusted as

Note that the name changes to the work item the worker is currently
executing. It won't stay that way. Workers are shared across the workqueues,
so I'm not sure "identify and account all kernel threads" is working as well
as you think it is.

> you mentioned before. I think if we followed the same naming convention
> for a rescuer kworker then it would be more consistent. I'll send a patch
> so it can be discussed further.

We can certainly rename them to indicate that they are rescuers - e.g. maybe
krescuer? But, at the moment, the proposed reason seems rather dubious.

Thanks.

-- 
tejun
