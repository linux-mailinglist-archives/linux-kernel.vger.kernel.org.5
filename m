Return-Path: <linux-kernel+bounces-78732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FD18617EE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3477A28B471
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D39112837B;
	Fri, 23 Feb 2024 16:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0v90Tid4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E8B5D913
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 16:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708705846; cv=none; b=M5eMW7aqaipYbGHrW0TQcmmoMK3fJRGwcMkuY4j4MLJi8q0XPuF3cHWZ+WP5naYlISkV6EZDgT9wJ3f2xKf0gPEif7mTrvqO0c/yQIkm0jJQu1PnPESikr+MQZr66a0G7JS2MYeQbW2lSHm5kgy5voLLbrPBcFP7kivK3jILjAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708705846; c=relaxed/simple;
	bh=Yvt2VYDz9L5nNPLFoXi5zt1ijUuJUhtrFYMTsa2Lguk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNKz5x8z2XZpxLv5jj21x8azRdYvDG5sj+fNzWiPtntnaurrDtVBUcgMBDyky6ipEuvqI0+tZ0bezw5Rvl/6T+xnw5IQkcrOYA9FExUVae5tGbbHfNEpT/7iz05fs+N9n75XKPNeXpig+1k8tEPAmX7pc/Bfj3dyNTH92IL4pes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0v90Tid4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83142C433C7;
	Fri, 23 Feb 2024 16:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708705845;
	bh=Yvt2VYDz9L5nNPLFoXi5zt1ijUuJUhtrFYMTsa2Lguk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0v90Tid4G9qWnCDlIbpAfr3IFkQW08cWdeXA+s9981EXyV7COl2xUiZAJ4KPAEC98
	 0a996Vo863xKp1WSYnHPRIkHm8V93+4xSQpE+CXu4l0BKDiantK/43rQn8v/euR0tT
	 uYJJFYOUsl494iM14zupBxC9xl1ViSupq5zMsoMg=
Date: Fri, 23 Feb 2024 17:30:43 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nadav Amit <nadav.amit@gmail.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>
Subject: Re: [PATCH] vmw_balloon: change maintainership
Message-ID: <2024022333-matted-trickily-a23e@gregkh>
References: <20240202182339.1725466-1-nadav.amit@gmail.com>
 <CACKNADUCcW-Mrkt14VeGHTKsZ9KHMt9h=hfcncmDGUCyVGZqaw@mail.gmail.com>
 <400CBB6D-B5B6-4541-86DD-F1041B09A8F5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <400CBB6D-B5B6-4541-86DD-F1041B09A8F5@gmail.com>

On Fri, Feb 23, 2024 at 05:49:37PM +0200, Nadav Amit wrote:
> 
> > On Feb 5, 2024, at 9:04 PM, Jerrin Shaji George <jerrin.shaji-george@broadcom.com> wrote:
> > 
> > On Fri, Feb 2, 2024 at 10:24 AM Nadav Amit <nadav.amit@gmail.com> wrote:
> >> 
> >> Jerrin will be the new maintainer of the VMware balloon driver following
> >> Broadcom's acquisition and Nadav's departure.
> >> 
> >> Update accordingly:
> >> 1. Update the maintainer name and email.
> >> 2. Update the reviewer list to Broadcom's, which acquired VMware.
> >> 3. Add .mailmap entries for Nadav.
> >> 
> >> Cc: Jerrin Shaji George <jerrin.shaji-george@broadcom.com>
> >> Signed-off-by: Nadav Amit <nadav.amit@gmail.com>
> > 
> > Acked-by: Jerrin Shaji George <jerrin.shaji-george@broadcom.com>
> 
> Greg, can you please apply it?
> 

Sure, will do this next week, thanks.

greg k-h

