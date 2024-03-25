Return-Path: <linux-kernel+bounces-117851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B02D88B070
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 990361C3D11B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B543F41C79;
	Mon, 25 Mar 2024 19:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="heK1Rnyk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E890E3398B;
	Mon, 25 Mar 2024 19:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711396111; cv=none; b=cJGPm2qEbBnBoD1bGIS3eCkyMdzEkRbJOjOKI6jdRuKsvYXbuGHx2LJQgIwkSusyWDe++wRFNlOVdZbTxRwEtYShcBu3ZoVpdG+bhTYU6u8psRDbnhchVg64TyCZfjTopAOyD+OFEFDU3vnsB2K2vZkNp6zF9tVvkGi+J5MhcXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711396111; c=relaxed/simple;
	bh=kewFYRqhie/XcnlberYm9YkkG/goelTdU5EXcYg82SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoXGaAItEnUp7lCNacU0J4tn+LK027YbjhHhlh19am7qRVmu3yWtVY0N65TIsbYppgGtDFXYuXVlPBD7pd8xoF6cEG1hkox3AJEeu/lr7kvsI9tAK9Zp4I764OKeQvFoB1S+EfbjJhjqWuU8emUNN1M0YAHK9/0COV34XmyrmMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=heK1Rnyk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6615EC43399;
	Mon, 25 Mar 2024 19:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711396110;
	bh=kewFYRqhie/XcnlberYm9YkkG/goelTdU5EXcYg82SI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=heK1Rnyk787MP455BDd1yxr9409bzn8Hv0bqIVRyNYrbowroQ69aNvxQOxU4DHGBR
	 jJh+DkmtP+ncevvebIpYOT/JxqxQZNuc2WCQZ/MUQAIVlComsZ91HsiEKFk0Weg1x5
	 gkecO7l0hRzPxVykSxxNN/pIK49A7u1M+wFPK26oSaGNgDeeTXDCAKUhmwfr0Apsw4
	 6p76S4hoVFFN1I+paNG+Ey0UHIH059mzKj7O6+hoIfKydPhuSN07bkDMzx66mLSYpL
	 snZe4KI+OFFcuQChSQFw62REjB4YAb3kVgLoYUe4qDk2r8Em6pZOppG21KKclXtfjc
	 QD8WACQy4sdYA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1roqJC-000000004LS-15hB;
	Mon, 25 Mar 2024 20:48:38 +0100
Date: Mon, 25 Mar 2024 20:48:38 +0100
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
Message-ID: <ZgHVFjAZ1uqEiUa2@hovoldconsulting.com>
References: <20240314084412.1127-1-johan+linaro@kernel.org>
 <CABBYNZJV1htg46Gyu=7_iUWdukM+rHLitsLjxmWWYFGXty3tVw@mail.gmail.com>
 <ZfMStHjwtCT1SW3z@hovoldconsulting.com>
 <964131ff-293d-47d1-8119-a389fa21f385@leemhuis.info>
 <CABBYNZJ0ukd_8=SFzy8CEwgP7hV5unodca0NZ2zDZh+jPJsEFQ@mail.gmail.com>
 <ZgGzWWV4Lh2Nal--@hovoldconsulting.com>
 <CABBYNZJaXUhu1A+NyVT-TAJw49zcV6TMdGeVy2F+AVKWBOVC-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZJaXUhu1A+NyVT-TAJw49zcV6TMdGeVy2F+AVKWBOVC-g@mail.gmail.com>

On Mon, Mar 25, 2024 at 03:39:03PM -0400, Luiz Augusto von Dentz wrote:
> On Mon, Mar 25, 2024 at 1:24 PM Johan Hovold <johan@kernel.org> wrote:
> > On Mon, Mar 25, 2024 at 01:10:13PM -0400, Luiz Augusto von Dentz wrote:

> > > I guess the following is the latest version:
> > >
> > > https://patchwork.kernel.org/project/bluetooth/list/?series=836664
> > >
> > > Or are you working on a v5?
> >
> > This patch (revert) fixes a separate issue than the series you link to
> > above, but it is also a prerequisite for that series.
> >
> > v4 is indeed the latest version, and it has been acked by Rob and Bjorn
> > so you can take it all through the Bluetooth tree. Just remember to
> > apply this patch (the revert) first.
> 
> Doesn't seem to apply cleanly:
> 
> Applying: Bluetooth: qca: fix device-address endianness
> error: patch failed: drivers/bluetooth/hci_qca.c:1904
> error: drivers/bluetooth/hci_qca.c: patch does not apply
> Patch failed at 0004 Bluetooth: qca: fix device-address endianness

Did you apply this patch (the revert) before trying to apply the series?

Johan

