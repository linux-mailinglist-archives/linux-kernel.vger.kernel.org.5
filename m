Return-Path: <linux-kernel+bounces-85562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA88B86B7C4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B44EB21BD8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F78671ED5;
	Wed, 28 Feb 2024 18:57:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F16C79B79
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 18:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709146652; cv=none; b=O3kDb4PeuwDiiIDutoRGAXsD2RvzggII8OpjphmafNWGr1K1MTsCco86lgSJgYI4z7870JmAC+xfCnT8znmoJmx5MgLuhrzQ2OGziczBm1CEJ/xf6vgNMvqUGYU+RqFOT7ClPmmx9k2KNytBxWoiVRuP5GLH8X0vWcQ9ANU9jHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709146652; c=relaxed/simple;
	bh=RqOqrP5vMVCybB4XK2YCnjHu0lXb4N1pfS5fiKujnx4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RINbp3uwQiYrvjB64VSp8TmMa6VV4GKy1VE3++GoCeMPQceemcFzfFG6nBg+KGCOcCQLL6mMJJTtvHI43ACSgIZWggcoqzW7Ppl8lU7CNY4pKmfKBmM9ugNZxmKbIUpWQmn80SxN+gbUix/PbiL4Xxg8ckxq6vI56C1Em4/RlEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B56EC433F1;
	Wed, 28 Feb 2024 18:57:29 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Guo Hui <guohui@uniontech.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Leonardo Bras <leobras@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] arm64: remove unnecessary ifdefs around is_compat_task()
Date: Wed, 28 Feb 2024 18:57:26 +0000
Message-Id: <170914663633.3370652.15619827146542815142.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240109034651.478462-2-leobras@redhat.com>
References: <20240109034651.478462-2-leobras@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 09 Jan 2024 00:46:50 -0300, Leonardo Bras wrote:
> Currently some parts of the codebase will test for CONFIG_COMPAT before
> testing is_compat_task().
> 
> is_compat_task() is a inlined function only present on CONFIG_COMPAT.
> On the other hand, for !CONFIG_COMPAT, we have in linux/compat.h:
> 
>  #define is_compat_task() (0)
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: remove unnecessary ifdefs around is_compat_task()
      https://git.kernel.org/arm64/c/1984c805461f

-- 
Catalin


