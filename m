Return-Path: <linux-kernel+bounces-8224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4237C81B3FA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 741991C23CD8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34433745E0;
	Thu, 21 Dec 2023 10:40:59 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0D36EB66
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 10:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Swn5Z0FJqz4xMw;
	Thu, 21 Dec 2023 21:40:50 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: npiggin@gmail.com, christophe.leroy@csgroup.eu, Kunwu Chan <chentao@kylinos.cn>
Cc: kunwu.chan@hotmail.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231204023223.2447523-1-chentao@kylinos.cn>
References: <20231204023223.2447523-1-chentao@kylinos.cn>
Subject: Re: [PATCH v3] powerpc/mm: Fix null-pointer dereference in pgtable_cache_add
Message-Id: <170315510015.2192823.7515374595652036540.b4-ty@ellerman.id.au>
Date: Thu, 21 Dec 2023 21:38:20 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Mon, 04 Dec 2023 10:32:23 +0800, Kunwu Chan wrote:
> kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure. Ensure the allocation was successful
> by checking the pointer validity.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/mm: Fix null-pointer dereference in pgtable_cache_add
      https://git.kernel.org/powerpc/c/f46c8a75263f97bda13c739ba1c90aced0d3b071

cheers

