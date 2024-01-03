Return-Path: <linux-kernel+bounces-15765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B506C823176
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B9352860E0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0541C2A0;
	Wed,  3 Jan 2024 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TmpmCPp9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CE91C298
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 16:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DEE0C433C8;
	Wed,  3 Jan 2024 16:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704300437;
	bh=FxemScwI7xnZdUR9mF2HQbQBMyHFgOgTAfg8JVFalmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TmpmCPp9uzG91/0742R8V1RlrZrvIDnwQnqmQmvPhuDe5FiPt16p1xqm9xK56LOqZ
	 nA6yfK1NNhh4WdIi7I686smrXMhN3XmTdjJk8Qt+QEA7Au4P3OPVlJfFRrjLIbuvtJ
	 ssRx7Mm1dq6X4id8ho0Uw7fCnPp6B6C29aG0D8ik=
Date: Wed, 3 Jan 2024 17:47:10 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	William Breathitt Gray <william.gray@linaro.org>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] driver core: mark remaining local bus_type variables as
 const
Message-ID: <2024010357-oblivious-manger-d480@gregkh>
References: <2023121908-paver-follow-cc21@gregkh>
 <CAPDyKFq0_1LPX8KUkB_qKZXfm0yXKy5xusRjMK9kJdQULcf+eA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFq0_1LPX8KUkB_qKZXfm0yXKy5xusRjMK9kJdQULcf+eA@mail.gmail.com>

On Wed, Jan 03, 2024 at 02:24:05PM +0100, Ulf Hansson wrote:
> On Tue, 19 Dec 2023 at 16:35, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > Now that the driver core can properly handle constant struct bus_type,
> > change the local driver core bus_type variables to be a constant
> > structure as well, placing them into read-only memory which can not be
> > modified at runtime.
> >
> > Cc: Dave Ertman <david.m.ertman@intel.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: William Breathitt Gray <william.gray@linaro.org>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Oscar Salvador <osalvador@suse.de>
> > Cc: Kevin Hilman <khilman@kernel.org>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Len Brown <len.brown@intel.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/base/auxiliary.c    | 2 +-
> >  drivers/base/isa.c          | 2 +-
> >  drivers/base/memory.c       | 2 +-
> >  drivers/base/node.c         | 2 +-
> >  drivers/base/power/domain.c | 2 +-
> 
> This above file has moved to drivers/pmdomain/core.c and I am carrying
> that patch in my pmdomain tree. If you have the time to send a
> separate patch for it, I can pick it up.

This is already in my tree and in linux-next, so all should be good.

thanks,

greg k-h

