Return-Path: <linux-kernel+bounces-166779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 894108B9F6A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F0061F2411D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4832A16FF49;
	Thu,  2 May 2024 17:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsfN4bM4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBBF16FF31;
	Thu,  2 May 2024 17:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714670648; cv=none; b=PUzKrAnKZSwpNGsPrdQy4HbI06YuLEJS8kVebeAiUEuvh2FE97ZYLJfPcxGpiZZIKvvxi3xFh3R3zkcmahXbax4HkWrd5IM7I9nIwiYg5K6nCvJEmPmWiNo5wg8KB4dpoCiL3ZBldrC0bBNfashM5GidxZ726DtBBU9iM06FQrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714670648; c=relaxed/simple;
	bh=sZ14UICOFl5R+3avnCWhvEbLwBr21/jd+jDx6Z4O1Jo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BQFbt8gzJbz0i7iczoJSqy3maGYI6luLh3zCF3Fkhd252vgjOZkwe8/b1EyWfRUYc3BvqZHNxVaKET9e0BmShv6ldvLrXV+9FFYmuHS6nWxFfgJLA8TykszV173QbnYdMn2vp11MIEMzMKw66zoWdPjf7mMiVAZzB0Cx1/O4YxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsfN4bM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F78BC4AF1A;
	Thu,  2 May 2024 17:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714670648;
	bh=sZ14UICOFl5R+3avnCWhvEbLwBr21/jd+jDx6Z4O1Jo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AsfN4bM44k8tmJ3Yd1FCmdaF8LszcJCHE69Kq9CNgATB9TfdrviC9HMHXliKucxTo
	 KLTIEbzswYv2COzR9yB3WA2QujefQ0FXEwZmYz3BlfblgIyojZJpmMkPj/iZmXuAro
	 0cp90u1FBBH3hnCoXze4RpiHO8vkDiD/MPmLw1LWXC0dYbegAzJ7ipWCpKBGKGXqAH
	 eETHXD+1AiXI7f7XCIJRXBicJJf3zrut17a/xSb/vm+5Yms6AXCBDctZh6mTMSF/YK
	 8/0Te7mQa63+uXoIqwPRzEUKcAYaHcDj+ADQLZLnJ3q5eX/yVqFSw3gpWpCMeRqT51
	 8UXKyOpDvBJ7A==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, nm@ti.com, vigneshr@ti.com, kristo@kernel.org, 
 j-keerthy@ti.com, Nathan Morrisson <nmorrisson@phytec.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, upstream@lists.phytec.de, 
 w.egorov@phytec.de
In-Reply-To: <20240429195830.4027250-1-nmorrisson@phytec.com>
References: <20240429195830.4027250-1-nmorrisson@phytec.com>
Subject: Re: (subset) [PATCH v2 1/2] dt-bindings: mfd: Convert lp873x.txt
 to json-schema
Message-Id: <171467064532.1224868.13241585164664001110.b4-ty@kernel.org>
Date: Thu, 02 May 2024 18:24:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Mon, 29 Apr 2024 12:58:29 -0700, Nathan Morrisson wrote:
> Convert the lp873x binding to DT schema format. The gpio-controller
> and #gpio-cells properties were removed from required because using
> the device as a GPIO controller is optional.
> 
> 

Applied, thanks!

[1/2] dt-bindings: mfd: Convert lp873x.txt to json-schema
      commit: 7fcb2977c0b55c2d11aea3a6baa4c59d53709041

--
Lee Jones [李琼斯]


