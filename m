Return-Path: <linux-kernel+bounces-79360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F95286212E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565AF1C22C40
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F033310F4;
	Sat, 24 Feb 2024 00:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YzYGEEBx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9FBECE
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 00:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708734430; cv=none; b=tX7GZo4VP2N39IzEjJI2+6cY3HlYdz2cGg5R444yaHvf7d4iuOGi9WQ1WE9J3kromLQqV/a0q+YDOAvokb9Q2pWg92UT3y7C0c5m+bgs5u7F0ekZqbFAdHw+nxIm+iWOerPg0LnoZeipHCJuCHxC17ccMlbUptHvylAakvoQ7+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708734430; c=relaxed/simple;
	bh=bneAi/vKcoLCDnkXWsgRCpchfA7J54ykG9bA/e37k84=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dGzLoN3+BVsMgQ68i61ktR8Z5VRLrpIEYvt+CBgZiPXscJ+afllRxQs0uGOhrFiS6rtoQuaraOv61gEecyWxL2geV8zmYfpS4JSmlZg5iE485jtH9MAmIUlmlFzgG2e0bLMKNUgzecmZwTiRb6ICyn5lMj1pYuTffGF9D9O/AGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YzYGEEBx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8865FC433F1;
	Sat, 24 Feb 2024 00:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708734429;
	bh=bneAi/vKcoLCDnkXWsgRCpchfA7J54ykG9bA/e37k84=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YzYGEEBxCAOhsydQdXdL2lm8kP+DSLO9Ywlz8oAM1D5MKNi1dkCsT8uQe4u/8NJaA
	 pSGHqDkeCnC+5CDMTeAT4UAVe6lEK5Du0bghZHkYtAAfLs/kKP3oJPR5CXjjllVa7g
	 JVcSMCQ2w9hia5gd34QWBoJM2bwz5yyikzZyOo0s=
Date: Fri, 23 Feb 2024 16:27:08 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: stefani@seibold.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] kfifo: drop __kfifo_dma_out_finish_r()
Message-Id: <20240223162708.99a2e988860f3719a21ad115@linux-foundation.org>
In-Reply-To: <20240223115155.8806-2-jirislaby@kernel.org>
References: <20240223115155.8806-1-jirislaby@kernel.org>
	<20240223115155.8806-2-jirislaby@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

These four look OK to me.  Would it make sense to upstream them
via the serial tree?

