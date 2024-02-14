Return-Path: <linux-kernel+bounces-65057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EEA854739
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 471DC1F2A0B7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A37A1756F;
	Wed, 14 Feb 2024 10:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="OBEw/2S7"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EC210A3C;
	Wed, 14 Feb 2024 10:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707906961; cv=fail; b=nq5dy/4kaYrktyoJYfxvNvO95MvL0Ah7nTVkZwf/CRbsSlO+t3ktODccKgMQU7aco+TkLcjFu6RGpUzFzyyzddfV6boqRSnNlz9LlhA8gloevMnVl9NbhBmQbTG9nCD/QKgHMtUUOfR+Fp8UD4KXdC9ft/mAgZTDsLSixN0ofF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707906961; c=relaxed/simple;
	bh=qCf8oOLL6sVDQMNpH72xS7phjyjFAHim/OR8WREthYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAt9NsdusvexEjPLt3Pn4ZBOV3PLMkAKzSEoZDSuJ5wmkwpQIHYaRCkL2U6jhNfuVfAJpGVCJ6UqnRn0m+fmxoTXlP+m6O+ZOuSMTAnhB0e/lpiUg9nAjcdIuXGRLOBcDB6ls3s3xZB0IG537FhVzkGAKGx5Ea7+Qv9uofUdQuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b=OBEw/2S7; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xq7ChfZwr5TORGQ7EDz6ppkjunvZaoiya0+H+Dq4k72CDVxRT0ZVSOX49oqmHu74ZBLPKAKCHIjNilUQUhS50/4kDKfboWHIPFe19Q5wkhw43LW9ReCoaJ22K9cOxz0Jc0+EbL7JZTa6FhSiWlxciGJfZrjqhaUtBjA2aL7Nfs71kIj8k7rkiD7oqSKZMBYmTtKlNYvOyEdW/HGrh1dQYUuRwQ/WlZ/EwgOXjWHC/aW3qCRXjWX4U/nh5kCHhnuTpwAmDl6vzaxR+sAaEYqQBaK3RkBsjFL52ilA3zl6kK169Ars0ghXqNh5R0D+TBe8mQzwuKDVMrbQrjt09rwnDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/NLFDc9zOvoANAwIqb4vg8ALUyOc+KFaDQJXoCI/XU=;
 b=Jra530uZQ5rAIJlQKvhvzFYzWDaNCfWc/BfvF2uv6ttfXd892ZILAmo5t33bzclltNQQsFXdVBfFFfOMzesLs5dkuqj29TXXntsG4NQh5OjPYZdtgCxROGfUO0pH6SmkdwIYQhI3GKT8xRiEXRwqvojPRcus8qPYzPRE+Ln1kG9e66R1IXsbMC95gm/FLKtgrl6002FZVic/h0q5N9ROsmAnd8mh4rc4ZtSN70QBe93QF1HzaMeROV9kk1LnZc8rF4IO3rOPtWUyIRz6nIzMhEyPPn3lbZNz4S+y3KRZWfJNKJ+mDUQFVgSr7OBjx88MGL2oAGMZfPSicuxOpfOEfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 121.100.38.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/NLFDc9zOvoANAwIqb4vg8ALUyOc+KFaDQJXoCI/XU=;
 b=OBEw/2S7nabjb2ipUClPdQE0GcwMt3CQuvAc8UPSnOdL7fDaRz1TgAE7RHioq4nqaTjylpAN2px21xRrBSrDEbqb2ulQstgeTqOJH+NOqIi1C32Bx/9bXRTrk4jjSHhjywgwa/oMTLEzwRKJKyo+NXwoGMcuOwnPRaEZV6VQrZ4=
Received: from CYXPR02CA0058.namprd02.prod.outlook.com (2603:10b6:930:cd::27)
 by MW4PR13MB5990.namprd13.prod.outlook.com (2603:10b6:303:1ba::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Wed, 14 Feb
 2024 10:35:56 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:930:cd:cafe::e9) by CYXPR02CA0058.outlook.office365.com
 (2603:10b6:930:cd::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40 via Frontend
 Transport; Wed, 14 Feb 2024 10:35:56 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 121.100.38.198)
 smtp.mailfrom=sony.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=sony.com;
Received-SPF: Fail (protection.outlook.com: domain of sony.com does not
 designate 121.100.38.198 as permitted sender)
 receiver=protection.outlook.com; client-ip=121.100.38.198;
 helo=gepdcl09.sg.gdce.sony.com.sg;
