Return-Path: <linux-kernel+bounces-31746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA6E83334C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 09:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6027B2840D7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 08:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E7246A8;
	Sat, 20 Jan 2024 08:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="dFt7ghmS"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2091.outbound.protection.outlook.com [40.107.102.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AB45381;
	Sat, 20 Jan 2024 08:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705740597; cv=fail; b=MLgj0ZX4J3oVCwR1GlBJuWZRMvqBxvthW27N5wALXmtbv36xXx5wqklp3ReJt4DLMWQJaQ0Flj0HjOuC351N2Xi9TWA2tCyJtL45Q2aVWtPn14PXu++I5BPk7gQ6p6nWj2mA73IbV6Xu08Ee7U0abhGQYKXdjXUtA/K5MDs6rvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705740597; c=relaxed/simple;
	bh=L+K4CiVqSyO96JIP0qvkg8cDCwCLFn5zlJQv51Ys8h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPeN0xPj/jL+jgRDDh6p/W4w6Bb9Zy5b5SBtiBZWnJXB3K3X2FSBLy1WLvffIOeBNUxXWzK3dAPLdTz/W3TXjHTvYpIuP6a5e00uEWXzT/8zsIAO072HiMmI84EL5ZmAVjvAW84aoN631ntrtGwM6w1k2booMphAG8QzWIVUewQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b=dFt7ghmS; arc=fail smtp.client-ip=40.107.102.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3uNZqd83WjQ9T1ktGr2L6Ht8mk7/2eAW3Bc4RuidHwpZdbhdWZrFau2pZkW7qK8L5M66ChgHLEYH1uGxQIx70nHBORwefu0DuSzIR9wv3CxCkuGfa6BFad18kDwzYGSE1P/SDFlSKs50rPYSieFG3JL3dRLb4j7R61RHMuRfszhBBnqv/h9UDGpR1v2FaQmck4Fna31Up28vs7ATXHe/x8nR1dCtOfaIzsuoBgt002YenjiioCiFSNZSSPhsvj+z5OzSuCynelZ+u0XCBKcfaMpgypzaWbQIS+zkKTnkbsJT0Jyh4Kq07xJdWXTCWPSqkTIam7vTVAX04MFd19THw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpfgNU5qpYCgSwJcSiRvLvMi25vLK7Yaf/I4tMzZnh0=;
 b=fVYk/rnM7ifTYN8Jh/9s2X3Kl57HJMEpskMSfUACyowfAMxosqCPUnMnku5yi7NKmdPzEYqy1bJm27bxPmZTwHN/a0f15vW23xnZVF5CO4t/5QH6VmajotdAW8zIUJsQoTDEjPbKINGoOBxc24SQrhKd4eeEDJu04Mgixtzs9Aj4742xAh9aRwrILM+jUCeZBfpOcv+N33mRj+b9CGaxsyWmIYkUd/58VP2c9QqkIQHZWzbNTny47YJ+b3GVO9mvAC1m52eeWQdCAfBYu42k7QN5/01CfMpZrKbasPjw/Ozb/En6iy89gwUMCQfUBa+KoXjSgbsJq/D0sFgkUp3/QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 121.100.38.196) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpfgNU5qpYCgSwJcSiRvLvMi25vLK7Yaf/I4tMzZnh0=;
 b=dFt7ghmSjXqxSrXtc8S1qf8FnRQmKSGQxq5FkFBW9QMjMLTzdTvndaa0rGMZMnmBHbHPpTf7qzBmsPyQqxcBBf42xtHD0q+hf/1uJvNrf/zRkOeKu+ub8xfgjEcNpaOMLIViat1vJN4x0y325rbOGy/ZM1cHCBW+jOg8/sFxKD8=
Received: from DS7PR05CA0083.namprd05.prod.outlook.com (2603:10b6:8:57::29) by
 CO3PR13MB5704.namprd13.prod.outlook.com (2603:10b6:303:170::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.26; Sat, 20 Jan
 2024 08:49:52 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:8:57:cafe::dc) by DS7PR05CA0083.outlook.office365.com
 (2603:10b6:8:57::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.9 via Frontend
 Transport; Sat, 20 Jan 2024 08:49:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 121.100.38.196)
 smtp.mailfrom=sony.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=sony.com;
Received-SPF: Fail (protection.outlook.com: domain of sony.com does not
 designate 121.100.38.196 as permitted sender)
 receiver=protection.outlook.com; client-ip=121.100.38.196;
 helo=gepdcl07.sg.gdce.sony.com.sg;
Received: from gepdcl07.sg.gdce.sony.com.sg (121.100.38.196) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Sat, 20 Jan 2024 08:49:50 +0000
Received: from gepdcl04.s.gdce.sony.com.sg (SGGDCSE1NS08.sony.com.sg [146.215.123.198])
	by gepdcl07.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 40K8nXXH018928
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 20 Jan 2024 16:49:33 +0800
Received: from mail.sony.com ([43.88.80.246])
	by gepdcl04.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 40K8gwAe017865;
	Sat, 20 Jan 2024 16:42:58 +0800
