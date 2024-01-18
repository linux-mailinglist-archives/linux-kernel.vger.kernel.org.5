Return-Path: <linux-kernel+bounces-29970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0B6831601
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0C472881C0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D191F60B;
	Thu, 18 Jan 2024 09:42:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D9F1A279
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 09:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705570941; cv=none; b=r1j+WLO7EuqyGYADAv01Jjoh+TIxYtAdFNvWMOtqDZLFTUdQvS8wkDfvzAhXYTnEey14kOqSzKGZ7AiUaq6VWItF+6YTyIuSVQTuYixrylTsURbti2JribIvg9v6bxOY/UnMQ5kmCewlsZ6cTZKWpHmAd0R+4jEHSxvuThUQVT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705570941; c=relaxed/simple;
	bh=r8plYihb9laS5d5T4pemVhe8YrP40NGTCHr5Tf+g4LI=;
	h=Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=I93Jzxo1P28Y8c1r/Ynz8dVngahLd5/KKqTRxGHY0jR41uhILYgGTzeQGKMOCkTRhvQeRrKTXjeE4j7Sa4Q7TKLSih4lRPmxSuY+ij9mNl8OMIi2LR5PjUXGD2nhEOF3VosVKV9NVZDh9rlLZqInIcm1zb8HC/xAzmj+kxWLXp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 866F51042;
	Thu, 18 Jan 2024 01:43:04 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7E003F5A1;
	Thu, 18 Jan 2024 01:42:16 -0800 (PST)
Date: Thu, 18 Jan 2024 09:42:14 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	gregkh@linuxfoundation.org, rafael@kernel.org,
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com,
	ionela.voinescu@arm.com, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [Resend PATCH] topology: Set capacity_freq_ref in all cases
Message-ID: <ZajydrrHmErhS_qp@bogus>
References: <20240117190545.596057-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117190545.596057-1-vincent.guittot@linaro.org>

On Wed, Jan 17, 2024 at 08:05:45PM +0100, Vincent Guittot wrote:
> If "capacity-dmips-mhz" is not set, raw_capacity is null and we skip the
> normalization step which includes setting per_cpu capacity_freq_ref.
> Always register the notifier but skip the capacity normalization if
> raw_capacity is null.
>

LGTM,

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep

