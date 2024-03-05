Return-Path: <linux-kernel+bounces-92495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8944F872131
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF59FB2579B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF0186658;
	Tue,  5 Mar 2024 14:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hhZTzsnW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1340386644;
	Tue,  5 Mar 2024 14:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709647948; cv=none; b=sDmRyFrzvYndyelvvlGiWhqfYa8xEhpoNuLoydKS9ui7nnKjxBSyIwkI6FXpvRAYfl5yztIWZotpCyuv1OJKvGR2KoVrBO3lBJ3jW9mUyBpGizCRZ+KGOKhSx7ksnr/F5kQW9s1aP+3Orw3oeGR6e4J1O160fuCBcL/okAg8cM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709647948; c=relaxed/simple;
	bh=+jda2PQeIqR0FrCF7MkTx9P+41fy0010X+zrU2T3W8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJJa7+sxT/YPii9e8cEQz7oUVM6Gj3FuLOAM50eCCt6OqJOcwuYWnhBHHqafcg+UQ6wJDteGUGFToQ8dLFKRPmdb933/aW3UjOeEj+08c2Lt7Go8qsYP8J4yQGrPOU6YVcmd2nco6ZbD/gGRPMu7Zsaro6uj6iqP2X4F5sJ6dyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hhZTzsnW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471C9C433C7;
	Tue,  5 Mar 2024 14:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709647946;
	bh=+jda2PQeIqR0FrCF7MkTx9P+41fy0010X+zrU2T3W8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hhZTzsnWOPRwQYH8zsD85wy+/atYOC1RSNoB+WbMH5jmapEBHeY1AXxgIxjyrclWb
	 QKwXgdzRSwDpMQTh2rWEj5uNKtB9u7fyBuySbAQ7jPajaWAKEx8E8gAryPBfNqtcay
	 0FrtaQ8JH4CLlxlKBnf+jmEEmtrXTWd1bmcMWD3M=
Date: Tue, 5 Mar 2024 14:12:24 +0000
From: Gregkh <gregkh@linuxfoundation.org>
To: Aman Sharma <210100011@iitb.ac.in>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] Staging: pi433: Updated bitrate range from datasheet
Message-ID: <2024030515-diploma-husked-d76a@gregkh>
References: <34c89fc61663a5ecf3d83edebefc6b00@iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34c89fc61663a5ecf3d83edebefc6b00@iitb.ac.in>

On Mon, Mar 04, 2024 at 03:56:09PM +0530, Aman Sharma wrote:
> Updated bitrate range for FSK and OOK modulation from the RFM69 Datasheet.
> The values are mentioned in Section 2.3.2 of the datasheet.
> 
> Signed-off-by: Aman Sharma <amansharma6122002@gmail.com>
> ---
>  V1->V2: Added explanation about values in commit msg
>  V2->V3: Added version comments after changelog
>  V3->V4: Corrected the Signed-off-by line
> 
>  drivers/staging/pi433/Documentation/pi433.txt | 6 ++++--
>  drivers/staging/pi433/TODO                    | 1 -
>  2 files changed, 4 insertions(+), 3 deletions(-)

This patch is corrupted and can not be applied :(