Received: from gepdcl09.sg.gdce.sony.com.sg (121.100.38.198) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 10:35:55 +0000
Received: from gepdcl02.s.gdce.sony.com.sg (SGGDCSE1NS07.sony.com.sg [146.215.123.196])
	by gepdcl09.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 41EAZH1P005129;
	Wed, 14 Feb 2024 18:35:30 +0800
Received: from mail.sony.com ([43.88.80.246])
	by gepdcl02.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 41EAZGHJ003033;
	Wed, 14 Feb 2024 18:35:16 +0800
Received: by mail.sony.com (Postfix, from userid 1000)
	id 7572720C089C; Wed, 14 Feb 2024 16:03:50 +0530 (IST)
Date: Wed, 14 Feb 2024 16:03:50 +0530
From: Sreenath Vijayan <sreenath.vijayan@sony.com>
To: Petr Mladek <pmladek@suse.com>
Cc: john.ogness@linutronix.de, corbet@lwn.net, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, rdunlap@infradead.org, rostedt@goodmis.org,
        senozhatsky@chromium.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        taichi.shimoyashiki@sony.com, daniel.palmer@sony.com,
        anandakumar.balasubramaniam@sony.com
Subject: Re: [PATCH v4 1/2] printk: Add function to dump printk buffer
 directly to consoles
Message-ID: <ZcyXDvBBqYvkLr9e@sony.com>
References: <cover.1706772349.git.sreenath.vijayan@sony.com>
 <8cb5936021c5811bd03a6bc18300b1384009ac26.1706772349.git.sreenath.vijayan@sony.com>
 <ZcOXEyPsRnfewb4Y@alley>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcOXEyPsRnfewb4Y@alley>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|MW4PR13MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: 56417c6c-81c2-4744-c38d-08dc2d48b9e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ohp3iOiOrgY29W2j2eJMc+NuVsmu9QsOZDv1BoN2ignmk7aW/mH7xPE6dnvVXG9hN0lzMWolXIpLn3DPFxLoZqNE76h20753RVcy6fNpv8OvCyB+SHVwGnwNche4lIj6qPk6wvjMAN2wSx16F4lVobPv0/L0RmGS6f5O+hy+ss03E5LUrkWUM+A9BsNNUX3gCbU6IqNI+CSOiRqJz2vGw5Y5aVTmw3nUpQIsO8IE4S9xPOf7/5oijZGbrP4/2y+ZHVlAN0ixpw3+XOp4FQy9Hp/oIwlqe7ukfE+GNy2tGYFJcuuG5oJ4m5wOxl0PgEC2bxy32FdI7JvX+btu7DaMdy8IBaYXHcqH2NhAuixrCDxE15c4fo5uAIJxk0QBbTQY5bxA378S87neU1aHxNMUO9qlP58dG9inLPZA++/m6PFqGCDZxYKcs2/S7q0t1wpXWvyeQnNerKhhRfGA3frpXO2dL0WbSFIYKgt1IJfrQTD2xz+85EyF3btXXlEIUwFchFm0qMcR+E5ZBEzzph23hZh7r10et71oPgWqFyaZs8pL8s3dv7Xq3cmr4rGD8PJpvKG4lBL9lG+4isxjIVS04sh+StVD6Lt2seTL9BpvV28=
X-Forefront-Antispam-Report:
	CIP:121.100.38.198;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:gepdcl09.sg.gdce.sony.com.sg;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(82310400011)(186009)(1800799012)(451199024)(64100799003)(36840700001)(46966006)(40470700004)(2616005)(478600001)(107886003)(41300700001)(2906002)(4326008)(6862004)(5660300002)(70206006)(44832011)(8676002)(450100002)(8936002)(42186006)(316002)(26005)(83380400001)(36756003)(86362001)(82960400001)(426003)(336012)(6266002)(356005)(82740400003)(81166007);DIR:OUT;SFP:1101;
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 10:35:55.2605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56417c6c-81c2-4744-c38d-08dc2d48b9e7
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[121.100.38.198];Helo=[gepdcl09.sg.gdce.sony.com.sg]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR13MB5990

