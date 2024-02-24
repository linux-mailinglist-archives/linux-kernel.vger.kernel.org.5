Return-Path: <linux-kernel+bounces-79542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9F88623D5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 10:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD0181C21B19
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 09:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8961C1A702;
	Sat, 24 Feb 2024 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UrRpWmZ1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DEE4C9F;
	Sat, 24 Feb 2024 09:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708766546; cv=none; b=ke37FEvp1LjNGDG3jzr+/JO66cScVOoMzLJE3S8RGyhN2BYKM1VQNsbeNpQPi68CaBAHQGBSZ5HhwC3jmapsGlDpAEM94miBT04pBff2n7dcWKLDTXdoOyeBg9Mrc6elzcIMrIV9SQPGLMPl1qG8KJE0DpmRZdMwNK7PftGf0Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708766546; c=relaxed/simple;
	bh=H/s3tqtmKz+lYtgGOet5sgybxzSgFOHo1ghdcCr/VJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMXs4YZ76dl8DCGYUylgo0AalSlJbnGHMD08T4MNPfgVLy5lE7eE+SACXFDWf4S3GfenN+NB0ZO6zAu2IIG8oD4ZbrhbG+LOjlb0uEC00oseS/1/BK8Vr23H9xhkAhykqiH+M8jyg3BPYyh/jg+2m0qMuPM35s/mIf9/rrPijM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UrRpWmZ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A12C433F1;
	Sat, 24 Feb 2024 09:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708766546;
	bh=H/s3tqtmKz+lYtgGOet5sgybxzSgFOHo1ghdcCr/VJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UrRpWmZ14Vux5GlUAxS5wHFuq4QWwet+ZKs1Eribgm7ZjN2JMPpsHrhc/VwwbaMFw
	 m6fzDQjAd/hU0XAH77irq6DM0e2T0zg7Md/CFOHtK5SL7ZJuuKnwGH/DP6oXuyAeFw
	 CjER+T1sKqpnIGZv9CSTo4NEDTP4IjqkWHpazI9s=
Date: Sat, 24 Feb 2024 10:22:18 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Luna Jernberg <droidbittin@gmail.com>
Cc: Ronald Warsow <rwarsow@gmx.de>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.7 000/313] 6.7.6-rc2 review
Message-ID: <2024022432-fleshy-mumps-3b65@gregkh>
References: <ed9e1bca-d07b-42fa-9ceb-d0eef3976168@gmx.de>
 <CADo9pHg2jgYqE1qxpV40E6GHL1s+G+mNm1JCcB9GgA-4XM59+w@mail.gmail.com>
 <2cc27421-8791-47bd-a3d6-83188332ad3c@gmx.de>
 <2024022326-wheat-heat-e4ba@gregkh>
 <CADo9pHgvjr6-=heOBuhjZqW0W2nhC1zBbaqYq9bWis9J-6SBAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADo9pHgvjr6-=heOBuhjZqW0W2nhC1zBbaqYq9bWis9J-6SBAA@mail.gmail.com>

On Sat, Feb 24, 2024 at 10:01:36AM +0100, Luna Jernberg wrote:
> How do i change to bottom instead of top posting in the gmail webinterface?

Move to the bottom when responding, or use a different tool to access
your gmail account.  There's a whole document in the kernel
documentation directory for how to deal with email clients, I recommend
reading that.

thanks,

gre gk-h

