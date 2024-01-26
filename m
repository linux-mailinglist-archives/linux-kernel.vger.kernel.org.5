Return-Path: <linux-kernel+bounces-39733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D828983D584
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16B071C25DA8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3C4657B2;
	Fri, 26 Jan 2024 07:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VhPinX3N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tvxyV5it"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7B9125CF;
	Fri, 26 Jan 2024 07:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706255926; cv=none; b=a1yx7tkHeFSVJxrB5xa9FbrqlMFUcytSke4BPApsj9CwyBJIOqD4sPj78FrM/1gUDGVuwDg++syRohjaW1i06Nk+YG49SOfAbkqYk970QQre4hWF7OL6xksaGVXyDl3tGHUUzoCxRX2SY46sp4g+Aq++4VC4Kgu4ao8rnGzfv6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706255926; c=relaxed/simple;
	bh=m+Da7ZgxMwo2+HmAPs6huT15vqNO6TMgeWJ4uLPZKI4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=djCpmtFl64lK8o2sguboU7wfwYEHu9Fa7+GXyDliMjZcqVmxsbO/QrveGKa5APEXuzJdmDQUcrhP8sHAhtpSbtpat0WXjIaYfY2n6MiJzR0zzEgPyUIWJ4npXRH/mnE1054mNfBM3vuHobqZsRsEc26N3Q0jb00Ifl15gdcCOZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VhPinX3N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tvxyV5it; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706255922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m+Da7ZgxMwo2+HmAPs6huT15vqNO6TMgeWJ4uLPZKI4=;
	b=VhPinX3NOgsyBaG8CBodLCugiOh/eE0tYPg4fWSj3xCM+ctOF4AvBv13nssxuyx/J7jx9z
	d8xJwc0EWcix+eNvU3HO/gUxfGhizp0B5A3fIABdF5nq+jFXDAzSWtK9Jus7En2nQ7Fu5E
	xnst5nTjVIgZ5KEqq/lxgjeO5sLu+9llI0fKaLqPKiTizH0UxtZxVgJcC1meZQc5PADxax
	CMWUCfnV6A4IcuLWieAKSbzz/nV2vLjnF1MLqicJlzsvF9BdGHsCgIMrix4cdJ5krrT18q
	O6+uthd9/yInFrHvm+vbOsJl21VxXxH0PkrDhXZqXBf8+Ji9nPQhjTUuTry/9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706255922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m+Da7ZgxMwo2+HmAPs6huT15vqNO6TMgeWJ4uLPZKI4=;
	b=tvxyV5itSDj3HDeSNBmwPRynzEX0T7lyhc82weSldjV7fpyf4OEwWbaDRaAnIg0d/d/deu
	L15MK70h+UtV0nDg==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "Chang, Junxiao"
 <junxiao.chang@intel.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>, "rostedt@goodmis.org"
 <rostedt@goodmis.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "Li, Hao3" <hao3.li@intel.com>, "Li, Lili"
 <lili.li@intel.com>, "Gao, Jianfeng" <jianfeng.gao@intel.com>,
 "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 1/2] printk: nbcon: move locked_port flag to struct
 uart_port
In-Reply-To: <20240125133523.W7aDeBqt@linutronix.de>
References: <BN9PR11MB5370AED9C562F9DA75093557EC742@BN9PR11MB5370.namprd11.prod.outlook.com>
 <20240123054033.183114-1-junxiao.chang@intel.com>
 <20240123054033.183114-2-junxiao.chang@intel.com>
 <87le8f9i75.fsf@jogness.linutronix.de>
 <20240124100524.ZyAPfPU5@linutronix.de>
 <BN9PR11MB53701E5CF2737908FA9EB532EC7A2@BN9PR11MB5370.namprd11.prod.outlook.com>
 <20240125133523.W7aDeBqt@linutronix.de>
Date: Fri, 26 Jan 2024 09:04:34 +0106
Message-ID: <87il3gv845.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Sebastian,

On 2024-01-25, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> Okay, So that I see this and the unbalanced acquire/ release part with
> the attached patch. I leave it to John...

Please add this one patch to the 6.6-rt and later queues. The 2nd patch
in this series is not needed.

For 6.8 the fix may end up looking different, i.e. by eliminating the
struct console pointer sharing instead. But for now this patch is fully
sufficient.

Thanks.

John

