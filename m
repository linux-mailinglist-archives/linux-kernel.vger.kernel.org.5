Return-Path: <linux-kernel+bounces-112633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE681887C42
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 11:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BFA1281D48
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 10:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728721758E;
	Sun, 24 Mar 2024 10:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQiCeTpH"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B02117559;
	Sun, 24 Mar 2024 10:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711276305; cv=none; b=Eo1qb3ktCy3vX/Kawq/wBoPh93MD3xIgjxjEUvnOlvJK1R9qfFHC14N2QKX50/HdpPBrRpBnO7GBRma+y7mnDy8qeV6Vv4Vik0fwzCnLQGV0Tg0IUb9f+86eGAyjYIR063sm4P/25XhbQbi+xztMJ6142MVfTIp/7le8Mxj0w2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711276305; c=relaxed/simple;
	bh=SlUKX+vpE5/tUofA5xnCFLMt/y1YnwkKM0QuVaQkt3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVc1eLPlhIiBQGkio48uwBx9af3EhqzYAzJ5iG7j1AfZOY5kkRziCdcBZqUlP/k7aZLTlIwXqysPVt3VwnqkgacRdVuQ/1l/ybzZaoRoiglqYtPvI+BjGpTCcRQWjIev+idRpltuVznlHc+JAGRDjW5hajsqY1TWQMMqgXrh+kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQiCeTpH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41482aa8237so7008035e9.2;
        Sun, 24 Mar 2024 03:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711276302; x=1711881102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rQyx9cpHkhk4sWfUXICYh7TCfwztYm/UYhwISHKdM1Q=;
        b=eQiCeTpHa76U6LBGyuvV4dqx22ys0cQkRcuPBUilHZ/srQw8uCxkl4bBwSu013fN/O
         QF025E+ByZ8eUMlCTCjckfr1GS9KeS3FGjq8DRQqs881fBYTR3DJ7DMNAujsNnT7BIRe
         gT97SZ587OabKKxhSII2EXFWhlQ6q6WseVDdMaXkHB/01JJjBWou4jKkG2oT7dCHx6zq
         MMots10s7C29YMqqKbVut7O8VPjeJZgAhXcmeJoeOod7XWLR/SZ6y1WmGiI17rNClqQH
         SlkM1/4NoHkHq4N9tMeGg9X2c3SKdnE98uWnEDYDbxyWjl18b7VlbXGnjea9iGOT6uk5
         CRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711276302; x=1711881102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQyx9cpHkhk4sWfUXICYh7TCfwztYm/UYhwISHKdM1Q=;
        b=dQLFCXXZGmg44oBDVIzgQW9BN5X4Zpp6fCfa2lOoV75Cg3og+p+8bzZXxXI2uNUfcS
         QmDalu/k6JForckEgcx4/z87mZejhZNzxiWpM6Pe57iuQIHnMi9TwQdlKVsQ1H3lYJA/
         aP2Oj1ZVLKaCYk98d0Ne5TclpOzAhS8rCdzEj9UGYyH2m+NQ9amDqQSG17spSfQr3r9v
         vvk0GpDgsfRk6/mZ+YmvoA8oJYoQaTWglGHq8fyRhyrr0aKegJn1IrbwUE2R714LtrAf
         rF1lP48HXoYVRdvI0aKlL+hXBD0F1Woz8tswVpW7eNBXxINxR0YUfJZDoDJc7Ku27yi7
         AZfw==
X-Forwarded-Encrypted: i=1; AJvYcCWMStuFnlWuKolN1pIurO0nQSN34Kjr04ifjSeVHKZCKGOVRYhKD5tTQTE9IxqaZkaPLm5VK1LKtzKVVhrIM9x8v4bCVf56iK4kfx1qI5rYAHQZw5N6yihKZ5tpJE495zr4+xx3
X-Gm-Message-State: AOJu0YxSUCCioxT1vcS9cUi9chzx7FpvX+nFT3YjP1hIYHzNtpcQV0lZ
	Nun839DMI7UDz8sHygmOpPzrhH8VVsZ5NkLD1hgeVu2OnuU2Gwch
X-Google-Smtp-Source: AGHT+IGjLy01aO9r5B3GkKksauwntrKkor9blN2uaDBKNhlfd/tgRSqfW1/ieOqNiBxvigUAZ25tlw==
X-Received: by 2002:a7b:c055:0:b0:414:5cec:a9dd with SMTP id u21-20020a7bc055000000b004145ceca9ddmr3643664wmc.38.1711276302185;
        Sun, 24 Mar 2024 03:31:42 -0700 (PDT)
Received: from gmail.com (195-38-112-2.pool.digikabel.hu. [195.38.112.2])
        by smtp.gmail.com with ESMTPSA id x18-20020adfffd2000000b0034181bea3b0sm6554504wrs.3.2024.03.24.03.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 03:31:41 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sun, 24 Mar 2024 11:31:39 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Steve Wahl <steve.wahl@hpe.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	Pavin Joseph <me@pavinjoseph.com>, stable@vger.kernel.org,
	Eric Hagberg <ehagberg@gmail.com>,
	Simon Horman <horms@verge.net.au>,
	Eric Biederman <ebiederm@xmission.com>,
	Dave Young <dyoung@redhat.com>, Sarah Brofeldt <srhb@dbc.dk>,
	Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>
Subject: Re: [PATCH] x86/mm/ident_map: Use full gbpages in identity maps
 except on UV platform.
Message-ID: <ZgABC1oQ9YJW6Bw3@gmail.com>
References: <20240322162135.3984233-1-steve.wahl@hpe.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322162135.3984233-1-steve.wahl@hpe.com>


* Steve Wahl <steve.wahl@hpe.com> wrote:

> Some systems have ACPI tables that don't include everything that needs
> to be mapped for a successful kexec.  These systems rely on identity
> maps that include the full gigabyte surrounding any smaller region
> requested for kexec success.  Without this, they fail to kexec and end
> up doing a full firmware reboot.
> 
> So, reduce the use of GB pages only on systems where this is known to
> be necessary (specifically, UV systems).
> 
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> Fixes: d794734c9bbf ("x86/mm/ident_map: Use gbpages only where full GB page should be mapped.")
> Reported-by: Pavin Joseph <me@pavinjoseph.com>

Sigh, why was d794734c9bbf marked for a -stable backport? The commit 
never explains ...

If it's broken, it should be reverted - instead of trying to partially 
revert and then maybe break some other systems.

When there's boot breakage with new patches, we back out the bad patch 
and re-try in 99.9% of the cases.

Thanks,

	Ingo

