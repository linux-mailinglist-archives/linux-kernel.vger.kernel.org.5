Return-Path: <linux-kernel+bounces-146199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5478A61F1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08A31F22B23
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BA8210EC;
	Tue, 16 Apr 2024 04:01:39 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E001ED512;
	Tue, 16 Apr 2024 04:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713240098; cv=none; b=KY93rwmcGtnV1Gf9n/H1Hph2Pw5oUHuHmTkC4880NhMiNETMQbx8EUfBG7uHUIoENwJqY46TRy9ESKsOCh0FtKl+NvRHg/8HMJpfZTKMUjIGM77K+eNMXJ0g6mw2/2Cg7lrCjinrkqkImkeJvTARfpCW8gfw2ru4TAvKtZjboW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713240098; c=relaxed/simple;
	bh=kS4QErR+G5uIGvj0PAK9ennM8nQwV+qB5T2YG2zXdII=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kMVO0gU3TUQ02QXdxqfHHONqjjKUsawzXQ6AZvkOZd9E6LYgApGxjNu5Emrw4SWENtBCvE5F3aceT8f7vEAGN8eSYmelHwB1ulAllUhK4jcNxM5soWHeXb1NUjhIsiQThWrbzvzq/6GcZPvqCrrnA683/E0KpdOBlV2SrNRIBy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD1FC113CE;
	Tue, 16 Apr 2024 04:01:37 +0000 (UTC)
Date: Tue, 16 Apr 2024 00:01:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: TP_printk() bug with %c, and more?
Message-ID: <20240416000133.4b990f36@rorschach.local.home>
In-Reply-To: <20240416040846.00de86aa@booty>
References: <20240315174900.14418f22@booty>
	<20240315132146.29edf416@gandalf.local.home>
	<20240315190312.2bd6a198@booty>
	<20240315145852.46125ac5@gandalf.local.home>
	<20240318164307.53c5595f@booty>
	<20240415044431.308f2e09@rorschach.local.home>
	<20240416040846.00de86aa@booty>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Apr 2024 04:08:46 +0200
Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:

> Thanks for the insight. I'm definitely trying to fix this based on your
> hint as soon as I get my hand on a board.

I have a patch I forgot to send out. Let me do that now.

-- Steve

