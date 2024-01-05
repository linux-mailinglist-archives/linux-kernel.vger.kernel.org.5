Return-Path: <linux-kernel+bounces-17844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 747CE82537E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84CFA1C2309C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 12:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C162D610;
	Fri,  5 Jan 2024 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wew1HBWw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351012D602;
	Fri,  5 Jan 2024 12:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CD3C433C9;
	Fri,  5 Jan 2024 12:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704459191;
	bh=/OKCBDu+sT7dZNqDjiKljP55Xl6ozfTj6H60TBI/UN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wew1HBWw+Fwxi7TpcBJnT1OOVbtF1F4GkUOKrqJbWkamrdDOOlXOEGuQ6luQp1Foi
	 8jOa7NZzF1z4hhNgVz6dCLuzkguBr7DmL0RN2mtNgmn0mZrHNQlDXmSOD8wFVLtOjW
	 8fktZJFfYD+APqBQ+dOEBXomSveJlFIW+2XQbgzw=
Date: Fri, 5 Jan 2024 13:53:09 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Roger Quadros <rogerq@kernel.org>,
	Javier Carrasco <javier.carrasco@wolfvision.net>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tipd: fix use of device-specific init
 function
Message-ID: <2024010558-unhappy-scandal-b823@gregkh>
References: <20240104-dev_spec_init-v1-1-1a57e7fd8cc8@gmail.com>
 <ZZf2lhtRdmIHmlBq@kuha.fi.intel.com>
 <56a15164-dbce-4740-b59e-b566f613f878@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56a15164-dbce-4740-b59e-b566f613f878@gmail.com>

On Fri, Jan 05, 2024 at 01:42:47PM +0100, Javier Carrasco wrote:
> On 05.01.24 13:36, Heikki Krogerus wrote:
> > On Thu, Jan 04, 2024 at 06:07:12PM +0100, Javier Carrasco wrote:
> >> The current implementation supports device-pecific callbacks for the
> >> init function with a function pointer. The patch that introduced this
> >> feature did not update one call to the tps25750 init function to turn it
> >> into a call with the new pointer in the resume function.
> >>
> >> Fixes: d49f90822015 ("usb: typec: tipd: add init and reset functions to tipd_data")
> >> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> > 
> > This was suggested by Roger, no?
> > 
> 
> Yes, it was. Thanks for the reminder.
> 
> Could the following trailer be added before applying?
> 
> Suggested-by: Roger Quadros <rogerq@kernel.org>

The tools automatically just added that now, thanks.

greg k-h

