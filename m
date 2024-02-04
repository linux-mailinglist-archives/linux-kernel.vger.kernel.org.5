Return-Path: <linux-kernel+bounces-51768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B316C848F16
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFD371C212E3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF312261A;
	Sun,  4 Feb 2024 15:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QknxAfMq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0B82260B;
	Sun,  4 Feb 2024 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707062390; cv=none; b=NFSdi76lJDturKWHxmsL6DX4tHVV12EpyPPY97jZA/qW06GprtIB4j/4sVf/XLGERX5FoWZJl2Q2nyN+4wMJFAEWnK6obEIx6kYNZr5uXY1fLNqJ+qx5gS47a2Kyr2cQRFJhOXMM6Twv8EJQeFKMt5BbTKh1Gvz6/HgFpos6xPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707062390; c=relaxed/simple;
	bh=t3HsYFgTXOlo7Ny2SN2lClkEj8ijPMmSEVVOq9rUayI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XU6kjNVrGNdZpbUNSMqwQC8LW8lhX+L5amLHQiqIL4jNJE5Io9IPbMSOg8K4Nsiu3IZKmRkM24ieU6EXE7eeMy47lVo2RxSsuZpic9wp1MGn8kd1lIvRrBkHiqRxBq4GunxywZgc4UVcGyg96v7UVa1lQWONkBW7C1kJmiAiX9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QknxAfMq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA19C433F1;
	Sun,  4 Feb 2024 15:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707062390;
	bh=t3HsYFgTXOlo7Ny2SN2lClkEj8ijPMmSEVVOq9rUayI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QknxAfMq+cEG+fIxng+UsL77QazdPYU3S1KnMnocs+iMy+GywQ+yVUBbipc+1tqKI
	 WZwqG/Fe2+eQ9BxlBfwegbmMtBKpoLLsLAeo3yQ3kfk4+PMJka5lvL71ZrMEkqKYZd
	 G8uRzDCu5r/0dVgAFaLTawlfPJJzC0NqDPKAL0zpnSuzobccBDK+TwHSyO5HVG+/h1
	 aK+jMvqU+A8jvpsEd/elVVLv9L94gx5UMQlegro/xK/f1cfOT+EW7sdOhgdY5Wk+a4
	 vQFJsdnAua4rHLv48+vtCcdgzVU9vkKil8uXnC0ziyvdHHp80NUmTdGc7ZEZpJWhEZ
	 FbGV9FWGEEE5w==
Date: Sun, 4 Feb 2024 15:59:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jikos@kernel.org, lars@metafoo.de, Basavaraj.Natikar@amd.com,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] iio: hid-sensor-als: Add light chromaticity
 support
Message-ID: <20240204155934.0a8775e4@jic23-huawei>
In-Reply-To: <20240204130332.2635760-5-srinivas.pandruvada@linux.intel.com>
References: <20240204130332.2635760-1-srinivas.pandruvada@linux.intel.com>
	<20240204130332.2635760-5-srinivas.pandruvada@linux.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  4 Feb 2024 05:03:32 -0800
Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> 
> On some platforms, ambient color sensors also support the x and y light
> colors, which represent the coordinates on the CIE 1931 chromaticity
> diagram. Add light chromaticity x and y.
> 
> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Rest of series looks fine to me.

Jonathan

