Return-Path: <linux-kernel+bounces-122818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF84E88FDD6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 830EE1F26795
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A643E7E0F3;
	Thu, 28 Mar 2024 11:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="zibkovI2"
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776F71BDD0;
	Thu, 28 Mar 2024 11:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.87.146.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711624342; cv=none; b=c6BzBM/o4UoxC9pBXgE0Q/PSv8cQ0ZTxgiPHt80WJCYQvne6VVts4zSqscYIGZ1hSlvdO+9lwWWSFWu/OocKS0zs0dmYoHQjpBQjbWKqr+c0U/m1stK8Ikx6ua5tmqeTYmXC+NdAaiM1Bn2XPbEyxjJkQT5SU0e5VelSJO/pZrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711624342; c=relaxed/simple;
	bh=y4W0sq1JvhtcJFh4/mQlcLdJUhReEnI0NDx8hrvcY6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLQ+azzzMVeWGra95w3yEQkoa0SkEqOr3k2JmX1WSdaVxg9pehsNdQoOFogYyQZKeG2j0tJW3lWQQadmol7lg6kjqSCt0ArDJo6WPpw83fkkKf07uAxX+NZHKzNeuwQ9Sa1E0s8vIehkxKzqAa3LWPa/wYRdsbKZlH3Ac47WCU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru; spf=pass smtp.mailfrom=trvn.ru; dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b=zibkovI2; arc=none smtp.client-ip=194.87.146.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id 78A1040142;
	Thu, 28 Mar 2024 16:12:10 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1711624331; bh=y4W0sq1JvhtcJFh4/mQlcLdJUhReEnI0NDx8hrvcY6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zibkovI2tPcPFPC+eF6mlRbQW1YbE9tvrvnqcRFFeg0B1cEOLJmoX86pIRLx19VAC
	 IRLW1y6qDFRQH/HV5SwGxhlztiJLNLdLrzBq5ikZkZKSNdK6XAPHGzTnEN8kzsVBwB
	 xc5kb2/vUAFCb4+zqg3PbhpINx4+v8Zr41BQPK5WDa43llBkzHTp2cCCBZsIpyuN3q
	 /M2A3rjLW/+LhQAVSXTEDzw3OE15HuOEhpjTaHvezEk+OXV3bxlMxK+4qpGQkQgtkm
	 Oj09oARs+dFFQA28Lq1zdGmdIdMf20L1MKayOOwA925b9GHHmFm8sZ/jszcsKctbm3
	 nLYIdYu60ELhA==
Date: Thu, 28 Mar 2024 16:12:07 +0500
From: Nikita Travkin <nikita@trvn.ru>
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: qcom: cmd-db: map shared memory as WT, not WB
Message-ID: <amrgxdv2iq32wrrn4w2xtxaknmyijr6cu37ivjuqez5rzftde6@wwraopwfqtw5>
References: <20240327200917.2576034-1-volodymyr_babchuk@epam.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327200917.2576034-1-volodymyr_babchuk@epam.com>

On Wed, Mar 27, 2024 at 08:09:34PM +0000, Volodymyr Babchuk wrote:
> It appears that hardware does not like cacheable accesses to this
> region. Trying to access this shared memory region as Normal Memory
> leads to secure interrupt which causes an endless loop somewhere in
> Trust Zone.
> 
> The only reason it is working right now is because Qualcomm Hypervisor
> maps the same region as Non-Cacheable memory in Stage 2 translation
> tables. The issue manifests if we want to use another hypervisor (like
> Xen or KVM), which does not know anything about those specific
> mappings. This patch fixes the issue by mapping the shared memory as
> Write-Through. This removes dependency on correct mappings in Stage 2
> tables.
> 
> I tested this on SA8155P with Xen.
> 

Hi!

I observe a similar issue while trying to boot Linux in EL2 after taking
over qcom's hyp on a sc7180 WoA device:

[    0.337736] CPU: All CPU(s) started at EL2
(...)
[    0.475135] Serial: AMBA PL011 UART driver
[    0.479649] Internal error: synchronous external abort: 0000000096000410 [#1] PREEMPT SMP
[    0.488053] Modules linked in:
[    0.491213] CPU: 6 PID: 1 Comm: swapper/0 Not tainted 6.7.0 #41
[    0.497310] Hardware name: Acer Aspire 1 (DT)
[    0.501800] pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.508964] pc : cmd_db_dev_probe+0x38/0xc4
[    0.513290] lr : cmd_db_dev_probe+0x2c/0xc4
[    0.517606] sp : ffff8000817ebab0
[    0.521019] x29: ffff8000817ebab0 x28: 0000000000000000 x27: ffff800081346050
                     <uart cuts out>

Unfortunately this patch doesn't help in this case (I beileve I even
tried same/similar change a while back when trying to debug this)

Currently I can work around this by just reocationg the cmd-db while
still under the qcom's hyp [1] but it would be nice to find a generic
solution that doesn't need pre-boot hacks...

AFAIK this is not observed on at least sc8280xp WoA devices and I'd
assume cros is not affected because they don't use qcom's TZ and instead
use TF-A (which is overall more friendly, though still uses qcom's
proprietary qtiseclib under the hood)

Nikita

[1] https://github.com/TravMurav/slbounce/blob/main/src/dtbhack_main.c#L17

> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> ---
>  drivers/soc/qcom/cmd-db.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
> index a5fd68411bed5..dd5ababdb476c 100644
> --- a/drivers/soc/qcom/cmd-db.c
> +++ b/drivers/soc/qcom/cmd-db.c
> @@ -324,7 +324,7 @@ static int cmd_db_dev_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	cmd_db_header = memremap(rmem->base, rmem->size, MEMREMAP_WB);
> +	cmd_db_header = memremap(rmem->base, rmem->size, MEMREMAP_WT);
>  	if (!cmd_db_header) {
>  		ret = -ENOMEM;
>  		cmd_db_header = NULL;
> -- 
> 2.43.0

