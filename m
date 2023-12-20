Return-Path: <linux-kernel+bounces-6279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3DC8196AF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 533131C24D07
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCDD8486;
	Wed, 20 Dec 2023 02:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jaNCwrYJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA98BE4C;
	Wed, 20 Dec 2023 02:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=qya6je0ihv2fYYW7NmvzCuKXAHEO5f9H1K55chikLeg=; b=jaNCwrYJINLKkNUD/DMaMQLTq+
	TXriMQsriA6uYn/PlkbsrJWVwyfUNNVQe7KjdOlXDG7I+PgNnrKqq5VpbkEZwwT69p5asd7Xa2h6E
	NHOgfLi08rjkIpS3svfxj9JL1oCq9ops8eGDcfYtQWDdQ+VsCNDTMSv6pjdkcL+xuUjfxkF12fWn/
	txOPHFTnlzBYfNFDeFlxobQ+KO+oO6SMR2gpKxaZUlln9bYGHhuQXQWahWag2ullhz7xlArLyS3+e
	wJXb0XapysHLF1uhindIJUPE8w7N8LTHOLMtFWGsVDCBKQQhV72PgfS6efUk7hetby2TN/C4ntPGf
	V9GP1YNg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rFlym-00Fx9I-0K;
	Wed, 20 Dec 2023 02:06:36 +0000
Message-ID: <e4077345-0b0a-48a3-a710-cefbd2fcaf15@infradead.org>
Date: Tue, 19 Dec 2023 18:06:35 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ethtool: reformat kerneldoc for struct
 ethtool_link_settings
Content-Language: en-US
To: Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
References: <87zfy5g35h.fsf@meer.lwn.net>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87zfy5g35h.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/19/23 15:53, Jonathan Corbet wrote:
> The kernel doc comments for struct ethtool_link_settings includes
> documentation for three fields that were never present there, leading to
> these docs-build warnings:
> 
>   ./include/uapi/linux/ethtool.h:2207: warning: Excess struct member 'supported' description in 'ethtool_link_settings'
>   ./include/uapi/linux/ethtool.h:2207: warning: Excess struct member 'advertising' description in 'ethtool_link_settings'
>   ./include/uapi/linux/ethtool.h:2207: warning: Excess struct member 'lp_advertising' description in 'ethtool_link_settings'
> 
> Remove the entries to make the warnings go away.  There was some
> information there on how data in >link_mode_masks is formatted; move that
> to the body of the comment to preserve it.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  include/uapi/linux/ethtool.h | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
> index f7fba0dc87e5..50253287c321 100644
> --- a/include/uapi/linux/ethtool.h
> +++ b/include/uapi/linux/ethtool.h
> @@ -2128,18 +2128,6 @@ enum ethtool_reset_flags {
>   *	refused. For drivers: ignore this field (use kernel's
>   *	__ETHTOOL_LINK_MODE_MASK_NBITS instead), any change to it will
>   *	be overwritten by kernel.
> - * @supported: Bitmap with each bit meaning given by
> - *	%ethtool_link_mode_bit_indices for the link modes, physical
> - *	connectors and other link features for which the interface
> - *	supports autonegotiation or auto-detection.  Read-only.
> - * @advertising: Bitmap with each bit meaning given by
> - *	%ethtool_link_mode_bit_indices for the link modes, physical
> - *	connectors and other link features that are advertised through
> - *	autonegotiation or enabled for auto-detection.
> - * @lp_advertising: Bitmap with each bit meaning given by
> - *	%ethtool_link_mode_bit_indices for the link modes, and other
> - *	link features that the link partner advertised through
> - *	autonegotiation; 0 if unknown or not applicable.  Read-only.
>   * @transceiver: Used to distinguish different possible PHY types,
>   *	reported consistently by PHYLIB.  Read-only.
>   * @master_slave_cfg: Master/slave port mode.
> @@ -2181,6 +2169,21 @@ enum ethtool_reset_flags {
>   * %set_link_ksettings() should validate all fields other than @cmd
>   * and @link_mode_masks_nwords that are not described as read-only or
>   * deprecated, and must ignore all fields described as read-only.
> + *
> + * @link_mode_masks is divided into three bitfields, each of length
> + * @link_mode_masks_nwords:
> + * - supported: Bitmap with each bit meaning given by
> + *	%ethtool_link_mode_bit_indices for the link modes, physical
> + *	connectors and other link features for which the interface
> + *	supports autonegotiation or auto-detection.  Read-only.
> + * - advertising: Bitmap with each bit meaning given by
> + *	%ethtool_link_mode_bit_indices for the link modes, physical
> + *	connectors and other link features that are advertised through
> + *	autonegotiation or enabled for auto-detection.
> + * - lp_advertising: Bitmap with each bit meaning given by
> + *	%ethtool_link_mode_bit_indices for the link modes, and other
> + *	link features that the link partner advertised through
> + *	autonegotiation; 0 if unknown or not applicable.  Read-only.
>   */
>  struct ethtool_link_settings {
>  	__u32	cmd;

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

