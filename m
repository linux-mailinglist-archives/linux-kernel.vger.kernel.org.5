Return-Path: <linux-kernel+bounces-140051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB868A0AD2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72ECB1C21B3D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43D213FD67;
	Thu, 11 Apr 2024 08:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="K32ceWbo";
	dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="hbAjU+1d"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA2613DDC7;
	Thu, 11 Apr 2024 08:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712822719; cv=pass; b=bdOcYP3nisW1GdUt8adaEE9DN30mrWs74zGEatVWsUgTH2eL1zorbApAFTJxuI6uANL4KjxXk+8xow5FrQsbCDqiuCX0Pj2INL/iYGRfh38XrcVG3ZUd9TKbWI9US6kMbYMS71dE0lftsD4oI1FF2tbZq1PLi4oQE8NkewOBsSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712822719; c=relaxed/simple;
	bh=k0x/r8Jn3g2BWe8zJBk6R2s9O4m7icoE49i7gn3SsAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnltR4lQq6Eb3n2PwBBkGjZIhqLs+Rq/JY9xBEyf/yVtLlCgtY4thm41VW/aMDa/jM49a7AdKNK7QQ7J/Z+TyLk01stpFVK8wXJb8PCP31Or6anrQ2WTdfkk+e1Ifb/9NCxVC1Vn+1ktm+7xHrd2ndfwwI1I1ypUB7/7aP71Phk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net; spf=none smtp.mailfrom=gerhold.net; dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=K32ceWbo; dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=hbAjU+1d; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=gerhold.net
ARC-Seal: i=1; a=rsa-sha256; t=1712822529; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=P/kcwuIeoUbeZUYYUbIfF7pkrc/zL9KXLbblkcQMlKTuEg054A5KjJcKXMqyevkWiu
    /q16ASNZAxnxEXn4hAD2/mVfSmsz/VNFbhPjJDFO9oBIiZNo8NivMEsIoSEIgDB5wdgm
    7chzm/VM65Vpl5UUhSgJSvZMCUCfjCvjqrQzZ9LJu61Zmuk8TyXaMjpFyFUv66AL4MqA
    z3SketrLhdmtXzTz/mD2G/b+qHbPj5VJIMgaytqBniNi4YUAn69yh52Fs0LtCoeU5jOC
    S8Tefwceun5HVFo44Ysel2fnODs4ENmvFq5D2mKpATB+eJA5TcNX4qzpocuysr7zOcNi
    NOiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1712822529;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=ppwbDmup2wMDKDBXkN+XHpscPYZpnGSiu/96bn4RuWI=;
    b=n+Hv92WnPunROayR9CAVpMFCGyNIh+8Ouqt6Q/13ZJ6pCPEOHwS8gjlTOVNjpiRCqY
    pPpzCv6l70F4xqJv7n+ngpcLBBGMDOAdXJhQDswKqriDzpFseeUVXjVLNF2J6xlUYpUn
    7i1anutXfGedvk2Q0Ig84J7hbq6pbv02vmwHifQSkhmmVQ4Jkq2CYYswlmbpJYgLdAmP
    QCmUHsmmMo1n7yzmgj6CQyaUMgjuPVnm9jT7P+upVQxxacbjDOpHSlbhT856wOcawHCi
    Nk+BmH9lBq8rwNoBDFhJrr2+fR6kuaRNyqVJ/AtAperWqMSxvo5/e8Cr0hbuLrk0VU5y
    DPbQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1712822529;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=ppwbDmup2wMDKDBXkN+XHpscPYZpnGSiu/96bn4RuWI=;
    b=K32ceWbo3Nrd2/oo7IB36ugdBJCa0xqS7kbgWFQRei+WOzcEjR5dVDM2B9KDUyoKzt
    mm6BMvQMfeGkJACmcf4W0QimxLBnCPzD+MKLpY8TKO9vDvkLrJgXpO+i8Ps1bHMooYLi
    RTa/+56U9/M147rYnjQSMA+W8uvGsX4ymV2HOJ0D1QDIr3h+FTm0X+IUx5gYy/AdodKm
    3RxSb3dOHtygWfjIMdX716LZrw9WWDBjA+VSpJD/CCDoRQUwqwAkW2ym1/ZUAbjUvXKP
    cLsrtex/+8WHfPqeWPyZLAIUIg1wj8EtaYszd+4Y/MPWPRevrmdN3tmEBwWqDUs64vnK
    IvnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1712822529;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=ppwbDmup2wMDKDBXkN+XHpscPYZpnGSiu/96bn4RuWI=;
    b=hbAjU+1dVcVP51hOdENK5yo8tg2sqP+aopngPKHQVPiR9CFmZR129TP8ngMhC2aXBh
    vVoFC7Rb21FpEf2kZJDw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA+p3h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 50.3.2 DYNA|AUTH)
    with ESMTPSA id Raf12503B828aP2
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 11 Apr 2024 10:02:08 +0200 (CEST)
Date: Thu, 11 Apr 2024 10:02:01 +0200
From: Stephan Gerhold <stephan@gerhold.net>
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Rob Clark <robdclark@gmail.com>, Stephen Boyd <swboyd@chromium.org>,
	Nikita Travkin <nikita@trvn.ru>
Subject: Re: [PATCH] soc: qcom: cmd-db: map shared memory as WT, not WB
Message-ID: <ZheY-S5VY2AZD7V-@gerhold.net>
References: <20240327200917.2576034-1-volodymyr_babchuk@epam.com>
 <e0586d43-284c-4bef-a8be-4ffbc12bf787@linaro.org>
 <87a5mjz8s3.fsf@epam.com>
 <f4ebe819-9718-42c3-9874-037151587d0c@linaro.org>
 <cd549ee8-22dc-4bc4-af09-9c5c925ee03a@linaro.org>
 <ZgU_YDUhBeyS5wuh@gerhold.net>
 <875xwo6f57.fsf@epam.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875xwo6f57.fsf@epam.com>
