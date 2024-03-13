Return-Path: <linux-kernel+bounces-102473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 588EC87B296
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A79B1C2645A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEDF4CE11;
	Wed, 13 Mar 2024 20:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejMJq7M1"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292094CE04
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 20:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710360601; cv=none; b=D8ZleFEznxbrTufKNT22aEbKHfRfGSibhGgUWd/EC9OAc8J2govR/TpIFs1iK4WqMhFDKFY9JYL13Bl/uk2nXktAKEd8JraVsNMR0yHcL0X7E0pe51BRnsA7Jau+EplIIQZrPv06H+/nH+9IGJW1D6J3pMYi1EIK6iHpPmy7LMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710360601; c=relaxed/simple;
	bh=crtylJCJ37Rv30tA2SQq9ITXOrHxKa0Xy4hCndpt5ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jByL1QdOSoXFuN4zNftOsmEL/u7aiMxnDYgv6DQmbIEzQ01ZhdzOWC0/WMcAFDWC4AZ7BBS1cCaBm40KNrJl8xcbepxEsYyw56nLzXP07V4MZARH6GsJQD7Ka7yU9Z5ZW8e1eP+Dn1KwIyYseylgY64P+kBO2GgEl/XGDBqrU8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejMJq7M1; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dd10a37d68so2047375ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710360599; x=1710965399; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BZO5aH+0X1YI9UR60WVGp/9oy+26gtkvxRexbjencrY=;
        b=ejMJq7M1niyjoOxvhqH4vMd07BEhJWsxkkAh48S2doUtCBytgiUBQWP+SQVuB4n/Ow
         W+4ZtXJDAD9uOyzFPtAEP40+8SJDdm04/6PoIj0VoBB2SJdWrFeihwk46S1p2U2Qtqm/
         Ef4oaj7rvRafzzOk4yAcOCOMlXf20QS373yx6cNDIJ+NbWrXTSxlefgtSkommjiJzWpx
         ZnbWIWvAnkVDecLKi7wXD4iGWmf0+kCUEpHJ50SMb8mIzFpo/yhG9+7eSxQYnGMEzaz7
         8XQX3KIZGq5Mpo4eiX13LNzAvFGmLsCR96gxAPM/9wAif6WJ2eSbZkibbT1++O6tC0lk
         e3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710360599; x=1710965399;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZO5aH+0X1YI9UR60WVGp/9oy+26gtkvxRexbjencrY=;
        b=JZ4Ew8xIqln0UhUKftW+3wIkH0JTNC5Yem125YbeuTHM/QO2wF3clGVe/GzChKipUJ
         JaDNlRO5zff6y45i3fSMRlbSzL0AxOaTCnOA7VdEsL8vQmPbIWb8n+cfM4ASte4c8YV1
         AFodzUgLAwf2cax+zRhgZINivc+TncqsJInd75on5eKnxamb+VfhvrkekQsJTptSe0y+
         GkBU46tufBaxWVtgp/PGQE5w8CQNmo7tNGWLpCA6ch6037tc35k+1SUEmULVFa6/mmTI
         9BwIsdEyxwtL8f24JxGENGmbJObeNsIhICinyt2aypzIaXSGOorUCC9qpErEy4+zWPjQ
         9pwQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3oDija5cCMqTYAe/kwsVO4q7kZARhAWIxV+9zci5CvVj/jgm8L//WpZPTd26eXNK0qA5yi7IM71jtIXaG1XsAmBbVjeoiC5mcrH2L
X-Gm-Message-State: AOJu0YwCYfc1vYh5apz2JezAhPmx9Tzh8OZKPwzmb0ARYe9QhWKRCW5B
	lJId0NG31JJyJyygzG+0beD4SF1WrfweihCa1C2zPjfkOl5nInLn9y7jRb5n
X-Google-Smtp-Source: AGHT+IHf5/EZOF5hzrAVfXhHyqA490PEq0TzoFUHgncEHBuB1asB5/xEYtwJDwktnqcxvLuAhwqbJg==
X-Received: by 2002:a17:903:1246:b0:1dc:ceb0:b00c with SMTP id u6-20020a170903124600b001dcceb0b00cmr5470763plh.35.1710360599284;
        Wed, 13 Mar 2024 13:09:59 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:2875])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902650b00b001dcc18e1c10sm9335583plk.174.2024.03.13.13.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 13:09:58 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 13 Mar 2024 10:09:57 -1000
From: "tj@kernel.org" <tj@kernel.org>
To: =?iso-8859-1?B?V2Vp3yw=?= Simone <Simone.Weiss@elektrobit.com>
Cc: "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: BUG: MAX_LOCKDEP_ENTRIES too low! triggered by ext4&workqueue
Message-ID: <ZfIIFeXk_bZfI9MG@slm.duckdns.org>
References: <31142ccf9bd1893b773f53ff51025a27a8179367.camel@elektrobit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31142ccf9bd1893b773f53ff51025a27a8179367.camel@elektrobit.com>

On Wed, Mar 13, 2024 at 12:15:24PM +0000, Weiß, Simone wrote:
> Dear all,
> 
> For some experimentation, I have been running fuzzing campaigns and I
> noticed  BUG: MAX_LOCKDEP_ENTRIES too low! most likely triggered by ext4
> operations.
> 
> As I found a C reproducer in my setup, it could be bisected being introduced
> with the following:
> commit 967b494e2fd143a9c1a3201422aceadb5fa9fbfc
> Author: Tejun Heo <tj@kernel.org>
> Date:   Mon Aug 7 15:57:23 2023 -1000
> 
>     workqueue: Use a kthread_worker to release pool_workqueues
>     
>     pool_workqueue release path is currently bounced to system_wq; however, this
>     is a bit tricky because this bouncing occurs while holding a pool lock and
>     thus has risk of causing a A-A deadlock. This is currently addressed by the
>     fact that only unbound workqueues use this bouncing path and system_wq is a
>     per-cpu workqueue.
>  
> ...
> 
> It was reproducible on v6.6.16 and v6.16.21.
> The C reproducer is automatically generated by syzkaller and included below.
> 
> If you need any further information, just let me know.

Does the following happen to fix the issue for you?

Thanks.

diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index bbe9000260d0..bc027ea2372b 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -94,7 +94,7 @@ static const unsigned long LOCKF_USED_IN_IRQ_READ =
  * table (if it's not there yet), and we check it for lock order
  * conflicts and deadlocks.
  */
-#define MAX_LOCKDEP_ENTRIES    16384UL
+#define MAX_LOCKDEP_ENTRIES    32768UL
 #define MAX_LOCKDEP_CHAINS_BITS        15
 #define MAX_STACK_TRACE_ENTRIES        262144UL
 #define STACK_TRACE_HASH_SIZE  8192

-- 
tejun

