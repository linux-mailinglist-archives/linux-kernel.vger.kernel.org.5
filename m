Return-Path: <linux-kernel+bounces-131569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52279898999
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80CEA1C28C2A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8628012AAD6;
	Thu,  4 Apr 2024 14:08:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930CB1292DD
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712239709; cv=none; b=VPsysFQOiOH2HIhN9kxDM+gtGEkGE/CCDFbsMWEymxIrlRuftDFXEdeqqZcbys/53VBByCCkD6IvSXXOrKLG0F9Qbo75n+2ybmDSg4EaydCj/SaF8vOq1rXX3Dr1tY3yQlDNb8JdJnOhyVv1TUQ28t4N/3JmPq2P8+iY+ua8Zxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712239709; c=relaxed/simple;
	bh=DyhrdHYhXcaAjkORyJRa34tlH5CBJT+guu7FIYUWF9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=soxlKWKWT8SGmnzHgMZNn5xCQ62ZQ/QZVS8qTmSv0kLEwBCa5OSX7fHuqRLx8eXXlMADSddt9qb0zrTqwRRgxJ27XNTdAHC1iscEE1OWHZw0Ax1FlzujUMiY6WPAX6YM0NZWEkjrSjO+cK7X31zQiAAsDUqdgIzLlktgUaGKxjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A8701007;
	Thu,  4 Apr 2024 07:08:57 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F27C53F64C;
	Thu,  4 Apr 2024 07:08:25 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: cristian.marussi@arm.com,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2] firmware: arm_scmi: perf: print domain name in error path
Date: Thu,  4 Apr 2024 15:08:15 +0100
Message-ID: <171223963239.451081.2315537108604651714.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240322080531.3365016-1-peng.fan@oss.nxp.com>
References: <20240322080531.3365016-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 22 Mar 2024 16:05:31 +0800, Peng Fan (OSS) wrote:
> It would be easier to locate the problem if domain name is printed out.
>

Applied to sudeep.holla/linux (for-next/scmi/updates), thanks!

[1/1] firmware: arm_scmi: perf: print domain name in error path
      https://git.kernel.org/sudeep.holla/c/42a31d4410a8
--
Regards,
Sudeep


