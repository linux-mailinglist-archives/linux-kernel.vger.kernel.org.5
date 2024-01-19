Return-Path: <linux-kernel+bounces-31214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A18832AAB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75D10B240D8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5D452F8C;
	Fri, 19 Jan 2024 13:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="judiT5ws"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A973D524A8;
	Fri, 19 Jan 2024 13:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705671797; cv=none; b=jj6/XOvaAcGP8mnqYTnB1PDLjogJVX94jgTeDrHpz5QscrB578BEHeQ/t528PzVq2kEQ3d6ElTE2Zuja0AzpjrnZn9/lHz6KCEl/p1JiKgC2gWFJzLXWM5xab9njwVoTv5LUZ+g7FVkFd8q0soDjocAcKPK2rGys32mykm4PJCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705671797; c=relaxed/simple;
	bh=fHnQTGtIou/sS3njhF57F/qobMTpJROBdNwcGqxMbA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSkUA5wP5FTCwuutUgavZgsZgwo2qSLBmCt3Wliz3MSOG+uta3r4RWGTE7DWD7mecvVoixzNx3ydQIDqAnm/5X6wi2vBjLr1qgHNxf9cQqGgsPbV9HHgeXHriaNEjbWH+b/F9EUBp3R0tfBtQPHugQPGWgw/I84YctGdbXqZvH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=judiT5ws; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qcazD5k91TvVsRHS5wae0pStlAbdELEQKCdTVo0NwSk=; b=judiT5wsjEzh6HaqJcbIiGRRI8
	TdbVtvYiY7zvqew5toBvWvObp/Qy/K0hcTpc2nrPvJmIMHfeqiqflm5cSyg3PNmOICBTh4pg59Hxi
	98pYraGnm8F+ItDgy0kBV5DsTs57zuMv6cHR77RLxEVj1wv+8nh5uhjnEaGeLmPckVxc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rQp9I-005Yt9-1o; Fri, 19 Jan 2024 14:43:08 +0100
Date: Fri, 19 Jan 2024 14:43:08 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v3] soc: qcom: aoss: Add debugfs interface for sending
 messages
Message-ID: <de9ca78f-0d4c-4793-a21e-5d5f8dc6eacc@lunn.ch>
References: <20240117-qcom-aoss-debugfs-v2-v3-1-1aa779124822@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117-qcom-aoss-debugfs-v2-v3-1-1aa779124822@quicinc.com>

> +static void qmp_debugfs_create(struct qmp *qmp)
> +{
> +	const struct qmp_debugfs_entry *entry;
> +	int i;
> +
> +	qmp->debugfs_root = debugfs_create_dir("qcom_aoss", NULL);
> +
> +	for (i = 0; i < ARRAY_SIZE(qmp->debugfs_files); i++) {
> +		entry = &qmp_debugfs_entries[i];
> +
> +		qmp->debugfs_files[i] = debugfs_create_file(entry->name, 0220,

group write? Generally you only want root able to do writes.

However, thanks for reworking this to just support some well defined
commands, rather than binary blobs from user space.

      Andrew

