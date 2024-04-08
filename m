Return-Path: <linux-kernel+bounces-134814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9886889B74F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1083A1F21732
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 05:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB688494;
	Mon,  8 Apr 2024 05:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="naPG2Vhc"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82783BE55;
	Mon,  8 Apr 2024 05:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712555783; cv=fail; b=h6Vg45HXIBGLYThaSyBevLrjci9zeDViT2w6GHQxs9UaGIP0O8oi0MyKyu9ddwT0Gos/GiMjCTCRkHiAeMExtDVX+rdByvN9Zcim9HLB7DZN5+GrAFDj1ULtCt+HfuUEtHydA5qZS1+ufUZ1uN2xC4Q8MBDX7/IcGcjZZ+rhmBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712555783; c=relaxed/simple;
	bh=sETc1CltxqaEsBFpn9XoOKsO721a28C/EPYMworu6g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkmHyJ0TE5CJ4UU9S5MumCywa8IEVuerrSUuYNBVDEgOQpgspKBvmvzB3k31qvqKalaMlrlB/X7L3u+G/AXt1aIDZmaUJ+36Ig8URToOljMadnnGsipOFPJxI0uKGh4/cFeJ2ri47HOFSRM/dgGWba71a+wOJXJ++bSIhFf3Qgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b=naPG2Vhc; arc=fail smtp.client-ip=40.107.94.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1RS+/QtZMxfYpDJbWa4y0XhBDWuX0Y1LR+bo712cFFJdgpdDju9+RUDM3l1UCBq2pUaeBPJS5buxoThXc3pu0lUp8WAXmWswPz+8i/+rhWnfa5wlzsHQXAPHQERvzQmkNuzD3mr/y4z26BfVtMolpd7PM/PW/97DsAIANEtIooKPi/qUZJV3C5ZDZFmE9RF5SPTN8a/2QzU2JOrqU/M/k0I3xoSBB3Ofe2iumRbEdMim6CBX8P8mFKy9gfD9HfH3nWwFn3+MelijLQm4icI0QXGc/1YjIAmmzs+U8KWp5fF9EA7j3Z9zid/79pXkGGzjqVQEI0XDbdLHdSEl/2cDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kmD/K69K1k1eR6qLLgoNMW8GhJj1vk3TQMPHRuUzGs=;
 b=H6ma8MB9Yfd9eBSoMY3WU8h3l66i/lAO8fP1xpNdF5BgIrRkJpnpvs5KYgD9+GLJseMsUtjLJu4HfxG66I7/a0SosTm3j8hMY6DpvkV3Ce865FBSSslBMZrGJzjstOlFe+kNZhByLQdPotZL4wiCO4HxXsNu/+hmUxOMqwPCZmKHLnLQ9xxAnefCg/0uQjHTJgm6z4wp7ouq94FRCy3FSUeH/F6+WzhK6NsE7y7/naER3HjIQglntkuCG39Pw2cFvFvLOt3jmt2RrGoZc0PQ4tAnd0zyjDIoxyiwOueWb5xQ4Hizh2jZ3odPFQh5lnv/299AlOfP49ttJcrtmMpUZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 121.100.38.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kmD/K69K1k1eR6qLLgoNMW8GhJj1vk3TQMPHRuUzGs=;
 b=naPG2Vhc0DmYiM58xjSbBoTH52WGQ7PaQkSyPcTP7vIOryldGGA3OWNrqtnTBChoFstTXEmPqWki1gu/59aa2qR7qhMro9p7I7N3rB5IwF8E5933/SsFHbFkZNcg3HG9TwN3eR1ssxjmeLqckJyhoHWX3Yunk7PjQnq2zfQJ1ek=
Received: from BN9PR03CA0134.namprd03.prod.outlook.com (2603:10b6:408:fe::19)
 by MW4PR13MB5409.namprd13.prod.outlook.com (2603:10b6:303:181::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 05:56:18 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:408:fe:cafe::f0) by BN9PR03CA0134.outlook.office365.com
 (2603:10b6:408:fe::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.35 via Frontend
 Transport; Mon, 8 Apr 2024 05:56:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 121.100.38.198)
 smtp.mailfrom=sony.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=sony.com;
