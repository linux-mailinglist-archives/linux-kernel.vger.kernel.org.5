Return-Path: <linux-kernel+bounces-51171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B8E84874C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 769FE1F24131
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B375FB8B;
	Sat,  3 Feb 2024 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YPZ+VnNM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9F25FB82;
	Sat,  3 Feb 2024 15:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706975914; cv=none; b=cown85fQmBkCjJ+zGvSQnQXxLkfNoDPRNsL74veWrn0/RomFrq69HHbH+3KlUStXd+oGM1/ggPZ7BuhYCCCxktMKMl94HVKiwSTv+dCTJaVl8dxYjTj0O4pbZhIs/qJvRX6PuDAiljAYiPEYM/EQJ1CXO0ZNL0JCru+ZjpAnsts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706975914; c=relaxed/simple;
	bh=+qLxnypZuud3zlNiK/RSlw7RdMEvBX4l44JJi/kQdmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WtlGQjB0G9smPK4PyyNcJmjxYSVkJnFB9Q4dhigvf2hYN0ixSwRUEdAoQTO3f5dRfy6PT7w3x1PbX14X69RU1CyxKQhk8tAP8+yYA07sVtK8Xx/ZzwHUdLEH4SHusWw8qo8+e9RdjQb+SAmI1TtNDGDh21vBhsEhYGcUONzlbx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YPZ+VnNM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5652C433F1;
	Sat,  3 Feb 2024 15:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706975914;
	bh=+qLxnypZuud3zlNiK/RSlw7RdMEvBX4l44JJi/kQdmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YPZ+VnNMtlUqA34fBDsw66fqrzb3cw2nwPqFxCtEvI3Xl0veMcykU/pmZgRSSxIIK
	 mu4ElRYLacG5HuODWbHDJM8sYGUNh3fDElcO2BzOxjvk9gE+kEWpTyFOYEi7rFwMiJ
	 TTlDM4xHzA2iLqNX022O1Pe25eemTTjJxgn70UDM=
Date: Sat, 3 Feb 2024 07:58:33 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] media: media-devnode: make media_bus_type const
Message-ID: <2024020328-sculpture-size-009e@gregkh>
References: <20240203-bus_cleanup-media-v1-0-33e8feeab912@marliere.net>
 <20240203-bus_cleanup-media-v1-2-33e8feeab912@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203-bus_cleanup-media-v1-2-33e8feeab912@marliere.net>

On Sat, Feb 03, 2024 at 12:31:27PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the media_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>  drivers/media/mc/mc-devnode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

