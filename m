Return-Path: <linux-kernel+bounces-94516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 106D18740EC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7152228722A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA79C140E5E;
	Wed,  6 Mar 2024 19:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVh5/zyo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2946113DB9C;
	Wed,  6 Mar 2024 19:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709754952; cv=none; b=rPpva5lFz4KZ2Qy+FMh69QXPOUI636fSwu8T2ZMqUtG3XJWJPRKv34vwDsRSnfd0fWb2KdkjJgmXJW41rS8QNobkrBSlzwIvHrAJABuzkAxEyUl6EzxvROqHa6v1w2vpfU29UPV5NTmXOz67NmtXDWxetZx/EFNk+HaGS7J8gQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709754952; c=relaxed/simple;
	bh=AHBw5PELXWOXcc1dwUv+CjWxZZhla73VhJIx9MjeDBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+KY5YkDPwW+n6RGlH2tvvth8U4fpjXgckWMFZDupR/71jNOlwxoBtAAlnByRSEZtemdOop+fLy0XYxq24eA+3PGpUOszL/3dygX4OJDT1HVhw3sZle4OWV6awwVrJCwathSa8nUdcq5S29KcYkdxOW9aiM5/JFgAC9bDgryAQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVh5/zyo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D69C433C7;
	Wed,  6 Mar 2024 19:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709754951;
	bh=AHBw5PELXWOXcc1dwUv+CjWxZZhla73VhJIx9MjeDBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PVh5/zyo2OelorguhPvvFi/uKFx7vJAhx40rmDuZsitrQRZX5rjQslIuiGbR2HIyt
	 N0+OWip3hvWu0elFUhnhv0qLSoqjfCARp2cVlMmu1jmOuZvn4Gr4DsgNeSyp6PveP4
	 Rc5YdoCKHKqkPYrK8qEptXdXUGEAJXM/Z3ULhXvg7dnNXkd8GpTgmVZzOqX/Q5bpKY
	 YbC3PAnvcDaMxw9FYAwQtGU62ty99KPeTfIeYzWmOzxPw5kXbNibzO+vhfEdRCI5Ro
	 iNaAzlE5/N6OMGbfdYxoifHFTTw6d+d0W2D6fsjVHCPJk4dwwSHVUNeI+SgtwFpQ0h
	 ztBEQUd/z80pg==
Date: Wed, 6 Mar 2024 19:55:48 +0000
From: Simon Horman <horms@kernel.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Karsten Keil <isdn@linux-pingi.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] isdn: capi: make capi_class constant
Message-ID: <20240306195548.GE281974@kernel.org>
References: <20240305-class_cleanup-isdn-v1-0-6f0edca75b61@marliere.net>
 <20240305-class_cleanup-isdn-v1-2-6f0edca75b61@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305-class_cleanup-isdn-v1-2-6f0edca75b61@marliere.net>

On Tue, Mar 05, 2024 at 05:04:48PM -0300, Ricardo B. Marliere wrote:
> Since commit 43a7206b0963 ("driver core: class: make class_register() take
> a const *"), the driver core allows for struct class to be in read-only
> memory, so move the capi_class structure to be declared at build time
> placing it into read-only memory, instead of having to be dynamically
> allocated at boot time.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Simon Horman <horms@kernel.org>


