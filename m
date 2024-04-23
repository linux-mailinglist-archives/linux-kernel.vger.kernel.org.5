Return-Path: <linux-kernel+bounces-154345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B448ADB1A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC1CBB232F1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78510C142;
	Tue, 23 Apr 2024 00:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFClGBI+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B997A2F48;
	Tue, 23 Apr 2024 00:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830527; cv=none; b=C54Se1coCDlIydDRL+Z1guhQ/t2MhbcaE5fHxu+YeZlyGnC1O0fjROJ30zpXTvXXxpJyZJS9EkfUUlT/BbF/E4zvG4zwGqdhGFhgPOakUPuoRcAlgVCrImcGyXX1abWEX9J9/9v5oe7p17XnvNrKX6OXFygCOnQsuWYxhKmLJnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830527; c=relaxed/simple;
	bh=bHLvYXhRLIPy4suZ20NDYE9iMbpvxI2GEPyCSRYFUvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vFzhENjBgKGuFLyAJIMR0Y8iuQezEHatYc92ExO91Wi3qxMiG5fODXQsCb+3OSNZAw+fuPVjeoifD1AismBq9kQoi6mynUUvyXBrpJurDez1+yHsJMQFp6mQFV8w8/0nqzfPrDl8YtQjUB8w4MWUwczk3HkOhPsE5Jk5aEEi2Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFClGBI+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4292C113CC;
	Tue, 23 Apr 2024 00:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830527;
	bh=bHLvYXhRLIPy4suZ20NDYE9iMbpvxI2GEPyCSRYFUvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uFClGBI+5LsxfmzcgobjoVs00EeldzoL09O/ka0bUDS0hDo6o9KDGLqdDGLitSMhb
	 tcRuEH4Utg6OHwiRJdy1Jfu180yutVxljwMRSX/Ci0wOecnxB+D95jlmavOQyGGyfB
	 KdLB/Cc4TVIEQG4LPWErABck5o51zLKg9Un2A6RQCneG67W/7rQ1fDQ7qOpyiyZGrc
	 axPExbj9+2Iq0WmYByExmWVqhC+KtQbAb0WdJthTFoCIS/y4+FEdbswDehEja+LZiM
	 qhHMsG0l/HD/2mKc7EZZxITSgCNXGDOPvWaUKb1kzoQlzYhfycbnKk4OLeuxTuo/f6
	 kli1Nxlo7FLwA==
From: William Breathitt Gray <wbg@kernel.org>
To: William Breathitt Gray <william.gray@linaro.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: William Breathitt Gray <wbg@kernel.org>
Subject: Re: [PATCH v1 1/1] counter: Don't use "proxy" headers
Date: Tue, 23 Apr 2024 09:01:41 +0900
Message-ID: <171383041172.189737.14989786354854274180.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422144850.2031076-1-andriy.shevchenko@linux.intel.com>
References: <20240422144850.2031076-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=331; i=wbg@kernel.org; h=from:subject:message-id; bh=mTbmY1Aqtvxgqw4xiAIvBmBlKbyfAVYZVEtEmfJtIg8=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDGlqv7QVWdey/CkyazYv+Htqacn0BfW7DC9LR0zdlPvNl EHBKOx2RykLgxgXg6yYIkuv+dm7Dy6pavx4MX8bzBxWJpAhDFycAjCR1fGMDGdFj283eWi+9iLX 2m29HtvEU7PeJB/qVY9VLdGxdDhZ/YKRYabAv4ojd2wNXm7keKe44NSp1ItMc4qWrK8Rzphx+rK HKwsA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit


On Mon, 22 Apr 2024 17:48:50 +0300, Andy Shevchenko wrote:
> Update header inclusions to follow IWYU (Include What You Use)
> principle.
> 
> 

Applied, thanks!

[1/1] counter: Don't use "proxy" headers
      commit: c265838feed136c5b1f83c976ec75962331cfb82

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>

