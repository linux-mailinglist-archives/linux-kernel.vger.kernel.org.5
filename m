Return-Path: <linux-kernel+bounces-146860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074B08A6BFB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66C1BB20E25
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C9112C473;
	Tue, 16 Apr 2024 13:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEZRIcto"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E6639FCE;
	Tue, 16 Apr 2024 13:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713273357; cv=none; b=X1Gl0lWQO1DEw7qK9kEe51vO/rObYNI0flwT2i/htyorpJ5l+IUgXTFQZ6HTEPvzGTTpz8W5JV4qRCKequw13UAa9ZUOC8OImrNuiwKzivoiLC21/94UHiXToYqVtZDcG2XzkM6C+ZdRRqvQ+XVtVCa4cyFS7Vn8n5MJ92sj22A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713273357; c=relaxed/simple;
	bh=+RaJjq58bjdpAdYGgg5kbu/PuCVvFIRqwo+91MWU5Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJ/3rVpjFQrLAOVJU5rEV1akCuxXb5JxgGZRQC7g65DE/WQUqloSr5OD+UWkDzto9fNpFysvZ/+oFnzdL8e0+IdJq2ND6U2eFdDkKmHcV40jmtbwMibRiaiSDNkek0OfKzm1WmZxxNqiycsNtisVF/SRZKJ8BAbBU+9TNkYrE6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEZRIcto; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D011CC113CE;
	Tue, 16 Apr 2024 13:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713273357;
	bh=+RaJjq58bjdpAdYGgg5kbu/PuCVvFIRqwo+91MWU5Sc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vEZRIctom5oVGbyhmPWoDp1y+g+Fgg3GhhoBfhtPD4lBoprXDND4Q2DD3AkNyxg9k
	 k+JNmzmm97sWw90+M0pXB3UyTPvoM5c5Ifq3Diqqqxz+fHzviHibonKiNkss4IHWER
	 mD4RizU+WKf8qdKqLNfSR2eM/I6oYl5JyJfSRSLgBfJYNhMKngkS1NsiFvIib39jF+
	 1HWYZk70FP6cfwgCE1pZt0IUx1yvmKtUCFFiSdd9YVoNnf9Wbz9fGG6tfh9qx10rwR
	 lv4RjelnKUV1rZCic+UOfatQCPduPIZgtsqI0hyqzob535FEavCbScU/knKMkLZjL7
	 Uaf49yM2nd45w==
Date: Tue, 16 Apr 2024 08:15:54 -0500
From: Rob Herring <robh@kernel.org>
To: skseofh@gmail.com
Cc: saravanak@google.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: of_reserved_mem: remove repeated call to get no-map
 property
Message-ID: <20240416131554.GA2105823-robh@kernel.org>
References: <20240412140938.137803-1-skseofh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412140938.137803-1-skseofh@gmail.com>

On Fri, Apr 12, 2024 at 11:09:38PM +0900, skseofh@gmail.com wrote:
> From: Daero Lee <skseofh@gmail.com>
> 
> In __reserved_mem_alloc_size, of_get_flat_dt_prop is called and checked
> whether the "no-map" property exists for the node. In
> fdt_init_reserved_mem, the only caller of __reserved_mem_alloc_size,
> we checked this again for the same node. Therefore, repeated
> of_get_flat_dt_prop call was removed and 'nomap' was passed as an input
> parameter to the callee function.

This code is all about to get rearranged[1], so holding off on this.

Rob

[1] https://lore.kernel.org/lkml/20240328211543.191876-1-quic_obabatun@quicinc.com/

