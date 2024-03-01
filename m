Return-Path: <linux-kernel+bounces-88404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E11886E127
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE8EBB21917
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4302B20300;
	Fri,  1 Mar 2024 12:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="VM8yigu6"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90631115;
	Fri,  1 Mar 2024 12:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709296713; cv=none; b=dpawXOwzZ11esxZpZmN47ogh9eh3Jtd1Gy6O/gxUZAPKfnUKer6OFanwG3F8PvYxqAMVKO/28RZ+RG1Q+BpgHQa9pAf+68ONb+w1XPza04yRifWCE3dsOPtn0TtMThIXtlENdzmqQX2H665/HxQO234+l2V53XoEbWbnCuNRmKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709296713; c=relaxed/simple;
	bh=k7ZiguaZn6PywZYcKou0alZk50KA2KL+x67ceZzn0CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DKZz9d4iHmD5NYAS3//RRKTmB4ubry11qXayxUsVLYdNVBgNhzV5Tu5hnWxyMIKTyQ+dAvf98+eUd51+Vvc7VrTzRgLHN0dJvzyfRqT4HHJ3n5lsJQAWsXblC3FrROX6NYOhtzKzM4PqxZMpsB2gg7ro7pkCf9IaHoSU5eit0T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=VM8yigu6; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2VM4RvJF86wopAaCWqrnTL3rOiakzAcmW35hjIBnFAI=; b=VM8yigu6wthcDhYiDojLhYTXiP
	7Vlrl8+Edl7+S198TnYbF1AYc6zj+qCSpQQTdhkCLUIHMoBH2PYVNpCc8fkZq7WTQBbERR5HJiX51
	h7STmkAeIYay4HRfpKd0iYwdO9OpJIl5HLTKewJkkCJdqKeW6m8hgGnQFOxIYQgjI00NBI1wmHP/r
	drhIbrcX7h6keovhc+dJTiUUrhPH2LU5Ey5MlUbMZpl3j0Uo/uH7gIZPZFnINIjUp/jTuVQ+ns+7g
	DhaxzkS8R7VNvA5BKk595ISjEijcy1LEpi2h25kl9T7zn5QFgAzNidXTsC3sXTAMfykQqQatkZA+Z
	p7mGvg+Q==;
Received: from p200301077700b1001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7700:b100:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andreas@kemnade.info>)
	id 1rg29U-009vV7-3t; Fri, 01 Mar 2024 13:38:12 +0100
Date: Fri, 1 Mar 2024 13:38:09 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Roger Quadros <rogerq@kernel.org>
Cc: "Brock.Zheng" <yzheng@techyauld.com>, Tony Lindgren <tony@atomide.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memory: omap-gpmc: fixup wrongly hierarchy of the
 sub-devices
Message-ID: <20240301133809.0d26865e@aktux>
In-Reply-To: <f45b3195-38a9-4c49-b873-01e5a0b275a3@kernel.org>
References: <6fftq2zlkpaf7xptyff6ky63cinr76ziyvdbm5jhj2apubr5vf@l4gvbdax3l2e>
	<f45b3195-38a9-4c49-b873-01e5a0b275a3@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On Fri, 1 Mar 2024 13:22:12 +0200
Roger Quadros <rogerq@kernel.org> wrote:

> Hi,
> 
> Thanks for the patch but can you please re-send the patch in plain text format?
> Please refer to this article for more details.
> 
> https://subspace.kernel.org/etiquette.html
> 
for my own education, can you specify against what the patch excactly offends?
I see no html there and

Content-Type: text/plain; charset=gb2312

So what do you consider not "plain" in that email?

Regards,
Andreas

