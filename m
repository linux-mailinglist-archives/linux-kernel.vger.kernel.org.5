Return-Path: <linux-kernel+bounces-61369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A6C851178
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05FC41C2356D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628B839FCD;
	Mon, 12 Feb 2024 10:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m9mVvqVf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC38A39FC3
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707734765; cv=none; b=FnP8LkGtOnmBHxmIwGAKUibv9xXR95jdl7i9H1QIjMbyiUpHvI66xiEvbcGzMJWynLv+am14T6z6iqptU7NaHbniH5eA6WsTCd13xeTIPnJN9ZGYocsyQyxvbodLPyajZDI1d2O6PqNVq42HCUVESGK4++gDtOX/BKcKYC0k1jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707734765; c=relaxed/simple;
	bh=+nYMQEZkmIJ94Vpk11C3LTr1OPhiRCktKU82FImmmhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyZxR+tVN11sStcEZ+YmhOGm2FwYfGr+NHIbyN62mwpnozuiaknoXODMYzRnykC72Ntu3rCbF1gaD7/7O9XExJaAa3OuUVkCGIgX0B7b9LbunGIUALesnlOiAuAUy4JcXxXEkV5oPXIaHPpo4p+J2DEfvJlMUOQgBnFGyeA6pBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m9mVvqVf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30D4C433F1;
	Mon, 12 Feb 2024 10:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707734765;
	bh=+nYMQEZkmIJ94Vpk11C3LTr1OPhiRCktKU82FImmmhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m9mVvqVfhYoQrO0RfPBRxa+cTvnblId5W41NhlEdXvPqgDE632DbR71FZGQVTqKkQ
	 PW1nvaXA9F32qoXTJhivol4ngzQGbIzj2jbbiRym6Ir/KCMyVByfvqD6KDcWXgbtfr
	 ZLTXfEt2HVGHQSgtX1jHUIMJZ4JzhNZmDlKj/PGc=
Date: Mon, 12 Feb 2024 11:46:02 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] firmware: struct bus_type cleanup
Message-ID: <2024021257-anchovy-enlighten-7a2a@gregkh>
References: <20240211-bus_cleanup-firmware2-v1-0-1851c92c7be7@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211-bus_cleanup-firmware2-v1-0-1851c92c7be7@marliere.net>

On Sun, Feb 11, 2024 at 12:51:28PM -0300, Ricardo B. Marliere wrote:
> This series is part of an effort to cleanup the users of the driver
> core, as can be seen in many recent patches authored by Greg across the
> tree (e.g. [1]).
> 
> ---
> [1]: https://lore.kernel.org/lkml/?q=f%3Agregkh%40linuxfoundation.org+s%3A%22make%22+and+s%3A%22const%22
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

