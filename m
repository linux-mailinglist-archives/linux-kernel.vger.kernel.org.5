Return-Path: <linux-kernel+bounces-155150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE04E8AE5E3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66314283C42
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD0084E02;
	Tue, 23 Apr 2024 12:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="K9OvCga1"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA1182C60;
	Tue, 23 Apr 2024 12:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713874893; cv=none; b=kTjWjL8wK83qyQ1zSGMKJknptNxkTEqYscD0+FUtTR4L8RplBbdfcLmBgR+rF/tJi/UzsgL8tbkQkeBVH/Ui0i83H/sQDOARuBjwp9eEyfraX5hmyQhUPn65cv3Mc1uy+mrtknioWa9ciwZUBNr4QDDNySP0BFSTEX1PNfsbesc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713874893; c=relaxed/simple;
	bh=jGvAPhh5VW4fYO/D1OLd4bVzXz1IC7v3zJgq8hBP5Lk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ey1/uwMm4nSHhedZst2Gom6hs+yaF+qYIKSJoyADJT4UboIoooGA/BecZ817sYVqndv3ce49DoKHWkpSl0AxyzSN/PwvKN8XMS05d9EvtCoMxB3dFSy2L+u8USmQ804a2su0T+sCqQBX4iabiDzSya49eKWbocvJD+FZYT2JbKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=K9OvCga1; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1713874886; bh=jGvAPhh5VW4fYO/D1OLd4bVzXz1IC7v3zJgq8hBP5Lk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K9OvCga14y0WBgcruPsbzLBOtne4q8Mi7z2LzUbWS5fvaD1ouhUt8qir6CVg9LtRm
	 GZ+CIyI0LqMuLbvxZ9Gj7kZUlr17NDTHYcTfwE4WNIiICbmE+US76WPXFxytbGbfyz
	 BuDlgD29P6natxwYgrJgm1G0Obc5E2f1SfwsrMy8=
Received: from localhost.localdomain ([58.213.8.145])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id EB2B9A45; Tue, 23 Apr 2024 19:58:50 +0800
X-QQ-mid: xmsmtpt1713873530te3l2kvca
Message-ID: <tencent_5C4968C62CB4BF868761113A754124143108@qq.com>
X-QQ-XMAILINFO: NVviswOLIctoag8HirS4vhs5DaIAsMSDiT63tBsS7GQfqirzHH9nDuk9t5shdC
	 07bq+ZNHZ0tyP5Mp9aURyqwPltvbH7mClpV/r9wD4kik2mh9odCO/1N9/tyEI9WPL9InI+P0pjZG
	 2Hjne0JrrMrT2PeroFvelrJW5uJTRK5GvxTgQ0Mr8KSRfaS5JX1P5YgP2v2Yx3g4k0NF7QDKe/4c
	 OCVQetDfqY7O6B8isNpJWdYSh2wMLoGIWpOXmxeel5PnqQeDdxECBE419vl3Bb3R32CoBKGdXiZe
	 zUtn9zgE6r2QLMY3UKhCVQU9sHMZo3YCvkPBuh3LcSb+7AATOO5xAm6tCnT6VxmDSaZA1d6F78hu
	 JMPwKbtSwEkSi1ny44f2ikSC3iUxnHINYGy5a0KtZoBjJSI2JWqI0mum+XqcuB9qgW+FXBlE+y+5
	 RQ6SkMEhmNMEx+BONNHVd4c+lWbwlsxIZhA35AsKYF1IfbNhBlkp+uWQA0KK9TvefUVJnn81KuX3
	 ysrRq7db7iH5pjJRG9hDy2dVY5rucdX/Y/X5JuZ7xGSqjQ142yPJNzBr4sitGXuMFvpJmIKFEBVM
	 poN3QtIonhgMjBbiJBRK63eWs568BMm8S6lXi9jzD7GzibcpfPMCg8jCh3XB3SbNLCkMBuZOf+mH
	 iLB7K4tcUVW9rEFrS6wJorLMepePQLki3JM5Hvp2uD1Ud5pi8hBRWejiXmf00FRmWB2Nq7NPIH8g
	 6mxxAN6RSqkjPiVma71l1XgUkz5EmcnW5RHdhGq/OciwPWQE8JfVxg2ERSlzJnIz92Zyqc5Wj6hp
	 qdJSMuUx5Z973Z57zPCBIVQyZFNhDLKfR6mxfNNCzKlSNh+8rY+xwL+18xYTdezs1SUk3+F42aIC
	 6tDUIzjyBGaE44bO0xs6ZEzbKAcm4+kH8p4Y2JCe/gbgPTm3usg/HLSHF9AybynMchjgkZrc+3Ez
	 WUZo/W1vq69RBAayxxcNSIXVPFq6FiKNerZnLjOrS5/EMaZ2FXHHJ4WXdUAVYr6Xl4o8fPb1Q/Tn
	 eZaMBZ8g==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: linke li <lilinke99@qq.com>
To: razor@blackwall.org
Cc: bridge@lists.linux.dev,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	lilinke99@qq.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	roopa@nvidia.com,
	xujianhao01@gmail.com
Subject: Re: [PATCH] net: bridge: remove redundant check of f->dst
Date: Tue, 23 Apr 2024 19:58:45 +0800
X-OQ-MSGID: <20240423115845.78992-1-lilinke99@qq.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <b1fccc7c-3c9f-45e0-979f-f83dfc788613@blackwall.org>
References: <b1fccc7c-3c9f-45e0-979f-f83dfc788613@blackwall.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for your advice! Should I submit another patch with subject
"[PATCH net-next] net: bridge: remove redundant check of f->dst" or
"[PATCH net-next v2] net: bridge: remove redundant check of f->dst"?


