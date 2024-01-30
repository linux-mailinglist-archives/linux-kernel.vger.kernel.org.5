Return-Path: <linux-kernel+bounces-44366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 642248420F1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93E781C27D65
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E30B60DC9;
	Tue, 30 Jan 2024 10:15:18 +0000 (UTC)
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F736089A;
	Tue, 30 Jan 2024 10:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706609717; cv=none; b=HyOzxP5HWZJ7Qr6COqRFGnKBUULITTH+n4bvPAhAZkQ2waN3th7obcx+jMTKiczqzk+jYb+lxJxhvxuEW2az1ZIrlj6iq4xz040UzdiotMDxt5NBZRfj2U7bQuzfuZpJ29SW1GbLk0pcR9TMb9Ta6+Zmcwe8lQ28L3OtGY8yl9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706609717; c=relaxed/simple;
	bh=9fYioI8dC2iBxcG6AmP63IOk32XJP98pHndMcV1dzEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCSqYjGIN7b4321OuvyZRdgMT80JGvXSQKB/rW9yuzGEch/7jf9VnuPlMylI/H0Y9xhsLFcMzGdQkfYM22CmWY6ZoFPScY2aUyID6RPEyHD43Ugz+acET1CeQWtbTJ+n4e/rwER5e/y1KQ4//6P6Am93clmceJEQlph4zsQhYzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gnumonks.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gnumonks.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from uucp by ganesha.gnumonks.org with local-bsmtp (Exim 4.94.2)
	(envelope-from <laforge@gnumonks.org>)
	id 1rUl90-00F0vY-2G; Tue, 30 Jan 2024 11:15:06 +0100
Received: from laforge by localhost.localdomain with local (Exim 4.97)
	(envelope-from <laforge@gnumonks.org>)
	id 1rUl5f-0000000FnQK-1I97;
	Tue, 30 Jan 2024 11:11:39 +0100
Date: Tue, 30 Jan 2024 11:11:39 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: takeru hayasaka <hayatake396@gmail.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	vladimir.oltean@nxp.com, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	mailhol.vincent@wanadoo.fr
Subject: Re: [Intel-wired-lan] [PATCH net-next RESENT v3] ethtool: ice:
 Support for RSS settings to GTP from ethtool
Message-ID: <ZbjLWwG8m-FdyxMH@nataraja>
References: <20240127140747.905552-1-hayatake396@gmail.com>
 <154f979e-a335-461b-b72e-5e9c54fe940c@linux.intel.com>
 <CADFiAcJShbgBLXdVgs1vK1jqDFopkRcw-se4b4h0V3Yd60xLVw@mail.gmail.com>
 <92958c7b-7e5f-4e25-819f-4e52f9ffcf7b@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92958c7b-7e5f-4e25-819f-4e52f9ffcf7b@linux.intel.com>

hi Marcin,

Disclaimer: I have no understanding of the proposed implementation here, just commenting
on this from a 3GPP protocol architecture point of view.

On Tue, Jan 30, 2024 at 10:59:40AM +0100, Marcin Szycik wrote:
> >> gtpc(4|6) doesn't include TEID, so what is its purpose?
> > In GTPC communication, there is no TEID in the CSR (Create Session Request).
> > Therefore, there are cases of GTPC that do not include TEID.
> 
> The way I understand it now, this patch (and the ethtool one) adds hashing on
> TEID field in GTP* headers. So I wanted to ask why do we have a case (gtpc(4|6))
> that doesn't include TEID? Do we hash on other fields in this header?

There are many differen GTPv2C messages, most of which contain a TEID.  So it does
in general still make sense to be able to use RSS for all those other messages.

The CSR (Create Session Request) will not be able to benfit from it, but
it's just the first message initiating a dialogue between two elements
(think of it like a TCP SYN).  All the follow-up messages in that
dialogue contain TEIDs and hence can benefit from RSS.

-- 
- Harald Welte <laforge@gnumonks.org>          https://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

