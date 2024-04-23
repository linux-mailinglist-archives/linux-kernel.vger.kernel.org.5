Return-Path: <linux-kernel+bounces-155827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CD38AF7A6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 973AC1F226B2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736D71422C2;
	Tue, 23 Apr 2024 19:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Umwt1rgM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66641422A3
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 19:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713902232; cv=none; b=JpI0RxuIi1dPHFnsP/qvd4Kju+bJElE/Dk8NVUA0IZW1pawiGH1fH2NO0l+VtX/moPrvjXoknVzAY8Zy3bj2X9r5SfTjtJQ32n+Ws45XSF3hMCMfj8jwtA2A027oX0bZvr/WtDkpTS1z0m/51Df8WM8xYERIn4tab9IiW8eTQzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713902232; c=relaxed/simple;
	bh=jj/y9k1k2/l68zwukd3otAN0E5CDbwnRC4PxRJNSCRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDjfIQ+eAp34/Vu5Tveb5+LYlajRpsY96ZGg06txYfJOx13J5kXz+4Os5hQMx1UGCh9GKBXJ+XXYyiZd55Jpfe5UDzv5tAUXjlWD4tQn4mPZJDma/RFEERFvzyjrYPmM3MXouJVl+qE0NdpP5NBUzCFUhpqn4CotQEZns3+RMRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Umwt1rgM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF9AC2BD11;
	Tue, 23 Apr 2024 19:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713902232;
	bh=jj/y9k1k2/l68zwukd3otAN0E5CDbwnRC4PxRJNSCRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Umwt1rgMoDu0zKJfeR1CkiMm6P/lVYez+kwgzKW4j/Zm38Myqd20qaijWgKg5NON+
	 ILjNqWNAohlY0im2MmMfPbytocBkyyo/SINT7TAlDLPW8XqV//7Jg9VAQLw5D7aLOk
	 SEOyWEWUu+Rgd+PlnVioB90GrW46L4cXb/kLN0d8=
Date: Tue, 23 Apr 2024 12:57:02 -0700
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: Kunwu Chan <chentao@kylinos.cn>, "arnd@arndb.de" <arnd@arndb.de>,
	"kunwu.chan@hotmail.com" <kunwu.chan@hotmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mei: bus: constify the struct mei_cl_bus_type usage
Message-ID: <2024042350-lend-unsettled-957f@gregkh>
References: <20240423024133.1890455-1-chentao@kylinos.cn>
 <PH7PR11MB76051D97AC76E8FCDE464F2FE5112@PH7PR11MB7605.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR11MB76051D97AC76E8FCDE464F2FE5112@PH7PR11MB7605.namprd11.prod.outlook.com>

On Tue, Apr 23, 2024 at 07:45:08PM +0000, Winkler, Tomas wrote:
> 
> > 
> > Now that the driver core can properly handle constant struct bus_type,
> > move the mei_cl_bus_type variable to be a constant structure as well,
> > placing it into read-only memory which can not be modified at runtime.
> > 
> > Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> LGTM 

Can you provide a "Acked-by:"?

