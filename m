Return-Path: <linux-kernel+bounces-118297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1225388B767
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2231F3FBC3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B93580C1F;
	Tue, 26 Mar 2024 02:25:51 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C715157314;
	Tue, 26 Mar 2024 02:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711419951; cv=none; b=iw/iC24Yf2eDmK9eJx6jfu4cWkKEAkcG9GFQIdsycd0hz5dKKdouWemmcX/w+6hm8ebBv2qFVgopYD+ws/CrmwrkkCu/eAemJb3f2upJyTn+VrEPZ7wLzrZJQTo2mc56Lockp5uOItMlT1XNL4acGIIQf6CeLe1O2M1dbIV/WcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711419951; c=relaxed/simple;
	bh=c0zXOdmY8yi3sVERCY67fR6S98nyjCfrCLzup/zFNXw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TMO5wov5foRonuwkGvWHdPo8OZjOXdPZwxB9MCTYFDrLyu4kd8vIQa3M2smKvrCYLRiP1olXDV08LGsJUMG+gIMPlTx+j5jppXu9ifoCx3lEpZJfM8tPCqhas8k0xARkUhWcliBJ3yE+FIRrwoTYMDa1Vrc4yOb8yf93xQc6HSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [192.168.2.4] (51b68717.dsl.pool.telekom.hu [::ffff:81.182.135.23])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 000000000007719D.000000006602322A.0023B604; Tue, 26 Mar 2024 03:25:46 +0100
Message-ID: <481b31f72eea83fed618e277c62fb6a12949c525.camel@irl.hu>
Subject: Re: [PATCH] uvcvideo: Remo OBSBOT quirk fix for incorrect relative
 min pan/tilt/zoom speeds
From: Gergo Koteles <soyer@irl.hu>
To: John Bauer <john@oxt.co>
Cc: johnebgood@securitylive.com,
  Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
  Mauro Carvalho Chehab <mchehab@kernel.org>,
  linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
  linh.tp.vu@gmail.com, ribalda@chromium.org
Date: Tue, 26 Mar 2024 03:25:46 +0100
In-Reply-To: <CAMB8T1ULcfBOB5VwZzUtvRnp4FvtBCFWxxTdb+OJK8FOpjKCXA@mail.gmail.com>
References: 
	<20240325-obsbot-quirk-fix-relative-ptz-speed-v1-1-0eb1387d98c7@securitylive.com>
	 <6e6b75a15cdc6a1239edc4d49b927b187ed20054.camel@irl.hu>
	 <CAMB8T1ULcfBOB5VwZzUtvRnp4FvtBCFWxxTdb+OJK8FOpjKCXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi John,

On Mon, 2024-03-25 at 20:51 -0500, John Bauer wrote:
> I understand this patch might not be the ideal or proper solution; but it=
 works. I don't think the UVC
> implementation can be trusted on these cameras, just like the Windows Dir=
ectShow implementation is off.=C2=A0
> I put this patch out there as I have encountered many Linux users who are=
 struggling to get proper=C2=A0
> control of these awesome cameras. If the patch dies here for now, that's =
OK, at least there's a possible=C2=A0
> patch for those in need.

Sorry, maybe I didn't phrase it well. Based on the UVC specs, I think
your patch is good for all UVC PTZ cameras, so you don't need to use
UVC_QUIRK_OBSBOT_MIN_SETTINGS quirk entry, just apply the quirk changes
to all cameras.

Thanks for doing this!

Regards,
Gergo



