Return-Path: <linux-kernel+bounces-89856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8684386F694
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 19:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D371C20F39
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 18:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C102B76402;
	Sun,  3 Mar 2024 18:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgglCeFy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C82C1E4AF;
	Sun,  3 Mar 2024 18:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709491084; cv=none; b=i5xzz6AB3ZkYZsHXnr+MW+Y0xLkOZ8wiuckvDc21CKxbqYYDlFG/dFYTAxpLS50BeGlJpkAOscF5aQRYw+fwnZMeTx/4fBPcjLlQWx2CDjLFkPbpst+p3Loae/CXMqYVRKyN9dRlxTy+FEMkVKSh93UEAyiTkEIpsHFnnULx2ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709491084; c=relaxed/simple;
	bh=wb9M/TXW9yAW1F13VKA/l3kNiaI+HHxbDbSzbdVcWB4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BeuYBSA8jv0cGGIRBUSddljGVKHzZnQeXCQ9XoTi5LLPOunUwlATsZfXlzCmsf5JcomJe/fZfU/br/yKwT+Rj1ty84Mqnst8KhrBnP1X7giBW1+irMUJGU7FakfyqnOIWS0R5yx0iwLfel/P6r4duJiKXcTKhtWithNxupDQr2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgglCeFy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0282C433F1;
	Sun,  3 Mar 2024 18:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709491083;
	bh=wb9M/TXW9yAW1F13VKA/l3kNiaI+HHxbDbSzbdVcWB4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hgglCeFybrtyRo2yqC8ud3AOkW6K20YKwKxvWhvf0507cLMhfYGCBqK280MJcUImQ
	 LJxvaVvpRycjMXOV4nV9xeDT6viZpvmpkDFPZyKJtwhcVwN1AqjUiIwj/MWywpD+qN
	 nHfmtHNTf5WUD7tDqacBIxLvsCrGk/qQgAqK9TtryflO8mQwmxZNYbjZQkAkfsfcTO
	 MYjSJffuGeEsQhUyLm5Ky1ycgpBGwuxkr8K8l9AQAj+IFm1M7E0FUOc3GYiEZKLeU7
	 kTUC+uQQhwzSHhIU6+dTH39CMH+1VQZqzy8ysiI2bUFBEIA1yZHw3stwgRQqxJlktn
	 ukSBUcv0kmISw==
Date: Sun, 3 Mar 2024 18:37:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Saalim Quadri <danascape@gmail.com>
Cc: ciprian.hegbeli@analog.com, marcelo.schmitt@analog.com,
 dragos.bogdan@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: GSoC Proposal 2024
Message-ID: <20240303183750.4737bb90@jic23-huawei>
In-Reply-To: <20240229184636.13368-1-danascape@gmail.com>
References: <20240229184636.13368-1-danascape@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 Mar 2024 00:16:36 +0530
Saalim Quadri <danascape@gmail.com> wrote:

> Hi everyone, I am Saalim Quadri an undergrad student at Dayananda Sagar College of Engineering, pursuing Electronics and Communications.
> I wish to participate in the GSoC 2024 as a part of the Linux Foundation, IIO Project.
> 
> I have been contributing to the Linux Kernel and have more than 10 accepted patches.
> 
> I started looking into https://wiki.linuxfoundation.org/gsoc/2024-gsoc-iio-driver and Analog Devices Inc. and I am interested in writing
> the driver for AD7294-2 12-bit control system with ADC, DACs, temperature sensor, and current sense.
> 
> In that sense, I would like to know if anyone in the IIO community could provide with some suggestions, I can get started with.
> Any suggestion or hint is appreciated!
> 
> Sincerely,
> Saalim Quadri
> 
Hi Saalim,

Interestingly (you may be aware) you aren't the first to propose that part.
https://lore.kernel.org/all/YlXR0d7waKW9xncd@fedora/

There was some discussion back then but it was brief!

It seems like a sensible part to look at.  It has a broad range of different
features but from a quick glance at the datasheet nothing too unusual - which is
good because we won't get stuck discussing the userspace interface for too long.

Make a plan to build up functionality of your driver over the course of the project
with each step adding something significant and new.  Allow for reviewer time (up
to 2 weeks at worst - it is the summer so people go on holiday etc), but try 
to build a plan where you other elements to work on in parallel with waiting
for feedback.

Obviously sticking points like device availability and interest from the mentors
are important inputs on the decision though.

Good luck!

Jonathan



