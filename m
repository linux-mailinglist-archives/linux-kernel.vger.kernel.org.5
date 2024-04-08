Return-Path: <linux-kernel+bounces-135089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 798DD89BAFF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18CD61F2288D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37933A267;
	Mon,  8 Apr 2024 08:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="dC8TND7a"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7813D964;
	Mon,  8 Apr 2024 08:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712566590; cv=none; b=uKS5eyJXhm/Ln4buSdAcAKiM/FxkrtdABIjt3m15DQvPQWxsutwNwWvLaRlZwkRrAl5MQzYKybf7vZLRsv4UmpYheN38Jpdml2mR+3XaaY2t1KGnzbdUNX3DCTAlPjfFBfsgJ/EDnHwrcu7pt8/rT2RG1iwsJNZAp8yFqFF17vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712566590; c=relaxed/simple;
	bh=qzK+0wT9Cyf1NitkqrySMGpyo8anNQHWIeU6cKIpYWY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RLAPSvIYso7OxUQJIZtbNcmMzQO992KZaLzKrxQZ2WuJz7P0cuDNt9SN3cIe+cHvKkMissS3yWRlj9bo7sXKb54iLiSqNjpO7XzTX4GW9tr92xArwVrnDd8DYLztHn3bFFX80MJzUNGpkVcTpcpHZonEkAcPXiEciZgUTnPaBbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=dC8TND7a; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=qzK+0wT9Cyf1NitkqrySMGpyo8anNQHWIeU6cKIpYWY=; b=dC8TND7agfDyNYALvE97sUKUio
	LEBwCQM2OmTmz54MJ5kWzG6Dej7Q8WFmAE/WabcvYrjSyCWxiOMs3VMccEYEsDtFG0ad3fm971gYq
	VNPrkXCZYr30YxsDDqoMgfra5jQ3aq2bwt2FFE7LKJDacliBtpSRjQeXQqOAECWQaDUm/7PVyZJq5
	skPZiFu9BhLMOIdq6Er+Q7mc7pgRikOrvNUK1qrFgX9nMttGNAc8tVN7MKD2n3j0sFqM/mkVFPYIO
	OXVp6pSA0GXy+XfRnhoHNFpKpVoR5lX6n6KAvLyIdnVZY8ozLfLbTcnpstTEeHopPW5EXzwSQIjQj
	N9ikHv6Q==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1rtknZ-0007O7-Ml; Mon, 08 Apr 2024 10:56:17 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <esben@geanix.com>)
	id 1rtknY-000H9m-SJ; Mon, 08 Apr 2024 10:56:16 +0200
From: Esben Haabendal <esben@geanix.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  Jiri Slaby
 <jirislaby@kernel.org>,  Shawn Guo <shawnguo@kernel.org>,  Sascha Hauer
 <s.hauer@pengutronix.de>,  Pengutronix Kernel Team
 <kernel@pengutronix.de>,  Marc Kleine-Budde <mkl@pengutronix.de>,
  linux-kernel@vger.kernel.org,  linux-serial@vger.kernel.org,
  imx@lists.linux.dev,  linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] serial: imx: Introduce timeout when waiting on
 transmitter empty
In-Reply-To: <CAOMZO5Axz7un+9H2uEoQtE0=pYNC0hEyZiNobrSi2m0ajj8N+g@mail.gmail.com>
	(Fabio Estevam's message of "Fri, 5 Apr 2024 14:38:48 -0300")
References: <76cf9ce9cbf9dcdf78bc00ce7a919db1776ebce1.1712309058.git.esben@geanix.com>
	<CAOMZO5Axz7un+9H2uEoQtE0=pYNC0hEyZiNobrSi2m0ajj8N+g@mail.gmail.com>
Date: Mon, 08 Apr 2024 10:56:16 +0200
Message-ID: <87ttkckzbj.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27239/Mon Apr  8 10:26:06 2024)

Fabio Estevam <festevam@gmail.com> writes:

> On Fri, Apr 5, 2024 at 6:25=E2=80=AFAM Esben Haabendal <esben@geanix.com>=
 wrote:
>>
>> By waiting at most 1 second for USR2_TXDC to be set, we avoid a potentit=
al
>
> s/potentital/potential

Thanks, fixing.

> Could you elaborate on this deadlock? Have you seen it in practice?

I cannot say for sure if I have seen it. But in some cases, that is
exactly what you would see. Nothing.

If it would occur during shutdown, the console would simply stop/block,
and you would see nothing.

> Should a Fixes tag be added?

Which commit should I add to that tag? The polling without timeout dates
back to at least 2.6.12-rc2.

/Esben

