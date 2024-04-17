Return-Path: <linux-kernel+bounces-148977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F41C8A8A03
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412C41C222C8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1C417166B;
	Wed, 17 Apr 2024 17:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpSZP5e2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0514171099;
	Wed, 17 Apr 2024 17:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373928; cv=none; b=jARXfdIdnpHt/E2OrZE/dlbB51yQU8cOeSq4853jPEQRc5xYgitC5Lv7lM7HLXpMfmKqRTBNNM3kkVSH8lK2bhlqxjJf5zNUS1EshmswUPFGri/R5KUelUi6gyhqERFwm9TQPsfKxiOliFyicKD1yaxMLhHidDagwh86o2zqnps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373928; c=relaxed/simple;
	bh=Ngmd4BE+uLFutb7aXZWf16icIoWGI3EyNo90wGKobhY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VlLG9/7w/ofUqOj85yb7grgH79i2V8DfbzHTZrE/JYUatqoPIDXfBnIzREzCfDY7MZc+HwjzgAJlV9V8+ysJnuUGggpx81ymUIm3wUQqHqcWOo0HZ0WskSIlQ9VWObVh2z7V/8b0QRBXGZuRv1dddE2+ZRuTp4T0AiEoXtQeW0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpSZP5e2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F09BC072AA;
	Wed, 17 Apr 2024 17:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713373928;
	bh=Ngmd4BE+uLFutb7aXZWf16icIoWGI3EyNo90wGKobhY=;
	h=Date:From:To:Cc:Subject:From;
	b=bpSZP5e2NimQ13JaAcOW3gtmCK9xlIy3bXB64SAHh2A70pom5RGNHaNUuaWyCHghT
	 T8j6FbCnVEAjp2wdsUiwUy+sc1pioef5NN9yiK/x3IFDXTyfP7ji0T6bUpkW9Ndeqk
	 42FB3EPpBjiEoQJvdO1klGihFcC4QCCtwAeC9srp1Z1/giWEh24T2WEy3GSIJoESmr
	 tuTmv0FsBfsAK+r4A5AldEII8vIYcdVvRG93Zc0mnbkmATjE+VJ9ofWnOzd6k0qeWv
	 GJ0y9GhstG/rSzoFXqOCaZM4/pyzDz9SyRaO1F3/dQk44mx4G1YrmUKELuBBpG4wrC
	 VW+qxBeAndIGA==
Date: Wed, 17 Apr 2024 10:12:06 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: conor@kernel.org, ojeda@kernel.org
Subject: Prebuilt LLVM 18.1.4 uploaded
Message-ID: <20240417171206.GA1819161@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I have built and uploaded LLVM 18.1.4 to
https://mirrors.edge.kernel.org/pub/tools/llvm/.

If there are any issues found, please let us know via email or
https://github.com/ClangBuiltLinux/linux/issues/new, so that we have an
opportunity to get them fixed in main and backported before the 18.x
series is no longer supported.

Cheers,
Nathan

