Return-Path: <linux-kernel+bounces-117589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F3188ACF5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3033224F6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B8312838D;
	Mon, 25 Mar 2024 17:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgsmoO/w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7955A1272B7;
	Mon, 25 Mar 2024 17:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387475; cv=none; b=aqdrAEiXVYQoQCNSm5EUmumukRjPFypUZFJcEQgUBuJZ5t59Js2s7pTdSo1LSrNEsj6sIf7S/aAmk27vyaBEDMErG55FqRlqWdffEiDgRXBawee3vgjaIP1hknxKNGot5xlHvhRZ/OmTKgx4iWWbxVuPW+2GxBlsvL313xUQo7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387475; c=relaxed/simple;
	bh=SG6EGca3m/NZMVmD+LxtzI3FPLdQj5ggvZ1olnz8HTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxRjIBUPp1AmcDLfFE7xUfSr/LG5Uns+1pax0THfJrYwuspoqiFPLLtrF3Y3pKq/jw49WQZdylLCF9wxrLS2ZwuUBsI7e8J+R59J7irZUC+t4U2aKZqCl8WpELkucpj4L+ccHvL5VfEBEoSBVDs4MJ9PUzyoBCDUtsQLCK/HmfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgsmoO/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050EAC43390;
	Mon, 25 Mar 2024 17:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711387475;
	bh=SG6EGca3m/NZMVmD+LxtzI3FPLdQj5ggvZ1olnz8HTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fgsmoO/w37AzO+prEM9Ft/N4eq5n4ItZ+8EMWV1UByxm8W8USJXyj6Hj0Gm7BmrGT
	 vyByf40ffH3tIkPP0VCbKQvkT1e58wXQVH4iPIGXVYIvNdV6FV0kEYOh+07jfU1hqD
	 byneQL3xWLOhGcg5jSMyj+F0kthJn5y3hNKe83runpMAFVWpkRXOF0XcjVGdetYC+R
	 Ug5GpG50+qra8r6atTzz9YlHRQTIbtnPFK41Vu6uIG67G+jYdeknOSc4sX5GsquPZe
	 /aze01GgFpUJ+oqJtrn9bS5iAvLwIlYOY9ciTLjA0sfvfDKEr5cg426fNtaQTYsD0f
	 cDQBdON1ilgVQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1roo3t-0000000049f-2nVQ;
	Mon, 25 Mar 2024 18:24:42 +0100
Date: Mon, 25 Mar 2024 18:24:41 +0100
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
	Johan Hovold <johan+linaro@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Subject: Re: [PATCH] Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode
 exists in DT"
Message-ID: <ZgGzWWV4Lh2Nal--@hovoldconsulting.com>
References: <20240314084412.1127-1-johan+linaro@kernel.org>
 <CABBYNZJV1htg46Gyu=7_iUWdukM+rHLitsLjxmWWYFGXty3tVw@mail.gmail.com>
 <ZfMStHjwtCT1SW3z@hovoldconsulting.com>
 <964131ff-293d-47d1-8119-a389fa21f385@leemhuis.info>
 <CABBYNZJ0ukd_8=SFzy8CEwgP7hV5unodca0NZ2zDZh+jPJsEFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZJ0ukd_8=SFzy8CEwgP7hV5unodca0NZ2zDZh+jPJsEFQ@mail.gmail.com>

On Mon, Mar 25, 2024 at 01:10:13PM -0400, Luiz Augusto von Dentz wrote:
> On Mon, Mar 25, 2024 at 9:57 AM Linux regression tracking (Thorsten
> Leemhuis) <regressions@leemhuis.info> wrote:
> > On 14.03.24 16:07, Johan Hovold wrote:
> > > On Thu, Mar 14, 2024 at 10:30:36AM -0400, Luiz Augusto von Dentz wrote:
> > >> On Thu, Mar 14, 2024 at 4:44 AM Johan Hovold <johan+linaro@kernel.org> wrote:
> > >
> > >>> This reverts commit 7dcd3e014aa7faeeaf4047190b22d8a19a0db696.
> > >>>
> > >>> Qualcomm Bluetooth controllers like WCN6855 do not have persistent
> > >>> storage for the Bluetooth address and must therefore start as
> > >>> unconfigured to allow the user to set a valid address unless one has
> > >>> been provided by the boot firmware in the devicetree.
> > >>>
> > >>> A recent change snuck into v6.8-rc7 and incorrectly started marking the
> > >>> default (non-unique) address as valid. This specifically also breaks the
> > >>> Bluetooth setup for some user of the Lenovo ThinkPad X13s.
> > >>>
> > >>> Note that this is the second time Qualcomm breaks the driver this way
> > >>> and that this was fixed last year by commit 6945795bc81a ("Bluetooth:
> > >>> fix use-bdaddr-property quirk"), which also has some further details.
> > >>>
> > >>> Fixes: 7dcd3e014aa7 ("Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in DT")
> > >>> Cc: stable@vger.kernel.org      # 6.8
> > >>> Cc: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> > >>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

> > ...the plan forward here? This to me sounds like a case where a quick
> > revert is the right (interim?) solution, but nevertheless nothing
> > happened for ~10 days now afaics. Or am I missing something?

> I guess the following is the latest version:
> 
> https://patchwork.kernel.org/project/bluetooth/list/?series=836664
> 
> Or are you working on a v5?

This patch (revert) fixes a separate issue than the series you link to
above, but it is also a prerequisite for that series.

v4 is indeed the latest version, and it has been acked by Rob and Bjorn
so you can take it all through the Bluetooth tree. Just remember to
apply this patch (the revert) first.

Johan

