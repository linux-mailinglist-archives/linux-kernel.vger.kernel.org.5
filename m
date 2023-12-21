Return-Path: <linux-kernel+bounces-8600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E79181BA00
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B11B51C23A78
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CD8539F0;
	Thu, 21 Dec 2023 14:56:50 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A23539EA;
	Thu, 21 Dec 2023 14:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0639AC433C7;
	Thu, 21 Dec 2023 14:56:48 +0000 (UTC)
Date: Thu, 21 Dec 2023 09:57:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Tzvetomir Stoyanov
 <tz.stoyanov@gmail.com>, Vincent Donnefort <vdonnefort@google.com>, Kent
 Overstreet <kent.overstreet@gmail.com>
Subject: Re: [PATCH v5 02/15] ring-buffer: Page size per ring buffer
Message-ID: <20231221095752.0931fc19@gandalf.local.home>
In-Reply-To: <8b75519445ad458394439feed0ce6288@AcuMS.aculab.com>
References: <20231219185414.474197117@goodmis.org>
	<20231219185628.009147038@goodmis.org>
	<84d3b41a72bd43dbb9d44921ef535c92@AcuMS.aculab.com>
	<20231220080129.3453bca8@gandalf.local.home>
	<30f49370d7ae494ab1afca5cf602ab55@AcuMS.aculab.com>
	<20231221091947.3b35d5d8@gandalf.local.home>
	<8b75519445ad458394439feed0ce6288@AcuMS.aculab.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Dec 2023 14:51:29 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> > I think 1kb units is perfectly fine (patch 15 changes to kb units). The
> > interface says its to define the minimal size of the sub-buffer, not the
> > actual size.  
> 
> I didn't read that far through :-(
> 

Well, this isn't a normal patch series as I took the work from Tzvetomir
back from 2021, and started massaging them. I wanted to keep Tzvetomir's
original authorship even though he's not working on it, so I just applied
his patches as-is and then added patches on top of them, to denote what I
did and what he did.

This is why I never modified the first 5 patches of this series, except for
subject lines and change logs.

-- Steve

