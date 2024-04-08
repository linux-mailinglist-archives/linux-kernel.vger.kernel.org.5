Return-Path: <linux-kernel+bounces-134735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C71289B631
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 04:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5EBE1F21946
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 02:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368151869;
	Mon,  8 Apr 2024 02:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WApaUrxC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC9F17EF
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 02:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712545110; cv=none; b=WIWM6rJSLm/A7qqwhE7xDBORDHMOb1esRN7JR6gNkxHwMkxbGQ9rAYC6WxdMLKpTmZ6z47h5M3uQlaER7lOwK+AyXkguM7zRZg5YXjQmuCPRjm973MkRmSNr+EiW5NvXKfiO6Ifdgajit/5sksHh8ZHstyRSCuXs6j8thEHz+KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712545110; c=relaxed/simple;
	bh=I4W+IKmQ/TB/3FU2eHFkdOTnBZYgA2AkAPeJkEX27ko=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=ILdWNk19dY8gzTh8qaFsdaeHwbTUyq3nMp1OBVgYBDihwdjf6iV6EOSCiK0OdHuiUlrGUEx5PdB51WU9Aoj+xR6Y9MZLmum/oMAocbe0wxyZO9OZKLwPS+hrtDMmJPMovCcHKuo4RReT/IK/RHsygIFu8TIPpwJFkAFbIjGGEho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WApaUrxC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B33C433C7;
	Mon,  8 Apr 2024 02:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712545110;
	bh=I4W+IKmQ/TB/3FU2eHFkdOTnBZYgA2AkAPeJkEX27ko=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=WApaUrxC7RMNVZW0BBuSZf3Bzb/uHE7gOsNaEWy8EH8KXyska0hZ2SDkblZJEelmz
	 CEUyZ3YOjqF/b9UHjPbjotyl0lYNCSwB83FyJbntBJMuetAWQ3qtn4YkRywYlc+zM4
	 FA7f1s0zwfyBh5hTV/g3sscMKe4imaasy/+sYCCpHsPwt94mfh84kgexosilivlsWH
	 CDtKcktwUb6ccpFjId6/NnCotTloJINxL88YH38ickfQjJDFdXOtGJsNDtFWLokaOj
	 ph03HXoOU5P5I9glBjOiT0mCQ5X4OVn+bSSLuvYeQ4Jmt4z/AQ+5LROxYmU6K30c2E
	 K89A9BT4YLL8g==
Message-ID: <6158dd3e3a1b966935a399f728b000d9.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240204-bus_cleanup-spmi-v1-1-ef7f278f1987@marliere.net>
References: <20240204-bus_cleanup-spmi-v1-1-ef7f278f1987@marliere.net>
Subject: Re: [PATCH] spmi: make spmi_bus_type const
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ricardo B. Marliere <ricardo@marliere.net>
To: Ricardo B. Marliere <ricardo@marliere.net>
Date: Sun, 07 Apr 2024 19:58:28 -0700
User-Agent: alot/0.10

Quoting Ricardo B. Marliere (2024-02-04 12:38:38)
> Now that the driver core can properly handle constant struct bus_type,
> move the spmi_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
>=20
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---

Applied to spmi-next