Received: by mail.sony.com (Postfix, from userid 1000)
	id 6087620C0410; Sat, 20 Jan 2024 14:11:19 +0530 (IST)
Date: Sat, 20 Jan 2024 14:11:19 +0530
From: Sreenath Vijayan <sreenath.vijayan@sony.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: corbet@lwn.net, gregkh@linuxfoundation.org, jirislaby@kernel.org,
        rdunlap@infradead.org, pmladek@suse.com, rostedt@goodmis.org,
        senozhatsky@chromium.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        taichi.shimoyashiki@sony.com, daniel.palmer@sony.com,
        anandakumar.balasubramaniam@sony.com
Subject: Re: [PATCH v3 1/2] printk: Add function to dump printk buffer
 directly to consoles
Message-ID: <ZauHL7RzXON92gYl@sony.com>
References: <cover.1705331453.git.sreenath.vijayan@sony.com>
 <402f0cbc3a573503c7cc794113aa5137ed7f276c.1705331453.git.sreenath.vijayan@sony.com>
 <87le8nas4f.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87le8nas4f.fsf@jogness.linutronix.de>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|CO3PR13MB5704:EE_
X-MS-Office365-Filtering-Correlation-Id: 78ad5452-54dd-4fee-a128-08dc1994c41d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/4iQcloqAvzIFEj01xtpkuddHDNVBEWIWxBonfK3OofBXUg7Zq/x4lQfSpEmsfXJpEJMT3B+j4b58ywv3rP19ZG6VsYWIpuquIknMhwVtXQG+N9+g68aVvfH1z+Z8NRQ6+djfwz3TxVYauaBeucF4tXUi9Ctu8teIo405ibAIDjtnAA8QLP3bSX3Iu+X5P1+E2lW/uEKARSmTmoZVhJIoF6gOQ3QsICvwh0nDHEs7J++sMdE4XbSiK2djFDhyz8uDfgd1zBXkmPMx/vkmZUoywxJXbKO7po9Ho1aCWaAciFS3fdSXI02irVLm9N4HLBVljy0EM3zn6LQiS5QpgjIchWj7tEVtybuS3uw6HT7eKDy38r1jdp5L2N3LfC6xwDnd9VRZSCzcMvzMWlD82X7YLxMSs8RM+HfP50TZhvg1B7/cn0ycBo0BiT29VxhlpxtqmedsI0vNydBx3Aw1ta78LfDc+PsnwRZekK96YjINq+FmPM3u+bBaZXZy/nVO4zFHyXFczsmtgHrari7VrtpL5tyvVyaqh3pSSm1rdW+68MRU18H94cJnIKzTOFbthLqo8C/brTOJD25fRLQMPWRWNQWqC8ASc/FzqsOtQpl5ZqV7Ip0eEfxFxB5vz7CdDZS6ntSInOsJdx3YgIqJV7euziaDEq/dJ7S45cVMGUJ94N9U/TnZqTLp3LxdBFXDhYmcWgPPxjk+aaBuz3EQm90y0tIh3yHD5/e/hLF7gh3M1rv/SGrXgWv/14HCqtALYh5eNdcdipSAbhFB5uVs7VmtA==
X-Forefront-Antispam-Report:
	CIP:121.100.38.196;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:gepdcl07.sg.gdce.sony.com.sg;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(451199024)(64100799003)(82310400011)(1800799012)(186009)(36840700001)(40470700004)(46966006)(426003)(336012)(44832011)(6266002)(70206006)(2616005)(26005)(107886003)(42186006)(83380400001)(316002)(4326008)(36756003)(8676002)(6862004)(82960400001)(47076005)(81166007)(82740400003)(41300700001)(5660300002)(36860700001)(86362001)(2906002)(356005)(8936002)(450100002)(40480700001)(478600001)(40460700003)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2024 08:49:50.9179
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ad5452-54dd-4fee-a128-08dc1994c41d
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[121.100.38.196];Helo=[gepdcl07.sg.gdce.sony.com.sg]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO3PR13MB5704

