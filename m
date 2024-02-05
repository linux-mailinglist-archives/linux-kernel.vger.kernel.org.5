Return-Path: <linux-kernel+bounces-53343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 542B884A37C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ED042895E1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9444745C9;
	Mon,  5 Feb 2024 19:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ciCvQyym"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A196EB48
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159798; cv=none; b=hin32AqV0AxrEx0pgCZ+I3EWhZYp8tbAmrrSDsXpGAbudJWNWLkc+c2AQLK2gIEoIy8EdHyvM7koSO65PZJ5b/j+d1OcHFv+RNur/1QT9wMN5YMxZJLLKPIJ01RC3NvXYDfCICDdbdKAJQpegMVPw4cyapD26lYlXTYwlgKfZIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159798; c=relaxed/simple;
	bh=SaE5fyHUUm1NkAMFFfv91SoNo9DgaZQmpck7+KsBLoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qsNvuYrq8f6mcm8HNuWdNIw73QPHRaUNWI/7K8WnlVFop5UitE6TOxzVl/YOjSHl3CS1mA84rpAf4YBGYdWPVr6a/oeejgdvSap9XDxsNw3G+9Ebn+UiHcWEeQiNdAXb7Az0velGO4h+kI+LZ9RMwbfTUweXlhP4FgTkGI/cXo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ciCvQyym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440DDC43399;
	Mon,  5 Feb 2024 19:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159798;
	bh=SaE5fyHUUm1NkAMFFfv91SoNo9DgaZQmpck7+KsBLoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ciCvQyymBxhKwoAIvb1VMfW/wdYgjc/oGsTxnMcmsXJlZogWru271dn4RfWGey4Tx
	 uSXLb0p3WEG/6Nd4ubtzFqJsEqxQX9eCVh/oCVuLSMM+Z/FFCf9F/CI29pcAY1NDPC
	 +6nXisUB1uyKbH7SuPxD0fJoZTxMeCXaYG/7v6mo=
Date: Mon, 5 Feb 2024 04:47:16 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parport: make parport_bus_type const
Message-ID: <2024020510-october-lividly-83fa@gregkh>
References: <20240204-bus_cleanup-parport-v1-1-e6a0f756bbb8@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-parport-v1-1-e6a0f756bbb8@marliere.net>

On Sun, Feb 04, 2024 at 05:25:51PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the parport_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

