Return-Path: <linux-kernel+bounces-49772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C78846F34
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692411C2413E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D76313E22B;
	Fri,  2 Feb 2024 11:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhIbFC28"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D881C144609;
	Fri,  2 Feb 2024 11:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706873980; cv=none; b=S/oXL8mVKS24sVjeLsDBKU2kGnL0iUEGYM2oBjWExj8AhjGZ5gnSAMzomAZuEjx6ZACdqFPKDqzlKqcYyarcvSxETnaRtvsDV9i6LJ1jdPvKeBu/oe55BmJ40dzjvw93SV3knU27u4bLw9khHQNiwiMDaiUwwgeubTHhn8aVShc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706873980; c=relaxed/simple;
	bh=dRBobT+WpmPRhfZpKodvcWF3fz4dYA8o9bU+A200sUg=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=Dp8ZXWnhl6CVF0GCKkNCiDgKjuVi8N9t3InvYLVweczebz98qo8768cTl56+eG2rNYATX2xRcrncSASixS2MBW5dRS/S0QAZslT+cZFFxILtYfi0TIgbtgMn8TaRc9RXsCAktSzTPx8ad/actYrWDp5Ft1w0a4wsiJ9pQvuJeKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhIbFC28; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CBEC433F1;
	Fri,  2 Feb 2024 11:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706873979;
	bh=dRBobT+WpmPRhfZpKodvcWF3fz4dYA8o9bU+A200sUg=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=WhIbFC28dX/QlDe3zsQcauhfu/X/VglmFxp/cO+mN+Ek023qw6BBZ81JlxNTMFeHC
	 pAFwtKEqVEdsCDvsxf5le/7s8Prexm8AEjlo0AkN/cyoNgYqxEU1AgLuSZegLqCwzk
	 MmUhfMtp91iqPlGKd9HjpZdf4kPJv+ShgNKcdwtgnyhVyPccZ+9TYKphy2IMCJkOij
	 IcftNHQfYzfDi+HMGIggGrIBOawfnQy2q3ShwCjASYKO1nKxyYr2mkB0iRgY3aPv9A
	 iZZicaoz+lpmZ7WPXHxEw9Qb71tkm7X6nfAnshXB1r+q2Tpm7qOa9R/EN96hDKg0aj
	 C6+klghILNm5Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] wifi: ath9k:  remove redundant assignment to
 variable
 ret
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240116155452.2315351-1-colin.i.king@gmail.com>
References: <20240116155452.2315351-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170687397628.3200018.17782967291636533113.kvalo@kernel.org>
Date: Fri,  2 Feb 2024 11:39:38 +0000 (UTC)

Colin Ian King <colin.i.king@gmail.com> wrote:

> The variable ret is being assigned a value but it isn't being
> read afterwards. The assignment is redundant and so ret can be
> removed.
> 
> Cleans up clang scan build warning:
> warning: Although the value stored to 'ret' is used in the
> enclosing expression, the value is never actually read from
> 'ret' [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

08d82175bfbb wifi: ath9k:  remove redundant assignment to variable ret

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240116155452.2315351-1-colin.i.king@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


