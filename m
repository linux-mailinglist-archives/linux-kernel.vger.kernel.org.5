Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB3B76A4E8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 01:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjGaXfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 19:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjGaXfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:35:50 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1294E7C
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 16:35:47 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bbbbb77b38so29704615ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 16:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690846547; x=1691451347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D44fwITHqOzKSCX1s1m0Tgwi/dhRYO0oEqL/14QyVoc=;
        b=RwgIt1duiUrRhjEcURhmbIveMW2obdPCNKGXb6SyeOvHZR0826BdFgBW+m39HFLPso
         DUH8zr7KlwmOome+VI658BCVSPsYShfq76RTIv/qDbzdvVlK6bbDyWg2ac11a4Lb5GSx
         mRm852k8BHW+7xljYLcen7D//++6wkauB/7aIELd9IJpFuurGVkBys27y8t9XO7vJ7c0
         eFDIf3rxQekq7ycwxaAn7CaPxlHyXyvGhxyy8huCl5UjG1KeCDdrBSdsahbKecU0YC3b
         MRpnY3ZRRfPK/OynMXEOC+06dUQUb4Tvi/2n8rZa1LBaTQz7GpDMtmWUcH8fVJ1voAMq
         QEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690846547; x=1691451347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D44fwITHqOzKSCX1s1m0Tgwi/dhRYO0oEqL/14QyVoc=;
        b=cBjhxubWfkqeMCg4Mdp2HVdFAFiPVjnwnwL/qTlt3yf8VPgavN+5YuLOqhMeK//sdL
         qjzmBtKky/cTWM7m+orl8DWyj68gE1PTFdA6kQpINvMWUzS0lNk2eqH/NdiOgfL68ATc
         +WQF/pKOeT9yO6fmrpAU2nnbBLCbNmpfd0RJfnYi1jD1r6IRlT5tImOp+9Cb3vo+Pysr
         V3EkQjUR/cscHm3o8x+DKK2Y9lqBBX03gquF+Pc1u81bs56gTHBKFZ2wUrIHesYyZJbj
         19GELI6YC9v56aUDTPiAPLPccmuQVJHKILB67O0g5/OILPYUj3MUjEMPOW/OgYQn5ga1
         hDCQ==
X-Gm-Message-State: ABy/qLYLPzm5Ymp8EZSjusVPIf1jLYMDj1rwdFuefCfcVOvDZrx1P4OB
        lJ+GVYpa8jx3zkXM22NjY1Q=
X-Google-Smtp-Source: APBJJlGkgRGdtXar33TqGJe8AU5ERPlszqjEvb5w1jHguWNFfg5SU4jBQWLitU/ykPh/9ruK+HIEJQ==
X-Received: by 2002:a17:903:1107:b0:1b8:5a32:2345 with SMTP id n7-20020a170903110700b001b85a322345mr10857206plh.22.1690846547133;
        Mon, 31 Jul 2023 16:35:47 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:4a3a])
        by smtp.gmail.com with ESMTPSA id b10-20020a170902d50a00b001b890b3bbb1sm9071400plg.211.2023.07.31.16.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 16:35:46 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 31 Jul 2023 13:35:45 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Aaron Tomlin <atomlin@atomlin.com>
Cc:     linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
        peterz@infradead.org
Subject: Re: [RFC PATCH 0/2] workqueue: Introduce PF_WQ_RESCUE_WORKER
Message-ID: <ZMhFUbL42Ycyc2tI@slm.duckdns.org>
References: <20230729135334.566138-1-atomlin@atomlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729135334.566138-1-atomlin@atomlin.com>
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

On Sat, Jul 29, 2023 at 02:53:32PM +0100, Aaron Tomlin wrote:
> It can be useful to identify a rescue kworker since their CPU affinity
> cannot be modified and their initial CPU assignment can be safely ignored.

You really shouldn't be setting affinities on kworkers manually. There's no
way of knowing which kworker is going to execute which workqueue. Please use
the attributes API and sysfs interface to modify per-workqueue worker
attributes. If that's not sufficient and you need finer grained control, the
right thing to do is using kthread_worker which gives you a dedicated
kthread that you can manipulate as appropriate.

Thanks.

-- 
tejun
