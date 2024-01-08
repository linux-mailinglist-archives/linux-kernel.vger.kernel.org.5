Return-Path: <linux-kernel+bounces-20033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C81827871
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 271091F23187
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F7B54FB9;
	Mon,  8 Jan 2024 19:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BfLyY2sL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BA854679
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 19:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7bd7f05e9bdso70984139f.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 11:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704741652; x=1705346452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gwzp6rMNkMSlHf87v7eMcP4zz6PlcLGFKacicFVvzwk=;
        b=BfLyY2sLXQI9xe5xRBWEFGS+wvbuc70bSWMoU0Z/kbOo4Ehlx/DSkXVg/R5nZHeiJW
         NbYLLOBQpmHaEbeIVyBGuB3XQcu8qHhBqFd2yKWhXQn6nrzCkxNdMn70yzJuutdslsiE
         VEOgQ9BM8ef+sMyQhyXnpuNQyGb1Q9VEVcZKbGgDw0p91bhrRpuccitx6GkpK2/QJ6Wb
         UgOJQpLNFvsv/wD5pbbQOwKUcXXBjcB9DAw+2TF948GO+s5IKyBmaG/Et55Hdaw9cuc8
         RnGQdtQRTzviBJDhYkd3AxIKIIbmtjlpnkB2bX/FsWCHuSucNJlREszez66xPNvGmG91
         6S1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704741652; x=1705346452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwzp6rMNkMSlHf87v7eMcP4zz6PlcLGFKacicFVvzwk=;
        b=gFEfPVaxDJldtnyLi2Acp4RN22XMXMkL0dQnnlf0khZQHXygY6UI4qrnsiGboYDxom
         hZ+3QrjTDbaIAtVp/3cV18xddOHpLayOxou261Dv2HsOZWYEkEq+rg1BtBNpAF4L9MMB
         ycmJ+NIbYMHzvGjw7GpszLN0xxFgrsB/OAPsq/qaoGlBzeVpLq25AVKcFpHPiAe9YVVj
         LXVa+xFPCm5RCfEJcAX2FtddcHITZreluEM1z1DcZUZCtBgTi1z+wEb7V2pooEXxkZEj
         8Rq2ZidlJMrLRimem6jhWl1Dvu2FyQy4zMm3k7n6V6sT5+fv8Gxj4xqWxqgu8KPadiUn
         i1uA==
X-Gm-Message-State: AOJu0Yx3kpXTy8T3tXDF2BKLqeSsaWWqSUtIVqGlVcFd/9DACcou/pZ/
	7VZ5TY4rXDqqcMabMqJvIFPEwImSg840
X-Google-Smtp-Source: AGHT+IEG2gGNhLCAn3BnKKG89/89IKumj2SLI8/kUwEojoY0P2qqz6xhS+/X0URoz+fTxmHyhDE2zg==
X-Received: by 2002:a05:6e02:1be9:b0:35f:a1c8:a6e1 with SMTP id y9-20020a056e021be900b0035fa1c8a6e1mr6534231ilv.58.1704741651995;
        Mon, 08 Jan 2024 11:20:51 -0800 (PST)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id x4-20020a026f04000000b0043978165d54sm141137jab.104.2024.01.08.11.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 11:20:50 -0800 (PST)
Date: Mon, 8 Jan 2024 19:20:48 +0000
From: Justin Stitt <justinstitt@google.com>
To: Tanzir Hasan <tanzhasanwork@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Nick Desaulniers <nnn@google.com>,
	Tanzir Hasan <tanzhasanwork@gmail.com>,
	Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v3] mailmap: Switch email for Tanzir Hasan
Message-ID: <20240108192048.537bcblla5f6dd22@google.com>
References: <20240105-newemail-v3-1-3dc8ae035b54@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105-newemail-v3-1-3dc8ae035b54@google.com>

On Fri, Jan 05, 2024 at 11:44:34PM +0000, Tanzir Hasan wrote:
> From: Tanzir Hasan <tanzhasanwork@gmail.com>
>
> Access to the tanzirh@google.com email will be revoked upon the end of
> the internship.
>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Tanzir Hasan <tanzirh@google.com>
> ---

Can confirm that Tanzir previously owned that @google email. His
internship is ending and will need emails routed to his personal @gmail
email.

Can also confirm that the .mailmap entries are alphabetically sorted.

Reviewed-by: Justin Stitt <justinstitt@google.com>
> Changes in v3:
> - Used correct reviewed-by tag
> - Link to v2: https://lore.kernel.org/r/20240105-newemail-v2-1-a7fdeaa0abdc@google.com
>
> Changes in v2:
> - Fixed alphabetical ordering
> - Link to v1: https://lore.kernel.org/r/20240105-newemail-v1-1-c4e0ba2c7c11@google.com
> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.mailmap b/.mailmap
> index 9a9069235f0d..36d5bd3fdc8e 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -578,6 +578,7 @@ Surabhi Vishnoi <quic_svishnoi@quicinc.com> <svishnoi@codeaurora.org>
>  Takashi YOSHII <takashi.yoshii.zj@renesas.com>
>  Tamizh Chelvam Raja <quic_tamizhr@quicinc.com> <tamizhr@codeaurora.org>
>  Taniya Das <quic_tdas@quicinc.com> <tdas@codeaurora.org>
> +Tanzir Hasan <tanzhasanwork@gmail.com> <tanzirh@google.com>
>  Tejun Heo <htejun@gmail.com>
>  Tomeu Vizoso <tomeu@tomeuvizoso.net> <tomeu.vizoso@collabora.com>
>  Thomas Graf <tgraf@suug.ch>
>
> ---
> base-commit: ac865f00af293d081356bec56eea90815094a60e
> change-id: 20240105-newemail-ccd4a5db700d
>
> Best regards,
> --
> Tanzir Hasan <tanzirh@google.com>
>
Thanks
Justin

