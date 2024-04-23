Return-Path: <linux-kernel+bounces-154985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC1A8AE3E9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 189011C2224E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC4E7E59F;
	Tue, 23 Apr 2024 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="r0NCNhX1"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ECB77F2D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871810; cv=none; b=uV4VRgPcvG2OgkhCh0mWGlGa3Wk0JshOLBWd1x5vcymru9Tybayw7ChoLPGibD/jpVxYD8+U3wPI4smCinFlcSf4cfa0yioZfYyZ44j7PqfuQTxzGASEIFiC9HuHZUwP3XnYYFj6RFAKMAj9+dgYwbQ+KHnTKw7ZX34C51/VeEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871810; c=relaxed/simple;
	bh=wdLaAi/HXNFJUa/Vn86wUdeVGT8NCDKEn69CFwiXFwM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YXnUpwDiS+tKIXBuRK/qXgQP8Trva9rV2W1WNc3nktSZkwiZVWMrvIjbx0U4qZpwpMP2gQro3TFzbErVVWqSsAyC7BMA/1Tql2wPuTXtHegWMln0d7ibIXtqcqqX+5YEFV4reqP2CIvbjw9HxtNprvqPa4TsFNm7rugkMLla+AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=r0NCNhX1; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=wdLaAi/HXNFJUa/Vn86wUdeVGT8NCDKEn69CFwiXFwM=;
	t=1713871808; x=1715081408; b=r0NCNhX1VWKIzYXzk4kBnOqXfU//FFeXQwjhUqj5FS414Xs
	BoIDl4H5DqubRXqlrWNrGzBhh32mKV2lT0aSq4PuV9oUiUjbTyjL3uidd7AB+PHZ3WSql5S++qSeY
	OE83H37GQYSn0Z/O3dg1WfiqCy96/iE3QcNvTn1NHSQ4j5wXlOIgTFw0z/UtM4nFQm65KQU5gLOFS
	1gNj+YD5PVJM9xM/NgW7Eap23q5bV1vEeM9XB30NPJm3O5gojMhYYQo9+dLgeilCMOeiEYfS4UOwX
	stRee3KeO1EEmyAMpSx5CtFN2KlbX0OnfRvx1Pv9LF+N2xUTvsavlVWpZ8+V8yPg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rzELb-000000025yu-2KUq;
	Tue, 23 Apr 2024 13:30:03 +0200
Message-ID: <f175a7b540ffd6764aa68ae021c19920aa6d4f5a.camel@sipsolutions.net>
Subject: Re: [PATCH 3/7] um: Fix the -Wmissing-prototypes warning for
 get_thread_reg
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.btw@antgroup.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 23 Apr 2024 13:30:01 +0200
In-Reply-To: <20240423112457.2409319-4-tiwei.btw@antgroup.com>
References: <20240423112457.2409319-1-tiwei.btw@antgroup.com>
	 <20240423112457.2409319-4-tiwei.btw@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-04-23 at 19:24 +0800, Tiwei Bie wrote:
>=20
> +extern unsigned long get_thread_reg(int reg, jmp_buf *buf);
>=20

Like, in general :)

johannes

