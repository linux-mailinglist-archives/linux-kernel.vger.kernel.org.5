Return-Path: <linux-kernel+bounces-78179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C8B860FD8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90C62B21A80
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0966350B;
	Fri, 23 Feb 2024 10:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H22H0eRZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BB5171B8
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 10:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708685567; cv=none; b=tmgcVLiyfpHuUGQGHbvOVRjoP4Y61Jd/RgY2Pg9DtsHxWvLiV+cpjXQZrdUqiScYVzCGSY8IrZdsr6bStryktRtGj7MWFW8U4yWpWtZ5L+GolK37e2vQZ0mbBNh4Brx5kc5actL9anOp+S/BmakvUS09x+/5RbZlMYhrD9pMQq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708685567; c=relaxed/simple;
	bh=vaAM/oH2u2SDnBrjcpBhaiEavbJieS9sVTjGejK57O8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dswsB8VaEaxeh/r7wma56RwZuTDl2HyrMSjNAQsCkFbUbKWLP3A/weDvICK3lpTciM8WAVRNoq+GVLJ/YGgYYZA5MeHIQYMilZ9RB8n/RteykJADPcvZZPA/oMA3Pmz3+o19eUMKPkQLX6AdJUx7ZLdwwdciY2E4vZqoZWQnLDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H22H0eRZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2E8C433C7;
	Fri, 23 Feb 2024 10:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708685566;
	bh=vaAM/oH2u2SDnBrjcpBhaiEavbJieS9sVTjGejK57O8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H22H0eRZPn8eseckjuxnK4C9dKbuhmHOzMoRIGeCZJ7ZqGz4jVYAs2N7b/2Ua9oll
	 SH+N1APPNwt5Q39KSon+mMYVrB4xbchNQh2AgrsN8TTTpVqKg5Ymke2lAOOeu9mmEw
	 UESpKD/t/bwZFZ6vpv4Fnbuxe78LgwuV36mZxUMbtIsvDHCrSMJXW1ownd8gGi3qdx
	 Itr4og/I6nEDV5FhlVMbxgjT1wtcjg32UXWdmaK5bXXti/Ma971gNZySmIB3OfOKLi
	 anIjUZqbJ7a2A1QUypJlUWtQTFmXrFMS4HcxWZGF85Ho4bVnCNvcrenGx47K1uil7R
	 +u3mu8poOSTbQ==
Date: Fri, 23 Feb 2024 10:52:42 +0000
From: Lee Jones <lee@kernel.org>
To: Michael Brunner <michael.brunner@kontron.com>
Cc: "linux@roeck-us.net" <linux@roeck-us.net>,
	"mibru@gmx.de" <mibru@gmx.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: kempld-core: don't replace resources provided by
 ACPI
Message-ID: <20240223105242.GR10170@google.com>
References: <09855448430a5f090dbe09cbb269959a08881ee7.camel@kontron.com>
 <8ec638c2-93b6-48e4-8ac4-965072b1d5af@roeck-us.net>
 <de6bc09c779a4b4fa2ddaa1fa3a595de323b7f5a.camel@kontron.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de6bc09c779a4b4fa2ddaa1fa3a595de323b7f5a.camel@kontron.com>

On Wed, 21 Feb 2024, Michael Brunner wrote:

> Added Lee Jones again, as I erroneously used an old eMail address in
> my original mail.

I can't take/review patches like this.

Please [RESEND].

-- 
Lee Jones [李琼斯]

