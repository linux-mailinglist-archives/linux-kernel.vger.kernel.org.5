Return-Path: <linux-kernel+bounces-36759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13ED083A618
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94F91F219FE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1AF182B9;
	Wed, 24 Jan 2024 09:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ijr98ALA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JuE8dMyG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A24418B02;
	Wed, 24 Jan 2024 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706090269; cv=none; b=UhH8mHu7HYw7VaC0gsGA+eRj/JACf86YmuwrNi2iwJ3PRdb1Vqg3zfv3Zkf3yxtaSFtNnvrV4/63ei61OVTDARY/8Ocs5EjFf7upYMg8LtxNqL4DH6UxYsVS9LdLnjYfldSeVIHxubnFkBYGmv3PuHQUWs20WI58ADK3y1BFR28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706090269; c=relaxed/simple;
	bh=3wmf3wu6pEhYmgZge+vax11EPN8UmQlBJ3MKJwRgPqg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CfjTCubJcNcHERzdQGxuuGEG6NGc5jsQ3JcS5SWVtQ/trL/TF2cK65HLuDFJsIA6fWtgvlir9/0tyXUn65oClnUUd+RFc9qQ3eP6NejsHFG1GTQHNc40mir2yixT+aH69SfOPz/IRPMZA9kajQofJFcFnUVrs11SnoSb0N2H1N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ijr98ALA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JuE8dMyG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706090265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3wmf3wu6pEhYmgZge+vax11EPN8UmQlBJ3MKJwRgPqg=;
	b=ijr98ALAOMm+t8LvziczWeSUz9wq06w/YopVNxVBw66PvgsdRX0VIYvHIMptN1Ws1LdMF3
	Hr8m/aaj0YBlzl8GTC9N5tuT74SijcaVho8xhgPVYK604MMuMTRZJlUPNKJK8O1DeQtbbk
	ckCoUkG6UU9fNkjkqNx9DqgygCuTNDjIeNoEypTPKYNwF5p6d2W41StumFcHARc2eGOp6R
	k+JYowCM3HWCBztcI56Ld67Jr1d6de0g9ViYDxg1GXipfI4SPeMvP6QlZDwK5p9NII0XVB
	Z+bgzCD8+BzeQZxh3Jp6D7zCe3WtBJYGJ3dxdg70SJm5AflBFZhq19zj7TS2OA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706090265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3wmf3wu6pEhYmgZge+vax11EPN8UmQlBJ3MKJwRgPqg=;
	b=JuE8dMyG1DzirAos71dCRDjOy5/p1omOuBndfeO5yDfRmn3PjR1Y4ky6aesAnUtAKEnMcw
	fHO0dp4q6MSbhsCA==
To: Junxiao Chang <junxiao.chang@intel.com>, bigeasy@linutronix.de,
 tglx@linutronix.de, rostedt@goodmis.org, linux-kernel@vger.kernel.org
Cc: hao3.li@intel.com, lili.li@intel.com, jianfeng.gao@intel.com,
 linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 2/2] printk: nbcon: check uart port is nbcon or not in
 nbcon_release
In-Reply-To: <20240123054033.183114-3-junxiao.chang@intel.com>
References: <BN9PR11MB5370AED9C562F9DA75093557EC742@BN9PR11MB5370.namprd11.prod.outlook.com>
 <20240123054033.183114-1-junxiao.chang@intel.com>
 <20240123054033.183114-3-junxiao.chang@intel.com>
Date: Wed, 24 Jan 2024 11:03:39 +0106
Message-ID: <87il3j9hpo.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-01-23, Junxiao Chang <junxiao.chang@intel.com> wrote:
> Try to release nbcon only if current uart port is nbcon, as it does
> in nbcon_acquire.

The release needs to undo what acquire did. Why should it have its own
checks that would cause it to _not_ undo what acquire did?

Keep in mind that an nbcon console could be unregistered while another
CPU is holding the nbcon lock. The port lock (and nbcon lock) are
protecting access to the hardware. They are not related to console
registration/unregistration.

John

