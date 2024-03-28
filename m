Return-Path: <linux-kernel+bounces-123024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8126389012C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FDC71F230F8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448A712E1F3;
	Thu, 28 Mar 2024 14:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="mi1cdOJ+"
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B032B5223;
	Thu, 28 Mar 2024 14:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.87.146.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634816; cv=none; b=TAB6goeA0urFy+9ZbUelVTRqAw0B4kFE8N7eEuRv3Req5LZXwWIcqiOjXXE6vjlt1kYN0I2zQF5dvcsp8aYPJEFOXQXdrRhgt8w8Idgi+HJwDCMms0qntrW6XoUgcj9jJFs//dV+P2P0vGEt83sNoRluGiKpsuW/14Sj/Zii/PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634816; c=relaxed/simple;
	bh=eiv8+tfk5bWrbiEVZpxkUQotxO8sNqN4KDVcKJwpU/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/FleuxKUhhC3HudwDcdBz7g/oCVjuDPxA50gp15i0HesnWrYMoXBOg5+AcyFJDhHmhTTfGh+g1HSlhFufEtX5KJ0bZXBbPa1rxOyosA14d6K378zjojadkdVrdbLDNUvk8H737foDL1TgbL+D/tSVMaMVA/GpIli15fqRVhsyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru; spf=pass smtp.mailfrom=trvn.ru; dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b=mi1cdOJ+; arc=none smtp.client-ip=194.87.146.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id 7055A40142;
	Thu, 28 Mar 2024 19:06:47 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1711634808; bh=eiv8+tfk5bWrbiEVZpxkUQotxO8sNqN4KDVcKJwpU/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mi1cdOJ+MdfkpQEGxu+GhAMI5qnPYO3q2aBzlk22/sXOkAlqbv6MnIeOYcTKIdagi
	 jrQ8xKMU70ID/sizfpmYGLZUya6q98z4i0lTWCB0ThXBBf7H/6gHoA183TPGKE+7Mi
	 KMHgSaFBzUHbbxwV2IeZLBiF2BJhnQboK/b609L2koLMKAplmjmYOhB8R1g3sw3jpV
	 61td261jYTuO+s5PDg7bRhgob5GgyYWYbWVnctPXL+bozm7KgKvijvjmcj1c0Tcx+q
	 vkCLFNtoX8Umem9fLnroVmhL5DX04qkT2Hl6pw1b4+4NPKypG8xNNbLPFhVofJ1GW0
	 R9+t7Y8pRB3eA==
Date: Thu, 28 Mar 2024 19:06:45 +0500
From: Nikita Travkin <nikita@trvn.ru>
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: qcom: cmd-db: map shared memory as WT, not WB
Message-ID: <fz2fqji5uqeijyos3rp4lcjionmwjfw736jdcch4mmlnvhxu7q@zvjqizqhnx4x>
References: <20240327200917.2576034-1-volodymyr_babchuk@epam.com>
 <amrgxdv2iq32wrrn4w2xtxaknmyijr6cu37ivjuqez5rzftde6@wwraopwfqtw5>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amrgxdv2iq32wrrn4w2xtxaknmyijr6cu37ivjuqez5rzftde6@wwraopwfqtw5>

On Thu, Mar 28, 2024 at 04:12:11PM +0500, Nikita Travkin wrote:
> On Wed, Mar 27, 2024 at 08:09:34PM +0000, Volodymyr Babchuk wrote:
> > It appears that hardware does not like cacheable accesses to this
> > region. Trying to access this shared memory region as Normal Memory
> > leads to secure interrupt which causes an endless loop somewhere in
> > Trust Zone.
> > 
> > The only reason it is working right now is because Qualcomm Hypervisor
> > maps the same region as Non-Cacheable memory in Stage 2 translation
> > tables. The issue manifests if we want to use another hypervisor (like
> > Xen or KVM), which does not know anything about those specific
> > mappings. This patch fixes the issue by mapping the shared memory as
> > Write-Through. This removes dependency on correct mappings in Stage 2
> > tables.
> > 
> > I tested this on SA8155P with Xen.
> > 
> 
> Hi!
> 
> I observe a similar issue while trying to boot Linux in EL2 after taking
> over qcom's hyp on a sc7180 WoA device:
> 
> [    0.337736] CPU: All CPU(s) started at EL2
> (...)
> [    0.475135] Serial: AMBA PL011 UART driver
> [    0.479649] Internal error: synchronous external abort: 0000000096000410 [#1] PREEMPT SMP
> [    0.488053] Modules linked in:
> [    0.491213] CPU: 6 PID: 1 Comm: swapper/0 Not tainted 6.7.0 #41
> [    0.497310] Hardware name: Acer Aspire 1 (DT)
> [    0.501800] pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    0.508964] pc : cmd_db_dev_probe+0x38/0xc4
> [    0.513290] lr : cmd_db_dev_probe+0x2c/0xc4
> [    0.517606] sp : ffff8000817ebab0
> [    0.521019] x29: ffff8000817ebab0 x28: 0000000000000000 x27: ffff800081346050
>                      <uart cuts out>
> 
> Unfortunately this patch doesn't help in this case (I beileve I even
> tried same/similar change a while back when trying to debug this)
> 

I'm sorry, it looks like I made a mistake in my tooling while testing
this patch, which I only realized after trying Maulik's suggestion...

Both _WT and _WC fix the issue I see on sc7180 WoA, so whether you keep
the patch as is or change it to _WC as suggested:

Tested-By: Nikita Travkin <nikita@trvn.ru> # sc7180 WoA in EL2

Thanks for looking into this!
Nikita

> Currently I can work around this by just reocationg the cmd-db while
> still under the qcom's hyp [1] but it would be nice to find a generic
> solution that doesn't need pre-boot hacks...
> 
> AFAIK this is not observed on at least sc8280xp WoA devices and I'd
> assume cros is not affected because they don't use qcom's TZ and instead
> use TF-A (which is overall more friendly, though still uses qcom's
> proprietary qtiseclib under the hood)
> 
> Nikita
> 
> [1] https://github.com/TravMurav/slbounce/blob/main/src/dtbhack_main.c#L17
> 
> > Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> > ---
> >  drivers/soc/qcom/cmd-db.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
> > index a5fd68411bed5..dd5ababdb476c 100644
> > --- a/drivers/soc/qcom/cmd-db.c
> > +++ b/drivers/soc/qcom/cmd-db.c
> > @@ -324,7 +324,7 @@ static int cmd_db_dev_probe(struct platform_device *pdev)
> >  		return -EINVAL;
> >  	}
> >  
> > -	cmd_db_header = memremap(rmem->base, rmem->size, MEMREMAP_WB);
> > +	cmd_db_header = memremap(rmem->base, rmem->size, MEMREMAP_WT);
> >  	if (!cmd_db_header) {
> >  		ret = -ENOMEM;
> >  		cmd_db_header = NULL;
> > -- 
> > 2.43.0