Received-SPF: Fail (protection.outlook.com: domain of sony.com does not
 designate 121.100.38.198 as permitted sender)
 receiver=protection.outlook.com; client-ip=121.100.38.198;
 helo=gepdcl09.sg.gdce.sony.com.sg;
Received: from gepdcl09.sg.gdce.sony.com.sg (121.100.38.198) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7495.0 via Frontend Transport; Mon, 8 Apr 2024 05:56:16 +0000
Received: from gepdcl04.s.gdce.sony.com.sg (SGGDCSE1NS08.sony.com.sg [146.215.123.198])
	by gepdcl09.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 4385s6SK027698;
	Mon, 8 Apr 2024 13:55:59 +0800
Received: from mail.sony.com ([43.88.80.246])
	by gepdcl04.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 4385rXmh008417;
	Mon, 8 Apr 2024 13:53:33 +0800
Received: by mail.sony.com (Postfix, from userid 1001)
	id A98AF1D804D2; Mon,  8 Apr 2024 11:23:32 +0530 (IST)
Date: Mon, 8 Apr 2024 11:23:32 +0530
From: Sreenath Vijayan <sreenath.vijayan@sony.com>
To: pmladek@suse.com, john.ogness@linutronix.de, corbet@lwn.net,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc: rdunlap@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, taichi.shimoyashiki@sony.com,
        daniel.palmer@sony.com, anandakumar.balasubramaniam@sony.com
Subject: Re: [PATCH v6 2/2] tty/sysrq: Replay kernel log messages on consoles
 via sysrq
Message-ID: <ZhOGXGwGTWK5JVuU@sreenath.vijayan@sony.com>
References: <cover.1710220326.git.sreenath.vijayan@sony.com>
 <cc3b9b1aae60a236c6aed1dc7b0ffa2c7cd1f183.1710220326.git.sreenath.vijayan@sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc3b9b1aae60a236c6aed1dc7b0ffa2c7cd1f183.1710220326.git.sreenath.vijayan@sony.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|MW4PR13MB5409:EE_
X-MS-Office365-Filtering-Correlation-Id: e08d2a49-c493-433b-22b4-08dc57909b84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MA2W6rknB4Vlp6hDaZcNyAaEndR6h22VH1afjedTIKuc8GzgBIIwKi1eRtMVS7996d339eRjH8gxIMu7pmueOlCiB6LlpTG08okVLU79PpApLJzn3WLwL9xqYIXOJlSfsfyckmyrJKqUaZaKvOP/0/DKbhrcsDFPf1EPiVU60BVvosesRIKksObFcPoc6CZ3hf3flVoeg0Dtoo2TBJtUSXYz9ubeEStjrfYELq4JpC7EnqjvdlZGZq4s83C6WkdvOlWX4Dos41uwOmMTApTLBewchgWtM+CCCfZ2BW8qnbABzwwUCyV5qXiBU7uWsVmkMvm7zNROWg1Ym7IZ0BMRLwiuZSdD58fhkOnDhtur64xIDHetx1RavbA8e+hqgNMg1w53mppuSweyNRcbvdcvEP4+ljDUGIjkgW/L9od+qaVGdZ7lJRKF5PE8T6zP8cH0p9XYbdEgobMstp//Kjw7QcrQjtr8iUIyURzHoopOPDJ2Q2TtrqQ4CQ/jVti4eg6F94ZwW99CiKMeIPdWCI8EjKZXXXpY+4anEolLDO6hyJHtwJtZ+Rkzq3E6UfHfwxkRJuCXZmpu7DCKeChrAf5kbGRUnkCzf1fM/WYj2moNDeLya6fP5x894D2aCM+B9q3f35CeqEYDxkE3XHyMUTSvKj/HxmklVOMA+G1711QFQNcyigbuJkhpohyx3NJ96aGWyeyF/62OtYqc3oVtZHSudF0IkxYEe3uwSC35SA5PhGCMntjnWh8vlxI9crGPNIjp
X-Forefront-Antispam-Report:
	CIP:121.100.38.198;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:gepdcl09.sg.gdce.sony.com.sg;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 05:56:16.8303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e08d2a49-c493-433b-22b4-08dc57909b84
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[121.100.38.198];Helo=[gepdcl09.sg.gdce.sony.com.sg]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR13MB5409