Content-Transfer-Encoding: 7bit

On Wed, Apr 10, 2024 at 10:12:37PM +0000, Volodymyr Babchuk wrote:
> Stephan Gerhold <stephan@gerhold.net> writes:
> > On Wed, Mar 27, 2024 at 11:29:09PM +0000, Caleb Connolly wrote:
> >> On 27/03/2024 21:06, Konrad Dybcio wrote:
> >> > On 27.03.2024 10:04 PM, Volodymyr Babchuk wrote:
> >> >> Konrad Dybcio <konrad.dybcio@linaro.org> writes:
> >> >>> On 27.03.2024 9:09 PM, Volodymyr Babchuk wrote:
> >> >>>> It appears that hardware does not like cacheable accesses to this
> >> >>>> region. Trying to access this shared memory region as Normal Memory
> >> >>>> leads to secure interrupt which causes an endless loop somewhere in
> >> >>>> Trust Zone.
> >> >>>>
> >> >>>> The only reason it is working right now is because Qualcomm Hypervisor
> >> >>>> maps the same region as Non-Cacheable memory in Stage 2 translation
> >> >>>> tables. The issue manifests if we want to use another hypervisor (like
> >> >>>> Xen or KVM), which does not know anything about those specific
> >> >>>> mappings. This patch fixes the issue by mapping the shared memory as
> >> >>>> Write-Through. This removes dependency on correct mappings in Stage 2
> >> >>>> tables.
> >> >>>>
> >> >>>> I tested this on SA8155P with Xen.
> >> >>>>
> >> >>>> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> >> >>>> ---
> >> >>>
> >> >>> Interesting..
> >> >>>
> >> >>> +Doug, Rob have you ever seen this on Chrome? (FYI, Volodymyr, chromebooks
> >> >>> ship with no qcom hypervisor)
> >> >>
> >> >> Well, maybe I was wrong when called this thing "hypervisor". All I know
> >> >> that it sits in hyp.mbn partition and all what it does is setup EL2
> >> >> before switching to EL1 and running UEFI.
> >> >>
> >> >> In my experiments I replaced contents of hyp.mbn with U-Boot, which gave
> >> >> me access to EL2 and I was able to boot Xen and then Linux as Dom0.
> >> > 
> >> > Yeah we're talking about the same thing. I was just curious whether
> >> > the Chrome folks have heard of it, or whether they have any changes/
> >> > workarounds for it.
> >> 
> >> Does Linux ever write to this region? Given that the Chromebooks don't
> >> seem to have issues with this (we have a bunch of them in pmOS and I'd
> >> be very very surprised if this was an issue there which nobody had tried
> >> upstreaming before) I'd guess the significant difference here is between
> >> booting Linux in EL2 (as Chromebooks do?) vs with Xen.
> >> 
> >
> > FWIW: This old patch series from Stephen Boyd is closely related:
> > https://urldefense.com/v3/__https://lore.kernel.org/linux-arm-msm/20190910160903.65694-1-swboyd@chromium.org/__;!!GF_29dbcQIUBPA!yGecMHGezwkDU9t7XATVTI80PNGjZdQV2xsYFTl6EhpMMsRf_7xryKx8mEVpmTwTcKMGaaWomtyvr05zFcmsf2Kk$
> > [lore[.]kernel[.]org]
> >
> >> The main use case I have is to map the command-db memory region on
> >> Qualcomm devices with a read-only mapping. It's already a const marked
> >> pointer and the API returns const pointers as well, so this series
> >> makes sure that even stray writes can't modify the memory.
> >
> > Stephen, what was the end result of that patch series? Mapping the
> > cmd-db read-only sounds cleaner than trying to be lucky with the right
> > set of cache flags.
> >
> 
> I checked the series, but I am afraid that I have no capacity to finish
> this. Will it be okay to move forward with my patch? I understand that
> this is not the best solution, but it is simple and it works. If this is
> fine, I'll send v2 with all comments addressed.
> 

My current understanding is that the important property here is to have
a non-cacheable mapping, which is the case for both MEMREMAP_WT and
MEMREMAP_WC, but not MEMREMAP_WB. Unfortunately, the MEMREMAP_RO option
Stephen introduced is also a cacheable mapping, which still seems to
trigger the issue in some cases. I'm not sure why a cache writeback
still happens when the mapping is read-only and nobody writes anything.

You can also test it if you want. For a quick test,

-	cmd_db_header = memremap(rmem->base, rmem->size, MEMREMAP_WB);
+	cmd_db_header = ioremap_prot(rmem->base, rmem->size, _PAGE_KERNEL_RO);

should be (largely) equivalent to MEMREMAP_RO with Stephen's patch
series. I asked Nikita to test this on SC7180 and it still seems to
cause the crash.

It seems to work only with a read-only non-cacheable mapping, e.g. with

+	cmd_db_header = ioremap_prot(rmem->base, rmem->size,
				     ((PROT_NORMAL_NC & ~PTE_WRITE) | PTE_RDONLY));

The lines I just suggested for testing are highly architecture-specific
though so not usable for a proper patch. If MEMREMAP_RO does not solve
the real problem here then the work to make an usable read-only mapping
would go beyond just finishing Stephen's patch series, since one would
need to introduce some kind of MEMREMAP_RO_NC flag that creates a
read-only non-cacheable mapping.

It is definitely easier to just change the driver to use the existing
MEMREMAP_WC. Given the crash you found, the hardware/firmware seems to
have a built-in write protection on most platforms anyway. :D

Thanks,
Stephan

