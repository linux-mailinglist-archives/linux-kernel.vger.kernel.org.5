Return-Path: <linux-kernel+bounces-17897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F578254B5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FB901F223C3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761552D7A7;
	Fri,  5 Jan 2024 13:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eW66ElJd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6672D78A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 13:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dbe344a6cf4so1350866276.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 05:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1704462822; x=1705067622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFOCDfiRNVhSwkgtjGZQjnuXOXWIEEACwgomsYksHic=;
        b=eW66ElJdbv0hsOfQTOTyV+IGufjtqqgZ8kI+mhufnf86iDY6b8PdS/n5jmpiYTlIJ+
         VVcmBEDwBFhMWhZY+h9IvA8BpsVAx/thXe9pvzWnNsR0r6QrgnZIqQeyla95nCjQAXzs
         f90/friHfqomAFm5YYKpc/zoqQ5qlA5nZqrfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704462822; x=1705067622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFOCDfiRNVhSwkgtjGZQjnuXOXWIEEACwgomsYksHic=;
        b=g7pxmPCEiL+tFuJD5YUgs4kM/rHix77r7+h/3znVrG0rLKyFJxIKxqH1tGNvZnxiyN
         Oqh6EV4isdZRkSmHRgsilvA5WlaADg2zklU5pcCyukVFNqkBEmm6N2GKKZq3jerEf5hG
         zetJxfNmA1gvdODnjEx+D5KWQNXZiYD4l4D3m0OdMFpA4NaCWLW95sv43ozNgiZmPXs/
         5NBOO95xARp6jjX15d78+0KqNlCtFKrz3RPeibVTRArNW4JjgbReQviSHB9uYng6GpFW
         xOWX3HyLf3WdqjBwKyCuv+OYHy8CPt9lfVXuFuYCFv+41LbiTuRm+wJgQQBCWnpUdi2N
         WreA==
X-Gm-Message-State: AOJu0YwmAwiNnabDwSwGwN1RRGe+5P76lplSHa5Mkfiv7bf2+V9JSrdw
	9hOUax2lzhDMOKbNequeKuDmvtXTbQ4cdob1HRCbpr0vjLX2
X-Google-Smtp-Source: AGHT+IFwllAGuSzxfiNvJYq5HVd8LA4btV4STKM9+hWWoy2AfS19e9FrTfrglCtGtoFOE4WJjIZPhnxKC2RbUI9hZPg=
X-Received: by 2002:a5b:b43:0:b0:d9b:3ed:41a5 with SMTP id b3-20020a5b0b43000000b00d9b03ed41a5mr1899489ybr.21.1704462822423;
 Fri, 05 Jan 2024 05:53:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2b5648aa-f83d-d8f7-b0fd-39c859f32f33@linux.intel.com> <20240105135105.1921947-1-zack.rusin@broadcom.com>
In-Reply-To: <20240105135105.1921947-1-zack.rusin@broadcom.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Fri, 5 Jan 2024 08:53:31 -0500
Message-ID: <CABQX2QOK8yKqREbnuRy0bZwYBssS3Cmec+wV3Lq0MNZGFgsA1Q@mail.gmail.com>
Subject: Re: [PATCH v3] drm/ttm: Make sure the mapped tt pages are decrypted
 when needed
To: dri-devel@lists.freedesktop.org
Cc: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Huang Rui <ray.huang@amd.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 8:51=E2=80=AFAM Zack Rusin <zack.rusin@broadcom.com>=
 wrote:
>
> Some drivers require the mapped tt pages to be decrypted. In an ideal
> world this would have been handled by the dma layer, but the TTM page
> fault handling would have to be rewritten to able to do that.
>
> A side-effect of the TTM page fault handling is using a dma allocation
> per order (via ttm_pool_alloc_page) which makes it impossible to just
> trivially use dma_mmap_attrs. As a result ttm has to be very careful
> about trying to make its pgprot for the mapped tt pages match what
> the dma layer thinks it is. At the ttm layer it's possible to
> deduce the requirement to have tt pages decrypted by checking
> whether coherent dma allocations have been requested and the system
> is running with confidential computing technologies.
>
> This approach isn't ideal but keeping TTM matching DMAs expectations
> for the page properties is in general fragile, unfortunately proper
> fix would require a rewrite of TTM's page fault handling.
>
> Fixes vmwgfx with SEV enabled.
>
> v2: Explicitly include cc_platform.h
> v3: Use CC_ATTR_GUEST_MEM_ENCRYPT instead of CC_ATTR_MEM_ENCRYPT to
> limit the scope to guests and log when memory decryption is enabled.

Sorry, this also got a bit lost during the s/VMware/Broadcom/
transition. It seems to be pretty safe in general now. I wasn't able
to find a really clean way of adding a warn_once when pte's don't
match as suggested by Thomas, but I did add a quick log to at least
point out in the logs that we've enabled memory decryption in tt.

z