On Wed, Mar 13, 2024 at 03:52:52PM +0530, Sreenath Vijayan wrote:
> When terminal is unresponsive, one cannot use dmesg to view
> the printk ring buffer messages. Also, syslog services may be
> disabled, especially on embedded systems, to check the messages
> after a reboot. In this scenario, replay the messages in printk
> ring buffer on consoles via sysrq by pressing sysrq+R.
> 
> The console loglevel will determine which all kernel log messages
> are displayed. The messages will be displayed only when
> console_trylock() succeeds. Users could repeat the sysrq key when
> it fails. If the owner of console subsystem lock is stuck,
> repeating the key won't work.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>
> Reviewed-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Sreenath Vijayan <sreenath.vijayan@sony.com>
> ---
>  Documentation/admin-guide/sysrq.rst |  9 +++++++++
>  drivers/tty/sysrq.c                 | 13 ++++++++++++-
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/sysrq.rst b/Documentation/admin-guide/sysrq.rst
> index 2f2e5bd440f9..a85b3384d1e7 100644
> --- a/Documentation/admin-guide/sysrq.rst
> +++ b/Documentation/admin-guide/sysrq.rst
> @@ -161,6 +161,8 @@ Command	    Function
>              will be printed to your console. (``0``, for example would make
>              it so that only emergency messages like PANICs or OOPSes would
>              make it to your console.)
> +
> +``R``	    Replay the kernel log messages on consoles.
>  =========== ===================================================================
>  
>  Okay, so what can I use them for?
> @@ -211,6 +213,13 @@ processes.
>  "just thaw ``it(j)``" is useful if your system becomes unresponsive due to a
>  frozen (probably root) filesystem via the FIFREEZE ioctl.
>  
> +``Replay logs(R)`` is useful to view the kernel log messages when system is hung
> +or you are not able to use dmesg command to view the messages in printk buffer.
> +User may have to press the key combination multiple times if console system is
> +busy. If it is completely locked up, then messages won't be printed. Output
> +messages depend on current console loglevel, which can be modified using
> +sysrq[0-9] (see above).
> +
>  Sometimes SysRq seems to get 'stuck' after using it, what can I do?
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index 02217e3c916b..e5974b8239c9 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -450,6 +450,17 @@ static const struct sysrq_key_op sysrq_unrt_op = {
>  	.enable_mask	= SYSRQ_ENABLE_RTNICE,
>  };
>  
> +static void sysrq_handle_replay_logs(u8 key)
> +{
> +	console_replay_all();
> +}
> +static struct sysrq_key_op sysrq_replay_logs_op = {
> +	.handler        = sysrq_handle_replay_logs,
> +	.help_msg       = "replay-kernel-logs(R)",
> +	.action_msg     = "Replay kernel logs on consoles",
> +	.enable_mask    = SYSRQ_ENABLE_DUMP,
> +};
> +
>  /* Key Operations table and lock */
>  static DEFINE_SPINLOCK(sysrq_key_table_lock);
>  
> @@ -519,7 +530,7 @@ static const struct sysrq_key_op *sysrq_key_table[62] = {
>  	NULL,				/* O */
>  	NULL,				/* P */
>  	NULL,				/* Q */
> -	NULL,				/* R */
> +	&sysrq_replay_logs_op,		/* R */
>  	NULL,				/* S */
>  	NULL,				/* T */
>  	NULL,				/* U */
> -- 
> 2.25.1
> 

Hi,

Kindly let me know if there are any review comments for the above changes.

Regards,
Sreenath

