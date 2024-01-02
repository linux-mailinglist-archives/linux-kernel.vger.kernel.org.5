Return-Path: <linux-kernel+bounces-14749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E996682217D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 887121F217A7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D043715AE1;
	Tue,  2 Jan 2024 18:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffQR2hdY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2809315ACB;
	Tue,  2 Jan 2024 18:56:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF7EC433C7;
	Tue,  2 Jan 2024 18:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704221795;
	bh=gz17Q3LaLNGONzrG9Vd18+Rs9Kn8xf75GWaFmkYvJ2s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ffQR2hdYeYhSSld6+xMKJq7DquJ3aj22oQ3BnlQ8EEBYAYkTvxdOzWCUvC4rOCgvW
	 YckSO7kMz3OSrQ/60SZ7R+DeivVSKZRQBlE2DZUB3g41aMDIIRYAux44CYvUs8Utb0
	 9u0HsBFWHmpI57uSKmXPDtVSrx+bnO/G7m4/8lqcxaK/8gGWCgOPblqjKGlyEF9hXT
	 z2bHOByE5WNPnG+X6X7wIEsO8HX3IJP0M1C+Qu7c1dOfru2cLmv8YLylzCBOgi4ZJV
	 QdkVgg0iCpXUyfSsYdzeEAOU2+RYGskmhhudBJn+f4ahLoiip+GLC1lllDVrWvNKu8
	 HsGXHEKRbazHQ==
Date: Tue, 2 Jan 2024 10:56:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: richardcochran@gmail.com, jonathan.lemon@gmail.com, vadfed@fb.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ptp: ocp: add Adva timecard support Adding support
 for the Adva timecard. The card uses different drivers to provide access to
 the firmware SPI flash (Altera based). Other parts of the code are the same
 and could be reused.
Message-ID: <20240102105634.177aadc7@kernel.org>
In-Reply-To: <20231224134724.21676-1-maimon.sagi@gmail.com>
References: <20231224134724.21676-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 Dec 2023 15:47:24 +0200 Sagi Maimon wrote:
> Subject: [PATCH v2] ptp: ocp: add Adva timecard support Adding support for the Adva timecard. The card uses different drivers to provide access to the firmware SPI flash (Altera based). Other parts of the code are the same and could be reused.


Please reformat the commit message to separate the subject from 
the body of the message.
-- 
pw-bot: cr

