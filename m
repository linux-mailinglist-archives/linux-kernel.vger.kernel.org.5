Return-Path: <linux-kernel+bounces-134762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D693A89B693
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 05:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F051C20DA7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 03:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF8446B8;
	Mon,  8 Apr 2024 03:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBTY3ieM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E52B1877;
	Mon,  8 Apr 2024 03:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712548127; cv=none; b=UAXFOEAKnFwZ9PO01s/y5zgsVlWkCkjVirbBAXjteUqcd5CjrqotPGPLs207kLjS0ZDfZBvqL4+AbToIEwDew1Xodu/cTCPPAEg3YLtHr+hn7Y1sxXtEymE5BGeYWs04vN3BB0doVzkbqLrNaxFfUg+/z+g/duOLc6bT+awtnuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712548127; c=relaxed/simple;
	bh=Hnjg2c5JJtX62lv3zAjHn+jj7fDIGiotBLQE0BHCb3c=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=Mx1UzG87nPbh6GIGEXp37se4nVJjx2dCpyKUmB/GMIEtKJAIF0FeZ+G03ynpyXs/K0YpnOS0fZE+bZVIDNjUTNUnA7mHY+c/9vyVAbB1WBosWnDEryG9fvUnC9BUgIRATFBL90SVyEBbp/pII6tBmCCfQ4C7oSPe3ta7H7XF798=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBTY3ieM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5151C433F1;
	Mon,  8 Apr 2024 03:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712548126;
	bh=Hnjg2c5JJtX62lv3zAjHn+jj7fDIGiotBLQE0BHCb3c=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=bBTY3ieMBDzi79R7Tz27+DBRH6rzv5wwMBBQNGd66sHB9iUdpARjWv18TF0V6TM9h
	 VhU6ZTHzSalP/J8hhv/iQCjDha7MVlP5DhSMGknTUWAXCtQn4/GOqfmJjJ2LiUH8L8
	 mBYEBT2IMP/UTBnSxMhI38thKxvtAmRZd2BVD3eUh32W/1Neu9gMHt3v8MwOwjVQV8
	 jAE6l8VOVgP6Pvvvsv83qV9cNYqZhWL6PQ0q4EiO8sDDfjvpsGKRTbPuB87HARwrR7
	 doo3fAg0VOzz8UXA+WOW4lGYOGKKvDrBmcVizhwM8PqNm08T6zCtls6vbjzMwGztPV
	 rQAmH2QHVgrwA==
Message-ID: <117880094a993713e7914b712ba661a6.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <E1rl62V-004UFh-Te@rmk-PC.armlinux.org.uk>
References: <E1rl62V-004UFh-Te@rmk-PC.armlinux.org.uk>
Subject: Re: [PATCH] clkdev: report over-sized strings when creating clkdev entries
From: Stephen Boyd <sboyd@kernel.org>
Cc: Duanqiang Wen <duanqiangwen@net-swift.com>, mturquette@baylibre.com, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
Date: Sun, 07 Apr 2024 20:48:44 -0700
User-Agent: alot/0.10

Quoting Russell King (Oracle) (2024-03-15 04:47:55)
> Report an error when an attempt to register a clkdev entry results in a
> truncated string so the problem can be easily spotted.
>=20
> Reported by: Duanqiang Wen <duanqiangwen@net-swift.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Russell, are you taking this through your tree? I took the last one
because it was small and you reviewed it instead of applied it. If
you're taking it please add:

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

