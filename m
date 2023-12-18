Return-Path: <linux-kernel+bounces-3556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CE0816DCB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED069B20A77
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93352481BC;
	Mon, 18 Dec 2023 12:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U1zxJOEc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CE02030F;
	Mon, 18 Dec 2023 12:18:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA69FC433C8;
	Mon, 18 Dec 2023 12:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702901903;
	bh=RKxkpi4VMfErZSEKvSliBz5sD1Yuk65kLdGZ8NdpA/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U1zxJOEcU1gJy/RU0pKgS+WwAUo5tCgYmJ206N6sw30uFkeKNlVUfB20MJ3Qozx8m
	 hhc8N4C//eq99hexkpqABByXQQbvFWRPMX/Vzw+TfM+ZOqJ1EelCgh6T2GEErx1359
	 6WGEyeLrOSXLQGRY7vTf6HsDE9bpjiOz3GNPDJbw=
Date: Mon, 18 Dec 2023 13:18:20 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?utf-8?B?VG9tw6HFoSBNdWRydcWIa2E=?= <tomas.mudrunka@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] /proc/sysrq-trigger can now pause processing for one
 second
Message-ID: <2023121858-aground-consent-cfe3@gregkh>
References: <20231218114222.283705-1-tomas.mudrunka@gmail.com>
 <c22997c9-6d99-4e1f-9015-b7f80be2a720@kernel.org>
 <CAH2-hcJe40e7LhrmQb5XjGpRfrUEp3RukqWUqn1p8UQSNkpisg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH2-hcJe40e7LhrmQb5XjGpRfrUEp3RukqWUqn1p8UQSNkpisg@mail.gmail.com>

On Mon, Dec 18, 2023 at 01:13:34PM +0100, Tomáš Mudruňka wrote:
> > Bah, what's wrong with:
> >   echo e > /proc/sysrq-trigger
> >   sleep 2
> >   echo i > /proc/sysrq-trigger
> > ?
> 
> Your bash, or even ssh session being killed during the first line, not
> getting to the two subsequent lines.

What will kill it?  I feel like you are adding features to the kernel
that can be done in userspace, which is generally not a good idea.

thanks,

greg k-h

