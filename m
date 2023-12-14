Return-Path: <linux-kernel+bounces-114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA62813C60
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68EDE283801
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543CD39FE6;
	Thu, 14 Dec 2023 21:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ZTEFJ7oF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E167273FD;
	Thu, 14 Dec 2023 21:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9ID6E51wXAKn7Ezg5ykW3DY/29a9sY2cYsFnqwiNNi8=; b=ZTEFJ7oFYCxmuqRe9pouzKHXcM
	vA49XHnKOrNMfyKjL/tqpbbQZjfGxyIxA9U5quw/GkIHoTPr6sg7MeqpJlyCoNkO3LTM3D6zn4XZA
	6EVxoMLNssmFdaiZjjLfTNClUTILmaeRWhL8ut/m7/aVnwVkyENWBaWYAo8UZCCN2mgWXgcHxBrBg
	o0xf3W7nRBfhQy7vOn+1e381I/5qZPNIjC6oyLw4UjVAgvhAmQYTr8CkXlIaOQ0tqDwJR4G2sgEmC
	p5IwkjnM3ZPQkynrBNWaQD6P3pwx2kkcIh9KzGLAJ6cTQ2YRykOiAgtGpRmuO4LX4iGsCO0mnP5Xx
	qHY+QUAA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rDsyl-00CSEB-03;
	Thu, 14 Dec 2023 21:10:47 +0000
Date: Thu, 14 Dec 2023 21:10:46 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] clk: microchip: mpfs-ccc: replace include of
 asm-generic/errno-base.h
Message-ID: <20231214211046.GS1674809@ZenIV>
References: <20231214-dipper-earshot-72eef3059961@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214-dipper-earshot-72eef3059961@spud>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Dec 14, 2023 at 10:59:57AM +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> As evidenced by the fact that only 2 other drivers include this header,
> it is not a normal thing to do. Including the regular version of this
> header is far more conventional for drivers.

ACK.  Includes of asm-generic/anything.h are fine in arch/*/include/*
and (under some circumstances) in include/*; anywhere else they are very
dubious, including outright bugs (io_uring/uring_cmd.h include
of asm-generic/ioctls.h, for example).

