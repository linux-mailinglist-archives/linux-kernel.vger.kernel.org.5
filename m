Return-Path: <linux-kernel+bounces-110101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E22D7885A0A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01DA91C21719
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A3184A57;
	Thu, 21 Mar 2024 13:36:39 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693F3134CD;
	Thu, 21 Mar 2024 13:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711028199; cv=none; b=kStpAIsYqVa0ch9BLt84SNr9PcoMRV+Tx7hK+SCj6Tspqa8YQ5RMM1hnJtxxMxkqlyQO+v7CcCmJWWbdm641FukMVfUd5j1o5ZCegVjawHTth0lqNVBz0yT23k0Ll3cyQjZyl08vmk1BmcMJJ86WD0vY+VOHTayZGHvP4zKlDME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711028199; c=relaxed/simple;
	bh=ra8zoPHUNwWfEZK3+SNr/xeXhA/VoCBJ9K+j+pIxJ2o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vi3Am+pUDhSQS7pxgOLvs599zA3czrm4Oa8tZlHWW1hofoNvUdVku1RXxlV125Eez9QqWp3fWtYyCe+kxZ+kmyjyM2IvO6R53fsL4SrThbdzTAtA5bms9PfUTJJ8gA2tqbe1Hk20GuD92KGeH07KEBxwR3Y0RdAhH/DoQihGVs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7566DC433F1;
	Thu, 21 Mar 2024 13:36:37 +0000 (UTC)
Date: Thu, 21 Mar 2024 09:39:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: xu.xin16@zte.com.cn, edumazet@google.com, davem@davemloft.net,
 mhiramat@kernel.org, dsahern@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 netdev@vger.kernel.org, yang.yang29@zte.com.cn, he.peilin@zte.com.cn,
 liu.chun2@zte.com.cn, jiang.xuexin@zte.com.cn, zhang.yunkai@zte.com.cn
Subject: Re:  [PATCH v3] net/ipv4: add tracepoint for icmp_send
Message-ID: <20240321093904.65f91d10@gandalf.local.home>
In-Reply-To: <CAL+tcoAdZOKnHTbRnmrjtrhJynGfDy4xXvus1hh_UTbh5eSMTA@mail.gmail.com>
References: <202403211010443485000@zte.com.cn>
	<CAL+tcoAdZOKnHTbRnmrjtrhJynGfDy4xXvus1hh_UTbh5eSMTA@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Mar 2024 10:45:00 +0800
Jason Xing <kerneljasonxing@gmail.com> wrote:

> The format of the whole patch looks strange... Did you send this patch
> by using 'git send-email' instead of pasting the text and sending?

Yeah, it's uuencoded.

Subject: =?UTF-8?B?wqBbUEFUQ0ggdjNdIG5ldC9pcHY0OiBhZGQgdHJhY2Vwb2ludCBmb3IgaWNtcF9zZW5k?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL:mse-fl2.zte.com.cn 42L2Ahm2097008
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 65FB975E.000/4V0TV60kJlz8XrRb



--=====_001_next=====
Content-Type: multipart/related;
	boundary="=====_002_next====="


--=====_002_next=====
Content-Type: multipart/alternative;
	boundary="=====_003_next====="


--=====_003_next=====
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

-- Steve

