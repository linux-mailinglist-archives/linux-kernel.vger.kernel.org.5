Return-Path: <linux-kernel+bounces-138359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 721F089F01B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 355F0282AAF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E369159219;
	Wed, 10 Apr 2024 10:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xz7tCpLG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834EE13DB9F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712745863; cv=none; b=B50oAjPwn14S5ulafMFjR7SNRHFSMm9SrMaLm2W25NYG2Yzb4V5uGPENSWcfXz5Fob+bKF+ZCNnbiMfQMKr8BEwMW0t84kC9FMUtf5Er8MyHv2HdxnJQqNgOKwyWBDdFAnU8PBm67llMsjuwpSdMMLHCwSKDdCsZ2hCWspByg4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712745863; c=relaxed/simple;
	bh=Bk3mwOlBc8d/2rqp8L4enHpQiDZEZfTlKgGkqsDe1Zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M/0yvVW3O8tbuDyxzKyeEYP/LUlwBRGuL1sBxEKahmjtmUn2FZ6hZdl6SyqtugINv2Jqnzfb40gQ8HfiyxxdfqWhWwo/vbMpReiz7Wb+uyl7GC4ejviKzbn971YvjxQqc/smUFcPrEdwEfzLSwf79r3O6jOk+36Sy/iq74Lyy6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xz7tCpLG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CEFC433F1;
	Wed, 10 Apr 2024 10:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712745863;
	bh=Bk3mwOlBc8d/2rqp8L4enHpQiDZEZfTlKgGkqsDe1Zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xz7tCpLG9ar6z+Y/r9n8bZ7HT+B/o0Kk0fIXgtfjbVmFvZM5xEtkHSkhZ8+LyfE+H
	 4brxdgGzZmLals5+10vmSg0PtVo9Aj5MyhWaqSz4UtvdcoVE7za1I5z64KMlvbpskT
	 pmhFklgSupwkOlgipyPVGSJCLBshLwyPQIMjdpIGXeggHuNVNdUwD9OfS0DesealuZ
	 vPOgEy8lXk3DlNeeNKH0sH8VM9CPDNixtnJl4qMY9UKp1eDERR9zYGH9ss40YUA01d
	 CSgTppu4qDzUnN3WUMwwjyJmQLVo/OlmLIG0GN9N9UqPwieRgrsSodST9FS0K/pNPQ
	 l7++WqZZPT6aw==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org,
	Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] RISC-V: drop SOC_SIFIVE for ARCH_SIFIVE
Date: Wed, 10 Apr 2024 11:44:15 +0100
Message-ID: <20240410-scarce-lyrically-63677063159d@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240305-praying-clad-c4fbcaa7ed0a@spud>
References: <20240305-praying-clad-c4fbcaa7ed0a@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=488; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=L9aP10EtX7u+zgE1Cd5w8MLZr4gSnhW66FKNakw9VNQ=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGliuQ33vDnsWFucnITXK1U6yXStCpwc3szavJtvb5d9z KvlLB0dpSwMYhwMsmKKLIm3+1qk1v9x2eHc8xZmDisTyBAGLk4BmAjLe4bfbEzP79St4gv+eDLr rcMFDfHCY1eWCFflzv0XcubPRs5/qYwMnXm/RTfs3/XF8nDVa0a/Qyah/inztBdv+yRSqLxJxiy OBwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Tue, 05 Mar 2024 18:37:05 +0000, Conor Dooley wrote:
> All the users in the kernel are gone and generated .config files from
> previous LTS kernels will contain ARCH_SIFIVE. Drop SOC_SIFIVE and
> update the defconfig.
> 
> 

Applied to riscv-soc-for-next, thanks!

[1/2] RISC-V: drop SOC_SIFIVE for ARCH_SIFIVE
      https://git.kernel.org/conor/c/d2a351e63779
[2/2] RISC-V: drop SOC_VIRT for ARCH_VIRT
      https://git.kernel.org/conor/c/1553a1c48281

Thanks,
Conor.

