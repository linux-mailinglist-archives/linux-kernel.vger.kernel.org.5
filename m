Return-Path: <linux-kernel+bounces-76016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A7A85F1FA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EBF01C22D4C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5169E1799C;
	Thu, 22 Feb 2024 07:38:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AF379EA
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 07:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708587500; cv=none; b=T5D8nGQAA1kxeB8hJJxJU4OKK+LjSGElrrhlbsRW11Yi0EULMvNOSzz4YDj9Pc00p7Xpui9lefvneDpTD6AG4KyXzOC1Z0iuuuyCAy9lI8WIQfXaOKiNX49cr/Ej6oz5LN/S4VVGyRCQt3yxx1jslQ0O4D30LUDYekamhUhmBuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708587500; c=relaxed/simple;
	bh=FSEIn7TKL0cw+Qnh47yGxDvJNkCX9bok7fIoj/Dliuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ht9P+bQ0zSsCDiDfGhe2mOeDwZOyJZWMlGhymeeCmum4a/Z0KqmQqs7KFeHdOluMjo0vvCKztKjYW85ER//Q07QQhAZqLroaN0QzQARZDUjojIkCj+gIz2CBIZipjXAepLjuhqU+ZkVcaHsif4JthGidEeA5yUi18YM8s7R+n/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1CCF1007;
	Wed, 21 Feb 2024 23:38:55 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AF2423F762;
	Wed, 21 Feb 2024 23:38:16 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>,
	"Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/2] firmware: struct bus_type cleanup
Date: Thu, 22 Feb 2024 07:38:10 +0000
Message-ID: <170858556491.105647.13334595992310350270.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240211-bus_cleanup-firmware2-v1-0-1851c92c7be7@marliere.net>
References: <20240211-bus_cleanup-firmware2-v1-0-1851c92c7be7@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 11 Feb 2024 12:51:28 -0300, Ricardo B. Marliere wrote:
> This series is part of an effort to cleanup the users of the driver
> core, as can be seen in many recent patches authored by Greg across the
> tree (e.g. [1]).
> 

Applied to sudeep.holla/linux (for-next/ffa/updates), thanks!

[1/2] firmware: arm_ffa: Make ffa_bus_type const
      https://git.kernel.org/sudeep.holla/c/989e8661dc45
--
Regards,
Sudeep


