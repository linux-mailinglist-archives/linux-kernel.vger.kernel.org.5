Return-Path: <linux-kernel+bounces-38679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F1E83C402
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DCAA292C4F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D075917D;
	Thu, 25 Jan 2024 13:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRogPOmC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7245915E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 13:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706190434; cv=none; b=FUhKBsyKLg+DdpfRrkTRL37sCdH7fux3VZwIsekUD4gPXAFNp0unOLWBNsisOy7mNpB60vG9Jo7E+1CwHCZYzIO/3VtV6EgdqSsMf4MuMQoR01dZOSfVlmKw5uCkPaleSVxN4uD0ORW3gBRY71NnkmCeGFrLz26OC1+GdmQ8lFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706190434; c=relaxed/simple;
	bh=1G6jYzOR6vQQqD33kePpFlK5C3Xw+9GJHJ462DCaibQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UGxFtpdIlolYXZ9mupsepwooX9hbuI9dJSTlfacJmgsIJoXRah0j0P2shoj+6H44SzA3dTWkoFAMzrS/XkMh+LGWvz0+Iq96ZjDjN77PRiO56yS6ZG+zMhX2KQ5Qryekv+fW31A9awVrkJhGBj4PdVNXURUarWs1y51hWtG/N9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRogPOmC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A344EC433C7;
	Thu, 25 Jan 2024 13:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706190433;
	bh=1G6jYzOR6vQQqD33kePpFlK5C3Xw+9GJHJ462DCaibQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FRogPOmCoSFpsaJRqx0YzXGkiuL/ZumXTTs0guih/pvI6SA3nyOgSU6zSby2ym4Bi
	 L4zHzxUfaCuaHJ72Rzt6hlbDigM/I7aLuPYLewzpJhivHp5dgz3caA3YvL3KVY2mqO
	 eAV6/ISNcoo03+xnVs1mshdVolzvsLEJMDw+D6Dgt6eZAQEQArb7itwBBCLOx4uPUi
	 FWdq6LG+HrX6oIByFHY9sIkVpejqS6fDXklWrtsQimjGT6HoVIUHP+kOhYykqmap0g
	 vfoNxdLREtC9WT8F4q6RbmIOd8hODS0K2jbVq9EtSeCH+b+zg1LlYj1Ss+va2jUTB4
	 qPJUMgGcvCdHQ==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, 
 Maciej Strozek <mstrozek@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
In-Reply-To: <20240123154259.81258-1-mstrozek@opensource.cirrus.com>
References: <20240123154259.81258-1-mstrozek@opensource.cirrus.com>
Subject: Re: (subset) [RESEND PATCH v3] mfd: wm831x: Remove redundant
 forever while loop
Message-Id: <170619043237.1474160.1073776055156365922.b4-ty@kernel.org>
Date: Thu, 25 Jan 2024 13:47:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Tue, 23 Jan 2024 15:42:59 +0000, Maciej Strozek wrote:
> Current code excutes only once despite the while loop, so remove the
> loop. Also msleep(1) will likely result in a larger sleep, so increase
> its value for clarity while keeping the same behaviour.
> 
> 

Applied, thanks!

[1/1] mfd: wm831x: Remove redundant forever while loop
      commit: 1e0ea9e75ff3f395ad6f85f0be2258ef114a53dc

--
Lee Jones [李琼斯]


