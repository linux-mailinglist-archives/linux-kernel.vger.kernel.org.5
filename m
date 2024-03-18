Return-Path: <linux-kernel+bounces-106338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7C987ECB3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 733931C2120E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E700253377;
	Mon, 18 Mar 2024 15:51:32 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B85252F98;
	Mon, 18 Mar 2024 15:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710777092; cv=none; b=IjM5Q5yLfScAIHCm3vZtFhMKIpnuvFxHaoAF5w8l9L+32S1vXHx2Ii7UR27skGuBK9gWCvmCrek3k3be5QIb4xIEkJk4yY7/eed2T4VeQJHhOTV912UDeos4dteb2iFJR92w7G0Ojzhvbelbno0HWFjexLP4cJ3i588vNVj9ISE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710777092; c=relaxed/simple;
	bh=ueH60MClIK4FdfU/RUmpF4cE3xHP+LGu0QE6c4ifqeA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m5gZ4fGDFXQlBZUq3ERR21gSlzS2Ab9janeaVOYA8L4RdKDr4+9sbdLEReKTmdp1JsK9C3hJKHWk1dfy8FlJskOKhjeNQ3/NzpbQ2rGdm3jXWpmDbx+0NJuGrd4SfOFgTAmgihrvW4IuUf+NRMOf8m0OA2x9aRn5wJpYIM6mtfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06AFFC433F1;
	Mon, 18 Mar 2024 15:51:29 +0000 (UTC)
Date: Mon, 18 Mar 2024 11:53:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: TP_printk() bug with %c, and more?
Message-ID: <20240318115350.52f97855@gandalf.local.home>
In-Reply-To: <20240318164307.53c5595f@booty>
References: <20240315174900.14418f22@booty>
	<20240315132146.29edf416@gandalf.local.home>
	<20240315190312.2bd6a198@booty>
	<20240315145852.46125ac5@gandalf.local.home>
	<20240318164307.53c5595f@booty>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Mar 2024 16:43:07 +0100
Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:

> Indeed I was on an older version, apologies.
> 
> I upgraded both libtraceevent and trace-cmd to master and applied your
> patch, now the %c is formatted correctly.
> 
> However the arrows are still reversed.
> 
> Is this what you were expecting?

No, I didn't look at the arrows, just the %c issue. I'll try to get some
time to do that.

-- Steve

