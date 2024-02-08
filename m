Return-Path: <linux-kernel+bounces-57974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D05AD84DFD4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EB9E1C2212F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1544C6F08D;
	Thu,  8 Feb 2024 11:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGTfgz7I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B20D6EB54;
	Thu,  8 Feb 2024 11:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707392144; cv=none; b=WJzW6u5qoxtUu/5616U4TvIKtJ3xERk2/w8zAf2JUeC/avG7QP2OFG2tupV0BjnFgCiG6+6zB98+P9BQf15AvaekT88524/EzqDoGCUWxNkr7a42QWwggglud7p4jb18/6J0Jo19a8Od9oNaE8iVTb1H5AAvbmz1nvB9Lsg6lIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707392144; c=relaxed/simple;
	bh=dbEqbs2DlZ57eJRLbS3RnNuusT5JJtnYhLOjxPF5GXM=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=u5vQiWH1p7DZfCYBqhUTgd1aJnFH9qM7j+KZXzQXxLeTrDb6SRCYduCxDSsIEoSMeehuTXycsUlwMhvId5CnK8fbogxN2iGq68W082rZvPNMU/h1VJgqUOtOPEa0uI7dcKK1lTMP468nPyNTRPZxU7jywwxXOFgE+hTuBmsZ8m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGTfgz7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A36C433F1;
	Thu,  8 Feb 2024 11:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707392143;
	bh=dbEqbs2DlZ57eJRLbS3RnNuusT5JJtnYhLOjxPF5GXM=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=CGTfgz7ILbunX8vMly1n7DggEg2KZdersB/jeWhDOVGS0RF4s82z8FXRj6uoWPjd/
	 5SIT9NGjP3KLwJ+dNzdI/Ru5XX+atVja2zo4Ae+138guuExpZXdtUMce7/hh9Toj2n
	 cu2wdFZ1Xcj5u7TpbscBXc7VPoNs2x+Anz16Eo9NwdYdUJELrXSKD5fML9h21LmfBq
	 AbAVHNjeJVz++Tz4ujFaLJYxwgFqjipJoPR5AgtvV7fr3yTyP41Dh8Vd+JiL25GtVx
	 HITW0EBenLbLky53aB/pDbIkG2EpnT7EI3Z1BNz8ORRtFg1fK+ZyeJFjr7bSIKsxIr
	 0ctmFc4EO7DFg==
From: Lee Jones <lee@kernel.org>
To: pavel@ucw.cz, lee@kernel.org, linux-leds@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Amitesh Singh <singh.amitesh@gmail.com>
In-Reply-To: <20240203162524.343936-1-singh.amitesh@gmail.com>
References: <20240203162524.343936-1-singh.amitesh@gmail.com>
Subject: Re: (subset) [PATCH v3] leds: pca963x: Add power management
 support
Message-Id: <170739214246.950581.13917324551294999476.b4-ty@kernel.org>
Date: Thu, 08 Feb 2024 11:35:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Sat, 03 Feb 2024 21:55:24 +0530, Amitesh Singh wrote:
> This implements power management for pca9633 which enables
> device sleep and resume on system-wide sleep/hibernation
> 
> 

Applied, thanks!

[1/1] leds: pca963x: Add power management support
      commit: e684dcca3659a3f88945a2a5c6fe5a156d4b0178

--
Lee Jones [李琼斯]


