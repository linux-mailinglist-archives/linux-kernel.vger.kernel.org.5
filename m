Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A247CD8A1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjJRJxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjJRJxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:53:16 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B871FD
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 02:53:15 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c9b95943beso55942585ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 02:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697622794; x=1698227594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XWww5smGZiKM1zO5u+I0nBnhhjZpj4rKz0idTCEfo7w=;
        b=XejG7sxChvY4DWvjYfH0HOnnWXs6RdKSkpwMRfw2q82r7gW/8eAFLOUle5j79YEEzi
         u/WbWCJXeRgOYQ4QImNIqIIHnXQFTf5G8jK6HdyMtmOOf/RtvKf9KTnFbcugvN+JVDm8
         QqmipOP7gLyIoYs+FoS8bfsGG23fqBPsoh47At25cYGuB/DLjowGS9b0Csh6+8+v5WD3
         RShidb2uYvwZW34r1nnuPpLwhNbohQN3KjANMiMZx3EzOq8R9vQg6wmZa7T0VkGmqrQF
         /3iMKCKX+NvpWOvrouYlb/CQgcTYFbmY5oaV1lHiiHT798CzTCRsva12+Sfho+tri4WB
         yRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697622794; x=1698227594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWww5smGZiKM1zO5u+I0nBnhhjZpj4rKz0idTCEfo7w=;
        b=qgtHdruhsZRtpZRfcCDpaS53RYyD32QmyKdeVhgQ+9rHwcFfQY711857dMJB192pr3
         ouYu75QLom8DJhIvPd0Qld4XFpql4Dw2IShcOcXVBpLUrYsKSX24oA0eY8AyRInsPcxJ
         MO+9xxLLHRbYJQB1z3us16qJJoE91JbScw2/iwP0G4KBuZwfINk/atiOg/VSGUiFRLVN
         4GsSNWA5VGghry9WT7Hvd3j79DhhjuYtEeRtjYZcc4bTRGgQhRdwqYBVeAVV5J+VNUzf
         PMs5547r+TsWEAfGPfgTnoDVKjzAHGg2WgWocqKMn0oL5HWj6H5GHaeVvFM28zeeVPL2
         jZew==
X-Gm-Message-State: AOJu0YyO6EUxTUJlx8ZEJo5ljsfSDGulq/YyL2/I6NOV0H/Q43Esptmz
        vppacVoqpE9F0jbZP8wDbVzbvfbN8WxCpA==
X-Google-Smtp-Source: AGHT+IGgomQfrT8uV3fjm3ff9PxK/tRPO9COy7PecDAvOs2Wkii4Zmrm8yh9stEhto3AzkNB3Px7Pg==
X-Received: by 2002:a17:902:e305:b0:1c6:d88:dc07 with SMTP id q5-20020a170902e30500b001c60d88dc07mr4594447plc.48.1697622794531;
        Wed, 18 Oct 2023 02:53:14 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id y9-20020a17090264c900b001c61901ed37sm3150300pli.191.2023.10.18.02.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 02:53:13 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 17 Oct 2023 23:53:12 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] workqueue: Provide one lock class key per work_on_cpu()
 callsite
Message-ID: <ZS-rCIejToOlJcqm@slm.duckdns.org>
References: <20230924150702.9588-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230924150702.9588-1-frederic@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2023 at 05:07:02PM +0200, Frederic Weisbecker wrote:
> All callers of work_on_cpu() share the same lock class key for all the
> functions queued. As a result the workqueue related locking scenario for
> a function A may be spuriously accounted as an inversion against the
> locking scenario of function B such as in the following model:
> 
> 	long A(void *arg)
> 	{
> 		mutex_lock(&mutex);
> 		mutex_unlock(&mutex);
> 	}
> 
> 	long B(void *arg)
> 	{
> 	}
> 
> 	void launchA(void)
> 	{
> 		work_on_cpu(0, A, NULL);
> 	}
> 
> 	void launchB(void)
> 	{
> 		mutex_lock(&mutex);
> 		work_on_cpu(1, B, NULL);
> 		mutex_unlock(&mutex);
> 	}
> 
> launchA and launchB running concurrently have no chance to deadlock.
> However the above can be reported by lockdep as a possible locking
> inversion because the works containing A() and B() are treated as
> belonging to the same locking class.

Sorry about the delay. I missed this one. Applied to wq/for-6.7.

Thanks.

-- 
tejun
