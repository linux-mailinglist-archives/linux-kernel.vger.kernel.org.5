Return-Path: <linux-kernel+bounces-16922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FE282461F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28F841F23E6F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F93124B3A;
	Thu,  4 Jan 2024 16:26:49 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF21250E9;
	Thu,  4 Jan 2024 16:26:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B34AC433C7;
	Thu,  4 Jan 2024 16:26:47 +0000 (UTC)
Date: Thu, 4 Jan 2024 11:27:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, =?UTF-8?B?5a2f5pWs5ae/?=
 <mengjingzi@iie.ac.cn>, john.ogness@linutronix.de,
 senozhatsky@chromium.org, keescook@chromium.org, tony.luck@intel.com,
 gpiccoli@igalia.com, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: Suggestion for Capability Check Refinement in
 check_syslog_permissions()
Message-ID: <20240104112752.120cb566@gandalf.local.home>
In-Reply-To: <ZZZ92cjhyr_CgLRJ@alley>
References: <1ee10aa6.d064.18ccdb23971.Coremail.mengjingzi@iie.ac.cn>
	<2024010306-tweezers-skinhead-083e@gregkh>
	<ZZZ92cjhyr_CgLRJ@alley>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jan 2024 10:43:53 +0100
Petr Mladek <pmladek@suse.com> wrote:

> And CAP_SYS_ADMIN has really been deprecated last 13 years, see the
> commit ee24aebffb75a7f940cf ("cap_syslog: accept CAP_SYS_ADMIN for now").
> 
> Maybe, it is really time to remove it.

Perhaps what we should do is to remove it in a simple change that can be
easily reverted if someone complains.

The point is, Linus always says "Don't break user space", but he has even
said that we have broken user API before, but as long as no user space
breaks, it's OK. It's the "tree falls in the forest" analogy. If we break
user space API, but no user space application uses it, did it really break?

If nothing is using CAP_SYS_ADMIN why keep it?

If we remove it, and nobody complains, it means that nothing broke. If we
remove it and someone complains, then we know it's still needed and we
revert the removal just like Linus would do with any other commit that
broke user space.

-- Steve

