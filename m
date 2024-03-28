Return-Path: <linux-kernel+bounces-122938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F74C88FFD5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 983F428817A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0440180603;
	Thu, 28 Mar 2024 13:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjkKoVwQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B2F7F488;
	Thu, 28 Mar 2024 13:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711631297; cv=none; b=kDvuIf1nZ/07VHUV4ymiEtrb0ZiriSmWGCOTbekox+myatvTsVssEXg9seh4DLFeOXUuXSRCPdndH86dQi8Asfjn0sX1DCTzwID6L+vyKaYzHP+WNMzFWS4f/aBMi8U1SODHPnzJarZu67W2BX5B2gMaIHeAXIO9daLIMB5YdmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711631297; c=relaxed/simple;
	bh=nShQvEWBHWFkHeUvTXhbDAYLvFW0P8doKSZGdt8MvuI=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=AN+B38ojtv3Ujho8R+2H2ShpcG2e92/oriDFEeRbbLlNnyqqQ3OVhdcjWDUC5obwmoE5sBNOTOz05mze7DKPbopsbSjo/AQaEg1spUXis0Ey5+tuNpIRIuKrf3eUwUGA7zL2km0ib/PDNKdZgPpAqz0KycHseqEvuSIvoOIj7Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjkKoVwQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0484C433F1;
	Thu, 28 Mar 2024 13:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711631296;
	bh=nShQvEWBHWFkHeUvTXhbDAYLvFW0P8doKSZGdt8MvuI=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=UjkKoVwQrROwSq73YwDIuiTrCSQZORLenJpjokIRrD+XNzf3/uY7PHRmSYY1ZSn6T
	 12IOGyhNLap82s6+lHGUDUSUrFP+0B/+y5nXKiAuV0D+KCAeptqdKxdqZMNpWDiqCY
	 sHxZK6L4XBO350+Z+l4t4Vgh3B8hqB0GO9fjJRmfswFYO1rNM/5aiKD1dfCFkvIUIU
	 jHCaYGFeZjE1tNoypMRBvuvWqIEzADfty3RXOBCkZn2XRrwl35A0QqthJjsHJhYISU
	 hccPxmrYw/QdBp9kTbxlmqfrkeak/6Bs4To9Mis8+JhsYb7nGoUP5QUne1xf1bTq1+
	 bSNYo1WaqVmhg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH][next] wifi: mwl8k: Avoid -Wflex-array-member-not-at-end
 warnings
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <ZgDrhe5pbV/WvDiZ@neat>
References: <ZgDrhe5pbV/WvDiZ@neat>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-hardening@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171163129374.129280.17590412225670656069.kvalo@kernel.org>
Date: Thu, 28 Mar 2024 13:08:15 +0000 (UTC)

"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
> ready to enable it globally.
> 
> There is currently an object (`header`), at the beginning of multiple
> structures, that contains a flexible structure (`struct mwl8k_cmd_pkt`),
> for example:
> 
> struct mwl8k_cmd_get_hw_spec_sta {
>         struct mwl8k_cmd_pkt header;
> 
> 	...
> 
> 	__le32 num_tx_desc_per_queue;
>         __le32 total_rxd;
> } __packed;
> 
> So, in order to avoid ending up with flexible-array members in the
> middle of multiple other structs, we use the `__struct_group()` helper
> to separate the flexible array from the rest of the members in the
> flexible structure:
> 
> struct mwl8k_cmd_pkt {
>         __struct_group(mwl8k_cmd_pkt_hdr, hdr, __packed,
> 
> 	... the rest of the members
> 
>         );
>         char payload[];
> } __packed;
> 
> With the change described above, we now declare objects of the type of
> the tagged struct, in this case `struct mwl8k_cmd_pkt_hdr`, without
> embedding flexible arrays in the middle of another struct:
> 
> struct mwl8k_cmd_get_hw_spec_sta {
>         struct mwl8k_cmd_pkt_hdr header;
> 
>         ...
> 
>         __le32 num_tx_desc_per_queue;
>         __le32 total_rxd;
> } __packed;
> 
> Also, update the type of a couple of variables and function parameters
> from `struct mwl8k_cmd_pkt` to `struct mwl8k_cmd_pkt_hdr`.
> 
> So, with these changes, fix 33 of the following warnings[1]:
> drivers/net/wireless/marvell/mwl8k.c:2353:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Link: https://gist.github.com/GustavoARSilva/7a841a92c0f24e5efdb30ce02b601eb8 [1]
> Link: https://github.com/KSPP/linux/issues/202
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Patch applied to wireless-next.git, thanks.

5c4250092fad wifi: mwl8k: Avoid -Wflex-array-member-not-at-end warnings

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/ZgDrhe5pbV/WvDiZ@neat/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


