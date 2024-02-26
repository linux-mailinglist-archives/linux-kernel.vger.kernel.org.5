Return-Path: <linux-kernel+bounces-81494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8E18676A4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9261C25018
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25ADA128832;
	Mon, 26 Feb 2024 13:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YhLG2hT5"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63927E570;
	Mon, 26 Feb 2024 13:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708954410; cv=none; b=dcS6WuQ3ygfHITECcqFOXJvUBd2+Nul93FWGwcLUU4lktgCRLARFVR28shNbTGynNNC3wtlxfOGHo0j+T3yblgtmW7BCkuoJhI8T14pIXoxo6GS5QgKn291jYeV56bVKbYSCZDfr/DSEeH5ZqNhsh/MHVQrHPS7RUpFwFK45Q/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708954410; c=relaxed/simple;
	bh=3sQB4Jid9BCVU9AlXki1bBaFE8YjYmogAbihbNOrFeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCKppzTUt6MoFdaJLNkl3veMGmRsuTlul9nKw1XYb+9wR6ZryXXAOGklUcmir57aYOLvbvPh+bX33jBbMw80YfHol5I9ccHZgnXpu0DucJ1mP4xe+o2hznyoj2osGeQJlE1PpPI31TdMKRmBlfUeY9ifpMcpYug993a/VMH3QpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YhLG2hT5; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708954407;
	bh=3sQB4Jid9BCVU9AlXki1bBaFE8YjYmogAbihbNOrFeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YhLG2hT5r9yJlvjsvgSV/ulegdGL2uUzzxX7vRWZTZKICKmnCss5QAxdlWw9+P0OV
	 6pxaMnU0xOOti/P0xBtaQmarWNa3nBP4Xi5hHiEHl7UxhimXEKEIL6VhfFEuQOUL3G
	 Md4dvvOffhOjARRAv4fAxoyGsEFbgChBjgMSgfMVw+ONiT7cu+025HFnmlR5EjxAVx
	 IkPe6YXQ/vCYiH6oN8432f5G5ET04yqZXmEY/ZqTehz5g73YGK1pn6CinbzrJUq/fe
	 Gup7eMaYlS3Vjpit80eUf2Ij4tzauW5/mQ5jNFO8Y+cwPkNsZQAC2tCrC5gzEKhnsm
	 X5Hs5n0N7nXWA==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sebastianfricke)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id F12E73780016;
	Mon, 26 Feb 2024 13:33:26 +0000 (UTC)
Date: Mon, 26 Feb 2024 14:33:26 +0100
From: Sebastian Fricke <sebastian.fricke@collabora.com>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Nas Chung <nas.chung@chipsnmedia.com>,
	Jackson Lee <jackson.lee@chipsnmedia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: wave5: Remove unnecessary semicolons
Message-ID: <20240226133326.yoa4vwbdob3kkczq@basti-XPS-13-9310>
References: <20240213140441.8640-1-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20240213140441.8640-1-thorsten.blum@toblux.com>

Hey Thorsten,

Thanks for the patch, change looks obviously good, one small thing to
note for the future, the commit title should start with:

media: chips-media: wave5:

instead of:

drivers: wave5: 

I will change that myself this time, but please do a quick git log next
time to check how the path should be formatted for the driver.

Greetings,
Sebastian

On 13.02.2024 15:04, Thorsten Blum wrote:
>Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
>semantic patch at scripts/coccinelle/misc/semicolon.cocci.
>
>Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
>---
> drivers/media/platform/chips-media/wave5/wave5-hw.c      | 2 +-
> drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-hw.c b/drivers/media/platform/chips-media/wave5/wave5-hw.c
>index f1e022fb148e..2d82791f575e 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5-hw.c
>+++ b/drivers/media/platform/chips-media/wave5/wave5-hw.c
>@@ -2315,7 +2315,7 @@ static bool wave5_vpu_enc_check_common_param_valid(struct vpu_instance *inst,
> 				param->intra_refresh_mode);
> 			return false;
> 		}
>-	};
>+	}
> 	return true;
>
> invalid_refresh_argument:
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
>index f29cfa3af94a..8bbf9d10b467 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
>+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
>@@ -92,7 +92,7 @@ static int switch_state(struct vpu_instance *inst, enum vpu_instance_state state
> 		break;
> 	case VPU_INST_STATE_STOP:
> 		break;
>-	};
>+	}
>
> 	dev_dbg(inst->dev->dev, "Switch state from %s to %s.\n",
> 		state_to_str(inst->state), state_to_str(state));
>-- 
>2.43.0
>
>

