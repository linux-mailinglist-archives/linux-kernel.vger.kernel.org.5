Return-Path: <linux-kernel+bounces-154357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B308ADB30
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F32D91F224BC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF57C14292;
	Tue, 23 Apr 2024 00:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcJWmRTK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2B812B95;
	Tue, 23 Apr 2024 00:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713832732; cv=none; b=ts4V3BfmJMEU/eUMunB5oiUWeVX7efsBSzLlhf+y1o4GYZ8KYLqD6j5caY671j6KyCFHhTmigj4zRD6vqHBlrPLp4LJc4cq4leVDHaWcuC8DUYTWaIMj7WKZOLjGSyErWhM2lL0NCROFJbxtsR3b3/Vv4bUISQu88Jrlfv7nNwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713832732; c=relaxed/simple;
	bh=E9+RsWxIjC2HxdWYdJ7u8cdMUO7bM5Px2e7ZnnhAzGk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HtcmatFmlm/DpnaLsdEIMuegGWWbbqpq0BUHo0fXox3ZII7pH+ZJ+K8kUYN8K3agtMr8gzwNYnRP2/zL9/KytxAAnqeJhiynD78tSFcsyfhNZ/uGaE9UVPFpIhZ8oPNQDboL9yZoDTts6I54vAQnon2M+81+PjVuYvkIi7ZePgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcJWmRTK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2194C113CC;
	Tue, 23 Apr 2024 00:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713832731;
	bh=E9+RsWxIjC2HxdWYdJ7u8cdMUO7bM5Px2e7ZnnhAzGk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qcJWmRTKEX7PM2lNDSUeg8aeMkeG3vVIZhIwcKMkEtkiMWAp+9hGW3I5UNxdCUFcg
	 0TDmiqd0tzLXL13mRvvyTlkESLga2Fl5ZOyGNT8xD+U57atfczXgMbNTukv/FjJDqO
	 EVoMLJtErqOsX2gLOPuJknTzMvSZBybgquwxSL/Sx5Ft+L+q2q9G4uMkuYN+lgMwZQ
	 qNOCUXU6rWmnbEeJx1Aiju9IpYpwREavecfM6Urrw6+6aNWzjtxue1Pj6DF3Y96s3B
	 KtdyH1zeJMRbFvr3woeZKbbQ3Z1XxD6Ujj7Y4er6wXGc57F0bcoXv237PZo2kLUwPB
	 RfUBUB5LmKaJg==
Date: Mon, 22 Apr 2024 17:38:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jun Gu <jun.gu@easystack.cn>
Cc: dev@openvswitch.org, echaudro@redhat.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4] net: openvswitch: Check vport netdev name
Message-ID: <20240422173850.2222305f@kernel.org>
In-Reply-To: <20240419061425.132723-1-jun.gu@easystack.cn>
References: <20240419061425.132723-1-jun.gu@easystack.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Apr 2024 14:14:25 +0800 Jun Gu wrote:
>  	vport->dev = dev_get_by_name(ovs_dp_get_net(vport->dp), name);
> -	if (!vport->dev) {
> +	/* Ensure that the device exists and that the provided
> +	 * name is not one of its aliases.
> +	 */
> +	if (!vport->dev || strcmp(name, ovs_vport_name(vport))) {
>  		err = -ENODEV;
>  		goto error_free_vport;
>  	}

Sorry I applied this before I realised that it's buggy.
dev_get_by_name() will give you a reference on the device.
You must free it, so the error handling is different.
Please follow up ASAP to fix that.

