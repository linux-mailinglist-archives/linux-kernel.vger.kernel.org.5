Return-Path: <linux-kernel+bounces-139993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C57F88A0A0C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CAB21F21E83
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7971465B8;
	Thu, 11 Apr 2024 07:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/4QM+KR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A9A13E412;
	Thu, 11 Apr 2024 07:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712820941; cv=none; b=LDxKz99Dwezhl4B8ZY6kM5FLcriIdcoT+URup6oN7IPmH9gcYLDVzP7sYMpE4sGaEudYwr7+SLSMM4ZNP1AWLItTDYmgGhbXTWiv1tSAFQySd5sHWxIBrsCeKQP2ByiHsJpjfJs3q057yb7Ic0qtYB1ExQND4RJ0kMsYvXHLchI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712820941; c=relaxed/simple;
	bh=uGw7Yk9Z4mxKn1Sz272Iwa07FqsOMFt7sMdXjPFNCs4=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=TnVh/m90A+V1LYJFignbytZi7OJ5xnQhVnyXuuXbEwUsvCvxAR3wCvWdJ+gAJ0lXzz/E/U7Iht1A6Eihc0W1qDQ6UTxEs4gZ/OV39w11ZPLGkBydC5PDAJUapKYT5az6QNsQISSjGugu4dSHXVahGvsOTLwWoOuDhgtyjiS0nSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/4QM+KR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA189C433C7;
	Thu, 11 Apr 2024 07:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712820940;
	bh=uGw7Yk9Z4mxKn1Sz272Iwa07FqsOMFt7sMdXjPFNCs4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=s/4QM+KRRU596UrAICP2zlCRcG6R9L3t90W5BFOMI3EcdeV+rpnojlPdG996NFiCX
	 aWydQipcz5GN9/MspML+lRnakpTqVViGTfvDHNU9Dl9R8cqXjOtuCCi2VLR9m2jaWf
	 Q3RE9guO7cAOFLDl6tUg+IDLApjlc6yVu5QuykjL5eoIH4fi20RUuwoCTiNPTqpqFo
	 g34PvdusxZ4o9+2XIxZV+idIxrSigrhuanbU/badmue7YB2mBhSAcWz5GXNHh9HzuV
	 uUI9PDIfR2JN1RASbR8cvT0jiU7qVDHXtdFdC9MhbpwPoGNaiIr9qA2Vd6Jz7rOOt3
	 KXAMUuOFfSEFQ==
Message-ID: <27c15251bd98f27ff4e21236adcc98d7.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240205111155.3939125-1-onkarnath.1@samsung.com>
References: <CGME20240205111208epcas5p4775d540854dd8778388065a574b7862b@epcas5p4.samsung.com> <20240205111155.3939125-1-onkarnath.1@samsung.com>
Subject: Re: [PATCH 1/1] clk: imgtec: use %pe for better readability of errors while printing
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-mips@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, r.thapliyal@samsung.com, Onkarnath <onkarnath.1@samsung.com>, Maninder singh <maninder1.s@samsung.com>
To: Onkarnarth <onkarnath.1@samsung.com>, mturquette@baylibre.com, paulburton@kernel.org
Date: Thu, 11 Apr 2024 00:35:38 -0700
User-Agent: alot/0.10

Quoting Onkarnarth (2024-02-05 03:11:55)
> From: Onkarnath <onkarnath.1@samsung.com>
>=20
> instead of printing errros as a number(%ld), it's better to print in stri=
ng
> format for better readability of logs
>=20
> Signed-off-by: Maninder singh <maninder1.s@samsung.com>

This SoB chain is wrong. Either the above email is that author, and thus
the From should match, or it's a Co-Developed-by tag. I don't know which
one it is, but for a 6 line patch I hope it's not co developed...


> Signed-off-by: Onkarnath <onkarnath.1@samsung.com>

