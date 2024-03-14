Return-Path: <linux-kernel+bounces-103455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D85E087BF93
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68BBBB22A0C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E017174A;
	Thu, 14 Mar 2024 15:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kM8VADVD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344BF29CE3;
	Thu, 14 Mar 2024 15:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710428845; cv=none; b=uQLCbvCYGyvoeqtkqMzVqRUgBUXpcyxLpYZypfqUXe/Yf2j9Vb45nyZaqsJBQgtPR1IJvc70wukjOAjJK3TSyjtSabi3eIz0hauxubPfLkgrSqHCGf9sj2oXUDl2bStdTBXvqmWIOLI/vaUN+EsAUM3zIyAWKfw9qu5otW/R8h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710428845; c=relaxed/simple;
	bh=UDO+GCBQ2Q8HVX/DgX++9oioBWZq9EGTDYBCcJjoj7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXUQkamQPHS6lIRhQtxsfE/2U6oRKxKaDf1IN3GJAKV2YugKIn5sN/0pQ0piJUIdn5wDsmWGcFWhxHMA1atgLRBIYf+/oIJhj5zJ2J4B7P/ynasqLbR/WedUYWagcF4thDkF0sZ22gJzRm6TRc4Fu5GPF3+qEzo5qkCOxY+aRTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kM8VADVD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30D3C433F1;
	Thu, 14 Mar 2024 15:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710428844;
	bh=UDO+GCBQ2Q8HVX/DgX++9oioBWZq9EGTDYBCcJjoj7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kM8VADVD2HQiVDgozP7tWxSYt1hVTgBtx9xVZYEIGbWPlQb7MY7iWsd18hnwCHKRH
	 //Sx3ZXVgXvYvCBcrC5Eb8BMbnePZAlOdFRLi0mXF9+YUaHvwSWw0Q0gB+P+5ShMiv
	 RAKqLtewuovmzU2IYFUxPZexuQUbg/XJiqos9adOu2mXpitIlKlNHP50etzuWLLpB5
	 2HTKbU1JyBiHtmrpfWBnuBlgXPMv96fPCisDYU132tOiYKqHX2bHFVwEVPGUi0rWBU
	 wqJbP8CuP8y6cmcC1re/5CdrvU/OmVaQ27CLZEvYVd2qUmewPm1hV+NZXPpfDkvrpE
	 tMcoSVFJrAK7Q==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rkmg8-000000004p1-35kT;
	Thu, 14 Mar 2024 16:07:33 +0100
Date: Thu, 14 Mar 2024 16:07:32 +0100
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Subject: Re: [PATCH] Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode
 exists in DT"
Message-ID: <ZfMStHjwtCT1SW3z@hovoldconsulting.com>
References: <20240314084412.1127-1-johan+linaro@kernel.org>
 <CABBYNZJV1htg46Gyu=7_iUWdukM+rHLitsLjxmWWYFGXty3tVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZJV1htg46Gyu=7_iUWdukM+rHLitsLjxmWWYFGXty3tVw@mail.gmail.com>

On Thu, Mar 14, 2024 at 10:30:36AM -0400, Luiz Augusto von Dentz wrote:
> On Thu, Mar 14, 2024 at 4:44 AM Johan Hovold <johan+linaro@kernel.org> wrote:

> > This reverts commit 7dcd3e014aa7faeeaf4047190b22d8a19a0db696.
> >
> > Qualcomm Bluetooth controllers like WCN6855 do not have persistent
> > storage for the Bluetooth address and must therefore start as
> > unconfigured to allow the user to set a valid address unless one has
> > been provided by the boot firmware in the devicetree.
> >
> > A recent change snuck into v6.8-rc7 and incorrectly started marking the
> > default (non-unique) address as valid. This specifically also breaks the
> > Bluetooth setup for some user of the Lenovo ThinkPad X13s.
> >
> > Note that this is the second time Qualcomm breaks the driver this way
> > and that this was fixed last year by commit 6945795bc81a ("Bluetooth:
> > fix use-bdaddr-property quirk"), which also has some further details.
> >
> > Fixes: 7dcd3e014aa7 ("Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in DT")
> > Cc: stable@vger.kernel.org      # 6.8
> > Cc: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> Well I guess I will need to start asking for evidence that this works
> on regular Linux distros then, because it looks like that is not the
> environment Janaki and others Qualcomm folks are testing with.
> 
> What I probably would consider as evidence is bluetoothd logs showing
> that the controller has been configured correctly or perhaps there is
> a simpler way?

Well, in this case we actually want the controller to remain
unconfigured (e.g. to avoid having every user of the X13s unknowingly
use the same default address). 

I'm not sure why Qualcomm insists on breaking these quirks, but I guess
they just haven't understood why they exist. It's of course convenient
to be able to use the default address during development without first
having to provide an address, but that's not a valid reason to break the
driver.

From what I hear the Qualcomm developers only care about Android and I
believe they have some out-of-tree hack for retrieving the device
address directly from the rootfs.

For the X13s, and as I think I've mentioned before, we have been trying
to get Qualcomm to tell us how to access the assigned addresses that are
stored in some secure world storage so that we can set it directly from
the driver. But until we figure that out, users will need to continue
setting the address manually.

Johan

