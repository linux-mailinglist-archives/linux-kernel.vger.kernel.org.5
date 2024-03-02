Return-Path: <linux-kernel+bounces-89307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04E686EE11
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 03:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6B91C20DAF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 02:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DA97489;
	Sat,  2 Mar 2024 02:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZFeNkD1"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF16320B;
	Sat,  2 Mar 2024 02:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709344919; cv=none; b=rlOuLVy0Q9MLO6vDnqL8UozdJ8Q9xyKZC0V75w8Fi1V5FwY8uJXvUmNbDVUNU6po2b8Cd6wa7BOrvg5Rtttxc2F6ero7PdXFLODoLJ3uZ1H61/bN90e7MltS87iyIml083GT5KGcmFcW3HHLuOkrj58C1xuxXmwEFuEc/AY+nPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709344919; c=relaxed/simple;
	bh=LIqKAURAPbbMEH2j4IdH6pzC43kT8Yy0pz8xS+NLjPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzrHwTHRAXd47HYnKXiaD/LYYMdwxPTD0f9EVDtgyVDrvHVyvQXU+On/Uhs+f8PObWV/KMk6uuV6NLauGPye3VXJNO7kMZDk6jRS2Z8kvO/8gL2cYOu6WI2kv5vU6cZzpFSOcfugh5bEKAY9e4mSorytZCzuAkgSrexh41nQFPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZFeNkD1; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dc29f1956cso24467105ad.0;
        Fri, 01 Mar 2024 18:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709344917; x=1709949717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I/ES75OINXio6Jg14hlcZ63hcfEZjDHEPfBn7kPat2w=;
        b=gZFeNkD1jh81FZsWO7bRMVx9fh3lps8yGyzqReTdx5PrkKz7gUyHvCuAYOTMXE9VHS
         Dlk84omO0G0lQKHcBdJLaZ32jVCgc1awBLTnKah8N+fX3dzfHspEDqamWxNpVWP4hbEj
         UPyOiMKtedIKTVdvBjhAQlYeeiz0K8Kw01b9BmW8FOMW+LhYAkXpl3dlJ4CzLydxxova
         v513n/pN2HxgMk/bvCQqZu9m8FfRbSpb3jDLb8197xIhPmWdRE/ZL+A65EI150CTLnj1
         qtPI2Zw3uVbeg4H9c24cn7LOKA+ICAsIMhBzp1iVhA2npxVSptRuzvaBDDA2ftRDZkNr
         mx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709344917; x=1709949717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/ES75OINXio6Jg14hlcZ63hcfEZjDHEPfBn7kPat2w=;
        b=vsyVaPNW2ZocX7CdA+Lr+J5J9/KnKu08CsT5EZHBK6iDwLiyNxiYv99izpKX5IkG6R
         kgdwOpGg7od4VtI1YWJETSjaTzwu8YqLbNUfVuQS3VT6aVzp1eAX/vOVm8zs9rN3fEQk
         wZ0WdTJq6kXbZON26oXpnfd+LJUdnIE6GaQcJQ4jLx2/pDzq6Dn/t4n4UF55hyXdp/k8
         CQ+aLu2o7F5c+ZURl6jow2scsd3tZ62iitjr9XqJDUPhDRPFnmW0V5y5RNYpFWUIBu0a
         /YgKpymS/JwxLMQR3+XiNuRYVr5ZgpiV1wgeop6Iyrq2M23Ta0az5Tt0nYs/2Rdibz6H
         x6vg==
X-Forwarded-Encrypted: i=1; AJvYcCVX9wxgwrDCVhdcjC1RdtHRhOCzZaS/cVS+rfty46RFwEAYuLE0MphrrgHqXcxJcjvX7xlmCaKYquQn4uhIxjtviPmJUoCsFQMP0kbbekQv9imUgSz4+SDh+r1sNjdtl+w0uYLXffRUp72IlGYdq5D9Gf+awNagQ0ZCtlEIU+Rfcsx0WA==
X-Gm-Message-State: AOJu0YxlqTzawE+U0WkKcUg4KAqx9Rzk2mZUyT3FdDH0W7KBTAHPkaGH
	f1NumeSPZ7aUDVtSq6rzWssiVBujCjVAG2HD+TN/juYrDjLj2naG
X-Google-Smtp-Source: AGHT+IG/wQLDc3mJzbkZUilzgPH70FoHHXwvpIEuQUi67d1EuWHrRCL2C71gorxmluFqJf5/NEsxfA==
X-Received: by 2002:a17:903:32c8:b0:1dc:fadb:4b1a with SMTP id i8-20020a17090332c800b001dcfadb4b1amr563181plr.54.1709344917098;
        Fri, 01 Mar 2024 18:01:57 -0800 (PST)
Received: from linux-8mug (111-248-209-112.dynamic-ip.hinet.net. [111.248.209.112])
        by smtp.gmail.com with ESMTPSA id im22-20020a170902bb1600b001dcd00165a6sm4181614plb.208.2024.03.01.18.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 18:01:56 -0800 (PST)
Date: Sat, 2 Mar 2024 10:01:51 +0800
From: Chester Lin <chester62515@gmail.com>
To: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
Cc: Andreas Farber <afaerber@suse.de>, Matthias Brugger <mbrugger@suse.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, NXP S32 Linux Team <s32@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
Subject: Re: [PATCH v2 0/2] add uSDHC and SCMI nodes to the S32G2 SoC
Message-ID: <ZeKIjyFF0ftnr19q@linux-8mug>
References: <20240122140602.1006813-1-ghennadi.procopciuc@oss.nxp.com>
 <a7a55dc6-c204-4aad-adff-9806d3302b6b@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7a55dc6-c204-4aad-adff-9806d3302b6b@oss.nxp.com>

Hi,

On Thu, Feb 08, 2024 at 11:34:58AM +0200, Ghennadi Procopciuc wrote:
> On 1/22/24 16:05, Ghennadi Procopciuc wrote:
> > From: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> > 
> > This patchset adds device tree support for S32G2 SCMI firmware and uSDHC
> > node. The SCMI clock IDs are based on a downstream version of the TF-A
> > stored on GitHub [0].
> > 
> > I can send the patches individually if you prefer that instead of
> > submitting them all at once.??
> > 
> > [0] https://github.com/nxp-auto-linux/arm-trusted-firmware
> > 
> > Changes in v2:
> >  - The SCMI clock bindings header has been removed.
> > 
> > Ghennadi Procopciuc (2):
> >   arm64: dts: s32g: add SCMI firmware node
> >   arm64: dts: s32g: add uSDHC node
> > 
> >  arch/arm64/boot/dts/freescale/s32g2.dtsi      | 37 ++++++++++++++++++-
> >  .../arm64/boot/dts/freescale/s32g274a-evb.dts |  6 ++-
> >  .../boot/dts/freescale/s32g274a-rdb2.dts      |  6 ++-
> >  3 files changed, 46 insertions(+), 3 deletions(-)
> > 
> Hi Chester,
> 
> I want to confirm if you are open to accepting the proposed changes for
> ARM/NXP S32G architecture, given your maintainer role. Please let me
> know if any revisions or adaptations are required.
> 

These patches look good to me.

Hi Shawn,

Per the discussion in another thread, could you help to apply these two
through the imx tree? Thanks!

Chester

> Regards,
> Ghennadi
> 

