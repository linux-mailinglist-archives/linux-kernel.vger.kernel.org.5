Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7AC76D694
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 20:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbjHBSK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 14:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbjHBSKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 14:10:47 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28F52704
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 11:10:35 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bba48b0bd2so1072795ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 11:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690999835; x=1691604635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ldvDwR+TbK2QfS8E1DpAj886KyiAxDSW8+aMumyhSP4=;
        b=YCD0Qgu9KEs/01vlshq7vgamQUq2iwEcGVAA/dU6ceJRnKZ0R4kTQKnLUs7qoJ1KTw
         y2WzL0DJw8CLtzDO9d3XYhzUKw6ewLW3gYXDe+AMmM4R0abPYilMxLve0Wg4/fb5vOV7
         xBYHpxLOrrkladpdurehm8/OlkHS+AbhY65oF6XnBQY2UZzRksq4rJBKKfLRXACS1Vdc
         XI45SUPCgN35/sOA7ohp9IMl+fMf9EOOEk8MOpl1INLVsn6j0tjLbunLACuQxyPjS+S8
         Cu8IuSSNgiTWRvTW71MnHrdJuEozIOks6JD9Pv8oprCbwnN9UWO7wfH9mH3103W0k3va
         lFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690999835; x=1691604635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ldvDwR+TbK2QfS8E1DpAj886KyiAxDSW8+aMumyhSP4=;
        b=kdo8/+6sicfuA87NkDvGGQEy3Yg7MOXBtwm5tALpIZtQQMbxvlEWzEQzEIMwywmUCF
         S3J07vt8nunHTcIm3KXrtLvRD6t50bLe/pAwNEXnbJznB7OpiiGQNsDNYzgYDKdZAfhw
         U54zcFihgVYZjnk1NRn4nmooo3+VOD/m0OH4vY15gzzQkMrqVF1qek/+uw7Ldg0jMrR/
         kREQOAy7Ju91CNzL2sNzqiUv5lL8t2K/5wzKZ8O1E+shMJwtElWXenk8aesXjSFDbol7
         0QiRQkNbcgxmbrNMuwJIIElZoTFKVPtJuxdCDzH5p0mVWqim+/KlNDDEKDHUVy1l9Yyr
         7HmQ==
X-Gm-Message-State: ABy/qLYMjcYA+uSoAB+By9U3IQsqU1bDmv7+UADatXNNDWHYMZU1u8JZ
        vOI4vGU6fFgLVdbHGDfliZQ=
X-Google-Smtp-Source: APBJJlEDNO9oKf3ODmJZdN4zDJ7iVeH5HMme3KrhK5nNF1JkAnS+pS9euqDGAEk4v361jdcFVYPA6w==
X-Received: by 2002:a17:902:e5c4:b0:1bb:5b88:73da with SMTP id u4-20020a170902e5c400b001bb5b8873damr17310361plf.61.1690999835179;
        Wed, 02 Aug 2023 11:10:35 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id iz12-20020a170902ef8c00b001b9de2b905asm12761279plb.231.2023.08.02.11.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 11:10:34 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 2 Aug 2023 08:10:33 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Aaron Tomlin <atomlin@atomlin.com>
Cc:     peterz@infradead.org, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] workqueue: Introduce PF_WQ_RESCUE_WORKER
Message-ID: <ZMqcGUderg8v5SEz@slm.duckdns.org>
References: <ZMhFUbL42Ycyc2tI@slm.duckdns.org>
 <20230801105301.952042-1-atomlin@atomlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801105301.952042-1-atomlin@atomlin.com>
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

On Tue, Aug 01, 2023 at 11:53:01AM +0100, Aaron Tomlin wrote:
> > You really shouldn't be setting affinities on kworkers manually. There's
> > no way of knowing which kworker is going to execute which workqueue.
> > Please use the attributes API and sysfs interface to modify per-workqueue
> > worker attributes. If that's not sufficient and you need finer grained
> > control, the right thing to do is using kthread_worker which gives you a
> > dedicated kthread that you can manipulate as appropriate.
> 
> I completely agree. Each kworker has PF_NO_SETAFFINITY applied anyway.
> If I understand correctly, only an unbound kworker can have their CPU
> affinity modified via sysfs. The objective of this series was to easily
> identify a rescuer kworker from user-mode.

But why do you need to identify rescue workers? What are you trying to
achieve?

Thanks.

-- 
tejun
