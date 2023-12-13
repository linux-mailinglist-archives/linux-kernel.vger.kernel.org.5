Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD171811CC7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbjLMSig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbjLMSi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:38:27 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCA210D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:38:34 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6ceb27ec331so4724014b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702492714; x=1703097514; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aP0+DaLfepHxP70wW1Gax8IzK3ru38iVVmbmgXj+IhY=;
        b=TgbHx0u7m22dJFWYt6TRDACn88IhEI6UHj0hqxR7kxazhiUopMX0eHc+uEZVxa4Ldp
         5tPdpxCMZokWscIuOvpjoOa0b2HNOpxquWAU7p/hd1Y3tiU5HvjpDLdrdNz1xlj4UIny
         JIF6DataVDEpE2oMNFvW3mf+LfFUbAMBR9EQ0tp3det/Hg9xjYmHcKgJVC3AQo8Je/j3
         Im43d3yr/NyeZjMDL1d6Ep5vQtW1POEQNiHeYCPi64ZU6NrBPbziVvDbw7ixt90xCEA5
         RoQezo23eM9lVJnvuN/2K1TJpDKMnYqdtPRaATOCVm2ituUeVWlo60LcRSu7OYdF/xqA
         G1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702492714; x=1703097514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aP0+DaLfepHxP70wW1Gax8IzK3ru38iVVmbmgXj+IhY=;
        b=Qjq3VM8wBoKjLjNnW+hI57yRSfhmgnAPZqh82pZapAbJqWXw+eCdQrale19x3PNho1
         Ebc2HQP5dHB5HPGmhfDzdVL5sOKomR4YmRuBGhGmuawEbF7BghynOKBQXLleQwhjlNkA
         uWA0r2qpj8wcaKS+YMFd31ehgu3cvL9N/5mB6KxvFWHWbWDVXxKONtq2kR2n4E6R3anW
         2rbWoCyRTm0hGZBoB5MP06Oh15bHs4UnKujhQL5LCTdz4Cl3LeVrZ4RFzOJjrcwhJTve
         WqYMLy6ipG9FU/QQgoOdG/TDP4rW3x0A9Wb7rl6kefyNJviN6pGS1Rhmopyml152rgfZ
         EAjA==
X-Gm-Message-State: AOJu0YyRul1Jy97i6wCqbgI3bb6BWgk4tbKek88Fmtkg0wc2PmJfaM0G
        eY620q15I0uNS0pc9ftfHVQ=
X-Google-Smtp-Source: AGHT+IEdiNTWejF/6XdIcn6jNFbc4LTqKtHXG9tvAyyxAe5Rib8ovN4qD47DkMbaMIMFXN2v9qyMUw==
X-Received: by 2002:a05:6a20:8f0f:b0:18c:159b:777 with SMTP id b15-20020a056a208f0f00b0018c159b0777mr4979433pzk.26.1702492713524;
        Wed, 13 Dec 2023 10:38:33 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id k8-20020a63ba08000000b005b1bf3a200fsm8959166pgf.1.2023.12.13.10.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 10:38:33 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 13 Dec 2023 08:38:31 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Aaron Tomlin <atomlin@atomlin.com>, linux-kernel@vger.kernel.org,
        jiangshanlai@gmail.com, peterz@infradead.org
Subject: Re: [RFC PATCH 0/2] workqueue: Introduce PF_WQ_RESCUE_WORKER
Message-ID: <ZXn6J5bN-dPC1WSk@slm.duckdns.org>
References: <20230729135334.566138-1-atomlin@atomlin.com>
 <um77hym4t6zyypfbhwbaeqxpfdzc657oa7vgowdfah7cuctjak@pexots3mfb24>
 <ZXdXdBzvbkI4Y4fL@slm.duckdns.org>
 <ZXguMgcKLCLn16T4@localhost.localdomain>
 <ZXiVCOKk90Fjpmhw@slm.duckdns.org>
 <ZXlyfjDsFGbYcMU6@localhost.localdomain>
 <ZXnPVtISKQ2JFDNn@slm.duckdns.org>
 <ZXn4qiMetd7zY1sb@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXn4qiMetd7zY1sb@localhost.localdomain>
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

On Wed, Dec 13, 2023 at 07:32:10PM +0100, Juri Lelli wrote:
> > Maybe the easiest way to do this is making rescuer_thread() restore the wq's
> > cpumask right before going to sleep, and making apply_wqattrs_commit() just
> > wake up the rescuer.
> 
> Hummm, don't think we can call that either while the rescuer is actually
> running. Maybe we can simply s/kthread_bind_mask/set_cpus_allowed_ptr/
> in the above?

So, we have to use set_cpus_allowed_ptr() but we still don't want to change
the affinity of a rescuer which is already running a task for a pool.

Thanks.

-- 
tejun
