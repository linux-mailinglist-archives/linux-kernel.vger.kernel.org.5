Return-Path: <linux-kernel+bounces-85550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBA386B78B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08EC91C20CB2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782AA71EC3;
	Wed, 28 Feb 2024 18:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beUFeDxZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF78D40849;
	Wed, 28 Feb 2024 18:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709145971; cv=none; b=CGvAwL7nk4wAq/BMWEELUDZvKCKIg1USD3RdQLT+YJO2AtN2fiFA20laTjfP2cUbjaw6CVdsaWIU14VD72pRBohZtB/mtnO9YcloseK6GuRaJqfivCQQFLNrLyTnRCrRQYGtjOX2seAOt3Eoqc6pA1IwzzohpksZP5Ru38nGNTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709145971; c=relaxed/simple;
	bh=H0I4zsx6nQtDiPwTywepV0T7BHo3m2Gw6dx6hzN/UHY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZXkLAiSA8kag/71wgJR9kMuv4yJ0HB6XUeQaSyx62N/+Z5SaE5hhvrUDSkd88JOu9eBTgNTqtWOGVQg/GnmHcuOkC/jy5rm6QH1+qv97m28KfIm7R3pcp8w4hyKXeA4u/ZrJ13JRanx3py5wedcUH337aXyuNTXQhDGAtpSBj2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beUFeDxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B09C433F1;
	Wed, 28 Feb 2024 18:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709145971;
	bh=H0I4zsx6nQtDiPwTywepV0T7BHo3m2Gw6dx6hzN/UHY=;
	h=Date:From:To:Cc:Subject:From;
	b=beUFeDxZgH008qepuHn/4aGPKVXgGdISWp0651nHubmfPeV2KjsVzdJN71XJlGeoq
	 eEbSk7D/OYGUubDnHq4pQkj1+BG3GMopcvKghDKMWhF4+SytljC48+sh6NjN8SyiyS
	 L2pIDTHWHHkN8QHl3TX1UrDJR6+W83vl1eNyW0ERuvQ1T6N1JKKLzNQHazJxuTWyLq
	 C9BXUsj0buO+CN5BrCH1HXFtSCXjIHjBo/8YPzW+oidkYnGY6MOaLEup4//DaTgKR9
	 aOdmyHhgE1mHcQQvb+9La030YbDKggIt7b9FRpGM+8OXoplIat/9Z3y1oO1vN1zryJ
	 vpLXhtDoE29lg==
Date: Wed, 28 Feb 2024 11:46:09 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: conor@kernel.org, ojeda@kernel.org
Subject: Prebuilt LLVM 18.1.0-rc4 uploaded
Message-ID: <20240228184609.GB139944@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I have built and uploaded a prebuilt version of LLVM 18.1.0-rc4 to
https://mirrors.edge.kernel.org/pub/tools/llvm/.

As with Linux -rc releases, this is not the final version that will
ship. If you run across any issues, especially ones that were not
present in earlier LLVM releases, please consider reporting them to us
so that we have a chance to investigate and fix them before the final
release.

Cheers,
Nathan

