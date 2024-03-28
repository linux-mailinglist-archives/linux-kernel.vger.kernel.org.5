Return-Path: <linux-kernel+bounces-123147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F50F8902FA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEE6F295432
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9878122086;
	Thu, 28 Mar 2024 15:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBQES8Ag"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D7142061;
	Thu, 28 Mar 2024 15:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711639408; cv=none; b=s9JYj6G5pBSTQ5gYonwB4+WcFL5458gByx1rxH7notqn6AiRkt2zwPkXfQ2/8Ph/39IalWNt63H0XzF7LDK3UTb3z0vJijLbX/7aj/Izj+mIXhX18bMv39dV8sUXE7CL8JMrOawT8KDKav2XKHl4t57EoRxRcjthEqUdpwCaP50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711639408; c=relaxed/simple;
	bh=dnSbevCgnnrvCsW1rdcQnYaE9brbk1uzpAjP/6V2omQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+efKnXp7GBqUCzi1CiAxF3XmAbOgWoz5W8uONQtoxhZnhim8gMgZDQLCfV6Xv9ndVEXD/82e1+FnQ0uevVKjLzpyXOs/A7X6N/dMQhPVmhA6TgEBn0NGUKHh0dpVL/hJBgRuKXKdDSqeG/mdWReMn9ABdg3q0S5MfpsufihViI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBQES8Ag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE24C43390;
	Thu, 28 Mar 2024 15:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711639408;
	bh=dnSbevCgnnrvCsW1rdcQnYaE9brbk1uzpAjP/6V2omQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RBQES8Ag/ugJEbXDoX5YOjZ2oB9uXUu4qWwhAWnWPsG02Xs4pBbyL2tnNgPa0oYi3
	 pMqphA6zt0Ib3h65a2kIjWjdPJrL2dXPsbhO1fG26gbk/MT+fTp8H8FNwj/hyzsJCV
	 YFcixzykwxEEk54AUCppxgeDpRo4PHgzCXlsSlxQ2RO5X+kFUVcZ4WN7y6tekm6bND
	 Vtts8x0fRtlZITqtByAHEmoB/Sj1AqBx0IwsPInF20ruhlu1SX+uy1pfRklpULHN53
	 2n65O7FEXefD5MQxdzoiBow9kC9CqAUAHO4fLWidFfiDSOsJzI+26SuD0jNbYulRFe
	 d5SE5aOFsWvzg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rprbO-000000007oC-0ruF;
	Thu, 28 Mar 2024 16:23:38 +0100
Date: Thu, 28 Mar 2024 16:23:38 +0100
From: Johan Hovold <johan@kernel.org>
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: patchwork-bot+bluetooth@kernel.org,
	Johan Hovold <johan+linaro@kernel.org>, luiz.dentz@gmail.com,
	marcel@holtmann.org, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	quic_mohamull@quicinc.com, quic_hbandi@quicinc.com
Subject: Re: [PATCH] Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode
 exists in DT"
Message-ID: <ZgWLeo5KSLurLDhK@hovoldconsulting.com>
References: <20240314084412.1127-1-johan+linaro@kernel.org>
 <171146704035.9961.13096206001570615153.git-patchwork-notify@kernel.org>
 <124a7d54-5a18-4be7-9a76-a12017f6cce5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <124a7d54-5a18-4be7-9a76-a12017f6cce5@quicinc.com>

[ Please wrap your emails at 72 columns or so. ]

On Thu, Mar 28, 2024 at 08:25:16PM +0530, Janaki Ramaiah Thota wrote:
> We made this change to configure the device which supports persistent
> memory for the BD-Address

Can you say something more about which devices support persistent
storage for the address? Is that all or just some of the chip variants?

> So to make device functional in both scenarios we are adding a new
> property in dts file to distinguish persistent and non-persistent
> support of BD Address and set HCI_QUIRK_USE_BDADDR_PROPERTY bit
> accordingly

Depending on the answer to my questions above, you may be able to infer
this from the compatible string and/or you can read out the address from
the device and only set the quirk if it's set to the default address.

You should not need to add a new property for this.

Johan

