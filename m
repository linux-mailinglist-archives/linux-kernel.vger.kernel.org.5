Return-Path: <linux-kernel+bounces-8221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C755081B3F3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 837D92823F4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91EA6EB7B;
	Thu, 21 Dec 2023 10:40:57 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECD06EB4F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 10:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Swn5W4MLjz4xKl;
	Thu, 21 Dec 2023 21:40:47 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: npiggin@gmail.com, christophe.leroy@csgroup.eu, bgray@linux.ibm.com, maddy@linux.vnet.ibm.com, bigeasy@linutronix.de, hemant@linux.vnet.ibm.com, anju@linux.vnet.ibm.com, kjain@linux.ibm.com, Kunwu Chan <chentao@kylinos.cn>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kunwu.chan@hotmail.com
In-Reply-To: <20231126093719.1440305-1-chentao@kylinos.cn>
References: <20231126093719.1440305-1-chentao@kylinos.cn>
Subject: Re: [PATCH] powerpc/imc-pmu: Fix null pointer dereference in update_events_in_group
Message-Id: <170315510019.2192823.17458008321780037269.b4-ty@ellerman.id.au>
Date: Thu, 21 Dec 2023 21:38:20 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Sun, 26 Nov 2023 17:37:19 +0800, Kunwu Chan wrote:
> kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/imc-pmu: Fix null pointer dereference in update_events_in_group
      https://git.kernel.org/powerpc/c/0a233867a39078ebb0f575e2948593bbff5826b3

cheers

