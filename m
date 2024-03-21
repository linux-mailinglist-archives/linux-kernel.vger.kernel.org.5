Return-Path: <linux-kernel+bounces-110534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5240288603D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05C182843DD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63151332B0;
	Thu, 21 Mar 2024 18:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFhpGpTd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1211912BF3E;
	Thu, 21 Mar 2024 18:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711044284; cv=none; b=BziGoHFysCerx1KdTS2+t9avwweV+kfh92EprcQWRSim/czyvFFDRO+HNTnRBJW3x1UFneTN3op2fCG4X6VHjrCUpWHr4dlIdY9iIOo+uEvHm4jbQeUATS+nuW7BbC4eCwn5sOD2fHrZSNZ5IF+CzHdRx8eCv8tab4YjiWgyhs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711044284; c=relaxed/simple;
	bh=J80hw9KyCX9opqR+XEOMaH/He6vXKIOqs0CbuKC20xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aiMrKWSS2Iegp66fMSFNGw3/LQSTzU7vJlcXPakDgWh2XnBoW5dqJ0kW4VWfIq32VqiMv2HuBdd2qkICWF0TkzhMI6RFBSCRu23HXmCPTMyrXWSto1ArhlXXd8V+of4tR3NQwWgK3se3Lh07DyPBAE0uNWn3unk/0DsBiK+A4RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFhpGpTd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453F7C433C7;
	Thu, 21 Mar 2024 18:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711044283;
	bh=J80hw9KyCX9opqR+XEOMaH/He6vXKIOqs0CbuKC20xA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oFhpGpTdoER41EnaleJXCKlOCWbfnWqrs7uW3RUUBTJPsqV/V8T0nlPVJJ8m4itIQ
	 MjNThyJMqmzOwJYctzZSMUqGkGbrV/hexI7izxOiExiQSgs9YFzvWU4CLUp2uXCCWP
	 x+77dJWpw0QvetCYbEHS1aehIej4HaHki7KAYpn8DapTNTL0LuLqbuXjuhS/ANKyBH
	 0KrNAlBFPg0Ceojnl7wQydbJZ+zQCEZjN9FvVAGKjXDV6nIuCzax6zWr7emxC4NDDB
	 iOyCeCI410WdXe5QI0c59RbgM0oYALw56Dzp+gw/smhvf754x9NvlWRy9lnzQA0BB7
	 9/Hxj3RYPJVIw==
Date: Thu, 21 Mar 2024 18:04:39 +0000
From: Lee Jones <lee@kernel.org>
To: Min Li <lnimi@hotmail.com>
Cc: richardcochran@gmail.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v7 0/5] ptp: clockmatrix: support 32-bit address
 space
Message-ID: <20240321180439.GF13211@google.com>
References: <LV3P220MB1202C9E9B0C5CE022F78CA5DA02D2@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <LV3P220MB1202C9E9B0C5CE022F78CA5DA02D2@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>

On Mon, 18 Mar 2024, Min Li wrote:

> From: Min Li <min.li.xe@renesas.com>
> 
> The main porpose of this series is [PATCH 1/5], which is to support read/write
> to the whole 32-bit address space. Other changes are increamental since
> [PATCH 1/5].
>  
> 
> Min Li (5):
>   ptp: clockmatrix: support 32-bit address space
>   ptp: clockmatrix: set write phase timer to 0 when not in PCW mode
>   ptp: clockmatrix: dco input-to-output delay is 20 FOD cycles + 8ns
>   ptp: clockmatrix: Fix caps.max_adj to reflect
>     DPLL_MAX_FREQ_OFFSET[MAX_FFO]
>   ptp: clockmatrix: move register and firmware related definition to
>     idt8a340_reg.h
> 
>  drivers/ptp/ptp_clockmatrix.c    | 120 ++++--
>  drivers/ptp/ptp_clockmatrix.h    |  66 +--

>  include/linux/mfd/idt8a340_reg.h | 664 ++++++++++++++++++-------------

Acked-by: Lee Jones <lee@kernel.org>

>  3 files changed, 482 insertions(+), 368 deletions(-)

-- 
Lee Jones [李琼斯]

