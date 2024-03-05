Return-Path: <linux-kernel+bounces-92041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC443871A23
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78AC6282B20
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2C654750;
	Tue,  5 Mar 2024 10:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3dghNzo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9054D9F9;
	Tue,  5 Mar 2024 10:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709632981; cv=none; b=okn3MITzxwXZjUyOReKnhSxNwAhNj1BaI8A/eCDJ+4hNO0CkSf7U9VHQ6aMewBikeu0hRI7IQDpzBwWCq0dJaWhy09/4elpNrbkZbEeEvjjaEFQYGej0SeNFPNgYA5ezPPBdw5tBG+9S34Imv3HQQiIyKqC7u9FL9F0Up1hbckQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709632981; c=relaxed/simple;
	bh=CK3hGEkomyEWi++yHT0MA62YvDNmdI7jRyt+cZI+39M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8LUoWJSRkJxZLnL/ueoS+5BXqh9Q+470ocb9798O+EKA983pv2k+hSqS8t6NodPwVEUeDy26VHWajl41Z25M/8CtwyCjOgeaXlGNELOyzBlRie/S2dTdXwumrx4BhDw7eTqd/JZteFptLJZ9Nc3OTFeRQ3GrRU/9brdmR+DXSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3dghNzo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48687C433C7;
	Tue,  5 Mar 2024 10:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709632980;
	bh=CK3hGEkomyEWi++yHT0MA62YvDNmdI7jRyt+cZI+39M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q3dghNzo7HlmbEOACI4bncZhwmZXipl+TemetSV+yqFniCeRIAGEv/1goTgQg9DKA
	 QuDNmDvcvUkBEAxItcYPDEah06kSVtuBKKRpVu50+yiPNIQabzdSkEkvRFMgBaWT0/
	 HwXzBrNkDSLAPZDmNOCB5dnQAMXvO01gizNb3wldqr9DvHpXzYt2SxggwaBKv1W+M0
	 2VxYi7BjXCcoWjK9n3WtKDUEuZq/tQsM1B4aH1ZhH4qOQtgerQf/cIX0gGMjPPigu2
	 IE50Z0Q6VXaxXItvGljUFpi8L4lfoe6383qzPkDl3KLgUoT2aM70YzGNxJS93D6rk2
	 2seRVT/1pMKrg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rhRdb-000000004md-0LEo;
	Tue, 05 Mar 2024 11:03:07 +0100
Date: Tue, 5 Mar 2024 11:03:07 +0100
From: Johan Hovold <johan@kernel.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stephen Boyd <swboyd@chromium.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] Revert "tty: serial: simplify
 qcom_geni_serial_send_chunk_fifo()"
Message-ID: <Zebt2_BTiYSlgxtJ@hovoldconsulting.com>
References: <20240304174952.1.I920a314049b345efd1f69d708e7f74d2213d0b49@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304174952.1.I920a314049b345efd1f69d708e7f74d2213d0b49@changeid>

On Mon, Mar 04, 2024 at 05:49:53PM -0800, Douglas Anderson wrote:
> This reverts commit 5c7e105cd156fc9adf5294a83623d7a40c15f9b9.
> 
> As identified by KASAN, the simplification done by the cleanup patch
> was not legal.
> 
> From tracing through the code, it can be seen that we're transmitting
> from a 4096-byte circular buffer. We copy anywhere from 1-4 bytes from
> it each time. The simplification runs into trouble when we get near
> the end of the circular buffer. For instance, we might start out with
> xmit->tail = 4094 and we want to transfer 4 bytes. With the code
> before simplification this was no problem. We'd read buf[4094],
> buf[4095], buf[0], and buf[1]. With the new code we'll do a
> memcpy(&buf[4094], 4) which reads 2 bytes past the end of the buffer
> and then skips transmitting what's at buf[0] and buf[1].

Good catch!

> Running "ls -al" on large directories also made the missing bytes
> obvious since columns didn't line up.

I had not noticed this in my limited use of the serial console on the
sc8280xp CRD, but sure enough there are garbage characters and missing
characters in the output of 'ls -al' before applying this patch.

> While the original code may not be the most elegant, we only talking
> about copying up to 4 bytes here. Let's just go back to the code that
> worked.
> 
> Fixes: 5c7e105cd156 ("tty: serial: simplify qcom_geni_serial_send_chunk_fifo()")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Tested-by: Johan Hovold <johan+linaro@kernel.org>

and as Jiri already pointed out:

Cc: stable@vger.kernel.org      # 6.4

Johan

