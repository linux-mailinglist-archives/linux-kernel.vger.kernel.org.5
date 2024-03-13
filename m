Return-Path: <linux-kernel+bounces-102242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B1D87AFBC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5132B2891FF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A313C7C0A3;
	Wed, 13 Mar 2024 17:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gaE78Dgv"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119807BB11;
	Wed, 13 Mar 2024 17:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710350034; cv=none; b=ePBNxK8DSfDwv5CLekJc2YZkN6rgeJvWjWdwc5ZHv2lKdNdKzVoIcAu0+huD/ve5+yeL2Tc6Al/45vy6d8AGgf3akggf8jqtwqIhRVta6pm+SzEvZuSXetTckJeWUkvInt5plgn6iUWxJoyfA+NhqJ9pNttlvxt6fbCnzWyykv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710350034; c=relaxed/simple;
	bh=GUQXLTXTZ/RC3EIvgtVKiqNodwEKbwS4Cu2U8qXFU/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8IuPHKfZ3k6qosQYp8noz9b3W2LQ4YEY7tpdWC0xxH3eU5bn3U42cespeDtX4TF40svG+NqI9w5DqdtXtXLJ95oz+VIgnzpzBeZhrUmXiRWm3Fa8cqbbNobbfAPZ1MVvIL7RjXqHaJ6hBaggNcIA5QA3O9f9pBgD7jNBUp/QAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=gaE78Dgv; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PplELY1KFkbbainlrPdk4FaZv2dPnxhGL2R5dvxZJcc=; b=gaE78DgvKAJxF5LfQGZm9rbZnq
	Z6g9f1MSGKltQmW+YWLoqsnkeGJUXUGPP1sjsV3PidbKBCS5V9wNQjTXOrlwwmwm5bbV/BxWMAr2x
	sTjZF0F6PR9AYHWc9+auHzQVw4pZRi7IIZ5xMlKxmn9VcoawshgDsEDKz0zSmdCCE+ZXVUKwRHXLY
	bdvmNEyOB6vNM01wor0GwCEy0QZ8WoBSHJ97KjFOXz7i368MBndTTPTtjn75tFwxUgqqU3n7bkAHc
	6CzEW+lQ1fE9lpgzIG4VkIQ8bJ/vG3Egqoref58CZpLPcRcoFZWM9kQqNYrJ/5MPmamzjixkUvUvW
	RHj+UJcA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45220)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rkSAf-0007y7-0R;
	Wed, 13 Mar 2024 17:13:41 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rkSAX-0004eW-SY; Wed, 13 Mar 2024 17:13:33 +0000
Date: Wed, 13 Mar 2024 17:13:33 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Christoph Lameter (Ampere)" <cl@linux.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>, Will Deacon <will@kernel.org>,
	Jonathan.Cameron@huawei.com, Matteo.Carlini@arm.com,
	Valentin.Schneider@arm.com, akpm@linux-foundation.org,
	anshuman.khandual@arm.com, Eric Mackay <eric.mackay@oracle.com>,
	dave.kleikamp@oracle.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	robin.murphy@arm.com, vanshikonda@os.amperecomputing.com,
	yang@os.amperecomputing.com, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3] ARM64: Dynamically allocate cpumasks and increase
 supported CPUs to 512
Message-ID: <ZfHevcKpcb6i1fn5@shell.armlinux.org.uk>
References: <37099a57-b655-3b3a-56d0-5f7fbd49d7db@gentwo.org>
 <CGME20240308140130eucas1p1259c805a0b6491ce2f69c6fca0264b1f@eucas1p1.samsung.com>
 <c1f2902d-cefc-4122-9b86-d1d32911f590@samsung.com>
 <Ze9TsQ-qVCZMazfI@arm.com>
 <9352f410-9dad-ac89-181a-b3cfc86176b8@linux.com>
 <bf1757ca-6d41-87e7-53dd-56146eef5693@linux.com>
 <ZfCXJRJSMK4tt_Cm@arm.com>
 <ZfG5oyrgGOkpHYD6@bogus>
 <432c1980-b00f-4b07-9e24-0bec52ccb5d6@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <432c1980-b00f-4b07-9e24-0bec52ccb5d6@samsung.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Mar 13, 2024 at 05:22:33PM +0100, Marek Szyprowski wrote:
> On 13.03.2024 15:35, Sudeep Holla wrote:
> > On Tue, Mar 12, 2024 at 05:55:49PM +0000, Catalin Marinas wrote:
> >> On Tue, Mar 12, 2024 at 10:06:06AM -0700, Christoph Lameter (Ampere) wrote:
> >>> On Mon, 11 Mar 2024, Christoph Lameter (Ampere) wrote:
> >>>
> >>>> This could be an issue in the ARM64 arch code itself where there maybe
> >>>> an assumption elsewhere that a cpumask can always store up to NR_CPU
> >>>> cpus and not only nr_cpu_ids as OFFSTACK does.
> >>>>
> >>>> How can I exercise the opp driver in order to recreate the problem?
> >>>>
> >>>> I assume the opp driver is ARM specific? x86 defaults to OFFSTACK so if
> >>>> there is an issue with OFFSTACK in opp then it should fail with kernel
> >>>> default configuration on that platform.
> >>> I checked the ARM64 arch sources use of NR_CPUS and its all fine.
> >>>
> >>> Also verified in my testing logs that CONFIG_PM_OPP was set in all tests.
> >>>
> >>> No warnings in the kernel log during those tests.
> >>>
> >>> How to reproduce this?
> >> I guess you need a platform with a dts that has an "operating-points-v2"
> >> property. I don't have any around.
> >>
> >> Sudeep was trying to trigger this code path earlier, not sure where he
> >> got to.
> > I did try to trigger this on FVP by adding OPPs + some hacks to add dummy
> > clock provider to successfully probe this driver. I couldn't hit the issue
> > reported 🙁. It could be that with the hardware clock/regulator drivers, it
> > take a different path in OPP core.
> 
> I can fully reproduce this issue on Khadas VIM3 and Odroid-N2 boards. 
> Both Meson A311D SoC based.

So, if I'm reading the OPP code and the DTS* files for Khadas VIM3
correctly, these use operating-points-v2, which is parsed by the opp
layer.

If the opp layer is unable to parse any operating points, it should
print "no supported OPPs" and remove the table (thereby preventing
the code in question being reached.)

So, I wonder whether what you're seeing is a latent bug which is
being tickled by the presence of the CPU masks being off-stack
changing the kernel timing.

I would suggest the printk debug approach may help here to see when
the OPPs are begun to be parsed, when they're created etc and their
timing relationship to being used. Given the suspicion, it's possible
that the mere addition of printk() may "fix" the problem, which again
would be another semi-useful data point.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

