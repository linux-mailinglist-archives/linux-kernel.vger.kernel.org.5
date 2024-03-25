Return-Path: <linux-kernel+bounces-117587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A7788ACE9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FAF61FA030A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BBC84D25;
	Mon, 25 Mar 2024 17:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a88I9ZD/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F251A535AC;
	Mon, 25 Mar 2024 17:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387414; cv=none; b=ZaJrg4ub6T08FRwCTzjEXAfRbfVMvTEv+oACVGgYfLn7yID4k/qdlVKdNBfQc1mtMnl4NKreD9laVWHNmMfnNqYSRFQx2VtlhFFOhvld1wruAKaYXZMSJRQziGok//taMBFFsZ6BGL5w2MBj3KPgdq3FXDrmtmXV2OJqduAWHTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387414; c=relaxed/simple;
	bh=tYPxAtJOADxLj4QV0nuo2ems//1Fri3Ot9KeWJ93tHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTEr4I/BBifq2Gc+oNsbA9sVFDuZOiv4LgqU2aWomd2SSH1vhVTwUn9eAAlsITorMYzQts5Lr7aAqfkGJBjDFZMPH0GD2C6Do/ZqY9Q6bcA2+oGIzMPF0WqXnL1JP6BfUPF25cUco5aa5MD8UTAAm0Lkox/ZCDmw9nUX5flhQcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a88I9ZD/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15323C433F1;
	Mon, 25 Mar 2024 17:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711387413;
	bh=tYPxAtJOADxLj4QV0nuo2ems//1Fri3Ot9KeWJ93tHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a88I9ZD/UJHEUfwccZEZnly5tZYiQdBj5jooq/l3+q+QS4Tfcechmm+Vpexcw949Y
	 t5cn7r4PRkuV5O15T2wp8LVcugyiVbVwIkbwNR+qD6sBIZxgu8GUFhBkDQt8e4qmmj
	 kYTmPaSr1yJcAxqTIEDJzCi9LjFxwIvJrydWjsRE=
Date: Mon, 25 Mar 2024 18:23:30 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ayush Tiwari <ayushtiw0110@gmail.com>
Cc: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v3 0/3] Trivial code cleanup patches
Message-ID: <2024032552-ardently-colonial-8502@gregkh>
References: <cover.1710965653.git.ayushtiw0110@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710965653.git.ayushtiw0110@gmail.com>

On Thu, Mar 21, 2024 at 02:44:51AM +0530, Ayush Tiwari wrote:
> Address different kinds of checkpatch complains for the rtl8712 module
> to ensure adherence to coding style guidelines.
> 
> Changes in v3: Fixed issues about backupPMKIDList and verified with
> CONFIG_WERROR set and built the kernel.
> 
> Changes in v2: Checked any possible reuse of backup_PMKID_list
> manually and rebuilt, rebooted the kernel and loaded the driver
> with modprobe.

The subject line for this 0/3 email does not give us a hint as to what
these changes are for.  Please resend the next version with something
like:
	staging: rtl8712: .....

so that we know what to expect.

thanks,

greg k-h

