Return-Path: <linux-kernel+bounces-57379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9481D84D7AC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 02:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CA6A28712D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFFB1CD25;
	Thu,  8 Feb 2024 01:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bluemarch.art header.i=@bluemarch.art header.b="JEzVx4iq"
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC19E14AB2
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 01:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707357392; cv=none; b=DZL2BBx7JC8ZTG5kXjEE7k0OmhwAbzvTwK9TEbb/1JP06Tn97aPDWxsePmKf/d0JkbCGjqhjrVQvEo5NDNiB+iwvKZGWEQb8kqrKmFj3N0F4uP0RryHtvKIL3AC3xBVmY7DeRsvs+9k7WSOW3luIrJ4vLHOwovrGwDdxL0H4MMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707357392; c=relaxed/simple;
	bh=HwFBxc5UHj6IfzmWRFjPq4XAbavJWNBFqvw1INO0bvc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hBlJBZbAQv3vCfYMhkxQ8EK6tChNehHkSrJzY0gm7x0XFWh47rwuaWFPwBVNrTTvMvhKUEhE1G9VENJoCzb2eXIzYqh0X8BDlnoOVJUWjBukNdOTRXw4b6B34C2u2PaJo7dZWtNhS/sy88dIP1pgLhWRTiyO0oH9jF4lrsILSGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bluemarch.art; spf=pass smtp.mailfrom=bluemarch.art; dkim=pass (2048-bit key) header.d=bluemarch.art header.i=@bluemarch.art header.b=JEzVx4iq; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bluemarch.art
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bluemarch.art
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bluemarch.art;
	s=protonmail; t=1707357381; x=1707616581;
	bh=HwFBxc5UHj6IfzmWRFjPq4XAbavJWNBFqvw1INO0bvc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=JEzVx4iq+2BnQZAvSvV2pNdke4zXasesAesXf+czKv9qS26c2+UHFSSA5GxKPbyx5
	 cspCI/72wA3xnJYL0PWmZhNDcRsvnzL0jHO/evn2zN8cHxq+EtVYMXAJrtOSIrUDdS
	 r/X3s9KfuDXurX2pYgS7DkeP5qEn7xBUlx03NXxwnVhm+b/u6sGju133hiLZZ3MtAX
	 IDQNo8t38wPb3nlNKErHpeAdMMjC9uxKDltSYvbHsQOEXoO+j1jVWTI0e8hh3bcgWr
	 /JdRXuVFvmMo+b97hVFz8asFt7Z/jNhQpWk2IAZko1b2VDbts/MxgZeWOYb6Vg58AC
	 EENI5kifhXpVA==
Date: Thu, 08 Feb 2024 01:56:04 +0000
To: Hans de Goede <hdegoede@redhat.com>
From: Szilard Fabian <szfabian@bluemarch.art>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, jwoithe@just42.net, ilpo.jarvinen@linux.intel.com, W_Armin@gmx.de, Jelle van der Waa <jelle@vdwaa.nl>
Subject: Re: [RFC PATCH v3] platform/x86/fujitsu-laptop: Add battery charge control support
Message-ID: <ZcQ0qGEuHOSoLC8R@N>
In-Reply-To: <e305a170-362d-48bb-a742-f4c8f010b2c7@redhat.com>
References: <20240129163502.161409-2-szfabian@bluemarch.art> <20240129175714.164326-2-szfabian@bluemarch.art> <20240207023031.56805-2-szfabian@bluemarch.art> <e305a170-362d-48bb-a742-f4c8f010b2c7@redhat.com>
Feedback-ID: 87830438:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 07, 2024 at 09:57:21AM +0100, Hans de Goede wrote:
> Thank you for your patch. Do you happen to know if there also
> is a noticeable fixed start threshold which is like say always 5%
> lower then then end threshold ?
There is a start threshold, it's always 11% lower than the end threshold.
I don't know yet if it's a fixed value or if there is a way to set it to a
different value. If I find something usable about that I'm more than willin=
g
to create an another patch.

Regards,
Szilard



