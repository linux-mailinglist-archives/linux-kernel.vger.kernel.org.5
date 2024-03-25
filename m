Return-Path: <linux-kernel+bounces-117673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4BC88AE4D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E1081C607EC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3916A008;
	Mon, 25 Mar 2024 18:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b6FwJfrn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B4E2F2A;
	Mon, 25 Mar 2024 18:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389780; cv=none; b=tQKKZWlwlAGnx6TEtWt3zdqO936Y7c9wU4mR7xB4CRwajiQVxuf73Ltce8BZ7MAmZZWTMM/yhXqPrNxUIi4aWyc8h9z2c/Cl0UHSiQ15KA9hCcxlA7EHXPNjh2ekUj1H8iH8KPXDTIQZTWHCpLcYtaIY/KFKuHHO6DyPqTu0D94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389780; c=relaxed/simple;
	bh=f9kshTE64yVK5tZkqd7Yhr4ZPjWrAoRTLalLjqHr/8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/KtZok8zjDUeKgNTcnlvWQ+aGUbKuA/uCH8TCB+NX3KONyVT9PNU3m78rNhi/A5bt2YAA8JKhL1IPPlYyM/euxON1yQqK8Cy+KvFxsqAUvGCsXXD6au9uJiB3W6IZy0tRUZtkfFG9oRw1hTq4RBjFySQ1fHY4f/Hx8Wb4JMfTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b6FwJfrn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D53DC433C7;
	Mon, 25 Mar 2024 18:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711389779;
	bh=f9kshTE64yVK5tZkqd7Yhr4ZPjWrAoRTLalLjqHr/8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b6FwJfrng3JgswX8mZDHkzwoK5+yW0JgG40OpqaoFCuUkF/5IFmlQqQVk4h1w4yrs
	 iGRSFh3UgArScuww2kExaRB4mhCd8SoPDTiP8vh8qlapj80Wv+/XKElTiRe0yHSYUY
	 Hd7vUd29cKOes9SSDTsAMj2lncJte3UNkUai+Suk=
Date: Mon, 25 Mar 2024 19:02:27 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Tree Davies <tdavies@darkphysics.net>
Cc: philipp.g.hortmann@gmail.com, anjan@momi.ca,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] Staging: rtl8192e: Style guide Renames and Macros
Message-ID: <2024032515-prolonged-cornhusk-40e6@gregkh>
References: <20240310235552.4217-1-tdavies@darkphysics.net>
 <2024032534-return-edging-a2a2@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024032534-return-edging-a2a2@gregkh>

On Mon, Mar 25, 2024 at 07:01:50PM +0100, Greg KH wrote:
> On Sun, Mar 10, 2024 at 04:55:41PM -0700, Tree Davies wrote:
> > 10/11 patches in this series rename variables to fix camelCase style
> > guide violations. The 11th patch implements the use of the BIT macro
> > instead of regular bit shift operations.
> > 
> > MOTE: Because patch #11 changes DEFINEs the compiler issues 
> > redefinition warnings. I don't know how to address these as part
> > of this submission. 
> > 
> > All changes Tested on Hardware
> 
> This patch series blows up the build, as the kernel test bot says, so I
> can't apply it, sorry.

Ah, it's just the last patch, I applied the first 10 now, thanks.

greg k-h

