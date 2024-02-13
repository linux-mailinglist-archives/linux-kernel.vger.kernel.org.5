Return-Path: <linux-kernel+bounces-63398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 848ED852EC8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 185B0282585
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CF12C69A;
	Tue, 13 Feb 2024 11:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lm3b2fcw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BCA381C6
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 11:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707822460; cv=none; b=FQYUXJV5bFk2Ol/c66qDv/6ybZitqgt2jSd/PHLdHVHHw78VqTV1enuPJadXDxbS6pH3I1P/lhjKTYfVvKkqrwleSzTEhPUITRCIuIGrpFen35bm5HFdHEktqd0SuJNlFfdk5DOaEv4SAHe7vc39oEZ185tSD1sgMCFSs1UM764=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707822460; c=relaxed/simple;
	bh=8IAiOzlAm0hby7CIaHI0gOwxx/kmSj9YMV3D4bA1Yck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CW2ykA1PXBc1yJ7gmFJiKQmlUXAkDXVAxq2j2Z0nqwjxK03EZCc6xY8i2xdccvu47VzXT+4cNVJjYtizjYOy6UWwW8Um3KMQvMUf6JEIqpkMvliGJ5Q3HbbMDKcj3JxdUhIzEMkjOdLX9s7gZ0NhgQZE/Y8TqUJl6lXt4uciX10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lm3b2fcw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F06FC433F1;
	Tue, 13 Feb 2024 11:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707822459;
	bh=8IAiOzlAm0hby7CIaHI0gOwxx/kmSj9YMV3D4bA1Yck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lm3b2fcwh3x7jo+27J56ukMPcy+oEKsQKexJEYw3AivzBeYYdbDJ5rehVk7I+aLu8
	 jucKBlzs0tp7SpQBjyrD41j1+wB3V6xrds4Du2RCPPY4wN9+Qv0lW3XFkAMhL+KWEk
	 F9aCEJuyrdKaD2iCJFsIz3giONMgwiMsI1Z3S0oI=
Date: Tue, 13 Feb 2024 12:07:36 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] powerpc: struct bus_type cleanup
Message-ID: <2024021332-unzip-satirical-268d@gregkh>
References: <20240212-bus_cleanup-powerpc2-v2-0-8441b3f77827@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212-bus_cleanup-powerpc2-v2-0-8441b3f77827@marliere.net>

On Mon, Feb 12, 2024 at 05:04:58PM -0300, Ricardo B. Marliere wrote:
> This series is part of an effort to cleanup the users of the driver
> core, as can be seen in many recent patches authored by Greg across the
> tree (e.g. [1]). Patch 1/5 is a prerequisite to 2/5, but the others have
> no dependency. They were built using bootlin's without warnings using
> powerpc64le-power8--glibc--stable-2023.11-1 toolchain.
> 
> ---
> [1]: https://lore.kernel.org/lkml/?q=f%3Agregkh%40linuxfoundation.org+s%3A%22make%22+and+s%3A%22const%22
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

