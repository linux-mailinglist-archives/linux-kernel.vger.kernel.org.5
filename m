Return-Path: <linux-kernel+bounces-119551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE8688CA5C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FAB91F82AB8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F871CD30;
	Tue, 26 Mar 2024 17:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOMBDpkx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CC51BC30;
	Tue, 26 Mar 2024 17:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472873; cv=none; b=P1D7L3av1sRDgqAiV2/lEQBkL0FrWrAjOyRl+eY4Y1LWh3tXoEZrVRkpc7MLOujdAH91h3wecgJzAgUzra8TjKaES/XgBV2yNcX9cxQ2lUPLYntba/rqsayjOI4w2cvDHMpCulEDOxvIkfTOn39tHYbvsAqUoLeX3eboo9ZGvso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472873; c=relaxed/simple;
	bh=apTnrnce0SUkwLXn+Zd0KKmK+W2FLOA6q7nRFX2NOCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxswqI5R4Bs3XMRmDrYdFagyr1LG2B+ASbgXWWInW6ewnE56d8AhgJqarYU6CRsKSI9CN28YVY4z6w0VP0N3bOPBAKV1QGs/nrghYWBeZwPP7GmMHcWVFiWp+23AzRpRzMgkvU3JQJe88LmhcqSRllKG5LPV3kG0NVueTFTsLv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOMBDpkx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C52C433C7;
	Tue, 26 Mar 2024 17:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711472872;
	bh=apTnrnce0SUkwLXn+Zd0KKmK+W2FLOA6q7nRFX2NOCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HOMBDpkx2VhmMjbiHfu/i/5327cpKQV8Q9JdMMFnm7NH4GySlKkSMl1L03sElfHoE
	 GkvhGU9usasbKxfLBA5El69ZtgPf7mDqqy/5PqJuy3Vnaga8HWX+vopcyEPfSZhF0/
	 CrVYWvy/G+sW3bVBmnaqgcrsgQSqYcHasKu4SW7VmaQBbcyQMsiVb8i1ibCey4Kk8f
	 IVb8ZR39fivzgh0oRLM077T2kVeI4ZhuWx5mKkW1c7IakJjkQ1dWt+fjTRxNOa8tfm
	 yDP6MR2/VWkbRbXnJyjRwzSMj0a+u+9qeOh+EL8qXpieCPXPh5Q4U/uFVmxV0kXsBZ
	 HXUzg8rt0lZcg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rpAHJ-000000006pz-0gDZ;
	Tue, 26 Mar 2024 18:08:01 +0100
Date: Tue, 26 Mar 2024 18:08:01 +0100
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
	Johan Hovold <johan+linaro@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Subject: Re: [PATCH] Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode
 exists in DT"
Message-ID: <ZgMA8WdRVeOjbxun@hovoldconsulting.com>
References: <CABBYNZJaXUhu1A+NyVT-TAJw49zcV6TMdGeVy2F+AVKWBOVC-g@mail.gmail.com>
 <ZgHVFjAZ1uqEiUa2@hovoldconsulting.com>
 <CABBYNZJUVhNKVD=s+=eYJ1q+j1W8rVSRqM4bKPbxT=TKrnZdoQ@mail.gmail.com>
 <ZgHbPo57UKUxK7G8@hovoldconsulting.com>
 <CABBYNZJFzDaLdXsdNEP1384JaJEN5E78cgmWfOus_LGOREGsWA@mail.gmail.com>
 <ZgJ0okobGv5nPreG@hovoldconsulting.com>
 <CABBYNZKJJuPHEwyXFRi8Z=P0GyaY-HdamsxmV8sR+R97ETTmEg@mail.gmail.com>
 <ZgLnOHiCzo5AQzra@hovoldconsulting.com>
 <ZgL10ur0825LgWVK@hovoldconsulting.com>
 <CABBYNZ+1vXi51YbcfqaHTwW+z7OL=yDCuab6X8eDB-q+CoO+7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZ+1vXi51YbcfqaHTwW+z7OL=yDCuab6X8eDB-q+CoO+7w@mail.gmail.com>

On Tue, Mar 26, 2024 at 12:58:12PM -0400, Luiz Augusto von Dentz wrote:
> On Tue, Mar 26, 2024 at 12:20 PM Johan Hovold <johan@kernel.org> wrote:

> > Did I understand you correctly that you'll be able to get all five
> > commits into 6.9 during this development cycle (e.g. 6.9-rc2)?
> 
> Yep, I will be preparing a pull-request with them later this week,
> there are some other fixes that I want to get in as well.

Perfect, thanks!

Johan

