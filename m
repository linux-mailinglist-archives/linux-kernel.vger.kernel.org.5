Return-Path: <linux-kernel+bounces-166480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FBD8B9B41
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 259DBB21FCD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C97383CB0;
	Thu,  2 May 2024 13:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dx4FGICF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDEA80025;
	Thu,  2 May 2024 13:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714655025; cv=none; b=mvO1Soe4koWRxW3Vv3GDGmKj6B1sxoUI+qaAuSP+/jvFQ9e3wub0BfWUc9VjF+peIDxtaEai050KPW6/YurZIvm5/3H/5z1GlAxy0mUDJ1NqNkQx3W+TQajgDH3U+E0pOq6xCCQaqKg7z9LSo/bUHpRbaWFhmghcleQr/mvP0eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714655025; c=relaxed/simple;
	bh=TIF4FMSqrUlFRETJ/qfFlessQJ7mkpFvx/oyhHmPOA0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=okvvveLfjqCb56gwtL37AshA+1Jy06yyMvqyOjKo9DBCctQmorqruvmZnNuJz4/jJec4jtQf/lO6NyCIOI/+luZ5S1avJ+oFzHqRAaynxPI3pRVy8QVQd3NhAK5C1fKXOCs2JWGmCpr5G2oWKL1Mv7wP+zPpesIFCwiESR5SdUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dx4FGICF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5CE1C113CC;
	Thu,  2 May 2024 13:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714655025;
	bh=TIF4FMSqrUlFRETJ/qfFlessQJ7mkpFvx/oyhHmPOA0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Dx4FGICFI8dwY9memwTfLSH/wX6LmZItbuUmtNwTmVLf+poeqBMDLbsAsffR9kgBr
	 K62S5c8wgV4RJUReC92Df3i5gpKksOgMVQRHMbRhBQOXTUybYovn3m4Deo+CfSf0He
	 9/6yr2mnOnwsvXq1i+5Otvf6DdYpf6wRoOUI6nVQ6RlVOJ2ob+TQ9eU69eqGNaAQtL
	 54WKmR2t72OJy3onr2/mwmVEjkQU6xnBhGRf3iPthuvubW4WUs++v0YQgBdIbA4FZg
	 JAJXOPbM6bl3fbAn0RnlOFee1fat3DV5tzPpVyfC+h7XJI+S+cuv0ofEgJdUdpTyoH
	 6XXFPMj/u74pg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Masahiro Yamada <masahiroy@kernel.org>, Nathan
 Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Nick
 Terrell <terrelln@fb.com>
Subject: Re: [PATCH v1 0/3] riscv: make image compression configurable
In-Reply-To: <20240502111613.1380453-1-emil.renner.berthing@canonical.com>
References: <20240502111613.1380453-1-emil.renner.berthing@canonical.com>
Date: Thu, 02 May 2024 15:03:42 +0200
Message-ID: <87y18scqmp.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Emil Renner Berthing <emil.renner.berthing@canonical.com> writes:

> Masahiro's patch[1] made me wonder why we're not just using KBUILD_IMAGE
> to determine which (possibly compressed) kernel image to use in 'make
> tar-pkg' like other architectures do. It turns out we're always setting
> KBUILD_IMAGE to the uncompressed Image file and then compressing it into
> the Image.gz file afterwards.
>
> This series fixes that so the compression method is configurable and
> KBUILD_IMAGE is set to the chosen (possibly uncompressed) kernel image
> which is then used by targets like 'make install' and 'make bindeb-pkg' a=
nd
> 'make tar-pkg'.
>
> Patch 3/3 depends on the previously mentioned patch below.

Nice!

Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