On Thu, Jan 18, 2024 at 10:55:20AM +0106, John Ogness wrote:
> On 2024-01-17, Sreenath Vijayan <sreenath.vijayan@sony.com> wrote:
> > It is useful to be able to dump the printk buffer directly to
> > consoles in some situations so as to not flood the buffer.
> > This needs access to private items of printk like PRINTK_MESSAGE_MAX.
> > Add function in printk.c to accomplish this.
> >
> > Suggested-by: John Ogness <john.ogness@linutronix.de>
> > Signed-off-by: Sreenath Vijayan <sreenath.vijayan@sony.com>
> > Signed-off-by: Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>
> > ---
> >  include/linux/printk.h |  4 ++++
> >  kernel/printk/printk.c | 33 +++++++++++++++++++++++++++++++++
> >  2 files changed, 37 insertions(+)
> >
> > diff --git a/include/linux/printk.h b/include/linux/printk.h
> > index 8ef499ab3c1e..0896745f31e2 100644
> > --- a/include/linux/printk.h
> > +++ b/include/linux/printk.h
> > @@ -192,6 +192,7 @@ void show_regs_print_info(const char *log_lvl);
> >  extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
> >  extern asmlinkage void dump_stack(void) __cold;
> >  void printk_trigger_flush(void);
> > +void dump_printk_buffer(void);
> >  #else
> >  static inline __printf(1, 0)
> >  int vprintk(const char *s, va_list args)
> > @@ -271,6 +272,9 @@ static inline void dump_stack(void)
> >  static inline void printk_trigger_flush(void)
> >  {
> >  }
> > +static inline void dump_printk_buffer(void)
> > +{
> > +}
> >  #endif
> >  
> >  #ifdef CONFIG_SMP
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index f2444b581e16..5b11fb377f8f 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -4259,6 +4259,39 @@ void kmsg_dump_rewind(struct kmsg_dump_iter *iter)
> >  }
> >  EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
> >  
> > +/**
> > + * Dump the printk ring buffer directly to consoles
> > + */
> > +void dump_printk_buffer(void)
> > +{
> > +	struct kmsg_dump_iter iter;
> > +	struct console *con;
> > +	char *buf;
> > +	size_t len;
> > +	int cookie;
> > +
> > +	buf = kmalloc(PRINTK_MESSAGE_MAX, GFP_KERNEL);
> > +	if (!buf)
> > +		return;
> > +
> > +	kmsg_dump_rewind(&iter);
> > +	while (kmsg_dump_get_line(&iter, 1, buf, PRINTK_MESSAGE_MAX, &len)) {
> 
> Although using the kmsg_dump interface will provide you the messages,
> they will not necessarily be in the correct format. Consoles can be set
> to use extended format.
> 
> We probably should respect that console setting.

Thank you for reviewing the patch and pointing out the limitations
of ksmg_dump interface.

> 
> > +		/*
> > +		 * Since using printk() or pr_*() will append the message to the
> > +		 * printk ring buffer, they cannot be used to display the retrieved
> > +		 * message. Hence console_write() of serial drivers is used.
> > +		 */
> > +		console_lock();
> > +		cookie = console_srcu_read_lock();
> > +		for_each_console_srcu(con) {
> > +			if ((console_srcu_read_flags(con) & CON_ENABLED) && con->write)
> 
> console_is_usable() should be used instead. It makes the correct checks.
>

Ok, noted.
 
> > +				con->write(con, buf, len);
> > +		}
> > +		console_srcu_read_unlock(cookie);
> > +		console_unlock();
> > +	}
> > +	kfree(buf);
> > +}
> 
> We could do something like this:
> 
> void dump_printk_buffer(void)
> {
> 	console_lock();
> 	console_flush_on_panic(CONSOLE_REPLAY_ALL);
> 	console_unlock();
> }
> 
> This version respects all the console features (formatting, handovers),
> but console_flush_on_panic() does not to allow cond_resched(), which we
> would want in this case.
> 
> We could take the console sequence-resetting code out into its own
> helper function. Then it would look like this (comments removed to keep
> things short):
> 
> static void console_rewind_all(void)
> {
> 	struct console *c;
> 	short flags;
> 	int cookie;
> 	u64 seq;
> 
> 	seq = prb_first_valid_seq(prb);
> 
> 	cookie = console_srcu_read_lock();
> 	for_each_console_srcu(c) {
> 		flags = console_srcu_read_flags(c);
> 
> 		if (flags & CON_NBCON)
> 			nbcon_seq_force(c, seq);
> 		else
> 			c->seq = seq;
> 	}
> 	console_srcu_read_unlock(cookie);
> }
> 
> void console_flush_on_panic(enum con_flush_mode mode)
> {
> 	bool handover;
> 	u64 next_seq;
> 
> 	console_may_schedule = 0;
> 
> 	if (mode == CONSOLE_REPLAY_ALL)
> 		console_rewind_all();
> 
> 	console_flush_all(false, &next_seq, &handover);
> }
> 
> void dump_printk_buffer(void)
> {
> 	bool handover;
> 	u64 next_seq;
> 
> 	console_lock();
> 	console_rewind_all();
> 	console_flush_all(true, &next_seq, &handover);
> 	console_unlock();
> }
> 
> Any thoughts?
> 
> John

Thank you for suggesting this new method. From initial tests,
this change looks ok. I will do more testing and send out the
next version.

Sreenath

