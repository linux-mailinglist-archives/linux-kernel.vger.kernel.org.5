Return-Path: <linux-kernel+bounces-54498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C929E84B002
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 557571F2597A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD3A12B163;
	Tue,  6 Feb 2024 08:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="lYpWmurC"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE892C877;
	Tue,  6 Feb 2024 08:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707208484; cv=none; b=Sdd8IMqGN3V0jaVI2bY9zOjDlvi9tz5MewuA9pFSxayzMUd7qiCQyId1TMPQTNvx/RDYOdykpU4IzantmjzbuqHXywKiOgiFRHH2SA6IwspnBM0mD5TQWSeJ2fZPiXxT/21zmJOJgrvUIVp64U5C/6caI4eO8WkhoCfJyK9GLeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707208484; c=relaxed/simple;
	bh=Z2mwNLm1V8FlR00nmF3zbnb4bZ7trrAYANe+rIXrX8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOgO3SY78Ycc7WIpMPZclO8z9llZAqPBpt3OPQrtCB3rk6qNCAEgE1uVKliH+Ylw/HV+fIIbufSHSGPwsAIpv0Z9nA5dmxm+l1vYxgaZglHe3xHOl8Jy2AfNQA6EIaOiPR3Asl/c11cgMGl3e1+fhYdszDzxXmyHsoAl4AUhLIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=lYpWmurC; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 5605560372;
	Tue,  6 Feb 2024 08:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1707208476;
	bh=Z2mwNLm1V8FlR00nmF3zbnb4bZ7trrAYANe+rIXrX8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lYpWmurC7xgUhLnvkqYDZtNWTEWv8TJdZgVrq96lA7NpuSvInAh3RVo7s10VgW+6i
	 JgDMYQf4ya5c97mOpKUYXqbSKnTIneYPILPyQSRYWoKQYbqwD6Vbh0y2YLeOTQe2fR
	 worb6xDW/zTmxajnqJ1fBDi1e9Hp5FZfd08/fzKnT+wf1jZbRlMSocsIpBEzpIXqXD
	 wnTwhWTNlk4DCnEXsWZfTUhpIY0CnqnXSVdslOnx26ZYTXa+xNrpfV2sUH3mUhn4MS
	 abVhX3Y3S40QjUyPt62LgW+737Z8RdOFyv06UHeKGr4Ig1J60623CHFmUlnjD1GomA
	 YV6CfVYQ0eejA==
Date: Tue, 6 Feb 2024 10:34:07 +0200
From: Tony Lindgren <tony@atomide.com>
To: Yicong Yang <yangyicong@huawei.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	john.ogness@linutronix.de, andriy.shevchenko@linux.intel.com,
	tglx@linutronix.de, yangyicong@hisilicon.com, linuxarm@huawei.com,
	prime.zeng@hisilicon.com, jonathan.cameron@huawei.com,
	fanghao11@huawei.com
Subject: Re: [PATCH v2] serial: port: Don't suspend if the port is still busy
Message-ID: <20240206083407.GG5185@atomide.com>
References: <20240206073322.5560-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206073322.5560-1-yangyicong@huawei.com>

* Yicong Yang <yangyicong@huawei.com> [240206 09:37]:
> Change since v1:
> - Use port lock wrapper per John
> - Flush the pending chars and return -EBUSY per Tony.

Looks good to me thanks:

Reviewed-by: Tony Lindgren <tony@atomide.com>

