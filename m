Return-Path: <linux-kernel+bounces-45151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E568842C36
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38623282780
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433613838C;
	Tue, 30 Jan 2024 18:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="booGVQ8d"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982A779942
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 18:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706641080; cv=none; b=fWeCzBWtOAu4qvYTG7+S1yRoMMFuI/93CDSkBdcbkJ/HChpEFnwklJp6nN/E9FagQhs/YMFvR5ZQkySIiaQmuienpChfYIZ+pyTtP+0/RQeBtDd25fRDpTcPkryDRWa21Hqnjpg8d5R5WOZrjJbBxRkLFxFVeZ0r7Hllk8b5Iv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706641080; c=relaxed/simple;
	bh=k6HRdPozVBTmbethj///4v44JcIV6nTJmQs4So93nWE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uV/3paN7xA5Chhz/kFX1Jb/LWwbZy3WzfLQUWu1M9qBGT+KNgAS1e6MUmygOmOau+B93hmMZik/jCjMsa7W/E3NxYPhHQzq6+YNvWXfTq9UknoJTLMPocouJ6/TlC6gGFNqxEzQRzFPx4N7IwbIVfMjUM0d+8whCZNdTE7BNFeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=booGVQ8d; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1706641070; x=1706900270;
	bh=k6HRdPozVBTmbethj///4v44JcIV6nTJmQs4So93nWE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=booGVQ8dCrkbnpd2VeDyQENHr7gfcpo6TbD8YW3C4laEp1ZYJCUzfBa4FJQSCbj7q
	 ugrfd/bHNyEIUuuGG/CpvykTHSOkkN/74yV57n/7VbFnij/Egeyh5ylO1Cye0eC5sA
	 DICX+ZkTUpbcOyWiaCy7AQTrhjs9gEl+rOR70+lq5gIiz7XsLMqgxFxrB5d4NFClQD
	 hDGGNynJoD4lkUZrO3IHVN/PZzVxHv1xEJ6y4cL0RkPuWnID8siiO2crVyJ2RkyG6u
	 67HB9FGf0v3CcS6EnreFHKNU8nnqLlicxDJJ+OFFWOINNoP+AfDqZ3XWgz9jGmHEyh
	 Hgh3hnGttauyg==
Date: Tue, 30 Jan 2024 18:57:47 +0000
To: Jiri Slaby <jirislaby@kernel.org>
From: Emil Kronborg <emil.kronborg@protonmail.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: mxs-auart broken in v6.2 and onwards
Message-ID: <djtgk274iojly23xjb6kgx7ucgv6a4d23ix4vvr2cfskrkeb2r@uykelfkgrcg7>
In-Reply-To: <040064c5-c285-4e02-b545-47c5085f0068@kernel.org>
References: <miwgbnvy3hjpnricubg76ytpn7xoceehwahupy25bubbduu23s@om2lptpa26xw> <040064c5-c285-4e02-b545-47c5085f0068@kernel.org>
Feedback-ID: 20949900:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 30, 2024 at 10:38 +0100, Jiri Slaby wrote:
> Hm, the tx stop handling is weird throughout mxs. What about the
> attached patch?

It seems to fix the issue, but I do not see any way to fix this just for
mxs-auart.c without also changing serial_core.h, and thus affecting a
bunch of other drivers. Would reverting the changes from 2d141e683e9a
("tty: serial: use uart_port_tx() helper") for just mxs-auart.c be okay?
If so, I can do that, test it again, and send a patch.

--
Emil


