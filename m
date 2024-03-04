Return-Path: <linux-kernel+bounces-90595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9360A8701E7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CDD1289C04
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF903D547;
	Mon,  4 Mar 2024 12:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="CTnrPNLa";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="CTnrPNLa"
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E9A3D39A;
	Mon,  4 Mar 2024 12:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.71.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709557188; cv=none; b=H4nXKqGSO7itD+TaMKljNT6xO8dwRn3BC6qlbu+witN1eNNLv/Am57UM24gXEg4fXXbMBy+fBfZpTQkWE8SYnEXBu4JVWmKF4uwyUlY8kL1PIULTw0m10/cv2F217BvQdSo7l8xr/bpIwNCV/EAag3QwfkQsXxWhZcaSduXfMug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709557188; c=relaxed/simple;
	bh=e6W5dVjrDlaxEdGJQ8TjsG2c+Fxj/jwHrFyoZXM5Vj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjzAKrEB+KLO/EvivnXN4+m//vNl29FG6spAEw1pYUhn7Ij9Zi8foooymra0QKMQYeR/loXzgQxMluZwKyGlON7T28Yak9is4Nwv0A8u9bI3mHXucLYvTA3YkvJ6ipdvULqKttYkFXRilY0qzZzDoEzjFMpZZ1PQ+im+1SJ2cxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=CTnrPNLa; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=CTnrPNLa; arc=none smtp.client-ip=91.121.71.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id D339BC01E; Mon,  4 Mar 2024 13:59:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1709557184; bh=XCIi2WCMNQlzfotdYfhM0XMfceVX/+qsBXNDxTeiHxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CTnrPNLa4r78QqlS0P0Qp+MgRcQmweTgXU2ePiSPL3S0MkI7aUJBd1neL3Imj4D4e
	 rkf8lc76Q8tO1ojOWz7aeOytnGEHRtWfWWM83cOApHUtvFOD8n/Efmmr0DLEJeChGv
	 PgqNR5QPYNRAiUiYUL73Iy0wL+gKnJXyH79GqAKWAwrvxODO/PfVMhYb/3q+A3l/R+
	 DckCEfvMa1PI+7CYX7uHlVLUW0TGeMnfmpDgaRo/oCSTPV9Rb5V2od7o3um+uQxfnF
	 bDyRvc1byit6BJIeZWRhqZLqtp7yuq1Sv61xlHygFtZsMSE0CWIY83yFEqOej7tCsv
	 OFbLNhzJXDqRg==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 2DE2AC009;
	Mon,  4 Mar 2024 13:59:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1709557184; bh=XCIi2WCMNQlzfotdYfhM0XMfceVX/+qsBXNDxTeiHxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CTnrPNLa4r78QqlS0P0Qp+MgRcQmweTgXU2ePiSPL3S0MkI7aUJBd1neL3Imj4D4e
	 rkf8lc76Q8tO1ojOWz7aeOytnGEHRtWfWWM83cOApHUtvFOD8n/Efmmr0DLEJeChGv
	 PgqNR5QPYNRAiUiYUL73Iy0wL+gKnJXyH79GqAKWAwrvxODO/PfVMhYb/3q+A3l/R+
	 DckCEfvMa1PI+7CYX7uHlVLUW0TGeMnfmpDgaRo/oCSTPV9Rb5V2od7o3um+uQxfnF
	 bDyRvc1byit6BJIeZWRhqZLqtp7yuq1Sv61xlHygFtZsMSE0CWIY83yFEqOej7tCsv
	 OFbLNhzJXDqRg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id b5420c5c;
	Mon, 4 Mar 2024 12:59:37 +0000 (UTC)
Date: Mon, 4 Mar 2024 21:59:22 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Eric Van Hensbergen <ericvh@kernel.org>
Cc: Colin Ian King <colin.i.king@gmail.com>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] fs/9p: remove redundant pointer v9ses
Message-ID: <ZeXFqt1NDp9sdz7n@codewreck.org>
References: <20240229222250.351322-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240229222250.351322-1-colin.i.king@gmail.com>

Colin Ian King wrote on Thu, Feb 29, 2024 at 10:22:50PM +0000:
> Pointer v9ses is being assigned the value from the return of inlined
> function v9fs_inode2v9ses (which just returns inode->i_sb->s_fs_info).
> The pointer is not used after the assignment, so the variable is
> redundant and can be removed.
> 
> Cleans up clang scan warnings such as:
> fs/9p/vfs_inode_dotl.c:300:28: warning: variable 'v9ses' set but not
> used [-Wunused-but-set-variable]

Thanks for the patch!

Eric, this appears to be for your -next tree as it doesn't build on
master -- didn't notice the [next] in the subject line until I tried...
(I've just build-checked on your tree and it appears correct there)

> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>

-- 
Dominique

