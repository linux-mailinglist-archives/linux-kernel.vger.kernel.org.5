Return-Path: <linux-kernel+bounces-95057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C77F68748B4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 606061F22D2B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54D363127;
	Thu,  7 Mar 2024 07:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QeWVABOR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E3D5FDCC
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 07:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709796602; cv=none; b=fgVvsJkczgXO/87vM+qV5aSDUavkYHUyTyn8siTRMElRmNzqnN9ayG0xrl7NoMlwkN6YOjHY29Ot/3/vEgjDZSl/gz1vOzhc5EUE8LDU8J76qB3LNxbqWn8GMYJ30F6dn+0aiPjZyqWXHQEJU4/RQpsx9WxCP3t1Fc4ts9Xuh6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709796602; c=relaxed/simple;
	bh=uOitGMaR+iBTfWK+Kc+1O9pOqzYTokoWTjwf+rP8NSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U18XIBiUL7a5TJiHv/na8M7HiGHmPcbGc6v46y5OLcdoAx+tKXZGtzqmZOfVo2EZJrqXdTIgPsqc8KeczZE6Nw7y0dVfHFrI+0SZJCtLI6WlcES6x2Btw9j7hvrXRd3o2g3inx+ruhaklXyOjbgohkSDwXAkGqQ9AlCxMNAlktU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QeWVABOR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46579C43394;
	Thu,  7 Mar 2024 07:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709796601;
	bh=uOitGMaR+iBTfWK+Kc+1O9pOqzYTokoWTjwf+rP8NSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QeWVABORKFOidzI5mHG5XtQi90rwT2Z5tX94Bn4bChUoPvGhVVF2o/0XG9l7rTJ8V
	 0epdg0zohjpLdGlI1w+tBS1hZ+xfUgu/BK+JccgYvkJVuChgX98m5bWC6VxJEyILiB
	 9nzLn5+Ctl6ohfEocAiQQ/956Jk/78KTz9HmtfQA=
Date: Thu, 7 Mar 2024 07:29:59 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thorsten Scherer <t.scherer@eckelmann.de>, linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 2/4] siox: Provide a devm variant of siox_master_alloc()
Message-ID: <2024030732-ocean-handbook-161f@gregkh>
References: <cover.1708328466.git.u.kleine-koenig@pengutronix.de>
 <ad141dd22c7d95ad0bd347f257ce586e1afb22a4.1708328466.git.u.kleine-koenig@pengutronix.de>
 <ftvih5huvc72a76s7fe4zisrqtaax5tcgoukqoi2bkz47zcrq2@4fixszonixgl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ftvih5huvc72a76s7fe4zisrqtaax5tcgoukqoi2bkz47zcrq2@4fixszonixgl>

On Thu, Mar 07, 2024 at 08:13:55AM +0100, Uwe Kleine-König wrote:
> Hello,
> 
> On Mon, Feb 19, 2024 at 08:46:30AM +0100, Uwe Kleine-König wrote:
> > +struct siox_master *devm_siox_master_alloc(struct device *dev,
> > +					   size_t size)
> > +{
> > +	struct siox_master *smaster;
> > +	int ret;
> > +
> > +	smaster = siox_master_alloc(dev, size);
> > +	if (!smaster)
> > +		return NULL;
> > +
> > +	ret = devm_add_action_or_reset(dev, devm_siox_master_put, smaster);
> > +	if (ret)
> > +		return NULL;
> > +
> > +	return smaster;
> > +}
> 
> Here is missing an EXPORT_SYMBOL_GPL for devm_siox_master_alloc(). I
> squashed this into to commit I created. Find the fixed commit at
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git siox/for-next

Can you send me a "real" git pull request so that I can verify it is
what you say it is (ideally with a signed tag)?

thanks,

greg k-h

