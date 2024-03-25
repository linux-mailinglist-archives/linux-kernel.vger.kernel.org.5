Return-Path: <linux-kernel+bounces-117461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6DE88ABA3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BADA4303FF5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAA7134735;
	Mon, 25 Mar 2024 16:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7DFIqc5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C4912E1D9
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711383771; cv=none; b=k6bxHzVfvfsBYwmVvDs7J7GZjE7mrYFNBu7n2q85DKjFSaN0f7jRjR0mZr+oEKQpaO0L172doynFl9zUhcV3JV7+taRH6eE+mQZ956NjbP1nxgIHnx+oh/UvgljWM0jT2vJRYVQ/RCjMXBpMR2lf9p6EXYgElss8/pjpS6TddKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711383771; c=relaxed/simple;
	bh=Nn9yAwz6gZxbSteIuZaZE+uSVwVjPtH/MxPFZVa4f9A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qYKtlduNIkySfLfYD0AvQIliyNTlyMqgBIsokBk7/eDCo/pEspWwkEoCC49gD4BfngPWxSwbP2Itz1fna11Q3SNOpkOZOaehRVtADViX8RxdvSw9Iqzb1zSESse8JQf98MockvVYVRmzH48tyTNzzP2FZlJ1RGFja5/HXWfsLNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7DFIqc5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF74C433C7;
	Mon, 25 Mar 2024 16:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711383771;
	bh=Nn9yAwz6gZxbSteIuZaZE+uSVwVjPtH/MxPFZVa4f9A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=C7DFIqc5w8NfWpQ2Ap2KqM/NT2tZzuBGjXDsQn6kD8Kgbgf7H2NlfKQU9LXc3Xa7U
	 mZekM1MMiHAQAukef1X+/QF/Jy9fUL7IJVZ3bgqb57DeJG25Mk5Z1r5SPaq5rJSdOM
	 xubrm4VbOThj1RTcy7Zjt8w0fmRJQQ+Cxp3rg+8U30FBYF29rfLA5jA1NhBMFYTB9J
	 QIrMqiZJhDCk2YRlTMTSArlhBT6/FSbJfZK89y+NkgI2qC3Wf5MG+NHSyzsWGfYt/B
	 B3LEiODRYOfRSVr2Du4toLr6eMb31bJG0/+Fv70sz3rwFl1ayanIlfBoSamJ+Q7d17
	 x+lV63Q73tzOw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,  Miquel
 Raynal <miquel.raynal@bootlin.com>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v1 1/1] mtd: core: Align comment with an action in
 mtd_otp_nvmem_add()
In-Reply-To: <20240325151150.3368658-1-andriy.shevchenko@linux.intel.com>
	(Andy Shevchenko's message of "Mon, 25 Mar 2024 17:11:50 +0200")
References: <20240325151150.3368658-1-andriy.shevchenko@linux.intel.com>
Date: Mon, 25 Mar 2024 17:22:49 +0100
Message-ID: <mafs0ttku1dt2.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Mar 25 2024, Andy Shevchenko wrote:

> The comment is related to the non-error case, make it more clear
> by inverting the condition. It also makes code neater at the end.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav

