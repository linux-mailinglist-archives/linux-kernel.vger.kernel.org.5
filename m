Return-Path: <linux-kernel+bounces-32116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B11C8356B2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 17:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 433CB1F21A91
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DF037710;
	Sun, 21 Jan 2024 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDsQ32Go"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8AD34CD5;
	Sun, 21 Jan 2024 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705855299; cv=none; b=JjBDpCXk6/BYlPHZmZv2HAIPmSZ/IkrPrubMPUvwATLD6rCxXPDH3bWvF8mL9M57o1vNn4AaA6J0eEwMijvutyXuvAfu1UFTOhXNdTCYJDCuyDhBfLQnlxKncJJMl5zThRmlhC5wtfJjIj7io+BPekNNAG4IWXy7765wv1xFV0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705855299; c=relaxed/simple;
	bh=51UlQqphSgXsPSJFl8/Rx05VZDKMVQU2uJ0P+iHg1FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aZVksqcY9P+9t8gOXgunHPCsIC2bJ813KjSqE6eS5Burpl08TUJSv3+yjI7HjkFvTax1nEGnWCtYaA0BMlV9hIwEQVrADsce4o19W/mYaOChTfwWrs3cm1wyVByU3gwEafN1GWVjFC5/FG1DLFx63q6zWoN1HC7K+oO22C4F41Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDsQ32Go; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB35C433C7;
	Sun, 21 Jan 2024 16:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705855298;
	bh=51UlQqphSgXsPSJFl8/Rx05VZDKMVQU2uJ0P+iHg1FQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HDsQ32GoN42KL6wglqQl+WgBmDJQyBdvAcTk6X6jDY5YhOPS8tv5OLD/c3sNkM3jC
	 P18uOBmI73k5sIN++GkQzNw35AzG4qPzsfqOExSDryYwWujp/bJ1jWHxSOIighw1sz
	 oC+EIVVtURl5lclzPSIobI1yd60VVw2i38ROjYynbdvuY4fgkJSA8fka+vBH9q0RNN
	 hIPSyAw7MUVY7U1hJS0IO5pY5TtOezVkIFEn6NYQ7LXHCwaJcZXY7Rgcc622v3sqtp
	 gSjPmhRSJ15twM9TlEgbQ0G5Yf05NSsMp+wgsixmz3y2y+BzU8BAjjns4DZt9+F7nZ
	 u/5LWsoXfurNQ==
Date: Sun, 21 Jan 2024 16:41:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?TcOlcnRlbg==?= Lindahl <marten.lindahl@axis.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kernel@axis.com>
Subject: Re: [PATCH v3] iio: light: vcnl4000: Set ps high definition for
 4040/4200
Message-ID: <20240121164121.159aea5e@jic23-huawei>
In-Reply-To: <20231221-vcnl4000-ps-hd-v3-1-6dcc889372be@axis.com>
References: <20231221-vcnl4000-ps-hd-v3-1-6dcc889372be@axis.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Jan 2024 12:44:36 +0100
M=C3=A5rten Lindahl <marten.lindahl@axis.com> wrote:

> The vcnl4040/vcnl4200 proximity sensor defaults to 12 bit data
> resolution, but the chip also supports 16 bit data resolution, which is
> called proximity high definition (PS_HD).
>=20
> Make the vcnl4040/vcnl4200 proximity sensor use the high definition for
> all data readings. Please note that in order to preserve the 12 bit
> integer part of the in_proximity_raw output, the format is changed from
> integer to fixed point.
>=20
> Signed-off-by: M=C3=A5rten Lindahl <marten.lindahl@axis.com>
Applied to the togreg branch of iio.git and initially pushed out as testing
for 0-day to see if it can find anything we missed.

Thanks,

Jonathan

