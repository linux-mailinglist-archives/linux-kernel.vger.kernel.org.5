Return-Path: <linux-kernel+bounces-23373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BFD82ABBC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031571F28921
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA5912E6B;
	Thu, 11 Jan 2024 10:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pB2wA90P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13E712E56
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 10:15:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D03FC433C7;
	Thu, 11 Jan 2024 10:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704968152;
	bh=D6sS/Pceji4FThqKIJkfmA1PpZmWrYTLa2K2XCUK5AU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pB2wA90PxKYaSonI6IKfyrmUV4x17tyatawufFTgBUpKAszNfTp79NaqpPuGIZ7u2
	 t0PzHvbFE3zGNyjhB+c5EJbSVEPYGf3YnYjMfPtk5NQ9KN3412r1DvrV0pVnA8obSu
	 VvrACsNAEvay1l2cQoxvyi/u8oCmvmLRy3Coz2K4Xv/gRHWK9sVZi92CduHPksyQ5K
	 reRsBL4v7xUVcj9KK1TlJoyym0EKabbpa7ebbCVlpUMG4X97AjnPnsIwsK0ma5JZGW
	 tUMUcTKgV25mtrFEmAq6tvdw4Izzv2zblAG0xC9ls7WyoJCKKUP4E//RBeIlen/1AC
	 TRDlHfNGyF10g==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 linux-kernel@vger.kernel.org, 
 Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231221185142.9224-1-alex.vinarskis@gmail.com>
References: <20231221185142.9224-1-alex.vinarskis@gmail.com>
Subject: Re: [PATCH v4 0/2] Fix LPSS clock divider for XPS 9530
Message-Id: <170496815117.1660675.17225837755492911459.b4-ty@kernel.org>
Date: Thu, 11 Jan 2024 10:15:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Thu, 21 Dec 2023 19:51:40 +0100, Aleksandrs Vinarskis wrote:
> Dell XPS 9530 (2023) uses spi-pxa2xx with clock-divider enabled from
> intel-lpss with the ratio of 1:32767 (Dell's firmware bug). This caps SPI
> controller's speed at very low value of 3051Hz, which makes the interface
> practically unusable. Since either spi-pxa2xx or intel-lpss should have
> clock divider enabled, not both, and SPI controller can have higher speed
> than requested by the device, it is preffered to disable intel-lpss
> clock-divider, and let SPI controller handle it.
> 
> [...]

Applied, thanks!

[1/2] mfd: intel-lpss: Switch to generalized quirk table
      commit: d43b5230c38ed6001f996eb9262b457713b31ef8
[2/2] mfd: intel-lpss: Introduce QUIRK_CLOCK_DIVIDER_UNITY for XPS 9530
      commit: 106362167f49a0e83f4e6c26f9653f3061575229

--
Lee Jones [李琼斯]