On Wed, Feb 07, 2024 at 03:43:52PM +0100, Petr Mladek wrote:
> On Thu 2024-02-01 15:53:40, Sreenath Vijayan wrote:
> > It is useful to be able to dump the printk buffer directly to
> > consoles in some situations so as to not flood the buffer.
> 
> This is not longer true. I think that it was valid for
> the previous versions which used separate buffers with
> the kmsg_dump API.
> 
> > To do this, we reuse the CONSOLE_REPLAY_ALL mode code in
> > console_flush_on_panic() by moving the code to a helper function
> > console_rewind_all(). This is done because console_flush_on_panic()
> > sets console_may_schedule to 0 but this should not be done in our
> > case.
> 
> Also the "c->seq = seq;" is not safe in the panic version.
> But it will be safe when called under the console_lock.
> 
> > Then console_rewind_all() is called from the new function
> > dump_printk_buffer() with console lock held to set the console
> > sequence number to oldest record in the buffer for all consoles.
> > Releasing the console lock will flush the contents of printk buffer
> > to the consoles.
> 
> My proposed commit message is:
> 
> <proposal>
> Add a generic function for replaying the kernel log on consoles.
> It would allow seeing the the log on an unresponsive terminal
> via sysrq interface.
> 
> Reuse the existing code from console_flush_on_panic() for
> reseting the sequence numbers. It will be safe when called
> under console_lock(). Also the console_unlock() will
> automatically flush the messages on the consoles.
> 
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -3134,6 +3134,32 @@ void console_unblank(void)
> >  		pr_flush(1000, true);
> >  }
> >  
> 
> I would call this function __console_rewind_all(void)
> because it is not safe on its own. Also It would
> deserve a comment, something like:
> 
> /*
>  * Rewind all consoles to the oldest available record.
>  *
>  * IMPORTANT: The function is safe only when called under
>  *            console_lock(). It is not enforced because
>  *	      it is used as a best effort in panic().
>  */
> static void __console_rewind_all(void)
> 
> 
> This would deserve a comment because it is not safe by
> default.
> 
> > +static void console_rewind_all(void)
> > +{
> > +	struct console *c;
> > +	short flags;
> > +	int cookie;
> > +	u64 seq;
> > +
> > +	seq = prb_first_valid_seq(prb);
> > +
> > +	cookie = console_srcu_read_lock();
> > +	for_each_console_srcu(c) {
> > +		flags = console_srcu_read_flags(c);
> > +
> > +		if (flags & CON_NBCON) {
> > +			nbcon_seq_force(c, seq);
> > +		} else {
> > +			/*
> > +			 * This is an unsynchronized assignment. On
> > +			 * panic legacy consoles are only best effort.
> > +			 */
> 
> We should change this to something like:
> 
> 			/*
> 			 * This assigment is safe only when called under
> 			 * console_lock(). */
> 			 */
> 
> > +			c->seq = seq;
> > +		}
> > +	}
> > +	console_srcu_read_unlock(cookie);
> > +}
> > +
> >  /**
> >   * console_flush_on_panic - flush console content on panic
> >   * @mode: flush all messages in buffer or just the pending ones
> > @@ -3162,30 +3188,8 @@ void console_flush_on_panic(enum con_flush_mode mode)
> >  	 */
> >  	console_may_schedule = 0;
> >  
> > -	if (mode == CONSOLE_REPLAY_ALL) {
> > -		struct console *c;
> > -		short flags;
> > -		int cookie;
> > -		u64 seq;
> > -
> > -		seq = prb_first_valid_seq(prb);
> > -
> > -		cookie = console_srcu_read_lock();
> > -		for_each_console_srcu(c) {
> > -			flags = console_srcu_read_flags(c);
> > -
> > -			if (flags & CON_NBCON) {
> > -				nbcon_seq_force(c, seq);
> > -			} else {
> > -				/*
> > -				 * This is an unsynchronized assignment. On
> > -				 * panic legacy consoles are only best effort.
> > -				 */
> > -				c->seq = seq;
> > -			}
> > -		}
> > -		console_srcu_read_unlock(cookie);
> > -	}
> > +	if (mode == CONSOLE_REPLAY_ALL)
> > +		console_rewind_all();
> >  
> >  	console_flush_all(false, &next_seq, &handover);
> >  }
> > @@ -4259,6 +4263,15 @@ void kmsg_dump_rewind(struct kmsg_dump_iter *iter)
> >  }
> >  EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
> >  
> > +/**
> > + * Dump the printk ring buffer directly to consoles
> > + */
> > +void dump_printk_buffer(void)
> 
> I would call this function console_replay_all(). IMHO, it better describes
> what it does.
> 
> > +{
> > +	console_lock();
> > +	console_rewind_all();
> 
> I would add a comment:
> 
> 	/* Consoles are flushed as part of console_unlock(). */
> 
> > +	console_unlock();
> > +}
> >  #endif
> 
> Best Regards,
> Petr

Thank you for the review comments. Will fix all these points in the
next version.

Regards,
Sreenath

