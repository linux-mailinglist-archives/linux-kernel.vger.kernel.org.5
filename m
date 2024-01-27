Return-Path: <linux-kernel+bounces-41390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF70B83EFF6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 21:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62F8E1F23050
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 20:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE6829CEE;
	Sat, 27 Jan 2024 20:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QKS6e1l7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD562E646;
	Sat, 27 Jan 2024 20:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706387075; cv=none; b=WgGD8Og6g9ZQaWqOv0m1/zjjq6lW70M2RPe9eBkZR/EqyvWkkoVYU4KCYEdnddOKNwYBdwJsDt7huL8cX8WzMVhPfisHnwiKcqFDV3UQFIgnctX5LFH80BNorT6f3lCeIaFQpOzPOQzEc2IcxWgjrVC3PnNLzgT6PHaj7b4HuDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706387075; c=relaxed/simple;
	bh=Qy/uM5ceRH/PfTVRGdIn3mzi8v6/KvHX23QSNmHl5CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCbIN6+iHsjJeRkc+zLT4EDkkUajr570sHZTPo2A8M6k1hCnNoH/v0Navk+sQqALU5+BlBLAOs0TS7iTg4AeFEgNsHqAy6ZHhWGao79qQ8ievs6ov3x9qTNFobhugXfohMZGS+yFq8GBaGec53iCq2GKgqhopDhny0fcJqnyn0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QKS6e1l7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B630C433C7;
	Sat, 27 Jan 2024 20:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706387074;
	bh=Qy/uM5ceRH/PfTVRGdIn3mzi8v6/KvHX23QSNmHl5CU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QKS6e1l7taRwHKWGuT0C7FJU+PtcEguE5lVt/KOQxu6KWBEDvsHP3304X8BSqnDCW
	 wTbcDEvIxN5XFu2QdHVQPrt96HetsZ4E6TVa48wS0CEkKQ42VtYhbi7/qZ+3TIeEkS
	 w+b4+8q/Sglm2mHiEo7vnzPq08sruQXz8VACgNAU=
Date: Sat, 27 Jan 2024 12:24:33 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: Tree Davies <tdavies@darkphysics.net>, anjan@momi.ca,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/18] Staging: rtl8192e: 18 Additional checkpatch
 fixes for rtllib_softmac.c
Message-ID: <2024012707-garbage-kissing-99b5@gregkh>
References: <20240126223106.986093-1-tdavies@darkphysics.net>
 <6f13d58a-f072-49dc-a9bc-f742550fc9f7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f13d58a-f072-49dc-a9bc-f742550fc9f7@gmail.com>

On Sat, Jan 27, 2024 at 05:44:58PM +0100, Philipp Hortmann wrote:
> On 1/26/24 23:30, Tree Davies wrote:
> > Version 2
> > 
> > Another checkpatch fix series to be applied after the series titled:
> > 'checkpatch fixes for rtllib_softmac.c' submitted by me, to the list,
> > on 1/5/2024
> > 
> > Thank you in advance to all reviewers
> > regards,
> > Tree
> 
> 
> Is working fine on hardware.

You might want to respond with:
	Tested-by: ....
so that our tools pick it up and you get added to the commit logs, if
you want that.

thanks,

greg k-h

