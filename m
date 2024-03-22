Return-Path: <linux-kernel+bounces-110935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DC28865ED
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A49B1F24530
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 05:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5006F8F7D;
	Fri, 22 Mar 2024 05:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="RS5hRsRl"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA8A8BE8;
	Fri, 22 Mar 2024 05:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711084547; cv=none; b=ssbY2uqcGEyOn/Xji5XeI1I5VPcJikkBGqntc4YW9zxzw/i/NptKvYhgWat7M4YCLlGQ/3ObhvWDQrQzMjhlrjitOgV4MEQobm31bkNZg1iSNrdSemUo6nuZKSxZfeJfgMWGJHNbYghcGGwzEGCL96CFVlqMTGhbTSK1m3Y0hAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711084547; c=relaxed/simple;
	bh=zZ3yn/or8XI7NTp4HCt3i6GrXqOYvdyBZlw7ZdLzjPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIklLAjSChRPqEdv5Srm9vNOK4JIRXCIXwO/J7xhdtdAIYZQZ9+XB/XpbN3CrUP8TBiecrHuwicNrGoA40IjCO4NNY9BDMWWgwVWpXoHBWl+jE/x2CSEiGMXKVKY2p2z02n13rarryFP9KULNojk+SlOcnE7javXzDRgO2LtUiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=RS5hRsRl; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 05FEA603CD;
	Fri, 22 Mar 2024 05:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1711084544;
	bh=zZ3yn/or8XI7NTp4HCt3i6GrXqOYvdyBZlw7ZdLzjPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RS5hRsRls1aBGMe4PuqiHIIA68L1TqGweQkAVbOW8sGqQebRXsoB3mosy/Tb9Z5+g
	 PiRFJcxdxAmX4T9WSBqKmSwqkiRCAO4vffg7pJMkkJaDnFSRVAetVrBpVJBQtlfj33
	 soIbj0M0casLr4TGpanTnrOhQOkivlt0a5JjslYpCwdK8BJGhjKgKKYVuDPkplDa4t
	 BCyt6jaOPKzSa2hjufF8LC7r0E1rVzTb0BcoNiB1cw1yJK/khcOU0vSp8qv9tZ5/oc
	 0bId4FBMoBwYjR2jgHejWiw7PzKMwaCcnBybnK/wwgKuzyLHxPJlQDYUqGWjPpSkOM
	 DbrfxyK19lBgw==
Date: Fri, 22 Mar 2024 07:15:32 +0200
From: Tony Lindgren <tony@atomide.com>
To: Nick Bowler <nbowler@draconx.ca>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
	regressions@lists.linux.dev, linux-serial@vger.kernel.org
Subject: Re: PROBLEM: Sun Ultra 60 hangs on boot since Linux 6.8
Message-ID: <20240322051531.GA5132@atomide.com>
References: <d84baa5d-a092-3647-8062-ed7081d329d4@draconx.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d84baa5d-a092-3647-8062-ed7081d329d4@draconx.ca>

Hi,

* Nick Bowler <nbowler@draconx.ca> [240322 04:29]:
> I bisected to this commit:
> 
>   commit 45a3a8ef81291b63a2b50a1a145857dd9fc05e89
>   Author: Tony Lindgren <tony@atomide.com>
>   Date:   Mon Nov 13 10:07:53 2023 +0200
>   
>       serial: core: Revert checks for tx runtime PM state
> 
> Reverting this commit on top of Linux 6.8 is sufficient to get the
> system booting again.

Thanks a lot for bisecting and reporting the issue.

Can you please test if the following change to add back the check for
!pm_runtime_active() is enough to fix the issue?

Regards,

Tony

8< -----------------------
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -156,7 +156,7 @@ static void __uart_start(struct uart_state *state)
 	 * enabled, serial_port_runtime_resume() calls start_tx() again
 	 * after enabling the device.
 	 */
-	if (pm_runtime_active(&port_dev->dev))
+	if (!pm_runtime_enabled(&port_dev->dev) || pm_runtime_active(&port_dev->dev))
 		port->ops->start_tx(port);
 	pm_runtime_mark_last_busy(&port_dev->dev);
 	pm_runtime_put_autosuspend(&port_dev->dev);
-- 
2.44.0

