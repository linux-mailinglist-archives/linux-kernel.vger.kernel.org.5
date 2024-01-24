Return-Path: <linux-kernel+bounces-36739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F12CB83A5D5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9E49287049
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64281803D;
	Wed, 24 Jan 2024 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uOem8iJx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HOzolg7d"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CAF175AB;
	Wed, 24 Jan 2024 09:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706089640; cv=none; b=o9uHEWcbH7nV31wjhhIbJsClO9/l1D3tB/uMeenvoVfyyvbiJhjqVgPdvtFYcpJ2W7vhszOA8r/zu66EsjBJE5N3wPrwIu+b66rA/ocIkaU5ZYro2a0xH1MMhMO9z29/D7hEJiPqSD3VXAtutljv+E8Y8P/JAHS1hxgJxuXKKDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706089640; c=relaxed/simple;
	bh=8ChCn7BnUC2Ra2qH1XEh6xfcFp4o5YyhARENMBZPK1s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dzLQccLnFXrjzXgq0A4HDcpmHM84T6HQCruH7uzTAr8lK9IaVj1bPPBRFbmCMQTPV7InFegyusROIM7QQo5QguzqWwbVRWMdWGlyNAS4pzqyqHtTH/4W+g695n52h6UZPeBgsDVFcCto3LNHboycvp3NwJcctqfRj2hyijWdZXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uOem8iJx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HOzolg7d; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706089636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ChCn7BnUC2Ra2qH1XEh6xfcFp4o5YyhARENMBZPK1s=;
	b=uOem8iJxhr+RJ+vL+x7ujlYNCrsCKwZl0FUe6Jzi0qCfUt5PU9gWQ2sd+ivORtnOh2ios/
	H1yGHwAcRgk/Cd+j4DfMFq+PsfGloLn2IDLgo9iwP8RvS2/AwhxjYOsaQlczLzNhy1zJBq
	U3RQ+EaOR3erZuPx+Qg02bG7W+cB1R88GjpoULb1RZ6Q0Egk5pl1wRuM5OXLvMxG8MDL4t
	L8nAfFJt37oKwL1XpA94eGJyvzUMMV9n1AK+X8m6sxDdE4UnvAEm7hkzt25TGfuOM9NBFH
	u9M1FV+wbNCJlK4bCflsJApVZEBpqgs5IXNRjYvln5aZ2c96wcHPiFuwBPBOnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706089636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ChCn7BnUC2Ra2qH1XEh6xfcFp4o5YyhARENMBZPK1s=;
	b=HOzolg7djKXwbPIRObqTQzCtNM0iLjCuPQlOcYuIhJ6pKTCM057teONezZNSTEc2kSMciU
	rasfiXI3DlmGVyAA==
To: Junxiao Chang <junxiao.chang@intel.com>, bigeasy@linutronix.de,
 tglx@linutronix.de, rostedt@goodmis.org, linux-kernel@vger.kernel.org
Cc: hao3.li@intel.com, lili.li@intel.com, jianfeng.gao@intel.com,
 linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 1/2] printk: nbcon: move locked_port flag to struct
 uart_port
In-Reply-To: <20240123054033.183114-2-junxiao.chang@intel.com>
References: <BN9PR11MB5370AED9C562F9DA75093557EC742@BN9PR11MB5370.namprd11.prod.outlook.com>
 <20240123054033.183114-1-junxiao.chang@intel.com>
 <20240123054033.183114-2-junxiao.chang@intel.com>
Date: Wed, 24 Jan 2024 10:53:10 +0106
Message-ID: <87le8f9i75.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-01-23, Junxiao Chang <junxiao.chang@intel.com> wrote:
> Console pointer in uart_port might be shared among multiple uart
> ports.

I still want to investigate why the pointer is shared. This sounds
sloppy or dangerous.

> Flag port locked by nbcon should be saved in uart_port
> structure instead of in console structure.

If it turns out that the pointer sharing is necessary, this patch will
fix the reported problem.

Reviewed-by: John Ogness <john.ogness@linutronix.de>

