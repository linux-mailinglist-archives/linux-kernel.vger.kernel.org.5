Return-Path: <linux-kernel+bounces-145467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E230C8A5684
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64AD0B22ACA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C146F76046;
	Mon, 15 Apr 2024 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9zao9fW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F97080BF5;
	Mon, 15 Apr 2024 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713195165; cv=none; b=GpX9TsoZyriAkmQtDRvDL/Fhy+GGKqFU1KDzIWbJM4AQRpDcvZ3nsQ8meZwVnAeSA2G8puytZa3+821e/5jPMDmhvTRMuMgBowF+hFwH39PB4AzvKQt2w0NwNp8gIrlRq1opRK1gGdvQeIc5VqZfBzlofMejZDbTpn0HxNuUVBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713195165; c=relaxed/simple;
	bh=xQYU0e7X39DSajVS8rhXQ8Da6tifi91BKqm4wTgtmCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XSh4M5hfEkywgTc2CW8idDkQN/E4yCHDXHh2FU5W5ZFaF1AKb9l2EzJStcWIHgIQSC0Jdg2S5jYd1ZLT5vaCM5mvneI6JtAaTYqyt+R0wkxSn3Iuzm6m91aOW9oPNm++Xz1HRQVsgj97/bjwb+wvEX9l2fb+GEHycKRF9wc63GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9zao9fW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1E3C4AF08;
	Mon, 15 Apr 2024 15:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713195164;
	bh=xQYU0e7X39DSajVS8rhXQ8Da6tifi91BKqm4wTgtmCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q9zao9fWypDb5owZQLC9RQqNQgusD6wLSs9G1KIccnC9I1OE92AdBFYfxrbwsfXtB
	 7pY5Uox28KLcfro/G3puHy6GnGGUjzLaqhvNwDa7Rb4RjxUGXjmhrnyEnzSvErupr0
	 ixX/7RMQBasUr1QaY9Wq4W2wUyOD3C0F4QTdwT62mpyTTkXVQwXBlmAPkC63w4i2h/
	 MB7yX3UUrqT8y9rUxGV7NhHL/SIGNzwdE5gGCo/zp1MaUBZsmb6uilJht0uSD38rO1
	 sZBOpIiRr/sJTbhjKzTNupj7fJ3IzJboan3tVNcjAJsEIdPn3JK7TObKnVjpxsDBCe
	 gbDEO1O1DuXDQ==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hannah Peuckmann <hannah.peuckmann@canonical.com>
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Walker Chen <walker.chen@starfivetech.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	Xingyu Wu <xingyu.wu@starfivetech.com>
Subject: Re: [PATCH v1 0/2] riscv: dts: starfive: visionfive 2: Remove non-existing hardware
Date: Mon, 15 Apr 2024 16:31:19 +0100
Message-ID: <20240415-tabasco-avalanche-5dc660e5701a@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415125033.86909-1-hannah.peuckmann@canonical.com>
References: <20240415125033.86909-1-hannah.peuckmann@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=807; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=m4UTRyLnDIb2TXMDA83B0GKpyfK7QjI3ZTJ599y3sUo=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGmyHu6KF62be57ZP1D6xSz6W2Jmp+9BWfWp1x2/H3fdn mirWXWqo5SFQYyDQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABPJK2D4K/Hj5Y5rdl6rq1qP mC6pEA5IOiHySJTZZ8v8O0/eb/31upjhr+Dq3ncGMyZuOur6TUzTL+v/BgHVrwZidSH8H29OFet w5QcA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Mon, 15 Apr 2024 14:50:31 +0200, Hannah Peuckmann wrote:
> This series fixes the device tree for the VisionFive 2 which has nodes for
> non-existing hardware which should have been left to overlays. It also results
> in error on boot when both both the TDM and I2S drivers tries to claim GPIO 44.
> 
> Hannah Peuckmann (2):
>   riscv: dts: starfive: visionfive 2: Remove non-existing TDM hardware
>   riscv: dts: starfive: visionfive 2: Remove non-existing I2S hardware
> 
> [...]

Applied to riscv-dt-fixes, thanks. I should've probably realised this
when I merged them - thinking back I think I might even have had to do a
conflict resolution. Sorry about this.

[1/2] riscv: dts: starfive: visionfive 2: Remove non-existing TDM hardware
      https://git.kernel.org/conor/c/dcde4e97b122
[2/2] riscv: dts: starfive: visionfive 2: Remove non-existing I2S hardware
      https://git.kernel.org/conor/c/e0503d47e93d

Thanks,
Conor.

